Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261619AbUKJJjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbUKJJjo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUKJJjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:39:41 -0500
Received: from mailservice.tudelft.nl ([130.161.131.5]:46114 "EHLO
	mailservice.tudelft.nl") by vger.kernel.org with ESMTP
	id S261577AbUKJJh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:37:58 -0500
Subject: Re: [PATCH] Documentation/preempt-locking.txt clarification
From: Thomas Hood <jdthood@yahoo.co.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041110005742.35828d2b.akpm@osdl.org>
References: <1073302283.1903.85.camel@thanatos.hubertnet>
	 <1074561880.26456.26.camel@localhost> <1100074907.3654.780.camel@thanatos>
	 <20041110005742.35828d2b.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-b0H14U3BpJNHkknbOl8J"
Message-Id: <1100078840.3654.822.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 10 Nov 2004 10:27:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b0H14U3BpJNHkknbOl8J
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-11-10 at 09:57, Andrew Morton wrote:
> I guess it's saying ...

Thanks for the explanation.  I include a new patch which incorporates
your example.  I am in no position to judge the _truth_ of the
statements in this document; I am only hoping to _understand_ them.  :)

                                               // Thomas Hood


                  Proper locking in a Preemptible Kernel
                     Keeping kernel code preempt-safe
                       Robert Love <rml@tech9.net>
                         Last Update: 10 Nov 2004


INTRODUCTION


Allowing preemption within kernel code raises locking issues that
don't arise for a non-preemptable kernel.  For the most part the
issues are the same as those under SMP -- concurrency and reentrancy --
and fortunately SMP locking mechanisms can be leveraged.  The kernel
requires additional explicit locking for a few situations. The purpose
of this document is to help kernel hackers to understand the issues
and to deal correctly with these situations.
 

RULE #1: Explicitly protect per-CPU data structures


Two problems can arise.  Consider this code snippet:

	struct nifty data[NR_CPUS];
	data[smp_processor_id()] = ...;
	/* imagine the task is preempted here */
	some_value = data[smp_processor_id()];
	/* imagine the task is preempted here */
	data[smp_processor_id()] = some_value + ...;

The first problem is that local data may lack SMP locking (because
tasks running on other CPUs cannot access it); but when preemption is
possible, if one task executing this code is preempted then another
task on the same CPU can interfere with the data.

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
play, leaving another task to release the lock.  If you want to do
something like that then acquire and release the lock in the first
task and make the other task wait on an event triggered by the first.


DISABLING PREEMPTION


Here are the functions that are used explicitly to disable and enable
preemption.

   preempt_disable()            increment the preempt counter
   preempt_enable()             decrement the preempt counter
   preempt_enable_no_resched()  decrement, but do not immediately preempt
   preempt_check_resched()      reschedule if needed
   preempt_count()              return the preempt count

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
local_irq_save().  These may be used to prevent preemption.  If these
are called from the spin_lock and read/write lock macros then the
right thing is done.  They may also be called from within spinlock-
protected regions and from interrupt contexts and bottom halves /
tasklets (which are protected by preemption locks) without further
ado.  However, if they are ever called from outside of such contexts
then a test for preemption should be done.  E.g., if you do this:

        local_irq_disable();
	lah_de_dah();
	local_irq_enable();

then you should follow that by:

        preempt_check_resched();

just in case someone told this task to preempt itself while it had
interrupts disabled.



--=-b0H14U3BpJNHkknbOl8J
Content-Disposition: attachment; filename=preempt-locking.txt_jdth20041110_2.patch
Content-Type: text/x-patch; name=preempt-locking.txt_jdth20041110_2.patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- preempt-locking.txt_ORIG	2004-11-10 10:19:12.000000000 +0100
+++ preempt-locking.txt	2004-11-10 10:23:31.000000000 +0100
@@ -1,97 +1,116 @@
-		  Proper Locking Under a Preemptible Kernel:
-		       Keeping Kernel Code Preempt-Safe
-			 Robert Love <rml@tech9.net>
-			  Last Updated: 28 Aug 2002
+                  Proper locking in a Preemptible Kernel
+                     Keeping kernel code preempt-safe
+                       Robert Love <rml@tech9.net>
+                         Last Update: 10 Nov 2004
 
 
 INTRODUCTION
 
 
-A preemptible kernel creates new locking issues.  The issues are the same as
-those under SMP: concurrency and reentrancy.  Thankfully, the Linux preemptible
-kernel model leverages existing SMP locking mechanisms.  Thus, the kernel
-requires explicit additional locking for very few additional situations.
-
-This document is for all kernel hackers.  Developing code in the kernel
-requires protecting these situations.
+Allowing preemption within kernel code raises locking issues that
+don't arise for a non-preemptable kernel.  For the most part the
+issues are the same as those under SMP -- concurrency and reentrancy --
+and fortunately SMP locking mechanisms can be leveraged.  The kernel
+requires additional explicit locking for a few situations. The purpose
+of this document is to help kernel hackers to understand the issues
+and to deal correctly with these situations.
  
 
-RULE #1: Per-CPU data structures need explicit protection
+RULE #1: Explicitly protect per-CPU data structures
+
 
+Two problems can arise.  Consider this code snippet:
 
-Two similar problems arise. An example code snippet:
+	struct nifty data[NR_CPUS];
+	data[smp_processor_id()] = ...;
+	/* imagine the task is preempted here */
+	some_value = data[smp_processor_id()];
+	/* imagine the task is preempted here */
+	data[smp_processor_id()] = some_value + ...;
 
-	struct this_needs_locking tux[NR_CPUS];
-	tux[smp_processor_id()] = some_value;
-	/* task is preempted here... */
-	something = tux[smp_processor_id()];
+The first problem is that local data may lack SMP locking (because
+tasks running on other CPUs cannot access it); but when preemption is
+possible, if one task executing this code is preempted then another
+task on the same CPU can interfere with the data.
 
-First, since the data is per-CPU, it may not have explicit SMP locking, but
-require it otherwise.  Second, when a preempted task is finally rescheduled,
-the previous value of smp_processor_id may not equal the current.  You must
-protect these situations by disabling preemption around them.
+Second, when the preempted task is finally rescheduled the value of
+smp_processor_id() may be different from the old value.
 
-You can also use put_cpu() and get_cpu(), which will disable preemption.
+For both of these reasons you must protect per-CPU data by disabling
+preemption for the duration of the critical region.
 
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
 
-Note, some FPU functions are already explicitly preempt safe.  For example,
-kernel_fpu_begin and kernel_fpu_end will disable and enable preemption.
-However, math_state_restore must be called with preemption disabled.
+In a preemptable kernel the state of the CPU must be protected.  
+Vulnerable are the CPU structures and state not preserved over context
+switches.  Which structures these are depends on the arch.  On x86,
+for example, entering and exiting FPU mode must happen in critical
+sections that are executed with preemption disabled.  Think what would
+happen if a task was executing a floating-point instruction and was
+preempted!  (Remember, the kernel does not save FPU state except for
+user tasks.)  The FPU registers would be sold to the highest bidder.
+Preemption must be disabled around such regions.
 
+Note that some FPU functions have already been modified for preempt-
+safety.  For example, kernel_fpu_begin() disables preemption.  On the
+other hand, math_state_restore() must be called with preemption
+already disabled.
 
-RULE #3: Lock acquire and release must be performed by same task
 
+RULE #3: A lock must be released by the task that acquires it
 
-A lock acquired in one task must be released by the same task.  This
+
+A lock acquired by one task must be released by the same task.  This
 means you can't do oddball things like acquire a lock and go off to
-play while another task releases it.  If you want to do something
-like this, acquire and release the task in the same code path and
-have the caller wait on an event by the other task.
+play, leaving another task to release the lock.  If you want to do
+something like that then acquire and release the lock in the first
+task and make the other task wait on an event triggered by the first.
+
 
+DISABLING PREEMPTION
 
-SOLUTION
 
+Here are the functions that are used explicitly to disable and enable
+preemption.
 
-Data protection under preemption is achieved by disabling preemption for the
-duration of the critical region.
+   preempt_disable()            increment the preempt counter
+   preempt_enable()             decrement the preempt counter
+   preempt_enable_no_resched()  decrement, but do not immediately preempt
+   preempt_check_resched()      reschedule if needed
+   preempt_count()              return the preempt count
 
-preempt_enable()		decrement the preempt counter
-preempt_disable()		increment the preempt counter
-preempt_enable_no_resched()	decrement, but do not immediately preempt
-preempt_check_resched()		if needed, reschedule
-preempt_count()			return the preempt counter
+The disable and enable functions are nestable.  In other words, you
+can call preempt_disable() n times in a code path and preemption will
+not be re-enabled until the n'th call to preempt_enable().
 
-The functions are nestable.  In other words, you can call preempt_disable
-n-times in a code path, and preemption will not be reenabled until the n-th
-call to preempt_enable.  The preempt statements define to nothing if
-preemption is not enabled.
+These are actually macros which are defined as no-ops if the kernel
+is configured not to support preemption.
 
-Note that you do not need to explicitly prevent preemption if you are holding
-any locks or interrupts are disabled, since preemption is implicitly disabled
-in those cases.
+Note that you do not need explicitly to disable preemption if any
+locks are held or if interrupts are disabled, since preemption is
+implicitly disabled in those cases.
 
-But keep in mind that 'irqs disabled' is a fundamentally unsafe way of
-disabling preemption - any spin_unlock() decreasing the preemption count
-to 0 might trigger a reschedule. A simple printk() might trigger a reschedule.
-So use this implicit preemption-disabling property only if you know that the
-affected codepath does not do any of this. Best policy is to use this only for
-small, atomic code that you wrote and which calls no complex functions.
+However, keep in mind that relying on irqs being disabled is a risky
+business.  Any spin_unlock() that decreases the preemption count to 0
+can trigger a reschedule.  Even a simple printk() might trigger such
+a reschedule.  So rely on implicit preemption-disabling only if you
+know that this sort of thing cannot happen in your code path.  The
+best policy is to rely on implicit preemption-disabling only for
+short times and only so long as your remain within your own code.
 
-Example:
 
-	cpucache_t *cc; /* this is per-CPU */
+EXAMPLE -- EXPLICITLY PREVENTING PREEMPTION
+
+
+An example of disabling preemption using the above functions:
+
+	cpucache_t *cc; /* pointer to per-CPU data */
+	/* ... */
 	preempt_disable();
 	cc = cc_data(searchp);
 	if (cc && cc->avail) {
@@ -101,35 +120,51 @@
 	preempt_enable();
 	return 0;
 
-Notice how the preemption statements must encompass every reference of the
-critical variables.  Another example:
+Notice how the preemption-disabled range must encompass every
+reference to the per-CPU data.
 
-	int buf[NR_CPUS];
+Another example:
+
+	int buf[NR_CPUS]; /* per-CPU data */
+	/* ... */
 	set_cpu_val(buf);
 	if (buf[smp_processor_id()] == -1) printf(KERN_INFO "wee!\n");
 	spin_lock(&buf_lock);
 	/* ... */
 
-This code is not preempt-safe, but see how easily we can fix it by simply
-moving the spin_lock up two lines.
+This code is not preempt-safe, but see how easily we can fix it by
+simply moving the spin_lock() up two lines.
+
+
+EXAMPLE -- PREVENTING PREEMPTION USING INTERRUPT DISABLING
+
+
+It is possible to prevent preemption using local_irq_disable() and
+local_irq_save().  If you do this you must be very careful not to
+cause an event that would set need_resched and result in a preemption
+check.  When in doubt, rely on locking or explicit preemption
+disabling.
+
+Note that as of 2.5 interrupt disabling is always local (i.e.,
+per-CPU).
 
+An additional concern is proper usage of local_irq_disable() and
+local_irq_save().  These may be used to prevent preemption.  If these
+are called from the spin_lock and read/write lock macros then the
+right thing is done.  They may also be called from within spinlock-
+protected regions and from interrupt contexts and bottom halves /
+tasklets (which are protected by preemption locks) without further
+ado.  However, if they are ever called from outside of such contexts
+then a test for preemption should be done.  E.g., if you do this:
 
-PREVENTING PREEMPTION USING INTERRUPT DISABLING
+        local_irq_disable();
+	lah_de_dah();
+	local_irq_enable();
 
+then you should follow that by:
 
-It is possible to prevent a preemption event using local_irq_disable and
-local_irq_save.  Note, when doing so, you must be very careful to not cause
-an event that would set need_resched and result in a preemption check.  When
-in doubt, rely on locking or explicit preemption disabling.
+        preempt_check_resched();
 
-Note in 2.5 interrupt disabling is now only per-CPU (e.g. local).
+just in case someone told this task to preempt itself while it had
+interrupts disabled.
 
-An additional concern is proper usage of local_irq_disable and local_irq_save.
-These may be used to protect from preemption, however, on exit, if preemption
-may be enabled, a test to see if preemption is required should be done.  If
-these are called from the spin_lock and read/write lock macros, the right thing
-is done.  They may also be called within a spin-lock protected region, however,
-if they are ever called outside of this context, a test for preemption should
-be made. Do note that calls from interrupt context or bottom half/ tasklets
-are also protected by preemption locks and so may use the versions which do
-not check preemption.

--=-b0H14U3BpJNHkknbOl8J--

