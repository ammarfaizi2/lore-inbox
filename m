Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVBBEIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVBBEIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 23:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbVBBDDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 22:03:02 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:24556 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262224AbVBBCts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 21:49:48 -0500
Date: Tue, 1 Feb 2005 18:49:19 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock in
 handle_mm_fault
In-Reply-To: <1107308498.5131.28.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.58.0502011843570.6511@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au>  <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
  <41E5BC60.3090309@yahoo.com.au>  <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
  <20050113031807.GA97340@muc.de>  <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
  <20050113180205.GA17600@muc.de>  <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
  <20050114043944.GB41559@muc.de>  <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
  <20050114170140.GB4634@muc.de>  <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
  <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com> 
 <41FF00CE.8060904@yahoo.com.au>  <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
  <1107304296.5131.13.camel@npiggin-nld.site> 
 <Pine.LNX.4.58.0502011718240.5549@schroedinger.engr.sgi.com>
 <1107308498.5131.28.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Nick Piggin wrote:

> Well yeah, but the interesting case is when that isn't a lock ;)
>
> I'm not saying what you've got is no good. I'm sure it would be fine
> for testing. And if it happens that we can do the "page_count doesn't
> mean anything after it has reached zero and been freed. Nor will it
> necessarily be zero when a new page is allocated" thing without many
> problems, then this may be a fine way to do it.
>
> I was just pointing out this could be a problem without putting a
> lot of thought into it...

Surely we need to do this the right way. Do we really need to
use page_cache_get()? Is anything relying on page_count == 2 of
the old_page?

I mean we could just speculatively copy, risk copying crap and
discard that later when we find that the pte has changed. This would
simplify the function:

Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-02-01 18:10:46.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-02-01 18:43:08.000000000 -0800
@@ -1323,9 +1323,6 @@ static int do_wp_page(struct mm_struct *
 	/*
 	 * Ok, we need to copy. Oh, well..
 	 */
-	if (!PageReserved(old_page))
-		page_cache_get(old_page);
-
 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
 	if (old_page == ZERO_PAGE(address)) {
@@ -1336,6 +1333,10 @@ static int do_wp_page(struct mm_struct *
 		new_page = alloc_page_vma(GFP_HIGHUSER, vma, address);
 		if (!new_page)
 			goto no_new_page;
+		/*
+		 * No page_cache_get so we may copy some crap
+		 * that is later discarded if the pte has changed
+		 */
 		copy_user_highpage(new_page, old_page, address);
 	}
 	/*
@@ -1352,7 +1353,6 @@ static int do_wp_page(struct mm_struct *
 			acct_update_integrals();
 			update_mem_hiwater();
 		} else
-
 			page_remove_rmap(old_page);
 		break_cow(vma, new_page, address, page_table);
 		lru_cache_add_active(new_page);
@@ -1363,7 +1363,6 @@ static int do_wp_page(struct mm_struct *
 	}
 	pte_unmap(page_table);
 	page_cache_release(new_page);
-	page_cache_release(old_page);
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_MINOR;

