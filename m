Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965218AbVHPNe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965218AbVHPNe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965217AbVHPNe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:34:56 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:55447 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S965218AbVHPNey convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:34:54 -0400
Content-class: urn:content-classes:message
Subject: RE: The Linux FAT issue on SD Cards.. maintainer support please
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 16 Aug 2005 18:54:40 +0530
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <43E52E630789A34CBC7422287BFB99AC01F129@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: The Linux FAT issue on SD Cards.. maintainer support please
Thread-Index: AcWfVw50cfaKfXhJTdmFYlMaBV5InwDB1RAA
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Cc: <hirofumi@mail.parknet.co.jp>,
       "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Lenneart,

Good Morning. Sorry for the delay.
It is Independence Day celebration Week in INDIA. And it's time for my
independence from this problem.
Please see my advances in-lined below.

Work time
-----------
>> And is it due to lack of partition support in the driver that will
>> affect the FAT layer reading the device. Please update?
>
>No, the kernel read the partition table if it is there, and presents
>each partition as a device.
Yes, I agree. My sentence formation was wrong.

My question here is:

If I have NO multiple partition support implemented in the driver, will
it effect mounting the first partition on the device?

i.e. If I said alloc_disk(1) (single partition), and if I am trying to
mount the very first partition, will I be able to do it?

Existing gendisk code:
---------------
	alloc_disk(1);
	first_minor = socket_no; // Device socket no varies from 0 - 3.
					 // so, each device- we have
just one node; 					 // NO partitions on
each device.

Device Interface: mknod /dev/tfa0 b 252 0

Will I have to modify the above code? 
Will you tell me what else do I need to handle multiple partition in my
driver apart from alloc_disk(n) & first_minor modifications as per n(n/o
partitions)?

>> So, I say "mount -tvfat /dev/tfa0 /mnt" which works for windows
>> formatted SD.
>> The same does NOT work with CAM formatted SD.
>
>Well if you ignore the partition table and just use a hardcoded offset
>to the start of the partition, well then it likely won't work if the
>partitioning layout is different for the two cards.

The partition layout mentioned in the partition table is same for the
Windows formatted SD & CAM formatted SD. I assume partition layout
starts at 0x1BE.

>> Sfdisk -l /dev/tfa0 ( CAM & win)
>> Disk /dev/tfa0: 448 cylinders, 2 heads, 32 sectors/track
>> Units = cylinders of 32768 bytes, blocks of 1024 bytes, counting from
0
>>
>>    Device Boot Start     End   #cyls    #blocks   Id  System
>> /dev/tfa0p1   *      0+    449     450-     14371+   1  FAT12
>> /dev/tfa0p2          0       -       0          0    0  Empty
>> /dev/tfa0p3          0       -       0          0    0  Empty
>> /dev/tfa0p4          0       -       0          0    0  Empty
>> Warning: partition 1 extends past end of disk
>>
Can you quote your comments on the warning given by sfdisk command
above?

>> I dumped the 1st sector of SD when formatted on CAM.
>> I have attached the files. Please have a look at them
>>
>> 	Cluster-0.txt - First 16 Blocks of the device
>> 	Phy-Cam-57-sector.txt - 57th sector of the device (claimed FAT
>> sector
>> in Partition table)
>
>Well one of the two files you sent appears to contain a FAT12
filesystem
>directly on the device and has no partitions.  The other appears to
>contain a partition table with one partition, and I suspect that
>partition contains a FAT12 filesystem.

These files belong to the same device. They are just different sectors
of the device file. 
	
	Cluster-0.txt - First 16 Blocks of the device
	Phy-Cam-57-sector.txt - 57th sector of the device (claimed FAT
	
Sector)

>So for the device above with one partition, you would have to check
>the partition table entry to find the start sector number of the
>partition and then offset requests by that amount.

You mean the application like mount should check the partition table
entry to find the start sector number of the partition and then mount
the particular partition.

>For example:
>fdisk -l -u /dev/sde:
>debdev1:~# fdisk -l -u /dev/sde
>
>Disk /dev/sde: 14 MB, 14745600 bytes
>2 heads, 32 sectors/track, 450 cylinders, total 28800 sectors
>Units = sectors of 1 * 512 = 512 bytes
>
>   Device Boot      Start         End      Blocks   Id  System
>/dev/sde1              57       28799       14371+   1  FAT12
>
>So if you skip 57 sectors you would see the FAT12 filesystem.
>

Can you comment on the fdisk output which says the total sectors are
28672 while the total n/o sector passed to fdisk through the HDIO_GETGEO
ioctl is 28800.

I have a single ioctl implemented in the driver i.e HDIO_GETGEO ioctl.

fdisk -l -u /dev/tfa0:
debdev1:~# fdisk -l -u /dev/tfa0

Disk /dev/tfa0: 14 MB, 14680064 bytes
2 heads, 32 sectors/track, 450 cylinders, total 28672 sectors
Units = sectors of 1 * 512 = 512 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/ tfa0p1		57       28799       14371+   1  FAT12


>On your card without a partition table, the FAT12 starts at sector 0,
on
>the other it is offset by the number of sectors to the start of the
>first partition.

This is a miscommunication. I have sent u the files of the same device
at different offsets and NOT different devices. One of them is cluster 0
and the other one sector 57 of the device which is the start of
partition table as seen in the above fdisk output.

Regards,
Mukund Jampala


