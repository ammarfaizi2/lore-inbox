Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758087AbWK2VUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758087AbWK2VUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 16:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758105AbWK2VUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 16:20:08 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:43492 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1758087AbWK2VUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 16:20:06 -0500
Date: Wed, 29 Nov 2006 13:18:57 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, avi@qumranet.com, yaniv@qumranet.com
Subject: [PATCH] KVM: fix NULL and C99 init sparse warnings
Message-Id: <20061129131857.bd3c68f9.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

Fix sparse NULL and C99 struct init warnings in kvm:

drivers/kvm/vmx.c:62:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:63:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:64:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:65:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:66:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:67:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:68:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:69:2: warning: obsolete array initializer, use C99 syntax
drivers/kvm/vmx.c:116:32: warning: Using plain integer as NULL pointer
drivers/kvm/vmx.c:559:10: warning: Using plain integer as NULL pointer
drivers/kvm/kvm.h:385:57: warning: Using plain integer as NULL pointer
drivers/kvm/kvm.h:385:57: warning: Using plain integer as NULL pointer
drivers/kvm/kvm.h:385:57: warning: Using plain integer as NULL pointer
drivers/kvm/vmx.c:1293:33: warning: Using plain integer as NULL pointer
drivers/kvm/vmx.c:1917:16: warning: Using plain integer as NULL pointer
drivers/kvm/mmu.c:321:34: warning: Using plain integer as NULL pointer
drivers/kvm/mmu.c:387:47: warning: Using plain integer as NULL pointer
drivers/kvm/mmu.c:548:47: warning: Using plain integer as NULL pointer
drivers/kvm/mmu.c:566:47: warning: Using plain integer as NULL pointer
drivers/kvm/x86_emulate.c:686:20: warning: Using plain integer as NULL pointer

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/kvm/kvm.h         |    2 +-
 drivers/kvm/mmu.c         |    8 ++++----
 drivers/kvm/vmx.c         |   18 +++++++++---------
 drivers/kvm/x86_emulate.c |    2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

--- linux-2.6.19-rc6-mm2.orig/drivers/kvm/kvm.h
+++ linux-2.6.19-rc6-mm2/drivers/kvm/kvm.h
@@ -382,7 +382,7 @@ unsigned long segment_base(u16 selector)
 static inline struct page *_gfn_to_page(struct kvm *kvm, gfn_t gfn)
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
-	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : 0;
+	return (slot) ? slot->phys_mem[gfn - slot->base_gfn] : NULL;
 }
 
 static inline int is_pae(struct kvm_vcpu *vcpu)
--- linux-2.6.19-rc6-mm2.orig/drivers/kvm/mmu.c
+++ linux-2.6.19-rc6-mm2/drivers/kvm/mmu.c
@@ -318,7 +318,7 @@ static void nonpaging_flush(struct kvm_v
 	pgprintk("nonpaging_flush\n");
 	ASSERT(VALID_PAGE(root));
 	release_pt_page_64(vcpu, root, vcpu->mmu.shadow_root_level);
-	root = kvm_mmu_alloc_page(vcpu, 0);
+	root = kvm_mmu_alloc_page(vcpu, NULL);
 	ASSERT(VALID_PAGE(root));
 	vcpu->mmu.root_hpa = root;
 	if (is_paging(vcpu))
@@ -384,7 +384,7 @@ static int nonpaging_init_context(struct
 	context->free = nonpaging_free;
 	context->root_level = PT32E_ROOT_LEVEL;
 	context->shadow_root_level = PT32E_ROOT_LEVEL;
-	context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
+	context->root_hpa = kvm_mmu_alloc_page(vcpu, NULL);
 	ASSERT(VALID_PAGE(context->root_hpa));
 	kvm_arch_ops->set_cr3(vcpu, context->root_hpa);
 	return 0;
@@ -545,7 +545,7 @@ static int paging64_init_context(struct 
 	context->free = paging_free;
 	context->root_level = PT64_ROOT_LEVEL;
 	context->shadow_root_level = PT64_ROOT_LEVEL;
-	context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
+	context->root_hpa = kvm_mmu_alloc_page(vcpu, NULL);
 	ASSERT(VALID_PAGE(context->root_hpa));
 	kvm_arch_ops->set_cr3(vcpu, context->root_hpa |
 		    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
@@ -563,7 +563,7 @@ static int paging32_init_context(struct 
 	context->free = paging_free;
 	context->root_level = PT32_ROOT_LEVEL;
 	context->shadow_root_level = PT32E_ROOT_LEVEL;
-	context->root_hpa = kvm_mmu_alloc_page(vcpu, 0);
+	context->root_hpa = kvm_mmu_alloc_page(vcpu, NULL);
 	ASSERT(VALID_PAGE(context->root_hpa));
 	kvm_arch_ops->set_cr3(vcpu, context->root_hpa |
 		    (vcpu->cr3 & (CR3_PCD_MASK | CR3_WPT_MASK)));
--- linux-2.6.19-rc6-mm2.orig/drivers/kvm/vmx.c
+++ linux-2.6.19-rc6-mm2/drivers/kvm/vmx.c
@@ -46,11 +46,11 @@ static struct vmcs_descriptor {
 } vmcs_descriptor;
 
 #define VMX_SEGMENT_FIELD(seg)					\
-	[VCPU_SREG_##seg] {                                     \
-		GUEST_##seg##_SELECTOR,				\
-		GUEST_##seg##_BASE,			   	\
-		GUEST_##seg##_LIMIT,			   	\
-		GUEST_##seg##_AR_BYTES,			   	\
+	[VCPU_SREG_##seg] = {                                   \
+		.selector = GUEST_##seg##_SELECTOR,		\
+		.base = GUEST_##seg##_BASE,		   	\
+		.limit = GUEST_##seg##_LIMIT,		   	\
+		.ar_bytes = GUEST_##seg##_AR_BYTES,	   	\
 	}
 
 static struct kvm_vmx_segment_field {
@@ -113,7 +113,7 @@ static void __vcpu_clear(void *arg)
 	if (vcpu->cpu == cpu)
 		vmcs_clear(vcpu->vmcs);
 	if (per_cpu(current_vmcs, cpu) == vcpu->vmcs)
-		per_cpu(current_vmcs, cpu) = 0;
+		per_cpu(current_vmcs, cpu) = NULL;
 }
 
 static unsigned long vmcs_readl(unsigned long field)
@@ -556,7 +556,7 @@ static struct vmcs *alloc_vmcs_cpu(int c
 
 	pages = alloc_pages_node(node, GFP_KERNEL, vmcs_descriptor.order);
 	if (!pages)
-		return 0;
+		return NULL;
 	vmcs = page_address(pages);
 	memset(vmcs, 0, vmcs_descriptor.size);
 	vmcs->revision_id = vmcs_descriptor.revision_id; /* vmcs revision id */
@@ -1290,7 +1290,7 @@ static int handle_rmode_exception(struct
 		return 0;
 
 	if (vec == GP_VECTOR && err_code == 0)
-		if (emulate_instruction(vcpu, 0, 0, 0) == EMULATE_DONE)
+		if (emulate_instruction(vcpu, NULL, 0, 0) == EMULATE_DONE)
 			return 1;
 	return 0;
 }
@@ -1914,7 +1914,7 @@ static void vmx_free_vmcs(struct kvm_vcp
 	if (vcpu->vmcs) {
 		on_each_cpu(__vcpu_clear, vcpu, 0, 1);
 		free_vmcs(vcpu->vmcs);
-		vcpu->vmcs = 0;
+		vcpu->vmcs = NULL;
 	}
 }
 
--- linux-2.6.19-rc6-mm2.orig/drivers/kvm/x86_emulate.c
+++ linux-2.6.19-rc6-mm2/drivers/kvm/x86_emulate.c
@@ -683,7 +683,7 @@ done_prefixes:
 		if (mode == X86EMUL_MODE_PROT64 &&
 		    override_base != &ctxt->fs_base &&
 		    override_base != &ctxt->gs_base)
-			override_base = 0;
+			override_base = NULL;
 
 		if (override_base)
 			modrm_ea += *override_base;


---
