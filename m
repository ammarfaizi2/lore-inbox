Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbUKJIdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbUKJIdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 03:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbUKJIdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 03:33:32 -0500
Received: from mailservice.tudelft.nl ([130.161.131.5]:27433 "EHLO
	mailservice.tudelft.nl") by vger.kernel.org with ESMTP
	id S261286AbUKJIcL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 03:32:11 -0500
Subject: [PATCH] Documentation/preempt-locking.txt clarification
From: Thomas Hood <jdthood@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1074561880.26456.26.camel@localhost>
References: <1073302283.1903.85.camel@thanatos.hubertnet>
	 <1074561880.26456.26.camel@localhost>
Content-Type: multipart/mixed; boundary="=-vhWBOxNfj88zMKbJSxq1"
Message-Id: <1100074907.3654.780.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 10 Nov 2004 09:21:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vhWBOxNfj88zMKbJSxq1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-01-20 at 02:24, Robert Love wrote:
> On Mon, 2004-01-05 at 06:31, Thomas Hood wrote:
> > [...]
> > If I sent you a patch [for preempt-locking.txt] would you review
> > it and apply it if it improves the wording?
> [...]
> Sure, you can send me the patch.  If you want, CC akmp@osdl.org and lkml
> and we can just apply it.


Here is a patch for Documentation/preempt-locking.txt.

I have tried to clarify the text while at the same time
preserving the original meaning.  Everything is pretty clear
now except for the last paragraph which I still find baffling.
I don't know what "a test to see if preemption is required" is
exactly and I don't understand when such a test is required.
I read a number of source files but this didn't help.

It does need proof reading and if anyone would like to work on
it further then they're completely welcome.

Apart from that I have formatted the file to fit within 70
columns.

I also attach a patch.  It was prepared some time ago for Linux
2.6.3 but it still applies to Linux 2.6.8.1.
                                               // Thomas Hood


                  Proper locking in a Preemptible Kernel
                     Keeping kernel code preempt-safe
                       Robert Love <rml@tech9.net>
                         Last Update: 24 Feb 2004


INTRODUCTION


Allowing preemption within kernel code raises new locking issues.
For the most part the issues are the same as those under SMP --
concurrency and reentrancy -- and fortunately SMP locking mechanisms
can be leveraged.  The kernel requires additional explicit locking for
a few situations. The purpose of this document is to help kernel
hackers to understand the issues and to deal correctly with these
situations.
 

RULE #1: Explicitly protect per-CPU data structures


Two problems can arise.  Consider this code snippet:

	struct nifty data[NR_CPUS];
	some_value = tux[smp_processor_id()] + ...;
	/* imagine the task is preempted here... */
	tux[smp_processor_id()] = some_value;
	/* imagine the task is preempted here... */
	something = tux[smp_processor_id()];

The first problem is that the local data may fail to be locked for SMP
purposes because tasks running on other CPUs cannot access it.  But if
one task executing this code were to be preempted then another task on
the same CPU might interfere with the data.

Second, when the preempted task is finally rescheduled the value of
smp_processor_id() may be different from the old value.

For both of these reasons you must protect per-CPU data by disabling
preemption for the duration of the critical region.

The functions get_cpu() and put_cpu(), which disable preemption, may
be useful for this purpose.


RULE #2: Protect CPU state


In a preemptable kernel the state of the CPU must be protected.  
Vulnerable are the CPU structures and state not preserved over context
switches.  Which structures these are depends on the arch.  On x86,
for example, entering and exiting FPU mode must happen in critical
sections that are executed with preemption disabled.  Think what would
happen if a task was executing a floating-point instruction and was
preempted!  (Remember, the kernel does not save FPU state except for
user tasks.)  The FPU registers would be sold to the highest bidder.
Preemption must be disabled around such regions.

Note that some FPU functions have already been modified for preempt-
safety.  For example, kernel_fpu_begin() disables preemption.  On the
other hand, math_state_restore() must be called with preemption
already disabled.


RULE #3: A lock must be released by the task that acquires it


A lock acquired by one task must be released by the same task.  This
means you can't do oddball things like acquire a lock and go off to
play, leaving another task to release it.  If you want to do something
like that then acquire and release the lock in the first task and
make the other task wait on an event triggered by the first.


DISABLING PREEMPTION


Here are the functions that are used explicitly to disable and enable
preemption.

    preempt_disable()             increment the preempt counter
    preempt_enable()              decrement the preempt counter
    preempt_enable_no_resched()   decrement, but do not immediately preempt
    preempt_check_resched()       reschedule if needed
    preempt_count()               return the preempt count

The disable and enable functions are nestable.  In other words, you
can call preempt_disable() n times in a code path and preemption will
not be re-enabled until the n'th call to preempt_enable().

These are actually macros which are defined as no-ops if the kernel
is configured not to support preemption.

Note that you do not need explicitly to disable preemption if any
locks are held or if interrupts are disabled, since preemption is
implicitly disabled in those cases.

However, keep in mind that relying on irqs being disabled is a risky
business.  Any spin_unlock() that decreases the preemption count to 0
can trigger a reschedule.  Even a simple printk() might trigger such
a reschedule.  So rely on implicit preemption-disabling only if you
know that this sort of thing cannot happen in your code path.  The
best policy is to rely on implicit preemption-disabling only for
short times and only so long as your remain within your own code.


EXAMPLE -- EXPLICITLY PREVENTING PREEMPTION


An example of disabling preemption using the above functions:

	cpucache_t *cc; /* pointer to per-CPU data */
	/* ... */
	preempt_disable();
	cc = cc_data(searchp);
	if (cc && cc->avail) {
		__free_block(searchp, cc_entry(cc), cc->avail);
		cc->avail = 0;
	}
	preempt_enable();
	return 0;

Notice how the preemption-disabled range must encompass every
reference to the per-CPU data.

Another example:

	int buf[NR_CPUS]; /* per-CPU data */
	/* ... */
	set_cpu_val(buf);
	if (buf[smp_processor_id()] == -1) printf(KERN_INFO "wee!\n");
	spin_lock(&buf_lock);
	/* ... */

This code is not preempt-safe, but see how easily we can fix it by
simply moving the spin_lock() up two lines.


EXAMPLE -- PREVENTING PREEMPTION USING INTERRUPT DISABLING


It is possible to prevent preemption using local_irq_disable() and
local_irq_save().  If you do this you must be very careful not to
cause an event that would set need_resched and result in a preemption
check.  When in doubt, rely on locking or explicit preemption
disabling.

Note that as of 2.5 interrupt disabling is always local (i.e.,
per-CPU).

An additional concern is proper usage of local_irq_disable() and
local_irq_save().  These may be used to prevent preemption.  However,
on exit, if preemption may be enabled, a test to see if preemption is
required should be done.  If these are called from the spin_lock and
read/write lock macros then the right thing is done.  They may also be
called from within spinlock-protected regions and from interrupt
contexts and bottom halves/tasklets (which are protected by preemption
locks) without further ado.  However, if they are ever called from
outside of such contexts then a test for preemption should be done.



--=-vhWBOxNfj88zMKbJSxq1
Content-Disposition: attachment; filename=preempt-locking.txt.patch
Content-Type: text/x-patch; name=preempt-locking.txt.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.6.3/Documentation/preempt-locking.txt_ORIG	2003-12-18 03:58:07.000000000 +0100
+++ linux-2.6.3/Documentation/preempt-locking.txt	2004-02-24 19:37:50.000000000 +0100
@@ -1,97 +1,116 @@
-		  Proper Locking Under a Preemptible Kernel:
-		       Keeping Kernel Code Preempt-Safe
-			 Robert Love <rml@tech9.net>
-			  Last Updated: 28 Aug 2002
+                  Proper locking in a Preemptible Kernel
+                     Keeping kernel code preempt-safe
+                       Robert Love <rml@tech9.net>
+                         Last Update: 24 Feb 2004
 
 
 INTRODUCTION
 
 
-A preemptible kernel creates new locking issues.  The issues are the same as
-those under SMP: concurrency and reentrancy.  Thankfully, the Linux preemptible
-kernel model leverages existing SMP locking mechanisms.  Thus, the kernel
-requires explicit additional locking for very few additional situations.
-
-This document is for all kernel hackers.  Developing code in the kernel
-requires protecting these situations.
+Allowing preemption within kernel code raises new locking issues.
+For the most part the issues are the same as those under SMP --
+concurrency and reentrancy -- and fortunately SMP locking mechanisms
+can be leveraged.  The kernel requires additional explicit locking for
+a few situations. The purpose of this document is to help kernel
+hackers to understand the issues and to deal correctly with these
+situations.
  
 
-RULE #1: Per-CPU data structures need explicit protection
+RULE #1: Explicitly protect per-CPU data structures
 
 
-Two similar problems arise. An example code snippet:
+Two problems can arise.  Consider this code snippet:
 
-	struct this_needs_locking tux[NR_CPUS];
+	struct nifty data[NR_CPUS];
+	some_value = tux[smp_processor_id()] + ...;
+	/* imagine the task is preempted here... */
 	tux[smp_processor_id()] = some_value;
-	/* task is preempted here... */
+	/* imagine the task is preempted here... */
 	something = tux[smp_processor_id()];
 
-First, since the data is per-CPU, it may not have explicit SMP locking, but
-require it otherwise.  Second, when a preempted task is finally rescheduled,
-the previous value of smp_processor_id may not equal the current.  You must
-protect these situations by disabling preemption around them.
+The first problem is that the local data may fail to be locked for SMP
+purposes because tasks running on other CPUs cannot access it.  But if
+one task executing this code were to be preempted then another task on
+the same CPU might interfere with the data.
+
+Second, when the preempted task is finally rescheduled the value of
+smp_processor_id() may be different from the old value.
+
+For both of these reasons you must protect per-CPU data by disabling
+preemption for the duration of the critical region.
 
-You can also use put_cpu() and get_cpu(), which will disable preemption.
+The functions get_cpu() and put_cpu(), which disable preemption, may
+be useful for this purpose.
 
 
-RULE #2: CPU state must be protected.
+RULE #2: Protect CPU state
 
 
-Under preemption, the state of the CPU must be protected.  This is arch-
-dependent, but includes CPU structures and state not preserved over a context
-switch.  For example, on x86, entering and exiting FPU mode is now a critical
-section that must occur while preemption is disabled.  Think what would happen
-if the kernel is executing a floating-point instruction and is then preempted.
-Remember, the kernel does not save FPU state except for user tasks.  Therefore,
-upon preemption, the FPU registers will be sold to the lowest bidder.  Thus,
-preemption must be disabled around such regions.
+In a preemptable kernel the state of the CPU must be protected.  
+Vulnerable are the CPU structures and state not preserved over context
+switches.  Which structures these are depends on the arch.  On x86,
+for example, entering and exiting FPU mode must happen in critical
+sections that are executed with preemption disabled.  Think what would
+happen if a task was executing a floating-point instruction and was
+preempted!  (Remember, the kernel does not save FPU state except for
+user tasks.)  The FPU registers would be sold to the highest bidder.
+Preemption must be disabled around such regions.
 
-Note, some FPU functions are already explicitly preempt safe.  For example,
-kernel_fpu_begin and kernel_fpu_end will disable and enable preemption.
-However, math_state_restore must be called with preemption disabled.
+Note that some FPU functions have already been modified for preempt-
+safety.  For example, kernel_fpu_begin() disables preemption.  On the
+other hand, math_state_restore() must be called with preemption
+already disabled.
 
 
-RULE #3: Lock acquire and release must be performed by same task
+RULE #3: A lock must be released by the task that acquires it
 
 
-A lock acquired in one task must be released by the same task.  This
+A lock acquired by one task must be released by the same task.  This
 means you can't do oddball things like acquire a lock and go off to
-play while another task releases it.  If you want to do something
-like this, acquire and release the task in the same code path and
-have the caller wait on an event by the other task.
+play, leaving another task to release it.  If you want to do something
+like that then acquire and release the lock in the first task and
+make the other task wait on an event triggered by the first.
+
+
+DISABLING PREEMPTION
+
 
+Here are the functions that are used explicitly to disable and enable
+preemption.
 
-SOLUTION
+    preempt_disable()             increment the preempt counter
+    preempt_enable()              decrement the preempt counter
+    preempt_enable_no_resched()   decrement, but do not immediately preempt
+    preempt_check_resched()       reschedule if needed
+    preempt_count()               return the preempt count
 
+The disable and enable functions are nestable.  In other words, you
+can call preempt_disable() n times in a code path and preemption will
+not be re-enabled until the n'th call to preempt_enable().
 
-Data protection under preemption is achieved by disabling preemption for the
-duration of the critical region.
+These are actually macros which are defined as no-ops if the kernel
+is configured not to support preemption.
 
-preempt_enable()		decrement the preempt counter
-preempt_disable()		increment the preempt counter
-preempt_enable_no_resched()	decrement, but do not immediately preempt
-preempt_check_resched()		if needed, reschedule
-preempt_count()			return the preempt counter
+Note that you do not need explicitly to disable preemption if any
+locks are held or if interrupts are disabled, since preemption is
+implicitly disabled in those cases.
 
-The functions are nestable.  In other words, you can call preempt_disable
-n-times in a code path, and preemption will not be reenabled until the n-th
-call to preempt_enable.  The preempt statements define to nothing if
-preemption is not enabled.
+However, keep in mind that relying on irqs being disabled is a risky
+business.  Any spin_unlock() that decreases the preemption count to 0
+can trigger a reschedule.  Even a simple printk() might trigger such
+a reschedule.  So rely on implicit preemption-disabling only if you
+know that this sort of thing cannot happen in your code path.  The
+best policy is to rely on implicit preemption-disabling only for
+short times and only so long as your remain within your own code.
 
-Note that you do not need to explicitly prevent preemption if you are holding
-any locks or interrupts are disabled, since preemption is implicitly disabled
-in those cases.
 
-But keep in mind that 'irqs disabled' is a fundamentally unsafe way of
-disabling preemption - any spin_unlock() decreasing the preemption count
-to 0 might trigger a reschedule. A simple printk() might trigger a reschedule.
-So use this implicit preemption-disabling property only if you know that the
-affected codepath does not do any of this. Best policy is to use this only for
-small, atomic code that you wrote and which calls no complex functions.
+EXAMPLE -- EXPLICITLY PREVENTING PREEMPTION
 
-Example:
 
-	cpucache_t *cc; /* this is per-CPU */
+An example of disabling preemption using the above functions:
+
+	cpucache_t *cc; /* pointer to per-CPU data */
+	/* ... */
 	preempt_disable();
 	cc = cc_data(searchp);
 	if (cc && cc->avail) {
@@ -101,35 +120,41 @@
 	preempt_enable();
 	return 0;
 
-Notice how the preemption statements must encompass every reference of the
-critical variables.  Another example:
+Notice how the preemption-disabled range must encompass every
+reference to the per-CPU data.
+
+Another example:
 
-	int buf[NR_CPUS];
+	int buf[NR_CPUS]; /* per-CPU data */
+	/* ... */
 	set_cpu_val(buf);
 	if (buf[smp_processor_id()] == -1) printf(KERN_INFO "wee!\n");
 	spin_lock(&buf_lock);
 	/* ... */
 
-This code is not preempt-safe, but see how easily we can fix it by simply
-moving the spin_lock up two lines.
-
+This code is not preempt-safe, but see how easily we can fix it by
+simply moving the spin_lock() up two lines.
 
-PREVENTING PREEMPTION USING INTERRUPT DISABLING
 
+EXAMPLE -- PREVENTING PREEMPTION USING INTERRUPT DISABLING
 
-It is possible to prevent a preemption event using local_irq_disable and
-local_irq_save.  Note, when doing so, you must be very careful to not cause
-an event that would set need_resched and result in a preemption check.  When
-in doubt, rely on locking or explicit preemption disabling.
 
-Note in 2.5 interrupt disabling is now only per-CPU (e.g. local).
+It is possible to prevent preemption using local_irq_disable() and
+local_irq_save().  If you do this you must be very careful not to
+cause an event that would set need_resched and result in a preemption
+check.  When in doubt, rely on locking or explicit preemption
+disabling.
+
+Note that as of 2.5 interrupt disabling is always local (i.e.,
+per-CPU).
+
+An additional concern is proper usage of local_irq_disable() and
+local_irq_save().  These may be used to prevent preemption.  However,
+on exit, if preemption may be enabled, a test to see if preemption is
+required should be done.  If these are called from the spin_lock and
+read/write lock macros then the right thing is done.  They may also be
+called from within spinlock-protected regions and from interrupt
+contexts and bottom halves/tasklets (which are protected by preemption
+locks) without further ado.  However, if they are ever called from
+outside of such contexts then a test for preemption should be done.
 
-An additional concern is proper usage of local_irq_disable and local_irq_save.
-These may be used to protect from preemption, however, on exit, if preemption
-may be enabled, a test to see if preemption is required should be done.  If
-these are called from the spin_lock and read/write lock macros, the right thing
-is done.  They may also be called within a spin-lock protected region, however,
-if they are ever called outside of this context, a test for preemption should
-be made. Do note that calls from interrupt context or bottom half/ tasklets
-are also protected by preemption locks and so may use the versions which do
-not check preemption.

--=-vhWBOxNfj88zMKbJSxq1--

