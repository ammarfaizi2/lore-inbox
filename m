Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVHPQIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVHPQIW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbVHPQIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:08:22 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:12224 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1030209AbVHPQIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:08:21 -0400
Date: Tue, 16 Aug 2005 12:08:20 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050816160820.GY6714@csclub.uwaterloo.ca>
References: <43E52E630789A34CBC7422287BFB99AC01F129@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E52E630789A34CBC7422287BFB99AC01F129@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 06:54:40PM +0530, Mukund JB. wrote:
> Yes, I agree. My sentence formation was wrong.
> 
> My question here is:
> 
> If I have NO multiple partition support implemented in the driver, will
> it effect mounting the first partition on the device?

Yes.  If you have no partition support, then you can only mount cards
without a partition table since that is all you are presenting.  cards
which have a partition table will have their start of filesystem offset
by a few sectors to the start of partition 1 or 4 or whichever it is
using.

> i.e. If I said alloc_disk(1) (single partition), and if I am trying to
> mount the very first partition, will I be able to do it?
> 
> Existing gendisk code:
> ---------------
> 	alloc_disk(1);
> 	first_minor = socket_no; // Device socket no varies from 0 - 3.
> 					 // so, each device- we have
> just one node; 					 // NO partitions on
> each device.
> 
> Device Interface: mknod /dev/tfa0 b 252 0
> 
> Will I have to modify the above code? 

I don't even know what that code is doing.

> Will you tell me what else do I need to handle multiple partition in my
> driver apart from alloc_disk(n) & first_minor modifications as per n(n/o
> partitions)?

Well you can either support partitions fully by making your driver work
like the ide and scsi and such drivers do things, or you can just make
it simpler and only support devices without a partition table and those
with a single partition entry in the partition table.  That would
support probably 99.99% of cards you would encounter.  You just have to
check if a partition table exists, if it doesn't, just present the whole
device as the disk, while if a partition table exists, scan it for a
partition that is not a blank entry, then find the start of that
partition and present the device to the user starting at that sector.

> The partition layout mentioned in the partition table is same for the
> Windows formatted SD & CAM formatted SD. I assume partition layout
> starts at 0x1BE.

If there is a partition table then it starts there.

> >> Sfdisk -l /dev/tfa0 ( CAM & win)
> >> Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
> >> Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting from
> 0
> >>
> >>    Device Boot Start     End   #cyls    #blocks   Id  System
> >> /dev/tfa0p1   *      0+    449     450-     14371+   1  FAT12
> >> /dev/tfa0p2          0       -       0          0    0  Empty
> >> /dev/tfa0p3          0       -       0          0    0  Empty
> >> /dev/tfa0p4          0       -       0          0    0  Empty
> >> Warning: partition 1 extends past end of disk
> >>
> Can you quote your comments on the warning given by sfdisk command
> above?

The warning means the driver is broken and says the wrong number of
cylinders for the device.

> These files belong to the same device. They are just different sectors
> of the device file. 
> 	
> 	Cluster-0.txt - First 16 Blocks of the device
> 	Phy-Cam-57-sector.txt - 57th sector of the device (claimed FAT
> 	
> Sector)

Oh ok.  So on that card the first partition probably starts that that
sector.

> >So for the device above with one partition, you would have to check
> >the partition table entry to find the start sector number of the
> >partition and then offset requests by that amount.
> 
> You mean the application like mount should check the partition table
> entry to find the start sector number of the partition and then mount
> the particular partition.
> 
> >For example:
> >fdisk -l -u /dev/sde:
> >debdev1:~# fdisk -l -u /dev/sde
> >
> >Disk /dev/sde: 14 MB, 14745600 bytes
> >2 heads, 32 sectors/track, 450 cylinders, total 28800 sectors
> >Units = sectors of 1 * 512 = 512 bytes
> >
> >   Device Boot      Start         End      Blocks   Id  System
> >/dev/sde1              57       28799       14371+   1  FAT12
> >
> >So if you skip 57 sectors you would see the FAT12 filesystem.
> >
> 
> Can you comment on the fdisk output which says the total sectors are
> 28672 while the total n/o sector passed to fdisk through the HDIO_GETGEO
> ioctl is 28800.

You are missing 128 sectors which happens to be 2 heads * 32 sectors *
2 cylinders.  So 28672 matches 2 heads, 32 sectors 448 cylinders, so
may the real problem you had with sfdisk was that it decided your total
sector size was wrong, and fixed the cylinder count down by 2 to match
the number of sectors.  Your driver SHOULD be returning 28800 for the
number of sectors.

> I have a single ioctl implemented in the driver i.e HDIO_GETGEO ioctl.

Perhaps one of the more modern ways of getting disk size would return
the full number of sectors instead.  For example the ioctl BLKSSZGET and
BLKGETSIZE and BLKGETSIZE64.

Now on the other hand, I think you may have an error in your total size
calculation in the driver too, since 2 heads * 32 sectors * 450
cylinders is 28800 sectors total.

> fdisk -l -u /dev/tfa0:
> debdev1:~# fdisk -l -u /dev/tfa0
> 
> Disk /dev/tfa0: 14 MB, 14680064 bytes
> 2 heads, 32 sectors/track, 450 cylinders, total 28672 sectors
> Units = sectors of 1 * 512 = 512 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/ tfa0p1		57       28799       14371+   1  FAT12

I think given your partition table says the last sector is 28799 of the
partition, you have to find out why your driver is returning a total
size of 28672 when the real size is 28800.

Len Sorensen
