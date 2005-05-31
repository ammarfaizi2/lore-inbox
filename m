Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVEaHbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVEaHbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 03:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVEaHbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 03:31:06 -0400
Received: from gate.crashing.org ([63.228.1.57]:1711 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261284AbVEaH35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 03:29:57 -0400
Subject: [RFC] Add some hooks to generic suspend code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 31 May 2005 17:29:37 +1000
Message-Id: <1117524577.5826.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

While consolidating the powermac suspend to ram and suspend to disk
implementations to properly use the new framework in kernel/power, among
others, I ended up with the need of adding various callbacks to
kernel/power/main.c. Here is a patch adding & documenting those.

The reasons I need them are:

	/* Call before process freezing. If returns 0, then no freeze
	 * should be done, if 1, freeze, negative -> error
	 */
	int (*pre_freeze)(suspend_state_t state);

I'm using that one for calling my "old style" notifiers (they are beeing phased
out but I still have a couple of drivers using them). The reason I do that here
is because that's how my APM emulation hooks, and that code interacts with userland
(to properly signal things like X of the suspend process), so I need to do that
before we freeze processes.

This call also allow me to decide not to freeze process (in my suspend-to-ram
implementation) by returning 0 (the absence of the callback defaults to freeze
of course, to not break existing code). So far, I have been using the freezer
though, as it seem to be fast enough, but I still dislike relying on it for
suspend to ram, it just hides bugs imho, and I've had a couple of problems with
it where it failed to stop a process occasionally, or lost track of one on
wakeup (and left it in D state in the refrigerator forever) for reasons I haven't
yet explained.


	/* called just before irqs are off and device second pass
	 * and sysdevs are suspended. This function can on some archs
	 * shut irqs off, in which case, they'll still be off when
	 * finish_irqs() is called.
	 */
	int (*prepare_irqs)(suspend_state_t state);

I use that one to do some housekeeping that I want to do before the interrupts are
switched off, that is after device_suspend() and before device_power_off(). That
includes some mucking around with the interrupt controller (so that it doesn't try
to deliver interrupts to a CPU that won't take them, that avoids some "issues" on
wakeup), plus a couple of other things that don't quite fit in sysdev's and that
I want to do before sysdev's get suspended.

Additionally, I shut interrupts down (with local_irq_disable) myself in that callback,
which means that the "common" code which does local_irq_save/restore will end up not
re-enabling them before it calls the "mirror" callback of that one (see below the
explanation of finish_irqs), which I do need.


	/* called after sysdevs and "irq off" devices have been
	 * worken up, irqs have just been restored to whatever state
	 * prepare_irqs() left them in.
	 */
	void (*finish_irqs)(suspend_state_t state);

This is the pending of the above callback. It gets called after sysdev's
have been woken up but before normal devices have. It's called after the core has
restored local interrupts to what they were upon exit of prepare_irqs(), so if
you do nothing special in prepare_irqs(), you'll get entered with irqs re-enabled
here, while if you exit prepare_irqs() with irqs off, you'll get here with irqs
off as well (and thus become responsible for re-enabling them).

I want this callback to have finer control of re-enabling interrutps. The interrupt
controller has been partially reconfigured earlier in arch code, but the CPU priority
is only lowered here, so that it starts hitting the CPU again only now. There is
also some code to properly wake up the CPU decrementer so it ticks right away, and
to force taking a pseudo-interrupt (to sort-of "kick" the interrupt controller into
life, seems to work around an issue that I think is related to a HW bug in the
interrupt controller we use). 

I also do some arch magic at this point, mirror of what was done in prepare_irqs(),
that doesn't quite fit in a sysdev.


	/* called after unfreezing userland */
	void (*post_freeze)(suspend_state_t state);

That one is the mirror of pre-freeze, gets called after userland has been re-enabled,
it also calls my old-style notifiers, which includes APM emulation, which is important
for sending the APM wakeup events to things like X.


Please comment, I would like these patches in early 2.6.13 stages,

Thanks,
Ben.


Index: linux-work/include/linux/pm.h
===================================================================
--- linux-work.orig/include/linux/pm.h	2005-05-31 16:29:22.000000000 +1000
+++ linux-work/include/linux/pm.h	2005-05-31 16:57:29.000000000 +1000
@@ -169,9 +169,38 @@
 
 struct pm_ops {
 	suspend_disk_method_t pm_disk_mode;
+	
+	/* Call before process freezing. If returns 0, then no freeze
+	 * should be done, if 1, freeze, negative -> error
+	 */
+	int (*pre_freeze)(suspend_state_t state);
+
+	/* called before devices are suspended */
 	int (*prepare)(suspend_state_t state);
+
+	/* called just before irqs are off and device second pass
+	 * and sysdevs are suspended. This function can on some archs
+	 * shut irqs off, in which case, they'll still be off when
+	 * finish_irqs() is called.
+	 */
+	int (*prepare_irqs)(suspend_state_t state);
+
+	/* called for entering the actual suspend state. Exits with
+	 * machine worken up and interrupts off
+	 */
 	int (*enter)(suspend_state_t state);
-	int (*finish)(suspend_state_t state);
+
+	/* called after sysdevs and "irq off" devices have been
+	 * worken up, irqs have just been restored to whatever state
+	 * prepare_irqs() left them in.
+	 */
+	void (*finish_irqs)(suspend_state_t state);
+
+	/* called after all devices are woken up, processes still frozen */
+	void (*finish)(suspend_state_t state);
+
+	/* called after unfreezing userland */
+	void (*post_freeze)(suspend_state_t state);
 };
 
 extern void pm_set_ops(struct pm_ops *);
Index: linux-work/kernel/power/main.c
===================================================================
--- linux-work.orig/kernel/power/main.c	2005-05-31 16:29:22.000000000 +1000
+++ linux-work/kernel/power/main.c	2005-05-31 16:57:29.000000000 +1000
@@ -23,6 +23,7 @@
 
 struct pm_ops * pm_ops = NULL;
 suspend_disk_method_t pm_disk_mode = PM_DISK_SHUTDOWN;
+static int pm_process_frozen;
 
 /**
  *	pm_set_ops - Set the global power method table. 
@@ -49,32 +50,53 @@
 static int suspend_prepare(suspend_state_t state)
 {
 	int error = 0;
+	int freeze = 1;
 
 	if (!pm_ops || !pm_ops->enter)
 		return -EPERM;
 
 	pm_prepare_console();
 
-	if (freeze_processes()) {
+	if (pm_ops->pre_freeze)
+		freeze = pm_ops->pre_freeze(state);
+	if (freeze < 0)
+		goto Console;
+
+	if (freeze && freeze_processes()) {
 		error = -EAGAIN;
 		goto Thaw;
 	}
+	pm_process_frozen = freeze;
 
 	if (pm_ops->prepare) {
+		pr_debug("preparing arch...\n");
 		if ((error = pm_ops->prepare(state)))
 			goto Thaw;
 	}
 
+	pr_debug("suspending devices...\n");
 	if ((error = device_suspend(PMSG_SUSPEND))) {
 		printk(KERN_ERR "Some devices failed to suspend\n");
 		goto Finish;
 	}
+
+	if (pm_ops->prepare_irqs) {
+		pr_debug("preparing arch irqs...\n");
+		if ((error = pm_ops->prepare_irqs(state)))
+			goto Finish;
+	}
+
 	return 0;
  Finish:
 	if (pm_ops->finish)
 		pm_ops->finish(state);
  Thaw:
-	thaw_processes();
+	if (freeze)
+		thaw_processes();
+
+	if (pm_ops->post_freeze)
+		pm_ops->post_freeze(state);
+ Console:
 	pm_restore_console();
 	return error;
 }
@@ -109,10 +131,18 @@
 
 static void suspend_finish(suspend_state_t state)
 {
+	if (!pm_ops)
+		return;
+
+	if (pm_ops->finish_irqs)
+		pm_ops->finish_irqs(state);
 	device_resume();
-	if (pm_ops && pm_ops->finish)
+	if (pm_ops->finish)
 		pm_ops->finish(state);
-	thaw_processes();
+	if (pm_process_frozen)
+		thaw_processes();
+	if (pm_ops->post_freeze)
+		pm_ops->post_freeze(state);
 	pm_restore_console();
 }
 


