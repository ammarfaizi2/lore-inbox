Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbULPQpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbULPQpn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 11:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbULPQpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 11:45:42 -0500
Received: from web26506.mail.ukl.yahoo.com ([217.146.176.43]:1913 "HELO
	web26506.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261720AbULPQoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 11:44:14 -0500
Message-ID: <20041216164413.71455.qmail@web26506.mail.ukl.yahoo.com>
Date: Thu, 16 Dec 2004 16:44:13 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: 3TB disk hassles
To: Hans Kristian Rosbach <hk@isphuset.no>,
       Mark Watts <m.watts@eris.qinetiq.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1103211487.25024.38.camel@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all - thanks for the replies.

 --- Hans Kristian Rosbach <hk@isphuset.no> wrote: 
> > Are you sure your card supports creating a single volume in excess
> of 2TB? 
> > Some cards have such a limit, although you can create many 2TB
> volumes on the 
> > same card.
> 
> http://www.3ware.com/products/serial_ata9000.asp
> States: "Single array capacity scales to over 3 terabytes per
> controller
> (64-bit LBA support)"

Yes indeed, the 3ware unit is more than happy to make a 2.7TB (TiB)
array with all 11 disks (12th disk is hot spare).  This can be
partitioned fine, mke2fs'd to ext3 fine (maybe xfs would be better
though!), filled with lots of data and fsck'ed with no problems at all.
 (We've used more than one config, but right now it's running FC3 with
2.6.9-1.681_FC3.)

The problems only occur after a reboot, at which point Linux still sees
the disk as a 2.7TB disk, but the partition table read from the disk
says that sda4 isn't a 2.7TB partition any more, but a mere (!) 700GB.

Catting /proc/partitions right now gives:
[root@fuslsb ~]# cat /proc/partitions
major minor  #blocks  name

   8     0 2929582080 sda
   8     1     136521 sda1
   8     2   20972857 sda2
   8     3    4200997 sda3
   8     4 2904270862 sda4
[root@fuslsb ~]#

This is fine - but only because I re-ran parted after the boot. 
Indeed, parted itself shows that things aren't really right, presumably
because the partition table is a "normal" one and doesn't have space
for more than 2^32 * 512 bytes (i.e. 2^41 bytes, or 2TB binary).

[root@fuslsb ~]# parted /dev/sda print
Disk geometry for /dev/sda: 0.000-2860920.000 megabytes
Disk label type: msdos
Minor    Start       End     Type      Filesystem  Flags
1          0.031    133.352  primary   ext3        boot
2        133.352  20614.658  primary   ext3
3      20614.658  24717.194  primary   linux-swap
4      24717.195 763767.208  primary   ext3
Information: Don't forget to update /etc/fstab, if necessary.

I guess this means parted is sucking the partition table (incorrect of
course) from the MBR, and this is what the kernel sees on reboot.

fdisk gives similar output:
[root@fuslsb ~]# fdisk -l /dev/sda

Disk /dev/sda: 2999.8 GB, 2999892049920 bytes
255 heads, 63 sectors/track, 364716 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *           1          17      136521   83  Linux
/dev/sda2              18        2628    20972857+  83  Linux
/dev/sda3            2629        3151     4200997+  82  Linux swap
/dev/sda4            3152       97367   756787214+  83  Linux

My understanding (evolving as I learn more about it) of this is simply
that normal partition tables as stored in the MBR cannot handle disks
bigger than 2TB, since they assume 512-byte sectors and only have a
32-bit field to indicate partition start and end points.

However, browsing the net, it seems like shedloads of people are using
>2TB disks out there, so what's the magic bullet?

Right now, the only scheme I have vaguely concocted in my head that
will make this work for us is to add another disk to become the boot
disk - this is actually a major PITA cos there's really no physical
space in the chassis - and then use a GPT/EFI (whatever?) partition
table on the big disk.  This means that BIOS won't understand the big
disk at all but that'll be OK since it isn't trying to boot from it.

Anyone with a magic tip for how to do this is welcome to tell us all
;-))

thanks
Neil





		
___________________________________________________________ 
Win a castle for NYE with your mates and Yahoo! Messenger 
http://uk.messenger.yahoo.com
