Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbREZP1p>; Sat, 26 May 2001 11:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261274AbREZP1g>; Sat, 26 May 2001 11:27:36 -0400
Received: from [209.10.41.242] ([209.10.41.242]:44720 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261351AbREZP1Y>;
	Sat, 26 May 2001 11:27:24 -0400
Date: Sat, 26 May 2001 17:20:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526172002.Z9634@athlon.random>
In-Reply-To: <20010526170306.X9634@athlon.random> <Pine.LNX.4.21.0105261206260.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="QKdGvSO+nmPlgiQ/"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105261206260.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 12:08:34PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 26, 2001 at 12:08:34PM -0300, Rik van Riel wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> > Others agreed that the real source of the create_buffers could be just
> > too few reserved pages in the unused_list
> 
> To quote you, from the message to which I replied with the
> "No Comment" comment:
> 
> ------> Andrea Arcangeli wrote:
> Anything supposed to work because there's enough memory between
> zone->pages_min*3/4 and zone->pages_min/4 is just obviously broken
> period.
> ------

What are you smoking again? You said "No Comment(tm)   *grin*" to my
suggestion to increase NR_RESERVED (attached).

Andrea

--QKdGvSO+nmPlgiQ/
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <riel@conectiva.com.br>
Received: from Hermes.suse.de (Hermes.suse.de [10.10.96.4])
	by Wotan.suse.de (Postfix) with ESMTP id 7D0301C825C
	for <andrea@wotan.suse.de>; Sat, 26 May 2001 06:45:32 +0200 (CEST)
Received: by Hermes.suse.de (Postfix)
	id 783FB5D83D; Sat, 26 May 2001 06:45:32 +0200 (MEST)
Received: from Cantor.suse.de (ns.suse.de [213.95.15.193])
	by Hermes.suse.de (Postfix) with ESMTP id 736D35D83C
	for <andrea@suse.de>; Sat, 26 May 2001 06:45:32 +0200 (MEST)
Received: from netbank.com.br (garrincha.netbank.com.br [200.203.199.88])
	by Cantor.suse.de (Postfix) with ESMTP id 53F8E1E071
	for <andrea@suse.de>; Sat, 26 May 2001 06:45:31 +0200 (MEST)
Received: from surriel.ddts.net (1-029.ctame701-1.telepar.net.br [200.181.137.29])
	by netbank.com.br (Postfix) with ESMTP
	id C098446814; Sat, 26 May 2001 01:44:50 -0300 (BRST)
Received: from localhost (uctkny@localhost [127.0.0.1])
	by surriel.ddts.net (8.11.3/8.11.2) with ESMTP id f4Q4jSu09857;
	Sat, 26 May 2001 01:45:28 -0300
Date: Sat, 26 May 2001 01:45:27 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-Sender: riel@imladris.rielhome.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ben LaHaise <bcrl@redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526051156.S9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105260137140.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII

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


--QKdGvSO+nmPlgiQ/--
