Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755138AbWKMQzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755138AbWKMQzc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbWKMQyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:54:53 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:38825 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755138AbWKMQyY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:54:24 -0500
Date: Mon, 13 Nov 2006 11:40:39 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com
Subject: [RFC] [PATCH 8/16] x86_64: Add EFER to the set registers saved by save_processor_state
Message-ID: <20061113164039.GI17429@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061113162135.GA17429@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061113162135.GA17429@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



EFER varies like %cr4 depending on the cpu capabilities, and which cpu
capabilities we want to make use of.  So save/restore it make certain
we have the same EFER value when we are done.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/kernel/suspend.c |    3 ++-
 include/asm-x86_64/suspend.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/suspend.c~x86_64-Add-EFER-to-the-set-registers-saved-by-save_processor_state arch/x86_64/kernel/suspend.c
--- linux-2.6.19-rc5-reloc/arch/x86_64/kernel/suspend.c~x86_64-Add-EFER-to-the-set-registers-saved-by-save_processor_state	2006-11-09 22:58:53.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/arch/x86_64/kernel/suspend.c	2006-11-09 22:58:53.000000000 -0500
@@ -33,7 +33,6 @@ void __save_processor_state(struct saved
 	asm volatile ("str %0"  : "=m" (ctxt->tr));
 
 	/* XMM0..XMM15 should be handled by kernel_fpu_begin(). */
-	/* EFER should be constant for kernel version, no need to handle it. */
 	/*
 	 * segment registers
 	 */
@@ -50,6 +49,7 @@ void __save_processor_state(struct saved
 	/*
 	 * control registers 
 	 */
+	rdmsrl(MSR_EFER, ctxt->efer);
 	asm volatile ("movq %%cr0, %0" : "=r" (ctxt->cr0));
 	asm volatile ("movq %%cr2, %0" : "=r" (ctxt->cr2));
 	asm volatile ("movq %%cr3, %0" : "=r" (ctxt->cr3));
@@ -75,6 +75,7 @@ void __restore_processor_state(struct sa
 	/*
 	 * control registers
 	 */
+	wrmsrl(MSR_EFER, ctxt->efer);
 	asm volatile ("movq %0, %%cr8" :: "r" (ctxt->cr8));
 	asm volatile ("movq %0, %%cr4" :: "r" (ctxt->cr4));
 	asm volatile ("movq %0, %%cr3" :: "r" (ctxt->cr3));
diff -puN include/asm-x86_64/suspend.h~x86_64-Add-EFER-to-the-set-registers-saved-by-save_processor_state include/asm-x86_64/suspend.h
--- linux-2.6.19-rc5-reloc/include/asm-x86_64/suspend.h~x86_64-Add-EFER-to-the-set-registers-saved-by-save_processor_state	2006-11-09 22:58:53.000000000 -0500
+++ linux-2.6.19-rc5-reloc-root/include/asm-x86_64/suspend.h	2006-11-09 22:58:53.000000000 -0500
@@ -17,6 +17,7 @@ struct saved_context {
   	u16 ds, es, fs, gs, ss;
 	unsigned long gs_base, gs_kernel_base, fs_base;
 	unsigned long cr0, cr2, cr3, cr4, cr8;
+	unsigned long efer;
 	u16 gdt_pad;
 	u16 gdt_limit;
 	unsigned long gdt_base;
_
