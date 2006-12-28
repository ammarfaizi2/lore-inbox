Return-Path: <linux-kernel-owner+w=401wt.eu-S1753739AbWL1VY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbWL1VY5 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 16:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754987AbWL1VY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 16:24:57 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33340 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbWL1VY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 16:24:56 -0500
Date: Thu, 28 Dec 2006 13:24:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc Haber <mh+linux-kernel@zugschlus.de>
cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612281318480.4473@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost> <20061217154026.219b294f.akpm@osdl.org>
 <Pine.LNX.4.64.0612171716510.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171725110.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612171744360.3479@woody.osdl.org> <45861E68.3060403@yahoo.com.au>
 <20061217214308.62b9021a.akpm@osdl.org> <20061219085149.GA20442@torres.l21.ma.zugschlus.de>
 <20061228180536.GB7385@torres.zugschlus.de> <Pine.LNX.4.64.0612281014190.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Dec 2006, Linus Torvalds wrote:
> 
> What we need now is actually looking at the source code, and people who 
> understand the VM, I'm afraid. I'm gathering traces now that I have a good 
> test-case. I'll post my trace tools once I've tested that they work, in 
> case others want to help.

Ok, I've got the traces, but quite frankly, I doubt anybody is crazy 
enough to want to trawl through them. It's a bit painful, since we're 
talking thousands of pages to trigger this problem.

Also, I've used the PG_arch_1 flag, which is fine on x86[-64] and probably 
ARM, but is used for other things on ia64, powerpc and sparc64. But here's 
the patch in case anybody cares.

It wants a _big_ kernel buffer to capture all the crud into (which is why 
I made the thing accept a bigger log buffer), and quite frankly, I'm not 
at all sure that all the locking is ok (ie I could imagine that the 
dcache-locking thing there in "is_interesting()" could deadlock, what do I 
know..)

But I've captured some real data with this, which I'll describe 
separately.

		Linus

----
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 350878a..967dd80 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -91,6 +91,8 @@
 #define PG_nosave_free		18	/* Used for system suspend/resume */
 #define PG_buddy		19	/* Page is free, on buddy lists */
 
+#define SetPageInteresting(page) set_bit(PG_arch_1, &(page)->flags)
+#define PageInteresting(page)	test_bit(PG_arch_1, &(page)->flags)
 
 #if (BITS_PER_LONG > 32)
 /*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 5c26818..7735b83 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -79,7 +79,7 @@ config DEBUG_KERNEL
 
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
-	range 12 21
+	range 12 24
 	default 17 if S390 || LOCKDEP
 	default 16 if X86_NUMAQ || IA64
 	default 15 if SMP
diff --git a/mm/filemap.c b/mm/filemap.c
index 8332c77..d6a0f56 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -116,6 +116,7 @@ void __remove_from_page_cache(struct page *page)
 {
 	struct address_space *mapping = page->mapping;
 
+if (PageInteresting(page)) printk("Removing index %08x from page cache\n", page->index);
 	radix_tree_delete(&mapping->page_tree, page->index);
 	page->mapping = NULL;
 	mapping->nrpages--;
@@ -421,6 +422,23 @@ int filemap_write_and_wait_range(struct address_space *mapping,
 	return err;
 }
 
+static noinline int is_interesting(struct address_space *mapping)
+{
+	struct inode *inode = mapping->host;
+	struct dentry *dentry;
+	int retval = 0;
+
+	spin_lock(&dcache_lock);
+	list_for_each_entry(dentry, &inode->i_dentry, d_alias) {
+		if (strcmp(dentry->d_name.name, "mapfile"))
+			continue;
+		retval = 1;
+		break;
+	}
+	spin_unlock(&dcache_lock);
+	return retval;
+}
+
 /**
  * add_to_page_cache - add newly allocated pagecache pages
  * @page:	page to add
@@ -439,6 +457,9 @@ int add_to_page_cache(struct page *page, struct address_space *mapping,
 {
 	int error = radix_tree_preload(gfp_mask & ~__GFP_HIGHMEM);
 
+	if (is_interesting(mapping))
+		SetPageInteresting(page);
+
 	if (error == 0) {
 		write_lock_irq(&mapping->tree_lock);
 		error = radix_tree_insert(&mapping->page_tree, offset, page);
diff --git a/mm/memory.c b/mm/memory.c
index 563792f..14c9815 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -667,6 +667,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			tlb_remove_tlb_entry(tlb, pte, addr);
 			if (unlikely(!page))
 				continue;
+if (PageInteresting(page))
+	printk("Unmapped index %08x at %08x\n", page->index, addr);
 			if (unlikely(details) && details->nonlinear_vma
 			    && linear_page_index(details->nonlinear_vma,
 						addr) != page->index)
@@ -1605,6 +1607,7 @@ gotten:
 		 */
 		ptep_clear_flush(vma, address, page_table);
 		set_pte_at(mm, address, page_table, entry);
+if (PageInteresting(new_page)) printk("do_wp_page: mapping index %08x at %08lx\n", new_page->index, address);
 		update_mmu_cache(vma, address, entry);
 		lru_cache_add_active(new_page);
 		page_add_new_anon_rmap(new_page, vma, address);
@@ -2249,6 +2252,7 @@ retry:
 		entry = mk_pte(new_page, vma->vm_page_prot);
 		if (write_access)
 			entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+if (PageInteresting(new_page)) printk("do_no_page: mapping index %08x at %08lx (%s)\n", new_page->index, address, write_access ? "write" : "read");
 		set_pte_at(mm, address, page_table, entry);
 		if (anon) {
 			inc_mm_counter(mm, anon_rss);
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b3a198c..0466601 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -813,6 +813,7 @@ int fastcall set_page_dirty(struct page *page)
 		if (!spd)
 			spd = __set_page_dirty_buffers;
 #endif
+if (PageInteresting(page)) printk("Setting page %08x dirty\n", page->index);
 		return (*spd)(page);
 	}
 	if (!PageDirty(page)) {
@@ -867,6 +868,7 @@ int clear_page_dirty_for_io(struct page *page)
 
 	if (TestClearPageDirty(page)) {
 		if (mapping_cap_account_dirty(mapping)) {
+if (PageInteresting(page)) printk("cpd_for_io: index %08x\n", page->index);
 			page_mkclean(page);
 			dec_zone_page_state(page, NR_FILE_DIRTY);
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 57306fa..e98e84c 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -448,6 +448,7 @@ static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
 	if (pte_dirty(*pte) || pte_write(*pte)) {
 		pte_t entry;
 
+if (PageInteresting(page)) printk("cleaning index %08x at %08x\n", page->index, address);
 		flush_cache_page(vma, address, pte_pfn(*pte));
 		entry = ptep_clear_flush(vma, address, pte);
 		entry = pte_wrprotect(entry);
@@ -637,6 +638,7 @@ static int try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		goto out_unmap;
 	}
 
+if (PageInteresting(page)) printk("unmapping index %08x from %08lx\n", page->index, address);
 	/* Nuke the page table entry. */
 	flush_cache_page(vma, address, page_to_pfn(page));
 	pteval = ptep_clear_flush(vma, address, pte);
@@ -767,6 +769,7 @@ static void try_to_unmap_cluster(unsigned long cursor,
 		if (ptep_clear_flush_young(vma, address, pte))
 			continue;
 
+if (PageInteresting(page)) printk("Cluster-unmapping %08x from %08lx\n", page->index, address);
 		/* Nuke the page table entry. */
 		flush_cache_page(vma, address, pte_pfn(*pte));
 		pteval = ptep_clear_flush(vma, address, pte);
