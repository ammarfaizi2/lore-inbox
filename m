Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262442AbSLMMAP>; Fri, 13 Dec 2002 07:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262901AbSLML74>; Fri, 13 Dec 2002 06:59:56 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3844 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262442AbSLML6A>;
	Fri, 13 Dec 2002 06:58:00 -0500
Date: Thu, 12 Dec 2002 21:37:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: ACPI/S3: simplify assembly code a bit
Message-ID: <20021212203718.GA1498@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kill unused variable and simplify assembly portion a bit... Please
apply,

								Pavel

--- clean/arch/i386/kernel/acpi.c	2002-12-11 23:33:53.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi.c	2002-12-12 19:05:13.000000000 +0100
@@ -448,10 +448,11 @@
 
 /* address in low memory of the wakeup routine. */
 unsigned long acpi_wakeup_address = 0;
+extern char wakeup_start, wakeup_end;
 
 extern unsigned long FASTCALL(acpi_copy_wakeup_routine(unsigned long));
 
-static void init_low_mapping(pgd_t *pgd, int pgd_ofs, int pgd_limit)
+static void init_low_mapping(pgd_t *pgd, int pgd_limit)
 {
 	int pgd_ofs = 0;
 
@@ -473,7 +474,8 @@
 	panic("S3 and PAE do not like each other for now.");
 	return 1;
 #endif
-	init_low_mapping(swapper_pg_dir, 0, USER_PTRS_PER_PGD);
+	init_low_mapping(swapper_pg_dir, USER_PTRS_PER_PGD);
+	memcpy((void *) acpi_wakeup_address, &wakeup_start, &wakeup_end - &wakeup_start);
 	acpi_copy_wakeup_routine(acpi_wakeup_address);
 
 	return 0;
@@ -506,7 +508,6 @@
  */
 void __init acpi_reserve_bootmem(void)
 {
-	extern char wakeup_start, wakeup_end;
 	acpi_wakeup_address = (unsigned long)alloc_bootmem_low(PAGE_SIZE);
 	if ((&wakeup_end - &wakeup_start) > PAGE_SIZE)
 		printk(KERN_CRIT "ACPI: Wakeup code way too big, will crash on attempt to suspend\n");
--- clean/arch/i386/kernel/acpi_wakeup.S	2002-12-11 23:33:53.000000000 +0100
+++ linux-swsusp/arch/i386/kernel/acpi_wakeup.S	2002-12-05 18:02:30.000000000 +0100
@@ -239,20 +241,11 @@
 #
 ENTRY(acpi_copy_wakeup_routine)
 
-	pushl	%esi
-	pushl	%edi
-
 	sgdt	saved_gdt
 	sidt	saved_idt
 	sldt	saved_ldt
 	str	saved_tss
 
-	movl	%eax, %edi
-	leal	wakeup_start, %esi
-	movl	$(wakeup_end - wakeup_start + 3) >> 2, %ecx
-
-	rep ;  movsl
-
 	movl    %cr3, %edx
 	movl    %edx, real_save_cr3 - wakeup_start (%eax)
 	movl    %cr4, %edx
@@ -265,10 +258,6 @@
 	movl	%edx, video_mode - wakeup_start (%eax)
 	movl	$0x12345678, real_magic - wakeup_start (%eax)
 	movl	$0x12345678, saved_magic
-
-	# restore the regs we used
-	popl	%edi
-	popl	%esi
 	ret
 
 .data

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
