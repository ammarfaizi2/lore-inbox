Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264132AbUDGHpw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 03:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264134AbUDGHpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 03:45:52 -0400
Received: from ozlabs.org ([203.10.76.45]:49612 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264132AbUDGHpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 03:45:41 -0400
Date: Wed, 7 Apr 2004 17:42:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linuxppc64-dev@lists.linuxppc.org
Subject: RFC: COW for hugepages
Message-ID: <20040407074239.GG18264@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the kernel does not implement copy-on-write for huge pages -
in fact any sort of page fault on a hugepage results in a SIGBUS.
This means that hugepages *always* have MAP_SHARED semantics, even if
MAP_PRIVATE is requested, and in particular that they are always
shared across a fork().  Particularly when using hugetlbfs as just a
source of quasi-anonymous memory, those are rather strange semantics.

So, the patch below adds COW support for hugepages.  It has all the
necessary generic code changes and the arch-specific code for PPC64
(because that's what I have to hand to test on).  Other architectures
will just get SIGBUS on any hugepage fault, as before.

This does introduce an inconsistency into hugepage semantics, in that
the initial hugepage mapping is always prefaulted (so you know at
mmap() time whether or not you were able to get enough hugepage
memory), whereas after a fork(), or on a MAP_PRIVATE mapping its
possible to get a SIGBUS if a COW fails due to a lack of hugepages.
The inconsistency is odd, but I think it's actually the best semantics
we can get simply, because:

- We want to prefault and fail early normal hugepage mappings, because
the normal use will be some big program grabbing a huge pile at
startup.  We'd rather it just fails to get the mapping if there aren't
enough hugepages, so it can request a smaller amount or die
gracefully, rather than getting 3/4 of the way through its big number
crunching job (say), then falling over with a SIGBUS.

- We don't want to prefault pages on fork(), because of the (probably
common) case of some big hugepage-using program calling a little shell
function with system.  If we copy all the hugepages on fork(), a) it
will be very slow and b) it could fail if there aren't enough
hugepages, although the child is actually just about to exec() and
won't need any of them.

Doing the COW for hugepages turns out not to be terribly difficult.
Is there any reason not to apply this patch?

Index: working-2.6/arch/ppc64/mm/hugetlbpage.c
===================================================================
--- working-2.6.orig/arch/ppc64/mm/hugetlbpage.c	2004-04-07 13:49:56.000000000 +1000
+++ working-2.6/arch/ppc64/mm/hugetlbpage.c	2004-04-07 15:12:01.546762168 +1000
@@ -117,6 +117,16 @@
 #define hugepte_page(x)	pfn_to_page(hugepte_pfn(x))
 #define hugepte_none(x)	(!(hugepte_val(x) & _HUGEPAGE_PFN))
 
+#define hugepte_write(x) (hugepte_val(x) & _HUGEPAGE_RW)
+#define hugepte_same(A,B) \
+	(((hugepte_val(A) ^ hugepte_val(B)) & ~_HUGEPAGE_HPTEFLAGS) == 0)
+
+static inline hugepte_t hugepte_mkwrite(hugepte_t pte)
+{
+	hugepte_val(pte) |= _HUGEPAGE_RW;
+	return pte;
+}
+
 
 static void free_huge_page(struct page *page);
 static void flush_hash_hugepage(mm_context_t context, unsigned long ea,
@@ -324,6 +334,16 @@
 	struct page *ptepage;
 	unsigned long addr = vma->vm_start;
 	unsigned long end = vma->vm_end;
+	cpumask_t tmp;
+	int cow;
+	int local;
+
+	/* XXX are there races with checking cpu_vm_mask? - Anton */
+	tmp = cpumask_of_cpu(smp_processor_id());
+	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
+		local = 1;
+
+	cow = (vma->vm_flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
 
 	while (addr < end) {
 		BUG_ON(! in_hugepage_area(src->context, addr));
@@ -334,6 +354,17 @@
 			return -ENOMEM;
 
 		src_pte = hugepte_offset(src, addr);
+
+		if (cow) {
+			entry = __hugepte(hugepte_update(src_pte, 
+							 _HUGEPAGE_RW
+							 | _HUGEPAGE_HPTEFLAGS,
+							 0));
+			if ((addr % HPAGE_SIZE) == 0)
+				flush_hash_hugepage(src->context, addr,
+						    entry, local);
+		}
+
 		entry = *src_pte;
 		
 		if ((addr % HPAGE_SIZE) == 0) {
@@ -507,12 +538,16 @@
 	struct mm_struct *mm = current->mm;
 	unsigned long addr;
 	int ret = 0;
+	int writable;
 
 	WARN_ON(!is_vm_hugetlb_page(vma));
 	BUG_ON((vma->vm_start % HPAGE_SIZE) != 0);
 	BUG_ON((vma->vm_end % HPAGE_SIZE) != 0);
 
 	spin_lock(&mm->page_table_lock);
+
+	writable = (vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_SHARED);
+
 	for (addr = vma->vm_start; addr < vma->vm_end; addr += HPAGE_SIZE) {
 		unsigned long idx;
 		hugepte_t *pte = hugepte_alloc(mm, addr);
@@ -542,15 +577,25 @@
 				ret = -ENOMEM;
 				goto out;
 			}
-			ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
-			unlock_page(page);
+			/* This is a new page, all full of zeroes.  If
+			 * we're MAP_SHARED, the page needs to go into
+			 * the page cache.  If it's MAP_PRIVATE it
+			 * might as well be made "anonymous" now or
+			 * we'll just have to copy it on the first
+			 * write. */
+			if (vma->vm_flags & VM_SHARED) {
+				ret = add_to_page_cache(page, mapping, idx, GFP_ATOMIC);
+				unlock_page(page);
+			} else {
+				writable = (vma->vm_flags & VM_WRITE);
+			}
 			if (ret) {
 				hugetlb_put_quota(mapping);
 				free_huge_page(page);
 				goto out;
 			}
 		}
-		setup_huge_pte(mm, page, pte, vma->vm_flags & VM_WRITE);
+		setup_huge_pte(mm, page, pte, writable);
 	}
 out:
 	spin_unlock(&mm->page_table_lock);
@@ -701,7 +746,7 @@
 	 * prevented then send the problem up to do_page_fault.
 	 */
 	is_write = access & _PAGE_RW;
-	if (unlikely(is_write && !(hugepte_val(*ptep) & _HUGEPAGE_RW)))
+	if (unlikely(is_write && !hugepte_write(*ptep)))
 		return 1;
 
 	/*
@@ -944,6 +989,121 @@
 }
 EXPORT_SYMBOL(hugetlb_total_pages);
 
+static int hugepage_cow(struct mm_struct *mm, struct vm_area_struct *vma,
+			unsigned long address, hugepte_t *ptep, hugepte_t pte)
+{
+	struct page *old_page, *new_page;
+	int i;
+	cpumask_t tmp;
+	int local;
+
+	BUG_ON(!pfn_valid(hugepte_pfn(*ptep)));
+
+	old_page = hugepte_page(*ptep);
+
+	/* XXX are there races with checking cpu_vm_mask? - Anton */
+	tmp = cpumask_of_cpu(smp_processor_id());
+	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
+		local = 1;
+
+	/* If no-one else is actually using this page, avoid the copy
+	 * and just make the page writable */
+	if (!TestSetPageLocked(old_page)) {
+		int avoidcopy = (page_count(old_page) == 1);
+		unlock_page(old_page);
+		if (avoidcopy) {
+			for (i = 0; i < HUGEPTE_BATCH_SIZE; i++)
+				set_hugepte(ptep+i, hugepte_mkwrite(pte));
+			
+
+			pte = __hugepte(hugepte_update(ptep, _HUGEPAGE_HPTEFLAGS, 0));
+			if (hugepte_val(pte) & _HUGEPAGE_HASHPTE)
+				flush_hash_hugepage(mm->context, address,
+						    pte, local);
+			spin_unlock(&mm->page_table_lock);
+			return VM_FAULT_MINOR;
+		}
+	}
+
+	page_cache_get(old_page);
+
+	spin_unlock(&mm->page_table_lock);
+
+	new_page = alloc_hugetlb_page();
+	if (! new_page) {
+		page_cache_release(old_page);
+
+		/* Logically this is OOM, not a SIGBUS, but an OOM
+		 * could cause the kernel to go killing other
+		 * processes which won't help the hugepage situation
+		 * at all (?) */
+		return VM_FAULT_SIGBUS;
+	}
+
+	for (i = 0; i < HPAGE_SIZE/PAGE_SIZE; i++)
+		copy_user_highpage(new_page + i, old_page + i, address + i*PAGE_SIZE);
+
+	spin_lock(&mm->page_table_lock);
+
+	/* XXX are there races with checking cpu_vm_mask? - Anton */
+	tmp = cpumask_of_cpu(smp_processor_id());
+	if (cpus_equal(vma->vm_mm->cpu_vm_mask, tmp))
+		local = 1;
+
+	ptep = hugepte_offset(mm, address);
+	if (hugepte_same(*ptep, pte)) {
+		/* Break COW */
+		for (i = 0; i < HUGEPTE_BATCH_SIZE; i++)
+			hugepte_update(ptep, ~0,
+				       hugepte_val(mk_hugepte(new_page, 1)));
+
+		if (hugepte_val(pte) & _HUGEPAGE_HASHPTE)
+			flush_hash_hugepage(mm->context, address,
+					    pte, local);
+
+		/* Make the old page be freed below */
+		new_page = old_page;
+	}
+	page_cache_release(new_page);
+	page_cache_release(old_page);
+	spin_unlock(&mm->page_table_lock);
+	return VM_FAULT_MINOR;
+}
+
+int handle_hugetlb_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+			    unsigned long address, int write_access)
+{
+	hugepte_t *ptep;
+	int rc = VM_FAULT_SIGBUS;
+
+	spin_lock(&mm->page_table_lock);
+
+	ptep = hugepte_offset(mm, address & HPAGE_MASK);
+
+	if ( (! ptep) || hugepte_none(*ptep))
+		goto fail;
+
+	/* Otherwise, there ought to be a real hugepte here */
+	BUG_ON(hugepte_bad(*ptep));
+
+	rc = VM_FAULT_MINOR;
+
+	if (! (write_access && !hugepte_write(*ptep))) {
+		printk(KERN_WARNING "Unexpected hugepte fault (wr=%d hugepte=%08x\n",
+		     write_access, hugepte_val(*ptep));
+		goto fail;
+	}
+		
+	/* The only faults we should actually get are COWs */
+	/* this drops the page_table_lock */
+	return hugepage_cow(mm, vma, address, ptep, *ptep); 
+	
+ fail:
+	spin_unlock(&mm->page_table_lock);
+
+	return rc;
+}
+
 /*
  * We cannot handle pagefaults against hugetlb pages at all.  They cause
  * handle_mm_fault() to try to instantiate regular-sized pages in the
Index: working-2.6/include/asm-ppc64/page.h
===================================================================
--- working-2.6.orig/include/asm-ppc64/page.h	2004-04-06 11:32:00.000000000 +1000
+++ working-2.6/include/asm-ppc64/page.h	2004-04-07 15:12:01.548761864 +1000
@@ -55,6 +55,7 @@
 	  && touches_hugepage_low_range((addr), (len))))
 #define hugetlb_free_pgtables free_pgtables
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#define ARCH_HANDLES_HUGEPAGE_FAULTS
 
 #define in_hugepage_area(context, addr) \
 	((cur_cpu_spec->cpu_features & CPU_FTR_16M_PAGE) && \
Index: working-2.6/include/linux/hugetlb.h
===================================================================
--- working-2.6.orig/include/linux/hugetlb.h	2004-04-05 14:04:37.000000000 +1000
+++ working-2.6/include/linux/hugetlb.h	2004-04-07 15:12:01.557760496 +1000
@@ -50,6 +50,13 @@
 int prepare_hugepage_range(unsigned long addr, unsigned long len);
 #endif
 
+#ifndef ARCH_HANDLES_HUGEPAGE_FAULTS
+#define handle_hugetlb_mm_fault(mm, vma, a, w)	(VM_FAULT_SIGBUS)
+#else
+int handle_hugetlb_mm_fault(struct mm_struct *mm, struct vm_area_struct * vma,
+			    unsigned long address, int write_access);
+#endif
+
 #else /* !CONFIG_HUGETLB_PAGE */
 
 static inline int is_vm_hugetlb_page(struct vm_area_struct *vma)
Index: working-2.6/mm/memory.c
===================================================================
--- working-2.6.orig/mm/memory.c	2004-03-16 11:31:35.000000000 +1100
+++ working-2.6/mm/memory.c	2004-04-07 15:12:01.562759736 +1000
@@ -1619,7 +1619,8 @@
 	inc_page_state(pgfault);
 
 	if (is_vm_hugetlb_page(vma))
-		return VM_FAULT_SIGBUS;	/* mapping truncation does this. */
+		/* mapping truncation can do this. */
+		return handle_hugetlb_mm_fault(mm, vma, address, write_access);
 
 	/*
 	 * We need the page table lock to synchronize with kswapd



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
