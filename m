Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSG1PIj>; Sun, 28 Jul 2002 11:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316855AbSG1PIj>; Sun, 28 Jul 2002 11:08:39 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:48911 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S316853AbSG1PIi>;
	Sun, 28 Jul 2002 11:08:38 -0400
Date: Sun, 28 Jul 2002 17:11:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Egger <degger@fhm.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: Linux-2.5.28
Message-ID: <20020728151156.GB26862@win.tue.nl>
References: <20020727235726.GB26742@win.tue.nl> <Pine.LNX.4.44.0207271939220.3799-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207271939220.3799-100000@home.transmeta.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 27, 2002 at 07:47:01PM -0700, Linus Torvalds wrote:

> > My third candidate is USB. Systems without USB are clearly more stable.
> 
> Hmm.. I doubt that's your problem, but you might just want to pester
> Martin about your particular IDE setup and see if some light eventually
> goes off somewhere.
> 
> I have this memory that you're using PIO mode? Please do make full details
> available, reminding people which exact setups are broken..

The machine I usually try new kernels on is a 400 MHz Intel Pentium II.

% dmesg | grep hd
Kernel command line: auto BOOT_IMAGE=2.5.27axboe ro root=346 rootfstype=reiserfs hdc=ide-scsi
ide_setup: hdc=ide-scsi
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
    ide2: BM-DMA at 0x9c00-0x9c07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa800-0xa807, BIOS settings: hdg:pio, hdh:pio
hda: Maxtor 91728D8, ATA DISK drive
hdb: Maxtor 91728D8, ATA DISK drive
hdc: Hewlett-Packard CD-Writer Plus 8200, ATAPI CD/DVD-ROM drive
hdd: CD-ROM 40X/AKU, ATAPI CD/DVD-ROM drive
hde: Maxtor 93652U8, ATA DISK drive
hdf: Maxtor 96147H6, ATA DISK drive
hda: host protected area => 1
hda: 33750864 sectors (17280 MB) w/512KiB Cache, CHS=2100/255/63
hdb: host protected area => 1
hdb: 33750864 sectors (17280 MB) w/512KiB Cache, CHS=2100/255/63
hde: host protected area => 1
hde: 71346240 sectors (36529 MB) w/2048KiB Cache, CHS=70780/16/63
hdf: host protected area => 1
hdf: 120064896 sectors (61473 MB) w/2048KiB Cache, CHS=119112/16/63
hdd: ATAPI 48X CD-ROM drive, 128kB Cache
 hda: hda1 < hda5 hda6 hda7 > hda4
 hda4: <unixware: hda8 hda9 hda10 hda11 hda12 hda13 hda14 >
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 >
 hde: hde1 hde2 hde3 < hde5 > hde4
 hde2: <bsd: hde6 hde7 hde8 hde9 >
 hdf: hdf1 hdf2 hdf3
...

Here hde and hdf live on a HPT366 card.

% dmesg | grep HPT
HPT366: IDE controller on PCI bus 00 dev 48
HPT366: detected chipset, but driver not compiled in!
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
HPT366: IDE controller on PCI bus 00 dev 49
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later

[This is from dmesg on a 2.5.27+2.4ide.]

hdc is a CD writer (on ide-scsi)
hdd is a CDROM

No hdparm is used - the IDE is left as the kernel sets it.

I have seen (at least) two kinds of problems:
kernel hang and filesystem corruption.
The hang was always on hde. The corruption was mostly on hdb.

1) Hangs are caused by this HPT366 card. Early 2.5 kernels would
not boot because they would hang as soon as hde was touched.
The same happens for example with the SuSE 8.0 install kernel.
Other kernels would boot but would hang when there was significant
activity on hde or hdf.

2) A different type of problem would be that the superblock
of the root filesystem (on hdb) was zeroed. I have seen this
at least three times - no damage at all, except for a wiped
superblock. Easily repaired with e2fsck -b N.

A less pleasant version of this is a wiped block different
from the superblock, or a block in which all data has been
shifted by a few bytes. On such an occasion e2fsck went
totally berserk and after believing this one block decided
that most of my filesystem was broken, and "repaired" it
out of existence. (That was a filesystem different from
the root filesystem.)

Also yesterday the damage was to a single block, this time
to a reiserfs root filesystem. Lots of messages

is_leaf: free space seems wrong: level=1, nr_items=29, free_space=64 rdkey
vs-5150: search_by_key: invalid format found in block 8274. Fsck?
vs-13070: reiserfs_read_locked_inode: i/o failure occurred trying to find stat data of [328 634 0x0 SD]

all involving block 8274.

Turns out that one needs to boot from other media in order to repair
a reiserfs root filesystem - it does not suffice to mount it read-only.
So, maybe ext2 is more convenient than reiserfs on root.

It is not impossible that this corruption-type problem is created at
reboot time.

Andries



