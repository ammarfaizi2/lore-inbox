Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261276AbSIZNkC>; Thu, 26 Sep 2002 09:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261281AbSIZNkC>; Thu, 26 Sep 2002 09:40:02 -0400
Received: from thunk.org ([140.239.227.29]:15264 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261276AbSIZNkA>;
	Thu, 26 Sep 2002 09:40:00 -0400
Date: Thu, 26 Sep 2002 09:44:35 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jakob Oestergaard <jakob@unthought.net>,
       "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: jbd bug(s) (?)
Message-ID: <20020926134435.GA9400@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jakob Oestergaard <jakob@unthought.net>,
	"Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@zip.com.au>
References: <20020924072117.GD2442@unthought.net> <20020925173605.A12911@redhat.com> <20020926122124.GS2442@unthought.net> <20020926132723.D2721@redhat.com> <20020926125647.GT2442@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020926125647.GT2442@unthought.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2002 at 02:56:47PM +0200, Jakob Oestergaard wrote:
> I know.  What I imagined was, that there were disks out there which
> *internally* worked with smaller sector sizes, and merely presented a
> 512 byte sector to the outside world.

Actually, it's the other way around.  Most disks are internally
actually using a sector size of 32k or now even 64k.  So ideally, I'd
like to have ext2 be able to support such larger block sizes, since it
would be win from a performance perspective.  There are only two
problems with that.  First of all, we need to support tail-merging, so
small files don't cause fragmentation problems.  But this isn't an
absolute requirement, since without it a 32k block filesystem would
still be useful for a filesystem dedicates for large multimedia files
(and heck, a FAT16 filesystem would often use an 32k or larger block
size.)   

The real problem is that the current VM has an intrinsic assumption
that the blocksize is less than or equal to the page size.  It could
be possible to fake things by using an internal blocksize of 32k or
64k, but emulate a 4k blocksize to the VM layer, but provides only a
very limited benefit.  Since the VM doesn't know that the block size
is really 32k, we don't get the automatic I/O clustering.  Also, we
end up needing to use multiple buffer heads per real ext2 block (since
the VM still thinks the block size is PAGE_SIZE, not the larger ext2
block size).  So we could add larger block sizes, but it would mean
adding a huge amount of complexity for minimal gain (and if you really
want that, you can always use XFS, which pays that complexity cost).

It'd be nice to get real VM support for this, but that will almost
certainly have to wait for 2.6.

> Let's hope that none of the partitioning formats or LVM projects out
> there will misalign the filesystem so that your index actually *does*
> cross a 512 byte boundary   ;)

None of them would do anything as insane as that, not just because of
the safety issue, but because it would be a performace loss.  Just as
misaligned data accesses in memory are slower (or prohibited in some
architectures), misaligned data on disks are bad for the same reason.

> > Making parts of the disk suddenly unreadable on power-fail is
> > generally considered a bad thing, though, so modern disks go to great
> > lengths to ensure the write finishes.
> 
> Lucky us  :)

Actually, disks try so hard to ensure the write finishes that
sometimes they ensure it past the point where the memory has already
started going insane because of the low voltage during a power
failure.  This is why some people have reported extensive data loss
after just switching off the power switch.  The system was in the
midst of writing out part of the inode table, and as the voltage of
the +5 voltage rail started dipping, the memory started returning bad
results, but the DMA engine and the disk drive still had enough juice
to complete the write.  Oops.

This is one place where the physical journalling layer in ext3
actually helps us out tremendously, because before we write out a
metadata block (such as part of the inode table), it gets written to
the journal first.  So each metadata block gets written twice to disk;
once to the journal, synchronously, and then layer when we have free
time, to the disk.  This wastes some of our disk bandwidth --- which
won't be noticed if the system isn't busy, but if the workload
saturates the disk write bandwidth, then it will slow the system down.
However, this redundancy is worth it, because in the case of this
particular cause of corruption, although part of the on-disk inode
table might get corrupted on an unexpected power failure, it is also
on the journal, so the problem gets silently and automatically fixed
when the journal is run.  

Filesystems such as JFS and XFS do not use physical journaling, but
use logical journalling instead.  So they don't write the entire inode
table block to the journal, but just an abstract representation of
what changed.  This is more efficient from the standpoint of
conserving your write bandwidth, but it leaves them helpless if the
disk subsystem writes out garbage due to an unclean power failure.

Is this tradeoff worth it?  Well, arguably hardware Shouldn't Do That,
and it's not fair to require filesystems to deal with lousy hardware.
However, as I've said for a long time, the reason why PC hardware is
cheap is because PC hardware is crap, and since we live in the real
world, it's something we need to deal with.  

Also, the double write overhead which ext3 imposes is only for the
metadata, and for real-life workloads, the overhead presented is
relatively minimal.  There are some lousy benchmarks like dbench which
exaggerate the metadata costs, but they aren't really representative
of real life.  So personally, I think the tradeoffs are worth it; of
course, though, I'm biased.  :-)

							- Ted
