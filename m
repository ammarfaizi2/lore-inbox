Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131136AbQLUV6W>; Thu, 21 Dec 2000 16:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131339AbQLUV6M>; Thu, 21 Dec 2000 16:58:12 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:14897 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S131136AbQLUV6A>;
	Thu, 21 Dec 2000 16:58:00 -0500
Message-ID: <20001221222735.A15396@win.tue.nl>
Date: Thu, 21 Dec 2000 22:27:35 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Ishikawa <ishikawa@yk.rim.or.jp>, linux-kernel@vger.kernel.org
Subject: Re: IDE woes:linux and BIOS won't agree on C/H/S detection
In-Reply-To: <3A424B0F.39E71E4F@yk.rim.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A424B0F.39E71E4F@yk.rim.or.jp>; from Ishikawa on Fri, Dec 22, 2000 at 03:25:20AM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 03:25:20AM +0900, Ishikawa wrote:

[a long and very well documented story]

> How can I "erase" this 2940/255/63 CHS setting from the disk

It is far from clear that it is on your disk, so it is far from
clear that something can be erased.

First a few warnings - probably you know already, but just to be sure:

(i) The geometry you get is mostly determined by the BIOS settings
(Normal / Large / LBA / PartitionTable).

(ii) The 2.2.14+ and 2.4 behaviours are both correct, but differ.
The difference consists in that 2.2.14 will use a 255 head geometry
by default (on a large disk), while 2.4 will not.
2.2.12 is broken for large disks.

(iii) The geometry seen on a partition table may override the geometry
detected earlier. If this happens you see lines like
	 hde: [PTBL] [4441/255/63] hde1 hde2 hde3 < hde5 > hde4
in the dmesg, but you did not report any PTBL, so as far as Linux
is concerned the partition table did not play a role.

(iv) It is impossible to guess what geometry the BIOS will invent,
but Linux makes a feeble attempt. For your hda it asks the BIOS
about hd0, the 0x80 disk. But if you also have SCSI disks, then
the BIOS may number the disks such that 0x80 is the SCSI disk.
(This may depend on which disk you boot from.)
In such a case the geometry the BIOS reports is the geometry
it uses for that SCSI disk.

So, if you play with these things in order to understand all
details, you can try with and without SCSI disks and see
whether it makes a difference. (On my machine it does.)


> I can't get linux to properly recognize the C/H/S

A disk does not have a geometry, so there is no proper value.
So, one has to invent something, rather arbitrarily.
Since each BIOS invents different things, a disk may
get a different geometry when you move it to a different machine.

However, these days both Linux and Windows and all BIOSes can
cope with different geometries, so all should be well for
all parties involved with 16 heads, and all should also be
well with 255 heads. Just make sure to select the proper thing
in the BIOS setup.


> On 586SG motherboard, Linux 2.4.0-testXX reported acceptable
> 39693/16/63 (QUESTION: why 39693 is one less the number reported by
> AMI BIOS? Oh well.)

You can do the computation for yourself: 40011300/(16*63) = 39693.
Apparently the AMI BIOS is buggy here.

> Nov 23 20:59:40 standard kernel: hdc: 40011300 sectors (20486 MB)
>  w/512KiB Cache, CHS=39693/16/63, UDMA(33)

> Then the disk is moved onto Soyo SY-K7VTA motherboard with AMD K7
> Duron 750 (the current CPU I use) and used there for two weeks.
> 
> After digging up the old log, I found that the initially
> all was well. 
> 
>     Nov 24 13:21:45 standard kernel: hda: 40011300 sectors (20486 MB)
>     w/512KiB Cache, CHS=39693/16/63
> 
> So far, so good.
> 
> (2-b) Tried partitioning with 2.2.1? and fdisk.
> 
> I wanted to experimenting repartition the whole seagate disk into a
> main linux partition, linux swap, and DOS/Win98 partition, etc.. While
> playing with this using somewhat old Debian Gnu/Linux disk that had
> 2.2.yy on it, the incorrect C/H/S crept in.  (I think it was 2.2.12.
> Ugh, very old.)
> 
>     Dec  6 05:37:09 duron kernel: hda: 40011300 sectors (20486 MB)
>     w/512KiB Cache, CHS=2490/255/63
> 
> (3) CHS=2490/255/63 stuck?
> 
> I tried
> 
>   fdisk /mbr
> 
> from the DOS/Win. (This may not clear the whole 512bytes as explained
> in the ide.txt and large-disk-howto doc.)

Precisely. It doesnt help at all.

>   dd if=/dev/null of=/dev/hdaZ bs=512 count=1
> 
> But this didn't to seem to work.
> (I am now not sure which value of Z I used. Maybe I should try simple
> hda without Z?)

Yes, you should. But this changes something for Linux only in case
it earlier reported PTBL which it didnt. So, it won't help, unless
this changes something for the BIOS.

> I even used the Seagate partition tool that could be used to partition
> large disk from DOS (even on a machine without BIOS support for large
> ATA disk).  The tool, called Disk manager

Disk managers only make your life much more complicated.
Stay far away from them, if you can.

> With the boot line command line parameter, fdisk /dev/hda prints the
> following.
> I take that as long as I stay away from the first and the last
> partition,
> I can make linux and win98 co-exist.
> 
> command (m for help): p
> 
> Disk /dev/hda: 16 heads, 63 sectors, 39693 cylinders
> Units = cylinders of 1008 * 512 bytes
> 
>    Device Boot    Start       End    Blocks   Id  System
> /dev/hda1   *         1      3969   2000061    6  FAT16
> Partition 1 does not end on cylinder boundary:
>      phys=(248, 254, 63) should be (248, 15, 63)
> /dev/hda2          3969     39685  18000832+   f  Win95 Ext'd (LBA)
> Partition 2 does not end on cylinder boundary:
>      phys=(1023, 254, 63) should be (1023, 15, 63)

Interesting. It looks like you are trying to get 39693/16/63
while Windows in fact uses the 2940/255/63 that you are trying
to get rid of.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
