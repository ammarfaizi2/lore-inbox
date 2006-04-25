Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWDYBRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWDYBRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 21:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWDYBRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 21:17:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38885 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751491AbWDYBRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 21:17:52 -0400
Date: Mon, 24 Apr 2006 18:16:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: dcn@sgi.com (Dean Nelson)
Cc: tony.luck@intel.com, jes@sgi.com, avolkov@varma-el.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
Message-Id: <20060424181626.09966912.akpm@osdl.org>
In-Reply-To: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com>
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dcn@sgi.com (Dean Nelson) wrote:
>
> 
> The following patch modifies the gen_pool allocator (lib/genalloc.c) to
> utilize a bitmap scheme instead of the buddy scheme. The purpose of this
> change is to eliminate the touching of the actual memory being allocated.
> 
> Since the change modifies the interface, a change to the uncached
> allocator (arch/ia64/kernel/uncached.c) is also required.
> 
> Signed-off-by: Dean Nelson <dcn@sgi.com>
> 
> ---
> 
> Andrew,
> 
> Both Andrey Volkov and Jes Sorenson have expressed a desire that the
> gen_pool allocator not write to the memory being managed. See the
> following:
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=113518602713125&w=2
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=113533568827916&w=2

hm, fair enough.

The patch is fairly large+intrusive.  I trust it's been broadly tested?

> -unsigned long gen_pool_alloc(struct gen_pool *poolp, int size)
> +int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
> +		 int nid)
>  {
> -	int j, i, s, max_chunk_size;
> -	unsigned long a, flags;
> -	struct gen_pool_link *h = poolp->h;
> +	struct gen_pool_chunk *chunk;
> +	int nbits = size >> pool->min_alloc_order;
> +	int nbytes = sizeof(struct gen_pool_chunk) + nbits / 8;

We can use BITS_PER_BYTE rather than "8".

I have a suspicion that `nbytes' here needs to be rounded up.

> +	if (nbytes > PAGE_SIZE) {
> +		if (nid == GENALLOC_NID_NONE)
> +			chunk = vmalloc(nbytes);
> +		else
> +			chunk = vmalloc_node(nbytes, nid);
> +	} else {
> +		if (nid == GENALLOC_NID_NONE)
> +			chunk = kmalloc(nbytes, GFP_KERNEL);
> +		else
> +			chunk = kmalloc_node(nbytes, GFP_KERNEL, nid);
> +	}

I don't think GENALLOC_NID_NONE needs to exist.  If the caller passes in
`nid=-1', kmalloc_node() will do what you want.

Which is an apparently-undocumented feature...


