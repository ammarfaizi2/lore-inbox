Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932903AbWKLNxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932903AbWKLNxF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 08:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932889AbWKLNxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 08:53:05 -0500
Received: from il.qumranet.com ([62.219.232.206]:49326 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S932903AbWKLNxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 08:53:02 -0500
Subject: [PATCH] KVM: Fix segment state changes across processor mode switches
From: Avi Kivity <avi@qumranet.com>
Date: Sun, 12 Nov 2006 13:53:00 -0000
To: kvm-devel@lists.sourceforge.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, simon.kagstrom@bth.se
Message-Id: <20061112135300.CAE51A0001@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaniv Kamay <yaniv@qumranet.com>

A problem with Intel VT is that it performs very strict segment checks on
entry to vm86 mode.  These checks are much stricter than what the cpu
actually allows for real mode, which is a problem since we use vm86 mode to
virtualize real mode.

The problem scenario is something like:

- switch to real mode
  - here kvm mangles the segments to something that VT will like
- do something uninteresting
- switch to protected mode
- touch mangled segments
- blow up at unexpected values

Fix is as follows:

- switch to real mode
  - mangle segments, but save original values somethere
- do something uninteresting
- switch to protected mode
  - if segment selectors have not been changed, restore from saved values
- touch restored segments
- live happily ever after

Reported by: Simon Kagstrom <simon.kagstrom@bth.se>

Signed-off-by: Yaniv Kamay <yaniv@qumranet.com>
Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -199,10 +199,11 @@ struct kvm_vcpu {
 		int active;
 		u8 save_iopl;
 		struct {
+			u16 selector;
 			unsigned long base;
 			u32 limit;
 			u32 ar;
-		} tr;
+		} tr, es, ds, fs, gs;
 	} rmode;
 };
 
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -710,18 +710,27 @@ static void enter_pmode(struct kvm_vcpu 
 	update_exception_bitmap(vcpu);
 
 	#define FIX_PMODE_DATASEG(seg, save) {				\
-			vmcs_write16(GUEST_##seg##_SELECTOR, 0); 	\
-			vmcs_writel(GUEST_##seg##_BASE, 0); 		\
-			vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);	\
-			vmcs_write32(GUEST_##seg##_AR_BYTES, 0x93);	\
+		if (vmcs_readl(GUEST_##seg##_BASE) == save.base) { \
+			vmcs_write16(GUEST_##seg##_SELECTOR, save.selector); \
+			vmcs_writel(GUEST_##seg##_BASE, save.base); \
+			vmcs_write32(GUEST_##seg##_LIMIT, save.limit); \
+			vmcs_write32(GUEST_##seg##_AR_BYTES, save.ar); \
+		} else { \
+			u32 dpl = (vmcs_read16(GUEST_##seg##_SELECTOR) & \
+				   SELECTOR_RPL_MASK) << AR_DPL_SHIFT; \
+			vmcs_write32(GUEST_##seg##_AR_BYTES, 0x93 | dpl); \
+		} \
 	}
 
-	FIX_PMODE_DATASEG(SS, vcpu->rmode.ss);
 	FIX_PMODE_DATASEG(ES, vcpu->rmode.es);
 	FIX_PMODE_DATASEG(DS, vcpu->rmode.ds);
 	FIX_PMODE_DATASEG(GS, vcpu->rmode.gs);
 	FIX_PMODE_DATASEG(FS, vcpu->rmode.fs);
 
+
+	vmcs_write16(GUEST_SS_SELECTOR, 0);
+	vmcs_write32(GUEST_SS_AR_BYTES, 0x93);
+
 	vmcs_write16(GUEST_CS_SELECTOR,
 		     vmcs_read16(GUEST_CS_SELECTOR) & ~SELECTOR_RPL_MASK);
 	vmcs_write32(GUEST_CS_AR_BYTES, 0x9b);
@@ -757,19 +766,26 @@ static void enter_rmode(struct kvm_vcpu 
 	vmcs_writel(GUEST_CR4, vmcs_readl(GUEST_CR4) | CR4_VME_MASK);
 	update_exception_bitmap(vcpu);
 
-	#define FIX_RMODE_SEG(seg, save) {				   \
+	#define FIX_RMODE_SEG(seg, save) { \
+		save.selector = vmcs_read16(GUEST_##seg##_SELECTOR); \
+		save.base = vmcs_readl(GUEST_##seg##_BASE); \
+		save.limit = vmcs_read32(GUEST_##seg##_LIMIT); \
+		save.ar = vmcs_read32(GUEST_##seg##_AR_BYTES); \
 		vmcs_write16(GUEST_##seg##_SELECTOR, 			   \
 					vmcs_readl(GUEST_##seg##_BASE) >> 4); \
 		vmcs_write32(GUEST_##seg##_LIMIT, 0xffff);		   \
 		vmcs_write32(GUEST_##seg##_AR_BYTES, 0xf3);		   \
 	}
 
+	vmcs_write16(GUEST_SS_SELECTOR, vmcs_readl(GUEST_SS_BASE) >> 4);
+	vmcs_write32(GUEST_SS_LIMIT, 0xffff);
+	vmcs_write32(GUEST_SS_AR_BYTES, 0xf3);
+
 	vmcs_write32(GUEST_CS_AR_BYTES, 0xf3);
 	vmcs_write16(GUEST_CS_SELECTOR, vmcs_readl(GUEST_CS_BASE) >> 4);
 
 	FIX_RMODE_SEG(ES, vcpu->rmode.es);
 	FIX_RMODE_SEG(DS, vcpu->rmode.ds);
-	FIX_RMODE_SEG(SS, vcpu->rmode.ss);
 	FIX_RMODE_SEG(GS, vcpu->rmode.gs);
 	FIX_RMODE_SEG(FS, vcpu->rmode.fs);
 }
