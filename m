Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319407AbSIFWHy>; Fri, 6 Sep 2002 18:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319408AbSIFWHy>; Fri, 6 Sep 2002 18:07:54 -0400
Received: from nameservices.net ([208.234.25.16]:26756 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S319407AbSIFWHm>;
	Fri, 6 Sep 2002 18:07:42 -0400
Message-ID: <3D792919.C40A2F02@opersys.com>
Date: Fri, 06 Sep 2002 18:15:53 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH] 1/8 LTT for 2.5.33: Core infrastructure
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is the core code for the mechanisms provided by LTT. This patch
adds 2 files:
kernel/trace.c
include/linux/trace.h

The trace statements in trace.h are currently implemented as inline
functions. We plan on replacing those by kernel hooks once the kernel
hooks become part of the kernel. The cost of the trace statements
when they are compiled in the kernel is already low, but by using
kernel hooks there would be no cost at all.

The complete patch is available in one piece here:
http://opersys.com/ftp/pub/LTT/ExtraPatches/patch-ltt-linux-2.5.33-vanilla-020906-1.14.bz2

The userspace tools are available here:
http://www.opersys.com/LTT

diff -urN linux-2.5.33/kernel/Makefile linux-2.5.33-ltt/kernel/Makefile
--- linux-2.5.33/kernel/Makefile	Sat Aug 31 18:04:52 2002
+++ linux-2.5.33-ltt/kernel/Makefile	Fri Sep  6 15:14:28 2002
@@ -10,7 +10,7 @@
 O_TARGET := kernel.o
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-		printk.o platform.o suspend.o dma.o
+		printk.o platform.o suspend.o dma.o trace.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
@@ -32,6 +32,10 @@
 # I turn this off for IA-64 only.  Andreas Schwab says it's also needed on m68k
 # to get a correct value for the wait-channel (WCHAN in ps). --davidm
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
+endif
+
+ifdef CONFIG_TRACE
+obj-y += trace.o
 endif
 
 include $(TOPDIR)/Rules.make
diff -urN linux-2.5.33/include/linux/trace.h linux-2.5.33-ltt/include/linux/trace.h
--- linux-2.5.33/include/linux/trace.h	Wed Dec 31 19:00:00 1969
+++ linux-2.5.33-ltt/include/linux/trace.h	Fri Sep  6 16:02:14 2002
@@ -0,0 +1,450 @@
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
+#if defined(CONFIG_TRACE) || defined(CONFIG_TRACE_MODULE)
+
+/* Structure packing within the trace */
+#if LTT_UNPACKED_STRUCTS
+#define LTT_PACKED_STRUCT
+#else				/* if LTT_UNPACKED_STRUCTS */
+#define LTT_PACKED_STRUCT __attribute__ ((packed))
+#endif				/* if LTT_UNPACKED_STRUCTS */
+
+/* The prototype of the tracer call (EventID, *EventStruct) */
+typedef int (*tracer_call) (u8, void *);
+
+/* This structure contains all the information needed to be known
+   about the tracing module. */
+struct tracer {
+	tracer_call trace;			/* The tracing routine itself */
+
+	int fetch_syscall_eip_use_depth;	/* Use the given depth */
+	int fetch_syscall_eip_use_bounds;	/* Find eip in bounds */
+	int syscall_eip_depth;			/* Call depth at which eip is fetched */
+	void *syscall_lower_eip_bound;		/* Lower eip bound */
+	void *syscall_upper_eip_bound;		/* Higher eip bound */
+};
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
+/* Architecture types */
+#define TRACE_ARCH_TYPE_I386                1   /* i386 system */
+#define TRACE_ARCH_TYPE_PPC                 2   /* PPC system */
+#define TRACE_ARCH_TYPE_SH                  3   /* SH system */
+#define TRACE_ARCH_TYPE_S390                4   /* S/390 system */
+#define TRACE_ARCH_TYPE_MIPS                5   /* MIPS system */
+
+/* Standard definitions for variants */
+#define TRACE_ARCH_VARIANT_NONE             0   /* Main architecture implementation */
+
+/* Global trace flags */
+extern unsigned int syscall_entry_trace_active;
+extern unsigned int syscall_exit_trace_active;
+
+/* The functions to the tracer management code */
+int register_tracer
+ (tracer_call /* The tracer function */ );
+int unregister_tracer
+ (tracer_call /* The tracer function */ );
+int trace_set_config
+ (tracer_call /* The tracer function */ ,
+  int /* Use depth to fetch eip */ ,
+  int /* Use bounds to fetch eip */ ,
+  int /* Detph to fetch eip */ ,
+  void * /* Lower bound eip address */ ,
+  void * /* Upper bound eip address */ );
+int trace_register_callback
+ (tracer_call /* The callback to add */ ,
+  u8 /* The event ID targeted */ );
+int trace_unregister_callback
+ (tracer_call /* The callback to remove */ ,
+  u8 /* The event ID targeted */ );
+int trace_get_config
+ (int * /* Use depth to fetch eip */ ,
+  int * /* Use bounds to fetch eip */ ,
+  int * /* Detph to fetch eip */ ,
+  void ** /* Lower bound eip address */ ,
+  void ** /* Upper bound eip address */ );
+int trace_create_event
+ (char * /* String describing event type */ ,
+  char * /* String to format standard event description */ ,
+  int /* Type of formatting used to log event data */ ,
+  char * /* Data specific to format */ );
+int trace_create_owned_event
+ (char * /* String describing event type */ ,
+  char * /* String to format standard event description */ ,
+  int /* Type of formatting used to log event data */ ,
+  char * /* Data specific to format */ ,
+  pid_t /* PID of event's owner */ );
+void trace_destroy_event
+ (int /* The event ID given by trace_create_event() */ );
+void trace_destroy_owners_events
+ (pid_t /* The PID of the process' who's events are to be deleted */ );
+void trace_reregister_custom_events
+ (void);
+int trace_std_formatted_event
+ (int /* The event ID given by trace_create_event() */ ,
+  ... /* The parameters to be printed out in the event string */ );
+int trace_raw_event
+ (int /* The event ID given by trace_create_event() */ ,
+  int /* The size of the raw data */ ,
+  void * /* Pointer to the raw event data */ );
+int trace_event
+ (u8 /* Event ID (as defined in this header file) */ ,
+  void * /* Structure describing the event */ );
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
+/* Number of traced events */
+#define TRACE_EV_MAX           TRACE_EV_CHANGE_MASK
+
+/* Structures and macros for events */
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
+typedef u64 trace_event_mask;	/* The event mask type */
+typedef struct _trace_change_mask {
+	trace_event_mask mask;	/* Event mask */
+} LTT_PACKED_STRUCT trace_change_mask;
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
+#endif				/* defined(CONFIG_TRACE) || defined(CONFIG_TRACE_MODULE) */
+
+#endif				/* _LINUX_TRACE_H */
diff -urN linux-2.5.33/kernel/trace.c linux-2.5.33-ltt/kernel/trace.c
--- linux-2.5.33/kernel/trace.c	Wed Dec 31 19:00:00 1969
+++ linux-2.5.33-ltt/kernel/trace.c	Fri Sep  6 16:03:01 2002
@@ -0,0 +1,631 @@
+/*
+ * linux/kernel/trace.c
+ *
+ * (C) Copyright 1999, 2000, 2001, 2002 - Karim Yaghmour (karym@opersys.com)
+ *
+ * This code is distributed under the GPL license
+ *
+ * Tracing management
+ *
+ */
+
+#include <linux/init.h>		/* For __init */
+#include <linux/trace.h>	/* Tracing definitions */
+#include <linux/errno.h>	/* Miscellaneous error codes */
+#include <linux/stddef.h>	/* NULL */
+#include <linux/slab.h>		/* kmalloc() */
+#include <linux/module.h>	/* EXPORT_SYMBOL */
+#include <linux/sched.h>	/* pid_t */
+
+/* Global variables */
+unsigned int syscall_entry_trace_active = 0;
+unsigned int syscall_exit_trace_active = 0;
+
+/* Local variables */
+static int tracer_registered = 0;   /* Is there a tracer registered */
+struct tracer *tracer = NULL;       /* The registered tracer */
+
+/* Registration lock. This lock avoids a race condition in case a tracer is
+removed while an event is being traced. */
+rwlock_t tracer_register_lock = RW_LOCK_UNLOCKED;
+
+/* Trace callback table entry */
+struct trace_callback_table_entry {
+	tracer_call callback;
+
+	struct trace_callback_table_entry *next;
+};
+
+/* Trace callback table */
+struct trace_callback_table_entry trace_callback_table[TRACE_EV_MAX];
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
+/*********************************************************************
+ * Register the tracer to the kernel
+ * Return values :
+ *   0, all is OK
+ *   -EBUSY, there already is a registered tracer
+ *   -ENOMEM, couldn't allocate memory
+ *********************************************************************/
+int register_tracer(tracer_call pm_trace_function)
+{
+	unsigned long l_flags;
+
+	if (tracer_registered == 1)
+		return -EBUSY;
+
+	/* Allocate memory for the tracer */
+	if ((tracer = (struct tracer *) kmalloc(sizeof(struct tracer), GFP_ATOMIC)) == NULL)
+		 return -ENOMEM;
+
+	/* Safely register the new tracer */
+	write_lock_irqsave(&tracer_register_lock, l_flags);
+	tracer_registered = 1;
+	tracer->trace = pm_trace_function;
+	write_unlock_irqrestore(&tracer_register_lock, l_flags);
+
+	/* Initialize the tracer settings */
+	tracer->fetch_syscall_eip_use_bounds = 0;
+	tracer->fetch_syscall_eip_use_depth = 0;
+
+	return 0;
+}
+
+/*********************************************************************
+ * Unregister the currently registered tracer
+ * Return values :
+ *   0, all is OK
+ *   -ENOMEDIUM, there isn't a registered tracer
+ *   -ENXIO, unregestering wrong tracer
+ *********************************************************************/
+int unregister_tracer(tracer_call pm_trace_function)
+{
+	unsigned long l_flags;
+
+	if (tracer_registered == 0)
+		return -ENOMEDIUM;
+
+	write_lock_irqsave(&tracer_register_lock, l_flags);
+
+	/* Is it the tracer that was registered */
+	if (tracer->trace == pm_trace_function)
+		/* There isn't any tracer in here */
+		tracer_registered = 0;
+	else {
+		write_unlock_irqrestore(&tracer_register_lock, l_flags);
+		return -ENXIO;
+	}
+
+	/* Free the memory used by the tracing structure */
+	kfree(tracer);
+	tracer = NULL;
+
+	write_unlock_irqrestore(&tracer_register_lock, l_flags);
+
+	return 0;
+}
+
+/*********************************************************************
+ * Set the tracing configuration
+ * Parameters :
+ *   pm_trace_function, the trace function.
+ *   pm_fetch_syscall_use_depth, Use depth to fetch eip
+ *   pm_fetch_syscall_use_bounds, Use bounds to fetch eip
+ *   pm_syscall_eip_depth, Detph to fetch eip
+ *   pm_syscall_lower_bound, Lower bound eip address
+ *   pm_syscall_upper_bound, Upper bound eip address
+ * Return values : 
+ *   0, all is OK 
+ *   -ENOMEDIUM, there isn't a registered tracer
+ *   -ENXIO, wrong tracer
+ *   -EINVAL, invalid configuration
+ *********************************************************************/
+int trace_set_config(tracer_call pm_trace_function,
+		     int pm_fetch_syscall_use_depth,
+		     int pm_fetch_syscall_use_bounds,
+		     int pm_syscall_eip_depth,
+		     void *pm_syscall_lower_bound,
+		     void *pm_syscall_upper_bound)
+{
+	if (tracer_registered == 0)
+		return -ENOMEDIUM;
+
+	/* Is this the tracer that is already registered */
+	if (tracer->trace != pm_trace_function)
+		return -ENXIO;
+
+	/* Is this a valid configuration */
+	if ((pm_fetch_syscall_use_depth && pm_fetch_syscall_use_bounds)
+	    || (pm_syscall_lower_bound > pm_syscall_upper_bound)
+	    || (pm_syscall_eip_depth < 0))
+		return -EINVAL;
+
+	/* Set the configuration */
+	tracer->fetch_syscall_eip_use_depth = pm_fetch_syscall_use_depth;
+	tracer->fetch_syscall_eip_use_bounds = pm_fetch_syscall_use_bounds;
+	tracer->syscall_eip_depth = pm_syscall_eip_depth;
+	tracer->syscall_lower_eip_bound = pm_syscall_lower_bound;
+	tracer->syscall_upper_eip_bound = pm_syscall_upper_bound;
+
+	return 0;
+}
+
+/*********************************************************************
+ * Get the tracing configuration
+ * Parameters :
+ *   pm_fetch_syscall_use_depth, Use depth to fetch eip
+ *   pm_fetch_syscall_use_bounds, Use bounds to fetch eip
+ *   pm_syscall_eip_depth, Detph to fetch eip
+ *   pm_syscall_lower_bound, Lower bound eip address
+ *   pm_syscall_upper_bound, Upper bound eip address
+ * Return values :
+ *   0, all is OK 
+ *   -ENOMEDIUM, there isn't a registered tracer
+ *********************************************************************/
+int trace_get_config(int *pm_fetch_syscall_use_depth,
+		     int *pm_fetch_syscall_use_bounds,
+		     int *pm_syscall_eip_depth,
+		     void **pm_syscall_lower_bound,
+		     void **pm_syscall_upper_bound)
+{
+	if (tracer_registered == 0)
+		return -ENOMEDIUM;
+
+	/* Get the configuration */
+	*pm_fetch_syscall_use_depth = tracer->fetch_syscall_eip_use_depth;
+	*pm_fetch_syscall_use_bounds = tracer->fetch_syscall_eip_use_bounds;
+	*pm_syscall_eip_depth = tracer->syscall_eip_depth;
+	*pm_syscall_lower_bound = tracer->syscall_lower_eip_bound;
+	*pm_syscall_upper_bound = tracer->syscall_upper_eip_bound;
+
+	return 0;
+}
+
+/*********************************************************************
+ * Register a callback function to be called on occurence
+ * of given event
+ * Parameters :
+ *   pm_trace_function, the callback function.
+ *   pm_event_id, the event ID to be monitored.
+ * Return values :
+ *   0, all is OK
+ *   -ENOMEM, unable to allocate memory for callback
+ *********************************************************************/
+int trace_register_callback(tracer_call pm_trace_function,
+			    u8 pm_event_id)
+{
+	struct trace_callback_table_entry *p_tct_entry;
+
+	/* Search for an empty entry in the callback table */
+	for (p_tct_entry = &(trace_callback_table[pm_event_id - 1]);
+	     p_tct_entry->next != NULL;
+	     p_tct_entry = p_tct_entry->next);
+
+	/* Allocate a new callback */
+	if ((p_tct_entry->next = kmalloc(sizeof(struct trace_callback_table_entry), GFP_ATOMIC)) == NULL)
+		 return -ENOMEM;
+
+	/* Setup the new callback */
+	p_tct_entry->next->callback = pm_trace_function;
+	p_tct_entry->next->next = NULL;
+
+	return 0;
+}
+
+/*********************************************************************
+ * UnRegister a callback function.
+ * Parameters :
+ *   pm_trace_function, the callback function.
+ *   pm_event_id, the event ID that had to be monitored.
+ * Return values :
+ *   0, all is OK
+ *   -ENOMEDIUM, no such callback resigtered
+ *********************************************************************/
+int trace_unregister_callback(tracer_call pm_trace_function,
+			      u8 pm_event_id)
+{
+	struct trace_callback_table_entry *p_tct_entry;
+	struct trace_callback_table_entry *p_temp_entry;
+
+	/* Search for the callback in the callback table */
+	for (p_tct_entry = &(trace_callback_table[pm_event_id - 1]);
+	     ((p_tct_entry->next != NULL) && (p_tct_entry->next->callback != pm_trace_function));
+	     p_tct_entry = p_tct_entry->next);
+
+	/* Did we find anything */
+	if (p_tct_entry == NULL)
+		return -ENOMEDIUM;
+
+	/* Free the callback entry we found */
+	p_temp_entry = p_tct_entry->next->next;
+	kfree(p_tct_entry->next);
+	p_tct_entry->next = p_temp_entry;
+
+	return 0;
+}
+
+/*********************************************************************
+ * Create a new traceable event type
+ * Parameters :
+ *   pm_event_type, string describing event type
+ *   pm_event_desc, string used for standard formatting
+ *   pm_format_type, type of formatting used to log event data
+ *   pm_format_data, data specific to format
+ *   pm_owner_pid, PID of event's owner (0 if none)
+ * Return values :
+ *   New Event ID if all is OK
+ *   -ENOMEM, Unable to allocate new event
+ *********************************************************************/
+int _trace_create_event(char *pm_event_type,
+			char *pm_event_desc,
+			int pm_format_type,
+			char *pm_format_data,
+			pid_t pm_owner_pid)
+{
+	struct custom_event_desc *p_new_event;
+
+	/* Create event */
+	if ((p_new_event = (struct custom_event_desc *) kmalloc(sizeof(struct custom_event_desc), GFP_ATOMIC)) == NULL)
+		 return -ENOMEM;
+
+	/* Initialize event properties */
+	p_new_event->event.type[0] = '\0';
+	p_new_event->event.desc[0] = '\0';
+	p_new_event->event.form[0] = '\0';
+
+	/* Set basic event properties */
+	if (pm_event_type != NULL)
+		strncpy(p_new_event->event.type, pm_event_type, CUSTOM_EVENT_TYPE_STR_LEN);
+	if (pm_event_desc != NULL)
+		strncpy(p_new_event->event.desc, pm_event_desc, CUSTOM_EVENT_DESC_STR_LEN);
+	if (pm_format_data != NULL)
+		strncpy(p_new_event->event.form, pm_format_data, CUSTOM_EVENT_FORM_STR_LEN);
+
+	/* Ensure that strings are bound */
+	p_new_event->event.type[CUSTOM_EVENT_TYPE_STR_LEN - 1] = '\0';
+	p_new_event->event.desc[CUSTOM_EVENT_DESC_STR_LEN - 1] = '\0';
+	p_new_event->event.form[CUSTOM_EVENT_FORM_STR_LEN - 1] = '\0';
+
+	/* Set format type */
+	p_new_event->event.format_type = pm_format_type;
+
+	/* Give the new event a unique event ID */
+	p_new_event->event.id = next_event_id;
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
+	return p_new_event->event.id;
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
+/*********************************************************************
+ * Destroy a created event type
+ * Parameters :
+ *   pm_event_id, the Id returned by trace_create_event()
+ * Return values :
+ *   NONE
+ *********************************************************************/
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
+/*********************************************************************
+ * Destroy an owner's events
+ * Parameters :
+ *   pm_owner_pid, the PID of the owner who's events are to be deleted.
+ * Return values :
+ *   NONE
+ *********************************************************************/
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
+/*********************************************************************
+ * Relog the declarations of custom events. This is necessary to make
+ * sure that even though the event creation might not have taken place
+ * during a previous trace, that all custom events be part of all traces.
+ * Hence, if a custom event occurs during a new trace, we can be sure
+ * that its definition will also be part of the trace.
+ * Parameters :
+ *    NONE
+ * Return values :
+ *    NONE
+ *********************************************************************/
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
+/*********************************************************************
+ * Trace a formatted event
+ * Parameters :
+ *   pm_event_id, the event Id provided upon creation
+ *   ..., printf-like data that will be used to fill the event string.
+ * Return values :
+ *   Trace fct return code if OK.
+ *   -ENOMEDIUM, there is no registered tracer or event doesn't exist.
+ *********************************************************************/
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
+/*********************************************************************
+ * Trace a raw event
+ * Parameters :
+ *   pm_event_id, the event Id provided upon creation
+ *   pm_event_size, the size of the data provided
+ *   pm_event_data, data buffer describing event
+ * Return values :
+ *   Trace fct return code if OK.
+ *   -ENOMEDIUM, there is no registered tracer or event doesn't exist.
+ *********************************************************************/
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
+/*********************************************************************
+ * Trace an event
+ * Parameters :
+ *   pm_event_id, the event's ID (check out trace.h)
+ *   pm_event_struct, the structure describing the event
+ * Return values :
+ *   Trace fct return code if OK.
+ *   -ENOMEDIUM, there is no registered tracer
+ *********************************************************************/
+int trace_event(u8 pm_event_id,
+		void *pm_event_struct)
+{
+	int l_ret_value;
+	struct trace_callback_table_entry *p_tct_entry;
+
+	read_lock(&tracer_register_lock);
+
+	/* Is there a tracer registered */
+	if (tracer_registered != 1)
+		l_ret_value = -ENOMEDIUM;
+	else
+		/* Call the tracer */
+		l_ret_value = tracer->trace(pm_event_id, pm_event_struct);
+
+	read_unlock(&tracer_register_lock);
+
+	/* Is this a native event */
+	if (pm_event_id <= TRACE_EV_MAX) {
+		/* Are there any callbacks to call */
+		if (trace_callback_table[pm_event_id - 1].next != NULL) {
+			/* Call all the callbacks linked to this event */
+			for (p_tct_entry = trace_callback_table[pm_event_id - 1].next;
+			     p_tct_entry != NULL;
+			     p_tct_entry = p_tct_entry->next)
+				p_tct_entry->callback(pm_event_id, pm_event_struct);
+		}
+	}
+	return l_ret_value;
+}
+
+/*********************************************************************
+ * Initialize trace facility
+ * Parameters :
+ *    NONE
+ * Return values :
+ *    0, if everything went ok.
+ *********************************************************************/
+static int __init trace_init(void)
+{
+	int i;
+
+	/* Initialize callback table */
+	for (i = 0; i < TRACE_EV_MAX; i++) {
+		trace_callback_table[i].callback = NULL;
+		trace_callback_table[i].next = NULL;
+	}
+
+	/* Initialize next event ID to be used */
+	next_event_id = TRACE_EV_MAX + 1;
+
+	/* Initialize custom events list */
+	custom_events = &custom_events_head;
+	custom_events->next = custom_events;
+	custom_events->prev = custom_events;
+
+	return 0;
+}
+
+module_init(trace_init);
+
+/* Export symbols so that can be visible from outside this file */
+EXPORT_SYMBOL(register_tracer);
+EXPORT_SYMBOL(unregister_tracer);
+EXPORT_SYMBOL(trace_set_config);
+EXPORT_SYMBOL(trace_get_config);
+EXPORT_SYMBOL(trace_register_callback);
+EXPORT_SYMBOL(trace_unregister_callback);
+EXPORT_SYMBOL(trace_create_event);
+EXPORT_SYMBOL(trace_create_owned_event);
+EXPORT_SYMBOL(trace_destroy_event);
+EXPORT_SYMBOL(trace_destroy_owners_events);
+EXPORT_SYMBOL(trace_reregister_custom_events);
+EXPORT_SYMBOL(trace_std_formatted_event);
+EXPORT_SYMBOL(trace_raw_event);
+EXPORT_SYMBOL(trace_event);
+
+EXPORT_SYMBOL(syscall_entry_trace_active);
+EXPORT_SYMBOL(syscall_exit_trace_active);
