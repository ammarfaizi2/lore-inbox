Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292588AbSDAByj>; Sun, 31 Mar 2002 20:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292666AbSDABya>; Sun, 31 Mar 2002 20:54:30 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:26386 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S292588AbSDAByM>; Sun, 31 Mar 2002 20:54:12 -0500
Message-ID: <3CA7BD46.A59532D0@zip.com.au>
Date: Sun, 31 Mar 2002 17:52:06 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Mike Galbraith <mikeg@wen-online.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: -aa VM splitup
In-Reply-To: <3C9807AD.65EBB69C@zip.com.au> <Pine.LNX.4.10.10203311422310.2622-100000@mikeg.wen-online.de> <20020401030207.N1331@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> Another possibility is that the lru could be more fair (we may better at
> flushing dirty pages, allowing them to be discarded in lru order), I
> assume your machine cannot take in cache a kernel tree, so there should
> be a total cache trashing scenario.  So you may want to verify with
> vmstat that both kernels are doing the very same amount of I/O, just to
> be sure one of the two isn't faster because of additional fariness in
> the lru information, and not because of slower I/O.

2.5.x is spending significantly more CPU on I/O for smallish machines
such as Mike's.  The extra bio allocation for each bh is showing up
heavily.

But more significantly, something has gone wrong at the buffer
writeback level.   Try writing a 100 meg file in 4096 byte
write()s.  It's nice.

Now write it in 5000 byte write()s.  It's horrid.  We spend moe
time in write_some_buffers() than in copy_*_user.  With 4096
byte writes, write_some_buffers visits 150,000 buffers.  With
5000-byte writes, it visits 8,000,000.  Under lru_list_lock.

I assume what's happening is that we write to a buffer, it goes onto
BUF_DIRTY and then balance_dirty or bdflush or kupdate moves it to
BUF_LOCKED.  Then write(2) redirties the buffer so it is locked, dirty,
on BUF_DIRTY, with I/O underway.   BUF_DIRTY gets flooded with locked buffers
and we just do enormous amounts of scanning in write_some_buffers().

I haven't looked into this further yet.  Not sure why it only
happens in 2.5.  Maybe it is happening in 2.4, but it's not as
easy to trigger for some reason.

But I don't think there's anything to prevent this from happening
in 2.4 is there?

Also, I've been *trying* to get some decent I/O bandwidth on my test
box, but 2.4 badness keeps on getting in the way.  bounce_end_io_read()
is being particularly irritating.  It's copying tons of data
which has just come in from PCI while inside io_request_lock.  Ugh.

Is there any reason why we can't drop io_request_lock around the
completion handler in end_that_request_first()?

-
