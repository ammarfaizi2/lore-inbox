Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132080AbRBQV5q>; Sat, 17 Feb 2001 16:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131960AbRBQV50>; Sat, 17 Feb 2001 16:57:26 -0500
Received: from m220-mp1-cvx1b.col.ntl.com ([213.104.72.220]:62471 "EHLO
	[213.104.72.220]") by vger.kernel.org with ESMTP id <S132001AbRBQV5P>;
	Sat, 17 Feb 2001 16:57:15 -0500
To: <johnsom@orst.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Changes to ide-cd for 2.4.1 are broken?
From: John Fremlin <chief@bandits.org>
Date: 17 Feb 2001 21:56:30 +0000
Message-ID: <m2k86pnfch.fsf@boreas.yi.org.>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Specifically, this part:

@@ -2324,11 +2309,17 @@
                    sense.ascq == 0x04)
                        return CDS_DISC_OK;
 
+
+               /*
+                * If not using Mt Fuji extended media tray reports,
+                * just return TRAY_OPEN since ATAPI doesn't provide
+                * any other way to detect this...
+                */
                if (sense.sense_key == NOT_READY) {
-                       /* ATAPI doesn't have anything that can help
-                          us decide whether the drive is really
-                          emtpy or the tray is just open. irk. */
-                       return CDS_TRAY_OPEN;
+                       if (sense.asc == 0x3a && (!sense.ascq||sense.ascq == 1))
+                               return CDS_NO_DISC;
+                       else
+                               return CDS_TRAY_OPEN;
                }

My tray is open as I type, and it is misreported as CDS_NO_DISC. In
2.4.0 it worked fine.

# strace cdd
execve("/trusted/bin/cdd", ["cdd"], [/* 35 vars */]) = 0
open("/dev/cdrom", O_RDONLY|O_NONBLOCK) = 5
ioctl(5, CDROM_DRIVE_STATUS, 0)         = 1
write(1, "No disc in drive\n", 17No disc in drive
)      = 17
_exit(0)                                = ?

>From linux/include/linux/cdrom.h:

#define CDS_NO_INFO		0	/* if not implemented */
#define CDS_NO_DISC		1
#define CDS_TRAY_OPEN		2
#define CDS_DRIVE_NOT_READY	3
#define CDS_DISC_OK		4

(The usual plug: download my beautifully minimalistic but featureful
hand coded assembly cd player from
http://john.snoop.dk/programs/linux/asm-toys).

Some miscellaneous hardware details from dmesg:

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller on PCI bus 00 dev 78
PCI: Hardcoded IRQ 14 for device 00:0f.0
ALI15X3: chipset revision 32
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: SAMSUNG VG36483A (6.48GB), ATA DISK drive
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
hdc: IBM-DTLA-305020, ATA DISK drive
hdd: TOSHIBA DVD-ROM SD-M1102, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12685680 sectors (6495 MB) w/494KiB Cache, CHS=789/255/63, (U)DMA
hdc: 40188960 sectors (20577 MB) w/380KiB Cache, CHS=39870/16/63, (U)DMA
hdd: ATAPI 24X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12

-- 

	http://www.penguinpowered.com/~vii
