Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbWFFS2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbWFFS2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 14:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbWFFS2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 14:28:42 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:28299 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750915AbWFFS2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 14:28:41 -0400
Date: Tue, 6 Jun 2006 11:28:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, mbligh@google.com,
       apw@shadowen.org, mbligh@mbligh.org, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: 2.6.17-rc5-mm1
In-Reply-To: <Pine.LNX.4.64.0606061909360.31871@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0606061125120.28346@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com>  <20060531140652.054e2e45.akpm@osdl.org>
 <447E104B.6040007@mbligh.org>  <447F1702.3090405@shadowen.org>
 <44842C01.2050604@shadowen.org>  <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
  <44848DD2.7010506@shadowen.org>  <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
  <44848F45.1070205@shadowen.org> <44849075.5070802@google.com> 
 <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0606051334010.18717@schroedinger.engr.sgi.com> 
 <20060605135812.30138205.akpm@osdl.org>  <Pine.LNX.4.64.0606060537460.6045@blonde.wat.veritas.com>
  <Pine.LNX.4.64.0606060923250.27550@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0606061805380.28806@blonde.wat.veritas.com> 
 <Pine.LNX.4.64.0606061023080.27969@schroedinger.engr.sgi.com> 
 <Pine.LNX.4.64.0606061850001.30030@blonde.wat.veritas.com>
 <1149617155.29059.74.camel@localhost> <Pine.LNX.4.64.0606061909360.31871@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So it seems that this issue was page migration specific. Patch 
would need to go with the swapless-pm-add-r-w-migration-entries.patch

Acked-by: Christoph Lameter <clameter@sgi.com>

> Remove unnecessary obfuscation from sys_swapon's range check on swap
> type, which blew up causing memory corruption once swapless migration
> made MAX_SWAPFILES no longer 2 ^ MAX_SWAPFILES_SHIFT.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> --- 2.6.17-rc5-mm3/mm/swapfile.c	2006-06-04 11:52:47.000000000 +0100
> +++ linux/mm/swapfile.c	2006-06-06 19:08:51.000000000 +0100
> @@ -1392,19 +1392,7 @@ asmlinkage long sys_swapon(const char __
>  		if (!(p->flags & SWP_USED))
>  			break;
>  	error = -EPERM;
> -	/*
> -	 * Test if adding another swap device is possible. There are
> -	 * two limiting factors: 1) the number of bits for the swap
> -	 * type swp_entry_t definition and 2) the number of bits for
> -	 * the swap type in the swap ptes as defined by the different
> -	 * architectures. To honor both limitations a swap entry
> -	 * with swap offset 0 and swap type ~0UL is created, encoded
> -	 * to a swap pte, decoded to a swp_entry_t again and finally
> -	 * the swap type part is extracted. This will mask all bits
> -	 * from the initial ~0UL that can't be encoded in either the
> -	 * swp_entry_t or the architecture definition of a swap pte.
> -	 */
> -	if (type > swp_type(pte_to_swp_entry(swp_entry_to_pte(swp_entry(~0UL,0))))) {
> +	if (type >= MAX_SWAPFILES) {
>  		spin_unlock(&swap_lock);
>  		goto out;
>  	}
> 
