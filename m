Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269353AbUJWAOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269353AbUJWAOn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269351AbUJWAOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:14:11 -0400
Received: from smtp09.auna.com ([62.81.186.19]:22155 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S269353AbUJWAMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:12:13 -0400
Date: Sat, 23 Oct 2004 00:12:10 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: pdc202xx_old broke boot [was Re: 2.6.9-mm1]
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
References: <20041022032039.730eb226.akpm@osdl.org>
In-Reply-To: <20041022032039.730eb226.akpm@osdl.org> (from akpm@osdl.org on
	Fri Oct 22 12:20:39 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1098490330l.28166l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

On 2004.10.22, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9/2.6.9-mm1/
> 

I upgraded from 2.6.9-rc3-mm3 to 2.6.9-mm1 and the system coould not boot.
What was before hde now was hda (guess ? root is on hde1...)

Thi system has a promise controller and the internal via one:
nada:~# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266] (rev 01)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
00:07.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:08.0 RAID bus controller: Promise Technology, Inc. PDC20319 (FastTrak S150 TX4) (rev 02)
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
00:0c.0 RAID bus controller: Promise Technology, Inc. PDC20267 (FastTrak100/Ultra100) (rev 02)
00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 62)
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX 400] (rev b2)

The PDC at 0c.0 is detected before the VIA. Last 2.6.9-mm1 skips the
activation of the ide channels if bios disables it (there's no drive connected).
The new pdc driver has an option to control this behavior, but the old one
does not. dmesg diff:

--- dmesg-2.6.9-rc3-mm3	2004-10-23 01:49:19.537021164 +0200
+++ dmesg-2.6.9-mm1	2004-10-23 01:48:05.149674818 +0200
@@ -1,4 +1,4 @@
-Linux version 2.6.9-rc3-mm3 (root@nada.cps.unizar.es) (gcc version 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1 SMP Fri Oct 8 00:59:09 CEST 2004
+Linux version 2.6.9-mm1 (root@nada.cps.unizar.es) (gcc version 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #1 SMP Fri Oct 22 14:36:09 CEST 2004
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
...
 Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
 PDC20267: IDE controller at PCI slot 0000:00:0c.0
 ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 18 (level, low) -> IRQ 169
 PDC20267: chipset revision 2
 PDC20267: 100% native mode on irq 169
-PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER Mode.
-    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:pio, hdb:pio
-    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:pio, hdd:DMA
-Probing IDE interface ide0...
-Probing IDE interface ide1...
+PDC20267: neither IDE port enabled (BIOS)
 VP_IDE: IDE controller at PCI slot 0000:00:11.1
 VP_IDE: chipset revision 6
 VP_IDE: not 100% native mode: will probe irqs later
 VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
-    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:DMA, hdf:pio
-    ide3: BM-DMA at 0xd408-0xd40f, BIOS settings: hdg:pio, hdh:DMA
+    ide0: BM-DMA at 0xd400-0xd407, BIOS settings: hda:DMA, hdb:pio
+    ide1: BM-DMA at 0xd408-0xd40f, BIOS settings: hdc:pio, hdd:DMA
+Probing IDE interface ide0...
+hda: Maxtor 6Y080L0, ATA DISK drive
+ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
+Probing IDE interface ide1...
+ide1: Wait for ready failed before probe !
+hdd: HL-DT-ST DVDRAM GSA-4040B, ATAPI CD/DVD-ROM drive
+ide1 at 0x170-0x177,0x376 on irq 15
 Probing IDE interface ide2...
-hde: Maxtor 6Y080L0, ATA DISK drive
-ide2 at 0x1f0-0x1f7,0x3f6 on irq 14
+ide2: Wait for ready failed before probe !
 Probing IDE interface ide3...
 ide3: Wait for ready failed before probe !
-hdh: HL-DT-ST DVDRAM GSA-4040B, ATAPI CD/DVD-ROM drive
-ide3 at 0x170-0x177,0x376 on irq 15
-Probing IDE interface ide0...
-Probing IDE interface ide1...
 Probing IDE interface ide4...
 ide4: Wait for ready failed before probe !
 Probing IDE interface ide5...
 ide5: Wait for ready failed before probe !
-hde: max request size: 128KiB
-hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
-hde: cache flushes supported
- hde: hde1 hde2 hde3 hde4 < hde5 >
-hdh: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
+hda: max request size: 128KiB
+hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
+hda: cache flushes supported
+ hda: hda1 hda2 hda3 hda4 < hda5 >
+hdd: ATAPI 32X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
 Uniform CD-ROM driver Revision: 3.20
 libata version 1.02 loaded.
 sata_promise version 1.00

How can I restore the old behaviour ? Plain 2.6.9 booted. So reconfiguring
fstab to say / == hda1 will make impossible switch between kernels ...
Better, can I force ide0=via, for any kernel I boot ?

Any idea ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc4-mm1 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #4


