Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268010AbTBRVII>; Tue, 18 Feb 2003 16:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268013AbTBRVIH>; Tue, 18 Feb 2003 16:08:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52228 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268010AbTBRVIG>; Tue, 18 Feb 2003 16:08:06 -0500
Date: Tue, 18 Feb 2003 22:17:41 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Patrick Mochel <mochel@osdl.org>, torvalds@transmeta.com,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Fixes to suspend-to-RAM
Message-ID: <20030218211741.GA1039@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Clean up comments in sleep.c and make code robust against
out-of-memory. In wakeup.S, reload segment registers: bios might have
changed them. In main.c -- we really need to disable devices before
going to sleep -- its critical for APIC (driver model for that will be
supplied later). Please apply,
								Pavel

--- clean/arch/i386/kernel/acpi/sleep.c	2003-02-15 18:51:10.000000000 +0100
+++ linux/arch/i386/kernel/acpi/sleep.c	2003-02-15 19:00:15.000000000 +0100
@@ -2,6 +2,7 @@
  * sleep.c - x86-specific ACPI sleep support.
  *
  *  Copyright (C) 2001-2003 Patrick Mochel
+ *  Copyright (C) 2001-2003 Pavel Machek <pavel@suse.cz>
  */
 
 #include <linux/acpi.h>
@@ -38,6 +39,8 @@
 	panic("S3 and PAE do not like each other for now.");
 	return 1;
 #endif
+	if (!acpi_wakeup_address)
+		return 1;
 	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
 	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
@@ -65,17 +68,18 @@
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
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
+	if (!acpi_wakeup_address)
+		printk(KERN_ERR "ACPI: Cannot allocate lowmem. S3 disabled.\n");
 	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
 		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
-	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
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
--- clean/drivers/acpi/sleep/main.c	2003-02-15 18:51:17.000000000 +0100
+++ linux/drivers/acpi/sleep/main.c	2003-02-15 18:57:27.000000000 +0100
@@ -103,6 +103,10 @@
 			return error;
 		}
 
+		error = device_suspend(state, SUSPEND_DISABLE);
+		if (error)
+			panic("Sorry, devices really should know how to disable\n");
+
 		/* flush caches */
 		ACPI_FLUSH_CPU_CACHE();
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
