Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933112AbWKMW4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933112AbWKMW4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 17:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933123AbWKMW4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 17:56:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:31104 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S933112AbWKMW4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 17:56:41 -0500
Date: Mon, 13 Nov 2006 14:56:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kirill Korotaev <dev@openvz.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devel@openvz.org,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH]: OOM can panic due to processes stuck in
 __alloc_pages()
Message-Id: <20061113145638.1fe2ac78.akpm@osdl.org>
In-Reply-To: <4558C3EB.1070400@openvz.org>
References: <4558C3EB.1070400@openvz.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006 22:13:47 +0300
Kirill Korotaev <dev@openvz.org> wrote:

> OOM can panic due to the processes stuck in __alloc_pages()
> doing infinite rebalance loop while no memory can be reclaimed.
> OOM killer tries to kill some processes, but unfortunetaly,
> rebalance label was moved by someone below the TIF_MEMDIE check,
> so buddy allocator doesn't see that process is OOM-killed
> and it can simply fail the allocation :/
> 
> Observed in reality on RHEL4(2.6.9)+OpenVZ kernel when a user doing
> some memory allocation tricks triggered OOM panic.
> 
> Signed-Off-By: Denis Lunev <den@sw.ru>
> Signed-Off-By: Kirill Korotaev <dev@openvz.org>
> 
> --- ./mm/page_alloc.c.oomx	2006-11-08 17:44:16.000000000 +0300
> +++ ./mm/page_alloc.c	2006-11-13 21:57:33.000000000 +0300
> @@ -1251,6 +1251,7 @@ restart:
>  
>  	/* This allocation should allow future memory freeing. */
>  
> +rebalance:
>  	if (((p->flags & PF_MEMALLOC) || unlikely(test_thread_flag(TIF_MEMDIE)))
>  			&& !in_interrupt()) {
>  		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
> @@ -1272,7 +1273,6 @@ nofail_alloc:
>  	if (!wait)
>  		goto nopage;
>  
> -rebalance:
>  	cond_resched();
>  
>  	/* We now go into synchronous reclaim */

Your patch reverts a change made by Nick's
a457c255ae59b5f7f52f63fc88d5e530101772c6 two years ago.

It looks right to me, but the original change was unchangelogged and I
wonder what it was aiming to do?

