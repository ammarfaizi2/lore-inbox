Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSFTGtP>; Thu, 20 Jun 2002 02:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318131AbSFTGtO>; Thu, 20 Jun 2002 02:49:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313305AbSFTGtN>;
	Thu, 20 Jun 2002 02:49:13 -0400
Message-ID: <3D117BF9.3657DA1E@zip.com.au>
Date: Wed, 19 Jun 2002 23:53:45 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: Dave Hansen <haveblue@us.ibm.com>, mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, richard.a.griffiths@intel.com
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles 
 gets large
References: <200206200022.g5K0MKP27994@unix-os.sc.intel.com> <3D1127D6.F6988C4B@zip.com.au> <3D115563.4020402@us.ibm.com> <20020620060337.GJ22427@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
