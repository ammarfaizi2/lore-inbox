Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVAYBGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVAYBGp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 20:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVAYBFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 20:05:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56521 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261719AbVAYBFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 20:05:04 -0500
Date: Tue, 25 Jan 2005 01:04:57 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@zip.com.au>,
       linux-mm@kvack.org, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH] Remove special case in kmem_getpages()
Message-ID: <20050125010457.GR31455@parcelfarce.linux.theplanet.co.uk>
References: <20050124165412.GL31455@parcelfarce.linux.theplanet.co.uk> <41F5999B.3060608@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F5999B.3060608@didntduck.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 07:58:03PM -0500, Brian Gerst wrote:
> Matthew Wilcox wrote:
> >__get_free_pages() calls alloc_pages, finds the page_address() and
> >throws away the struct page *.  Slab then calls virt_to_page to get it
> >back again.  Much more efficient for slab to call alloc_pages itself,
> >as well as making the NUMA and non-NUMA cases more similarr to each other.
> 
> Here is a better patch:

I disagree.  This disables the alloc_pages_current() optimisation.
I considered this option and rejected it.

> Remove the special case of nodeid == -1.  Instead, use numa_node_id() 
> when calling cache_grow().
> 
> Signed-off-by: Brian Gerst <bgerst@didntduck.org>

> diff -urN linux-2.6.11-rc2-bk/mm/slab.c linux/mm/slab.c
> --- linux-2.6.11-rc2-bk/mm/slab.c	2005-01-22 01:58:25.000000000 -0500
> +++ linux/mm/slab.c	2005-01-24 15:35:08.000000000 -0500
> @@ -893,17 +893,11 @@
>  	int i;
>  
>  	flags |= cachep->gfpflags;
> -	if (likely(nodeid == -1)) {
> -		addr = (void*)__get_free_pages(flags, cachep->gfporder);
> -		if (!addr)
> -			return NULL;
> -		page = virt_to_page(addr);
> -	} else {
> -		page = alloc_pages_node(nodeid, flags, cachep->gfporder);
> -		if (!page)
> -			return NULL;
> -		addr = page_address(page);
> -	}
> +
> +	page = alloc_pages_node(nodeid, flags, cachep->gfporder);
> +	if (!page)
> +		return NULL;
> +	addr = page_address(page);
>  
>  	i = (1 << cachep->gfporder);
>  	if (cachep->flags & SLAB_RECLAIM_ACCOUNT)
> @@ -2065,7 +2059,7 @@
>  
>  	if (unlikely(!ac->avail)) {
>  		int x;
> -		x = cache_grow(cachep, flags, -1);
> +		x = cache_grow(cachep, flags, numa_node_id());
>  		
>  		// cache_grow can reenable interrupts, then ac could change.
>  		ac = ac_data(cachep);


-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
