Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267497AbRGMQH7>; Fri, 13 Jul 2001 12:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267498AbRGMQHt>; Fri, 13 Jul 2001 12:07:49 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:49755 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267497AbRGMQHe>; Fri, 13 Jul 2001 12:07:34 -0400
Date: Fri, 13 Jul 2001 18:07:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Dilger <adilger@turbolinux.com>
Cc: lvm-devel@sistina.com, Andi Kleen <ak@suse.de>,
        Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010713180716.C24180@athlon.random>
In-Reply-To: <20010713005501.J19011@athlon.random> <200107130735.f6D7Z0Bl029176@webber.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107130735.f6D7Z0Bl029176@webber.adilger.int>; from adilger@turbolinux.com on Fri, Jul 13, 2001 at 01:35:00AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 01:35:00AM -0600, Andreas Dilger wrote:
> Andrea writes:
> > With the current design of the pe_lock_req logic when you return from
> > the ioctl(PE_LOCK) syscall, you never have the guarantee that all the
> > in-flight writes are commited to disk, the
> > fsync_dev(pe_lock_req.data.lv_dev) is just worthless, there's an huge
> > race window between the fsync_dev and the pe_lock_req.lock = LOCK_PE
> > where whatever I/O can be started without you fiding it later in the
> > _pe_request list.
> 
> Yes there is a slight window there, but fsync_dev() serves to flush out the
> majority of outstanding I/Os to disk (it waits for I/O completion).  All
> of these buffers should be on disk, right?

Yes, however fsync_dev also has the problem that it cannot catch rawio.
Plus fsync_dev is useless since whatever I/O can be started between
fsync_dev and the pe_lock.

But the even bigger problem (regardless of fsync_dev) is that by the
time we set pe_lock and we return from the ioctl(PE_LOCK) we only know
all the requests passed the pe_lock-check in lvm_map, but we never know
if they are just commited on disk by the time we start moving the PVs.

> 
> > Even despite of that window we don't even wait the
> > requests running just after the lock test to complete, the only lock we
> > have is in lvm_map, but we should really track which of those bh are
> > been committed successfully to the platter before we can actually copy
> > the pv under the lvm from userspace.
> 
> As soon as we set LOCK_PE, any new I/Os coming in on the LV device will
> be put on the queue, so we don't need to worry about those.  We have to

Correct, actually as Joe noticed that is broken too but for other reasource
management reasons (I also thought about the resource management thing
of too many bh queued waiting the pv move, but I ignored that problem
for now since that part cannot silenty generate corruption, as worse it
will deadlock the machine which is much better than silenty corrupting
the fs and letting the administrator thing the pv_move worked ok).

> do something like sync_buffers(PV, 1) for the PV that is underneath the
> PE being moved, to ensure any buffers that arrived between fsync_dev()
> and LOCK_PE are flushed (they are the only buffers that can be in flight).

correct, we need to ensure those buffers are flushed, however
sync_buffers(PV, 1) is broken way to do that, it won't work out because
no buffer cache or bh in general lives on top of the PV and secondly we must
handle anonymous bh rawio etc too before moving the PV around (anonymous
buffers in kiobufs are never visible in any lru list, they are only
telling the blkdev where to write, they're not holding any memory or
data, the kiobuf does but we don't know which kiobufs are writing to the
LV...)

One right way I can imagine to fix the in-flight-I/O race is to overload
the end_io callback with a private one for all the bh passing through
lvm_map, and atomically counting the number of in-flight-bh per-LV, then
you lock the device and you wait the count to go down to zero while you
unplug the tq_disk. The fsync_dev basically only matters to try to
reduce the size of the bh-queue while we hold the lock (so we avoid a
flood of bh caming from kupdate for example), but the fsync_dev cannot
be part of the locking logic itself. You may use the bh_async patch
from IBM that I am maintaining in my tree waiting 2.5 to avoid
allocating a new bh for the callback overload.

> Is there another problem you are referring to?

yes that's it.

> AFAICS, there would only be a large window for missed buffers if you
> were doing two PE moves at once, and had contention for _pe_lock,

Ok, let's forget the two concurrent PE moves at once for now ;) Let's
get right the one live pv_move case first ;)

Andrea
