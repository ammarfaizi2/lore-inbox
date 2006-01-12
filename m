Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWALCwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWALCwN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 21:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWALCwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 21:52:12 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:37599 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964996AbWALCwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 21:52:12 -0500
Subject: [PATCH RT] fix or hrtimers (was: [ANNOUNCE] 2.6.15-rc5-hrt2 -
	hrtimers based high resolution patches)
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>,
       tglx@linutronix.de, George Anzinger <george@mvista.com>
In-Reply-To: <1137032072.6197.134.camel@localhost.localdomain>
References: <1134385343.4205.72.camel@tglx.tec.linutronix.de>
	 <1134507927.18921.26.camel@localhost.localdomain>
	 <20051214084019.GA18708@elte.hu>  <20051214084333.GA20284@elte.hu>
	 <1136937547.6197.73.camel@localhost.localdomain>
	 <1137032072.6197.134.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 21:51:45 -0500
Message-Id: <1137034306.6197.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 21:14 -0500, Steven Rostedt wrote:
> Finally!  I did it.  I have an updated timer_stress test at 
> http://www.kihontech.com/tests/rt/timer_stress.c
> that triggers the deadlock that I have been mentioning (and hit once in
> my kernel).  But this time I hit it in 2.6.15-rt4-sr1 and got the
> following output:

OK, it's not like me to just show a problem, without at least having
some type of fix for it.  Since my last fix, was turned down, and
looking into it further, I now understand why.

The patch below now makes hrtimer_start cancel the timer and lock the
base in one action. It also checks to see if the timer is running, and
if it is, it doesn't do anything.  It basically, tests to see if it
should cancel the timer.

This is now included in my rt maintenance patches at:

http://home.stny.rr.com/rostedt/patches/patch-2.6.15-rt4-sr2

But I'll include this patch here too so that you can look at what I've
done.

My test at http://www.kihontech.com/tests/rt/timer_stress.c hasn't
killed this kernel yet.  But I'll run it all night on both a UP machine
with the -P (posix timers) and without -P on a SMP machine (setitimer).

-- Steve

Index: linux-2.6.15-rt4/kernel/hrtimer.c
===================================================================
--- linux-2.6.15-rt4.orig/kernel/hrtimer.c	2006-01-11 14:46:30.000000000 -0500
+++ linux-2.6.15-rt4/kernel/hrtimer.c	2006-01-11 21:36:31.000000000 -0500
@@ -610,6 +610,35 @@
 }
 
 /**
+ * hrtimer_cancel_and_lock - deactivate a timer and lock its base.
+ *
+ * @timer:	hrtimer to stop
+ * @flags:	pointer to the flags argument
+ *
+ * Returns:
+ *  base of the timer.
+ */
+static struct hrtimer_base *
+hrtimer_cancel_and_lock(struct hrtimer *timer, unsigned long *flags)
+{
+	struct hrtimer_base *base;
+
+retry:
+	base = lock_hrtimer_base(timer, flags);
+
+	if (base->curr_timer == timer) {
+		unlock_hrtimer_base(timer, flags);
+		hrtimer_wait_for_timer();
+		goto retry;
+	}
+
+	remove_hrtimer(timer, base);
+
+	return base;
+
+}
+
+/**
  * hrtimer_start - (re)start an relative timer on the current CPU
  *
  * @timer:	the timer to be added
@@ -628,10 +657,7 @@
 	unsigned long flags;
 	int ret;
 
-	base = lock_hrtimer_base(timer, &flags);
-
-	/* Remove an active timer from the queue: */
-	remove_hrtimer(timer, base);
+	base = hrtimer_cancel_and_lock(timer, &flags);
 
 	/* Switch the timer base, if necessary: */
 	new_base = switch_hrtimer_base(timer, base);


