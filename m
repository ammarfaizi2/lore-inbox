Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968185AbWLENia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968185AbWLENia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968186AbWLENia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:38:30 -0500
Received: from fms-01.valinux.co.jp ([210.128.90.1]:60321 "EHLO
	mail.valinux.co.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968185AbWLENi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:38:29 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, fastboot@lists.osdl.org,
       magnus.damm@gmail.com, Magnus Damm <magnus@valinux.co.jp>,
       ebiederm@xmission.com, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>
Date: Tue, 05 Dec 2006 22:38:02 +0900
Message-Id: <20061205133802.25725.58802.sendpatchset@localhost>
In-Reply-To: <20061205133757.25725.96929.sendpatchset@localhost>
References: <20061205133757.25725.96929.sendpatchset@localhost>
Subject: [PATCH 01/02] kexec: Move segment code to assembly file (i386)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Move segment code to assembly file (i386)

This patch moves the idt, gdt, and segment handling code from machine_kexec.c
to relocate_kernel.S. The main reason behind this move is to avoid code 
duplication in the Xen hypervisor. With this patch all code required to kexec
is put on the control page.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies to 2.6.19.

 arch/i386/kernel/machine_kexec.c   |   59 ------------------------------------
 arch/i386/kernel/relocate_kernel.S |   58 ++++++++++++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 64 deletions(-)

--- 0001/arch/i386/kernel/machine_kexec.c
+++ work/arch/i386/kernel/machine_kexec.c	2006-12-05 17:24:10.000000000 +0900
@@ -29,48 +29,6 @@ static u32 kexec_pmd1[1024] PAGE_ALIGNED
 static u32 kexec_pte0[1024] PAGE_ALIGNED;
 static u32 kexec_pte1[1024] PAGE_ALIGNED;
 
-static void set_idt(void *newidt, __u16 limit)
-{
-	struct Xgt_desc_struct curidt;
-
-	/* ia32 supports unaliged loads & stores */
-	curidt.size    = limit;
-	curidt.address = (unsigned long)newidt;
-
-	load_idt(&curidt);
-};
-
-
-static void set_gdt(void *newgdt, __u16 limit)
-{
-	struct Xgt_desc_struct curgdt;
-
-	/* ia32 supports unaligned loads & stores */
-	curgdt.size    = limit;
-	curgdt.address = (unsigned long)newgdt;
-
-	load_gdt(&curgdt);
-};
-
-static void load_segments(void)
-{
-#define __STR(X) #X
-#define STR(X) __STR(X)
-
-	__asm__ __volatile__ (
-		"\tljmp $"STR(__KERNEL_CS)",$1f\n"
-		"\t1:\n"
-		"\tmovl $"STR(__KERNEL_DS)",%%eax\n"
-		"\tmovl %%eax,%%ds\n"
-		"\tmovl %%eax,%%es\n"
-		"\tmovl %%eax,%%fs\n"
-		"\tmovl %%eax,%%gs\n"
-		"\tmovl %%eax,%%ss\n"
-		::: "eax", "memory");
-#undef STR
-#undef __STR
-}
-
 /*
  * A architecture hook called to validate the
  * proposed image and prepare the control pages
@@ -127,23 +85,6 @@ NORET_TYPE void machine_kexec(struct kim
 	page_list[PA_PTE_1] = __pa(kexec_pte1);
 	page_list[VA_PTE_1] = (unsigned long)kexec_pte1;
 
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
 			image->start, cpu_has_pae);
 }
--- 0001/arch/i386/kernel/relocate_kernel.S
+++ work/arch/i386/kernel/relocate_kernel.S	2006-12-05 17:24:10.000000000 +0900
@@ -154,14 +154,45 @@ relocate_new_kernel:
 	movl	PTR(PA_PGD)(%ebp), %eax
 	movl	%eax, %cr3
 
+	/* setup idt */
+	movl	%edi, %eax
+	addl	$(idt_48 - relocate_kernel), %eax
+	lidtl	(%eax)
+
+	/* setup gdt */
+	movl	%edi, %eax
+	addl	$(gdt - relocate_kernel), %eax
+	movl	%edi, %esi
+	addl	$((gdt_48 - relocate_kernel) + 2), %esi
+	movl	%eax, (%esi)
+	
+	movl	%edi, %eax
+	addl	$(gdt_48 - relocate_kernel), %eax
+	lgdtl	(%eax)
+
+	/* setup data segment registers */
+	mov	$(gdt_ds - gdt), %eax
+	mov	%eax, %ds
+	mov	%eax, %es
+	mov	%eax, %fs
+	mov	%eax, %gs
+	mov	%eax, %ss
+	
 	/* setup a new stack at the end of the physical control page */
 	lea	4096(%edi), %esp
 
-	/* jump to identity mapped page */
-	movl    %edi, %eax
-	addl    $(identity_mapped - relocate_kernel), %eax
-	pushl   %eax
-	ret
+	/* load new code segment and jump to identity mapped page */
+	movl	%edi, %esi
+	xorl	%eax, %eax
+	pushl	%eax
+	pushl	%esi
+	pushl	%eax
+	movl	$(gdt_cs - gdt), %eax
+	pushl	%eax	
+	movl	%edi, %eax
+	addl	$(identity_mapped - relocate_kernel),%eax
+	pushl	%eax
+	iretl
 
 identity_mapped:
 	/* store the start address on the stack */
@@ -250,3 +281,20 @@ identity_mapped:
 	xorl    %edi, %edi
 	xorl    %ebp, %ebp
 	ret
+
+	.align	16
+gdt:
+	.quad	0x0000000000000000	/* NULL descriptor */
+gdt_cs:	
+	.quad	0x00cf9a000000ffff	/* kernel 4GB code at 0x00000000 */
+gdt_ds:
+	.quad	0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
+gdt_end:
+	
+gdt_48:
+	.word	gdt_end - gdt - 1	/* limit */
+	.long	0			/* base - filled in by code above */
+
+idt_48:
+	.word	0			/* limit */
+	.long	0			/* base */
