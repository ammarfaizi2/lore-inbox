Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318122AbSFTGFg>; Thu, 20 Jun 2002 02:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318124AbSFTGFf>; Thu, 20 Jun 2002 02:05:35 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:7678 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S318122AbSFTGFc>; Thu, 20 Jun 2002 02:05:32 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Thu, 20 Jun 2002 00:03:38 -0600
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles gets large
Message-ID: <20020620060337.GJ22427@clusterfs.com>
Mail-Followup-To: Dave Hansen <haveblue@us.ibm.com>,
	Andrew Morton <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com
References: <200206200022.g5K0MKP27994@unix-os.sc.intel.com> <3D1127D6.F6988C4B@zip.com.au> <3D115563.4020402@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D115563.4020402@us.ibm.com>
User-Agent: Mutt/1.3.28i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 19, 2002  21:09 -0700, Dave Hansen wrote:
> Andrew Morton wrote:
> >The vague plan there is to replace lock_kernel with lock_journal
> >where appropriate.  But ext3 scalability work of this nature
> >will be targetted at the 2.5 kernel, most probably.
> 
> I really doubt that dropping in lock_journal will help this case very 
> much.  Every single kernel_flag entry in the lockmeter output where 
> Util > 0.00% is caused by ext3.  The schedule entry is probably caused 
> by something in ext3 grabbing BKL, getting scheduled out for some 
> reason, then having it implicitly released in schedule().  The 
> schedule() contention comes from the reacquire_kernel_lock().
> 
> We used to see plenty of ext2 BKL contention, but Al Viro did a good 
> job fixing that early in 2.5 using a per-inode rwlock.  I think that 
> this is the required level of lock granularity, another global lock 
> just won't cut it.
> http://lse.sourceforge.net/lockhier/bkl_rollup.html#getblock

There are a variety of different efforts that could be made towards
removing the BKL from ext2 and ext3.  The first, of course, would be
to have a per-filesystem lock instead of taking the BKL (I don't know
if Al has changed lock_super() in 2.5 to be a real semaphore or not).
As Andrew mentioned, there would also need to be be a per-journal lock to
ensure coherency of the journal data.  Currently the per-filesystem and
per-journal lock would be equivalent, but when a single journal device
can be shared among multiple filesystems they would be different locks.

I will leave it up to Andrew and Stephen to discuss locking scalability
within the journal layer.

Within the filesystem there can be a large number of increasingly fine
locks added - a superblock-only lock with per-group locks, or even
per-bitmap and per-inode-table(-block) locks if needed.  This would
allow multi- threaded inode and block allocations, but a sane lock
ranking strategy would have to be developed.  The bitmap locks would
only need to be 2-state locks, because you only look at the bitmaps
when you want to modify them.  The inode table locks would be read/write
locks.

If there is a try-writelock mechanism for the individual inode table
blocks you can avoid write lock contention for creations by simply
finding the first un-write-locked block in the target group's inode table
(usually in the hundreds of blocks per group for default parameters).
For inode allocation you don't really care which inode you get, as long
as you get one in the preferred group (even that isn't critical for
directory creation).  For inode deletions you will get essentially random
block locking, which is actually improved by the find-first-unlocked
allocation policy (at the expense of dirtying more inode table blocks).

Contention for the superblock lock for updates to the superblock free
block and free inode counts could be mitigated by keeping "per-group
delta buckets" in memory, that are written into the superblock only
once every few seconds or at statfs time instead of needing multiple
locks for each block/inode alloc/free.  The groups already keep their
own summary counts for free blocks and inodes.  The coherency of these
fields with the superblock on recovery would be handled at journal
recovery time (either in the kernel or e2fsck*).  Other than these two
fields there are few write updates to the superblock (on ext3 there
is also the orphan list, modified at truncate and when an open file is
unlinked and when such a file is closed).

I have even been thinking about multi-threaded directory-entry creation
in a single directory.  One nice thing about ext2/ext3 directory blocks
is that each one is self-contained and can be modified independently.
For regular ext2/ext3 directories you would only be able to do
multi-threaded deletes by having a lock for each directory block.
For creations you would need to lock the entire directory to ensure
exclusive access for a create, which is the same single-threaded behaviour
for a single directory we have today with the directory i_sem.

However, if you are using the htree indexed directory layout (which you
will be, if you care about scalable filesystem performance) then there
is only a single[**] block into which a given filename can be added, so
you can have per-block locks even for file creation.  As the number of
directory entries grows (and hence more directory blocks) the locking
becomes increasingly more fine-grained so you get better scalability
with larger directories, which is what you want.

Cheers, Andreas
[*]  If we think that we will go to any kind of per-group locking in the
     near future, the support for this could be added into e2fsck and
     existing kernels today with read support for a COMPAT flag to
     ensure maximal forwards compatibility.  On e2fsck runs we already
     validate the superblock on each boot, and the group descriptor table
     is contiguous with the superblock, so the amount of extra checking
     at boot time would be very minimal.

     The kernel already has ext[23]_count_free_{blocks,inodes} functions
     that just need a bit of tweaking to check only the descriptor
     summaries unless mounted with debug and check options, and to update
     the superblock counts at mount time if the COMPAT flag is set.

[**] In rare circumstances you may have a large number of hash collisions
     for a single hash value which fill more than one block, so an entry
     with that hash value could live in more than a single block.  This
     would need to be handled somehow (e.g. always getting the locks on
     all such blocks in order at create time; you only need a single
     block lock at delete time).
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

