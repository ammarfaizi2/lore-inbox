Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUEJWR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUEJWR1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 18:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUEJWR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 18:17:26 -0400
Received: from fmr05.intel.com ([134.134.136.6]:40407 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S261693AbUEJWQh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 18:16:37 -0400
Message-ID: <409FFF3B.3090506@linux.intel.com>
Date: Mon, 10 May 2004 15:16:27 -0700
From: Geoff Gustafson <geoff@linux.jf.intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] Performance of del_timer_sync
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started this patch based on profiling an enterprise database application
on a 32p IA64 NUMA machine, where del_timer_sync was one of the top few
functions taking CPU time in the kernel. The problem: even though a timer
can only be scheduled on one CPU at a time, a loop was searching through
each CPU. This is particularly bad on a NUMA machine, but doesn't scale
well on a normal SMP either. With this patch, here were some results:

Before:             32p     4p
     Warm cache   29,000    505
     Cold cache   37,800   1220

After:              32p     4p
     Warm cache       95     88
     Cold cache    1,800    140

[Measurements are CPU cycles spent in a call to del_timer_sync, the average
of 1000 calls. 32p is 16-node NUMA, 4p is SMP.]

I'd be very interested for others to try out this patch, and see what kind
of results you get. Have you also observed del_timer_sync as a hotspot?

Now on to the patch. The basic idea is to remember which 'base' (i.e. CPU)
is currently executing the timer function. Ingo once sent a patch that did
this exact thing, to solve SMP races:
http://marc.theaimsgroup.com/?l=linux-kernel&m=106610555708068&w=2

Linus pointed out that you can't reset timer->running to NULL in
__run_timers because the timer might have been freed by the timer function.
The patch was then dropped. It now seems to me though that we can still get
the performance gains - I call it timer->last_running and it just does not
get reset to NULL. Thus it may be stale, but at least then you only have to
check _one_ CPU for the running timer instead of all of them.

Here are some known issues I'd like people to comment on:

1. How bad is the performance hit of adding a last_running field to
timer_list? I ifdef'd everything with CONFIG_SMP to make sure there's no
impact to uniprocessors, although that may be objectionable for its ugliness.

2. I believe there's a theoretical race; I'm not sure if it could actually
happen in practice. When the timer function gets executed in __run_timers,
the base->lock is briefly unlocked. This gives another CPU that has been
waiting in __mod_timer the opportunity to step in and reschedule the timer.
Then that new scheduled timer has to actually expire (next timer interrupt
at the earliest I believe). Then it has to get around to executing the timer
function. So now two timer functions are overlapping, and timer->last_running
only remembers the second one.

In this situation, the original del_timer_sync code would find the timer
function on the lowest numbered CPU, wait for it to finish, and break out of
the loop. If the function on the higher numbered CPU runs longer, it will
return before it is finished.

With the patch, the code will wait for the most recently executed timer
function to finish. If the older function finishes after the newer one, we
get the original problem. I'd suggest waiting for the most recent one is an
improvement, though not a fix.

If del_timer_sync returns while the timer function is still running, the
caller may do something (like free the timer) that will cause the running
timer function to go awry. Can this really happen? Would it be the timer
function's fault, for running too long?

Comments, results, bug fixes, and improvements welcome!

- Geoff Gustafson

diff -Naur fresh/include/linux/timer.h timer/include/linux/timer.h
--- fresh/include/linux/timer.h	Sat Apr  3 19:37:37 2004
+++ timer/include/linux/timer.h	Tue May  4 14:51:51 2004
@@ -18,10 +18,20 @@
  	unsigned long data;

  	struct tvec_t_base_s *base;
+
+#ifdef CONFIG_SMP
+	struct tvec_t_base_s *last_running;
+#endif
  };

  #define TIMER_MAGIC	0x4b87ad6e

+#ifdef CONFIG_SMP
+#define TIMER_INIT_LASTRUNNING .last_running = NULL,
+#else
+#define TIMER_INIT_LASTRUNNING
+#endif
+
  #define TIMER_INITIALIZER(_function, _expires, _data) {		\
  		.function = (_function),			\
  		.expires = (_expires),				\
@@ -29,6 +39,7 @@
  		.base = NULL,					\
  		.magic = TIMER_MAGIC,				\
  		.lock = SPIN_LOCK_UNLOCKED,			\
+		TIMER_INIT_LASTRUNNING				\
  	}

  /***
@@ -40,6 +51,9 @@
   */
  static inline void init_timer(struct timer_list * timer)
  {
+#ifdef CONFIG_SMP
+	timer->last_running = NULL;
+#endif
  	timer->base = NULL;
  	timer->magic = TIMER_MAGIC;
  	spin_lock_init(&timer->lock);
diff -Naur fresh/kernel/timer.c timer/kernel/timer.c
--- fresh/kernel/timer.c	Sat Apr  3 19:37:59 2004
+++ timer/kernel/timer.c	Tue May  4 11:37:36 2004
@@ -75,6 +75,14 @@
  #endif
  }

+static inline void set_last_running(struct timer_list *timer,
+				    tvec_base_t *base)
+{
+#ifdef CONFIG_SMP
+	timer->last_running = base;
+#endif
+}
+
  /* Fake initialization */
  static DEFINE_PER_CPU(tvec_base_t, tvec_bases) = { SPIN_LOCK_UNLOCKED };

@@ -325,25 +333,22 @@
  int del_timer_sync(struct timer_list *timer)
  {
  	tvec_base_t *base;
-	int i, ret = 0;
+	int ret = 0;

  	check_timer(timer);

  del_again:
  	ret += del_timer(timer);

-	for_each_cpu(i) {
-		base = &per_cpu(tvec_bases, i);
-		if (base->running_timer == timer) {
-			while (base->running_timer == timer) {
-				cpu_relax();
-				preempt_check_resched();
-			}
-			break;
+	base = timer->last_running;
+	if (base) {
+		while (base->running_timer == timer) {
+			cpu_relax();
+			preempt_check_resched();
  		}
  	}
  	smp_rmb();
-	if (timer_pending(timer))
+	if (timer_pending(timer) || timer->last_running != base)
  		goto del_again;

  	return ret;
@@ -418,6 +423,7 @@
  			set_running_timer(base, timer);
  			smp_wmb();
  			timer->base = NULL;
+			set_last_running(timer, base);
  			spin_unlock_irq(&base->lock);
  			fn(data);
  			spin_lock_irq(&base->lock);

