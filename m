Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932639AbWHALQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbWHALQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 07:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbWHALFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 07:05:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:477 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932641AbWHALFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 07:05:40 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: <fastboot@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 24/33] x86_64: Add EFER to the set registers saved by save_processor_state
Date: Tue,  1 Aug 2006 05:03:39 -0600
Message-Id: <11544302442997-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.rc2.g5209e
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

EFER varies like %cr4 depending on the cpu capabilities, and which cpu
capabilities we want to make use of.  So save/restore it make certain
we have the same EFER value when we are done.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/suspend.c |    3 ++-
 include/asm-x86_64/suspend.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/kernel/suspend.c b/arch/x86_64/kernel/suspend.c
index 91f7e67..fe865ea 100644
--- a/arch/x86_64/kernel/suspend.c
+++ b/arch/x86_64/kernel/suspend.c
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
diff --git a/include/asm-x86_64/suspend.h b/include/asm-x86_64/suspend.h
index bc7f817..a42306c 100644
--- a/include/asm-x86_64/suspend.h
+++ b/include/asm-x86_64/suspend.h
@@ -17,6 +17,7 @@ struct saved_context {
   	u16 ds, es, fs, gs, ss;
 	unsigned long gs_base, gs_kernel_base, fs_base;
 	unsigned long cr0, cr2, cr3, cr4, cr8;
+	unsigned long efer;
 	u16 gdt_pad;
 	u16 gdt_limit;
 	unsigned long gdt_base;
-- 
1.4.2.rc2.g5209e

