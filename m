Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422732AbWCXMfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbWCXMfO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422725AbWCXMfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:35:14 -0500
Received: from kunzite.stewarts.org.uk ([80.68.93.148]:24336 "EHLO
	kunzite.stewarts.org.uk") by vger.kernel.org with ESMTP
	id S932607AbWCXMfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:35:11 -0500
Date: Fri, 24 Mar 2006 12:34:58 +0000
To: linux-kernel@vger.kernel.org
Subject: hpt366 with sata, increase ide controllers
Message-ID: <20060324123458.GA26508@stewarts.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Thomas Stewart <thomas@stewarts.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I bought three "HightPoint RocketRAID 1640" cards for a fileserver. 
Each is a pci card with 4 sata ports 
(http://www.highpoint-tech.com/USA/rr1640.htm).

I then booted 2.6.16 and ran into problems. As far as I can tell the
only module for my cards is the hpt366, which is an old style ide
module.

I found the SATA status report
(http://linux.yyz.us/sata/sata-status.html#hpt) which says there is no
libata driver, this does not sound too promising. Is there a libata
driver for the hpt range of chipsets? (That I could test maybe?)

The cards show up as follows:-
thomas@jade:~$ lspci -s 0:c; lspci -s 0:d; lspci -s 0:e
0000:00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
0000:00:0c.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
0000:00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
0000:00:0d.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
0000:00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
0000:00:0e.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)

It's as if each cards has two controllers. The verbose output of each
card looks like this (except that the IRQ and io ports vary on each
controller).

thomas@jade:~$ sudo lspci -s 0:c.0 -vvv
0000:00:0c.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 120 (2000ns min, 2000ns max)
        Interrupt: pin A routed to IRQ 193
        Region 0: I/O ports at ee70 [size=8]
        Region 1: I/O ports at ee80 [size=4]
        Region 2: I/O ports at ee68 [size=8]
        Region 3: I/O ports at ee7c [size=4]
        Region 4: I/O ports at e600 [size=256]
        Expansion ROM at fe600000 [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Each IDE interface uses two letters of the avalable hd* device files.
The motherboard has two interfaces which uses four letters (hda->hdd).
Each card gets four interfaces and therefore eight letters. With three
cards thats 24 letters plus the 4 on the motherboard.

This totals 14 ide interfaces and 28 letters. As far as I can gather
Linux only does ide0...ide9, and hda...hdt, the 28th letter being
somewhere after z :-).

I saw a post that said jacking up include/asm/ide.h:MAX_HWIFS from its
default of 10 would work. So I increased this to 14, rebooted and
promptly got talk about an 'ide:' 'ide;' 'ide<' 'ide=', as well as a
'hd{'

This would not bother me if I was able to access the devices, as they
will end up in software raid, but I can only access the drives in hd[a-t].

hdw and hd{ don't show up in /proc/partitions.

Some dmesg output:
HPT374: IDE controller at PCI slot 0000:00:0e.0
PCI: Enabling device 0000:00:0e.0 (0105 -> 0107)
ACPI: PCI Interrupt 0000:00:0e.0[A] -> GSI 17 (level, low) -> IRQ 209
HPT374: chipset revision 7
HPT374: 100% native mode on irq 209
HPT37X: using 33MHz PCI clock
    ide:: BM-DMA at 0xed00-0xed07, BIOS settings: hdu:pio, hdv:pio
HPT37X: using 33MHz PCI clock
    ide;: BM-DMA at 0xed08-0xed0f, BIOS settings: hdw:DMA, hdx:pio
ACPI: PCI Interrupt 0000:00:0e.1[A] -> GSI 17 (level, low) -> IRQ 209
HPT37X: using 33MHz PCI clock
    ide<: BM-DMA at 0xe000-0xe007, BIOS settings: hdy:pio, hdz:pio
HPT37X: using 33MHz PCI clock
    ide=: BM-DMA at 0xe008-0xe00f, BIOS settings: hd{:DMA, hd|:pio
Probing IDE interface ide:...
Probing IDE interface ide;...
hdw: WDC WD2500SD-01KCC0, ATA DISK drive
ide;: failed to initialize IDE interface
Probing IDE interface ide<...
Probing IDE interface ide=...
hd{: Maxtor 7L250S0, ATA DISK drive
register_blkdev: cannot get major 67 for ide=
ide=: failed to initialize IDE interface
VP_IDE: IDE controller at PCI slot 0000:00:0f.1

Is there a libata driver, in which case the number of letters would be
a non issue. Or is there a way of getting the hpt366 module to only
grab letters for drives present. Or is there another way to fix it?

As a very quick fix I wrote a patch to get things working. I am in no
way experienced doing any of this stuff so it's mostly guess work. Nor
am I gunning for this to be included. It's mostly just to put it out
there so maybe others with similar problems can get going.

All it does is:
-Bump MAX_HWIFS from 10 to 14
-Add 4 major devices for the extra ide interfaces IDE10_MAJOR->IDE13_MAJOR
-Bodge the naming so that the interfaces are called ide0 -> ide9 -> idea ...
-Bodge the naming so that the devices are called hda -> hdz -> hdA ...
-Make the /proc/ide/hd* links work

diff -urp linux-2.6.16.orig/drivers/ide/ide.c linux-2.6.16/drivers/ide/ide.c
--- linux-2.6.16.orig/drivers/ide/ide.c 2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/drivers/ide/ide.c      2006-03-24 10:59:37.000000000 +0000
@@ -168,7 +168,9 @@ static const u8 ide_hwif_to_major[] = {
                                        IDE2_MAJOR, IDE3_MAJOR,
                                        IDE4_MAJOR, IDE5_MAJOR,
                                        IDE6_MAJOR, IDE7_MAJOR,
-                                       IDE8_MAJOR, IDE9_MAJOR };
+                                       IDE8_MAJOR, IDE9_MAJOR,
+                                       IDE10_MAJOR, IDE11_MAJOR,
+                                       IDE12_MAJOR, IDE13_MAJOR };

 static int idebus_parameter;   /* holds the "idebus=" parameter */
 static int system_bus_speed;   /* holds what we think is VESA/PCI bus speed */
@@ -213,7 +215,7 @@ static void init_hwif_data(ide_hwif_t *h
        hwif->name[0]   = 'i';
        hwif->name[1]   = 'd';
        hwif->name[2]   = 'e';
-       hwif->name[3]   = '0' + index;
+       hwif->name[3]   = index < 10 ? '0' + index : 'a' + index - 10;

        hwif->bus_state = BUSSTATE_ON;

@@ -239,7 +241,10 @@ static void init_hwif_data(ide_hwif_t *h
                drive->special.b.set_geometry   = 1;
                drive->name[0]                  = 'h';
                drive->name[1]                  = 'd';
-               drive->name[2]                  = 'a' + (index * MAX_DRIVES) + unit;
+               drive->name[2]                  =
+                       (index * MAX_DRIVES) + unit < 26 ?
+                               'a' + (index * MAX_DRIVES) + unit :
+                               'A' + (index * MAX_DRIVES) + unit - 26;
                drive->max_failures             = IDE_DEFAULT_MAX_FAILURES;
                drive->using_dma                = 0;
                drive->vdma                     = 0;
Only in linux-2.6.16/drivers/ide: ide.c.orig
diff -urp linux-2.6.16.orig/drivers/ide/ide-probe.c linux-2.6.16/drivers/ide/ide-probe.c
--- linux-2.6.16.orig/drivers/ide/ide-probe.c   2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/drivers/ide/ide-probe.c        2006-03-24 10:59:37.000000000 +0000
@@ -1241,7 +1241,11 @@ void ide_init_disk(struct gendisk *disk,

        disk->major = hwif->major;
        disk->first_minor = unit << PARTN_BITS;
-       sprintf(disk->disk_name, "hd%c", 'a' + hwif->index * MAX_DRIVES + unit);
+       sprintf(disk->disk_name, "hd%c",
+                       hwif->index * MAX_DRIVES + unit < 26 ?
+                               'a' + hwif->index * MAX_DRIVES + unit :
+                               'A' + hwif->index * MAX_DRIVES + unit - 26
+                );
        disk->queue = drive->queue;
 }

Only in linux-2.6.16/drivers/ide: ide-probe.c.orig
diff -urp linux-2.6.16.orig/drivers/ide/ide-proc.c linux-2.6.16/drivers/ide/ide-proc.c
--- linux-2.6.16.orig/drivers/ide/ide-proc.c    2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/drivers/ide/ide-proc.c 2006-03-24 10:59:37.000000000 +0000
@@ -439,7 +439,7 @@ static void create_proc_ide_drives(ide_h
                drive->proc = proc_mkdir(drive->name, parent);
                if (drive->proc)
                        ide_add_proc_entries(drive->proc, generic_drive_entries, drive);
-               sprintf(name,"ide%d/%s", (drive->name[2]-'a')/2, drive->name);
+               sprintf(name,"%s/%s", hwif->name, drive->name);
                ent = proc_symlink(drive->name, proc_ide_root, name);
                if (!ent) return;
        }
diff -urp linux-2.6.16.orig/include/asm-i386/ide.h linux-2.6.16/include/asm-i386/ide.h
--- linux-2.6.16.orig/include/asm-i386/ide.h    2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/include/asm-i386/ide.h 2006-03-24 10:59:37.000000000 +0000
@@ -17,7 +17,7 @@

 #ifndef MAX_HWIFS
 # ifdef CONFIG_BLK_DEV_IDEPCI
-#define MAX_HWIFS      10
+#define MAX_HWIFS      14
 # else
 #define MAX_HWIFS      6
 # endif
diff -urp linux-2.6.16.orig/include/linux/major.h linux-2.6.16/include/linux/major.h
--- linux-2.6.16.orig/include/linux/major.h     2006-03-20 05:53:29.000000000 +0000
+++ linux-2.6.16/include/linux/major.h  2006-03-24 10:59:37.000000000 +0000
@@ -107,10 +107,16 @@
 #define IDE8_MAJOR             90
 #define IDE9_MAJOR             91

+#define IDE10_MAJOR            92
+#define IDE11_MAJOR            93
+
 #define DASD_MAJOR             94

 #define MDISK_MAJOR            95

+#define IDE12_MAJOR            96
+#define IDE13_MAJOR            97
+
 #define UBD_MAJOR              98

 #define JSFD_MAJOR             99


Regards
--
Tom
(Please CC me as I'm off the list)
