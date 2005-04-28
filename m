Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261868AbVD1Izc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbVD1Izc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVD1IwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:52:13 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40928 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261868AbVD1Iqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:46:31 -0400
Date: Thu, 28 Apr 2005 10:46:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: RFT: swsusp: more logical register saving order in swsusp
Message-ID: <20050428084605.GA27554@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like this to get some testing. It is "obviously correct",
but... :-).

								Pavel 

This patch fixes register saving so that each register is only
saved once, and adds missing saving of %cr8 on x86-64. Some reordering
so that save/restore is more logical (segment registers should be
restored after gdt).

Signed-off-by: Pavel Machek <pavel@suse.cz>

---
commit 1f9ca1262e6b27dde44d456a87c456d15f0a9b80
tree de65e7579ed050d324357e3040b37c561676ab7d
parent e8108c98dd6d65613fa0ec9d2300f89c48d554bf
author <pavel@amd.(none)> 1114677870 +0200
committer <pavel@amd.(none)> 1114677870 +0200

Index: arch/i386/power/cpu.c
===================================================================
--- 3608de2fc88b062070a9d197eda9cac1fb9635d3/arch/i386/power/cpu.c  (mode:100644 sha1:cf337c673d92a23d2d3ed339ec6e3065998a0a5e)
+++ de65e7579ed050d324357e3040b37c561676ab7d/arch/i386/power/cpu.c  (mode:100644 sha1:3e7e54b402a6ad11bbace158ab5d399a4efd149b)
@@ -44,7 +44,6 @@
 	 */
 	asm volatile ("sgdt %0" : "=m" (ctxt->gdt_limit));
 	asm volatile ("sidt %0" : "=m" (ctxt->idt_limit));
-	asm volatile ("sldt %0" : "=m" (ctxt->ldt));
 	asm volatile ("str %0"  : "=m" (ctxt->tr));
 
 	/*
@@ -107,7 +106,6 @@
 
 void __restore_processor_state(struct saved_context *ctxt)
 {
-
 	/*
 	 * control registers
 	 */
@@ -117,6 +115,13 @@
 	asm volatile ("movl %0, %%cr0" :: "r" (ctxt->cr0));
 
 	/*
+	 * now restore the descriptor tables to their proper values
+	 * ltr is done i fix_processor_context().
+	 */
+	asm volatile ("lgdt %0" :: "m" (ctxt->gdt_limit));
+	asm volatile ("lidt %0" :: "m" (ctxt->idt_limit));
+
+	/*
 	 * segment registers
 	 */
 	asm volatile ("movw %0, %%es" :: "r" (ctxt->es));
@@ -125,14 +130,6 @@
 	asm volatile ("movw %0, %%ss" :: "r" (ctxt->ss));
 
 	/*
-	 * now restore the descriptor tables to their proper values
-	 * ltr is done i fix_processor_context().
-	 */
-	asm volatile ("lgdt %0" :: "m" (ctxt->gdt_limit));
-	asm volatile ("lidt %0" :: "m" (ctxt->idt_limit));
-	asm volatile ("lldt %0" :: "m" (ctxt->ldt));
-
-	/*
 	 * sysenter MSRs
 	 */
 	if (boot_cpu_has(X86_FEATURE_SEP))
Index: arch/x86_64/kernel/suspend.c
===================================================================
--- 3608de2fc88b062070a9d197eda9cac1fb9635d3/arch/x86_64/kernel/suspend.c  (mode:100644 sha1:ebaa1e37d6579b7e0912e093fc1daa4fc186646d)
+++ de65e7579ed050d324357e3040b37c561676ab7d/arch/x86_64/kernel/suspend.c  (mode:100644 sha1:6c0f402e3a889c9b7234a6ed8de80b259bd12a38)
@@ -44,7 +44,6 @@
 	 */
 	asm volatile ("sgdt %0" : "=m" (ctxt->gdt_limit));
 	asm volatile ("sidt %0" : "=m" (ctxt->idt_limit));
-	asm volatile ("sldt %0" : "=m" (ctxt->ldt));
 	asm volatile ("str %0"  : "=m" (ctxt->tr));
 
 	/* XMM0..XMM15 should be handled by kernel_fpu_begin(). */
@@ -69,6 +68,7 @@
 	asm volatile ("movq %%cr2, %0" : "=r" (ctxt->cr2));
 	asm volatile ("movq %%cr3, %0" : "=r" (ctxt->cr3));
 	asm volatile ("movq %%cr4, %0" : "=r" (ctxt->cr4));
+	asm volatile ("movq %%cr8, %0" : "=r" (ctxt->cr8));
 }
 
 void save_processor_state(void)
@@ -90,12 +90,20 @@
 	/*
 	 * control registers
 	 */
+	asm volatile ("movq %0, %%cr8" :: "r" (ctxt->cr8));
 	asm volatile ("movq %0, %%cr4" :: "r" (ctxt->cr4));
 	asm volatile ("movq %0, %%cr3" :: "r" (ctxt->cr3));
 	asm volatile ("movq %0, %%cr2" :: "r" (ctxt->cr2));
 	asm volatile ("movq %0, %%cr0" :: "r" (ctxt->cr0));
 
 	/*
+	 * now restore the descriptor tables to their proper values
+	 * ltr is done i fix_processor_context().
+	 */
+	asm volatile ("lgdt %0" :: "m" (ctxt->gdt_limit));
+	asm volatile ("lidt %0" :: "m" (ctxt->idt_limit));
+
+	/*
 	 * segment registers
 	 */
 	asm volatile ("movw %0, %%ds" :: "r" (ctxt->ds));
@@ -108,14 +116,6 @@
 	wrmsrl(MSR_GS_BASE, ctxt->gs_base);
 	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->gs_kernel_base);
 
-	/*
-	 * now restore the descriptor tables to their proper values
-	 * ltr is done i fix_processor_context().
-	 */
-	asm volatile ("lgdt %0" :: "m" (ctxt->gdt_limit));
-	asm volatile ("lidt %0" :: "m" (ctxt->idt_limit));
-	asm volatile ("lldt %0" :: "m" (ctxt->ldt));
-
 	fix_processor_context();
 
 	do_fpu_end();
Index: include/asm-x86_64/suspend.h
===================================================================
--- 3608de2fc88b062070a9d197eda9cac1fb9635d3/include/asm-x86_64/suspend.h  (mode:100644 sha1:ec745807feae4892ec7d560e9fc930ca04591acb)
+++ de65e7579ed050d324357e3040b37c561676ab7d/include/asm-x86_64/suspend.h  (mode:100644 sha1:bb9f40597d097dacf7e08ae8de2cc23dfbb2adab)
@@ -16,7 +16,7 @@
 struct saved_context {
   	u16 ds, es, fs, gs, ss;
 	unsigned long gs_base, gs_kernel_base, fs_base;
-	unsigned long cr0, cr2, cr3, cr4;
+	unsigned long cr0, cr2, cr3, cr4, cr8;
 	u16 gdt_pad;
 	u16 gdt_limit;
 	unsigned long gdt_base;



!-------------------------------------------------------------flip-



-- 
Boycott Kodak -- for their patent abuse against Java.
