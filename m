Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSFTPYo>; Thu, 20 Jun 2002 11:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSFTPYo>; Thu, 20 Jun 2002 11:24:44 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:57849 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S314938AbSFTPYn>; Thu, 20 Jun 2002 11:24:43 -0400
Message-ID: <01BDB7EEF8D4D3119D95009027AE99951B0E63E3@fmsmsx33.fm.intel.com>
From: "Griffiths, Richard A" <richard.a.griffiths@intel.com>
To: "'Andrew Morton'" <akpm@zip.com.au>,
       Andreas Dilger <adilger@clusterfs.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Subject: RE: [Lse-tech] Re: ext3 performance bottleneck as the number of s
	pindles  gets large
Date: Thu, 20 Jun 2002 08:24:40 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Sparc only had 1GB of memory so for parity we ran the Linux machine
without highmem enabled.

Richard

-----Original Message-----
From: Andrew Morton [mailto:akpm@zip.com.au]
Sent: Wednesday, June 19, 2002 11:54 PM
To: Andreas Dilger
Cc: Dave Hansen; mgross@unix-os.sc.intel.com; Linux Kernel Mailing List;
lse-tech@lists.sourceforge.net; richard.a.griffiths@intel.com
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of
spindles gets large


Andreas Dilger wrote:
> 
> On Jun 19, 2002  21:09 -0700, Dave Hansen wrote:
> > Andrew Morton wrote:
> > >The vague plan there is to replace lock_kernel with lock_journal
> > >where appropriate.  But ext3 scalability work of this nature
> > >will be targetted at the 2.5 kernel, most probably.
> >
> > I really doubt that dropping in lock_journal will help this case very
> > much.  Every single kernel_flag entry in the lockmeter output where
> > Util > 0.00% is caused by ext3.  The schedule entry is probably caused
> > by something in ext3 grabbing BKL, getting scheduled out for some
> > reason, then having it implicitly released in schedule().  The
> > schedule() contention comes from the reacquire_kernel_lock().
> >
> > We used to see plenty of ext2 BKL contention, but Al Viro did a good
> > job fixing that early in 2.5 using a per-inode rwlock.  I think that
> > this is the required level of lock granularity, another global lock
> > just won't cut it.
> > http://lse.sourceforge.net/lockhier/bkl_rollup.html#getblock
> 
> There are a variety of different efforts that could be made towards
> removing the BKL from ext2 and ext3.  The first, of course, would be
> to have a per-filesystem lock instead of taking the BKL (I don't know
> if Al has changed lock_super() in 2.5 to be a real semaphore or not).

lock_super() has been `down()' for a long time.  In 2.4, too.

> As Andrew mentioned, there would also need to be be a per-journal lock to
> ensure coherency of the journal data.  Currently the per-filesystem and
> per-journal lock would be equivalent, but when a single journal device
> can be shared among multiple filesystems they would be different locks.

Well.  First I want to know if block-highmem is in there.  If not,
then yep, we'll spend ages spinning on the BKL.  Because ext3 _is_
BKL-happy, and if a CPU takes a disk interrupt while holding the BKL
and then sits there in interrupt context copying tons of cache-cold
memory around, guess what the other CPUs will be doing?

> I will leave it up to Andrew and Stephen to discuss locking scalability
> within the journal layer.

ext3 is about 700x as complex as ext2.  It will need to be done with
some care.
 
> Within the filesystem there can be a large number of increasingly fine
> locks added - a superblock-only lock with per-group locks, or even
> per-bitmap and per-inode-table(-block) locks if needed.  This would
> allow multi- threaded inode and block allocations, but a sane lock
> ranking strategy would have to be developed.  The bitmap locks would
> only need to be 2-state locks, because you only look at the bitmaps
> when you want to modify them.  The inode table locks would be read/write
> locks.

The next steps for ext2 are: stare at Anton's next set of graphs and
then, I expect, removal of the fs-private bitmap LRUs, per-cpu buffer
LRUs to avoid blockdev mapping lock contention,  per-blockgroup locks
and removal of lock_super from the block allocator.

But there's no point in doing that while zone->lock and pagemap_lru_lock
are top of the list.  Fixes for both of those are in progress.

ext2 is bog-simple.  It will scale up the wazoo in 2.6.
 
> If there is a try-writelock mechanism for the individual inode table
> blocks you can avoid write lock contention for creations by simply
> finding the first un-write-locked block in the target group's inode table
> (usually in the hundreds of blocks per group for default parameters).

Depends on what the profile say, Andreas.  And I mean profiles - lockmeter
tends to tell you "what", not "why".   Start at the top of the list.  Fix
them by design if possible.  If not, tweak it!


-
