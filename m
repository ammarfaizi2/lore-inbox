Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWBNDMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWBNDMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWBNDMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:12:43 -0500
Received: from fmr22.intel.com ([143.183.121.14]:27278 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030213AbWBNDMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:12:42 -0500
Message-Id: <200602140312.k1E3CWg17620@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Nick Piggin'" <nickpiggin@yahoo.com.au>, "'Ingo Molnar'" <mingo@elte.hu>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch 1/2] fix perf. bug in wake-up load balancing for aim7 and db workload
Date: Mon, 13 Feb 2006 19:12:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYxFAK2pbwTbFOMQ5WU5455NIBdvQAAB8LQ
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Revert commit d7102e95b7b9c00277562c29aad421d2d521c5f6,
which causes more than 10% performance regression with aim7.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.16-rc2/include/linux/sched.h.orig	2006-02-13 18:15:09.660276655 -0800
+++ linux-2.6.16-rc2/include/linux/sched.h	2006-02-13 18:15:36.234495079 -0800
@@ -697,12 +697,9 @@ struct task_struct {
 
 	int lock_depth;		/* BKL lock depth */
 
-#if defined(CONFIG_SMP)
-	int last_waker_cpu;	/* CPU that last woke this task up */
-#if defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	int oncpu;
 #endif
-#endif
 	int prio, static_prio;
 	struct list_head run_list;
 	prio_array_t *array;
--- linux-2.6.16-rc2/kernel/sched.c.orig	2006-02-13 18:11:28.946412171 -0800
+++ linux-2.6.16-rc2/kernel/sched.c	2006-02-13 18:14:29.595824020 -0800
@@ -1294,9 +1294,6 @@ static int try_to_wake_up(task_t *p, uns
 		}
 	}
 
-	if (p->last_waker_cpu != this_cpu)
-		goto out_set_cpu;
-
 	if (unlikely(!cpu_isset(this_cpu, p->cpus_allowed)))
 		goto out_set_cpu;
 
@@ -1367,8 +1364,6 @@ out_set_cpu:
 		cpu = task_cpu(p);
 	}
 
-	p->last_waker_cpu = this_cpu;
-
 out_activate:
 #endif /* CONFIG_SMP */
 	if (old_state == TASK_UNINTERRUPTIBLE) {
@@ -1450,12 +1445,9 @@ void fastcall sched_fork(task_t *p, int 
 #ifdef CONFIG_SCHEDSTATS
 	memset(&p->sched_info, 0, sizeof(p->sched_info));
 #endif
-#if defined(CONFIG_SMP)
-	p->last_waker_cpu = cpu;
-#if defined(__ARCH_WANT_UNLOCKED_CTXSW)
+#if defined(CONFIG_SMP) && defined(__ARCH_WANT_UNLOCKED_CTXSW)
 	p->oncpu = 0;
 #endif
-#endif
 #ifdef CONFIG_PREEMPT
 	/* Want to start with kernel preemption disabled. */
 	task_thread_info(p)->preempt_count = 1;

