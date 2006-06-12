Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932657AbWFMABF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932657AbWFMABF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 20:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWFMABF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 20:01:05 -0400
Received: from mail04.syd.optusnet.com.au ([211.29.132.185]:404 "EHLO
	mail04.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932657AbWFMABE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 20:01:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH 19/21] swap_prefetch: Conversion of nr_unstable to ZVC
Date: Tue, 13 Jun 2006 09:57:27 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, linux-mm@kvack.org,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
References: <20060612211244.20862.41106.sendpatchset@schroedinger.engr.sgi.com> <200606130940.16956.kernel@kolivas.org> <Pine.LNX.4.64.0606121647090.22052@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606121647090.22052@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130957.28414.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 June 2006 09:48, Christoph Lameter wrote:
> On Tue, 13 Jun 2006, Con Kolivas wrote:
> > Nack. You're changing some other code unintentionally.
>
> Is this okay?

Not quite.

Remove the test_pagestate variable entirely and leave the check something 
like:

	if (!(sp_stat.prefetched_pages % SWAP_CLUSTER_MAX) &&
		above_background_load())
			goto out;

Thanks

>
> Subject: swap_prefetch: conversion of nr_unstable to per zone counter
> From: Christoph Lameter <clameter@sgi.com>
>
> The determination of the vm state is now not that expensive
> anymore after we remove the use of the page state.
> Remove the logic to avoid the expensive checks.
>
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
>
> Index: linux-2.6.17-rc6-cl/mm/swap_prefetch.c
> ===================================================================
> --- linux-2.6.17-rc6-cl.orig/mm/swap_prefetch.c	2006-06-12
> 13:37:47.283159568 -0700 +++
> linux-2.6.17-rc6-cl/mm/swap_prefetch.c	2006-06-12 16:46:48.504626417 -0700
> @@ -357,7 +357,6 @@ static int prefetch_suitable(void)
>  	 */
>  	for_each_node_mask(node, sp_stat.prefetch_nodes) {
>  		struct node_stats *ns = &sp_stat.node[node];
> -		struct page_state ps;
>
>  		/*
>  		 * We check to see that pages are not being allocated
> @@ -375,11 +374,6 @@ static int prefetch_suitable(void)
>  		} else
>  			ns->last_free = ns->current_free;
>
> -		if (!test_pagestate)
> -			continue;
> -
> -		get_page_state_node(&ps, node);
> -
>  		/* We shouldn't prefetch when we are doing writeback */
>  		if (node_page_state(node, NR_WRITEBACK)) {
>  			node_clear(node, sp_stat.prefetch_nodes);
> @@ -394,7 +388,8 @@ static int prefetch_suitable(void)
>  			node_page_state(node, NR_ANON) +
>  			node_page_state(node, NR_SLAB) +
>  			node_page_state(node, NR_DIRTY) +
> -			ps.nr_unstable + total_swapcache_pages;
> +			node_page_state(node, NR_UNSTABLE) +
> +			total_swapcache_pages;
>  		if (limit > ns->prefetch_watermark) {
>  			node_clear(node, sp_stat.prefetch_nodes);
>  			continue;

-- 
-ck
