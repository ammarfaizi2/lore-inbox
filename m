Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbULEXJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbULEXJh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULEXJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 18:09:37 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:53404 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261202AbULEXJR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 18:09:17 -0500
Date: Sat, 4 Dec 2004 16:45:57 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Fw: [RFC] Strange code in cpu_idle()
Message-ID: <20041205004557.GA2028@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Steve,

OK, I believe I found the other end of this:

static void __exit apm_exit(void)
{
	int	error;

	if (set_pm_idle) {
		pm_idle = original_pm_idle;
		/*
		 * We are about to unload the current idle thread pm callback
		 * (pm_idle), Wait for all processors to update cached/local
		 * copies of pm_idle before proceeding.
		 */
		synchronize_kernel();
	}

Unfortunately, the idle loop is a quiescent state, so it is
possible for synchronize_kernel() to return before the idle threads
have returned.  So I don't believe RCU is useful here.  One other
approach would be to keep a cpu mask, in which apm_exit() sets all
bits, and pm_idle() clears its CPU's bit only if it is set.
Then apm_exit() could wait for all CPU's bits to clear.

There is probably a better way to do this, but that is what comes
to mind immediately.

Thoughts?

					Thanx, Paul

----- Forwarded message from "Paul E. McKenney" <paulmck@us.ibm.com> -----

Date: Sat, 4 Dec 2004 15:11:49 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: dipankar@in.ibm.com, rusty@au1.ibm.com, ak@suse.de, gareth@valinux.com,
	davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] Strange code in cpu_idle()
Reply-To: paulmck@us.ibm.com

Hello!

Strange code in i386, ia64, and x86-64 cpu_idle():

	void cpu_idle (void)
	{
		/* endless idle loop with no priority at all */
		while (1) {
			while (!need_resched()) {
				void (*idle)(void);
				/*
				 * Mark this as an RCU critical section so that
				 * synchronize_kernel() in the unload path waits
				 * for our completion.
				 */
				rcu_read_lock();
				idle = pm_idle;
				if (!idle)
					idle = default_idle;
				idle();
				rcu_read_unlock();
			}
			schedule();
		}
	}

Unless idle_cpu() is busted, it seems like the above is, given the code in
rcu_check_callbacks():

	void rcu_check_callbacks(int cpu, int user)
	{
		if (user || 
		    (idle_cpu(cpu) && !in_softirq() && 
					hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
			rcu_qsctr_inc(cpu);
			rcu_bh_qsctr_inc(cpu);
		} else if (!in_softirq())
			rcu_bh_qsctr_inc(cpu);
		tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
	}

And idle_cpu() is pretty straightforward:

	int idle_cpu(int cpu)
	{
		return cpu_curr(cpu) == cpu_rq(cpu)->idle;
	}

So I would say that the rcu_read_lock() in cpu_idle() is having no
effect, because any timer interrupt from cpu_idle() will mark a
quiescent state notwithstanding.  What am I missing here?

If I am not missing anything, then the attached patch would be in
order here, though there might be some additional work required.
(Though I thought that the try_stop_module() stuff took care of
all of this these days...)

Note that we really, really do want the idle loop to be an extended
quiescent state, otherwise one gets indefinite grace periods and
runs out of memory...

						Thanx, Paul

diff -urpN -X ../dontdiff linux-2.5/arch/i386/kernel/process.c linux-2.5-idle_rcu/arch/i386/kernel/process.c
--- linux-2.5/arch/i386/kernel/process.c	Mon Nov 29 10:47:14 2004
+++ linux-2.5-idle_rcu/arch/i386/kernel/process.c	Sat Dec  4 14:53:37 2004
@@ -144,14 +144,12 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
+		/*
+		 * Note that it is illegal to use RCU read-side
+		 * critical sections within the idle loop.
+		 */
 		while (!need_resched()) {
 			void (*idle)(void);
-			/*
-			 * Mark this as an RCU critical section so that
-			 * synchronize_kernel() in the unload path waits
-			 * for our completion.
-			 */
-			rcu_read_lock();
 			idle = pm_idle;
 
 			if (!idle)
@@ -159,7 +157,6 @@ void cpu_idle (void)
 
 			irq_stat[smp_processor_id()].idle_timestamp = jiffies;
 			idle();
-			rcu_read_unlock();
 		}
 		schedule();
 	}
diff -urpN -X ../dontdiff linux-2.5/arch/ia64/kernel/process.c linux-2.5-idle_rcu/arch/ia64/kernel/process.c
--- linux-2.5/arch/ia64/kernel/process.c	Mon Nov 29 10:47:18 2004
+++ linux-2.5-idle_rcu/arch/ia64/kernel/process.c	Sat Dec  4 14:54:30 2004
@@ -230,6 +230,10 @@ cpu_idle (void *unused)
 
 	/* endless idle loop with no priority at all */
 	while (1) {
+		/*
+		 * Note that it is illegal to use RCU read-side
+		 * critical sections within the idle loop.
+		 */
 #ifdef CONFIG_SMP
 		if (!need_resched())
 			min_xtp();
@@ -239,17 +243,10 @@ cpu_idle (void *unused)
 
 			if (mark_idle)
 				(*mark_idle)(1);
-			/*
-			 * Mark this as an RCU critical section so that
-			 * synchronize_kernel() in the unload path waits
-			 * for our completion.
-			 */
-			rcu_read_lock();
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
 			(*idle)();
-			rcu_read_unlock();
 		}
 
 		if (mark_idle)
diff -urpN -X ../dontdiff linux-2.5/arch/x86_64/kernel/process.c linux-2.5-idle_rcu/arch/x86_64/kernel/process.c
--- linux-2.5/arch/x86_64/kernel/process.c	Mon Nov 29 10:48:05 2004
+++ linux-2.5-idle_rcu/arch/x86_64/kernel/process.c	Sat Dec  4 14:55:13 2004
@@ -133,19 +133,16 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
+		/*
+		 * Note that it is illegal to use RCU read-side
+		 * critical sections within the idle loop.
+		 */
 		while (!need_resched()) {
 			void (*idle)(void);
-			/*
-			 * Mark this as an RCU critical section so that
-			 * synchronize_kernel() in the unload path waits
-			 * for our completion.
-			 */
-			rcu_read_lock();
 			idle = pm_idle;
 			if (!idle)
 				idle = default_idle;
 			idle();
-			rcu_read_unlock();
 		}
 		schedule();
 	}

----- End forwarded message -----
