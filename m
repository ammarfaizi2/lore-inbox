Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbVLKSL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVLKSL6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 13:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVLKSL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 13:11:58 -0500
Received: from waste.org ([64.81.244.121]:7314 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1750763AbVLKSL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 13:11:57 -0500
Date: Sun, 11 Dec 2005 10:05:51 -0800
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] fix SLOB on x64
Message-ID: <20051211180551.GW8637@waste.org>
References: <20051211141217.GA5912@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211141217.GA5912@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 03:12:17PM +0100, Ingo Molnar wrote:
> 
> this patch fixes 32-bitness bugs in mm/slob.c. Successfully booted x64 
> with SLOB enabled. (i have switched the PREEMPT_RT feature to use the 
> SLOB allocator exclusively, so it must work on all platforms)

The patch looks fine, but what's this about using SLOB exclusively?
Fragmentation performance of SLOB is miserable on anything like a
modern desktop, I think SLOB only makes sense for small machines. The
locking also suggests dual core at most.

Anyway,

> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Acked-by: Matt Mackall <mpm@selenic.com>
> 
> Index: linux/mm/slob.c
> ===================================================================
> --- linux.orig/mm/slob.c
> +++ linux/mm/slob.c
> @@ -198,7 +198,7 @@ void kfree(const void *block)
>  	if (!block)
>  		return;
>  
> -	if (!((unsigned int)block & (PAGE_SIZE-1))) {
> +	if (!((unsigned long)block & (PAGE_SIZE-1))) {
>  		/* might be on the big block list */
>  		spin_lock_irqsave(&block_lock, flags);
>  		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next) {
> @@ -227,7 +227,7 @@ unsigned int ksize(const void *block)
>  	if (!block)
>  		return 0;
>  
> -	if (!((unsigned int)block & (PAGE_SIZE-1))) {
> +	if (!((unsigned long)block & (PAGE_SIZE-1))) {
>  		spin_lock_irqsave(&block_lock, flags);
>  		for (bb = bigblocks; bb; bb = bb->next)
>  			if (bb->pages == block) {
> @@ -326,7 +326,7 @@ void kmem_cache_init(void)
>  	void *p = slob_alloc(PAGE_SIZE, 0, PAGE_SIZE-1);
>  
>  	if (p)
> -		free_page((unsigned int)p);
> +		free_page((unsigned long)p);
>  
>  	mod_timer(&slob_timer, jiffies + HZ);
>  }

-- 
Mathematics is the supreme nostalgia of our time.
