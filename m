Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVANGLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVANGLd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 01:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261927AbVANGLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 01:11:32 -0500
Received: from opersys.com ([64.40.108.71]:59152 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261920AbVANGDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 01:03:36 -0500
Message-ID: <41E76279.5020507@opersys.com>
Date: Fri, 14 Jan 2005 01:11:05 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: [PATCH 2/8 ] ltt for 2.6.10 : core headers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


signed-off-by: Karim Yaghmour (karim@opersys.com)

--- linux-2.6.10-relayfs/include/linux/ltt-core.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/include/linux/ltt-core.h	2005-01-13 22:21:56.000000000 -0500
@@ -0,0 +1,430 @@
+/*
+ * linux/include/linux/ltt-core.h
+ *
+ * Copyright (C) 1999-2004 Karim Yaghmour (karim@opersys.com)
+ *
+ * This contains the core definitions for the Linux Trace Toolkit.
+ */
+
+#ifndef _LTT_CORE_H
+#define _LTT_CORE_H
+
+#include <linux/config.h>
+#include <linux/types.h>
+
+#include <linux/relayfs_fs.h>
+
+/* Is kernel tracing enabled */
+#if defined(CONFIG_LTT)
+
+#define LTT_CUSTOM_EV_MAX_SIZE		8192
+#define LTT_CUSTOM_EV_TYPE_STR_LEN	20
+#define LTT_CUSTOM_EV_DESC_STR_LEN	100
+#define LTT_CUSTOM_EV_FORM_STR_LEN	256
+#define LTT_CUSTOM_EV_FINAL_STR_LEN	200
+
+#define LTT_CUSTOM_EV_FORMAT_TYPE_NONE	0
+#define LTT_CUSTOM_EV_FORMAT_TYPE_STR	1
+#define LTT_CUSTOM_EV_FORMAT_TYPE_HEX	2
+#define LTT_CUSTOM_EV_FORMAT_TYPE_XML	3
+#define LTT_CUSTOM_EV_FORMAT_TYPE_IBM	4
+
+#define LTT_MAX_HANDLES			256
+
+/* In the ltt root directory lives the trace control file, used for
+   kernel-user communication. */
+#define LTT_RELAYFS_ROOT		"ltt"
+#define LTT_CONTROL_FILE		"control"
+
+/* We currently support 2 traces, normal trace and flight recorder */
+#define NR_TRACES			2
+#define TRACE_HANDLE			0
+#define FLIGHT_HANDLE			1
+
+/* System types */
+#define LTT_SYS_TYPE_VANILLA_LINUX	1
+
+/* Architecture types */
+#define LTT_ARCH_TYPE_I386			1
+#define LTT_ARCH_TYPE_PPC			2
+#define LTT_ARCH_TYPE_SH			3
+#define LTT_ARCH_TYPE_S390			4
+#define LTT_ARCH_TYPE_MIPS			5
+#define LTT_ARCH_TYPE_ARM			6
+
+/* Standard definitions for variants */
+#define LTT_ARCH_VARIANT_NONE             0   /* Main architecture implementation */
+
+typedef u64 ltt_event_mask;
+
+/* Per-CPU channel information */
+struct ltt_channel_data
+{
+	int channel_handle;
+	struct rchan_reader *reader;
+	atomic_t waiting_for_cpu_async;
+	u32 events_lost;
+};
+
+/* Per-trace status info */
+struct ltt_trace_info
+{
+	int			active;
+	unsigned int		trace_handle;
+	int			paused;
+	int			flight_recorder;
+	int			use_locking;
+	int			using_tsc;
+	u32			n_buffers;
+	u32			buf_size;
+	ltt_event_mask		traced_events;
+	ltt_event_mask		log_event_details_mask;
+	u32			buffers_produced[NR_CPUS];
+};
+
+/* Status info for all traces */
+struct ltt_tracer_status
+{
+	int num_cpus;
+	struct ltt_trace_info traces[NR_TRACES];
+};
+
+/* Per-trace information - each trace/flight recorder represented by one */
+struct ltt_trace_struct
+{
+	unsigned int		trace_handle;	/* For convenience */
+	struct ltt_trace_struct	*active;	/* 'this' if active, or NULL */
+	int			paused;		/* Not currently logging */
+	struct ltt_channel_data relay_data[NR_CPUS];/* Relayfs handles, by CPU */
+	int			flight_recorder;/* i.e. this is not a trace */
+	struct task_struct	*daemon_task_struct;/* Daemon associated with trace */
+	struct _ltt_trace_start	*trace_start_data; /* Trace start event data, for flight recorder */
+	int			tracer_started;
+	int			tracer_stopping;
+	struct proc_dir_entry	*proc_dir_entry;	/* proc/ltt/0..1 */
+	ltt_event_mask		traced_events;
+	ltt_event_mask		log_event_details_mask;
+	u32			n_buffers;	/* Number of sub-buffers */
+	u32			buf_size;	/* Size of sub-buffer */
+	int			use_locking;
+	int			using_tsc;
+	int			log_cpuid;
+	int			tracing_pid;
+	int			tracing_pgrp;
+	int			tracing_gid;
+	int			tracing_uid;
+	pid_t			traced_pid;
+	pid_t			traced_pgrp;
+	gid_t			traced_gid;
+	uid_t			traced_uid;
+	unsigned long		buffer_switches_pending;/* For trace */
+	struct work_struct	work;	/* stop work struct */
+};
+
+extern int ltt_set_trace_config(
+	int		do_syscall_depth,
+	int		do_syscall_bounds,
+	int		eip_depth,
+	void		*eip_lower_bound,
+	void		*eip_upper_bound);
+extern void ltt_set_flight_recorder_config(
+	struct ltt_trace_struct	*trace);
+extern int ltt_get_trace_config(
+	int		*do_syscall_depth,
+	int		*do_syscall_bounds,
+	int		*eip_depth,
+	void		**eip_lower_bound,
+	void		**eip_upper_bound);
+extern int ltt_get_status(
+	struct ltt_tracer_status	*tracer_status);
+extern int ltt_create_event(
+	char		*event_type,
+	char		*event_desc,
+	int		format_type,
+	char		*format_data);
+extern int ltt_create_owned_event(
+	char		*event_type,
+	char		*event_desc,
+	int		format_type,
+	char		*format_data,
+	pid_t		owner_pid);
+extern void ltt_destroy_event(
+	int		event_id);
+extern void ltt_destroy_owners_events(
+	pid_t		owner_pid);
+extern void ltt_reregister_custom_events(void);
+extern int ltt_log_std_formatted_event(
+	int		event_id,
+	...);
+extern int ltt_log_raw_event(
+	int		event_id,
+	int		event_size,
+	void		*event_data);
+extern int _ltt_log_event(
+	struct ltt_trace_struct	*trace,
+	u8			event_id,
+	void			*event_struct,
+	u8			cpu_id);
+extern int ltt_log_event(
+	u8		event_id,
+	void		*event_struct);
+extern int ltt_valid_trace_handle(
+	unsigned int	tracer_handle);
+extern int ltt_alloc_trace_handle(
+	unsigned int	tracer_handle);
+extern int ltt_free_trace_handle(
+	unsigned int	tracer_handle);
+extern int ltt_free_daemon_handle(
+	struct ltt_trace_struct *trace);
+extern void ltt_free_all_handles(
+	struct task_struct*	task_ptr);
+extern int ltt_set_buffer_size(
+	struct ltt_trace_struct	*trace,
+	int			buffers_size,
+	char			*dirname);
+extern int ltt_set_n_buffers(
+	struct ltt_trace_struct	*trace,
+	int			no_buffers);
+extern int ltt_set_default_config(
+	struct ltt_trace_struct	*trace);
+extern int ltt_syscall_active(
+	int syscall_type);
+extern void ltt_flight_pause(
+	void);
+extern void ltt_flight_unpause(
+	void);
+
+/* Tracer properties */
+#define LTT_TRACER_DEFAULT_BUF_SIZE   50000
+#define LTT_TRACER_MIN_BUF_SIZE        1000
+#define LTT_TRACER_MAX_BUF_SIZE      500000
+#define LTT_TRACER_MIN_BUFFERS            2
+#define LTT_TRACER_MAX_BUFFERS          256
+#define LTT_TRACER_MAGIC_NUMBER     0x00D6B7ED
+#define LTT_TRACER_VERSION_MAJOR    2
+#define LTT_TRACER_VERSION_MINOR    2
+
+#define LTT_TRACER_FIRST_EVENT_SIZE   (sizeof(u8) + sizeof(u32) + sizeof(ltt_buffer_start) + sizeof(uint16_t))
+#define LTT_TRACER_START_TRACE_EVENT_SIZE   (sizeof(u8) + sizeof(u32) + sizeof(ltt_trace_start) + sizeof(uint16_t))
+#define LTT_TRACER_LAST_EVENT_SIZE   (sizeof(u8) \
+				  + sizeof(u8) \
+				  + sizeof(u32) \
+				  + sizeof(ltt_buffer_end) \
+				  + sizeof(uint16_t) \
+				  + sizeof(u32))
+
+/* The configurations possible */
+enum {
+	LTT_TRACER_START = LTT_TRACER_MAGIC_NUMBER,	/* Start tracing events using the current configuration */
+	LTT_TRACER_STOP,				/* Stop tracing */
+	LTT_TRACER_CONFIG_DEFAULT,			/* Set the tracer to the default configuration */
+	LTT_TRACER_CONFIG_MEMORY_BUFFERS,		/* Set the memory buffers the daemon wants us to use */
+	LTT_TRACER_CONFIG_EVENTS,			/* Trace the given events */
+	LTT_TRACER_CONFIG_DETAILS,			/* Record the details of the event, or not */
+	LTT_TRACER_CONFIG_CPUID,			/* Record the CPUID associated with the event */
+	LTT_TRACER_CONFIG_PID,				/* Trace only one process */
+	LTT_TRACER_CONFIG_PGRP,				/* Trace only the given process group */
+	LTT_TRACER_CONFIG_GID,				/* Trace the processes of a given group of users */
+	LTT_TRACER_CONFIG_UID,				/* Trace the processes of a given user */
+	LTT_TRACER_CONFIG_SYSCALL_EIP_DEPTH,		/* Set the call depth at which the EIP should be fetched on syscall */
+	LTT_TRACER_CONFIG_SYSCALL_EIP_LOWER,		/* Set the lowerbound address from which EIP is recorded on syscall */
+	LTT_TRACER_CONFIG_SYSCALL_EIP_UPPER,		/* Set the upperbound address from which EIP is recorded on syscall */
+	LTT_TRACER_DATA_COMITTED,			/* The daemon has comitted the last trace */
+	LTT_TRACER_GET_EVENTS_LOST,			/* Get the number of events lost */
+	LTT_TRACER_CREATE_USER_EVENT,			/* Create a user tracable event */
+	LTT_TRACER_DESTROY_USER_EVENT,			/* Destroy a user tracable event */
+	LTT_TRACER_TRACE_USER_EVENT,			/* Trace a user event */
+	LTT_TRACER_SET_EVENT_MASK,			/* Set the trace event mask */
+	LTT_TRACER_GET_EVENT_MASK,			/* Get the trace event mask */
+	LTT_TRACER_GET_BUFFER_CONTROL,			/* Get the buffer control data for the lockless schem*/
+	LTT_TRACER_CONFIG_N_MEMORY_BUFFERS,		/* Set the number of memory buffers the daemon wants us to use */
+	LTT_TRACER_CONFIG_USE_LOCKING,			/* Set the locking scheme to use */
+	LTT_TRACER_CONFIG_TIMESTAMP,			/* Set the timestamping method to use */
+	LTT_TRACER_GET_ARCH_INFO,			/* Get information about the CPU configuration */
+	LTT_TRACER_ALLOC_HANDLE,			/* Allocate a tracer handle */
+	LTT_TRACER_FREE_HANDLE,				/* Free a single handle */
+	LTT_TRACER_FREE_DAEMON_HANDLE,			/* Free the daemon's handle */
+	LTT_TRACER_FREE_ALL_HANDLES,			/* Free all handles */
+	LTT_TRACER_MAP_BUFFER,				/* Map buffer to process-space */
+	LTT_TRACER_PAUSE,				/* Pause tracing */
+	LTT_TRACER_UNPAUSE,				/* Unpause tracing */
+	LTT_TRACER_GET_START_INFO,			/* trace start data */
+	LTT_TRACER_GET_STATUS				/* status of traces */
+};
+
+/* Lockless scheme definitions */
+#define LTT_TRACER_LOCKLESS_MIN_BUF_SIZE LTT_CUSTOM_EV_MAX_SIZE + 8192
+#define LTT_TRACER_LOCKLESS_MAX_BUF_SIZE 0x1000000
+
+/* Flags used for per-CPU tasks */
+#define LTT_NOTHING_TO_DO      0x00
+#define LTT_FINALIZE_TRACE     0x02
+#define LTT_TRACE_HEARTBEAT    0x08
+
+/* How often the LTT per-CPU timers fire */
+#define LTT_PERCPU_TIMER_FREQ  (HZ/10);
+
+/* Convenience accessors */
+#define waiting_for_cpu_async(trace_handle, cpu) (current_traces[trace_handle].relay_data[cpu].waiting_for_cpu_async)
+#define trace_channel_handle(trace_handle, cpu) (current_traces[trace_handle].relay_data[cpu].channel_handle)
+#define trace_channel_reader(trace_handle, cpu) (current_traces[trace_handle].relay_data[cpu].reader)
+#define trace_buffers_full(cpu) (daemon_relay_data[cpu].buffers_full)
+#define events_lost(trace_handle, cpu) (current_traces[trace_handle].relay_data[cpu].events_lost)
+
+/* Used for sharing per-buffer information between driver and daemon */
+struct ltt_buf_control_info
+{
+	s16 cpu_id;
+	u32 buffer_switches_pending;
+	u32 buffer_control_valid;
+
+	u32 buf_size;
+	u32 n_buffers;
+	u32 cur_idx;
+	u32 buffers_produced;
+	u32 buffers_consumed;
+	int buffer_complete[LTT_TRACER_MAX_BUFFERS];
+};
+
+/* Used for sharing buffer-commit information between driver and daemon */
+struct ltt_buffers_committed
+{
+	u8 cpu_id;
+	u32 buffers_consumed;
+};
+
+/* Used for specifying size/cpu id pair between driver and daemon */
+struct ltt_cpu_mmap_data
+{
+	u8 cpu_id;
+	unsigned long map_size;
+};
+
+/* Used for sharing architecture-specific info between driver and daemon */
+struct ltt_arch_info
+{
+	int n_cpus;
+	int page_shift;
+};
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
+#if !defined(CONFIG_X86)
+# define cpu_has_tsc 0 /* FIXME: cpu_has_tsc isn't set except on x86 */
+#endif
+
+/**
+ *	switch_time_delta: - Utility function getting buffer switch time delta.
+ *	@time_delta: previously calculated or retrieved time delta
+ *
+ *	Returns the time_delta passed in if we're using TSC or 0 otherwise.
+ */
+static inline u32 switch_time_delta(u32 time_delta,
+				    int using_tsc)
+{
+	if((using_tsc == 1) && cpu_has_tsc)
+		return time_delta;
+	else
+		return 0;
+}
+
+#else /* defined(CONFIG_LTT) */
+static inline int ltt_create_event(char	*event_type,
+		    char	*event_desc,
+		    int		format_type,
+		    char	*format_data)
+{
+	return 0;
+}
+
+static inline int ltt_create_owned_event(char		*event_type,
+			   char		*event_desc,
+			   int		format_type,
+			   char		*format_data,
+			   pid_t	owner_pid)
+{
+	return 0;
+}
+
+static inline void ltt_destroy_event(int event_id)
+{
+}
+
+static inline void ltt_destroy_owners_events(pid_t owner_pid)
+{
+}
+
+static inline void ltt_reregister_custom_events(void)
+{
+}
+
+static inline int ltt_log_std_formatted_event(int event_id, ...)
+{
+	return 0;
+}
+
+
+static inline  int ltt_log_raw_event(int	event_id,
+				     int	event_size,
+				     void	*event_data)
+{
+	return 0;
+}
+
+static inline  int _ltt_log_event(u8	event_id,
+				  void	*event_struct,
+				  u8	cpu_id)
+{
+	return 0;
+}
+
+static inline int ltt_log_event(u8	event_id,
+				void	*event_struct)
+{
+	return 0;
+}
+
+static inline void ltt_flight_pause(void)
+{
+}
+
+static inline void ltt_flight_unpause(void)
+{
+}
+
+#endif /* defined(CONFIG_LTT) */
+#endif /* _LTT_CORE_H */
--- linux-2.6.10-relayfs/include/linux/ltt-events.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/include/linux/ltt-events.h	2005-01-13 22:21:56.000000000 -0500
@@ -0,0 +1,424 @@
+/*
+ * linux/include/linux/ltt-events.h
+ *
+ * Copyright (C) 1999-2004 Karim Yaghmour (karim@opersys.com)
+ *
+ * This contains the event definitions for the Linux Trace Toolkit.
+ */
+
+#ifndef _LTT_EVENTS_H
+#define _LTT_EVENTS_H
+
+#include <linux/ltt-core.h>
+#include <linux/sched.h>
+
+/* Is kernel tracing enabled */
+#if defined(CONFIG_LTT)
+
+/* Don't set this to "1" unless you really know what you're doing */
+#define LTT_UNPACKED_STRUCTS	0
+
+/* Structure packing within the trace */
+#if LTT_UNPACKED_STRUCTS
+#define LTT_PACKED_STRUCT
+#else
+#define LTT_PACKED_STRUCT __attribute__ ((packed))
+#endif
+
+extern unsigned int ltt_syscall_entry_trace_active;
+extern unsigned int ltt_syscall_exit_trace_active;
+
+static inline void ltt_ev(u8 event_id, void* data)
+{
+	ltt_log_event(event_id, data);
+}
+
+/* Traced events */
+enum {
+	LTT_EV_START = 0,	/* This is to mark the trace's start */
+	LTT_EV_SYSCALL_ENTRY,	/* Entry in a given system call */
+	LTT_EV_SYSCALL_EXIT,	/* Exit from a given system call */
+	LTT_EV_TRAP_ENTRY,	/* Entry in a trap */
+	LTT_EV_TRAP_EXIT,	/* Exit from a trap */
+	LTT_EV_IRQ_ENTRY,	/* Entry in an irq */
+	LTT_EV_IRQ_EXIT,	/* Exit from an irq */
+	LTT_EV_SCHEDCHANGE,	/* Scheduling change */
+	LTT_EV_KERNEL_TIMER,	/* The kernel timer routine has been called */
+	LTT_EV_SOFT_IRQ,	/* Hit key part of soft-irq management */
+	LTT_EV_PROCESS,	/* Hit key part of process management */
+	LTT_EV_FILE_SYSTEM,	/* Hit key part of file system */
+	LTT_EV_TIMER,		/* Hit key part of timer management */
+	LTT_EV_MEMORY,	/* Hit key part of memory management */
+	LTT_EV_SOCKET,	/* Hit key part of socket communication */
+	LTT_EV_IPC,		/* Hit key part of System V IPC */
+	LTT_EV_NETWORK,	/* Hit key part of network communication */
+	LTT_EV_BUFFER_START,	/* Mark the begining of a trace buffer */
+	LTT_EV_BUFFER_END,	/* Mark the ending of a trace buffer */
+	LTT_EV_NEW_EVENT,	/* New event type */
+	LTT_EV_CUSTOM,	/* Custom event */
+	LTT_EV_CHANGE_MASK,	/* Change in event mask */
+	LTT_EV_HEARTBEAT	/* Heartbeat event */
+};
+
+/* Number of traced events */
+#define LTT_EV_MAX           LTT_EV_HEARTBEAT
+
+/* Information logged when a trace is started */
+typedef struct _ltt_trace_start {
+	u32 magic_number;
+	u32 arch_type;
+	u32 arch_variant;
+	u32 system_type;
+	u8 major_version;
+	u8 minor_version;
+
+	u32 buffer_size;
+	ltt_event_mask event_mask;
+	ltt_event_mask details_mask;
+	u8 log_cpuid;
+	u8 use_tsc;
+	u8 flight_recorder;
+} LTT_PACKED_STRUCT ltt_trace_start;
+
+/*  LTT_SYSCALL_ENTRY */
+typedef struct _ltt_syscall_entry {
+	u8 syscall_id;		/* Syscall entry number in entry.S */
+	u32 address;		/* Address from which call was made */
+} LTT_PACKED_STRUCT ltt_syscall_entry;
+
+/*  LTT_TRAP_ENTRY */
+#ifndef __s390__
+typedef struct _ltt_trap_entry {
+	u16 trap_id;		/* Trap number */
+	u32 address;		/* Address where trap occured */
+} LTT_PACKED_STRUCT ltt_trap_entry;
+static inline void ltt_ev_trap_entry(u16 trap_id, u32 address)
+#else
+typedef u64 trapid_t;
+typedef struct _ltt_trap_entry {
+	trapid_t trap_id;	/* Trap number */
+	u32 address;		/* Address where trap occured */
+} LTT_PACKED_STRUCT ltt_trap_entry;
+static inline void ltt_ev_trap_entry(trapid_t trap_id, u32 address)
+#endif
+{
+	ltt_trap_entry trap_event;
+
+	trap_event.trap_id = trap_id;
+	trap_event.address = address;
+
+	ltt_log_event(LTT_EV_TRAP_ENTRY, &trap_event);
+}
+
+/*  LTT_TRAP_EXIT */
+static inline void ltt_ev_trap_exit(void)
+{
+	ltt_log_event(LTT_EV_TRAP_EXIT, NULL);
+}
+
+/*  LTT_IRQ_ENTRY */
+typedef struct _ltt_irq_entry {
+	u8 irq_id;		/* IRQ number */
+	u8 kernel;		/* Are we executing kernel code */
+} LTT_PACKED_STRUCT ltt_irq_entry;
+static inline void ltt_ev_irq_entry(u8 irq_id, u8 in_kernel)
+{
+	ltt_irq_entry irq_entry;
+
+	irq_entry.irq_id = irq_id;
+	irq_entry.kernel = in_kernel;
+
+	ltt_log_event(LTT_EV_IRQ_ENTRY, &irq_entry);
+}
+
+/*  LTT_IRQ_EXIT */
+static inline void ltt_ev_irq_exit(void)
+{
+	ltt_log_event(LTT_EV_IRQ_EXIT, NULL);
+}
+
+/*  LTT_SCHEDCHANGE */
+typedef struct _ltt_schedchange {
+	u32 out;		/* Outgoing process */
+	u32 in;			/* Incoming process */
+	u32 out_state;		/* Outgoing process' state */
+} LTT_PACKED_STRUCT ltt_schedchange;
+static inline void ltt_ev_schedchange(task_t * task_out, task_t * task_in)
+{
+	ltt_schedchange sched_event;
+
+	sched_event.out = (u32) task_out->pid;
+	sched_event.in = (u32) task_in;
+	sched_event.out_state = (u32) task_out->state;
+
+	ltt_log_event(LTT_EV_SCHEDCHANGE, &sched_event);
+}
+
+/*  LTT_SOFT_IRQ */
+enum {
+	LTT_EV_SOFT_IRQ_BOTTOM_HALF = 1,	/* Conventional bottom-half */
+	LTT_EV_SOFT_IRQ_SOFT_IRQ,		/* Real soft-irq */
+	LTT_EV_SOFT_IRQ_TASKLET_ACTION,		/* Tasklet action */
+	LTT_EV_SOFT_IRQ_TASKLET_HI_ACTION	/* Tasklet hi-action */
+};
+typedef struct _ltt_soft_irq {
+	u8 event_sub_id;	/* Soft-irq event Id */
+	u32 event_data;
+} LTT_PACKED_STRUCT ltt_soft_irq;
+static inline void ltt_ev_soft_irq(u8 ev_id, u32 data)
+{
+	ltt_soft_irq soft_irq_event;
+
+	soft_irq_event.event_sub_id = ev_id;
+	soft_irq_event.event_data = data;
+
+	ltt_log_event(LTT_EV_SOFT_IRQ, &soft_irq_event);
+}
+
+/*  LTT_PROCESS */
+enum {
+	LTT_EV_PROCESS_KTHREAD = 1,	/* Creation of a kernel thread */
+	LTT_EV_PROCESS_FORK,		/* A fork or clone occured */
+	LTT_EV_PROCESS_EXIT,		/* An exit occured */
+	LTT_EV_PROCESS_WAIT,		/* A wait occured */
+	LTT_EV_PROCESS_SIGNAL,		/* A signal has been sent */
+	LTT_EV_PROCESS_WAKEUP		/* Wake up a process */
+};
+typedef struct _ltt_process {
+	u8 event_sub_id;	/* Process event ID */
+	u32 event_data1;
+	u32 event_data2;
+} LTT_PACKED_STRUCT ltt_process;
+static inline void ltt_ev_process(u8 ev_id, u32 data1, u32 data2)
+{
+	ltt_process proc_event;
+
+	proc_event.event_sub_id = ev_id;
+	proc_event.event_data1 = data1;
+	proc_event.event_data2 = data2;
+
+	ltt_log_event(LTT_EV_PROCESS, &proc_event);
+}
+static inline void ltt_ev_process_exit(u32 data1, u32 data2)
+{
+	ltt_process proc_event;
+
+	proc_event.event_sub_id = LTT_EV_PROCESS_EXIT;
+
+	/**** WARNING ****/
+	/* Regardless of whether this trace statement is active or not, these
+	two function must be called, otherwise there will be inconsistencies
+	in the kernel's structures. */
+	ltt_destroy_owners_events(current->pid);
+	ltt_free_all_handles(current);
+
+	ltt_log_event(LTT_EV_PROCESS, &proc_event);
+}
+
+/*  LTT_FILE_SYSTEM */
+enum {
+	LTT_EV_FILE_SYSTEM_BUF_WAIT_START = 1,	/* Starting to wait for a data buffer */
+	LTT_EV_FILE_SYSTEM_BUF_WAIT_END,	/* End to wait for a data buffer */
+	LTT_EV_FILE_SYSTEM_EXEC,		/* An exec occured */
+	LTT_EV_FILE_SYSTEM_OPEN,		/* An open occured */
+	LTT_EV_FILE_SYSTEM_CLOSE,		/* A close occured */
+	LTT_EV_FILE_SYSTEM_READ,		/* A read occured */
+	LTT_EV_FILE_SYSTEM_WRITE,		/* A write occured */
+	LTT_EV_FILE_SYSTEM_SEEK,		/* A seek occured */
+	LTT_EV_FILE_SYSTEM_IOCTL,		/* An ioctl occured */
+	LTT_EV_FILE_SYSTEM_SELECT,		/* A select occured */
+	LTT_EV_FILE_SYSTEM_POLL			/* A poll occured */
+};
+typedef struct _ltt_file_system {
+	u8 event_sub_id;	/* File system event ID */
+	u32 event_data1;
+	u32 event_data2;
+	char *file_name;	/* Name of file operated on */
+} LTT_PACKED_STRUCT ltt_file_system;
+static inline void ltt_ev_file_system(u8 ev_id, u32 data1, u32 data2, const unsigned char *file_name)
+{
+	ltt_file_system fs_event;
+
+	fs_event.event_sub_id = ev_id;
+	fs_event.event_data1 = data1;
+	fs_event.event_data2 = data2;
+	fs_event.file_name = (char*) file_name;
+
+	ltt_log_event(LTT_EV_FILE_SYSTEM, &fs_event);
+}
+
+/*  LTT_TIMER */
+enum {
+	LTT_EV_TIMER_EXPIRED = 1,	/* Timer expired */
+	LTT_EV_TIMER_SETITIMER,		/* Setting itimer occurred */
+	LTT_EV_TIMER_SETTIMEOUT		/* Setting sched timeout occurred */
+};
+typedef struct _ltt_timer {
+	u8 event_sub_id;	/* Timer event ID */
+	u8 event_sdata;		/* Short data */
+	u32 event_data1;
+	u32 event_data2;
+} LTT_PACKED_STRUCT ltt_timer;
+static inline void ltt_ev_timer(u8 ev_id, u8 sdata, u32 data1, u32 data2)
+{
+	ltt_timer timer_event;
+
+	timer_event.event_sub_id = ev_id;
+	timer_event.event_sdata = sdata;
+	timer_event.event_data1 = data1;
+	timer_event.event_data2 = data2;
+
+	ltt_log_event(LTT_EV_TIMER, &timer_event);
+}
+
+/*  LTT_MEMORY */
+enum {
+	LTT_EV_MEMORY_PAGE_ALLOC = 1,	/* Allocating pages */
+	LTT_EV_MEMORY_PAGE_FREE,	/* Freing pages */
+	LTT_EV_MEMORY_SWAP_IN,		/* Swaping pages in */
+	LTT_EV_MEMORY_SWAP_OUT,		/* Swaping pages out */
+	LTT_EV_MEMORY_PAGE_WAIT_START,	/* Start to wait for page */
+	LTT_EV_MEMORY_PAGE_WAIT_END	/* End to wait for page */
+};
+typedef struct _ltt_memory {
+	u8 event_sub_id;	/* Memory event ID */
+	u32 event_data;
+} LTT_PACKED_STRUCT ltt_memory;
+static inline void ltt_ev_memory(u8 ev_id, u32 data)
+{
+	ltt_memory memory_event;
+
+	memory_event.event_sub_id = ev_id;
+	memory_event.event_data = data;
+
+	ltt_log_event(LTT_EV_MEMORY, &memory_event);
+}
+
+/*  LTT_SOCKET */
+enum {
+	LTT_EV_SOCKET_CALL = 1,	/* A socket call occured */
+	LTT_EV_SOCKET_CREATE,	/* A socket has been created */
+	LTT_EV_SOCKET_SEND,	/* Data was sent to a socket */
+	LTT_EV_SOCKET_RECEIVE	/* Data was read from a socket */
+};
+typedef struct _ltt_socket {
+	u8 event_sub_id;	/* Socket event ID */
+	u32 event_data1;
+	u32 event_data2;
+} LTT_PACKED_STRUCT ltt_socket;
+static inline void ltt_ev_socket(u8 ev_id, u32 data1, u32 data2)
+{
+	ltt_socket socket_event;
+
+	socket_event.event_sub_id = ev_id;
+	socket_event.event_data1 = data1;
+	socket_event.event_data2 = data2;
+
+	ltt_log_event(LTT_EV_SOCKET, &socket_event);
+}
+
+/*  LTT_IPC */
+enum {
+	LTT_EV_IPC_CALL = 1,	/* A System V IPC call occured */
+	LTT_EV_IPC_MSG_CREATE,	/* A message queue has been created */
+	LTT_EV_IPC_SEM_CREATE,	/* A semaphore was created */
+	LTT_EV_IPC_SHM_CREATE	/* A shared memory segment has been created */
+};
+typedef struct _ltt_ipc {
+	u8 event_sub_id;	/* IPC event ID */
+	u32 event_data1;
+	u32 event_data2;
+} LTT_PACKED_STRUCT ltt_ipc;
+static inline void ltt_ev_ipc(u8 ev_id, u32 data1, u32 data2)
+{
+	ltt_ipc ipc_event;
+
+	ipc_event.event_sub_id = ev_id;
+	ipc_event.event_data1 = data1;
+	ipc_event.event_data2 = data2;
+
+	ltt_log_event(LTT_EV_IPC, &ipc_event);
+}
+
+/*  LTT_NETWORK */
+enum {
+	LTT_EV_NETWORK_PACKET_IN = 1,	/* A packet came in */
+	LTT_EV_NETWORK_PACKET_OUT	/* A packet was sent */
+};
+typedef struct _ltt_network {
+	u8 event_sub_id;	/* Network event ID */
+	u32 event_data;
+} LTT_PACKED_STRUCT ltt_network;
+static inline void ltt_ev_network(u8 ev_id, u32 data)
+{
+	ltt_network net_event;
+
+	net_event.event_sub_id = ev_id;
+	net_event.event_data = data;
+
+	ltt_log_event(LTT_EV_NETWORK, &net_event);
+}
+
+/* Start of trace buffer information */
+typedef struct _ltt_buffer_start {
+	struct timeval time;	/* Time stamp of this buffer */
+	u32 tsc;   		/* TSC of this buffer, if applicable */
+	u32 id;			/* Unique buffer ID */
+} LTT_PACKED_STRUCT ltt_buffer_start;
+
+/* End of trace buffer information */
+typedef struct _ltt_buffer_end {
+	struct timeval time;	/* Time stamp of this buffer */
+	u32 tsc;   		/* TSC of this buffer, if applicable */
+} LTT_PACKED_STRUCT ltt_buffer_end;
+
+/* Custom declared events */
+/* ***WARNING*** These structures should never be used as is, use the
+   provided custom event creation and logging functions. */
+typedef struct _ltt_new_event {
+	/* Basics */
+	u32 id;					/* Custom event ID */
+	char type[LTT_CUSTOM_EV_TYPE_STR_LEN];	/* Event type description */
+	char desc[LTT_CUSTOM_EV_DESC_STR_LEN];	/* Detailed event description */
+
+	/* Custom formatting */
+	u32 format_type;			/* Type of formatting */
+	char form[LTT_CUSTOM_EV_FORM_STR_LEN];	/* Data specific to format */
+} LTT_PACKED_STRUCT ltt_new_event;
+typedef struct _ltt_custom {
+	u32 id;			/* Event ID */
+	u32 data_size;		/* Size of data recorded by event */
+	void *data;		/* Data recorded by event */
+} LTT_PACKED_STRUCT ltt_custom;
+
+/* LTT_CHANGE_MASK */
+typedef struct _ltt_change_mask {
+	ltt_event_mask mask;	/* Event mask */
+} LTT_PACKED_STRUCT ltt_change_mask;
+
+
+/*  LTT_HEARTBEAT */
+static inline void ltt_ev_heartbeat(void)
+{
+	ltt_log_event(LTT_EV_HEARTBEAT, NULL);
+}
+
+#else /* defined(CONFIG_LTT) */
+#define ltt_ev(ID, DATA)
+#define ltt_ev_trap_entry(ID, EIP)
+#define ltt_ev_trap_exit()
+#define ltt_ev_irq_entry(ID, KERNEL)
+#define ltt_ev_irq_exit()
+#define ltt_ev_schedchange(OUT, IN)
+#define ltt_ev_soft_irq(ID, DATA)
+#define ltt_ev_process(ID, DATA1, DATA2)
+#define ltt_ev_process_exit(DATA1, DATA2)
+#define ltt_ev_file_system(ID, DATA1, DATA2, FILE_NAME)
+#define ltt_ev_timer(ID, SDATA, DATA1, DATA2)
+#define ltt_ev_memory(ID, DATA)
+#define ltt_ev_socket(ID, DATA1, DATA2)
+#define ltt_ev_ipc(ID, DATA1, DATA2)
+#define ltt_ev_network(ID, DATA)
+#define ltt_ev_heartbeat()
+#endif /* defined(CONFIG_LTT) */
+#endif /* _LTT_EVENTS_H */
--- linux-2.6.10-relayfs/init/Kconfig	2004-12-24 16:35:24.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/init/Kconfig	2005-01-13 22:21:56.000000000 -0500
@@ -315,6 +315,38 @@ config CC_OPTIMIZE_FOR_SIZE

 	  If unsure, say N.

+config LTT
+	bool "Linux Trace Toolkit support"
+	depends on RELAYFS_FS=y
+	default n
+	---help---
+	  It is possible for the kernel to log important events to a trace
+	  facility. Doing so, enables the use of the generated traces in order
+	  to reconstruct the dynamic behavior of the kernel, and hence the
+	  whole system.
+
+	  The tracing process contains 4 parts :
+	      1) The logging of events by key parts of the kernel.
+	      2) The tracer that keeps the events in a data buffer (uses
+	         relayfs).
+	      3) A trace daemon that interacts with the tracer and is
+	         notified every time there is a certain quantity of data to
+	         read from the tracer.
+	      4) A trace event data decoder that reads the accumulated data
+	         and formats it in a human-readable format.
+
+	  If you say Y, the first two components will be built into the kernel.
+	  Critical parts of the kernel will call upon the kernel tracing
+	  function. The data is then recorded by the tracer if a trace daemon
+	  is running in user-space and has issued a "start" command.
+
+	  In order to enable LTT support you must first select relayfs as
+	  built-in.
+
+	  For more information on kernel tracing, the trace daemon or the event
+	  decoder, please check the following address :
+	       http://www.opersys.com/ltt
+
 config SHMEM
 	default y
 	bool "Use full shmem filesystem" if EMBEDDED && MMU
--- linux-2.6.10-relayfs/kernel/Makefile	2004-12-24 16:34:26.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/kernel/Makefile	2005-01-13 22:21:56.000000000 -0500
@@ -17,6 +17,7 @@ obj-$(CONFIG_MODULES) += module.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PM) += power/
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
+obj-$(CONFIG_LTT) += ltt-core.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
 obj-$(CONFIG_IKCONFIG_PROC) += configs.o
--- linux-2.6.10-relayfs/MAINTAINERS	2004-12-24 16:35:00.000000000 -0500
+++ linux-2.6.10-relayfs-ltt/MAINTAINERS	2005-01-13 22:21:56.000000000 -0500
@@ -1363,6 +1363,13 @@ L:	linux-security-module@wirex.com
 W:	http://lsm.immunix.org
 S:	Supported

+LINUX TRACE TOOLKIT
+P:	Karim Yaghmour
+M:	karim@opersys.com
+W:	http://www.opersys.com/LTT
+L:	ltt-dev@listserv.shafik.org
+S:	Maintained
+
 LM83 HARDWARE MONITOR DRIVER
 P:	Jean Delvare
 M:	khali@linux-fr.org


