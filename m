Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311121AbSCWTiW>; Sat, 23 Mar 2002 14:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311026AbSCWTiN>; Sat, 23 Mar 2002 14:38:13 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16369 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311025AbSCWTiE>; Sat, 23 Mar 2002 14:38:04 -0500
Date: Sat, 23 Mar 2002 14:37:53 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Patch to split kmalloc in sd.c in 2.4.18+
Message-ID: <20020323143753.A1011@devserv.devel.redhat.com>
In-Reply-To: <20020322215809.A17173@devserv.devel.redhat.com> <3C9CB643.FC33C0AF@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sat, 23 Mar 2002 12:07:15 -0500
> From: Douglas Gilbert <dougg@torque.net>

> > One problem I see when trying to use a box with 128 SCSI disks
> > is that sd_mod sometimes refuses to load. Earlier kernels simply
> > oopsed when it happened, but that is fixed in 2.4.18. The root
> > of the evil is the enormous array sd[] that sd_init allocates.
> > Alan suggested to split the allocation, which is what I did.

> So the only thing that is now contiguous is an array of
> pointers (to device state structures). [...]
> There have been no reported errors with this approach
> during the lk 2.4 series. A patched sg driver (together
> with Richard Gooch's sd-many patch) has been able to
> address over 300 (similated) disks without noticeable
> memory problems on a modestly-sized box.

The sg driver does not have any hd_struct arrays to allocate,
because it's not a disk.

> I believe that it was Eric's intention to implement the
> same solution in sd. The generic disk stuff and the
> partitions are a complicating factor.
> All those parallel arrays set up by sd_init (e.g.
> rscsi_disks[], sd_sizes[], sd_blocksizes[],
> sd_hardsizes[], sd_max_sectors[] and sd[] are a mess.

Excuse me, but I think you are trying to solve quite different
problem here. It looks that you target the code cleanliness first,
and the biggest allocation as an afterthought: "partitions
are a complicating factor". I target the biggest allocation,
which is the array of hd_struct (without loosing any code
cleanliness, if any remains in that rathole). Do you see the
difference?

Even after my patch broke the biggest allocation into 8 parts,
it is still the biggest! Every one of those other arrays is smaller
than an array of 256 hd_struct's. There is no way to switch to
arrays of pointers for hd_struct, because it is indexed with
minor in ll_rw_blk. Really, my change is independent of any
cleanups for other arrays (such as rscsi_disks[]).

It would be very nice if someone actually looked into detangling
those arrays in 2.5. Currently, Andreas Jaeger rewrote that part
without changing anything, only adding a bunch of butt-ugly macroses.
2.5 is where the better place for array squashing excercises is,
because I certainly would like to see this GONE:

        if (rscsi_disks)
                return 0;

        /* allocate memory */
#define init_mem_lth(x,n)       x = kmalloc((n) * sizeof(*x), GFP_ATOMIC)
#define zero_mem_lth(x,n)       memset(x, 0, (n) * sizeof(*x))

>[...]
> BTW. It is probably worth looking at the sd-many patch
> as it must have been faced with a similar problem.

It just occured to me after I sent the patch.

I would appreciate if someone applied and used my patch and told
me how it went. Array cleanups are parallel to the break-up of
the biggest allocation in sd (which must stay an array :-P).

-- Pete
