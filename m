Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262368AbSJ2Vrq>; Tue, 29 Oct 2002 16:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262371AbSJ2Vrq>; Tue, 29 Oct 2002 16:47:46 -0500
Received: from nameservices.net ([208.234.25.16]:50988 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262368AbSJ2VrY>;
	Tue, 29 Oct 2002 16:47:24 -0500
Message-ID: <3DBF0468.7BF06D8B@opersys.com>
Date: Tue, 29 Oct 2002 16:58:00 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.44-bk2 1/10: Core definitions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Linus,

We've had this patch around for quite a while and it has been
reviewed by quite a few folks, including Ingo Molnar, Christoph
Hellwig, Roman Zippel, Pavel Machek, and yourself. Here's a
summary of the changes we carried out following LKML feedback:
- Add Lockless event logging
- Add Per-CPU buffering
- Add TSC timestamping
- Changed tracer from device to kernel subsystem
- Change coding style to match kernel

Considering that this patch has been around for over 3 years now,
that it has been extensively modified to satisfy the requirements
voiced on the LKML, and that LTT has been adopted as the main
tracing tool for Linux, Linus please apply.

We've also run an extensive set of stress tests on the patch
which show that that tracing has no overhead when unused and
very low overhead when used:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103573710926859&w=2
Basically, the overhead is 0% when compiled out, < 0.5% when
compile in, and 2.0% when tracing all kernel events and writing
the data to disk.

Note that the patch set is quite modular. In other words, you
can apply the core infrastructure (patches # 1, 2 and 3) and
apply the actual trace statement patches later on (patches # 4
through 10).

D: This patch includes all the definitions (headers/configs/makefiles)
D: required by the trace subsystem.

diffstat:
 MAINTAINERS                 |    7 
 include/asm-generic/trace.h |   86 ++++
 include/linux/trace.h       |  930 ++++++++++++++++++++++++++++++++++++++++++++
 init/Config.help            |   23 +
 init/Config.in              |    1 

The complete patch is available from:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.44-bk2-021029-2.2.bz2

(This set of patches is against the bk2 snapshot available from:
ftp://ftp.kernel.org/pub/linux/kernel/v2.5/snapshots/)

diff -urpN linux-2.5.44-bk2/MAINTAINERS linux-2.5.44-bk2-ltt/MAINTAINERS
--- linux-2.5.44-bk2/MAINTAINERS	Tue Oct 29 15:54:54 2002
+++ linux-2.5.44-bk2-ltt/MAINTAINERS	Tue Oct 29 15:24:17 2002
@@ -983,6 +983,13 @@ W:	http://linuxppc64.org
 L:	linuxppc64-dev@lists.linuxppc.org
 S:	Supported
 
+LINUX TRACE TOOLKIT
+P:	Karim Yaghmour
+M:	karim@opersys.com
+W:	http://www.opersys.com/LTT
+L:	ltt-dev@listserv.shafik.org
+S:	Maintained
+
 LOGICAL DISK MANAGER SUPPORT (LDM, Windows 2000/XP Dynamic Disks)
 P:	Richard Russon (FlatCap)
 M:	ldm@flatcap.org
diff -urpN linux-2.5.44-bk2/include/asm-generic/trace.h linux-2.5.44-bk2-ltt/include/asm-generic/trace.h
--- linux-2.5.44-bk2/include/asm-generic/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.44-bk2-ltt/include/asm-generic/trace.h	Tue Oct 29 15:24:18 2002
@@ -0,0 +1,86 @@
+/*
+ * linux/include/asm-generic/trace.h
+ *
+ * Copyright (C) 1999-2002 Karim Yaghmour (karim@opersys.com)
+ *
+ * Basic architecture independent default definitions for low-level functions.
+ */
+
+/**
+ *	get_time_delta: - Utility function for getting time delta.
+ *	@now: pointer to a timeval struct that may be given current time
+ *	@cpu: the associated CPU id
+ *
+ *	Returns the time difference between the current time and the buffer
+ *	start time.  The time is returned so that callers can use the
+ *	do_gettimeofday() result if they need to.
+ */
+static inline trace_time_delta get_time_delta(struct timeval *now, u8 cpu)
+{
+	trace_time_delta time_delta;
+
+	do_gettimeofday(now);
+	time_delta = calc_time_delta(now, &buffer_start_time(cpu));
+
+	return time_delta;
+}
+
+/**
+ *	get_timestamp: - Utility function for getting a time and TSC pair.
+ *	@now: current time
+ *	@tsc: the TSC associated with now
+ *
+ *	Sets the value pointed to by now to the current time. Value pointed to
+ *	by tsc is not set since there is no generic TSC support.
+ */
+static inline void get_timestamp(struct timeval *now, 
+				 trace_time_delta *tsc)
+{
+	do_gettimeofday(now);
+}
+
+/**
+ *	get_time_or_tsc: - Utility function for getting a time or a TSC.
+ *	@now: current time
+ *	@tsc: current TSC
+ *
+ *	Sets the value pointed to by now to the current time.
+ */
+static inline void get_time_or_tsc(struct timeval *now, 
+				   trace_time_delta *tsc)
+{
+	do_gettimeofday(now);
+}
+
+/**
+ *	switch_time_delta: - Utility function getting buffer switch time delta.
+ *	@time_delta: previously calculated or retrieved time delta 
+ *
+ *	Returns 0.
+ *	This function is used only for start/end buffer events.
+ */
+static inline trace_time_delta switch_time_delta(trace_time_delta time_delta)
+{
+	return 0;
+}
+
+/**
+ *	have_tsc: - Does this platform have a useable TSC?
+ *
+ *	Returns 0.
+ */
+static inline int have_tsc(void)
+{
+	return 0;
+}
+
+/**
+ *	init_percpu_timers: - Initialize per-cpu timers (only if using TSC)
+ *
+ *	Sets up the timers needed on each CPU for checking asynchronous 
+ *	tasks needing attention.  This is only the case when TSC timestamping 
+ *	is being used (TSCs need to be read on the current CPU).
+ */
+static inline void init_percpu_timers(void)
+{
+}
diff -urpN linux-2.5.44-bk2/include/linux/trace.h linux-2.5.44-bk2-ltt/include/linux/trace.h
--- linux-2.5.44-bk2/include/linux/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.44-bk2-ltt/include/linux/trace.h	Tue Oct 29 15:24:18 2002
@@ -0,0 +1,930 @@
+/*
+ * linux/include/linux/trace.h
+ *
+ * Copyright (C) 1999-2002 Karim Yaghmour (karim@opersys.com)
+ *
+ * This contains the necessary definitions for tracing the
+ * the system.
+ */
+
+#ifndef _LINUX_TRACE_H
+#define _LINUX_TRACE_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/sched.h>
+
+/* Is kernel tracing enabled */
+#if defined(CONFIG_TRACE)
+
+/* Don't set this to "1" unless you really know what you're doing */
+#define LTT_UNPACKED_STRUCTS	0
+
+/* Structure packing within the trace */
+#if LTT_UNPACKED_STRUCTS
+#define LTT_PACKED_STRUCT
+#else				/* if LTT_UNPACKED_STRUCTS */
+#define LTT_PACKED_STRUCT __attribute__ ((packed))
+#endif				/* if LTT_UNPACKED_STRUCTS */
+
+/* Misc type definitions */
+typedef u32 trace_time_delta;	/* The type used to start the time delta between events */
+typedef u64 trace_event_mask;	/* The event mask type */
+
+/* Maximal size a custom event can have */
+#define CUSTOM_EVENT_MAX_SIZE		8192
+
+/* String length limits for custom events creation */
+#define CUSTOM_EVENT_TYPE_STR_LEN	20
+#define CUSTOM_EVENT_DESC_STR_LEN	100
+#define CUSTOM_EVENT_FORM_STR_LEN	256
+#define CUSTOM_EVENT_FINAL_STR_LEN	200
+
+/* Type of custom event formats */
+#define CUSTOM_EVENT_FORMAT_TYPE_NONE	0
+#define CUSTOM_EVENT_FORMAT_TYPE_STR	1
+#define CUSTOM_EVENT_FORMAT_TYPE_HEX	2
+#define CUSTOM_EVENT_FORMAT_TYPE_XML	3
+#define CUSTOM_EVENT_FORMAT_TYPE_IBM	4
+
+/* Tracing handles */
+#define TRACE_MAX_HANDLES		256
+
+/* System types */
+#define TRACE_SYS_TYPE_VANILLA_LINUX	1	/* Vanilla linux kernel  */
+
+/* Architecture types */
+#define TRACE_ARCH_TYPE_I386			1   /* i386 system */
+#define TRACE_ARCH_TYPE_PPC			2   /* PPC system */
+#define TRACE_ARCH_TYPE_SH			3   /* SH system */
+#define TRACE_ARCH_TYPE_S390			4   /* S/390 system */
+#define TRACE_ARCH_TYPE_MIPS			5   /* MIPS system */
+#define TRACE_ARCH_TYPE_ARM			6   /* ARM system */
+
+/* Standard definitions for variants */
+#define TRACE_ARCH_VARIANT_NONE             0   /* Main architecture implementation */
+
+/* Global trace flags */
+extern unsigned int syscall_entry_trace_active;
+extern unsigned int syscall_exit_trace_active;
+
+/* The functions to the tracer management code */
+extern int trace_set_config(
+	int		do_syscall_depth,	/* Use depth to fetch eip */
+	int		do_syscall_bounds,	/* Use bounds to fetch eip */
+	int		eip_depth,		/* Detph to fetch eip */
+	void		*eip_lower_bound,	/* Lower bound eip address */
+	void		*eip_upper_bound);	/* Upper bound eip address */
+extern int trace_get_config(
+	int		*do_syscall_depth,	/* Use depth to fetch eip */
+	int		*do_syscall_bounds,	/* Use bounds to fetch eip */
+	int		*eip_depth,		/* Detph to fetch eip */
+	void		**eip_lower_bound,	/* Lower bound eip address */
+	void		**eip_upper_bound);	/* Upper bound eip address */
+extern int trace_create_event(
+	char		*event_type,		/* String describing event type */
+	char		*event_desc,		/* String to format standard event description */
+	int		format_type,		/* Type of formatting used to log event data */
+	char		*format_data);		/* Data specific to format */
+extern int trace_create_owned_event(
+	char		*event_type,		/* String describing event type */
+	char		*event_desc,		/* String to format standard event description */
+	int		format_type,		/* Type of formatting used to log event data */
+	char		*format_data,		/* Data specific to format */
+	pid_t		owner_pid);      	/* PID of event's owner */
+extern void trace_destroy_event(
+	int		event_id);		/* The event ID given by trace_create_event() */
+extern void trace_destroy_owners_events(
+	pid_t		owner_pid);		/* The PID of the process' who's events are to be deleted */
+extern void trace_reregister_custom_events(void);
+extern int trace_std_formatted_event(
+	int		event_id,		/* The event ID given by trace_create_event() */
+	...);					/* The parameters to be printed out in the event string */
+extern int trace_raw_event(
+	int		event_id,		/* The event ID given by trace_create_event() */
+	int		event_size,		/* The size of the raw data */
+	void		*event_data);		/* Pointer to the raw event data */
+extern int trace_event(
+	u8		event_id,		/* Event ID (as defined in this header file) */
+	void		*event_struct);		/* Structure describing the event */
+extern int trace_get_pending_write_count(void);
+extern int trace(
+	u8		event_id,		/* ID of event as described in this header */
+	void		*event_struct,		/* Structure describing the event */
+	u8		cpu_id);		/* CPU associated with event */
+extern void tracer_switch_buffers(
+	struct timeval		current_time,	/* Current time (time where switch occurs) */
+	trace_time_delta	current_tsc,	/* TSC value associated with current time */
+	u8			cpu_id);	/* CPU associated with event */
+extern int trace_mmap_buffer(
+	unsigned int	tracer_handle,		/* Tracer handle */
+	unsigned long	length,			/* Length of mapping range */
+	unsigned long	*start_addr);		/* Pointer to mapping start address */
+extern int trace_valid_handle(
+	unsigned int	tracer_handle);		/* Tracer handle */
+extern int trace_alloc_handle(
+	unsigned int	tracer_handle);		/* Tracer handle */
+extern int trace_free_handle(
+	unsigned int	tracer_handle);		/* Tracer handle */
+extern int trace_free_daemon_handle(void);
+extern void trace_free_all_handles(
+	struct task_struct*	task_ptr);	/* Pointer to task who's handles are to be freed */
+extern int tracer_set_buffer_size(
+	int		buffers_size);		/* Size of buffers */
+extern int tracer_set_n_buffers(
+	int		no_buffers);		/* Number of buffers */
+extern int tracer_set_default_config(void);
+
+extern asmlinkage int sys_trace(
+	unsigned int	tracer_handle,		/* Tracer handle */
+	unsigned int	tracer_command,		/* Trace subsystem command */
+	unsigned long	command_arg1,		/* Argument "1" to command */
+	unsigned long	command_arg2);		/* Argument "2" to command */
+
+/* Generic function */
+static inline void TRACE_EVENT(u8 event_id, void* data)
+{
+	trace_event(event_id, data);
+}
+
+/* Traced events */
+enum {
+	TRACE_EV_START = 0,	/* This is to mark the trace's start */
+	TRACE_EV_SYSCALL_ENTRY,	/* Entry in a given system call */
+	TRACE_EV_SYSCALL_EXIT,	/* Exit from a given system call */
+	TRACE_EV_TRAP_ENTRY,	/* Entry in a trap */
+	TRACE_EV_TRAP_EXIT,	/* Exit from a trap */
+	TRACE_EV_IRQ_ENTRY,	/* Entry in an irq */
+	TRACE_EV_IRQ_EXIT,	/* Exit from an irq */
+	TRACE_EV_SCHEDCHANGE,	/* Scheduling change */
+	TRACE_EV_KERNEL_TIMER,	/* The kernel timer routine has been called */
+	TRACE_EV_SOFT_IRQ,	/* Hit key part of soft-irq management */
+	TRACE_EV_PROCESS,	/* Hit key part of process management */
+	TRACE_EV_FILE_SYSTEM,	/* Hit key part of file system */
+	TRACE_EV_TIMER,		/* Hit key part of timer management */
+	TRACE_EV_MEMORY,	/* Hit key part of memory management */
+	TRACE_EV_SOCKET,	/* Hit key part of socket communication */
+	TRACE_EV_IPC,		/* Hit key part of System V IPC */
+	TRACE_EV_NETWORK,	/* Hit key part of network communication */
+	TRACE_EV_BUFFER_START,	/* Mark the begining of a trace buffer */
+	TRACE_EV_BUFFER_END,	/* Mark the ending of a trace buffer */
+	TRACE_EV_NEW_EVENT,	/* New event type */
+	TRACE_EV_CUSTOM,	/* Custom event */
+	TRACE_EV_CHANGE_MASK,	/* Change in event mask */
+	TRACE_EV_HEARTBEAT	/* Heartbeat event */
+};
+
+/* Number of traced events */
+#define TRACE_EV_MAX           TRACE_EV_HEARTBEAT
+
+/* Structures and macros for events */
+/* The information logged when the tracing is started */
+#define TRACER_MAGIC_NUMBER     0x00D6B7ED	/* That day marks an important historical event ... */
+#define TRACER_VERSION_MAJOR    2	/* Major version number */
+#define TRACER_VERSION_MINOR    2	/* Minor version number */
+typedef struct _trace_start {
+	u32 magic_number;	/* Magic number to identify a trace */
+	u32 arch_type;		/* Type of architecture */
+	u32 arch_variant;	/* Variant of the given type of architecture */
+	u32 system_type;	/* Operating system type */
+	u8 major_version;	/* Major version of trace */
+	u8 minor_version;	/* Minor version of trace */
+
+	u32 buffer_size;		/* Size of buffers */
+	trace_event_mask event_mask;	/* The event mask */
+	trace_event_mask details_mask;	/* Are the event details logged */
+	u8 log_cpuid;			/* Is the CPUID logged */
+	u8 use_tsc;		/* Are we using TSCs or time deltas? */
+} LTT_PACKED_STRUCT trace_start;
+
+/*  TRACE_SYSCALL_ENTRY */
+typedef struct _trace_syscall_entry {
+	u8 syscall_id;		/* Syscall entry number in entry.S */
+	u32 address;		/* Address from which call was made */
+} LTT_PACKED_STRUCT trace_syscall_entry;
+
+/*  TRACE_TRAP_ENTRY */
+#ifndef __s390__
+typedef struct _trace_trap_entry {
+	u16 trap_id;		/* Trap number */
+	u32 address;		/* Address where trap occured */
+} LTT_PACKED_STRUCT trace_trap_entry;
+static inline void TRACE_TRAP_ENTRY(u16 trap_id, u32 address)
+#else
+typedef u64 trapid_t;
+typedef struct _trace_trap_entry {
+	trapid_t trap_id;	/* Trap number */
+	u32 address;		/* Address where trap occured */
+} LTT_PACKED_STRUCT trace_trap_entry;
+static inline void TRACE_TRAP_ENTRY(trapid_t trap_id, u32 address)
+#endif
+{
+	trace_trap_entry trap_event;
+
+	trap_event.trap_id = trap_id;
+	trap_event.address = address;
+
+	trace_event(TRACE_EV_TRAP_ENTRY, &trap_event);
+}
+
+/*  TRACE_TRAP_EXIT */
+static inline void TRACE_TRAP_EXIT(void)
+{
+	trace_event(TRACE_EV_TRAP_EXIT, NULL);
+}
+
+/*  TRACE_IRQ_ENTRY */
+typedef struct _trace_irq_entry {
+	u8 irq_id;		/* IRQ number */
+	u8 kernel;		/* Are we executing kernel code */
+} LTT_PACKED_STRUCT trace_irq_entry;
+static inline void TRACE_IRQ_ENTRY(u8 irq_id, u8 in_kernel)
+{
+	trace_irq_entry irq_entry;
+
+	irq_entry.irq_id = irq_id;
+	irq_entry.kernel = in_kernel;
+
+	trace_event(TRACE_EV_IRQ_ENTRY, &irq_entry);
+}
+
+/*  TRACE_IRQ_EXIT */
+static inline void TRACE_IRQ_EXIT(void)
+{
+	trace_event(TRACE_EV_IRQ_EXIT, NULL);
+}
+
+/*  TRACE_SCHEDCHANGE */
+typedef struct _trace_schedchange {
+	u32 out;		/* Outgoing process */
+	u32 in;			/* Incoming process */
+	u32 out_state;		/* Outgoing process' state */
+} LTT_PACKED_STRUCT trace_schedchange;
+static inline void TRACE_SCHEDCHANGE(task_t * task_out, task_t * task_in)
+{
+	trace_schedchange sched_event;
+
+	sched_event.out = (u32) task_out->pid;
+	sched_event.in = (u32) task_in;
+	sched_event.out_state = (u32) task_out->state;
+
+	trace_event(TRACE_EV_SCHEDCHANGE, &sched_event);
+}
+
+/*  TRACE_SOFT_IRQ */
+enum {
+	TRACE_EV_SOFT_IRQ_BOTTOM_HALF = 1,	/* Conventional bottom-half */
+	TRACE_EV_SOFT_IRQ_SOFT_IRQ,		/* Real soft-irq */
+	TRACE_EV_SOFT_IRQ_TASKLET_ACTION,	/* Tasklet action */
+	TRACE_EV_SOFT_IRQ_TASKLET_HI_ACTION	/* Tasklet hi-action */
+};
+typedef struct _trace_soft_irq {
+	u8 event_sub_id;	/* Soft-irq event Id */
+	u32 event_data;		/* Data associated with event */
+} LTT_PACKED_STRUCT trace_soft_irq;
+static inline void TRACE_SOFT_IRQ(u8 ev_id, u32 data)
+{
+	trace_soft_irq soft_irq_event;
+
+	soft_irq_event.event_sub_id = ev_id;
+	soft_irq_event.event_data = data;
+
+	trace_event(TRACE_EV_SOFT_IRQ, &soft_irq_event);
+}
+
+/*  TRACE_PROCESS */
+enum {
+	TRACE_EV_PROCESS_KTHREAD = 1,	/* Creation of a kernel thread */
+	TRACE_EV_PROCESS_FORK,		/* A fork or clone occured */
+	TRACE_EV_PROCESS_EXIT,		/* An exit occured */
+	TRACE_EV_PROCESS_WAIT,		/* A wait occured */
+	TRACE_EV_PROCESS_SIGNAL,	/* A signal has been sent */
+	TRACE_EV_PROCESS_WAKEUP		/* Wake up a process */
+};
+typedef struct _trace_process {
+	u8 event_sub_id;	/* Process event ID */
+	u32 event_data1;	/* Data associated with event */
+	u32 event_data2;
+} LTT_PACKED_STRUCT trace_process;
+static inline void TRACE_PROCESS(u8 ev_id, u32 data1, u32 data2)
+{
+	trace_process proc_event;
+
+	proc_event.event_sub_id = ev_id;
+	proc_event.event_data1 = data1;
+	proc_event.event_data2 = data2;
+
+	trace_event(TRACE_EV_PROCESS, &proc_event);
+}
+static inline void TRACE_PROCESS_EXIT(u32 data1, u32 data2)
+{
+	trace_process proc_event;
+
+	proc_event.event_sub_id = TRACE_EV_PROCESS_EXIT;
+
+	/**** WARNING ****/
+	/* Regardless of whether this trace statement is active or not, these
+	two function must be called, otherwise there will be inconsistencies
+	in the kernel's structures. */
+	trace_destroy_owners_events(current->pid);
+	trace_free_all_handles(current);
+
+	trace_event(TRACE_EV_PROCESS, &proc_event);
+}
+
+/*  TRACE_FILE_SYSTEM */
+enum {
+	TRACE_EV_FILE_SYSTEM_BUF_WAIT_START = 1,	/* Starting to wait for a data buffer */
+	TRACE_EV_FILE_SYSTEM_BUF_WAIT_END,		/* End to wait for a data buffer */
+	TRACE_EV_FILE_SYSTEM_EXEC,			/* An exec occured */
+	TRACE_EV_FILE_SYSTEM_OPEN,			/* An open occured */
+	TRACE_EV_FILE_SYSTEM_CLOSE,			/* A close occured */
+	TRACE_EV_FILE_SYSTEM_READ,			/* A read occured */
+	TRACE_EV_FILE_SYSTEM_WRITE,			/* A write occured */
+	TRACE_EV_FILE_SYSTEM_SEEK,			/* A seek occured */
+	TRACE_EV_FILE_SYSTEM_IOCTL,			/* An ioctl occured */
+	TRACE_EV_FILE_SYSTEM_SELECT,			/* A select occured */
+	TRACE_EV_FILE_SYSTEM_POLL			/* A poll occured */
+};
+typedef struct _trace_file_system {
+	u8 event_sub_id;	/* File system event ID */
+	u32 event_data1;	/* Event data */
+	u32 event_data2;	/* Event data 2 */
+	char *file_name;	/* Name of file operated on */
+} LTT_PACKED_STRUCT trace_file_system;
+static inline void TRACE_FILE_SYSTEM(u8 ev_id, u32 data1, u32 data2, const unsigned char *file_name)
+{
+	trace_file_system fs_event;
+
+	fs_event.event_sub_id = ev_id;
+	fs_event.event_data1 = data1;
+	fs_event.event_data2 = data2;
+	fs_event.file_name = (char*) file_name;
+
+	trace_event(TRACE_EV_FILE_SYSTEM, &fs_event);
+}
+
+/*  TRACE_TIMER */
+enum {
+	TRACE_EV_TIMER_EXPIRED = 1,	/* Timer expired */
+	TRACE_EV_TIMER_SETITIMER,	/* Setting itimer occurred */
+	TRACE_EV_TIMER_SETTIMEOUT	/* Setting sched timeout occurred */
+};
+typedef struct _trace_timer {
+	u8 event_sub_id;	/* Timer event ID */
+	u8 event_sdata;		/* Short data */
+	u32 event_data1;	/* Data associated with event */
+	u32 event_data2;
+} LTT_PACKED_STRUCT trace_timer;
+static inline void TRACE_TIMER(u8 ev_id, u8 sdata, u32 data1, u32 data2)
+{
+	trace_timer timer_event;
+
+	timer_event.event_sub_id = ev_id;
+	timer_event.event_sdata = sdata;
+	timer_event.event_data1 = data1;
+	timer_event.event_data2 = data2;
+
+	trace_event(TRACE_EV_TIMER, &timer_event);
+}
+
+/*  TRACE_MEMORY */
+enum {
+	TRACE_EV_MEMORY_PAGE_ALLOC = 1,		/* Allocating pages */
+	TRACE_EV_MEMORY_PAGE_FREE,		/* Freing pages */
+	TRACE_EV_MEMORY_SWAP_IN,		/* Swaping pages in */
+	TRACE_EV_MEMORY_SWAP_OUT,		/* Swaping pages out */
+	TRACE_EV_MEMORY_PAGE_WAIT_START,	/* Start to wait for page */
+	TRACE_EV_MEMORY_PAGE_WAIT_END		/* End to wait for page */
+};
+typedef struct _trace_memory {
+	u8 event_sub_id;	/* Memory event ID */
+	u32 event_data;		/* Data associated with event */
+} LTT_PACKED_STRUCT trace_memory;
+static inline void TRACE_MEMORY(u8 ev_id, u32 data)
+{
+	trace_memory memory_event;
+
+	memory_event.event_sub_id = ev_id;
+	memory_event.event_data = data;
+
+	trace_event(TRACE_EV_MEMORY, &memory_event);
+}
+
+/*  TRACE_SOCKET */
+enum {
+	TRACE_EV_SOCKET_CALL = 1,	/* A socket call occured */
+	TRACE_EV_SOCKET_CREATE,		/* A socket has been created */
+	TRACE_EV_SOCKET_SEND,		/* Data was sent to a socket */
+	TRACE_EV_SOCKET_RECEIVE		/* Data was read from a socket */
+};
+typedef struct _trace_socket {
+	u8 event_sub_id;	/* Socket event ID */
+	u32 event_data1;	/* Data associated with event */
+	u32 event_data2;	/* Data associated with event */
+} LTT_PACKED_STRUCT trace_socket;
+static inline void TRACE_SOCKET(u8 ev_id, u32 data1, u32 data2)
+{
+	trace_socket socket_event;
+
+	socket_event.event_sub_id = ev_id;
+	socket_event.event_data1 = data1;
+	socket_event.event_data2 = data2;
+
+	trace_event(TRACE_EV_SOCKET, &socket_event);
+}
+
+/*  TRACE_IPC */
+enum {
+	TRACE_EV_IPC_CALL = 1,		/* A System V IPC call occured */
+	TRACE_EV_IPC_MSG_CREATE,	/* A message queue has been created */
+	TRACE_EV_IPC_SEM_CREATE,	/* A semaphore was created */
+	TRACE_EV_IPC_SHM_CREATE		/* A shared memory segment has been created */
+};
+typedef struct _trace_ipc {
+	u8 event_sub_id;	/* IPC event ID */
+	u32 event_data1;	/* Data associated with event */
+	u32 event_data2;	/* Data associated with event */
+} LTT_PACKED_STRUCT trace_ipc;
+static inline void TRACE_IPC(u8 ev_id, u32 data1, u32 data2)
+{
+	trace_ipc ipc_event;
+
+	ipc_event.event_sub_id = ev_id;
+	ipc_event.event_data1 = data1;
+	ipc_event.event_data2 = data2;
+
+	trace_event(TRACE_EV_IPC, &ipc_event);
+}
+
+/*  TRACE_NETWORK */
+enum {
+	TRACE_EV_NETWORK_PACKET_IN = 1,	/* A packet came in */
+	TRACE_EV_NETWORK_PACKET_OUT	/* A packet was sent */
+};
+typedef struct _trace_network {
+	u8 event_sub_id;	/* Network event ID */
+	u32 event_data;		/* Event data */
+} LTT_PACKED_STRUCT trace_network;
+static inline void TRACE_NETWORK(u8 ev_id, u32 data)
+{
+	trace_network net_event;
+
+	net_event.event_sub_id = ev_id;
+	net_event.event_data = data;
+
+	trace_event(TRACE_EV_NETWORK, &net_event);
+}
+
+/* Start of trace buffer information */
+typedef struct _trace_buffer_start {
+	struct timeval time;	/* Time stamp of this buffer */
+	trace_time_delta tsc;   /* TSC of this buffer, if applicable */
+	u32 id;			/* Unique buffer ID */
+} LTT_PACKED_STRUCT trace_buffer_start;
+
+/* End of trace buffer information */
+typedef struct _trace_buffer_end {
+	struct timeval time;	/* Time stamp of this buffer */
+	trace_time_delta tsc;   /* TSC of this buffer, if applicable */
+} LTT_PACKED_STRUCT trace_buffer_end;
+
+/* Custom declared events */
+/* ***WARNING*** These structures should never be used as is, use the provided custom
+   event creation and logging functions. */
+typedef struct _trace_new_event {
+	/* Basics */
+	u32 id;					/* Custom event ID */
+	char type[CUSTOM_EVENT_TYPE_STR_LEN];	/* Event type description */
+	char desc[CUSTOM_EVENT_DESC_STR_LEN];	/* Detailed event description */
+
+	/* Custom formatting */
+	u32 format_type;			/* Type of formatting */
+	char form[CUSTOM_EVENT_FORM_STR_LEN];	/* Data specific to format */
+} LTT_PACKED_STRUCT trace_new_event;
+typedef struct _trace_custom {
+	u32 id;			/* Event ID */
+	u32 data_size;		/* Size of data recorded by event */
+	void *data;		/* Data recorded by event */
+} LTT_PACKED_STRUCT trace_custom;
+
+/* TRACE_CHANGE_MASK */
+typedef struct _trace_change_mask {
+	trace_event_mask mask;	/* Event mask */
+} LTT_PACKED_STRUCT trace_change_mask;
+
+
+/*  TRACE_HEARTBEAT */
+static inline void TRACE_HEARTBEAT(void)
+{
+	trace_event(TRACE_EV_HEARTBEAT, NULL);
+}
+
+/* Tracer properties */
+#define TRACER_NAME      "tracer"	/* Name of the device as seen in /proc/devices */
+
+/* Tracer buffer information */
+#define TRACER_DEFAULT_BUF_SIZE   50000		/* Default size of tracing buffer */
+#define TRACER_MIN_BUF_SIZE        1000		/* Minimum size of tracing buffer */
+#define TRACER_MAX_BUF_SIZE      500000		/* Maximum size of tracing buffer */
+#define TRACER_MIN_BUFFERS            2		/* Minimum number of tracing buffers */
+#define TRACER_MAX_BUFFERS          256		/* Maximum number of tracing buffers */
+
+/* Number of bytes reserved for first event */
+#define TRACER_FIRST_EVENT_SIZE   (sizeof(u8) + sizeof(trace_time_delta) + sizeof(trace_buffer_start) + sizeof(uint16_t))
+
+/* Number of bytes reserved for the start-of-trace event */
+#define TRACER_START_TRACE_EVENT_SIZE   (sizeof(u8) + sizeof(trace_time_delta) + sizeof(trace_start) + sizeof(uint16_t))
+
+/* Number of bytes reserved for last event, including lost size word */
+#define TRACER_LAST_EVENT_SIZE   (sizeof(u8) \
+				  + sizeof(u8) \
+				  + sizeof(trace_time_delta) \
+				  + sizeof(trace_buffer_end) \
+				  + sizeof(uint16_t) \
+				  + sizeof(u32))
+
+/* The configurations possible */
+enum {
+	TRACER_START = TRACER_MAGIC_NUMBER,	/* Start tracing events using the current configuration */
+	TRACER_STOP,				/* Stop tracing */
+	TRACER_CONFIG_DEFAULT,			/* Set the tracer to the default configuration */
+	TRACER_CONFIG_MEMORY_BUFFERS,		/* Set the memory buffers the daemon wants us to use */
+	TRACER_CONFIG_EVENTS,			/* Trace the given events */
+	TRACER_CONFIG_DETAILS,			/* Record the details of the event, or not */
+	TRACER_CONFIG_CPUID,			/* Record the CPUID associated with the event */
+	TRACER_CONFIG_PID,			/* Trace only one process */
+	TRACER_CONFIG_PGRP,			/* Trace only the given process group */
+	TRACER_CONFIG_GID,			/* Trace the processes of a given group of users */
+	TRACER_CONFIG_UID,			/* Trace the processes of a given user */
+	TRACER_CONFIG_SYSCALL_EIP_DEPTH,	/* Set the call depth at which the EIP should be fetched on syscall */
+	TRACER_CONFIG_SYSCALL_EIP_LOWER,	/* Set the lowerbound address from which EIP is recorded on syscall */
+	TRACER_CONFIG_SYSCALL_EIP_UPPER,	/* Set the upperbound address from which EIP is recorded on syscall */
+	TRACER_DATA_COMITTED,			/* The daemon has comitted the last trace */
+	TRACER_GET_EVENTS_LOST,			/* Get the number of events lost */
+	TRACER_CREATE_USER_EVENT,		/* Create a user tracable event */
+	TRACER_DESTROY_USER_EVENT,		/* Destroy a user tracable event */
+	TRACER_TRACE_USER_EVENT,		/* Trace a user event */
+	TRACER_SET_EVENT_MASK,			/* Set the trace event mask */
+	TRACER_GET_EVENT_MASK,			/* Get the trace event mask */
+	TRACER_GET_BUFFER_CONTROL,		/* Get the buffer control data for the lockless schem*/
+	TRACER_CONFIG_N_MEMORY_BUFFERS,		/* Set the number of memory buffers the daemon wants us to use */
+	TRACER_CONFIG_USE_LOCKING,		/* Set the locking scheme to use */
+	TRACER_CONFIG_TIMESTAMP,		/* Set the timestamping method to use */
+	TRACER_GET_ARCH_INFO,			/* Get information about the CPU configuration */
+	TRACER_ALLOC_HANDLE,			/* Allocate a tracer handle */
+	TRACER_FREE_HANDLE,			/* Free a single handle */
+	TRACER_FREE_DAEMON_HANDLE,		/* Free the daemon's handle */
+	TRACER_FREE_ALL_HANDLES,		/* Free all handles */
+	TRACER_MAP_BUFFER			/* Map buffer to process-space */
+};
+
+/* For the lockless scheme:
+
+   A trace index is composed of two parts, a buffer number and a buffer 
+   offset.  The actual number of buffers allocated is a run-time decision, 
+   although it must be a power of two for efficient computation.  We define 
+   a maximum number of bits for the buffer number, because the fill_count 
+   array in buffer_control must have a fixed size.  offset_bits must be at 
+   least as large as the maximum event size+start/end buffer event size+
+   lost size word (since a buffer must be able to hold an event of maximum 
+   size).  Making offset_bits larger reduces fragmentation.  Making it 
+   smaller increases trace responsiveness. */
+
+/* We need at least enough room for the max custom event, and we also need
+   room for the start and end event.  We also need it to be a power of 2. */
+#define TRACER_LOCKLESS_MIN_BUF_SIZE CUSTOM_EVENT_MAX_SIZE + 8192 /* 16K */
+/* Because we use atomic_t as the type for fill_counts, which has only 24
+   usable bits, we have 2**24 = 16M max for each buffer. */
+#define TRACER_LOCKLESS_MAX_BUF_SIZE 0x1000000 /* 16M */
+/* Since we multiply n buffers by the buffer size, this provides a sanity
+   check, much less than the 256*16M possible. */
+#define TRACER_LOCKLESS_MAX_TOTAL_BUF_SIZE 0x8000000 /* 128M */
+
+#define TRACE_MAX_BUFFER_NUMBER(bufno_bits) (1UL << (bufno_bits))
+#define TRACE_BUFFER_SIZE(offset_bits) (1UL << (offset_bits))
+#define TRACE_BUFFER_OFFSET_MASK(offset_bits) (TRACE_BUFFER_SIZE(offset_bits) - 1)
+
+#define TRACE_BUFFER_NUMBER_GET(index, offset_bits) ((index) >> (offset_bits))
+#define TRACE_BUFFER_OFFSET_GET(index, mask) ((index) & (mask))
+#define TRACE_BUFFER_OFFSET_CLEAR(index, mask) ((index) & ~(mask))
+
+/* Flags returned by trace_reserve/trace_reserve_slow */
+#define LTT_BUFFER_SWITCH_NONE 0x00
+#define LTT_EVENT_DISCARD_NONE 0x00
+#define LTT_BUFFER_SWITCH      0x01
+#define LTT_EVENT_DISCARD      0x02
+#define LTT_EVENT_TOO_LONG     0x04
+
+/* Flags used to indicate things to do on particular CPUs */
+#define LTT_NOTHING_TO_DO      0x00
+#define LTT_INITIALIZE_TRACE   0x01
+#define LTT_FINALIZE_TRACE     0x02
+#define LTT_CONTINUE_TRACE     0x04
+#define LTT_TRACE_HEARTBEAT    0x08
+
+/* How often the LTT per-CPU timers fire */
+#define LTT_PERCPU_TIMER_FREQ  (HZ/10);
+
+/* Per-CPU buffer information for the lockless scheme */
+struct lockless_buffer_control
+{
+	u8 bufno_bits;
+	u8 offset_bits;
+	u32 buffers_produced;
+	u32 buffers_consumed;
+
+	u32 index;
+	u32 n_buffers; /* cached value */
+	u32 offset_mask; /* cached value */
+	u32 index_mask; /* cached value */
+	int buffers_full; /* All-(sub)buffers-full boolean */
+	u32 last_event_index; /* For full-buffers state */ 
+	struct timeval last_event_timestamp; /* For full-buffers state */
+	trace_time_delta last_event_tsc; /* TSC at buffer_start_time */
+	atomic_t fill_count[TRACER_MAX_BUFFERS];
+};
+
+/* Per-CPU buffer information for the locking scheme */
+struct locking_buffer_control
+{
+	char* write_buf; /* Buffer used for writting */
+	char* read_buf; /* Buffer used for reading */
+	char* write_buf_end; /* End of write buffer */
+	char* read_buf_end; /* End of read buffer */
+	char* current_write_pos; /* Current position for writting */
+	char* read_limit; /* Limit at which read should stop */
+	char* write_limit; /* Limit at which write should stop */
+	atomic_t signal_sent;
+};
+
+/* Data structure containing per-buffer tracing information. */ 
+struct buffer_control
+{
+	char *trace_buffer;
+	u32 buffer_id; /* for start-buffer event */
+	u32 events_lost; /* Events lost on this cpu */
+	struct timeval  buffer_start_time; /* Time the buffer was started */
+	trace_time_delta buffer_start_tsc; /* TSC at buffer_start_time */
+	atomic_t waiting_for_cpu;
+	atomic_t waiting_for_cpu_async;
+
+	union 
+	{
+		struct lockless_buffer_control lockless;
+		struct locking_buffer_control locking;
+	} scheme;
+} ____cacheline_aligned;
+
+/* Data structure for sharing per-buffer information between driver and 
+   daemon (via ioctl) */
+struct shared_buffer_control
+{
+	u8 cpu_id;
+	u32 buffer_switches_pending;
+	u32 buffer_control_valid;
+
+	u8 bufno_bits;
+	u8 offset_bits;
+	u32 buffers_produced;
+	u32 buffers_consumed;
+	/* atomic_t has only 24 usable bits, limiting us to 16M buffers */
+	int fill_count[TRACER_MAX_BUFFERS];
+};
+
+/* Data structure for sharing buffer-commit information between driver and 
+   daemon (via ioctl) */
+struct buffers_committed
+{
+	u8 cpu_id;
+	u32 buffers_consumed;
+};
+
+/* Data structure for sharing architecture-specific info between driver and 
+   daemon (via ioctl) */
+struct ltt_arch_info
+{
+	int n_cpus;
+	int page_shift;
+};
+
+/* Buffer control data structure accessor functions */
+#define _index(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.index)
+#define index(cpu) (_index(buffer_control, (cpu)))
+#define _bufno_bits(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.bufno_bits)
+#define bufno_bits(cpu) (_bufno_bits(buffer_control, (cpu)))
+#define _n_buffers(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.n_buffers)
+#define n_buffers(cpu) (_n_buffers(buffer_control, (cpu)))
+#define _offset_bits(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.offset_bits)
+#define offset_bits(cpu) (_offset_bits(buffer_control, (cpu)))
+#define _offset_mask(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.offset_mask)
+#define offset_mask(cpu) (_offset_mask(buffer_control, (cpu)))
+#define _index_mask(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.index_mask)
+#define index_mask(cpu) (_index_mask(buffer_control, (cpu)))
+#define _buffers_produced(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.buffers_produced)
+#define buffers_produced(cpu) (_buffers_produced(buffer_control, (cpu)))
+#define _buffers_consumed(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.buffers_consumed)
+#define buffers_consumed(cpu) (_buffers_consumed(buffer_control, (cpu)))
+#define _buffers_full(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.buffers_full)
+#define buffers_full(cpu) (_buffers_full(buffer_control, (cpu)))
+#define _fill_count(sbc, cpu, i) (((sbc)+(cpu))->scheme.lockless.fill_count[(i)])
+#define fill_count(cpu, i) (_fill_count(buffer_control, (cpu), (i)))
+#define _trace_buffer(sbc, cpu) (((sbc)+(cpu))->trace_buffer)
+#define trace_buffer(cpu) (_trace_buffer(buffer_control, (cpu)))
+#define _buffer_id(sbc, cpu) (((sbc)+(cpu))->buffer_id)
+#define buffer_id(cpu) (_buffer_id(buffer_control, (cpu)))
+#define _events_lost(sbc, cpu) (((sbc)+(cpu))->events_lost)
+#define events_lost(cpu) (_events_lost(buffer_control, (cpu)))
+#define _buffer_start_time(sbc, cpu) (((sbc)+(cpu))->buffer_start_time)
+#define buffer_start_time(cpu) (_buffer_start_time(buffer_control, (cpu)))
+#define _buffer_start_tsc(sbc, cpu) (((sbc)+(cpu))->buffer_start_tsc)
+#define buffer_start_tsc(cpu) (_buffer_start_tsc(buffer_control, (cpu)))
+#define _last_event_index(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.last_event_index)
+#define last_event_index(cpu) (_last_event_index(buffer_control, (cpu)))
+#define _last_event_timestamp(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.last_event_timestamp)
+#define last_event_timestamp(cpu) (_last_event_timestamp(buffer_control, (cpu)))
+#define _last_event_tsc(sbc, cpu) (((sbc)+(cpu))->scheme.lockless.last_event_tsc)
+#define last_event_tsc(cpu) (_last_event_tsc(buffer_control, (cpu)))
+#define _write_buf(sbc, cpu) (((sbc)+(cpu))->scheme.locking.write_buf)
+#define write_buf(cpu) (_write_buf(buffer_control, (cpu)))
+#define _read_buf(sbc, cpu) (((sbc)+(cpu))->scheme.locking.read_buf)
+#define read_buf(cpu) (_read_buf(buffer_control, (cpu)))
+#define _write_buf_end(sbc, cpu) (((sbc)+(cpu))->scheme.locking.write_buf_end)
+#define write_buf_end(cpu) (_write_buf_end(buffer_control, (cpu)))
+#define _read_buf_end(sbc, cpu) (((sbc)+(cpu))->scheme.locking.read_buf_end)
+#define read_buf_end(cpu) (_read_buf_end(buffer_control, (cpu)))
+#define _current_write_pos(sbc, cpu) (((sbc)+(cpu))->scheme.locking.current_write_pos)
+#define current_write_pos(cpu) (_current_write_pos(buffer_control, (cpu)))
+#define _read_limit(sbc, cpu) (((sbc)+(cpu))->scheme.locking.read_limit)
+#define read_limit(cpu) (_read_limit(buffer_control, (cpu)))
+#define _write_limit(sbc, cpu) (((sbc)+(cpu))->scheme.locking.write_limit)
+#define write_limit(cpu) (_write_limit(buffer_control, (cpu)))
+#define _signal_sent(sbc, cpu) (((sbc)+(cpu))->scheme.locking.signal_sent)
+#define signal_sent(cpu) (_signal_sent(buffer_control, (cpu)))
+#define _waiting_for_cpu(sbc, cpu) (((sbc)+(cpu))->waiting_for_cpu)
+#define waiting_for_cpu(cpu) (_waiting_for_cpu(buffer_control, (cpu)))
+#define _waiting_for_cpu_async(sbc, cpu) (((sbc)+(cpu))->waiting_for_cpu_async)
+#define waiting_for_cpu_async(cpu) (_waiting_for_cpu_async(buffer_control, (cpu)))
+
+extern int using_tsc;
+extern struct buffer_control buffer_control[];
+
+/**
+ *	set_waiting_for_cpu: - Utility function for setting wait flags
+ *	@cpu_id: which CPU to set flag on
+ *	@bit: which bit to set
+ *
+ *	Sets the given bit of the CPU's waiting_for_cpu flags.
+ */
+static inline void set_waiting_for_cpu(u8 cpu_id, int bit)
+{
+	atomic_set(&waiting_for_cpu(cpu_id), 
+		   atomic_read(&waiting_for_cpu(cpu_id)) | bit);
+}
+
+/**
+ *	clear_waiting_for_cpu: - Utility function for clearing wait flags
+ *	@cpu_id: which CPU to clear flag on
+ *	@bit: which bit to clear
+ *
+ *	Clears the given bit of the CPU's waiting_for_cpu flags.
+ */
+static inline void clear_waiting_for_cpu(u8 cpu_id, int bit)
+{
+	atomic_set(&waiting_for_cpu(cpu_id), 
+		   atomic_read(&waiting_for_cpu(cpu_id)) & ~bit);
+}
+
+/**
+ *	set_waiting_for_cpu_async: - Utility function for setting wait flags
+ *	@cpu_id: which CPU to set flag on
+ *	@bit: which bit to set
+ *
+ *	Sets the given bit of the CPU's waiting_for_cpu_async flags.
+ */
+static inline void set_waiting_for_cpu_async(u8 cpu_id, int bit)
+{
+	atomic_set(&waiting_for_cpu_async(cpu_id), 
+		   atomic_read(&waiting_for_cpu_async(cpu_id)) | bit);
+}
+
+/**
+ *	clear_waiting_for_cpu_async: - Utility function for clearing wait flags
+ *	@cpu_id: which CPU to clear flag on
+ *	@bit: which bit to clear
+ *
+ *	Clears the given bit of the CPU's waiting_for_cpu_async flags.
+ */
+static inline void clear_waiting_for_cpu_async(u8 cpu_id, int bit)
+{
+	atomic_set(&waiting_for_cpu_async(cpu_id), 
+		   atomic_read(&waiting_for_cpu_async(cpu_id)) & ~bit);
+}
+
+/**
+ *	calc_time_delta: - Utility function for time delta calculation.
+ *	@now: current time
+ *	@start: start time
+ *
+ *	Returns the time delta produced by subtracting start time from now.
+ */
+static inline trace_time_delta calc_time_delta(struct timeval *now, 
+					       struct timeval *start)
+{
+	return (now->tv_sec - start->tv_sec) * 1000000
+		+ (now->tv_usec - start->tv_usec);
+}
+
+/**
+ *	recalc_time_delta: - Utility function for time delta recalculation.
+ *	@now: current time
+ *	@new_delta: the new time delta calculated
+ *	@cpu: the associated CPU id
+ *
+ *	Sets the value pointed to by new_delta to the time difference between
+ *	the buffer start time and now, if TSC timestamping is being used. 
+ */
+static inline void recalc_time_delta(struct timeval *now, 
+				     trace_time_delta *new_delta,
+				     u8 cpu)
+{
+	if(using_tsc == 0)
+		*new_delta = calc_time_delta(now, &buffer_start_time(cpu));
+}
+
+/**
+ *	have_cmpxchg: - Does this platform have a cmpxchg?
+ *
+ *	Returns 1 if this platform has a cmpxchg useable by 
+ *	the lockless scheme, 0 otherwise.
+ */
+static inline int have_cmpxchg(void)
+{
+#if defined(__HAVE_ARCH_CMPXCHG)
+	return 1;
+#else
+	return 0;
+#endif
+}
+
+/* If cmpxchg isn't defined for the architecture, we don't want to 
+   generate a link error - the locking scheme will still be available. */  
+#ifndef __HAVE_ARCH_CMPXCHG
+#define cmpxchg(p,o,n) 0
+#endif
+
+extern __inline__ int ltt_set_bit(int nr, void *addr)
+{
+	unsigned char *p = addr;
+	unsigned char mask = 1 << (nr & 7);
+	unsigned char old;
+
+	p += nr >> 3;
+	old = *p;
+	*p |= mask;
+
+	return ((old & mask) != 0);
+}
+
+extern __inline__ int ltt_clear_bit(int nr, void *addr)
+{
+	unsigned char *p = addr;
+	unsigned char mask = 1 << (nr & 7);
+	unsigned char old;
+
+	p += nr >> 3;
+	old = *p;
+	*p &= ~mask;
+
+	return ((old & mask) != 0);
+}
+
+extern __inline__ int ltt_test_bit(int nr, void *addr)
+{
+	unsigned char *p = addr;
+	unsigned char mask = 1 << (nr & 7);
+
+	p += nr >> 3;
+
+	return ((*p & mask) != 0);
+}
+
+#else				/* Kernel is configured without tracing */
+#define TRACE_EVENT(ID, DATA)
+#define TRACE_TRAP_ENTRY(ID, EIP)
+#define TRACE_TRAP_EXIT()
+#define TRACE_IRQ_ENTRY(ID, KERNEL)
+#define TRACE_IRQ_EXIT()
+#define TRACE_SCHEDCHANGE(OUT, IN)
+#define TRACE_SOFT_IRQ(ID, DATA)
+#define TRACE_PROCESS(ID, DATA1, DATA2)
+#define TRACE_PROCESS_EXIT(DATA1, DATA2)
+#define TRACE_FILE_SYSTEM(ID, DATA1, DATA2, FILE_NAME)
+#define TRACE_TIMER(ID, SDATA, DATA1, DATA2)
+#define TRACE_MEMORY(ID, DATA)
+#define TRACE_SOCKET(ID, DATA1, DATA2)
+#define TRACE_IPC(ID, DATA1, DATA2)
+#define TRACE_NETWORK(ID, DATA)
+#define TRACE_HEARTBEAT()
+#endif				/* defined(CONFIG_TRACE) */
+#endif				/* _LINUX_TRACE_H */
diff -urpN linux-2.5.44-bk2/init/Config.help linux-2.5.44-bk2-ltt/init/Config.help
--- linux-2.5.44-bk2/init/Config.help	Sat Oct 19 00:02:00 2002
+++ linux-2.5.44-bk2-ltt/init/Config.help	Tue Oct 29 15:24:18 2002
@@ -115,3 +115,26 @@ CONFIG_KMOD
   replacement for kerneld.) Say Y here and read about configuring it
   in <file:Documentation/kmod.txt>.
 
+CONFIG_TRACE
+  It is possible for the kernel to log important events to a trace
+  facility. Doing so, enables the use of the generated traces in order
+  to reconstruct the dynamic behavior of the kernel, and hence the
+  whole system.
+
+  The tracing process contains 4 parts :
+      1) The logging of events by key parts of the kernel.
+      2) The tracer that keeps the events in a data buffer.
+      3) A trace daemon that interacts with the tracer and is
+         notified every time there is a certain quantity of data to
+         read from the tracer.
+      4) A trace event data decoder that reads the accumulated data
+         and formats it in a human-readable format.
+
+  If you say Y, the first two components will be built into the kernel.
+  Critical parts of the kernel will call upon the kernel tracing
+  function. The data is then recorded by the tracer if a trace daemon
+  is running in user-space and has issued a "start" command.
+
+  For more information on kernel tracing, the trace daemon or the event
+  decoder, please check the following address :
+       http://www.opersys.com/LTT
diff -urpN linux-2.5.44-bk2/init/Config.in linux-2.5.44-bk2-ltt/init/Config.in
--- linux-2.5.44-bk2/init/Config.in	Sat Oct 19 00:01:13 2002
+++ linux-2.5.44-bk2-ltt/init/Config.in	Tue Oct 29 15:24:18 2002
@@ -9,6 +9,7 @@ bool 'Networking support' CONFIG_NET
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+bool 'Tracing support' CONFIG_TRACE
 endmenu
 
 mainmenu_option next_comment
