Return-Path: <linux-kernel-owner+w=401wt.eu-S964934AbXADPyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbXADPyL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXADPyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:54:10 -0500
Received: from il.qumranet.com ([62.219.232.206]:39069 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964936AbXADPyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:54:08 -0500
Subject: [PATCH 5/33] KVM: MU: Special treatment for shadow pae root pages
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:54:05 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155405.F02E2250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since we're not going to cache the pae-mode shadow root pages, allocate
a single pae shadow that will hold the four lower-level pages, which
will act as roots.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -420,19 +420,63 @@ static int nonpaging_map(struct kvm_vcpu
 	}
 }
 
+static void mmu_free_roots(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+#ifdef CONFIG_X86_64
+	if (vcpu->mmu.shadow_root_level == PT64_ROOT_LEVEL) {
+		hpa_t root = vcpu->mmu.root_hpa;
+
+		ASSERT(VALID_PAGE(root));
+		release_pt_page_64(vcpu, root, PT64_ROOT_LEVEL);
+		vcpu->mmu.root_hpa = INVALID_PAGE;
+		return;
+	}
+#endif
+	for (i = 0; i < 4; ++i) {
+		hpa_t root = vcpu->mmu.pae_root[i];
+
+		ASSERT(VALID_PAGE(root));
+		root &= PT64_BASE_ADDR_MASK;
+		release_pt_page_64(vcpu, root, PT32E_ROOT_LEVEL - 1);
+		vcpu->mmu.pae_root[i] = INVALID_PAGE;
+	}
+	vcpu->mmu.root_hpa = INVALID_PAGE;
+}
+
+static void mmu_alloc_roots(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+#ifdef CONFIG_X86_64
+	if (vcpu->mmu.shadow_root_level == PT64_ROOT_LEVEL) {
+		hpa_t root = vcpu->mmu.root_hpa;
+
+		ASSERT(!VALID_PAGE(root));
+		root = kvm_mmu_alloc_page(vcpu, NULL);
+		vcpu->mmu.root_hpa = root;
+		return;
+	}
+#endif
+	for (i = 0; i < 4; ++i) {
+		hpa_t root = vcpu->mmu.pae_root[i];
+
+		ASSERT(!VALID_PAGE(root));
+		root = kvm_mmu_alloc_page(vcpu, NULL);
+		vcpu->mmu.pae_root[i] = root | PT_PRESENT_MASK;
+	}
+	vcpu->mmu.root_hpa = __pa(vcpu->mmu.pae_root);
+}
+
 static void nonpaging_flush(struct kvm_vcpu *vcpu)
 {
 	hpa_t root = vcpu->mmu.root_hpa;
 
 	++kvm_stat.tlb_flush;
 	pgprintk("nonpaging_flush\n");
-	ASSERT(VALID_PAGE(root));
-	release_pt_page_64(vcpu, root, vcpu->mmu.shadow_root_level);
-	root = kvm_mmu_alloc_page(vcpu, NULL);
-	ASSERT(VALID_PAGE(root));
-	vcpu->mmu.root_hpa = root;
-	if (is_paging(vcpu))
-		root |= (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK));
+	mmu_free_roots(vcpu);
+	mmu_alloc_roots(vcpu);
 	kvm_arch_ops->set_cr3(vcpu, root);
 	kvm_arch_ops->tlb_flush(vcpu);
 }
@@ -475,13 +519,7 @@ static void nonpaging_inval_page(struct 
 
 static void nonpaging_free(struct kvm_vcpu *vcpu)
 {
-	hpa_t root;
-
-	ASSERT(vcpu);
-	root = vcpu->mmu.root_hpa;
-	if (VALID_PAGE(root))
-		release_pt_page_64(vcpu, root, vcpu->mmu.shadow_root_level);
-	vcpu->mmu.root_hpa = INVALID_PAGE;
+	mmu_free_roots(vcpu);
 }
 
 static int nonpaging_init_context(struct kvm_vcpu *vcpu)
@@ -495,7 +533,7 @@ static int nonpaging_init_context(struct
 	context->free = nonpaging_free;
 	context->root_level = PT32E_ROOT_LEVEL;
 	context->shadow_root_level = PT32E_ROOT_LEVEL;
-	context->root_hpa = kvm_mmu_alloc_page(vcpu, NULL);
+	mmu_alloc_roots(vcpu);
 	ASSERT(VALID_PAGE(context->root_hpa));
 	kvm_arch_ops->set_cr3(vcpu, context->root_hpa);
 	return 0;
@@ -647,7 +685,7 @@ static void paging_free(struct kvm_vcpu 
 #include "paging_tmpl.h"
 #undef PTTYPE
 
-static int paging64_init_context(struct kvm_vcpu *vcpu)
+static int paging64_init_context_common(struct kvm_vcpu *vcpu, int level)
 {
 	struct kvm_mmu *context = &vcpu->mmu;
 
@@ -657,15 +695,20 @@ static int paging64_init_context(struct 
 	context->inval_page = paging_inval_page;
 	context->gva_to_gpa = paging64_gva_to_gpa;
 	context->free = paging_free;
-	context->root_level = PT64_ROOT_LEVEL;
-	context->shadow_root_level = PT64_ROOT_LEVEL;
-	context->root_hpa = kvm_mmu_alloc_page(vcpu, NULL);
+	context->root_level = level;
+	context->shadow_root_level = level;
+	mmu_alloc_roots(vcpu);
 	ASSERT(VALID_PAGE(context->root_hpa));
 	kvm_arch_ops->set_cr3(vcpu, context->root_hpa |
 		    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
 	return 0;
 }
 
+static int paging64_init_context(struct kvm_vcpu *vcpu)
+{
+	return paging64_init_context_common(vcpu, PT64_ROOT_LEVEL);
+}
+
 static int paging32_init_context(struct kvm_vcpu *vcpu)
 {
 	struct kvm_mmu *context = &vcpu->mmu;
@@ -677,7 +720,7 @@ static int paging32_init_context(struct 
 	context->free = paging_free;
 	context->root_level = PT32_ROOT_LEVEL;
 	context->shadow_root_level = PT32E_ROOT_LEVEL;
-	context->root_hpa = kvm_mmu_alloc_page(vcpu, NULL);
+	mmu_alloc_roots(vcpu);
 	ASSERT(VALID_PAGE(context->root_hpa));
 	kvm_arch_ops->set_cr3(vcpu, context->root_hpa |
 		    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
@@ -686,14 +729,7 @@ static int paging32_init_context(struct 
 
 static int paging32E_init_context(struct kvm_vcpu *vcpu)
 {
-	int ret;
-
-	if ((ret = paging64_init_context(vcpu)))
-		return ret;
-
-	vcpu->mmu.root_level = PT32E_ROOT_LEVEL;
-	vcpu->mmu.shadow_root_level = PT32E_ROOT_LEVEL;
-	return 0;
+	return paging64_init_context_common(vcpu, PT32E_ROOT_LEVEL);
 }
 
 static int init_kvm_mmu(struct kvm_vcpu *vcpu)
@@ -737,26 +773,40 @@ static void free_mmu_pages(struct kvm_vc
 		__free_page(pfn_to_page(page->page_hpa >> PAGE_SHIFT));
 		page->page_hpa = INVALID_PAGE;
 	}
+	free_page((unsigned long)vcpu->mmu.pae_root);
 }
 
 static int alloc_mmu_pages(struct kvm_vcpu *vcpu)
 {
+	struct page *page;
 	int i;
 
 	ASSERT(vcpu);
 
 	for (i = 0; i < KVM_NUM_MMU_PAGES; i++) {
-		struct page *page;
 		struct kvm_mmu_page *page_header = &vcpu->page_header_buf[i];
 
 		INIT_LIST_HEAD(&page_header->link);
-		if ((page = alloc_page(GFP_KVM_MMU)) == NULL)
+		if ((page = alloc_page(GFP_KERNEL)) == NULL)
 			goto error_1;
 		page->private = (unsigned long)page_header;
 		page_header->page_hpa = (hpa_t)page_to_pfn(page) << PAGE_SHIFT;
 		memset(__va(page_header->page_hpa), 0, PAGE_SIZE);
 		list_add(&page_header->link, &vcpu->free_pages);
 	}
+
+	/*
+	 * When emulating 32-bit mode, cr3 is only 32 bits even on x86_64.
+	 * Therefore we need to allocate shadow page tables in the first
+	 * 4GB of memory, which happens to fit the DMA32 zone.
+	 */
+	page = alloc_page(GFP_KERNEL | __GFP_DMA32);
+	if (!page)
+		goto error_1;
+	vcpu->mmu.pae_root = page_address(page);
+	for (i = 0; i < 4; ++i)
+		vcpu->mmu.pae_root[i] = INVALID_PAGE;
+
 	return 0;
 
 error_1:
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -123,6 +123,8 @@ struct kvm_mmu {
 	hpa_t root_hpa;
 	int root_level;
 	int shadow_root_level;
+
+	u64 *pae_root;
 };
 
 struct kvm_guest_debug {
@@ -548,19 +550,4 @@ static inline u32 get_rdx_init_val(void)
 #define TSS_REDIRECTION_SIZE (256 / 8)
 #define RMODE_TSS_SIZE (TSS_BASE_SIZE + TSS_REDIRECTION_SIZE + TSS_IOPB_SIZE + 1)
 
-#ifdef CONFIG_X86_64
-
-/*
- * When emulating 32-bit mode, cr3 is only 32 bits even on x86_64.  Therefore
- * we need to allocate shadow page tables in the first 4GB of memory, which
- * happens to fit the DMA32 zone.
- */
-#define GFP_KVM_MMU (GFP_KERNEL | __GFP_DMA32)
-
-#else
-
-#define GFP_KVM_MMU GFP_KERNEL
-
-#endif
-
 #endif
