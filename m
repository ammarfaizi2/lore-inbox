Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932427AbWCPRuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWCPRuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 12:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932429AbWCPRuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 12:50:20 -0500
Received: from 213-239-205-134.clients.your-server.de ([213.239.205.134]:17854
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932427AbWCPRuT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 12:50:19 -0500
Subject: Re: 2.6.16-rc6-rt7
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: David Brown <dmlb2000@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>
In-Reply-To: <9c21eeae0603160939sa48bbe7i84698c8a2187ae4@mail.gmail.com>
References: <20060316095607.GA28571@elte.hu>
	 <9c21eeae0603160939sa48bbe7i84698c8a2187ae4@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 18:50:21 +0100
Message-Id: <1142531421.29968.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 09:39 -0800, David Brown wrote:
> I've been having issues with the realtime patch set and using scp
> (specifically scp, wget, curl, git, cvs everything else works fine). I
> was wondering what extra debugging features are helpful to have built
> into the kernel that could help me nail down why this bug is
> happening.
> 
> Specifically what's happening is scp is freezing my system, there
> haven't been any kernel warnings or panics upon execution of scp, it
> just freezes, every other application that uses network seems to work
> just fine, so far it's just been scp.

Just found a problem in the highres timer merge. Can you try the patch
below?

	tglx

Index: linux-2.6.16-rc6/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-rc6.orig/include/linux/hrtimer.h
+++ linux-2.6.16-rc6/include/linux/hrtimer.h
@@ -114,6 +114,8 @@ extern void hrtimer_clock_notify(void);
 extern void clock_was_set(void);
 extern int hrtimer_interrupt(void);
 
+#define hrtimer_cb_get_time(t)	(t)->base->get_time()
+
 /*
  * The resolution of the clocks. The resolution value is returned in
  * the clock_getres() system call to give application programmers an
@@ -136,6 +138,8 @@ extern int hrtimer_interrupt(void);
 #define clock_was_set()		do { } while (0)
 #define hrtimer_clock_notify()	do { } while (0)
 
+#define hrtimer_cb_get_time(t)	(t)->base->softirq_time
+
 #endif
 
 # if (BITS_PER_LONG == 64) || defined(CONFIG_KTIME_SCALAR)
Index: linux-2.6.16-rc6/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/hrtimer.c
+++ linux-2.6.16-rc6/kernel/hrtimer.c
@@ -970,8 +970,6 @@ static inline void run_hrtimer_hres_queu
 {
 	spin_lock_irq(&base->lock);
 
-	base->softirq_time = base->get_softirq_time();
-
 	while (!list_empty(&base->cb_pending)) {
 		struct hrtimer *timer;
 		int (*fn)(struct hrtimer *);
Index: linux-2.6.16-rc6/kernel/itimer.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/itimer.c
+++ linux-2.6.16-rc6/kernel/itimer.c
@@ -136,7 +136,7 @@ int it_real_fn(struct hrtimer *timer)
 	send_group_sig_info(SIGALRM, SEND_SIG_PRIV, sig->tsk);
 
 	if (sig->it_real_incr.tv64 != 0) {
-		hrtimer_forward(timer, timer->base->softirq_time,
+		hrtimer_forward(timer, hrtimer_cb_get_time(timer),
 				sig->it_real_incr);
 		return HRTIMER_RESTART;
 	}
Index: linux-2.6.16-rc6/kernel/posix-timers.c
===================================================================
--- linux-2.6.16-rc6.orig/kernel/posix-timers.c
+++ linux-2.6.16-rc6/kernel/posix-timers.c
@@ -355,9 +355,10 @@ static int posix_timer_fn(struct hrtimer
 		if (timr->it.real.interval.tv64 != 0) {
 			timr->it_overrun +=
 				hrtimer_forward(timer,
-						timer->base->softirq_time,
+						hrtimer_cb_get_time(timer),
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
+			++timr->it_requeue_pending;
 		}
 	}
 


