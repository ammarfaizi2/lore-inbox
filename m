Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269099AbRHWRG2>; Thu, 23 Aug 2001 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269119AbRHWRGS>; Thu, 23 Aug 2001 13:06:18 -0400
Received: from eamail1-out.unisys.com ([192.61.61.99]:38582 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S269099AbRHWRGK>; Thu, 23 Aug 2001 13:06:10 -0400
Message-ID: <245F259ABD41D511A07000D0B71C4CBA289F34@us-slc-exch-3.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Andrew Morton'" <akpm@zip.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: The cause of the "VM" performance problem with 2.4.X
Date: Thu, 23 Aug 2001 12:06:01 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Yes, it helps quite a bit.  Still not as good as I'd like: I don't
> > dare try lots of disks yet :-(
> 
> Great, thanks.  Aside from the lock contention and stuff, how was the
> actual disk throughput affected?  You said that the stock kernel
> basically stops doing anything, yes?

It got really bad.  It would make "progress", but slower than I
can encode the bits on the platter with a hand magnet ;-)
Now, it's only "pretty bad".

> > Looks like blkdev_put() holds kernel_flag for way too long.
> 
> It calls fsync_dev().

Right.  Which ends up calling our friend, write_unlocked_buffers(),
which does locking, but it also holds the kernel lock the entire time.

> There are two n^2 loops in buffer.c.  There's one on the 
> sync_buffers()
> path, which we fixed yesterday.  But there's also a potential 
> O(2n) path
> in balance_dirty().  So if we're calling mark_buffer_dirty() a lot,
> this becomes quadratic.  For this to bite us the BUF_DIRTY list would
> have to be "almost full" of buffers for another device.  There's also
> some weird stuff in sync_buffers() - not sure what it's trying to do.
> I'll take that up with the boss when he gets back from the polar bear
> hunt or whatever it is they do over there.
> 
> Here's a different patch which addresses the balance_dirty() thing
> as well..

It looks like the same patch as yesterday.  Did you attach the wrong
patch?  In any event, it doesn't look like it helps balance_dirty()
at all because the location is not retained across multiple calls
to write_some_buffers().

Kevin Van Maren
