Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311536AbSCXELM>; Sat, 23 Mar 2002 23:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311531AbSCXEK6>; Sat, 23 Mar 2002 23:10:58 -0500
Received: from gear.torque.net ([204.138.244.1]:7442 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S311532AbSCXEKq>;
	Sat, 23 Mar 2002 23:10:46 -0500
Message-ID: <3C9D5219.1403288B@torque.net>
Date: Sat, 23 Mar 2002 23:12:09 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Patch to split kmalloc in sd.c in 2.4.18+
In-Reply-To: <20020322215809.A17173@devserv.devel.redhat.com> <3C9CB643.FC33C0AF@torque.net> <20020323143753.A1011@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev wrote:
> 
> > Date: Sat, 23 Mar 2002 12:07:15 -0500
> > From: Douglas Gilbert <dougg@torque.net>
> 
> > > One problem I see when trying to use a box with 128 SCSI disks
> > > is that sd_mod sometimes refuses to load. Earlier kernels simply
> > > oopsed when it happened, but that is fixed in 2.4.18. The root
> > > of the evil is the enormous array sd[] that sd_init allocates.
> > > Alan suggested to split the allocation, which is what I did.
> 
> > So the only thing that is now contiguous is an array of
> > pointers (to device state structures). [...]
> > There have been no reported errors with this approach
> > during the lk 2.4 series. A patched sg driver (together
> > with Richard Gooch's sd-many patch) has been able to
> > address over 300 (similated) disks without noticeable
> > memory problems on a modestly-sized box.
> 
> The sg driver does not have any hd_struct arrays to allocate,
> because it's not a disk.
> 
> > I believe that it was Eric's intention to implement the
> > same solution in sd. The generic disk stuff and the
> > partitions are a complicating factor.
> > All those parallel arrays set up by sd_init (e.g.
> > rscsi_disks[], sd_sizes[], sd_blocksizes[],
> > sd_hardsizes[], sd_max_sectors[] and sd[] are a mess.
> 
> Excuse me, but I think you are trying to solve quite different
> problem here. It looks that you target the code cleanliness first,
> and the biggest allocation as an afterthought: "partitions
> are a complicating factor". I target the biggest allocation,
> which is the array of hd_struct (without loosing any code
> cleanliness, if any remains in that rathole). Do you see the
> difference?
> 
> Even after my patch broke the biggest allocation into 8 parts,
> it is still the biggest! Every one of those other arrays is smaller
> than an array of 256 hd_struct's. There is no way to switch to
> arrays of pointers for hd_struct, because it is indexed with
> minor in ll_rw_blk. Really, my change is independent of any
> cleanups for other arrays (such as rscsi_disks[]).
> 
> It would be very nice if someone actually looked into detangling
> those arrays in 2.5. Currently, Andreas Jaeger rewrote that part
> without changing anything, only adding a bunch of butt-ugly macroses.
> 2.5 is where the better place for array squashing excercises is,
> because I certainly would like to see this GONE:
> 
>         if (rscsi_disks)
>                 return 0;
> 
>         /* allocate memory */
> #define init_mem_lth(x,n)       x = kmalloc((n) * sizeof(*x), GFP_ATOMIC)
> #define zero_mem_lth(x,n)       memset(x, 0, (n) * sizeof(*x))
> 
> >[...]
> > BTW. It is probably worth looking at the sd-many patch
> > as it must have been faced with a similar problem.
> 
> It just occured to me after I sent the patch.
> 
> I would appreciate if someone applied and used my patch and told
> me how it went. Array cleanups are parallel to the break-up of
> the biggest allocation in sd (which must stay an array :-P).

Your patch worked ok for me. I have a couple of real
disks and 120 simulated ones with scsi_debug. My last disk
was /dev/sddq and I was able to fdisk, mke2fs, mount
and copy files to it ok.


I had a look at ide-disk.c (lk 2.4.19-pre4) and it
looks remarkably clean compared to sd.c . It seems
to warrant further study.

Doug Gilbert
