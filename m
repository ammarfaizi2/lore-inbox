Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267424AbSLEU65>; Thu, 5 Dec 2002 15:58:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267437AbSLEU5g>; Thu, 5 Dec 2002 15:57:36 -0500
Received: from [195.39.17.254] ([195.39.17.254]:16644 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267424AbSLEU5H>;
	Thu, 5 Dec 2002 15:57:07 -0500
Date: Wed, 4 Dec 2002 14:08:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: s3 sleep: make it work when kernel is big
Message-ID: <20021204130807.GA8245@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When kernel becomes too big, table allocated in acpi.c is no longer
big enough and machine crashes during acpi_wakeup.S... This fixes
it and adds safety check for acpi_wakeup's code size. Please apply,

								Pavel


--- clean/arch/i386/kernel/acpi.c	2002-09-22 23:46:52.000000000 +0200
+++ linux-swsusp/arch/i386/kernel/acpi.c	2002-11-24 20:29:33.000000000 +0100
@@ -446,72 +446,19 @@
 
 #ifdef CONFIG_ACPI_SLEEP
 
-#define DEBUG
-
-#ifdef DEBUG
-#include <linux/serial.h>
-#endif
-
 /* address in low memory of the wakeup routine. */
 unsigned long acpi_wakeup_address = 0;
 
-/* new page directory that we will be using */
-static pmd_t *pmd;
-
-/* saved page directory */
-static pmd_t saved_pmd;
-
-/* page which we'll use for the new page directory */
-static pte_t *ptep;
-
 extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
 
-/*
- * acpi_create_identity_pmd
- *
- * Create a new, identity mapped pmd.
- *
- * Do this by creating new page directory, and marking all the pages as R/W
- * Then set it as the new Page Middle Directory.
- * And, of course, flush the TLB so it takes effect.
- *
- * We save the address of the old one, for later restoration.
- */
-static void acpi_create_identity_pmd (void)
+static void init_low_mapping(pgd_t *pgd, int pgd_ofs, int pgd_limit)
 {
-	pgd_t *pgd;
-	int i;
-
-	ptep = (pte_t*)__get_free_page(GFP_KERNEL);
+	int pgd_ofs = 0;
 
-	/* fill page with low mapping */
-	for (i = 0; i < PTRS_PER_PTE; i++)
-		set_pte(ptep + i, pfn_pte(i, PAGE_SHARED));
-
-	pgd = pgd_offset(current->active_mm, 0);
-	pmd = pmd_alloc(current->mm,pgd, 0);
-
-	/* save the old pmd */
-	saved_pmd = *pmd;
-
-	/* set the new one */
-	set_pmd(pmd, __pmd(_PAGE_TABLE + __pa(ptep)));
-
-	/* flush the TLB */
-	local_flush_tlb();
-}
-
-/*
- * acpi_restore_pmd
- *
- * Restore the old pmd saved by acpi_create_identity_pmd and
- * free the page that said function alloc'd
- */
-static void acpi_restore_pmd (void)
-{
-	set_pmd(pmd, saved_pmd);
-	local_flush_tlb();
-	free_page((unsigned long)ptep);
+	while ((pgd_ofs < pgd_limit) && (pgd_ofs + USER_PTRS_PER_PGD < PTRS_PER_PGD)) {
+		set_pgd(pgd, *(pgd+USER_PTRS_PER_PGD));
+		pgd_ofs++, pgd++;
+	}
 }
 
 /**
@@ -522,7 +469,11 @@
  */
 int acpi_save_state_mem (void)
 {
-	acpi_create_identity_pmd();
+#if CONFIG_X86_PAE
+	panic("S3 and PAE do not like each other for now.");
+	return 1;
+#endif
+	init_low_mapping(swapper_pg_dir, 0, USER_PTRS_PER_PGD);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
 
 	return 0;
@@ -542,7 +493,7 @@
  */
 void acpi_restore_state_mem (void)
 {
-	acpi_restore_pmd();
+	zap_low_mappings();
 }
 
 /**
@@ -555,7 +506,10 @@
  */
 void __init acpi_reserve_bootmem(void)
 {
+	extern char wakeup_start, wakeup_end;
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
+	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
+		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
 	printk(KERN_DEBUG "ACPI: have wakeup address 0x%8.8lx\n", acpi_wakeup_address);
 }
 
--- clean/arch/i386/mm/init.c	2002-11-19 16:45:26.000000000 +0100
+++ linux-swsusp/arch/i386/mm/init.c	2002-11-24 20:18:22.000000000 +0100
@@ -299,7 +299,7 @@
 #endif
 }
 
-void __init zap_low_mappings (void)
+void zap_low_mappings (void)
 {
 	int i;
 	/*

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
