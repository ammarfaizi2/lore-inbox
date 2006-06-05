Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750761AbWFEUoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWFEUoq (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWFEUoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:44:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750761AbWFEUop (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:44:45 -0400
Date: Mon, 5 Jun 2006 13:44:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: mbligh@google.com, apw@shadowen.org, mbligh@mbligh.org,
        linux-kernel@vger.kernel.org, ak@suse.de, hugh@veritas.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060605134425.0a539836.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
References: <447DEF49.9070401@google.com>
	<20060531140652.054e2e45.akpm@osdl.org>
	<447E093B.7020107@mbligh.org>
	<20060531144310.7aa0e0ff.akpm@osdl.org>
	<447E104B.6040007@mbligh.org>
	<447F1702.3090405@shadowen.org>
	<44842C01.2050604@shadowen.org>
	<Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com>
	<44848DD2.7010506@shadowen.org>
	<Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com>
	<44848F45.1070205@shadowen.org>
	<44849075.5070802@google.com>
	<Pine.LNX.4.64.0606051325351.18717@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 13:27:11 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> 
> > Either way, random panics are not the appropriate response ;-)
> > 
> > if it can't cope with that, why isn't it failing the request ???
> 
> There is a crappy test in swap_on(). It should check against MAX_SWAPFILES 
> and not do this conversion back and forth. Some architectures may not 
> check if we are beyond the boundaries of what a swap entry can take.
> 
> Why is this strange this in there? Are there architectures that support 
> less than 32 swap devices?
> 
> Signed-off-by: Christoph Lameter <clameter@sgi.com>
> 
> Index: linux-2.6.17-rc5-mm2/mm/swapfile.c
> ===================================================================
> --- linux-2.6.17-rc5-mm2.orig/mm/swapfile.c	2006-06-01 10:03:07.127259731 -0700
> +++ linux-2.6.17-rc5-mm2/mm/swapfile.c	2006-06-05 13:24:56.000823157 -0700
> @@ -1384,6 +1384,9 @@ asmlinkage long sys_swapon(const char __
>  	struct inode *inode = NULL;
>  	int did_down = 0;
>  
> +	if (nr_swapfiles >= MAX_SWAPFILES)
> +		return -E2BIG;
> +
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  	spin_lock(&swap_lock);
> @@ -1392,22 +1395,6 @@ asmlinkage long sys_swapon(const char __
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
> -		spin_unlock(&swap_lock);
> -		goto out;
> -	}
>  	if (type >= nr_swapfiles)
>  		nr_swapfiles = type+1;
>  	INIT_LIST_HEAD(&p->extent_list);

Added writer-of-crappy-tests@de.ibm.com to cc.
