Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270248AbSKEB6T>; Mon, 4 Nov 2002 20:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270341AbSKEB6T>; Mon, 4 Nov 2002 20:58:19 -0500
Received: from nameservices.net ([208.234.25.16]:44968 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S270248AbSKEB5D>;
	Mon, 4 Nov 2002 20:57:03 -0500
Message-ID: <3DC727D8.5244DB56@opersys.com>
Date: Mon, 04 Nov 2002 21:07:20 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.46 2/10: Trace subsystem 1/2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D: This is the actual code for the tracing subsystem. It has two
D: main modes of operation, locking and non-locking, each with its
D: own particular buffer-management policies. Systems requiring
D: rigid and instantaneous event logging should use the locking
D: scheme. Systems requiring higher throughput should use the
D: lockless scheme. Event timestamps can be obtained either using
D: do_gettimeofday or the TSC (if available). Interfacing with
D: user-space is done through sys_trace.

[This is part 1 of 2 since the file bounces off the mailing lists
if it's sent in one piece. Concat piece 2/2 to obtain complete file.]

diff -urpN linux-2.5.46/kernel/trace.c linux-2.5.46-ltt/kernel/trace.c
--- linux-2.5.46/kernel/trace.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.46-ltt/kernel/trace.c	Mon Nov  4 19:41:30 2002
@@ -0,0 +1,3396 @@
+/*
+ * linux/drivers/trace/tracer.c
+ *
+ * (C) Copyright, 1999, 2000, 2001, 2002 - Karim Yaghmour (karim@opersys.com)
+ *
+ * Contains the code for the kernel tracer.
+ *
+ * Author:
+ *	Karim Yaghmour (karim@opersys.com)
+ *
+ * Changelog:
+ *	15/10/02, Changed tracer from device to kernel subsystem and added
+ *		custom trace system call (sys_trace).
+ *	01/10/02, Coding style change to fit with kernel coding style.
+ *	16/02/02, Added Tom Zanussi's implementation of K42's lockless logging.
+ *		K42 tracing guru Robert Wisniewski participated in the
+ *		discussions surrounding this implementation. A big thanks to
+ *		the IBM folks.
+ *	03/12/01, Added user event support.
+ *	05/01/01, Modified PPC bit manipulation functions for x86
+ *	compatibility (andy_lowe@mvista.com).
+ *	15/11/00, Finally fixed memory allocation and remapping method. Now
+ *		using BTTV-driver-inspired code.
+ *	13/03/00, Modified tracer so that the daemon mmaps the tracer's buffers
+ *		in it's address space rather than use "read".
+ *	26/01/00, Added support for standardized buffer sizes and extensibility
+ *		of events.
+ *	01/10/99, Modified tracer in order to used double-buffering.
+ *	28/09/99, Adding tracer configuration support.
+ *	09/09/99, Chaging the format of an event record in order to reduce the
+ *	size of the traces.
+ *	04/03/99, Initial typing.
+ *
+ * Note:
+ *	The sizes of the variables used to store the details of an event are
+ *	planned for a system who gets at least one clock tick every 10 
+ *	milli-seconds. There has to be at least one event every 2^32-1
+ *	microseconds, otherwise the size of the variable holding the time
+ *	doesn't work anymore.
+ */
+
+#include <linux/init.h>		/* For __init */
+#include <linux/trace.h>	/* Tracing definitions */
+#include <linux/errno.h>	/* Miscellaneous error codes */
+#include <linux/stddef.h>	/* NULL */
+#include <linux/slab.h>		/* kmalloc() */
+#include <linux/module.h>	/* EXPORT_SYMBOL */
+#include <linux/sched.h>	/* pid_t */
+#include <linux/string.h>
+#include <linux/time.h>
+#include <linux/wrapper.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/mman.h>
+#include <linux/delay.h>
+
+#include <asm/io.h>
+#include <asm/current.h>
+#include <asm/uaccess.h>
+#include <asm/bitops.h>
+#include <asm/pgtable.h>
+#include <asm/trace.h>
+
+/* Global variables */
+/*  Locking */
+static spinlock_t 	trace_spin_lock;	/* Spinlock in order to lock kernel */
+static atomic_t		pending_write_count;	/* Number of event writes in progress */
+/*  Daemon */
+static struct task_struct*	daemon_task_struct;	/* Task structure of the tracer daemon */
+static struct vm_area_struct*	tracer_vm_area;		/* VM area where buffers are mapped */
+/*  Tracer configuration */
+static int		tracer_started;		/* Is the tracer started */
+static int		tracer_stopping;	/* Is the tracer stopping */
+static trace_event_mask	traced_events;		/* Bit-field of events being traced */
+static trace_event_mask	log_event_details_mask;	/* Log the details of the events mask */
+static int		log_cpuid;		/* Log the CPUID associated with each event */
+static int		use_syscall_eip_bounds;	/* Use adress bounds to fetch the EIP where call is made */
+static int		lower_eip_bound_set;	/* The lower bound EIP has been set */
+static int		upper_eip_bound_set;	/* The upper bound EIP has been set */
+static void*		lower_eip_bound;	/* The lower bound EIP */
+static void*		upper_eip_bound;	/* The upper bound EIP */
+static int		tracing_pid;		/* Tracing only the events for one pid */
+static int		tracing_pgrp;		/* Tracing only the events for one process group */
+static int		tracing_gid;		/* Tracing only the events for one gid */
+static int		tracing_uid;		/* Tracing only the events for one uid */
+static pid_t		traced_pid;		/* PID being traced */
+static pid_t		traced_pgrp;		/* Process group being traced */
+static gid_t		traced_gid;		/* GID being traced */
+static uid_t		traced_uid;		/* UID being traced */
+static int		syscall_eip_depth_set;	/* The call depth at which to fetch EIP has been set */
+static int		syscall_eip_depth;	/* The call depth at which to fetch the EIP */
+/*  Event data buffers */
+static int		buf_read_complete;	/* Number of buffers completely filled */
+static int		size_read_incomplete;	/* Quantity of data read from incomplete buffers */
+static u32		buf_size;		/* Buffer sizes */
+static u32		cpu_buf_size;		/* Total buffer size per CPU */
+static u32		alloc_size;		/* Size of buffers allocated */
+static char*		trace_buf = NULL;	/* Trace buffer */
+static int		use_locking;		/* Holds command from daemon */
+static u32		buf_no_bits;		/* Holds command from daemon */
+static u32		buf_offset_bits;	/* Holds command from daemon */
+static int		using_tsc;              /* Using TSC timestamping? */
+static int		using_lockless;         /* Using lockless scheme? */
+static int		num_cpus;               /* Number of CPUs found */ 
+static atomic_t		send_signal;            /* Should the daemon be summoned */ 
+
+/*  Trace statement behavior */
+unsigned int		syscall_entry_trace_active = 0;
+unsigned int		syscall_exit_trace_active = 0;
+static int		fetch_syscall_eip_use_depth;
+static int		fetch_syscall_eip_use_bounds ;
+static int		syscall_eip_depth;
+static void*		syscall_lower_eip_bound;
+static void*		syscall_upper_eip_bound;
+
+/* Timers needed if TSC being used */
+static struct timer_list heartbeat_timer;	
+static struct timer_list percpu_timer[NR_CPUS] __cacheline_aligned;
+
+/* The global per-buffer control data structure */
+static struct buffer_control buffer_control[NR_CPUS] __cacheline_aligned;
+
+/* The data structure shared between the tracing driver and the trace daemon 
+   via ioctl. */
+static struct shared_buffer_control shared_buffer_control;
+
+/* Per-cpu bitmap of buffer switches in progress */
+static unsigned long buffer_switches_pending;
+
+/* Architecture-specific info the daemon needs to know about */
+static struct ltt_arch_info ltt_arch_info;
+
+/*  Large data components allocated at load time */
+static char *user_event_data = NULL;		/* The data associated with a user event */
+
+/* Space reserved for TRACE_EV_BUFFER_START */
+static u32 start_reserve = TRACER_FIRST_EVENT_SIZE; 
+
+/* Space reserved for TRACE_EV_BUFFER_END event + sizeof lost word, which 
+   though the sizeof lost word isn't necessarily contiguous with rest of 
+   event (it's always at the end of the buffer) is included here for code 
+   clarity. */
+static u32 end_reserve = TRACER_LAST_EVENT_SIZE; 
+
+/* The size of the structures used to describe the events */
+static int event_struct_size[TRACE_EV_MAX + 1] =
+{
+	sizeof(trace_start)		/* TRACE_START */ ,
+	sizeof(trace_syscall_entry)	/* TRACE_SYSCALL_ENTRY */ ,
+	0				/* TRACE_SYSCALL_EXIT */ ,
+	sizeof(trace_trap_entry)	/* TRACE_TRAP_ENTRY */ ,
+	0				/* TRACE_TRAP_EXIT */ ,
+	sizeof(trace_irq_entry)		/* TRACE_IRQ_ENTRY */ ,
+	0				/* TRACE_IRQ_EXIT */ ,
+	sizeof(trace_schedchange)	/* TRACE_SCHEDCHANGE */ ,
+	0				/* TRACE_KERNEL_TIMER */ ,
+	sizeof(trace_soft_irq)		/* TRACE_SOFT_IRQ */ ,
+	sizeof(trace_process)		/* TRACE_PROCESS */ ,
+	sizeof(trace_file_system)	/* TRACE_FILE_SYSTEM */ ,
+	sizeof(trace_timer)		/* TRACE_TIMER */ ,
+	sizeof(trace_memory)		/* TRACE_MEMORY */ ,
+	sizeof(trace_socket)		/* TRACE_SOCKET */ ,
+	sizeof(trace_ipc)		/* TRACE_IPC */ ,
+	sizeof(trace_network)		/* TRACE_NETWORK */ ,
+	sizeof(trace_buffer_start)	/* TRACE_BUFFER_START */ ,
+	sizeof(trace_buffer_end)	/* TRACE_BUFFER_END */ ,
+	sizeof(trace_new_event)		/* TRACE_NEW_EVENT */ ,
+	sizeof(trace_custom)		/* TRACE_CUSTOM */ ,
+	sizeof(trace_change_mask)	/* TRACE_CHANGE_MASK */,
+	0				/* TRACE_HEARTBEAT */
+};
+
+/* Custom event description */
+struct custom_event_desc {
+	trace_new_event event;
+
+	pid_t owner_pid;
+
+	struct custom_event_desc *next;
+	struct custom_event_desc *prev;
+};
+
+/* Next event ID to be used */
+int next_event_id;
+
+/* Circular list of custom events */
+struct custom_event_desc custom_events_head;
+struct custom_event_desc *custom_events;
+
+/* Circular list lock. This is classic lock that provides for atomic access
+to the circular list. */
+rwlock_t custom_list_lock = RW_LOCK_UNLOCKED;
+
+/* Tracing subsystem handle */
+struct trace_handle_struct{
+	struct task_struct	*owner;
+};
+
+/* Handle table */
+struct trace_handle_struct	trace_handle_table[TRACE_MAX_HANDLES];
+
+/* Lock on handle table */
+rwlock_t trace_handle_table_lock = RW_LOCK_UNLOCKED;
+
+/* This inspired by rtai/shmem */
+#define FIX_SIZE(x) (((x) - 1) & PAGE_MASK) + PAGE_SIZE
+
+/* \begin{Code inspired from BTTV driver} */
+
+/* Here we want the physical address of the memory.
+ * This is used when initializing the contents of the
+ * area and marking the pages as reserved.
+ */
+static inline unsigned long kvirt_to_pa(unsigned long adr)
+{
+	unsigned long kva, ret;
+
+	kva = (unsigned long) page_address(vmalloc_to_page((void *) adr));
+	kva |= adr & (PAGE_SIZE - 1);	/* restore the offset */
+	ret = __pa(kva);
+	return ret;
+}
+
+static void *rvmalloc(unsigned long size)
+{
+	void *mem;
+	unsigned long adr;
+
+	mem = vmalloc_32(size);
+	if (!mem)
+		return NULL;
+
+	memset(mem, 0, size);	/* Clear the ram out, no junk to the user */
+	adr = (unsigned long) mem;
+	while (size > 0) {
+		mem_map_reserve(vmalloc_to_page((void *) adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+
+	return mem;
+}
+
+static void rvfree(void *mem, unsigned long size)
+{
+	unsigned long adr;
+
+	if (!mem)
+		return;
+
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		mem_map_unreserve(vmalloc_to_page((void *) adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	vfree(mem);
+}
+
+static int tracer_mmap_region(struct vm_area_struct *vma,
+			      const char *adr,
+			      const char *start_pos,
+			      unsigned long size)
+{
+	unsigned long start = (unsigned long) adr;
+	unsigned long page, pos;
+
+	pos = (unsigned long) start_pos;
+	
+	while (size > 0) {
+		page = kvirt_to_pa(pos);
+		if (remap_page_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
+			return -EAGAIN;
+		
+		start += PAGE_SIZE;
+		pos += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	return 0;
+}
+/* \end{Code inspired from BTTV driver} */
+
+/**
+ *	tracer_write_to_buffer: - Write data to destination buffer
+ *
+ *	Writes data to the destination buffer and updates the begining the
+ *	buffer write position.
+ */
+#define tracer_write_to_buffer(DEST, SRC, SIZE) \
+do\
+{\
+   memcpy(DEST, SRC, SIZE);\
+   DEST += SIZE;\
+} while(0);
+
+/*** Lockless scheme functions ***/
+
+/* These inline atomic functions wrap the linux versions in order to 
+   implement the interface we want as well as to ensure memory barriers. */
+
+/**
+ *	compare_and_store_volatile: - Self-explicit
+ *	@ptr: ptr to the word that will receive the new value
+ *	@oval: the value we think is currently in *ptr
+ *	@nval: the value *ptr will get if we were right
+ *
+ *	If *ptr is still what we think it is, atomically assign nval to it and
+ *	return a boolean indicating TRUE if the new value was stored, FALSE
+ *	otherwise.
+ *
+ *	Pseudocode for this operation:
+ *  
+ *	if(*ptr == oval) {
+ *	   *ptr = nval;
+ *	   return TRUE;
+ *	} else {
+ *	   return FALSE;
+ *	}
+ */
+inline int compare_and_store_volatile(volatile u32 *ptr, 
+				      u32 oval,
+				      u32 nval)
+{
+	u32 prev;
+
+	barrier();
+	prev = cmpxchg(ptr, oval, nval);
+	barrier();
+
+	return (prev == oval);
+}
+
+/**
+ *	atomic_set_volatile: - Atomically set the value in ptr to nval.
+ *	@ptr: ptr to the word that will receive the new value
+ *	@nval: the new value
+ *
+ *	Uses memory barriers to set *ptr to nval.
+ */
+inline void atomic_set_volatile(atomic_t *ptr,
+				u32 nval)
+{
+	barrier();
+	atomic_set(ptr, (int)nval);
+	barrier();
+}
+
+/**
+ *	atomic_add_volatile: - Atomically add val to the value at ptr.
+ *	@ptr: ptr to the word that will receive the addition
+ *	@val: the value to add to *ptr
+ *
+ *	Uses memory barriers to add val to *ptr.
+ */
+inline void atomic_add_volatile(atomic_t *ptr, u32 val)
+{
+	barrier();
+	atomic_add((int)val, ptr);
+	barrier();
+}
+
+/**
+ *	atomic_sub_volatile: - Atomically substract val from the value at ptr.
+ *	@ptr: ptr to the word that will receive the subtraction
+ *	@val: the value to subtract from *ptr
+ *
+ *	Uses memory barriers to substract val from *ptr.
+ */
+inline void atomic_sub_volatile(atomic_t *ptr, s32 val)
+{
+	barrier();
+	atomic_sub((int)val, ptr);
+	barrier();
+}
+
+/**
+ *	trace_commit: - Atomically commit a reserved slot in the buffer.
+ *	@index: index into the trace buffer
+ *	@len: the value to add to fill_count of the buffer contained in index
+ *	@cpu: the CPU id associated with the event
+ *
+ *	Atomically add len to the fill_count of the buffer specified by the
+ *	buffer number contained in index.
+ */
+static inline void trace_commit(u32 index, u32 len, u8 cpu)
+{
+	u32 bufno = TRACE_BUFFER_NUMBER_GET(index, offset_bits(cpu));
+	atomic_add_volatile(&fill_count(cpu, bufno), len);
+}
+
+/**
+ *	write_start_event: - Write start event to beginning of trace.
+ *	@start_event: the start event data
+ *	@start_tsc: the timestamp counter associated with the event
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Writes start event at the start of the trace, just following the
+ *	start buffer event of the first buffer.
+ */
+static inline void write_start_event(trace_start *start_event,
+				     trace_time_delta start_tsc,
+				     u8 cpu_id)
+{
+	u8 event_id;			/* Event ID of last event */
+	uint16_t data_size;		/* Size of tracing data */
+	trace_time_delta time_delta;	/* Time between now and prev event */
+	char* current_write_pos;       	/* Current position for writing */
+
+        /* Skip over the start buffer event */
+	current_write_pos = trace_buffer(cpu_id) + TRACER_FIRST_EVENT_SIZE;
+	
+	/* Write event type to tracing buffer */
+	event_id = TRACE_EV_START;
+	tracer_write_to_buffer(current_write_pos,
+			       &event_id,
+			       sizeof(event_id));
+
+	/* Write event time delta/TSC to tracing buffer */
+	time_delta = switch_time_delta(start_tsc);
+	tracer_write_to_buffer(current_write_pos,
+			       &time_delta,
+			       sizeof(time_delta));
+
+	/* Write event structure */
+	tracer_write_to_buffer(current_write_pos,
+			       start_event,
+			       sizeof(trace_start));
+
+	/* Compute the data size */
+	data_size = sizeof(event_id)
+	    + sizeof(time_delta)
+	    + sizeof(trace_start)
+	    + sizeof(data_size);
+
+	/* Write the length of the event description */
+	tracer_write_to_buffer(current_write_pos,
+			       &data_size,
+			       sizeof(data_size));
+}
+
+/**
+ *	write_start_buffer_event: - Write start-buffer event to buffer start.
+ *	@buf_index: index into the trace buffer
+ *	@start_time: the time of the start-buffer event
+ *	@start_tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Writes start-buffer event at the start of the buffer specified by the
+ *	buffer number contained in buf_index.
+ */
+static inline void write_start_buffer_event(u32 buf_index, 
+					    struct timeval start_time,
+					    trace_time_delta start_tsc,
+					    u8 cpu_id)
+{
+	trace_buffer_start start_buffer_event; /* Start of new buffer event */
+	u8 event_id;			/* Event ID of last event */
+	uint16_t data_size;		/* Size of tracing data */
+	trace_time_delta time_delta;	/* Time between now and prev event */
+	char* current_write_pos;       	/* Current position for writing */
+
+	/* Clear the offset bits of index to get the beginning of buffer */
+	current_write_pos = trace_buffer(cpu_id) 
+		+ TRACE_BUFFER_OFFSET_CLEAR(buf_index, offset_mask(cpu_id));
+
+	/* Increment buffer ID */
+	(buffer_id(cpu_id))++;
+	
+	/* Write the start of buffer event */
+	start_buffer_event.id = buffer_id(cpu_id);
+	start_buffer_event.time = start_time;
+	start_buffer_event.tsc = start_tsc;
+
+	/* Write event type to tracing buffer */
+	event_id = TRACE_EV_BUFFER_START;
+	tracer_write_to_buffer(current_write_pos,
+			       &event_id,
+			       sizeof(event_id));
+
+	/* Write event time delta/TSC to tracing buffer */
+	time_delta = switch_time_delta(start_tsc);
+	tracer_write_to_buffer(current_write_pos,
+			       &time_delta,
+			       sizeof(time_delta));
+
+	/* Write event structure */
+	tracer_write_to_buffer(current_write_pos,
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
+	tracer_write_to_buffer(current_write_pos,
+			       &data_size,
+			       sizeof(data_size));
+}
+
+/**
+ *	write_end_buffer_event: - Write end-buffer event to end of buffer.
+ *	@buf_index: index into the trace buffer
+ *	@end_time: the time of the end-buffer event
+ *	@end_tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Writes end-buffer event at the end of the buffer specified by the
+ *	buffer number contained in buf_index, at the offset also contained in
+ *	buf_index.
+ */
+static inline void write_end_buffer_event(u32 buf_index, 
+					  struct timeval end_time,
+					  trace_time_delta end_tsc,
+					  u8 cpu_id)
+{
+ 	trace_buffer_end end_buffer_event; /* End of buffer event */
+	u8 event_id;			/* Event ID of last event */
+	trace_time_delta time_delta;	/* Time between now and prev event */
+	char* current_write_pos;        /* Current position for writing */
+	uint16_t data_size;		/* Size of tracing data */
+
+	current_write_pos = trace_buffer(cpu_id) + buf_index;
+
+	/* Write the end of buffer event */
+	end_buffer_event.time = end_time;
+	end_buffer_event.tsc = end_tsc;
+
+	/* Write the CPUID to the tracing buffer, if required */
+	if (log_cpuid == 1) {
+		tracer_write_to_buffer(current_write_pos,
+				       &cpu_id,
+				       sizeof(cpu_id));
+	}
+	/* Write event type to tracing buffer */
+	event_id = TRACE_EV_BUFFER_END;
+	tracer_write_to_buffer(current_write_pos,
+			       &event_id,
+			       sizeof(event_id));
+
+	/* Write event time delta/TSC to tracing buffer */
+	time_delta = switch_time_delta(end_tsc);
+	tracer_write_to_buffer(current_write_pos,
+			       &time_delta,
+			       sizeof(time_delta));
+
+	/* Write event structure */
+	tracer_write_to_buffer(current_write_pos,
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
+	tracer_write_to_buffer(current_write_pos,
+			       &data_size,
+			       sizeof(data_size));
+}
+
+/**
+ *	write_lost_size: - Write lost size to end of buffer contained in index.
+ *	@buf_index: index into the trace buffer 
+ *	@size_lost: number of bytes lost at the end of buffer
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Writes the value contained in size_lost as the last word in the 
+ *	the buffer specified by the buffer number contained in buf_index.  The
+ *	'lost size' is the number of bytes that are left unused by the tracing
+ *	scheme at the end of a buffer for a variety of reasons.
+ */
+static inline void write_lost_size(u32 buf_index, u32 size_lost, u8 cpu_id)
+{
+	char* write_buffer_end;		/* End of buffer */
+
+	/* Get end of buffer by clearing offset and adding buffer size */
+	write_buffer_end = trace_buffer(cpu_id)
+	  + TRACE_BUFFER_OFFSET_CLEAR(buf_index, offset_mask(cpu_id))
+	  + TRACE_BUFFER_SIZE(offset_bits(cpu_id));
+
+	/* Write size lost at the end of the buffer */
+	*((u32 *) (write_buffer_end - sizeof(size_lost))) = size_lost;
+}
+
+/**
+ *	finalize_buffer: - Utility function consolidating end-of-buffer tasks.
+ *	@end_index: index into trace buffer to write the end-buffer event at
+ *	@size_lost: number of unused bytes at the end of the buffer
+ *	@time_stamp: the time of the end-buffer event
+ *	@tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	This function must be called from within a lock, because it increments
+ *	buffers_produced.
+ */
+static inline void finalize_buffer(u32 end_index, 
+				   u32 size_lost, 
+				   struct timeval *time_stamp,
+				   trace_time_delta *tsc, 
+				   u8 cpu_id)
+{
+	/* Write end buffer event as last event in old buffer. */
+	write_end_buffer_event(end_index, *time_stamp, *tsc, cpu_id);
+
+	/* In any buffer switch, we need to write out the lost size,
+	   which can be 0. */
+	write_lost_size(end_index, size_lost, cpu_id);
+
+	/* Add the size lost and end event size to fill_count so that 
+	   the old buffer won't be seen as incomplete. */
+	trace_commit(end_index, size_lost, cpu_id);
+
+	/* Every finalized buffer means a produced buffer */
+	(buffers_produced(cpu_id))++;
+}
+
+/**
+ *	finalize_lockless_trace: - finalize last buffer at end of trace
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Called when tracing is stopped, to finish processing last buffer.
+ */
+static inline void finalize_lockless_trace(u8 cpu_id)
+{
+	u32 events_end_index;		/* Index of end of last event */
+	u32 size_lost;			/* Bytes after end of last event */
+	unsigned long int flags;	/* CPU flags for lock */
+	struct timeval time;            /* The buffer-end time */
+	trace_time_delta tsc;	        /* The buffer-end TSC */
+
+	/* Find index of end of last event */
+	events_end_index = TRACE_BUFFER_OFFSET_GET(index(cpu_id), 
+						   offset_mask(cpu_id));
+
+	/* Size lost in buffer is the unused space after end of last event
+	   and end of buffer. */
+	size_lost = TRACE_BUFFER_SIZE(offset_bits(cpu_id)) - events_end_index;
+
+	/* Disable interrupts on this CPU */
+	local_irq_save(flags);
+
+	/* Get the time and TSC of the end-buffer event */
+	get_timestamp(&time, &tsc);
+
+	/* Write end event etc. and increment buffers_produced.  The  
+	   time used here is what the locking version uses as well. */
+	finalize_buffer(index(cpu_id) & index_mask(cpu_id), size_lost, 
+			&time, &tsc, cpu_id);
+
+	/* Atomically mark buffer-switch bit for this cpu */
+	set_bit(cpu_id, &buffer_switches_pending);
+
+	/* Restore interrupts on this CPU */
+	local_irq_restore(flags);
+}
+
+/**
+ *	discard_check: -  Determine whether an event should be discarded.
+ *	@old_index: index into trace buffer where check for space should begin
+ *	@event_len: the length of the event to check
+ *	@time_stamp: the time of the end-buffer event
+ *	@tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Checks whether an event of size event_len will fit into the available
+ *	buffer space as indicated by the value in old_index.  A side effect
+ *	of this function is that if the length would fill or overflow the
+ *	last available buffer, that buffer will be finalized and all 
+ *	subsequent events will be automatically discarded until a buffer is
+ *	later freed.
+ *
+ *	The return value contains the result flags and is an ORed combination 
+ *	of the following:
+ *
+ *	LTT_EVENT_DISCARD_NONE - event should not be discarded
+ *	LTT_BUFFER_SWITCH - buffer switch occurred
+ *	LTT_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	LTT_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+static inline int discard_check(u32 old_index,
+				u32 event_len, 
+				struct timeval *time_stamp,
+				trace_time_delta *tsc,
+				u8 cpu_id)
+{
+	u32 buffers_ready;
+	u32 offset_mask = offset_mask(cpu_id);
+	u8 offset_bits = offset_bits(cpu_id);
+	u32 index_mask = index_mask(cpu_id);
+	u32 size_lost;
+	unsigned long int flags; /* CPU flags for lock */
+
+	/* Check whether the event is larger than a buffer */ 
+	if(event_len >= TRACE_BUFFER_SIZE(offset_bits))
+		return LTT_EVENT_DISCARD | LTT_EVENT_TOO_LONG;
+
+	/* Disable interrupts on this CPU */
+	local_irq_save(flags);
+
+	/* We're already overrun, nothing left to do */  
+	if(buffers_full(cpu_id) == 1) {
+		/* Restore interrupts on this CPU */
+		local_irq_restore(flags);
+		return LTT_EVENT_DISCARD;
+	}
+	
+	buffers_ready = buffers_produced(cpu_id) - buffers_consumed(cpu_id);
+
+	/* If this happens, we've been pushed to the edge of the last 
+	   available buffer which means we need to finalize it and increment 
+	   buffers_produced.  However, we don't want to allow 
+	   sBufferControl.index to be actually pushed to full or beyond, 
+	   otherwise we'd just be wrapping around and allowing subsequent
+	   events to overwrite good buffers.  It is true that there may not
+	   be enough space for this event, but there could be space for 
+	   subsequent smaller event(s).  It doesn't matter if they write 
+	   themselves, because here we say that anything after the old_index 
+	   passed in to this function is lost, even if other events have or 
+	   will reserve space in this last buffer.  Nor can any other event
+	   reserve space in buffers following this one, until at least one
+	   buffer is consumed by the daemon. */
+	if(buffers_ready == n_buffers(cpu_id) - 1) {
+		/* We set this flag so we only do this once per overrun */
+		buffers_full(cpu_id) = 1;
+
+		/* Get the time of the event */
+		get_timestamp(time_stamp, tsc);
+
+		/* Size lost is everything after old_index */
+		size_lost = TRACE_BUFFER_SIZE(offset_bits)
+		  - TRACE_BUFFER_OFFSET_GET(old_index, offset_mask);
+
+		/* Write end event and lost size.  This increases buffer_count
+		   by the lost size, which is important later when we add the
+		   deferred size. */
+		finalize_buffer(old_index & index_mask, size_lost, 
+				time_stamp, tsc, cpu_id);
+
+		/* We need to add the lost size to old index, but we can't
+		   do it now, or we'd roll index over and allow new events,
+		   so we defer it until a buffer is free.  Note however that
+		   buffer_count does get incremented by lost size, which is
+		   important later when start logging again. */
+		last_event_index(cpu_id) = old_index;
+		last_event_timestamp(cpu_id) = *time_stamp;
+		last_event_tsc(cpu_id) = *tsc;
+
+		/* Restore interrupts on this CPU */
+		local_irq_restore(flags);
+
+		/* We lose this event */
+		return LTT_BUFFER_SWITCH | LTT_EVENT_DISCARD;
+	}
+
+	/* Restore interrupts on this CPU */
+	local_irq_restore(flags);
+
+	/* Nothing untoward happened */
+	return LTT_EVENT_DISCARD_NONE;
+}
+
+/**
+ *	trace_reserve_slow: - The slow reserve path in the lockless scheme.
+ *	@old_index: the value of the buffer control index when we were called
+ *	@slot_len: the length of the slot to reserve
+ *	@index_ptr: variable that will receive the start pos of the reserved slot
+ *	@time_stamp: variable that will receive the time the slot was reserved
+ *	@tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Called by trace_reserve() if the length of the event being logged would
+ *	most likely cause a 'buffer switch'.  The value of the variable pointed
+ *	to by index_ptr will contain the index actually reserved by this 
+ *	function.  The timestamp reflecting the time the slot was reserved 
+ *	will be saved in *time_stamp.  The return value indicates whether 
+ *	there actually was a buffer switch (not inevitable in all cases).
+ *	If the return value also indicates a discarded event, the values in 
+ *	*index_ptr and *time_stamp will be indeterminate. 
+ *
+ *	The return value contains the result flags and is an ORed combination 
+ *	of the following:
+ *
+ *	LTT_BUFFER_SWITCH_NONE - no buffer switch occurred 
+ *	LTT_EVENT_DISCARD_NONE - event should not be discarded
+ *	LTT_BUFFER_SWITCH - buffer switch occurred
+ *	LTT_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	LTT_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+static inline int trace_reserve_slow(u32 old_index, /* needed for overruns */
+				     u32 slot_len,
+				     u32 *index_ptr,
+				     struct timeval *time_stamp,
+				     trace_time_delta *tsc,
+				     u8 cpu_id)
+{
+	u32 new_index, offset, new_buf_no;
+	unsigned long int flags; /* CPU flags for lock */
+	u32 offset_mask = offset_mask(cpu_id);
+	u8 offset_bits = offset_bits(cpu_id);
+	u32 index_mask = index_mask(cpu_id);
+	u32 size_lost = end_reserve; /* size lost always includes end event */
+	int discard_event;
+	int buffer_switched = LTT_BUFFER_SWITCH_NONE;
+
+	/* We don't get here unless the event might cause a buffer switch */
+
+	/* First check whether conditions exist do discard the event */
+	discard_event = discard_check(old_index, slot_len, time_stamp, 
+				      tsc, cpu_id);
+	if(discard_event != LTT_EVENT_DISCARD_NONE)
+		return discard_event;
+
+	/* If we're here, we still have free buffers to reserve from */
+
+	/* Do this until we reserve a spot for the event */
+	do {
+		/* Yeah, we're re-using a param variable, is that bad form? */ 
+		old_index = index(cpu_id);
+
+		/* We're here because the event + ending reserve space would
+		   overflow or exactly fill old buffer.  Calculate new index
+		   again. */
+		new_index = old_index + slot_len;
+
+		/* We only care about the offset part of the new index */
+		offset = TRACE_BUFFER_OFFSET_GET(new_index + end_reserve, 
+						 offset_mask);
+
+		/* If we would actually overflow and not exactly fill the old 
+		   buffer, we reserve the first slot (after adding a buffer 
+		   start event) in the new one. */
+		if((offset < slot_len) && (offset > 0)) {
+
+			/* This is an overflow, not an exact fit.  The 
+			   reserved index is just after the space reserved for
+			   the start event in the new buffer. */
+			*index_ptr = TRACE_BUFFER_OFFSET_CLEAR(new_index + end_reserve, offset_mask)
+				+ start_reserve;
+
+			/* Now the next free space is at the reserved index 
+			   plus the length of this event. */
+			new_index = *index_ptr + slot_len;
+		} else if (offset < slot_len) {
+			/* We'll exactly fill the old buffer, so our reserved
+			   index is still in the old buffer and our new index
+			   is in the new one + sStartReserve */
+			*index_ptr = old_index;
+			new_index = TRACE_BUFFER_OFFSET_CLEAR(new_index + end_reserve, offset_mask)
+				+ start_reserve;
+		} else
+			/* another event has actually pushed us into a new 
+			   buffer since we were called. */ 
+			*index_ptr = old_index;
+					
+		/* Get the time of the event */
+		get_timestamp(time_stamp, tsc);
+	} while (!compare_and_store_volatile(&index(cpu_id), 
+					     old_index, new_index));
+
+	/* Once we're successful in saving a new_index as the authoritative
+	   new global buffer control index, finish the buffer switch 
+	   processing. */
+
+	/* Mask off the high bits outside of our reserved index */
+	*index_ptr &= index_mask;
+
+	/* At this point, our indices are set in stone, so we can safely
+	   write our start and end events and lost count to our buffers.
+	   The first test here could fail if between the time reserve_slow
+	   was called and we got a reserved slot, we slept and someone else
+	   did the buffer switch already. */
+	if(offset < slot_len) { /* Event caused a buffer switch. */
+		if(offset > 0) /* We didn't exactly fill the old buffer */
+			/* Set the size lost value in the old buffer.  That
+			   value is len+sEndReserve-offset-sEndReserve,
+			   i.e. sEndReserve cancels itself out. */
+			size_lost += slot_len - offset;
+		else /* We exactly filled the old buffer */
+			/* Since we exactly filled the old buffer, the index 
+			   we write the end event to is after the space 
+			   reserved for this event. */
+			old_index += slot_len;
+
+		/* Disable interrupts on this CPU */
+		local_irq_save(flags);
+
+		/* Write end event etc. and increment buffers_produced. */
+		finalize_buffer(old_index & index_mask, size_lost, 
+				time_stamp, tsc, cpu_id);
+
+		/* If we're here, we had a normal buffer switch and need to 
+		   update the start buffer time before writing the event.  
+		   The start buffer time is the same as the event time for the 
+		   event reserved, and lTimeDelta of 0 but that also appears 
+		   to be the case in the locking version as well. */
+		buffer_start_time(cpu_id) = *time_stamp;
+		buffer_start_tsc(cpu_id) = *tsc;
+
+		/* Restore interrupts on this CPU */
+		local_irq_restore(flags);
+
+		/* new_index is always valid here, since it's set correctly 
+		   if offset < len + sEndReserve, and we don't get here
+		   unless that's true.  The issue would be that if we didn't
+		   actually switch buffers, new_index would be too large by
+		   sEndReserve bytes. */
+		write_start_buffer_event(new_index & index_mask, 
+					 *time_stamp, *tsc, cpu_id);
+
+		/* We initialize the new buffer by subtracting 
+		   TRACE_BUFFER_SIZE rather than directly initializing to 
+		   sStartReserve in case events have been already been added 
+		   to the new buffer under us.  We subtract space for the start
+		   buffer event from buffer size to leave room for the start
+		   buffer event we just wrote. */
+		new_buf_no = TRACE_BUFFER_NUMBER_GET(new_index & index_mask, 
+						     offset_bits);
+		atomic_sub_volatile(&fill_count(cpu_id, new_buf_no),
+			    TRACE_BUFFER_SIZE(offset_bits) - start_reserve);
+
+		/* We need to check whether fill_count is less than the 
+		   sStartReserve.  If this test is true, it means that 
+		   subtracting the buffer size underflowed fill_count i.e. 
+		   fill_count represents an incomplete buffer.  Any any case, 
+		   we're completely fubared and don't have any choice but to 
+		   start the new buffer out fresh. */
+		if(atomic_read(&fill_count(cpu_id, new_buf_no)) < start_reserve)
+			atomic_set_volatile(&fill_count(cpu_id, new_buf_no), 
+					    start_reserve);
+
+		/* If we're here, there must have been a buffer switch */
+		buffer_switched = LTT_BUFFER_SWITCH;
+	}
+	
+	return buffer_switched;
+}
+
+/**
+ *	trace_reserve: -  Reserve a slot in the trace buffer for an event.
+ *	@slot_len: the length of the slot to reserve
+ *	@index_prt: variable that will receive the start pos of the reserved slot
+ *	@time_stamp: variable that will receive the time the slot was reserved
+ *	@tsc: the timestamp counter associated with time
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	This is the fast path for reserving space in the trace buffer in the  
+ *	lockless tracing scheme.  If a slot was successfully reserved, the 
+ *	caller can then at its leisure write data to the reserved space (at
+ *	least until the space is reclaimed in an out-of-space situation).
+ *
+ *	If the requested length would fill or exceed the current buffer, the
+ *	slow path, trace_reserve_slow(), will be executed instead.
+ *
+ *	The index reflecting the start position of the slot reserved will be 
+ *	saved in *index_prt, and the timestamp reflecting the time the slot was
+ *	reserved will be saved in *time_stamp.  If the return value indicates
+ *	a discarded event, the values in *index_prt and *time_stamp will be
+ *	indeterminate. 
+ *
+ *	The return value contains the result flags and is an ORed combination 
+ *	of the following:
+ *
+ *	LTT_BUFFER_SWITCH_NONE - no buffer switch occurred
+ *	LTT_EVENT_DISCARD_NONE - event should not be discarded
+ *	LTT_BUFFER_SWITCH - buffer switch occurred
+ *	LTT_EVENT_DISCARD - event should be discarded (all buffers are full)
+ *	LTT_EVENT_TOO_LONG - event won't fit into even an empty buffer
+ */
+static inline int trace_reserve(u32 slot_len, 
+				u32 *index_ptr, 
+				struct timeval *time_stamp,
+				trace_time_delta *tsc,
+				u8 cpu_id)
+{
+	u32 old_index, new_index, offset;
+	u32 offset_mask = offset_mask(cpu_id);
+
+	/* Do this until we reserve a spot for the event */
+	do {
+		old_index = index(cpu_id);
+
+		/* If adding len + sEndReserve to the old index doesn't put us
+		   into a new buffer, this is what the new index would be. */
+		new_index = old_index + slot_len;
+		offset = TRACE_BUFFER_OFFSET_GET(new_index + end_reserve, 
+						 offset_mask);
+
+		/* If adding the length reserved for the end buffer event and
+		   lost count to the new index would put us into a new buffer,
+		   we need to do a buffer switch.  If in between now and the 
+		   buffer switch another event that does fit comes in, no 
+		   problem because we check again in the slow version.  In 
+		   either case, there will always be room for the end event 
+		   in the old buffer.  The trick in this test is that adding 
+		   a length that would carry into the non-offset bits of the 
+		   index results in the offset portion being smaller than the 
+		   length that was added. */
+		if(offset < slot_len)
+			/* We would roll over into a new buffer, need to do 
+			   buffer switch processing. */
+			return trace_reserve_slow(old_index, slot_len, 
+				  index_ptr, time_stamp, tsc, cpu_id);
+
+		/* Get the timestamp/TSC of the event, whatever appropriate */
+		get_time_or_tsc(time_stamp, tsc);
+	} while (!compare_and_store_volatile(&index(cpu_id), 
+					     old_index, new_index));
+
+	/* Once we're successful in saving a new_index as the authoritative
+	   new global buffer control index, we can return old_index, the 
+	   successfully reserved index. */
+
+        /* Return the reserved index value */
+	*index_ptr = old_index & index_mask(cpu_id);
+
+	return LTT_BUFFER_SWITCH_NONE; /* No buffer switch occurred */
+}
+
+/**
+ *	lockless_write_event: - Locklessly reserves space and writes an event.
+ *	@event_id: event id
+ *	@event_struct: event details
+ *	@data_size: total event size 
+ *	@cpu_id: CPU ID associated with event
+ *	@var_data_beg: ptr to variable-length data for the event
+ *	@var_data_len: length of variable-length data for the event
+ *
+ *	This is the main event-writing function for the lockless scheme.  It
+ *	reserves space for an event if possible, writes the event and signals 
+ *	the daemon if it caused a buffer switch.
+ */
+int lockless_write_event(u8 event_id, 
+			 void *event_struct,
+			 uint16_t data_size,
+			 u8 cpu_id,
+			 void *var_data_beg,
+			 int var_data_len)
+{
+	u32 reserved_index;
+	struct timeval time_stamp;
+	trace_time_delta time_delta;	/* Time between now and prev event */
+	struct siginfo daemon_sig_info;	/* Signal information */
+	int reserve_ret_code;
+	char* current_write_pos;	/* Current position for writing */
+	int return_code = 0;
+
+	/* Reserve space for the event.  If the space reserved is in a new
+	   buffer, note that fact. */
+	reserve_ret_code = trace_reserve((u32)data_size, &reserved_index, 
+				 &time_stamp, &time_delta, cpu_id);
+
+	if(reserve_ret_code & LTT_BUFFER_SWITCH)
+		/* We need to inform the daemon */
+		atomic_set(&send_signal, 1);
+
+	/* Exact lost event count isn't important to anyone, so this is OK. */
+	if(reserve_ret_code & LTT_EVENT_DISCARD)
+		(events_lost(cpu_id))++;
+
+	/* We don't write the event, but we still need to signal */
+	if((reserve_ret_code & LTT_BUFFER_SWITCH) && 
+	   (reserve_ret_code & LTT_EVENT_DISCARD)) {
+		return_code = -ENOMEM;
+		goto send_buffer_switch_signal;
+	}
+	
+	/* no buffer space left, discard event. */
+	if((reserve_ret_code & LTT_EVENT_DISCARD) || 
+	   (reserve_ret_code & LTT_EVENT_TOO_LONG)) {
+		/* return value for trace() */
+		return_code = -ENOMEM;
+		goto send_buffer_switch_signal;
+	}
+
+	/* The position we write to in the trace memory area is simply the
+	   beginning of trace memory plus the index we just reserved. */
+	current_write_pos = trace_buffer(cpu_id) + reserved_index;
+
+	/* If not using TSC, calculate delta */ 
+	recalc_time_delta(&time_stamp, &time_delta, cpu_id);
+
+	/* Write the CPUID to the tracing buffer, if required */
+	if ((log_cpuid == 1) && (event_id != TRACE_EV_START) 
+	    && (event_id != TRACE_EV_BUFFER_START))
+		tracer_write_to_buffer(current_write_pos,
+				       &cpu_id,
+				       sizeof(cpu_id));
+
+	/* Write event type to tracing buffer */
+	tracer_write_to_buffer(current_write_pos,
+			       &event_id,
+			       sizeof(event_id));
+
+	/* Write event time delta to tracing buffer */
+	tracer_write_to_buffer(current_write_pos,
+			       &time_delta,
+			       sizeof(time_delta));
+
+	/* Do we log event details */
+	if (ltt_test_bit(event_id, &log_event_details_mask)) {
+		/* Write event structure */
+		tracer_write_to_buffer(current_write_pos,
+				       event_struct,
+				       event_struct_size[event_id]);
+
+		/* Write string if any */
+		if (var_data_len)
+			tracer_write_to_buffer(current_write_pos,
+					       var_data_beg,
+					       var_data_len);
+	}
+	/* Write the length of the event description */
+	tracer_write_to_buffer(current_write_pos,
+			       &data_size,
+			       sizeof(data_size));
+
+	/* We've written the event - update the fill_count for the buffer. */ 
+	trace_commit(reserved_index, (u32)data_size, cpu_id);
+
+send_buffer_switch_signal:
+	/* Signal the daemon if we switched buffers */
+	if((atomic_read(&send_signal) == 1) && 
+	   (event_id != TRACE_EV_SCHEDCHANGE)) {
+		/* Atomically mark buffer-switch bit for this CPU */
+		set_bit(cpu_id, &buffer_switches_pending);
+
+		/* Clear the global pending signal flag */
+		atomic_set(&send_signal, 0);
+
+		/* Setup signal information */
+		daemon_sig_info.si_signo = SIGIO;
+		daemon_sig_info.si_errno = 0;
+		daemon_sig_info.si_code = SI_KERNEL;
+
+		/* Signal the tracing daemon */
+		send_sig_info(SIGIO, &daemon_sig_info, daemon_task_struct);
+	} 
+
+	return return_code;
+}
+
+/**
+ *	continue_trace: - Continue a stopped trace.
+ *	@cpu_id: the CPU id associated with the event
+ *
+ *	Continue a trace that's been temporarily stopped because all buffers
+ *	were full.
+ */
+static inline void continue_trace(u8 cpu_id)
+{
+	int discard_size;
+	u32 last_event_buf_no;
+	u32 last_buffer_lost_size;
+	u32 last_event_offset;
+	u32 new_index;
+	int freed_buf_no;
+
+	/* A buffer's been consumed, and as we've been waiting around at the 
+	   end of the last one produced, the one after that must now be free */
+	freed_buf_no = buffers_produced(cpu_id) % n_buffers(cpu_id);
+
+	/* Start the new buffer out at the beginning */
+	atomic_set_volatile(&fill_count(cpu_id, freed_buf_no), start_reserve);
+
+	/* In the all-buffers-full case, sBufferControl.index is frozen at the 
+	   position of the first event that would have caused a buffer switch.
+	   However, the fill_count for that buffer is not frozen and reflects 
+	   not only the lost size calculated at that point, but also any 
+	   smaller events that managed to write themselves at the end of the 
+	   last buffer (because there's technically still space at the end, 
+	   though it and all those contained events will be erased here).  
+	   Here we try to salvage if possible that last buffer, but to do 
+	   that, we need to subtract those pesky smaller events that managed 
+	   to get in.  If after all that, another small event manages to 
+	   sneak in in the time it takes us to do this, well, we concede and 
+	   the daemon will toss that buffer.  It's not the end of the world 
+	   if that happens, since that buffer actually marked the start of a 
+	   bunch of lost events which continues until a buffer is freed. */
+
+	/* Get the bufno and offset of the buffer containing the last event 
+	   logged before we had to stop for a buffer-full condition. */
+	last_event_offset = TRACE_BUFFER_OFFSET_GET(last_event_index(cpu_id), 
+						    offset_mask(cpu_id));
+	last_event_buf_no = TRACE_BUFFER_NUMBER_GET(last_event_index(cpu_id), 
+						    offset_bits(cpu_id));
+
+	/* We also need to know the lost size we wrote to that buffer when we 
+	   stopped */
+	last_buffer_lost_size = TRACE_BUFFER_SIZE(offset_bits(cpu_id)) 
+		- last_event_offset;
+
+	/* Since the time we stopped, some smaller events probably reserved 
+	   space and wrote themselves in, the sizes of which would have been 
+	   reflected in the fill_count.  The total size of these events is 
+	   calculated here.  */  
+	discard_size = atomic_read(&fill_count(cpu_id, last_event_buf_no))
+	  - last_event_offset
+	  - last_buffer_lost_size;
+
+	/* If there were events written after we stopped, subtract those from 
+	   the fill_count.  If that doesn't fix things, the buffer either is 
+	   really incomplete, or another event snuck in, and we'll just stop 
+	   now and say we did what we could for it. */
+	if(discard_size > 0)
+		atomic_sub_volatile(&fill_count(cpu_id, last_event_buf_no), 
+				    discard_size);
+
+	/* Since our end buffer event probably got trounced, rewrite it in old
+	   buffer. */
+	write_end_buffer_event(last_event_index(cpu_id) & index_mask(cpu_id), 
+	       last_event_timestamp(cpu_id), last_event_tsc(cpu_id), cpu_id);
+
+	/* We also need to update the buffer start time and write the start 
+	   event for the next buffer, since we couldn't do it until now */
+	get_timestamp(&buffer_start_time(cpu_id), &buffer_start_tsc(cpu_id));
+
+	/* The current buffer control index is hanging around near the end of 
+	   the last buffer.  So we add the buffer size and clear the offset to
+	   get to the beginning of the newly freed buffer. */
+	new_index = index(cpu_id) + TRACE_BUFFER_SIZE(offset_bits(cpu_id));
+	new_index = TRACE_BUFFER_OFFSET_CLEAR(new_index, 
+				      offset_mask(cpu_id)) + start_reserve;
+	write_start_buffer_event(new_index & index_mask(cpu_id), 
+		 buffer_start_time(cpu_id), buffer_start_tsc(cpu_id), cpu_id);
+
+	/* Fixing up sBufferControl.index is simpler.  Since a buffer has been
+	   consumed, there's now at least one buffer free, and we can continue.
+	   We start off the next buffer in a fresh state.  Since nothing else 
+	   can be meaningfully updating the buffer control index, we can safely
+	   do that here.  'Meaningfully' means that there may be cases of 
+	   smaller events managing to update the index in the last buffer but 
+	   they're essentially erased by the lost size of that buffer when 
+	   sBuffersFull was set. We need to restart the index at the beginning
+	   of the next available buffer before turning off sBuffersFull, and 
+	   avoid an erroneous buffer switch.  */ 
+	index(cpu_id) = new_index;
+
+	/* Now we can continue reserving events */
+	buffers_full(cpu_id) = 0;
+}
+
+/**
+ *	tracer_set_n_buffers: - Sets the number of buffers.
+ *	@no_buffers: number of buffers.
+ *
+ *	Sets the number of buffers containing the trace data, valid only for
+ *	lockless scheme, must be a power of 2.
+ *
+ *	Returns:
+ *
+ *	0, Size setting went OK
+ *	-EINVAL, not a power of 2
+ */
+int tracer_set_n_buffers(int no_buffers)
+{
+	if(hweight32(no_buffers) != 1) /* Invalid if # set bits in word != 1 */
+		return -EINVAL;
+	
+	/* Find position of one and only set bit */
+	buf_no_bits = ffs(no_buffers) - 1;
+
+	return 0;
+}
+
+/**
+ *	write_heartbeat_event: - Timer function generating hearbeat event.
+ *	@data: unused
+ *
+ *	Called at a frequency calculated to guarantee at least 1 event is 
+ *	logged before the low word of the TSC wraps.  The post-processing
+ *	tools depend on this in order to calculate the correct timestamp
+ *	in cases where no events occur in that interval e.g. ~10s on a 
+ *	400 MHz machine.
+ */
+static void write_heartbeat_event(unsigned long data)
+{
+	unsigned long int flags;	/* CPU flags for lock */
+	int i;
+	
+	local_irq_save(flags);
+	for(i =  0; i < num_cpus; i++)
+                set_waiting_for_cpu_async(i, LTT_TRACE_HEARTBEAT);
+	local_irq_restore(flags);
+
+	del_timer(&heartbeat_timer);
+
+	/* subtract a jiffy so we're more sure to get a slot */
+	heartbeat_timer.expires = jiffies + 0xffffffffUL/loops_per_jiffy - 1;
+	add_timer(&heartbeat_timer);
+}
+
+/**
+ *	init_heartbeat_timer: - Start timer generating hearbeat events.
+ *
+ *	In order to detect TSC wraps, at least one event must be written
+ *	within the TSC wrap time.  This ensures that will happen even if 
+ *	there aren't any other events occurring.
+ */
+static void init_heartbeat_timer(void)
+{
+	if(using_tsc == 1) {
+		if(loops_per_jiffy > 0) {
+			init_timer(&heartbeat_timer);
+			heartbeat_timer.function = write_heartbeat_event;
+
+			/* subtract a jiffy so we're more sure to get a slot */
+			heartbeat_timer.expires = jiffies 
+				+ 0xffffffffUL/loops_per_jiffy - 1;
+			add_timer(&heartbeat_timer);
+		} else
+			printk(KERN_ALERT "Tracer: Couldn't set up heartbeat timer - continuing without one \n");
+	}
+}
+
+/**
+ *	initialize_trace: - Initialize a trace session for a given CPU.
+ *	@cpu_id: the CPU id to initialize a trace for
+ *
+ *	Write the start-buffer and start-trace events for a CPU.
+ */
+static inline void initialize_trace(u8 cpu_id)
+{
+	trace_start start_event; /* Event marking the begining of the trace */
+	trace_buffer_start start_buffer_event;	/* Start of new buffer event */
+
+	/* Get the time of start */
+	get_timestamp(&buffer_start_time(cpu_id), &buffer_start_tsc(cpu_id));
+
+	/* Set the event description */
+	start_buffer_event.id = buffer_id(cpu_id);
+	start_buffer_event.time = buffer_start_time(cpu_id);
+	start_buffer_event.tsc = buffer_start_tsc(cpu_id);
+
+	/* Set the event description */
+	start_event.magic_number = TRACER_MAGIC_NUMBER;
+	start_event.arch_type = TRACE_ARCH_TYPE;
+	start_event.arch_variant = TRACE_ARCH_VARIANT;
+	start_event.system_type = TRACE_SYS_TYPE_VANILLA_LINUX;
+	start_event.major_version = TRACER_VERSION_MAJOR;
+	start_event.minor_version = TRACER_VERSION_MINOR;
+	start_event.buffer_size = buf_size;
+	start_event.event_mask = traced_events;
+	start_event.details_mask = log_event_details_mask;
+	start_event.log_cpuid = log_cpuid;
+	start_event.use_tsc = using_tsc;
+
+	/* Trace the buffer start event using the appropriate method depending
+	   on the locking scheme */
+	if(using_lockless == 1) {
+		write_start_buffer_event(index(cpu_id) & index_mask(cpu_id),
+					 buffer_start_time(cpu_id), 
+					 buffer_start_tsc(cpu_id), cpu_id);
+		write_start_event(&start_event, 
+				  buffer_start_tsc(cpu_id), cpu_id);
+	} else {
+		trace(TRACE_EV_BUFFER_START, &start_buffer_event, cpu_id);
+		/* Trace the start event */
+		trace(TRACE_EV_START, &start_event, cpu_id);
+	}
+}
+
+/**
+ *	all_finalized: - Determine whether all traces have been finalized.
+ *
+ *	Utility function for figuring out whether or not the traces for all
+ *	CPUs have been completed.  Returns 1 if so, 0 otherwise.
+ */
+static int all_finalized(void)
+{
+	int i;
+	
+	for(i = 0; i < num_cpus; i++)
+		if(atomic_read(&waiting_for_cpu_async(i)) & LTT_FINALIZE_TRACE)
+			return 0;
+
+	return 1;
+}
+
+/**
+ *	do_waiting_tasks: - perform synchronous per-CPU tasks.
+ *	@cpu_id: the CPU the tasks should be executed on
+ *
+ *	Certain tasks (e.g. initializing/continuing a trace) need to be 
+ *	executed on a particular CPU before anything else can be done on that
+ *	CPU and in certain cases can't be at the time the need is found to do 
+ *	so.  Each CPU has a set of flags indicating that the next thing that 
+ *	needs to be done on that CPU is one or more of the tasks indicated by 
+ *	a bit set in this set of flags.  Only one type of synchronous task per
+ *	 CPU is ever pending so queues aren't necessary.  This function 
+ *	(re)checks the flags and performs any of the indicated tasks.
+ */
+static void do_waiting_tasks(u8 cpu_id)
+{
+	unsigned long int flags;	/* CPU flags for lock */
+	int tasks;
+	
+	local_irq_save(flags);
+	/* Check again in case we've been usurped */
+	tasks = atomic_read(&waiting_for_cpu(cpu_id));
+	if(tasks == 0) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	/* Before we can log any events, we need to write start/start_buffer 
+	   event for this CPU */
+	if(using_tsc && tracer_started && (tasks & LTT_INITIALIZE_TRACE)) {
+                clear_waiting_for_cpu(cpu_id, LTT_INITIALIZE_TRACE);
+		initialize_trace(cpu_id);
+	}
+
+	if(using_lockless && tracer_started && (tasks & LTT_CONTINUE_TRACE)) {
+                clear_waiting_for_cpu(cpu_id, LTT_CONTINUE_TRACE);
+		continue_trace(cpu_id);
+	}
+
+	local_irq_restore(flags);
+}
+
+/**
+ *	del_percpu_timers: - Delete all per_cpu timers.
+ *
+ *	Delete the per-cpu timers synchronously.
+ */
+static inline void del_percpu_timers(void)
+{
+	int i;
+	
+	for(i =  0; i < num_cpus; i++)
+		del_timer_sync(&percpu_timer[i]);
+}
+
+/**
+ *	do_waiting_async_tasks: - perform asynchronous per-CPU tasks.
+ *	@cpu_id: the CPU the tasks should be executed on
+ *
+ *	Certain tasks (e.g. finalizing/writing a heartbeat event) need to be 
+ *	executed on a particular CPU as soon as possible on that CPU and in 
+ *	certain cases can't be at the time the need is found to do so.  Each 
+ *	CPU has a set of flags indicating something that needs to be done soon
+ *	on that CPU by a bit set in this set of flags.  Only one type of 
+ *	asynchronous task per CPU is ever pending so queues aren't necessary.
+ *	This function (re)checks the flags and performs any of the indicated 
+ *	tasks.
+ */
+static void do_waiting_async_tasks(u8 cpu_id)
+{
+	unsigned long int flags;	/* CPU flags for lock */
+	struct timeval time;		/* Event time */
+	trace_time_delta tsc;	        /* The buffer-end TSC */
+	int tasks;
+
+	local_irq_save(flags);
+	/* Check again in case we've been usurped */
+	tasks = atomic_read(&waiting_for_cpu_async(cpu_id));
+	if(tasks == 0) {
+		local_irq_restore(flags);
+		return;
+	}
+
+	if(using_tsc && tracer_started && (tasks & LTT_TRACE_HEARTBEAT)) {
+                clear_waiting_for_cpu_async(cpu_id, LTT_TRACE_HEARTBEAT);
+		TRACE_HEARTBEAT();
+	}
+
+	/* Before we finish logging, we need to write end_buffer 
+	   event for this CPU, if we're using TSC timestamping (because
+	   we couldn't do all finalizing in TRACER_STOP itself) */
+	if(tracer_stopping && using_tsc && (tasks & LTT_FINALIZE_TRACE)) {
+		/* NB - we need to do this before calling trace to 
+		   avoid recursion */
+                clear_waiting_for_cpu_async(cpu_id, LTT_FINALIZE_TRACE);
+		if(using_lockless) {
+			finalize_lockless_trace(cpu_id);
+		} else {
+			/* Atomically mark buffer-switch bit for this cpu */
+			set_bit(cpu_id, &buffer_switches_pending);
+
+			/* Get the time of the event */
+			get_timestamp(&time, &tsc);
+			tracer_switch_buffers(time, tsc, cpu_id);
+		}
+		if(all_finalized())
+			tracer_stopping = 0;
+	}
+	local_irq_restore(flags);
+}
+
+/**
+ *	check_waiting_async_tasks: - Timer function checking for async tasks.
+ *	@data: unused
+ *
+ *	Called at a frequency of LTT_PERCPU_TIMER_FREQ in order to check
+ *	whether there are any tasks that need peforming in the current CPU.
+ */
+static void check_waiting_async_tasks(unsigned long data)
+{
+	int cpu = smp_processor_id();
+
+	/* Execute any tasks waiting for this CPU */
+	if(atomic_read(&waiting_for_cpu_async(cpu)) != 0)
+		do_waiting_async_tasks(cpu);
+
+	del_timer(&percpu_timer[cpu]);
+	percpu_timer[cpu].expires = jiffies + LTT_PERCPU_TIMER_FREQ;
+	add_timer(&percpu_timer[cpu]);
+}
+
+/**
+ *	init_percpu_timer: - Start timer checking for async tasks.
+ *
+ *	Because we can't guarantee trace event frequency and thus the
+ *	frequency the tracer is able to execute something on a particular CPU,
+ *	we need to force the issue by making sure we gain control every so
+ *	often.  Examples of things we can't wait too long for are heartbeat
+ *	events and trace finalization.
+ */
+void init_ltt_percpu_timer(void * dummy)
+{
+	int cpu = smp_processor_id();
+
+	init_timer(&percpu_timer[cpu]);
+	percpu_timer[cpu].function = check_waiting_async_tasks;
+	percpu_timer[cpu].expires = jiffies + LTT_PERCPU_TIMER_FREQ;
+	add_timer(&percpu_timer[cpu]);
+}
