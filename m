Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932906AbWJIOPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906AbWJIOPW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932901AbWJIOOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:14:52 -0400
Received: from gundega.hpl.hp.com ([192.6.19.190]:61695 "EHLO
	gundega.hpl.hp.com") by vger.kernel.org with ESMTP id S932906AbWJIOLd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:11:33 -0400
Date: Mon, 9 Oct 2006 07:10:20 -0700
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200610091410.k99EAKaW026168@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] 2.6.18 perfmon2 : common core functions
Cc: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@frankl.hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch the core of perfmon2.

The core consists of:
	- back-end to most system calls
	- notification message queue management
	- sampling buffer allocation
	- support functions for sampling
	- context allocation and destruction
	- user level notification
	- perfmon2 initialization
	- permission checking





--- linux-2.6.18.base/include/linux/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/linux/perfmon.h	2006-09-25 12:15:51.000000000 -0700
@@ -0,0 +1,745 @@
+/*
+ * Copyright (c) 2001-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+
+#ifndef __LINUX_PERFMON_H__
+#define __LINUX_PERFMON_H__
+
+#ifdef CONFIG_PERFMON
+
+/*
+ * user interface definitions
+ *
+ * Do not use directly for applications, use libpfm/libc provided
+ * header file instead.
+ */
+
+#define PFM_MAX_HW_PMCS		256
+#define PFM_MAX_HW_PMDS		256
+#define PFM_MAX_XTRA_PMCS	64
+#define PFM_MAX_XTRA_PMDS	64
+
+#define PFM_MAX_PMCS	(PFM_MAX_HW_PMCS+PFM_MAX_XTRA_PMCS)
+#define PFM_MAX_PMDS	(PFM_MAX_HW_PMDS+PFM_MAX_XTRA_PMDS)
+
+/*
+ * number of elements for each type of bitvector
+ * all bitvectors use u64 fixed size type on all architectures.
+ */
+#define PFM_BVSIZE(x)	(((x)+(sizeof(u64)<<3)-1) / (sizeof(u64)<<3))
+#define PFM_HW_PMD_BV	PFM_BVSIZE(PFM_MAX_HW_PMDS)
+#define PFM_PMD_BV	PFM_BVSIZE(PFM_MAX_PMDS)
+#define PFM_PMC_BV	PFM_BVSIZE(PFM_MAX_PMCS)
+
+/*
+ * custom sampling buffer identifier type
+ */
+typedef __u8 pfm_uuid_t[16];
+
+/*
+ * PMC/PMD flags to use with pfm_write_pmds() or pfm_write_pmcs()
+ *
+ * reg_flags layout:
+ * bit 00-15 : generic flags
+ * bit 16-23 : arch-specific flags
+ * bit 24-31 : error codes
+ */
+#define PFM_REGFL_OVFL_NOTIFY	0x1	/* PMD: send notification on overflow */
+#define PFM_REGFL_RANDOM	0x2	/* PMD: randomize sampling interval   */
+#define PFM_REGFL_NO_EMUL64	0x4	/* PMC: no 64-bit emulation for counter */
+
+/*
+ * event set flags layout:
+ * bit 00-15 : generic flags
+ * bit 16-31 : arch-specific flags
+ */
+#define PFM_SETFL_OVFL_SWITCH	0x01 /* enable switch on overflow */
+#define PFM_SETFL_TIME_SWITCH	0x02 /* switch set on timeout */
+#define PFM_SETFL_EXPL_NEXT	0x04 /* use set_id_next as the next set */
+
+/*
+ * PMD/PMC return flags in case of error (ignored on input)
+ *
+ * reg_flags layout:
+ * bit 00-15 : generic flags
+ * bit 16-23 : arch-specific flags
+ * bit 24-31 : error codes
+ *
+ * Those flags are used on output and must be checked in case EINVAL is
+ * returned by a command accepting a vector of values and each has a flag
+ * field, such as pfarg_pmc or pfarg_pmd.
+ */
+#define PFM_REG_RETFL_NOTAVAIL	(1<<31) /* implemented but not available */
+#define PFM_REG_RETFL_EINVAL	(1<<30) /* entry is invalid */
+#define PFM_REG_RETFL_NOSET	(1<<29) /* event set does not exist */
+#define PFM_REG_RETFL_MASK	(PFM_REG_RETFL_NOTAVAIL|\
+				 PFM_REG_RETFL_EINVAL|\
+				 PFM_REG_RETFL_NOSET)
+
+#define PFM_REG_HAS_ERROR(flag)	(((flag) & PFM_REG_RETFL_MASK) != 0)
+
+typedef __u32 __bitwise pfm_flags_t;
+/*
+ * Request structure used to define a context
+ */
+struct pfarg_ctx {
+	pfm_uuid_t	ctx_smpl_buf_id;   /* which buffer format to use */
+	pfm_flags_t	ctx_flags;	   /* noblock/block/syswide */
+	__s32		ctx_fd;		   /* ret arg: fd for context */
+	__u64		ctx_smpl_buf_size; /* ret arg: actual buffer size */
+	__u64		ctx_reserved3[12]; /* for future use */
+};
+/*
+ * context flags (ctx_flags)
+ *
+ */
+#define PFM_FL_NOTIFY_BLOCK    	 0x01	/* block task on user notifications */
+#define PFM_FL_SYSTEM_WIDE	 0x02	/* create a system wide context */
+#define PFM_FL_OVFL_NO_MSG	 0x80   /* no overflow msgs */
+#define PFM_FL_MAP_SETS		 0x10	/* event sets are remapped */
+
+
+/*
+ * argument structure for pfm_write_pmcs()
+ */
+struct pfarg_pmc {
+	__u16 reg_num;		/* which register */
+	__u16 reg_set;		/* event set for this register */
+	pfm_flags_t reg_flags;	/* input: flags, return: reg error */
+	__u64 reg_value;	/* pmc value */
+	__u64 reg_reserved2[4];	/* for future use */
+};
+
+/*
+ * argument structure for pfm_write_pmds() and pfm_read_pmds()
+ */
+struct pfarg_pmd {
+	__u16 reg_num;	   	/* which register */
+	__u16 reg_set;	   	/* event set for this register */
+	pfm_flags_t reg_flags; 	/* input: flags, return: reg error */
+	__u64 reg_value;	/* initial pmc/pmd value */
+	__u64 reg_long_reset;	/* value to reload after notification */
+	__u64 reg_short_reset;  /* reset after counter overflow */
+	__u64 reg_last_reset_val;	/* return: PMD last reset value */
+	__u64 reg_ovfl_switch_cnt;	/* #overflows before switch */
+	__u64 reg_reset_pmds[PFM_PMD_BV]; /* reset on overflow */
+	__u64 reg_smpl_pmds[PFM_PMD_BV];  /* record in sample */
+	__u64 reg_smpl_eventid; /* opaque event identifier */
+	__u64 reg_random_mask; 	/* bitmask used to limit random value */
+	__u32 reg_random_seed;  /* seed for randomization */
+	__u32 reg_reserved2[7];	/* for future use */
+};
+
+/*
+ * optional argument to pfm_start(), pass NULL if no arg needed
+ */
+struct pfarg_start {
+	__u16 start_set;	/* event set to start with */
+	__u16 start_reserved1;	/* for future use */
+	__u32 start_reserved2;	/* for future use */
+	__u64 reserved3[3];	/* for future use */
+};
+
+/*
+ * argument to pfm_load_context()
+ */
+struct pfarg_load {
+	__u32	load_pid;	   /* thread to attach to */
+	__u16	load_set;	   /* set to load first */
+	__u16	load_reserved1;	   /* for future use */
+	__u64	load_reserved2[3]; /* for future use */
+};
+
+/*
+ * argument to pfm_create_evtsets()/pfm_delete_evtsets()
+ *
+ * max timeout: 1h11mn33s (2<<32 usecs)
+ */
+struct pfarg_setdesc {
+	__u16	set_id;		  /* which set */
+	__u16	set_id_next;	  /* next set to go to */
+	pfm_flags_t set_flags; 	  /* input: flags, return: err flag  */
+	__u32	set_timeout;	  /* req/eff switch timeout in usecs */
+	__u32	set_reserved1;	  /* for future use */
+	__u64	set_mmap_offset;  /* ret arg: cookie for mmap offset */
+	__u64	reserved[5];	  /* for future use */
+};
+
+/*
+ * argument to pfm_getinfo_evtsets()
+ */
+struct pfarg_setinfo {
+	__u16	set_id;             /* which set */
+	__u16	set_id_next;        /* out: next set to go to */
+	pfm_flags_t set_flags;	    /* out:flags or error */
+	__u64 	set_ovfl_pmds[PFM_PMD_BV]; /* out: last ovfl PMDs */
+	__u64	set_runs;            /* out: #times the set was active */
+	__u32	set_timeout;         /* out: effective switch timeout in usecs */
+	__u32	set_reserved1;       /* for future use */
+	__u64	set_act_duration;    /* out: time set active (ns) */
+	__u64	set_mmap_offset;     /* cookie to for mmap offset */
+	__u64	set_avail_pmcs[PFM_PMC_BV];/* unavailable PMCs */
+	__u64	set_avail_pmds[PFM_PMD_BV];/* unavailable PMDs */
+	__u64	reserved[4];         /* for future use */
+};
+
+/*
+ * default value for the user and group security parameters in
+ * /proc/sys/kernel/perfmon/sys_group
+ * /proc/sys/kernel/perfmon/task_group
+ */
+#define PFM_GROUP_PERM_ANY	-1	/* any user/group */
+
+/*
+ * remapped set view
+ *
+ * IMPORTANT: cannot be bigger than PAGE_SIZE
+ */
+struct pfm_set_view {
+	__u32      set_status;             /* set status: active/inact */
+	__u32      set_reserved1;          /* for future use */
+	__u64      set_runs;               /* number of activations */
+	__u64      set_pmds[PFM_MAX_PMDS]; /* 64-bit value of PMDS */
+	volatile unsigned long	set_seq;   /* sequence number of updates */
+};
+
+/*
+ * pfm_set_view status flags
+ */
+#define PFM_SETVFL_ACTIVE	0x1 /* set is active */
+
+struct pfm_ovfl_msg {
+	__u32 		msg_type;	/* generic message header */
+	__u32		msg_ovfl_pid;	/* process id */
+	__u64		msg_ovfl_pmds[PFM_HW_PMD_BV];/* overflowed PMDs */
+	__u16 		msg_active_set;	/* active set at overflow */
+	__u16 		msg_ovfl_cpu;	/* cpu of PMU interrupt */
+	__u32		msg_ovfl_tid;	/* kernel thread id */
+	__u64		msg_ovfl_ip;    /* IP on PMU intr */
+};
+
+#define PFM_MSG_OVFL	1	/* an overflow happened */
+#define PFM_MSG_END	2	/* task to which context was attached ended */
+
+union pfm_msg {
+	__u32	type;
+	struct pfm_ovfl_msg	pfm_ovfl_msg;
+};
+
+/*
+ * perfmon version number
+ */
+#define PFM_VERSION_MAJ		 2U
+#define PFM_VERSION_MIN		 2U
+#define PFM_VERSION		 (((PFM_VERSION_MAJ&0xffff)<<16)|\
+				  (PFM_VERSION_MIN & 0xffff))
+#define PFM_VERSION_MAJOR(x)	 (((x)>>16) & 0xffff)
+#define PFM_VERSION_MINOR(x)	 ((x) & 0xffff)
+
+
+/*
+ * This part of the header file is meant for kernel level code only including
+ * kernel modules
+ */
+#ifdef __KERNEL__
+
+#include <linux/file.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/kobject.h>
+
+/*
+ * perfmon context state
+ */
+#define PFM_CTX_UNLOADED	1 /* context is not loaded onto any task */
+#define PFM_CTX_LOADED		2 /* context is loaded onto a task */
+#define PFM_CTX_MASKED		3 /* context is loaded, monitoring is masked */
+#define PFM_CTX_ZOMBIE		4 /* context lost owner but is still attached */
+
+/*
+ * depth of message queue
+ */
+#define PFM_MAX_MSGS		8
+#define PFM_CTXQ_EMPTY(g)	((g)->msgq_head == (g)->msgq_tail)
+
+/*
+ * type of PMD reset for pfm_reset_pmds() or pfm_switch_sets()
+ */
+#define PFM_PMD_RESET_NONE	0	/* do not reset (pfm_switch_set) */
+#define PFM_PMD_RESET_SHORT	1	/* use short reset value */
+#define PFM_PMD_RESET_LONG	2	/* use long reset value  */
+
+/*
+ * describe the content of the pfm_syst_info field
+ */
+#define PFM_CPUINFO_TIME_SWITCH	   0x20 /* current set is time-switched */
+
+struct pfm_controls {
+	int	debug;		/* debugging via syslog */
+	int	debug_ovfl;	/* overflow handling debugging */
+	gid_t	sys_group;	/* gid to create a syswide context */
+	gid_t	task_group;	/* gid to create a per-task context */
+	size_t	arg_size_max;	/* maximum vector argument size */
+	size_t	smpl_buf_size_max; /* max buf mem, -1 for infinity */
+	int pmd_read;
+};
+
+DECLARE_PER_CPU(struct task_struct *, pmu_owner);
+DECLARE_PER_CPU(struct pfm_context *, pmu_ctx);
+DECLARE_PER_CPU(unsigned long, pfm_syst_info);
+DECLARE_PER_CPU(u64, pmu_activation_number);
+DECLARE_PER_CPU(struct pfm_stats, pfm_stats);
+
+/*
+ * logging
+ */
+#define PFM_ERR(f, x...)  printk(KERN_ERR     "perfmon: " f "\n", ## x)
+#define PFM_WARN(f, x...) printk(KERN_WARNING "perfmon: " f "\n", ## x)
+#define PFM_LOG(f, x...)  printk(KERN_NOTICE  "perfmon: " f "\n", ## x)
+#define PFM_INFO(f, x...) printk(KERN_INFO    "perfmon: " f "\n", ## x)
+
+/*
+ * debugging
+ */
+#define PFM_DEBUGGING 1
+#ifdef  PFM_DEBUGGING
+#define PFM_DBG(f, x...) \
+	do { \
+		if (unlikely(pfm_controls.debug >0)) { \
+			printk("perfmon: %s.%d: CPU%d [%d]: " f "\n", \
+			       __FUNCTION__, __LINE__, \
+			       smp_processor_id(), current->pid , ## x); \
+		} \
+	} while (0)
+
+#define PFM_DBG_ovfl(f, x...) \
+	do { \
+		if (unlikely(pfm_controls.debug_ovfl >0)) { \
+			printk("perfmon: %s.%d: CPU%d [%d]: " f "\n", \
+			       __FUNCTION__, __LINE__, \
+			       smp_processor_id(), current->pid , ## x); \
+		} \
+	} while (0)
+#else
+#define PFM_DBG(f, x...)	do {} while(0)
+#define PFM_DBG_ovfl(f, x...)	do {} while(0)
+#endif
+
+/*
+ * global information about all sessions
+ * mostly used to synchronize between system wide and per-process
+ */
+struct pfm_sessions {
+	u32		pfs_task_sessions;/* #num loaded per-thread sessions */
+	u32		pfs_sys_sessions; /* #num loaded system wide sessions */
+	size_t		pfs_cur_smpl_buf_mem; /* current smpl buf mem usage */
+	cpumask_t	pfs_sys_cpumask;/* bitmask of used cpus */
+};
+
+/*
+ * PMD information
+ * software maintained value is in the pfm_set_view structure.
+ */
+struct pfm_pmd {
+	u64 lval;		/* last reset value */
+	u64 ovflsw_thres;	 /* #overflows left before switching */
+	u64 long_reset;		/* reset value on sampling overflow */
+	u64 short_reset;    	/* reset value on overflow */
+	u64 reset_pmds[PFM_PMD_BV];  /* pmds to reset on overflow */
+	u64 smpl_pmds[PFM_PMD_BV];   /* pmds to record on overflow */
+	u64 mask;		 /* mask for generator */
+	u64 seed;		 /* seed for generator (must be 64 bits here) */
+	u32 flags;		 /* notify/do not notify */
+	u64 ovflsw_ref_thres;	 /* #overflows before switching to next set */
+	u64 eventid;	 	 /* overflow event identifier */
+};
+
+/*
+ * perfmon context: encapsulates all the state of a monitoring session
+ */
+struct pfm_event_set {
+	u16 id;
+	u16 id_next;			/* which set to go to from this one */
+	pfm_flags_t flags;		/* public set flags */
+
+	struct list_head list;		/* next in the ordered list */
+	struct pfm_event_set *sw_next;	/* address of set to go to */
+	pfm_flags_t priv_flags;		/* private flags */
+	u32 npend_ovfls;		/* number of pending PMD overflow */
+
+	u64 used_pmds[PFM_PMD_BV];    /* used PMDs */
+	u64 povfl_pmds[PFM_PMD_BV];   /* pending overflowed PMDs */
+	u64 ovfl_pmds[PFM_PMD_BV];    /* last overflowed PMDs */
+	u64 reset_pmds[PFM_PMD_BV];   /* PMDs to reset */
+	u64 ovfl_notify[PFM_PMD_BV];  /* notify on overflow */
+	u64 pmcs[PFM_MAX_PMCS];	      /* PMC values */
+
+	u16 nused_pmds;			    /* max number of used PMDs */
+	u16 nused_pmcs;			    /* max number of used PMCs */
+
+	struct pfm_pmd pmds[PFM_MAX_PMDS];  /* 64-bit SW PMDs */
+	struct pfm_set_view *view;	    /* pointer to view */
+	u64 timeout_sw_ref;		    /* switch timeout reference */
+	u64 timeout_sw_left;		    /* timeout remaining */
+	u64 timeout_sw_exp;		    /* timeout expiration jiffies */
+	u64 duration_start;		    /* start ns */
+	u64 duration;			    /* total active ns */
+	off_t mmap_offset;		    /* view mmap offset */
+	u64 used_pmcs[PFM_PMC_BV];    /* used PMCs (keep for arbitration) */
+
+	unsigned long last_iip;		/* last interrupt instruction pointer */
+	u64 last_ovfl_pmd_reset;/* reset of lowest idx of last overflowed pmds */
+	unsigned int last_ovfl_pmd;	/* lowest idx of last overflowed pmds */
+};
+
+/*
+ * common private event set flags (priv_flags)
+ *
+ * upper 16 bits: for arch-specific use
+ * lower 16 bits: for common use
+ */
+#define PFM_SETFL_PRIV_MOD_PMDS 0x1 /* PMD register(s) modified */
+#define PFM_SETFL_PRIV_MOD_PMCS 0x2 /* PMC register(s) modified */
+#define PFM_SETFL_PRIV_SWITCH	0x4 /* must switch set on restart */
+#define PFM_SETFL_PRIV_MOD_BOTH	(PFM_SETFL_PRIV_MOD_PMDS | PFM_SETFL_PRIV_MOD_PMCS)
+
+/*
+ * context flags
+ */
+struct pfm_context_flags {
+	unsigned int block:1;		/* task blocks on user notifications */
+	unsigned int system:1;		/* do system wide monitoring */
+	unsigned int no_msg:1;		/* no message sent on overflow */
+	unsigned int can_restart:1;	/* allowed to issue a PFM_RESTART */
+	unsigned int switch_ovfl:1;	/* switch set on counter ovfl */
+	unsigned int switch_time:1;	/* switch set on timeout */
+	unsigned int mapset:1;		/* event sets are remapped */
+	unsigned int started:1;		/* pfm_start() issued */
+	unsigned int work_type:2;	/* type of work for pfm_handle_work() */
+	unsigned int reserved:20;	/* for future use */
+};
+
+/*
+ * values for work_type (TIF_PERFMON_WORK must be set)
+ */
+#define PFM_WORK_NONE	0	/* nothing to do */
+#define PFM_WORK_RESET	1	/* reset overflowed counters */
+#define PFM_WORK_BLOCK	2	/* block current thread */
+#define PFM_WORK_ZOMBIE	3	/* cleanup zombie context */
+
+/*
+ * check_mask bitmask values for pfm_check_task_state()
+ */
+#define PFM_CMD_STOPPED		0x01	/* command needs thread stopped */
+#define PFM_CMD_UNLOADED	0x02	/* command needs ctx unloaded */
+#define PFM_CMD_UNLOAD		0x04	/* command is unload */
+
+#include <linux/perfmon_pmu.h>
+#include <linux/perfmon_fmt.h>
+#include <linux/perfmon_kernel.h>
+
+/*
+ * perfmon context: encapsulates all the state of a monitoring session
+ */
+struct pfm_context {
+	spinlock_t		lock;	/* context protection */
+
+	struct file		*filp;	/* filp */
+
+	struct pfm_context_flags flags;	/*  flags */
+	u32			state;	/* state */
+	struct task_struct 	*task;	/* attached task */
+
+	struct completion       restart_complete;/* block on notification */
+	u64 			last_act;	/* last activation */
+	u32			last_cpu;   	/* last CPU used (SMP only) */
+	u32			cpu;		/* cpu bound to context */
+
+	struct pfm_smpl_fmt	*smpl_fmt;	/* buffer format callbacks */
+	void			*smpl_addr;	/* smpl buffer base */
+	size_t			smpl_size;
+
+	wait_queue_head_t 	msgq_wait;	/* used when flags.kapi=0 */
+	union pfm_msg		msgq[PFM_MAX_MSGS];
+	int			msgq_head;
+	int			msgq_tail;
+
+	struct fasync_struct	*async_queue;
+
+	struct pfm_event_set	*active_set; /* active set */
+	struct list_head	list;	 /* ordered list of sets */
+
+	/*
+	 * save stack space by allocating temporary variables for
+	 * pfm_overflow_handler() in pfm_context
+	 */
+	struct pfm_ovfl_arg 	ovfl_arg;
+	u64 ovfl_ovfl_notify[PFM_PMD_BV];
+};
+
+#define pfm_ctx_arch(c)	((struct pfm_arch_context *)((c)+1))
+
+static inline void pfm_set_pmu_owner(struct task_struct *task,
+				     struct pfm_context *ctx)
+{
+	BUG_ON(task && task->pid == 0);
+	__get_cpu_var(pmu_owner) = task;
+	__get_cpu_var(pmu_ctx) = ctx;
+}
+
+static inline void pfm_inc_activation(void)
+{
+	__get_cpu_var(pmu_activation_number)++;
+}
+
+static inline void pfm_set_activation(struct pfm_context *ctx)
+{
+	ctx->last_act = __get_cpu_var(pmu_activation_number);
+}
+
+static inline void pfm_set_last_cpu(struct pfm_context *ctx, int cpu)
+{
+	ctx->last_cpu = cpu;
+}
+
+static inline void pfm_modview_begin(struct pfm_event_set *set)
+{
+	set->view->set_seq++;
+}
+
+static inline void pfm_modview_end(struct pfm_event_set *set)
+{
+	set->view->set_seq++;
+}
+
+static inline void pfm_retflag_set(u32 flags, u32 val)
+{
+	flags &= ~PFM_REG_RETFL_MASK;
+	flags |= (val);
+}
+
+extern struct _pfm_pmu_config  *pfm_pmu_conf;
+extern struct pfm_controls pfm_controls;
+extern atomic_t perfmon_disabled;
+
+int  pfm_get_args(void __user *, size_t, size_t, void *, void **, void **);
+int  pfm_get_smpl_arg(pfm_uuid_t, void __user *, size_t,
+		     void **, struct pfm_smpl_fmt **);
+
+int  pfm_alloc_fd(struct file **);
+int  pfm_sessions_block(void);
+void pfm_sessions_unblock(void);
+
+int  __pfm_write_pmcs(struct pfm_context *, struct pfarg_pmc *, int);
+int  __pfm_write_pmds(struct pfm_context *, struct pfarg_pmd *, int, int);
+int  __pfm_read_pmds(struct pfm_context *, struct pfarg_pmd *, int);
+void __pfm_reset_stats(void);
+int  __pfm_load_context(struct pfm_context *, struct pfarg_load *);
+int  __pfm_unload_context(struct pfm_context *, int);
+int  __pfm_stop(struct pfm_context *);
+int  __pfm_restart(struct pfm_context *);
+int  __pfm_start(struct pfm_context *, struct pfarg_start *);
+int  __pfm_delete_evtsets(struct pfm_context *, void *, int);
+int  __pfm_getinfo_evtsets(struct pfm_context *, struct pfarg_setinfo *, int);
+int __pfm_create_evtsets(struct pfm_context *, struct pfarg_setdesc *, int);
+int  __pfm_create_context(struct pfarg_ctx *, struct pfm_smpl_fmt *,
+			  void *,
+			  int,
+			  struct pfm_context **);
+int  pfm_check_task_state(struct pfm_context *, int, unsigned long *);
+
+struct pfm_event_set *pfm_find_set(struct pfm_context *, u16, int);
+struct pfm_context * pfm_get_ctx(int);
+
+void pfm_context_free(struct pfm_context *);
+struct pfm_context *pfm_context_alloc(void);
+int  pfm_pmu_conf_get(int);
+void pfm_pmu_conf_put(void);
+
+int pfm_reserve_session(struct pfm_context *, u32);
+int pfm_release_session(struct pfm_context *, u32);
+
+int  pfm_smpl_buffer_alloc(struct pfm_context *, size_t);
+int pfm_reserve_buf_space(size_t);
+void pfm_release_buf_space(size_t);
+
+struct pfm_smpl_fmt *pfm_smpl_fmt_get(pfm_uuid_t);
+void pfm_smpl_fmt_put(struct pfm_smpl_fmt *);
+int pfm_use_smpl_fmt(pfm_uuid_t);
+
+int  pfm_init_sysfs(void);
+ssize_t pfm_sysfs_session_show(char *, size_t , int);
+int pfm_sysfs_remove_pmu(struct _pfm_pmu_config *);
+int pfm_sysfs_add_pmu(struct _pfm_pmu_config *);
+int pfm_sysfs_remove_fmt(struct pfm_smpl_fmt *);
+int pfm_sysfs_add_fmt(struct pfm_smpl_fmt *);
+int pfm_sysfs_add_cpu(int);
+void pfm_sysfs_del_cpu(int);
+
+void pfm_interrupt_handler(unsigned long iip, struct pt_regs *);
+void pfm_save_pmds_release(struct pfm_context *);
+void pfm_save_prev_context(struct pfm_context *ctxp);
+
+void pfm_reset_pmds(struct pfm_context *, struct pfm_event_set *, int);
+
+void __pfm_handle_switch_timeout(void);
+int pfm_prepare_sets(struct pfm_context *, struct pfm_event_set *);
+int pfm_sets_init(void);
+int pfm_mmap_set(struct pfm_context *, struct vm_area_struct *, size_t);
+void pfm_free_sets(struct pfm_context *);
+void pfm_init_evtset(struct pfm_event_set *);
+void pfm_switch_sets(struct pfm_context *,
+	    	    struct pfm_event_set *,
+	            int,
+	            int);
+
+void pfm_save_pmds(struct pfm_context *, struct pfm_event_set *);
+void pfm_mask_monitoring(struct pfm_context *);
+int pfm_ovfl_notify_user(struct pfm_context *,
+				struct pfm_event_set *,
+				unsigned long);
+
+int pfm_init_fs(void);
+int pfm_is_fd(struct file *);
+
+u64 carta_random32 (u64);
+
+int __pfm_close(struct pfm_context *, struct file *);
+
+static inline void pfm_put_ctx(struct pfm_context *ctx)
+{
+	fput(ctx->filp);
+}
+
+#define PFM_MAX_NUM_SETS		65536
+#define PFM_SET_REMAP_SCALAR		PAGE_SIZE
+#define PFM_SET_REMAP_OFFS		16384	/* number of pages to offset */
+#define PFM_SET_REMAP_BASE		(PFM_SET_REMAP_OFFS*PAGE_SIZE)
+#define PFM_SET_REMAP_OFFS_MAX		(PFM_SET_REMAP_OFFS+\
+					 PFM_MAX_NUM_SETS*PFM_SET_REMAP_SCALAR)
+
+#define PFM_ONE_64		((u64)1)
+
+struct pfm_stats {
+	u64 pfm_ovfl_intr_replay_count;	/* replayed ovfl interrupts */
+	u64 pfm_ovfl_intr_regular_count;/* processed ovfl interrupts */
+	u64 pfm_ovfl_intr_all_count; 	/* total ovfl interrupts */
+	u64 pfm_ovfl_intr_ns;		/* cycles in ovfl interrupts */
+	u64 pfm_ovfl_intr_phase1;	/* cycles in ovfl interrupts */
+	u64 pfm_ovfl_intr_phase2;	/* cycles in ovfl interrupts */
+	u64 pfm_ovfl_intr_phase3;	/* cycles in ovfl interrupts */
+	u64 pfm_fmt_handler_calls;	/* # calls smpl buffer handler */
+	u64 pfm_fmt_handler_ns;		/* cycle in smpl format handler */
+	u64 pfm_set_switch_count;	/* #set_switches on this CPU */
+	u64 pfm_set_switch_ns;		/* cycles for switching sets */
+	u64 pfm_ctxsw_count;		/* #context switches on this CPU */
+	u64 pfm_ctxsw_ns;		/* cycles for context switches */
+	u64 pfm_handle_timeout_count;	/* #count of set timeouts handled */
+	u64 pfm_ovfl_intr_nmi_count;	/* count number of NMI-base ovfl */
+	struct kobject kobj;		/* for sysfs internal use only */
+};
+#define to_stats(n) container_of(n, struct pfm_stats, kobj)
+
+
+#include <asm/perfmon.h>
+
+extern const struct file_operations pfm_file_ops;
+/*
+ * max vector argument elements for local storage (no kmalloc/kfree)
+ * The PFM_ARCH_PM*_ARG should be defined in the arch specific perfmon.h
+ * file. If not, default (conservative) values are used
+ */
+
+#ifndef PFM_ARCH_PMC_STK_ARG
+#define PFM_ARCH_PMC_STK_ARG	1
+#endif
+
+#ifndef PFM_ARCH_PMD_STK_ARG
+#define PFM_ARCH_PMD_STK_ARG	1
+#endif
+
+#define PFM_PMC_STK_ARG	PFM_ARCH_PMC_STK_ARG
+#define PFM_PMD_STK_ARG	PFM_ARCH_PMD_STK_ARG
+
+#define PFM_BPL		64
+#define PFM_LBPL	6	/* log2(BPL) */
+
+/*
+ * upper limit for count in calls that take vector arguments. This is used
+ * to prevent for multiplication overflow when we compute actual storage size
+ */
+#define PFM_MAX_ARG_COUNT(m) (INT_MAX/sizeof(*(m)))
+
+/*
+ * those operations are not provided by linux/bitmap.h.
+ * We do not need atomicity nor volatile accesses here.
+ * All bitmaps are 64-bit wide.
+ */
+static inline void pfm_bv_set(u64 *bv, unsigned int rnum)
+{
+	bv[rnum>>PFM_LBPL] |= PFM_ONE_64 << (rnum&(PFM_BPL-1));
+}
+
+static inline int pfm_bv_isset(u64 *bv, unsigned int rnum)
+{
+	return bv[rnum>>PFM_LBPL] & (PFM_ONE_64 <<(rnum&(PFM_BPL-1))) ? 1 : 0;
+}
+
+static inline void pfm_bv_clear(u64 *bv, unsigned int rnum)
+{
+	bv[rnum>>PFM_LBPL] &= ~(PFM_ONE_64 << (rnum&(PFM_BPL-1)));
+}
+
+/*
+ * read a single PMD register. PMD register mapping is provided by PMU
+ * description module. Virtual PMD registers have special handler.
+ */
+static inline u64 pfm_read_pmd(struct pfm_context *ctx, unsigned int cnum)
+{
+	if (unlikely(pfm_pmu_conf->pmd_desc[cnum].type & PFM_REG_V))
+		return pfm_pmu_conf->pmd_sread(ctx, cnum);
+
+	return pfm_arch_read_pmd(ctx, cnum);
+}
+
+static inline void pfm_write_pmd(struct pfm_context *ctx, unsigned int cnum, u64 value)
+{
+	/*
+	 * PMD writes are ignored for read-only registers
+	 */
+	if (pfm_pmu_conf->pmd_desc[cnum].type & PFM_REG_RO)
+		return;
+
+	if (pfm_pmu_conf->pmd_desc[cnum].type & PFM_REG_V) {
+		pfm_pmu_conf->pmd_swrite(ctx, cnum, value);
+		return;
+	}
+	pfm_arch_write_pmd(ctx, cnum, value);
+}
+
+#define ulp(_x) ((unsigned long *)_x)
+
+#define PFM_NORMAL      0
+#define PFM_COMPAT      1
+#define PFM_KAPI        2
+
+#endif /* __KERNEL__ */
+
+#endif /* CONFIG_PERFMON */
+
+#endif /* __LINUX_PERFMON_H__ */
--- linux-2.6.18.base/include/linux/perfmon_kernel.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/include/linux/perfmon_kernel.h	2006-09-25 12:16:18.000000000 -0700
@@ -0,0 +1,97 @@
+/*
+ * Copyright (c) 2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *
+ * Kernel hooks for perfmon
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+  */
+#ifndef __PERFMON_KERNEL_H__
+#define __PERFMON_KERNEL_H__ 1
+
+#ifdef __KERNEL__
+
+#ifdef CONFIG_PERFMON
+
+void __pfm_exit_thread(struct task_struct *);
+void __pfm_copy_thread(struct task_struct *);
+void __pfm_ctxsw(struct task_struct *, struct task_struct *);
+void __pfm_handle_work(void);
+void __pfm_handle_switch_timeout(void);
+void __pfm_init_percpu(void *);
+void __pfm_cpu_disable(void);
+
+static inline void pfm_exit_thread(struct task_struct *task)
+{
+	if (task->pfm_context)
+		__pfm_exit_thread(task);
+}
+
+static inline void pfm_handle_work(void)
+{
+	__pfm_handle_work();
+}
+
+static inline void pfm_copy_thread(struct task_struct *task)
+{
+	/*
+	 * task is child state
+	 * perfmon context is never shared with child tasks
+	 */
+	task->pfm_context = NULL;
+	clear_tsk_thread_flag(task, TIF_PERFMON_CTXSW);
+	clear_tsk_thread_flag(task, TIF_PERFMON_WORK);
+}
+
+static inline void pfm_ctxsw(struct task_struct *p, struct task_struct *n)
+{
+	__pfm_ctxsw(p, n);
+}
+
+static inline void pfm_handle_switch_timeout(void)
+{
+	unsigned long info;
+	info = __get_cpu_var(pfm_syst_info);
+	if (info & PFM_CPUINFO_TIME_SWITCH)
+		__pfm_handle_switch_timeout();
+}
+
+static inline void pfm_init_percpu(void)
+{
+	__pfm_init_percpu(NULL);
+}
+static inline void pfm_cpu_disable(void)
+{
+	__pfm_cpu_disable();
+}
+
+#else /* !CONFIG_PERFMON */
+
+#define tsks_have_perfmon(p, n)	(0)
+#define pfm_cpu_disable()		do { } while (0)
+#define pfm_init_percpu()		do { } while (0)
+#define pfm_exit_thread(_t)  		do { } while (0)
+#define pfm_handle_work(_t)    		do { } while (0)
+#define pfm_copy_thread(_t,_r)		do { } while (0)
+#define pfm_ctxsw(_p, _t)     		do { } while (0)
+#define pfm_handle_switch_timeout()  	do { } while (0)
+#define pfm_release_dbregs(_t) 		do { } while (0)
+#define pfm_use_dbregs(_t)     		(0)
+
+#endif /* CONFIG_PERFMON */
+
+#endif /* __KERNEL__ */
+
+#endif /* __PERFMON_KERNEL_H__ */
--- linux-2.6.18.base/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/perfmon.c	2006-09-25 12:08:04.000000000 -0700
@@ -0,0 +1,1680 @@
+/*
+ * perfmon.c: perfmon2 core functions
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
+ * The initial version of perfmon.c was written by
+ * Ganesh Venkitachalam, IBM Corp.
+ *
+ * Then it was modified for perfmon-1.x by Stephane Eranian and
+ * David Mosberger, Hewlett Packard Co.
+ *
+ * Version Perfmon-2.x is a complete rewrite of perfmon-1.x
+ * by Stephane Eranian, Hewlett Packard Co.
+ *
+ * Copyright (c) 1999-2006 Hewlett-Packard Development Company, L.P.
+ * Contributed by Stephane Eranian <eranian@hpl.hp.com>
+ *                David Mosberger-Tang <davidm@hpl.hp.com>
+ *
+ * More information about perfmon available at:
+ * 	http://www.hpl.hp.com/research/linux/perfmon
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+ * 02111-1307 USA
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/vmalloc.h>
+#include <linux/poll.h>
+#include <linux/ptrace.h>
+#include <linux/perfmon.h>
+#include <linux/cpu.h>
+
+/*
+ * internal variables
+ */
+static kmem_cache_t *pfm_ctx_cachep;
+
+/*
+ * external variables
+ */
+DEFINE_PER_CPU(unsigned long, pfm_syst_info);
+DEFINE_PER_CPU(struct task_struct *, pmu_owner);
+DEFINE_PER_CPU(struct pfm_context  *, pmu_ctx);
+DEFINE_PER_CPU(u64, pmu_activation_number);
+DEFINE_PER_CPU(struct pfm_stats, pfm_stats);
+
+#define PFM_INVALID_ACTIVATION	((u64)~0)
+
+atomic_t perfmon_disabled;	/* >0 if perfmon is disabled */
+
+/*
+ * Reset PMD register flags
+ */
+#define PFM_PMD_RESET_NONE	0	/* do not reset (pfm_switch_set) */
+#define PFM_PMD_RESET_SHORT	1	/* use short reset value */
+#define PFM_PMD_RESET_LONG	2	/* use long reset value  */
+
+static union pfm_msg *pfm_get_new_msg(struct pfm_context *ctx)
+{
+	int idx, next;
+
+	next = (ctx->msgq_tail+1) % PFM_MAX_MSGS;
+
+	PFM_DBG("head=%d tail=%d", ctx->msgq_head, ctx->msgq_tail);
+
+	if (next == ctx->msgq_head)
+		return NULL;
+
+	idx = ctx->msgq_tail;
+	ctx->msgq_tail = next;
+
+	PFM_DBG("head=%d tail=%d msg=%d",
+		ctx->msgq_head,
+		ctx->msgq_tail, idx);
+
+	return ctx->msgq+idx;
+}
+
+static inline void pfm_reset_msgq(struct pfm_context *ctx)
+{
+	ctx->msgq_head = ctx->msgq_tail = 0;
+}
+
+void pfm_context_free(struct pfm_context *ctx)
+{
+	struct pfm_smpl_fmt *fmt;
+
+	fmt = ctx->smpl_fmt;
+
+	pfm_free_sets(ctx);
+
+	if (ctx->smpl_addr) {
+		PFM_DBG("freeing sampling buffer @%p size=%zu",
+			ctx->smpl_addr,
+			ctx->smpl_size);
+
+		pfm_release_buf_space(ctx->smpl_size);
+
+		if (fmt->fmt_exit)
+			(*fmt->fmt_exit)(ctx->smpl_addr);
+
+		vfree(ctx->smpl_addr);
+	}
+
+	PFM_DBG("free ctx @%p", ctx);
+	kmem_cache_free(pfm_ctx_cachep, ctx);
+	/*
+	 * decrease refcount on:
+	 * 	- PMU description table
+	 * 	- sampling format
+	 */
+	pfm_pmu_conf_put();
+	pfm_smpl_fmt_put(fmt);
+}
+
+/*
+ * only called in for the current task
+ */
+static int pfm_setup_smpl_fmt(struct pfm_smpl_fmt *fmt, void *fmt_arg,
+				struct pfm_context *ctx, u32 ctx_flags,
+				int mode, struct file *filp)
+{
+	size_t size = 0;
+	int ret = 0;
+
+	/*
+	 * validate parameters
+	 */
+	if (fmt->fmt_validate) {
+		ret = (*fmt->fmt_validate)(ctx_flags, pfm_pmu_conf->num_pmds,
+					   fmt_arg);
+		PFM_DBG("validate(0x%x,%p)=%d", ctx_flags, fmt_arg, ret);
+		if (ret)
+			goto error;
+	}
+
+	/*
+	 * check if buffer format wants to use perfmon
+	 * buffer allocation/mapping service
+	 */
+	size = 0;
+	if (fmt->fmt_getsize) {
+		ret = (*fmt->fmt_getsize)(ctx_flags, fmt_arg, &size);
+		if (ret) {
+			PFM_DBG("cannot get size ret=%d", ret);
+			goto error;
+		}
+	}
+
+	if (size) {
+#ifdef CONFIG_IA64_PERFMON_COMPAT
+		if (mode == PFM_COMPAT)
+			ret = pfm_smpl_buffer_alloc_old(ctx, size, filp);
+		else
+#endif
+		{
+			ret = pfm_smpl_buffer_alloc(ctx, size);
+		}
+		if (ret)
+			goto error;
+
+	}
+
+	if (fmt->fmt_init) {
+		ret = (*fmt->fmt_init)(ctx, ctx->smpl_addr, ctx_flags,
+				       pfm_pmu_conf->num_pmds,
+				       fmt_arg);
+		if (ret)
+			goto error_buffer;
+	}
+	return 0;
+
+error_buffer:
+	pfm_release_buf_space(ctx->smpl_size);
+	/*
+	 * we do not call fmt_exit, if init has failed
+	 */
+	vfree(ctx->smpl_addr);
+error:
+	return ret;
+}
+
+
+
+void pfm_mask_monitoring(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 now;
+
+	PFM_DBG_ovfl("masking monitoring");
+
+	now = sched_clock();
+	set = ctx->active_set;
+
+	/*
+	 * monitoring can only be masked as a result of a valid
+	 * counter overflow. In UP and per-thread mode,
+	 * it is possible that the current task may not be the
+	 * one that generated the overflow because the overflow happen
+	 * very close to the context switch point where interrupts are
+	 * masked.  In SMP per-thread, current is always the task that
+	 * generated the overflow.
+	 *
+	 * For system-wide, the current task is alwys the one that
+	 * generated the overflow.
+	 *
+	 * In any case, accessing the PMU directly is always safe
+	 * given that we are only called from the overflow handler.
+	 */
+	pfm_modview_begin(set);
+	pfm_save_pmds(ctx, set);
+	pfm_modview_end(set);
+	pfm_arch_mask_monitoring(ctx);
+
+	/*
+	 * accumulate the set duration up to this point
+	 */
+	set->duration += now - set->duration_start;
+}
+
+/*
+ * interrupts are masked when entering this function.
+ * context must be in MASKED state when calling.
+ */
+static void pfm_unmask_monitoring(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+
+	if (ctx->state != PFM_CTX_MASKED)
+		return;
+
+	PFM_DBG("unmasking monitoring");
+
+	set = ctx->active_set;
+
+	/*
+	 * must be done before calling
+	 * pfm_arch_unmask_monitoring()
+	 */
+	ctx->state = PFM_CTX_LOADED;
+
+	pfm_arch_restore_pmds(ctx, set);
+
+	pfm_arch_unmask_monitoring(ctx);
+
+	set->priv_flags &= ~PFM_SETFL_PRIV_MOD_BOTH;
+
+	/*
+	 * reset set duration timer
+	 */
+	set->duration_start = sched_clock();
+}
+
+/*
+ * called from pfm_smpl_buffer_alloc_old() (IA64-COMPAT)
+ * and pfm_setup_smpl_fmt()
+ *
+ * interrupts are enabled, context is not locked.
+ */
+int pfm_smpl_buffer_alloc(struct pfm_context *ctx, size_t rsize)
+{
+	void *addr;
+	size_t size;
+	int ret;
+
+	might_sleep();
+
+	/*
+	 * the fixed header + requested size and align to page boundary
+	 */
+	size = PAGE_ALIGN(rsize);
+
+	PFM_DBG("sampling buffer rsize=%zu size=%zu", rsize, size);
+
+	ret = pfm_reserve_buf_space(size);
+	if (ret)
+		return ret;
+
+	/*
+	 * vmalloc can sleep. we do not hold
+	 * any spinlock and interrupts are enabled
+	 */
+	addr = vmalloc(size);
+	if (!addr) {
+		PFM_DBG("cannot allocate sampling buffer");
+		goto unres;
+	}
+
+	memset(addr, 0, size);
+
+	ctx->smpl_addr = addr;
+	ctx->smpl_size = size;
+
+	PFM_DBG("kernel smpl buffer @%p", addr);
+
+	return 0;
+unres:
+	pfm_release_buf_space(size);
+	return -ENOMEM;
+}
+
+static inline u64 pfm_new_pmd_value (struct pfm_pmd *reg, int reset_mode)
+{
+	u64 val, mask;
+	u64 new_seed, old_seed;
+
+	val = reset_mode == PFM_PMD_RESET_LONG ? reg->long_reset : reg->short_reset;
+	old_seed = reg->seed;
+	mask = reg->mask;
+
+	if (reg->flags & PFM_REGFL_RANDOM) {
+		new_seed = carta_random32(old_seed);
+
+		/* counter values are negative numbers! */
+		val -= (old_seed & mask);
+		if ((mask >> 32) != 0)
+			/* construct a full 64-bit random value: */
+			new_seed |= (u64)carta_random32((u32)(old_seed >> 32)) << 32;
+		reg->seed = new_seed;
+	}
+	reg->lval = val;
+	return val;
+}
+
+void pfm_reset_pmds(struct pfm_context *ctx, struct pfm_event_set *set,
+		    int reset_mode)
+{
+	u64 ovfl_mask, hw_val;
+	u64 *cnt_mask, *reset_pmds;
+	u64 val;
+	unsigned int i, max_pmd, not_masked;
+
+	reset_pmds = set->reset_pmds;
+	max_pmd	= pfm_pmu_conf->max_pmd;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	cnt_mask = pfm_pmu_conf->cnt_pmds;
+	not_masked = ctx->state != PFM_CTX_MASKED;
+
+	PFM_DBG_ovfl("%s r_pmds=0x%llx not_masked=%d",
+		     reset_mode == PFM_PMD_RESET_LONG ? "long" : "short",
+		     (unsigned long long)reset_pmds[0],
+		     not_masked);
+
+	pfm_modview_begin(set);
+
+	for (i = 0; i < max_pmd; i++) {
+
+		if (pfm_bv_isset(reset_pmds, i)) {
+
+			val = pfm_new_pmd_value(set->pmds + i,
+						reset_mode);
+
+			set->view->set_pmds[i]= val;
+
+			/*
+			 * not all PMD to reset are necessarily
+			 * counters
+			 */
+			if (not_masked) {
+				if (pfm_bv_isset(cnt_mask, i)) {
+					hw_val = val & ovfl_mask;
+				} else {
+					hw_val = val;
+				}
+				pfm_write_pmd(ctx, i, hw_val);
+			}
+			PFM_DBG_ovfl("pmd%u set=%u sval=0x%llx",
+				     i,
+				     set->id,
+				     (unsigned long long)val);
+		}
+	}
+
+	pfm_modview_end(set);
+
+	/*
+	 * done with reset
+	 */
+	bitmap_zero(ulp(reset_pmds), max_pmd);
+
+	/*
+	 * make changes visible
+	 */
+	if (not_masked)
+		pfm_arch_serialize();
+}
+
+
+
+
+/*
+ * called from pfm_handle_work() and __pfm_restart()
+ * for system-wide and per-thread context.
+ */
+static void pfm_resume_after_ovfl(struct pfm_context *ctx)
+{
+	struct pfm_smpl_fmt *fmt;
+	u32 rst_ctrl;
+	struct pfm_event_set *set;
+	u64 *reset_pmds;
+	void *hdr;
+	int state, ret;
+
+	hdr = ctx->smpl_addr;
+	fmt = ctx->smpl_fmt;
+	state = ctx->state;
+	set = ctx->active_set;
+	ret = 0;
+
+	if (hdr) {
+		rst_ctrl = 0;
+		prefetch(hdr);
+		if (fmt->fmt_restart)
+			ret = (*fmt->fmt_restart)(state == PFM_CTX_LOADED,
+					  	  &rst_ctrl, hdr);
+	} else {
+		rst_ctrl= PFM_OVFL_CTRL_RESET;
+	}
+	reset_pmds = set->reset_pmds;
+
+	PFM_DBG("restart=%d set=%u r_pmds=0x%llx switch=%d ctx_state=%d",
+		ret,
+		set->id,
+		(unsigned long long)reset_pmds[0],
+		!(set->priv_flags & PFM_SETFL_PRIV_SWITCH),
+		state);
+
+	if (!ret) {
+		/*
+		 * switch set if needed
+		 */
+		if (set->priv_flags & PFM_SETFL_PRIV_SWITCH) {
+			set->priv_flags &= ~PFM_SETFL_PRIV_SWITCH;
+			pfm_switch_sets(ctx, NULL, PFM_PMD_RESET_LONG, 0);
+			set = ctx->active_set;
+		} else if (rst_ctrl & PFM_OVFL_CTRL_RESET) {
+			if (!bitmap_empty(ulp(set->reset_pmds), pfm_pmu_conf->max_pmd))
+				pfm_reset_pmds(ctx, set, PFM_PMD_RESET_LONG);
+		}
+
+		if (!(rst_ctrl & PFM_OVFL_CTRL_MASK)) {
+			pfm_unmask_monitoring(ctx);
+		} else {
+			PFM_DBG("stopping monitoring?");
+		}
+		ctx->state = PFM_CTX_LOADED;
+	}
+	ctx->flags.can_restart = 0;
+}
+
+/*
+ * This function is always called after pfm_stop has been issued
+ */
+void pfm_flush_pmds(struct task_struct *task, struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	u64 ovfl_mask;
+	u64 *ovfl_pmds;
+	u32 num_ovfls;
+	u16 i, first_cnt_pmd;
+
+	ovfl_mask = pfm_pmu_conf->ovfl_mask;
+	first_cnt_pmd = pfm_pmu_conf->first_cnt_pmd;
+
+	set = ctx->active_set;
+
+	/*
+	 * save active set
+	 * UP:
+	 * 	if not current task and due to lazy, state may
+	 * 	still be live
+	 * for system-wide, guaranteed to run on correct CPU
+	 */
+	if (__get_cpu_var(pmu_ctx) == ctx) {
+		/*
+		 * pending overflows have been saved by pfm_stop()
+		 */
+		pfm_modview_begin(set);
+		pfm_save_pmds(ctx, set);
+		pfm_modview_end(set);
+		pfm_set_pmu_owner(NULL, NULL);
+		PFM_DBG("released ownership");
+	}
+
+	/*
+	 * cleanup each set
+	 */
+	list_for_each_entry(set, &ctx->list, list) {
+		if (!set->npend_ovfls)
+			continue;
+
+		pfm_modview_begin(set);
+
+		/*
+		 * take care of overflow
+		 * no format handler is called here
+		 */
+		ovfl_pmds = set->povfl_pmds;
+		num_ovfls = set->npend_ovfls;
+
+		PFM_DBG("set%u first=%u novfls=%u",
+			set->id, first_cnt_pmd, num_ovfls);
+		/*
+		 * only look up to the last counting PMD register
+		 */
+		for (i = first_cnt_pmd; num_ovfls; i++) {
+			if (pfm_bv_isset(ovfl_pmds, i)) {
+				set->view->set_pmds[i] += 1 + ovfl_mask;
+				num_ovfls--;
+				PFM_DBG("pmd%u overflowed", i);
+ 			}
+			PFM_DBG("pmd%u set=%u val=0x%llx",
+				i,
+				set->id,
+				(unsigned long long)set->view->set_pmds[i]);
+		}
+		pfm_modview_end(set);
+	}
+}
+
+/*
+ * pfm_handle_work() can be called with interrupts enabled
+ * (TIF_NEED_RESCHED) or disabled. The down_interruptible
+ * call may sleep, therefore we must re-enable interrupts
+ * to avoid deadlocks. It is safe to do so because this function
+ * is called ONLY when returning to user level, in which case
+ * there is no risk of kernel stack overflow due to deep
+ * interrupt nesting.
+ */
+void __pfm_handle_work(void)
+{
+	struct pfm_context *ctx;
+	unsigned long flags, dummy_flags;
+	int type, ret;
+
+	clear_thread_flag(TIF_PERFMON_WORK);
+
+	ctx = current->pfm_context;
+	if (ctx == NULL) {
+		PFM_ERR("handle_work [%d] has no ctx", current->pid);
+		return;
+	}
+
+	BUG_ON(ctx->flags.system);
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	type = ctx->flags.work_type;
+	ctx->flags.work_type = PFM_WORK_NONE;
+
+	/*
+	 * must be done before we check for simple reset mode
+	 */
+	if (type == PFM_WORK_ZOMBIE)
+		goto do_zombie;
+
+	if (type == PFM_WORK_RESET) {
+		PFM_DBG("counter reset");
+		goto skip_blocking;
+	}
+
+	/*
+	 * restore interrupt mask to what it was on entry.
+	 * Could be enabled/diasbled.
+	 */
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	/*
+	 * force interrupt enable because of down_interruptible()
+	 */
+	local_irq_enable();
+
+	PFM_DBG("before block sleeping");
+
+	/*
+	 * may go through without blocking on SMP systems
+	 * if restart has been received already by the time we call down()
+	 */
+	ret = wait_for_completion_interruptible(&ctx->restart_complete);
+
+	PFM_DBG("after block sleeping ret=%d", ret);
+
+	/*
+	 * lock context and mask interrupts again
+	 * We save flags into a dummy because we may have
+	 * altered interrupts mask compared to entry in this
+	 * function.
+	 */
+	spin_lock_irqsave(&ctx->lock, dummy_flags);
+
+	if (ctx->state == PFM_CTX_ZOMBIE)
+		goto do_zombie;
+
+	/*
+	 * in case of interruption of down() we don't restart anything
+	 */
+	if (ret < 0)
+		goto nothing_to_do;
+
+skip_blocking:
+	pfm_resume_after_ovfl(ctx);
+
+nothing_to_do:
+
+	/*
+	 * restore flags as they were upon entry
+	 */
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	return;
+
+do_zombie:
+	PFM_DBG("context is zombie, bailing out");
+
+	__pfm_unload_context(ctx, 0);
+
+	/*
+	 * enable interrupt for vfree()
+	 */
+	local_irq_enable();
+
+	/*
+	 * actual context free
+	 */
+	pfm_context_free(ctx);
+
+	/*
+	 * restore interrupts as they were upon entry
+	 */
+	local_irq_restore(flags);
+}
+
+static int pfm_notify_user(struct pfm_context *ctx, union pfm_msg *msg)
+{
+	if (ctx->state == PFM_CTX_ZOMBIE) {
+		PFM_DBG("ignoring overflow notification, owner is zombie");
+		return 0;
+	}
+	PFM_DBG("waking up somebody");
+
+	wake_up_interruptible(&ctx->msgq_wait);
+
+	/*
+	 * it is safe to call kill_fasync() from an interrupt
+	 * handler. kill_fasync()  grabs two RW locks (fasync_lock,
+	 * tasklist_lock) in read mode. There is conflict only in
+	 * case the PMU interrupt occurs during a write mode critical
+	 * section. This cannot happen because for both locks, the
+	 * write mode is always using interrupt masking (write_lock_irq).
+	 */
+	kill_fasync (&ctx->async_queue, SIGIO, POLL_IN);
+
+	return 0;
+}
+
+int pfm_ovfl_notify_user(struct pfm_context *ctx,
+			struct pfm_event_set *set,
+	     		unsigned long ip)
+{
+	union pfm_msg *msg = NULL;
+	int max_cnt_pmd;
+	u64 *ovfl_pmds;
+
+	max_cnt_pmd = pfm_pmu_conf->max_cnt_pmd;
+
+	if (!ctx->flags.no_msg) {
+		msg = pfm_get_new_msg(ctx);
+		if (msg == NULL) {
+			/*
+			 * when message queue fills up it is because the user
+			 * did not extract the message, yet issued
+			 * pfm_restart(). At this point, we stop sending
+			 * notification, thus the user will not be able to get
+			 * new samples when using the default format.
+			 */
+			PFM_DBG_ovfl("no more notification msgs");
+			return -1;
+		}
+
+		msg->pfm_ovfl_msg.msg_type = PFM_MSG_OVFL;
+		msg->pfm_ovfl_msg.msg_ovfl_pid = current->pid;
+		msg->pfm_ovfl_msg.msg_active_set = set->id;
+
+		ovfl_pmds = msg->pfm_ovfl_msg.msg_ovfl_pmds;
+
+		bitmap_copy(ulp(ovfl_pmds), ulp(set->ovfl_pmds),
+			    max_cnt_pmd);
+
+		msg->pfm_ovfl_msg.msg_ovfl_cpu = smp_processor_id();
+		msg->pfm_ovfl_msg.msg_ovfl_tid = current->tgid;
+		msg->pfm_ovfl_msg.msg_ovfl_ip = ip;
+	}
+
+	PFM_DBG("ovfl msg: ip=0x%lx o_pmds=0x%llx",
+		ip,
+		(unsigned long long)set->ovfl_pmds[0]);
+
+	return pfm_notify_user(ctx, msg);
+}
+
+static int pfm_end_notify_user(struct pfm_context *ctx)
+{
+	union pfm_msg *msg;
+
+	msg = pfm_get_new_msg(ctx);
+	if (msg == NULL) {
+		PFM_ERR("%s no more msgs", __FUNCTION__);
+		return -1;
+	}
+	/* no leak */
+	memset(msg, 0, sizeof(*msg));
+
+	msg->type = PFM_MSG_END;
+
+	PFM_DBG("end msg: msg=%p no_msg=%d",
+		msg,
+		ctx->flags.no_msg);
+
+	return pfm_notify_user(ctx, msg);
+}
+
+/*
+ * called only from exit_thread(): task == current
+ * we come here only if current has a context
+ * attached (loaded or masked or zombie)
+ */
+void __pfm_exit_thread(struct task_struct *task)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int free_ok = 0;
+
+	ctx  = task->pfm_context;
+
+	BUG_ON(ctx->flags.system);
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	PFM_DBG("state=%d", ctx->state);
+
+	/*
+	 * __pfm_unload_context() cannot fail
+	 * in the context states we are interested in
+	 */
+	switch(ctx->state) {
+		case PFM_CTX_LOADED:
+		case PFM_CTX_MASKED:
+			__pfm_unload_context(ctx, 0);
+			pfm_end_notify_user(ctx);
+			break;
+		case PFM_CTX_ZOMBIE:
+			__pfm_unload_context(ctx, 0);
+			free_ok = 1;
+			break;
+		default:
+			BUG_ON(ctx->state != PFM_CTX_LOADED);
+			break;
+	}
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	/*
+	 * All memory free operations (especially for vmalloc'ed memory)
+	 * MUST be done with interrupts ENABLED.
+	 */
+	if (free_ok)
+		pfm_context_free(ctx);
+}
+
+static int pfm_cpu_notify(struct notifier_block *nfb,
+			  unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	int ret = NOTIFY_OK;
+
+	pfm_pmu_conf_get(0);
+
+	switch (action) {
+		case CPU_ONLINE:
+			pfm_sysfs_add_cpu(cpu);
+			PFM_INFO("CPU%d is online", cpu);
+			break;
+		case CPU_UP_PREPARE:
+			PFM_INFO("CPU%d prepare online", cpu);
+			break;
+		case CPU_UP_CANCELED:
+			pfm_sysfs_del_cpu(cpu);
+			PFM_INFO("CPU%d is up canceled", cpu);
+			break;
+		case CPU_DOWN_PREPARE:
+			PFM_INFO("CPU%d prepare offline", cpu);
+			break;
+		case CPU_DOWN_FAILED:
+			PFM_INFO("CPU%d is down failed", cpu);
+			break;
+		case CPU_DEAD:
+			pfm_sysfs_del_cpu(cpu);
+			PFM_INFO("CPU%d is offline", cpu);
+			break;
+	}
+	pfm_pmu_conf_put();
+	return ret;
+}
+
+static struct notifier_block pfm_cpu_notifier ={
+	.notifier_call = pfm_cpu_notify
+};
+
+/*
+ * called from cpu_init() and pfm_pmu_register()
+ */
+void __pfm_init_percpu (void *dummy)
+{
+	pfm_arch_init_percpu();
+}
+
+/*
+ * global initialization routine, executed only once
+ */
+int __init pfm_init(void)
+{
+	int ret;
+
+	PFM_LOG("version %u.%u", PFM_VERSION_MAJ, PFM_VERSION_MIN);
+
+	pfm_ctx_cachep = kmem_cache_create("pfm_context",
+				   sizeof(struct pfm_context)+PFM_ARCH_CTX_SIZE,
+				   SLAB_HWCACHE_ALIGN, 0, NULL, NULL);
+	if (pfm_ctx_cachep == NULL) {
+		PFM_ERR("cannot initialize context slab");
+		goto error_disable;
+	}
+	ret = pfm_sets_init();
+	if (ret)
+		goto error_disable;
+
+	if (pfm_init_fs())
+		goto error_disable;
+
+	/*
+	 * sysfs is not critical for normal operation, so
+	 * this is not a fatal error;
+	 */
+	pfm_init_sysfs();
+
+	/*
+	 * one time, arch-specific global initialization
+	 */
+	if (pfm_arch_init())
+		goto error_disable;
+
+	/*
+	 * register CPU hotplug event notifier
+	 */
+	ret = register_cpu_notifier(&pfm_cpu_notifier);
+	if (!ret)
+		return 0;
+
+error_disable:
+	PFM_INFO("perfmon is disabled due to initialization error");
+	atomic_set(&perfmon_disabled, 1);
+	return -1;
+}
+/*
+ * must use subsys_initcall() to ensure that the perfmon2 core
+ * is initialized before any PMU description module when they are
+ * compiled in.
+ */
+subsys_initcall(pfm_init);
+
+int __pfm_start(struct pfm_context *ctx, struct pfarg_start *start)
+{
+	struct task_struct *task, *owner_task;
+	struct pfm_event_set *new_set, *old_set;
+	u64 now;
+	int is_self;
+
+	task = ctx->task;
+
+	/*
+	 * context must be loaded.
+	 * we do not support starting while in MASKED state
+	 * (mostly because of set switching issues)
+	 */
+	if (ctx->state != PFM_CTX_LOADED)
+		return -EINVAL;
+
+	old_set = new_set = ctx->active_set;
+
+	/*
+	 * always the case for system-wide
+	 */
+	if (task == NULL)
+		task = current;
+
+	is_self = task == current;
+
+	/*
+	 * argument is provided?
+	 */
+	if (start) {
+		/*
+		 * find the set to load first
+		 */
+		new_set = pfm_find_set(ctx, start->start_set, 0);
+		if (new_set == NULL) {
+			PFM_DBG("event set%u does not exist",
+				start->start_set);
+			return -EINVAL;
+		}
+	}
+
+	PFM_DBG("cur_set=%u req_set=%u",
+		old_set->id,
+		new_set->id);
+
+	/*
+	 * if we need to change the active set we need
+	 * to check if we can access the PMU
+	 */
+	if (new_set != old_set) {
+		owner_task = __get_cpu_var(pmu_owner);
+		/*
+		 * system-wide: must run on the right CPU
+		 * per-thread : must be the owner of the PMU context
+		 *
+		 * pfm_switch_sets() returns with monitoring stopped
+		 */
+		if (is_self) {
+			pfm_switch_sets(ctx, new_set, PFM_PMD_RESET_LONG, 1);
+		} else {
+			/*
+			 * In a UP kernel, the PMU may contain the state
+			 * of the task we want to operate on, yet the task
+			 * may be switched out (lazy save). We need to save
+			 * current state (old_set), switch active_set and
+			 * mark it for reload.
+			 */
+			if (owner_task == task) {
+				pfm_modview_begin(old_set);
+				pfm_save_pmds(ctx, old_set);
+				pfm_modview_end(old_set);
+			}
+			ctx->active_set = new_set;
+			new_set->view->set_status |= PFM_SETVFL_ACTIVE;
+			new_set->priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
+		}
+	}
+	/*
+	 * mark as started, must be done before calling
+	 * pfm_arch_start()
+	 */
+	ctx->flags.started = 1;
+
+	/*
+	 * at this point, monitoring is:
+	 * 	- stopped if we switched set (self-monitoring)
+	 * 	- stopped if never started
+	 * 	- started if calling pfm_start() in sequence
+	 */
+	now = sched_clock();
+
+	pfm_arch_start(task, ctx, new_set);
+
+	/*
+	 * we restart total duration even if context was
+	 * already started. In that case, counts are simply
+	 * reset.
+	 *
+	 * For system-wide, we start counting even when we exclude
+	 * idle and pfm_start() called by idle.
+	 *
+	 * For per-thread, if not self-monitoring, the statement
+	 * below will have no effect because thread is stopped.
+	 * The field is reset of ctxsw in.
+	 *
+	 * if monitoring is masked (MASKED), this statement
+	 * will be overriden in pfm_unmask_monitoring()
+	 */
+	new_set->duration_start = now;
+
+	return 0;
+}
+
+int __pfm_stop(struct pfm_context *ctx)
+{
+	struct pfm_event_set *set;
+	struct task_struct *task;
+	u64 now;
+	int state;
+
+	now = sched_clock();
+	state = ctx->state;
+	set = ctx->active_set;
+
+	/*
+	 * context must be attached (zombie cannot happen)
+	 */
+	if (state == PFM_CTX_UNLOADED)
+		return -EINVAL;
+
+	task = ctx->task;
+
+	PFM_DBG("ctx_task=[%d] ctx_state=%d is_system=%d",
+		task ? task->pid : -1,
+		state,
+		ctx->flags.system);
+
+	/*
+	 * this happens for system-wide context
+	 */
+	if (task == NULL)
+		task = current;
+
+	/*
+	 * compute elapsed time
+	 * don't update set duration if masked
+	 */
+	if (task == current && state == PFM_CTX_LOADED)
+		set->duration += now - set->duration_start;
+
+	pfm_arch_stop(task, ctx, set);
+
+	ctx->flags.started = 0;
+
+
+	return 0;
+}
+
+int __pfm_restart(struct pfm_context *ctx)
+{
+	int state;
+
+	state = ctx->state;
+
+	if (state != PFM_CTX_MASKED && state != PFM_CTX_LOADED) {
+		PFM_DBG("invalid state=%d", state);
+		return -EBUSY;
+	}
+
+	switch(state) {
+		case PFM_CTX_MASKED:
+			break;
+		case PFM_CTX_LOADED:
+			if (ctx->smpl_addr && ctx->smpl_fmt->fmt_restart)
+				break;
+	}
+	/*
+	 * at this point, the context is either LOADED or MASKED
+	 */
+
+	if (ctx->task == current || ctx->flags.system) {
+		pfm_resume_after_ovfl(ctx);
+		return 0;
+	}
+
+	/*
+	 * restart another task
+	 */
+
+	/*
+	 * When PFM_CTX_MASKED, we cannot issue a restart before the previous
+	 * one is seen by the task.
+	 */
+	if (state == PFM_CTX_MASKED) {
+		if (!ctx->flags.can_restart) {
+			PFM_DBG("cannot restart can_restart=%d",
+				ctx->flags.can_restart);
+			return -EBUSY;
+		}
+		/*
+		 * prevent subsequent restart before this one is
+		 * seen by the task
+		 */
+		ctx->flags.can_restart = 0;
+	}
+
+	/*
+	 * if blocking, then post the semaphore is PFM_CTX_MASKED, i.e.
+	 * the task is blocked or on its way to block. That's the normal
+	 * restart path. If the monitoring is not masked, then the task
+	 * can be actively monitoring and we cannot directly intervene.
+	 * Therefore we use the trap mechanism to catch the task and
+	 * force it to reset the buffer/reset PMDs.
+	 *
+	 * if non-blocking, then we ensure that the task will go into
+	 * pfm_handle_work() before returning to user mode.
+	 *
+	 * We cannot explicitely reset another task, it MUST always
+	 * be done by the task itself. This works for system wide because
+	 * the tool that is controlling the session is logically doing
+	 * "self-monitoring".
+	 */
+	if (ctx->flags.block && state == PFM_CTX_MASKED) {
+		PFM_DBG("unblocking [%d]", ctx->task->pid);
+		complete(&ctx->restart_complete);
+	} else {
+		PFM_DBG("[%d] armed exit trap", ctx->task->pid);
+		ctx->flags.work_type = PFM_WORK_RESET;
+		set_tsk_thread_flag(ctx->task, TIF_PERFMON_WORK);
+	}
+	return 0;
+}
+
+
+
+/*
+ * should not call when task == current
+ */
+static int pfm_bad_permissions(struct task_struct *task)
+{
+	/* inspired by ptrace_attach() */
+	PFM_DBG("cur: euid=%d uid=%d gid=%d task: euid=%d "
+		"suid=%d uid=%d egid=%d cap:%d sgid=%d",
+		current->euid,
+		current->uid,
+		current->gid,
+		task->euid,
+		task->suid,
+		task->uid,
+		task->egid,
+		task->sgid, capable(CAP_SYS_PTRACE));
+
+	return ((current->uid != task->euid)
+	    || (current->uid != task->suid)
+	    || (current->uid != task->uid)
+	    || (current->gid != task->egid)
+	    || (current->gid != task->sgid)
+	    || (current->gid != task->gid)) && !capable(CAP_SYS_PTRACE);
+}
+
+
+/*
+ * cannot attach if :
+ * 	- kernel task
+ * 	- task not owned by caller
+ * 	- task incompatible with context mode
+ */
+static int pfm_task_incompatible(struct pfm_context *ctx,
+				 struct task_struct *task)
+{
+	/*
+	 * no kernel task or task not owned by caller
+	 */
+	if (!task->mm) {
+		PFM_DBG("cannot attach to kernel thread [%d]", task->pid);
+		return -EPERM;
+	}
+
+	if (pfm_bad_permissions(task)) {
+		PFM_DBG("no permission to attach to [%d]", task->pid);
+		return -EPERM;
+	}
+
+	/*
+	 * cannot block in self-monitoring mode
+	 */
+	if (ctx->flags.block && task == current) {
+		PFM_DBG("cannot load a in blocking mode on self for [%d]",
+			task->pid);
+		return -EINVAL;
+	}
+
+	if (task->state == EXIT_ZOMBIE || task->state == EXIT_DEAD) {
+		PFM_DBG("cannot attach to zombie/dead task [%d]", task->pid);
+		return -EBUSY;
+	}
+	return 0;
+}
+
+static int pfm_get_task(struct pfm_context *ctx, pid_t pid,
+			struct task_struct **task)
+{
+	struct task_struct *p;
+	int ret;
+
+	/*
+	 * When attaching to another thread we must ensure
+	 * that the thread is actually stopped. Just like with
+	 * perfmon system calls, we enforce that the thread 
+	 * be ptraced and STOPPED by using ptrace_check_attach()
+	 * As a consequence, only the ptracing parent can actually
+	 * attach a context to a thread. Obviously, this constraint
+	 * does not exist for self-monitoring threads.
+	 */
+	if (pid != current->pid) {
+		read_lock(&tasklist_lock);
+		p = find_task_by_pid(pid);
+		if (p)
+			get_task_struct(p);
+		read_unlock(&tasklist_lock);
+		if (p == NULL)
+			return -ESRCH;
+
+		preempt_disable();
+		local_irq_enable();
+
+		ret = ptrace_check_attach(p, 0);
+
+		local_irq_disable();
+		preempt_enable();
+
+		if (ret) {
+			put_task_struct(p);
+			return ret;
+		}
+	} else 
+		p = current;
+
+	ret = pfm_task_incompatible(ctx, p);
+	if (!ret) {
+		*task = p;
+	} else if (p != current)
+		put_task_struct(p);
+
+	return ret;
+}
+
+int __pfm_load_context(struct pfm_context *ctx, struct pfarg_load *req)
+{
+	struct pfm_event_set *set;
+	struct pfm_context *old;
+	struct task_struct *task;
+	int ret;
+
+	/*
+	 * locate first set to activate
+	 */
+	set = pfm_find_set(ctx, req->load_set, 0);
+	if (set == NULL) {
+		PFM_DBG("event set%u does not exist", req->load_set);
+		return -EINVAL;
+	}
+
+	/*
+	 * assess sanity of event sets, initialize set state
+	 */
+	ret = pfm_prepare_sets(ctx, set);
+	if (ret) {
+		PFM_DBG("invalid next field pointers in the sets");
+		return -EINVAL;
+	}
+
+	PFM_DBG("load_tgt=%d set=%u set_flags=0x%x",
+		req->load_pid,
+		set->id,
+		set->flags);
+
+	/*
+	 * per-thread: 
+	 *   check existence of task, and grab reference to it.
+	 *   As a side effect, the task refcount is incremented
+	 *   Reason for failing:
+	 * 	- pid does not exist
+	 * 	- permission denied
+	 * system-wide:
+	 *   check that runnig on requested CPU
+	 */
+	if (ctx->flags.system) {
+		if (req->load_pid != smp_processor_id()) {
+			PFM_DBG("running on wrong CPU: %u vs. %u",
+				smp_processor_id(), req->load_pid);
+			return -EINVAL;
+		}
+		ctx->cpu = smp_processor_id();
+		ctx->task = NULL;
+		task = current;
+	} else {
+		ret = pfm_get_task(ctx, req->load_pid, &task);
+		if (ret) {
+			PFM_DBG("load_tgt=%d get_task=%d", req->load_pid, ret);
+			return ret;
+		}
+
+		old = cmpxchg(&task->pfm_context, NULL, ctx);
+		if (old != NULL) {
+			PFM_DBG("load_tgt=%d already has a context "
+				"old=%p new=%p cur=%p",
+				req->load_pid,
+				old,
+				ctx,
+				task->pfm_context);
+			return -EEXIST;
+		}
+		ctx->task = task;
+		ctx->cpu = -1;
+		/*
+		 * now that we have a reference
+		 */
+		if (task != current)
+			put_task_struct(task);
+	}
+	/*
+	 * perfmon any architecture specific actions
+	 */
+	ret = pfm_arch_load_context(ctx, ctx->task);
+	if (ret)
+		goto error;
+
+	/*
+	 * now reserve the session, before we can proceed with
+	 * actually accessing the PMU hardware
+	 */
+	ret = pfm_reserve_session(ctx, ctx->cpu);
+	if (ret)
+		goto error;
+
+
+	/*
+	 * commit active set
+	 */
+	ctx->active_set = set;
+
+	pfm_modview_begin(set);
+
+	set->view->set_runs++;
+
+	set->view->set_status |= PFM_SETVFL_ACTIVE;
+
+	/*
+	 * self-monitoring (incl. system-wide)
+	 */
+	if (task == current) {
+		struct pfm_context *ctxp;
+		ctxp = __get_cpu_var(pmu_ctx);
+		if (ctxp)
+			pfm_save_prev_context(ctxp);
+		pfm_set_last_cpu(ctx, smp_processor_id());
+		pfm_inc_activation();
+		pfm_set_activation(ctx);
+
+		/*
+	 	 * we activate switch timeout callbacks to pfm_handle_switch_timeout()
+	 	 * even though the interface guarantees monitoring is inactive at
+	 	 * this point. The reason is that on some architectures (e.g., IA-64)
+	 	 * it is possible to start monitoring directly from user level without
+	 	 * the kernel knowing. In that case, the kernel would not be able to
+	 	 * active switch timeout when monitoring starts
+	 	 */
+		if (set->flags & PFM_SETFL_TIME_SWITCH)
+			__get_cpu_var(pfm_syst_info) = PFM_CPUINFO_TIME_SWITCH;
+
+		/*
+		 * load all PMD from set
+		 * load all PMC from set
+		 */
+		pfm_arch_restore_pmds(ctx, set);
+		pfm_arch_restore_pmcs(ctx, set);
+
+		/*
+		 * set new ownership
+		 */
+		pfm_set_pmu_owner(ctx->task, ctx);
+	} else {
+		/* force a full reload */
+		ctx->last_act = PFM_INVALID_ACTIVATION;
+		pfm_set_last_cpu(ctx, -1);
+		set->priv_flags |= PFM_SETFL_PRIV_MOD_BOTH;
+		PFM_DBG("context loaded next ctxswin for [%d]", task->pid);
+	}
+	pfm_modview_end(set);
+
+	if (!ctx->flags.system) {
+		set_tsk_thread_flag(task, TIF_PERFMON_CTXSW);
+		PFM_DBG("[%d] set TIF", task->pid);
+	}
+
+	ctx->flags.work_type = PFM_WORK_NONE;
+
+	/*
+	 * reset message queue
+	 */
+	pfm_reset_msgq(ctx);
+
+	ctx->state = PFM_CTX_LOADED;
+
+	return 0;
+error:
+	pfm_arch_unload_context(ctx, task);
+	/*
+	 * detach context
+	 */
+	if (!ctx->flags.system)
+		task->pfm_context = NULL;
+
+	return ret;
+}
+
+int __pfm_unload_context(struct pfm_context *ctx, int defer_release)
+{
+	struct task_struct *task;
+	struct pfm_event_set *set;
+	int prev_state, ret, is_self;
+
+	prev_state = ctx->state;
+
+	/*
+	 * unload only when necessary
+	 */
+	if (prev_state == PFM_CTX_UNLOADED)
+		return 0;
+
+	task = ctx->task;
+	set = ctx->active_set;
+	is_self = ctx->flags.system || task == current;
+
+	PFM_DBG("ctx_state=%d task [%d]", prev_state, task ? task->pid : -1);
+
+	/*
+	 * stop monitoring
+	 */
+	ret = __pfm_stop(ctx);
+	if (ret)
+		return ret;
+
+	pfm_modview_begin(set);
+	set->view->set_status &= ~PFM_SETVFL_ACTIVE;
+	pfm_modview_end(set);
+
+	ctx->state = PFM_CTX_UNLOADED;
+	ctx->flags.can_restart = 0;
+
+	/*
+	 * clear any leftover in pfm_syst_info.
+	 *
+	 * for non-self monitoring,
+	 * this is done in pfm_ctxswout_thread.
+	 */
+	if (is_self)
+		__get_cpu_var(pfm_syst_info) = 0;
+
+	/*
+	 * save PMD registers
+	 * release ownership
+	 */
+	pfm_flush_pmds(task, ctx);
+
+	/*
+	 * arch-specific unload operations
+	 */
+	pfm_arch_unload_context(ctx, task);
+
+	/*
+	 * per-thread: disconnect from monitored task
+	 * syswide   : keep ctx->cpu has it may be used after unload
+	 *             to release the session
+	 */
+	if (task) {
+		task->pfm_context = NULL;
+		ctx->task = NULL;
+		clear_tsk_thread_flag(task, TIF_PERFMON_CTXSW);
+	}
+	/*
+	 * at this point we are done with the PMU
+	 * so we can release the resource.
+	 *
+	 * when prev_state is ZOMBIE, we have already released
+	 */
+	if (prev_state != PFM_CTX_ZOMBIE && !defer_release)
+		pfm_release_session(ctx, ctx->cpu);
+
+	return 0;
+}
+
+static int pfm_ctx_flags_sane(u32 ctx_flags)
+{
+	if (ctx_flags & PFM_FL_SYSTEM_WIDE) {
+		if (ctx_flags & PFM_FL_NOTIFY_BLOCK) {
+			PFM_DBG("cannot use blocking mode in syswide mode");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+/*
+ * check for permissions to create a context
+ */
+static inline int pfm_ctx_permissions(u32 ctx_flags)
+{
+	if (  (ctx_flags & PFM_FL_SYSTEM_WIDE)
+	   && pfm_controls.sys_group != PFM_GROUP_PERM_ANY
+	   && !in_group_p(pfm_controls.sys_group)) {
+		PFM_DBG("user group not allowed to create a syswide ctx");
+		return -EPERM;
+	} else if (pfm_controls.task_group != PFM_GROUP_PERM_ANY
+		   && !in_group_p(pfm_controls.task_group)) {
+		PFM_DBG("user group not allowed to create a task context");
+		return -EPERM;
+	}
+	return 0;
+}
+
+int __pfm_create_context(struct pfarg_ctx *req,
+			 struct pfm_smpl_fmt *fmt,
+			 void *fmt_arg,
+			 int mode,
+			 struct pfm_context **new_ctx)
+{
+	struct pfm_context *ctx;
+	struct pfm_event_set *set;
+	struct file *filp = NULL;
+	u32 ctx_flags;
+	int fd = 0, ret;
+
+	ctx_flags = req->ctx_flags;
+
+	/* Increase refcount on PMU description */
+	ret = pfm_pmu_conf_get(1);
+	if (ret < 0)
+		goto error_conf;
+
+	ret = pfm_ctx_flags_sane(ctx_flags);
+	if (ret < 0)
+		goto error_alloc;
+
+	ret = pfm_ctx_permissions(ctx_flags);
+	if (ret < 0)
+		goto error_alloc;
+
+	ret = -ENOMEM;
+	ctx = kmem_cache_zalloc(pfm_ctx_cachep, SLAB_ATOMIC);
+	if (!ctx)
+		goto error_alloc;
+
+	/*
+	 * link to format, must be done first for correct
+	 * error handling in pfm_context_free()
+	 */
+	ctx->smpl_fmt = fmt;
+
+	ret = -ENFILE;
+	fd = pfm_alloc_fd(&filp);
+	if (fd < 0)
+		goto error_file;
+
+	/*
+	 * context is unloaded
+	 */
+	ctx->state = PFM_CTX_UNLOADED;
+
+	/*
+	 * initialization of context's flags
+	 * must be done before pfm_find_set()
+	 */
+	ctx->flags.block = (ctx_flags & PFM_FL_NOTIFY_BLOCK) ? 1 : 0;
+	ctx->flags.system = (ctx_flags & PFM_FL_SYSTEM_WIDE) ? 1: 0;
+	ctx->flags.no_msg = (ctx_flags & PFM_FL_OVFL_NO_MSG) ? 1: 0;
+	ctx->flags.mapset = (ctx_flags & PFM_FL_MAP_SETS) ? 1: 0;
+
+	INIT_LIST_HEAD(&ctx->list);
+
+	/*
+	 * initialize arch-specific section
+	 * must be done before fmt_init()
+	 *
+	 * XXX: fix dependency with fmt_init()
+	 */
+	ret = pfm_arch_context_initialize(ctx, ctx_flags);
+	if (ret)
+		goto error_set;
+
+	ret = -ENOMEM;
+	/*
+	 * create initial set
+	 */
+	if (pfm_find_set(ctx, 0, 1) == NULL)
+		goto error_set;
+
+	set = list_entry(ctx->list.next, struct pfm_event_set, list);
+
+	pfm_init_evtset(set);
+
+	/*
+	 * does the user want to sample?
+	 */
+	if (fmt) {
+		ret = pfm_setup_smpl_fmt(fmt, fmt_arg, ctx, ctx_flags,
+					 mode, filp);
+		if (ret)
+			goto error_set;
+	}
+
+	req->ctx_smpl_buf_size = ctx->smpl_size;
+
+	/*
+	 * attach context to file
+	 */
+	if (filp)
+		filp->private_data = ctx;
+
+	spin_lock_init(&ctx->lock);
+	init_completion(&ctx->restart_complete);
+
+	ctx->last_act = PFM_INVALID_ACTIVATION;
+	pfm_set_last_cpu(ctx, -1);
+
+	/*
+	 * initialize notification message queue
+	 */
+	ctx->msgq_head = ctx->msgq_tail = 0;
+	init_waitqueue_head(&ctx->msgq_wait);
+
+	PFM_DBG("ctx=%p flags=0x%x system=%d notify_block=%d no_msg=%d"
+		" use_fmt=%d remap=%d ctx_fd=%d mode=%d",
+		ctx,
+		ctx_flags,
+		ctx->flags.system,
+		ctx->flags.block,
+		ctx->flags.no_msg,
+		fmt != NULL,
+		ctx->flags.mapset,
+		fd, mode);
+
+	*new_ctx = ctx;
+
+	/*
+	 * we defer the fd_install until we are certain the call succeeded
+	 * to ensure we do not have to undo its effect. Neither put_filp()
+	 * nor put_unused_fd() undoes the effect of fd_install().
+	 */
+	fd_install(fd, filp);
+
+	req->ctx_fd = fd;
+
+	return 0;
+
+error_set:
+	put_filp(filp);
+	put_unused_fd(fd);
+error_file:
+	/* calls the right *_put() functions */
+	pfm_context_free(ctx);
+	return ret;
+
+error_alloc:
+	pfm_pmu_conf_put();
+error_conf:
+	pfm_smpl_fmt_put(fmt);
+	return ret;
+}
+
+/*
+ * called from __cpu_disable()
+ * We cannot use the cpu hotplug notifier because we MUST run
+ * on the CPU that is going down to save some PMU state
+ */
+void __pfm_cpu_disable(void)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int ret = 0;
+
+	ctx = __get_cpu_var(pmu_ctx);
+	if (ctx == NULL)
+		return;
+	/*
+	 * context is LOADED or MASKED
+	 *
+	 * we unload from CPU. That stops monitoring and does
+	 * all the bookeeping of saving values and updating duration
+	 */
+	spin_lock_irqsave(&ctx->lock, flags);
+	if (ctx->flags.system)
+		ret = __pfm_unload_context(ctx, 0);
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	PFM_DBG("unload=%d", ret);
+}
--- linux-2.6.18.base/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.18/perfmon/Makefile	2006-09-22 01:58:48.000000000 -0700
@@ -0,0 +1,8 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+obj-$(CONFIG_PERFMON) = perfmon.o perfmon_rw.o perfmon_res.o perfmon_fmt.o \
+			perfmon_pmu.o perfmon_sysfs.o perfmon_syscalls.o   \
+			perfmon_file.o perfmon_ctxsw.o perfmon_intr.o	   \
+			perfmon_dfl_smpl.o perfmon_sets.o
