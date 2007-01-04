Return-Path: <linux-kernel-owner+w=401wt.eu-S964890AbXADPwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbXADPwK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbXADPwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:52:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:39057 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932372AbXADPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:52:08 -0500
Subject: [PATCH 3/33] KVM: MMU: Load the pae pdptrs on cr3 change like the
	processor does
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:52:05 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155205.CF83C250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In pae mode, a load of cr3 loads the four third-level page table entries
in addition to cr3 itself.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -298,14 +298,17 @@ static void inject_gp(struct kvm_vcpu *v
 	kvm_arch_ops->inject_gp(vcpu, 0);
 }
 
-static int pdptrs_have_reserved_bits_set(struct kvm_vcpu *vcpu,
-					 unsigned long cr3)
+/*
+ * Load the pae pdptrs.  Return true is they are all valid.
+ */
+static int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3)
 {
 	gfn_t pdpt_gfn = cr3 >> PAGE_SHIFT;
-	unsigned offset = (cr3 & (PAGE_SIZE-1)) >> 5;
+	unsigned offset = ((cr3 & (PAGE_SIZE-1)) >> 5) << 2;
 	int i;
 	u64 pdpte;
 	u64 *pdpt;
+	int ret;
 	struct kvm_memory_slot *memslot;
 
 	spin_lock(&vcpu->kvm->lock);
@@ -313,16 +316,23 @@ static int pdptrs_have_reserved_bits_set
 	/* FIXME: !memslot - emulate? 0xff? */
 	pdpt = kmap_atomic(gfn_to_page(memslot, pdpt_gfn), KM_USER0);
 
+	ret = 1;
 	for (i = 0; i < 4; ++i) {
 		pdpte = pdpt[offset + i];
-		if ((pdpte & 1) && (pdpte & 0xfffffff0000001e6ull))
-			break;
+		if ((pdpte & 1) && (pdpte & 0xfffffff0000001e6ull)) {
+			ret = 0;
+			goto out;
+		}
 	}
 
+	for (i = 0; i < 4; ++i)
+		vcpu->pdptrs[i] = pdpt[offset + i];
+
+out:
 	kunmap_atomic(pdpt, KM_USER0);
 	spin_unlock(&vcpu->kvm->lock);
 
-	return i != 4;
+	return ret;
 }
 
 void set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0)
@@ -368,8 +378,7 @@ void set_cr0(struct kvm_vcpu *vcpu, unsi
 			}
 		} else
 #endif
-		if (is_pae(vcpu) &&
-			    pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
+		if (is_pae(vcpu) && !load_pdptrs(vcpu, vcpu->cr3)) {
 			printk(KERN_DEBUG "set_cr0: #GP, pdptrs "
 			       "reserved bits\n");
 			inject_gp(vcpu);
@@ -411,7 +420,7 @@ void set_cr4(struct kvm_vcpu *vcpu, unsi
 			return;
 		}
 	} else if (is_paging(vcpu) && !is_pae(vcpu) && (cr4 & CR4_PAE_MASK)
-		   && pdptrs_have_reserved_bits_set(vcpu, vcpu->cr3)) {
+		   && !load_pdptrs(vcpu, vcpu->cr3)) {
 		printk(KERN_DEBUG "set_cr4: #GP, pdptrs reserved bits\n");
 		inject_gp(vcpu);
 	}
@@ -443,7 +452,7 @@ void set_cr3(struct kvm_vcpu *vcpu, unsi
 			return;
 		}
 		if (is_paging(vcpu) && is_pae(vcpu) &&
-		    pdptrs_have_reserved_bits_set(vcpu, cr3)) {
+		    !load_pdptrs(vcpu, cr3)) {
 			printk(KERN_DEBUG "set_cr3: #GP, pdptrs "
 			       "reserved bits\n");
 			inject_gp(vcpu);
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -185,6 +185,7 @@ struct kvm_vcpu {
 	unsigned long cr3;
 	unsigned long cr4;
 	unsigned long cr8;
+	u64 pdptrs[4]; /* pae */
 	u64 shadow_efer;
 	u64 apic_base;
 	int nmsrs;
