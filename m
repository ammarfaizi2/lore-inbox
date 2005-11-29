Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVK2Bga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVK2Bga (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 20:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVK2BfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 20:35:25 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:20926 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932329AbVK2BfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 20:35:19 -0500
Date: Tue, 29 Nov 2005 02:35:18 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] remove it_real_value
Message-ID: <Pine.LNX.4.61.0511290235140.2844@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This it_real_value field is currently practically unused and depending on the
source it has different meanings. Until 2.6.12 it was set to the initial
it_value from setitimer(), 2.6.13 updates it to the next itimer value, 2.6.14
doesn't set it anymore at all.  proc(5) says "The time in jiffies before the
next SIGALRM is sent to the process due to an interval timer.", which was true
until 1.3.x.

I don't think anyone seriously uses this field, so just remove it.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 fs/proc/array.c       |    4 +---
 include/linux/sched.h |    1 -
 kernel/fork.c         |    1 -
 3 files changed, 1 insertion(+), 5 deletions(-)

Index: linux-2.6-mm/fs/proc/array.c
===================================================================
--- linux-2.6-mm.orig/fs/proc/array.c	2005-11-28 22:30:41.000000000 +0100
+++ linux-2.6-mm/fs/proc/array.c	2005-11-28 22:31:17.000000000 +0100
@@ -330,7 +330,6 @@ static int do_task_stat(struct task_stru
 	unsigned long  min_flt = 0,  maj_flt = 0;
 	cputime_t cutime, cstime, utime, stime;
 	unsigned long rsslim = 0;
-	unsigned long it_real_value = 0;
 	struct task_struct *t;
 	char tcomm[sizeof(task->comm)];
 
@@ -386,7 +385,6 @@ static int do_task_stat(struct task_stru
 			utime = cputime_add(utime, task->signal->utime);
 			stime = cputime_add(stime, task->signal->stime);
 		}
-		it_real_value = task->signal->it_real_value;
 	}
 	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
@@ -435,7 +433,7 @@ static int do_task_stat(struct task_stru
 		priority,
 		nice,
 		num_threads,
-		jiffies_to_clock_t(it_real_value),
+		0L,
 		start_time,
 		vsize,
 		mm ? get_mm_rss(mm) : 0,
Index: linux-2.6-mm/include/linux/sched.h
===================================================================
--- linux-2.6-mm.orig/include/linux/sched.h	2005-11-28 22:31:12.000000000 +0100
+++ linux-2.6-mm/include/linux/sched.h	2005-11-28 22:31:17.000000000 +0100
@@ -405,7 +405,6 @@ struct signal_struct {
 	/* ITIMER_REAL timer for the process */
 	struct ptimer real_timer;
 	struct task_struct *tsk;
-	unsigned long it_real_value;
 	ktime_t it_real_incr;
 
 	/* ITIMER_PROF and ITIMER_VIRTUAL timers for the process */
Index: linux-2.6-mm/kernel/fork.c
===================================================================
--- linux-2.6-mm.orig/kernel/fork.c	2005-11-28 22:31:12.000000000 +0100
+++ linux-2.6-mm/kernel/fork.c	2005-11-28 22:31:17.000000000 +0100
@@ -794,7 +794,6 @@ static inline int copy_signal(unsigned l
 	init_sigpending(&sig->shared_pending);
 	INIT_LIST_HEAD(&sig->posix_timers);
 
-	sig->it_real_value = 0;
 	sig->it_real_incr.tv64 = KTIME_ZERO;
 	ptimer_init(&sig->real_timer, CLOCK_MONOTONIC);
 	sig->real_timer.function = it_real_fn;
