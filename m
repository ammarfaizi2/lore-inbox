Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266270AbTGKU7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266778AbTGKU7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:59:30 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:11933 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S266270AbTGKU7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:59:24 -0400
Date: Fri, 11 Jul 2003 23:13:52 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: suspend/resume messages cleanup
Message-ID: <20030711211351.GA310@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Suspend/resume is way too verbose at the moment. It works good enough
to kill extra messages. Please apply,

							Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/sysenter.c	2003-05-27 13:42:29.000000000 +0200
+++ /usr/src/linux/arch/i386/kernel/sysenter.c	2003-07-11 23:01:54.000000000 +0200
@@ -31,8 +31,6 @@
 	wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
 	wrmsr(MSR_IA32_SYSENTER_ESP, tss->esp1, 0);
 	wrmsr(MSR_IA32_SYSENTER_EIP, (unsigned long) sysenter_entry, 0);
-
-	printk("Enabling SEP on CPU %d\n", cpu);
 	put_cpu();	
 }
 
--- /usr/src/tmp/linux/drivers/base/power.c	2003-06-15 22:42:36.000000000 +0200
+++ /usr/src/linux/drivers/base/power.c	2003-07-11 22:43:21.000000000 +0200
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
--- /usr/src/tmp/linux/kernel/suspend.c	2003-07-11 23:03:35.000000000 +0200
+++ /usr/src/linux/kernel/suspend.c	2003-07-11 22:57:01.000000000 +0200
@@ -143,8 +143,7 @@
 /*
  * Debug
  */
-#define	DEBUG_DEFAULT
-#undef	DEBUG_PROCESS
+#undef	DEBUG_DEFAULT
 #undef	DEBUG_SLOW
 #define TEST_SWSUSP 1		/* Set to 1 to reboot instead of halt machine after suspension */
 
@@ -563,7 +562,6 @@
 			free_suspend_pagedir((unsigned long) pagedir);
 			return NULL;
 		}
-		printk(".");
 		SetPageNosave(virt_to_page(p->address));
 		p->orig_address = 0;
 		p++;
@@ -585,8 +583,8 @@
 		return 1;
 
 	set_console (SUSPEND_CONSOLE);
-	if(vt_waitactive(SUSPEND_CONSOLE)) {
-		PRINTK("Bummer. Can't switch VCs.");
+	if (vt_waitactive(SUSPEND_CONSOLE)) {
+		printk(KERN_ERR "Bummer. Can't switch VCs.\n");
 		return 1;
 	}
 	orig_kmsg = kmsg_redirect;
@@ -854,7 +852,6 @@
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
 	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK(KERN_WARNING "%sLeaving do_magic_suspend_2...\n", name_suspend);	
 }
 
 static void do_software_suspend(void)

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
