Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbREZCj0>; Fri, 25 May 2001 22:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbREZCjQ>; Fri, 25 May 2001 22:39:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:48694 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S262545AbREZCjE>; Fri, 25 May 2001 22:39:04 -0400
Date: Sat, 26 May 2001 04:38:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ben LaHaise <bcrl@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526043835.R9634@athlon.random>
In-Reply-To: <20010526035936.P9634@athlon.random> <Pine.LNX.4.33.0105252206550.3806-100000@toomuch.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0105252206550.3806-100000@toomuch.toronto.redhat.com>; from bcrl@redhat.com on Fri, May 25, 2001 at 10:11:40PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 10:11:40PM -0400, Ben LaHaise wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> > Now if you send some debugging info with deadlocks you gets with 2.4.5
> > vanilla I will be certainly interested to found their source. Also Rik
> > just said to have a fix for other bugs in that area, I didn't checked
> > that part.
> 
> In the red hat tree, we fixed the problem by adding __GFP_FAIL to
> GFP_BUFFER, as well as adding a yield to alloc_pages.  Think of what
> happens when you try to allocate a buffer_head to swap out a page when
> you're out of memory.  See below.

Allocating a buffer head during out of memory is always been deadlock
prone, 2.2 always had the same problem too. I'm not sure why you are
telling me this, I didn't changed anything that happens to be in the
swapout path (besides removing the deadlock in create_bounces with
evolution of first Ingo's patch but that is not specific to the
swapout). I only changed the getblk path (which is not used by the
swapout, at least unless you swapout on a file not on a blkdev, but even
in that case the change is fine).

About yelding interally to alloc_pages it would make sense if we
had a private pool internally to the allocator, otherwise with current
code you definitely want to return a faliure fast to the caller so the
caller will try the private pool before the yield.

btw in the below patch __GFP_FAIL is a noop.

> 
> 		-ben
> 
> diff -ur v2.4.4-ac9/include/linux/mm.h work/include/linux/mm.h
> --- v2.4.4-ac9/include/linux/mm.h	Mon May 14 15:22:17 2001
> +++ work/include/linux/mm.h	Mon May 14 18:33:21 2001
> @@ -528,7 +528,7 @@
> 
> 
>  #define GFP_BOUNCE	(__GFP_HIGH | __GFP_FAIL)
> -#define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT)
> +#define GFP_BUFFER	(__GFP_HIGH | __GFP_FAIL | __GFP_WAIT)
>  #define GFP_ATOMIC	(__GFP_HIGH)
>  #define GFP_USER	(             __GFP_WAIT | __GFP_IO)
>  #define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHMEM)
> diff -ur v2.4.4-ac9/mm/vmscan.c work/mm/vmscan.c
> --- v2.4.4-ac9/mm/vmscan.c	Mon May 14 14:57:00 2001
> +++ work/mm/vmscan.c	Mon May 14 16:43:05 2001
> @@ -636,6 +636,12 @@
>  	 */
>  	shortage = free_shortage();
>  	if (can_get_io_locks && !launder_loop && shortage) {
> +		if (gfp_mask & __GFP_WAIT) {
> +			__set_current_state(TASK_RUNNING);
> +			current->policy |= SCHED_YIELD;
> +			schedule();
> +		}
> +
>  		launder_loop = 1;
> 
>  		/*
> 


Andrea
