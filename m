Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbRGMHhE>; Fri, 13 Jul 2001 03:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266942AbRGMHg4>; Fri, 13 Jul 2001 03:36:56 -0400
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:57850 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S266940AbRGMHgs>; Fri, 13 Jul 2001 03:36:48 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107130735.f6D7Z0Bl029176@webber.adilger.int>
Subject: Re: [lvm-devel] Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <20010713005501.J19011@athlon.random> "from Andrea Arcangeli at
 Jul 13, 2001 00:55:01 am"
To: Andrea Arcangeli <andrea@suse.de>
Date: Fri, 13 Jul 2001 01:35:00 -0600 (MDT)
CC: Andreas Dilger <adilger@turbolinux.com>, lvm-devel@sistina.com,
        Andi Kleen <ak@suse.de>, Lance Larsh <llarsh@oracle.com>,
        Brian Strand <bstrand@switchmanagement.com>,
        linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea writes:
> With the current design of the pe_lock_req logic when you return from
> the ioctl(PE_LOCK) syscall, you never have the guarantee that all the
> in-flight writes are commited to disk, the
> fsync_dev(pe_lock_req.data.lv_dev) is just worthless, there's an huge
> race window between the fsync_dev and the pe_lock_req.lock = LOCK_PE
> where whatever I/O can be started without you fiding it later in the
> _pe_request list.

Yes there is a slight window there, but fsync_dev() serves to flush out the
majority of outstanding I/Os to disk (it waits for I/O completion).  All
of these buffers should be on disk, right?

> Even despite of that window we don't even wait the
> requests running just after the lock test to complete, the only lock we
> have is in lvm_map, but we should really track which of those bh are
> been committed successfully to the platter before we can actually copy
> the pv under the lvm from userspace.

As soon as we set LOCK_PE, any new I/Os coming in on the LV device will
be put on the queue, so we don't need to worry about those.  We have to
do something like sync_buffers(PV, 1) for the PV that is underneath the
PE being moved, to ensure any buffers that arrived between fsync_dev()
and LOCK_PE are flushed (they are the only buffers that can be in flight).
Is there another problem you are referring to?

AFAICS, there would only be a large window for missed buffers if you
were doing two PE moves at once, and had contention for _pe_lock,
otherwise fsync_dev to LOCK_PE is a very small window, I think.
However, I think we are also protected by the global LVM lock from
doing multiple PE moves at one time.

> If the logic would been sane, your patch would also been ok
> (besides the C breakage of the missing volatile but we abuse gcc this
> way in other parts of the kernel too after all).

Yes, I never thought about GCC optimizing away the two references to the
same var before and after making the check.

> I think the whole pv_move logic needs to be redesigned and rewritten, if
> you could rewrite it and send patches (possibly also against beta7 if
> a new lvm release is not scheduled shortly) that would be more than
> welcome!

Yes, well the correct solution is to do it all in a kernel thread, so
that you don't need to do kernel->user->kernel data copying.  I already
discussed this with Joe Thornber (I think) and it was decided to be too
much for now (needs changes to user tools, IOP version, etc).  Later.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
