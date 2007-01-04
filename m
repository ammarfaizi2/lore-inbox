Return-Path: <linux-kernel-owner+w=401wt.eu-S964942AbXADP6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbXADP6O (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 10:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbXADP6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 10:58:14 -0500
Received: from il.qumranet.com ([62.219.232.206]:46533 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964950AbXADP6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 10:58:10 -0500
Subject: [PATCH 9/33] KVM: MMU: Shadow page table caching
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 15:58:06 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104155806.62E7C250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Define a hashtable for caching shadow page tables. Look up the cache on
context switch (cr3 change) or during page faults.

The key to the cache is a combination of
- the guest page table frame number
- the number of paging levels in the guest
   * we can cache real mode, 32-bit mode, pae, and long mode page
     tables simultaneously.  this is useful for smp bootup.
- the guest page table table
   * some kernels use a page as both a page table and a page directory.  this
     allows multiple shadow pages to exist for that page, one per level
- the "quadrant"
   * 32-bit mode page tables span 4MB, whereas a shadow page table spans
     2MB.  similarly, a 32-bit page directory spans 4GB, while a shadow
     page directory spans 1GB.  the quadrant allows caching up to 4 shadow page
     tables for one guest page in one level.
- a "metaphysical" bit
   * for real mode, and for pse pages, there is no guest page table, so set
     the bit to avoid write protecting the page.

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -26,8 +26,8 @@
 #include "vmx.h"
 #include "kvm.h"
 
-#define pgprintk(x...) do { } while (0)
-#define rmap_printk(x...) do { } while (0)
+#define pgprintk(x...) do { printk(x); } while (0)
+#define rmap_printk(x...) do { printk(x); } while (0)
 
 #define ASSERT(x)							\
 	if (!(x)) {							\
@@ -35,8 +35,10 @@
 		       __FILE__, __LINE__, #x);				\
 	}
 
-#define PT64_ENT_PER_PAGE 512
-#define PT32_ENT_PER_PAGE 1024
+#define PT64_PT_BITS 9
+#define PT64_ENT_PER_PAGE (1 << PT64_PT_BITS)
+#define PT32_PT_BITS 10
+#define PT32_ENT_PER_PAGE (1 << PT32_PT_BITS)
 
 #define PT_WRITABLE_SHIFT 1
 
@@ -292,6 +294,11 @@ static int is_empty_shadow_page(hpa_t pa
 	return 1;
 }
 
+static unsigned kvm_page_table_hashfn(gfn_t gfn)
+{
+	return gfn;
+}
+
 static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu,
 					       u64 *parent_pte)
 {
@@ -306,10 +313,147 @@ static struct kvm_mmu_page *kvm_mmu_allo
 	ASSERT(is_empty_shadow_page(page->page_hpa));
 	page->slot_bitmap = 0;
 	page->global = 1;
+	page->multimapped = 0;
 	page->parent_pte = parent_pte;
 	return page;
 }
 
+static void mmu_page_add_parent_pte(struct kvm_mmu_page *page, u64 *parent_pte)
+{
+	struct kvm_pte_chain *pte_chain;
+	struct hlist_node *node;
+	int i;
+
+	if (!parent_pte)
+		return;
+	if (!page->multimapped) {
+		u64 *old = page->parent_pte;
+
+		if (!old) {
+			page->parent_pte = parent_pte;
+			return;
+		}
+		page->multimapped = 1;
+		pte_chain = kzalloc(sizeof(struct kvm_pte_chain), GFP_NOWAIT);
+		BUG_ON(!pte_chain);
+		INIT_HLIST_HEAD(&page->parent_ptes);
+		hlist_add_head(&pte_chain->link, &page->parent_ptes);
+		pte_chain->parent_ptes[0] = old;
+	}
+	hlist_for_each_entry(pte_chain, node, &page->parent_ptes, link) {
+		if (pte_chain->parent_ptes[NR_PTE_CHAIN_ENTRIES-1])
+			continue;
+		for (i = 0; i < NR_PTE_CHAIN_ENTRIES; ++i)
+			if (!pte_chain->parent_ptes[i]) {
+				pte_chain->parent_ptes[i] = parent_pte;
+				return;
+			}
+	}
+	pte_chain = kzalloc(sizeof(struct kvm_pte_chain), GFP_NOWAIT);
+	BUG_ON(!pte_chain);
+	hlist_add_head(&pte_chain->link, &page->parent_ptes);
+	pte_chain->parent_ptes[0] = parent_pte;
+}
+
+static void mmu_page_remove_parent_pte(struct kvm_mmu_page *page,
+				       u64 *parent_pte)
+{
+	struct kvm_pte_chain *pte_chain;
+	struct hlist_node *node;
+	int i;
+
+	if (!page->multimapped) {
+		BUG_ON(page->parent_pte != parent_pte);
+		page->parent_pte = NULL;
+		return;
+	}
+	hlist_for_each_entry(pte_chain, node, &page->parent_ptes, link)
+		for (i = 0; i < NR_PTE_CHAIN_ENTRIES; ++i) {
+			if (!pte_chain->parent_ptes[i])
+				break;
+			if (pte_chain->parent_ptes[i] != parent_pte)
+				continue;
+			while (i + 1 < NR_PTE_CHAIN_ENTRIES) {
+				pte_chain->parent_ptes[i]
+					= pte_chain->parent_ptes[i + 1];
+				++i;
+			}
+			pte_chain->parent_ptes[i] = NULL;
+			return;
+		}
+	BUG();
+}
+
+static struct kvm_mmu_page *kvm_mmu_lookup_page(struct kvm_vcpu *vcpu,
+						gfn_t gfn)
+{
+	unsigned index;
+	struct hlist_head *bucket;
+	struct kvm_mmu_page *page;
+	struct hlist_node *node;
+
+	pgprintk("%s: looking for gfn %lx\n", __FUNCTION__, gfn);
+	index = kvm_page_table_hashfn(gfn) % KVM_NUM_MMU_PAGES;
+	bucket = &vcpu->kvm->mmu_page_hash[index];
+	hlist_for_each_entry(page, node, bucket, hash_link)
+		if (page->gfn == gfn && !page->role.metaphysical) {
+			pgprintk("%s: found role %x\n",
+				 __FUNCTION__, page->role.word);
+			return page;
+		}
+	return NULL;
+}
+
+static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
+					     gfn_t gfn,
+					     gva_t gaddr,
+					     unsigned level,
+					     int metaphysical,
+					     u64 *parent_pte)
+{
+	union kvm_mmu_page_role role;
+	unsigned index;
+	unsigned quadrant;
+	struct hlist_head *bucket;
+	struct kvm_mmu_page *page;
+	struct hlist_node *node;
+
+	role.word = 0;
+	role.glevels = vcpu->mmu.root_level;
+	role.level = level;
+	role.metaphysical = metaphysical;
+	if (vcpu->mmu.root_level <= PT32_ROOT_LEVEL) {
+		quadrant = gaddr >> (PAGE_SHIFT + (PT64_PT_BITS * level));
+		quadrant &= (1 << ((PT32_PT_BITS - PT64_PT_BITS) * level)) - 1;
+		role.quadrant = quadrant;
+	}
+	pgprintk("%s: looking gfn %lx role %x\n", __FUNCTION__,
+		 gfn, role.word);
+	index = kvm_page_table_hashfn(gfn) % KVM_NUM_MMU_PAGES;
+	bucket = &vcpu->kvm->mmu_page_hash[index];
+	hlist_for_each_entry(page, node, bucket, hash_link)
+		if (page->gfn == gfn && page->role.word == role.word) {
+			mmu_page_add_parent_pte(page, parent_pte);
+			pgprintk("%s: found\n", __FUNCTION__);
+			return page;
+		}
+	page = kvm_mmu_alloc_page(vcpu, parent_pte);
+	if (!page)
+		return page;
+	pgprintk("%s: adding gfn %lx role %x\n", __FUNCTION__, gfn, role.word);
+	page->gfn = gfn;
+	page->role = role;
+	hlist_add_head(&page->hash_link, bucket);
+	return page;
+}
+
+static void kvm_mmu_put_page(struct kvm_vcpu *vcpu,
+			     struct kvm_mmu_page *page,
+			     u64 *parent_pte)
+{
+	mmu_page_remove_parent_pte(page, parent_pte);
+}
+
 static void page_header_update_slot(struct kvm *kvm, void *pte, gpa_t gpa)
 {
 	int slot = memslot_id(kvm, gfn_to_memslot(kvm, gpa >> PAGE_SHIFT));
@@ -389,11 +533,15 @@ static int nonpaging_map(struct kvm_vcpu
 	for (; ; level--) {
 		u32 index = PT64_INDEX(v, level);
 		u64 *table;
+		u64 pte;
 
 		ASSERT(VALID_PAGE(table_addr));
 		table = __va(table_addr);
 
 		if (level == 1) {
+			pte = table[index];
+			if (is_present_pte(pte) && is_writeble_pte(pte))
+				return 0;
 			mark_page_dirty(vcpu->kvm, v >> PAGE_SHIFT);
 			page_header_update_slot(vcpu->kvm, table, v);
 			table[index] = p | PT_PRESENT_MASK | PT_WRITABLE_MASK |
@@ -404,8 +552,13 @@ static int nonpaging_map(struct kvm_vcpu
 
 		if (table[index] == 0) {
 			struct kvm_mmu_page *new_table;
+			gfn_t pseudo_gfn;
 
-			new_table = kvm_mmu_alloc_page(vcpu, &table[index]);
+			pseudo_gfn = (v & PT64_DIR_BASE_ADDR_MASK)
+				>> PAGE_SHIFT;
+			new_table = kvm_mmu_get_page(vcpu, pseudo_gfn,
+						     v, level - 1,
+						     1, &table[index]);
 			if (!new_table) {
 				pgprintk("nonpaging_map: ENOMEM\n");
 				return -ENOMEM;
@@ -427,7 +580,6 @@ static void mmu_free_roots(struct kvm_vc
 		hpa_t root = vcpu->mmu.root_hpa;
 
 		ASSERT(VALID_PAGE(root));
-		release_pt_page_64(vcpu, root, PT64_ROOT_LEVEL);
 		vcpu->mmu.root_hpa = INVALID_PAGE;
 		return;
 	}
@@ -437,7 +589,6 @@ static void mmu_free_roots(struct kvm_vc
 
 		ASSERT(VALID_PAGE(root));
 		root &= PT64_BASE_ADDR_MASK;
-		release_pt_page_64(vcpu, root, PT32E_ROOT_LEVEL - 1);
 		vcpu->mmu.pae_root[i] = INVALID_PAGE;
 	}
 	vcpu->mmu.root_hpa = INVALID_PAGE;
@@ -446,13 +597,16 @@ static void mmu_free_roots(struct kvm_vc
 static void mmu_alloc_roots(struct kvm_vcpu *vcpu)
 {
 	int i;
+	gfn_t root_gfn;
+	root_gfn = vcpu->cr3 >> PAGE_SHIFT;
 
 #ifdef CONFIG_X86_64
 	if (vcpu->mmu.shadow_root_level == PT64_ROOT_LEVEL) {
 		hpa_t root = vcpu->mmu.root_hpa;
 
 		ASSERT(!VALID_PAGE(root));
-		root = kvm_mmu_alloc_page(vcpu, NULL)->page_hpa;
+		root = kvm_mmu_get_page(vcpu, root_gfn, 0,
+					PT64_ROOT_LEVEL, 0, NULL)->page_hpa;
 		vcpu->mmu.root_hpa = root;
 		return;
 	}
@@ -461,7 +615,13 @@ static void mmu_alloc_roots(struct kvm_v
 		hpa_t root = vcpu->mmu.pae_root[i];
 
 		ASSERT(!VALID_PAGE(root));
-		root = kvm_mmu_alloc_page(vcpu, NULL)->page_hpa;
+		if (vcpu->mmu.root_level == PT32E_ROOT_LEVEL)
+			root_gfn = vcpu->pdptrs[i] >> PAGE_SHIFT;
+		else if (vcpu->mmu.root_level == 0)
+			root_gfn = 0;
+		root = kvm_mmu_get_page(vcpu, root_gfn, i << 30,
+					PT32_ROOT_LEVEL, !is_paging(vcpu),
+					NULL)->page_hpa;
 		vcpu->mmu.pae_root[i] = root | PT_PRESENT_MASK;
 	}
 	vcpu->mmu.root_hpa = __pa(vcpu->mmu.pae_root);
@@ -529,7 +689,7 @@ static int nonpaging_init_context(struct
 	context->inval_page = nonpaging_inval_page;
 	context->gva_to_gpa = nonpaging_gva_to_gpa;
 	context->free = nonpaging_free;
-	context->root_level = PT32E_ROOT_LEVEL;
+	context->root_level = 0;
 	context->shadow_root_level = PT32E_ROOT_LEVEL;
 	mmu_alloc_roots(vcpu);
 	ASSERT(VALID_PAGE(context->root_hpa));
@@ -537,29 +697,18 @@ static int nonpaging_init_context(struct
 	return 0;
 }
 
-
 static void kvm_mmu_flush_tlb(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu_page *page, *npage;
-
-	list_for_each_entry_safe(page, npage, &vcpu->kvm->active_mmu_pages,
-				 link) {
-		if (page->global)
-			continue;
-
-		if (!page->parent_pte)
-			continue;
-
-		*page->parent_pte = 0;
-		release_pt_page_64(vcpu, page->page_hpa, 1);
-	}
 	++kvm_stat.tlb_flush;
 	kvm_arch_ops->tlb_flush(vcpu);
 }
 
 static void paging_new_cr3(struct kvm_vcpu *vcpu)
 {
+	mmu_free_roots(vcpu);
+	mmu_alloc_roots(vcpu);
 	kvm_mmu_flush_tlb(vcpu);
+	kvm_arch_ops->set_cr3(vcpu, vcpu->mmu.root_hpa);
 }
 
 static void mark_pagetable_nonglobal(void *shadow_pte)
@@ -578,6 +727,16 @@ static inline void set_pte_common(struct
 	*shadow_pte |= access_bits << PT_SHADOW_BITS_OFFSET;
 	if (!dirty)
 		access_bits &= ~PT_WRITABLE_MASK;
+	if (access_bits & PT_WRITABLE_MASK) {
+		struct kvm_mmu_page *shadow;
+
+		shadow = kvm_mmu_lookup_page(vcpu, gaddr >> PAGE_SHIFT);
+		if (shadow)
+			pgprintk("%s: found shadow page for %lx, marking ro\n",
+				 __FUNCTION__, (gfn_t)(gaddr >> PAGE_SHIFT));
+		if (shadow)
+			access_bits &= ~PT_WRITABLE_MASK;
+	}
 
 	if (access_bits & PT_WRITABLE_MASK)
 		mark_page_dirty(vcpu->kvm, gaddr >> PAGE_SHIFT);
Index: linux-2.6/drivers/kvm/kvm.h
===================================================================
--- linux-2.6.orig/drivers/kvm/kvm.h
+++ linux-2.6/drivers/kvm/kvm.h
@@ -89,14 +89,53 @@ typedef unsigned long  hva_t;
 typedef u64            hpa_t;
 typedef unsigned long  hfn_t;
 
+#define NR_PTE_CHAIN_ENTRIES 5
+
+struct kvm_pte_chain {
+	u64 *parent_ptes[NR_PTE_CHAIN_ENTRIES];
+	struct hlist_node link;
+};
+
+/*
+ * kvm_mmu_page_role, below, is defined as:
+ *
+ *   bits 0:3 - total guest paging levels (2-4, or zero for real mode)
+ *   bits 4:7 - page table level for this shadow (1-4)
+ *   bits 8:9 - page table quadrant for 2-level guests
+ *   bit   16 - "metaphysical" - gfn is not a real page (huge page/real mode)
+ */
+union kvm_mmu_page_role {
+	unsigned word;
+	struct {
+		unsigned glevels : 4;
+		unsigned level : 4;
+		unsigned quadrant : 2;
+		unsigned pad_for_nice_hex_output : 6;
+		unsigned metaphysical : 1;
+	};
+};
+
 struct kvm_mmu_page {
 	struct list_head link;
+	struct hlist_node hash_link;
+
+	/*
+	 * The following two entries are used to key the shadow page in the
+	 * hash table.
+	 */
+	gfn_t gfn;
+	union kvm_mmu_page_role role;
+
 	hpa_t page_hpa;
 	unsigned long slot_bitmap; /* One bit set per slot which has memory
 				    * in this shadow page.
 				    */
 	int global;              /* Set if all ptes in this page are global */
-	u64 *parent_pte;
+	int multimapped;         /* More than one parent_pte? */
+	union {
+		u64 *parent_pte;               /* !multimapped */
+		struct hlist_head parent_ptes; /* multimapped, kvm_pte_chain */
+	};
 };
 
 struct vmcs {
@@ -235,7 +274,11 @@ struct kvm {
 	spinlock_t lock; /* protects everything except vcpus */
 	int nmemslots;
 	struct kvm_memory_slot memslots[KVM_MEMORY_SLOTS];
+	/*
+	 * Hash table of struct kvm_mmu_page.
+	 */
 	struct list_head active_mmu_pages;
+	struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];
 	struct kvm_vcpu vcpus[KVM_MAX_VCPUS];
 	int memory_config_version;
 	int busy;
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -32,6 +32,11 @@
 	#define SHADOW_PT_INDEX(addr, level) PT64_INDEX(addr, level)
 	#define PT_LEVEL_MASK(level) PT64_LEVEL_MASK(level)
 	#define PT_PTE_COPY_MASK PT64_PTE_COPY_MASK
+	#ifdef CONFIG_X86_64
+	#define PT_MAX_FULL_LEVELS 4
+	#else
+	#define PT_MAX_FULL_LEVELS 2
+	#endif
 #elif PTTYPE == 32
 	#define pt_element_t u32
 	#define guest_walker guest_walker32
@@ -42,6 +47,7 @@
 	#define SHADOW_PT_INDEX(addr, level) PT64_INDEX(addr, level)
 	#define PT_LEVEL_MASK(level) PT32_LEVEL_MASK(level)
 	#define PT_PTE_COPY_MASK PT32_PTE_COPY_MASK
+	#define PT_MAX_FULL_LEVELS 2
 #else
 	#error Invalid PTTYPE value
 #endif
@@ -52,7 +58,7 @@
  */
 struct guest_walker {
 	int level;
-	gfn_t table_gfn;
+	gfn_t table_gfn[PT_MAX_FULL_LEVELS];
 	pt_element_t *table;
 	pt_element_t *ptep;
 	pt_element_t inherited_ar;
@@ -68,7 +74,9 @@ static void FNAME(walk_addr)(struct gues
 	struct kvm_memory_slot *slot;
 	pt_element_t *ptep;
 	pt_element_t root;
+	gfn_t table_gfn;
 
+	pgprintk("%s: addr %lx\n", __FUNCTION__, addr);
 	walker->level = vcpu->mmu.root_level;
 	walker->table = NULL;
 	root = vcpu->cr3;
@@ -81,8 +89,11 @@ static void FNAME(walk_addr)(struct gues
 		--walker->level;
 	}
 #endif
-	walker->table_gfn = (root & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
-	slot = gfn_to_memslot(vcpu->kvm, walker->table_gfn);
+	table_gfn = (root & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
+	walker->table_gfn[walker->level - 1] = table_gfn;
+	pgprintk("%s: table_gfn[%d] %lx\n", __FUNCTION__,
+		 walker->level - 1, table_gfn);
+	slot = gfn_to_memslot(vcpu->kvm, table_gfn);
 	hpa = safe_gpa_to_hpa(vcpu, root & PT64_BASE_ADDR_MASK);
 	walker->table = kmap_atomic(pfn_to_page(hpa >> PAGE_SHIFT), KM_USER0);
 
@@ -111,12 +122,15 @@ static void FNAME(walk_addr)(struct gues
 
 		if (walker->level != 3 || is_long_mode(vcpu))
 			walker->inherited_ar &= walker->table[index];
-		walker->table_gfn = (*ptep & PT_BASE_ADDR_MASK) >> PAGE_SHIFT;
+		table_gfn = (*ptep & PT_BASE_ADDR_MASK) >> PAGE_SHIFT;
 		paddr = safe_gpa_to_hpa(vcpu, *ptep & PT_BASE_ADDR_MASK);
 		kunmap_atomic(walker->table, KM_USER0);
 		walker->table = kmap_atomic(pfn_to_page(paddr >> PAGE_SHIFT),
 					    KM_USER0);
 		--walker->level;
+		walker->table_gfn[walker->level - 1 ] = table_gfn;
+		pgprintk("%s: table_gfn[%d] %lx\n", __FUNCTION__,
+			 walker->level - 1, table_gfn);
 	}
 	walker->ptep = ptep;
 }
@@ -181,6 +195,8 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 		u64 *shadow_ent = ((u64 *)__va(shadow_addr)) + index;
 		struct kvm_mmu_page *shadow_page;
 		u64 shadow_pte;
+		int metaphysical;
+		gfn_t table_gfn;
 
 		if (is_present_pte(*shadow_ent) || is_io_pte(*shadow_ent)) {
 			if (level == PT_PAGE_TABLE_LEVEL)
@@ -205,7 +221,17 @@ static u64 *FNAME(fetch)(struct kvm_vcpu
 			return shadow_ent;
 		}
 
-		shadow_page = kvm_mmu_alloc_page(vcpu, shadow_ent);
+		if (level - 1 == PT_PAGE_TABLE_LEVEL
+		    && walker->level == PT_DIRECTORY_LEVEL) {
+			metaphysical = 1;
+			table_gfn = (*guest_ent & PT_BASE_ADDR_MASK)
+				>> PAGE_SHIFT;
+		} else {
+			metaphysical = 0;
+			table_gfn = walker->table_gfn[level - 2];
+		}
+		shadow_page = kvm_mmu_get_page(vcpu, table_gfn, addr, level-1,
+					       metaphysical, shadow_ent);
 		if (!shadow_page)
 			return ERR_PTR(-ENOMEM);
 		shadow_addr = shadow_page->page_hpa;
@@ -227,7 +253,8 @@ static int FNAME(fix_write_pf)(struct kv
 			       u64 *shadow_ent,
 			       struct guest_walker *walker,
 			       gva_t addr,
-			       int user)
+			       int user,
+			       int *write_pt)
 {
 	pt_element_t *guest_ent;
 	int writable_shadow;
@@ -264,6 +291,12 @@ static int FNAME(fix_write_pf)(struct kv
 	}
 
 	gfn = (*guest_ent & PT64_BASE_ADDR_MASK) >> PAGE_SHIFT;
+	if (kvm_mmu_lookup_page(vcpu, gfn)) {
+		pgprintk("%s: found shadow page for %lx, marking ro\n",
+			 __FUNCTION__, gfn);
+		*write_pt = 1;
+		return 0;
+	}
 	mark_page_dirty(vcpu->kvm, gfn);
 	*shadow_ent |= PT_WRITABLE_MASK;
 	*guest_ent |= PT_DIRTY_MASK;
@@ -294,7 +327,9 @@ static int FNAME(page_fault)(struct kvm_
 	struct guest_walker walker;
 	u64 *shadow_pte;
 	int fixed;
+	int write_pt = 0;
 
+	pgprintk("%s: addr %lx err %x\n", __FUNCTION__, addr, error_code);
 	/*
 	 * Look up the shadow pte for the faulting address.
 	 */
@@ -302,6 +337,7 @@ static int FNAME(page_fault)(struct kvm_
 		FNAME(walk_addr)(&walker, vcpu, addr);
 		shadow_pte = FNAME(fetch)(vcpu, addr, &walker);
 		if (IS_ERR(shadow_pte)) {  /* must be -ENOMEM */
+			printk("%s: oom\n", __FUNCTION__);
 			nonpaging_flush(vcpu);
 			FNAME(release_walker)(&walker);
 			continue;
@@ -313,20 +349,27 @@ static int FNAME(page_fault)(struct kvm_
 	 * The page is not mapped by the guest.  Let the guest handle it.
 	 */
 	if (!shadow_pte) {
+		pgprintk("%s: not mapped\n", __FUNCTION__);
 		inject_page_fault(vcpu, addr, error_code);
 		FNAME(release_walker)(&walker);
 		return 0;
 	}
 
+	pgprintk("%s: shadow pte %p %llx\n", __FUNCTION__,
+		 shadow_pte, *shadow_pte);
+
 	/*
 	 * Update the shadow pte.
 	 */
 	if (write_fault)
 		fixed = FNAME(fix_write_pf)(vcpu, shadow_pte, &walker, addr,
-					    user_fault);
+					    user_fault, &write_pt);
 	else
 		fixed = fix_read_pf(shadow_pte);
 
+	pgprintk("%s: updated shadow pte %p %llx\n", __FUNCTION__,
+		 shadow_pte, *shadow_pte);
+
 	FNAME(release_walker)(&walker);
 
 	/*
@@ -344,14 +387,14 @@ static int FNAME(page_fault)(struct kvm_
 	/*
 	 * pte not present, guest page fault.
 	 */
-	if (pte_present && !fixed) {
+	if (pte_present && !fixed && !write_pt) {
 		inject_page_fault(vcpu, addr, error_code);
 		return 0;
 	}
 
 	++kvm_stat.pf_fixed;
 
-	return 0;
+	return write_pt;
 }
 
 static gpa_t FNAME(gva_to_gpa)(struct kvm_vcpu *vcpu, gva_t vaddr)
@@ -395,3 +438,4 @@ static gpa_t FNAME(gva_to_gpa)(struct kv
 #undef PT_PTE_COPY_MASK
 #undef PT_NON_PTE_COPY_MASK
 #undef PT_DIR_BASE_ADDR_MASK
+#undef PT_MAX_FULL_LEVELS
