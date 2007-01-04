Return-Path: <linux-kernel-owner+w=401wt.eu-S932336AbXADPuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbXADPuJ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964780AbXADPuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:50:09 -0500
Received: from il.qumranet.com ([62.219.232.206]:34437 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932336AbXADPuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:50:07 -0500
Subject: [PATCH 1/33] KVM: MMU: Implement simple reverse mapping
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:50:05 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155005.98B85250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keep in each host page frame's page->private a pointer to the shadow pte which
maps it.  If there are multiple shadow ptes mapping the page, set bit 0 of
page->private, and use the rest as a pointer to a linked list of all such
mappings.

Reverse mappings are needed because we when we cache shadow page tables,
we must protect the guest page tables from being modified by the guest, as
that would invalidate the cached ptes.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -27,6 +27,7 @@
 #include "kvm.h"
 
 #define pgprintk(x...) do { } while (0)
+#define rmap_printk(x...) do { } while (0)
 
 #define ASSERT(x)							\
 	if (!(x)) {							\
@@ -125,6 +126,13 @@
 #define PT_DIRECTORY_LEVEL 2
 #define PT_PAGE_TABLE_LEVEL 1
 
+#define RMAP_EXT 4
+
+struct kvm_rmap_desc {
+	u64 *shadow_ptes[RMAP_EXT];
+	struct kvm_rmap_desc *more;
+};
+
 static int is_write_protection(struct kvm_vcpu *vcpu)
 {
 	return vcpu->cr0 & CR0_WP_MASK;
@@ -150,6 +158,120 @@ static int is_io_pte(unsigned long pte)
 	return pte & PT_SHADOW_IO_MARK;
 }
 
+static int is_rmap_pte(u64 pte)
+{
+	return (pte & (PT_WRITABLE_MASK | PT_PRESENT_MASK))
+		== (PT_WRITABLE_MASK | PT_PRESENT_MASK);
+}
+
+/*
+ * Reverse mapping data structures:
+ *
+ * If page->private bit zero is zero, then page->private points to the
+ * shadow page table entry that points to page_address(page).
+ *
+ * If page->private bit zero is one, (then page->private & ~1) points
+ * to a struct kvm_rmap_desc containing more mappings.
+ */
+static void rmap_add(struct kvm *kvm, u64 *spte)
+{
+	struct page *page;
+	struct kvm_rmap_desc *desc;
+	int i;
+
+	if (!is_rmap_pte(*spte))
+		return;
+	page = pfn_to_page((*spte & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT);
+	if (!page->private) {
+		rmap_printk("rmap_add: %p %llx 0->1\n", spte, *spte);
+		page->private = (unsigned long)spte;
+	} else if (!(page->private & 1)) {
+		rmap_printk("rmap_add: %p %llx 1->many\n", spte, *spte);
+		desc = kzalloc(sizeof *desc, GFP_NOWAIT);
+		if (!desc)
+			BUG(); /* FIXME: return error */
+		desc->shadow_ptes[0] = (u64 *)page->private;
+		desc->shadow_ptes[1] = spte;
+		page->private = (unsigned long)desc | 1;
+	} else {
+		rmap_printk("rmap_add: %p %llx many->many\n", spte, *spte);
+		desc = (struct kvm_rmap_desc *)(page->private & ~1ul);
+		while (desc->shadow_ptes[RMAP_EXT-1] && desc->more)
+			desc = desc->more;
+		if (desc->shadow_ptes[RMAP_EXT-1]) {
+			desc->more = kzalloc(sizeof *desc->more, GFP_NOWAIT);
+			if (!desc->more)
+				BUG(); /* FIXME: return error */
+			desc = desc->more;
+		}
+		for (i = 0; desc->shadow_ptes[i]; ++i)
+			;
+		desc->shadow_ptes[i] = spte;
+	}
+}
+
+static void rmap_desc_remove_entry(struct page *page,
+				   struct kvm_rmap_desc *desc,
+				   int i,
+				   struct kvm_rmap_desc *prev_desc)
+{
+	int j;
+
+	for (j = RMAP_EXT - 1; !desc->shadow_ptes[j] && j > i; --j)
+		;
+	desc->shadow_ptes[i] = desc->shadow_ptes[j];
+	desc->shadow_ptes[j] = 0;
+	if (j != 0)
+		return;
+	if (!prev_desc && !desc->more)
+		page->private = (unsigned long)desc->shadow_ptes[0];
+	else
+		if (prev_desc)
+			prev_desc->more = desc->more;
+		else
+			page->private = (unsigned long)desc->more | 1;
+	kfree(desc);
+}
+
+static void rmap_remove(struct kvm *kvm, u64 *spte)
+{
+	struct page *page;
+	struct kvm_rmap_desc *desc;
+	struct kvm_rmap_desc *prev_desc;
+	int i;
+
+	if (!is_rmap_pte(*spte))
+		return;
+	page = pfn_to_page((*spte & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT);
+	if (!page->private) {
+		printk(KERN_ERR "rmap_remove: %p %llx 0->BUG\n", spte, *spte);
+		BUG();
+	} else if (!(page->private & 1)) {
+		rmap_printk("rmap_remove:  %p %llx 1->0\n", spte, *spte);
+		if ((u64 *)page->private != spte) {
+			printk(KERN_ERR "rmap_remove:  %p %llx 1->BUG\n",
+			       spte, *spte);
+			BUG();
+		}
+		page->private = 0;
+	} else {
+		rmap_printk("rmap_remove:  %p %llx many->many\n", spte, *spte);
+		desc = (struct kvm_rmap_desc *)(page->private & ~1ul);
+		prev_desc = NULL;
+		while (desc) {
+			for (i = 0; i < RMAP_EXT && desc->shadow_ptes[i]; ++i)
+				if (desc->shadow_ptes[i] == spte) {
+					rmap_desc_remove_entry(page, desc, i,
+							       prev_desc);
+					return;
+				}
+			prev_desc = desc;
+			desc = desc->more;
+		}
+		BUG();
+	}
+}
+
 static void kvm_mmu_free_page(struct kvm_vcpu *vcpu, hpa_t page_hpa)
 {
 	struct kvm_mmu_page *page_head = page_header(page_hpa);
@@ -229,27 +351,27 @@ hpa_t gva_to_hpa(struct kvm_vcpu *vcpu, 
 static void release_pt_page_64(struct kvm_vcpu *vcpu, hpa_t page_hpa,
 			       int level)
 {
+	u64 *pos;
+	u64 *end;
+
 	ASSERT(vcpu);
 	ASSERT(VALID_PAGE(page_hpa));
 	ASSERT(level <= PT64_ROOT_LEVEL && level > 0);
 
-	if (level == 1)
-		memset(__va(page_hpa), 0, PAGE_SIZE);
-	else {
-		u64 *pos;
-		u64 *end;
-
-		for (pos = __va(page_hpa), end = pos + PT64_ENT_PER_PAGE;
-		     pos != end; pos++) {
-			u64 current_ent = *pos;
+	for (pos = __va(page_hpa), end = pos + PT64_ENT_PER_PAGE;
+	     pos != end; pos++) {
+		u64 current_ent = *pos;
 
-			*pos = 0;
-			if (is_present_pte(current_ent))
+		if (is_present_pte(current_ent)) {
+			if (level != 1)
 				release_pt_page_64(vcpu,
 						  current_ent &
 						  PT64_BASE_ADDR_MASK,
 						  level - 1);
+			else
+				rmap_remove(vcpu->kvm, pos);
 		}
+		*pos = 0;
 	}
 	kvm_mmu_free_page(vcpu, page_hpa);
 }
@@ -275,6 +397,7 @@ static int nonpaging_map(struct kvm_vcpu
 			page_header_update_slot(vcpu->kvm, table, v);
 			table[index] = p | PT_PRESENT_MASK | PT_WRITABLE_MASK |
 								PT_USER_MASK;
+			rmap_add(vcpu->kvm, &table[index]);
 			return 0;
 		}
 
@@ -437,6 +560,7 @@ static inline void set_pte_common(struct
 	} else {
 		*shadow_pte |= paddr;
 		page_header_update_slot(vcpu->kvm, shadow_pte, gaddr);
+		rmap_add(vcpu->kvm, shadow_pte);
 	}
 }
 
@@ -489,6 +613,7 @@ static void paging_inval_page(struct kvm
 		u64 *table = __va(page_addr);
 
 		if (level == PT_PAGE_TABLE_LEVEL ) {
+			rmap_remove(vcpu->kvm, &table[index]);
 			table[index] = 0;
 			return;
 		}
@@ -679,8 +804,9 @@ void kvm_mmu_slot_remove_write_access(st
 		pt = __va(page->page_hpa);
 		for (i = 0; i < PT64_ENT_PER_PAGE; ++i)
 			/* avoid RMW */
-			if (pt[i] & PT_WRITABLE_MASK)
+			if (pt[i] & PT_WRITABLE_MASK) {
+				rmap_remove(kvm, &pt[i]);
 				pt[i] &= ~PT_WRITABLE_MASK;
-
+			}
 	}
 }
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -236,6 +236,7 @@ struct kvm {
 	struct kvm_vcpu vcpus[KVM_MAX_VCPUS];
 	int memory_config_version;
 	int busy;
+	unsigned long rmap_overflow;
 };
 
 struct kvm_stat {
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -261,6 +261,7 @@ static int FNAME(fix_write_pf)(struct kv
 	mark_page_dirty(vcpu->kvm, gfn);
 	*shadow_ent |= PT_WRITABLE_MASK;
 	*guest_ent |= PT_DIRTY_MASK;
+	rmap_add(vcpu->kvm, shadow_ent);
 
 	return 1;
 }
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -638,6 +638,7 @@ raced:
 						     | __GFP_ZERO);
 			if (!new.phys_mem[i])
 				goto out_free;
+ 			new.phys_mem[i]->private = 0;
 		}
 	}
 
