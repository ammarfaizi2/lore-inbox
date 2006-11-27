Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758151AbWK0Mok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758151AbWK0Mok (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 07:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758152AbWK0Mok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 07:44:40 -0500
Received: from il.qumranet.com ([62.219.232.206]:44512 "EHLO cleopatra.q")
	by vger.kernel.org with ESMTP id S1758151AbWK0Mok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 07:44:40 -0500
Subject: [PATCH 34/38] KVM: Use the tlb flush arch operation instead of an
	inline
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 27 Nov 2006 12:44:38 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <456AD5C6.1090406@qumranet.com>
In-Reply-To: <456AD5C6.1090406@qumranet.com>
Message-Id: <20061127124438.DD01E25015E@cleopatra.q>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -445,11 +445,6 @@ static inline int is_external_interrupt(
 		== (INTR_TYPE_EXT_INTR | INTR_INFO_VALID_MASK);
 }
 
-static inline void flush_guest_tlb(struct kvm_vcpu *vcpu)
-{
-	vmcs_writel(GUEST_CR3, vmcs_readl(GUEST_CR3));
-}
-
 static inline int memslot_id(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
 	return slot - kvm->memslots;
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -775,7 +775,7 @@ static int kvm_dev_ioctl_get_dirty_log(s
 
 			if (!vcpu)
 				continue;
-			flush_guest_tlb(vcpu);
+			kvm_arch_ops->flush_tlb(vcpu);
 			vcpu_put(vcpu);
 		}
 	}
