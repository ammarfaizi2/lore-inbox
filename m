Return-Path: <linux-kernel-owner+w=401wt.eu-S964774AbXAGQbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbXAGQbE (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 11:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932607AbXAGQbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 11:31:04 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3130 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932605AbXAGQbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 11:31:00 -0500
Date: Sun, 7 Jan 2007 16:30:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: David Miller <davem@davemloft.net>, miklos@szeredi.hu, arjan@infradead.org,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, akpm@osdl.org
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
Message-ID: <20070107163040.GB21133@flint.arm.linux.org.uk>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	David Miller <davem@davemloft.net>, miklos@szeredi.hu,
	arjan@infradead.org, torvalds@osdl.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	akpm@osdl.org
References: <1167778403.3687.1.camel@mulgrave.il.steeleye.com> <20070102.151906.21595863.davem@davemloft.net> <1167780858.3687.13.camel@mulgrave.il.steeleye.com> <20070102.162058.55482337.davem@davemloft.net> <20070103141655.GA25434@flint.arm.linux.org.uk> <1167836458.2789.6.camel@mulgrave.il.steeleye.com> <20070103150912.GB25434@flint.arm.linux.org.uk> <1168186153.2792.80.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168186153.2792.80.camel@mulgrave.il.steeleye.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2007 at 10:09:13AM -0600, James Bottomley wrote:
> On Wed, 2007-01-03 at 15:09 +0000, Russell King wrote:
> > On Wed, Jan 03, 2007 at 09:00:58AM -0600, James Bottomley wrote:
> > > However, I was wondering if there might be a different way around this.
> > > We can't really walk all the user mappings because of the locks, but
> > > could we store the user flush hints in the page (or a related
> > > structure)?  On parisc we don't care about the process id (called space
> > > in our architecture) because we've turned off the pieces of the cache
> > > that match on space id.  Thus, all we care about is flushing with the
> > > physical address and virtual address (and only about 10 bits of this are
> > > significant for matching).  We go to great lengths to ensure that every
> > > mapping in user space all has the same 10 bits of virtual address, so if
> > > we just new what they were we could flush the whole of the user spaces
> > > for the page without having to walk any VMA lists.  Could arm do this as
> > > well?
> > 
> > I don't think so.  The organisation of the VIVT caches in terms of
> > how the set index and tag correspond with virtual addresses are hardly
> > ever documented.  When they are, they don't appear to lend themselves
> > to such an approach.  For example,  Xscale has:
> > 
> >  tag:       virtual address b31-10
> >  set index: b9-5
> > 
> > and there's 32 ways per set.  So there's nothing to be gained from
> > controlling the virtual address which individual mappings end up at
> > in this case.
> 
> OK, so the bottom line we seem to have reached is that we can't manage
> the user coherency in the DMA API.  Does this also mean you can't do it
> for non-DMA cases (kmap_atomic would seem to be a likely problem)?

It will only work if we can walk the VMA lists associated with the
page from IRQ context.  By that I mean the address_space vma lists
as well as the anonymous memory list.

> in which case the only coherency kmap would control would be kernel
> coherency?

If that's all that kmap could do, it would solve the issues with PIO,
but not things like fuse and the other users of get_user_pages() with
the current context.  All those would remain potential sources of data
corruption.

My current attempt at solving this (following David's advice for anon
pages in flush_dcache_page()) is as follows (which involves duplicating
bits of mm/rmap.c) but I remain unconvinced that this is safe from all
contexts which flush_dcache_page() may be called from.

Given where we are in the -rc cycle, I feel that my original two patches
are far safer to solve the problems reported so far - especially as they've
been tested.  If someone can come up with a better way, then we can look
to implementing that instead once 2.6.20 has happened.

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 628348c..e5830f6 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
+#include <linux/rmap.h>
 
 #include <asm/cacheflush.h>
 #include <asm/system.h>
@@ -117,6 +118,56 @@ void flush_ptrace_access(struct vm_area_struct *vma, struct page *page,
 #define flush_pfn_alias(pfn,vaddr)	do { } while (0)
 #endif
 
+/*
+ * Copy of vma_address in mm/rmap.c... would be useful to have that non-static.
+ */
+static inline unsigned long
+arm_vma_address(struct page *page, struct vm_area_struct *vma)
+{
+	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
+	unsigned long address;
+
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	if (unlikely(address < vma->vm_start || address >= vma->vm_end)) {
+		/* page should be within any vma from prio_tree_next */
+		BUG_ON(!PageAnon(page));
+		return -EFAULT;
+	}
+	return address;
+}
+
+static void flush_user_mapped_page(struct vm_area_struct *vma, struct page *page)
+{
+	unsigned long address = arm_vma_address(page, vma);
+
+	if (address != -EFAULT)
+		flush_cache_page(vma, address, page_to_pfn(page));
+}
+
+static void __flush_anon_mapping(struct page *page)
+{
+	struct mm_struct *mm = current->active_mm;
+
+	rcu_read_lock();
+	if (page_mapped(page)) {
+		unsigned long anon_mapping = (unsigned long) page->mapping;
+		struct anon_vma *anon_vma;
+		struct vm_area_struct *vma;
+
+		anon_vma = (struct anon_vma *)(anon_mapping - PAGE_MAPPING_ANON);
+		spin_lock(&anon_vma->lock);
+		rcu_read_unlock();
+
+		list_for_each_entry(vma, &anon_vma->head, anon_vma_node) {
+			if (vma->vm_mm == mm)
+				flush_user_mapped_page(vma, page);
+		}
+		spin_unlock(&anon_vma->lock);
+	} else {
+		rcu_read_unlock();
+	}
+}
+
 void __flush_dcache_page(struct address_space *mapping, struct page *page)
 {
 	/*
@@ -141,20 +192,17 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 	struct mm_struct *mm = current->active_mm;
 	struct vm_area_struct *mpnt;
 	struct prio_tree_iter iter;
-	pgoff_t pgoff;
+	pgoff_t pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 
 	/*
 	 * There are possible user space mappings of this page:
 	 * - VIVT cache: we need to also write back and invalidate all user
 	 *   data in the current VM view associated with this page.
 	 * - aliasing VIPT: we only need to find one mapping of this page.
+	 *   (we handle this separately)
 	 */
-	pgoff = page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
-
 	flush_dcache_mmap_lock(mapping);
 	vma_prio_tree_foreach(mpnt, &iter, &mapping->i_mmap, pgoff, pgoff) {
-		unsigned long offset;
-
 		/*
 		 * If this VMA is not in our MM, we can ignore it.
 		 */
@@ -162,8 +210,7 @@ static void __flush_dcache_aliases(struct address_space *mapping, struct page *p
 			continue;
 		if (!(mpnt->vm_flags & VM_MAYSHARE))
 			continue;
-		offset = (pgoff - mpnt->vm_pgoff) << PAGE_SHIFT;
-		flush_cache_page(mpnt, mpnt->vm_start + offset, page_to_pfn(page));
+		flush_user_mapped_page(mpnt, page);
 	}
 	flush_dcache_mmap_unlock(mapping);
 }
@@ -199,6 +246,8 @@ void flush_dcache_page(struct page *page)
 		__flush_dcache_page(mapping, page);
 		if (mapping && cache_is_vivt())
 			__flush_dcache_aliases(mapping, page);
+		if (PageAnon(page))
+			__flush_anon_mapping(page);
 	}
 }
 EXPORT_SYMBOL(flush_dcache_page);


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
