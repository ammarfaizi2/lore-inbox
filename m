Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129546AbRBVI5X>; Thu, 22 Feb 2001 03:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbRBVI5S>; Thu, 22 Feb 2001 03:57:18 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:45954 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S129546AbRBVI5F>; Thu, 22 Feb 2001 03:57:05 -0500
Date: Thu, 22 Feb 2001 09:03:37 +0000 (GMT)
From: Mark Hemment <markhe@veritas.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: [PATCH] nfsd + scalability
In-Reply-To: <14996.23434.271569.212657@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0102220828220.11260-100000@alloc>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2001, Neil Brown wrote:

> On Sunday February 18, markhe@veritas.com wrote:
> > Hi Neil, all,
> > 
> >   The nfs daemons run holding the global kernel lock.  They still hold
> > this lock over calls to file_op's read and write.
> > [snip]
> >   Dropping the kernel lock around read and write in fs/nfsd/vfs.c is a
> > _big_ SMP scalability win!
> 
> Certainly I would like to not hold the BKL so much, but I'm curious
> how much effect it will really have.  Do you have any data on the
> effect of this change?

  Depends very much on the hardware configuration, and underlying
filesystem.
  On an I/O bound system, obviously this has little effect.

  Using a filesystem which has a quite deep stack (CPU cycle heavy),
this is a big win.  I've been running with this for so long that I can't
find my original data files at the moment, but it was around +8%
improvment in throughput for a 4-way box under SpecFS with vxfs as the
underlying filesystem.  Less benefit for ext2 (all filesystems NFS
exported "sync" and "no_subtree_check").  Some of the benefit came from
the fact that there is also a volume manager sitting under the filesystem
(more CPU cycles with the kernel lock held!).

  Holding the kernel lock for less cycles has an important side benefit!
  If it is held for less cycles, then the probability of it being held
when an interrupt is processed is reduced.  This benefit is further
enhanced if there are bottom-halfs running off the back of the interrupt
(such as networking code).
  I need to get actual figures for how many cycles are we spinning at the
reacquire_kernel_lock() (in schedule()), but my gut feeling is that we
aren't doing too well when running as a file server.

> Also, I would much rather drop the lock in nfsd_dispatch() and then go
> around reclaiming it whereever it was needed.
> Subsequently we would drop the lock in nfsd() and make sure sunrpc is
> safe.

  sunrpc definitely tries to be SMP safe, I haven't convienced myself that
it actually is.
  In sunrpc, dropping the kernel lock when checksuming the UDP packet, and
when sending, is another win-win case (again, need to find my data files,
but this was approx +3% improvement in throughput).

> This would be more work (any volunteers?:-) but I feel that dropping
> it in little places like this is a bit unsatisfying.

  True, not 100% satisfying, but even little places give an overall
improvement in  scalability.  If they can be proved to be correct, then
why not do it?  It moves the code in the right direction.

  I am planning on slow expanding the dropping of the kernel lock within
NFS, rather than do it in one single bang.  It looks do able, but there
_might_ be an issue with the interaction with the dcache.

Mark

