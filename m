Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSEAC3z>; Tue, 30 Apr 2002 22:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315288AbSEAC3y>; Tue, 30 Apr 2002 22:29:54 -0400
Received: from relaydal.nai.com ([161.69.213.5]:44269 "EHLO RelayDAL.nai.com")
	by vger.kernel.org with ESMTP id <S315287AbSEAC3x>;
	Tue, 30 Apr 2002 22:29:53 -0400
Message-ID: <1D4F16D4D695D21186A300A0C9DCF983DBE88B@LOS-83-207.nai.com>
From: Andrew_Purtell@NAI.com
To: wyuan1@ews.uiuc.edu
Cc: linux-kernel@vger.kernel.org
Subject: RE: what replaces tq_scheduler in 2.4
Date: Tue, 30 Apr 2002 21:27:47 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wanghong Yuan wrote:
> It seems that tq_scheduler disappears in Linux 2.4. SO what can
> I do if I need to do something when the scheduler wakes up. 

I also needed the tq_scheduler "feature". I've used the following 
patch with success on 2.4.18 (UP) + preempt. However, since this is
strictly a local hack I felt free to change the semantics somewhat.
If this patch is applied to 2.4.18, the tq_scheduler hook returns
 -- but the runqueue is serviced *after* the context switch, just
before execution in user space is resumed. The old 2.2.x 
tq_scheduler ran just *before* the context switch. 

YMMV.

>>>>>
--- linux-2.4.18/include/linux/tqueue.h.old	Tue Apr 30 19:03:59 2002
+++ linux-2.4.18/include/linux/tqueue.h	Tue Apr 30 19:04:12 2002
@@ -66,7 +66,7 @@
 #define DECLARE_TASK_QUEUE(q)	LIST_HEAD(q)
 #define TQ_ACTIVE(q)		(!list_empty(&q))
 
-extern task_queue tq_timer, tq_immediate, tq_disk;
+extern task_queue tq_timer, tq_immediate, tq_scheduler, tq_disk;
 
 /*
  * To implement your own list of active bottom halfs, use the following
--- linux-2.4.18/kernel/sched.c.old	Tue Apr 30 19:06:30 2002
+++ linux-2.4.18/kernel/sched.c	Tue Apr 30 19:06:00 2002
@@ -106,6 +106,8 @@
 	char __pad [SMP_CACHE_BYTES];
 } aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
 
+DECLARE_TASK_QUEUE(tq_scheduler);
+
 #define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
 #define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
 
@@ -496,6 +498,7 @@
 
 out_unlock:
 	task_unlock(prev);	/* Synchronise here with release_task() if
prev is TASK_ZOMBIE */
+	run_task_queue(&tq_scheduler);
 	return;
 
 	/*
@@ -528,6 +531,7 @@
 	}
 #else
 	prev->policy &= ~SCHED_YIELD;
+	run_task_queue(&tq_scheduler);
 #endif /* CONFIG_SMP */
 }
 
--- linux-2.4.18/kernel/ksyms.c.old	Tue Apr 30 19:06:40 2002
+++ linux-2.4.18/kernel/ksyms.c	Tue Apr 30 19:04:46 2002
@@ -442,6 +442,7 @@
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
 EXPORT_SYMBOL(do_settimeofday);
+EXPORT_SYMBOL(tq_scheduler);
 
 #if !defined(__ia64__)
 EXPORT_SYMBOL(loops_per_jiffy);
<<<<<


Andrew Purtell                               andrew_purtell@nai.com
NAI Labs at Network Associates, Inc.                    Seattle, WA
