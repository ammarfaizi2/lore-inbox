Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTJKJFo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 05:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJKJFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 05:05:44 -0400
Received: from mx1.elte.hu ([157.181.1.137]:43467 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263268AbTJKJEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 05:04:54 -0400
Date: Sat, 11 Oct 2003 10:55:42 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch] SMP races in the timer code, timer-fix-2.6.0-test7-A0
Message-ID: <Pine.LNX.4.56.0310111032250.5373@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the patch below fixes two del_timer_sync() races that are still in the
timer code.

the first race was actually triggered in a 2.4 backport of the 2.6 timer
code. The second race was never triggered - it is mostly theoretical on a
standalone kernel. (it's more likely in any virtualized or otherwise
preemptable environment.)

both races happen when self-rearming timers are used. One mainstream
example is kernel/itimer.c. The effect of the races is that
del_timer_sync() lets a timer running instead of synchronizing with it,
causing logic bugs (and crashes) in the affected kernel code. One typical
incarnation of the race is a double add_timer().

race #1:

this code in __run_timers() is running on CPU0:

                        list_del(&timer->entry);
                        timer->base = NULL;
			[*]
                        set_running_timer(base, timer);
                        spin_unlock_irq(&base->lock);
			[**]
                        fn(data);
                        spin_lock_irq(&base->lock);

CPU0 gets stuck at the [*] code-point briefly - after the timer->base has
been set to NULL, but before the base->running_timer pointer has been set
up. This is a fundamentally volatile scenario, as there's _zero_ knowledge
in the data structures that this timer is about to be executed!

now CPU1 comes along and calls del_timer_sync(). It will find nothing -
neither timer->base nor base->running_timer will cause it to synchronize.  
It will return and report that the timer has been deleted - shortly
afterwards CPU1 continues to execute the timer fn, which will cause
crashes.

this particular race is easy to fix by reordering the timer->base clearing
with set_running_timer(), and putting a wmb() between them, but there's
more races:

race #2

the checking of del_timer_sync() for 'pending or running timer' is
fundamentally unrobust. Eg. if CPU0 gets stuck at the [***] point below:

                base = &per_cpu(tvec_bases, i);
                if (base->running_timer == timer) {
                        while (base->running_timer == timer) {
                                cpu_relax();
                                preempt_check_resched();
                        }
			[***]
                        break;
                }
        }
        smp_rmb();
        if (timer_pending(timer))
                goto del_again;


then del_timer_sync() has already decided that this timer is not running
(we just finished loop-waiting for it), but we have not done the
timer_pending() check yet.

if the timer has re-armed itself, and if the timer expires on CPU1 (this
needs a long delay on CPU0 but that's not hard to achieve eg. in UML or
with kernel preemption enabled), then CPU1 could start to expire the timer
and gets to the [**] point in __run_timers (see above), then CPU1 gets
stalled and CPU0 is unstalled, then the timer_pending() check in
del_timer_sync() will not notice the running timer, and del_timer_sync()  
returns - while CPU1 is just about to run the timer!

fixing this second race is hard - it involves a heavy race-check operation
that has to lock all bases, and has to re-check the base->running_timer
value, and timer_pending condition atomically.

this fix also fixes the first race, due to forcing del_timer_sync() to
always observe the timer state atomically, so the [*] code point will
always synchronize with del_timer_sync().

the patch is ugly but safe, and it has fixed the crashes in the 2.4
backport. I tested the patch on 2.6.0-test7 with some heavy itimer use and
it works fine. Removing self-arming timers safely is the sole purpose of
del_timer_sync(), so there's no way around this overhead i think. I
believe we should ultimately fix all major del_timer_sync() users to not
use self-arming timers - having del_timer_sync() in the thread-exit path
is now a considerable source of SMP overhead. But this is out of the scope
of current 2.6 fixes of course, and we have to support self-arming timers
as well.

	Ingo

--- linux/kernel/timer.c.orig
+++ linux/kernel/timer.c
@@ -315,23 +315,30 @@ EXPORT_SYMBOL(del_timer);
  * the timer it also makes sure the handler has finished executing on other
  * CPUs.
  *
- * Synchronization rules: callers must prevent restarting of the timer,
- * otherwise this function is meaningless. It must not be called from
- * interrupt contexts. Upon exit the timer is not queued and the handler
- * is not running on any CPU.
+ * Synchronization rules: callers must prevent restarting of the timer
+ * (except restarting the timer from the timer function itself), otherwise
+ * this function is meaningless. It must not be called from interrupt
+ * contexts. Upon exit the timer is not queued and the handler is not
+ * running on any CPU.
  *
- * The function returns whether it has deactivated a pending timer or not.
+ * The function returns the number of times it has deactivated a pending
+ * timer.
  */
 int del_timer_sync(struct timer_list *timer)
 {
+	int i, ret = 0, again;
+	unsigned long flags;
 	tvec_base_t *base;
-	int i, ret = 0;
 
 	check_timer(timer);
 
 del_again:
 	ret += del_timer(timer);
 
+	/*
+	 * First do a lighter but racy check, whether the
+	 * timer is running on any other CPU:
+	 */
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
@@ -345,8 +352,33 @@ del_again:
 			break;
 		}
 	}
-	smp_rmb();
+
+	/*
+	 * Do a heavy but race-free re-check to make sure both that
+	 * the timer is neither running nor pending:
+	 */
+	again = 0;
+	local_irq_save(flags);
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			spin_lock(&per_cpu(tvec_bases, i).lock);
+
 	if (timer_pending(timer))
+		again = 1;
+	else
+		for (i = 0; i < NR_CPUS; i++)
+			if (cpu_online(i) &&
+				(per_cpu(tvec_bases, i).running_timer == timer))
+					again = 1;
+
+	for (i = 0; i < NR_CPUS; i++)
+		if (cpu_online(i))
+			spin_unlock(&per_cpu(tvec_bases, i).lock);
+
+	local_irq_restore(flags);
+
+	if (again)
 		goto del_again;
 
 	return ret;
