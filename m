Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262715AbSJJF4z>; Thu, 10 Oct 2002 01:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbSJJF4z>; Thu, 10 Oct 2002 01:56:55 -0400
Received: from nameservices.net ([208.234.25.16]:11535 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262715AbSJJFzL>;
	Thu, 10 Oct 2002 01:55:11 -0400
Message-ID: <3DA518A2.BF7377DC@opersys.com>
Date: Thu, 10 Oct 2002 02:05:22 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.41: Core infrastructure 3/3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the second piece of kernel/trace.c, just cat this to the
earlier piece. Sorry, I'd avoid this if I could.

+/**
+ *	init_buffer_control: - Init buffer control struct for new tracing run.
+ *	@buf_ctrl: buffer control struct to be initialized
+ *	@use_lockless: which tracing scheme to use, TRUE for lockless
+ *	@buffer_number_bits: number of bits in index word for buffer number
+ *	@offset_bits: number of bits in index word to use for buffer offset
+ *
+ *	Sanity of param values should be checked by caller. i.e. bufno_bits and
+ *	offset_bits must reflect sane buffer sizes/numbers.
+ */
+static void init_buffer_control(struct buffer_control * buf_ctrl,
+				int use_lockless,
+				u8 buffer_number_bits,
+				u8 offset_bits)
+{
+	unsigned i, j;
+	int n_buffers = TRACE_MAX_BUFFER_NUMBER(buffer_number_bits);
+	
+	using_lockless = use_lockless;
+	buffer_switches_pending = 0;
+	
+	for(i = 0; i < num_cpus; i++) {
+		_buffer_id(buf_ctrl, i) = 0;
+		_events_lost(buf_ctrl, i) = 0;
+
+		/* Set things up to trigger per-cpu initialization */ 
+		atomic_set(&_waiting_for_cpu(buf_ctrl, i), 
+			   LTT_INITIALIZE_TRACE);
+		_trace_buffer(buf_ctrl, i) = trace_buf + (i * cpu_buf_size);
+		if(using_lockless == 0) {
+			atomic_set(&_signal_sent(buf_ctrl, i), 0);
+			write_buf(i) = trace_buffer(i);
+			read_buf(i) = trace_buffer(i) + buf_size;
+			write_buf_end(i) = write_buf(i) + buf_size;
+			read_buf_end(i) = read_buf(i) + buf_size;
+			current_write_pos(i) = write_buf(i);
+			read_limit(i) = read_buf(i);
+			write_limit(i) = write_buf_end(i)
+				- TRACER_LAST_EVENT_SIZE;
+		} else {
+			_index(buf_ctrl, i) = start_reserve;
+			_bufno_bits(buf_ctrl, i) = buffer_number_bits;
+			_n_buffers(buf_ctrl, i) = 
+				TRACE_MAX_BUFFER_NUMBER(buffer_number_bits);
+			_offset_bits(buf_ctrl, i) = offset_bits;
+			_offset_mask(buf_ctrl, i) =  
+				TRACE_BUFFER_OFFSET_MASK(offset_bits);
+			_index_mask(buf_ctrl, i) =  
+				(1UL << (buffer_number_bits + offset_bits)) - 1;
+			_buffers_produced(buf_ctrl, i) = 0;
+			_buffers_consumed(buf_ctrl, i) = 0;
+			_buffers_full(buf_ctrl, i) = 0;
+
+			/* When a new buffer is switched to, TRACE_BUFFER_SIZE
+			   is subtracted from its fill_count in order to 
+			   initialize it to the empty state.  The reason it's 
+			   done this way is because an intervening event may 
+			   have already been written to the buffer while we 
+			   were in the process of switching and thus blindly 
+			   initializing to 0 would erase that event.  The first
+			   buffer is initialized to 0 and the others are 
+			   initialized to TRACE_BUFFER_SIZE because the very 
+			   first buffer we ever see won't be initialized in 
+			   that way by the switching code and since there's 
+			   never been an event, we know it should be 0 and that
+			   it must be explicitly initialized that way before 
+			   logging begins.  sStartReserve is is factored into 
+			   the end-of-buffer processing, so isn't added to the
+			   fill counts here, except for the first. */
+			atomic_set(&_fill_count(buf_ctrl, i, 0), 
+				   (int)start_reserve);
+			for(j = 1; j < n_buffers; j++)
+				atomic_set(&_fill_count(buf_ctrl, i, j),
+				   (int)TRACE_BUFFER_SIZE(offset_bits));
+			
+		}
+	}
+}
+
+/**
+ *	trace: - Tracing function per se.
+ *	@event_id: ID of event as defined in linux/trace.h
+ *	@event_struct: struct describing the event
+ *	@cpu_id: the CPU associated with the event
+ *
+ *	Returns: 
+ *	0, if everything went OK (event got registered)
+ *	-ENODEV, no tracing daemon opened the driver.
+ *	-ENOMEM, no more memory to store events.
+ *	-EBUSY, tracer not started yet.
+ */
+int trace(u8 event_id,
+	  void *event_struct,
+	  u8 cpu_id)
+{
+	int var_data_len = 0;		/* Length of variable length data to be copied, if any */
+	void *var_data_beg = NULL;	/* Begining of variable length data to be copied */
+	int send_signal = FALSE;	/* Should the daemon be summoned */
+	uint16_t data_size;		/* Size of tracing data */
+	struct siginfo daemon_sig_info;	/* Signal information */
+	struct timeval time_stamp;	/* Event time */
+	unsigned long int flags;	/* CPU flags for lock */
+	trace_time_delta time_delta;	/* The time elapsed between now and the last event */
+	struct task_struct *incoming_process = NULL;	/* Pointer to incoming process */
+
+	/* Is there a tracing daemon */
+	if (daemon_task_struct == NULL)
+		return -ENODEV;
+
+	/* Execute any tasks waiting for this CPU */
+	if(atomic_read(&waiting_for_cpu(cpu_id)) != 0)
+		do_waiting_tasks(cpu_id);
+
+	/* Is this the exit of a process? */
+	if ((event_id == TRACE_EV_PROCESS) &&
+	    (event_struct != NULL) &&
+	    ((((trace_process *) event_struct)->event_sub_id) == TRACE_EV_PROCESS_EXIT))
+		trace_destroy_owners_events(current->pid);
+
+	/* Do we trace the event */
+	if ((tracer_started == TRUE) || (event_id == TRACE_EV_START) || (event_id == TRACE_EV_BUFFER_START))
+		goto TraceEvent;
+
+	return -EBUSY;
+
+TraceEvent:
+	/* Are we monitoring this event */
+	if (!ltt_test_bit(event_id, &traced_events))
+		return 0;
+
+	/* Always let the start event pass, whatever the IDs */
+	if ((event_id != TRACE_EV_START) && (event_id != TRACE_EV_BUFFER_START)) {
+		/* Is this a scheduling change */
+		if (event_id == TRACE_EV_SCHEDCHANGE) {
+			/* Get pointer to incoming process */
+			incoming_process = (struct task_struct *) (((trace_schedchange *) event_struct)->in);
+
+			/* Set PID information in schedchange event */
+			(((trace_schedchange *) event_struct)->in) = incoming_process->pid;
+		}
+		/* Are we monitoring a particular process */
+		if ((tracing_pid == TRUE) && (current->pid != traced_pid)) {
+			/* Record this event if it is the scheduling change bringing in the traced PID */
+			if (incoming_process == NULL)
+				return 0;
+			else if (incoming_process->pid != traced_pid)
+				return 0;
+		}
+		/* Are we monitoring a particular process group */
+		if ((tracing_pgrp == TRUE) && (current->pgrp != traced_pgrp)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced PGRP */
+			if (incoming_process == NULL)
+				return 0;
+			else if (incoming_process->pgrp != traced_pgrp)
+				return 0;
+		}
+		/* Are we monitoring the processes of a given group of users */
+		if ((tracing_gid == TRUE) && (current->egid != traced_gid)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced GID */
+			if (incoming_process == NULL)
+				return 0;
+			else if (incoming_process->egid != traced_gid)
+				return 0;
+		}
+		/* Are we monitoring the processes of a given user */
+		if ((tracing_uid == TRUE) && (current->euid != traced_uid)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced UID */
+			if (incoming_process == NULL)
+				return 0;
+			else if (incoming_process->euid != traced_uid)
+				return 0;
+		}
+	}
+
+	/* Compute size of tracing data */
+	data_size = sizeof(event_id) + sizeof(time_delta) + sizeof(data_size);
+
+	/* Do we log the event details */
+	if (ltt_test_bit(event_id, &log_event_details_mask)) {
+		/* Update the size of the data entry */
+		data_size += event_struct_size[event_id];
+
+		/* Some events have variable length */
+		switch (event_id) {
+		/* Is there a file name in this */
+		case TRACE_EV_FILE_SYSTEM:
+			if ((((trace_file_system *) event_struct)->event_sub_id == TRACE_EV_FILE_SYSTEM_EXEC)
+			    || (((trace_file_system *) event_struct)->event_sub_id == TRACE_EV_FILE_SYSTEM_OPEN)) {
+				/* Remember the string's begining and update size variables */
+				var_data_beg = ((trace_file_system *) event_struct)->file_name;
+				var_data_len = ((trace_file_system *) event_struct)->event_data2 + 1;
+				data_size += (uint16_t) var_data_len;
+			}
+			break;
+
+		/* Logging of a custom event */
+		case TRACE_EV_CUSTOM:
+			var_data_beg = ((trace_custom *) event_struct)->data;
+			var_data_len = ((trace_custom *) event_struct)->data_size;
+			data_size += (uint16_t) var_data_len;
+			break;
+		}
+	}
+
+	/* Do we record the CPUID */
+	if ((log_cpuid == TRUE) && (event_id != TRACE_EV_START) && (event_id != TRACE_EV_BUFFER_START)) {
+		/* Update the size of the data entry */
+		data_size += sizeof(cpu_id);
+	}
+
+	/* If we're using the lockless scheme, we preempt the default path 
+	   here - nothing after this point in this function will be executed. 
+	   Note that even if we do have cmpxchg, we still want to have a 
+	   choice between the lock-free and locking schemes at run-time, thus 
+	   the using_lockless check.  This used to be implemented as a kernel 
+	   hook, and will be again when/if kernel hooks are accepted into the 
+	   kernel. */
+	if(using_lockless && have_cmpxchg())
+		return lockless_write_event(event_id, 
+					    event_struct,	
+					    data_size,
+					    cpu_id,
+					    var_data_beg,
+					    var_data_len);
+
+	/* Lock the kernel */
+	spin_lock_irqsave(&trace_spin_lock, flags);
+
+	/* The following time calculations have to be done within the spinlock because
+	   otherwise the event order could be inverted. */
+
+	/* Get the time of the event */
+	time_delta = get_time_delta(&time_stamp, cpu_id);
+
+	/* Is there enough space left in the write buffer */
+	if (current_write_pos(cpu_id) + data_size > write_limit(cpu_id)) {
+		/* Have we already switched buffers and informed the daemon of it */
+		if (atomic_read(&signal_sent(cpu_id)) == TRUE) {
+			/* We've lost another event */
+			(events_lost(cpu_id))++;
+
+			/* Bye, bye, now */
+			spin_unlock_irqrestore(&trace_spin_lock, flags);
+			return -ENOMEM;
+		}
+		/* We need to inform the daemon */
+		send_signal = TRUE;
+
+		/* Get the time and TSC of the start/end buffer event */
+		get_timestamp(&time_stamp, &time_delta);
+
+		/* Switch buffers, pass lTimeDelta in case it's really a TSC */
+		tracer_switch_buffers(time_stamp, time_delta, cpu_id);
+
+		/* Recompute the time delta since buffer_start_time has changed because of the buffer change */
+		recalc_time_delta(&time_stamp, &time_delta, cpu_id);
+	}
+
+	/* Write the CPUID to the tracing buffer, if required */
+	if ((log_cpuid == TRUE) && (event_id != TRACE_EV_START) && (event_id != TRACE_EV_BUFFER_START))
+		tracer_write_to_buffer(current_write_pos(cpu_id),
+				       &cpu_id,
+				       sizeof(cpu_id));
+
+	/* Write event type to tracing buffer */
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &event_id,
+			       sizeof(event_id));
+
+	/* Write event time delta to tracing buffer */
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &time_delta,
+			       sizeof(time_delta));
+
+	/* Do we log event details */
+	if (ltt_test_bit(event_id, &log_event_details_mask)) {
+		/* Write event structure */
+		tracer_write_to_buffer(current_write_pos(cpu_id),
+				       event_struct,
+				       event_struct_size[event_id]);
+
+		/* Write string if any */
+		if (var_data_len)
+			tracer_write_to_buffer(current_write_pos(cpu_id),
+					       var_data_beg,
+					       var_data_len);
+	}
+	/* Write the length of the event description */
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &data_size,
+			       sizeof(data_size));
+
+	/* Should the tracing daemon be notified  */
+	if (send_signal == TRUE) {
+		/* Remember that a signal has been sent */
+		atomic_set(&signal_sent(cpu_id), TRUE);
+		buffer_switches_pending |= (1UL << cpu_id);
+
+		/* Unlock the kernel */
+		spin_unlock_irqrestore(&trace_spin_lock, flags);
+
+		/* Setup signal information */
+		daemon_sig_info.si_signo = SIGIO;
+		daemon_sig_info.si_errno = 0;
+		daemon_sig_info.si_code = SI_KERNEL;
+
+		/* Signal the tracing daemon */
+		send_sig_info(SIGIO, &daemon_sig_info, daemon_task_struct);
+	} else
+		/* Unlock the kernel */
+		spin_unlock_irqrestore(&trace_spin_lock, flags);
+
+	return 0;
+}
+
+/**
+ *	tracer_switch_buffers: - Switches between read and write buffers.
+ *	@current_time: current time.
+ *	@current_tsc: the TSC associated with current_time, if applicable
+ *	@cpu_id: the CPU associated with the event
+ *
+ *	Put the current write buffer to be read and reset put the old read
+ *	buffer to be written to. Set the tracer variables in consequence.
+ *
+ *	No return values.
+ *
+ *	This should be called from within a spin_lock.
+ */
+void tracer_switch_buffers(struct timeval current_time,
+ 			   trace_time_delta current_tsc,
+			   u8 cpu_id)
+{
+	char *temp_buf;			/* Temporary buffer pointer */
+	char *temp_buf_end;		/* Temporary buffer end pointer */
+	char *init_write_pos;		/* Initial write position */
+	u8 event_id;			/* Event ID of last event */
+	uint16_t data_size;		/* Size of tracing data */
+	u32 size_lost;			/* Size delta between last event and end of buffer */
+	trace_time_delta time_delta;	/* The time elapsed between now and the last event */
+	trace_buffer_start start_buffer_event;	/* Start of the new buffer event */
+	trace_buffer_end end_buffer_event; /* End of buffer event */
+
+	/* Remember initial write position */
+	init_write_pos = current_write_pos(cpu_id);
+
+	/* Write the end event at the write of the buffer */
+	end_buffer_event.time = current_time;
+	end_buffer_event.tsc = current_tsc;
+
+	/* Write the CPUID to the tracing buffer, if required */
+	if (log_cpuid == TRUE) {
+		tracer_write_to_buffer(current_write_pos(cpu_id),
+				       &cpu_id,
+				       sizeof(cpu_id));
+	}
+	/* Write event type to tracing buffer */
+	event_id = TRACE_EV_BUFFER_END;
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &event_id,
+			       sizeof(event_id));
+
+	/* Write event time delta/TSC to tracing buffer */
+	time_delta = switch_time_delta(current_tsc);
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &time_delta,
+			       sizeof(time_delta));
+
+	/* Write event structure */
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &end_buffer_event,
+			       sizeof(end_buffer_event));
+
+	/* Compute the data size */
+	data_size = sizeof(event_id)
+		+ sizeof(time_delta)
+		+ sizeof(end_buffer_event)
+		+ sizeof(data_size);
+
+	/* Write the length of the event description */
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &data_size,
+			       sizeof(data_size));
+
+	/* Get size lost */
+	size_lost = write_buf_end(cpu_id) - init_write_pos;
+
+	/* Write size lost at the end of the buffer */
+	*((u32 *) (write_buf_end(cpu_id) - sizeof(size_lost))) = size_lost;
+
+	/* Switch buffers */
+	temp_buf = read_buf(cpu_id);
+	read_buf(cpu_id) = write_buf(cpu_id);
+	write_buf(cpu_id) = temp_buf;
+
+	/* Set buffer ends */
+	temp_buf_end = read_buf_end(cpu_id);
+	read_buf_end(cpu_id) = write_buf_end(cpu_id);
+	write_buf_end(cpu_id) = temp_buf_end;
+
+	/* Set read limit */
+	read_limit(cpu_id) = read_buf_end(cpu_id);
+
+	/* Set write limit */
+	write_limit(cpu_id) = write_buf_end(cpu_id) - TRACER_LAST_EVENT_SIZE;
+
+	/* Set write position */
+	current_write_pos(cpu_id) = write_buf(cpu_id);
+
+	/* Increment buffer ID */
+	(buffer_id(cpu_id))++;
+
+	/* Set the time/TSC of beginning of this buffer */
+	buffer_start_time(cpu_id) = current_time;
+	buffer_start_tsc(cpu_id) = current_tsc;
+
+	/* Write the start of buffer event */
+	start_buffer_event.id = buffer_id(cpu_id);
+	start_buffer_event.time = current_time;
+	start_buffer_event.tsc = current_tsc;
+
+	/* Write event type to tracing buffer */
+	event_id = TRACE_EV_BUFFER_START;
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &event_id,
+			       sizeof(event_id));
+
+	/* Write event time delta to tracing buffer */
+	time_delta = switch_time_delta(current_tsc);
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &time_delta,
+			       sizeof(time_delta));
+
+	/* Write event structure */
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &start_buffer_event,
+			       sizeof(start_buffer_event));
+
+	/* Compute the data size */
+	data_size = sizeof(event_id)
+	    + sizeof(time_delta)
+	    + sizeof(start_buffer_event)
+	    + sizeof(data_size);
+
+	/* Write the length of the event description */
+	tracer_write_to_buffer(current_write_pos(cpu_id),
+			       &data_size,
+			       sizeof(data_size));
+}
+
+/**
+ *	update_shared_buffer_control: - prepare for GET_BUFFER_CONTROL ioctl
+ *	@cpu_id: the CPU associated with the ioctl
+ *
+ *	Copies buffer control data into a common format that can be shared
+ *	between the tracer and the daemon, allowing alignment to be ignored.
+ */
+static inline void update_shared_buffer_control(u8 cpu_id)
+{
+	int i, n_buffers;
+	
+	shared_buffer_control.cpu_id = cpu_id;
+
+	/* Let the caller know if there are more buffer switches to process 
+	   AFTER this one */
+	shared_buffer_control.buffer_switches_pending =
+		buffer_switches_pending & ~(1UL << cpu_id);
+	shared_buffer_control.buffer_control_valid = TRUE;
+	if(using_lockless) {
+		shared_buffer_control.bufno_bits = bufno_bits(cpu_id);
+		shared_buffer_control.offset_bits = offset_bits(cpu_id);
+		shared_buffer_control.buffers_produced = 
+			buffers_produced(cpu_id);
+		shared_buffer_control.buffers_consumed = 
+			buffers_consumed(cpu_id);
+		n_buffers = TRACE_MAX_BUFFER_NUMBER(buf_no_bits);
+		for(i = 0; i < n_buffers; i++) {
+			shared_buffer_control.fill_count[i] = 
+				atomic_read(&fill_count(cpu_id, i));
+		}
+	}
+}
+
+/**
+ *	tracer_ioctl: - "ioctl" file op
+ *
+ *	@tracer_inode: the inode associated with the device
+ *	@task_file: file structure given to the acting process
+ *	@tracer_command: command given by the caller
+ *	@ioctl_arg: arguments to the command
+ *
+ *	Returns:
+ *	>0, In case the caller requested the number of events lost.
+ *	0, Everything went OK
+ *	-ENOSYS, no such command
+ *	-EINVAL, tracer not properly configured
+ *	-EBUSY, tracer can't be reconfigured while in operation
+ *	-ENOMEM, no more memory
+ *	-EFAULT, unable to access user space memory
+ *
+ *	Note:
+ *	In the future, this function should check to make sure that it's the
+ *	server that make thes ioctl.
+ */
+int tracer_ioctl(struct inode *tracer_inode,
+		 struct file *task_file,
+		 unsigned int tracer_command,
+		 unsigned long ioctl_arg)
+{
+	int return_val;			/* Function return value */
+	int dev_minor_no;		/* Device minor number */
+	int new_user_event_id;		/* ID of newly created user event */
+	unsigned long int flags;	/* CPU flags for lock */
+	u8 cpu_id;			/* Current CPU */
+	u8 i;				/* Counter */
+	u32 buffers_consumed;		/* # buffers consumed */
+	trace_custom user_event;	/* The user event to be logged */
+	trace_change_mask trace_mask;	/* Event mask */
+	trace_new_event new_user_event;	/* The event to be created for the user */
+	struct timeval current_time;   	/* The time elapsed between now and the last event */
+	trace_time_delta current_tsc;  	/* The time elapsed between now and the last event */
+	struct buffers_committed buffers_committed;  /* For COMMITTED case */
+
+	/* Get device's minor number */
+	dev_minor_no = minor(tracer_inode->i_rdev) & 0x0f;
+
+	/* If the tracer is started, the daemon can't modify the configuration */
+	if ((dev_minor_no == 0)
+	    && (tracer_started == TRUE)
+	    && (tracer_command != TRACER_STOP)
+	    && (tracer_command != TRACER_DATA_COMITTED)
+	    && (tracer_command != TRACER_GET_BUFFER_CONTROL))
+		return -EBUSY;
+
+	/* Only some operations are permitted to user processes trying to log events */
+	if ((dev_minor_no == 1)
+	    && (tracer_command != TRACER_CREATE_USER_EVENT)
+	    && (tracer_command != TRACER_DESTROY_USER_EVENT)
+	    && (tracer_command != TRACER_TRACE_USER_EVENT)
+	    && (tracer_command != TRACER_SET_EVENT_MASK)
+	    && (tracer_command != TRACER_GET_EVENT_MASK))
+		return -ENOSYS;
+
+	/* Depending on the command executed */
+	switch (tracer_command) {
+	/* Start the tracer */
+	case TRACER_START:
+		init_heartbeat_timer();
+		
+		/* Initialize buffer control regardless of scheme in use */
+		init_buffer_control(buffer_control,
+				    !use_locking,    /* using_lockless */
+				    buf_no_bits,     /* bufno_bits, 2**n */
+				    buf_offset_bits); /* offset_bits, 2**n */
+
+		/* Check if the device has been properly set up */
+		if (((use_syscall_eip_bounds == TRUE)
+		     && (syscall_eip_depth_set == TRUE))
+		    || ((use_syscall_eip_bounds == TRUE)
+			&& ((lower_eip_bound_set != TRUE)
+			    || (upper_eip_bound_set != TRUE)))
+		    || ((tracing_pid == TRUE)
+			&& (tracing_pgrp == TRUE)))
+			return -EINVAL;
+
+		/* Set the kernel-side trace configuration */
+		if (trace_set_config(syscall_eip_depth_set,
+				     use_syscall_eip_bounds,
+				     syscall_eip_depth,
+				     lower_eip_bound,
+				     upper_eip_bound) < 0)
+			return -EINVAL;
+
+		/* Always log the start event and the buffer start event */
+		ltt_set_bit(TRACE_EV_BUFFER_START, &traced_events);
+		ltt_set_bit(TRACE_EV_BUFFER_START, &log_event_details_mask);
+		ltt_set_bit(TRACE_EV_START, &traced_events);
+		ltt_set_bit(TRACE_EV_START, &log_event_details_mask);
+		ltt_set_bit(TRACE_EV_CHANGE_MASK, &traced_events);
+		ltt_set_bit(TRACE_EV_CHANGE_MASK, &log_event_details_mask);
+
+		/* If we're not using TSC, then we can initialize all now */
+		if(using_tsc == FALSE)
+			for(i = 0; i < num_cpus; i++)
+				initialize_trace(i);
+ 
+		/* Start tapping into Linux's syscall flow */
+		syscall_entry_trace_active = ltt_test_bit(TRACE_EV_SYSCALL_ENTRY, &traced_events);
+		syscall_exit_trace_active  = ltt_test_bit(TRACE_EV_SYSCALL_EXIT, &traced_events);
+
+		/* We can start tracing */
+		tracer_stopping = FALSE;
+		tracer_started = TRUE;
+
+		/* Reregister custom trace events created earlier */
+		trace_reregister_custom_events();
+		break;
+
+	/* Stop the tracer */
+	case TRACER_STOP:
+		if(using_tsc == TRUE)
+			del_timer(&heartbeat_timer);
+
+		/* Stop tracing */
+ 		/* We don't log new events, but old lockless ones can finish */
+		tracer_stopping = TRUE;
+		tracer_started = FALSE;
+
+		/* Stop interrupting the normal flow of system calls */
+		syscall_entry_trace_active = 0;
+		syscall_exit_trace_active  = 0;
+
+ 		/* Make sure the last buffer touched is finalized */
+		if(using_lockless) {
+			/* If we're not using TSC, we can finalize all now */
+			/* Write end buffer event as last event in old buf. */
+			if(using_tsc == FALSE) {
+				for(i = 0; i < num_cpus; i++)
+					finalize_lockless_trace(i);
+				tracer_stopping = FALSE;
+			} else
+				for(i = 0; i < num_cpus; i++)
+					set_waiting_for_cpu(i, LTT_FINALIZE_TRACE);
+			break;
+ 		} /* Else locking scheme */
+
+		/* Acquire the lock to avoid SMP case of where another CPU is writing a trace
+		   while buffer is being switched */
+		spin_lock_irqsave(&trace_spin_lock, flags);
+
+		if(using_tsc == FALSE) {
+			/* Get the time of the event */
+			get_timestamp(&current_time, &current_tsc);
+
+			/* If we're not using TSC, we can finalize all now */
+			for(i = 0; i < num_cpus; i++) {
+				buffer_switches_pending |= (1UL << i);
+				/* Switch the buffers to ensure that the end 
+				   of the buffer mark is set */
+				tracer_switch_buffers(current_time, 
+						      current_tsc, i);
+			}
+			tracer_stopping = FALSE;
+		} else {
+			for(i = 0; i < num_cpus; i++)
+				set_waiting_for_cpu(i, LTT_FINALIZE_TRACE);
+		}
+
+		/* Release lock */
+		spin_unlock_irqrestore(&trace_spin_lock, flags);
+		break;
+
+	/* Set the tracer to the default configuration */
+	case TRACER_CONFIG_DEFAULT:
+		tracer_set_default_config();
+		break;
+
+	/* Set the memory buffers the daemon wants us to use */
+	case TRACER_CONFIG_MEMORY_BUFFERS:
+		/* Is the given size "reasonable" */
+		if (use_locking == TRUE) {
+			if (ioctl_arg < TRACER_MIN_BUF_SIZE)
+				return -EINVAL;
+		} else {
+			if ((ioctl_arg < TRACER_LOCKLESS_MIN_BUF_SIZE) || 
+			    (ioctl_arg > TRACER_LOCKLESS_MAX_BUF_SIZE))
+				return -EINVAL;
+		}
+
+		/* Set the buffer's size */
+		return tracer_set_buffer_size(ioctl_arg);
+		break;
+
+	/* Set the number of memory buffers the daemon wants us to use */
+	case TRACER_CONFIG_N_MEMORY_BUFFERS:
+		/* Is the given size "reasonable" */
+		if ((use_locking == TRUE) || (ioctl_arg < TRACER_MIN_BUFFERS) || 
+		    (ioctl_arg > TRACER_MAX_BUFFERS))
+			return -EINVAL;
+
+		/* Set the number of buffers */
+		return tracer_set_n_buffers(ioctl_arg);
+		break;
+
+	/* Set locking scheme the daemon wants us to use */
+	case TRACER_CONFIG_USE_LOCKING:
+		/* Set the locking scheme in a global for later */
+		use_locking = ioctl_arg;
+		if((use_locking == FALSE) && (have_cmpxchg() == FALSE))
+                        /* Lock-free scheme not supported on this platform */
+			return -EINVAL; 
+		break;
+
+	/* Trace the given events */
+	case TRACER_CONFIG_EVENTS:
+		if (copy_from_user(&traced_events, (void *) ioctl_arg, sizeof(traced_events)))
+			return -EFAULT;
+		break;
+
+	/* Trace the given events */
+	case TRACER_CONFIG_TIMESTAMP:
+		using_tsc = ioctl_arg;
+		if((using_tsc == TRUE) && (have_tsc() == FALSE)) {
+			using_tsc = FALSE;
+			return -EINVAL;
+		}
+		break;
+
+	/* Record the details of the event, or not */
+	case TRACER_CONFIG_DETAILS:
+		if (copy_from_user(&log_event_details_mask, (void *) ioctl_arg, sizeof(log_event_details_mask)))
+			return -EFAULT;
+		break;
+
+	/* Record the CPUID associated with the event */
+	case TRACER_CONFIG_CPUID:
+		log_cpuid = TRUE;
+		break;
+
+	/* Trace only one process */
+	case TRACER_CONFIG_PID:
+		tracing_pid = TRUE;
+		traced_pid = ioctl_arg;
+		break;
+
+	/* Trace only the given process group */
+	case TRACER_CONFIG_PGRP:
+		tracing_pgrp = TRUE;
+		traced_pgrp = ioctl_arg;
+		break;
+
+	/* Trace the processes of a given group of users */
+	case TRACER_CONFIG_GID:
+		tracing_gid = TRUE;
+		traced_gid = ioctl_arg;
+		break;
+
+	/* Trace the processes of a given user */
+	case TRACER_CONFIG_UID:
+		tracing_uid = TRUE;
+		traced_uid = ioctl_arg;
+		break;
+
+	/* Set the call depth a which the EIP should be fetched on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_DEPTH:
+		syscall_eip_depth_set = TRUE;
+		syscall_eip_depth = ioctl_arg;
+		break;
+
+	/* Set the lowerbound address from which EIP is recorded on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_LOWER:
+		/* We are using bounds for fetching the EIP where syscall was made */
+		use_syscall_eip_bounds = TRUE;
+
+		/* Set the lower bound */
+		lower_eip_bound = (void *) ioctl_arg;
+
+		/* The lower bound has been set */
+		lower_eip_bound_set = TRUE;
+		break;
+
+	/* Set the upperbound address from which EIP is recorded on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_UPPER:
+		/* We are using bounds for fetching the EIP where syscall was made */
+		use_syscall_eip_bounds = TRUE;
+
+		/* Set the upper bound */
+		upper_eip_bound = (void *) ioctl_arg;
+
+		/* The upper bound has been set */
+		upper_eip_bound_set = TRUE;
+		break;
+
+	/* The daemon has comitted the last trace */
+	case TRACER_DATA_COMITTED:
+		/* Copy the information from user space */
+		if (copy_from_user(&buffers_committed, (void *)ioctl_arg, 
+				   sizeof(buffers_committed)))
+			return -EFAULT;
+
+		cpu_id = buffers_committed.cpu_id;
+		buffers_consumed = buffers_committed.buffers_consumed;
+
+		/* Turn off the bit indicating that the cpu's buffer switch
+		   needs servicing */ 
+		buffer_switches_pending &= ~(1 << cpu_id);
+
+		/* The lockless version doesn't use signal_sent.  ioctl_arg is
+		   the number of buffers the daemon has told us it just 
+		   consumed.  Add that to the global count. */
+		if(using_lockless) {
+			local_irq_save(flags);
+
+			/* We consumed some buffers, note it. */
+			buffers_consumed(cpu_id) += buffers_consumed;
+
+			/* If we were full, we no longer are */
+			if(buffers_full(cpu_id) && (buffers_consumed > 0)) {
+				set_waiting_for_cpu(cpu_id, LTT_CONTINUE_TRACE);
+			}
+
+			local_irq_restore(flags);
+			break;
+		} /* Else locking version below */
+
+		/* Safely set the signal sent flag to FALSE */
+		local_irq_save(flags);
+		atomic_set(&signal_sent(cpu_id), FALSE);
+		local_irq_restore(flags);
+		break;
+
+	/* Get the number of events lost */
+	case TRACER_GET_EVENTS_LOST:
+		return events_lost(ioctl_arg);
+		break;
+
+	/* Create a user event */
+	case TRACER_CREATE_USER_EVENT:
+		/* Copy the information from user space */
+		if (copy_from_user(&new_user_event, (void *) ioctl_arg, sizeof(new_user_event)))
+			return -EFAULT;
+
+		/* Create the event */
+		new_user_event_id = trace_create_owned_event(new_user_event.type,
+							     new_user_event.desc,
+							     new_user_event.format_type,
+							     new_user_event.form,
+							     current->pid);
+
+		/* Has the operation succeded */
+		if (new_user_event_id >= 0) {
+			/* Set the event ID */
+			new_user_event.id = new_user_event_id;
+
+			/* Copy the event information back to user space */
+			if (copy_to_user((void *) ioctl_arg, &new_user_event, sizeof(new_user_event))) {
+				/* Since we were unable to tell the user about the event, destroy it */
+				trace_destroy_event(new_user_event_id);
+				return -EFAULT;
+			}
+		} else
+			/* Forward trace_create_event()'s error code */
+			return new_user_event_id;
+		break;
+
+	/* Destroy a user event */
+	case TRACER_DESTROY_USER_EVENT:
+		/* Pass on the user's request */
+		trace_destroy_event((int) ioctl_arg);
+		break;
+
+	/* Trace a user event */
+	case TRACER_TRACE_USER_EVENT:
+		/* Copy the information from user space */
+		if (copy_from_user(&user_event, (void *) ioctl_arg, sizeof(user_event)))
+			return -EFAULT;
+
+		/* Copy the user event data */
+		if (copy_from_user(user_event_data, user_event.data, user_event.data_size))
+			return -EFAULT;
+
+		/* Log the raw event */
+		return_val = trace_raw_event(user_event.id,
+					     user_event.data_size,
+					     user_event_data);
+
+		/* Has the operation failed */
+		if (return_val < 0)
+			/* Forward trace_create_event()'s error code */
+			return return_val;
+		break;
+
+	/* Set event mask */
+	case TRACER_SET_EVENT_MASK:
+		/* Copy the information from user space */
+		if (copy_from_user(&(trace_mask.mask), (void *) ioctl_arg, sizeof(trace_mask.mask)))
+			return -EFAULT;
+
+		/* Trace the event */
+
+		/* Note that we log this only for whatever CPU happens to be 
+		   current - the visualizer tools need to pick this up and 
+		   correlate it with the other CPUs' events. */
+		return_val = trace(TRACE_EV_CHANGE_MASK, &trace_mask, 
+				  smp_processor_id());
+
+		/* Change the event mask. (This has to be done second or else may loose the
+		   information if the user decides to stop logging "change mask" events) */
+		memcpy(&traced_events, &(trace_mask.mask), sizeof(trace_mask.mask));
+		syscall_entry_trace_active = ltt_test_bit(TRACE_EV_SYSCALL_ENTRY, &traced_events);
+		syscall_exit_trace_active  = ltt_test_bit(TRACE_EV_SYSCALL_EXIT, &traced_events);
+
+		/* Always trace the buffer start, the trace start and the change mask */
+		ltt_set_bit(TRACE_EV_BUFFER_START, &traced_events);
+		ltt_set_bit(TRACE_EV_START, &traced_events);
+		ltt_set_bit(TRACE_EV_CHANGE_MASK, &traced_events);
+
+		/* Forward trace()'s error code */
+		return return_val;
+		break;
+
+	/* Get event mask */
+	case TRACER_GET_EVENT_MASK:
+		/* Copy the information to user space */
+		if (copy_to_user((void *) ioctl_arg, &traced_events, sizeof(traced_events)))
+			return -EFAULT;
+		break;
+
+	/* Get information about the CPU configuration */
+	case TRACER_GET_ARCH_INFO:
+		ltt_arch_info.n_cpus = num_cpus;
+		ltt_arch_info.page_shift = PAGE_SHIFT;
+		if(copy_to_user((void *) ioctl_arg, 
+				&ltt_arch_info, 
+				sizeof(ltt_arch_info)))
+			return -EFAULT;
+		break;
+
+	/* Get buffer control data */
+	case TRACER_GET_BUFFER_CONTROL:
+		for(i = 0; i < num_cpus; i++) {
+			/* Return the first buffer control with a buffer switch
+			   still needing to be serviced - the daemon will ask
+			   for the others later. */
+			if(buffer_switches_pending & (1UL << i)) {
+				update_shared_buffer_control(i);
+				/* Copy the buffer control information to user
+				   space.  We can't copy_to_user() with a lock
+				   held (accessing user memory may cause a page
+				   fault),  so buffers_produced may actually be
+				   larger than what the daemon sees when this
+				   snapshot is taken.  This isn't a problem 
+				   because the daemon will get a chance to 
+				   read the new buffer the next time it's 
+				   signaled. */
+				if(copy_to_user((void *) ioctl_arg, 
+						&shared_buffer_control, 
+						sizeof(shared_buffer_control)))
+					return -EFAULT;
+				return 0;
+			}
+		}
+
+		/* If we're here, there were no cpus ready - let the daemon
+		   know that.  Use cpu 0 marked as invalid for this purpose. */
+		shared_buffer_control.cpu_id = 0;
+		shared_buffer_control.buffer_control_valid = FALSE;
+		if(copy_to_user((void *) ioctl_arg, 
+				&shared_buffer_control, 
+				sizeof(shared_buffer_control)))
+			return -EFAULT;
+		break;
+
+	/* Unknown command */
+	default:
+		return -ENOSYS;
+	}
+
+	return 0;
+}
+
+/**
+ *	tracer_mmap: - "Mmap" file op
+ *	@tracer_inode: the inode associated with the device
+ *	@task_file: file structure given to the acting process
+ *	@tracer_vm_area: Virtual memory area description structure
+ *
+ *	Returns:
+ *	0 if ok
+ *	-EAGAIN, when remap failed
+ *	-EACCESS, permission denied
+ */
+int tracer_mmap(struct file *task_file,
+		struct vm_area_struct *tracer_vm_area)
+{
+	int return_val;		/* Function's return value */
+
+	/* Only the trace daemon is allowed access to mmap */
+	if (current != daemon_task_struct)
+		return -EACCES;
+
+	/* Remap trace buffer into the process's memory space */
+	return_val = tracer_mmap_region(tracer_vm_area,
+					(char *) tracer_vm_area->vm_start,
+					trace_buf,
+					tracer_vm_area->vm_end - tracer_vm_area->vm_start);
+
+	return return_val;
+}
+
+/**
+ *	tracer_open(): - "Open" file op
+ *	@tracer_inode: the inode associated with the device
+ *	@task_file: file structure given to the acting process
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-ENODEV, no such device.
+ *	-EBUSY, daemon channel (minor number 0) already in use.
+ */
+int tracer_open(struct inode *tracer_inode,
+		struct file *task_file)
+{
+	int dev_minor_no = minor(tracer_inode->i_rdev) & 0x0f;	/* Device minor number */
+
+	tracer_started = FALSE;
+	tracer_stopping = FALSE;
+
+	/* Only minor number 0 and 1 are used */
+	if ((dev_minor_no > 0) && (dev_minor_no != 1))
+		return -ENODEV;
+
+	/* If the device has already been opened */
+	if (open_count) {
+		/* Is there another process trying to open the daemon's channel (minor number 0) */
+		if (dev_minor_no == 0)
+			return -EBUSY;
+		else
+			/* Only increment use, this is just another user process trying to log user events */
+			goto IncrementUse;
+	}
+
+	/* Fetch the task structure of the process that opened the device */
+	daemon_task_struct = current;
+
+	/* Reset the default configuration since this is the daemon and he will complete the setup */
+	tracer_set_default_config();
+
+IncrementUse:
+	/* Lock the device */
+	open_count++;
+
+#ifdef MODULE
+	/* Increment module usage */
+	MOD_INC_USE_COUNT;
+#endif
+
+	return 0;
+}
+
+/**
+ *	tracer_release: - "Release" file op
+ *	@tracer_inode: the inode associated with the device
+ *	@task_file: file structure given to the acting process
+ *
+ *	Returns: 
+ *	0, everything went OK
+ *	-EBUSY, there are still event writes in progress so the buffer can't
+ *	be released.
+ *
+ *	Note:
+ *	It is assumed that if the tracing daemon dies, exits or simply stops
+ *	existing, the kernel or "someone" will call tracer_release. Otherwise,
+ *      we're in trouble ...
+ */
+int tracer_release(struct inode *tracer_inode,
+		   struct file *task_file)
+{
+	int event_writes_pending, i;
+	int dev_minor_no = minor(tracer_inode->i_rdev) & 0x0f;	/* Device minor number */
+
+	/* Is this a simple user process exiting? */
+	if (dev_minor_no != 0)
+		goto DecrementUse;
+
+	/* Did we loose any events */
+	for(i = 0; i < num_cpus; i++)
+		if (events_lost(i) > 0)
+			printk(KERN_ALERT "Tracer: Lost %d events on cpu %d\n",
+			       events_lost(i), i);
+
+	/* Reset the daemon PID */
+	daemon_task_struct = NULL;
+
+	/* Free the current buffers, if any, but only if they're not still
+	   in use */
+	if (trace_buf != NULL) {
+		event_writes_pending = trace_get_pending_write_count();
+		if(event_writes_pending == 0)
+			rvfree(trace_buf, alloc_size);
+		else {
+			printk(KERN_ERR "Tracer: Couldn't release tracer - %d event writes pending \n",
+			       event_writes_pending);
+			return -EBUSY;
+		}
+	}
+
+	/* Reset the read and write buffers */
+	trace_buf = NULL;
+	for(i = 0; i < num_cpus; i++) {
+		write_buf(i) = NULL;
+		read_buf(i) = NULL;
+		write_buf_end(i) = NULL;
+		read_buf_end(i) = NULL;
+		current_write_pos(i) = NULL;
+		read_limit(i) = NULL;
+		write_limit(i) = NULL;
+		events_lost(i) = 0;
+		atomic_set(&signal_sent(i), FALSE);
+	}
+
+	use_locking = TRUE;
+
+	/* Reset the tracer's configuration */
+	tracer_set_default_config();
+	tracer_started = FALSE;
+	tracer_stopping = FALSE;
+
+	/* Reset number of bytes recorded and number of events lost */
+	buf_read_complete = 0;
+	size_read_incomplete = 0;
+
+DecrementUse:
+	/* Unlock the device */
+	open_count--;
+
+#ifdef MODULE
+	/* Decrement module usage */
+	MOD_DEC_USE_COUNT;
+#endif
+
+	return 0;
+}
+
+/**
+ *	tracer_fsync: - "Fsync" file op
+ *	@task_file: file structure given to the acting process
+ *	@tracer_dentry: dentry associated with file
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-EACCESS, permission denied
+ *
+ *	Note:
+ *	We need to look the modifications of the values because they are read
+ *	and written by trace().
+ */
+int tracer_fsync(struct file *task_file,
+		 struct dentry *tracer_dentry,
+		 int data_sync)
+{
+	unsigned long int flags, i;
+
+	/* Only the trace daemon is allowed access to fsync */
+	if (current != daemon_task_struct)
+		return -EACCES;
+
+	/* Lock the kernel */
+	spin_lock_irqsave(&trace_spin_lock, flags);
+
+	for(i = 0; i < num_cpus; i++) {
+		/* Reset the write positions */
+		current_write_pos(i) = write_buf(i);
+
+		/* Reset read limit */
+		read_limit(i) = read_buf(i);
+		events_lost(i) = 0;
+		atomic_set(&signal_sent(i), FALSE);
+	}
+
+	/* Reset bytes recorded */
+	buf_read_complete = 0;
+	size_read_incomplete = 0;
+
+	/* Unlock the kernel */
+	spin_unlock_irqrestore(&trace_spin_lock, flags);
+
+	return 0;
+}
+
+/**
+ *	tracer_set_buffer_size: - Sets the size of the buffers.
+ *	@buffers_size: Size of buffers
+ *
+ *	Returns:
+ *	0, Size setting went OK
+ *	-ENOMEM, unable to get a hold of memory for tracer
+ *
+ *	buf_no_bits must have already been set before this function is called.
+ */
+int tracer_set_buffer_size(int buffers_size)
+{
+	int size_alloc;
+	int no_buffers = TRACE_MAX_BUFFER_NUMBER(buf_no_bits);
+
+	/* We want to make sure the number of buffers allocated matches
+	   the number of CPUs we use for the rest of the trace */
+	num_cpus = num_online_cpus();
+
+	if(use_locking == TRUE) {
+		/* Set size to allocate (= pmSize * 2) per CPU and fix it's 
+		   size to be on a page boundary */
+		cpu_buf_size = FIX_SIZE(buffers_size << 1);
+
+		/* Set size allocated for all CPUs */
+		size_alloc = cpu_buf_size * num_cpus;
+	} else {
+		/* Calculate power-of-2 buffer size */
+		if(hweight32(buffers_size) != 1)
+			/* Invalid if # set bits != 1 */
+			return -EINVAL;
+			
+		/* Find position of one and only set bit */
+		buf_offset_bits = ffs(buffers_size) - 1;
+
+		/* Set size to allocate (= pmSize * n buffers) per CPU and 
+		   fix it's size to be on a page boundary */
+		cpu_buf_size = FIX_SIZE(buffers_size * no_buffers);
+
+		/* Calculate total size of buffers for all CPUs*/
+		size_alloc = cpu_buf_size * num_cpus;
+
+		/* Sanity check */ 
+		if(size_alloc > TRACER_LOCKLESS_MAX_TOTAL_BUF_SIZE) 
+			return -EINVAL;
+	}
+
+	/* Free the current buffers, if any, but only if they're not still in use */
+	if (trace_buf != NULL) {
+		if(trace_get_pending_write_count() == 0)
+			rvfree(trace_buf, alloc_size);
+		else
+			return -EBUSY;
+	}
+
+	/* Allocate space for the tracing buffers */
+	if ((trace_buf = (char *) rvmalloc(size_alloc)) == NULL)
+		return -ENOMEM;
+
+	/* Remember the size set */
+	buf_size = buffers_size;
+	alloc_size = size_alloc;
+
+	return 0;
+}
+
+/**
+ *	tracer_set_default_config: - Sets the tracer in its default config
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-ENOMEM, unable to get a hold of memory for tracer
+ */
+int tracer_set_default_config(void)
+{
+	int i;
+	int return_val = 0;
+
+	/* Initialize the event mask */
+	traced_events = 0;
+
+	/* Initialize the event mask with all existing events with their details */
+	for (i = 0; i <= TRACE_EV_MAX; i++) {
+		ltt_set_bit(i, &traced_events);
+		ltt_set_bit(i, &log_event_details_mask);
+	}
+
+	/* Do not interfere with Linux's syscall flow until we actually start tracing */
+	syscall_entry_trace_active = 0;
+	syscall_exit_trace_active  = 0;
+
+	/* Forget about the CPUID */
+	log_cpuid = FALSE;
+
+	/* We aren't tracing any PID or GID in particular */
+	tracing_pid = FALSE;
+	tracing_pgrp = FALSE;
+	tracing_gid = FALSE;
+	tracing_uid = FALSE;
+
+	/* We aren't looking for a particular call depth */
+	syscall_eip_depth_set = FALSE;
+
+	/* We aren't going to place bounds on syscall EIP fetching */
+	use_syscall_eip_bounds = FALSE;
+	lower_eip_bound_set = FALSE;
+	upper_eip_bound_set = FALSE;
+
+	/* By default, use TSC timestamping */
+	using_tsc = TRUE;
+	
+	/* Set the kernel trace configuration to it's basics */
+	trace_set_config(syscall_eip_depth_set,
+			 use_syscall_eip_bounds,
+			 0,
+			 0,
+			 0);
+
+	return return_val;
+}
+
+/**
+ *	tracer_init: - Tracer initialization function.
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-ENONMEM, incapable of allocating necessary memory
+ *	Forwarded error code otherwise
+ */
+int __init tracer_init(void)
+{
+	int return_val = 0;
+
+	/* Initialize configuration */
+	if ((return_val = tracer_set_default_config()) < 0)
+		return return_val;
+
+	/* Initialize open count */
+	open_count = 0;
+
+	/* Initialize tracer lock */
+	trace_lock = 0;
+
+	/* Initialize bytes read and events lost */
+	buf_read_complete = 0;
+	size_read_incomplete = 0;
+
+	/* Initialize tracing daemon task structure */
+	daemon_task_struct = NULL;
+
+	/* Allocate memory for large data components */
+	if ((user_event_data = vmalloc(CUSTOM_EVENT_MAX_SIZE)) < 0)
+		return -ENOMEM;
+
+	/* Initialize spin lock */
+	trace_spin_lock = SPIN_LOCK_UNLOCKED;
+
+	/* By default, use locking scheme */
+	use_locking = TRUE;
+
+	/* Register the tracer as a char device */
+	major_number = register_chrdev(0, TRACER_NAME, &tracer_file_ops);
+
+	/* Initialize next event ID to be used */
+	next_event_id = TRACE_EV_MAX + 1;
+
+	/* Initialize custom events list */
+	custom_events = &custom_events_head;
+	custom_events->next = custom_events;
+	custom_events->prev = custom_events;
+
+	return return_val;
+}
+
+/**
+ *	trace_set_config: - Set the tracing configuration
+ *	@pm_trace_function: the trace function.
+ *	@pm_fetch_syscall_use_depth: Use depth to fetch eip
+ *	@pm_fetch_syscall_use_bounds: Use bounds to fetch eip
+ *	@pm_syscall_eip_depth: Detph to fetch eip
+ *	@pm_syscall_lower_bound: Lower bound eip address
+ *	@pm_syscall_upper_bound: Upper bound eip address
+ *
+ *	Returns: 
+ *	0, all is OK 
+ *	-ENOMEDIUM, there isn't a registered tracer
+ *	-ENXIO, wrong tracer
+ *	-EINVAL, invalid configuration
+ */
+int trace_set_config(int pm_fetch_syscall_use_depth,
+		     int pm_fetch_syscall_use_bounds,
+		     int pm_syscall_eip_depth,
+		     void *pm_syscall_lower_bound,
+		     void *pm_syscall_upper_bound)
+{
+	/* Is this a valid configuration */
+	if ((pm_fetch_syscall_use_depth && pm_fetch_syscall_use_bounds)
+	    || (pm_syscall_lower_bound > pm_syscall_upper_bound)
+	    || (pm_syscall_eip_depth < 0))
+		return -EINVAL;
+
+	/* Set the configuration */
+	fetch_syscall_eip_use_depth = pm_fetch_syscall_use_depth;
+	fetch_syscall_eip_use_bounds = pm_fetch_syscall_use_bounds;
+	syscall_eip_depth = pm_syscall_eip_depth;
+	syscall_lower_eip_bound = pm_syscall_lower_bound;
+	syscall_upper_eip_bound = pm_syscall_upper_bound;
+
+	return 0;
+}
+
+/**
+ *	trace_get_config: - Get the tracing configuration
+ *	@pm_fetch_syscall_use_depth: Use depth to fetch eip
+ *	@pm_fetch_syscall_use_bounds: Use bounds to fetch eip
+ *	@pm_syscall_eip_depth: Detph to fetch eip
+ *	@pm_syscall_lower_bound: Lower bound eip address
+ *	@pm_syscall_upper_bound: Upper bound eip address
+ *
+ *	Returns:
+ *	0, all is OK 
+ *	-ENOMEDIUM, there isn't a registered tracer
+ */
+int trace_get_config(int *pm_fetch_syscall_use_depth,
+		     int *pm_fetch_syscall_use_bounds,
+		     int *pm_syscall_eip_depth,
+		     void **pm_syscall_lower_bound,
+		     void **pm_syscall_upper_bound)
+{
+	/* Get the configuration */
+	*pm_fetch_syscall_use_depth = fetch_syscall_eip_use_depth;
+	*pm_fetch_syscall_use_bounds = fetch_syscall_eip_use_bounds;
+	*pm_syscall_eip_depth = syscall_eip_depth;
+	*pm_syscall_lower_bound = syscall_lower_eip_bound;
+	*pm_syscall_upper_bound = syscall_upper_eip_bound;
+
+	return 0;
+}
+
+/**
+ *	_trace_create_event: - Create a new traceable event type
+ *	@pm_event_type: string describing event type
+ *	@pm_event_desc: string used for standard formatting
+ *	@pm_format_type: type of formatting used to log event data
+ *	@pm_format_data: data specific to format
+ *	@pm_owner_pid: PID of event's owner (0 if none)
+ *
+ *	Returns:
+ *	New Event ID if all is OK
+ *	-ENOMEM, Unable to allocate new event
+ */
+int _trace_create_event(char *pm_event_type,
+			char *pm_event_desc,
+			int pm_format_type,
+			char *pm_format_data,
+			pid_t pm_owner_pid)
+{
+	trace_new_event *p_event;
+	struct custom_event_desc *p_new_event;
+
+	/* Create event */
+	if ((p_new_event = (struct custom_event_desc *) kmalloc(sizeof(struct custom_event_desc), GFP_ATOMIC)) == NULL)
+		 return -ENOMEM;
+	p_event = &(p_new_event->event);
+
+	/* Initialize event properties */
+	p_event->type[0] = '\0';
+	p_event->desc[0] = '\0';
+	p_event->form[0] = '\0';
+
+	/* Set basic event properties */
+	if (pm_event_type != NULL)
+		strncpy(p_event->type, pm_event_type, CUSTOM_EVENT_TYPE_STR_LEN);
+	if (pm_event_desc != NULL)
+		strncpy(p_event->desc, pm_event_desc, CUSTOM_EVENT_DESC_STR_LEN);
+	if (pm_format_data != NULL)
+		strncpy(p_event->form, pm_format_data, CUSTOM_EVENT_FORM_STR_LEN);
+
+	/* Ensure that strings are bound */
+	p_event->type[CUSTOM_EVENT_TYPE_STR_LEN - 1] = '\0';
+	p_event->desc[CUSTOM_EVENT_DESC_STR_LEN - 1] = '\0';
+	p_event->form[CUSTOM_EVENT_FORM_STR_LEN - 1] = '\0';
+
+	/* Set format type */
+	p_event->format_type = pm_format_type;
+
+	/* Give the new event a unique event ID */
+	p_event->id = next_event_id;
+	next_event_id++;
+
+	/* Set event's owner */
+	p_new_event->owner_pid = pm_owner_pid;
+
+	/* Insert new event in event list */
+	write_lock(&custom_list_lock);
+	p_new_event->next = custom_events;
+	p_new_event->prev = custom_events->prev;
+	custom_events->prev->next = p_new_event;
+	custom_events->prev = p_new_event;
+	write_unlock(&custom_list_lock);
+
+	/* Log the event creation event */
+	trace_event(TRACE_EV_NEW_EVENT, &(p_new_event->event));
+
+	return p_event->id;
+}
+int trace_create_event(char *pm_event_type,
+		       char *pm_event_desc,
+		       int pm_format_type,
+		       char *pm_format_data)
+{
+	return _trace_create_event(pm_event_type, pm_event_desc, pm_format_type, pm_format_data, 0);
+}
+int trace_create_owned_event(char *pm_event_type,
+			     char *pm_event_desc,
+			     int pm_format_type,
+			     char *pm_format_data,
+			     pid_t pm_owner_pid)
+{
+	return _trace_create_event(pm_event_type, pm_event_desc, pm_format_type, pm_format_data, pm_owner_pid);
+}
+
+/**
+ *	trace_destroy_event: - Destroy a created event type
+ *	@pm_event_id, the Id returned by trace_create_event()
+ *
+ *	No return values.
+ */
+void trace_destroy_event(int pm_event_id)
+{
+	struct custom_event_desc *p_event_desc;
+
+	write_lock(&custom_list_lock);
+
+	/* Find the event to destroy in the event description list */
+	for (p_event_desc = custom_events->next;
+	     p_event_desc != custom_events;
+	     p_event_desc = p_event_desc->next)
+		if (p_event_desc->event.id == pm_event_id)
+			break;
+
+	/* If we found something */
+	if (p_event_desc != custom_events) {
+		/* Remove the event fromt the list */
+		p_event_desc->next->prev = p_event_desc->prev;
+		p_event_desc->prev->next = p_event_desc->next;
+
+		/* Free the memory used by this event */
+		kfree(p_event_desc);
+	}
+	write_unlock(&custom_list_lock);
+}
+
+/**
+ *	trace_destroy_owners_events: Destroy an owner's events
+ *	@pm_owner_pid: the PID of the owner who's events are to be deleted.
+ *
+ *	No return values.
+ */
+void trace_destroy_owners_events(pid_t pm_owner_pid)
+{
+	struct custom_event_desc *p_temp_event;
+	struct custom_event_desc *p_event_desc;
+
+	write_lock(&custom_list_lock);
+
+	/* Start at the first event in the list */
+	p_event_desc = custom_events->next;
+
+	/* Find all events belonging to the PID */
+	while (p_event_desc != custom_events) {
+		p_temp_event = p_event_desc->next;
+
+		/* Does this event belong to the same owner */
+		if (p_event_desc->owner_pid == pm_owner_pid) {
+			/* Remove the event from the list */
+			p_event_desc->next->prev = p_event_desc->prev;
+			p_event_desc->prev->next = p_event_desc->next;
+
+			/* Free the memory used by this event */
+			kfree(p_event_desc);
+		}
+		p_event_desc = p_temp_event;
+	}
+
+	write_unlock(&custom_list_lock);
+}
+
+/**
+ *	trace_reregister_custom_events: - Relogs event creations.
+ *
+ *	Relog the declarations of custom events. This is necessary to make
+ *	sure that even though the event creation might not have taken place
+ *	during a previous trace, that all custom events be part of all traces.
+ *	Hence, if a custom event occurs during a new trace, we can be sure
+ *	that its definition will also be part of the trace.
+ *
+ *	No return values.
+ */
+void trace_reregister_custom_events(void)
+{
+	struct custom_event_desc *p_event_desc;
+
+	read_lock(&custom_list_lock);
+
+	/* Log an event creation for every description in the list */
+	for (p_event_desc = custom_events->next;
+	     p_event_desc != custom_events;
+	     p_event_desc = p_event_desc->next)
+		trace_event(TRACE_EV_NEW_EVENT, &(p_event_desc->event));
+
+	read_unlock(&custom_list_lock);
+}
+
+/**
+ *	trace_std_formatted_event: - Trace a formatted event
+ *	@pm_event_id: the event Id provided upon creation
+ *	@...: printf-like data that will be used to fill the event string.
+ *
+ *	Returns:
+ *	Trace fct return code if OK.
+ *	-ENOMEDIUM, there is no registered tracer or event doesn't exist.
+ */
+int trace_std_formatted_event(int pm_event_id,...)
+{
+	int l_string_size;	/* Size of the string outputed by vsprintf() */
+	char l_string[CUSTOM_EVENT_FINAL_STR_LEN];	/* Final formatted string */
+	va_list l_var_arg_list;	/* Variable argument list */
+	trace_custom l_custom;
+	struct custom_event_desc *p_event_desc;
+
+	read_lock(&custom_list_lock);
+
+	/* Find the event description matching this event */
+	for (p_event_desc = custom_events->next;
+	     p_event_desc != custom_events;
+	     p_event_desc = p_event_desc->next)
+		if (p_event_desc->event.id == pm_event_id)
+			break;
+
+	/* If we haven't found anything */
+	if (p_event_desc == custom_events) {
+		read_unlock(&custom_list_lock);
+
+		return -ENOMEDIUM;
+	}
+	/* Set custom event Id */
+	l_custom.id = pm_event_id;
+
+	/* Initialize variable argument list access */
+	va_start(l_var_arg_list, pm_event_id);
+
+	/* Print the description out to the temporary buffer */
+	l_string_size = vsprintf(l_string, p_event_desc->event.desc, l_var_arg_list);
+
+	read_unlock(&custom_list_lock);
+
+	/* Facilitate return to caller */
+	va_end(l_var_arg_list);
+
+	/* Set the size of the event */
+	l_custom.data_size = (u32) (l_string_size + 1);
+
+	/* Set the pointer to the event data */
+	l_custom.data = l_string;
+
+	/* Log the custom event */
+	return trace_event(TRACE_EV_CUSTOM, &l_custom);
+}
+
+/**
+ *	trace_raw_event: - Trace a raw event
+ *	@pm_event_id, the event Id provided upon creation
+ *	@pm_event_size, the size of the data provided
+ *	@pm_event_data, data buffer describing event
+ *
+ *	Returns:
+ *	Trace fct return code if OK.
+ *	-ENOMEDIUM, there is no registered tracer or event doesn't exist.
+ */
+int trace_raw_event(int pm_event_id, int pm_event_size, void *pm_event_data)
+{
+	trace_custom l_custom;
+	struct custom_event_desc *p_event_desc;
+
+	read_lock(&custom_list_lock);
+
+	/* Find the event description matching this event */
+	for (p_event_desc = custom_events->next;
+	     p_event_desc != custom_events;
+	     p_event_desc = p_event_desc->next)
+		if (p_event_desc->event.id == pm_event_id)
+			break;
+
+	read_unlock(&custom_list_lock);
+
+	/* If we haven't found anything */
+	if (p_event_desc == custom_events)
+		return -ENOMEDIUM;
+
+	/* Set custom event Id */
+	l_custom.id = pm_event_id;
+
+	/* Set the data size */
+	if (pm_event_size <= CUSTOM_EVENT_MAX_SIZE)
+		l_custom.data_size = (u32) pm_event_size;
+	else
+		l_custom.data_size = (u32) CUSTOM_EVENT_MAX_SIZE;
+
+	/* Set the pointer to the event data */
+	l_custom.data = pm_event_data;
+
+	/* Log the custom event */
+	return trace_event(TRACE_EV_CUSTOM, &l_custom);
+}
+
+/**
+ *	trace_event: - Trace an event
+ *	@pm_event_id, the event's ID (check out trace.h)
+ *	@pm_event_struct, the structure describing the event
+ *
+ *	Returns:
+ *	Trace fct return code if OK.
+ *	-ENOMEDIUM, there is no registered tracer
+ *	-ENOMEM, couldn't access ltt_info
+ */
+int trace_event(u8 pm_event_id,
+		void *pm_event_struct)
+{
+	int l_ret_value;
+
+	atomic_inc(&pending_write_count);
+
+	/* Call the tracer */
+	l_ret_value = trace(pm_event_id, 
+			    pm_event_struct, 
+			    smp_processor_id());
+	
+	atomic_dec(&pending_write_count);
+
+	return l_ret_value;
+}
+
+/**
+ *	trace_get_pending_write_count: - Get nbr pending writes.
+ *
+ *	Returns the number of trace event writes in progress.
+ */
+int trace_get_pending_write_count(void)
+{
+	return atomic_read(&pending_write_count);
+}
+
+module_init(tracer_init);
+
+/* Export symbols so that can be visible from outside this file */
+EXPORT_SYMBOL(trace_set_config);
+EXPORT_SYMBOL(trace_get_config);
+EXPORT_SYMBOL(trace_create_event);
+EXPORT_SYMBOL(trace_create_owned_event);
+EXPORT_SYMBOL(trace_destroy_event);
+EXPORT_SYMBOL(trace_destroy_owners_events);
+EXPORT_SYMBOL(trace_std_formatted_event);
+EXPORT_SYMBOL(trace_raw_event);
+EXPORT_SYMBOL(trace_event);
+
+EXPORT_SYMBOL(syscall_entry_trace_active);
+EXPORT_SYMBOL(syscall_exit_trace_active);
