Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSJJFy7>; Thu, 10 Oct 2002 01:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbSJJFy7>; Thu, 10 Oct 2002 01:54:59 -0400
Received: from nameservices.net ([208.234.25.16]:8975 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S262062AbSJJFyq>;
	Thu, 10 Oct 2002 01:54:46 -0400
Message-ID: <3DA5188A.D5436324@opersys.com>
Date: Thu, 10 Oct 2002 02:04:58 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] LTT for 2.5.41: Core infrastructure 1/3
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This one has been longer to produce than the earlier ones because LTT
went through major surgery following Ingo's input. So here's a summary:
- Added per-CPU buffering (to both locking and lockless schemes)
- Added TSC timestamping
- Removed registration/unregistration
- Removed callbacks
- Merged all code into kernel/trace.c, thereby removing drivers/trace/
- Changed coding style completely to match kernel
- Removed all entries from task_struct
- Removed #ifdefs from tracer
- Removed debug code from tracer
- Added a "Tracing support" config item in "General setup" menu

There's only one final thing to do. Currently the tracer is still a
device, albeit living in kernel/trace.c. The final iteration will be
to remove all file-ops and replace them with a sys_trace() system call.
Most operations should be fairly simple. The only one I'm still iffy
about is mmap(). Since the tracer won't be a device anymore, I'll have
to find another way to remap the buffer into the daemon's address
space. Anyone have any suggestions on the cleanest way to do this?

Also, 2 items worthy of mention:
1) We needed to define TRUE and FALSE for the tracer. A grep for
#define TRUE/FALSE in include/linux shows a few repeats. Shouldn't
these be globally defined somewhere?
2) The tracer uses rvmalloc/rvfree. If I remember correctly there was
a suggestion at some point to define these globally for easier use.
A rapid grep in drivers/ shows that quite a few drivers had copies
of these functions in their source (especially drivers/ieee1394,
drivers/media/video, drivers/usb/media/).

Here are the file modifications:
 include/linux/trace.h |  957 +++++++++++++++
 init/Config.help      |   23
 init/Config.in        |    1
 kernel/Makefile       |    3
 kernel/trace.c        | 3123 ++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 4106 insertions, 1 deletion

I won't be posting the trace statements themselves this time around
because I'm really looking for input on the core infrastructure only
for this round. The trace points basically haven't changed, except to
adapt to some kernel modifications here and there. The only thing
that did change is that the bottom-half trace point has vanished ...
this is the first ever LTT trace point in 4 years to go bye-bye.

Don't attempt to use the patch below with version 0.9.6pre1 of the user
tools. The tools need to be updated. I will release 0.9.6pre2 shortly.

You can get the entire patch from:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.41-vanilla-021009-2.1.bz2

[Unfortunately, the entire thing doesn't fit in one post the LKML and
I got a bounce the first time around, so I had to cut it up a little.
Here's the first part which contains all the Makefile/Config/header stuff]

diff -urpN linux-2.5.41/include/linux/trace.h linux-2.5.41-ltt/include/linux/trace.h
--- linux-2.5.41/include/linux/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.41-ltt/include/linux/trace.h	Wed Oct  9 22:20:12 2002
@@ -0,0 +1,957 @@
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
+/* Logic values */
+/* BTW, this really ought to be defined globally somewhere in the kernel, there are
+already a few headers that define this each on their own. */
+#define FALSE 0
+#define TRUE  1
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
+#define CUSTOM_EVENT_MAX_SIZE        8192
+
+/* String length limits for custom events creation */
+#define CUSTOM_EVENT_TYPE_STR_LEN      20
+#define CUSTOM_EVENT_DESC_STR_LEN     100
+#define CUSTOM_EVENT_FORM_STR_LEN     256
+#define CUSTOM_EVENT_FINAL_STR_LEN    200
+
+/* Type of custom event formats */
+#define CUSTOM_EVENT_FORMAT_TYPE_NONE   0
+#define CUSTOM_EVENT_FORMAT_TYPE_STR    1
+#define CUSTOM_EVENT_FORMAT_TYPE_HEX    2
+#define CUSTOM_EVENT_FORMAT_TYPE_XML    3
+#define CUSTOM_EVENT_FORMAT_TYPE_IBM    4
+
+/* System types */
+#define TRACE_SYS_TYPE_VANILLA_LINUX        1	/* Vanilla linux kernel  */
+
+/* Architecture types */
+#define TRACE_ARCH_TYPE_I386                1   /* i386 system */
+#define TRACE_ARCH_TYPE_PPC                 2   /* PPC system */
+#define TRACE_ARCH_TYPE_SH                  3   /* SH system */
+#define TRACE_ARCH_TYPE_S390                4   /* S/390 system */
+#define TRACE_ARCH_TYPE_MIPS                5   /* MIPS system */
+#define TRACE_ARCH_TYPE_ARM                 6   /* ARM system */
+
+/* Standard definitions for variants */
+#define TRACE_ARCH_VARIANT_NONE             0   /* Main architecture implementation */
+
+/* Global trace flags */
+extern unsigned int syscall_entry_trace_active;
+extern unsigned int syscall_exit_trace_active;
+
+/* The functions to the tracer management code */
+int trace_set_config
+ (int,		/* Use depth to fetch eip */
+  int,		/* Use bounds to fetch eip */
+  int,		/* Detph to fetch eip */
+  void *,	/* Lower bound eip address */
+  void *);	/* Upper bound eip address */
+int trace_get_config
+ (int *,	/* Use depth to fetch eip */
+  int *,	/* Use bounds to fetch eip */
+  int *,	/* Detph to fetch eip */
+  void **,	/* Lower bound eip address */
+  void **);	/* Upper bound eip address */
+int trace_create_event
+ (char *,	/* String describing event type */
+  char *,	/* String to format standard event description */
+  int,		/* Type of formatting used to log event data */
+  char *);	/* Data specific to format */
+int trace_create_owned_event
+ (char *,	/* String describing event type */
+  char *,	/* String to format standard event description */
+  int,		/* Type of formatting used to log event data */
+  char *,	/* Data specific to format */
+  pid_t);      	/* PID of event's owner */
+void trace_destroy_event
+ (int);		/* The event ID given by trace_create_event() */
+void trace_destroy_owners_events
+ (pid_t);	/* The PID of the process' who's events are to be deleted */
+void trace_reregister_custom_events
+ (void);
+int trace_std_formatted_event
+ (int,		/* The event ID given by trace_create_event() */
+  ...);		/* The parameters to be printed out in the event string */
+int trace_raw_event
+ (int,		/* The event ID given by trace_create_event() */
+  int,		/* The size of the raw data */
+  void *);	/* Pointer to the raw event data */
+int trace_event
+ (u8,		/* Event ID (as defined in this header file) */
+  void *);	/* Structure describing the event */
+int trace_get_pending_write_count
+ (void);
+int trace
+ (u8,
+  void *,
+  u8);
+void tracer_switch_buffers
+ (struct timeval,
+  trace_time_delta tsc,
+  u8 cpu);
+int tracer_ioctl
+ (struct inode *,
+  struct file *,
+  unsigned int,
+  unsigned long);
+int tracer_mmap
+ (struct file *,
+  struct vm_area_struct *);
+int tracer_open
+ (struct inode *,
+  struct file *);
+int tracer_release
+ (struct inode *,
+  struct file *);
+int tracer_fsync
+ (struct file *,
+  struct dentry *,
+  int);
+int tracer_set_buffer_size
+ (int);
+int tracer_set_n_buffers
+ (int);
+int tracer_set_default_config
+ (void);
+
+/* Generic function */
+static inline void TRACE_EVENT(u8 event_id, void* data)
+{
+	trace_event(event_id, data);
+}
+
+/* Traced events */
+#define TRACE_EV_START           0	/* This is to mark the trace's start */
+#define TRACE_EV_SYSCALL_ENTRY   1	/* Entry in a given system call */
+#define TRACE_EV_SYSCALL_EXIT    2	/* Exit from a given system call */
+#define TRACE_EV_TRAP_ENTRY      3	/* Entry in a trap */
+#define TRACE_EV_TRAP_EXIT       4	/* Exit from a trap */
+#define TRACE_EV_IRQ_ENTRY       5	/* Entry in an irq */
+#define TRACE_EV_IRQ_EXIT        6	/* Exit from an irq */
+#define TRACE_EV_SCHEDCHANGE     7	/* Scheduling change */
+#define TRACE_EV_KERNEL_TIMER    8	/* The kernel timer routine has been called */
+#define TRACE_EV_SOFT_IRQ        9	/* Hit key part of soft-irq management */
+#define TRACE_EV_PROCESS        10	/* Hit key part of process management */
+#define TRACE_EV_FILE_SYSTEM    11	/* Hit key part of file system */
+#define TRACE_EV_TIMER          12	/* Hit key part of timer management */
+#define TRACE_EV_MEMORY         13	/* Hit key part of memory management */
+#define TRACE_EV_SOCKET         14	/* Hit key part of socket communication */
+#define TRACE_EV_IPC            15	/* Hit key part of System V IPC */
+#define TRACE_EV_NETWORK        16	/* Hit key part of network communication */
+
+#define TRACE_EV_BUFFER_START   17	/* Mark the begining of a trace buffer */
+#define TRACE_EV_BUFFER_END     18	/* Mark the ending of a trace buffer */
+#define TRACE_EV_NEW_EVENT      19	/* New event type */
+#define TRACE_EV_CUSTOM         20	/* Custom event */
+
+#define TRACE_EV_CHANGE_MASK    21	/* Change in event mask */
+
+#define TRACE_EV_HEARTBEAT      22	/* Heartbeat event */
+
+/* Number of traced events */
+#define TRACE_EV_MAX           TRACE_EV_HEARTBEAT
+
+/* Structures and macros for events */
+/* The information logged when the tracing is started */
+#define TRACER_MAGIC_NUMBER     0x00D6B7ED	/* That day marks an important historical event ... */
+#define TRACER_VERSION_MAJOR    2	/* Major version number */
+#define TRACER_VERSION_MINOR    1	/* Minor version number */
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
+#define TRACE_EV_SOFT_IRQ_BOTTOM_HALF        1	/* Conventional bottom-half */
+#define TRACE_EV_SOFT_IRQ_SOFT_IRQ           2	/* Real soft-irq */
+#define TRACE_EV_SOFT_IRQ_TASKLET_ACTION     3	/* Tasklet action */
+#define TRACE_EV_SOFT_IRQ_TASKLET_HI_ACTION  4	/* Tasklet hi-action */
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
+#define TRACE_EV_PROCESS_KTHREAD     1	/* Creation of a kernel thread */
+#define TRACE_EV_PROCESS_FORK        2	/* A fork or clone occured */
+#define TRACE_EV_PROCESS_EXIT        3	/* An exit occured */
+#define TRACE_EV_PROCESS_WAIT        4	/* A wait occured */
+#define TRACE_EV_PROCESS_SIGNAL      5	/* A signal has been sent */
+#define TRACE_EV_PROCESS_WAKEUP      6	/* Wake up a process */
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
+
+/*  TRACE_FILE_SYSTEM */
+#define TRACE_EV_FILE_SYSTEM_BUF_WAIT_START  1	/* Starting to wait for a data buffer */
+#define TRACE_EV_FILE_SYSTEM_BUF_WAIT_END    2	/* End to wait for a data buffer */
+#define TRACE_EV_FILE_SYSTEM_EXEC            3	/* An exec occured */
+#define TRACE_EV_FILE_SYSTEM_OPEN            4	/* An open occured */
+#define TRACE_EV_FILE_SYSTEM_CLOSE           5	/* A close occured */
+#define TRACE_EV_FILE_SYSTEM_READ            6	/* A read occured */
+#define TRACE_EV_FILE_SYSTEM_WRITE           7	/* A write occured */
+#define TRACE_EV_FILE_SYSTEM_SEEK            8	/* A seek occured */
+#define TRACE_EV_FILE_SYSTEM_IOCTL           9	/* An ioctl occured */
+#define TRACE_EV_FILE_SYSTEM_SELECT         10	/* A select occured */
+#define TRACE_EV_FILE_SYSTEM_POLL           11	/* A poll occured */
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
+#define TRACE_EV_TIMER_EXPIRED      1	/* Timer expired */
+#define TRACE_EV_TIMER_SETITIMER    2	/* Setting itimer occurred */
+#define TRACE_EV_TIMER_SETTIMEOUT   3	/* Setting sched timeout occurred */
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
+#define TRACE_EV_MEMORY_PAGE_ALLOC        1	/* Allocating pages */
+#define TRACE_EV_MEMORY_PAGE_FREE         2	/* Freing pages */
+#define TRACE_EV_MEMORY_SWAP_IN           3	/* Swaping pages in */
+#define TRACE_EV_MEMORY_SWAP_OUT          4	/* Swaping pages out */
+#define TRACE_EV_MEMORY_PAGE_WAIT_START   5	/* Start to wait for page */
+#define TRACE_EV_MEMORY_PAGE_WAIT_END     6	/* End to wait for page */
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
+#define TRACE_EV_SOCKET_CALL     1	/* A socket call occured */
+#define TRACE_EV_SOCKET_CREATE   2	/* A socket has been created */
+#define TRACE_EV_SOCKET_SEND     3	/* Data was sent to a socket */
+#define TRACE_EV_SOCKET_RECEIVE  4	/* Data was read from a socket */
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
+#define TRACE_EV_IPC_CALL            1	/* A System V IPC call occured */
+#define TRACE_EV_IPC_MSG_CREATE      2	/* A message queue has been created */
+#define TRACE_EV_IPC_SEM_CREATE      3	/* A semaphore was created */
+#define TRACE_EV_IPC_SHM_CREATE      4	/* A shared memory segment has been created */
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
+#define TRACE_EV_NETWORK_PACKET_IN   1	/* A packet came in */
+#define TRACE_EV_NETWORK_PACKET_OUT  2	/* A packet was sent */
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
+/* Number of bytes reserved for last event, including lost size word */
+#define TRACER_LAST_EVENT_SIZE   (sizeof(u8) + sizeof(u8) + sizeof(trace_time_delta) + sizeof(u32))
+
+/* The configurations possible */
+#define TRACER_START                      TRACER_MAGIC_NUMBER + 0	/* Start tracing events using the current configuration */
+#define TRACER_STOP                       TRACER_MAGIC_NUMBER + 1	/* Stop tracing */
+#define TRACER_CONFIG_DEFAULT             TRACER_MAGIC_NUMBER + 2	/* Set the tracer to the default configuration */
+#define TRACER_CONFIG_MEMORY_BUFFERS      TRACER_MAGIC_NUMBER + 3	/* Set the memory buffers the daemon wants us to use */
+#define TRACER_CONFIG_EVENTS              TRACER_MAGIC_NUMBER + 4	/* Trace the given events */
+#define TRACER_CONFIG_DETAILS             TRACER_MAGIC_NUMBER + 5	/* Record the details of the event, or not */
+#define TRACER_CONFIG_CPUID               TRACER_MAGIC_NUMBER + 6	/* Record the CPUID associated with the event */
+#define TRACER_CONFIG_PID                 TRACER_MAGIC_NUMBER + 7	/* Trace only one process */
+#define TRACER_CONFIG_PGRP                TRACER_MAGIC_NUMBER + 8	/* Trace only the given process group */
+#define TRACER_CONFIG_GID                 TRACER_MAGIC_NUMBER + 9	/* Trace the processes of a given group of users */
+#define TRACER_CONFIG_UID                 TRACER_MAGIC_NUMBER + 10	/* Trace the processes of a given user */
+#define TRACER_CONFIG_SYSCALL_EIP_DEPTH   TRACER_MAGIC_NUMBER + 11	/* Set the call depth at which the EIP should be fetched on syscall */
+#define TRACER_CONFIG_SYSCALL_EIP_LOWER   TRACER_MAGIC_NUMBER + 12	/* Set the lowerbound address from which EIP is recorded on syscall */
+#define TRACER_CONFIG_SYSCALL_EIP_UPPER   TRACER_MAGIC_NUMBER + 13	/* Set the upperbound address from which EIP is recorded on syscall */
+#define TRACER_DATA_COMITTED              TRACER_MAGIC_NUMBER + 14	/* The daemon has comitted the last trace */
+#define TRACER_GET_EVENTS_LOST            TRACER_MAGIC_NUMBER + 15	/* Get the number of events lost */
+#define TRACER_CREATE_USER_EVENT          TRACER_MAGIC_NUMBER + 16	/* Create a user tracable event */
+#define TRACER_DESTROY_USER_EVENT         TRACER_MAGIC_NUMBER + 17	/* Destroy a user tracable event */
+#define TRACER_TRACE_USER_EVENT           TRACER_MAGIC_NUMBER + 18	/* Trace a user event */
+#define TRACER_SET_EVENT_MASK             TRACER_MAGIC_NUMBER + 19	/* Set the trace event mask */
+#define TRACER_GET_EVENT_MASK             TRACER_MAGIC_NUMBER + 20	/* Get the trace event mask */
+#define TRACER_GET_BUFFER_CONTROL         TRACER_MAGIC_NUMBER + 21	/* Get the buffer control data for the lockless schem*/
+#define TRACER_CONFIG_N_MEMORY_BUFFERS    TRACER_MAGIC_NUMBER + 22	/* Set the number of memory buffers the daemon wants us to use */
+#define TRACER_CONFIG_USE_LOCKING         TRACER_MAGIC_NUMBER + 23      /* Set the locking scheme to use */
+#define TRACER_CONFIG_TIMESTAMP           TRACER_MAGIC_NUMBER + 24      /* Set the timestamping method to use */
+#define TRACER_GET_ARCH_INFO              TRACER_MAGIC_NUMBER + 25      /* Get information about the CPU configuration */
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
+#ifdef CONFIG_X86_TSC
+#include <asm/msr.h>
+#endif
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
+	if(using_tsc == FALSE)
+		*new_delta = calc_time_delta(now, &buffer_start_time(cpu));
+}
+
+/**
+ *	get_time_delta: - Utility function for getting time delta.
+ *	@now: pointer to a timeval struct that may be given current time
+ *	@cpu: the associated CPU id
+ *
+ *	Returns either the TSC if TSCs are being used, or the time and the
+ *	time difference between the current time and the buffer start time 
+ *	if TSCs are not being used.  The time is returned so that callers
+ *	can use the do_gettimeofday() result if they need to.
+ */
+static inline trace_time_delta get_time_delta(struct timeval *now, u8 cpu)
+{
+	trace_time_delta time_delta;
+
+#if defined (__i386__) || defined (__x86_64__)
+	if((using_tsc == TRUE) && cpu_has_tsc)
+		rdtscl(time_delta);
+	else {
+		do_gettimeofday(now);
+		time_delta = calc_time_delta(now, &buffer_start_time(cpu));
+	}
+#else	
+	do_gettimeofday(now);
+	time_delta = calc_time_delta(now, &buffer_start_time(cpu));
+#endif
+
+	return time_delta;
+}
+
+/**
+ *	get_timestamp: - Utility function for getting a time and TSC pair.
+ *	@now: current time
+ *	@tsc: the TSC associated with now
+ *
+ *	Sets the value pointed to by now to the current time and the value
+ *	pointed to by tsc to the tsc associated with that time, if the 
+ *	platform supports TSC.
+ */
+static inline void get_timestamp(struct timeval *now, 
+				 trace_time_delta *tsc)
+{
+	do_gettimeofday(now);
+
+#if defined (__i386__) || defined (__x86_64__)
+	if((using_tsc == TRUE) && cpu_has_tsc)
+		rdtscl(*tsc);
+#endif
+}
+
+/**
+ *	get_time_or_tsc: - Utility function for getting a time or a TSC.
+ *	@now: current time
+ *	@tsc: current TSC
+ *
+ *	Sets the value pointed to by now to the current time or the value
+ *	pointed to by tsc to the current tsc, depending on whether we're
+ *	using TSCs or not.
+ */
+static inline void get_time_or_tsc(struct timeval *now, 
+				   trace_time_delta *tsc)
+{
+#if defined (__i386__) || defined (__x86_64__)
+	if((using_tsc == TRUE) && cpu_has_tsc)
+		rdtscl(*tsc);
+	else
+#endif
+	do_gettimeofday(now);
+}
+
+/**
+ *	switch_time_delta: - Utility function getting buffer switch time delta.
+ *	@time_delta: previously calculated or retrieved time delta 
+ *
+ *	Returns the time_delta passed in if we're using TSC or 0 otherwise.
+ *	This function is used only for start/end buffer events.
+ */
+static inline trace_time_delta switch_time_delta(trace_time_delta time_delta)
+{
+#if defined (__i386__) || defined (__x86_64__)
+	if((using_tsc == TRUE) && cpu_has_tsc)
+		return time_delta;
+#endif
+	return 0;
+}
+
+/**
+ *	have_tsc: - Does this platform have a useable TSC?
+ *
+ *	Returns TRUE if this platform has a useable TSC counter for
+ *	timestamping purposes, FALSE otherwise.
+ */
+static inline int have_tsc(void)
+{
+#if defined (__i386__) || defined (__x86_64__)
+	if(cpu_has_tsc)
+		return TRUE;
+#endif
+	return FALSE;
+}
+
+/**
+ *	have_cmpxchg: - Does this platform have a cmpxchg?
+ *
+ *	Returns TRUE if this platform has a cmpxchg useable by 
+ *	the lockless scheme, FALSE otherwise.
+ */
+static inline int have_cmpxchg(void)
+{
+#if defined(__HAVE_ARCH_CMPXCHG)
+	return TRUE;
+#endif
+	return FALSE;
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
+#define TRACE_FILE_SYSTEM(ID, DATA1, DATA2, FILE_NAME)
+#define TRACE_TIMER(ID, SDATA, DATA1, DATA2)
+#define TRACE_MEMORY(ID, DATA)
+#define TRACE_SOCKET(ID, DATA1, DATA2)
+#define TRACE_IPC(ID, DATA1, DATA2)
+#define TRACE_NETWORK(ID, DATA)
+#define TRACE_HEARTBEAT()
+#endif				/* defined(CONFIG_TRACE) */
+#endif				/* _LINUX_TRACE_H */
diff -urpN linux-2.5.41/init/Config.help linux-2.5.41-ltt/init/Config.help
--- linux-2.5.41/init/Config.help	Mon Oct  7 14:23:24 2002
+++ linux-2.5.41-ltt/init/Config.help	Wed Oct  9 21:42:15 2002
@@ -115,3 +115,26 @@ CONFIG_KMOD
   replacement for kerneld.) Say Y here and read about configuring it
   in <file:Documentation/kmod.txt>.
 
+CONFIG_TRACE
+  It is possible for the kernel to log important events to a tracing
+  driver. Doing so, enables the use of the generated traces in order
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
+  function. The data is the recorded by the tracer if a trace daemon
+  is running in user-space and has issued a "start" command.
+
+  For more information on kernel tracing, the trace daemon or the event
+  decoder, please check the following address :
+       http://www.opersys.com/LTT
diff -urpN linux-2.5.41/init/Config.in linux-2.5.41-ltt/init/Config.in
--- linux-2.5.41/init/Config.in	Mon Oct  7 14:23:27 2002
+++ linux-2.5.41-ltt/init/Config.in	Wed Oct  9 21:36:13 2002
@@ -9,6 +9,7 @@ bool 'Networking support' CONFIG_NET
 bool 'System V IPC' CONFIG_SYSVIPC
 bool 'BSD Process Accounting' CONFIG_BSD_PROCESS_ACCT
 bool 'Sysctl support' CONFIG_SYSCTL
+bool 'Tracing support' CONFIG_TRACE
 endmenu
 
 mainmenu_option next_comment
diff -urpN linux-2.5.41/kernel/Makefile linux-2.5.41-ltt/kernel/Makefile
--- linux-2.5.41/kernel/Makefile	Mon Oct  7 14:23:34 2002
+++ linux-2.5.41-ltt/kernel/Makefile	Wed Oct  9 21:14:11 2002
@@ -3,7 +3,7 @@
 #
 
 export-objs = signal.o sys.o kmod.o workqueue.o ksyms.o pm.o exec_domain.o \
-	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
+	      printk.o platform.o suspend.o dma.o module.o cpufreq.o trace.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -19,6 +19,7 @@ obj-$(CONFIG_PM) += pm.o
 obj-$(CONFIG_CPU_FREQ) += cpufreq.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_SOFTWARE_SUSPEND) += suspend.o
+obj-$(CONFIG_TRACE) += trace.o
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
