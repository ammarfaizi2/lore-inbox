Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266508AbRGGR3g>; Sat, 7 Jul 2001 13:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266507AbRGGR31>; Sat, 7 Jul 2001 13:29:27 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:274 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266483AbRGGR3M>; Sat, 7 Jul 2001 13:29:12 -0400
Date: Sat, 7 Jul 2001 10:28:20 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <3B47116C.14118B9C@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33.0107071019440.31249-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 7 Jul 2001, Jeff Garzik wrote:
>
> When building gcc-2.96 RPM using gcc-2.96 under kernel 2.4.7 on alpha,
> the system goes --deeply-- into swap.  Not pretty at all.  The system
> will be 200MB+ into swap, with 200MB+ in cache!  I presume this affects
> 2.4.7-release also.

Note that "200MB+ into swap, with 200MB+ in cache" is NOT bad in itself.

It only means that we have scanned the VM, and allocated swap-space for
200MB worth of VM space. It does NOT necessarily mean that any actual
swapping has been taking place: you should realize that the "cache" is
likely to be not at least partly the _swap_ cache that hasn't been written
out.

This is an accounting problem, nothing more. It looks strange, but it's
normal.

Now, the fact that the system appears unusable does obviously mean that
something is wrong. But you're barking up the wrong tree.

Although it might be the "right tree" in the sense that we might want to
remove the swap cache from the "cached" output in /proc/meminfo. It might
be more useful to separate out "Cached" and "SwapCache": add a new line to
/proc/meminfo that is "swapper_space.nr_pages", and make the current code
that does

	atomic_read(&page_cache_size)

do

	(atomic_read(&page_cache_size) - swapper_space.nrpages)

instead. That way the vmstat output might be more useful, although vmstat
obviously won't know about the new "SwapCache:" field..

Can you try that, and see if something else stands out once the misleading
accounting is taken care of?

		Linus

