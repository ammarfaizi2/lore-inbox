Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318469AbSGZTuI>; Fri, 26 Jul 2002 15:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318472AbSGZTuI>; Fri, 26 Jul 2002 15:50:08 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35745 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318469AbSGZTuG>;
	Fri, 26 Jul 2002 15:50:06 -0400
Date: Fri, 26 Jul 2002 21:52:11 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] f00f workaround update, TLS, 2.5.28
Message-ID: <Pine.LNX.4.44.0207262147150.21525-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch is ontop of the 2.5.28 TLS patch (which is in
BK-current) updates the F00F bug workaround code to the IDT changes in the
TLS patch. It compiles & works just fine - i've tested it on a non-Pentium
box on which i triggered the workaround artificially.

Please apply,

	Ingo

--- linux/arch/i386/kernel/head.S.orig	Fri Jul 26 09:09:57 2002
+++ linux/arch/i386/kernel/head.S	Fri Jul 26 21:45:55 2002
@@ -348,6 +348,7 @@
 .globl cpu_gdt_descr
 
 	ALIGN
+	.word 0				# 32-bit align idt_desc.address
 idt_descr:
 	.word IDT_ENTRIES*8-1		# idt contains 256 entries
 	.long idt_table
--- linux/arch/i386/kernel/traps.c.orig	Fri Jul 26 21:19:41 2002
+++ linux/arch/i386/kernel/traps.c	Fri Jul 26 21:44:31 2002
@@ -784,11 +784,10 @@
 	__set_fixmap(FIX_F00F_IDT, __pa(&idt_table), PAGE_KERNEL_RO);
 
 	/*
-	 * "idt" is magic - it overlaps the idt_descr
-	 * variable so that updating idt will automatically
-	 * update the idt descriptor..
+	 * Update the IDT descriptor and reload the IDT so that
+	 * it uses the read-only mapped virtual address.
 	 */
-	idt = (struct desc_struct *) fix_to_virt(FIX_F00F_IDT);
+	idt_descr.address = fix_to_virt(FIX_F00F_IDT);
 	__asm__ __volatile__("lidt %0": "=m" (idt_descr));
 }
 #endif
--- linux/arch/i386/mm/fault.c.orig	Fri Jul 26 21:46:21 2002
+++ linux/arch/i386/mm/fault.c	Fri Jul 26 21:46:34 2002
@@ -24,6 +24,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
 #include <asm/hardirq.h>
+#include <asm/desc.h>
 
 extern void die(const char *,struct pt_regs *,long);
 
@@ -129,7 +130,6 @@
 }
 
 asmlinkage void do_invalid_op(struct pt_regs *, unsigned long);
-extern unsigned long idt;
 
 /*
  * This routine handles page faults.  It determines the address,
@@ -293,7 +293,7 @@
 	if (boot_cpu_data.f00f_bug) {
 		unsigned long nr;
 		
-		nr = (address - idt) >> 3;
+		nr = (address - idt_descr.address) >> 3;
 
 		if (nr == 6) {
 			do_invalid_op(regs, 0);

