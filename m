Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRCPB7L>; Thu, 15 Mar 2001 20:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129469AbRCPB7B>; Thu, 15 Mar 2001 20:59:01 -0500
Received: from h24-65-193-28.cg.shawcable.net ([24.65.193.28]:24305 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S129460AbRCPB6s>; Thu, 15 Mar 2001 20:58:48 -0500
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200103160051.f2G0pgH00998@webber.adilger.int>
Subject: Re: [util-linux] Re: magic device renumbering was -- Re: Linux 2.4.2ac20
In-Reply-To: <UTC200103152331.AAA2159588.aeb@vlet.cwi.nl> from "Andries.Brouwer@cwi.nl"
 at "Mar 16, 2001 00:31:07 am"
To: Andries.Brouwer@cwi.nl
Date: Thu, 15 Mar 2001 17:51:42 -0700 (MST)
CC: adilger@turbolinux.com, lars@larsshack.org, mikpe@csd.uu.se,
        amnet@amnet-comp.com, hch@caldera.de, jjasen1@umbc.edu,
        linux-kernel@vger.kernel.org, util-linux@math.uio.no
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries writes:
> > I've implemented a patch for util-linux-2.11a
> > which adds LABEL support to mkswap(8) and swapon/swapoff(8).
> 
> But I would prefer a somewhat more ambitious approach.
> 
> My first thought was: why label individual swap partitions?
> I almost never want to distinguish swap partitions, and just do
> "swapon -a". In case one wants to guard against changing device names,
> why not add an option -A so that "swapon -A" does swapon on each
> partition with a swap signature?
> 
> However, that would greatly increase the risk that exists already
> today: someone has a swap partition, and does mkfs.foo, and
> it so happens that foofs does not use the sector with the swapsignature.
> Now this foofs partition has a swap signature, but we would be very
> unhappy if it were used as swap space.

I think the LABEL is a good intermediate step for people not using LVM.
It basically allows your /etc/fstab to not have _any_ device names in it.
I'm not sure I would be happy with auto-mounting swap partitions,
especially because this would overwrite any data in the partition.  Bad.

> The real problem is that our disks usually do not have a volume label.
> Outside of all file systems.
> The "signatures" that we rely on today are located in different places,
> so that a filesystem can have several valid signatures at the same time.
> And we first know where to look when we know the type already.
> 
> Design a Linux partition table format, where a partition descriptor
> has fields start, end, fstype, fslabel, and the whole disk has a vollabel.
> Put it in sector 0-N for an all-Linux disk, and in sectors pointed at
> by a classical DOS-type partition table entry when the disk is shared.
> 
> (Maybe I already did that once - it sounds so familiar now that I write
> this. Then why was it not pursued? Maybe LVM already does these things?)

LVM will handle the disk and "partition" naming and size issues.

It does NOT currently handle the fstype names, but this _could_ be
determined via magic numbers, as now.  In the "(struct dentry *)->vfsmnt"
thread, I was trying to work out a way to get mountpoint information
for LVM.  In the end, I think I will store most of the /etc/fstab line
into a field in the LV header, so it is easily retrievable.  This would
also include the fstype, and mount/dump/fsck options.  It would _not_
store the device name.

The proposed solution would be to have mount(8) write the mount info to
the disk (for logical volumes only, of course) at mount time.  I suppose
the fs type, options, mountpoint could come from either /etc/fstab or
from the command-line, since mount(8) is already parsing all of this info.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert
