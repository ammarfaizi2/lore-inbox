Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWBWVMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWBWVMQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 16:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWBWVMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 16:12:16 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:61421 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751504AbWBWVMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 16:12:16 -0500
Date: Thu, 23 Feb 2006 16:10:01 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Patch 3/3] prepopulate/cache cleared pages
To: Arjan van de Ven <arjan@intel.linux.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200602231611_MC3-1-B91D-9C03@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1140686994.4672.4.camel@laptopd505.fenrus.org>

On Thu, 23 Feb 2006 at 10:29:54 +0100, Arjan van de Ven wrote:

> Index: linux-work/mm/mempolicy.c
> ===================================================================
> --- linux-work.orig/mm/mempolicy.c
> +++ linux-work/mm/mempolicy.c
> @@ -1231,6 +1231,13 @@ alloc_page_vma(gfp_t gfp, struct vm_area
>  {
>       struct mempolicy *pol = get_vma_policy(current, vma, addr);
>  
> +     if ( (gfp & __GFP_ZERO) && current->cleared_page) {
> +             struct page *addr;
> +             addr = current->cleared_page;
> +             current->cleared_page = NULL;
> +             return addr;
> +     }
> +
>       cpuset_update_task_memory_state();
>  
>       if (unlikely(pol->policy == MPOL_INTERLEAVE)) {
> @@ -1242,6 +1249,36 @@ alloc_page_vma(gfp_t gfp, struct vm_area
>       return __alloc_pages(gfp, 0, zonelist_policy(gfp, pol));
>  }
>  
> +
> +/**
> + *   prepare_cleared_page - populate the per-task zeroed-page cache
> + *
> + *   This function populates the per-task cache with one zeroed page
> + *   (if there wasn't one already)
> + *   The idea is that this (expensive) clearing is done before any
> + *   locks are taken, speculatively, and that when the page is actually
> + *   needed under a lock, it is ready for immediate use
> + */
> +
> +void prepare_cleared_page(void)
> +{
> +     struct mempolicy *pol = current->mempolicy;
> +
> +     if (current->cleared_page)
> +             return;
> +
> +     cpuset_update_task_memory_state();
> +
> +     if (!pol)
> +             pol = &default_policy;
> +     if (pol->policy == MPOL_INTERLEAVE)
> +             current->cleared_page = alloc_page_interleave(
> +                     GFP_HIGHUSER | __GFP_ZERO, 0, interleave_nodes(pol));

======> else ???

> +     current->cleared_page = __alloc_pages(GFP_USER | __GFP_ZERO,
> +                     0, zonelist_policy(GFP_USER, pol));
> +}
> +
> +
>  /**
>   *   alloc_pages_current - Allocate pages.
>   *

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert

