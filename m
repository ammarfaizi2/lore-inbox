Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265707AbTF2RG2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 13:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265706AbTF2RG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 13:06:28 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:60945 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S265707AbTF2RGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 13:06:25 -0400
Date: Sun, 29 Jun 2003 20:20:25 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Yes, it works (Re: kernel 2.2.2x + 2.4 IDE backport: anybody tried >137GB disks?)
Message-ID: <20030629172025.GA150921@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030616204100.GK31162@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030616204100.GK31162@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 16, 2003 at 11:41:00PM +0300, you [Ville Herva] wrote:
> 
> The reason I'm asking is of course that I'd need to buy some larger disks,
> but I'm limited to kernel 2.2 :). I have i815 and HPT370 ide on the Abit
> ST6R mobo, both of which work very well with the ide patch -- but I've had
> no chance to try out >137GB disks.

Ok, I got a hold of a 160GB Samsung SP1604N, and was able to try out 
lba48 with 2.2+ide backport myself.

So, I took Marc-Christian Petersen's 2.2.25-secure patchset
(sourceforge.net/projects/wolk) that includes Krzysztof Olêdzki's ide
2.2.21-06162002 patch and booted. After some severe confusion, it turned out
2.2 + the ide backport supports >137GB disk just fine.

The confusion arose from that I had used an old version of fdisk (v2.10f
from redhat-6.2) to create a partition to hda. fdisk probably read the disk
geometry all wrong and created too big partition. And the kernel seems to
have believed the bogus partition table. When I tried mkfs.ext2 /dev/hda1,
it ran well until about 1193 inode groups (little over 41.9% of total), and
then the kernel begun spitting out SectorIdNotFound IDE errors (see the log
below). After I found out that mkfs on 2.4.20 kernel did the same, I begun
suspecting 2.2 ide was not to blame. I found out that badblocks -w /dev/hda
ran all ok up to 160GB on both 2.2 and 2.4. And when I did mkfs.ext2 on
/dev/hda (omitting the partition table altogether), 2.2 worked all solid. I
tried filling up the file system, and there were no problems. I also did
some other short stress tests and everything seems to work based on this
quick test.

I also tried creating the partition with cfdisk, and it seemed to handle the
larger disk right (see the attached log). The mkfs.ext2 succeeded and I was
able to mount and use the partition.

The hardware is Abit ST6R, I tried both i815 IDE (PIIX4 chipset revision 17)
and HPT370A IDE (HPT370A chipset revision 4). FWIW, both gave >42MB/s with
hdparm -t. (Both were reportedly using UDMA mode5.)

Thanks to Andre Hedrick, Krzysztof Olêdzki, Marc-Christian Petersen and all
involved in the linux ide development!


-- v --

v@iki.fi


dmesg:
-------------------------------------------------------------------------------
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 17
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
HPT370A: IDE controller on PCI bus 02 dev 30
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
HPT370: using 33MHz PCI clock
    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
hda: SAMSUNG SP1604N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 312581808 sectors (160042 MB) w/2048KiB Cache, CHS=4961616/255/63, UDMA(100)
-------------------------------------------------------------------------------

fdisk vs cfdisk:
-------------------------------------------------------------------------------
Partition number (1-4): 1
First cylinder (1-46416, default 1):
Using default value 1
Last cylinder or +size or +sizeM or +sizeK (1-46416, default 46416):
Using default value 46416

Disk /dev/hda: 255 heads, 63 sectors, 46416 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1             1     46416 372836488+  83  Linux


root@linux3:/mnt>mkfs.ext2 -m0 /dev/hda1
mke2fs 1.18.9, 22-Dec-1999 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
46612480 inodes, 93209122 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
2845 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968

Writing inode tables:   1193/2845
<hangs>
root@linux3:/mnt>dmesg
<...>
hda: write_intr error1: nr_sectors=1 stat=0x51                                  
hda: write_intr: status=0x51 { DriveReady SeekComplete Error }                  
hda: write_intr: error=0x10 { SectorIdNotFound }, LBAsect=%ld, high=312480015, low=0 sector=315625784                                                         


(after boot)


                              Disk Drive: /dev/hda
                            Size: 160041885696 bytes
             Heads: 255   Sectors per Track: 63   Cylinders: 19457

    Name        Flags      Part Type  FS Type          [Label]        Size (MB)
 ------------------------------------------------------------------------------
    hda1                    Primary   Linux                           160039.28


root@linux3:/mnt>mkfs.ext2 -m0 /dev/hda1
mke2fs 1.18.9, 22-Dec-1999 for EXT2 FS 0.5b, 95/08/09
Filesystem label=
OS type: Linux
Block size=4096 (log=2)
Fragment size=4096 (log=2)
19546112 inodes, 39072080 blocks
0 blocks (0.00%) reserved for the super user
First data block=0
1193 block groups
32768 blocks per group, 32768 fragments per group
16384 inodes per group
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424, 20480000, 23887872

Writing inode tables:  .../1193
-------------------------------------------------------------------------------
