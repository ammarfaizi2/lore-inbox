Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268376AbTBYVD6>; Tue, 25 Feb 2003 16:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268377AbTBYVD6>; Tue, 25 Feb 2003 16:03:58 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:37512 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S268376AbTBYVD4>; Tue, 25 Feb 2003 16:03:56 -0500
Date: Tue, 25 Feb 2003 21:15:56 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Jonah Sherman <jsherman@stuy.edu>
cc: Andrew Morton <akpm@digeo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.5.63 - NULL pointer dereference in loop device
In-Reply-To: <20030224212530.GA631@j0nah.ath.cx>
Message-ID: <Pine.LNX.4.44.0302252059370.1430-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Jonah Sherman wrote:

> I have come across a bug in the loop driver.  To reproduce this bug,
> simply do:
> losetup /dev/loop0 /dev/[sh]da(some unused partition)
> dd if=/dev/zero of=/dev/loop0
> If you use the count/bs args for dd, or just wait for it to write alot
> with the above command, you will notice that once it writes more
> than the free amount of RAM, you will get the following oops.
> The strange thing is, this ONLY occurs when attaching the loop device 
> to another block device(well, I only tested with an unused partition); 
> this bug does NOT occur if the loop target is a regular file on the
> filesystem.  I'm a very newbie kernel hacker, so I am not able to create
> a patch to fix this.  However, I did trace the oops to
> drivers/block/loop.c:loop_get_buffer(): (kernel 2.5.63, however same
> bug is in 2.5.62, I don't know when it was first introduced)
> 
> bio=bio_copy(rbh,GFP_NOIO,rbh->bi_rw & WRITE); // This returns NULL
> bio->bi_end_io = loop_end_io_transfer; // Making this crash

I can't reproduce this, and I don't understand it: please help me!

If you "losetup /dev/loop0 /dev/hdN", then it's LO_FLAGS_BH_REMAP
and doesn't even call bio_copy: it doesn't copy bio or buffers or
pages (unless you have highmem, which you don't mention: then its
pointless wasteful blk_queue_bounce might cause trouble), it's a
straight route through to disk, which should be using mempools
to complete i/o even if the rest of the system is out of memory.

Of course the loop driver is wrong to ignore NULL return from bio_copy
(if you used losetup -e), and there's a lot of unnecessary allocation
and copying and a lot of opportunity for deadlock, for which I have
some perpetually unfinished patches.

But the loop to disk is relatively straightforward, pdflush should
take care of the dirty pages Andrew worries about (though in writing
to blockdev when there's highmem, pdflush may kick in too late); and
I couldn't even reproduce your oops using "-e xor".

Can you shed more light on how to reproduce this?
Thanks,
Hugh

