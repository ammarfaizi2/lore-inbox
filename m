Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751157AbVHQSul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVHQSul (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVHQSul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:50:41 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:59264 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751157AbVHQSuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:50:40 -0400
Date: Wed, 17 Aug 2005 14:50:37 -0400
To: "Mukund JB`." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050817185037.GA3208@csclub.uwaterloo.ca>
References: <3AEC1E10243A314391FE9C01CD65429B380C@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B380C@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 10:32:03PM +0530, Mukund JB`. wrote:
> A have a new fining here.
> 
> fdisk -l -u /dev/tfa0:
> debdev1:~# fdisk -l -u /dev/tfa0
> 
> Disk /dev/tfa0: 14 MB, 14680064 bytes
> 2 heads, 32 sectors/track, 448 cylinders, total 28672 sectors Units =
> sectors of 1 * 512 = 512 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/ tfa0p1		57       28799       14371+   1  FAT12
> 
> On a keen look on the above fdisk output on my 16MB SD card, you can
> find the cylinder information as 448 where as my driver ioctl returns
> 450.
> 
> I have found from the partition table that Total n/o sector for the
> primary partition is 28743 (total sectors).
> But my ioctl returns total cylinders as 450 i.e. 28800 sectors.
> As 28743 is NOT any multiple of 64(2*32)i.e sectors*heads, the fdisk
> tried manipulates it to get multiples of 64.
> So, finally the best multiple 448 cylinders (i.e. 28672 sector)
> So, finally that NOT a BUG in the driver instead is a generalization
> made by fdisk command.

If the partition starts at sector 57 and is 28743 sectors long, then
that matches 28800 sectors total.  No problem there.

If on the other hand fdisk reports 28672 sectors total then there is a
problem somewhere.

> This is a policy & NO policy is the driver should be implemented.
> I think we need NOT handle all this in the driver. The upper layer of
> the mount application looks into verifying this.

Well then you have to implement full partition support and present a
seperate device for each partition in /dev so that mount can access each
partition.

> There is a partition table in the CAM formatted device & it looks like
> there is also a partition table in the win formatted device.
> The details of there at offset 0x1BE are below.
> 
> CAM formatted SD Details
> ------------- 0x1BE offset detailed messages (decimal no
> )------------------ Reading data from sector '0' at offset
> 0x1BE(Partition table start addr)
> 
> bootable 		= 0x80	(0x1BE)
> beg-chs.heads 	= 0x1
> beg-chs.sect 	= 0x1A
> beg-chs.cylin 	= 0x0
> sys-type 		= 0x1
> end-chs.heads 	= 0x1
> end-chs.sect 	= 0x60
> end-chs.cylin 	= 0xC1
> start sect  	= 0x39
> n/o sec in part 	= 0x7047

Well that one looks pretty sane.

> Win formatted SD Details
> ------------- 0x1BE offset detailed messages (decimal no
> )------------------ Reading data from sector '0' at offset
> 0x1BE(Partition table start addr)
> 
> bootable 		= 0x6F	(0x1BE)
> beg-chs.heads 	= 0x74
> beg-chs.sect 	= 0x68
> beg-chs.cylin 	= 0x65
> sys-type 		= 0x72
> end-chs.heads 	= 0x20
> end-chs.sect 	= 0x6D
> end-chs.cylin 	= 0x65
> start sect  	= 0x2E61964
> n/o sec in part 	= 0x440A0DFF

That one looks more like random numbers.  Maybe the partition entry that
it really uses is not number 1, but number 2 3 or 4, or no partition
table at all.

Could you do dd if=/dev/sda bs=512 count=1 | xxd

For each of your two cards.  Then we can really see what is in the
partition tables of those two cards.

> NO, I think driver is NOT broken instead the partition tables speaks SO.
> sfdisk returns 448 cylinders for my 16MB SD card, where as my driver
> ioctl returns 450.

Well I wouldn't ever trust sfdisk.  fdisk -l -u I trust more.

> I have found from the partition table that Total n/o sector for the
> primary partition is 28743 (total sectors) whereas my ioctl returns
> total cylinders as 450 i.e. 28800 sectors. 
> 
> As 28743 is NOT any multiple of 64(2*32)i.e sectors*heads, the sfdisk
> manipulates it to get multiples of 64. The best multiple is 448
> cylinders (i.e. 28672 sector). This is where we are missing 128 sectors.
> 
> So, finally that NOT a BUG in the driver instead is a generalization
> made by sfdisk command.

Well I believe sfdisk has been broken in the past.  It wouldn't surprise
me if it still has bugs.

> I added BLKGETSIZE ioctl. When I tried to note the ioctl called at mount
> time I find it is all the time HDIO_GETGEO.
> 
> At this angle it clear that sfdisk output is Not the result of BUG in
> the driver instead it is a result of partition table TOTAL SECTORS
> entry. 
> 
> I have a doubt where Linux is treating this a separate class of device.
> I heard some thing about the FS found on the Floppies. 
> I guess FS on win & linux SD is such kind of FS & so I am able to mount
> it.
> 
> How do I verify this? I am clean about the FS on Floppies. I will try to
> find it tomorrow on the NET.
> 
> As CAM SD has altogether HD like info. And that is why we are NOT able
> to mount it.
> 
> Can you comment on this?

Well if you inlcude the hex dump of the two MBR sectors then I may be
able to comment on it.

fdisk -u -l /dev/sda for each card would also help (using the usb reader
preferably if you got that working yet.)

Len Sorensen
