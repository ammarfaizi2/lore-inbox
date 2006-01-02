Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWABXlF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWABXlF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 18:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWABXlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 18:41:05 -0500
Received: from hera.kernel.org ([140.211.167.34]:65440 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751129AbWABXlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 18:41:02 -0500
Date: Mon, 2 Jan 2006 19:40:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
Message-ID: <20060102214016.GA13905@dmt.cnet>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com> <20051231064615.GB11069@dmt.cnet> <43B63931.6000307@yahoo.com.au> <20051231202602.GC3903@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231202602.GC3903@dmt.cnet>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 06:26:02PM -0200, Marcelo Tosatti wrote:
> Hi Nick!
> 
> On Sat, Dec 31, 2005 at 06:54:25PM +1100, Nick Piggin wrote:
> > Marcelo Tosatti wrote:
> > 
> > >
> > >What about this addition to the documentation above, to make it a little 
> > >more verbose:
> > >
> > >	The possible race scenario is restricted to kernel preemption,
> > >	and could happen as follows:
> > >
> > >	thread A				thread B
> > >a)	movl    xyz(%ebp), %eax			movl    xyz(%ebp), %eax
> > >b)	incl    %eax				incl    %eax
> > >c)	movl    %eax, xyz(%ebp)			movl    %eax, xyz(%ebp)
> > >
> > >Thread A can be preempted in b), and thread B succesfully increments the
> > >counter, writing it back to memory. Now thread A resumes execution, with
> > >its stale copy of the counter, and overwrites the current counter.
> > >
> > >Resulting in increments lost.
> > >
> > >However that should be relatively rare condition.
> > >
> > 
> > Hi Guys,
> > 
> > I've been waiting for some mm/ patches to clear from -mm before commenting
> > too much... however I see that this patch is actually against -mm itself,
> > with my __mod_page_state stuff in it... that makes the page state accounting
> > much lighter weight AND is not racy.
> 
> It is racy with reference to preempt (please refer to the race condition
> described above):
> 
> diff -puN mm/rmap.c~mm-page_state-opt mm/rmap.c
> --- devel/mm/rmap.c~mm-page_state-opt   2005-12-13 22:25:01.000000000 -0800
> +++ devel-akpm/mm/rmap.c        2005-12-13 22:25:01.000000000 -0800
> @@ -451,7 +451,11 @@ static void __page_set_anon_rmap(struct 
> 
>         page->index = linear_page_index(vma, address);
>  
> -       inc_page_state(nr_mapped);
> +       /*
> +        * nr_mapped state can be updated without turning off
> +        * interrupts because it is not modified via interrupt.
> +        */
> +       __inc_page_state(nr_mapped);
>  }
> 
> And since "nr_mapped" is not a counter for debugging purposes only, you 
> can't be lazy with reference to its consistency.
> 
> I would argue that you need a preempt save version for this important
> counters, surrounded by preempt_disable/preempt_enable (which vanish 
> if one selects !CONFIG_PREEMPT).

Nick, 

The following patch:

- Moves the lightweight "inc/dec" versions of mod_page_state variants
to three underscores, making those the default for locations where enough
locks are held.

- Make the two-underscore version disable and enable preemption, which 
is required to avoid preempt-related races which can result in missed
updates.

- Extends the lightweight version usage in page reclaim, 
pte allocation, and a few other codepaths.

How does it look? 


 fs/buffer.c                |    2 +-
 fs/inode.c                 |    4 ++--
 include/linux/page-flags.h |   17 +++++++++++++++++
 mm/memory.c                |    7 +++++--
 mm/page-writeback.c        |    2 +-
 mm/page_alloc.c            |   14 +++++++++++---
 mm/rmap.c                  |    3 ++-
 mm/swap.c                  |    4 ++--
 mm/vmscan.c                |    8 ++++----
 9 files changed, 45 insertions(+), 16 deletions(-)

diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/fs/buffer.c linux-2.6.15-rc5/fs/buffer.c
--- /tmp/2.6.15-rc5-mm3.orig/fs/buffer.c	2006-01-02 18:25:51.000000000 -0200
+++ linux-2.6.15-rc5/fs/buffer.c	2006-01-02 18:55:01.000000000 -0200
@@ -857,7 +857,7 @@ int __set_page_dirty_buffers(struct page
 		write_lock_irq(&mapping->tree_lock);
 		if (page->mapping) {	/* Race with truncate? */
 			if (mapping_cap_account_dirty(mapping))
-				inc_page_state(nr_dirty);
+				___inc_page_state(nr_dirty);
 			radix_tree_tag_set(&mapping->page_tree,
 						page_index(page),
 						PAGECACHE_TAG_DIRTY);
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/fs/inode.c linux-2.6.15-rc5/fs/inode.c
--- /tmp/2.6.15-rc5-mm3.orig/fs/inode.c	2006-01-02 18:26:26.000000000 -0200
+++ linux-2.6.15-rc5/fs/inode.c	2006-01-02 18:54:36.000000000 -0200
@@ -462,9 +462,9 @@ static void prune_icache(int nr_to_scan)
 	up(&iprune_sem);
 
 	if (current_is_kswapd())
-		mod_page_state(kswapd_inodesteal, reap);
+		__mod_page_state(kswapd_inodesteal, reap);
 	else
-		mod_page_state(pginodesteal, reap);
+		__mod_page_state(pginodesteal, reap);
 }
 
 /*
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/include/linux/page-flags.h linux-2.6.15-rc5/include/linux/page-flags.h
--- /tmp/2.6.15-rc5-mm3.orig/include/linux/page-flags.h	2006-01-02 18:26:10.000000000 -0200
+++ linux-2.6.15-rc5/include/linux/page-flags.h	2006-01-02 18:45:40.000000000 -0200
@@ -157,6 +157,7 @@ extern void get_page_state_node(struct p
 extern void get_full_page_state(struct page_state *ret);
 extern unsigned long read_page_state_offset(unsigned long offset);
 extern void mod_page_state_offset(unsigned long offset, unsigned long delta);
+extern void ___mod_page_state_offset(unsigned long offset, unsigned long delta);
 extern void __mod_page_state_offset(unsigned long offset, unsigned long delta);
 
 #define read_page_state(member) \
@@ -168,16 +169,27 @@ extern void __mod_page_state_offset(unsi
 #define __mod_page_state(member, delta)	\
 	__mod_page_state_offset(offsetof(struct page_state, member), (delta))
 
+#define ___mod_page_state(member, delta)	\
+	___mod_page_state_offset(offsetof(struct page_state, member), (delta))
+
+/* preempt/IRQ safe */
 #define inc_page_state(member)		mod_page_state(member, 1UL)
 #define dec_page_state(member)		mod_page_state(member, 0UL - 1)
 #define add_page_state(member,delta)	mod_page_state(member, (delta))
 #define sub_page_state(member,delta)	mod_page_state(member, 0UL - (delta))
 
+/* only preempt safe */
 #define __inc_page_state(member)	__mod_page_state(member, 1UL)
 #define __dec_page_state(member)	__mod_page_state(member, 0UL - 1)
 #define __add_page_state(member,delta)	__mod_page_state(member, (delta))
 #define __sub_page_state(member,delta)	__mod_page_state(member, 0UL - (delta))
 
+/* preempt/IRQ unsafe (plain inc/dec operations) */
+#define ___inc_page_state(member)	___mod_page_state(member, 1UL)
+#define ___dec_page_state(member)	___mod_page_state(member, 0UL - 1)
+#define ___add_page_state(member,delta)	___mod_page_state(member, (delta))
+#define ___sub_page_state(member,delta)	___mod_page_state(member, 0UL - (delta))
+
 #define page_state(member) (*__page_state(offsetof(struct page_state, member)))
 
 #define state_zone_offset(zone, member)					\
@@ -194,6 +206,11 @@ extern void __mod_page_state_offset(unsi
 	offset;								\
 })
 
+#define ___mod_page_state_zone(zone, member, delta)			\
+ do {									\
+	___mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
+ } while (0)
+
 #define __mod_page_state_zone(zone, member, delta)			\
  do {									\
 	__mod_page_state_offset(state_zone_offset(zone, member), (delta)); \
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/mm/memory.c linux-2.6.15-rc5/mm/memory.c
--- /tmp/2.6.15-rc5-mm3.orig/mm/memory.c	2006-01-02 18:25:34.000000000 -0200
+++ linux-2.6.15-rc5/mm/memory.c	2006-01-02 18:39:49.000000000 -0200
@@ -116,7 +116,7 @@ static void free_pte_range(struct mmu_ga
 	pmd_clear(pmd);
 	pte_lock_deinit(page);
 	pte_free_tlb(tlb, page);
-	dec_page_state(nr_page_table_pages);
+	__dec_page_state(nr_page_table_pages);
 	tlb->mm->nr_ptes--;
 }
 
@@ -302,7 +302,10 @@ int __pte_alloc(struct mm_struct *mm, pm
 		pte_free(new);
 	} else {
 		mm->nr_ptes++;
-		inc_page_state(nr_page_table_pages);
+		/* nr_page_table_pages is never touched by interrupt 
+		 * context, so its not necessary to disable them.
+		 */
+		__inc_page_state(nr_page_table_pages);
 		pmd_populate(mm, pmd, new);
 	}
 	spin_unlock(&mm->page_table_lock);
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/mm/page_alloc.c linux-2.6.15-rc5/mm/page_alloc.c
--- /tmp/2.6.15-rc5-mm3.orig/mm/page_alloc.c	2006-01-02 18:26:26.000000000 -0200
+++ linux-2.6.15-rc5/mm/page_alloc.c	2006-01-02 18:26:54.000000000 -0200
@@ -443,7 +443,7 @@ static void __free_pages_ok(struct page 
 
 	kernel_map_pages(page, 1 << order, 0);
 	local_irq_save(flags);
-	__mod_page_state(pgfree, 1 << order);
+	___mod_page_state(pgfree, 1 << order);
 	free_one_page(page_zone(page), page, order);
 	local_irq_restore(flags);
 }
@@ -753,7 +753,7 @@ static void fastcall free_hot_cold_page(
 
 	pcp = &zone_pcp(zone, get_cpu())->pcp[cold];
 	local_irq_save(flags);
-	__inc_page_state(pgfree);
+	___inc_page_state(pgfree);
 	list_add(&page->lru, &pcp->list);
 	pcp->count++;
 	if (pcp->count >= pcp->high) {
@@ -820,7 +820,7 @@ again:
 			goto failed;
 	}
 
-	__mod_page_state_zone(zone, pgalloc, 1 << order);
+	___mod_page_state_zone(zone, pgalloc, 1 << order);
 	zone_statistics(zonelist, zone, cpu);
 	local_irq_restore(flags);
 	put_cpu();
@@ -1375,8 +1375,16 @@ unsigned long read_page_state_offset(uns
 	return ret;
 }
 
+
 void __mod_page_state_offset(unsigned long offset, unsigned long delta)
 {
+	preempt_disable();
+	___mod_page_state_offset(offset, delta);
+	preempt_enable();
+}
+
+void ___mod_page_state_offset(unsigned long offset, unsigned long delta)
+{
 	void *ptr;
 
 	ptr = &__get_cpu_var(page_states);
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/mm/page-writeback.c linux-2.6.15-rc5/mm/page-writeback.c
--- /tmp/2.6.15-rc5-mm3.orig/mm/page-writeback.c	2006-01-02 18:25:12.000000000 -0200
+++ linux-2.6.15-rc5/mm/page-writeback.c	2006-01-02 19:27:52.000000000 -0200
@@ -632,7 +632,7 @@ int __set_page_dirty_nobuffers(struct pa
 			if (mapping2) { /* Race with truncate? */
 				BUG_ON(mapping2 != mapping);
 				if (mapping_cap_account_dirty(mapping))
-					inc_page_state(nr_dirty);
+					___inc_page_state(nr_dirty);
 				radix_tree_tag_set(&mapping->page_tree,
 					page_index(page), PAGECACHE_TAG_DIRTY);
 			}
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/mm/rmap.c linux-2.6.15-rc5/mm/rmap.c
--- /tmp/2.6.15-rc5-mm3.orig/mm/rmap.c	2006-01-02 18:25:35.000000000 -0200
+++ linux-2.6.15-rc5/mm/rmap.c	2006-01-02 18:29:48.000000000 -0200
@@ -453,7 +453,8 @@ static void __page_set_anon_rmap(struct 
 
 	/*
 	 * nr_mapped state can be updated without turning off
-	 * interrupts because it is not modified via interrupt.
+	 * interrupts because it is not modified via interrupt. 
+	 * But it must be guarded against preemption.
 	 */
 	__inc_page_state(nr_mapped);
 }
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/mm/swap.c linux-2.6.15-rc5/mm/swap.c
--- /tmp/2.6.15-rc5-mm3.orig/mm/swap.c	2006-01-02 18:25:35.000000000 -0200
+++ linux-2.6.15-rc5/mm/swap.c	2006-01-02 18:33:50.000000000 -0200
@@ -85,7 +85,7 @@ int rotate_reclaimable_page(struct page 
 	if (PageLRU(page) && !PageActive(page)) {
 		list_del(&page->lru);
 		list_add_tail(&page->lru, &zone->inactive_list);
-		inc_page_state(pgrotated);
+		___inc_page_state(pgrotated);
 	}
 	if (!test_clear_page_writeback(page))
 		BUG();
@@ -105,7 +105,7 @@ void fastcall activate_page(struct page 
 		del_page_from_inactive_list(zone, page);
 		SetPageActive(page);
 		add_page_to_active_list(zone, page);
-		inc_page_state(pgactivate);
+		___inc_page_state(pgactivate);
 	}
 	spin_unlock_irq(&zone->lru_lock);
 }
diff -Nur -p --exclude-from=linux-2.6.15-rc5/Documentation/dontdiff /tmp/2.6.15-rc5-mm3.orig/mm/vmscan.c linux-2.6.15-rc5/mm/vmscan.c
--- /tmp/2.6.15-rc5-mm3.orig/mm/vmscan.c	2006-01-02 18:26:26.000000000 -0200
+++ linux-2.6.15-rc5/mm/vmscan.c	2006-01-02 18:53:56.000000000 -0200
@@ -1058,8 +1058,8 @@ refill_inactive_zone(struct zone *zone, 
 	zone->nr_active += pgmoved;
 	spin_unlock(&zone->lru_lock);
 
-	__mod_page_state_zone(zone, pgrefill, pgscanned);
-	__mod_page_state(pgdeactivate, pgdeactivate);
+	___mod_page_state_zone(zone, pgrefill, pgscanned);
+	___mod_page_state(pgdeactivate, pgdeactivate);
 	local_irq_enable();
 
 	pagevec_release(&pvec);
@@ -1182,7 +1182,7 @@ int try_to_free_pages(struct zone **zone
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
 
-	inc_page_state(allocstall);
+	__inc_page_state(allocstall);
 
 	for (i = 0; zones[i] != NULL; i++) {
 		struct zone *zone = zones[i];
@@ -1285,7 +1285,7 @@ loop_again:
 	sc.may_writepage = 0;
 	sc.nr_mapped = read_page_state(nr_mapped);
 
-	inc_page_state(pageoutrun);
+	__inc_page_state(pageoutrun);
 
 	for (i = 0; i < pgdat->nr_zones; i++) {
 		struct zone *zone = pgdat->node_zones + i;







