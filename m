Return-Path: <linux-kernel-owner+w=401wt.eu-S965295AbXAHJV3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbXAHJV3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbXAHJV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:21:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:45466 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965295AbXAHJV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:21:28 -0500
Date: Mon, 8 Jan 2007 10:18:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070108091819.GB26587@elte.hu>
References: <20070105215223.GA5361@elte.hu> <45A0E586.50806@qumranet.com> <20070107174416.GA14607@elte.hu> <45A1FF4E.1020106@qumranet.com> <20070108083935.GB18259@elte.hu> <45A20A0A.70403@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A20A0A.70403@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> >but AFAICS rmap_write_protect() is only ever called if we write a new 
> >cr3 - hence a TLB flush will happen anyway, because we do a 
> >vmcs_writel(GUEST_CR3, new_cr3). Am i missing something?
> 
> No, rmap_write_protect() is called whenever we shadow a new guest page 
> table (the mechanism used to maintain coherency is write faults on 
> page tables).

hm. Where? I only see rmap_write_protect() called from 
kvm_mmu_get_page(), which is only called from nonpaging_map() [but it 
doesnt call the rmap function in that case, due to metaphysical], and 
mmu_alloc_roots(). mmu_alloc_roots() is only called from context init 
(init-only thing) or from paging_new_cr3().

ahh ... i missed paging_tmpl.h.

how about the patch below then?

furthermore, shouldnt we pass in the flush area size from the pagefault 
handler? In most cases it would be 4096 bytes, that would mean an invlpg 
is enough, not a full cr3 flush. Although ... i dont know how to invlpg 
a guest-side TLB. On VMX it probably doesnt matter at all. On SVM, is 
there a way (or a need) to flush a single TLB of another context ID?

	Ingo

Index: linux/drivers/kvm/mmu.c
===================================================================
--- linux.orig/drivers/kvm/mmu.c
+++ linux/drivers/kvm/mmu.c
@@ -378,7 +378,7 @@ static void rmap_remove(struct kvm_vcpu 
 	}
 }
 
-static void rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
+static void rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn, int flush_tlb)
 {
 	struct kvm *kvm = vcpu->kvm;
 	struct page *page;
@@ -404,7 +404,13 @@ static void rmap_write_protect(struct kv
 		BUG_ON(!(*spte & PT_WRITABLE_MASK));
 		rmap_printk("rmap_write_protect: spte %p %llx\n", spte, *spte);
 		rmap_remove(vcpu, spte);
-		kvm_arch_ops->tlb_flush(vcpu);
+		/*
+		 * While we removed a mapping there's no need to explicitly
+		 * flush the TLB here if we write a new cr3. It is needed
+		 * from the pagefault path though.
+		 */
+		if (flush_tlb)
+			kvm_arch_ops->tlb_flush(vcpu);
 		*spte &= ~(u64)PT_WRITABLE_MASK;
 	}
 }
@@ -561,7 +567,8 @@ static struct kvm_mmu_page *kvm_mmu_get_
 					     gva_t gaddr,
 					     unsigned level,
 					     int metaphysical,
-					     u64 *parent_pte)
+					     u64 *parent_pte,
+					     int flush_tlb)
 {
 	union kvm_mmu_page_role role;
 	unsigned index;
@@ -597,7 +604,7 @@ static struct kvm_mmu_page *kvm_mmu_get_
 	page->role = role;
 	hlist_add_head(&page->hash_link, bucket);
 	if (!metaphysical)
-		rmap_write_protect(vcpu, gfn);
+		rmap_write_protect(vcpu, gfn, flush_tlb);
 	return page;
 }
 
@@ -764,7 +771,7 @@ static int nonpaging_map(struct kvm_vcpu
 				>> PAGE_SHIFT;
 			new_table = kvm_mmu_get_page(vcpu, pseudo_gfn,
 						     v, level - 1,
-						     1, &table[index]);
+						     1, &table[index], 0);
 			if (!new_table) {
 				pgprintk("nonpaging_map: ENOMEM\n");
 				return -ENOMEM;
@@ -838,7 +845,7 @@ static void mmu_alloc_roots(struct kvm_v
 
 		ASSERT(!VALID_PAGE(root));
 		page = kvm_mmu_get_page(vcpu, root_gfn, 0,
-					PT64_ROOT_LEVEL, 0, NULL);
+					PT64_ROOT_LEVEL, 0, NULL, 0);
 		root = page->page_hpa;
 		++page->root_count;
 		vcpu->mmu.root_hpa = root;
@@ -857,7 +864,7 @@ static void mmu_alloc_roots(struct kvm_v
 			root_gfn = 0;
 		page = kvm_mmu_get_page(vcpu, root_gfn, i << 30,
 					PT32_ROOT_LEVEL, !is_paging(vcpu),
-					NULL);
+					NULL, 0);
 		root = page->page_hpa;
 		++page->root_count;
 		vcpu->mmu.pae_root[j][i] = root | PT_PRESENT_MASK;
Index: linux/drivers/kvm/paging_tmpl.h
===================================================================
--- linux.orig/drivers/kvm/paging_tmpl.h
+++ linux/drivers/kvm/paging_tmpl.h
@@ -245,7 +245,7 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 			table_gfn = walker->table_gfn[level - 2];
 		}
 		shadow_page = kvm_mmu_get_page(vcpu, table_gfn, addr, level-1,
-					       metaphysical, shadow_ent);
+					       metaphysical, shadow_ent, 1);
 		shadow_addr = shadow_page->page_hpa;
 		shadow_pte = shadow_addr | PT_PRESENT_MASK | PT_ACCESSED_MASK
 			| PT_WRITABLE_MASK | PT_USER_MASK;

