Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269203AbUIYDTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269203AbUIYDTV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 23:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269206AbUIYDTU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 23:19:20 -0400
Received: from holomorphy.com ([207.189.100.168]:50148 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269203AbUIYDTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 23:19:16 -0400
Date: Fri, 24 Sep 2004 20:19:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [sched.h 4/8] move struct k_itimer to posix-timers.h
Message-ID: <20040925031912.GP9106@holomorphy.com>
References: <20040925024513.GL9106@holomorphy.com> <20040925024917.GM9106@holomorphy.com> <20040925025304.GN9106@holomorphy.com> <20040925030802.GO9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040925030802.GO9106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 08:08:02PM -0700, William Lee Irwin III wrote:
> CALC_LOAD() is used nowhere but kernel/timer.c; this patch moves it
> there.

struct k_itimer is used nowhere but posix-timers.h; this patch moves it
there.


Index: mm3-2.6.9-rc2/include/linux/posix-timers.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/posix-timers.h	2004-09-12 22:32:27.000000000 -0700
+++ mm3-2.6.9-rc2/include/linux/posix-timers.h	2004-09-24 18:55:19.288557856 -0700
@@ -8,6 +8,8 @@
 	struct list_head list;
 	spinlock_t lock;
 };
+
+struct k_itimer;
 struct k_clock {
 	int res;		/* in nano seconds */
 	struct k_clock_abs *abs_struct;
@@ -23,6 +25,27 @@
 	void (*timer_get) (struct k_itimer * timr,
 			   struct itimerspec * cur_setting);
 };
+
+/* POSIX.1b interval timer structure. */
+struct k_itimer {
+	struct list_head list;		 /* free/ allocate list */
+	spinlock_t it_lock;
+	clockid_t it_clock;		/* which timer type */
+	timer_t it_id;			/* timer id */
+	int it_overrun;			/* overrun on pending signal  */
+	int it_overrun_last;		 /* overrun on last delivered signal */
+	int it_requeue_pending;          /* waiting to requeue this timer */
+	int it_sigev_notify;		 /* notify word of sigevent struct */
+	int it_sigev_signo;		 /* signo word of sigevent struct */
+	sigval_t it_sigev_value;	 /* value word of sigevent struct */
+	unsigned long it_incr;		/* interval specified in jiffies */
+	struct task_struct *it_process;	/* process to send signal to */
+	struct timer_list it_timer;
+	struct sigqueue *sigq;		/* signal queue entry. */
+	struct list_head abs_timer_entry; /* clock abs_timer_list */
+	struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
+};
+
 struct now_struct {
 	unsigned long jiffies;
 };
Index: mm3-2.6.9-rc2/include/linux/sched.h
===================================================================
--- mm3-2.6.9-rc2.orig/include/linux/sched.h	2004-09-24 18:51:25.969027816 -0700
+++ mm3-2.6.9-rc2/include/linux/sched.h	2004-09-24 18:54:45.788650616 -0700
@@ -352,26 +352,6 @@
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
