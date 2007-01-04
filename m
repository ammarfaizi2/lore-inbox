Return-Path: <linux-kernel-owner+w=401wt.eu-S965027AbXADQWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbXADQWM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 11:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbXADQWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 11:22:12 -0500
Received: from il.qumranet.com ([62.219.232.206]:55845 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965034AbXADQWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 11:22:10 -0500
Subject: [PATCH 33/33] KVM: MMU: add audit code to check mappings,
	etc are correct
From: Avi Kivity <avi@qumranet.com>
Date: Thu, 04 Jan 2007 16:22:07 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <459D21DD.5090506@qumranet.com>
In-Reply-To: <459D21DD.5090506@qumranet.com>
Message-Id: <20070104162207.CA48D250048@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/drivers/kvm/mmu.c
===================================================================
--- linux-2.6.orig/drivers/kvm/mmu.c
+++ linux-2.6/drivers/kvm/mmu.c
@@ -26,8 +26,31 @@
 #include "vmx.h"
 #include "kvm.h"
 
-#define pgprintk(x...) do { printk(x); } while (0)
-#define rmap_printk(x...) do { printk(x); } while (0)
+#undef MMU_DEBUG
+
+#undef AUDIT
+
+#ifdef AUDIT
+static void kvm_mmu_audit(struct kvm_vcpu *vcpu, const char *msg);
+#else
+static void kvm_mmu_audit(struct kvm_vcpu *vcpu, const char *msg) {}
+#endif
+
+#ifdef MMU_DEBUG
+
+#define pgprintk(x...) do { if (dbg) printk(x); } while (0)
+#define rmap_printk(x...) do { if (dbg) printk(x); } while (0)
+
+#else
+
+#define pgprintk(x...) do { } while (0)
+#define rmap_printk(x...) do { } while (0)
+
+#endif
+
+#if defined(MMU_DEBUG) || defined(AUDIT)
+static int dbg = 1;
+#endif
 
 #define ASSERT(x)							\
 	if (!(x)) {							\
@@ -1271,3 +1294,163 @@ void kvm_mmu_slot_remove_write_access(st
 			}
 	}
 }
+
+#ifdef AUDIT
+
+static const char *audit_msg;
+
+static gva_t canonicalize(gva_t gva)
+{
+#ifdef CONFIG_X86_64
+	gva = (long long)(gva << 16) >> 16;
+#endif
+	return gva;
+}
+
+static void audit_mappings_page(struct kvm_vcpu *vcpu, u64 page_pte,
+				gva_t va, int level)
+{
+	u64 *pt = __va(page_pte & PT64_BASE_ADDR_MASK);
+	int i;
+	gva_t va_delta = 1ul << (PAGE_SHIFT + 9 * (level - 1));
+
+	for (i = 0; i < PT64_ENT_PER_PAGE; ++i, va += va_delta) {
+		u64 ent = pt[i];
+
+		if (!ent & PT_PRESENT_MASK)
+			continue;
+
+		va = canonicalize(va);
+		if (level > 1)
+			audit_mappings_page(vcpu, ent, va, level - 1);
+		else {
+			gpa_t gpa = vcpu->mmu.gva_to_gpa(vcpu, va);
+			hpa_t hpa = gpa_to_hpa(vcpu, gpa);
+
+			if ((ent & PT_PRESENT_MASK)
+			    && (ent & PT64_BASE_ADDR_MASK) != hpa)
+				printk(KERN_ERR "audit error: (%s) levels %d"
+				       " gva %lx gpa %llx hpa %llx ent %llx\n",
+				       audit_msg, vcpu->mmu.root_level,
+				       va, gpa, hpa, ent);
+		}
+	}
+}
+
+static void audit_mappings(struct kvm_vcpu *vcpu)
+{
+	int i;
+
+	if (vcpu->mmu.root_level == 4)
+		audit_mappings_page(vcpu, vcpu->mmu.root_hpa, 0, 4);
+	else
+		for (i = 0; i < 4; ++i)
+			if (vcpu->mmu.pae_root[i] & PT_PRESENT_MASK)
+				audit_mappings_page(vcpu,
+						    vcpu->mmu.pae_root[i],
+						    i << 30,
+						    2);
+}
+
+static int count_rmaps(struct kvm_vcpu *vcpu)
+{
+	int nmaps = 0;
+	int i, j, k;
+
+	for (i = 0; i < KVM_MEMORY_SLOTS; ++i) {
+		struct kvm_memory_slot *m = &vcpu->kvm->memslots[i];
+		struct kvm_rmap_desc *d;
+
+		for (j = 0; j < m->npages; ++j) {
+			struct page *page = m->phys_mem[j];
+
+			if (!page->private)
+				continue;
+			if (!(page->private & 1)) {
+				++nmaps;
+				continue;
+			}
+			d = (struct kvm_rmap_desc *)(page->private & ~1ul);
+			while (d) {
+				for (k = 0; k < RMAP_EXT; ++k)
+					if (d->shadow_ptes[k])
+						++nmaps;
+					else
+						break;
+				d = d->more;
+			}
+		}
+	}
+	return nmaps;
+}
+
+static int count_writable_mappings(struct kvm_vcpu *vcpu)
+{
+	int nmaps = 0;
+	struct kvm_mmu_page *page;
+	int i;
+
+	list_for_each_entry(page, &vcpu->kvm->active_mmu_pages, link) {
+		u64 *pt = __va(page->page_hpa);
+
+		if (page->role.level != PT_PAGE_TABLE_LEVEL)
+			continue;
+
+		for (i = 0; i < PT64_ENT_PER_PAGE; ++i) {
+			u64 ent = pt[i];
+
+			if (!(ent & PT_PRESENT_MASK))
+				continue;
+			if (!(ent & PT_WRITABLE_MASK))
+				continue;
+			++nmaps;
+		}
+	}
+	return nmaps;
+}
+
+static void audit_rmap(struct kvm_vcpu *vcpu)
+{
+	int n_rmap = count_rmaps(vcpu);
+	int n_actual = count_writable_mappings(vcpu);
+
+	if (n_rmap != n_actual)
+		printk(KERN_ERR "%s: (%s) rmap %d actual %d\n",
+		       __FUNCTION__, audit_msg, n_rmap, n_actual);
+}
+
+static void audit_write_protection(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mmu_page *page;
+
+	list_for_each_entry(page, &vcpu->kvm->active_mmu_pages, link) {
+		hfn_t hfn;
+		struct page *pg;
+
+		if (page->role.metaphysical)
+			continue;
+
+		hfn = gpa_to_hpa(vcpu, (gpa_t)page->gfn << PAGE_SHIFT)
+			>> PAGE_SHIFT;
+		pg = pfn_to_page(hfn);
+		if (pg->private)
+			printk(KERN_ERR "%s: (%s) shadow page has writable"
+			       " mappings: gfn %lx role %x\n",
+			       __FUNCTION__, audit_msg, page->gfn,
+			       page->role.word);
+	}
+}
+
+static void kvm_mmu_audit(struct kvm_vcpu *vcpu, const char *msg)
+{
+	int olddbg = dbg;
+
+	dbg = 0;
+	audit_msg = msg;
+	audit_rmap(vcpu);
+	audit_write_protection(vcpu);
+	audit_mappings(vcpu);
+	dbg = olddbg;
+}
+
+#endif
Index: linux-2.6/drivers/kvm/paging_tmpl.h
===================================================================
--- linux-2.6.orig/drivers/kvm/paging_tmpl.h
+++ linux-2.6/drivers/kvm/paging_tmpl.h
@@ -355,6 +355,7 @@ static int FNAME(page_fault)(struct kvm_
 	int r;
 
 	pgprintk("%s: addr %lx err %x\n", __FUNCTION__, addr, error_code);
+	kvm_mmu_audit(vcpu, "pre page fault");
 
 	r = mmu_topup_memory_caches(vcpu);
 	if (r)
@@ -402,6 +403,7 @@ static int FNAME(page_fault)(struct kvm_
 		pgprintk("%s: io work, no access\n", __FUNCTION__);
 		inject_page_fault(vcpu, addr,
 				  error_code | PFERR_PRESENT_MASK);
+		kvm_mmu_audit(vcpu, "post page fault (io)");
 		return 0;
 	}
 
@@ -410,10 +412,12 @@ static int FNAME(page_fault)(struct kvm_
 	 */
 	if (pte_present && !fixed && !write_pt) {
 		inject_page_fault(vcpu, addr, error_code);
+		kvm_mmu_audit(vcpu, "post page fault (guest)");
 		return 0;
 	}
 
 	++kvm_stat.pf_fixed;
+	kvm_mmu_audit(vcpu, "post page fault (fixed)");
 
 	return write_pt;
 }
