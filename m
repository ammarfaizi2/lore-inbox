Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293555AbSCHUPv>; Fri, 8 Mar 2002 15:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310140AbSCHUPm>; Fri, 8 Mar 2002 15:15:42 -0500
Received: from rj.sgi.com ([204.94.215.100]:59542 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S293555AbSCHUP1>;
	Fri, 8 Mar 2002 15:15:27 -0500
Date: Fri, 8 Mar 2002 12:14:47 -0800 (PST)
From: Samuel Ortiz <sortiz@dbear.engr.sgi.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] stop null ptr deference in __alloc_pages
In-Reply-To: <7730000.1015616191@flay>
Message-ID: <Pine.LNX.4.33.0203081207360.18968-100000@dbear.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Fri, 8 Mar 2002, Martin J. Bligh wrote:

> Summary: Avoid null ptr defererence in __alloc_pages
> This exists in 2.4. and 2.5
>
> Configuration: a NUMA (ia32) system which only has highmem
> on one or more nodes.
>
> Action to create: Try to allocate ZONE_NORMAL memory
> from a node which only has highmem. What we should do
> is fall back to another node, looking for ZONE_NORMAL
> memory.
If you applied an SGI patch that makes the zonelist contain all the zones
of your machine, then the zonelist should not be NULL.
If you allocate memory with gfp_mask & GFP_ZONEMASK == GFP_NORMAL from a
HIGHMEM only node, then the first entry on the corresponding zonelist
should be the first NORMAL zone on some other node.
Am I missing something here ?


> In looking at the specified zonelist, we panic because that zonelist
> is NULL. The simple patch below avoids the null deference, and
> returns failure. alloc_pages will continue looking through the nodes
> until it finds one with some ZONE_NORMAL memory. We actually
> panic at the moment a few lines later when we do,
> classzone->need_balance = 1; thus dereferencing the pointer.
>
> --- linux-2.4.18-memalloc/mm/page_alloc.c.old	Fri Mar  8 18:21:41 2002
> +++ linux-2.4.18-memalloc/mm/page_alloc.c	Fri Mar  8 18:23:27 2002
> @@ -317,6 +317,8 @@
>
>  	zone = zonelist->zones;
>  	classzone = *zone;
> +	if (classzone == NULL)
> +		return NULL;
>  	min = 1UL << order;
>  	for (;;) {
>  		zone_t *z = *(zone++);
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
Thanks,
Samuel.



