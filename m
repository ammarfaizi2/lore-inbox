Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968186AbWLENiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968186AbWLENiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968190AbWLENiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:38:46 -0500
Received: from fms-01.valinux.co.jp ([210.128.90.1]:60342 "EHLO
	mail.valinux.co.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968186AbWLENie (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:38:34 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, magnus.damm@gmail.com,
       fastboot@lists.osdl.org, Magnus Damm <magnus@valinux.co.jp>,
       ebiederm@xmission.com, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>
Date: Tue, 05 Dec 2006 22:38:07 +0900
Message-Id: <20061205133807.25725.27903.sendpatchset@localhost>
In-Reply-To: <20061205133757.25725.96929.sendpatchset@localhost>
References: <20061205133757.25725.96929.sendpatchset@localhost>
Subject: [PATCH 02/02] kexec: Move segment code to assembly file (x86_64)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Move segment code to assembly file (x86_64)

This patch moves the idt, gdt, and segment handling code from machine_kexec.c
to relocate_kernel.S. The main reason behind this move is to avoid code 
duplication in the Xen hypervisor. With this patch all code required to kexec
is put on the control page.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies to 2.6.19.

 arch/x86_64/kernel/machine_kexec.c   |   58 ----------------------------------
 arch/x86_64/kernel/relocate_kernel.S |   50 ++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 63 deletions(-)

--- 0001/arch/x86_64/kernel/machine_kexec.c
+++ work/arch/x86_64/kernel/machine_kexec.c	2006-12-05 17:24:14.000000000 +0900
@@ -112,47 +112,6 @@ static int init_pgtable(struct kimage *i
  	return init_level4_page(image, level4p, 0, end_pfn << PAGE_SHIFT);
 }
 
-static void set_idt(void *newidt, u16 limit)
-{
-	struct desc_ptr curidt;
-
-	/* x86-64 supports unaliged loads & stores */
-	curidt.size    = limit;
-	curidt.address = (unsigned long)newidt;
-
-	__asm__ __volatile__ (
-		"lidtq %0\n"
-		: : "m" (curidt)
-		);
-};
-
-
-static void set_gdt(void *newgdt, u16 limit)
-{
-	struct desc_ptr curgdt;
-
-	/* x86-64 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	__asm__ __volatile__ (
-		"lgdtq %0\n"
-		: : "m" (curgdt)
-		);
-};
-
-static void load_segments(void)
-{
-	__asm__ __volatile__ (
-		"\tmovl %0,%%ds\n"
-		"\tmovl %0,%%es\n"
-		"\tmovl %0,%%ss\n"
-		"\tmovl %0,%%fs\n"
-		"\tmovl %0,%%gs\n"
-		: : "a" (__KERNEL_DS) : "memory"
-		);
-}
-
 int machine_kexec_prepare(struct kimage *image)
 {
 	unsigned long start_pgtable;
@@ -209,23 +168,6 @@ NORET_TYPE void machine_kexec(struct kim
 	page_list[PA_TABLE_PAGE] =
 	  (unsigned long)__pa(page_address(image->control_code_page));
 
-	/* The segment registers are funny things, they have both a
-	 * visible and an invisible part.  Whenever the visible part is
-	 * set to a specific selector, the invisible part is loaded
-	 * with from a table in memory.  At no other time is the
-	 * descriptor table in memory accessed.
-	 *
-	 * I take advantage of this here by force loading the
-	 * segments, before I zap the gdt with an invalid value.
-	 */
-	load_segments();
-	/* The gdt & idt are now invalid.
-	 * If you want to load them you must set up your own idt & gdt.
-	 */
-	set_gdt(phys_to_virt(0),0);
-	set_idt(phys_to_virt(0),0);
-
-	/* now call it */
 	relocate_kernel((unsigned long)image->head, (unsigned long)page_list,
 			image->start);
 }
--- 0001/arch/x86_64/kernel/relocate_kernel.S
+++ work/arch/x86_64/kernel/relocate_kernel.S	2006-12-05 17:24:14.000000000 +0900
@@ -159,13 +159,39 @@ relocate_new_kernel:
 	movq	PTR(PA_PGD)(%rsi), %r9
 	movq	%r9, %cr3
 
+	/* setup idt */
+	movq    %r8, %rax
+	addq    $(idt_80 - relocate_kernel), %rax
+	lidtq   (%rax)
+
+	/* setup gdt */
+	movq    %r8, %rax
+	addq    $(gdt - relocate_kernel), %rax
+	movq    %r8, %r9
+	addq    $((gdt_80 - relocate_kernel) + 2), %r9
+	movq    %rax, (%r9)
+
+	movq    %r8, %rax
+	addq    $(gdt_80 - relocate_kernel), %rax
+	lgdtq   (%rax)
+
+	/* setup data segment registers */
+	xorl	%eax, %eax
+	movl    %eax, %ds
+	movl    %eax, %es
+	movl    %eax, %fs
+	movl    %eax, %gs
+	movl    %eax, %ss
+	
 	/* setup a new stack at the end of the physical control page */
 	lea	4096(%r8), %rsp
 
-	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %r8
-	pushq	%r8
-	ret
+	/* load new code segment and jump to identity mapped page */
+	movq	%r8, %rax
+	addq    $(identity_mapped - relocate_kernel), %rax
+	pushq	$(gdt_cs - gdt)
+	pushq	%rax
+	lretq
 
 identity_mapped:
 	/* store the start address on the stack */
@@ -272,5 +298,19 @@ identity_mapped:
 	xorq	%r13, %r13
 	xorq	%r14, %r14
 	xorq	%r15, %r15
-
 	ret
+
+	.align  16
+gdt:
+	.quad	0x0000000000000000	/* NULL descriptor */
+gdt_cs:
+	.quad   0x00af9a000000ffff
+gdt_end:
+
+gdt_80:
+	.word	gdt_end - gdt - 1	/* limit */
+	.quad	0			/* base - filled in by code above */
+
+idt_80:
+	.word	0			/* limit */
+	.quad	0			/* base */
