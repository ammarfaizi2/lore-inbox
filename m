Return-Path: <linux-kernel-owner+w=401wt.eu-S965028AbXADQUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbXADQUL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965015AbXADQUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:20:11 -0500
Received: from il.qumranet.com ([62.219.232.206]:51755 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965033AbXADQUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:20:09 -0500
Subject: [PATCH 31/33] KVM: MMU: Flush guest tlb when reducing permissions on
	a pte
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:20:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104162007.AF4E9250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we reduce permissions on a pte, we must flush the cached copy of the pte
from the guest's tlb.

This is implemented at the moment by flushing the entire guest tlb, and can
be improved by flushing just the relevant virtual address, if it is known.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -383,6 +383,7 @@ static void rmap_write_protect(struct kv
 		BUG_ON(!(*spte & PT_WRITABLE_MASK));
 		rmap_printk("rmap_write_protect: spte %p %llx\n", spte, *spte);
 		rmap_remove(vcpu, spte);
+		kvm_arch_ops->tlb_flush(vcpu);
 		*spte &= ~(u64)PT_WRITABLE_MASK;
 	}
 }
@@ -594,6 +595,7 @@ static void kvm_mmu_page_unlink_children
 				rmap_remove(vcpu, &pt[i]);
 			pt[i] = 0;
 		}
+		kvm_arch_ops->tlb_flush(vcpu);
 		return;
 	}
 
@@ -927,7 +929,10 @@ static inline void set_pte_common(struct
 			pgprintk("%s: found shadow page for %lx, marking ro\n",
 				 __FUNCTION__, gfn);
 			access_bits &= ~PT_WRITABLE_MASK;
-			*shadow_pte &= ~PT_WRITABLE_MASK;
+			if (is_writeble_pte(*shadow_pte)) {
+				    *shadow_pte &= ~PT_WRITABLE_MASK;
+				    kvm_arch_ops->tlb_flush(vcpu);
+			}
 		}
 	}
 
