Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422970AbWHZRmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422970AbWHZRmp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 13:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422944AbWHZRmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 13:42:38 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:48765 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964813AbWHZRm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 13:42:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=1XZLgk0C3x7lwYvE2wnF2VesjmHVQOUAREGWvRPFRFuaDhyZ5jV1nTNRltPcSTuQ+1FsXCpUkSh4/FiNmirfn+719cd6JSzwh0ivpJEmbBvUXNeLd74VHN1N0z6yE6ivRahE+kc2KzxtMcmq+4ccTyO1HQFm4M0VzXezzFSe1b4=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH RFP-V4 04/13] RFP prot support: handle MANYPROTS VMAs
Date: Sat, 26 Aug 2006 19:42:20 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-Id: <20060826174220.14790.39620.stgit@memento.home.lan>
In-Reply-To: <200608261933.36574.blaisorblade@yahoo.it>
References: <200608261933.36574.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Handle the possible existance of VM_MANYPROTS vmas, without actually creating
them.

* Replace old uses of pgoff_to_pte with pgoff_prot_to_pte.
* Introduce the flag, use it to read permissions from the PTE rather than from
  the VMA flags.
* Replace the linear_page_index() check with save_nonlinear_pte(), which
  encapsulates the check.
2.6.14+ updates:
* Add VM_MANYPROTS among cases needing copying of PTE at fork time rather than
  faulting.
* check for VM_MANYPROTS in do_file_pte before complaining for pte_file PTE
* check for VM_MANYPROTS in *_populate, when we skip installing pte_file PTE's
  for linear areas

Below there is a long explaination of why I've added VM_MANYPROTS, rather
than simply overload VM_NONLINEAR. You can freely skip that if you have real
work to do :-).

However, this patch is only sufficient if VM_MANYPROTS vmas are also marked as
nonlinear. Otherwise also other changes are needed.

I've implemented both solutions - I've sent only full support for the easy case,
but possibly I'll afterwards reintroduce the other changes; in particular,
they're needed to make this useful for general usage beyond UML.

*) remap_file_pages protection support: add VM_MANYPROTS to fix existing usage of mprotect()

Distinguish between "normal" VMA and VMA with variable protection, by
adding the VM_MANYPROTS flag. This is needed for various reasons:

* notify the arch fault handlers that they must not check VMA protection for
  giving SIGSEGV
* fixing regression of mprotect() on !VM_MANYPROTS mappings (see below)
* (in next patches) giving a sensible behaviour to mprotect on VM_MANYPROTS
  mappings
* (TODO?) avoid regression in max file offset with r_f_p() for older mappings;
  we could use either the old offset encoding or the new offset-prot encoding
  depending on this flag.
  It's trivial to do, just I don't know whether existing apps will overflow
  the new limits. They go down from 2Tb to 1Tb on i386 and 512G on PPC, and
  from 256G to 128G on S390/31 bits. Give me a call in case.
* (TODO?) on MAP_PRIVATE mappings, especially when they are readonly, we can
  easily support VM_MANYPROTS. This has been explicitly requested by Ulrich
  Drepper for DSO handling - creating a PROT_NONE VMA for guard pages is bad.
  And that is worse when you have a binary with 100 DSO, or a program with
  really many threads - Ulrich profiled a workload where the RB-tree lookup
  function is a performance bottleneck.

In fact, without this flag, we'd have indeed a regression with
remap_file_pages VS mprotect, on uniform nonlinear VMAs.

mprotect alters the VMA prots and walks each present PTE, ignoring installed
ones, even when pte_file() is on; their saved prots will be restored on faults,
ignoring VMA ones and losing the mprotect() on them. So, in do_file_page(), we
must restore anyway VMA prots when the VMA is uniform, as we used to do before
this trail of patches.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 include/linux/mm.h      |    7 +++++++
 include/linux/pagemap.h |   22 ++++++++++++++++++++++
 mm/filemap.c            |    2 +-
 mm/fremap.c             |    8 ++++----
 mm/memory.c             |   21 +++++++++++++--------
 mm/rmap.c               |    3 +--
 mm/shmem.c              |    2 +-
 7 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f0b135c..66de7a7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -162,7 +162,14 @@ #define VM_RESERVED	0x00080000	/* Count 
 #define VM_ACCOUNT	0x00100000	/* Is a VM accounted object */
 #define VM_HUGETLB	0x00400000	/* Huge TLB Page VM */
 #define VM_NONLINEAR	0x00800000	/* Is non-linear (remap_file_pages) */
+
+#ifndef CONFIG_MMU
 #define VM_MAPPED_COPY	0x01000000	/* T if mapped copy of data (nommu mmap) */
+#else
+#define VM_MANYPROTS	0x01000000	/* The VM individual pages have
+					   different protections
+					   (remap_file_pages)*/
+#endif
 #define VM_INSERTPAGE	0x02000000	/* The vma has had "vm_insert_page()" done on it */
 
 #ifndef VM_STACK_DEFAULT_FLAGS		/* arch can override this */
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0a2f5d2..6f98602 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -129,6 +129,28 @@ static inline pgoff_t linear_page_index(
 	return pgoff >> (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 }
 
+/***
+ * Checks if the PTE is nonlinear, and if yes sets it.
+ * @vma: the VMA in which @addr is; we don't check if it's VM_NONLINEAR, just
+ * if this PTE is nonlinear.
+ * @addr: the addr which @pte refers to.
+ * @pte: the old PTE value (to read its protections.
+ * @ptep: the PTE pointer (for setting it).
+ * @mm: passed to set_pte_at.
+ * @page: the page which was installed (to read its ->index, i.e. the old
+ * offset inside the file.
+ */
+static inline void save_nonlinear_pte(pte_t pte, pte_t * ptep, struct
+		vm_area_struct *vma, struct mm_struct *mm, struct page* page,
+		unsigned long addr)
+{
+	pgprot_t pgprot = pte_to_pgprot(pte);
+	if (linear_page_index(vma, addr) != page->index ||
+		pgprot_val(pgprot) != pgprot_val(vma->vm_page_prot))
+		set_pte_at(mm, addr, ptep, pgoff_prot_to_pte(page->index,
+					pgprot));
+}
+
 extern void FASTCALL(__lock_page(struct page *page));
 extern void FASTCALL(unlock_page(struct page *page));
 
diff --git a/mm/filemap.c b/mm/filemap.c
index b9a60c4..ed4eb45 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1706,7 +1706,7 @@ repeat:
 			page_cache_release(page);
 			return err;
 		}
-	} else if (vma->vm_flags & VM_NONLINEAR) {
+	} else if (vma->vm_flags & (VM_NONLINEAR|VM_MANYPROTS)) {
 		/* No page was found just because we can't read it in now (being
 		 * here implies nonblock != 0), but the page may exist, so set
 		 * the PTE to fault it in later. */
diff --git a/mm/fremap.c b/mm/fremap.c
index cdeabad..f57cd6d 100644
--- a/mm/fremap.c
+++ b/mm/fremap.c
@@ -49,7 +49,7 @@ static int zap_pte(struct mm_struct *mm,
  * previously existing mapping.
  */
 int install_page(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, struct page *page, pgprot_t prot)
+		unsigned long addr, struct page *page, pgprot_t pgprot)
 {
 	struct inode *inode;
 	pgoff_t size;
@@ -79,7 +79,7 @@ int install_page(struct mm_struct *mm, s
 		inc_mm_counter(mm, file_rss);
 
 	flush_icache_page(vma, page);
-	set_pte_at(mm, addr, pte, mk_pte(page, prot));
+	set_pte_at(mm, addr, pte, mk_pte(page, pgprot));
 	page_add_file_rmap(page);
 	pte_val = *pte;
 	update_mmu_cache(vma, addr, pte_val);
@@ -97,7 +97,7 @@ EXPORT_SYMBOL(install_page);
  * previously existing mapping.
  */
 int install_file_pte(struct mm_struct *mm, struct vm_area_struct *vma,
-		unsigned long addr, unsigned long pgoff, pgprot_t prot)
+		unsigned long addr, unsigned long pgoff, pgprot_t pgprot)
 {
 	int err = -ENOMEM;
 	pte_t *pte;
@@ -113,7 +113,7 @@ int install_file_pte(struct mm_struct *m
 		dec_mm_counter(mm, file_rss);
 	}
 
-	set_pte_at(mm, addr, pte, pgoff_to_pte(pgoff));
+	set_pte_at(mm, addr, pte, pgoff_prot_to_pte(pgoff, pgprot));
 	pte_val = *pte;
 	/*
 	 * We don't need to run update_mmu_cache() here because the "file pte"
diff --git a/mm/memory.c b/mm/memory.c
index 109e986..a87526e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -594,7 +594,8 @@ int copy_page_range(struct mm_struct *ds
 	 * readonly mappings. The tradeoff is that copy_page_range is more
 	 * efficient than faulting.
 	 */
-	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_PFNMAP|VM_INSERTPAGE))) {
+	if (!(vma->vm_flags & (VM_HUGETLB|VM_NONLINEAR|VM_MANYPROTS|
+					VM_PFNMAP|VM_INSERTPAGE))) {
 		if (!vma->anon_vma)
 			return 0;
 	}
@@ -663,11 +664,11 @@ static unsigned long zap_pte_range(struc
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
-			if (unlikely(details) && details->nonlinear_vma
-			    && linear_page_index(details->nonlinear_vma,
-						addr) != page->index)
-				set_pte_at(mm, addr, pte,
-					   pgoff_to_pte(page->index));
+			if (unlikely(details) && details->nonlinear_vma) {
+				save_nonlinear_pte(ptent, pte,
+						details->nonlinear_vma,
+						mm, page, addr);
+			}
 			if (PageAnon(page))
 				anon_rss--;
 			else {
@@ -2224,12 +2225,13 @@ static int do_file_page(struct mm_struct
 		int write_access, pte_t orig_pte)
 {
 	pgoff_t pgoff;
+	pgprot_t pgprot;
 	int err;
 
 	if (!pte_unmap_same(mm, pmd, page_table, orig_pte))
 		return VM_FAULT_MINOR;
 
-	if (unlikely(!(vma->vm_flags & VM_NONLINEAR))) {
+	if (unlikely(!(vma->vm_flags & (VM_NONLINEAR|VM_MANYPROTS)))) {
 		/*
 		 * Page table corrupted: show pte and kill process.
 		 */
@@ -2239,8 +2241,11 @@ static int do_file_page(struct mm_struct
 	/* We can then assume vm->vm_ops && vma->vm_ops->populate */
 
 	pgoff = pte_to_pgoff(orig_pte);
+	pgprot = (vma->vm_flags & VM_MANYPROTS) ? pte_file_to_pgprot(orig_pte) :
+		vma->vm_page_prot;
+
 	err = vma->vm_ops->populate(vma, address & PAGE_MASK, PAGE_SIZE,
-					vma->vm_page_prot, pgoff, 0);
+					pgprot, pgoff, 0);
 	if (err == -ENOMEM)
 		return VM_FAULT_OOM;
 	if (err)
diff --git a/mm/rmap.c b/mm/rmap.c
index 40158b5..77e9ef1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -704,8 +704,7 @@ static void try_to_unmap_cluster(unsigne
 		pteval = ptep_clear_flush(vma, address, pte);
 
 		/* If nonlinear, store the file page offset in the pte. */
-		if (page->index != linear_page_index(vma, address))
-			set_pte_at(mm, address, pte, pgoff_to_pte(page->index));
+		save_nonlinear_pte(pteval, pte, vma, mm, page, address);
 
 		/* Move the dirty bit to the physical page now the pte is gone. */
 		if (pte_dirty(pteval))
diff --git a/mm/shmem.c b/mm/shmem.c
index db21c51..72e37d0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1265,7 +1265,7 @@ static int shmem_populate(struct vm_area
 				page_cache_release(page);
 				return err;
 			}
-		} else if (vma->vm_flags & VM_NONLINEAR) {
+		} else if (vma->vm_flags & (VM_NONLINEAR|VM_MANYPROTS)) {
 			/* No page was found just because we can't read it in
 			 * now (being here implies nonblock != 0), but the page
 			 * may exist, so set the PTE to fault it in later. */
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
