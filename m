Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbVHLQAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVHLQAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 12:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVHLQAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 12:00:45 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:5079 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751208AbVHLQAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 12:00:45 -0400
Date: Fri, 12 Aug 2005 12:00:43 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050812160043.GM6714@csclub.uwaterloo.ca>
References: <C349E772C72290419567CFD84C26E0170A0194@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C349E772C72290419567CFD84C26E0170A0194@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 09:16:56PM +0530, Mukund JB. wrote:
> When I said mount, I guess FAT will read sector 0 to get the partition
> info. And is it due to lack of partition support in the driver that will
> affect the FAT layer reading the device.
> Please update?

No, the kernel read the partition table if it is there, and presents
each partition as a device.

The user can then mount the partition or the whole device (whichever is
appropriate for the card) using the FAT filesystem driver.  The fat
driver only works when pointed at the right location and has no clue
about partitions (and it should not have a clue).

> Yes, right, my card size if 16 MB. FS type is FAT12.
> 
> The SD card has partitions on it (both: cam, windows).
> So, my device node accessing is direct. 
> You can see below the SD card has a single primary partition.
> 
> So, I say "mount -tvfat /dev/tfa0 /mnt" which works for windows
> formatted SD.
> The same does NOT work with CAM formatted SD.

Well if you ignore the partition table and just use a hardcoded offset
to the start of the partition, well then it likely won't work if the
partitioning layout is different for the two cards.

> Sfdisk -l /dev/tfa0 ( CAM & win)
> Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
> Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting from 0
> 
>    Device Boot Start     End   #cyls    #blocks   Id  System
> /dev/tfa0p1   *      0+    449     450-     14371+   1  FAT12
> /dev/tfa0p2          0       -       0          0    0  Empty
> /dev/tfa0p3          0       -       0          0    0  Empty
> /dev/tfa0p4          0       -       0          0    0  Empty
> Warning: partition 1 extends past end of disk
> 
> I don't understand, what is /dev/tfa0p1? I have no such device.

Well that would be the partition 1 on the tfa0 device, which you need
since that card has a partition there.

> Will you please elaborate this?
> What kind of partition support is required in the driver to support the
> Camera Fat12 formatted SD Card?
> 
> I dumped the 1st sector of SD when formatted on CAM.
> I have attached the files. Please have a look at them
> 
> 	Cluster-0.txt - First 16 Blocks of the device
> 	Phy-Cam-57-sector.txt - 57th sector of the device (claimed FAT
> sector
> in Partition table)

Well one of the two files you sent appears to contain a FAT12 filesystem
directly on the device and has no partitions.  The other appears to
contain a partition table with one partition, and I suspect that
partition contains a FAT12 filesystem.

To read one you access the whole device and mount that.  To access the
other you have to use the partition and mount that instead.  This is why
your driver MUST support partitions, or at the very least look for a
partition table, and if it sees one, skip to the sector the partition
table says is the start and present the device from that location on as
the device (although that MAY mess up FAT, since I don't know if fat
uses relative sector numbers from the start of the partition, or
physical drive sector numbers.  I would think it was relative, in which
case you should be ok just offseting all requests to the device by the
number of sectors to the start of the partition found.

So for the device above with one partition, you would have to check
the partition table entry to find the start sector number of the
partition and then offset requests by that amount.

For example:
fdisk -l -u /dev/sde:
debdev1:~# fdisk -l -u /dev/sde

Disk /dev/sde: 14 MB, 14745600 bytes
2 heads, 32 sectors/track, 450 cylinders, total 28800 sectors
Units = sectors of 1 * 512 = 512 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sde1              57       28799       14371+   1  FAT12

So if you skip 57 sectors you would see the FAT12 filesystem.

On your card without a partition table, the FAT12 starts at sector 0, on
the other it is offset by the number of sectors to the start of the
first partition.

Len Sorensen
