Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262596AbREZErA>; Sat, 26 May 2001 00:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262594AbREZEqj>; Sat, 26 May 2001 00:46:39 -0400
Received: from [200.203.199.88] ([200.203.199.88]:24338 "HELO netbank.com.br")
	by vger.kernel.org with SMTP id <S262596AbREZEqa>;
	Sat, 26 May 2001 00:46:30 -0400
Date: Sat, 26 May 2001 01:45:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526051156.S9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105260137140.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:
> On Fri, May 25, 2001 at 10:49:38PM -0400, Ben LaHaise wrote:
> > Highmem.  0 free pages in ZONE_NORMAL.  Now try to allocate a buffer_head.
> 
> That's a longstanding deadlock, it was there the first time I read
> fs/buffer.c, nothing related to highmem, we have it in 2.2 too. Also
> getblk is deadlock prone in a smiliar manner.

Not only this, but the fix is _surprisingly_ simple...
All we need to make sure of is that the following order
of allocations is possible and that we back out instead
of deadlock when we don't succeed at any step.

1) normal user allocation
2) buffer allocation (bounce buffer + bufferhead)
3) allocation from interrupt (for device driver)

This is fixed by the patch I sent because:

1) user allocations stop when we reach zone->pages_min and
   keep looping until we freed some memory ... well, these
   don't just loop because we can guarantee that freeing
   memory with GFP_USER or GFP_KERNEL is possible

2) GFP_BUFFER allocations can allocate down to the point
   where free pages go to zone->pages_min * 3 / 4, so we
   can continue to swapout highmem pages when userland
   allocations have stopped ... this is needed because
   otherwise we cannot always make progress on highmem
   pages and we could have the effective amount of RAM
   in the system reduced to less than 1GB, in really bad
   cases not having this could even cause a deadlock

3) If the device driver needs to allocate something, it
   has from zone->pages_min*3/4 down to zone->pages_min/4
   space to allocate stuff, this should be very useful
   for swap or mmap() over the network, or to encrypted
   block devices, etc...

> Can you try to simply change NR_RESERVED to say 200*MAX_BUF_PER_PAGE
> and see if it makes a difference?

No Comment(tm)   *grin*

cheers,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

