Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268141AbUI2Beg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268141AbUI2Beg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 21:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268142AbUI2Beg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 21:34:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16354 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268141AbUI2Bec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 21:34:32 -0400
Date: Tue, 28 Sep 2004 18:34:24 -0700
Message-Id: <200409290134.i8T1YOI9002933@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] move struct k_itimer out of linux/sched.h
X-Shopping-List: (1) Autistic metronomes
   (2) Indigenous piano rings
   (3) Gripping dogboy wine
   (4) Tumultuous retributions
   (5) Red-winged corruption
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know why struct k_itimer was ever declared in sched.h; perhaps at
one time it was referenced by something else there.  There is no need for
it now.  This patch moves the struct where it belongs, in linux/posix-timers.h.
It has zero effect on anything except keeping the source easier to read.


Thanks,
Roland


Index: linux-2.6/include/linux/posix-timers.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/posix-timers.h,v
retrieving revision 1.3
diff -B -b -p -u -r1.3 posix-timers.h
--- linux-2.6/include/linux/posix-timers.h 2 Jul 2004 17:31:23 -0000 1.3
+++ linux-2.6/include/linux/posix-timers.h 29 Sep 2004 01:31:29 -0000
@@ -4,6 +4,26 @@
 #include <linux/spinlock.h>
 #include <linux/list.h>
 
+/* POSIX.1b interval timer structure. */
+struct k_itimer {
+	struct list_head list;		/* free/ allocate list */
+	spinlock_t it_lock;
+	clockid_t it_clock;		/* which timer type */
+	timer_t it_id;			/* timer id */
+	int it_overrun;			/* overrun on pending signal  */
+	int it_overrun_last;		/* overrun on last delivered signal */
+	int it_requeue_pending;         /* waiting to requeue this timer */
+	int it_sigev_notify;		/* notify word of sigevent struct */
+	int it_sigev_signo;		/* signo word of sigevent struct */
+	sigval_t it_sigev_value;	/* value word of sigevent struct */
+	unsigned long it_incr;		/* interval specified in jiffies */
+	struct task_struct *it_process;	/* process to send signal to */
+	struct timer_list it_timer;
+	struct sigqueue *sigq;		/* signal queue entry. */
+	struct list_head abs_timer_entry; /* clock abs_timer_list */
+	struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
+};
+
 struct k_clock_abs {
 	struct list_head list;
 	spinlock_t lock;
Index: linux-2.6/include/linux/sched.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/linux/sched.h,v
retrieving revision 1.272
diff -B -b -p -u -r1.272 sched.h
--- linux-2.6/include/linux/sched.h 13 Sep 2004 21:05:18 -0000 1.272
+++ linux-2.6/include/linux/sched.h 29 Sep 2004 00:52:23 -0000
@@ -360,26 +360,6 @@ typedef struct prio_array prio_array_t;
 struct backing_dev_info;
 struct reclaim_state;
 
-/* POSIX.1b interval timer structure. */
-struct k_itimer {
-	struct list_head list;		 /* free/ allocate list */
-	spinlock_t it_lock;
-	clockid_t it_clock;		/* which timer type */
-	timer_t it_id;			/* timer id */
-	int it_overrun;			/* overrun on pending signal  */
-	int it_overrun_last;		 /* overrun on last delivered signal */
-	int it_requeue_pending;          /* waiting to requeue this timer */
-	int it_sigev_notify;		 /* notify word of sigevent struct */
-	int it_sigev_signo;		 /* signo word of sigevent struct */
-	sigval_t it_sigev_value;	 /* value word of sigevent struct */
-	unsigned long it_incr;		/* interval specified in jiffies */
-	struct task_struct *it_process;	/* process to send signal to */
-	struct timer_list it_timer;
-	struct sigqueue *sigq;		/* signal queue entry. */
-	struct list_head abs_timer_entry; /* clock abs_timer_list */
-	struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
-};
-
 #ifdef CONFIG_SCHEDSTATS
 struct sched_info {
 	/* cumulative counters */
