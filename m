Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSCHPsh>; Fri, 8 Mar 2002 10:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310919AbSCHPsT>; Fri, 8 Mar 2002 10:48:19 -0500
Received: from [195.63.194.11] ([195.63.194.11]:42758 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310917AbSCHPr7>; Fri, 8 Mar 2002 10:47:59 -0500
Message-ID: <3C88DCEF.5000708@evision-ventures.com>
Date: Fri, 08 Mar 2002 16:46:55 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.6 IDE 18
In-Reply-To: <Pine.LNX.4.33.0202232152200.26469-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------020300060000000107070401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020300060000000107070401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

No fixes for new problems which occured since today, just syncup.

- Remove help text about suitable compiler versions, which is obsoleted
   by the overall kernel reality.

- Remove traces of not progressing work in progress code for the
   CONFIG_BLK_DEV_ADMA option as well as the empty ide-adma.c file as
   well as CONFIG_BLK_DEV_IDEDMA_TCQ.

- Remove redundant CONFIG_BLK_DEV_IDE != n check in ide/Config.in. Hugh,
   this is a tricky one...

- Add EXPORT_SYMBOL(ide_fops) again, since it's used in ide-cd.c add a
   note there that this is actually possibly adding the same device twice
   to the devfs stuff.

- Finally change the MAINTAINER entry. Just too many persons bogged me
   about it and it doesn't take me too much time apparently.

- Apply sis.patch.20020304_1.

- Don't call ide_release_dma twice in cleanup_ata, since ide_unregister
   is already calling it for us. Change prototype of ide_unregister to
   take a hwif as parameter and disable an ioctl for removing/scanning
   hwif from the list of handled interfaces. I see no reasons for having
   it and doing it is the fastest DOS attack on my home system I know
   about it. Contrary to the comments found here and there, hdparm
   doesn't use it. There are better hot plugging interfaces coming to the
   kernel right now anyway.

- Wrap invalidate_drives in ide_unregister under the ide_lock instead of
   disabling and enabling interrupts during this operation. There are
   plenty of other places where the IDE drivers are enabling and
   disabling interrupts just to protect some data structures.

- Don't call destroy_proc_ide_drives(hwif) for every single drive out
   there.This routine takes a hwif as a parameter.

- Resync with the instable 2.5.6...

--------------020300060000000107070401
Content-Type: text/plain;
 name="ide-clean-18.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-18.diff"

diff -urN linux-2.5.6/MAINTAINERS linux/MAINTAINERS
--- linux-2.5.6/MAINTAINERS	Fri Mar  8 03:18:07 2002
+++ linux/MAINTAINERS	Fri Mar  8 10:49:13 2002
@@ -709,14 +709,12 @@
 S:	Supported 
 
 IDE DRIVER [GENERAL]
-P:	Andre Hedrick
-M:	andre@linux-ide.org
-M:	andre@linuxdiskcert.org
+P:	Martin Dalecki
+M:	martin@dalecki.de
+I:	pl_PL.ISO8859-2, de_DE.ISO8859-15, (en_US.ISO8859-1)
 L:	linux-kernel@vger.kernel.org
-W:	http://www.kernel.org/pub/linux/kernel/people/hedrick/
-W:	http://www.linux-ide.org/
-W:	http://www.linuxdiskcert.org/
-S:	Maintained
+W:	http://www.dalecki.de
+S:	Developement
 
 IDE/ATAPI CDROM DRIVER
 P:	Jens Axboe
diff -urN linux-2.5.6/arch/alpha/defconfig linux/arch/alpha/defconfig
--- linux-2.5.6/arch/alpha/defconfig	Fri Mar  8 03:18:32 2002
+++ linux/arch/alpha/defconfig	Fri Mar  8 10:49:13 2002
@@ -255,7 +255,6 @@
 # CONFIG_IDEDMA_PCI_WIP is not set
 # CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
 # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_AEC62XX_TUNING is not set
 CONFIG_BLK_DEV_ALI15X3=y
diff -urN linux-2.5.6/arch/arm/def-configs/iq80310 linux/arch/arm/def-configs/iq80310
--- linux-2.5.6/arch/arm/def-configs/iq80310	Fri Mar  8 03:18:15 2002
+++ linux/arch/arm/def-configs/iq80310	Fri Mar  8 10:49:13 2002
@@ -454,7 +454,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_IDEPCI_SHARE_IRQ is not set
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/i386/defconfig linux/arch/i386/defconfig
--- linux-2.5.6/arch/i386/defconfig	Fri Mar  8 03:18:13 2002
+++ linux/arch/i386/defconfig	Fri Mar  8 10:49:13 2002
@@ -258,7 +258,6 @@
 # CONFIG_IDEDMA_PCI_WIP is not set
 # CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
 # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_AEC62XX_TUNING is not set
 # CONFIG_BLK_DEV_ALI15X3 is not set
diff -urN linux-2.5.6/arch/ia64/defconfig linux/arch/ia64/defconfig
--- linux-2.5.6/arch/ia64/defconfig	Fri Mar  8 03:18:11 2002
+++ linux/arch/ia64/defconfig	Fri Mar  8 10:49:13 2002
@@ -207,7 +207,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/mips/defconfig-ddb5476 linux/arch/mips/defconfig-ddb5476
--- linux-2.5.6/arch/mips/defconfig-ddb5476	Fri Mar  8 03:18:28 2002
+++ linux/arch/mips/defconfig-ddb5476	Fri Mar  8 10:49:13 2002
@@ -224,7 +224,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_IDEPCI_SHARE_IRQ is not set
 # CONFIG_BLK_DEV_IDEDMA_PCI is not set
-# CONFIG_BLK_DEV_ADMA is not set
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
diff -urN linux-2.5.6/arch/mips/defconfig-it8172 linux/arch/mips/defconfig-it8172
--- linux-2.5.6/arch/mips/defconfig-it8172	Fri Mar  8 03:18:25 2002
+++ linux/arch/mips/defconfig-it8172	Fri Mar  8 10:49:13 2002
@@ -289,7 +289,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/mips64/kernel/ioctl32.c linux/arch/mips64/kernel/ioctl32.c
--- linux-2.5.6/arch/mips64/kernel/ioctl32.c	Fri Mar  8 03:18:31 2002
+++ linux/arch/mips64/kernel/ioctl32.c	Fri Mar  8 10:49:13 2002
@@ -750,9 +750,7 @@
 	IOCTL32_DEFAULT(HDIO_SET_NOWERR),
 	IOCTL32_DEFAULT(HDIO_SET_DMA),
 	IOCTL32_DEFAULT(HDIO_SET_PIO_MODE),
-	IOCTL32_DEFAULT(HDIO_SCAN_HWIF),
 	IOCTL32_DEFAULT(HDIO_SET_NICE),
-	//HDIO_UNREGISTER_HWIF
 
 	IOCTL32_DEFAULT(BLKROSET),			/* fs.h ioctls  */
 	IOCTL32_DEFAULT(BLKROGET),
diff -urN linux-2.5.6/arch/ppc/configs/common_defconfig linux/arch/ppc/configs/common_defconfig
--- linux-2.5.6/arch/ppc/configs/common_defconfig	Fri Mar  8 03:18:21 2002
+++ linux/arch/ppc/configs/common_defconfig	Fri Mar  8 10:49:13 2002
@@ -252,7 +252,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/ppc/configs/k2_defconfig linux/arch/ppc/configs/k2_defconfig
--- linux-2.5.6/arch/ppc/configs/k2_defconfig	Fri Mar  8 03:18:06 2002
+++ linux/arch/ppc/configs/k2_defconfig	Fri Mar  8 10:49:13 2002
@@ -235,7 +235,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/ppc/configs/menf1_defconfig linux/arch/ppc/configs/menf1_defconfig
--- linux-2.5.6/arch/ppc/configs/menf1_defconfig	Fri Mar  8 03:18:03 2002
+++ linux/arch/ppc/configs/menf1_defconfig	Fri Mar  8 10:49:13 2002
@@ -239,7 +239,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 # CONFIG_IDEPCI_SHARE_IRQ is not set
 # CONFIG_BLK_DEV_IDEDMA_PCI is not set
-# CONFIG_BLK_DEV_ADMA is not set
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
diff -urN linux-2.5.6/arch/ppc/configs/pmac_defconfig linux/arch/ppc/configs/pmac_defconfig
--- linux-2.5.6/arch/ppc/configs/pmac_defconfig	Fri Mar  8 03:18:57 2002
+++ linux/arch/ppc/configs/pmac_defconfig	Fri Mar  8 10:49:13 2002
@@ -242,7 +242,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/ppc/configs/pplus_defconfig linux/arch/ppc/configs/pplus_defconfig
--- linux-2.5.6/arch/ppc/configs/pplus_defconfig	Fri Mar  8 03:18:55 2002
+++ linux/arch/ppc/configs/pplus_defconfig	Fri Mar  8 10:49:13 2002
@@ -246,7 +246,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/ppc/configs/sandpoint_defconfig linux/arch/ppc/configs/sandpoint_defconfig
--- linux-2.5.6/arch/ppc/configs/sandpoint_defconfig	Fri Mar  8 03:18:29 2002
+++ linux/arch/ppc/configs/sandpoint_defconfig	Fri Mar  8 10:49:13 2002
@@ -209,7 +209,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 # CONFIG_IDEDMA_PCI_AUTO is not set
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/ppc/defconfig linux/arch/ppc/defconfig
--- linux-2.5.6/arch/ppc/defconfig	Fri Mar  8 03:18:19 2002
+++ linux/arch/ppc/defconfig	Fri Mar  8 10:49:13 2002
@@ -252,7 +252,6 @@
 CONFIG_BLK_DEV_IDEPCI=y
 CONFIG_IDEPCI_SHARE_IRQ=y
 CONFIG_BLK_DEV_IDEDMA_PCI=y
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_OFFBOARD is not set
 CONFIG_IDEDMA_PCI_AUTO=y
 CONFIG_BLK_DEV_IDEDMA=y
diff -urN linux-2.5.6/arch/ppc64/kernel/ioctl32.c linux/arch/ppc64/kernel/ioctl32.c
--- linux-2.5.6/arch/ppc64/kernel/ioctl32.c	Fri Mar  8 03:18:59 2002
+++ linux/arch/ppc64/kernel/ioctl32.c	Fri Mar  8 10:49:13 2002
@@ -3713,7 +3713,6 @@
 COMPATIBLE_IOCTL(HDIO_SET_MULTCOUNT),
 COMPATIBLE_IOCTL(HDIO_DRIVE_CMD),
 COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE),
-COMPATIBLE_IOCTL(HDIO_SCAN_HWIF),
 COMPATIBLE_IOCTL(HDIO_SET_NICE),
 /* 0x02 -- Floppy ioctls */
 COMPATIBLE_IOCTL(FDMSGON),
diff -urN linux-2.5.6/arch/sparc64/defconfig linux/arch/sparc64/defconfig
--- linux-2.5.6/arch/sparc64/defconfig	Fri Mar  8 03:18:23 2002
+++ linux/arch/sparc64/defconfig	Fri Mar  8 10:49:13 2002
@@ -291,7 +291,6 @@
 # CONFIG_IDEDMA_PCI_WIP is not set
 # CONFIG_BLK_DEV_IDEDMA_TIMEOUT is not set
 # CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
-CONFIG_BLK_DEV_ADMA=y
 # CONFIG_BLK_DEV_AEC62XX is not set
 # CONFIG_AEC62XX_TUNING is not set
 CONFIG_BLK_DEV_ALI15X3=y
diff -urN linux-2.5.6/arch/sparc64/kernel/ioctl32.c linux/arch/sparc64/kernel/ioctl32.c
--- linux-2.5.6/arch/sparc64/kernel/ioctl32.c	Fri Mar  8 03:18:24 2002
+++ linux/arch/sparc64/kernel/ioctl32.c	Fri Mar  8 10:49:13 2002
@@ -3973,7 +3973,6 @@
 COMPATIBLE_IOCTL(HDIO_SET_MULTCOUNT)
 COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
 COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE)
-COMPATIBLE_IOCTL(HDIO_SCAN_HWIF)
 COMPATIBLE_IOCTL(HDIO_SET_NICE)
 /* 0x02 -- Floppy ioctls */
 COMPATIBLE_IOCTL(FDMSGON)
diff -urN linux-2.5.6/arch/x86_64/ia32/ia32_ioctl.c linux/arch/x86_64/ia32/ia32_ioctl.c
--- linux-2.5.6/arch/x86_64/ia32/ia32_ioctl.c	Fri Mar  8 03:18:03 2002
+++ linux/arch/x86_64/ia32/ia32_ioctl.c	Fri Mar  8 10:49:13 2002
@@ -3059,7 +3059,6 @@
 COMPATIBLE_IOCTL(HDIO_SET_MULTCOUNT)
 COMPATIBLE_IOCTL(HDIO_DRIVE_CMD)
 COMPATIBLE_IOCTL(HDIO_SET_PIO_MODE)
-COMPATIBLE_IOCTL(HDIO_SCAN_HWIF)
 COMPATIBLE_IOCTL(HDIO_SET_NICE)
 /* 0x02 -- Floppy ioctls */
 COMPATIBLE_IOCTL(FDMSGON)
diff -urN linux-2.5.6/drivers/ide/Config.help linux/drivers/ide/Config.help
--- linux-2.5.6/drivers/ide/Config.help	Fri Mar  8 03:18:57 2002
+++ linux/drivers/ide/Config.help	Fri Mar  8 10:49:13 2002
@@ -251,10 +251,6 @@
   be (U)DMA capable but aren't. This is a blanket on/off test with no
   speed limit options.
 
-  Straight GNU GCC 2.7.3/2.8.X compilers are known to be safe;
-  whereas, many versions of EGCS have a problem and miscompile if you
-  say Y here.
-
   If in doubt, say N.
 
 CONFIG_BLK_DEV_IDEDMA_TIMEOUT
@@ -319,10 +315,6 @@
 
   It is SAFEST to say N to this question.
 
-CONFIG_BLK_DEV_ADMA
-  Please read the comments at the top of
-  <file:drivers/ide/ide-adma.c>.
-
 CONFIG_BLK_DEV_PDC_ADMA
   Please read the comments at the top of <file:drivers/ide/ide-pci.c>.
 
@@ -515,10 +507,16 @@
   For FastTrak enable overriding BIOS.
 
 CONFIG_BLK_DEV_SIS5513
-  This driver ensures (U)DMA support for SIS5513 chipset based
-  mainboards. SiS620/530 UDMA mode 4, SiS5600/5597 UDMA mode 2, all
-  other DMA mode 2 limited chipsets are unsupported to date.
+  This driver ensures (U)DMA support for SIS5513 chipset family based
+  mainboards.
 
+  The following chipsets are supported:
+  ATA16:  SiS5511, SiS5513
+  ATA33:  SiS5591, SiS5597, SiS5598, SiS5600
+  ATA66:  SiS530, SiS540, SiS620, SiS630, SiS640
+  ATA100: SiS635, SiS645, SiS650, SiS730, SiS735, SiS740,
+          SiS745, SiS750
+ 
   If you say Y here, you need to say Y to "Use DMA by default when
   available" as well.
 
diff -urN linux-2.5.6/drivers/ide/Config.in linux/drivers/ide/Config.in
--- linux-2.5.6/drivers/ide/Config.in	Fri Mar  8 03:18:57 2002
+++ linux/drivers/ide/Config.in	Fri Mar  8 10:49:13 2002
@@ -4,7 +4,7 @@
 # Andre Hedrick <andre@linux-ide.org>
 #
 mainmenu_option next_comment
-comment 'IDE, ATA and ATAPI Block devices'
+comment 'ATA and ATAPI Block devices'
 
 dep_tristate 'Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support' CONFIG_BLK_DEV_IDE $CONFIG_IDE
 comment 'Please see Documentation/ide.txt for help/info on IDE drives'
@@ -34,121 +34,120 @@
    dep_tristate '  SCSI emulation support' CONFIG_BLK_DEV_IDESCSI $CONFIG_BLK_DEV_IDE $CONFIG_SCSI
 
    comment 'IDE chipset support'
-   if [ "$CONFIG_BLK_DEV_IDE" != "n" ]; then
-      dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
-      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
-      dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
-      if [ "$CONFIG_PCI" = "y" ]; then
-	 dep_bool '  RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
-	 bool '  Generic PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
-	 if [ "$CONFIG_BLK_DEV_IDEPCI" = "y" ]; then
-	    bool '    Sharing PCI IDE interrupts support' CONFIG_IDEPCI_SHARE_IRQ
-	    bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
-	    bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
-	    dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
-            dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
-	    define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool '      ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
-	    dep_bool '      Attempt to HACK around Chipsets that TIMEOUT (WIP)' CONFIG_BLK_DEV_IDEDMA_TIMEOUT $CONFIG_IDEDMA_PCI_WIP
-	    dep_bool '      Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
-#	    dep_bool '      Asynchronous DMA support (WIP) (EXPERIMENTAL)' CONFIG_BLK_DEV_ADMA $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_IDEDMA_PCI_WIP
-	    define_bool CONFIG_BLK_DEV_ADMA $CONFIG_BLK_DEV_IDEDMA_PCI
-#	    dep_bool '      Tag Command Queue DMA support (WIP) (EXPERIMENTAL)' CONFIG_BLK_DEV_IDEDMA_TCQ $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_IDEDMA_PCI_WIP
-
-	    dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
-	    dep_bool '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
-	    dep_bool '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_mbool '      AMD Viper ATA-66 Override (WIP)' CONFIG_AMD74XX_OVERRIDE $CONFIG_BLK_DEV_AMD74XX $CONFIG_IDEDMA_PCI_WIP
-	    dep_bool '    CMD64X chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
-  	    dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
-	    dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
-	       dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
-	       dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
-	    fi
-	    if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
-	       dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
-	       dep_mbool '      IT8172 IDE Tuning support' CONFIG_IT8172_TUNING $CONFIG_BLK_DEV_IT8172 $CONFIG_IDEDMA_PCI_AUTO
-	    fi
-	    dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
-	    dep_mbool '   Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_BLK_DEV_ADMA $CONFIG_IDEDMA_PCI_WIP
-	    dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
-	    dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
-	    dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
-	    dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
-	    dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
-	    dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
-	    dep_bool '    VIA82CXXX chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
-         fi
-
-	 if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
-	    bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
-	 fi
-      fi
-      if [ "$CONFIG_ALL_PPC" = "y" ]; then
-	 bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
-	 dep_bool '      PowerMac IDE DMA support' CONFIG_BLK_DEV_IDEDMA_PMAC $CONFIG_BLK_DEV_IDE_PMAC
-	 dep_bool '        Use DMA by default' CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO $CONFIG_BLK_DEV_IDEDMA_PMAC
-	 if [ "$CONFIG_BLK_DEV_IDE_PMAC" = "y" ]; then
-	   define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PMAC
+   dep_bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640 $CONFIG_X86
+   dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
+   dep_bool '  ISA-PNP EIDE support' CONFIG_BLK_DEV_ISAPNP $CONFIG_ISAPNP
+   if [ "$CONFIG_PCI" = "y" ]; then
+      dep_bool '  RZ1000 chipset bugfix/support' CONFIG_BLK_DEV_RZ1000 $CONFIG_X86
+      bool '  Generic PCI IDE chipset support' CONFIG_BLK_DEV_IDEPCI
+      if [ "$CONFIG_BLK_DEV_IDEPCI" = "y" ]; then
+	 bool '    Boot off-board chipsets first support' CONFIG_BLK_DEV_OFFBOARD
+	 bool '    Sharing PCI IDE interrupts support' CONFIG_IDEPCI_SHARE_IRQ
+	 bool '    Generic PCI bus-master DMA support' CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '      Use PCI DMA by default when available' CONFIG_IDEDMA_PCI_AUTO $CONFIG_BLK_DEV_IDEDMA_PCI
+         dep_bool '    Enable DMA only for disks ' CONFIG_IDEDMA_ONLYDISK $CONFIG_IDEDMA_PCI_AUTO
+	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    ATA Work(s) In Progress (EXPERIMENTAL)' CONFIG_IDEDMA_PCI_WIP $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_EXPERIMENTAL
+	 dep_bool '    Attempt to HACK around Chipsets that TIMEOUT (WIP)' CONFIG_BLK_DEV_IDEDMA_TIMEOUT $CONFIG_IDEDMA_PCI_WIP
+	 dep_bool '    Good-Bad DMA Model-Firmware (WIP)' CONFIG_IDEDMA_NEW_DRIVE_LISTINGS $CONFIG_IDEDMA_PCI_WIP
+	 dep_bool '    AEC62XX chipset support' CONFIG_BLK_DEV_AEC62XX $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_mbool '      AEC62XX Tuning support' CONFIG_AEC62XX_TUNING $CONFIG_BLK_DEV_AEC62XX
+	 dep_bool '    ALI M15x3 chipset support' CONFIG_BLK_DEV_ALI15X3 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_mbool '      ALI M15x3 WDC support (DANGEROUS)' CONFIG_WDC_ALI15X3 $CONFIG_BLK_DEV_ALI15X3
+	 dep_bool '    AMD Viper support' CONFIG_BLK_DEV_AMD74XX $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_mbool '      AMD Viper ATA-66 Override (WIP)' CONFIG_AMD74XX_OVERRIDE $CONFIG_BLK_DEV_AMD74XX $CONFIG_IDEDMA_PCI_WIP
+	 dep_bool '    CMD64X chipset support' CONFIG_BLK_DEV_CMD64X $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    CY82C693 chipset support' CONFIG_BLK_DEV_CY82C693 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    Cyrix CS5530 MediaGX chipset support' CONFIG_BLK_DEV_CS5530 $CONFIG_BLK_DEV_IDEDMA_PCI
+  	 dep_bool '    HPT34X chipset support' CONFIG_BLK_DEV_HPT34X $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_mbool '      HPT34X AUTODMA support (WIP)' CONFIG_HPT34X_AUTODMA $CONFIG_BLK_DEV_HPT34X $CONFIG_IDEDMA_PCI_WIP
+	 dep_bool '    HPT366 chipset support' CONFIG_BLK_DEV_HPT366 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 if [ "$CONFIG_X86" = "y" -o "$CONFIG_IA64" = "y" ]; then
+	    dep_mbool '    Intel PIIXn chipsets support' CONFIG_BLK_DEV_PIIX $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_mbool '      PIIXn Tuning support' CONFIG_PIIX_TUNING $CONFIG_BLK_DEV_PIIX $CONFIG_IDEDMA_PCI_AUTO
 	 fi
-	 if [ "$CONFIG_BLK_DEV_IDEDMA_PMAC" = "y" ]; then
-	   define_bool CONFIG_BLK_DEV_IDEPCI $CONFIG_BLK_DEV_IDEDMA_PMAC
+	 if [ "$CONFIG_MIPS_ITE8172" = "y" -o "$CONFIG_MIPS_IVR" = "y" ]; then
+	    dep_mbool '    IT8172 IDE support' CONFIG_BLK_DEV_IT8172 $CONFIG_BLK_DEV_IDEDMA_PCI
+	    dep_mbool '      IT8172 IDE Tuning support' CONFIG_IT8172_TUNING $CONFIG_BLK_DEV_IT8172 $CONFIG_IDEDMA_PCI_AUTO
 	 fi
+	 dep_bool '    NS87415 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_NS87415 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    OPTi 82C621 chipset enhanced support (EXPERIMENTAL)' CONFIG_BLK_DEV_OPTI621 $CONFIG_EXPERIMENTAL
+	 dep_mbool '    Pacific Digital A-DMA support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC_ADMA $CONFIG_IDEDMA_PCI_WIP
+	 dep_bool '    PROMISE PDC202{46|62|65|67|68|69|70} support' CONFIG_BLK_DEV_PDC202XX $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '      Special UDMA Feature' CONFIG_PDC202XX_BURST $CONFIG_BLK_DEV_PDC202XX
+	 dep_bool '      Special FastTrak Feature' CONFIG_PDC202XX_FORCE $CONFIG_BLK_DEV_PDC202XX
+	 dep_bool '    ServerWorks OSB4/CSB5 chipsets support' CONFIG_BLK_DEV_SVWKS $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
+	 dep_bool '    SiS5513 chipset support' CONFIG_BLK_DEV_SIS5513 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
+	 dep_bool '    SLC90E66 chipset support' CONFIG_BLK_DEV_SLC90E66 $CONFIG_BLK_DEV_IDEDMA_PCI $CONFIG_X86
+	 dep_bool '    Tekram TRM290 chipset support (EXPERIMENTAL)' CONFIG_BLK_DEV_TRM290 $CONFIG_BLK_DEV_IDEDMA_PCI
+	 dep_bool '    VIA82CXXX chipset support' CONFIG_BLK_DEV_VIA82CXXX $CONFIG_BLK_DEV_IDEDMA_PCI
       fi
-      if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
-	 dep_bool '    ICS IDE interface support' CONFIG_BLK_DEV_IDE_ICSIDE $CONFIG_ARCH_ACORN
-	 dep_bool '      ICS DMA support' CONFIG_BLK_DEV_IDEDMA_ICS $CONFIG_BLK_DEV_IDE_ICSIDE
-	 dep_bool '        Use ICS DMA by default' CONFIG_IDEDMA_ICS_AUTO $CONFIG_BLK_DEV_IDEDMA_ICS
-	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_ICS
-	 dep_bool '    RapIDE interface support' CONFIG_BLK_DEV_IDE_RAPIDE $CONFIG_ARCH_ACORN
-      fi
-      if [ "$CONFIG_AMIGA" = "y" ]; then
-	 dep_bool '  Amiga Gayle IDE interface support' CONFIG_BLK_DEV_GAYLE $CONFIG_AMIGA
-	 dep_mbool '    Amiga IDE Doubler support (EXPERIMENTAL)' CONFIG_BLK_DEV_IDEDOUBLER $CONFIG_BLK_DEV_GAYLE $CONFIG_EXPERIMENTAL
-      fi
-      if [ "$CONFIG_ZORRO" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	 dep_mbool '  Buddha/Catweasel IDE interface support (EXPERIMENTAL)' CONFIG_BLK_DEV_BUDDHA $CONFIG_ZORRO $CONFIG_EXPERIMENTAL
-      fi
-      if [ "$CONFIG_ATARI" = "y" ]; then
-	 dep_bool '  Falcon IDE interface support' CONFIG_BLK_DEV_FALCON_IDE $CONFIG_ATARI
-      fi
-      if [ "$CONFIG_MAC" = "y" ]; then
-	 dep_bool '  Macintosh Quadra/Powerbook IDE interface support' CONFIG_BLK_DEV_MAC_IDE $CONFIG_MAC
+
+      if [ "$CONFIG_PPC" = "y" -o "$CONFIG_ARM" = "y" ]; then
+	 bool '    Winbond SL82c105 support' CONFIG_BLK_DEV_SL82C105
       fi
-      if [ "$CONFIG_Q40" = "y" ]; then
-	 dep_bool '  Q40/Q60 IDE interface support' CONFIG_BLK_DEV_Q40IDE $CONFIG_Q40
+   fi
+   if [ "$CONFIG_ALL_PPC" = "y" ]; then
+      bool '    Builtin PowerMac IDE support' CONFIG_BLK_DEV_IDE_PMAC
+      dep_bool '      PowerMac IDE DMA support' CONFIG_BLK_DEV_IDEDMA_PMAC $CONFIG_BLK_DEV_IDE_PMAC
+      dep_bool '        Use DMA by default' CONFIG_BLK_DEV_IDEDMA_PMAC_AUTO $CONFIG_BLK_DEV_IDEDMA_PMAC
+      if [ "$CONFIG_BLK_DEV_IDE_PMAC" = "y" ]; then
+	 define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_PMAC
       fi
-      if [ "$CONFIG_8xx" = "y" ]; then
-         dep_bool '  MPC8xx IDE support' CONFIG_BLK_DEV_MPC8xx_IDE $CONFIG_8xx
+      if [ "$CONFIG_BLK_DEV_IDEDMA_PMAC" = "y" ]; then
+	 define_bool CONFIG_BLK_DEV_IDEPCI $CONFIG_BLK_DEV_IDEDMA_PMAC
       fi
+   fi
+   if [ "$CONFIG_ARCH_ACORN" = "y" ]; then
+      dep_bool '    ICS IDE interface support' CONFIG_BLK_DEV_IDE_ICSIDE $CONFIG_ARCH_ACORN
+      dep_bool '      ICS DMA support' CONFIG_BLK_DEV_IDEDMA_ICS $CONFIG_BLK_DEV_IDE_ICSIDE
+      dep_bool '        Use ICS DMA by default' CONFIG_IDEDMA_ICS_AUTO $CONFIG_BLK_DEV_IDEDMA_ICS
+      define_bool CONFIG_BLK_DEV_IDEDMA $CONFIG_BLK_DEV_IDEDMA_ICS
+      dep_bool '    RapIDE interface support' CONFIG_BLK_DEV_IDE_RAPIDE $CONFIG_ARCH_ACORN
+   fi
+   if [ "$CONFIG_AMIGA" = "y" ]; then
+      dep_bool '  Amiga Gayle IDE interface support' CONFIG_BLK_DEV_GAYLE $CONFIG_AMIGA
+      dep_mbool '    Amiga IDE Doubler support (EXPERIMENTAL)' CONFIG_BLK_DEV_IDEDOUBLER $CONFIG_BLK_DEV_GAYLE $CONFIG_EXPERIMENTAL
+   fi
+   if [ "$CONFIG_ZORRO" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      dep_mbool '  Buddha/Catweasel IDE interface support (EXPERIMENTAL)' CONFIG_BLK_DEV_BUDDHA $CONFIG_ZORRO $CONFIG_EXPERIMENTAL
+   fi
+   if [ "$CONFIG_ATARI" = "y" ]; then
+      dep_bool '  Falcon IDE interface support' CONFIG_BLK_DEV_FALCON_IDE $CONFIG_ATARI
+   fi
+   if [ "$CONFIG_MAC" = "y" ]; then
+      dep_bool '  Macintosh Quadra/Powerbook IDE interface support' CONFIG_BLK_DEV_MAC_IDE $CONFIG_MAC
+   fi
+   if [ "$CONFIG_Q40" = "y" ]; then
+      dep_bool '  Q40/Q60 IDE interface support' CONFIG_BLK_DEV_Q40IDE $CONFIG_Q40
+   fi
+   if [ "$CONFIG_8xx" = "y" ]; then
+      dep_bool '  MPC8xx IDE support' CONFIG_BLK_DEV_MPC8xx_IDE $CONFIG_8xx
+   fi
 
-      if [ "$CONFIG_BLK_DEV_MPC8xx_IDE" = "y" ]; then
-         choice 'Type of MPC8xx IDE interface'		\
-		"8xx_PCCARD	CONFIG_IDE_8xx_PCCARD	\
-		 8xx_DIRECT	CONFIG_IDE_8xx_DIRECT	\
-		 EXT_DIRECT	CONFIG_IDE_EXT_DIRECT"	8xx_PCCARD
-      fi
+   if [ "$CONFIG_BLK_DEV_MPC8xx_IDE" = "y" ]; then
+      choice 'Type of MPC8xx IDE interface'		\
+	     "8xx_PCCARD	CONFIG_IDE_8xx_PCCARD	\
+	      8xx_DIRECT	CONFIG_IDE_8xx_DIRECT	\
+	      EXT_DIRECT	CONFIG_IDE_EXT_DIRECT"	8xx_PCCARD
+   fi
 
-      bool '  Other IDE chipset support' CONFIG_IDE_CHIPSETS
-      if [ "$CONFIG_IDE_CHIPSETS" = "y" ]; then
-	 comment 'Note: most of these also require special kernel boot parameters'
-	 bool '    ALI M14xx support' CONFIG_BLK_DEV_ALI14XX
-	 bool '    DTC-2278 support' CONFIG_BLK_DEV_DTC2278
-	 bool '    Holtek HT6560B support' CONFIG_BLK_DEV_HT6560B
-	 if [ "$CONFIG_BLK_DEV_IDEDISK" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
-	    bool '    PROMISE DC4030 support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC4030
-	 fi
-	 bool '    QDI QD65xx support' CONFIG_BLK_DEV_QD65XX
-	 bool '    UMC-8672 support' CONFIG_BLK_DEV_UMC8672
+   bool '  Other IDE chipset support' CONFIG_IDE_CHIPSETS
+   if [ "$CONFIG_IDE_CHIPSETS" = "y" ]; then
+      comment 'Note: most of these also require special kernel boot parameters'
+      bool '    ALI M14xx support' CONFIG_BLK_DEV_ALI14XX
+      bool '    DTC-2278 support' CONFIG_BLK_DEV_DTC2278
+      bool '    Holtek HT6560B support' CONFIG_BLK_DEV_HT6560B
+      if [ "$CONFIG_BLK_DEV_IDEDISK" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
+	 bool '    PROMISE DC4030 support (EXPERIMENTAL)' CONFIG_BLK_DEV_PDC4030
       fi
+      bool '    QDI QD65xx support' CONFIG_BLK_DEV_QD65XX
+      bool '    UMC-8672 support' CONFIG_BLK_DEV_UMC8672
+   fi
+   if [ "$CONFIG_BLK_DEV_IDEDMA_PCI" = "y" -o \
+        "$CONFIG_BLK_DEV_IDEDMA_PMAC" = "y" -o \
+        "$CONFIG_BLK_DEV_IDEDMA_ICS" = "y" ]; then
+      bool '  IGNORE word93 Validation BITS' CONFIG_IDEDMA_IVB
    fi
 else
    bool 'Old hard disk (MFM/RLL/IDE) driver' CONFIG_BLK_DEV_HD_ONLY
@@ -163,12 +162,6 @@
    define_bool CONFIG_IDEDMA_AUTO n
 fi
 
-if [ "$CONFIG_BLK_DEV_IDEDMA_PCI" = "y" -o \
-     "$CONFIG_BLK_DEV_IDEDMA_PMAC" = "y" -o \
-     "$CONFIG_BLK_DEV_IDEDMA_ICS" = "y" ]; then
-   bool '  IGNORE word93 Validation BITS' CONFIG_IDEDMA_IVB
-fi
-
 if [ "$CONFIG_BLK_DEV_TIVO" = "y" ]; then
   define_bool CONFIG_DMA_NONPCI y
 else
diff -urN linux-2.5.6/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.6/drivers/ide/Makefile	Fri Mar  8 03:18:11 2002
+++ linux/drivers/ide/Makefile	Fri Mar  8 10:49:13 2002
@@ -44,7 +44,6 @@
 ide-obj-$(CONFIG_BLK_DEV_HPT366)	+= hpt366.o
 ide-obj-$(CONFIG_BLK_DEV_HT6560B)	+= ht6560b.o
 ide-obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
-ide-obj-$(CONFIG_BLK_DEV_ADMA)		+= ide-adma.o
 ide-obj-$(CONFIG_BLK_DEV_IDEDMA_PCI)	+= ide-dma.o
 ide-obj-$(CONFIG_BLK_DEV_IDEPCI)	+= ide-pci.o
 ide-obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
diff -urN linux-2.5.6/drivers/ide/ide-adma.c linux/drivers/ide/ide-adma.c
--- linux-2.5.6/drivers/ide/ide-adma.c	Fri Mar  8 03:18:27 2002
+++ linux/drivers/ide/ide-adma.c	Thu Jan  1 01:00:00 1970
@@ -1,9 +0,0 @@
-/*
- *  linux/drivers/ide/ide-adma.c         Version 0.00	June 24, 2001
- *
- *  Copyright (c) 2001		Andre Hedrick <andre@linux-ide.org>
- *
- *  Asynchronous DMA -- TBA, this is a holding file.
- *
- */
-
diff -urN linux-2.5.6/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.6/drivers/ide/ide-cd.c	Fri Mar  8 03:18:28 2002
+++ linux/drivers/ide/ide-cd.c	Fri Mar  8 10:49:13 2002
@@ -2508,6 +2508,11 @@
 	if (!CDROM_CONFIG_FLAGS (drive)->close_tray)
 		devinfo->mask |= CDC_CLOSE_TRAY;
 
+	/* FIXME: I'm less that sure that this is the proper thing to do, since
+	 * ware already adding the devices to devfs int ide.c upon device
+	 * registration.
+	 */
+
 	devinfo->de = devfs_register(drive->de, "cd", DEVFS_FL_DEFAULT,
 				     HWIF(drive)->major, minor,
 				     S_IFBLK | S_IRUGO | S_IWUGO,
diff -urN linux-2.5.6/drivers/ide/ide-cs.c linux/drivers/ide/ide-cs.c
--- linux-2.5.6/drivers/ide/ide-cs.c	Fri Mar  8 03:18:23 2002
+++ linux/drivers/ide/ide-cs.c	Fri Mar  8 10:49:13 2002
@@ -401,7 +401,7 @@
     DEBUG(0, "ide_release(0x%p)\n", link);
 
     if (info->ndev) {
-	ide_unregister(info->hd);
+	ide_unregister(&ide_hwifs[info->hd]);
 	MOD_DEC_USE_COUNT;
     }
 
diff -urN linux-2.5.6/drivers/ide/ide-dma.c linux/drivers/ide/ide-dma.c
--- linux-2.5.6/drivers/ide/ide-dma.c	Fri Mar  8 03:18:16 2002
+++ linux/drivers/ide/ide-dma.c	Fri Mar  8 10:49:13 2002
@@ -707,8 +707,11 @@
 /*
  * Needed for allowing full modular support of ide-driver
  */
-int ide_release_dma (ide_hwif_t *hwif)
+int ide_release_dma(ide_hwif_t *hwif)
 {
+	if (!hwif->dma_base)
+		return;
+
 	if (hwif->dmatable_cpu) {
 		pci_free_consistent(hwif->pci_dev,
 				    PRD_ENTRIES * PRD_BYTES,
@@ -723,6 +726,8 @@
 	if ((hwif->dma_extra) && (hwif->channel == 0))
 		release_region((hwif->dma_base + 16), hwif->dma_extra);
 	release_region(hwif->dma_base, 8);
+	hwif->dma_base = 0;
+
 	return 1;
 }
 
diff -urN linux-2.5.6/drivers/ide/ide-pci.c linux/drivers/ide/ide-pci.c
--- linux-2.5.6/drivers/ide/ide-pci.c	Fri Mar  8 03:18:56 2002
+++ linux/drivers/ide/ide-pci.c	Fri Mar  8 10:49:13 2002
@@ -6,15 +6,8 @@
  */
 
 /*
- *  This module provides support for automatic detection and
- *  configuration of all PCI IDE interfaces present in a system.
- */
-
-/*
- * Chipsets that are on the IDE_IGNORE list because of problems of not being
- * set at compile time.
- *
- * CONFIG_BLK_DEV_PDC202XX
+ *  This module provides support for automatic detection and configuration of
+ *  all PCI ATA host chip chanells interfaces present in a system.
  */
 
 #include <linux/config.h>
@@ -34,8 +27,14 @@
 #define PCI_VENDOR_ID_HINT 0x3388
 #define PCI_DEVICE_ID_HINT 0x8013
 
-#define	IDE_IGNORE	((void *)-1)
-#define IDE_NO_DRIVER	((void *)-2)
+/*
+ * Some combi chips, which can be used on the PCI bus or the VL bus can be in
+ * some systems acessed either through the PCI config space or through the
+ * hosts IO bus.  If the corresponding initialization driver is using the host
+ * IO space to deal with them please define the following.
+ */
+
+#define	ATA_PCI_IGNORE	((void *)-1)
 
 #ifdef CONFIG_BLK_DEV_AEC62XX
 extern unsigned int pci_init_aec62xx(struct pci_dev *);
@@ -306,7 +305,7 @@
 	 * but which still need some generic quirk handling.
 	 */
 	{PCI_VENDOR_ID_PCTECH, PCI_DEVICE_ID_PCTECH_SAMURAI_IDE, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
-	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_640, NULL, NULL, IDE_IGNORE, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
+	{PCI_VENDOR_ID_CMD, PCI_DEVICE_ID_CMD_640, NULL, NULL, ATA_PCI_IGNORE, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_NS, PCI_DEVICE_ID_NS_87410, NULL, NULL, NULL, NULL, {{0x43,0x08,0x08}, {0x47,0x08,0x08}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_HINT, PCI_DEVICE_ID_HINT, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
 	{PCI_VENDOR_ID_HOLTEK, PCI_DEVICE_ID_HOLTEK_6565, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, 0 },
@@ -314,7 +313,7 @@
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886A, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_UMC, PCI_DEVICE_ID_UMC_UM8886BF, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_FIXIRQ },
 	{PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C561, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0, ATA_F_NOADMA },
-	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL, IDE_NO_DRIVER, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
+	{PCI_VENDOR_ID_TTI, PCI_DEVICE_ID_TTI_HPT366, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, OFF_BOARD, 240, ATA_F_IRQ | ATA_F_HPTHACK },
 	{0, 0, NULL, NULL, NULL, NULL, {{0x00,0x00,0x00}, {0x00,0x00,0x00}}, ON_BOARD, 0 }};
 
 /*
@@ -683,11 +682,6 @@
 		autodma = 1;
 #endif
 
-	if (d->init_hwif == IDE_NO_DRIVER) {
-		printk(KERN_WARNING "%s: detected chipset, but driver not compiled in!\n", dev->name);
-		d->init_hwif = NULL;
-	}
-
 	if (pci_enable_device(dev)) {
 		printk(KERN_WARNING "%s: Could not enable PCI device.\n", dev->name);
 		return;
@@ -883,11 +877,11 @@
  * This finds all PCI IDE controllers and calls appropriate initialization
  * functions for them.
  */
-static void __init ide_scan_pcidev(struct pci_dev *dev)
+static void __init scan_pcidev(struct pci_dev *dev)
 {
 	unsigned short vendor;
 	unsigned short device;
-	ide_pci_device_t	*d;
+	ide_pci_device_t *d;
 
 	vendor = dev->vendor;
 	device = dev->device;
@@ -898,7 +892,7 @@
 	while (d->vendor && !(d->vendor == vendor && d->device == device))
 		++d;
 
-	if (d->init_hwif == IDE_IGNORE)
+	if (d->init_hwif == ATA_PCI_IGNORE)
 		printk("%s: has been ignored by PCI bus scan\n", dev->name);
 	else if ((d->vendor == PCI_VENDOR_ID_OPTI && d->device == PCI_DEVICE_ID_OPTI_82C558) && !(PCI_FUNC(dev->devfn) & 1))
 		return;
@@ -927,12 +921,10 @@
 	struct pci_dev *dev;
 
 	if (!scan_direction) {
-		pci_for_each_dev(dev) {
-			ide_scan_pcidev(dev);
-		}
+		pci_for_each_dev(dev)
+			scan_pcidev(dev);
 	} else {
-		pci_for_each_dev_reverse(dev) {
-			ide_scan_pcidev(dev);
-		}
+		pci_for_each_dev_reverse(dev)
+			scan_pcidev(dev);
 	}
 }
diff -urN linux-2.5.6/drivers/ide/ide-probe.c linux/drivers/ide/ide-probe.c
--- linux-2.5.6/drivers/ide/ide-probe.c	Fri Mar  8 03:18:03 2002
+++ linux/drivers/ide/ide-probe.c	Fri Mar  8 10:49:13 2002
@@ -576,18 +576,19 @@
 {
 	request_queue_t *q = &drive->queue;
 	int max_sectors;
-#ifdef CONFIG_BLK_DEV_PDC4030
-	int is_pdc4030_chipset = (HWIF(drive)->chipset == ide_pdc4030);
-#else
-	const int is_pdc4030_chipset = 0;
-#endif
 
 	q->queuedata = HWGROUP(drive);
 	blk_init_queue(q, do_ide_request, &ide_lock);
 	blk_queue_segment_boundary(q, 0xffff);
 
 	/* IDE can do up to 128K per request, pdc4030 needs smaller limit */
-	max_sectors = (is_pdc4030_chipset ? 127 : 255);
+#ifdef CONFIG_BLK_DEV_PDC4030
+	if (HWIF(drive)->chipset == ide_pdc4030)
+		max_sectors = 127;
+	else
+#else
+		max_sectors = 255;
+#endif
 	blk_queue_max_sectors(q, max_sectors);
 
 	/* IDE DMA can do PRD_ENTRIES number of segments. */
diff -urN linux-2.5.6/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.6/drivers/ide/ide.c	Fri Mar  8 03:18:29 2002
+++ linux/drivers/ide/ide.c	Fri Mar  8 10:49:13 2002
@@ -445,7 +445,7 @@
 /*
  * Do not even *think* about calling this!
  */
-static void init_hwif_data (unsigned int index)
+static void init_hwif_data(ide_hwif_t *hwif, int index)
 {
 	static const byte ide_major[] = {
 		IDE0_MAJOR, IDE1_MAJOR, IDE2_MAJOR, IDE3_MAJOR, IDE4_MAJOR,
@@ -454,7 +454,6 @@
 
 	unsigned int unit;
 	hw_regs_t hw;
-	ide_hwif_t *hwif = &ide_hwifs[index];
 
 	/* bulk initialize hwif & drive info with zeros */
 	memset(hwif, 0, sizeof(ide_hwif_t));
@@ -507,7 +506,7 @@
 #define MAGIC_COOKIE 0x12345678
 static void __init init_ide_data (void)
 {
-	unsigned int index;
+	unsigned int h;
 	static unsigned long magic_cookie = MAGIC_COOKIE;
 
 	if (magic_cookie != MAGIC_COOKIE)
@@ -515,8 +514,8 @@
 	magic_cookie = 0;
 
 	/* Initialize all interface structures */
-	for (index = 0; index < MAX_HWIFS; ++index)
-		init_hwif_data(index);
+	for (h = 0; h < MAX_HWIFS; ++h)
+		init_hwif_data(&ide_hwifs[h], h);
 
 	/* Add default hw interfaces */
 	ide_init_default_hwifs();
@@ -1629,7 +1628,7 @@
  * But note that it can also be invoked as a result of a "sleep" operation
  * triggered by the mod_timer() call in ide_do_request.
  */
-void ide_timer_expiry (unsigned long data)
+void ide_timer_expiry(unsigned long data)
 {
 	ide_hwgroup_t	*hwgroup = (ide_hwgroup_t *) data;
 	ide_handler_t	*handler;
@@ -1667,7 +1666,7 @@
 			if ((expiry = hwgroup->expiry) != NULL) {
 				/* continue */
 				if ((wait = expiry(drive)) != 0) {
-					/* reset timer */
+					/* reengage timer */
 					hwgroup->timer.expires  = jiffies + wait;
 					add_timer(&hwgroup->timer);
 					spin_unlock_irqrestore(&ide_lock, flags);
@@ -1869,13 +1868,13 @@
  */
 ide_drive_t *get_info_ptr (kdev_t i_rdev)
 {
-	int		major = major(i_rdev);
-	unsigned int	h;
+	unsigned int major = major(i_rdev);
+	int h;
 
 	for (h = 0; h < MAX_HWIFS; ++h) {
 		ide_hwif_t  *hwif = &ide_hwifs[h];
 		if (hwif->present && major == hwif->major) {
-			unsigned unit = DEVICE_NR(i_rdev);
+			int unit = DEVICE_NR(i_rdev);
 			if (unit < MAX_DRIVES) {
 				ide_drive_t *drive = &hwif->drives[unit];
 				if (drive->present)
@@ -2012,13 +2011,13 @@
 {
 	ide_hwif_t *hwif;
 	ide_drive_t *drive;
-	int index;
-	int unit;
+	int h;
 
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		hwif = &ide_hwifs[index];
+	for (h = 0; h < MAX_HWIFS; ++h) {
+		int unit;
+		hwif = &ide_hwifs[h];
 		for (unit = 0; unit < MAX_DRIVES; ++unit) {
-			drive = &ide_hwifs[index].drives[unit];
+			drive = &ide_hwifs[h].drives[unit];
 			if (drive->revalidate) {
 				drive->revalidate = 0;
 				if (!initializing)
@@ -2164,22 +2163,19 @@
 #endif
 }
 
-void ide_unregister (unsigned int index)
+void ide_unregister(ide_hwif_t *hwif)
 {
 	struct gendisk *gd;
 	ide_drive_t *drive, *d;
-	ide_hwif_t *hwif, *g;
+	ide_hwif_t *g;
 	ide_hwgroup_t *hwgroup;
 	int irq_count = 0, unit, i;
 	unsigned long flags;
 	unsigned int p, minor;
 	ide_hwif_t old_hwif;
 
-	if (index >= MAX_HWIFS)
-		return;
 	save_flags(flags);	/* all CPUs */
 	cli();			/* all CPUs */
-	hwif = &ide_hwifs[index];
 	if (!hwif->present)
 		goto abort;
 	put_device(&hwif->device);
@@ -2202,7 +2198,7 @@
 	/*
 	 * All clear?  Then blow away the buffer cache
 	 */
-	sti();
+	spin_lock_irqsave(&ide_lock, flags);
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		drive = &hwif->drives[unit];
 		if (!drive->present)
@@ -2214,11 +2210,13 @@
 				invalidate_device(devp, 0);
 			}
 		}
+
+	}
+
 #ifdef CONFIG_PROC_FS
-		destroy_proc_ide_drives(hwif);
+	destroy_proc_ide_drives(hwif);
 #endif
-	}
-	cli();
+	spin_unlock_irqrestore(&ide_lock, flags);
 	hwgroup = hwif->hwgroup;
 
 	/*
@@ -2271,11 +2269,8 @@
 		hwgroup->hwif = HWIF(hwgroup->drive);
 
 #if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-	if (hwif->dma_base) {
-		(void) ide_release_dma(hwif);
-		hwif->dma_base = 0;
-	}
-#endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
+	ide_release_dma(hwif);
+#endif
 
 	/*
 	 * Remove us from the kernel's knowledge
@@ -2297,8 +2292,14 @@
 		kfree(gd);
 		hwif->gd = NULL;
 	}
+
+	/*
+	 * Reinitialize the hwif handler, but preserve any special methods for
+	 * it.
+	 */
+
 	old_hwif		= *hwif;
-	init_hwif_data(index);	/* restore hwif data to pristine status */
+	init_hwif_data(hwif, hwif->index);
 	hwif->hwgroup		= old_hwif.hwgroup;
 	hwif->tuneproc		= old_hwif.tuneproc;
 	hwif->speedproc		= old_hwif.speedproc;
@@ -2390,12 +2391,11 @@
 				goto found;
 		}
 		for (index = 0; index < MAX_HWIFS; index++)
-			ide_unregister(index);
+			ide_unregister(&ide_hwifs[index]);
 	} while (retry--);
 	return -1;
 found:
-	if (hwif->present)
-		ide_unregister(index);
+	ide_unregister(hwif);
 	if (hwif->present)
 		return -1;
 	memcpy(&hwif->hw, hw, sizeof(*hw));
@@ -2756,21 +2756,6 @@
 				return -EACCES;
 			return ide_task_ioctl(drive, inode, file, cmd, arg);
 
-		case HDIO_SCAN_HWIF:
-		{
-			int args[3];
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-			if (copy_from_user(args, (void *)arg, 3 * sizeof(int)))
-				return -EFAULT;
-			if (ide_register(args[0], args[1], args[2]) == -1)
-				return -EIO;
-			return 0;
-		}
-	        case HDIO_UNREGISTER_HWIF:
-			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
-			/* (arg > MAX_HWIFS) checked in function */
-			ide_unregister(arg);
-			return 0;
 		case HDIO_SET_NICE:
 			if (!capable(CAP_SYS_ADMIN)) return -EACCES;
 			if (arg != (arg & ((1 << IDE_NICE_DSC_OVERLAP) | (1 << IDE_NICE_1))))
@@ -3479,6 +3464,7 @@
 	revalidate:		ide_revalidate_disk
 }};
 
+EXPORT_SYMBOL(ide_fops);
 EXPORT_SYMBOL(ide_hwifs);
 EXPORT_SYMBOL(ide_spin_wait_hwgroup);
 EXPORT_SYMBOL(revalidate_drives);
@@ -3490,7 +3476,6 @@
 
 EXPORT_SYMBOL(ide_lock);
 EXPORT_SYMBOL(drive_is_flashcard);
-EXPORT_SYMBOL(ide_timer_expiry);
 EXPORT_SYMBOL(ide_intr);
 EXPORT_SYMBOL(ide_get_queue);
 EXPORT_SYMBOL(ide_add_generic_settings);
@@ -3584,7 +3569,7 @@
  */
 static int __init ata_module_init(void)
 {
-	int i;
+	int h;
 
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver ver.:" VERSION "\n");
 
@@ -3714,8 +3699,8 @@
 
 	initializing = 0;
 
-	for (i = 0; i < MAX_HWIFS; ++i) {
-		ide_hwif_t  *hwif = &ide_hwifs[i];
+	for (h = 0; h < MAX_HWIFS; ++h) {
+		ide_hwif_t  *hwif = &ide_hwifs[h];
 		if (hwif->present)
 			ide_geninit(hwif);
 	}
@@ -3750,21 +3735,17 @@
 
 static void __exit cleanup_ata (void)
 {
-	int index;
+	int h;
 
 	unregister_reboot_notifier(&ide_notifier);
-	for (index = 0; index < MAX_HWIFS; ++index) {
-		ide_unregister(index);
-# if defined(CONFIG_BLK_DEV_IDEDMA) && !defined(CONFIG_DMA_NONPCI)
-		if (ide_hwifs[index].dma_base)
-			ide_release_dma(&ide_hwifs[index]);
-# endif /* (CONFIG_BLK_DEV_IDEDMA) && !(CONFIG_DMA_NONPCI) */
+	for (h = 0; h < MAX_HWIFS; ++h) {
+		ide_unregister(&ide_hwifs[h]);
 	}
 
 # ifdef CONFIG_PROC_FS
 	proc_ide_destroy();
 # endif
-	devfs_unregister (ide_devfs_handle);
+	devfs_unregister(ide_devfs_handle);
 }
 
 module_init(init_ata);
diff -urN linux-2.5.6/drivers/ide/sis5513.c linux/drivers/ide/sis5513.c
--- linux-2.5.6/drivers/ide/sis5513.c	Fri Mar  8 03:18:25 2002
+++ linux/drivers/ide/sis5513.c	Fri Mar  8 10:49:13 2002
@@ -1,11 +1,35 @@
 /*
- * linux/drivers/ide/sis5513.c		Version 0.11	June 9, 2000
+ * linux/drivers/ide/sis5513.c		Version 0.13	March 4, 2002
  *
  * Copyright (C) 1999-2000	Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C) 2002		Lionel Bouton <Lionel.Bouton@inet6.fr>, Maintainer
  * May be copied or modified under the terms of the GNU General Public License
  *
- * Thanks to SIS Taiwan for direct support and hardware.
- * Tested and designed on the SiS620/5513 chipset.
+*/
+
+/* Thanks :
+ * For direct support and hardware : SiS Taiwan.
+ * For ATA100 support advice       : Daniela Engert.
+ * For checking code correctness, providing patches :
+ * John Fremlin, Manfred Spraul
+ */
+
+/*
+ * Original tests and design on the SiS620/5513 chipset.
+ * ATA100 tests and design on the SiS735/5513 chipset.
+ * ATA16/33 design from specs
+ */
+
+/*
+ * TODO:
+ *	- Get ridden of SisHostChipInfo[] completness dependancy.
+ *	- Get ATA-133 datasheets, implement ATA-133 init code.
+ *	- Are there pre-ATA_16 SiS chips ? -> tune init code for them
+ *	  or remove ATA_00 define
+ *	- More checks in the config registers (force values instead of
+ *	  relying on the BIOS setting them correctly).
+ *	- Further optimisations ?
+ *	  . for example ATA66+ regs 0x48 & 0x4A
  */
 
 #include <linux/config.h>
@@ -28,88 +52,184 @@
 
 #include "ide_modes.h"
 
+// #define DEBUG
+/* if BROKEN_LEVEL is defined it limits the DMA mode
+   at boot time to its value */
+// #define BROKEN_LEVEL XFER_SW_DMA_0
 #define DISPLAY_SIS_TIMINGS
-#define SIS5513_DEBUG_DRIVE_INFO	0
 
-static struct pci_dev *host_dev = NULL;
+/* Miscellaneaous flags */
+#define SIS5513_LATENCY		0x01
+/* ATA transfer mode capabilities */
+#define ATA_00		0x00
+#define ATA_16		0x01
+#define ATA_33		0x02
+#define ATA_66		0x03
+#define ATA_100a	0x04
+#define ATA_100		0x05
+#define ATA_133		0x06
+
+static unsigned char dma_capability = 0x00;
 
-#define SIS5513_FLAG_ATA_00		0x00000000
-#define SIS5513_FLAG_ATA_16		0x00000001
-#define SIS5513_FLAG_ATA_33		0x00000002
-#define SIS5513_FLAG_ATA_66		0x00000004
-#define SIS5513_FLAG_LATENCY		0x00000010
 
+/*
+ * Debug code: following IDE config registers' changes
+ */
+#ifdef DEBUG
+/* Copy of IDE Config registers 0x00 -> 0x58
+   Fewer might be used depending on the actual chipset */
+static unsigned char ide_regs_copy[] = {
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0,
+	0x0, 0x0, 0x0, 0x0
+};
+
+static byte sis5513_max_config_register(void) {
+	switch(dma_capability) {
+		case ATA_00:
+		case ATA_16:	return 0x4f;
+		case ATA_33:	return 0x52;
+		case ATA_66:
+		case ATA_100a:
+		case ATA_100:
+		case ATA_133:
+		default:	return 0x57;
+	}
+}
+
+/* Read config registers, print differences from previous read */
+static void sis5513_load_verify_registers(struct pci_dev* dev, char* info) {
+	int i;
+	byte reg_val;
+	byte changed=0;
+	byte max = sis5513_max_config_register();
+
+	printk("SIS5513: %s, changed registers:\n", info);
+	for(i=0; i<=max; i++) {
+		pci_read_config_byte(dev, i, &reg_val);
+		if (reg_val != ide_regs_copy[i]) {
+			printk("%0#x: %0#x -> %0#x\n",
+			       i, ide_regs_copy[i], reg_val);
+			ide_regs_copy[i]=reg_val;
+			changed=1;
+		}
+	}
+
+	if (!changed) {
+		printk("none\n");
+	}
+}
+
+/* Load config registers, no printing */
+static void sis5513_load_registers(struct pci_dev* dev) {
+	int i;
+	byte max = sis5513_max_config_register();
+
+	for(i=0; i<=max; i++) {
+		pci_read_config_byte(dev, i, &(ide_regs_copy[i]));
+	}
+}
+
+/* Print a register */
+static void sis5513_print_register(int reg) {
+	printk(" %0#x:%0#x", reg, ide_regs_copy[reg]);
+}
+
+/* Print valuable registers */
+static void sis5513_print_registers(struct pci_dev* dev, char* marker) {
+	int i;
+	byte max = sis5513_max_config_register();
+
+	sis5513_load_registers(dev);
+	printk("SIS5513 %s\n", marker);
+	printk("SIS5513 dump:");
+	for(i=0x00; i<0x40; i++) {
+		if ((i % 0x10)==0) printk("\n             ");
+		sis5513_print_register(i);
+	}
+	for(; i<49; i++) {
+		sis5513_print_register(i);
+	}
+	printk("\n             ");
+
+	for(; i<=max; i++) {
+		sis5513_print_register(i);
+	}
+	printk("\n");
+}
+#endif
+
+
+/*
+ * Devices supported
+ */
 static const struct {
 	const char *name;
 	unsigned short host_id;
-	unsigned int flags;
+	unsigned char dma_capability;
+	unsigned char flags;
 } SiSHostChipInfo[] = {
-	{ "SiS530",	PCI_DEVICE_ID_SI_530,	SIS5513_FLAG_ATA_66, },
-	{ "SiS540",	PCI_DEVICE_ID_SI_540,	SIS5513_FLAG_ATA_66, },
-	{ "SiS620",	PCI_DEVICE_ID_SI_620,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS630",	PCI_DEVICE_ID_SI_630,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS635",	PCI_DEVICE_ID_SI_635,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS640",	PCI_DEVICE_ID_SI_640,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS645",	PCI_DEVICE_ID_SI_645,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS650",	PCI_DEVICE_ID_SI_650,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS730",	PCI_DEVICE_ID_SI_730,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS735",	PCI_DEVICE_ID_SI_735,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS740",	PCI_DEVICE_ID_SI_740,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS745",	PCI_DEVICE_ID_SI_745,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS750",	PCI_DEVICE_ID_SI_750,	SIS5513_FLAG_ATA_66|SIS5513_FLAG_LATENCY, },
-	{ "SiS5591",	PCI_DEVICE_ID_SI_5591,	SIS5513_FLAG_ATA_33, },
-	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	SIS5513_FLAG_ATA_33, },
-	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	SIS5513_FLAG_ATA_33, },
-	{ "SiS5511",	PCI_DEVICE_ID_SI_5511,	SIS5513_FLAG_ATA_16, },
-};
-
-#if 0
-
-static struct _pio_mode_mapping {
-	byte data_active;
-	byte recovery;
-	byte pio_mode;
-} pio_mode_mapping[] = {
-	{ 8, 12, 0 },
-	{ 6,  7, 1 },
-	{ 4,  4, 2 },
-	{ 3,  3, 3 },
-	{ 3,  1, 4 }
+	{ "SiS750",	PCI_DEVICE_ID_SI_750,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS745",	PCI_DEVICE_ID_SI_745,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS740",	PCI_DEVICE_ID_SI_740,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS735",	PCI_DEVICE_ID_SI_735,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS730",	PCI_DEVICE_ID_SI_730,	ATA_100a,	SIS5513_LATENCY },
+	{ "SiS650",	PCI_DEVICE_ID_SI_650,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS645",	PCI_DEVICE_ID_SI_645,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS635",	PCI_DEVICE_ID_SI_635,	ATA_100,	SIS5513_LATENCY },
+	{ "SiS640",	PCI_DEVICE_ID_SI_640,	ATA_66,		SIS5513_LATENCY },
+	{ "SiS630",	PCI_DEVICE_ID_SI_630,	ATA_66,		SIS5513_LATENCY },
+	{ "SiS620",	PCI_DEVICE_ID_SI_620,	ATA_66,		SIS5513_LATENCY },
+	{ "SiS540",	PCI_DEVICE_ID_SI_540,	ATA_66,		0},
+	{ "SiS530",	PCI_DEVICE_ID_SI_530,	ATA_66,		0},
+	{ "SiS5600",	PCI_DEVICE_ID_SI_5600,	ATA_33,		0},
+	{ "SiS5598",	PCI_DEVICE_ID_SI_5598,	ATA_33,		0},
+	{ "SiS5597",	PCI_DEVICE_ID_SI_5597,	ATA_33,		0},
+	{ "SiS5591",	PCI_DEVICE_ID_SI_5591,	ATA_33,		0},
+	{ "SiS5513",	PCI_DEVICE_ID_SI_5513,	ATA_16,		0},
+	{ "SiS5511",	PCI_DEVICE_ID_SI_5511,	ATA_16,		0},
 };
 
-static struct _dma_mode_mapping {
-	byte data_active;
-	byte recovery;
-	byte dma_mode;
-} dma_mode_mapping[] = {
-	{ 8, 8, 0 },
-	{ 3, 2, 1 },
-	{ 3, 1, 2 }
+/* Cycle time bits and values vary accross chip dma capabilities
+   These three arrays hold the register layout and the values to set.
+   Indexed by dma_capability and (dma_mode - XFER_UDMA_0) */
+static byte cycle_time_offset[] = {0,0,5,4,4,0,0};
+static byte cycle_time_range[] = {0,0,2,3,3,4,4};
+static byte cycle_time_value[][XFER_UDMA_5 - XFER_UDMA_0 + 1] = {
+	{0,0,0,0,0,0}, /* no udma */
+	{0,0,0,0,0,0}, /* no udma */
+	{3,2,1,0,0,0},
+	{7,5,3,2,1,0},
+	{7,5,3,2,1,0},
+	{11,7,5,4,2,1},
+	{0,0,0,0,0,0} /* not yet known, ask SiS */
 };
 
-static struct _udma_mode_mapping {
-	byte cycle_time;
-	char * udma_mode;
-} udma_mode_mapping[] = {
-	{ 8, "Mode 0" },
-	{ 6, "Mode 1" },
-	{ 4, "Mode 2" }, 
-	{ 3, "Mode 3" },
-	{ 2, "Mode 4" },
-	{ 0, "Mode 5" }
-};
+static struct pci_dev *host_dev = NULL;
 
-static __inline__ char * find_udma_mode (byte cycle_time)
-{
-	int n;
-	
-	for (n = 0; n <= 4; n++)
-		if (udma_mode_mapping[n].cycle_time <= cycle_time)
-			return udma_mode_mapping[n].udma_mode;
-	return udma_mode_mapping[4].udma_mode;
-}
-#endif
 
+/*
+ * Printing configuration
+ */
 #if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
@@ -118,12 +238,12 @@
 extern int (*sis_display_info)(char *, char **, off_t, int); /* ide-proc.c */
 static struct pci_dev *bmide_dev;
 
-static char *cable_type[] = {
+static char* cable_type[] = {
 	"80 pins",
 	"40 pins"
 };
 
-static char *recovery_time [] ={
+static char* recovery_time[] ={
 	"12 PCICLK", "1 PCICLK",
 	"2 PCICLK", "3 PCICLK",
 	"4 PCICLK", "5 PCICLCK",
@@ -134,101 +254,184 @@
 	"15 PCICLK", "15 PCICLK"
 };
 
-static char * cycle_time [] = {
-	"2 CLK", "2 CLK",
-	"3 CLK", "4 CLK",
-	"5 CLK", "6 CLK",
-	"7 CLK", "8 CLK"
-};
-
-static char * active_time [] = {
+static char* active_time[] = {
 	"8 PCICLK", "1 PCICLCK",
-	"2 PCICLK", "2 PCICLK",
+	"2 PCICLK", "3 PCICLK",
 	"4 PCICLK", "5 PCICLK",
 	"6 PCICLK", "12 PCICLK"
 };
 
+static char* cycle_time[] = {
+	"Reserved", "2 CLK",
+	"3 CLK", "4 CLK",
+	"5 CLK", "6 CLK",
+	"7 CLK", "8 CLK",
+	"9 CLK", "10 CLK",
+	"11 CLK", "12 CLK",
+	"Reserved", "Reserved",
+	"Reserved", "Reserved"
+};
+
+/* Generic add master or slave info function */
+static char* get_drives_info (char *buffer, byte pos)
+{
+	byte reg00, reg01, reg10, reg11; /* timing registers */
+	char* p = buffer;
+
+/* Postwrite/Prefetch */
+	pci_read_config_byte(bmide_dev, 0x4b, &reg00);
+	p += sprintf(p, "Drive %d:        Postwrite %s \t \t Postwrite %s\n",
+		     pos, (reg00 & (0x10 << pos)) ? "Enabled" : "Disabled",
+		     (reg00 & (0x40 << pos)) ? "Enabled" : "Disabled");
+	p += sprintf(p, "                Prefetch  %s \t \t Prefetch  %s\n",
+		     (reg00 & (0x01 << pos)) ? "Enabled" : "Disabled",
+		     (reg00 & (0x04 << pos)) ? "Enabled" : "Disabled");
+
+	pci_read_config_byte(bmide_dev, 0x40+2*pos, &reg00);
+	pci_read_config_byte(bmide_dev, 0x41+2*pos, &reg01);
+	pci_read_config_byte(bmide_dev, 0x44+2*pos, &reg10);
+	pci_read_config_byte(bmide_dev, 0x45+2*pos, &reg11);
+
+/* UDMA */
+	if (dma_capability >= ATA_33) {
+		p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
+			     (reg01 & 0x80)  ? "Enabled" : "Disabled",
+			     (reg11 & 0x80) ? "Enabled" : "Disabled");
+
+		p += sprintf(p, "                UDMA Cycle Time    ");
+		switch(dma_capability) {
+			case ATA_33:	p += sprintf(p, cycle_time[(reg01 & 0x60) >> 5]); break;
+			case ATA_66:
+			case ATA_100a:	p += sprintf(p, cycle_time[(reg01 & 0x70) >> 4]); break;
+			case ATA_100:	p += sprintf(p, cycle_time[reg01 & 0x0F]); break;
+			case ATA_133:
+			default:	p += sprintf(p, "133+ ?"); break;
+		}
+		p += sprintf(p, " \t UDMA Cycle Time    ");
+		switch(dma_capability) {
+			case ATA_33:	p += sprintf(p, cycle_time[(reg11 & 0x60) >> 5]); break;
+			case ATA_66:
+			case ATA_100a:	p += sprintf(p, cycle_time[(reg11 & 0x70) >> 4]); break;
+			case ATA_100:	p += sprintf(p, cycle_time[reg11 & 0x0F]); break;
+			case ATA_133:
+			default:	p += sprintf(p, "133+ ?"); break;
+		}
+		p += sprintf(p, "\n");
+	}
+
+/* Data Active */
+	p += sprintf(p, "                Data Active Time   ");
+	switch(dma_capability) {
+		case ATA_00:
+		case ATA_16: /* confirmed */
+		case ATA_33:
+		case ATA_66:
+		case ATA_100a: p += sprintf(p, active_time[reg01 & 0x07]); break;
+		case ATA_100: p += sprintf(p, active_time[(reg00 & 0x70) >> 4]); break;
+		case ATA_133:
+		default: p += sprintf(p, "133+ ?"); break;
+	}
+	p += sprintf(p, " \t Data Active Time   ");
+	switch(dma_capability) {
+		case ATA_00:
+		case ATA_16:
+		case ATA_33:
+		case ATA_66:
+		case ATA_100a: p += sprintf(p, active_time[reg11 & 0x07]); break;
+		case ATA_100: p += sprintf(p, active_time[(reg10 & 0x70) >> 4]); break;
+		case ATA_133:
+		default: p += sprintf(p, "133+ ?"); break;
+	}
+	p += sprintf(p, "\n");
+
+/* Data Recovery */
+	/* warning: may need (reg&0x07) for pre ATA66 chips */
+	p += sprintf(p, "                Data Recovery Time %s \t Data Recovery Time %s\n",
+		     recovery_time[reg00 & 0x0f], recovery_time[reg10 & 0x0f]);
+
+	return p;
+}
+
+static char* get_masters_info(char* buffer)
+{
+	return get_drives_info(buffer, 0);
+}
+
+static char* get_slaves_info(char* buffer)
+{
+	return get_drives_info(buffer, 1);
+}
+
+/* Main get_info, called on /proc/ide/sis reads */
 static int sis_get_info (char *buffer, char **addr, off_t offset, int count)
 {
-	int rc;
 	char *p = buffer;
-	byte reg,reg1;
+	byte reg;
 	u16 reg2, reg3;
 
+	p += sprintf(p, "\nSiS 5513 ");
+	switch(dma_capability) {
+		case ATA_00: p += sprintf(p, "Unknown???"); break;
+		case ATA_16: p += sprintf(p, "DMA 16"); break;
+		case ATA_33: p += sprintf(p, "Ultra 33"); break;
+		case ATA_66: p += sprintf(p, "Ultra 66"); break;
+		case ATA_100a:
+		case ATA_100: p += sprintf(p, "Ultra 100"); break;
+		case ATA_133:
+		default: p+= sprintf(p, "Ultra 133+"); break;
+	}
+	p += sprintf(p, " chipset\n");
 	p += sprintf(p, "--------------- Primary Channel ---------------- Secondary Channel -------------\n");
-	rc = pci_read_config_byte(bmide_dev, 0x4a, &reg);
-	p += sprintf(p, "Channel Status: %s \t \t \t \t %s \n",
-		     (reg & 0x02) ? "On" : "Off",
-		     (reg & 0x04) ? "On" : "Off");
-		     
-	rc = pci_read_config_byte(bmide_dev, 0x09, &reg);
+
+/* Status */
+	pci_read_config_byte(bmide_dev, 0x4a, &reg);
+	p += sprintf(p, "Channel Status: ");
+	if (dma_capability < ATA_66) {
+		p += sprintf(p, "%s \t \t \t \t %s\n",
+			     (reg & 0x04) ? "On" : "Off",
+			     (reg & 0x02) ? "On" : "Off");
+	} else {
+		p += sprintf(p, "%s \t \t \t \t %s \n",
+			     (reg & 0x02) ? "On" : "Off",
+			     (reg & 0x04) ? "On" : "Off");
+	}
+
+/* Operation Mode */
+	pci_read_config_byte(bmide_dev, 0x09, &reg);
 	p += sprintf(p, "Operation Mode: %s \t \t \t %s \n",
 		     (reg & 0x01) ? "Native" : "Compatible",
 		     (reg & 0x04) ? "Native" : "Compatible");
-		     	     
-	rc = pci_read_config_byte(bmide_dev, 0x48, &reg);
-	p += sprintf(p, "Cable Type:     %s \t \t \t %s\n",
-		     (reg & 0x10) ? cable_type[1] : cable_type[0],
-		     (reg & 0x20) ? cable_type[1] : cable_type[0]);
-		     
-	rc = pci_read_config_word(bmide_dev, 0x4c, &reg2);
-	rc = pci_read_config_word(bmide_dev, 0x4e, &reg3);
-	p += sprintf(p, "Prefetch Count: %d \t \t \t \t %d\n",
-		     reg2, reg3);
-
-	rc = pci_read_config_byte(bmide_dev, 0x4b, &reg);	     
-	p += sprintf(p, "Drive 0:        Postwrite %s \t \t Postwrite %s\n",
-		     (reg & 0x10) ? "Enabled" : "Disabled",
-		     (reg & 0x40) ? "Enabled" : "Disabled");
-	p += sprintf(p, "                Prefetch  %s \t \t Prefetch  %s\n",
-		     (reg & 0x01) ? "Enabled" : "Disabled",
-		     (reg & 0x04) ? "Enabled" : "Disabled");
-		          
-	rc = pci_read_config_byte(bmide_dev, 0x41, &reg);
-	rc = pci_read_config_byte(bmide_dev, 0x45, &reg1);
-	p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
-		     (reg & 0x80)  ? "Enabled" : "Disabled",
-		     (reg1 & 0x80) ? "Enabled" : "Disabled");
-	p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
-		     cycle_time[(reg & 0x70) >> 4], cycle_time[(reg1 & 0x70) >> 4]);
-	p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
-		     active_time[(reg & 0x07)], active_time[(reg1 &0x07)] ); 
-
-	rc = pci_read_config_byte(bmide_dev, 0x40, &reg);
-	rc = pci_read_config_byte(bmide_dev, 0x44, &reg1);
-	p += sprintf(p, "                Data Recovery Time %s \t Data Recovery Time %s\n",
-		     recovery_time[(reg & 0x0f)], recovery_time[(reg1 & 0x0f)]);
 
+/* 80-pin cable ? */
+	if (dma_capability > ATA_33) {
+		pci_read_config_byte(bmide_dev, 0x48, &reg);
+		p += sprintf(p, "Cable Type:     %s \t \t \t %s\n",
+			     (reg & 0x10) ? cable_type[1] : cable_type[0],
+			     (reg & 0x20) ? cable_type[1] : cable_type[0]);
+	}
 
-	rc = pci_read_config_byte(bmide_dev, 0x4b, &reg);	     
-	p += sprintf(p, "Drive 1:        Postwrite %s \t \t Postwrite %s\n",
-		     (reg & 0x20) ? "Enabled" : "Disabled",
-		     (reg & 0x80) ? "Enabled" : "Disabled");
-	p += sprintf(p, "                Prefetch  %s \t \t Prefetch  %s\n",
-		     (reg & 0x02) ? "Enabled" : "Disabled",
-		     (reg & 0x08) ? "Enabled" : "Disabled");
+/* Prefetch Count */
+	pci_read_config_word(bmide_dev, 0x4c, &reg2);
+	pci_read_config_word(bmide_dev, 0x4e, &reg3);
+	p += sprintf(p, "Prefetch Count: %d \t \t \t \t %d\n",
+		     reg2, reg3);
 
-	rc = pci_read_config_byte(bmide_dev, 0x43, &reg);
-	rc = pci_read_config_byte(bmide_dev, 0x47, &reg1);
-	p += sprintf(p, "                UDMA %s \t \t \t UDMA %s\n",
-		     (reg & 0x80)  ? "Enabled" : "Disabled",
-		     (reg1 & 0x80) ? "Enabled" : "Disabled");
-	p += sprintf(p, "                UDMA Cycle Time    %s \t UDMA Cycle Time    %s\n",
-		     cycle_time[(reg & 0x70) >> 4], cycle_time[(reg1 & 0x70) >> 4]);
-	p += sprintf(p, "                Data Active Time   %s \t Data Active Time   %s\n",
-		     active_time[(reg & 0x07)], active_time[(reg1 &0x07)] ); 
+	p = get_masters_info(p);
+	p = get_slaves_info(p);
 
-	rc = pci_read_config_byte(bmide_dev, 0x42, &reg);
-	rc = pci_read_config_byte(bmide_dev, 0x46, &reg1);
-	p += sprintf(p, "                Data Recovery Time %s \t Data Recovery Time %s\n",
-		     recovery_time[(reg & 0x0f)], recovery_time[(reg1 & 0x0f)]);
 	return p-buffer;
 }
 #endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
 
+
 byte sis_proc = 0;
 extern char *ide_xfer_verbose (byte xfer_rate);
 
+
+/*
+ * Configuration functions
+ */
+/* Enables per-drive prefetch and postwrite */
 static void config_drive_art_rwp (ide_drive_t *drive)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -237,14 +440,24 @@
 	byte reg4bh		= 0;
 	byte rw_prefetch	= (0x11 << drive->dn);
 
-	pci_read_config_byte(dev, 0x4b, &reg4bh);
+#ifdef DEBUG
+	printk("SIS5513: config_drive_art_rwp, drive %d\n", drive->dn);
+	sis5513_load_verify_registers(dev, "config_drive_art_rwp start");
+#endif
+
 	if (drive->type != ATA_DISK)
 		return;
-	
+	pci_read_config_byte(dev, 0x4b, &reg4bh);
+
 	if ((reg4bh & rw_prefetch) != rw_prefetch)
 		pci_write_config_byte(dev, 0x4b, reg4bh|rw_prefetch);
+#ifdef DEBUG
+	sis5513_load_verify_registers(dev, "config_drive_art_rwp end");
+#endif
 }
 
+
+/* Set per-drive active and recovery time */
 static void config_art_rwp_pio (ide_drive_t *drive, byte pio)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -255,6 +468,10 @@
 	unsigned short eide_pio_timing[6] = {600, 390, 240, 180, 120, 90};
 	unsigned short xfer_pio = drive->id->eide_pio_modes;
 
+#ifdef DEBUG
+	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
+#endif
+
 	config_drive_art_rwp(drive);
 	pio = ide_get_best_pio_mode(drive, 255, pio, NULL);
 
@@ -263,8 +480,8 @@
 
 	if (drive->id->eide_pio_iordy > 0) {
 		for (xfer_pio = 5;
-			xfer_pio>0 &&
-			drive->id->eide_pio_iordy>eide_pio_timing[xfer_pio];
+			(xfer_pio > 0) &&
+			(drive->id->eide_pio_iordy > eide_pio_timing[xfer_pio]);
 			xfer_pio--);
 	} else {
 		xfer_pio = (drive->id->eide_pio_modes & 4) ? 0x05 :
@@ -274,14 +491,10 @@
 
 	timing = (xfer_pio >= pio) ? xfer_pio : pio;
 
-/*
- *               Mode 0       Mode 1     Mode 2     Mode 3     Mode 4
- * Active time    8T (240ns)  6T (180ns) 4T (120ns) 3T  (90ns) 3T  (90ns)
- * 0x41 2:0 bits  000          110        100        011        011
- * Recovery time 12T (360ns)  7T (210ns) 4T (120ns) 3T  (90ns) 1T  (30ns)
- * 0x40 3:0 bits 0000         0111       0100       0011       0001
- * Cycle time    20T (600ns) 13T (390ns) 8T (240ns) 6T (180ns) 4T (120ns)
- */
+#ifdef DEBUG
+	printk("SIS5513: config_drive_art_rwp_pio, drive %d, pio %d, timing %d\n",
+	       drive->dn, pio, timing);
+#endif
 
 	switch(drive->dn) {
 		case 0:		drive_pci = 0x40; break;
@@ -291,31 +504,43 @@
 		default:	return;
 	}
 
-	pci_read_config_byte(dev, drive_pci, &test1);
-	pci_read_config_byte(dev, drive_pci|0x01, &test2);
-
-	/*
-	 * Do a blanket clear of active and recovery timings.
-	 */
-
-	test1 &= ~0x07;
-	test2 &= ~0x0F;
-
-	switch(timing) {
-		case 4:		test1 |= 0x01; test2 |= 0x03; break;
-		case 3:		test1 |= 0x03; test2 |= 0x03; break;
-		case 2:		test1 |= 0x04; test2 |= 0x04; break;
-		case 1:		test1 |= 0x07; test2 |= 0x06; break;
-		default:	break;
+	/* register layout changed with newer ATA100 chips */
+	if (dma_capability < ATA_100) {
+		pci_read_config_byte(dev, drive_pci, &test1);
+		pci_read_config_byte(dev, drive_pci+1, &test2);
+
+		/* Clear active and recovery timings */
+		test1 &= ~0x0F;
+		test2 &= ~0x07;
+
+		switch(timing) {
+			case 4:		test1 |= 0x01; test2 |= 0x03; break;
+			case 3:		test1 |= 0x03; test2 |= 0x03; break;
+			case 2:		test1 |= 0x04; test2 |= 0x04; break;
+			case 1:		test1 |= 0x07; test2 |= 0x06; break;
+			default:	break;
+		}
+		pci_write_config_byte(dev, drive_pci, test1);
+		pci_write_config_byte(dev, drive_pci+1, test2);
+	} else {
+		switch(timing) { /*   active  recovery
+					  v     v */
+			case 4:		test1 = 0x30|0x01; break;
+			case 3:		test1 = 0x30|0x03; break;
+			case 2:		test1 = 0x40|0x04; break;
+			case 1:		test1 = 0x60|0x07; break;
+			default:	break;
+		}
+		pci_write_config_byte(dev, drive_pci, test1);
 	}
 
-	pci_write_config_byte(dev, drive_pci, test1);
-	pci_write_config_byte(dev, drive_pci|0x01, test2);
+#ifdef DEBUG
+	sis5513_load_verify_registers(dev, "config_drive_art_rwp_pio start");
+#endif
 }
 
 static int config_chipset_for_pio (ide_drive_t *drive, byte pio)
 {
-	int err;
 	byte speed;
 
 	switch(pio) {
@@ -328,8 +553,7 @@
 
 	config_art_rwp_pio(drive, pio);
 	drive->current_speed = speed;
-	err = ide_config_drive_speed(drive, speed);
-	return err;
+	return ide_config_drive_speed(drive, speed);
 }
 
 static int sis5513_tune_chipset (ide_drive_t *drive, byte speed)
@@ -337,82 +561,73 @@
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 
-	byte			drive_pci, test1, test2;
-	byte			unmask, four_two, mask = 0;
-
-	if (host_dev) {
-		switch(host_dev->device) {
-			case PCI_DEVICE_ID_SI_530:
-			case PCI_DEVICE_ID_SI_540:
-			case PCI_DEVICE_ID_SI_620:
-			case PCI_DEVICE_ID_SI_630:
-			case PCI_DEVICE_ID_SI_635:
-			case PCI_DEVICE_ID_SI_640:
-			case PCI_DEVICE_ID_SI_645:
-			case PCI_DEVICE_ID_SI_650:
-			case PCI_DEVICE_ID_SI_730:
-			case PCI_DEVICE_ID_SI_735:
-			case PCI_DEVICE_ID_SI_740:
-			case PCI_DEVICE_ID_SI_745:
-			case PCI_DEVICE_ID_SI_750:
-				unmask   = 0xF0;
-				four_two = 0x01;
-				break;
-			default:
-				unmask   = 0xE0;
-				four_two = 0x00;
-				break;
-		}
-	} else {
-		unmask   = 0xE0;
-		four_two = 0x00;
-	}
+	byte			drive_pci, reg;
 
+#ifdef DEBUG
+	sis5513_load_verify_registers(dev, "sis5513_tune_chipset start");
+	printk("SIS5513: sis5513_tune_chipset, drive %d, speed %d\n",
+	       drive->dn, speed);
+#endif
 	switch(drive->dn) {
-		case 0:		drive_pci = 0x40;break;
-		case 1:		drive_pci = 0x42;break;
-		case 2:		drive_pci = 0x44;break;
-		case 3:		drive_pci = 0x46;break;
+		case 0:		drive_pci = 0x40; break;
+		case 1:		drive_pci = 0x42; break;
+		case 2:		drive_pci = 0x44; break;
+		case 3:		drive_pci = 0x46; break;
 		default:	return ide_dma_off;
 	}
 
-	pci_read_config_byte(dev, drive_pci, &test1);
-	pci_read_config_byte(dev, drive_pci|0x01, &test2);
+#ifdef BROKEN_LEVEL
+#ifdef DEBUG
+	printk("SIS5513: BROKEN_LEVEL activated, speed=%d -> speed=%d\n", speed, BROKEN_LEVEL);
+#endif
+	if (speed > BROKEN_LEVEL) speed = BROKEN_LEVEL;
+#endif
 
-	if ((speed <= XFER_MW_DMA_2) && (test2 & 0x80)) {
-		pci_write_config_byte(dev, drive_pci|0x01, test2 & ~0x80);
-		pci_read_config_byte(dev, drive_pci|0x01, &test2);
-	} else {
-		pci_write_config_byte(dev, drive_pci|0x01, test2 & ~unmask);
+	pci_read_config_byte(dev, drive_pci+1, &reg);
+	/* Disable UDMA bit for non UDMA modes on UDMA chips */
+	if ((speed < XFER_UDMA_0) && (dma_capability > ATA_16)) {
+		reg &= 0x7F;
+		pci_write_config_byte(dev, drive_pci+1, reg);
 	}
 
+	/* Config chip for mode */
 	switch(speed) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-		case XFER_UDMA_5: mask = 0x80; break;
-		case XFER_UDMA_4: mask = 0x90; break;
-		case XFER_UDMA_3: mask = 0xA0; break;
-		case XFER_UDMA_2: mask = (four_two) ? 0xB0 : 0xA0; break;
-		case XFER_UDMA_1: mask = (four_two) ? 0xD0 : 0xC0; break;
-		case XFER_UDMA_0: mask = unmask; break;
+		case XFER_UDMA_5:
+		case XFER_UDMA_4:
+		case XFER_UDMA_3:
+		case XFER_UDMA_2:
+		case XFER_UDMA_1:
+		case XFER_UDMA_0:
+			/* Force the UDMA bit on if we want to use UDMA */
+			reg |= 0x80;
+			/* clean reg cycle time bits */
+			reg &= ~((0xFF >> (8 - cycle_time_range[dma_capability]))
+				 << cycle_time_offset[dma_capability]);
+			/* set reg cycle time bits */
+			reg |= cycle_time_value[dma_capability-ATA_00][speed-XFER_UDMA_0]
+				<< cycle_time_offset[dma_capability];
+			pci_write_config_byte(dev, drive_pci+1, reg);
+			break;
 		case XFER_MW_DMA_2:
 		case XFER_MW_DMA_1:
 		case XFER_MW_DMA_0:
 		case XFER_SW_DMA_2:
 		case XFER_SW_DMA_1:
-		case XFER_SW_DMA_0: break;
+		case XFER_SW_DMA_0:
+			break;
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 		case XFER_PIO_4: return((int) config_chipset_for_pio(drive, 4));
 		case XFER_PIO_3: return((int) config_chipset_for_pio(drive, 3));
 		case XFER_PIO_2: return((int) config_chipset_for_pio(drive, 2));
 		case XFER_PIO_1: return((int) config_chipset_for_pio(drive, 1));
 		case XFER_PIO_0:
-		default:	 return((int) config_chipset_for_pio(drive, 0));
+		default:	 return((int) config_chipset_for_pio(drive, 0));	
 	}
-
-	if (speed > XFER_MW_DMA_2)
-		pci_write_config_byte(dev, drive_pci|0x01, test2|mask);
-
 	drive->current_speed = speed;
+#ifdef DEBUG
+	sis5513_load_verify_registers(dev, "sis5513_tune_chipset end");
+#endif
 	return ((int) ide_config_drive_speed(drive, speed));
 }
 
@@ -430,47 +645,27 @@
 	struct hd_driveid *id	= drive->id;
 	ide_hwif_t *hwif	= HWIF(drive);
 
-	byte			four_two = 0, speed = 0;
-	int			err;
+	byte			speed = 0;
 
 	byte unit		= (drive->select.b.unit & 0x01);
 	byte udma_66		= eighty_ninty_three(drive);
-	byte ultra_100		= 0;
 
-	if (host_dev) {
-		switch(host_dev->device) {
-			case PCI_DEVICE_ID_SI_635:
-			case PCI_DEVICE_ID_SI_640:
-			case PCI_DEVICE_ID_SI_645:
-			case PCI_DEVICE_ID_SI_650:
-			case PCI_DEVICE_ID_SI_730:
-			case PCI_DEVICE_ID_SI_735:
-			case PCI_DEVICE_ID_SI_740:
-			case PCI_DEVICE_ID_SI_745:
-			case PCI_DEVICE_ID_SI_750:
-				ultra_100 = 1;
-			case PCI_DEVICE_ID_SI_530:
-			case PCI_DEVICE_ID_SI_540:
-			case PCI_DEVICE_ID_SI_620:
-			case PCI_DEVICE_ID_SI_630:
-				four_two = 0x01;
-				break;
-			default:
-				four_two = 0x00; break;
-		}
-	}
+#ifdef DEBUG
+	printk("SIS5513: config_chipset_for_dma, drive %d, ultra %d\n",
+	       drive->dn, ultra);
+#endif
 
-	if ((id->dma_ultra & 0x0020) && (ultra) && (udma_66) && (four_two) && (ultra_100))
+	if ((id->dma_ultra & 0x0020) && ultra && udma_66 && (dma_capability >= ATA_100a))
 		speed = XFER_UDMA_5;
-	else if ((id->dma_ultra & 0x0010) && (ultra) && (udma_66) && (four_two))
+	else if ((id->dma_ultra & 0x0010) && ultra && udma_66 && (dma_capability >= ATA_66))
 		speed = XFER_UDMA_4;
-	else if ((id->dma_ultra & 0x0008) && (ultra) && (udma_66) && (four_two))
+	else if ((id->dma_ultra & 0x0008) && ultra && udma_66 && (dma_capability >= ATA_66))
 		speed = XFER_UDMA_3;
-	else if ((id->dma_ultra & 0x0004) && (ultra))
+	else if ((id->dma_ultra & 0x0004) && ultra && (dma_capability >= ATA_33))
 		speed = XFER_UDMA_2;
-	else if ((id->dma_ultra & 0x0002) && (ultra))
+	else if ((id->dma_ultra & 0x0002) && ultra && (dma_capability >= ATA_33))
 		speed = XFER_UDMA_1;
-	else if ((id->dma_ultra & 0x0001) && (ultra))
+	else if ((id->dma_ultra & 0x0001) && ultra && (dma_capability >= ATA_33))
 		speed = XFER_UDMA_0;
 	else if (id->dma_mword & 0x0004)
 		speed = XFER_MW_DMA_2;
@@ -489,11 +684,7 @@
 
 	outb(inb(hwif->dma_base+2)|(1<<(5+unit)), hwif->dma_base+2);
 
-	err = sis5513_tune_chipset(drive, speed);
-
-#if SIS5513_DEBUG_DRIVE_INFO
-	printk("%s: %s drive%d\n", drive->name, ide_xfer_verbose(speed), drive->dn);
-#endif /* SIS5513_DEBUG_DRIVE_INFO */
+	sis5513_tune_chipset(drive, speed);
 
 	return ((int)	((id->dma_ultra >> 11) & 7) ? ide_dma_on :
 			((id->dma_ultra >> 8) & 7) ? ide_dma_on :
@@ -550,9 +741,7 @@
 	return HWIF(drive)->dmaproc(dma_func, drive);
 }
 
-/*
- * sis5513_dmaproc() initiates/aborts (U)DMA read/write operations on a drive.
- */
+/* initiates/aborts (U)DMA read/write operations on a drive. */
 int sis5513_dmaproc (ide_dma_action_t func, ide_drive_t *drive)
 {
 	switch (func) {
@@ -567,15 +756,18 @@
 }
 #endif /* CONFIG_BLK_DEV_IDEDMA */
 
+/* Chip detection and general config */
 unsigned int __init pci_init_sis5513(struct pci_dev *dev)
 {
 	struct pci_dev *host;
 	int i = 0;
-	byte latency = 0;
 
-	pci_read_config_byte(dev, PCI_LATENCY_TIMER, &latency);
+#ifdef DEBUG
+	sis5513_print_registers(dev, "pci_init_sis5513 start");
+#endif
 
-	for (i = 0; i < ARRAY_SIZE (SiSHostChipInfo) && !host_dev; i++) {
+	/* Find the chip */
+	for (i = 0; i < ARRAY_SIZE(SiSHostChipInfo) && !host_dev; i++) {
 		host = pci_find_device (PCI_VENDOR_ID_SI,
 					SiSHostChipInfo[i].host_id,
 					NULL);
@@ -583,30 +775,67 @@
 			continue;
 
 		host_dev = host;
+		dma_capability = SiSHostChipInfo[i].dma_capability;
 		printk(SiSHostChipInfo[i].name);
 		printk("\n");
-		if (SiSHostChipInfo[i].flags & SIS5513_FLAG_LATENCY) {
-			if (latency != 0x10)
-				pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x10);
+
+		if (SiSHostChipInfo[i].flags & SIS5513_LATENCY) {
+			byte latency = (dma_capability == ATA_100)? 0x80 : 0x10; /* Lacking specs */
+			pci_write_config_byte(dev, PCI_LATENCY_TIMER, latency);
 		}
 	}
 
+	/* Make general config ops here
+	   1/ tell IDE channels to operate in Compabitility mode only
+	   2/ tell old chips to allow per drive IDE timings */
 	if (host_dev) {
-		byte reg52h = 0;
-
-		pci_read_config_byte(dev, 0x52, &reg52h);
-		if (!(reg52h & 0x04)) {
-			/* set IDE controller to operate in Compabitility mode only */
-			pci_write_config_byte(dev, 0x52, reg52h|0x04);
+		byte reg;
+		switch(dma_capability) {
+			case ATA_133:
+			case ATA_100:
+				/* Set compatibility bit */
+				pci_read_config_byte(dev, 0x49, &reg);
+				if (!(reg & 0x01)) {
+					pci_write_config_byte(dev, 0x49, reg|0x01);
+				}
+				break;
+			case ATA_100a:
+			case ATA_66:
+				/* On ATA_66 chips the bit was elsewhere */
+				pci_read_config_byte(dev, 0x52, &reg);
+				if (!(reg & 0x04)) {
+					pci_write_config_byte(dev, 0x52, reg|0x04);
+				}
+				break;
+			case ATA_33:
+				/* On ATA_33 we didn't have a single bit to set */
+				pci_read_config_byte(dev, 0x09, &reg);
+				if ((reg & 0x0f) != 0x00) {
+					pci_write_config_byte(dev, 0x09, reg&0xf0);
+				}
+			case ATA_16:
+				/* force per drive recovery and active timings
+				   needed on ATA_33 and below chips */
+				pci_read_config_byte(dev, 0x52, &reg);
+				if (!(reg & 0x08)) {
+					pci_write_config_byte(dev, 0x52, reg|0x08);
+				}
+				break;
+			case ATA_00:
+			default: break;
 		}
+
 #if defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS)
 		if (!sis_proc) {
 			sis_proc = 1;
 			bmide_dev = dev;
 			sis_display_info = &sis_get_info;
 		}
-#endif /* defined(DISPLAY_SIS_TIMINGS) && defined(CONFIG_PROC_FS) */
+#endif
 	}
+#ifdef DEBUG
+	sis5513_load_verify_registers(dev, "pci_init_sis5513 end");
+#endif
 	return 0;
 }
 
@@ -616,27 +845,10 @@
 	byte mask = hwif->channel ? 0x20 : 0x10;
 	pci_read_config_byte(hwif->pci_dev, 0x48, &reg48h);
 
-	if (host_dev) {
-		switch(host_dev->device) {
-			case PCI_DEVICE_ID_SI_530:
-			case PCI_DEVICE_ID_SI_540:
-			case PCI_DEVICE_ID_SI_620:
-			case PCI_DEVICE_ID_SI_630:
-			case PCI_DEVICE_ID_SI_635:
-			case PCI_DEVICE_ID_SI_640:
-			case PCI_DEVICE_ID_SI_645:
-			case PCI_DEVICE_ID_SI_650:
-			case PCI_DEVICE_ID_SI_730:
-			case PCI_DEVICE_ID_SI_735:
-			case PCI_DEVICE_ID_SI_740:
-			case PCI_DEVICE_ID_SI_745:
-			case PCI_DEVICE_ID_SI_750:
-				ata66 = (reg48h & mask) ? 0 : 1;
-			default:
-				break;
-		}
+	if (dma_capability >= ATA_66) {
+		ata66 = (reg48h & mask) ? 0 : 1;
 	}
-        return (ata66);
+        return ata66;
 }
 
 void __init ide_init_sis5513 (ide_hwif_t *hwif)
@@ -651,34 +863,17 @@
 		return;
 
 	if (host_dev) {
-		switch(host_dev->device) {
 #ifdef CONFIG_BLK_DEV_IDEDMA
-			case PCI_DEVICE_ID_SI_530:
-			case PCI_DEVICE_ID_SI_540:
-			case PCI_DEVICE_ID_SI_620:
-			case PCI_DEVICE_ID_SI_630:
-			case PCI_DEVICE_ID_SI_635:
-			case PCI_DEVICE_ID_SI_640:
-			case PCI_DEVICE_ID_SI_645:
-			case PCI_DEVICE_ID_SI_650:
-			case PCI_DEVICE_ID_SI_730:
-			case PCI_DEVICE_ID_SI_735:
-			case PCI_DEVICE_ID_SI_740:
-			case PCI_DEVICE_ID_SI_745:
-			case PCI_DEVICE_ID_SI_750:
-			case PCI_DEVICE_ID_SI_5600:
-			case PCI_DEVICE_ID_SI_5597:
-			case PCI_DEVICE_ID_SI_5591:
-				if (!noautodma)
-					hwif->autodma = 1;
-				hwif->highmem = 1;
-				hwif->dmaproc = &sis5513_dmaproc;
-				break;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
-			default:
-				hwif->autodma = 0;
-				break;
+		if (dma_capability > ATA_16) {
+			hwif->autodma = noautodma ? 0 : 1;
+			hwif->highmem = 1;
+			hwif->dmaproc = &sis5513_dmaproc;
+		} else {
+#endif
+			hwif->autodma = 0;
+#ifdef CONFIG_BLK_DEV_IDEDMA
 		}
+#endif
 	}
 	return;
 }
diff -urN linux-2.5.6/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.6/include/linux/hdreg.h	Fri Mar  8 03:18:29 2002
+++ linux/include/linux/hdreg.h	Fri Mar  8 10:49:13 2002
@@ -368,9 +368,7 @@
 #define HDIO_SET_NOWERR		0x0325	/* change ignore-write-error flag */
 #define HDIO_SET_DMA		0x0326	/* change use-dma flag */
 #define HDIO_SET_PIO_MODE	0x0327	/* reconfig interface to new speed */
-#define HDIO_SCAN_HWIF		0x0328	/* register and (re)scan interface */
 #define HDIO_SET_NICE		0x0329	/* set nice flags */
-#define HDIO_UNREGISTER_HWIF	0x032a  /* unregister interface */
 #define HDIO_SET_WCACHE		0x032b	/* change write cache enable-disable */
 #define HDIO_SET_ACOUSTIC	0x032c	/* change acoustic behavior */
 #define HDIO_SET_BUSSTATE	0x032d	/* set the bus state of the hwif */
@@ -645,17 +643,4 @@
 #define IDE_NICE_1		(3)	/* when probably won't affect us much */
 #define IDE_NICE_2		(4)	/* when we know it's on our expense */
 
-#ifdef __KERNEL__
-/*
- * These routines are used for kernel command line parameters from main.c:
- */
-#include <linux/config.h>
-
-#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
-int ide_register(int io_port, int ctl_port, int irq);
-void ide_unregister(unsigned int);
-#endif /* CONFIG_BLK_DEV_IDE || CONFIG_BLK_DEV_IDE_MODULE */
-
-#endif  /* __KERNEL__ */
-
 #endif	/* _LINUX_HDREG_H */
diff -urN linux-2.5.6/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.6/include/linux/ide.h	Fri Mar  8 03:18:16 2002
+++ linux/include/linux/ide.h	Fri Mar  8 10:53:21 2002
@@ -242,8 +242,7 @@
 /*
  * Register new hardware with ide
  */
-int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
-
+extern int ide_register_hw(hw_regs_t *hw, struct hwif_s **hwifp);
 /*
  * Set up hw_regs_t structure before calling ide_register_hw (optional)
  */
@@ -506,6 +505,8 @@
 	struct device	device;		/* global device tree handle */
 } ide_hwif_t;
 
+extern void ide_unregister(ide_hwif_t *hwif);
+
 /*
  * Status returned from various ide_ functions
  */

--------------020300060000000107070401--

