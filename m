Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751792AbWBWW22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWBWW22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWBWW21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:28:27 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:47250 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751793AbWBWW21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:28:27 -0500
Date: Thu, 23 Feb 2006 17:28:24 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>
cc: sekharan@us.ibm.com, <linux-kernel@vger.kernel.org>
Subject: [PATCH] The idle notifier chain should be atomic
In-Reply-To: <20060223110350.49c8b869.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44L0.0602231631560.7782-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch (as658) makes the idle_notifier in x86_64 and idle_chain in
s390 into atomic notifier chains rather than blocking chains.  This is
necessary because they are called during IRQ handling as CPUs leave and
enter the idle state.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

This patch should fix one of the problems you saw.  A second patch to fix 
the other problem is right behind.

Please revert those two debugging changes (the one I sent and the one you 
wrote) before applying this.

Alan Stern

Index: usb-2.6/arch/x86_64/kernel/process.c
===================================================================
--- usb-2.6.orig/arch/x86_64/kernel/process.c
+++ usb-2.6/arch/x86_64/kernel/process.c
@@ -66,17 +66,17 @@ EXPORT_SYMBOL(boot_option_idle_override)
 void (*pm_idle)(void);
 static DEFINE_PER_CPU(unsigned int, cpu_idle_state);
 
-static BLOCKING_NOTIFIER_HEAD(idle_notifier);
+static ATOMIC_NOTIFIER_HEAD(idle_notifier);
 
 void idle_notifier_register(struct notifier_block *n)
 {
-	blocking_notifier_chain_register(&idle_notifier, n);
+	atomic_notifier_chain_register(&idle_notifier, n);
 }
 EXPORT_SYMBOL_GPL(idle_notifier_register);
 
 void idle_notifier_unregister(struct notifier_block *n)
 {
-	blocking_notifier_chain_unregister(&idle_notifier, n);
+	atomic_notifier_chain_unregister(&idle_notifier, n);
 }
 EXPORT_SYMBOL(idle_notifier_unregister);
 
@@ -86,13 +86,13 @@ static DEFINE_PER_CPU(enum idle_state, i
 void enter_idle(void)
 {
 	__get_cpu_var(idle_state) = CPU_IDLE;
-	blocking_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
+	atomic_notifier_call_chain(&idle_notifier, IDLE_START, NULL);
 }
 
 static void __exit_idle(void)
 {
 	__get_cpu_var(idle_state) = CPU_NOT_IDLE;
-	blocking_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
+	atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
 }
 
 /* Called from interrupts to signify idle end */
Index: usb-2.6/arch/s390/kernel/process.c
===================================================================
--- usb-2.6.orig/arch/s390/kernel/process.c
+++ usb-2.6/arch/s390/kernel/process.c
@@ -76,17 +76,17 @@ unsigned long thread_saved_pc(struct tas
 /*
  * Need to know about CPUs going idle?
  */
-static BLOCKING_NOTIFIER_HEAD(idle_chain);
+static ATOMIC_NOTIFIER_HEAD(idle_chain);
 
 int register_idle_notifier(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_register(&idle_chain, nb);
+	return atomic_notifier_chain_register(&idle_chain, nb);
 }
 EXPORT_SYMBOL(register_idle_notifier);
 
 int unregister_idle_notifier(struct notifier_block *nb)
 {
-	return blocking_notifier_chain_unregister(&idle_chain, nb);
+	return atomic_notifier_chain_unregister(&idle_chain, nb);
 }
 EXPORT_SYMBOL(unregister_idle_notifier);
 
@@ -95,7 +95,7 @@ void do_monitor_call(struct pt_regs *reg
 	/* disable monitor call class 0 */
 	__ctl_clear_bit(8, 15);
 
-	blocking_notifier_call_chain(&idle_chain, CPU_NOT_IDLE,
+	atomic_notifier_call_chain(&idle_chain, CPU_NOT_IDLE,
 			    (void *)(long) smp_processor_id());
 }
 
@@ -116,7 +116,7 @@ void default_idle(void)
 		return;
 	}
 
-	rc = blocking_notifier_call_chain(&idle_chain,
+	rc = atomic_notifier_call_chain(&idle_chain,
 			CPU_IDLE, (void *)(long) cpu);
 	if (rc != NOTIFY_OK && rc != NOTIFY_DONE)
 		BUG();

