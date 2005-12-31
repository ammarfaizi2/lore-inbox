Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965056AbVLaW0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbVLaW0J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 17:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbVLaW0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 17:26:08 -0500
Received: from hera.kernel.org ([140.211.167.34]:57489 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965056AbVLaW0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 17:26:07 -0500
Date: Sat, 31 Dec 2005 18:26:02 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC] Event counters [1/3]: Basic counter functionality
Message-ID: <20051231202602.GC3903@dmt.cnet>
References: <20051220235733.30925.55642.sendpatchset@schroedinger.engr.sgi.com> <20051231064615.GB11069@dmt.cnet> <43B63931.6000307@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B63931.6000307@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick!

On Sat, Dec 31, 2005 at 06:54:25PM +1100, Nick Piggin wrote:
> Marcelo Tosatti wrote:
> 
> >
> >What about this addition to the documentation above, to make it a little 
> >more verbose:
> >
> >	The possible race scenario is restricted to kernel preemption,
> >	and could happen as follows:
> >
> >	thread A				thread B
> >a)	movl    xyz(%ebp), %eax			movl    xyz(%ebp), %eax
> >b)	incl    %eax				incl    %eax
> >c)	movl    %eax, xyz(%ebp)			movl    %eax, xyz(%ebp)
> >
> >Thread A can be preempted in b), and thread B succesfully increments the
> >counter, writing it back to memory. Now thread A resumes execution, with
> >its stale copy of the counter, and overwrites the current counter.
> >
> >Resulting in increments lost.
> >
> >However that should be relatively rare condition.
> >
> 
> Hi Guys,
> 
> I've been waiting for some mm/ patches to clear from -mm before commenting
> too much... however I see that this patch is actually against -mm itself,
> with my __mod_page_state stuff in it... that makes the page state accounting
> much lighter weight AND is not racy.

It is racy with reference to preempt (please refer to the race condition
described above):

diff -puN mm/rmap.c~mm-page_state-opt mm/rmap.c
--- devel/mm/rmap.c~mm-page_state-opt   2005-12-13 22:25:01.000000000 -0800
+++ devel-akpm/mm/rmap.c        2005-12-13 22:25:01.000000000 -0800
@@ -451,7 +451,11 @@ static void __page_set_anon_rmap(struct 

        page->index = linear_page_index(vma, address);
 
-       inc_page_state(nr_mapped);
+       /*
+        * nr_mapped state can be updated without turning off
+        * interrupts because it is not modified via interrupt.
+        */
+       __inc_page_state(nr_mapped);
 }

And since "nr_mapped" is not a counter for debugging purposes only, you 
can't be lazy with reference to its consistency.

I would argue that you need a preempt save version for this important
counters, surrounded by preempt_disable/preempt_enable (which vanish 
if one selects !CONFIG_PREEMPT).

As Christoph notes, debugging counter consistency can be lazy, not even
requiring correct preempt locking (hum, this is debatable, needs careful
verification).
 
> So I'm not exactly sure why such a patch as this is wanted now? Are there
> any more xxx_page_state hotspots? (I admit to only looking at page faults,
> page allocator, and page reclaim).

A consolidation of the good parts of both would be interesting.

I don't see much point in Christoph's naming change to "event_counter", 
why are you doing that?

And follows an addition to your's mm-page_state-opt-docs.patch. Still
need to verify "nr_dirty" and "nr_unstable".

Happy new year!

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 343083f..f173e0f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -83,10 +83,14 @@
 struct page_state {
 	unsigned long nr_dirty;		/* Dirty writeable pages */
 	unsigned long nr_writeback;	/* Pages under writeback */
+					/* also modified from IRQ context */
 	unsigned long nr_unstable;	/* NFS unstable pages */
 	unsigned long nr_page_table_pages;/* Pages used for pagetables */
+					/* only modified from process context */
 	unsigned long nr_mapped;	/* mapped into pagetables */
+					/* only modified from process context */
 	unsigned long nr_slab;		/* In slab */
+					/* also modified from IRQ context */
 #define GET_PAGE_STATE_LAST nr_slab
 
 	/*
