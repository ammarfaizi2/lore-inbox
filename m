Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968169AbWLELIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968169AbWLELIV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 06:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967999AbWLELIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 06:08:20 -0500
Received: from gundega.hpl.hp.com ([192.6.19.190]:59837 "EHLO
	gundega.hpl.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968168AbWLELIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 06:08:12 -0500
Date: Tue, 5 Dec 2006 03:07:14 -0800
From: Stephane Eranian <eranian@frankl.hpl.hp.com>
Message-Id: <200612051107.kB5B7Epk017625@frankl.hpl.hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/21] 2.6.19 perfmon2 : common core functions
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




--- linux-2.6.19.base/include/linux/perfmon.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/include/linux/perfmon.h	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,818 @@
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
+#define PFM_SETFL_TIME_SWITCH	0x02 /* enable switch on timeout */
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
+#define PFM_REG_RETFL_NOTAVAIL	(1<<31) /* not implemented or unaccessible */
+#define PFM_REG_RETFL_EINVAL	(1<<30) /* entry is invalid */
+#define PFM_REG_RETFL_NOSET	(1<<29) /* event set does not exist */
+#define PFM_REG_RETFL_MASK	(PFM_REG_RETFL_NOTAVAIL|\
+				 PFM_REG_RETFL_EINVAL|\
+				 PFM_REG_RETFL_NOSET)
+
+#define PFM_REG_HAS_ERROR(flag)	(((flag) & PFM_REG_RETFL_MASK) != 0)
+
+/*
+ * argument to pfm_create_context() system call
+ * structure shared with user level
+ */
+struct pfarg_ctx {
+	__u32		ctx_flags;	  /* noblock/block/syswide */
+	__u32		ctx_reserved1;	  /* ret arg: fd for context */
+	__u64		ctx_reserved2[7]; /* for future use */
+};
+
+/*
+ * context flags (ctx_flags)
+ *
+ */
+#define PFM_FL_NOTIFY_BLOCK    	 0x01	/* block task on user notifications */
+#define PFM_FL_SYSTEM_WIDE	 0x02	/* create a system wide context */
+#define PFM_FL_OVFL_NO_MSG	 0x80   /* no overflow msgs */
+#define PFM_FL_MAP_SETS		 0x10	/* event sets are remapped */
+
+/*
+ * argument to pfm_write_pmcs() system call.
+ * structure shared with user level
+ */
+struct pfarg_pmc {
+	__u16 reg_num;		/* which register */
+	__u16 reg_set;		/* event set for this register */
+	__u32 reg_flags;	/* input: flags, return: reg error */
+	__u64 reg_value;	/* pmc value */
+	__u64 reg_reserved2[4];	/* for future use */
+};
+
+/*
+ * argument to pfm_write_pmds() and pfm_read_pmds() system calls.
+ * structure shared with user level
+ */
+struct pfarg_pmd {
+	__u16 reg_num;	   	/* which register */
+	__u16 reg_set;	   	/* event set for this register */
+	__u32 reg_flags; 	/* input: flags, return: reg error */
+	__u64 reg_value;	/* initial pmc/pmd value */
+	__u64 reg_long_reset;	/* value to reload after notification */
+	__u64 reg_short_reset;  /* reset after counter overflow */
+	__u64 reg_last_reset_val;	/* return: PMD last reset value */
+	__u64 reg_ovfl_switch_cnt;	/* #overflows before switch */
+	__u64 reg_reset_pmds[PFM_PMD_BV]; /* reset on overflow */
+	__u64 reg_smpl_pmds[PFM_PMD_BV];  /* record in sample */
+	__u64 reg_smpl_eventid; /* opaque event identifier */
+	__u64 reg_random_mask; 	/* bitmask used to limit random value */
+	__u32 reg_random_seed;  /* seed for randomization (OBSOLETE) */
+	__u32 reg_reserved2[7];	/* for future use */
+};
+
+/*
+ * optional argument to pfm_start() system call. Pass NULL if not needed.
+ * structure shared with user level
+ */
+struct pfarg_start {
+	__u16 start_set;	/* event set to start with */
+	__u16 start_reserved1;	/* for future use */
+	__u32 start_reserved2;	/* for future use */
+	__u64 reserved3[3];	/* for future use */
+};
+
+/*
+ * argument to pfm_load_context() system call.
+ * structure shared with user level
+ */
+struct pfarg_load {
+	__u32	load_pid;	   /* thread or CPU to attach to */
+	__u16	load_set;	   /* set to load first */
+	__u16	load_reserved1;	   /* for future use */
+	__u64	load_reserved2[3]; /* for future use */
+};
+
+/*
+ * argument to pfm_create_evtsets() and pfm_delete_evtsets() system calls.
+ * structure shared with user level.
+ */
+struct pfarg_setdesc {
+	__u16	set_id;		  /* which set */
+	__u16	set_id_next;	  /* next set to go to */
+	__u32	set_flags; 	  /* input: flags, return: err flag  */
+	__u64	set_timeout;	  /* req/eff switch timeout in nsecs */
+	__u64	set_mmap_offset;  /* ret arg: cookie for mmap offset */
+	__u64	reserved[5];	  /* for future use */
+};
+
+/*
+ * argument to pfm_getinfo_evtsets() system call.
+ * structure shared with user level
+ */
+struct pfarg_setinfo {
+	__u16	set_id;             /* which set */
+	__u16	set_id_next;        /* out: next set to go to */
+	__u32	set_flags;	    /* out:flags or error */
+	__u64 	set_ovfl_pmds[PFM_PMD_BV]; /* out: last ovfl PMDs */
+	__u64	set_runs;            /* out: #times the set was active */
+	__u64	set_timeout;         /* out: effective/leftover switch timeout in nsecs */
+	__u64	set_act_duration;    /* out: time set was active in nsecs */
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
+ * remapped set view. structure shared with user level via remapping
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
+/*
+ * pfm_set_view status flags
+ */
+#define PFM_SETVFL_ACTIVE	0x1 /* set is active */
+
+/*
+ * overflow notification message.
+ * structure shared with user level
+ */
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
+/*
+ * generic notification message (union).
+ * union shared with user level
+ */
+union pfm_msg {
+	__u32	type;
+	struct pfm_ovfl_msg	pfm_ovfl_msg;
+};
+
+/*
+ * perfmon version number
+ */
+#define PFM_VERSION_MAJ		 2U
+#define PFM_VERSION_MIN		 3U
+#define PFM_VERSION		 (((PFM_VERSION_MAJ&0xffff)<<16)|\
+				  (PFM_VERSION_MIN & 0xffff))
+#define PFM_VERSION_MAJOR(x)	 (((x)>>16) & 0xffff)
+#define PFM_VERSION_MINOR(x)	 ((x) & 0xffff)
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
+#define PFM_MSGS_ORDER		3 /* log2(number of messages) */
+#define PFM_MSGS_COUNT		(1<<PFM_MSGS_ORDER) /* number of messages */
+#define PFM_MSGQ_MASK		(PFM_MSGS_COUNT-1)
+
+/*
+ * type of PMD reset for pfm_reset_pmds() or pfm_switch_sets()
+ */
+#define PFM_PMD_RESET_NONE	0	/* do not reset (pfm_switch_sets) */
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
+	size_t	arg_mem_max;	/* maximum vector argument size */
+	size_t	smpl_buffer_mem_max; /* max buf mem, -1 for infinity */
+	int pmd_read;
+};
+
+DECLARE_PER_CPU(unsigned long, pfm_syst_info);
+DECLARE_PER_CPU(struct task_struct *, pmu_owner);
+DECLARE_PER_CPU(struct pfm_context *, pmu_ctx);
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
+#ifdef CONFIG_PERFMON_DEBUG
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
+	u32 flags;		/* public set flags */
+
+	struct list_head list;		/* next in the ordered list */
+	struct pfm_event_set *sw_next;	/* address of set to go to */
+	u32 priv_flags;		/* private flags */
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
+	unsigned int work_type:2;	/* type of work for pfm_handle_work */
+	unsigned int mmap_nlock:1;	/* no lock in pfm_release_buf_space */
+	unsigned int reserved:19;	/* for future use */
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
+
+/*
+ * perfmon context: encapsulates all the state of a monitoring session
+ */
+struct pfm_context {
+	spinlock_t		lock;	/* context protection */
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
+	union pfm_msg		msgq[PFM_MSGS_COUNT];
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
+static inline struct pfm_arch_context *pfm_ctx_arch(struct pfm_context *c)
+{
+	return (struct pfm_arch_context *)(c+1);
+}
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
+int  pfm_get_args(void __user *ureq, size_t sz, size_t lsz, void *laddr,
+		  void **req, void **to_free);
+
+int pfm_get_task(struct pfm_context *ctx, pid_t pid, struct task_struct **task);
+int pfm_get_smpl_arg(char __user *fmt_uname, void __user *uaddr, size_t usize, void **arg,
+		     struct pfm_smpl_fmt **fmt);
+
+int pfm_alloc_fd(struct file **cfile);
+
+int __pfm_write_pmcs(struct pfm_context *ctx, struct pfarg_pmc *req, int count);
+int __pfm_write_pmds(struct pfm_context *ctx, struct pfarg_pmd *req, int count,
+		     int compat);
+int __pfm_read_pmds(struct pfm_context *ctx, struct pfarg_pmd *req, int count);
+int __pfm_load_context(struct pfm_context *ctx, struct pfarg_load *req,
+		       struct task_struct *task);
+int __pfm_unload_context(struct pfm_context *ctx, int *can_release);
+int __pfm_stop(struct pfm_context *ctx);
+int  __pfm_restart(struct pfm_context *ctx);
+int __pfm_start(struct pfm_context *ctx, struct pfarg_start *start);
+int __pfm_delete_evtsets(struct pfm_context *ctx, void *arg, int count);
+int __pfm_getinfo_evtsets(struct pfm_context *ctx, struct pfarg_setinfo *req,
+			  int count);
+int __pfm_create_evtsets(struct pfm_context *ctx, struct pfarg_setdesc *req,
+			int count);
+
+int __pfm_create_context(struct pfarg_ctx *req,
+			 struct pfm_smpl_fmt *fmt,
+			 void *fmt_arg,
+			 int mode,
+			 struct pfm_context **new_ctx);
+
+int pfm_check_task_state(struct pfm_context *ctx, int check_mask,
+			 unsigned long *flags);
+
+struct pfm_event_set *pfm_find_set(struct pfm_context *ctx, u16 set_id,
+				   int alloc);
+
+struct pfm_context *pfm_get_ctx(int fd);
+
+void pfm_context_free(struct pfm_context *ctx);
+struct pfm_context *pfm_context_alloc(void);
+int pfm_pmu_conf_get(int autoload);
+void pfm_pmu_conf_put(void);
+
+int pfm_reserve_session(int is_system, u32 cpu);
+int pfm_release_session(int is_system, u32 cpu);
+
+int pfm_smpl_buffer_alloc(struct pfm_context *ctx, size_t rsize);
+int pfm_reserve_buf_space(size_t size);
+void pfm_release_buf_space(struct pfm_context *ctx, size_t size);
+
+struct pfm_smpl_fmt *pfm_smpl_fmt_get(char *name);
+void pfm_smpl_fmt_put(struct pfm_smpl_fmt *fmt);
+
+int  pfm_init_sysfs(void);
+ssize_t pfm_sysfs_session_show(char *buf, size_t sz, int what);
+int pfm_sysfs_remove_pmu(struct _pfm_pmu_config *pmu);
+int pfm_sysfs_add_pmu(struct _pfm_pmu_config *pmu);
+
+int pfm_sysfs_add_fmt(struct pfm_smpl_fmt *fmt);
+int pfm_sysfs_remove_fmt(struct pfm_smpl_fmt *fmt);
+
+int pfm_sysfs_add_cpu(int mycpu);
+void pfm_sysfs_del_cpu(int mycpu);
+
+void pfm_interrupt_handler(unsigned long iip, struct pt_regs *regs);
+void pfm_save_prev_context(struct pfm_context *ctxp);
+
+void pfm_reset_pmds(struct pfm_context *ctx, struct pfm_event_set *set,
+		    int reset_mode);
+
+void __pfm_handle_switch_timeout(void);
+int pfm_prepare_sets(struct pfm_context *ctx, struct pfm_event_set *act_set);
+int pfm_sets_init(void);
+
+int pfm_mmap_set(struct pfm_context *ctx, struct vm_area_struct *vma,
+		 size_t size);
+
+void pfm_free_sets(struct pfm_context *ctx);
+void pfm_init_evtset(struct pfm_event_set *set);
+void pfm_switch_sets(struct pfm_context *ctx,
+		    struct pfm_event_set *new_set,
+		    int reset_mode,
+		    int no_restart);
+
+void pfm_save_pmds(struct pfm_context *ctx, struct pfm_event_set *set);
+void pfm_mask_monitoring(struct pfm_context *ctx);
+int pfm_ovfl_notify_user(struct pfm_context *ctx,
+			struct pfm_event_set *set,
+	     		unsigned long ip);
+
+int pfm_init_fs(void);
+
+#define PFM_MAX_NUM_SETS		65536
+#define PFM_SET_REMAP_SCALAR		PAGE_SIZE
+#define PFM_SET_REMAP_OFFS		16384	/* number of pages to offset */
+#define PFM_SET_REMAP_BASE		(PFM_SET_REMAP_OFFS*PAGE_SIZE)
+#define PFM_SET_REMAP_OFFS_MAX		(PFM_SET_REMAP_OFFS+\
+					 PFM_MAX_NUM_SETS*PFM_SET_REMAP_SCALAR)
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
+	u64 pfm_idle_start;
+	u64 pfm_idle_stop;
+	u64 pfm_ccnt0;
+	u64 pfm_ccnt1;
+	u64 pfm_ccnt2;
+	u64 pfm_ccnt3;
+	u64 pfm_ccnt4;
+	struct kobject kobj;		/* for sysfs internal use only */
+};
+#define to_stats(n) container_of(n, struct pfm_stats, kobj)
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
+	bv[rnum>>PFM_LBPL] |= 1ULL << (rnum&(PFM_BPL-1));
+}
+
+static inline int pfm_bv_isset(u64 *bv, unsigned int rnum)
+{
+	return bv[rnum>>PFM_LBPL] & (1ULL<<(rnum&(PFM_BPL-1))) ? 1 : 0;
+}
+
+static inline void pfm_bv_clear(u64 *bv, unsigned int rnum)
+{
+	bv[rnum>>PFM_LBPL] &= ~(1ULL<< (rnum&(PFM_BPL-1)));
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
+
+void __pfm_exit_thread(struct task_struct *task);
+void __pfm_copy_thread(struct task_struct *task);
+void __pfm_ctxsw(struct task_struct *prev, struct task_struct *next);
+void __pfm_handle_work(void);
+void __pfm_handle_switch_timeout(void);
+void __pfm_init_percpu (void *dummy);
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
+
+static inline void pfm_cpu_disable(void)
+{
+	__pfm_cpu_disable();
+}
+
+static inline int pfm_msgq_is_empty(struct pfm_context *ctx)
+{
+	return ctx->msgq_head == ctx->msgq_tail;
+}
+
+#endif /* __KERNEL__ */
+
+#else /* !CONFIG_PERFMON */
+#ifdef __KERNEL__
+
+#define tsks_have_perfmon(p, n)	(0)
+#define pfm_cpu_disable()		do { } while (0)
+#define pfm_init_percpu()		do { } while (0)
+#define pfm_exit_thread(_t)  		do { } while (0)
+#define pfm_handle_work(_t)    		do { } while (0)
+#define pfm_copy_thread(_t)		do { } while (0)
+#define pfm_ctxsw(_p, _t)     		do { } while (0)
+#define pfm_handle_switch_timeout()  	do { } while (0)
+#ifdef __ia64__
+#define pfm_release_dbregs(_t) 		do { } while (0)
+#define pfm_use_dbregs(_t)     		(0)
+#endif
+
+#endif /* __KERNEL__ */
+
+#endif /* CONFIG_PERFMON */
+
+#endif /* __LINUX_PERFMON_H__ */
--- linux-2.6.19.base/perfmon/perfmon.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/perfmon/perfmon.c	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,1685 @@
+/*
+ * perfmon.c: perfmon2 core functions
+ *
+ * This file implements the perfmon2 interface which
+ * provides access to the hardware performance counters
+ * of the host processor.
+ *
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
+#include <linux/random.h>
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
+	int next;
+
+	next = ctx->msgq_head & PFM_MSGQ_MASK;
+
+	if ((ctx->msgq_head - ctx->msgq_tail) == PFM_MSGS_COUNT)
+		return NULL;
+
+	/*
+	 * move to next possible slot
+	 */
+	ctx->msgq_head++;
+
+	PFM_DBG("head=%d tail=%d msg=%d",
+		ctx->msgq_head & PFM_MSGQ_MASK,
+		ctx->msgq_tail & PFM_MSGQ_MASK,
+		next);
+
+	return ctx->msgq+next;
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
+		pfm_release_buf_space(ctx, ctx->smpl_size);
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
+		if (mode == PFM_COMPAT)
+			ret = pfm_smpl_buffer_alloc_compat(ctx, size, filp);
+		else
+			ret = pfm_smpl_buffer_alloc(ctx, size);
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
+	pfm_release_buf_space(ctx, ctx->smpl_size);
+	/*
+	 * we do not call fmt_exit, if init has failed
+	 */
+	vfree(ctx->smpl_addr);
+error:
+	return ret;
+}
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
+	 * align page boundary
+	 */
+	size = PAGE_ALIGN(rsize);
+
+	PFM_DBG("buffer req_size=%zu actual_size=%zu before", rsize, size);
+
+	ret = pfm_reserve_buf_space(size);
+	if (ret)
+		return ret;
+
+	PFM_DBG("buffer req_size=%zu actual_size=%zu after", rsize, size);
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
+	PFM_DBG("buffer req_size=%zu actual_size=%zu error", rsize, size);
+	pfm_release_buf_space(ctx, size);
+	return -ENOMEM;
+}
+
+static inline u64 pfm_new_pmd_value (struct pfm_pmd *reg, int reset_mode)
+{
+	u64 val, mask;
+	u64 new_seed;
+
+	val = reset_mode == PFM_PMD_RESET_LONG ? reg->long_reset : reg->short_reset;
+
+	if (reg->flags & PFM_REGFL_RANDOM) {
+		mask = reg->mask;
+		new_seed = random32();
+
+		/* construct a full 64-bit random value: */
+		if ((unlikely(mask >> 32) != 0))
+			new_seed |= (u64)random32() << 32;
+
+		/* counter values are negative numbers! */
+		val -= (new_seed & mask);
+	}
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
+		if (pfm_bv_isset(reset_pmds, i)) {
+
+			val = pfm_new_pmd_value(set->pmds + i, reset_mode);
+
+			set->view->set_pmds[i]= val;
+			set->pmds[i].lval = val;
+
+			/*
+			 * not all PMD to reset are necessarily
+			 * counters
+			 */
+			if (not_masked) {
+				if (pfm_bv_isset(cnt_mask, i))
+					hw_val = val & ovfl_mask;
+				else
+					hw_val = val;
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
+/*
+ * called from pfm_handle_work() and __pfm_restart()
+ * for system-wide and per-thread context to resume
+ * monitoring after a user level notification.
+ *
+ * In both cases, the context is locked and interrupts
+ * are disabled.
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
+	} else
+		rst_ctrl= PFM_OVFL_CTRL_RESET;
+
+	/*
+	 * if using a sampling buffer format and it has a restart callback,
+	 * then invoke it. hdr may be NULL, it the format does not use a
+	 * perfmon buffer
+	 */
+	if (fmt && fmt->fmt_restart)
+		ret = (*fmt->fmt_restart)(state == PFM_CTX_LOADED, &rst_ctrl, hdr);
+
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
+		if (!(rst_ctrl & PFM_OVFL_CTRL_MASK))
+			pfm_unmask_monitoring(ctx);
+		else
+			PFM_DBG("stopping monitoring?");
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
+ * This function is called when we need to perfmon asynchronous
+ * work on a context. This function is called ONLY when about to
+ * return to user mode (very much like with signals handling).
+ *
+ * There are several reasons why we come here:
+ *
+ *  - per-thread mode, not self-monitoring, to reset the counters
+ *    after a pfm_restart() by the thread controlling the context
+ *
+ *  - because we are zombie and we need to cleanup our state
+ *
+ *  - because we need to block after an overflow notification
+ *    as requested by user with the PFM_OVFL_NOTIFY_BLOCK flag
+ *
+ * This function is never called for a system-wide context.
+ *
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
+	int type, ret, can_release;
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
+	 * Could be enabled/disabled.
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
+	/*
+	 * restore flags as they were upon entry
+	 */
+	spin_unlock_irqrestore(&ctx->lock, flags);
+	return;
+
+do_zombie:
+	PFM_DBG("context is zombie, bailing out");
+
+	__pfm_unload_context(ctx, &can_release);
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
+
+	/* always true) */
+	if (can_release)
+		pfm_release_session(0, 0);
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
+/*
+ * send a counter overflow notification message to
+ * user. First appends the message to the queue, then
+ * wake up ay waiter on the file descriptor
+ *
+ * context is locked and interrupts are disabled (no preemption).
+ */
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
+/*
+ * In per-thread mode, when not self-monitoring, perfmon
+ * send a 'end' notification message when the monitored
+ * thread where the context is attached is exiting.
+ *
+ * This helper message alleviate the need to track the activity
+ * of the thread/process when it is not directly related, i.e.,
+ * was attached vs was forked/execd.
+ *
+ * This function appends the 'end' notification message to the
+ * queue. 
+ *
+ * the context must be locked and interrupts disabled.
+ */
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
+	int free_ok = 0, can_release = 0;
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
+	switch (ctx->state) {
+	case PFM_CTX_LOADED:
+	case PFM_CTX_MASKED:
+		__pfm_unload_context(ctx, &can_release);
+		pfm_end_notify_user(ctx);
+		break;
+	case PFM_CTX_ZOMBIE:
+		__pfm_unload_context(ctx, &can_release);
+		free_ok = 1;
+		break;
+	default:
+		BUG_ON(ctx->state != PFM_CTX_LOADED);
+		break;
+	}
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (can_release)
+		pfm_release_session(0, 0);
+
+	/*
+	 * All memory free operations (especially for vmalloc'ed memory)
+	 * MUST be done with interrupts ENABLED.
+	 */
+	if (free_ok)
+		pfm_context_free(ctx);
+}
+
+/*
+ * CPU hotplug event nofication callback
+ *
+ * We use the callback to do manage the sysfs interface.
+ * Note that the actual shutdown of monitoring on the CPU
+ * is done in __pfm_cpu_disable(), see comments there for more
+ * information.
+ */
+static int pfm_cpu_notify(struct notifier_block *nfb,
+			  unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	int ret = NOTIFY_OK;
+
+	pfm_pmu_conf_get(0);
+
+	switch (action) {
+	case CPU_ONLINE:
+		pfm_sysfs_add_cpu(cpu);
+		PFM_INFO("CPU%d is online", cpu);
+		break;
+	case CPU_UP_PREPARE:
+		PFM_INFO("CPU%d prepare online", cpu);
+		break;
+	case CPU_UP_CANCELED:
+		pfm_sysfs_del_cpu(cpu);
+		PFM_INFO("CPU%d is up canceled", cpu);
+		break;
+	case CPU_DOWN_PREPARE:
+		PFM_INFO("CPU%d prepare offline", cpu);
+		break;
+	case CPU_DOWN_FAILED:
+		PFM_INFO("CPU%d is down failed", cpu);
+		break;
+	case CPU_DEAD:
+		pfm_sysfs_del_cpu(cpu);
+		PFM_INFO("CPU%d is offline", cpu);
+		break;
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
+void __pfm_init_percpu(void *dummy)
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
+
+/*
+ * must use subsys_initcall() to ensure that the perfmon2 core
+ * is initialized before any PMU description module when they are
+ * compiled in.
+ */
+subsys_initcall(pfm_init);
+
+/*
+ * function used to start monitoring. When operating in per-thread
+ * mode and when not self-monitoring, the monitored thread must be
+ * stopped.
+ *
+ * The pfarg_start argument is optional and may be used to designate
+ * the initial event set to activate. Wehn missing, the last active
+ * set is used. For the first activation, set0 is used.
+ *
+ * On some architectures, e.g., IA-64, it may be possible to start monitoring
+ * without calling this function under certain conditions (per-thread and self
+ * monitoring).
+ *
+ * the context is locked and interrupts are disabled.
+ */
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
+/*
+ * function used to stop monitoring. When operating in per-thread
+ * mode and when not self-monitoring, the monitored thread must be
+ * stopped.
+ *
+ * the context is locked and interrupts are disabled.
+ */
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
+	return 0;
+}
+
+/*
+ * function called from sys_pfm_restart(). It is used when overflow
+ * notification is requested. For each notification received, the user
+ * must call pfm_restart() to indicate to the kernel that it is done
+ * processing the notification.
+ *
+ * When the caller is doing user level sampling, this function resets
+ * the overflowed counters and resumes monitoring which is normally stopped
+ * during notification (always the consequence of a counter overflow).
+ *
+ * When using a sampling format, the format restart() callback is invoked,
+ * overflowed PMDS may be reset based upon decision from sampling format.
+ *
+ * When operating in per-thread mode, and when not self-monitoring, the
+ * monitored thread DOES NOT need to be stopped, unlike many other calls.
+ * This means that the effect of the restart may not necessilry be observed
+ * right when returning from the call. For instance, counters may not already
+ * be reset in the other thread.
+ *
+ * When operating in system-wide, the caller must be running on the monitored
+ * CPU.
+ *
+ * The context is locked and interrupts are disabled.
+ */
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
+	switch (state) {
+	case PFM_CTX_MASKED:
+		break;
+	case PFM_CTX_LOADED:
+		if (ctx->smpl_addr && ctx->smpl_fmt->fmt_restart)
+			break;
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
+/*
+ * function used to attach a context to either a CPU or a thread.
+ * In per-thread mode, and when not self-monitoring, the thread must be
+ * stopped. In system-wide mode, the cpu specified in the pfarg_load.load_tgt
+ * argument must be the current CPU.
+ *
+ * The function must be called with the context locked and interrupts disabled.
+ */
+int __pfm_load_context(struct pfm_context *ctx, struct pfarg_load *req,
+		       struct task_struct *task)
+{
+	struct pfm_event_set *set;
+	struct pfm_context *old;
+	int mycpu;
+	int ret;
+
+	mycpu = smp_processor_id();
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
+	PFM_DBG("load_pid=%d set=%u set_flags=0x%x",
+		req->load_pid,
+		set->id,
+		set->flags);
+
+	/*
+	 * per-thread: 
+	 *   - task to attach to is checked in sys_pfm_load_context() to avoid
+	 *     locking issues. if found, and not self,  task refcount was incremented.
+	 * system-wide:
+	 *   - check running on requested CPU
+	 */
+	if (ctx->flags.system) {
+		if (req->load_pid != mycpu) {
+			PFM_DBG("running on wrong CPU: %u vs. %u",
+				mycpu, req->load_pid);
+			return -EINVAL;
+		}
+		ctx->cpu = mycpu;
+		ctx->task = NULL;
+		task = current;
+	} else {
+		old = cmpxchg(&task->pfm_context, NULL, ctx);
+		if (old != NULL) {
+			PFM_DBG("load_pid=%d has a context "
+				"old=%p new=%p cur=%p",
+				req->load_pid,
+				old,
+				ctx,
+				task->pfm_context);
+			return -EEXIST;
+		}
+		ctx->task = task;
+		ctx->cpu = -1;
+	}
+
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
+	ret = pfm_reserve_session(ctx->flags.system, ctx->cpu);
+	if (ret)
+		goto error;
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
+		pfm_set_last_cpu(ctx, mycpu);
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
+		 * load PMD from set
+		 * load PMC from set
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
+	ctx->msgq_head = ctx->msgq_tail = 0;
+
+	ctx->state = PFM_CTX_LOADED;
+
+	return 0;
+
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
+/*
+ * Function used to detach a context from either a CPU or a thread.
+ * In the per-thread case and when not self-monitoring, the thread must be
+ * stopped. After the call, the context is detached and monitoring is stopped.
+ *
+ * The function must be called with the context locked and interrupts disabled.
+ */
+int __pfm_unload_context(struct pfm_context *ctx, int *can_release)
+{
+	struct task_struct *task;
+	struct pfm_event_set *set;
+	int ret, is_self;
+
+	PFM_DBG("ctx_state=%d task [%d]", ctx->state, ctx->task ? ctx->task->pid : -1);
+
+	*can_release = 0;
+
+	/*
+	 * unload only when necessary
+	 */
+	if (ctx->state == PFM_CTX_UNLOADED)
+		return 0;
+
+	task = ctx->task;
+	set = ctx->active_set;
+	is_self = ctx->flags.system || task == current;
+
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
+
+	*can_release = 1;
+#if 0
+	/*
+	 * at this point we are done with the PMU
+	 * so we can release the resource.
+	 *
+	 * Applies also when was ZOMBIE
+	 */
+	pfm_release_session(ctx->flags.system, ctx->cpu);
+#endif
+
+	return 0;
+}
+
+static inline int pfm_ctx_flags_sane(u32 ctx_flags)
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
+ * A sysadmin may decide to restrict creation of per-thread
+ * and/or system-wide context to a group of users using the group id.
+ *
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
+/*
+ * function used to allocate a new context. A context is allocated along
+ * with the default event set. If a sampling format is used, the buffer
+ * may be allocated and initialized.
+ *
+ * The file descriptor identifying the context is allocated and returned
+ * to caller.
+ *
+ * This function operates with no locks and interrupts are enabled.
+ * return:
+ * 	>=0: the file descriptor to identify the context
+ * 	<0 : the error code
+ */
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
+	/*
+	 * we can use SLAB_KERNEL and potentially sleep because we do
+	 * not hold any lock at this point.
+	 */
+	might_sleep();
+	ret = -ENOMEM;
+	ctx = kmem_cache_zalloc(pfm_ctx_cachep, SLAB_KERNEL);
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
+	filp->private_data = ctx;
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
+	return fd;
+
+error_set:
+	put_filp(filp);
+	put_unused_fd(fd);
+error_file:
+	/* calls the right *_put() functions */
+	pfm_context_free(ctx);
+	return ret;
+error_alloc:
+	pfm_pmu_conf_put();
+error_conf:
+	pfm_smpl_fmt_put(fmt);
+	return ret;
+}
+
+/*
+ * called from __cpu_disable() to detach the perfmon context
+ * from the CPU going down.
+ *
+ * We cannot use the cpu hotplug notifier because we MUST run
+ * on the CPU that is going down to save the PMU state
+ */
+void __pfm_cpu_disable(void)
+{
+	struct pfm_context *ctx;
+	unsigned long flags;
+	int is_system, can_release = 0;
+	u32 cpu;
+
+	ctx = __get_cpu_var(pmu_ctx);
+	if (ctx == NULL)
+		return;
+
+	is_system = ctx->flags.system;
+	cpu = ctx->cpu;
+
+	/*
+	 * context is LOADED or MASKED
+	 *
+	 * we unload from CPU. That stops monitoring and does
+	 * all the bookeeping of saving values and updating duration
+	 */
+	spin_lock_irqsave(&ctx->lock, flags);
+	if (is_system)
+		__pfm_unload_context(ctx, &can_release);
+	spin_unlock_irqrestore(&ctx->lock, flags);
+
+	if (can_release)
+		pfm_release_session(is_system, cpu);
+}
--- linux-2.6.19.base/perfmon/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.19/perfmon/Makefile	2006-12-03 14:15:48.000000000 -0800
@@ -0,0 +1,8 @@
+#
+# Copyright (c) 2005-2006 Hewlett-Packard Development Company, L.P.
+# Contributed by Stephane Eranian <eranian@hpl.hp.com>
+#
+obj-$(CONFIG_PERFMON) = perfmon.o perfmon_rw.o perfmon_res.o perfmon_fmt.o \
+			perfmon_pmu.o perfmon_sysfs.o perfmon_syscalls.o   \
+			perfmon_file.o perfmon_ctxsw.o perfmon_intr.o	   \
+			perfmon_dfl_smpl.o perfmon_sets.o
