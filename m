Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287357AbRL3H5W>; Sun, 30 Dec 2001 02:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287358AbRL3H5N>; Sun, 30 Dec 2001 02:57:13 -0500
Received: from mail6.speakeasy.net ([216.254.0.206]:44484 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP
	id <S287357AbRL3H5E>; Sun, 30 Dec 2001 02:57:04 -0500
Subject: Re: [PATCH *] 2.4.17 rmap based VM #9
From: safemode <safemode@speakeasy.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0112292357420.24031-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0112292357420.24031-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 30 Dec 2001 02:57:02 -0500
Message-Id: <1009699023.343.0.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems that not all of the live-deadlocks were fixed.  The one i saw in
the last version is still present.   It occurs when you're heavily
swapping out and the nall of a sudden require something to heavily swap
in (yet not have enough room to be completely in ram so it still has to
swap things out to refresh the screen in X).  that is to say in my
lowmem configuration (32MB of ram)  rmap9 still fails where the plain
kernel succeeds.  Perhaps rml's preempt patch does not play well with
the new vm,  but i doubt that's the case at all.  

summary:
	heavy swapping out then user requested large swapin 
	system response slows to a halt nearly instantly. 
	Disk activity stops and becomes non-existant, nothing responds.


I also ran some tests and looked at the graphs to the rmap9 kernel
compared to rmap8, I saw little to no difference except that it did it a
little more quickly. I think rmap has something to show when memory
allocation gets tough, but whenever i stress it, it locks up.  I'm not
going to bother making any graphs this time, it would be kind of
pointless,  something really worth seeing is the stress tests output. 

Here is the data collected anyway on the normal vm load configuration.
http://safemode.homeip.net/2.4.17-rmap9.vmstat

perhaps tomorrow sometime i'll get a chance to play with the low mem
config again.  

On Sat, 2001-12-29 at 20:58, Rik van Riel wrote:
> The 9th version of the reverse mapping based VM is now available.
> This is an attempt at making a more robust and flexible VM
> subsystem, while cleaning up a lot of code at the same time. The patch
> is available from:
> 
>            http://surriel.com/patches/2.4/2.4.17-rmap-9
> and        http://linuxvm.bkbits.net/
> 
> 
> My big TODO items for a next release are:
>   - fix page_launder() so it doesn't submit the whole
>     inactive_dirty list for writeout in one go
> 
> rmap 9:
>   - improve comments all over the place                   (Michael Cohen)
>   - don't panic if page_remove_rmap() cannot find the
>     rmap in question, it's possible that the memory was
>     PG_reserved and belonging to a driver, but the driver
>     exited and cleared the PG_reserved bit                (me)
>   - fix the VM livelock by replacing > by >= in a few
>     critical places in the pageout code                   (me)
>   - treat the reclaiming of an inactive_clean page like
>     allocating a new page, calling try_to_free_pages()
>     and/or fixup_freespace() if required                  (me)
> rmap 8:
>   - add ANY_ZONE to the balancing functions to improve
>     kswapd's balancing a bit                              (me)
>   - regularize some of the maximum loop bounds in
>     vmscan.c for cosmetic purposes                        (William Lee Irwin)
>   - move page_address() to architecture-independent
>     code, now the removal of page->virtual is portable    (William Lee Irwin)
>   - speed up free_area_init_core() by doing a single
>     pass over the pages and not using atomic ops          (William Lee Irwin)
>   - documented the buddy allocator in page_alloc.c        (William Lee Irwin)
> rmap 7:
>   - clean up and document vmscan.c                        (me)
>   - reduce size of page struct, part one                  (William Lee Irwin)
>   - add rmap.h for other archs (untested, not for ARM)    (me)
> rmap 6:
>   - make the active and inactive_dirty list per zone,
>     this is finally possible because we can free pages
>     based on their physical address                       (William Lee Irwin)
>   - cleaned up William's code a bit                       (me)
>   - turn some defines into inlines and move those to
>     mm_inline.h (the includes are a mess ...)             (me)
>   - improve the VM balancing a bit                        (me)
>   - add back inactive_target to /proc/meminfo             (me)
> rmap 5:
>   - fixed recursive buglet, introduced by directly
>     editing the patch for making rmap 4 ;)))              (me)
> rmap 4:
>   - look at the referenced bits in page tables            (me)
> rmap 3:
>   - forgot one FASTCALL definition                        (me)
> rmap 2:
>   - teach try_to_unmap_one() about mremap()               (me)
>   - don't assign swap space to pages with buffers         (me)
>   - make the rmap.c functions FASTCALL / inline           (me)
> rmap 1:
>   - fix the swap leak in rmap 0                           (Dave McCracken)
> rmap 0:
>   - port of reverse mapping VM to 2.4.16                  (me)
> 
> Rik
> -- 
> Shortwave goes a long way:  irc.starchat.net  #swl
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


