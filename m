Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274758AbRIUSCk>; Fri, 21 Sep 2001 14:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274767AbRIUSCU>; Fri, 21 Sep 2001 14:02:20 -0400
Received: from zok.sgi.com ([204.94.215.101]:36229 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S274758AbRIUSCR>;
	Fri, 21 Sep 2001 14:02:17 -0400
Message-Id: <200109211803.f8LI3Vf32124@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Alexander Viro <viro@math.psu.edu>
cc: Steve Lord <lord@sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source 
In-Reply-To: Message from Alexander Viro <viro@math.psu.edu> 
   of "Thu, 20 Sep 2001 16:40:51 EDT." <Pine.GSO.4.21.0109201633530.5631-100000@weyl.math.psu.edu> 
Date: Fri, 21 Sep 2001 13:03:30 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I started writing this, and then got dragged in various other directions,
so I am sending this out as a starting point - I will also be offline until
Monday, we have to go to a wedding... so I am not ignoring responses, just
probably not reading email.

Steve

> 
> 
> On Thu, 20 Sep 2001, Steve Lord wrote:
> 

> > 
> > Since we have your attention - which chunks? One of the frustrations we hav
> e
> > had is the lack of feedback from anyone who has looked at XFS.
> 
> Locking.  There is a _lot_ of duplication between fs/namei.c and fs/xfs/* -
> you definitely don't need most of the stuff you do with locks there.

Looks like its time for the xfs locking tutorial....

I am going to walk through this in terms of the internal locks within
XFS and how they interact.

The XFS inode has two main locks, these are both multi reader, single
writer sleep locks which have some semantics beyond those provided by
the Linux i_sema lock. There is one other lock which could probably be
removed on linux - it relates to readahead state, but we are not using
the readahead code within XFS so.... the final lock is the flush lock
which is used to synchronize flush activity on the inode (only one flush
at once for an inode). These multireader locks have a couple of other
things we can do with them - trylock and demote being the two we use
right now I think.

We have the ilock and the iolock. The ilock is used to protect the core
of the inode, and the iolock is used to protect file data, the iolock
is above the ilock in the locking hierarchy, but is obtained much less
of the time.

The ilock is closely tied in with the transaction system. In general
the sequence of events when performing a transaction which modifies an
inode in xfs is as follows:

 1. obtain the ilock, do access & resource checks, fail the request
    if there are problems.

 2. drop the ilock (we cannot hold the lock whilst doing the next step)

 3. allocate a transaction and reserve the transaction space. The reason
    this cannot be performed with the lock is that reserving space in
    the log can require flushing metadata out to disk (to allow old
    log contents to be overwritten). In order to flush the metadata out to
    disk we need to ensure it is stable - which means we need a lock. So
    should an inode be at the tail of the log and we need to start 
    another transaction on it, if we held the lock across the transaction
    reserve we have a deadlock.

 4. relock the inode - reperform the checks, drop locks, cancel transaction
    and return error if things changed.

 5. start metadata modifications - all objects are locked as required and
    remain locked until the transaction is committed.

 6. commit transaction. This copies contents of the modified objects into an
    in core log buffer, the individual items are 'pinned' into memory - which
    prevents a disk write, and unlocked - which means new operations can
    access them.

 7. write log buffer to disk, this is triggered by it being full, a sync
    transaction or filesystem sync activity (write_super). On completion of
    this we move the log items into something called the active item list
    and unpin them.

 8. metadata flush, triggered by background flushing, or by step 3 above
    taking items from the active item list. The flush gets the ilock on inodes
    and the flush lock. The inode lock is held until the inode contents are
    updated in an inode buffer, the flush lock is held until the buffer
    write completes.

 9. Metadate write completes - items are removed from the active item list
    and the tail of the log is moved if required. Threads waiting for log
    space (in step 3) are woken up.

So, there are lots of places in xfs which use the ilock for synchronization
between the top half - threads in system calls, and the bottom half - the
flushing of metadata to disk. Attempting to replace the ilock in the xfs
inode with the i_sema from the linux inode is not really a straightfoward
task.

This is really a little different from the rename checks performed by
xfs. I suspect we can remove these, but really we cannot just
blindly go replacing the ilock in the xfs inode with the i_sema and
expect anything reasonable to happen.

> 
> I understand that some of that stuff may be needed for CXFS, and I would
> really like to see the description of locking requirements of that animal.

Well, the main question here would be should cxfs have to go up to the top
of the vfs layer in linux, or can it go straight into xfs. Moving some
of the current locking out of xfs would mean the former.

> 
> Parts that are needed only on IRIX since IRIX VFS is braindead should go.
> Parts that can be moved to generic code should be moved (with sane set of
> methods provided by filesystems a-la CXFS). The rest will become much simpler
> .

Brain dead is your term, I would go more for having a different design
philosopy, but yes there is still code in xfs which is not needed under
the linux vfs. I am not yet sure what could be regarded as generic, and
I am not convinced making xfs simpler is as simple as you paint it as
being.

Steve



