Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270755AbTG0MO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 08:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270756AbTG0MO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 08:14:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:60680 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S270755AbTG0MOm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 08:14:42 -0400
Date: Sun, 27 Jul 2003 14:29:40 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Tomas Szepe <szepe@pinerecords.com>
cc: alan@lxorguk.ukuu.org.uk, <B.Zolnierkiewicz@elka.pw.edu.pl>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] kill surplus menu in IDE Kconfig
In-Reply-To: <20030726200059.GC16160@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0307271425140.717-100000@serv>
References: <20030726200059.GC16160@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 26 Jul 2003, Tomas Szepe wrote:

> $subj
> 
> Patch against -bk3.

Moving up BLK_DEV_HD_ONLY like this is probably not a good idea, it makes 
everything a submenu of this, what might be confusing.
Try the patch below instead, it fixes the menu structure, everything which 
requires BLK_DEV_IDEDMA_PCI is now also under that menu.

bye, Roman

Index: drivers/ide/Kconfig
===================================================================
RCS file: /usr/src/cvsroot/linux-2.6/drivers/ide/Kconfig,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 Kconfig
--- drivers/ide/Kconfig	18 Jul 2003 21:22:07 -0000	1.1.1.1
+++ drivers/ide/Kconfig	27 Jul 2003 12:23:08 -0000
@@ -4,9 +4,7 @@
 # Andre Hedrick <andre@linux-ide.org>
 #
 
-menu "ATA/ATAPI/MFM/RLL support"
-
-config IDE
+menuconfig IDE
 	tristate "ATA/ATAPI/MFM/RLL support"
 	---help---
 	  If you say Y here, your kernel will be able to manage low cost mass
@@ -52,21 +50,19 @@ config IDE
 
 	  If unsure, say Y.
 
+if IDE
+
 config IDE_MAX_HWIFS 
 	int "Max IDE interfaces"
-	depends on ALPHA && IDE
+	depends on ALPHA
 	default 4
 	help
 	  This is the maximum number of IDE hardware interfaces that will
 	  be supported by the driver. Make sure it is at least as high as
 	  the number of IDE interfaces in your system.
 
-menu "IDE, ATA and ATAPI Block devices"
-	depends on IDE!=n
-
 config BLK_DEV_IDE
 	tristate "Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support"
-	depends on IDE
 	---help---
 	  If you say Y here, you will use the full-featured IDE driver to
 	  control up to ten ATA/IDE interfaces, each being able to serve a
@@ -95,13 +91,15 @@ config BLK_DEV_IDE
 	  If you have one or more IDE drives, say Y or M here. If your system
 	  has no IDE drives, or if memory requirements are really tight, you
 	  could say N here, and select the "Old hard disk driver" below
-	  instead to save about 13 KB of memory in the kernel.
+	  instead to save about 60 KB of memory in the kernel.
+
+if BLK_DEV_IDE
 
 comment "Please see Documentation/ide.txt for help/info on IDE drives"
 
 config BLK_DEV_HD_IDE
 	bool "Use old disk-only driver on primary interface"
-	depends on BLK_DEV_IDE && X86 && X86_PC9800!=y
+	depends on X86 && X86_PC9800!=y
 	---help---
 	  There are two drivers for MFM/RLL/IDE disks.  Most people use just
 	  the new enhanced driver by itself.  This option however installs the
@@ -119,7 +117,7 @@ config BLK_DEV_HD_IDE
 
 config BLK_DEV_HD_IDE98
 	bool "Use old disk-only driver on primary interface"
-	depends on BLK_DEV_IDE && X86 && X86_PC9800
+	depends on X86 && X86_PC9800
 	---help---
 	  There are two drivers for MFM/RLL/IDE disks.  Most people use just
 	  the new enhanced driver by itself.  This option however installs the
@@ -135,14 +133,8 @@ config BLK_DEV_HD_IDE98
 	  Normally, just say N here; you will then use the new driver for all
 	  4 interfaces.
 
-config BLK_DEV_HD
-	bool
-	default BLK_DEV_HD_ONLY if BLK_DEV_IDE=n
-	default BLK_DEV_HD_IDE if BLK_DEV_IDE
-
 config BLK_DEV_IDEDISK
 	tristate "Include IDE/ATA-2 DISK support"
-	depends on BLK_DEV_IDE
 	---help---
 	  This will include enhanced support for MFM/RLL/IDE hard disks.  If
 	  you have a MFM/RLL/IDE disk, and there is no special reason to use
@@ -183,14 +175,13 @@ config IDEDISK_STROKE
 
 config BLK_DEV_IDECS
 	tristate "PCMCIA IDE support"
-	depends on BLK_DEV_IDE && PCMCIA
+	depends on PCMCIA
 	help
 	  Support for outboard IDE disks, tape drives, and CD-ROM drives
 	  connected through a  PCMCIA card.
 
 config BLK_DEV_IDECD
 	tristate "Include IDE/ATAPI CDROM support"
-	depends on BLK_DEV_IDE
 	---help---
 	  If you have a CD-ROM drive using the ATAPI protocol, say Y. ATAPI is
 	  a newer protocol used by IDE CD-ROM and TAPE drives, similar to the
@@ -216,7 +207,6 @@ config BLK_DEV_IDECD
 #dep_tristate '  Include IDE/ATAPI TAPE support' CONFIG_BLK_DEV_IDETAPE $CONFIG_BLK_DEV_IDE
 config BLK_DEV_IDEFLOPPY
 	tristate "Include IDE/ATAPI FLOPPY support"
-	depends on BLK_DEV_IDE
 	---help---
 	  If you have an IDE floppy drive which uses the ATAPI protocol,
 	  answer Y.  ATAPI is a newer protocol used by IDE CD-ROM/tape/floppy
@@ -241,7 +231,7 @@ config BLK_DEV_IDEFLOPPY
 
 config BLK_DEV_IDESCSI
 	tristate "SCSI emulation support"
-	depends on BLK_DEV_IDE && SCSI
+	depends on SCSI
 	---help---
 	  This will provide SCSI host adapter emulation for IDE ATAPI devices,
 	  and will allow you to use a SCSI device driver instead of a native
@@ -267,7 +257,6 @@ config BLK_DEV_IDESCSI
 
 config IDE_TASK_IOCTL
 	bool "IDE Taskfile Access"
-	depends on BLK_DEV_IDE
 	help
 	  This is a direct raw access to the media.  It is a complex but
 	  elegant solution to test and validate the domain of the hardware and
@@ -278,19 +267,17 @@ config IDE_TASK_IOCTL
 
 config IDE_TASKFILE_IO
 	bool 'IDE Taskfile IO (EXPERIMENTAL)'
-	depends on BLK_DEV_IDE && EXPERIMENTAL
-	default n
+	depends on EXPERIMENTAL
 	---help---
 	  Use new taskfile IO code.
 
 	  It is safe to say Y to this question, in most cases.
 
 comment "IDE chipset support/bugfixes"
-	depends on BLK_DEV_IDE
 
 config BLK_DEV_CMD640
 	bool "CMD640 chipset bugfix/support"
-	depends on BLK_DEV_IDE && X86
+	depends on X86
 	---help---
 	  The CMD-Technologies CMD640 IDE chip is used on many common 486 and
 	  Pentium motherboards, usually in combination with a "Neptune" or
@@ -324,7 +311,7 @@ config BLK_DEV_CMD640_ENHANCED
 
 config BLK_DEV_IDEPNP
 	bool "PNP EIDE support"
-	depends on BLK_DEV_IDE && PNP
+	depends on PNP
 	help
 	  If you have a PnP (Plug and Play) compatible EIDE card and
 	  would like the kernel to automatically detect and activate
@@ -332,8 +319,7 @@ config BLK_DEV_IDEPNP
 
 config BLK_DEV_IDEPCI
 	bool "PCI IDE chipset support" if PCI
-	depends on BLK_DEV_IDE
-	default BLK_DEV_IDEDMA_PMAC if PPC_PMAC && BLK_DEV_IDEDMA_PMAC
+	default BLK_DEV_IDEDMA_PMAC if PPC_PMAC
 	help
 	  Say Y here for PCI systems which use IDE drive(s).
 	  This option helps the IDE driver to automatically detect and
@@ -414,29 +400,6 @@ config BLK_DEV_IDE_TCQ_DEPTH
 	  You probably just want the default of 32 here. If you enter an invalid
 	  number, the default value will be used.
 
-config BLK_DEV_OFFBOARD
-	bool "Boot off-board chipsets first support"
-	depends on PCI && BLK_DEV_IDEPCI
-	---help---
-	  Normally, IDE controllers built into the motherboard (on-board
-	  controllers) are assigned to ide0 and ide1 while those on add-in PCI
-	  cards (off-board controllers) are relegated to ide2 and ide3.
-	  Answering Y here will allow you to reverse the situation, with
-	  off-board controllers on ide0/1 and on-board controllers on ide2/3.
-	  This can improve the usability of some boot managers such as lilo
-	  when booting from a drive on an off-board controller.
-
-	  If you say Y here, and you actually want to reverse the device scan
-	  order as explained above, you also need to issue the kernel command
-	  line option "ide=reverse". (Try "man bootparam" or see the
-	  documentation of your boot loader (lilo or loadlin) about how to
-	  pass options to the kernel at boot time.)
-
-	  Note that, if you do this, the order of the hd* devices will be
-	  rearranged which may require modification of fstab and other files.
-
-	  If in doubt, say N.
-
 config BLK_DEV_IDEDMA_FORCED
 	bool "Force enable legacy 2.0.X HOSTS to use DMA"
 	depends on BLK_DEV_IDEDMA_PCI
@@ -470,13 +433,6 @@ config IDEDMA_ONLYDISK
 
 	  Generally say N here.
 
-config BLK_DEV_IDEDMA
-	bool
-	depends on BLK_DEV_IDE
-	default BLK_DEV_IDEDMA_ICS if ARCH_ACORN
-	default BLK_DEV_IDEDMA_PMAC if PPC_PMAC && BLK_DEV_IDE_PMAC
-	default BLK_DEV_IDEDMA_PCI if PCI && BLK_DEV_IDEPCI
-
 config IDEDMA_PCI_WIP
 	bool "ATA Work(s) In Progress (EXPERIMENTAL)"
 	depends on BLK_DEV_IDEDMA_PCI && EXPERIMENTAL
@@ -498,11 +454,6 @@ config IDEDMA_NEW_DRIVE_LISTINGS
 
 	  If in doubt, say N.
 
-config BLK_DEV_ADMA
-	bool
-	depends on PCI && BLK_DEV_IDEPCI
-	default BLK_DEV_IDEDMA_PCI
-
 config BLK_DEV_AEC62XX
 	tristate "AEC62XX chipset support"
 	depends on BLK_DEV_IDEDMA_PCI
@@ -585,7 +536,7 @@ config BLK_DEV_CS5520
 
 config BLK_DEV_CS5530
 	tristate "Cyrix/National Semiconductor CS5530 MediaGX chipset support"
-	depends on BLK_DEV_IDEDMA_PCIOA
+	depends on BLK_DEV_IDEDMA_PCI
 	help
 	  Include support for UDMA on the Cyrix MediaGX 5530 chipset. This
 	  will automatically be detected and configured if found.
@@ -672,13 +623,6 @@ config BLK_DEV_NS87415
 
 	  Please read the comments at the top of <file:drivers/ide/ns87415.c>.
 
-config BLK_DEV_OPTI621
-	tristate "OPTi 82C621 chipset enhanced support (EXPERIMENTAL)"
-	depends on PCI && BLK_DEV_IDEPCI && EXPERIMENTAL
-	help
-	  This is a driver for the OPTi 82C621 EIDE controller.
-	  Please read the comments at the top of <file:drivers/ide/opti621.c>.
-
 config BLK_DEV_PDC202XX_OLD
 	tristate "PROMISE PDC202{46|62|65|67} support"
 	depends on BLK_DEV_IDEDMA_PCI
@@ -711,18 +655,6 @@ config PDC202XX_FORCE
 	help
 	  For FastTrak enable overriding BIOS.
 
-config BLK_DEV_RZ1000
-	tristate "RZ1000 chipset bugfix/support"
-	depends on PCI && BLK_DEV_IDEPCI && X86
-	help
-	  The PC-Technologies RZ1000 IDE chip is used on many common 486 and
-	  Pentium motherboards, usually along with the "Neptune" chipset.
-	  Unfortunately, it has a rather nasty design flaw that can cause
-	  severe data corruption under many conditions. Say Y here to include
-	  code which automatically detects and corrects the problem under
-	  Linux. This may slow disk throughput by a few percent, but at least
-	  things will operate 100% reliably.
-
 config BLK_DEV_SVWKS
 	tristate "ServerWorks OSB4/CSB5/CSB6 chipsets support"
 	depends on BLK_DEV_IDEDMA_PCI
@@ -789,6 +721,32 @@ config BLK_DEV_VIA82CXXX
 	  This allows the kernel to change PIO, DMA and UDMA speeds and to
 	  configure the chip to optimum performance.
 
+config BLK_DEV_PDC202XX
+	bool
+	depends on BLK_DEV_IDEDMA_PCI && (BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW)
+	default y
+	---help---
+	  Promise Ultra33 or PDC20246
+	  Promise Ultra66 or PDC20262
+	  Promise Ultra100 or PDC20265/PDC20267/PDC20268
+
+	  This driver adds up to 4 more EIDE devices sharing a single
+	  interrupt. This add-on card is a bootable PCI UDMA controller. Since
+	  multiple cards can be installed and there are BIOS ROM problems that
+	  happen if the BIOS revisions of all installed cards (three-max) do
+	  not match, the driver attempts to do dynamic tuning of the chipset
+	  at boot-time for max-speed.  Ultra33 BIOS 1.25 or newer is required
+	  for more than one card. This card may require that you say Y to
+	  "Special UDMA Feature".
+
+	  If you say Y here, you need to say Y to "Use DMA by default when
+	  available" as well.
+
+	  Please read the comments at the top of
+	  <file:drivers/ide/pdc202xx.c>.
+
+	  If unsure, say N.
+
 config BLK_DEV_SL82C105
 	tristate "Winbond SL82c105 support"
 	depends on PCI && (PPC || ARM) && BLK_DEV_IDEPCI
@@ -797,9 +755,56 @@ config BLK_DEV_SL82C105
 	  special configuration for this chip. This is common on various CHRP
 	  motherboards, but could be used elsewhere. If in doubt, say Y.
 
+config BLK_DEV_ADMA
+	bool
+	depends on PCI && BLK_DEV_IDEPCI
+	default BLK_DEV_IDEDMA_PCI
+
+config BLK_DEV_OPTI621
+	tristate "OPTi 82C621 chipset enhanced support (EXPERIMENTAL)"
+	depends on PCI && BLK_DEV_IDEPCI && EXPERIMENTAL
+	help
+	  This is a driver for the OPTi 82C621 EIDE controller.
+	  Please read the comments at the top of <file:drivers/ide/opti621.c>.
+
+config BLK_DEV_RZ1000
+	tristate "RZ1000 chipset bugfix/support"
+	depends on PCI && BLK_DEV_IDEPCI && X86
+	help
+	  The PC-Technologies RZ1000 IDE chip is used on many common 486 and
+	  Pentium motherboards, usually along with the "Neptune" chipset.
+	  Unfortunately, it has a rather nasty design flaw that can cause
+	  severe data corruption under many conditions. Say Y here to include
+	  code which automatically detects and corrects the problem under
+	  Linux. This may slow disk throughput by a few percent, but at least
+	  things will operate 100% reliably.
+
+config BLK_DEV_OFFBOARD
+	bool "Boot off-board chipsets first support"
+	depends on PCI && BLK_DEV_IDEPCI
+	---help---
+	  Normally, IDE controllers built into the motherboard (on-board
+	  controllers) are assigned to ide0 and ide1 while those on add-in PCI
+	  cards (off-board controllers) are relegated to ide2 and ide3.
+	  Answering Y here will allow you to reverse the situation, with
+	  off-board controllers on ide0/1 and on-board controllers on ide2/3.
+	  This can improve the usability of some boot managers such as lilo
+	  when booting from a drive on an off-board controller.
+
+	  If you say Y here, and you actually want to reverse the device scan
+	  order as explained above, you also need to issue the kernel command
+	  line option "ide=reverse". (Try "man bootparam" or see the
+	  documentation of your boot loader (lilo or loadlin) about how to
+	  pass options to the kernel at boot time.)
+
+	  Note that, if you do this, the order of the hd* devices will be
+	  rearranged which may require modification of fstab and other files.
+
+	  If in doubt, say N.
+
 config BLK_DEV_IDE_PMAC
 	bool "Builtin PowerMac IDE support"
-	depends on BLK_DEV_IDE && PPC_PMAC
+	depends on PPC_PMAC
 	help
 	  This driver provides support for the built-in IDE controller on
 	  most of the recent Apple Power Macintoshes and PowerBooks.
@@ -827,11 +832,11 @@ config BLK_DEV_IDEDMA_PMAC_AUTO
 
 config BLK_DEV_IDE_SWARM
 	bool "SWARM onboard IDE support"
-	depends on BLK_DEV_IDE && SIBYTE_SWARM
+	depends on SIBYTE_SWARM
 
 config BLK_DEV_IDE_ICSIDE
 	tristate "ICS IDE interface support"
-	depends on BLK_DEV_IDE!=n && ARM && ARCH_ACORN
+	depends on ARM && ARCH_ACORN
 	help
 	  On Acorn systems, say Y here if you wish to use the ICS IDE
 	  interface card.  This is not required for ICS partition support.
@@ -857,16 +862,32 @@ config IDEDMA_ICS_AUTO
 	  If you suspect your hardware is at all flakey, say N here.
 	  Do NOT email the IDE kernel people regarding this issue!
 
+config IDEDMA_IVB
+	bool "IGNORE word93 Validation BITS"
+	depends on BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS
+	---help---
+	  There are unclear terms in ATA-4 and ATA-5 standards how certain
+	  hardware (an 80c ribbon) should be detected. Different interpretations
+	  of the standards have been released in hardware. This causes problems:
+	  for example, a host with Ultra Mode 4 (or higher) will not run
+	  in that mode with an 80c ribbon.
+
+	  If you are experiencing compatibility or performance problems, you
+	  MAY try to answering Y here. However, it does not necessarily solve
+	  any of your problems, it could even cause more of them.
+
+	  It is normally safe to answer Y; however, the default is N.
+
 config BLK_DEV_IDE_RAPIDE
 	tristate "RapIDE interface support"
-	depends on BLK_DEV_IDE!=n && ARM && ARCH_ACORN
+	depends on ARM && ARCH_ACORN
 	help
 	  Say Y here if you want to support the Yellowstone RapIDE controller
 	  manufactured for use with Acorn computers.
 
 config BLK_DEV_GAYLE
 	bool "Amiga Gayle IDE interface support"
-	depends on BLK_DEV_IDE && AMIGA
+	depends on AMIGA
 	help
 	  This is the IDE driver for the builtin IDE interface on some Amiga
 	  models. It supports both the `A1200 style' (used in A600 and A1200)
@@ -893,7 +914,7 @@ config BLK_DEV_IDEDOUBLER
 
 config BLK_DEV_BUDDHA
 	bool "Buddha/Catweasel/X-Surf IDE interface support (EXPERIMENTAL)"
-	depends on BLK_DEV_IDE && ZORRO && EXPERIMENTAL
+	depends on ZORRO && EXPERIMENTAL
 	help
 	  This is the IDE driver for the IDE interfaces on the Buddha, 
 	  Catweasel and X-Surf expansion boards.  It supports up to two interfaces 
@@ -905,7 +926,7 @@ config BLK_DEV_BUDDHA
 
 config BLK_DEV_FALCON_IDE
 	bool "Falcon IDE interface support"
-	depends on BLK_DEV_IDE && ATARI
+	depends on ATARI
 	help
 	  This is the IDE driver for the builtin IDE interface on the Atari
 	  Falcon. Say Y if you have a Falcon and want to use IDE devices (hard
@@ -914,7 +935,7 @@ config BLK_DEV_FALCON_IDE
 
 config BLK_DEV_MAC_IDE
 	bool "Macintosh Quadra/Powerbook IDE interface support"
-	depends on BLK_DEV_IDE && MAC
+	depends on MAC
 	help
 	  This is the IDE driver for the builtin IDE interface on some m68k
 	  Macintosh models. It supports both the `Quadra style' (used in
@@ -927,7 +948,7 @@ config BLK_DEV_MAC_IDE
 
 config BLK_DEV_Q40IDE
 	bool "Q40/Q60 IDE interface support"
-	depends on BLK_DEV_IDE && Q40
+	depends on Q40
 	help
 	  Enable the on-board IDE controller in the Q40/Q60.  This should
 	  normally be on; disable it only if you are running a custom hard
@@ -935,7 +956,7 @@ config BLK_DEV_Q40IDE
 
 config BLK_DEV_MPC8xx_IDE
 	bool "MPC8xx IDE support"
-	depends on BLK_DEV_IDE && 8xx
+	depends on 8xx
 	help
 	  This option provides support for IDE on Motorola MPC8xx Systems.
 	  Please see 'Type of MPC8xx IDE interface' for details.
@@ -975,7 +996,7 @@ endchoice
 # no isa -> no vlb
 config IDE_CHIPSETS
 	bool "Other IDE chipset support"
-	depends on BLK_DEV_IDE && ISA
+	depends on ISA
 	---help---
 	  Say Y here if you want to include enhanced support for various IDE
 	  interface chipsets used on motherboards and add-on cards. You can
@@ -990,7 +1011,7 @@ config IDE_CHIPSETS
 	  People with SCSI-only systems can say N here.
 
 comment "Note: most of these also require special kernel boot parameters"
-	depends on BLK_DEV_IDE && IDE_CHIPSETS
+	depends on IDE_CHIPSETS
 
 config BLK_DEV_4DRIVES
 	bool "Generic 4 drives/port support"
@@ -1004,7 +1025,7 @@ config BLK_DEV_4DRIVES
 
 config BLK_DEV_ALI14XX
 	tristate "ALI M14xx support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=ali14xx" kernel
 	  boot parameter.  It enables support for the secondary IDE interface
@@ -1015,7 +1036,7 @@ config BLK_DEV_ALI14XX
 
 config BLK_DEV_DTC2278
 	tristate "DTC-2278 support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=dtc2278" kernel
 	  boot parameter. It enables support for the secondary IDE interface
@@ -1025,7 +1046,7 @@ config BLK_DEV_DTC2278
 
 config BLK_DEV_HT6560B
 	tristate "Holtek HT6560B support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=ht6560b" kernel
 	  boot parameter. It enables support for the secondary IDE interface
@@ -1048,7 +1069,7 @@ config BLK_DEV_PDC4030
 
 config BLK_DEV_QD65XX
 	tristate "QDI QD65xx support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=qd65xx" kernel
 	  boot parameter.  It permits faster I/O speeds to be set.  See the
@@ -1057,7 +1078,7 @@ config BLK_DEV_QD65XX
 
 config BLK_DEV_UMC8672
 	tristate "UMC-8672 support"
-	depends on IDE_CHIPSETS && BLK_DEV_IDE
+	depends on IDE_CHIPSETS
 	help
 	  This driver is enabled at runtime using the "ide0=umc8672" kernel
 	  boot parameter. It enables support for the secondary IDE interface
@@ -1065,6 +1086,8 @@ config BLK_DEV_UMC8672
 	  See the files <file:Documentation/ide.txt> and
 	  <file:drivers/ide/umc8672.c> for more info.
 
+endif
+
 config BLK_DEV_HD_ONLY
 	bool "Old hard disk (MFM/RLL/IDE) driver"
 	depends on BLK_DEV_IDE=n
@@ -1077,70 +1100,35 @@ config BLK_DEV_HD_ONLY
 	  since it lacks the enhanced functionality of the new one. This makes
 	  it a good choice for systems with very tight memory restrictions, or
 	  for systems with only older MFM/RLL/ESDI drives. Choosing the old
-	  driver can save 13 KB or so of kernel memory.
+	  driver can save 60 KB or so of kernel memory.
 
 	  If you are unsure, then just choose the Enhanced IDE/MFM/RLL driver
 	  instead of this one. For more detailed information, read the
 	  Disk-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
 
-config IDEDMA_AUTO
-	bool
-	depends on IDEDMA_PCI_AUTO || BLK_DEV_IDEDMA_PMAC_AUTO || IDEDMA_ICS_AUTO
-	default y
-
-config IDEDMA_IVB
-	bool "IGNORE word93 Validation BITS"
-	depends on BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS
-	---help---
-	  There are unclear terms in ATA-4 and ATA-5 standards how certain
-	  hardware (an 80c ribbon) should be detected. Different interpretations
-	  of the standards have been released in hardware. This causes problems:
-	  for example, a host with Ultra Mode 4 (or higher) will not run
-	  in that mode with an 80c ribbon.
+config BLK_DEV_HD
+	def_bool BLK_DEV_HD_ONLY || BLK_DEV_HD_IDE
 
-	  If you are experiencing compatibility or performance problems, you
-	  MAY try to answering Y here. However, it does not necessarily solve
-	  any of your problems, it could even cause more of them.
+config BLK_DEV_IDEDMA
+	def_bool BLK_DEV_IDEDMA_ICS || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_PCI
 
-	  It is normally safe to answer Y; however, the default is N.
+config IDEDMA_AUTO
+	def_bool IDEDMA_PCI_AUTO || BLK_DEV_IDEDMA_PMAC_AUTO || IDEDMA_ICS_AUTO
 
 config DMA_NONPCI
-	bool
-	depends on BLK_DEV_TIVO
-	default y
-
-config BLK_DEV_PDC202XX
-	bool
-	depends on BLK_DEV_IDEDMA_PCI && (BLK_DEV_PDC202XX_OLD || BLK_DEV_PDC202XX_NEW)
-	default y
-	---help---
-	  Promise Ultra33 or PDC20246
-	  Promise Ultra66 or PDC20262
-	  Promise Ultra100 or PDC20265/PDC20267/PDC20268
-
-	  This driver adds up to 4 more EIDE devices sharing a single
-	  interrupt. This add-on card is a bootable PCI UDMA controller. Since
-	  multiple cards can be installed and there are BIOS ROM problems that
-	  happen if the BIOS revisions of all installed cards (three-max) do
-	  not match, the driver attempts to do dynamic tuning of the chipset
-	  at boot-time for max-speed.  Ultra33 BIOS 1.25 or newer is required
-	  for more than one card. This card may require that you say Y to
-	  "Special UDMA Feature".
-
-	  If you say Y here, you need to say Y to "Use DMA by default when
-	  available" as well.
-
-	  Please read the comments at the top of
-	  <file:drivers/ide/pdc202xx.c>.
-
-	  If unsure, say N.
+	def_bool BLK_DEV_TIVO
 
 config BLK_DEV_IDE_MODES
-	bool
-	depends on BLK_DEV_4DRIVES || BLK_DEV_ALI14XX || BLK_DEV_DTC2278 || BLK_DEV_HT6560B || BLK_DEV_PDC4030 || BLK_DEV_QD65XX || BLK_DEV_UMC8672 || BLK_DEV_AEC62XX=y || BLK_DEV_ALI15X3=y || BLK_DEV_AMD74XX=y || BLK_DEV_CMD640 || BLK_DEV_CMD64X=y || BLK_DEV_CS5530=y || BLK_DEV_CY82C693=y || BLK_DEV_HPT34X=y || BLK_DEV_HPT366=y || BLK_DEV_IDE_PMAC || BLK_DEV_IT8172 || BLK_DEV_MPC8xx_IDE || BLK_DEV_NFORCE=y || BLK_DEV_OPTI621=y || BLK_DEV_PDC202XX || BLK_DEV_PIIX=y || BLK_DEV_SVWKS=y || BLK_DEV_SIIMAGE=y || BLK_DEV_SIS5513=y || BLK_DEV_SL82C105=y || BLK_DEV_SLC90E66=y || BLK_DEV_VIA82CXXX=y
-	default y
-
-endmenu
+	def_bool BLK_DEV_4DRIVES || BLK_DEV_ALI14XX || BLK_DEV_DTC2278 || \
+		 BLK_DEV_HT6560B || BLK_DEV_PDC4030 || BLK_DEV_QD65XX || \
+		 BLK_DEV_UMC8672 || BLK_DEV_AEC62XX=y || BLK_DEV_ALI15X3=y || \
+		 BLK_DEV_AMD74XX=y || BLK_DEV_CMD640 || BLK_DEV_CMD64X=y || \
+		 BLK_DEV_CS5530=y || BLK_DEV_CY82C693=y || BLK_DEV_HPT34X=y || \
+		 BLK_DEV_HPT366=y || BLK_DEV_IDE_PMAC || BLK_DEV_IT8172 || \
+		 BLK_DEV_MPC8xx_IDE || BLK_DEV_NFORCE=y || BLK_DEV_OPTI621=y || \
+		 BLK_DEV_PDC202XX || BLK_DEV_PIIX=y || BLK_DEV_SVWKS=y || \
+		 BLK_DEV_SIIMAGE=y || BLK_DEV_SIS5513=y || BLK_DEV_SL82C105=y || \
+		 BLK_DEV_SLC90E66=y || BLK_DEV_VIA82CXXX=y
 
-endmenu
+endif

