Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWFVQ3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWFVQ3l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 12:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWFVQ3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 12:29:41 -0400
Received: from silver.veritas.com ([143.127.12.111]:44160 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030640AbWFVQ3k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 12:29:40 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.06,166,1149490800"; 
   d="scan'208"; a="39470629:sNHT24339816"
Date: Thu, 22 Jun 2006 17:29:21 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: David Miller <davem@davemloft.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/6] mm: remove some update_mmu_cache() calls
In-Reply-To: <20060619175347.24655.67680.sendpatchset@lappy>
Message-ID: <Pine.LNX.4.64.0606221646000.4977@blonde.wat.veritas.com>
References: <20060619175243.24655.76005.sendpatchset@lappy>
 <20060619175347.24655.67680.sendpatchset@lappy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 22 Jun 2006 16:29:39.0811 (UTC) FILETIME=[0F165B30:01C69619]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006, Peter Zijlstra wrote:
> From: Christoph Lameter <clameter@sgi.com>
> 
> This may be a bit controversial but it does not seem to
> make sense to use the update_mmu_cache macro when we reuse
> the page. We are only fiddling around with the protections,
> the dirty and accessed bits.

Controversial indeed.  Just because Christoph tentatively puts forward
such a patch is no reason to include it in your dirty page series.

Probably my fault for drawing attention to the ill-defined relationship
between update_mmu_cache and more recently added lazy_mmu_prot_update,
and wondering aloud on what's different between do_wp_page and mprotect.

If you want to pursue this patch, you should address it to someone
experienced in update_mmu_cache, someone familiar with those
architectures which implement it: ideally to Dave Miller (CCed),
who designed and wrote most of Documentation/cachetlb.txt.

The answer I expect is that update_mmu_cache is essential there in
do_wp_page (reuse case) and handle_pte_fault, on at least some if
not all of those arches which implement it.  That without those
lines, they'll fault and refault endlessly, since the "MMU cache"
has not been updated with the write permission.

But omitted from mprotect, since that's dealing with a batch of
pages, perhaps none of which will be faulted in the near future:
a waste of resources to update for all those entries.

But now I wonder, why does do_wp_page reuse case flush_cache_page?

Hugh

> With the call to update_mmu_cache the way of using the macros
> would be different from mprotect() and page_mkclean(). I'd
> rather have everything work the same way. If this breaks on some
> arches then also mprotect and page_mkclean() are broken.
> The use of mprotect() is rare, we may have breakage in some
> arches that we just have not seen yet.
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  mm/memory.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> Index: 2.6-mm/mm/memory.c
> ===================================================================
> --- 2.6-mm.orig/mm/memory.c	2006-06-19 16:21:16.000000000 +0200
> +++ 2.6-mm/mm/memory.c	2006-06-19 16:21:25.000000000 +0200
> @@ -1514,7 +1514,6 @@ static int do_wp_page(struct mm_struct *
>  		entry = pte_mkyoung(orig_pte);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		ptep_set_access_flags(vma, address, page_table, entry, 1);
> -		update_mmu_cache(vma, address, entry);
>  		lazy_mmu_prot_update(entry);
>  		ret |= VM_FAULT_WRITE;
>  		goto unlock;
> @@ -2317,7 +2316,6 @@ static inline int handle_pte_fault(struc
>  	entry = pte_mkyoung(entry);
>  	if (!pte_same(old_entry, entry)) {
>  		ptep_set_access_flags(vma, address, pte, entry, write_access);
> -		update_mmu_cache(vma, address, entry);
>  		lazy_mmu_prot_update(entry);
>  	} else {
>  		/*
> 
