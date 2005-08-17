Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVHQRII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVHQRII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 13:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVHQRIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 13:08:07 -0400
Received: from [202.125.80.34] ([202.125.80.34]:38471 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S1751166AbVHQRIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 13:08:07 -0400
Content-class: urn:content-classes:message
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 17 Aug 2005 22:32:03 +0530
Message-ID: <3AEC1E10243A314391FE9C01CD65429B380C@mail.esn.co.in>
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWifLkpRaFGMCjpS++kxdn0FLXxzwAy4GQQ
From: "Mukund JB`." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Lennart,

A have a new fining here.

fdisk -l -u /dev/tfa0:
debdev1:~# fdisk -l -u /dev/tfa0

Disk /dev/tfa0: 14 MB, 14680064 bytes
2 heads, 32 sectors/track, 448 cylinders, total 28672 sectors Units =
sectors of 1 * 512 = 512 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/ tfa0p1		57       28799       14371+   1  FAT12

On a keen look on the above fdisk output on my 16MB SD card, you can
find the cylinder information as 448 where as my driver ioctl returns
450.

I have found from the partition table that Total n/o sector for the
primary partition is 28743 (total sectors).
But my ioctl returns total cylinders as 450 i.e. 28800 sectors.
As 28743 is NOT any multiple of 64(2*32)i.e sectors*heads, the fdisk
tried manipulates it to get multiples of 64.
So, finally the best multiple 448 cylinders (i.e. 28672 sector)
So, finally that NOT a BUG in the driver instead is a generalization
made by fdisk command.

Please find the inline comments.

>Well you can either support partitions fully by making your driver work
>like the ide and scsi and such drivers do things, or you can just make
>it simpler and only support devices without a partition table and those
>with a single partition entry in the partition table.  That would
>support probably 99.99% of cards you would encounter.  You just have to
>check if a partition table exists, if it doesn't, just present the
whole
>device as the disk, while if a partition table exists, scan it for a
>partition that is not a blank entry, then find the start of that
>partition and present the device to the user starting at that sector.

This is a policy & NO policy is the driver should be implemented.
I think we need NOT handle all this in the driver. The upper layer of
the mount application looks into verifying this.

>> The partition layout mentioned in the partition table is same for the
>> Windows formatted SD & CAM formatted SD. I assume partition layout
>> starts at 0x1BE.
>
>If there is a partition table then it starts there.

There is a partition table in the CAM formatted device & it looks like
there is also a partition table in the win formatted device.
The details of there at offset 0x1BE are below.

CAM formatted SD Details
------------- 0x1BE offset detailed messages (decimal no
)------------------ Reading data from sector '0' at offset
0x1BE(Partition table start addr)

bootable 		= 0x80	(0x1BE)
beg-chs.heads 	= 0x1
beg-chs.sect 	= 0x1A
beg-chs.cylin 	= 0x0
sys-type 		= 0x1
end-chs.heads 	= 0x1
end-chs.sect 	= 0x60
end-chs.cylin 	= 0xC1
start sect  	= 0x39
n/o sec in part 	= 0x7047


Win formatted SD Details
------------- 0x1BE offset detailed messages (decimal no
)------------------ Reading data from sector '0' at offset
0x1BE(Partition table start addr)

bootable 		= 0x6F	(0x1BE)
beg-chs.heads 	= 0x74
beg-chs.sect 	= 0x68
beg-chs.cylin 	= 0x65
sys-type 		= 0x72
end-chs.heads 	= 0x20
end-chs.sect 	= 0x6D
end-chs.cylin 	= 0x65
start sect  	= 0x2E61964
n/o sec in part 	= 0x440A0DFF


>> >> Sfdisk -l /dev/tfa0 ( CAM & win)
>> >> Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
>> >> Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting
from
>> 0
>> >>
>> >>    Device Boot Start     End   #cyls    #blocks   Id  System
>> >> /dev/tfa0p1   *      0+    449     450-     14371+   1  FAT12
>> >> /dev/tfa0p2          0       -       0          0    0  Empty
>> >> /dev/tfa0p3          0       -       0          0    0  Empty
>> >> /dev/tfa0p4          0       -       0          0    0  Empty
>> >> Warning: partition 1 extends past end of disk
>> >>
>> Can you quote your comments on the warning given by sfdisk command
>> above?
>
>The warning means the driver is broken and says the wrong number of
>cylinders for the device.

NO, I think driver is NOT broken instead the partition tables speaks SO.
sfdisk returns 448 cylinders for my 16MB SD card, where as my driver
ioctl returns 450.

I have found from the partition table that Total n/o sector for the
primary partition is 28743 (total sectors) whereas my ioctl returns
total cylinders as 450 i.e. 28800 sectors. 

As 28743 is NOT any multiple of 64(2*32)i.e sectors*heads, the sfdisk
manipulates it to get multiples of 64. The best multiple is 448
cylinders (i.e. 28672 sector). This is where we are missing 128 sectors.

So, finally that NOT a BUG in the driver instead is a generalization
made by sfdisk command.

>Perhaps one of the more modern ways of getting disk size would return
>the full number of sectors instead.  For example the ioctl BLKSSZGET
and
>BLKGETSIZE and BLKGETSIZE64.
I added BLKGETSIZE ioctl. When I tried to note the ioctl called at mount
time I find it is all the time HDIO_GETGEO.

At this angle it clear that sfdisk output is Not the result of BUG in
the driver instead it is a result of partition table TOTAL SECTORS
entry. 

I have a doubt where Linux is treating this a separate class of device.
I heard some thing about the FS found on the Floppies. 
I guess FS on win & linux SD is such kind of FS & so I am able to mount
it.

How do I verify this? I am clean about the FS on Floppies. I will try to
find it tomorrow on the NET.

As CAM SD has altogether HD like info. And that is why we are NOT able
to mount it.

Can you comment on this?

Regards,
Mukund Jampala

