Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261660AbTBXWgl>; Mon, 24 Feb 2003 17:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTBXWgl>; Mon, 24 Feb 2003 17:36:41 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11524 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261660AbTBXWgh>;
	Mon, 24 Feb 2003 17:36:37 -0500
Date: Mon, 24 Feb 2003 23:46:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp and S3 fixes
Message-ID: <20030224224610.GA15288@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

These are minor fixes for swsusp and S3 sleep. #ifdef mess in
acpi_save_state_mem() is simplified, better error handling in
reserving bootmem, handle video bioses that play with segment
registers, automagic support for S3 on toshiba notebook, don't try
to sync() when pdflush is already stopped, and reorder actions to make
pdflush not complain. Please apply,
						Pavel

--- clean/arch/i386/kernel/acpi/sleep.c	2003-02-15 18:51:10.000000000 +0100
+++ linux/arch/i386/kernel/acpi/sleep.c	2003-02-18 23:09:01.000000000 +0100
@@ -2,6 +2,7 @@
  * sleep.c - x86-specific ACPI sleep support.
  *
  *  Copyright (C) 2001-2003 Patrick Mochel
+ *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
  */
 
 #include <linux/acpi.h>
@@ -34,10 +35,8 @@
  */
 int acpi_save_state_mem (void)
 {
-#if CONFIG_X86_PAE
-	panic("S3 and PAE do not like each other for now.");
-	return 1;
-#endif
+	if (!acpi_wakeup_address)
+		return 1;
 	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
 	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
@@ -65,17 +64,24 @@
 /**
  * acpi_reserve_bootmem - do _very_ early ACPI initialisation
  *
- * We allocate a page in low memory for the wakeup
+ * We allocate a page from the first 1MB of memory for the wakeup
  * routine for when we come back from a sleep state. The
- * runtime allocator allows specification of <16M pages, but not
- * <1M pages.
+ * runtime allocator allows specification of <16MB pages, but not
+ * <1MB pages.
  */
 void __init acpi_reserve_bootmem(void)
 {
+	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE) {
+		printk(KERN_ERR "ACPI: Wakeup code way too big, S3 disabled.\n");
+		return;
+	}
+#if CONFIG_X86_PAE
+	printk(KERN_ERR "ACPI: S3 and PAE do not like each other for now, S3 disabled.\n");
+	return;
+#endif
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
-	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
-		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
-	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
+	if (!acpi_wakeup_address)
+		printk(KERN_ERR "ACPI: Cannot allocate lowmem, S3 disabled.\n");
 }
 
 static int __init acpi_sleep_setup(char *str)
--- clean/arch/i386/kernel/acpi/wakeup.S	2003-02-15 18:51:10.000000000 +0100
+++ linux/arch/i386/kernel/acpi/wakeup.S	2003-02-18 00:58:24.000000000 +0100
@@ -44,6 +44,9 @@
 	testl	$1, video_flags - wakeup_code
 	jz	1f
 	lcall   $0xc000,$3
+	movw	%cs, %ax
+	movw	%ax, %ds					# Bios might have played with that
+	movw	%ax, %ss
 1:
 
 	testl	$2, video_flags - wakeup_code
--- clean/arch/i386/kernel/dmi_scan.c	2003-02-11 17:40:33.000000000 +0100
+++ linux/arch/i386/kernel/dmi_scan.c	2003-02-15 21:22:10.000000000 +0100
@@ -455,7 +455,7 @@
 
 static __init int broken_toshiba_keyboard(struct dmi_blacklist *d)
 {
-	printk(KERN_WARNING "Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, contact pavel@ucw.cz\n");
+	printk(KERN_WARNING "Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, see http://davyd.ucc.asn.au/projects/toshiba/README\n");
 	return 0;
 }
 
@@ -470,6 +470,21 @@
 	return 0;
 }
 
+static __init int reset_videomode_after_s3(struct dmi_blacklist *d)
+{
+	/* See acpi_wakeup.S */
+	extern long acpi_video_flags;
+	acpi_video_flags |= 2;
+	return 0;
+}
+
+static __init int reset_videobios_after_s3(struct dmi_blacklist *d)
+{
+	extern long acpi_video_flags;
+	acpi_video_flags |= 1;
+	return 0;
+}
+
 /*
  * Some Bioses enable the PS/2 mouse (touchpad) at resume, even if it was
  * disabled before the suspend. Linux used to get terribly confused by that.
@@ -743,6 +758,10 @@
 			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
 			NO_MATCH, NO_MATCH, NO_MATCH
 			} },
+	{ reset_videomode_after_s3, "Toshiba Satellite 4030cdt", { /* Reset video mode after returning from ACPI S3 sleep */
+			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
+			NO_MATCH, NO_MATCH, NO_MATCH
+			} },
 
 	{ print_if_true, KERN_WARNING "IBM T23 - BIOS 1.03b+ and controller firmware 1.02+ may be needed for Linux APM.", {
 			MATCH(DMI_SYS_VENDOR, "IBM"),
--- clean/kernel/suspend.c	2003-02-11 17:41:41.000000000 +0100
+++ linux/kernel/suspend.c	2003-02-21 11:59:47.000000000 +0100
@@ -604,12 +608,12 @@
 
 static int prepare_suspend_processes(void)
 {
+	sys_sync();	/* Syncing needs pdflushd, so do it before stopping processes */
 	if (freeze_processes()) {
 		printk( KERN_ERR "Suspend failed: Not all processes stopped!\n" );
 		thaw_processes();
 		return 1;
 	}
-	sys_sync();
 	return 0;
 }
 
--- clean/mm/pdflush.c	2003-02-15 18:51:31.000000000 +0100
+++ linux/mm/pdflush.c	2003-02-21 10:41:33.000000000 +0100
@@ -103,9 +103,11 @@
 		my_work->when_i_went_to_sleep = jiffies;
 		spin_unlock_irq(&pdflush_lock);
 
-		if (current->flags & PF_FREEZE)
-			refrigerator(PF_IOTHREAD);
 		schedule();
+		if (current->flags & PF_FREEZE) {
+			refrigerator(PF_IOTHREAD);
+			continue;
+		}
 
 		spin_lock_irq(&pdflush_lock);
 		if (!list_empty(&my_work->list)) {
 
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
