Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTAGJT2>; Tue, 7 Jan 2003 04:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTAGJT2>; Tue, 7 Jan 2003 04:19:28 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:12774 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S267356AbTAGJTY>;
	Tue, 7 Jan 2003 04:19:24 -0500
Date: Tue, 7 Jan 2003 10:26:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Kulwant Bhogal <kulwant.bhogal@btinternet.com>
cc: Linux/PPC on APUS users <linux-apus-user@lists.sourceforge.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Ahah, 4096 blocksize disk is not recognised under Linux?
In-Reply-To: <0d46a4139000713PCOW035M@blueyonder.co.uk>
Message-ID: <Pine.GSO.4.21.0301071012420.14387-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jan 2003, Kulwant Bhogal wrote:
> > mke2fs /dev/<DEVICE>
> 
> Ok, I tried mke2fs dev/sdc because mke2fs /dev/sdc1 kinda obviously didn't
> work because LINUX can't see the partitions. And this is what I got: 
> 
> # mke2fs /dev/sdc
> 
> mke2fs 1.27 (8-Mar-2002)
> /dev/sdc is entire device, not just one partition!
> proceed anyway (y,n) y
> filesystem label= 
> OS type LINUX
> Block size = 4096 (log=2)
> Fragment size = 4096 bytes
> 636480 inodes, 1271205 blocks
> 63560 blocks (5.00%) reserved for the super use.
> First data block=0
> 39 block groups (I think that was a 9 - I can't read my own writing!)
> 32768 blocks per group, 32768 fragments per group 16320 inodes per group
> superblock backups stored on blocks: 
> 32708, 98304, 163840, 229376, 294912, 819200, 884736
> Warning: Could not read block 0: Attempt to read block from filesystem
> resulted in short read.

Oops...

> Writing inode tables: []1/39
> 
> ( [] was basically a black block cursor). 
> 
> At which point the machine appeared to hang (I left it for several minutes). It would accept a carriage return
> (I would get a new line) but I didn't get the command prompt (#) back - even
> after a Ctrl-C. So I rebooted. 
> 
> >> >   2. Does Linux recognize the blocksize during disk probing? E.g. for
> >> > my disks      it says
> >> >      | SCSI device sda: 8910423 512-byte hdwr sectors (4562 MB)
> >> >      | SCSI device sdb: 6281856 512-byte hdwr sectors (3216 MB)
> >> >      during startup.
> > Use `dmesg | less' or `dmesg | more'.
> 
> Here is an excerpt of the relevant bits of the dmesg output: 
> 
> Total memory 96Mb. 
> linux version 2.2.10 (root@pismo)
> (gcc version 2.95.2 20000220
> (Debian GNU/Linux)) #1 Wed Jan 24 00:44:26 CET 2001
> .
> . lots of other output about various other devices and drivers etc - all
> . looked ok.
> .
> SCSI: 1 host
> SCSI0: target 0 accepting period 200ns offset 8 5.00MHz Synchronous SCSI
> SCSI 0: setting target 0 to period 200ns offset 8 5.00MHz synchronous SCSI
> 
> Vendor: COMPAQ         Model DGHS18Y 
> Type: Direct Access     Rev 03F1                 ANSI SCSI Revision 03
> 
> Detected SCSI disk sda at SCSI 0, Channel 0, id 0, lun 0
> 
> Vendor: SEAGATE              Model ST34573LW
> Type: Direct Access            Rev: 6246        ANSI SCSI Revision 02
> 
> SCSI device sda: hdwr sector=512 bytes. Sectors=35566000 [17366MB] [17.4GB]
> SCSI Device sdb: hdwr sector = 4096 bytes. Sectors = 1271205 [4964MB][5.0GB]
> SCSI Device sdc: hdwr sector = 4096 bytes. Sectors = 1271205 [4964MB][5.0GB]
> SCSI Device sdd: hdwr sector = 512 bytes. Sectors = 17773524 [8678MB][8.7GB]

So those disks are recognized correctly as having 4096-byte sectors.

> Partition check: 
> 
> sda: RDSK sda1 sda2 sda3 sda4 sda5 sda6 sda7
> 
> sdb: sd.cBad block number/count requestedscsidisk I/O error: dev 08:10,
> sector 0
> unable to read partition table.

Either the SCSI disk driver or the RDSK partition code cannot handle 4096-byte
sectors.

> sdc: sd.cBad block number/count requestedscsidisk I/O error: dev 08:20,
> sector 0
> unable to read partition table.
> 
> sdd: RDSK sdd1 sdd2 sdd3 sdd4 sdd5 
> 
> hda: RDSK hda1 hda2 hda3
> 
> EXT2 - fs warning: checktime reached, running e2fsck is recommended.
> VFS: Mounted root (ext2 filesystem)
> 
> CFS: Disk change detected on device sr(11,0)
> attempt to access beyond end of device
> 0b:00: rw=0, want=33, limit=2
> isofs_read_super: bread failed, 
> dev=ob:00, iso_blknum=16. block=32
> sd.cBad block number/count requestedscsidisk I/O error: dev 08:10,
> sector 0
> sdc: sd.cBad block number/count requestedscsidisk I/O error: dev 08:20,
> sector 0
> unable to read partition table.
> 
> 
> I did run e2fsck on dev/sdc and I basically got the same sort of error about
> sector 0, short read and the partition being "zero length?" etc.

So the driver doesn't seem to handle 4K sectors. Anyone on lkml who has a
definitive answer about that?

> > The partitions look fine (cfr. your other email). So having Linux and
> > Amiga partitions shared on the 18 GB disk should work fine.
> 
> Should? That doesn't sound like 100%. I I think I will try the 420Mb Connor
> first, now that I have the data from it backed up. Something makes me
> slightly uneasy about sharing AmigaOS native and foreign partitions on the same disk
> especially when the disk is >4Gb which in itself requires OS patches to get it
> recognised and working. Just being cautious :-).

I've had them living on one disk for many many years. But I have to admit all
my disks are < 4 GB.

> I included the bits about the speeds because on the Amiga side, my drives
> accept 10MHz synchronous. Why does LINUX manage only 5MHz? Does this get
> better with a proper installation? 

I don't know.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

