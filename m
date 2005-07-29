Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVG2POW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVG2POW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVG2POV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:14:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48137 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262616AbVG2PNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:13:47 -0400
Date: Fri, 29 Jul 2005 16:13:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.6.13-rc3: cache flush missing from somewhere
Message-ID: <20050729161343.A18249@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been trying for the last 4 or 5 days to get the kernel stable on
an ARM SMP platform.  This platform has harvard PIPT caches with no
aliasing issues inside the separate I/D caches, except for the lack
of snooping between the I and D cache.  The caches are in write allocate
mode.

This means we need to ensure that the I/D coherency is handled, and
we do this via flush_dcache_page().  We actually do this lazily using
the Sparc64 method, so __flush_dcache_page() actually does the cache
operations.

My current patch to get this working is below.  The only thing which
really seems to fix the issue is the __flush_dcache_page call in
read_pages() - if I remove this, I get spurious segfaults and illegal
instruction faults.

If I make flush_dcache_page() non-lazy, this also fixes it, but this
is not desirable.  The problem also goes away if I disable the write
allocate cache mode.

If I call __flush_dcache_page() from update_mmu_cache() (iow, always
ensure that we have I/D coherency when the page is mapped into user
space) the effect is the same - I see random faults.

This is using cramfs as the filesystem, which does call flush_dcache_page()
on pages returned via its readpages implementation.

Unfortunately, I've only recently obtained this hardware, but I know
a previous kernel (2.6.7-based) works fine on it (already supplied by
others.)  However, there's a massive delta from mainline for this
which makes it totally impractical to try other mainline kernels.

To me, it feels like there's a path which results in pages mapped into
user space without update_mmu_cache() being called, but I'm unable to
find it.  Ideas?

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/mm/filemap.c linux/mm/filemap.c
--- orig/mm/filemap.c	Wed Jun 29 15:52:51 2005
+++ linux/mm/filemap.c	Fri Jul 29 15:32:40 2005
@@ -849,6 +849,8 @@ readpage:
 			unlock_page(page);
 		}
 
+if (page->mapping && !mapping_mapped(page->mapping)) BUG_ON(!test_bit(PG_dcache_dirty, &page->flags));
+{ void __flush_dcache_page(struct address_space *mapping, struct page *page); __flush_dcache_page(page->mapping, page); }
 		/*
 		 * i_size must be checked after we have done ->readpage.
 		 *
@@ -1158,6 +1160,8 @@ static int fastcall page_cache_read(stru
 	error = add_to_page_cache_lru(page, mapping, offset, GFP_KERNEL);
 	if (!error) {
 		error = mapping->a_ops->readpage(file, page);
+if (page->mapping && !mapping_mapped(page->mapping)) BUG_ON(!test_bit(PG_dcache_dirty, &page->flags));
+{ void __flush_dcache_page(struct address_space *mapping, struct page *page); __flush_dcache_page(page->mapping, page); }
 		page_cache_release(page);
 		return error;
 	}
@@ -1254,7 +1258,9 @@ retry_find:
 		page = find_get_page(mapping, pgoff);
 		if (!page)
 			goto no_cached_page;
+if (page->mapping && !mapping_mapped(page->mapping)) BUG_ON(!test_bit(PG_dcache_dirty, &page->flags));
 	}
+if (page->mapping && !mapping_mapped(page->mapping)) BUG_ON(!test_bit(PG_dcache_dirty, &page->flags));
 
 	if (!did_readaround)
 		ra->mmap_hit++;
@@ -1267,6 +1273,8 @@ retry_find:
 		goto page_not_uptodate;
 
 success:
+if (page->mapping && !mapping_mapped(page->mapping)) BUG_ON(!test_bit(PG_dcache_dirty, &page->flags));
+{ void __flush_dcache_page(struct address_space *mapping, struct page *page); __flush_dcache_page(page->mapping, page); }
 	/*
 	 * Found the page and have a reference on it.
 	 */
@@ -1402,6 +1410,8 @@ retry_find:
 	}
 
 success:
+if (page->mapping && !mapping_mapped(page->mapping)) BUG_ON(!test_bit(PG_dcache_dirty, &page->flags));
+{ void __flush_dcache_page(struct address_space *mapping, struct page *page); __flush_dcache_page(page->mapping, page); }
 	/*
 	 * Found the page and have a reference on it.
 	 */
@@ -1508,6 +1518,7 @@ repeat:
 	if (!page && !nonblock)
 		return -ENOMEM;
 	if (page) {
+{ void __flush_dcache_page(struct address_space *mapping, struct page *page); __flush_dcache_page(page->mapping, page); }
 		err = install_page(mm, vma, addr, page, prot);
 		if (err) {
 			page_cache_release(page);
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/mm/memory.c linux/mm/memory.c
--- orig/mm/memory.c	Wed Jun 29 15:52:51 2005
+++ linux/mm/memory.c	Fri Jul 29 15:41:11 2005
@@ -1821,6 +1821,7 @@ do_no_page(struct mm_struct *mm, struct 
 retry:
 	cond_resched();
 	new_page = vma->vm_ops->nopage(vma, address & PAGE_MASK, &ret);
+{ void __flush_dcache_page(struct address_space *mapping, struct page *page); __flush_dcache_page(new_page->mapping, new_page); }
 	/*
 	 * No smp_rmb is needed here as long as there's a full
 	 * spin_lock/unlock sequence inside the ->nopage callback
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/mm/readahead.c linux/mm/readahead.c
--- orig/mm/readahead.c	Mon Apr  4 22:54:55 2005
+++ linux/mm/readahead.c	Fri Jul 29 15:57:18 2005
@@ -172,6 +172,7 @@ static int read_pages(struct address_spa
 		if (!add_to_page_cache(page, mapping,
 					page->index, GFP_KERNEL)) {
 			mapping->a_ops->readpage(filp, page);
+{ void __flush_dcache_page(struct address_space *mapping, struct page *page); __flush_dcache_page(page->mapping, page); }
 			if (!pagevec_add(&lru_pvec, page))
 				__pagevec_lru_add(&lru_pvec);
 		} else {


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
