Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUDKOYT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 10:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUDKOYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 10:24:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:5927 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262351AbUDKOYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 10:24:13 -0400
Date: Sun, 11 Apr 2004 15:24:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: rmk@arm.linux.org.uk, <ralf@linux-mips.org>,
       <James.Bottomley@SteelEye.com>, <davem@redhat.com>, <gniibe@m17n.org>,
       <linux-kernel@vger.kernel.org>
Subject: [PATCH] rmap 4 flush_dcache revisited
Message-ID: <Pine.LNX.4.44.0404111520210.1923-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of another batch of three rmap patches: not the batch which will
change rmap around, just a set of fixes to issues which arose with the
first batch, scarcely related to rmap itself.  Based on 2.6.5-mc4, but
apply easily to 2.6.5-mm4 (except fault-armv.c, where -mm4 has a prior
fix in that area).

rmap 4 flush_dcache_page revisited

Sorry to follow up on the same files so soon, but I realized that this
arch code has long been slightly unsafe (if SMP or PREEMPT), silly not
to fix it while we're here.

One of the callers of flush_dcache_page is do_generic_mapping_read,
where file is read without i_sem and without page lock: concurrent
truncation may at any moment remove page from cache, NULLing ->mapping,
making flush_dcache_page liable to oops.  Put result of page_mapping in
a local variable and apply mapping_mapped to that (if we were to check
for NULL within mapping_mapped, it's unclear whether to say yes or no).

parisc and arm do have other locking unsafety in their i_mmap(_shared)
searching, but that's a larger issue to be dealt with down the line.

 arch/arm/mm/fault-armv.c        |   13 +++++++++----
 arch/mips/mm/cache.c            |    3 ++-
 arch/parisc/kernel/cache.c      |    7 ++++---
 arch/sparc64/mm/init.c          |    3 ++-
 include/asm-arm/cacheflush.h    |    4 +++-
 include/asm-parisc/cacheflush.h |    4 +++-
 include/asm-sh/pgalloc.h        |    7 +++----
 7 files changed, 26 insertions(+), 15 deletions(-)

--- 2.6.5-mc4/arch/arm/mm/fault-armv.c	2004-04-11 07:19:15.991662984 +0100
+++ rmap4/arch/arm/mm/fault-armv.c	2004-04-11 10:37:55.817550872 +0100
@@ -186,19 +186,20 @@ no_pmd:
 
 void __flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
 	struct list_head *l;
 
 	__cpuc_flush_dcache_page(page_address(page));
 
-	if (!page_mapping(page))
+	if (!mapping)
 		return;
 
 	/*
 	 * With a VIVT cache, we need to also write back
 	 * and invalidate any user data.
 	 */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
+	list_for_each(l, &mapping->i_mmap_shared) {
 		struct vm_area_struct *mpnt;
 		unsigned long off;
 
@@ -224,17 +225,21 @@ void __flush_dcache_page(struct page *pa
 static void
 make_coherent(struct vm_area_struct *vma, unsigned long addr, struct page *page, int dirty)
 {
-	struct list_head *l;
+	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = vma->vm_mm;
+	struct list_head *l;
 	unsigned long pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
 	int aliases = 0;
 
+	if (!mapping)
+		return;
+
 	/*
 	 * If we have any shared mappings that are in the same mm
 	 * space, then we need to handle them specially to maintain
 	 * cache coherency.
 	 */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
+	list_for_each(l, &mapping->i_mmap_shared) {
 		struct vm_area_struct *mpnt;
 		unsigned long off;
 
--- 2.6.5-mc4/arch/mips/mm/cache.c	2004-04-11 07:19:17.312462192 +0100
+++ rmap4/arch/mips/mm/cache.c	2004-04-11 10:37:55.818550720 +0100
@@ -55,9 +55,10 @@ asmlinkage int sys_cacheflush(void *addr
 
 void flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	unsigned long addr;
 
-	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
+	if (mapping && !mapping_mapped(mapping)) {
 		SetPageDcacheDirty(page);
 		return;
 	}
--- 2.6.5-mc4/arch/parisc/kernel/cache.c	2004-04-11 07:19:17.322460672 +0100
+++ rmap4/arch/parisc/kernel/cache.c	2004-04-11 10:37:55.819550568 +0100
@@ -229,16 +229,17 @@ void disable_sr_hashing(void)
 
 void __flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	struct mm_struct *mm = current->active_mm;
 	struct list_head *l;
 
 	flush_kernel_dcache_page(page_address(page));
 
-	if (!page_mapping(page))
+	if (!mapping)
 		return;
 	/* check shared list first if it's not empty...it's usually
 	 * the shortest */
-	list_for_each(l, &page->mapping->i_mmap_shared) {
+	list_for_each(l, &mapping->i_mmap_shared) {
 		struct vm_area_struct *mpnt;
 		unsigned long off;
 
@@ -267,7 +268,7 @@ void __flush_dcache_page(struct page *pa
 
 	/* then check private mapping list for read only shared mappings
 	 * which are flagged by VM_MAYSHARE */
-	list_for_each(l, &page->mapping->i_mmap) {
+	list_for_each(l, &mapping->i_mmap) {
 		struct vm_area_struct *mpnt;
 		unsigned long off;
 
--- 2.6.5-mc4/arch/sparc64/mm/init.c	2004-04-11 07:19:17.961363544 +0100
+++ rmap4/arch/sparc64/mm/init.c	2004-04-11 10:37:55.821550264 +0100
@@ -224,10 +224,11 @@ void update_mmu_cache(struct vm_area_str
 
 void flush_dcache_page(struct page *page)
 {
+	struct address_space *mapping = page_mapping(page);
 	int dirty = test_bit(PG_dcache_dirty, &page->flags);
 	int dirty_cpu = dcache_dirty_cpu(page);
 
-	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
+	if (mapping && !mapping_mapped(mapping)) {
 		if (dirty) {
 			if (dirty_cpu == smp_processor_id())
 				return;
--- 2.6.5-mc4/include/asm-arm/cacheflush.h	2004-04-11 07:19:22.378692008 +0100
+++ rmap4/include/asm-arm/cacheflush.h	2004-04-11 10:37:55.823549960 +0100
@@ -295,7 +295,9 @@ extern void __flush_dcache_page(struct p
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page_mapping(page) && !mapping_mapped(page->mapping))
+	struct address_space *mapping = page_mapping(page);
+
+	if (mapping && !mapping_mapped(mapping))
 		set_bit(PG_dcache_dirty, &page->flags);
 	else
 		__flush_dcache_page(page);
--- 2.6.5-mc4/include/asm-parisc/cacheflush.h	2004-04-11 07:19:22.804627256 +0100
+++ rmap4/include/asm-parisc/cacheflush.h	2004-04-11 10:37:55.823549960 +0100
@@ -69,7 +69,9 @@ extern void __flush_dcache_page(struct p
 
 static inline void flush_dcache_page(struct page *page)
 {
-	if (page_mapping(page) && !mapping_mapped(page->mapping)) {
+	struct address_space *mapping = page_mapping(page);
+
+	if (mapping && !mapping_mapped(mapping)) {
 		set_bit(PG_dcache_dirty, &page->flags);
 	} else {
 		__flush_dcache_page(page);
--- 2.6.5-mc4/include/asm-sh/pgalloc.h	2004-04-11 07:19:23.002597160 +0100
+++ rmap4/include/asm-sh/pgalloc.h	2004-04-11 10:37:55.824549808 +0100
@@ -97,12 +97,11 @@ static inline pte_t ptep_get_and_clear(p
 
 	pte_clear(ptep);
 	if (!pte_not_present(pte)) {
-		struct page *page;
 		unsigned long pfn = pte_pfn(pte);
 		if (pfn_valid(pfn)) {
-			page = pfn_to_page(pfn);
-			if (!page_mapping(page) ||
-			    !mapping_writably_mapped(page->mapping))
+			struct page *page = pfn_to_page(pfn);
+			struct address_space *mapping = page_mapping(page);
+			if (!mapping || !mapping_writably_mapped(mapping))
 				__clear_bit(PG_mapped, &page->flags);
 		}
 	}

