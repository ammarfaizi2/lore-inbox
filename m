Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262444AbUCJKgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 05:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbUCJKgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 05:36:24 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13067
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262444AbUCJKf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 05:35:29 -0500
Date: Wed, 10 Mar 2004 11:36:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: RFC anon_vma previous (i.e. full objrmap)
Message-ID: <20040310103610.GB30940@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040309105226.GA2863@elte.hu> <20040309110233.GA3819@elte.hu> <20040309030907.71a53a7c.akpm@osdl.org> <20040309114924.GA4581@elte.hu> <20040309160307.GI8193@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040309160307.GI8193@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2004 at 05:03:07PM +0100, Andrea Arcangeli wrote:
> those vmas in those apps are forced to be mlocked with the rmap VM, so
> it's hard for me to buy that rmap is any better. You can't even allow

btw, try your exploit by keeping the stuff mlocked. you'll see we're not
following the i_mmap already the first time we run into a VM_LOCKED vma,
we could be even more efficient by removing mlocked pages from the lru,
but it's definitely not required to get that workload right, and that
workload needs mlock with rmap to remove the pte_chains anyways!

So even now objrmap seems a lot better than rmap for that workload, it
doesn't even require mlock, it only requires it if you want to pageout
heavily (rmap requires it regardless if you pageout or not). And it can
be fixed too with an rbtree as worse, while the rmap overhead is not
fixable (other than to remove rmap enterely like I'm doing).

BTW, my current anon_vma work is going really well, the code is so much
nicer, and it's quite smaller too.

 include/linux/mm.h         |   76 +++
 include/linux/objrmap.h    |   74 +++
 include/linux/page-flags.h |    4 
 include/linux/rmap.h       |   53 --
 init/main.c                |    4 
 mm/memory.c                |   15 
 mm/mmap.c                  |    4 
 mm/nommu.c                 |    2 
 mm/objrmap.c               |  480 +++++++++++++++++++++++
 mm/page_alloc.c            |    6 
 mm/rmap.c                  |  908 ---------------------------------------------
 12 files changed, 636 insertions(+), 990 deletions(-)

and this doesn't remove all the pte_chains everywhere yet.

objrmap.c seems already fully complete, what's missing now is the
removal of all the pte_chains from memory.c and friends, and later the
anon_vma tracking with fork and munmap (I've only covered
do_anonymous_page, so far, see how cool it looks like now:

static int
do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
		pte_t *page_table, pmd_t *pmd, int write_access,
		unsigned long addr)
{
	pte_t entry;
	struct page * page = ZERO_PAGE(addr);
	int ret;

	/* Read-only mapping of ZERO_PAGE. */
	entry = pte_wrprotect(mk_pte(ZERO_PAGE(addr), vma->vm_page_prot));

	/* ..except if it's a write access */
	if (write_access) {
		/* Allocate our own private page. */
		pte_unmap(page_table);
		spin_unlock(&mm->page_table_lock);

		page = alloc_page(GFP_HIGHUSER);
		if (!page)
			goto no_mem;
		clear_user_highpage(page, addr);

		spin_lock(&mm->page_table_lock);
		page_table = pte_offset_map(pmd, addr);

		if (!pte_none(*page_table)) {
			pte_unmap(page_table);
			page_cache_release(page);
			spin_unlock(&mm->page_table_lock);
			ret = VM_FAULT_MINOR;
			goto out;
		}
		mm->rss++;
		entry = maybe_mkwrite(pte_mkdirty(mk_pte(page,
							 vma->vm_page_prot)),
				      vma);
		lru_cache_add_active(page);
		mark_page_accessed(page);
		SetPageAnon(page);
	}

	set_pte(page_table, entry);
	/* ignores ZERO_PAGE */
	page_add_rmap(page, vma);
	pte_unmap(page_table);

	/* No need to invalidate - it was non-present before */
	update_mmu_cache(vma, addr, entry);
	spin_unlock(&mm->page_table_lock);
	ret = VM_FAULT_MINOR;
	goto out;

no_mem:
	ret = VM_FAULT_OOM;
out:
	return ret;
}


no pte_chains anywhere.

and here the page_add_rmap from objrmap.c:

/* this needs the page->flags PG_map_lock held */
static void inline anon_vma_page_link(struct page * page, struct
vm_struct * vma)
{
	SetPageDirect(page);
	page->as.vma = vma;
}

/**
 * page_add_rmap - add reverse mapping entry to a page
 * @page: the page to add the mapping to
 * @vma: the vma that is covering the page
 *
 * Add a new pte reverse mapping to a page.
 * The caller needs to hold the mm->page_table_lock.
 */
void * fastcall
page_add_rmap(struct page *page, struct vm_struct * vma)
{
	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
		return;

	page_map_lock(page);

	if (!page->mapcount++)
		inc_page_state(nr_mapped);

	if (PageAnon(page))
		anon_vma_page_link(page, vma);
	else {
		/*
		 * If this is an object-based page, just count it.
		 * We can find the mappings by walking the object
		 * vma chain for that object.
		 */
		BUG_ON(!page->as.mapping);
		BUG_ON(PageSwapCache(page));
	}

	page_map_unlock(page);
}

here page_remove_rmap:

/* this needs the page->flags PG_map_lock held */
static void inline anon_vma_page_unlink(struct page * page)
{
	/*
	 * Cleanup if this anon page is gone
	 * as far as the vm is concerned.
	 */
	if (!page->mapcount) {
		page->as.vma = 0;
#if 0
		/*
		 * The above clears page->as.anon_vma too
		 * if the page wasn't direct.
		 */
		page->as.anon_vma = 0;
#endif
		ClearPageDirect(page);
	}
}

/**
 * page_remove_rmap - take down reverse mapping to a page
 * @page: page to remove mapping from
 *
 * Removes the reverse mapping from the pte_chain of the page,
 * after that the caller can clear the page table entry and free
 * the page.
 * Caller needs to hold the mm->page_table_lock.
 */
void fastcall page_remove_rmap(struct page *page)
{
	if (!pfn_valid(page_to_pfn(page)) || PageReserved(page))
		return;

	page_map_lock(page);

	if (!page_mapped(page))
		goto out_unlock;

	if (!--page->mapcount)
		dec_page_state(nr_mapped);

	if (PageAnon(page))
		anon_vma_page_unlink(page, vma);
	else {
		/*
		 * If this is an object-based page, just uncount it.
		 * We can find the mappings by walking the object vma
		 * chain for that object.
		 */
		BUG_ON(!page->as.mapping);
		BUG_ON(PageSwapCache(page));
	}
  
	page_map_unlock(page);
	return;
}


here the paging code that unmaps the ptes:

static int
try_to_unmap_anon(struct page * page)
{
	int ret = SWAP_AGAIN;

	page_map_lock(page);

	if (PageDirect(page)) {
		ret = try_to_unmap_inode_one(page->as.vma, page);
	} else {
		struct vm_area_struct * vma;
		anon_vma_t * anon_vma = page->as.anon_vma;
		
		list_for_each_entry(vma, &anon_vma->anon_vma_head, anon_vma_node) {
			ret = try_to_unmap_inode_one(vma, page);
			if (ret == SWAP_FAIL || !page->mapcount)
				goto out;
		}
	}

out:
	page_map_unlock(page);
	return ret;
}

/**
 * try_to_unmap - try to remove all page table mappings to a page
 * @page: the page to get unmapped
 *
 * Tries to remove all the page table entries which are mapping this
 * page, used in the pageout path.  Caller must hold the page lock
 * and its pte chain lock.  Return values are:
 *
 * SWAP_SUCCESS	- we succeeded in removing all mappings
 * SWAP_AGAIN	- we missed a trylock, try again later
 * SWAP_FAIL	- the page is unswappable
 */
int fastcall try_to_unmap(struct page * page)
{
	struct pte_chain *pc, *next_pc, *start;
	int ret = SWAP_SUCCESS;

	/* This page should not be on the pageout lists. */
	BUG_ON(PageReserved(page));
	BUG_ON(!PageLocked(page));

	/*
	 * We need backing store to swap out a page.
	 * Subtle: this checks for page->as.anon_vma too ;).
	 */
	BUG_ON(!page->as.mapping);

	if (!PageAnon(page))
		ret = try_to_unmap_inode(page);
	else
		ret = try_to_unmap_anon(page);

	if (!page_mapped(page)) {
		dec_page_state(nr_mapped);
		ret = SWAP_SUCCESS;
	}
	return ret;
}

In my first attempt I was nucking page->mapping++ (that's pure locking
overhead for the file mappings and it wastes 4 bytes per page_t) but
then I retraced since nr_mapped was expanding everywhere in the vm and
the modifications were growing too fast at the same time, so I'll think
about it later for now I will do anon_vma only plus the nonlinear
pagetable walk, so the page is as self contained as possible and it'll
drop all pte_chains from the kernel.

The only single reason I need page->mapped is that if the page is an
inode mapping, page->as.mapping won't be enough to tell if it was
already mapped or not. So my current anon_vma patch (incremental with
objrmap) only reduces the page_t of 4 bytes compared to mainline 2.4 and
mainline 2.6.

With PageDirect and the page->as.vma field I'm deferring _all_ anon_vma
object allocations to fork(), even when a MAP_PRIVATE vma is already
tracked by an inode and by an anon_vma (generated by an old fork), new
anonymous pages allocated are still "direct". So the same vma will have
direct anon pages, anon_vma indirect cow pages, and finally it will have
inode pages too (readonly writeprotect). I plan to teach the cow fault
to convert anon_vma indirect pages to direct pages if page->mapping ==
1 (no, I don't need page->mapping for that, I could use page_count but
since I've page->mapping I use it so the unlikely races are converted to
direct mode too). However a vma can't return "direct", only the page can
return direct. The reason is that I've no way to reach _only_ the pages
pointing to an anon_vma starting from the vma (the only way would be a
pagetable walk but I don't want to do that, and leaving the anon_vma is
perfectly fine, I will garbage collect it when the vma goes away too).
Overall this means anonymous page faults will be blazing fast, no
allocation ever in the fast paths, just fork will have to allocate 12
more bytes per anonymous vma to track the cows (not a big deal compared
to 8 bytes per pte of rmap ;).

here below (most important of all to understand my anon_vma proposed
design) a preview of the data structure layout.

I think this is close to DaveM's original approch to handle the
anonymous memory, though the last time I read his patch was a few years
ago so I don't remeber exactly, the only thing I remeber (because I
disliked that) was that he was doing slab allocations from page faults,
something that definitely completely avoid with highest priority. Hugh's
approch as well was not usable since it was tracking mm and it broke off
with mremap unfortunately.

the way I designed the garbage collection of the anon_vma transient
objects as well I think is extremely optimized, I don't need list of
pages or counter of the pages, I simply garbage collect the anon_vma
during vma destruction, checking vma->anon_vma &&
list_empty(&vma->anon_vma->anon_vma_head). I use the invariant that for
a page to point to an anon_vma there must be a vma still queued in the
anon_vma. That should work reliably and it allows me to only point
anon_vmas from pages, and I never know from a anon_vma (or a vma) if any
page is pointing to it (I only need to know that no page is pointing to
it if no vma is queued into the anon_vma).

It took me a while to design this thing, but now I'm quite happy, I hope
not to find some huge design flaw at the last minute ;). This is why I'm
showing you all this right now before it's finished, if you see any
design flaw please let me know ASAP, I need this thing working quickly!

thanks.

--- sles-anobjrmap-2/include/linux/mm.h.~1~	2004-03-03 06:45:38.000000000 +0100
+++ sles-anobjrmap-2/include/linux/mm.h	2004-03-10 10:25:55.955735680 +0100
@@ -39,6 +39,22 @@ extern int page_cluster;
  * mmap() functions).
  */
 
+typedef struct anon_vma_s {
+	/* This serializes the accesses to the vma list. */
+	spinlock_t anon_vma_lock;
+
+	/*
+	 * This is a list of anonymous "related" vmas,
+	 * to scan if one of the pages pointing to this
+	 * anon_vma needs to be unmapped.
+	 * After we unlink the last vma we must garbage collect
+	 * the object if the list is empty because we're
+	 * guaranteed no page can be pointing to this anon_vma
+	 * if there's no vma anymore.
+	 */
+	struct list_head anon_vma_head;
+} anon_vma_t;
+
 /*
  * This struct defines a memory VMM memory area. There is one of these
  * per VM-area/task.  A VM area is any part of the process virtual memory
@@ -69,6 +85,19 @@ struct vm_area_struct {
 	 */
 	struct list_head shared;
 
+	/*
+	 * The same vma can be both queued into the i_mmap and in a
+	 * anon_vma too, for example after a cow in
+	 * a MAP_PRIVATE file mapping. However only the MAP_PRIVATE
+	 * will go both in the i_mmap and anon_vma. A MAP_SHARED
+	 * will only be in the i_mmap_shared and a MAP_ANONYMOUS (file = 0)
+	 * will only be queued only in the anon_vma.
+	 * The list is serialized by the anon_vma->lock.
+	 */
+	struct list_head anon_vma_node;
+	/* Serialized by the vma->vm_mm->page_table_lock */
+	anon_vma_t * anon_vma;
+
 	/* Function pointers to deal with this struct. */
 	struct vm_operations_struct * vm_ops;
 
@@ -172,16 +201,51 @@ struct page {
 					   updated asynchronously */
 	atomic_t count;			/* Usage count, see below. */
 	struct list_head list;		/* ->mapping has some page lists. */
-	struct address_space *mapping;	/* The inode (or ...) we belong to. */
 	unsigned long index;		/* Our offset within mapping. */
 	struct list_head lru;		/* Pageout list, eg. active_list;
 					   protected by zone->lru_lock !! */
+
+	/*
+	 * Address space of this page.
+	 * A page can be either mapped to a file or to be anonymous
+	 * memory, so using the union is optimal here. The PG_anon
+	 * bitflag tells if this is anonymous or a file-mapping.
+	 * If PG_anon is clear we use the as.mapping, if PG_anon is
+	 * set and PG_direct is not set we use the as.anon_vma,
+	 * if PG_anon is set and PG_direct is set we use the as.vma.
+	 */
 	union {
-		struct pte_chain *chain;/* Reverse pte mapping pointer.
-					 * protected by PG_chainlock */
-		pte_addr_t direct;
-		int mapcount;
-	} pte;
+		/* The inode address space if it's a file mapping. */
+		struct address_space * mapping;
+
+		/*
+		 * This points to an anon_vma object.
+		 * The anon_vma can't go away under us if
+		 * we hold the PG_maplock.
+		 */
+		anon_vma_t * anon_vma;
+
+		/*
+		 * Before the first fork we avoid anon_vma object allocation
+		 * and we set PG_direct. anon_vma objects are only created
+		 * via fork(), and the vm then stop using the page->as.vma
+		 * and it starts using the as.anon_vma object instead.
+		 * After the first fork(), even if the child exit, the pages
+		 * cannot be downgraded to PG_direct anymore (even if we
+		 * wanted to) because there's no way to reach pages starting
+		 * from an anon_vma object.
+		 */
+		struct vm_struct * vma;
+	} as;
+	
+	/*
+	 * Number of ptes mapping this page.
+	 * It's serialized by PG_maplock.
+	 * This is needed only to maintain the nr_mapped global info
+	 * so it would be nice to drop it.
+	 */
+	unsigned long mapcount;		
+
 	unsigned long private;		/* mapping-private opaque data */
 
 	/*
--- sles-anobjrmap-2/include/linux/page-flags.h.~1~	2004-03-03 06:45:38.000000000 +0100
+++ sles-anobjrmap-2/include/linux/page-flags.h	2004-03-10 10:20:59.324830432 +0100
@@ -69,9 +69,9 @@
 #define PG_private		12	/* Has something at ->private */
 #define PG_writeback		13	/* Page is under writeback */
 #define PG_nosave		14	/* Used for system suspend/resume */
-#define PG_chainlock		15	/* lock bit for ->pte_chain */
+#define PG_maplock		15	/* lock bit for ->as.anon_vma and ->mapcount */
 
-#define PG_direct		16	/* ->pte_chain points directly at pte */
+#define PG_direct		16	/* if set it must use page->as.vma */
 #define PG_mappedtodisk		17	/* Has blocks allocated on-disk */
 #define PG_reclaim		18	/* To be reclaimed asap */
 #define PG_compound		19	/* Part of a compound page */

