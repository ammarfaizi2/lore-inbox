Return-Path: <linux-kernel-owner+w=401wt.eu-S964972AbXADQGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbXADQGK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbXADQGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:06:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:47301 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964972AbXADQGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:06:09 -0500
Subject: [PATCH 17/33] KVM: MMU: oom handling
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:06:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104160607.0A28A250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When beginning to process a page fault, make sure we have enough shadow pages
available to service the fault.  If not, free some pages.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -310,6 +310,7 @@ static void kvm_mmu_free_page(struct kvm
 	list_del(&page_head->link);
 	page_head->page_hpa = page_hpa;
 	list_add(&page_head->link, &vcpu->free_pages);
+	++vcpu->kvm->n_free_mmu_pages;
 }
 
 static int is_empty_shadow_page(hpa_t page_hpa)
@@ -344,6 +345,7 @@ static struct kvm_mmu_page *kvm_mmu_allo
 	page->global = 1;
 	page->multimapped = 0;
 	page->parent_pte = parent_pte;
+	--vcpu->kvm->n_free_mmu_pages;
 	return page;
 }
 
@@ -544,8 +546,7 @@ static void kvm_mmu_zap_page(struct kvm_
 	}
 	kvm_mmu_page_unlink_children(vcpu, page);
 	hlist_del(&page->hash_link);
-	list_del(&page->link);
-	list_add(&page->link, &vcpu->free_pages);
+	kvm_mmu_free_page(vcpu, page->page_hpa);
 }
 
 static int kvm_mmu_unprotect_page(struct kvm_vcpu *vcpu, gfn_t gfn)
@@ -743,18 +744,6 @@ static void mmu_alloc_roots(struct kvm_v
 	vcpu->mmu.root_hpa = __pa(vcpu->mmu.pae_root);
 }
 
-static void nonpaging_flush(struct kvm_vcpu *vcpu)
-{
-	hpa_t root = vcpu->mmu.root_hpa;
-
-	++kvm_stat.tlb_flush;
-	pgprintk("nonpaging_flush\n");
-	mmu_free_roots(vcpu);
-	mmu_alloc_roots(vcpu);
-	kvm_arch_ops->set_cr3(vcpu, root);
-	kvm_arch_ops->tlb_flush(vcpu);
-}
-
 static gpa_t nonpaging_gva_to_gpa(struct kvm_vcpu *vcpu, gva_t vaddr)
 {
 	return vaddr;
@@ -763,28 +752,19 @@ static gpa_t nonpaging_gva_to_gpa(struct
 static int nonpaging_page_fault(struct kvm_vcpu *vcpu, gva_t gva,
 			       u32 error_code)
 {
-	int ret;
 	gpa_t addr = gva;
+	hpa_t paddr;
 
 	ASSERT(vcpu);
 	ASSERT(VALID_PAGE(vcpu->mmu.root_hpa));
 
-	for (;;) {
-	     hpa_t paddr;
 
-	     paddr = gpa_to_hpa(vcpu , addr & PT64_BASE_ADDR_MASK);
+	paddr = gpa_to_hpa(vcpu , addr & PT64_BASE_ADDR_MASK);
 
-	     if (is_error_hpa(paddr))
-		     return 1;
+	if (is_error_hpa(paddr))
+		return 1;
 
-	     ret = nonpaging_map(vcpu, addr & PAGE_MASK, paddr);
-	     if (ret) {
-		     nonpaging_flush(vcpu);
-		     continue;
-	     }
-	     break;
-	}
-	return ret;
+	return nonpaging_map(vcpu, addr & PAGE_MASK, paddr);
 }
 
 static void nonpaging_inval_page(struct kvm_vcpu *vcpu, gva_t addr)
@@ -1093,6 +1073,18 @@ int kvm_mmu_unprotect_page_virt(struct k
 	return kvm_mmu_unprotect_page(vcpu, gpa >> PAGE_SHIFT);
 }
 
+void kvm_mmu_free_some_pages(struct kvm_vcpu *vcpu)
+{
+	while (vcpu->kvm->n_free_mmu_pages < KVM_REFILL_PAGES) {
+		struct kvm_mmu_page *page;
+
+		page = container_of(vcpu->kvm->active_mmu_pages.prev,
+				    struct kvm_mmu_page, link);
+		kvm_mmu_zap_page(vcpu, page);
+	}
+}
+EXPORT_SYMBOL_GPL(kvm_mmu_free_some_pages);
+
 static void free_mmu_pages(struct kvm_vcpu *vcpu)
 {
 	while (!list_empty(&vcpu->free_pages)) {
@@ -1124,6 +1116,7 @@ static int alloc_mmu_pages(struct kvm_vc
 		page_header->page_hpa = (hpa_t)page_to_pfn(page) << PAGE_SHIFT;
 		memset(__va(page_header->page_hpa), 0, PAGE_SIZE);
 		list_add(&page_header->link, &vcpu->free_pages);
+		++vcpu->kvm->n_free_mmu_pages;
 	}
 
 	/*
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -52,6 +52,8 @@
 #define KVM_MAX_VCPUS 1
 #define KVM_MEMORY_SLOTS 4
 #define KVM_NUM_MMU_PAGES 256
+#define KVM_MIN_FREE_MMU_PAGES 5
+#define KVM_REFILL_PAGES 25
 
 #define FX_IMAGE_SIZE 512
 #define FX_IMAGE_ALIGN 16
@@ -278,6 +280,7 @@ struct kvm {
 	 * Hash table of struct kvm_mmu_page.
 	 */
 	struct list_head active_mmu_pages;
+	int n_free_mmu_pages;
 	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
 	struct kvm_vcpu vcpus[KVM_MAX_VCPUS];
 	int memory_config_version;
@@ -451,6 +454,15 @@ unsigned long segment_base(u16 selector)
 void kvm_mmu_pre_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes);
 void kvm_mmu_post_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes);
 int kvm_mmu_unprotect_page_virt(struct kvm_vcpu *vcpu, gva_t gva);
+void kvm_mmu_free_some_pages(struct kvm_vcpu *vcpu);
+
+static inline int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_t gva,
+				     u32 error_code)
+{
+	if (unlikely(vcpu->kvm->n_free_mmu_pages < KVM_MIN_FREE_MMU_PAGES))
+		kvm_mmu_free_some_pages(vcpu);
+	return vcpu->mmu.page_fault(vcpu, gva, error_code);
+}
 
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
Index: linux-2.6/drivers/kvm/svm.c
===================================================================
--- linux-2.6.orig/drivers/kvm/svm.c
+++ linux-2.6/drivers/kvm/svm.c
@@ -861,7 +861,7 @@ static int pf_interception(struct kvm_vc
 
 	fault_address  = vcpu->svm->vmcb->control.exit_info_2;
 	error_code = vcpu->svm->vmcb->control.exit_info_1;
-	if (!vcpu->mmu.page_fault(vcpu, fault_address, error_code)) {
+	if (!kvm_mmu_page_fault(vcpu, fault_address, error_code)) {
 		spin_unlock(&vcpu->kvm->lock);
 		return 1;
 	}
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -246,8 +246,6 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 		}
 		shadow_page = kvm_mmu_get_page(vcpu, table_gfn, addr, level-1,
 					       metaphysical, shadow_ent);
-		if (!shadow_page)
-			return ERR_PTR(-ENOMEM);
 		shadow_addr = shadow_page->page_hpa;
 		shadow_pte = shadow_addr | PT_PRESENT_MASK | PT_ACCESSED_MASK
 			| PT_WRITABLE_MASK | PT_USER_MASK;
@@ -347,17 +345,8 @@ static int FNAME(page_fault)(struct kvm_
 	/*
 	 * Look up the shadow pte for the faulting address.
 	 */
-	for (;;) {
-		FNAME(walk_addr)(&walker, vcpu, addr);
-		shadow_pte = FNAME(fetch)(vcpu, addr, &walker);
-		if (IS_ERR(shadow_pte)) {  /* must be -ENOMEM */
-			printk("%s: oom\n", __FUNCTION__);
-			nonpaging_flush(vcpu);
-			FNAME(release_walker)(&walker);
-			continue;
-		}
-		break;
-	}
+	FNAME(walk_addr)(&walker, vcpu, addr);
+	shadow_pte = FNAME(fetch)(vcpu, addr, &walker);
 
 	/*
 	 * The page is not mapped by the guest.  Let the guest handle it.
Index: linux-2.6/drivers/kvm/vmx.c
===================================================================
--- linux-2.6.orig/drivers/kvm/vmx.c
+++ linux-2.6/drivers/kvm/vmx.c
@@ -1318,7 +1318,7 @@ static int handle_exception(struct kvm_v
 		cr2 = vmcs_readl(EXIT_QUALIFICATION);
 
 		spin_lock(&vcpu->kvm->lock);
-		if (!vcpu->mmu.page_fault(vcpu, cr2, error_code)) {
+		if (!kvm_mmu_page_fault(vcpu, cr2, error_code)) {
 			spin_unlock(&vcpu->kvm->lock);
 			return 1;
 		}
