Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266712AbUFYLz5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266712AbUFYLz5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 07:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266713AbUFYLz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 07:55:57 -0400
Received: from gprs214-83.eurotel.cz ([160.218.214.83]:12928 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266712AbUFYLzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 07:55:52 -0400
Date: Fri, 25 Jun 2004 13:55:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Next step of smp support & fix device suspending
Message-ID: <20040625115529.GA764@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This introduces functions for stopping all-but-boot-cpus, which will
be needed for smp suspend, and fixes level for calling driver model:
there's no D4 power level, only D3 (means device off), and tg3 driver
actually cares. Ugh and one useless mdelay killed, and
freeze_processes() now BUGS() if its not compiled in. [We can probably
just remove it for non-CONFIG_PM case in future]. It is bad idea to
pretend success, and nobody should ever call it in !CONFIG_PM case
anyway. Please apply,
								Pavel

--- linux-cvs/kernel/power/swsusp.c	2004-06-25 13:13:35.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-25 13:41:06.000000000 +0200
@@ -716,7 +721,7 @@
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
 
-	device_power_down(4);
+	device_power_down(3);
 	PRINTK( "Waiting for DMAs to settle down...\n");
 	mdelay(1000);	/* We do not want some readahead with DMA to corrupt our memory, right?
 			   Do it with disabled interrupts for best effect. That way, if some
@@ -785,7 +795,7 @@
 {
 	int is_problem;
 	read_swapfiles();
-	device_power_down(4);
+	device_power_down(3);
 	is_problem = suspend_prepare_image();
 	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -802,7 +812,6 @@
 	barrier();
 	mb();
 	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */ 
-	mdelay(1000);
 
 	free_pages((unsigned long) pagedir_nosave, pagedir_order);
 	spin_unlock_irq(&suspend_pagedir_lock);
@@ -839,9 +848,10 @@
                    need half of memory free. */
 
 		free_some_memory();
-		
-		/* Save state of all device drivers, and stop them. */		   
-		if ((res = device_suspend(4))==0)
+		disable_nonboot_cpus();
+		/* Save state of all device drivers, and stop them. */
+		printk("Suspending devices... ");
+		if ((res = device_suspend(3))==0) {
 			/* If stopping device drivers worked, we proceed basically into
 			 * suspend_save_image.
 			 *
@@ -852,7 +862,9 @@
 			 * using normal kernel mechanism.
 			 */
 			do_magic(0);
+		}
 		thaw_processes();
+		enable_nonboot_cpus();
 	} else
 		res = -EBUSY;
 	software_suspend_enabled = 1;
@@ -1192,7 +1204,9 @@
 	printk( "resuming from %s\n", resume_file);
 	if (read_suspend_image(resume_file, 0))
 		goto read_failure;
-	device_suspend(4);
+	/* FIXME: Should we stop processes here, just to be safer? */
+	disable_nonboot_cpus();
+	device_suspend(3);
 	do_magic(1);
 	panic("This never returns");
 
--- linux-cvs/include/linux/suspend.h	2004-04-12 23:57:22.000000000 +0200
+++ linux/include/linux/suspend.h	2004-06-25 13:07:52.000000000 +0200
@@ -67,20 +67,19 @@
 extern void pm_restore_console(void);
 
 #else
-static inline void refrigerator(unsigned long flag)
-{
-
-}
-static inline int freeze_processes(void)
-{
-	return 0;
-}
-static inline void thaw_processes(void)
-{
-
-}
+static inline void refrigerator(unsigned long flag) {}
+static inline int freeze_processes(void) { BUG(); }
+static inline void thaw_processes(void) {}
 #endif	/* CONFIG_PM */
 
+#ifdef CONFIG_SMP
+extern void disable_nonboot_cpus(void);
+extern void enable_nonboot_cpus(void);
+#else
+static inline void disable_nonboot_cpus(void) {}
+static inline void enable_nonboot_cpus(void) {}
+#endif
+
 asmlinkage void do_magic(int is_resume);
 asmlinkage void do_magic_resume_1(void);
 asmlinkage void do_magic_resume_2(void);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
