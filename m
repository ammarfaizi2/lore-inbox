Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266682AbUGLHFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbUGLHFZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266724AbUGLHFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:05:25 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:17523 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266682AbUGLHFJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:05:09 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.8-rc1] Make i386 die() more resilient against recursive errors
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 12 Jul 2004 17:05:03 +1000
Message-ID: <11093.1089615903@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make i386 die() more resilient against recursive errors, almost a cut
and paste of the ia64 die() routine.  Much of the patch is indentation
changes.

Signed-off-by: Keith Owens <kaos@sgi.com>

Index: 2.6.8-rc1/arch/i386/kernel/traps.c
===================================================================
--- 2.6.8-rc1.orig/arch/i386/kernel/traps.c	2004-07-12 16:52:39.000000000 +1000
+++ 2.6.8-rc1/arch/i386/kernel/traps.c	2004-07-12 16:52:42.000000000 +1000
@@ -292,35 +292,52 @@ bug:
 	printk("Kernel BUG\n");
 }
 
-spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
-
 void die(const char * str, struct pt_regs * regs, long err)
 {
+	static struct {
+		spinlock_t lock;
+		u32 lock_owner;
+		int lock_owner_depth;
+	} die = {
+		.lock =			SPIN_LOCK_UNLOCKED,
+		.lock_owner =		-1,
+		.lock_owner_depth =	0
+	};
 	static int die_counter;
-	int nl = 0;
 
-	console_verbose();
-	spin_lock_irq(&die_lock);
-	bust_spinlocks(1);
-	handle_BUG(regs);
-	printk(KERN_ALERT "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
+	if (die.lock_owner != smp_processor_id()) {
+		console_verbose();
+		spin_lock_irq(&die.lock);
+		die.lock_owner = smp_processor_id();
+		die.lock_owner_depth = 0;
+		bust_spinlocks(1);
+	}
+
+	if (++die.lock_owner_depth < 3) {
+		int nl = 0;
+		handle_BUG(regs);
+		printk(KERN_ALERT "%s: %04lx [#%d]\n", str, err & 0xffff, ++die_counter);
 #ifdef CONFIG_PREEMPT
-	printk("PREEMPT ");
-	nl = 1;
+		printk("PREEMPT ");
+		nl = 1;
 #endif
 #ifdef CONFIG_SMP
-	printk("SMP ");
-	nl = 1;
+		printk("SMP ");
+		nl = 1;
 #endif
 #ifdef CONFIG_DEBUG_PAGEALLOC
-	printk("DEBUG_PAGEALLOC");
-	nl = 1;
+		printk("DEBUG_PAGEALLOC");
+		nl = 1;
 #endif
-	if (nl)
-		printk("\n");
-	show_registers(regs);
+		if (nl)
+			printk("\n");
+		show_registers(regs);
+  	} else
+		printk(KERN_ERR "Recursive die() failure, output suppressed\n");
+
 	bust_spinlocks(0);
-	spin_unlock_irq(&die_lock);
+	die.lock_owner = -1;
+	spin_unlock_irq(&die.lock);
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 

