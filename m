Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293677AbSCES0Q>; Tue, 5 Mar 2002 13:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293683AbSCESZ4>; Tue, 5 Mar 2002 13:25:56 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:13324 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293677AbSCESZq>; Tue, 5 Mar 2002 13:25:46 -0500
Date: Tue, 5 Mar 2002 19:26:04 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305192604.J20606@dualathlon.random>
In-Reply-To: <20020305161032.F20606@dualathlon.random> <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203051354590.1413-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 01:57:13PM -0300, Rik van Riel wrote:
> Let me explain it to you again:
> 
> 1) ZONE_NORMAL + ZONE_DMA is low on free memory
> 
> 2) the memory is taken by buffer heads, these
>    buffer heads belong to pagecache pages that
>    live in highmem
> 
> 3) the highmem zone has enough free memory
> 
> 
> As you probably know, shrink_caches() has the following line
> of code to make sure it won't try to free highmem pages:
> 
>                 if (!memclass(page->zone, classzone))
>                         continue;
> 
> Of course, this line of code also means it will not take
> away the buffer heads from highmem pages, so the ZONE_NORMAL
> and ZONE_DMA memory USED BY THE BUFFER HEADS will not be
> freed.

I'm very sorry for not understanding your previous email, many thanks
for explaning this again since I understood perfectly this time :).
Right you are. I don't see this as a showstopper, but I think it would
be nice to do something about it in 2.4 too.

I think the best fix is to define a memclass_related() that checks
the page->buffers to see if there's any lowmem bh queued on top of such
page, the check cannot be embedded into the memclass, we need this
additional check, because we shouldn't consider a "classzone normal
progress" the freeing of a lowmem bh and furthmore we should only get
into the path of the bh-freeing, not the path of the page-freeing to
avoid throwing away highmem pagecache due a lowmem shortage. And if we
freed something significant but we think we failed (because we cannot
account the memclass_related as a progress), the .high watermark will
let us go ahead with the allocation later in page_alloc.c.

The above again fits beautifully into the classzone logic and it makes
100% sure not to waste a single page of highmem due a lowmem shortage.
It's nearly impossible that classzone collides with anything good
because classzone is the natural thing to do.

btw, I think you've the very same problem with the "plenty" logic, the
highmem zone will look as "plenty of ram free" and you won't balance it,
despite you should because otherwise the bh wouldn't be released.

The memclass_related will just make the VM accurate on those bh, and
later it can be extended to other metadata too if necessary, so we'll
always do the right thing.

Another approch would be to add the pages backing the bh into the lru
too, but then we'd need to mess with the slab and new bitflags, new
methods and so I don't think it's the best solution. The only good
reason for putting new kind of entries in the lru would be to age them
too the same way as the other pages, but we don't need that with the bh
(they're just in, and we mostly care only about the page age, not the bh
age).

Andrea
