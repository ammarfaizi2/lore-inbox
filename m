Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSEPPSF>; Thu, 16 May 2002 11:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313416AbSEPPSE>; Thu, 16 May 2002 11:18:04 -0400
Received: from pc-62-31-66-178-ed.blueyonder.co.uk ([62.31.66.178]:17283 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S313187AbSEPPSB>; Thu, 16 May 2002 11:18:01 -0400
Date: Thu, 16 May 2002 16:17:49 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Thoughts on using fs/jbd from drivers/md
Message-ID: <20020516161749.D2410@redhat.com>
In-Reply-To: <15587.18828.934431.941516@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 16, 2002 at 03:54:20PM +1000, Neil Brown wrote:
 
>   You mentioned to me some time ago the idea of using jbd to journal
>   RAID5 changes so as to improve recovery for raid5 from a crash.

Yes.  It just so happens that I've been swamped with maintenance stuff
recently but it looks like that's done with now --- I've got a patch
ready for the new ext3 version --- and I'm about to start on new
development bits and pieces myself.  One of the things on the list for
that is adding the necessary support to allow multiple disks to be
listed in the journal at once (I want that to allow different ext3
filesystems to share the same external journal disk), and that work
would be relevant to raid5 journaling too.

Oh, and my main test box has now got a Cenatek Rocket Drive
solid-state PCI memory card in it, so I can test this with a
zero-seek-cost shared journal, too. :-)

> The basic idea is to provide journaling for md/RAID arrays.  There
> are two reasons that one might want to do this:
>  1/ crash recovery.  Both raid1 and raid5 need to reconstruct the
>    redundancy after a crash.  For a degraded raid5 array, this is not
>    possible and you can suffer undetected data corruption.
>    If we have a journal of recent changes we can avoid the
>    reconstruction and the risk of corruption.

Right.  The ability of soft raid5 to lose data in degraded mode over a
reboot (including data that was not being modified at the time of the
crash) is something that is not nearly as widely understood as it
should be, and I'd love for us to do something about it.

>  2/ latency reduction.  If the journal is on a small, fast device
>    (e.g. NVRAM) then you can get greatly reduced latency (like ext3 with
>    data=journal).   This could benefit any raid level and would
>    effectively provide a write-behind cache.

Yep.  This already works a treat for ext3.

> A/ where to put the journal.
>  Presumably JBD doesn't care where the journal is.

Correct.  There are basically two choices --- you either give it an
inode, and it uses bmap to map the inode to a block device; or you
give it a block device and an offset.  The journal must be logically
contiguous, and its length is encoded in the superblock when you
create the journal.

>  The only other requirement that the JBD places would be a correct jbd
>  superblock at the start.  Would that be right?

Yes, although there is kernel code to create a new journal superblock
from scratch (all of the journal IO code is there already, so
journal_create is a tiny function to add on top of that.)

>  The md module could - at array configuration time - reserve the
>  head (or tail) of the array for a journal.  This wouldn't work for
>  raid5 - you would need to reserve the first (or last) few stripes and
>  treat them as raid1 so that there is no risk of data loss.  
>  I'm not sure how valuable having a journal on the main raid devices
>  would be though as it would probably kill performance...

It would depend on the workload.  For raid1 you'd be doubling the
number of IOs for writes, but because the journal writes are
sequential you don't double the number of seeks, which saves a bit.
For raid5, it might depend on how many of the disks you are going to
mirror the journal on.

For the initial development work, though, it would be much easier to
assume that the journal is just on a different device entirely.  Once
we can cleanly support multiple soft raid devices journaling to the
same external device, that restriction becomes much less onerous.

> B/ what to journal.
 
>  For raid4/5 we have the parity block to worry about.
>  I think we want to write data blocks to the journal ASAP, and then
>  once parity has been calculated for a stripe we write the parity
>  block to the journal and then are free to write the parity and data
>  to the array.

>  On journal replay we would collect together data blocks in a stripe
>  until we get a parity block for that stripe.

Actually, a block can appear multiple times in the journal.  In this
case, though, all we really need is a list of all stripes which have
been modified by the journal replay --- then you simply recalculate
parity on all of those stripes.  Until you have done that, we'll keep
the journal marked needs_recovery, so if the parity recalculation gets
interrupted by a crash, we'll just replay the whole lot and do another
full parity recalc on the subsequent reboot.

However, we have degraded mode to worry about, and in degraded mode we
*do* need to journal parity updates for all stripes (except those in
which it's the parity disk which has failed).

>  The only remaining issue is addressing. The journal presumably
>  doesn't know about "parity" or "data" blocks.  It just knows about
>  sector addresses.
>  I think I would tell the journal that data blocks have the address
>  that they have in the array, and parity block, which don't have an
>  address in the array, have an address which is the address on the
>  disc, plus some offset which is at least the size of the array.

Why not just journal them as writes to the underlying disks which
comprise the array?  That's the clean abstraction --- it means that
when raid5 schedules its stripe write, the journal deals with that
stripe as an atomic unit, but raid5 still sees it as a physical write.

>  Would it cause JBD any problems if the sector address it is given is
>  not a real address on any real device but is something that can be
>  adequately interpreted by the client?

Yes, because once you've given the block to JBD, it assumes that it is
ultimately responsible for all writeback.  

But that's something we'd need to discuss --- the JBD API would need
some enhancing in any case to cope with raid5's submit_bh regime to
deal with repeated writes to the same stripe (with the fs as a client,
we can assume that such repeated writes come from the same struct
buffer_head, at least until the bh is deleted, which is something
under our own control; or until the bh is explicitly released by JBD
once final writeback has happened.)

> C/ data management.
> 
>  One big difference between a filesystem using JBD and a device driver
>  using JBD is the ownership of buffers.
>  It is very important that a buffer which has been written to the
>  journal not be changed before it gets written to the main storage, so
>  ownership is important.

Not true!  If you write to the same stripe twice, then we can journal
the first version, modify the block, then journal the second version,
all without the write hitting backing store.

There's a second problem implicit in this --- while the stripe
writeback is pending, reads from the block device need to be satisfied
from the copy that is awaiting writeback.  For a filesystem client,
this isn't a problem --- the fs has its own cache and can make sure
that it reads from memory in the case where we've got a local,
non-writebacked copy.  But for a block device client, there isn't any
such automatic caching.

>  As I understand it, the filesystem owns it's buffers and can pretty
>  much control who writes and when

Not really; if the buffer is marked dirty, the VFS can write it
whenever it feels like it.

>  However a device drive does not own the buffers that it uses.

Soft raid5 _does_, however, own the temporary bh'es that are used to
schedule writes to the underlying physical devices.

>  It seems that we need a generic buffer-cache in front of the md
>  driver:
>    - A write request gets copied into a buffer from this cache
>    - the buffer gets written to the journal
>    - the original write request gets returned
>    - the buffer gets written to the array
> 
>  This would work, but means allocating lots more memory, and adds an
>  extra mem-to-mem copy which will slow things down.

Right, although I thought that you were already doing such a copy
inside raid5?

Doing zero-copy is essentially impossible in the general case.  The
writes can be coming from shared memory (mmap(MAP_SHARED,
PROT_WRITE)), so there is no guarantee that the incoming buffer_heads
will remain static throughout their progress towards the final raid
stripe.  If you want the parity to be correct, you are pretty much
forced to make a copy (unless we can do copy-on-write tricks to defer
this copy in certain cases, but that gets tricky and requires far more
interaction with the VM than is healthy for a block device driver!)

>  The only improvement that I can think of would only work with an
>  NVRAM journal device.  It involves writing to the journal and then
>  acknowledging the write - with minimal latency - and then reading the
>  data back in off the journal into a buffer that then gets written to
>  the main device.

If part of our objective is to be able to survive power loss plus loss
of a disk on power-return, then I don't think we've got any choice ---
we have to wait for the parity to be available before we commit and
acknowledge the write.

Most applications are not all that bound by write latency.  They
typically care more about read latency and/or write throughput, and
any fancy games which try to minimise write latency at the expense of
correctness feel wrong to me.

Cheers,
 Stephen
