Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVCQAy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVCQAy5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVCQAyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:54:12 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:25240 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262933AbVCQAkB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 19:40:01 -0500
Message-ID: <4238D1DC.8070004@us.ibm.com>
Date: Wed, 16 Mar 2005 16:39:56 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
CC: "Bligh, Martin J." <mbligh@aracnet.com>
Subject: Bug in __alloc_pages()?
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------030506090103090606080101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030506090103090606080101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

While looking at some bugs related to OOM handling in 2.6, Martin Bligh and 
I noticed some order 0 page allocation failures from kswapd:

kswapd0: page allocation failure. order:0, mode:0x50
  [<c0147b92>] __alloc_pages+0x288/0x295
  [<c0147bb7>] __get_free_pages+0x18/0x24
  [<c014b2c4>] kmem_getpages+0x15/0x94
  [<c014c047>] cache_grow+0x154/0x299
  [<c014c399>] cache_alloc_refill+0x20d/0x23d
  [<c014c622>] kmem_cache_alloc+0x46/0x4c
  [<f885a4b0>] journal_alloc_journal_head+0x10/0x5d [jbd]
  [<f885a523>] journal_add_journal_head+0x1a/0xe1 [jbd]
  [<f8850be3>] journal_dirty_data+0x2e/0x3a5 [jbd]
  [<f8883400>] ext3_journal_dirty_data+0xc/0x2a [ext3]
  [<f888329a>] walk_page_buffers+0x62/0x87 [ext3]
  [<f888382d>] ext3_ordered_writepage+0xea/0x136 [ext3]
  [<f8883731>] journal_dirty_data_fn+0x0/0x12 [ext3]
  [<c014ec31>] pageout+0x83/0xc0
  [<c014ee80>] shrink_list+0x212/0x55f
  [<c014de86>] __pagevec_release+0x15/0x1d
  [<c014f400>] shrink_cache+0x233/0x4d5
  [<c014fee2>] shrink_zone+0x91/0x9c
  [<c01501e9>] balance_pgdat+0x15f/0x208
  [<c0150350>] kswapd+0xbe/0xc0
  [<c011e1ef>] autoremove_wake_function+0x0/0x2d
  [<c0308886>] ret_from_fork+0x6/0x20
  [<c011e1ef>] autoremove_wake_function+0x0/0x2d
  [<c0150292>] kswapd+0x0/0xc0
  [<c01041d5>] kernel_thread_helper+0x5/0xb

We decided that seemed odd, as kswapd should be able to get a page as long 
as there is even one page left in the system, since being a memory 
allocator task (PF_MEMALLOC) should exempt kswapd from any page watermark 
restrictions.  Digging into the code I found what looked like a bug that 
could potentially cause this situation to be far more common.

This chunk of code from __alloc_pages() demonstrates the problem:

	/* This allocation should allow future memory freeing. */
	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE))) 
&& !in_interrupt()) {
		/* go through the zonelist yet again, ignoring mins */
		for (i = 0; (z = zones[i]) != NULL; i++) {
			if (!cpuset_zone_allowed(z))
				continue;
			page = buffered_rmqueue(z, order, gfp_mask);
			if (page)
				goto got_pg;
		}
		goto nopage;
	}

	/* Atomic allocations - we can't balance anything */
	if (!wait)
		goto nopage;

rebalance:
	cond_resched();

	/* We now go into synchronous reclaim */
	p->flags |= PF_MEMALLOC;
	reclaim_state.reclaimed_slab = 0;
	p->reclaim_state = &reclaim_state;

	did_some_progress = try_to_free_pages(zones, gfp_mask, order);

	p->reclaim_state = NULL;
	p->flags &= ~PF_MEMALLOC;

If, while the system is under memory pressure, something attempts to 
allocate a page from interrupt context while current == kswapd we will 
obviously fail the !in_interrupt() check and fall through.  If this 
allocation request was made with __GFP_WAIT set then we'll fall through the 
next !wait check.  We will then set the PF_MEMALLOC flag and set 
p->reclaim_state to point to __alloc_pages() local reclaim_state structure. 
  kswapd alread has it's own reclaim_state and already has PF_MEMALLOC set, 
which would then be lost when, after try_to_free_pages(), we 
unconditionally set the reclaim_state to NULL and turn off the PF_MEMALLOC 
flag.

I'm not 100% sure that this potential bug is even possible (ie: can we have 
an in_interrupt() page request that has __GFP_WAIT set?), or is the cause 
of the 0-order page allocation failures we see, but it does seem like 
potentially dangerous code.  I have attatched a patch (against 2.6.11-mm4) 
to check whether the current task has it's own reclaim_state or already has 
PF_MEMALLOC set and if so, no longer throws away this data.

-Matt

--------------030506090103090606080101
Content-Type: text/plain;
 name="fix-__alloc_pages.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-__alloc_pages.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.11-mm4/mm/page_alloc.c linux-2.6.11-mm4+fix-__alloc_pages/mm/page_alloc.c
--- linux-2.6.11-mm4/mm/page_alloc.c	2005-03-16 16:07:49.179230440 -0800
+++ linux-2.6.11-mm4+fix-__alloc_pages/mm/page_alloc.c	2005-03-16 16:09:54.019251872 -0800
@@ -867,13 +867,14 @@ __alloc_pages(unsigned int gfp_mask, uns
 	const int wait = gfp_mask & __GFP_WAIT;
 	struct zone **zones, *z;
 	struct page *page;
-	struct reclaim_state reclaim_state;
+	struct reclaim_state reclaim_state = { .reclaimed_slab = 0 };
 	struct task_struct *p = current;
 	int i;
 	int classzone_idx;
 	int do_retry;
 	int can_try_harder;
 	int did_some_progress;
+	int is_memalloc = 0, has_reclaim_state = 0;
 
 	might_sleep_if(wait);
 
@@ -957,14 +958,22 @@ rebalance:
 	cond_resched();
 
 	/* We now go into synchronous reclaim */
-	p->flags |= PF_MEMALLOC;
-	reclaim_state.reclaimed_slab = 0;
-	p->reclaim_state = &reclaim_state;
+	if (p->flags & PF_MEMALLOC)
+		is_memalloc = 1;
+	else
+		p->flags |= PF_MEMALLOC;
+
+	if (p->reclaim_state)
+		has_reclaim_state = 1;
+	else
+		p->reclaim_state = &reclaim_state;
 
 	did_some_progress = try_to_free_pages(zones, gfp_mask, order);
 
-	p->reclaim_state = NULL;
-	p->flags &= ~PF_MEMALLOC;
+	if (!has_reclaim_state)
+		p->reclaim_state = NULL;
+	if (!is_memalloc)
+		p->flags &= ~PF_MEMALLOC;
 
 	cond_resched();
 

--------------030506090103090606080101--
