Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVBBBVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVBBBVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 20:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbVBBBVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 20:21:11 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:19852 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261983AbVBBBUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 20:20:46 -0500
Date: Tue, 1 Feb 2005 17:20:17 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       hugh@veritas.com, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: page fault scalability patch V16 [3/4]: Drop page_table_lock in
 handle_mm_fault
In-Reply-To: <1107304296.5131.13.camel@npiggin-nld.site>
Message-ID: <Pine.LNX.4.58.0502011718240.5549@schroedinger.engr.sgi.com>
References: <41E5B7AD.40304@yahoo.com.au>  <Pine.LNX.4.58.0501121552170.12669@schroedinger.engr.sgi.com>
  <41E5BC60.3090309@yahoo.com.au>  <Pine.LNX.4.58.0501121611590.12872@schroedinger.engr.sgi.com>
  <20050113031807.GA97340@muc.de>  <Pine.LNX.4.58.0501130907050.18742@schroedinger.engr.sgi.com>
  <20050113180205.GA17600@muc.de>  <Pine.LNX.4.58.0501131701150.21743@schroedinger.engr.sgi.com>
  <20050114043944.GB41559@muc.de>  <Pine.LNX.4.58.0501140838240.27382@schroedinger.engr.sgi.com>
  <20050114170140.GB4634@muc.de>  <Pine.LNX.4.58.0501281233560.19266@schroedinger.engr.sgi.com>
  <Pine.LNX.4.58.0501281237010.19266@schroedinger.engr.sgi.com> 
 <41FF00CE.8060904@yahoo.com.au>  <Pine.LNX.4.58.0502011047330.3205@schroedinger.engr.sgi.com>
 <1107304296.5131.13.camel@npiggin-nld.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, Nick Piggin wrote:

> > The unmapping in rmap.c would change the pte. This would be discovered
> > after acquiring the spinlock later in do_wp_page. Which would then lead to
> > the operation being abandoned.
> Oh yes, but suppose your page_cache_get is happening at the same time
> as free_pages_check, after the page gets freed by the scanner? I can't
> actually think of anything that would cause a real problem (ie. not a
> debug check), off the top of my head. But can you say there _isn't_
> anything?
>
> Regardless, it seems pretty dirty to me. But could possibly be made
> workable, of course.

Would it make you feel better if we would move the spin_unlock back to the
prior position? This would ensure that the fallback case is exactly the
same.

Index: linux-2.6.10/mm/memory.c
===================================================================
--- linux-2.6.10.orig/mm/memory.c	2005-01-31 08:59:07.000000000 -0800
+++ linux-2.6.10/mm/memory.c	2005-02-01 10:55:30.000000000 -0800
@@ -1318,7 +1318,6 @@ static int do_wp_page(struct mm_struct *
 		}
 	}
 	pte_unmap(page_table);
-	page_table_atomic_stop(mm);

 	/*
 	 * Ok, we need to copy. Oh, well..
@@ -1326,6 +1325,7 @@ static int do_wp_page(struct mm_struct *
 	if (!PageReserved(old_page))
 		page_cache_get(old_page);

+	page_table_atomic_stop(mm);
 	if (unlikely(anon_vma_prepare(vma)))
 		goto no_new_page;
 	if (old_page == ZERO_PAGE(address)) {
