Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268025AbTBRWVd>; Tue, 18 Feb 2003 17:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268043AbTBRWVd>; Tue, 18 Feb 2003 17:21:33 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21267 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S268025AbTBRWVb>; Tue, 18 Feb 2003 17:21:31 -0500
Date: Tue, 18 Feb 2003 23:31:32 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@osdl.org>
Cc: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: Fixes to suspend-to-RAM
Message-ID: <20030218223132.GH21974@atrey.karlin.mff.cuni.cz>
References: <20030218220740.GD21974@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0302181556480.1035-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302181556480.1035-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Bootmem needs to be reserved pretty soon in the boot process, that
> > might be a problem.
> 
> That's not the issue. The call to the arch code would only check if the 
> bootmem had been reserved, and as far the arch code knew, it was OK to 
> enable S3.

Like this?

> > Based on recent talk... Will you act as S3 maintainer so that I can
> > submit patches to you and you'll take care of forwarding to Linus?
> 
> Yes, but please don't flood me with patches yet. I'm getting reacquainted 
> with some of the more esoteric details of suspend states, and verifying 
> that we have a working PM model for 2.6.

I have maybe two more patches around this size (i.e. small). Will you
take this?
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


-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
