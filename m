Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262370AbSJ2Vt5>; Tue, 29 Oct 2002 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262392AbSJ2Vt5>; Tue, 29 Oct 2002 16:49:57 -0500
Received: from nameservices.net ([208.234.25.16]:54060 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262370AbSJ2Vrn>;
	Tue, 29 Oct 2002 16:47:43 -0500
Message-ID: <3DBF0483.984E6E84@opersys.com>
Date: Tue, 29 Oct 2002 16:58:27 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.44-bk2 3/10: Trace subsystem 2/2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[This is the second part of kernel/trace.c]

+
+/**
+ *	init_buffer_control: - Init buffer control struct for new tracing run.
+ *	@buf_ctrl: buffer control struct to be initialized
+ *	@use_lockless: which tracing scheme to use, 1 for lockless
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
+		/* Set things up to trigger per-cpu initialization */ 
+		if(using_tsc)
+			atomic_set(&_waiting_for_cpu(buf_ctrl, i), 
+				   LTT_INITIALIZE_TRACE);
+		else
+			atomic_set(&_waiting_for_cpu(buf_ctrl, i), 
+				   LTT_NOTHING_TO_DO);
+		atomic_set(&_waiting_for_cpu_async(buf_ctrl, i), 
+			   LTT_NOTHING_TO_DO);
+		_trace_buffer(buf_ctrl, i) = trace_buf + (i * cpu_buf_size);
+
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
+			_index(buf_ctrl, i) = start_reserve + 
+				TRACER_START_TRACE_EVENT_SIZE;
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
+				   (int)start_reserve + 
+				   TRACER_START_TRACE_EVENT_SIZE);
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
+	/* Do we trace the event */
+	if ((tracer_started == 1) || (event_id == TRACE_EV_START) || (event_id == TRACE_EV_BUFFER_START))
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
+		if ((tracing_pid == 1) && (current->pid != traced_pid)) {
+			/* Record this event if it is the scheduling change bringing in the traced PID */
+			if (incoming_process == NULL)
+				return 0;
+			else if (incoming_process->pid != traced_pid)
+				return 0;
+		}
+		/* Are we monitoring a particular process group */
+		if ((tracing_pgrp == 1) && (current->pgrp != traced_pgrp)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced PGRP */
+			if (incoming_process == NULL)
+				return 0;
+			else if (incoming_process->pgrp != traced_pgrp)
+				return 0;
+		}
+		/* Are we monitoring the processes of a given group of users */
+		if ((tracing_gid == 1) && (current->egid != traced_gid)) {
+			/* Record this event if it is the scheduling change bringing in a process of the traced GID */
+			if (incoming_process == NULL)
+				return 0;
+			else if (incoming_process->egid != traced_gid)
+				return 0;
+		}
+		/* Are we monitoring the processes of a given user */
+		if ((tracing_uid == 1) && (current->euid != traced_uid)) {
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
+	if ((log_cpuid == 1) && (event_id != TRACE_EV_START) && (event_id != TRACE_EV_BUFFER_START)) {
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
+	/* Disable interrupts on this CPU */
+	local_irq_save(flags);
+
+	/* The following time calculations have to be done with interrupts disabled because
+	   otherwise the event order could be inverted. */
+
+	/* Get the time of the event */
+	time_delta = get_time_delta(&time_stamp, cpu_id);
+
+	/* Is there enough space left in the write buffer */
+	if (current_write_pos(cpu_id) + data_size > write_limit(cpu_id)) {
+		/* Have we already switched buffers and informed the daemon of it */
+		if (atomic_read(&signal_sent(cpu_id)) == 1) {
+			/* We've lost another event */
+			(events_lost(cpu_id))++;
+
+			/* Bye, bye, now */
+			local_irq_restore(flags);
+			return -ENOMEM;
+		}
+		/* We need to inform the daemon */
+		atomic_set(&send_signal, 1);
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
+	if ((log_cpuid == 1) && (event_id != TRACE_EV_START) && (event_id != TRACE_EV_BUFFER_START))
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
+	if ((atomic_read(&send_signal) == 1) && 
+	    (event_id != TRACE_EV_SCHEDCHANGE)) {
+		/* Remember that a signal has been sent */
+		atomic_set(&signal_sent(cpu_id), 1);
+
+		/* Atomically mark buffer-switch bit for this cpu */
+		set_bit(cpu_id, &buffer_switches_pending);
+ 
+		/* Clear the global pending signal flag */
+		atomic_set(&send_signal, 0);
+
+		/* Restore interrupts on this CPU */
+		local_irq_restore(flags);
+
+		/* Setup signal information */
+		daemon_sig_info.si_signo = SIGIO;
+		daemon_sig_info.si_errno = 0;
+		daemon_sig_info.si_code = SI_KERNEL;
+
+		/* Signal the tracing daemon */
+		send_sig_info(SIGIO, &daemon_sig_info, daemon_task_struct);
+	} else
+		/* Restore interrupts on this CPU */
+		local_irq_restore(flags);
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
+ *	This should be called from with interrupts disabled.
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
+	if (log_cpuid == 1) {
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
+	shared_buffer_control.buffer_control_valid = 1;
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
+ *	sys_trace: - Tracing system call
+ *
+ *	@tracer_handle: tracing mechanism handle
+ *	@tracer_command: command given by the caller
+ *	@command_arg1: argument "1" to the command
+ *	@command_arg2: argument "2" to the command
+ *
+ *	Returns:
+ *	>0, In case the caller requested the number of events lost.
+ *	0, Everything went OK
+ *	-ENOSYS, no such command
+ *	-EINVAL, tracer not properly configured
+ *	-EBUSY, tracer can't be reconfigured while in operation
+ *	-ENOMEM, no more memory
+ *	-EFAULT, unable to access user space memory
+ *	-EACCES, invalid tracer handle
+ */
+asmlinkage int sys_trace(unsigned int tracer_handle,
+			 unsigned int tracer_command,
+			 unsigned long command_arg1,
+			 unsigned long command_arg2)
+{
+	int retval;			/* Function return value */
+	int new_user_event_id;		/* ID of newly created user event */
+	unsigned long mmap_start_addr;	/* Start address of buffer in process space */
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
+	/* Is this a handle request */
+	if (tracer_command == TRACER_ALLOC_HANDLE)
+		return trace_alloc_handle(tracer_handle);
+
+	/* Is the handle provided valid? */
+	if (!trace_valid_handle(tracer_handle))
+		return -EACCES;
+
+	/* If the tracer is started, the daemon can't modify the configuration */
+	if ((tracer_handle == 0)
+	    && (tracer_started == 1)
+	    && (tracer_command != TRACER_STOP)
+	    && (tracer_command != TRACER_DATA_COMITTED)
+	    && (tracer_command != TRACER_GET_BUFFER_CONTROL))
+		return -EBUSY;
+
+	/* Only some operations are permitted to user processes trying to log events */
+	if ((tracer_handle > 1)
+	    && (tracer_command != TRACER_CREATE_USER_EVENT)
+	    && (tracer_command != TRACER_DESTROY_USER_EVENT)
+	    && (tracer_command != TRACER_TRACE_USER_EVENT)
+	    && (tracer_command != TRACER_SET_EVENT_MASK)
+	    && (tracer_command != TRACER_GET_EVENT_MASK))
+		return -ENOSYS;
+
+	
+	/* Depending on the command executed */
+	switch (tracer_command) {
+	/* Start the tracer */
+	case TRACER_START:
+		/* Clear the global pending signal flag */
+		atomic_set(&send_signal, 0);
+
+		/* Start the heartbeat timer */
+		init_heartbeat_timer();
+		init_percpu_timers();
+
+		/* Initialize buffer control regardless of scheme in use */
+		init_buffer_control(buffer_control,
+				    !use_locking,    /* using_lockless */
+				    buf_no_bits,     /* bufno_bits, 2**n */
+				    buf_offset_bits); /* offset_bits, 2**n */
+
+		/* Check if the device has been properly set up */
+		if (((use_syscall_eip_bounds == 1)
+		     && (syscall_eip_depth_set == 1))
+		    || ((use_syscall_eip_bounds == 1)
+			&& ((lower_eip_bound_set != 1)
+			    || (upper_eip_bound_set != 1)))
+		    || ((tracing_pid == 1)
+			&& (tracing_pgrp == 1)))
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
+		if(using_tsc == 0)
+			for(i = 0; i < num_cpus; i++)
+				initialize_trace(i);
+
+		/* Start tapping into Linux's syscall flow */
+		syscall_entry_trace_active = ltt_test_bit(TRACE_EV_SYSCALL_ENTRY, &traced_events);
+		syscall_exit_trace_active  = ltt_test_bit(TRACE_EV_SYSCALL_EXIT, &traced_events);
+
+		/* We can start tracing */
+		tracer_stopping = 0;
+		tracer_started = 1;
+
+		/* Reregister custom trace events created earlier */
+		trace_reregister_custom_events();
+
+		break;
+
+	/* Stop the tracer */
+	case TRACER_STOP:
+		/* Stop heartbeat timer if we were using it */
+		if(using_tsc == 1)
+			del_timer(&heartbeat_timer);
+
+		/* Stop tracing */
+ 		/* We don't log new events, but old lockless ones can finish */
+		tracer_stopping = 1;
+		tracer_started = 0;
+
+		/* Stop interrupting the normal flow of system calls */
+		syscall_entry_trace_active = 0;
+		syscall_exit_trace_active  = 0;
+
+ 		/* Make sure the last buffer touched is finalized */
+		if(using_lockless) {
+			/* If we're not using TSC, we can finalize all now */
+			/* Write end buffer event as last event in old buf. */
+			if(using_tsc == 0) {
+				for(i = 0; i < num_cpus; i++)
+					finalize_lockless_trace(i);
+				tracer_stopping = 0;
+			} else
+				for(i = 0; i < num_cpus; i++)
+					set_waiting_for_cpu_async(i, LTT_FINALIZE_TRACE);
+			break;
+ 		} /* Else locking scheme */
+
+		/* Acquire the lock to avoid SMP case of where another CPU is writing a trace
+		   while buffer is being switched */
+		spin_lock_irqsave(&trace_spin_lock, flags);
+
+		if(using_tsc == 0) {
+			/* Get the time of the event */
+			get_timestamp(&current_time, &current_tsc);
+
+			/* If we're not using TSC, we can finalize all now */
+			for(i = 0; i < num_cpus; i++) {
+				/* Atomically mark buffer-switch bit for cpu */
+				set_bit(i, &buffer_switches_pending);
+
+				/* Switch the buffers to ensure that the end 
+				   of the buffer mark is set */
+				tracer_switch_buffers(current_time, 
+						      current_tsc, i);
+			}
+			tracer_stopping = 0;
+		} else {
+			for(i = 0; i < num_cpus; i++)
+				set_waiting_for_cpu_async(i, LTT_FINALIZE_TRACE);
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
+		if (use_locking == 1) {
+			if (command_arg1 < TRACER_MIN_BUF_SIZE)
+				return -EINVAL;
+		} else {
+			if ((command_arg1 < TRACER_LOCKLESS_MIN_BUF_SIZE) || 
+			    (command_arg1 > TRACER_LOCKLESS_MAX_BUF_SIZE))
+				return -EINVAL;
+		}
+
+		/* Set the buffer's size */
+		return tracer_set_buffer_size(command_arg1);
+		break;
+
+	/* Set the number of memory buffers the daemon wants us to use */
+	case TRACER_CONFIG_N_MEMORY_BUFFERS:
+		/* Is the given size "reasonable" */
+		if ((use_locking == 1) || (command_arg1 < TRACER_MIN_BUFFERS) || 
+		    (command_arg1 > TRACER_MAX_BUFFERS))
+			return -EINVAL;
+
+		/* Set the number of buffers */
+		return tracer_set_n_buffers(command_arg1);
+		break;
+
+	/* Set locking scheme the daemon wants us to use */
+	case TRACER_CONFIG_USE_LOCKING:
+		/* Set the locking scheme in a global for later */
+		use_locking = command_arg1;
+		if((use_locking == 0) && (have_cmpxchg() == 0))
+                        /* Lock-free scheme not supported on this platform */
+			return -EINVAL; 
+		break;
+
+	/* Trace the given events */
+	case TRACER_CONFIG_EVENTS:
+		if (copy_from_user(&traced_events, (void *) command_arg1, sizeof(traced_events)))
+			return -EFAULT;
+		break;
+
+	/* Trace the given events */
+	case TRACER_CONFIG_TIMESTAMP:
+		using_tsc = command_arg1;
+		if((using_tsc == 1) && (have_tsc() == 0)) {
+			using_tsc = 0;
+			return -EINVAL;
+		}
+		break;
+
+	/* Record the details of the event, or not */
+	case TRACER_CONFIG_DETAILS:
+		if (copy_from_user(&log_event_details_mask, (void *) command_arg1, sizeof(log_event_details_mask)))
+			return -EFAULT;
+		break;
+
+	/* Record the CPUID associated with the event */
+	case TRACER_CONFIG_CPUID:
+		log_cpuid = 1;
+		break;
+
+	/* Trace only one process */
+	case TRACER_CONFIG_PID:
+		tracing_pid = 1;
+		traced_pid = command_arg1;
+		break;
+
+	/* Trace only the given process group */
+	case TRACER_CONFIG_PGRP:
+		tracing_pgrp = 1;
+		traced_pgrp = command_arg1;
+		break;
+
+	/* Trace the processes of a given group of users */
+	case TRACER_CONFIG_GID:
+		tracing_gid = 1;
+		traced_gid = command_arg1;
+		break;
+
+	/* Trace the processes of a given user */
+	case TRACER_CONFIG_UID:
+		tracing_uid = 1;
+		traced_uid = command_arg1;
+		break;
+
+	/* Set the call depth a which the EIP should be fetched on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_DEPTH:
+		syscall_eip_depth_set = 1;
+		syscall_eip_depth = command_arg1;
+		break;
+
+	/* Set the lowerbound address from which EIP is recorded on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_LOWER:
+		/* We are using bounds for fetching the EIP where syscall was made */
+		use_syscall_eip_bounds = 1;
+
+		/* Set the lower bound */
+		lower_eip_bound = (void *) command_arg1;
+
+		/* The lower bound has been set */
+		lower_eip_bound_set = 1;
+		break;
+
+	/* Set the upperbound address from which EIP is recorded on syscall */
+	case TRACER_CONFIG_SYSCALL_EIP_UPPER:
+		/* We are using bounds for fetching the EIP where syscall was made */
+		use_syscall_eip_bounds = 1;
+
+		/* Set the upper bound */
+		upper_eip_bound = (void *) command_arg1;
+
+		/* The upper bound has been set */
+		upper_eip_bound_set = 1;
+		break;
+
+	/* The daemon has comitted the last trace */
+	case TRACER_DATA_COMITTED:
+		/* Copy the information from user space */
+		if (copy_from_user(&buffers_committed, (void *)command_arg1, 
+				   sizeof(buffers_committed)))
+			return -EFAULT;
+
+		cpu_id = buffers_committed.cpu_id;
+		buffers_consumed = buffers_committed.buffers_consumed;
+
+		/* Turn off the bit indicating that the cpu's buffer switch
+		   needs servicing */ 
+		clear_bit(cpu_id, &buffer_switches_pending);
+
+		/* The lockless version doesn't use signal_sent.  command_arg1 is
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
+		/* Safely set the signal sent flag to 0 */
+		local_irq_save(flags);
+		atomic_set(&signal_sent(cpu_id), 0);
+		local_irq_restore(flags);
+		break;
+
+	/* Get the number of events lost */
+	case TRACER_GET_EVENTS_LOST:
+		return events_lost(command_arg1);
+		break;
+
+	/* Create a user event */
+	case TRACER_CREATE_USER_EVENT:
+		/* Copy the information from user space */
+		if (copy_from_user(&new_user_event, (void *) command_arg1, sizeof(new_user_event)))
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
+			if (copy_to_user((void *) command_arg1, &new_user_event, sizeof(new_user_event))) {
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
+		trace_destroy_event((int) command_arg1);
+		break;
+
+	/* Trace a user event */
+	case TRACER_TRACE_USER_EVENT:
+		/* Copy the information from user space */
+		if (copy_from_user(&user_event, (void *) command_arg1, sizeof(user_event)))
+			return -EFAULT;
+
+		/* Copy the user event data */
+		if (copy_from_user(user_event_data, user_event.data, user_event.data_size))
+			return -EFAULT;
+
+		/* Log the raw event */
+		retval = trace_raw_event(user_event.id,
+					     user_event.data_size,
+					     user_event_data);
+
+		/* Has the operation failed */
+		if (retval < 0)
+			/* Forward trace_create_event()'s error code */
+			return retval;
+		break;
+
+	/* Set event mask */
+	case TRACER_SET_EVENT_MASK:
+		/* Copy the information from user space */
+		if (copy_from_user(&(trace_mask.mask), (void *) command_arg1, sizeof(trace_mask.mask)))
+			return -EFAULT;
+
+		/* Trace the event */
+
+		/* Note that we log this only for whatever CPU happens to be 
+		   current - the visualizer tools need to pick this up and 
+		   correlate it with the other CPUs' events. */
+		retval = trace(TRACE_EV_CHANGE_MASK, &trace_mask, 
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
+		return retval;
+		break;
+
+	/* Get event mask */
+	case TRACER_GET_EVENT_MASK:
+		/* Copy the information to user space */
+		if (copy_to_user((void *) command_arg1, &traced_events, sizeof(traced_events)))
+			return -EFAULT;
+		break;
+
+	/* Get information about the CPU configuration */
+	case TRACER_GET_ARCH_INFO:
+		ltt_arch_info.n_cpus = num_cpus;
+		ltt_arch_info.page_shift = PAGE_SHIFT;
+		if(copy_to_user((void *) command_arg1, 
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
+				if(copy_to_user((void *) command_arg1, 
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
+		shared_buffer_control.buffer_control_valid = 0;
+		if(copy_to_user((void *) command_arg1, 
+				&shared_buffer_control, 
+				sizeof(shared_buffer_control)))
+			return -EFAULT;
+		break;
+
+	/* Free a handle */
+	case TRACER_FREE_HANDLE:
+		return trace_free_handle(tracer_handle);
+		break;
+
+	/* Free the daemon's handle */
+	case TRACER_FREE_DAEMON_HANDLE:
+		return trace_free_daemon_handle();
+		break;
+
+	/* Free all handles */
+	case TRACER_FREE_ALL_HANDLES:
+		trace_free_all_handles(current);
+		break;
+
+	/* Map buffer to process space */
+	case TRACER_MAP_BUFFER:
+		retval = trace_mmap_buffer(tracer_handle, command_arg1, &mmap_start_addr);
+		/* Copy the mapping information back to user space */
+		if (copy_to_user((void *) command_arg2, &mmap_start_addr, sizeof(mmap_start_addr)))
+			retval = -EFAULT;
+
+		return retval;
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
+ *	trace_mmap_buffer: - mmap buffer to process space
+ *	@tracer_handle: tracing handle
+ *	@length: length requested by daemon
+ *	@start_addr: pointer to mapping start address
+ *
+ *	This function mmaps the buffer to the daemon's address space. To unmap,
+ *	daemon should use sys_mumap(). No need to provide an actual function to
+ *	munmap since the kernel already provides on for that purpose. The
+ *	value of tracer_vm_area is set to NULL when trace_free_daemon_handle()
+ *	is called.
+ *	Returns:
+ *	0 if ok
+ *	-EAGAIN, when remap failed
+ *	-EINVAL, invalid requested length
+ *	-EACCES, permission denied
+ */
+int trace_mmap_buffer(unsigned int tracer_handle,
+		      unsigned long length,
+		      unsigned long *start_addr)
+{
+	int retval;
+	unsigned long actual_size;
+	struct mm_struct *mm = current->mm;
+
+	/* Only the trace daemon is allowed access to mmap */
+	if (current != daemon_task_struct)
+		return -EACCES;
+
+	/* Is the length requested equal to the existing length */
+	if (length != (unsigned long) alloc_size)
+		return -EINVAL;
+
+	/* Are the buffers already mapped to user-space */
+	if (tracer_vm_area != NULL)
+		return -EBUSY;
+
+	down_write(&mm->mmap_sem);
+
+	/* Allocate space of trace buffers in process' address space */
+	*start_addr = do_mmap(NULL, 0, alloc_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, 0);
+	/* Find vma matching start_addr */
+	tracer_vm_area = find_vma(mm, *start_addr);
+
+	actual_size = tracer_vm_area->vm_end - tracer_vm_area->vm_start;
+	/* Make sure sizes are consistent */
+	if (IS_ERR((void *)*start_addr)) {
+		do_munmap(mm, (unsigned long)*start_addr, alloc_size);
+		tracer_vm_area = NULL;
+		retval = -EAGAIN;
+	} else {
+		/* Remap trace buffer into the process's memory space */
+		retval = tracer_mmap_region(tracer_vm_area,
+					    (char *) *start_addr,
+					    trace_buf,
+					    alloc_size);
+	}
+
+	up_write(&mm->mmap_sem);
+
+	return retval;
+}
+
+/**
+ *	trace_valid_handle: - Validate tracer handle.
+ *	@tracer_handle: handle to be validated
+ *
+ *	Returns:
+ *	1, if handle is valid
+ *	0, if handle is invalid
+ */
+int trace_valid_handle(unsigned int tracer_handle)
+{
+	int retval;
+
+	/* Is this the daemon */
+	if (tracer_handle == 0) {
+		if (daemon_task_struct == current)
+			retval = 1;
+		else
+			retval = 0;
+	} else {
+		/* Lock handle table for reading */
+		read_lock(&trace_handle_table_lock);
+
+		/* Test the handle */
+		if (trace_handle_table[tracer_handle - 1].owner == current)
+			retval = 1;
+		else
+			retval = 0;
+
+		/* Unlock table */
+		read_unlock(&trace_handle_table_lock);
+	}
+
+	return retval;
+}
+
+/**
+ *	trace_alloc_handle: - Allocate trace handle to caller.
+ *	@tracer_handle: handle requested by process
+ *
+ *	Returns:
+ *	Handle ID, everything went OK
+ *	-ENODEV, no more free handles.
+ *	-EBUSY, daemon handle already in use.
+ */
+int trace_alloc_handle(unsigned int tracer_handle)
+{
+	int i;
+	int retval;
+
+	/* Is there another process trying to get the daemon's handle */
+	if ((tracer_handle == 0) && (daemon_task_struct != NULL))
+		return -EBUSY;
+
+	/* Is this a normal process trying to get a tracer handle */
+	if (tracer_handle == 1) {
+		/* Lock the trace handle table for writing */
+		write_lock(&trace_handle_table_lock);
+
+		/* Look for a free handle */
+		for (i = 0; i < TRACE_MAX_HANDLES; i++)
+			if (trace_handle_table[i].owner == NULL) {
+				trace_handle_table[i].owner = current;
+				break;
+			}
+
+		/* Unlock the trace handle table */
+		write_unlock(&trace_handle_table_lock);
+
+		/* Were there any free handles */
+		if (i == TRACE_MAX_HANDLES)
+			retval = -ENODEV;
+		else
+			retval = (i + 1);	/* User handle "1" is entry "0" in trace_handle_table. */
+	} else {
+		/* This is the daemon requesting his handle */
+		tracer_started = 0;
+		tracer_stopping = 0;
+
+		/* Fetch the task structure of the process that opened the device */
+		daemon_task_struct = current;
+
+		/* Reset the default configuration since this is the daemon and he will complete the setup */
+		tracer_set_default_config();
+
+		/* Only daemon gets handle "0" */
+		retval = 0;
+	}
+
+	return retval;
+}
+
+/**
+ *	trace_free_handle: - Free a single handle.
+ *	tracer_handle: handle to be freed.
+ *
+ *	Returns: 
+ *	0, everything went OK
+ *	-ENODEV, no such handle.
+ *	-EACCES, handle doesn't belong to caller.
+ */
+int trace_free_handle(unsigned int tracer_handle)
+{
+	int retval;
+
+	/* Does this handle ID makes sense */
+	if ((tracer_handle < 1) || (tracer_handle >= TRACE_MAX_HANDLES))
+		return -ENODEV;
+
+	/* Lock the trace handle table for writing */
+	write_lock(&trace_handle_table_lock);
+
+	/* Does this task have any handles */
+	if (trace_handle_table[tracer_handle - 1].owner == current) {
+		/* Free the handle */
+		trace_handle_table[tracer_handle - 1].owner = NULL;
+		retval = 0;
+	} else {
+		retval = -EACCES;
+	}
+
+	/* Unlock the trace handle table */
+	write_unlock(&trace_handle_table_lock);
+
+	return retval;
+}
+
+/**
+ *	trace_free_daemon_handle: - Free the daemon's handle.
+ *
+ *	Returns: 
+ *	0, everything went OK
+ *	-EACCES, handle doesn't belong to caller.
+ *	-EBUSY, there are still event writes in progress so the buffer can't
+ *	be released.
+ */
+int trace_free_daemon_handle(void)
+{
+	int i;
+	int event_writes_pending;
+
+	/* Is this requested by the daemon */
+	if (daemon_task_struct != current)
+		return -EACCES;
+
+	/* Did we loose any events */
+	for(i = 0; i < num_cpus; i++)
+		if (events_lost(i) > 0)
+			printk(KERN_ALERT "Tracer: Lost %d events on cpu %d\n",
+			       events_lost(i), i);
+
+	/* Reset the daemon's structures */
+	daemon_task_struct = NULL;
+	tracer_vm_area = NULL;
+
+	/* Make sure no timers can fire after we free buffer */
+	del_percpu_timers();
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
+		atomic_set(&signal_sent(i), 0);
+	}
+
+	use_locking = 1;
+
+	/* Reset the tracer's configuration */
+	tracer_set_default_config();
+	tracer_started = 0;
+	tracer_stopping = 0;
+
+	/* Reset number of bytes recorded and number of events lost */
+	buf_read_complete = 0;
+	size_read_incomplete = 0;
+
+	return 0;
+}
+
+/**
+ *	trace_free_all_handles: - Free all handles taken.
+ *	@task_ptr: pointer to exiting task.
+ */
+void trace_free_all_handles(struct task_struct* task_ptr)
+{
+	int i;
+
+	/* Is this the trace daemon */
+	if(daemon_task_struct == task_ptr)
+		trace_free_daemon_handle();
+
+	/* Lock the trace handle table for writing */
+	write_lock(&trace_handle_table_lock);
+
+	/* Does this task have any handles */
+	for (i = 0; i < TRACE_MAX_HANDLES; i++)
+		if (trace_handle_table[i].owner == current)
+			/* Free the handle */
+			trace_handle_table[i].owner = NULL;
+
+	/* Unlock the trace handle table */
+	write_unlock(&trace_handle_table_lock);
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
+	if(use_locking == 1) {
+		/* Set size to allocate (= buffers_size * 2) per CPU and fix it's 
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
+		/* Set size to allocate (= buffers_size * n buffers) per CPU and 
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
+	/* Make sure no timers can fire after we free buffer */
+	del_percpu_timers();
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
+	int retval = 0;
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
+	log_cpuid = 0;
+
+	/* We aren't tracing any PID or GID in particular */
+	tracing_pid = 0;
+	tracing_pgrp = 0;
+	tracing_gid = 0;
+	tracing_uid = 0;
+
+	/* We aren't looking for a particular call depth */
+	syscall_eip_depth_set = 0;
+
+	/* We aren't going to place bounds on syscall EIP fetching */
+	use_syscall_eip_bounds = 0;
+	lower_eip_bound_set = 0;
+	upper_eip_bound_set = 0;
+
+	/* By default, use TSC timestamping */
+	using_tsc = 1;
+	
+	/* Set the kernel trace configuration to it's basics */
+	trace_set_config(syscall_eip_depth_set,
+			 use_syscall_eip_bounds,
+			 0,
+			 0,
+			 0);
+
+	return retval;
+}
+
+/**
+ *	trace_init: - Tracing initialization function.
+ *
+ *	Returns:
+ *	0, everything went OK
+ *	-ENONMEM, incapable of allocating necessary memory
+ *	Forwarded error code otherwise
+ */
+int __init trace_init(void)
+{
+	int i;
+	int retval = 0;
+
+	/* Initialize configuration */
+	if ((retval = tracer_set_default_config()) < 0)
+		return retval;
+
+	/* Initialize bytes read and events lost */
+	buf_read_complete = 0;
+	size_read_incomplete = 0;
+
+	/* Initialize tracing daemon structures */
+	daemon_task_struct = NULL;
+	tracer_vm_area = NULL;
+
+	/* Allocate memory for large data components */
+	if ((user_event_data = vmalloc(CUSTOM_EVENT_MAX_SIZE)) < 0)
+		return -ENOMEM;
+
+	/* Initialize spin lock */
+	trace_spin_lock = SPIN_LOCK_UNLOCKED;
+
+	/* By default, use locking scheme */
+	use_locking = 1;
+
+	/* Initialize next event ID to be used */
+	next_event_id = TRACE_EV_MAX + 1;
+
+	/* Initialize custom events list */
+	custom_events = &custom_events_head;
+	custom_events->next = custom_events;
+	custom_events->prev = custom_events;
+
+	/* Initialize tracing handle table */
+	for(i = 0; i < TRACE_MAX_HANDLES; i++)
+		trace_handle_table[i].owner = NULL;
+
+	return retval;
+}
+
+/**
+ *	trace_set_config: - Set the tracing configuration
+ *	@do_syscall_depth: Use depth to fetch eip
+ *	@do_syscall_bounds: Use bounds to fetch eip
+ *	@eip_depth: Detph to fetch eip
+ *	@eip_lower_bound: Lower bound eip address
+ *	@eip_upper_bound: Upper bound eip address
+ *
+ *	Returns: 
+ *	0, all is OK 
+ *	-ENOMEDIUM, there isn't a registered tracer
+ *	-ENXIO, wrong tracer
+ *	-EINVAL, invalid configuration
+ */
+int trace_set_config(int do_syscall_depth,
+		     int do_syscall_bounds,
+		     int eip_depth,
+		     void *eip_lower_bound,
+		     void *eip_upper_bound)
+{
+	/* Is this a valid configuration */
+	if ((do_syscall_depth && do_syscall_bounds)
+	    || (eip_lower_bound > eip_upper_bound)
+	    || (eip_depth < 0))
+		return -EINVAL;
+
+	/* Set the configuration */
+	fetch_syscall_eip_use_depth = do_syscall_depth;
+	fetch_syscall_eip_use_bounds = do_syscall_bounds;
+	syscall_eip_depth = eip_depth;
+	syscall_lower_eip_bound = eip_lower_bound;
+	syscall_upper_eip_bound = eip_upper_bound;
+
+	return 0;
+}
+
+/**
+ *	trace_get_config: - Get the tracing configuration
+ *	@do_syscall_depth: Use depth to fetch eip
+ *	@do_syscall_bounds: Use bounds to fetch eip
+ *	@eip_depth: Detph to fetch eip
+ *	@eip_lower_bound: Lower bound eip address
+ *	@eip_upper_bound: Upper bound eip address
+ *
+ *	Returns:
+ *	0, all is OK 
+ *	-ENOMEDIUM, there isn't a registered tracer
+ */
+int trace_get_config(int *do_syscall_depth,
+		     int *do_syscall_bounds,
+		     int *eip_depth,
+		     void **eip_lower_bound,
+		     void **eip_upper_bound)
+{
+	/* Get the configuration */
+	*do_syscall_depth = fetch_syscall_eip_use_depth;
+	*do_syscall_bounds = fetch_syscall_eip_use_bounds;
+	*eip_depth = syscall_eip_depth;
+	*eip_lower_bound = syscall_lower_eip_bound;
+	*eip_upper_bound = syscall_upper_eip_bound;
+
+	return 0;
+}
+
+/**
+ *	_trace_create_event: - Create a new traceable event type
+ *	@event_type: string describing event type
+ *	@event_desc: string used for standard formatting
+ *	@format_type: type of formatting used to log event data
+ *	@format_data: data specific to format
+ *	@owner_pid: PID of event's owner (0 if none)
+ *
+ *	Returns:
+ *	New Event ID if all is OK
+ *	-ENOMEM, Unable to allocate new event
+ */
+int _trace_create_event(char *event_type,
+			char *event_desc,
+			int format_type,
+			char *format_data,
+			pid_t owner_pid)
+{
+	trace_new_event *new_event;
+	struct custom_event_desc *new_event_desc;
+
+	/* Create event */
+	if ((new_event_desc = (struct custom_event_desc *) kmalloc(sizeof(struct custom_event_desc), GFP_ATOMIC)) == NULL)
+		 return -ENOMEM;
+	new_event = &(new_event_desc->event);
+
+	/* Initialize event properties */
+	new_event->type[0] = '\0';
+	new_event->desc[0] = '\0';
+	new_event->form[0] = '\0';
+
+	/* Set basic event properties */
+	if (event_type != NULL)
+		strncpy(new_event->type, event_type, CUSTOM_EVENT_TYPE_STR_LEN);
+	if (event_desc != NULL)
+		strncpy(new_event->desc, event_desc, CUSTOM_EVENT_DESC_STR_LEN);
+	if (format_data != NULL)
+		strncpy(new_event->form, format_data, CUSTOM_EVENT_FORM_STR_LEN);
+
+	/* Ensure that strings are bound */
+	new_event->type[CUSTOM_EVENT_TYPE_STR_LEN - 1] = '\0';
+	new_event->desc[CUSTOM_EVENT_DESC_STR_LEN - 1] = '\0';
+	new_event->form[CUSTOM_EVENT_FORM_STR_LEN - 1] = '\0';
+
+	/* Set format type */
+	new_event->format_type = format_type;
+
+	/* Give the new event a unique event ID */
+	new_event->id = next_event_id;
+	next_event_id++;
+
+	/* Set event's owner */
+	new_event_desc->owner_pid = owner_pid;
+
+	/* Insert new event in event list */
+	write_lock(&custom_list_lock);
+	new_event_desc->next = custom_events;
+	new_event_desc->prev = custom_events->prev;
+	custom_events->prev->next = new_event_desc;
+	custom_events->prev = new_event_desc;
+	write_unlock(&custom_list_lock);
+
+	/* Log the event creation event */
+	trace_event(TRACE_EV_NEW_EVENT, &(new_event_desc->event));
+
+	return new_event->id;
+}
+int trace_create_event(char *event_type,
+		       char *event_desc,
+		       int format_type,
+		       char *format_data)
+{
+	return _trace_create_event(event_type, event_desc, format_type, format_data, 0);
+}
+int trace_create_owned_event(char *event_type,
+			     char *event_desc,
+			     int format_type,
+			     char *format_data,
+			     pid_t owner_pid)
+{
+	return _trace_create_event(event_type, event_desc, format_type, format_data, owner_pid);
+}
+
+/**
+ *	trace_destroy_event: - Destroy a created event type
+ *	@event_id, the Id returned by trace_create_event()
+ *
+ *	No return values.
+ */
+void trace_destroy_event(int event_id)
+{
+	struct custom_event_desc *event_desc;
+
+	write_lock(&custom_list_lock);
+
+	/* Find the event to destroy in the event description list */
+	for (event_desc = custom_events->next;
+	     event_desc != custom_events;
+	     event_desc = event_desc->next)
+		if (event_desc->event.id == event_id)
+			break;
+
+	/* If we found something */
+	if (event_desc != custom_events) {
+		/* Remove the event fromt the list */
+		event_desc->next->prev = event_desc->prev;
+		event_desc->prev->next = event_desc->next;
+
+		/* Free the memory used by this event */
+		kfree(event_desc);
+	}
+	write_unlock(&custom_list_lock);
+}
+
+/**
+ *	trace_destroy_owners_events: Destroy an owner's events
+ *	@owner_pid: the PID of the owner who's events are to be deleted.
+ *
+ *	No return values.
+ */
+void trace_destroy_owners_events(pid_t owner_pid)
+{
+	struct custom_event_desc *temp_event;
+	struct custom_event_desc *event_desc;
+
+	write_lock(&custom_list_lock);
+
+	/* Start at the first event in the list */
+	event_desc = custom_events->next;
+
+	/* Find all events belonging to the PID */
+	while (event_desc != custom_events) {
+		temp_event = event_desc->next;
+
+		/* Does this event belong to the same owner */
+		if (event_desc->owner_pid == owner_pid) {
+			/* Remove the event from the list */
+			event_desc->next->prev = event_desc->prev;
+			event_desc->prev->next = event_desc->next;
+
+			/* Free the memory used by this event */
+			kfree(event_desc);
+		}
+		event_desc = temp_event;
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
+	struct custom_event_desc *event_desc;
+
+	read_lock(&custom_list_lock);
+
+	/* Log an event creation for every description in the list */
+	for (event_desc = custom_events->next;
+	     event_desc != custom_events;
+	     event_desc = event_desc->next)
+		trace_event(TRACE_EV_NEW_EVENT, &(event_desc->event));
+
+	read_unlock(&custom_list_lock);
+}
+
+/**
+ *	trace_std_formatted_event: - Trace a formatted event
+ *	@event_id: the event Id provided upon creation
+ *	@...: printf-like data that will be used to fill the event string.
+ *
+ *	Returns:
+ *	Trace fct return code if OK.
+ *	-ENOMEDIUM, there is no registered tracer or event doesn't exist.
+ */
+int trace_std_formatted_event(int event_id,...)
+{
+	int string_size;	/* Size of the string outputed by vsprintf() */
+	char final_string[CUSTOM_EVENT_FINAL_STR_LEN];	/* Final formatted string */
+	va_list vararg_list;	/* Variable argument list */
+	trace_custom custom_event;
+	struct custom_event_desc *event_desc;
+
+	read_lock(&custom_list_lock);
+
+	/* Find the event description matching this event */
+	for (event_desc = custom_events->next;
+	     event_desc != custom_events;
+	     event_desc = event_desc->next)
+		if (event_desc->event.id == event_id)
+			break;
+
+	/* If we haven't found anything */
+	if (event_desc == custom_events) {
+		read_unlock(&custom_list_lock);
+
+		return -ENOMEDIUM;
+	}
+	/* Set custom event Id */
+	custom_event.id = event_id;
+
+	/* Initialize variable argument list access */
+	va_start(vararg_list, event_id);
+
+	/* Print the description out to the temporary buffer */
+	string_size = vsprintf(final_string, event_desc->event.desc, vararg_list);
+
+	read_unlock(&custom_list_lock);
+
+	/* Facilitate return to caller */
+	va_end(vararg_list);
+
+	/* Set the size of the event */
+	custom_event.data_size = (u32) (string_size + 1);
+
+	/* Set the pointer to the event data */
+	custom_event.data = final_string;
+
+	/* Log the custom event */
+	return trace_event(TRACE_EV_CUSTOM, &custom_event);
+}
+
+/**
+ *	trace_raw_event: - Trace a raw event
+ *	@event_id, the event Id provided upon creation
+ *	@event_size, the size of the data provided
+ *	@event_data, data buffer describing event
+ *
+ *	Returns:
+ *	Trace fct return code if OK.
+ *	-ENOMEDIUM, there is no registered tracer or event doesn't exist.
+ */
+int trace_raw_event(int event_id, int event_size, void *event_data)
+{
+	trace_custom custom_event;
+	struct custom_event_desc *event_desc;
+
+	read_lock(&custom_list_lock);
+
+	/* Find the event description matching this event */
+	for (event_desc = custom_events->next;
+	     event_desc != custom_events;
+	     event_desc = event_desc->next)
+		if (event_desc->event.id == event_id)
+			break;
+
+	read_unlock(&custom_list_lock);
+
+	/* If we haven't found anything */
+	if (event_desc == custom_events)
+		return -ENOMEDIUM;
+
+	/* Set custom event Id */
+	custom_event.id = event_id;
+
+	/* Set the data size */
+	if (event_size <= CUSTOM_EVENT_MAX_SIZE)
+		custom_event.data_size = (u32) event_size;
+	else
+		custom_event.data_size = (u32) CUSTOM_EVENT_MAX_SIZE;
+
+	/* Set the pointer to the event data */
+	custom_event.data = event_data;
+
+	/* Log the custom event */
+	return trace_event(TRACE_EV_CUSTOM, &custom_event);
+}
+
+/**
+ *	trace_event: - Trace an event
+ *	@event_id, the event's ID (check out trace.h)
+ *	@event_struct, the structure describing the event
+ *
+ *	Returns:
+ *	Trace fct return code if OK.
+ *	-ENOMEDIUM, there is no registered tracer
+ *	-ENOMEM, couldn't access ltt_info
+ */
+int trace_event(u8 event_id,
+		void *event_struct)
+{
+	int ret_value;
+
+	atomic_inc(&pending_write_count);
+
+	/* Call the tracer */
+	ret_value = trace(event_id, 
+			    event_struct, 
+			    smp_processor_id());
+	
+	atomic_dec(&pending_write_count);
+
+	return ret_value;
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
+module_init(trace_init);
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
