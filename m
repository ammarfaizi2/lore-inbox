Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129621AbQKLUaU>; Sun, 12 Nov 2000 15:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131142AbQKLUaK>; Sun, 12 Nov 2000 15:30:10 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17160 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129621AbQKLUaB>; Sun, 12 Nov 2000 15:30:01 -0500
Date: Sun, 12 Nov 2000 21:30:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ying Chen/Almaden/IBM <ying@almaden.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: problems with sync_all_inode() in prune_icache() and kupdate()
Message-ID: <20001112213010.B11857@athlon.random>
In-Reply-To: <OFF8FB6856.584FAA00-ON88256994.0064C480@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF8FB6856.584FAA00-ON88256994.0064C480@LocalDomain>; from ying@almaden.ibm.com on Sat, Nov 11, 2000 at 11:01:25AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2000 at 11:01:25AM -0800, Ying Chen/Almaden/IBM wrote:
> try to sync_inodes periodically anyway, but I don't know if this has other
> implications or not. I don't see a problem with this myself. In fact, I

Not running sync_all_inodes() from prune_icache() has the only implication of
swapping out more stuff instead of freeing the icache (no risk to crash I
mean).

However I'm wondering what this SPEC SFS benchmark is doing to trigger
the icache shrink often.

> prune_icache(). Actually if sync_all_inodes() is called, SPEC SFS sometimes
> simply fails due to the long response time on the I/O requests.

Hmm, what do you mean with "fails"?

> The similar theory goes with kupdate() daemon. That is, since there is only
> a single thread that does the inode and buffer flushing, under high load,
> kupdate() would not get a chance to call flush_dirty_buffers() until after
> sync_inodes() is completed. But sync_inodes() can take forever since inodes
> are flushed serially to disk. Imagine how long it might take if each inode

inodes are not flushed serially to disk. Inodes are flushed to dirty buffer
cache.

the problem here isn't the flush, but it's the read that we need to do before
we can write to the buffer. The machine is probably writing heavily to disk
when that stall happens, and so the read latency is huge (even with the right
elevator latency numbers) while the I/O queue is full of writes.

> Again, the solution can be simple, one can create multiple
> dirty_buffer_flushing daemon threads that calls flush_dirty_buffer()
> without sync_super or sync_inode stuff. I have done so in my own test9
> kernel, and the results with SPEC SFS is much more pleasant.

kflushd should keep care to do the other work (flushing buffers) while the
machine is under write load so I'm a little surprised it makes much difference
to move the sync_inodes in a separate kernel thread (because from a certain
prospective it's _just_ in a separate kthread :).

That leads me to think kflushd may not be working properly but I've not yet
checked if something is changed in that area recently.

Or maybe you're writing to more than one disk at the same time and by having
two threads flushing buffers all the time in parallel allows you to keep both
disks busy (in that case that's sure not the right fix, but one possible right
fix is instead to have a per-blockdevice list of dirty buffers and to have one
kflushd per queue cloned at blkdev registration, I was discussing this
problematic with Jens a few weeks ago).

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
