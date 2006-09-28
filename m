Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWI1Tj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWI1Tj6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 15:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWI1Tj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 15:39:57 -0400
Received: from excu-mxob-1.symantec.com ([198.6.49.12]:19615 "EHLO
	excu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1161028AbWI1Tj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 15:39:56 -0400
Date: Thu, 28 Sep 2006 20:39:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org, asit.k.mallick@intel.com
Subject: Re: [patch] mm: fix a race condition under SMC + COW
In-Reply-To: <20060927151507.A12423@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0609282015100.9244@blonde.wat.veritas.com>
References: <20060927151507.A12423@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2006 19:39:37.0397 (UTC) FILETIME=[D50F7650:01C6E335]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006, Siddha, Suresh B wrote:
> From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
> 
> Failing context is a multi threaded process context and the failing
> sequence is as follows.
> 
> One thread T0 doing self modifying code on page X on processor P0 and
> another thread T1 doing COW (breaking the COW setup as part of just happened
> fork() in another thread T2) on the same page X on processor P1. T0 doing SMC
> can endup modifying  the new page Y (allocated by the T1 doing COW on P1) but
> because of different I/D TLB's, P0 ITLB will not see the new mapping till
> the flush TLB IPI from  P1 is received. During this interval, if T0 executes
> the code created by SMC it can result in an app error (as ITLB still points to
> old page X and endup executing the content in page X rather than using
> the content in page Y).
> 
> Fix this issue by first clearing the PTE and flushing it, before updating it
> with new entry.
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

I was a bit sceptical, in the habit of thinking that Self Modifying Code
must look such issues itself: but I guess there's nothing it can do to
avoid this one.

Fair enough, what you're changing it to is pretty much what powerpc
and s390 were already doing, and is a more robust way of proceeding,
consistent with how ptes are set everywhere else.

The ptep_clear_flush is a bit heavy-handed (it's anxious to return
the pte that was atomically cleared), but we'd have to wander through
lots of arches to get the right minimal behaviour.  It'd also be nice
to eliminate ptep_establish completely, now only used to define other
macros/inlines: it always seemed obfuscation to me, what you've got
there now is clearer.  Let's put those cleanups on a TODO list.

Acked-by: Hugh Dickins <hugh@veritas.com>

> ---
> 
> --- linux-2.6.18/mm/memory.c.orig	2006-09-27 14:59:48.000000000 -0700
> +++ linux-2.6.18/mm/memory.c	2006-09-27 15:17:35.000000000 -0700
> @@ -1551,7 +1551,14 @@ gotten:
>  		entry = mk_pte(new_page, vma->vm_page_prot);
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
>  		lazy_mmu_prot_update(entry);
> -		ptep_establish(vma, address, page_table, entry);
> +		/*
> +		 * Clear the pte entry and flush it first, before updating the
> +		 * pte with the new entry. This will avoid a race condition
> +		 * seen in the presence of one thread doing SMC and another
> +		 * thread doing COW.
> +		 */
> +		ptep_clear_flush(vma, address, page_table);
> +		set_pte_at(mm, address, page_table, entry);
>  		update_mmu_cache(vma, address, entry);
>  		lru_cache_add_active(new_page);
>  		page_add_new_anon_rmap(new_page, vma, address);
