Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSGQRI5>; Wed, 17 Jul 2002 13:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSGQRI5>; Wed, 17 Jul 2002 13:08:57 -0400
Received: from daimi.au.dk ([130.225.16.1]:23458 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S315431AbSGQRI4>;
	Wed, 17 Jul 2002 13:08:56 -0400
Message-ID: <3D35A554.5E7BBF59@daimi.au.dk>
Date: Wed, 17 Jul 2002 19:11:48 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Linux 2.4.19-rc1-ac5
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com> <3D340775.7F7AAFB9@daimi.au.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> 
> DMA is still broken on the ALI15X3 IDE controller.
> Does anybody know what the problem could be? The
> problem was introduced by this patch:
> 
> http://www.linuxdiskcert.org/ide-2.4.19-p8-ac1.all.convert.10.patch.bz2
> http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.10.patch.bz2
> 
> But it is a 700K patch, without knowing a little
> more about what is going on I'd have a hard time
> finding the problem in that patch.
> 
> Symptoms are:
> - DMA does not get enabled at boot.
> - Manually switching on DMA will cause all disk
>   access to hang, the IDE led stays light until
>   IDE is initialized at next boot.

I tried adding some debug output in alim15x3.c.
In the start and end of every function (except from
ali15x3_dmaproc) I print the name of the function.
Bellow is a diff between 2.4.19-pre8-ac1 with and
without the patch. ali15x3_config_drive_for_dma
does get called in both cases, but with the patch
it does not call config_chipset_for_dma. What can
the reason for that be?

--- file1.log	Wed Jul 17 17:55:13 2002
+++ file2.log	Wed Jul 17 17:56:48 2002
@@ -1,4 +1,4 @@
-Linux version 2.4.19-pre8-ac1 (kasperd@eddie) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #5 Wed Jul 17 17:46:00 CEST 2002
+Linux version 2.4.19-pre8-ac1 (kasperd@eddie) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #6 Wed Jul 17 17:46:06 CEST 2002
 BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
@@ -10,12 +10,12 @@
 zone(0): 4096 pages.
 zone(1): 45056 pages.
 zone(2): 0 pages.
-Kernel command line: BOOT_IMAGE=2419pre8ac1 ro BOOT_FILE=/boot/vmlinuz-2.4.19-pre8-ac1 root=/dev/hda5 console=tty1 init=/bin/sh console=ttyS1
+Kernel command line: BOOT_IMAGE=2419pre8ac1p ro BOOT_FILE=/boot/vmlinuz-2.4.19-pre8-ac1-patch root=/dev/hda5 console=tty1 init=/bin/sh console=ttyS1
 Initializing CPU#0
 Detected 350.803 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 699.59 BogoMIPS
-Memory: 191328k/196608k available (1427k kernel code, 4892k reserved, 405k data, 260k init, 0k highmem)
+Memory: 191332k/196608k available (1431k kernel code, 4888k reserved, 407k data, 256k init, 0k highmem)
 Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
 Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
 Mount cache hash table entries: 4096 (order: 3, 32768 bytes)
@@ -49,6 +49,7 @@
 block: 368 slots per queue, batch=92
 Uniform Multi-Platform E-IDE driver Revision: 6.31
 ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
+Enter: fixup_device_ali15x3()
 ALI15X3: IDE controller on PCI bus 00 dev 78
 PCI: Assigned IRQ 11 for device 00:0f.0
 ALI15X3: chipset revision 32
@@ -66,6 +67,7 @@
 Leave: ide_dmacapable_ali15x3()
 Enter: ide_init_ali15x3()
 Leave: ide_init_ali15x3()
+Leave: fixup_device_ali15x3()
 hda: IC35L040AVER07-0, ATA DISK drive
 hdb: CREATIVEDVD-ROM DVD2240E 03/18/98, ATAPI CD/DVD-ROM drive
 Enter: ali15x3_tune_drive()
@@ -82,15 +84,15 @@
 ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
 ide1 at 0x170-0x177,0x376 on irq 15
 Enter: ali15x3_config_drive_for_dma()
-Enter: ali15x3_can_ultra()
-Enter: config_chipset_for_dma()
-Enter: ali15x3_tune_chipset()
-hda: 66055248 sectors (33820 MB) w/1916KiB Cache, CHS=4111/255/63, (U)DMA
+Enter: ali15x3_tune_drive()
+Leave: ali15x3_tune_drive()
+hda: host protected area => 1
+hda: 66055248 sectors (33820 MB) w/1916KiB Cache, CHS=4111/255/63
 Enter: ali15x3_config_drive_for_dma()
-Enter: ali15x3_can_ultra()
-Enter: config_chipset_for_dma()
-Enter: ali15x3_tune_chipset()
-hdd: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=32760/16/63, (U)DMA
+Enter: ali15x3_tune_drive()
+Leave: ali15x3_tune_drive()
+hdd: host protected area => 1
+hdd: 33022080 sectors (16907 MB) w/462KiB Cache, CHS=32760/16/63
 Partition check:
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
  hdd: [PTBL] [2055/255/63] hdd1 hdd2 hdd4 < hdd5 hdd6 hdd7 hdd8 >
@@ -112,15 +114,15 @@
 kjournald starting.  Commit interval 5 seconds
 EXT3-fs: mounted filesystem with ordered data mode.
 VFS: Mounted root (ext3 filesystem) readonly.
-Freeing unused kernel memory: 260k freed
+Freeing unused kernel memory: 256k freed
 [root:console:~] t
-Linux (none) 2.4.19-pre8-ac1 #5 Wed Jul 17 17:46:00 CEST 2002 i586 unknown
+Linux (none) 2.4.19-pre8-ac1 #6 Wed Jul 17 17:46:06 CEST 2002 i586 unknown
 
 /dev/hda:
  multcount    =  0 (off)
  I/O support  =  0 (default 16-bit)
  unmaskirq    =  0 (off)
- using_dma    =  1 (on)
+ using_dma    =  0 (off)
  keepsettings =  0 (off)
  nowerr       =  0 (off)
  readonly     =  0 (off)

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
