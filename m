Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbULGV05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbULGV05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 16:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbULGV05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 16:26:57 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35984 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261871AbULGV0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 16:26:55 -0500
Date: Tue, 7 Dec 2004 22:26:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Katrina Tsipenyuk <ytsipenyuk@fortifysoftware.com>,
       katrina@fortifysoftware.com, Mark Hemment <markhe@nextd.demon.co.uk>,
       akpm@osdl.org
Subject: Re: [PATCH][2/2] fix unchecked returns from kmalloc() (in mm/slab.c)
Message-ID: <20041207212603.GC10083@suse.de>
References: <Pine.LNX.4.61.0412072213320.3320@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412072213320.3320@dragon.hygekrogen.localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07 2004, Jesper Juhl wrote:
> 
> Problem reported by Katrina Tsipenyuk and the Fortify Software engineering
> team in thread with subject "PROBLEM: unchecked returns from kmalloc() in
> linux-2.6.10-rc2".
> 
> Unfortunately I'm not very familliar with the code in question, and since 
> I didn't find a really good way to deal with a failing kmalloc() here I 
> settled for second best which is to add a BUG_ON() in case kmalloc fails. 
> This will at least crash in a sane way at the point the problem occoures 
> rather than getting strange problems at a (possibly) later time. If 
> someone who's familliar with how this code works has a better solution 
> then please step forward :) but in the mean time I think this is at least 
> a slight improvement over the current situation.
> 
> Patch has been compile tested and boot tested and didn't blow up 
> instantly, but please review before applying.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-rc3-bk2-orig/mm/slab.c linux-2.6.10-rc3-bk2/mm/slab.c
> --- linux-2.6.10-rc3-bk2-orig/mm/slab.c	2004-12-06 22:24:56.000000000 +0100
> +++ linux-2.6.10-rc3-bk2/mm/slab.c	2004-12-07 21:27:20.000000000 +0100
> @@ -804,6 +804,7 @@ void __init kmem_cache_init(void)
>  		void * ptr;
>  		
>  		ptr = kmalloc(sizeof(struct arraycache_init), GFP_KERNEL);
> +		BUG_ON(ptr == NULL);	/* FIXME: Can a failed kmalloc be handled better? */
>  		local_irq_disable();
>  		BUG_ON(ac_data(&cache_cache) != &initarray_cache.cache);
>  		memcpy(ptr, ac_data(&cache_cache), sizeof(struct arraycache_init));

This is pointless, as a NULL deref on memcpy will give you the exact
same info.

-- 
Jens Axboe

