Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUGQXTB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUGQXTB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUGQW4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 18:56:00 -0400
Received: from digitalimplant.org ([64.62.235.95]:31721 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262391AbUGQWfP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:15 -0400
Date: Sat, 17 Jul 2004 15:35:07 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [8/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171528590.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1850, 2004/07/17 10:45:08-07:00, mochel@digitalimplant.org

[swsusp] Add helper suspend_finish, move common code there.

- Move call out of assembly-callbacks and into software_suspend() after
  do_magic() returns.


 kernel/power/swsusp.c |   56 ++++++++++++++++++++++----------------------------
 1 files changed, 25 insertions(+), 31 deletions(-)


diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:29 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:29 -07:00
@@ -869,6 +869,30 @@
 	/* NOTREACHED */
 }

+
+static void suspend_finish(void)
+{
+	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */
+
+	free_pages((unsigned long) pagedir_nosave, pagedir_order);
+	spin_unlock_irq(&suspend_pagedir_lock);
+
+#ifdef CONFIG_HIGHMEM
+	printk( "Restoring highmem\n" );
+	restore_highmem();
+#endif
+	device_resume();
+	PRINTK( "Fixing swap signatures... " );
+	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
+	PRINTK( "ok\n" );
+
+#ifdef SUSPEND_CONSOLE
+	acquire_console_sem();
+	update_screen(fg_console);
+	release_console_sem();
+#endif
+}
+
 /*
  * Magic happens here
  */
@@ -892,30 +916,8 @@
 	BUG_ON (pagedir_order_check != pagedir_order);

 	__flush_tlb_global();		/* Even mappings of "global" things (vmalloc) need to be fixed */
-
-	PRINTK( "Freeing prev allocated pagedir\n" );
-	free_suspend_pagedir((unsigned long) pagedir_save);
-
-#ifdef CONFIG_HIGHMEM
-	printk( "Restoring highmem\n" );
-	restore_highmem();
-#endif
-	printk("done, devices\n");
-
 	device_power_up();
 	spin_unlock_irq(&suspend_pagedir_lock);
-	device_resume();
-
-	/* Fixme: this is too late; we should do this ASAP to avoid "infinite reboots" problem */
-	PRINTK( "Fixing swap signatures... " );
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK( "ok\n" );
-
-#ifdef SUSPEND_CONSOLE
-	acquire_console_sem();
-	update_screen(fg_console);
-	release_console_sem();
-#endif
 }

 /* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:
@@ -964,15 +966,6 @@

 	barrier();
 	mb();
-	spin_lock_irq(&suspend_pagedir_lock);	/* Done to disable interrupts */
-
-	free_pages((unsigned long) pagedir_nosave, pagedir_order);
-	spin_unlock_irq(&suspend_pagedir_lock);
-
-	device_resume();
-	PRINTK( "Fixing swap signatures... " );
-	mark_swapfiles(((swp_entry_t) {0}), MARK_SWAP_RESUME);
-	PRINTK( "ok\n" );
 }

 /*
@@ -1015,6 +1008,7 @@
 			 * using normal kernel mechanism.
 			 */
 			do_magic(0);
+			suspend_finish();
 		}
 		thaw_processes();
 		enable_nonboot_cpus();
