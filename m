Return-Path: <linux-kernel-owner+w=401wt.eu-S965001AbXADQSM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbXADQSM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965004AbXADQSM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:18:12 -0500
Received: from il.qumranet.com ([62.219.232.206]:51744 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965014AbXADQSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:18:10 -0500
Subject: [PATCH 29/33] KVM: MMU: Replace atomic allocations by preallocated
	objects
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:18:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104161807.98D6B250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The mmu sometimes needs memory for reverse mapping and parent pte chains.
however, we can't allocate from within the mmu because of the atomic context.

So, move the allocations to a central place that can be executed before
the main mmu machinery, where we can bail out on failure before any damage is
done.

(error handling is deffered for now, but the basic structure is there)

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -166,6 +166,84 @@ static int is_rmap_pte(u64 pte)
 		== (PT_WRITABLE_MASK | PT_PRESENT_MASK);
 }
 
+static void mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
+				   size_t objsize, int min)
+{
+	void *obj;
+
+	if (cache->nobjs >= min)
+		return;
+	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
+		obj = kzalloc(objsize, GFP_NOWAIT);
+		if (!obj)
+			BUG();
+		cache->objects[cache->nobjs++] = obj;
+	}
+}
+
+static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
+{
+	while (mc->nobjs)
+		kfree(mc->objects[--mc->nobjs]);
+}
+
+static void mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
+{
+	mmu_topup_memory_cache(&vcpu->mmu_pte_chain_cache,
+			       sizeof(struct kvm_pte_chain), 4);
+	mmu_topup_memory_cache(&vcpu->mmu_rmap_desc_cache,
+			       sizeof(struct kvm_rmap_desc), 1);
+}
+
+static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
+{
+	mmu_free_memory_cache(&vcpu->mmu_pte_chain_cache);
+	mmu_free_memory_cache(&vcpu->mmu_rmap_desc_cache);
+}
+
+static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc,
+				    size_t size)
+{
+	void *p;
+
+	BUG_ON(!mc->nobjs);
+	p = mc->objects[--mc->nobjs];
+	memset(p, 0, size);
+	return p;
+}
+
+static void mmu_memory_cache_free(struct kvm_mmu_memory_cache *mc, void *obj)
+{
+	if (mc->nobjs < KVM_NR_MEM_OBJS)
+		mc->objects[mc->nobjs++] = obj;
+	else
+		kfree(obj);
+}
+
+static struct kvm_pte_chain *mmu_alloc_pte_chain(struct kvm_vcpu *vcpu)
+{
+	return mmu_memory_cache_alloc(&vcpu->mmu_pte_chain_cache,
+				      sizeof(struct kvm_pte_chain));
+}
+
+static void mmu_free_pte_chain(struct kvm_vcpu *vcpu,
+			       struct kvm_pte_chain *pc)
+{
+	mmu_memory_cache_free(&vcpu->mmu_pte_chain_cache, pc);
+}
+
+static struct kvm_rmap_desc *mmu_alloc_rmap_desc(struct kvm_vcpu *vcpu)
+{
+	return mmu_memory_cache_alloc(&vcpu->mmu_rmap_desc_cache,
+				      sizeof(struct kvm_rmap_desc));
+}
+
+static void mmu_free_rmap_desc(struct kvm_vcpu *vcpu,
+			       struct kvm_rmap_desc *rd)
+{
+	mmu_memory_cache_free(&vcpu->mmu_rmap_desc_cache, rd);
+}
+
 /*
  * Reverse mapping data structures:
  *
@@ -175,7 +253,7 @@ static int is_rmap_pte(u64 pte)
  * If page->private bit zero is one, (then page->private & ~1) points
  * to a struct kvm_rmap_desc containing more mappings.
  */
-static void rmap_add(struct kvm *kvm, u64 *spte)
+static void rmap_add(struct kvm_vcpu *vcpu, u64 *spte)
 {
 	struct page *page;
 	struct kvm_rmap_desc *desc;
@@ -189,9 +267,7 @@ static void rmap_add(struct kvm *kvm, u6
 		page->private = (unsigned long)spte;
 	} else if (!(page->private & 1)) {
 		rmap_printk("rmap_add: %p %llx 1->many\n", spte, *spte);
-		desc = kzalloc(sizeof *desc, GFP_NOWAIT);
-		if (!desc)
-			BUG(); /* FIXME: return error */
+		desc = mmu_alloc_rmap_desc(vcpu);
 		desc->shadow_ptes[0] = (u64 *)page->private;
 		desc->shadow_ptes[1] = spte;
 		page->private = (unsigned long)desc | 1;
@@ -201,9 +277,7 @@ static void rmap_add(struct kvm *kvm, u6
 		while (desc->shadow_ptes[RMAP_EXT-1] && desc->more)
 			desc = desc->more;
 		if (desc->shadow_ptes[RMAP_EXT-1]) {
-			desc->more = kzalloc(sizeof *desc->more, GFP_NOWAIT);
-			if (!desc->more)
-				BUG(); /* FIXME: return error */
+			desc->more = mmu_alloc_rmap_desc(vcpu);
 			desc = desc->more;
 		}
 		for (i = 0; desc->shadow_ptes[i]; ++i)
@@ -212,7 +286,8 @@ static void rmap_add(struct kvm *kvm, u6
 	}
 }
 
-static void rmap_desc_remove_entry(struct page *page,
+static void rmap_desc_remove_entry(struct kvm_vcpu *vcpu,
+				   struct page *page,
 				   struct kvm_rmap_desc *desc,
 				   int i,
 				   struct kvm_rmap_desc *prev_desc)
@@ -232,10 +307,10 @@ static void rmap_desc_remove_entry(struc
 			prev_desc->more = desc->more;
 		else
 			page->private = (unsigned long)desc->more | 1;
-	kfree(desc);
+	mmu_free_rmap_desc(vcpu, desc);
 }
 
-static void rmap_remove(struct kvm *kvm, u64 *spte)
+static void rmap_remove(struct kvm_vcpu *vcpu, u64 *spte)
 {
 	struct page *page;
 	struct kvm_rmap_desc *desc;
@@ -263,7 +338,8 @@ static void rmap_remove(struct kvm *kvm,
 		while (desc) {
 			for (i = 0; i < RMAP_EXT && desc->shadow_ptes[i]; ++i)
 				if (desc->shadow_ptes[i] == spte) {
-					rmap_desc_remove_entry(page, desc, i,
+					rmap_desc_remove_entry(vcpu, page,
+							       desc, i,
 							       prev_desc);
 					return;
 				}
@@ -274,8 +350,9 @@ static void rmap_remove(struct kvm *kvm,
 	}
 }
 
-static void rmap_write_protect(struct kvm *kvm, u64 gfn)
+static void rmap_write_protect(struct kvm_vcpu *vcpu, u64 gfn)
 {
+	struct kvm *kvm = vcpu->kvm;
 	struct page *page;
 	struct kvm_memory_slot *slot;
 	struct kvm_rmap_desc *desc;
@@ -298,7 +375,7 @@ static void rmap_write_protect(struct kv
 		BUG_ON(!(*spte & PT_PRESENT_MASK));
 		BUG_ON(!(*spte & PT_WRITABLE_MASK));
 		rmap_printk("rmap_write_protect: spte %p %llx\n", spte, *spte);
-		rmap_remove(kvm, spte);
+		rmap_remove(vcpu, spte);
 		*spte &= ~(u64)PT_WRITABLE_MASK;
 	}
 }
@@ -354,7 +431,8 @@ static struct kvm_mmu_page *kvm_mmu_allo
 	return page;
 }
 
-static void mmu_page_add_parent_pte(struct kvm_mmu_page *page, u64 *parent_pte)
+static void mmu_page_add_parent_pte(struct kvm_vcpu *vcpu,
+				    struct kvm_mmu_page *page, u64 *parent_pte)
 {
 	struct kvm_pte_chain *pte_chain;
 	struct hlist_node *node;
@@ -370,8 +448,7 @@ static void mmu_page_add_parent_pte(stru
 			return;
 		}
 		page->multimapped = 1;
-		pte_chain = kzalloc(sizeof(struct kvm_pte_chain), GFP_NOWAIT);
-		BUG_ON(!pte_chain);
+		pte_chain = mmu_alloc_pte_chain(vcpu);
 		INIT_HLIST_HEAD(&page->parent_ptes);
 		hlist_add_head(&pte_chain->link, &page->parent_ptes);
 		pte_chain->parent_ptes[0] = old;
@@ -385,13 +462,14 @@ static void mmu_page_add_parent_pte(stru
 				return;
 			}
 	}
-	pte_chain = kzalloc(sizeof(struct kvm_pte_chain), GFP_NOWAIT);
+	pte_chain = mmu_alloc_pte_chain(vcpu);
 	BUG_ON(!pte_chain);
 	hlist_add_head(&pte_chain->link, &page->parent_ptes);
 	pte_chain->parent_ptes[0] = parent_pte;
 }
 
-static void mmu_page_remove_parent_pte(struct kvm_mmu_page *page,
+static void mmu_page_remove_parent_pte(struct kvm_vcpu *vcpu,
+				       struct kvm_mmu_page *page,
 				       u64 *parent_pte)
 {
 	struct kvm_pte_chain *pte_chain;
@@ -418,7 +496,7 @@ static void mmu_page_remove_parent_pte(s
 			pte_chain->parent_ptes[i] = NULL;
 			if (i == 0) {
 				hlist_del(&pte_chain->link);
-				kfree(pte_chain);
+				mmu_free_pte_chain(vcpu, pte_chain);
 				if (hlist_empty(&page->parent_ptes)) {
 					page->multimapped = 0;
 					page->parent_pte = NULL;
@@ -478,7 +556,7 @@ static struct kvm_mmu_page *kvm_mmu_get_
 	bucket = &vcpu->kvm->mmu_page_hash[index];
 	hlist_for_each_entry(page, node, bucket, hash_link)
 		if (page->gfn == gfn && page->role.word == role.word) {
-			mmu_page_add_parent_pte(page, parent_pte);
+			mmu_page_add_parent_pte(vcpu, page, parent_pte);
 			pgprintk("%s: found\n", __FUNCTION__);
 			return page;
 		}
@@ -490,7 +568,7 @@ static struct kvm_mmu_page *kvm_mmu_get_
 	page->role = role;
 	hlist_add_head(&page->hash_link, bucket);
 	if (!metaphysical)
-		rmap_write_protect(vcpu->kvm, gfn);
+		rmap_write_protect(vcpu, gfn);
 	return page;
 }
 
@@ -506,7 +584,7 @@ static void kvm_mmu_page_unlink_children
 	if (page->role.level == PT_PAGE_TABLE_LEVEL) {
 		for (i = 0; i < PT64_ENT_PER_PAGE; ++i) {
 			if (pt[i] & PT_PRESENT_MASK)
-				rmap_remove(vcpu->kvm, &pt[i]);
+				rmap_remove(vcpu, &pt[i]);
 			pt[i] = 0;
 		}
 		return;
@@ -519,7 +597,7 @@ static void kvm_mmu_page_unlink_children
 		if (!(ent & PT_PRESENT_MASK))
 			continue;
 		ent &= PT64_BASE_ADDR_MASK;
-		mmu_page_remove_parent_pte(page_header(ent), &pt[i]);
+		mmu_page_remove_parent_pte(vcpu, page_header(ent), &pt[i]);
 	}
 }
 
@@ -527,7 +605,7 @@ static void kvm_mmu_put_page(struct kvm_
 			     struct kvm_mmu_page *page,
 			     u64 *parent_pte)
 {
-	mmu_page_remove_parent_pte(page, parent_pte);
+	mmu_page_remove_parent_pte(vcpu, page, parent_pte);
 }
 
 static void kvm_mmu_zap_page(struct kvm_vcpu *vcpu,
@@ -644,7 +722,7 @@ static int nonpaging_map(struct kvm_vcpu
 			page_header_update_slot(vcpu->kvm, table, v);
 			table[index] = p | PT_PRESENT_MASK | PT_WRITABLE_MASK |
 								PT_USER_MASK;
-			rmap_add(vcpu->kvm, &table[index]);
+			rmap_add(vcpu, &table[index]);
 			return 0;
 		}
 
@@ -747,6 +825,8 @@ static int nonpaging_page_fault(struct k
 	gpa_t addr = gva;
 	hpa_t paddr;
 
+	mmu_topup_memory_caches(vcpu);
+
 	ASSERT(vcpu);
 	ASSERT(VALID_PAGE(vcpu->mmu.root_hpa));
 
@@ -845,7 +925,7 @@ static inline void set_pte_common(struct
 		mark_page_dirty(vcpu->kvm, gaddr >> PAGE_SHIFT);
 
 	page_header_update_slot(vcpu->kvm, shadow_pte, gaddr);
-	rmap_add(vcpu->kvm, shadow_pte);
+	rmap_add(vcpu, shadow_pte);
 }
 
 static void inject_page_fault(struct kvm_vcpu *vcpu,
@@ -966,8 +1046,15 @@ static void destroy_kvm_mmu(struct kvm_v
 
 int kvm_mmu_reset_context(struct kvm_vcpu *vcpu)
 {
+	int r;
+
 	destroy_kvm_mmu(vcpu);
-	return init_kvm_mmu(vcpu);
+	r = init_kvm_mmu(vcpu);
+	if (r < 0)
+		goto out;
+	mmu_topup_memory_caches(vcpu);
+out:
+	return r;
 }
 
 void kvm_mmu_pre_write(struct kvm_vcpu *vcpu, gpa_t gpa, int bytes)
@@ -1030,10 +1117,10 @@ void kvm_mmu_pre_write(struct kvm_vcpu *
 		pte = *spte;
 		if (is_present_pte(pte)) {
 			if (level == PT_PAGE_TABLE_LEVEL)
-				rmap_remove(vcpu->kvm, spte);
+				rmap_remove(vcpu, spte);
 			else {
 				child = page_header(pte & PT64_BASE_ADDR_MASK);
-				mmu_page_remove_parent_pte(child, spte);
+				mmu_page_remove_parent_pte(vcpu, child, spte);
 			}
 		}
 		*spte = 0;
@@ -1145,10 +1232,12 @@ void kvm_mmu_destroy(struct kvm_vcpu *vc
 
 	destroy_kvm_mmu(vcpu);
 	free_mmu_pages(vcpu);
+	mmu_free_memory_caches(vcpu);
 }
 
-void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot)
+void kvm_mmu_slot_remove_write_access(struct kvm_vcpu *vcpu, int slot)
 {
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_mmu_page *page;
 
 	list_for_each_entry(page, &kvm->active_mmu_pages, link) {
@@ -1162,7 +1251,7 @@ void kvm_mmu_slot_remove_write_access(st
 		for (i = 0; i < PT64_ENT_PER_PAGE; ++i)
 			/* avoid RMW */
 			if (pt[i] & PT_WRITABLE_MASK) {
-				rmap_remove(kvm, &pt[i]);
+				rmap_remove(vcpu, &pt[i]);
 				pt[i] &= ~PT_WRITABLE_MASK;
 			}
 	}
Index: linux-2.6/drivers/kvm/kvm_main.c
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm_main.c
+++ linux-2.6/drivers/kvm/kvm_main.c
@@ -702,6 +702,13 @@ out:
 	return r;
 }
 
+static void do_remove_write_access(struct kvm_vcpu *vcpu, int slot)
+{
+	spin_lock(&vcpu->kvm->lock);
+	kvm_mmu_slot_remove_write_access(vcpu, slot);
+	spin_unlock(&vcpu->kvm->lock);
+}
+
 /*
  * Get (and clear) the dirty memory log for a memory slot.
  */
@@ -711,6 +718,7 @@ static int kvm_dev_ioctl_get_dirty_log(s
 	struct kvm_memory_slot *memslot;
 	int r, i;
 	int n;
+	int cleared;
 	unsigned long any = 0;
 
 	spin_lock(&kvm->lock);
@@ -741,15 +749,17 @@ static int kvm_dev_ioctl_get_dirty_log(s
 
 
 	if (any) {
-		spin_lock(&kvm->lock);
-		kvm_mmu_slot_remove_write_access(kvm, log->slot);
-		spin_unlock(&kvm->lock);
-		memset(memslot->dirty_bitmap, 0, n);
+		cleared = 0;
 		for (i = 0; i < KVM_MAX_VCPUS; ++i) {
 			struct kvm_vcpu *vcpu = vcpu_load(kvm, i);
 
 			if (!vcpu)
 				continue;
+			if (!cleared) {
+				do_remove_write_access(vcpu, log->slot);
+				memset(memslot->dirty_bitmap, 0, n);
+				cleared = 1;
+			}
 			kvm_arch_ops->tlb_flush(vcpu);
 			vcpu_put(vcpu);
 		}
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -168,6 +168,17 @@ struct kvm_mmu {
 	u64 *pae_root;
 };
 
+#define KVM_NR_MEM_OBJS 20
+
+struct kvm_mmu_memory_cache {
+	int nobjs;
+	void *objects[KVM_NR_MEM_OBJS];
+};
+
+/*
+ * We don't want allocation failures within the mmu code, so we preallocate
+ * enough memory for a single page fault in a cache.
+ */
 struct kvm_guest_debug {
 	int enabled;
 	unsigned long bp[4];
@@ -239,6 +250,9 @@ struct kvm_vcpu {
 	struct kvm_mmu_page page_header_buf[KVM_NUM_MMU_PAGES];
 	struct kvm_mmu mmu;
 
+	struct kvm_mmu_memory_cache mmu_pte_chain_cache;
+	struct kvm_mmu_memory_cache mmu_rmap_desc_cache;
+
 	gfn_t last_pt_write_gfn;
 	int   last_pt_write_count;
 
@@ -381,7 +395,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu
 int kvm_mmu_setup(struct kvm_vcpu *vcpu);
 
 int kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
-void kvm_mmu_slot_remove_write_access(struct kvm *kvm, int slot);
+void kvm_mmu_slot_remove_write_access(struct kvm_vcpu *vcpu, int slot);
 
 hpa_t gpa_to_hpa(struct kvm_vcpu *vcpu, gpa_t gpa);
 #define HPA_MSB ((sizeof(hpa_t) * 8) - 1)
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -323,7 +323,7 @@ static int FNAME(fix_write_pf)(struct kv
 	mark_page_dirty(vcpu->kvm, gfn);
 	*shadow_ent |= PT_WRITABLE_MASK;
 	*guest_ent |= PT_DIRTY_MASK;
-	rmap_add(vcpu->kvm, shadow_ent);
+	rmap_add(vcpu, shadow_ent);
 
 	return 1;
 }
@@ -353,6 +353,9 @@ static int FNAME(page_fault)(struct kvm_
 	int write_pt = 0;
 
 	pgprintk("%s: addr %lx err %x\n", __FUNCTION__, addr, error_code);
+
+	mmu_topup_memory_caches(vcpu);
+
 	/*
 	 * Look up the shadow pte for the faulting address.
 	 */
