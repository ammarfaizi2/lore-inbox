Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262501AbTIUSfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 14:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTIUSfR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 14:35:17 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:44302 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262501AbTIUSfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 14:35:05 -0400
Date: Sun, 21 Sep 2003 15:37:40 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Andrea Arcangeli <andrea@suse.de>
cc: Shantanu Goel <sgoel01@yahoo.com>, <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: A couple of 2.4.23-pre4 VM nits
In-Reply-To: <20030921024649.GB16294@velociraptor.random>
Message-ID: <Pine.LNX.4.44.0309211533310.18223-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Sep 2003, Andrea Arcangeli wrote:

> Hi Shantanu,
> 
> On Sat, Sep 20, 2003 at 06:39:30AM -0700, Shantanu Goel wrote:
> > Hi Andrea,
> > 
> > The VM fixes perform rather well in my testing
> > (thanks!), but I noticed a couple of glitches that the
> > attached patch addresses.
> > 
> > 1. max_scan is never decremented in shrink_cache().  I
> > am assuming this is a typo.
> 
> this is an huge half-merging error, no surprise Andi run into vm
> troubles with pre4. My tree looks like this for years:
> 
> 		if (unlikely(!page_count(page)))
> 			continue;
> 
> 		only_metadata = 0;
> 		if (!memclass(page_zone(page), classzone)) {
> 			/*
> 			 * Hack to address an issue found by Rik. The
> 			 * problem is that
> 			 * highmem pages can hold buffer headers
> 			 * allocated
> 			 * from the slab on lowmem, and so if we are
> 			 * working
> 			 * on the NORMAL classzone here, it is correct
> 			 * not to
> 			 * try to free the highmem pages themself (that
> 			 * would be useless)
> 			 * but we must make sure to drop any lowmem
> 			 * metadata related to those
> 			 * highmem pages.
> 			 */
> 			if (page->buffers && page->mapping) { /* fast
> path racy check */
> 				if (unlikely(TryLockPage(page)))
> 					continue;
> 				if (page->buffers && page->mapping &&
> memclass_related_bhs(page, classzone)) { /* non racy check */
> 					only_metadata = 1;
> 					goto free_bhs;
> 				}
> 				UnlockPage(page);
> 			}
> 			continue;
> 		}
> 
> 		max_scan--;
> 
> max_scan-- should happen only after the memclass check to ensure not
> failing too early on GFP_KERNEL/DMA allocations (i.e. no highmem)
> 
> This is the right fix:
> 
> --- 2.4.23pre4/mm/vmscan.c.~1~	2003-09-13 00:08:04.000000000 +0200
> +++ 2.4.23pre4/mm/vmscan.c	2003-09-21 04:40:12.000000000 +0200
> @@ -401,6 +401,8 @@ static int shrink_cache(int nr_pages, zo
>  		if (!memclass(page_zone(page), classzone))
>  			continue;
>  
> +		max_scan--;
> +
>  		/* Racy check to avoid trylocking when not worthwhile */
>  		if (!page->buffers && (page_count(page) != 1 || !page->mapping))
>  			goto page_mapped;

Right! Thanks Andrea. 

Sorry for the merge mistake people. Shame on me.

Im going to release pre5 now with this. 

