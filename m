Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270586AbTGZW2h (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270592AbTGZW2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:28:37 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:45224 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270586AbTGZW2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:28:34 -0400
Date: Sun, 27 Jul 2003 00:43:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Make suspend less talkative
Message-ID: <20030726224335.GA483@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is trivial killing of unneccessary printks. They mess up screen
badly during suspend. Patrick, some of those are patches to your parts
of code, so please try to propagate at least them to Linus.
								Pavel

Index: linux/drivers/acpi/sleep/main.c
===================================================================
--- linux.orig/drivers/acpi/sleep/main.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/acpi/sleep/main.c	2003-07-22 12:53:27.000000000 +0200
@@ -197,7 +205,7 @@
 		break;
 	}
 	local_irq_restore(flags);
-	printk(KERN_CRIT "Back to C!\n");
+	printk(KERN_DEBUG "Back to C!\n");
 
 	return status;
 }


Index: linux/arch/i386/kernel/sysenter.c
===================================================================
--- linux.orig/arch/i386/kernel/sysenter.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/arch/i386/kernel/sysenter.c	2003-07-17 22:22:58.000000000 +0200
@@ -31,8 +31,6 @@
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp1, 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
-
-	printk("Enabling SEP on CPU %d\n", cpu);
 	put_cpu();	
 }
 
Index: linux/drivers/base/power.c
===================================================================
--- linux.orig/drivers/base/power.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/base/power.c	2003-07-17 22:22:58.000000000 +0200
@@ -52,8 +52,6 @@
 	struct device * dev;
 	int error = 0;
 
-	printk(KERN_EMERG "Suspending devices\n");
-
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
 		if (dev->driver && dev->driver->suspend) {
@@ -114,8 +112,6 @@
 		}
 	}
 	up_write(&devices_subsys.rwsem);
-
-	printk(KERN_EMERG "Devices Resumed\n");
 }
 
 /**
@@ -125,8 +121,6 @@
 {
 	struct device * dev;
 	
-	printk(KERN_EMERG "Shutting down devices\n");
-
 	down_write(&devices_subsys.rwsem);
 	list_for_each_entry_reverse(dev,&devices_subsys.kset.list,kobj.entry) {
 		pr_debug("shutting down %s: ",dev->name);


Index: linux/kernel/suspend.c
===================================================================
--- linux.orig/kernel/suspend.c	2003-07-22 13:39:43.000000000 +0200
+++ linux/kernel/suspend.c	2003-07-22 13:46:26.000000000 +0200
@@ -561,7 +596,6 @@
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
-		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -852,7 +853,6 @@
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 static void do_software_suspend(void)
@@ -888,12 +881,11 @@
 			 * using normal kernel mechanism.
 			 */
 			do_magic(0);
-		PRINTK("Restarting processes...\n");
 		thaw_processes();
 	}
 	software_suspend_enabled = 1;
 	MDELAY(1000);
-	restore_console ();
+	restore_console();
 }
 
 /*

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
