Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUFGPBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUFGPBq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbUFGPBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:01:44 -0400
Received: from holomorphy.com ([207.189.100.168]:32951 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264750AbUFGPAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:00:52 -0400
Date: Mon, 7 Jun 2004 08:00:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] Staircase Scheduler v6.3 for 2.6.7-rc2
Message-ID: <20040607150037.GC21007@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200406070139.38433.kernel@kolivas.org> <20040607135631.GY21007@holomorphy.com> <20040607135738.GZ21007@holomorphy.com> <20040607140445.GA21007@holomorphy.com> <20040607140714.GB21007@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607140714.GB21007@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 07:04:45AM -0700, William Lee Irwin III wrote:
>> array->nr_active only ever modified, never examined.

On Mon, Jun 07, 2004 at 07:07:14AM -0700, William Lee Irwin III wrote:
> cpu_to_node_mask() is dead.

task->array is nothing more than a boolean flag. Shove it into
task->thread_info->flags, saving sizeof(prio_array_t *) from sizeof(task_t).
Compiletested only on sparc64 only.


Index: kolivas-2.6.7-rc2/include/asm-alpha/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-alpha/thread_info.h	2004-05-29 23:26:43.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-alpha/thread_info.h	2004-06-07 07:13:08.775700000 -0700
@@ -77,6 +77,7 @@
 #define TIF_UAC_NOPRINT		6	/* see sysinfo.h */
 #define TIF_UAC_NOFIX		7
 #define TIF_UAC_SIGBUS		8
+#define TIF_QUEUED		9	/* queued for scheduling */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/asm-arm/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-arm/thread_info.h	2004-05-29 23:26:10.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-arm/thread_info.h	2004-06-07 07:14:01.315712000 -0700
@@ -123,6 +123,7 @@
  *  TIF_NEED_RESCHED	- rescheduling necessary
  *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
+ *  TIF_QUEUED		- true if on scheduler runqueue
  */
 #define TIF_NOTIFY_RESUME	0
 #define TIF_SIGPENDING		1
@@ -130,6 +131,7 @@
 #define TIF_SYSCALL_TRACE	8
 #define TIF_USED_FPU		16
 #define TIF_POLLING_NRFLAG	17
+#define TIF_QUEUED		18
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: kolivas-2.6.7-rc2/include/asm-arm26/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-arm26/thread_info.h	2004-05-29 23:25:53.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-arm26/thread_info.h	2004-06-07 07:14:30.291307000 -0700
@@ -118,6 +118,7 @@
  *  TIF_NEED_RESCHED	- rescheduling necessary
  *  TIF_USEDFPU		- FPU was used by this task this quantum (SMP)
  *  TIF_POLLING_NRFLAG	- true if poll_idle() is polling TIF_NEED_RESCHED
+ *  TIF_QUEUED		- true if on scheduler runqueue
  */
 #define TIF_NOTIFY_RESUME	0
 #define TIF_SIGPENDING		1
@@ -125,6 +126,7 @@
 #define TIF_SYSCALL_TRACE	8
 #define TIF_USED_FPU		16
 #define TIF_POLLING_NRFLAG	17
+#define TIF_QUEUED		18
 
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: kolivas-2.6.7-rc2/include/asm-cris/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-cris/thread_info.h	2004-05-29 23:26:48.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-cris/thread_info.h	2004-06-07 07:14:57.512169000 -0700
@@ -85,6 +85,7 @@
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_QUEUED		17	/* true if on scheduler runqueue */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/asm-h8300/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-h8300/thread_info.h	2004-05-29 23:26:03.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-h8300/thread_info.h	2004-06-07 07:16:00.653570000 -0700
@@ -93,6 +93,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_QUEUED		17	/* true if on scheduler runqueue */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: kolivas-2.6.7-rc2/include/asm-i386/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-i386/thread_info.h	2004-05-29 23:25:45.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-i386/thread_info.h	2004-06-07 07:16:15.755274000 -0700
@@ -145,6 +145,7 @@
 #define TIF_IRET		5	/* return with iret */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_QUEUED		17	/* true if on scheduler runqueue */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/asm-ia64/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-ia64/thread_info.h	2004-05-29 23:26:49.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-ia64/thread_info.h	2004-06-07 07:16:53.195583000 -0700
@@ -74,6 +74,7 @@
 #define TIF_NEED_RESCHED	2	/* rescheduling necessary */
 #define TIF_SYSCALL_TRACE	3	/* syscall trace active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_QUEUED		17	/* true if on scheduler runqueue */
 
 #define TIF_WORK_MASK		0x7	/* like TIF_ALLWORK_BITS but sans TIF_SYSCALL_TRACE */
 #define TIF_ALLWORK_MASK	0xf	/* bits 0..3 are "work to do on user-return" bits */
Index: kolivas-2.6.7-rc2/include/asm-m68k/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-m68k/thread_info.h	2004-05-29 23:26:19.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-m68k/thread_info.h	2004-06-07 07:23:29.772294000 -0700
@@ -11,7 +11,7 @@
 	__s32			preempt_count; /* 0 => preemptable, <0 => BUG */
 	__u32 cpu; /* should always be 0 on m68k */
 	struct restart_block    restart_block;
-
+	unsigned char		queued;
 	__u8			supervisor_stack[0];
 };
 
@@ -48,6 +48,7 @@
 #define TIF_NOTIFY_RESUME	2	/* resumption notification requested */
 #define TIF_SIGPENDING		3	/* signal pending */
 #define TIF_NEED_RESCHED	4	/* rescheduling necessary */
+#define TIF_QUEUED		5	/* true if on scheduler runqueue */
 
 extern int thread_flag_fixme(void);
 
@@ -67,6 +68,9 @@
 	case TIF_SYSCALL_TRACE:				\
 		tsk->thread.work.syscall_trace = val;	\
 		break;					\
+	case TIF_QUEUED:				\
+		(tsk)->thread_info.queued = 1;		\
+		break;					\
 	default:					\
 		thread_flag_fixme();			\
 	}						\
@@ -84,6 +88,9 @@
 	case TIF_SYSCALL_TRACE:				\
 		___res = tsk->thread.work.syscall_trace;\
 		break;					\
+	case TIF_QUEUED:				\
+		___res = tsk->thread_info.queued;	\
+		break;					\
 	default:					\
 		___res = thread_flag_fixme();		\
 	}						\
Index: kolivas-2.6.7-rc2/include/asm-m68knommu/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-m68knommu/thread_info.h	2004-05-29 23:26:09.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-m68knommu/thread_info.h	2004-06-07 07:24:30.203107000 -0700
@@ -91,6 +91,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_QUEUED		16	/* true if on scheduler runqueue */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: kolivas-2.6.7-rc2/include/asm-mips/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-mips/thread_info.h	2004-05-29 23:25:40.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-mips/thread_info.h	2004-06-07 07:25:03.044114000 -0700
@@ -113,6 +113,7 @@
 #define TIF_SYSCALL_AUDIT	4	/* syscall auditing active */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_QUEUED		18	/* true if on scheduler runqueue */
 #define TIF_SYSCALL_TRACE	31	/* syscall trace active */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: kolivas-2.6.7-rc2/include/asm-parisc/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-parisc/thread_info.h	2004-05-29 23:26:03.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-parisc/thread_info.h	2004-06-07 07:25:26.559539000 -0700
@@ -60,6 +60,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT               5       /* 32 bit binary */
+#define TIF_QUEUED		6	/* true if on scheduler runqueue */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/asm-ppc/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-ppc/thread_info.h	2004-05-29 23:25:52.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-ppc/thread_info.h	2004-06-07 07:26:16.802901000 -0700
@@ -86,6 +86,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_QUEUED		5	/* true if on scheduler runqueue */
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/asm-ppc64/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-ppc64/thread_info.h	2004-05-29 23:25:45.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-ppc64/thread_info.h	2004-06-07 07:26:34.180260000 -0700
@@ -94,6 +94,7 @@
 #define TIF_RUN_LIGHT		6	/* iSeries run light */
 #define TIF_ABI_PENDING		7	/* 32/64 bit switch needed */
 #define TIF_SYSCALL_AUDIT	8	/* syscall auditing active */
+#define TIF_QUEUED		9	/* true if on scheduler runqueue */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: kolivas-2.6.7-rc2/include/asm-s390/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-s390/thread_info.h	2004-05-29 23:26:19.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-s390/thread_info.h	2004-06-07 07:27:50.350680000 -0700
@@ -89,6 +89,7 @@
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
 #define TIF_31BIT		18	/* 32bit process */ 
+#define TIF_QUEUED		19	/* true if on scheduler runqueue */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/asm-sh/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-sh/thread_info.h	2004-05-29 23:26:26.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-sh/thread_info.h	2004-06-07 07:28:08.307950000 -0700
@@ -93,6 +93,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
+#define TIF_QUEUED		18	/* true if on scheduler runqueue */
 #define TIF_USERSPACE		31	/* true if FS sets userspace */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: kolivas-2.6.7-rc2/include/asm-sparc/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-sparc/thread_info.h	2004-05-29 23:26:43.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-sparc/thread_info.h	2004-06-07 07:29:22.011745000 -0700
@@ -137,6 +137,7 @@
 					 * this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
 					 * TIF_NEED_RESCHED */
+#define TIF_QUEUED		10	/* true if on scheduler runqueue */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: kolivas-2.6.7-rc2/include/asm-sparc64/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-sparc64/thread_info.h	2004-05-29 23:26:26.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-sparc64/thread_info.h	2004-06-07 07:30:54.506684000 -0700
@@ -228,6 +228,7 @@
  *       an immediate value in instructions such as andcc.
  */
 #define TIF_ABI_PENDING		12
+#define TIF_QUEUED		13	/* true if on scheduler runqueue */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/asm-um/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-um/thread_info.h	2004-05-29 23:26:03.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-um/thread_info.h	2004-06-07 07:35:20.439256000 -0700
@@ -65,6 +65,7 @@
 #define TIF_POLLING_NRFLAG      3       /* true if poll_idle() is polling 
 					 * TIF_NEED_RESCHED 
 					 */
+#define TIF_QUEUED		4	/* true if on scheduler runqueue */
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
Index: kolivas-2.6.7-rc2/include/asm-v850/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-v850/thread_info.h	2004-05-29 23:26:03.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-v850/thread_info.h	2004-06-07 07:36:38.430400000 -0700
@@ -83,6 +83,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_POLLING_NRFLAG	4	/* true if poll_idle() is polling
 					   TIF_NEED_RESCHED */
+#define TIF_QUEUED		5	/* true if on scheduler runqueue */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
Index: kolivas-2.6.7-rc2/include/asm-x86_64/thread_info.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/asm-x86_64/thread_info.h	2004-05-29 23:26:26.000000000 -0700
+++ kolivas-2.6.7-rc2/include/asm-x86_64/thread_info.h	2004-06-07 07:37:09.234717000 -0700
@@ -106,6 +106,7 @@
 #define TIF_IA32		17	/* 32bit process */ 
 #define TIF_FORK		18	/* ret_from_fork */
 #define TIF_ABI_PENDING		19
+#define TIF_QUEUED		20	/* true if on scheduler runqueue */
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
Index: kolivas-2.6.7-rc2/include/linux/sched.h
===================================================================
--- kolivas-2.6.7-rc2.orig/include/linux/sched.h	2004-06-07 06:19:45.891612000 -0700
+++ kolivas-2.6.7-rc2/include/linux/sched.h	2004-06-07 07:37:49.068661000 -0700
@@ -325,7 +325,6 @@
 extern struct user_struct root_user;
 #define INIT_USER (&root_user)
 
-typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
 
@@ -392,8 +391,6 @@
 
 	int prio, static_prio;
 	struct list_head run_list;
-	prio_array_t *array;
-
 	unsigned long long timestamp;
 	unsigned long runtime, totalrun;
 	unsigned int deadline;
Index: kolivas-2.6.7-rc2/kernel/sched.c
===================================================================
--- kolivas-2.6.7-rc2.orig/kernel/sched.c	2004-06-07 07:06:28.072616000 -0700
+++ kolivas-2.6.7-rc2/kernel/sched.c	2004-06-07 07:59:22.711997000 -0700
@@ -85,10 +85,10 @@
 
 typedef struct runqueue runqueue_t;
 
-struct prio_array {
+typedef struct prio_array {
 	unsigned long bitmap[BITMAP_SIZE];
 	struct list_head queue[MAX_PRIO + 1];
-};
+} prio_array_t;
 
 /*
  * This is the main, per-CPU runqueue data structure.
@@ -191,6 +191,21 @@
 	spin_unlock_irq(&rq->lock);
 }
 
+static inline int task_queued(task_t *task)
+{
+	return test_ti_thread_flag(task->thread_info, TIF_QUEUED);
+}
+
+static inline void set_task_queued(task_t *task)
+{
+	set_ti_thread_flag(task->thread_info, TIF_QUEUED);
+}
+
+static inline void clear_task_queued(task_t *task)
+{
+	clear_ti_thread_flag(task->thread_info, TIF_QUEUED);
+}
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -207,7 +222,7 @@
 	prio_array_t* array = &rq->array;
 	list_add_tail(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
-	p->array = array;
+	set_task_queued(p);
 }
 
 /*
@@ -220,7 +235,7 @@
 	prio_array_t* array = &rq->array;
 	list_add(&p->run_list, array->queue + p->prio);
 	__set_bit(p->prio, array->bitmap);
-	p->array = array;
+	set_task_queued(p);
 }
 
 /*
@@ -369,7 +384,7 @@
 			p->deadline--;
 	}
 	dequeue_task(p, rq);
-	p->array = NULL;
+	clear_task_queued(p);
 }
 
 /*
@@ -442,7 +457,7 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && !task_running(rq, p)) {
+	if (!task_queued(p) && !task_running(rq, p)) {
 		set_task_cpu(p, dest_cpu);
 		return 0;
 	}
@@ -473,7 +488,7 @@
 repeat:
 	rq = task_rq_lock(p, &flags);
 	/* Must be off runqueue entirely, not preempted. */
-	if (unlikely(p->array)) {
+	if (unlikely(task_queued(p))) {
 		/* If it's preempted, we yield.  It could be a while. */
 		preempted = !task_running(rq, p);
 		task_rq_unlock(rq, &flags);
@@ -603,7 +618,7 @@
 	if (!(old_state & state))
 		goto out;
 
-	if (p->array)
+	if (task_queued(p))
 		goto out_running;
 
 	cpu = task_cpu(p);
@@ -663,7 +678,7 @@
 		old_state = p->state;
 		if (!(old_state & state))
 			goto out;
-		if (p->array)
+		if (task_queued(p))
 			goto out_running;
 
 		this_cpu = smp_processor_id();
@@ -725,7 +740,7 @@
 	 */
 	p->state = TASK_RUNNING;
 	INIT_LIST_HEAD(&p->run_list);
-	p->array = NULL;
+	clear_task_queued(p);
 	spin_lock_init(&p->switch_lock);
 #ifdef CONFIG_PREEMPT
 	/*
@@ -1079,12 +1094,12 @@
 	set_task_cpu(p, cpu);
 
 	if (cpu == this_cpu) {
-		if (unlikely(!current->array))
+		if (unlikely(!task_queued(current)))
 			__activate_task(p, rq);
 		else {
 			p->prio = current->prio;
 			list_add_tail(&p->run_list, &current->run_list);
-			p->array = current->array;
+			set_task_queued(p);
 			rq->nr_running++;
 		}
 	} else {
@@ -2232,9 +2247,8 @@
 void set_user_nice(task_t *p, long nice)
 {
 	unsigned long flags;
-	prio_array_t* array;
 	runqueue_t *rq;
-	int old_prio, new_prio, delta;
+	int queued, old_prio, new_prio, delta;
 
 	if (TASK_NICE(p) == nice || nice < -20 || nice > 19)
 		return;
@@ -2253,8 +2267,7 @@
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
 	}
-	array = p->array;
-	if (array)
+	if ((queued = task_queued(p)))
 		dequeue_task(p, rq);
 
 	old_prio = p->prio;
@@ -2263,7 +2276,7 @@
 	p->static_prio = NICE_TO_PRIO(nice);
 	p->prio += delta;
 
-	if (array) {
+	if (queued) {
 		enqueue_task(p, rq);
 		/*
 		 * If the task increased its priority or is running and
@@ -2369,7 +2382,7 @@
 /* Actually do priority change: must hold rq lock. */
 static void __setscheduler(struct task_struct *p, int policy, int prio)
 {
-	BUG_ON(p->array);
+	BUG_ON(task_queued(p));
 	p->policy = policy;
 	p->rt_priority = prio;
 	if (policy != SCHED_NORMAL)
@@ -2385,8 +2398,7 @@
 {
 	struct sched_param lp;
 	int retval = -EINVAL;
-	int oldprio;
-	prio_array_t* array;
+	int queued, oldprio;
 	unsigned long flags;
 	runqueue_t *rq;
 	task_t *p;
@@ -2446,13 +2458,12 @@
 	if (retval)
 		goto out_unlock;
 
-	array = p->array;
-	if (array)
+	if ((queued = task_queued(p)))
 		deactivate_task(p, task_rq(p));
 	retval = 0;
 	oldprio = p->prio;
 	__setscheduler(p, policy, lp.sched_priority);
-	if (array) {
+	if (queued) {
 		__activate_task(p, task_rq(p));
 		/*
 		 * Reschedule if we are currently running on this runqueue and
@@ -2922,7 +2933,7 @@
 
 	idle_rq->curr = idle_rq->idle = idle;
 	deactivate_task(idle, rq);
-	idle->array = NULL;
+	clear_task_queued(idle);
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
 	idle->deadline = 0;
@@ -3034,7 +3045,7 @@
 		goto out;
 
 	set_task_cpu(p, dest_cpu);
-	if (p->array) {
+	if (task_queued(p)) {
 		/*
 		 * Sync timestamp with rq_dest's before activating.
 		 * The same thing could be achieved by doing this step
