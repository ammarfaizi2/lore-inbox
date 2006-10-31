Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965253AbWJaBrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965253AbWJaBrM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 20:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWJaBrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 20:47:12 -0500
Received: from cantor.suse.de ([195.135.220.2]:12221 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965236AbWJaBrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 20:47:11 -0500
From: Neil Brown <neilb@suse.de>
To: Christian Schmidt <lkml@digadd.de>
Date: Tue, 31 Oct 2006 12:46:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17734.43789.697487.460594@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: Kernel OOPS with partitioned software raid (+ further questions)
In-Reply-To: message from Christian Schmidt on Monday October 30
References: <4545379E.4040203@digadd.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 30, lkml@digadd.de wrote:
> Hi all,
> 
> I'm running the following software-raid setup:
> 
> two raid 0 with two 250GB disks each (sdd1-sdg1) named md_d2 and md_d3
> one raid 5 with three 500GB disks (sda2-sdc2) and the two raid0 as
> members named md_d5
> one raid 1 with 100MB of each of the 500GB disks (sda1-sdc1) named md_d1
> 
> The only raid device that actually has a partition table is md_d5. The
> other devices are used unpartitioned, which brings me to the first
> question: Is it possible to run partitioned and unpartitioned software
> raids at the same time?
> 
> Back to the topic now after this question. The resulting problem is: due
> to the raid5 layout, the partition table of md_d5 is written to where a
> partition table on md_d3 would be as well:
> 
> [~]>fdisk -l /dev/md_d3
> 
> Disk /dev/md_d3: 500.1 GB, 500113211392 bytes
> 2 heads, 4 sectors/track, 122097952 cylinders
> Units = cylinders of 8 * 512 = 4096 bytes
> 
>       Device Boot      Start         End      Blocks   Id  System
> /dev/md_d3p1               1      244142      976566   83  Linux
> /dev/md_d3p2          244143     5126956    19531256   8e  Linux LVM
> /dev/md_d3p3         5126957   488279488  1932610128   8e  Linux LVM
> 
> Note that the end of md_d3p3 is way beyond the end of the actual device.
> Now during boot udev tries to find out about the content of the devices,
> using the vol_id program. It checks the various locations for raid
> superblocks, lvm superblocks. What happens show the following strace
> excerpts:

snip
> 
> The kernel above contains a lot of patches (gentoo's hardened sources),
> but the same syndrom can be seen with vanilla 2.6.18 or 2.6.19 rc3.
> 
> Even if there are likely a dozend workarounds (create a partition table
> on the raid 0s one by one and resync; no not rely on raid=part for
> autodetection as the raid5 doesn't come up automatically anyway; don't
> use vol_id) this should in my oppinion not happen. The points I'd like
> to criticize are:
> - The partition table read code, which accepts to create the devices
> even though they are obviously wrong,

Yeah, I don't like that either.  I tried submitting a patch to fix it
but different people have different ideas about what the 'right'
solution is (do we clip the partition to size, or make it disappear
completely?).

> - The partitioned raid device creation code, which creates subdevices
> which are larger than the containing device,

This is exactly the same as the above.  The raid code doesn't create
the subdevices.  The partition reading code does that.

> - The layer in the kernel that allows the read beyond end of device down
> to the raid driver,

Yes... This is generic_make_request in block/ll_rw_blk.c.
It check that the address is within the partition, but it does not
check that the address after mapping is still within the device.
It assumes partitions always fit within devices.

> - Most importantly, the raid driver for failing that bad mannered.
> 

Maybe, though I would rather the block layer guaranteed never to send
a request that was out-of-range...

> I honestly didn't look into the other software raid drivers, which are
> likely to produce the same result. The attached patch for raid0.c makes
> accesses beyond the end of a device into Buffer I/O errors:
> 
> xxxxxx Buffer I/O error on device md_d3p3, logical block 483152512
> 
> Regards,
> Christian
> --- raid0.c.orig	2006-10-30 00:12:22.000000000 +0100
> +++ raid0.c	2006-10-30 00:14:48.000000000 +0100
> @@ -415,6 +415,10 @@
>  	chunksize_bits = ffz(~chunk_size);
>  	block = bio->bi_sector >> 1;
>  	
> +	if (block >= mddev->array_size) {
> +		bio_endio(bio, bio->bi_size, -EIO);
> +		return 0;
> +	}

That would work.  Similar fixes needed in linear, raid10, and possible
raid5.

I'll try to push the 'fix it in the block layer' first though.

Thanks,
NeilBeown
