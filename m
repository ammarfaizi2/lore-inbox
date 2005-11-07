Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965082AbVKGUfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965082AbVKGUfi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 15:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVKGUfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 15:35:38 -0500
Received: from hera.kernel.org ([140.211.167.34]:16030 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965082AbVKGUfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 15:35:37 -0500
Date: Mon, 7 Nov 2005 13:33:37 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nikita Danilov <nikita@clusterfs.com>
Subject: Re: [PATCH 3/3] vm: writeout watermarks
Message-ID: <20051107153337.GB17246@logos.cnet>
References: <4366FA9A.20402@yahoo.com.au> <4366FAF5.8020908@yahoo.com.au> <4366FB24.5010507@yahoo.com.au> <4366FB4B.9000103@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4366FB4B.9000103@yahoo.com.au>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nikita has a customer using large percentage of RAM for 
a kernel module, which results in get_dirty_limits() misbehaviour
since

        unsigned long available_memory = total_pages;

It should work on the amount of cacheable pages instead.

He's got a patch but I dont remember the URL. Nikita?

On Tue, Nov 01, 2005 at 04:21:15PM +1100, Nick Piggin wrote:
> 3/3
> 
> -- 
> SUSE Labs, Novell Inc.
> 

> Slightly change the writeout watermark calculations so we keep background
> and synchronous writeout watermarks in the same ratios after adjusting them.
> This ensures we should always attempt to start background writeout before
> synchronous writeout.
> 
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> 
> Index: linux-2.6/mm/page-writeback.c
> ===================================================================
> --- linux-2.6.orig/mm/page-writeback.c	2005-11-01 13:41:39.000000000 +1100
> +++ linux-2.6/mm/page-writeback.c	2005-11-01 14:29:27.000000000 +1100
> @@ -165,9 +165,11 @@ get_dirty_limits(struct writeback_state 
>  	if (dirty_ratio < 5)
>  		dirty_ratio = 5;
>  
> -	background_ratio = dirty_background_ratio;
> -	if (background_ratio >= dirty_ratio)
> -		background_ratio = dirty_ratio / 2;
> +	/*
> +	 * Keep the ratio between dirty_ratio and background_ratio roughly
> +	 * what the sysctls are after dirty_ratio has been scaled (above).
> +	 */
> +	background_ratio = dirty_background_ratio * dirty_ratio/vm_dirty_ratio;
>  
>  	background = (background_ratio * available_memory) / 100;
>  	dirty = (dirty_ratio * available_memory) / 100;

