Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292857AbSDAC3c>; Sun, 31 Mar 2002 21:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293076AbSDAC3X>; Sun, 31 Mar 2002 21:29:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:24390 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292857AbSDAC3P>; Sun, 31 Mar 2002 21:29:15 -0500
Date: Mon, 1 Apr 2002 04:29:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Mike Galbraith <mikeg@wen-online.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
Message-ID: <20020401042909.P1331@dualathlon.random>
In-Reply-To: <3C9807AD.65EBB69C@zip.com.au> <Pine.LNX.4.10.10203311422310.2622-100000@mikeg.wen-online.de> <20020401030207.N1331@dualathlon.random> <3CA7BD46.A59532D0@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2002 at 05:52:06PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > Another possibility is that the lru could be more fair (we may better at
> > flushing dirty pages, allowing them to be discarded in lru order), I
> > assume your machine cannot take in cache a kernel tree, so there should
> > be a total cache trashing scenario.  So you may want to verify with
> > vmstat that both kernels are doing the very same amount of I/O, just to
> > be sure one of the two isn't faster because of additional fariness in
> > the lru information, and not because of slower I/O.
> 
> 2.5.x is spending significantly more CPU on I/O for smallish machines
> such as Mike's.  The extra bio allocation for each bh is showing up
> heavily.

But that should be a fixed cost for both (again assuming they're doing
the same amount of I/O, but if they aren't that's not an I/O comparison
in the first place). This is why I ignored the bio bit.

> But more significantly, something has gone wrong at the buffer
> writeback level.   Try writing a 100 meg file in 4096 byte
> write()s.  It's nice.
> 
> Now write it in 5000 byte write()s.  It's horrid.  We spend moe
> time in write_some_buffers() than in copy_*_user.  With 4096
> byte writes, write_some_buffers visits 150,000 buffers.  With
> 5000-byte writes, it visits 8,000,000.  Under lru_list_lock.
> 
> I assume what's happening is that we write to a buffer, it goes onto
> BUF_DIRTY and then balance_dirty or bdflush or kupdate moves it to
> BUF_LOCKED.  Then write(2) redirties the buffer so it is locked, dirty,
> on BUF_DIRTY, with I/O underway.   BUF_DIRTY gets flooded with locked buffers
> and we just do enormous amounts of scanning in write_some_buffers().
> 
> I haven't looked into this further yet.  Not sure why it only
> happens in 2.5.  Maybe it is happening in 2.4, but it's not as
> easy to trigger for some reason.
>
> But I don't think there's anything to prevent this from happening
> in 2.4 is there?

The dirty buffer should be inserted at the end, so it should be marked
dirty the second time around, before we had a chance to start the I/O on
it. We should start writing the first buffers at the top of the list,
after we just rewritten it before starting the I/O.  That is what should
mitigate the badness of the O(N) algorithm avoiding a flood of
dirty+locked buffers at the top of the list, maybe 2.5 simply writout
the whole list as fast as possible without stopping after some rasonable
amount of work done (bdflush breakage) or it balances way too early.
Any of those errors could lead 2.5 into submitting the buffer for the
I/O before it had a chance to be rewritten-in-cache while it was still
only dirty. My async flushing changes or any equivalent well balanced
logic, will hopefully avoid such a bad behaviour.

> Also, I've been *trying* to get some decent I/O bandwidth on my test
> box, but 2.4 badness keeps on getting in the way.  bounce_end_io_read()
> is being particularly irritating.  It's copying tons of data
> which has just come in from PCI while inside io_request_lock.  Ugh.
> 
> Is there any reason why we can't drop io_request_lock around the
> completion handler in end_that_request_first()?

You can apply the 00_block-highmem patch from 2.4.19pre5aa1, that will
apply cleanly to vanilla 2.4.19pre5 too, it will avoid the bounces on
all common high end hardware.

Andrea
