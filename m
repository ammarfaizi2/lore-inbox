Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314287AbSDRKQb>; Thu, 18 Apr 2002 06:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314288AbSDRKQa>; Thu, 18 Apr 2002 06:16:30 -0400
Received: from [195.63.194.11] ([195.63.194.11]:23055 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S314287AbSDRKQZ>; Thu, 18 Apr 2002 06:16:25 -0400
Message-ID: <3CBE8E61.6070702@evision-ventures.com>
Date: Thu, 18 Apr 2002 11:14:09 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.5.8 IDE 38
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBED42.50003@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------040705060106010604020701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040705060106010604020701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wed Apr 17 12:23:52 CEST 2002 ide-clean-38

- Fix typo in ide_cmd_ioctl().

- Fix typo in cris driver.

- Don't retry operations on medium errors. (pointed out by Eric Andersen).

- Attach the no_io_32bit, io_32bit, no_unmask, unmask and slow fields to the
   ata_channel instead of the ata_device structure. They are a property of the
   channel and not just the devices attached to it. This allowed us to fix the
   set_io_32bit function by removing the CONFIG_BLK_DEV_DTC2278 conditional. In
   fact initialization shows that this is fixing many other host chipsets as
   well since all of them did expect sometimes particular values for those
   parameters in paralell on both drives attached to a channel but we where
   allowed to apply different values on a per drive basis.

- The keep_settings flag is now unconditional and we don't mess with any
   channel parameters before drive reset. Some chipsets really really expect
   unconditionally that the tweaks they apply are always present and this wasn't
   honoured thus far! We are expecting the user to have good reasons for
   manually tweaking the settings.

- Don't reset io_32bit in ata_pre_reset() unconditionally. There are chipsets
   out there which expect io_32bit to be *allways* enabled!

- Remove many obsolete and nawadays just confusing documentation from ide.txt

--------------040705060106010604020701
Content-Type: text/plain;
 name="ide-clean-38.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-clean-38.diff"

diff -urN linux-2.5.8/Documentation/ide.txt linux/Documentation/ide.txt
--- linux-2.5.8/Documentation/ide.txt	Mon Mar 18 21:37:06 2002
+++ linux/Documentation/ide.txt	Wed Apr 17 22:55:55 2002
@@ -1,71 +1,16 @@
-ide.txt -- Information regarding the Enhanced IDE drive in Linux 2.2/2.3/2.4
-===============================================================================
 
-   +-----------------------------------------------------------------+
-   |  The hdparm utility for controlling various IDE features is     |
-   |  packaged separately.  Look for it on popular linux FTP sites.  |
-   +-----------------------------------------------------------------+
-
-See description later on below for handling BIG IDE drives with >1024 cyls.
-
-Major features of the 2.1/2.2 IDE driver ("NEW!" marks changes since 2.0.xx):
-
-NEW!	- support for IDE ATAPI *floppy* drives
-	- support for IDE ATAPI *tape* drives, courtesy of Gadi Oxman
-		(re-run MAKEDEV.ide to create the tape device entries in /dev/)
-	- support for up to *four* IDE interfaces on one or more IRQs
-	- support for any mix of up to *eight* IDE drives
-	- support for reading IDE ATAPI cdrom drives (NEC,MITSUMI,VERTOS,SONY)
-	- support for audio functions
-	- auto-detection of interfaces, drives, IRQs, and disk geometries
-		- "single" drives should be jumpered as "master", not "slave"
-		  (both are now probed for)
-	- support for BIOSs which report "more than 16 heads" on disk drives
-	- uses LBA (slightly faster) on disk drives which support it
-	- support for lots of fancy (E)IDE drive functions with hdparm utility
-	- optional (compile time) support for 32-bit VLB data transfers
-	- support for IDE multiple (block) mode (same as hd.c)
-	- support for interrupt unmasking during I/O (better than hd.c)
-	- improved handshaking and error detection/recovery
-	- can co-exist with hd.c controlling the first interface
-	- run-time selectable 32bit interface support (using hdparm-2.3)
-	- support for reliable operation of buggy RZ1000 interfaces
-		- PCI support is automatic when rz1000 support is configured
-	- support for reliable operation of buggy CMD-640 interfaces
-		- PCI support is automatic when cmd640 support is configured
-		- for VLB, use kernel command line option:   ide0=cmd640_vlb
-		- this support also enables the secondary i/f when needed
-		- interface PIO timing & prefetch parameter support
-	- experimental support for UMC 8672 interfaces
-	- support for secondary interface on the FGI/Holtek HT-6560B VLB i/f
-		- use kernel command line option:   ide0=ht6560b
-	- experimental support for various IDE chipsets
-		- use appropriate kernel command line option from list below
-	- support for drives with a stuck WRERR_STAT bit
-	- support for removable devices, including door lock/unlock
-	- transparent support for DiskManager 6.0x and "Dynamic Disk Overlay"
-	- works with Linux fdisk, LILO, loadlin, bootln, etc..
-	- mostly transparent support for EZ-Drive disk translation software
-		- to use LILO with EZ, install LILO on the linux partition
-		  rather than on the master boot record, and then mark the
-		  linux partition as "bootable" or "active" using fdisk.
-		  (courtesy of Juha Laiho <jlaiho@ichaos.nullnet.fi>).
-	- auto-detect of disk translations by examining partition table
-	- ide-cd.c now compiles separate from ide.c
-	- ide-cd.c now supports door locking and auto-loading.
-		- Also preliminary support for multisession
-		  and direct reads of audio data.
-	- experimental support for Promise DC4030VL caching interface card
-		- email thanks/problems to: peterd@pnd-pc.demon.co.uk
-	- the hdparm-3.1 package can be used to set PIO modes for some chipsets.
-NEW!	- support for setting PIO modes with the OPTi 82C621, courtesy of Jaromir Koutek.
-NEW!	- support for loadable modules
-NEW!	- optional SCSI host adapter emulation for ATAPI devices
-NEW!	- generic PCI Bus-Master DMA support
-NEW!		- works with most Pentium PCI systems, chipsets, add-on cards
-NEW!		- works with regular DMA as well as Ultra DMA
-NEW!		- automatically probes for all PCI IDE interfaces
-NEW!	- generic support for using BIOS-configured Ultra-DMA (UDMA) transfers
+
+
+	Information regarding the Enhanced IDE drive in Linux 2.5
+
+
+==============================================================================
+
+   
+   The hdparm utility can be used to controll various IDE features on a
+   running system. It is packaged separately.  Please Look for it on popular
+   linux FTP sites.
+   
 
 
 ***  IMPORTANT NOTICES:  BUGGY IDE CHIPSETS CAN CORRUPT DATA!!
@@ -92,9 +37,9 @@
 ***
 ***  Use of the "serialize" option is no longer necessary.
 
-This is the multiple IDE interface driver, as evolved from hd.c.
-It supports up to six IDE interfaces, on one or more IRQs (usually 14 & 15).
-There can be up to two drives per interface, as per the ATA-2 spec.
+This is the multiple IDE interface driver, as evolved from hd.c.  It supports
+up to 9 IDE interfaces per default, on one or more IRQs (usually 14 & 15).
+There can be up to two drives per interface, as per the ATA-6 spec.
 
 Primary:    ide0, port 0x1f0; major=3;  hda is minor=0; hdb is minor=64
 Secondary:  ide1, port 0x170; major=22; hdc is minor=0; hdd is minor=64
@@ -103,16 +48,14 @@
 fifth..     ide4, usually PCI, probed
 sixth..     ide5, usually PCI, probed
 
-To access devices on interfaces > ide0, device entries must first be
-created in /dev for them.  To create such entries, simply run the included
-shell script:   /usr/src/linux/scripts/MAKEDEV.ide
-
-Apparently many older releases of Slackware had incorrect entries
-in /dev for hdc* and hdd* -- this can also be corrected by running MAKEDEV.ide
-
-ide.c automatically probes for most IDE interfaces (including all PCI ones),
-for the drives/geometries attached to those interfaces, and for the
-IRQ numbers being used by the interfaces (normally 14, 15 for ide0/ide1).
+To access devices on interfaces > ide0, device entries please make sure that
+device files for them are present in /dev.  If not, please create such
+entries, by simply running the included shell script:
+/usr/src/linux/scripts/MAKEDEV.ide
+
+This driver automatically probes for most IDE interfaces (including all PCI
+ones), for the drives/geometries attached to those interfaces, and for the IRQ
+lines being used by the interfaces (normally 14, 15 for ide0/ide1).
 
 For special cases, interfaces may be specified using kernel "command line"
 options.  For example,
@@ -170,11 +113,11 @@
 	hdc=768,16,32
 	hdc=noprobe
 
-Note that when only one IDE device is attached to an interface,
-it should be jumpered as "single" or "master", *not* "slave".
-Many folks have had "trouble" with cdroms because of this requirement,
-so ide.c now probes for both units, though success is more likely
-when the drive is jumpered correctly.
+Note that when only one IDE device is attached to an interface, it should be
+jumpered as "single" or "master", *not* "slave".  Many folks have had
+"trouble" with cdroms because of this requirement, so the driver now probes
+for both units, though success is more likely when the drive is jumpered
+correctly.
 
 Courtesy of Scott Snyder and others, the driver supports ATAPI cdrom drives
 such as the NEC-260 and the new MITSUMI triple/quad speed drives.
@@ -193,8 +136,8 @@
 (/dev/hdc).  To mount a CD in the cdrom drive, one would use something like:
 
 	ln -sf /dev/hdc /dev/cdrom
-	mkdir /cd
-	mount /dev/cdrom /cd -t iso9660 -o ro
+	mkdir /mnt/cdrom
+	mount /dev/cdrom /mnt/cdrom -t iso9660 -o ro
 
 If, after doing all of the above, mount doesn't work and you see
 errors from the driver (with dmesg) complaining about `status=0xff',
@@ -274,8 +217,6 @@
 				older/odd IDE drives.
  "hdx=slow"		: insert a huge pause after each access to the data
 				port. Should be used only as a last resort.
- "hdx=swapdata"		: when the drive is a disk, byte swap all data
-
  "hdxlun=xx"		: set the drive last logical unit
 
  "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
@@ -307,8 +248,9 @@
  "idex=reset"		: reset interface after probe
  "idex=dma"		: automatically configure/use DMA if possible.
 
- The following are valid ONLY on ide0,
- and the defaults for the base,ctl ports must not be altered.
+The following are valid ONLY on ide0, which usually corresponds to the first
+ATA interface found on the particular host, and the defaults for the base,ctl
+ports must not be altered.
 
  "ide0=dtc2278"		: probe/support DTC2278 interface
  "ide0=ht6560b"		: probe/support HT6560B interface
@@ -329,179 +271,21 @@
 IDE = Integrated Drive Electronics, meaning that each drive has a built-in
 controller, which is why an "IDE interface card" is not a "controller card".
 
-IDE drives are designed to attach almost directly to the ISA bus of an AT-style
-computer.  The typical IDE interface card merely provides I/O port address
-decoding and tri-state buffers, although several newer localbus cards go much
-beyond the basics.  When purchasing a localbus IDE interface, avoid cards with
-an onboard BIOS and those which require special drivers.  Instead, look for a
-card which uses hardware switches/jumpers to select the interface timing speed,
-to allow much faster data transfers than the original 8MHz ISA bus allows.
-
 ATA = AT (the old IBM 286 computer) Attachment Interface, a draft American
 National Standard for connecting hard drives to PCs.  This is the official
 name for "IDE".
 
-The latest standards define some enhancements, known as the ATA-2 spec,
+The latest standards define some enhancements, known as the ATA-6 spec,
 which grew out of vendor-specific "Enhanced IDE" (EIDE) implementations.
 
 ATAPI = ATA Packet Interface, a new protocol for controlling the drives,
 similar to SCSI protocols, created at the same time as the ATA2 standard.
-ATAPI is currently used for controlling CDROM and TAPE devices, and will
-likely also soon be used for Floppy drives, removable R/W cartridges,
-and for high capacity hard disk drives.
-
-How To Use *Big* ATA/IDE drives with Linux
-------------------------------------------
-The ATA Interface spec for IDE disk drives allows a total of 28 bits
-(8 bits for sector, 16 bits for cylinder, and 4 bits for head) for addressing
-individual disk sectors of 512 bytes each (in "Linear Block Address" (LBA)
-mode, there is still only a total of 28 bits available in the hardware).
-This "limits" the capacity of an IDE drive to no more than 128GB (Giga-bytes).
-All current day IDE drives are somewhat smaller than this upper limit, and
-within a few years, ATAPI disk drives will raise the limit considerably.
-
-All IDE disk drives "suffer" from a "16-heads" limitation:  the hardware has
-only a four bit field for head selection, restricting the number of "physical"
-heads to 16 or less.  Since the BIOS usually has a 63 sectors/track limit,
-this means that all IDE drivers larger than 504MB (528Meg) must use a "physical"
-geometry with more than 1024 cylinders.
-
-   (1024cyls * 16heads * 63sects * 512bytes/sector) / (1024 * 1024) == 504MB
-
-(Some BIOSs (and controllers with onboard BIOS) pretend to allow "32" or "64"
- heads per drive (discussed below), but can only do so by playing games with
- the real (hidden) geometry, which is always limited to 16 or fewer heads).
-
-This presents two problems to most systems:
-
-	1. The INT13 interface to the BIOS only allows 10-bits for cylinder
-	addresses, giving a limit of 1024cyls for programs which use it.
-
-	2. The physical geometry fields of the disk partition table only
-	allow 10-bits for cylinder addresses, giving a similar limit of 1024
-	cyls for operating systems that do not use the "sector count" fields
-	instead of the physical Cyl/Head/Sect (CHS) geometry fields.
-
-Neither of these limitations affects Linux itself, as it (1) does not use the
-BIOS for disk access, and it (2) is clever enough to use the "sector count"
-fields of the partition table instead of the physical CHS geometry fields.
-
-	a) Most folks use LILO to load linux.  LILO uses the INT13 interface
-	to the BIOS to load the kernel at boot time.  Therefore, LILO can only
-	load linux if the files it needs (usually just the kernel images) are
-	located below the magic 1024 cylinder "boundary" (more on this later).
-
-	b) Many folks also like to have bootable DOS partitions on their
-	drive(s).  DOS also uses the INT13 interface to the BIOS, not only
-	for booting, but also for operation after booting.  Therefore, DOS
-	can normally only access partitions which are contained entirely below
-	the magic 1024 cylinder "boundary".
-
-There are at least seven commonly used schemes for kludging DOS to work
-around this "limitation".  In the long term, the problem is being solved
-by introduction of an alternative BIOS interface that does not have the
-same limitations as the INT13 interface.  New versions of DOS are expected
-to detect and use this interface in systems whose BIOS provides it.
-
-But in the present day, alternative solutions are necessary.
-
-The most popular solution in newer systems is to have the BIOS shift bits
-between the cylinder and head number fields.  This is activated by entering
-a translated logical geometry into the BIOS/CMOS setup for the drive.
-Thus, if the drive has a geometry of 2100/16/63 (CHS), then the BIOS could
-present a "logical" geometry of 525/64/63 by "shifting" two bits from the
-cylinder number into the head number field for purposes of the partition table,
-CMOS setup, and INT13 interfaces.  Linux kernels 1.1.39 and higher detect and
-"handle" this translation automatically, making this a rather painless solution
-for the 1024 cyls problem.  If for some reason Linux gets confused (unlikely),
-then use the kernel command line parameters to pass the *logical* geometry,
-as in:  hda=525,64,63
-
-If the BIOS does not support this form of drive translation, then several
-options remain, listed below in order of popularity:
-
-	- use a partition below the 1024 cyl boundary to hold the linux
-	boot files (kernel images and /boot directory), and place the rest
-	of linux anywhere else on the drive.  These files can reside in a DOS
-	partition, or in a tailor-made linux boot partition.
-	- use DiskManager software from OnTrack, supplied free with
-	many new hard drive purchases.
-	- use EZ-Drive software (similar to DiskManager).  Note though,
-	that LILO must *not* use the MBR when EZ-Drive is present.
-	Instead, install LILO on the first sector of your linux partition,
-	and mark it as "active" or "bootable" with fdisk.
-	- boot from a floppy disk instead of the hard drive (takes 10 seconds).
-
-If you cannot use drive translation, *and* your BIOS also restricts you to
-entering no more than 1024 cylinders in the geometry field in the CMOS setup,
-then just set it to 1024.  As of v3.5 of this driver, Linux automatically
-determines the *real* number of cylinders for fdisk to use, allowing easy
-access to the full disk capacity without having to fiddle around.
-
-Regardless of what you do, all DOS partitions *must* be contained entirely
-within the first 1024 logical cylinders.  For a 1Gig WD disk drive, here's
-a good "half and half" partitioning scheme to start with:
-
-	geometry = 2100/16/63
-	/dev/hda1 from cyl    1 to  992		dos
-	/dev/hda2 from cyl  993 to 1023		swap
-	/dev/hda3 from cyl 1024 to 2100		linux
-
-To ensure that LILO can boot linux, the boot files (kernel and /boot/*)
-must reside within the first 1024 cylinders of the drive.  If your linux
-root partition is *not* completely within the first 1024 cyls (quite common),
-then you can use LILO to boot linux from files on your DOS partition
-by doing the following after installing Slackware (or whatever):
-
-	0. Boot from the "boot floppy" created during the installation
-        1. Mount your DOS partition as /dos (and stick it in /etc/fstab)
-        2. Move /boot to /dos/boot with:  cp -a /boot /dos ; rm -r /boot
-        3. Create a symlink for LILO to use with:  ln -s /dos/boot /boot
-        4. Move your kernel (/vmlinuz) to /boot/vmlinuz:  mv /vmlinuz /boot
-        5. Edit /etc/lilo.conf to change /vmlinuz to /boot/vmlinuz
-        6. Re-run LILO with:  lilo
-
-	A danger with this approach is that whenever an MS-DOS "defragmentation"
-	program is run (like Norton "speeddisk"), it may move the Linux boot
-	files around, confusing LILO and making the (Linux) system unbootable.
-	Be sure to keep a kernel "boot floppy" at hand for such circumstances.
-	A possible workaround is to mark the Linux files as S+H+R (System,
-	Hidden, Readonly), to prevent most defragmentation programs from
-	moving the files around.
-
-If you "don't do DOS", then partition as you please, but remember to create
-a small partition to hold the /boot directory (and vmlinuz) as described above
-such that they stay within the first 1024 cylinders.
-
-Note that when creating partitions that span beyond cylinder 1024,
-Linux fdisk will complain about "Partition X has different physical/logical
-endings" and emit messages such as "This is larger than 1024, and may cause
-problems with some software".   Ignore this for linux partitions.  The "some
-software" refers to DOS, the BIOS, and LILO, as described previously.
-
-Western Digital ships a "DiskManager 6.03" diskette with all of their big
-hard drives.  Use BIOS translation instead of this if possible, as it is a
-more generally compatible method of achieving the same results (DOS access
-to the entire disk).  However, if you must use DiskManager, it now works
-with Linux 1.3.x in most cases.  Let me know if you still have trouble.
-
-My recommendations to anyone who asks about NEW systems are:
-
-        - buy a motherboard that uses the Intel Triton chipset -- very common.
-        - use IDE for the first two drives, placing them on separate interfaces.
-		- very fast 7200rpm drives are now available
-		(though many problems have been reported with Seagate ones).
-	- place the IDE cdrom drive as slave on either interface.
-        - if additional disks are to be connected, consider your needs:
-                - fileserver?  Buy a SC200 SCSI adaptor for the next few drives.
-                - personal system?  Use IDE for the next two drives.
-                - still not enough?  Keep adding SC200 SCSI cards as needed.
-
-Most manufacturers make both IDE and SCSI versions of each of their drives.
-The IDE ones are usually as fast and cheaper, due to lower command overhead
-and the higher data transfer speed of UDMA2.  But fast/ultrawide/superlative
-SCSI is still king of the heap, especially for servers, if you've got the bucks.
+ATAPI is currently used for controlling CDROM, TAPE and FLOPPY (ZIP or
+LS120/240) devices, removable R/W cartridges, and for high capacity hard disk
+drives.
 
 mlord@pobox.com
 --
-For current maintainers of this stuff, see the linux/MAINTAINERS file.
+Wed Apr 17 22:52:44 CEST 2002 edited by Marcin Dalecki
+
+For current maintainers of this stuff, please see the linux/MAINTAINERS file.
diff -urN linux-2.5.8/arch/cris/drivers/ide.c linux/arch/cris/drivers/ide.c
--- linux-2.5.8/arch/cris/drivers/ide.c	Wed Apr 17 23:09:16 2002
+++ linux/arch/cris/drivers/ide.c	Wed Apr 17 13:18:32 2002
@@ -280,7 +280,7 @@
 		hwif->tuneproc = &tune_e100_ide;
 		hwif->dmaproc = &e100_dmaproc;
 		hwif->ata_read = e100_ide_input_data;
-		hwif->ata_write = e100_ide_input_data;
+		hwif->ata_write = e100_ide_output_data;
 		hwif->atapi_read = e100_atapi_read;
 		hwif->atapi_write = e100_atapi_write;
 	}
@@ -560,32 +560,6 @@
 	e100_atapi_write(drive, buffer, wcount << 2);
 }
 
-/*
- * The multiplexor for ide_xxxput_data and atapi calls
- */
-static void 
-e100_ideproc (ide_ide_action_t func, ide_drive_t *drive,
-	      void *buffer, unsigned int length)
-{
-	switch (func) {
-		case ideproc_ide_input_data:
-			e100_ide_input_data(drive, buffer, length);
-			break;
-		case ideproc_ide_output_data:
-			e100_ide_input_data(drive, buffer, length);
-			break;
-		case ideproc_atapi_read:
-			e100_atapi_read(drive, buffer, length);
-			break;
-		case ideproc_atapi_write:
-			e100_atapi_write(drive, buffer, length);
-			break;
-		default:
-			printk("e100_ideproc: unsupported func %d!\n", func);
-			break;
-	}
-}
-
 /* we only have one DMA channel on the chip for ATA, so we can keep these statically */
 static etrax_dma_descr ata_descrs[MAX_DMA_DESCRS];
 static unsigned int ata_tot_size;
diff -urN linux-2.5.8/drivers/ide/amd74xx.c linux/drivers/ide/amd74xx.c
--- linux-2.5.8/drivers/ide/amd74xx.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/amd74xx.c	Wed Apr 17 18:41:36 2002
@@ -422,9 +422,10 @@
 	hwif->speedproc = &amd_set_drive;
 	hwif->autodma = 0;
 
+	hwif->io_32bit = 1;
+	hwif->unmask = 1;
+
 	for (i = 0; i < 2; i++) {
-		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = 1;
 		hwif->drives[i].autotune = 1;
 		hwif->drives[i].dn = hwif->unit * 2 + i;
 	}
diff -urN linux-2.5.8/drivers/ide/cmd640.c linux/drivers/ide/cmd640.c
--- linux-2.5.8/drivers/ide/cmd640.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/cmd640.c	Wed Apr 17 23:05:54 2002
@@ -21,7 +21,7 @@
  *
  *  A.Hartgers@stud.tue.nl, JZDQC@CUNYVM.CUNY.edu, abramov@cecmow.enet.dec.com,
  *  bardj@utopia.ppp.sn.no, bart@gaga.tue.nl, bbol001@cs.auckland.ac.nz,
- *  chrisc@dbass.demon.co.uk, dalecki@evision-ventures.com,
+ *  chrisc@dbass.demon.co.uk, martin@dalecki.de,
  *  derekn@vw.ece.cmu.edu, florian@btp2x3.phy.uni-bayreuth.de,
  *  flynn@dei.unipd.it, gadio@netvision.net.il, godzilla@futuris.net,
  *  j@pobox.com, jkemp1@mises.uni-paderborn.de, jtoppe@hiwaay.net,
@@ -403,19 +403,19 @@
  */
 static void __init check_prefetch (unsigned int index)
 {
-	ide_drive_t *drive = cmd_drives[index];
+	struct ata_device *drive = cmd_drives[index];
 	byte b = get_cmd640_reg(prefetch_regs[index]);
 
 	if (b & prefetch_masks[index]) {	/* is prefetch off? */
-		drive->no_unmask = 0;
-		drive->no_io_32bit = 1;
-		drive->io_32bit = 0;
+		drive->channel->no_unmask = 0;
+		drive->channel->no_io_32bit = 1;
+		drive->channel->io_32bit = 0;
 	} else {
 #if CMD640_PREFETCH_MASKS
-		drive->no_unmask = 1;
-		drive->unmask = 0;
+		drive->channel->no_unmask = 1;
+		drive->channel->unmask = 0;
 #endif
-		drive->no_io_32bit = 0;
+		drive->channel->no_io_32bit = 0;
 	}
 }
 
@@ -460,15 +460,15 @@
 	b = get_cmd640_reg(reg);
 	if (mode) {	/* want prefetch on? */
 #if CMD640_PREFETCH_MASKS
-		drive->no_unmask = 1;
-		drive->unmask = 0;
+		drive->channel->no_unmask = 1;
+		drive->channel->unmask = 0;
 #endif
-		drive->no_io_32bit = 0;
+		drive->channel->no_io_32bit = 0;
 		b &= ~prefetch_masks[index];	/* enable prefetch */
 	} else {
-		drive->no_unmask = 0;
-		drive->no_io_32bit = 1;
-		drive->io_32bit = 0;
+		drive->channel->no_unmask = 0;
+		drive->channel->no_io_32bit = 1;
+		drive->channel->io_32bit = 0;
 		b |= prefetch_masks[index];	/* disable prefetch */
 	}
 	put_cmd640_reg(reg, b);
@@ -827,7 +827,7 @@
 			retrieve_drive_counts (index);
 			check_prefetch (index);
 			printk("cmd640: drive%d timings/prefetch(%s) preserved",
-				index, drive->no_io_32bit ? "off" : "on");
+				index, drive->channel->no_io_32bit ? "off" : "on");
 			display_clocks(index);
 		}
 #else
@@ -836,7 +836,7 @@
 		 */
 		check_prefetch (index);
 		printk("cmd640: drive%d timings/prefetch(%s) preserved\n",
-			index, drive->no_io_32bit ? "off" : "on");
+			index, drive->channel->no_io_32bit ? "off" : "on");
 #endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
 	}
 
diff -urN linux-2.5.8/drivers/ide/dtc2278.c linux/drivers/ide/dtc2278.c
--- linux-2.5.8/drivers/ide/dtc2278.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/dtc2278.c	Wed Apr 17 18:45:21 2002
@@ -88,8 +88,7 @@
 	/*
 	 * 32bit I/O has to be enabled for *both* drives at the same time.
 	 */
-	drive->io_32bit = 1;
-	drive->channel->drives[!drive->select.b.unit].io_32bit = 1;
+	drive->channel->io_32bit = 1;
 }
 
 void __init init_dtc2278 (void)
@@ -120,10 +119,11 @@
 	ide_hwifs[0].chipset = ide_dtc2278;
 	ide_hwifs[1].chipset = ide_dtc2278;
 	ide_hwifs[0].tuneproc = &tune_dtc2278;
-	ide_hwifs[0].drives[0].no_unmask = 1;
-	ide_hwifs[0].drives[1].no_unmask = 1;
-	ide_hwifs[1].drives[0].no_unmask = 1;
-	ide_hwifs[1].drives[1].no_unmask = 1;
+	/* FIXME: What about the following?!
+	ide_hwifs[1].tuneproc = &tune_dtc2278;
+	 */
+	ide_hwifs[0].no_unmask = 1;
+	ide_hwifs[1].no_unmask = 1;
 	ide_hwifs[0].unit = ATA_PRIMARY;
 	ide_hwifs[1].unit = ATA_SECONDARY;
 }
diff -urN linux-2.5.8/drivers/ide/ht6560b.c linux/drivers/ide/ht6560b.c
--- linux-2.5.8/drivers/ide/ht6560b.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/ht6560b.c	Wed Apr 17 18:46:13 2002
@@ -261,11 +261,11 @@
 	 */
 	if (state) {
 		drive->drive_data |= t;   /* enable prefetch mode */
-		drive->no_unmask = 1;
-		drive->unmask = 0;
+		drive->channel->no_unmask = 1;
+		drive->channel->unmask = 0;
 	} else {
 		drive->drive_data &= ~t;  /* disable prefetch mode */
-		drive->no_unmask = 0;
+		drive->channel->no_unmask = 0;
 	}
 	
 	restore_flags (flags);	/* all CPUs */
diff -urN linux-2.5.8/drivers/ide/ide-cd.c linux/drivers/ide/ide-cd.c
--- linux-2.5.8/drivers/ide/ide-cd.c	Wed Apr 17 23:09:19 2002
+++ linux/drivers/ide/ide-cd.c	Wed Apr 17 16:58:38 2002
@@ -669,6 +669,12 @@
 			   request or data protect error.*/
 			ide_dump_status (drive, "command error", stat);
 			cdrom_end_request(drive, 0);
+		} else if (sense_key == MEDIUM_ERROR) {
+			/* No point in re-trying a zillion times on a bad
+			 * sector.  The error is not correctable at all.
+			 */
+			ide_dump_status (drive, "media error (bad sector)", stat);
+			cdrom_end_request(drive, 0);
 		} else if ((err & ~ABRT_ERR) != 0) {
 			/* Go to the default handler
 			   for other errors. */
diff -urN linux-2.5.8/drivers/ide/ide-disk.c linux/drivers/ide/ide-disk.c
--- linux-2.5.8/drivers/ide/ide-disk.c	Wed Apr 17 23:09:16 2002
+++ linux/drivers/ide/ide-disk.c	Wed Apr 17 21:40:09 2002
@@ -755,8 +755,6 @@
 	drive->special.b.recalibrate  = legacy;
 	if (OK_TO_RESET_CONTROLLER)
 		drive->mult_count = 0;
-	if (!drive->keep_settings && !drive->using_dma)
-		drive->mult_req = 0;
 	if (drive->mult_req != drive->mult_count)
 		drive->special.b.set_multmode = 1;
 }
@@ -1231,7 +1229,14 @@
 			drive->special.b.set_multmode = 1;
 #endif
 	}
-	drive->no_io_32bit = id->dword_io ? 1 : 0;
+
+	/* FIXME: Nowadays there are many chipsets out there which *require* 32
+	 * bit IO. Those will most propably not work properly with drives not
+	 * supporting this. But right now we don't do anything about this. We
+	 * dont' even *warn* the user!
+	 */
+
+	drive->channel->no_io_32bit = id->dword_io ? 1 : 0;
 
 	if (drive->id->cfs_enable_2 & 0x3000)
 		write_cache(drive, (id->cfs_enable_2 & 0x3000));
diff -urN linux-2.5.8/drivers/ide/ide-taskfile.c linux/drivers/ide/ide-taskfile.c
--- linux-2.5.8/drivers/ide/ide-taskfile.c	Wed Apr 17 23:09:19 2002
+++ linux/drivers/ide/ide-taskfile.c	Wed Apr 17 17:55:52 2002
@@ -156,7 +156,7 @@
 		return;
 	}
 
-	io_32bit = drive->io_32bit;
+	io_32bit = drive->channel->io_32bit;
 
 	if (io_32bit) {
 #if SUPPORT_VLB_SYNC
@@ -167,7 +167,7 @@
 			ata_read_32(drive, buffer, wcount);
 	} else {
 #if SUPPORT_SLOW_DATA_PORTS
-		if (drive->slow)
+		if (drive->channel->slow)
 			ata_read_slow(drive, buffer, wcount);
 		else
 #endif
@@ -187,7 +187,7 @@
 		return;
 	}
 
-	io_32bit = drive->io_32bit;
+	io_32bit = drive->channel->io_32bit;
 
 	if (io_32bit) {
 #if SUPPORT_VLB_SYNC
@@ -198,7 +198,7 @@
 			ata_write_32(drive, buffer, wcount);
 	} else {
 #if SUPPORT_SLOW_DATA_PORTS
-		if (drive->slow)
+		if (drive->channel->slow)
 			ata_write_slow(drive, buffer, wcount);
 		else
 #endif
@@ -976,6 +976,7 @@
 		if (argbuf == NULL)
 			return -ENOMEM;
 		memcpy(argbuf, vals, 4);
+		memset(argbuf + 4, 0, argsize - 4);
 	}
 
 	if (set_transfer(drive, &args)) {
@@ -986,14 +987,8 @@
 
 	/* Issue ATA command and wait for completion.
 	 */
-
-	/* FIXME: Do we really have to zero out the buffer?
-	 */
-	memset(argbuf, 4, SECTOR_WORDS * 4 * vals[3]);
 	ide_init_drive_cmd(&rq);
 	rq.buffer = argbuf;
-	memcpy(argbuf, vals, 4);
-
 	err = ide_do_drive_cmd(drive, &rq, ide_wait);
 
 	if (!err && xfer_rate) {
diff -urN linux-2.5.8/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.8/drivers/ide/ide.c	Wed Apr 17 23:09:19 2002
+++ linux/drivers/ide/ide.c	Wed Apr 17 21:47:51 2002
@@ -479,22 +479,18 @@
 	if (ata_ops(drive) && ata_ops(drive)->pre_reset)
 		ata_ops(drive)->pre_reset(drive);
 
-	if (!drive->keep_settings && !drive->using_dma) {
-		drive->unmask = 0;
-		drive->io_32bit = 0;
-	}
+	if (!drive->using_dma)
+	    return;
 
-	if (drive->using_dma) {
-		/* check the DMA crc count */
-		if (drive->crc_count) {
-			drive->channel->dmaproc(ide_dma_off_quietly, drive);
-			if ((drive->channel->speedproc) != NULL)
-				drive->channel->speedproc(drive, ide_auto_reduce_xfer(drive));
-			if (drive->current_speed >= XFER_SW_DMA_0)
-				drive->channel->dmaproc(ide_dma_on, drive);
-		} else
-			drive->channel->dmaproc(ide_dma_off, drive);
-	}
+	/* check the DMA crc count */
+	if (drive->crc_count) {
+		drive->channel->dmaproc(ide_dma_off_quietly, drive);
+		if ((drive->channel->speedproc) != NULL)
+		        drive->channel->speedproc(drive, ide_auto_reduce_xfer(drive));
+		if (drive->current_speed >= XFER_SW_DMA_0)
+			drive->channel->dmaproc(ide_dma_on, drive);
+	} else
+		drive->channel->dmaproc(ide_dma_off, drive);
 }
 
 /*
@@ -905,17 +901,15 @@
  */
 static void try_to_flush_leftover_data (ide_drive_t *drive)
 {
-	int i = (drive->mult_count ? drive->mult_count : 1);
+	int i;
 
 	if (drive->type != ATA_DISK)
 		return;
 
-	while (i > 0) {
+	for (i = (drive->mult_count ? drive->mult_count : 1); i > 0; --i) {
 		u32 buffer[SECTOR_WORDS];
-		unsigned int count = (i > 1) ? 1 : i;
 
-		ata_read(drive, buffer, count * SECTOR_WORDS);
-		i -= count;
+		ata_read(drive, buffer, SECTOR_WORDS);
 	}
 }
 
@@ -999,7 +993,7 @@
 /*
  * Invoked on completion of a special DRIVE_CMD.
  */
-static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
+static ide_startstop_t drive_cmd_intr(ide_drive_t *drive)
 {
 	struct request *rq = HWGROUP(drive)->rq;
 	u8 *args = rq->buffer;
@@ -1008,11 +1002,7 @@
 
 	ide__sti();	/* local CPU only */
 	if ((stat & DRQ_STAT) && args && args[3]) {
-		int io_32bit = drive->io_32bit;
-
-		drive->io_32bit = 0;
 		ata_read(drive, &args[4], args[3] * SECTOR_WORDS);
-		drive->io_32bit = io_32bit;
 
 		while (((stat = GET_STAT()) & BUSY_STAT) && retries--)
 			udelay(100);
@@ -1824,7 +1814,7 @@
 	del_timer(&hwgroup->timer);
 	spin_unlock(&ide_lock);
 
-	if (drive->unmask)
+	if (hwif->unmask)
 		ide__sti();	/* local CPU only */
 	startstop = handler(drive);		/* service this interrupt, may set handler for next interrupt */
 	spin_lock_irq(&ide_lock);
@@ -2572,14 +2562,10 @@
 
 static int set_io_32bit(struct ata_device *drive, int arg)
 {
-	if (drive->no_io_32bit)
+	if (drive->channel->no_io_32bit)
 		return -EIO;
 
-	drive->io_32bit = arg;
-#ifdef CONFIG_BLK_DEV_DTC2278
-	if (drive->channel->chipset == ide_dtc2278)
-		drive->channel->drives[!drive->select.b.unit].io_32bit = arg;
-#endif
+	drive->channel->io_32bit = arg;
 
 	return 0;
 }
@@ -2613,11 +2599,10 @@
 void ide_add_generic_settings (ide_drive_t *drive)
 {
 /*			drive	setting name		read/write access				read ioctl		write ioctl		data type	min	max				mul_factor	div_factor	data pointer			set function */
-	ide_add_setting(drive,	"io_32bit",		drive->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->io_32bit,		set_io_32bit);
-	ide_add_setting(drive,	"keepsettings",		SETTING_RW,					HDIO_GET_KEEPSETTINGS,	HDIO_SET_KEEPSETTINGS,	TYPE_BYTE,	0,	1,				1,		1,		&drive->keep_settings,		NULL);
+	ide_add_setting(drive,	"io_32bit",		drive->channel->no_io_32bit ? SETTING_READ : SETTING_RW,	HDIO_GET_32BIT,		HDIO_SET_32BIT,		TYPE_BYTE,	0,	1 + (SUPPORT_VLB_SYNC << 1),	1,		1,		&drive->channel->io_32bit,		set_io_32bit);
 	ide_add_setting(drive,	"pio_mode",		SETTING_WRITE,					-1,			HDIO_SET_PIO_MODE,	TYPE_BYTE,	0,	255,				1,		1,		NULL,				set_pio_mode);
-	ide_add_setting(drive,	"slow",			SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->slow,			NULL);
-	ide_add_setting(drive,	"unmaskirq",		drive->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->unmask,			NULL);
+	ide_add_setting(drive,	"slow",			SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->channel->slow,			NULL);
+	ide_add_setting(drive,	"unmaskirq",		drive->channel->no_unmask ? SETTING_READ : SETTING_RW,	HDIO_GET_UNMASKINTR,	HDIO_SET_UNMASKINTR,	TYPE_BYTE,	0,	1,				1,		1,		&drive->channel->unmask,			NULL);
 	ide_add_setting(drive,	"using_dma",		SETTING_RW,					HDIO_GET_DMA,		HDIO_SET_DMA,		TYPE_BYTE,	0,	1,				1,		1,		&drive->using_dma,		set_using_dma);
 	ide_add_setting(drive,	"ide_scsi",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			NULL);
 	ide_add_setting(drive,	"init_speed",		SETTING_RW,					-1,			-1,			TYPE_BYTE,	0,	69,				1,		1,		&drive->init_speed,		NULL);
@@ -3182,7 +3167,7 @@
 				drive->autotune = 2;
 				goto done;
 			case -8: /* "slow" */
-				drive->slow = 1;
+				hwif->slow = 1;
 				goto done;
 			case -9: /* "flash" */
 				drive->ata_flash = 1;
diff -urN linux-2.5.8/drivers/ide/pdc202xx.c linux/drivers/ide/pdc202xx.c
--- linux-2.5.8/drivers/ide/pdc202xx.c	Wed Apr 17 23:09:16 2002
+++ linux/drivers/ide/pdc202xx.c	Wed Apr 17 19:02:12 2002
@@ -1268,11 +1268,8 @@
 
 #undef CONFIG_PDC202XX_32_UNMASK
 #ifdef CONFIG_PDC202XX_32_UNMASK
-	hwif->drives[0].io_32bit = 1;
-	hwif->drives[1].io_32bit = 1;
-
-	hwif->drives[0].unmask = 1;
-	hwif->drives[1].unmask = 1;
+	hwif->io_32bit = 1;
+	hwif->unmask = 1;
 #endif
 
 #ifdef CONFIG_BLK_DEV_IDEDMA
diff -urN linux-2.5.8/drivers/ide/pdc4030.c linux/drivers/ide/pdc4030.c
--- linux-2.5.8/drivers/ide/pdc4030.c	Wed Apr 17 23:09:19 2002
+++ linux/drivers/ide/pdc4030.c	Wed Apr 17 21:42:09 2002
@@ -250,11 +250,9 @@
 	memcpy(hwif2->io_ports, hwif->hw.io_ports, sizeof(hwif2->io_ports));
 	hwif2->irq = hwif->irq;
 	hwif2->hw.irq = hwif->hw.irq = hwif->irq;
+	hwif->io_32bit = 3;
+	hwif2->io_32bit = 3;
 	for (i=0; i<2 ; i++) {
-		hwif->drives[i].io_32bit = 3;
-		hwif2->drives[i].io_32bit = 3;
-		hwif->drives[i].keep_settings = 1;
-		hwif2->drives[i].keep_settings = 1;
 		if (!ident.current_tm[i].cyl)
 			hwif->drives[i].noprobe = 1;
 		if (!ident.current_tm[i+2].cyl)
@@ -634,7 +632,7 @@
 			       "PROMISE_WRITE\n", drive->name);
 			return startstop;
 		}
-		if (!drive->unmask)
+		if (!drive->channel->unmask)
 			__cli();	/* local CPU only */
 		HWGROUP(drive)->wrq = *rq; /* scratchpad */
 		return promise_write(drive);
diff -urN linux-2.5.8/drivers/ide/piix.c linux/drivers/ide/piix.c
--- linux-2.5.8/drivers/ide/piix.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/piix.c	Wed Apr 17 18:54:19 2002
@@ -545,10 +545,9 @@
 	hwif->tuneproc = &piix_tune_drive;
 	hwif->speedproc = &piix_set_drive;
 	hwif->autodma = 0;
-
+	hwif->io_32bit = 1;
+	hwif->unmask = 1;
 	for (i = 0; i < 2; i++) {
-		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = 1;
 		hwif->drives[i].autotune = 1;
 		hwif->drives[i].dn = hwif->unit * 2 + i;
 	}
diff -urN linux-2.5.8/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.8/drivers/ide/qd65xx.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/qd65xx.c	Wed Apr 17 18:25:46 2002
@@ -370,8 +370,7 @@
 		hwif->config_data = config;
 		hwif->drives[0].drive_data =
 		hwif->drives[1].drive_data = QD6500_DEF_DATA;
-		hwif->drives[0].io_32bit =
-		hwif->drives[1].io_32bit = 1;
+		hwif->io_32bit = 1;
 		hwif->tuneproc = &qd6500_tune_drive;
 		return 1;
 	}
@@ -403,8 +402,7 @@
 			hwif->config_data = config | (control <<8);
 			hwif->drives[0].drive_data =
 			hwif->drives[1].drive_data = QD6580_DEF_DATA;
-			hwif->drives[0].io_32bit =
-			hwif->drives[1].io_32bit = 1;
+			hwif->io_32bit = 1;
 			hwif->tuneproc = &qd6580_tune_drive;
 
 			qd_write_reg(QD_DEF_CONTR,QD_CONTROL_PORT);
@@ -426,11 +424,11 @@
 				ide_hwifs[i].select_data = base;
 				ide_hwifs[i].config_data = config | (control <<8);
 				ide_hwifs[i].tuneproc = &qd6580_tune_drive;
+				ide_hwifs[i].io_32bit = 1;
 
 				for (j = 0; j < 2; j++) {
 					ide_hwifs[i].drives[j].drive_data =
 					       i?QD6580_DEF_DATA2:QD6580_DEF_DATA;
-					ide_hwifs[i].drives[j].io_32bit = 1;
 				}
 			}
 
diff -urN linux-2.5.8/drivers/ide/rz1000.c linux/drivers/ide/rz1000.c
--- linux-2.5.8/drivers/ide/rz1000.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/rz1000.c	Wed Apr 17 18:55:00 2002
@@ -40,8 +40,7 @@
 		printk("%s: disabled chipset read-ahead (buggy RZ1000/RZ1001)\n", hwif->name);
 	} else {
 		hwif->serialized = 1;
-		hwif->drives[0].no_unmask = 1;
-		hwif->drives[1].no_unmask = 1;
+		hwif->no_unmask = 1;
 		printk("%s: serialized, disabled unmasking (buggy RZ1000/RZ1001)\n", hwif->name);
 	}
 }
diff -urN linux-2.5.8/drivers/ide/via82cxxx.c linux/drivers/ide/via82cxxx.c
--- linux-2.5.8/drivers/ide/via82cxxx.c	Mon Apr 15 08:53:44 2002
+++ linux/drivers/ide/via82cxxx.c	Wed Apr 17 18:55:57 2002
@@ -535,10 +535,10 @@
 	hwif->tuneproc = &via82cxxx_tune_drive;
 	hwif->speedproc = &via_set_drive;
 	hwif->autodma = 0;
+	hwif->io_32bit = 1;
 
+	hwif->unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
 	for (i = 0; i < 2; i++) {
-		hwif->drives[i].io_32bit = 1;
-		hwif->drives[i].unmask = (via_config->flags & VIA_NO_UNMASK) ? 0 : 1;
 		hwif->drives[i].autotune = 1;
 		hwif->drives[i].dn = hwif->unit * 2 + i;
 	}
diff -urN linux-2.5.8/include/linux/hdreg.h linux/include/linux/hdreg.h
--- linux-2.5.8/include/linux/hdreg.h	Mon Apr 15 08:53:56 2002
+++ linux/include/linux/hdreg.h	Wed Apr 17 21:40:40 2002
@@ -296,7 +296,6 @@
 #define HDIO_GET_MULTCOUNT	0x0304	/* get current IDE blockmode setting */
 #define HDIO_GET_QDMA		0x0305	/* get use-qdma flag */
 #define HDIO_OBSOLETE_IDENTITY	0x0307	/* OBSOLETE, DO NOT USE: returns 142 bytes */
-#define HDIO_GET_KEEPSETTINGS	0x0308	/* get keep-settings-on-reset flag */
 #define HDIO_GET_32BIT		0x0309	/* get current io_32bit setting */
 #define HDIO_GET_NOWERR		0x030a	/* get ignore-write-error flag */
 #define HDIO_GET_DMA		0x030b	/* get use-dma flag */
@@ -316,7 +315,6 @@
 /* hd/ide ctl's that pass (arg) non-ptr values are numbered 0x032n/0x033n */
 #define HDIO_SET_MULTCOUNT	0x0321	/* change IDE blockmode */
 #define HDIO_SET_UNMASKINTR	0x0322	/* permit other irqs during I/O */
-#define HDIO_SET_KEEPSETTINGS	0x0323	/* keep ioctl settings on reset */
 #define HDIO_SET_32BIT		0x0324	/* change io_32bit flags */
 #define HDIO_SET_NOWERR		0x0325	/* change ignore-write-error flag */
 #define HDIO_SET_DMA		0x0326	/* change use-dma flag */
diff -urN linux-2.5.8/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.8/include/linux/ide.h	Wed Apr 17 23:09:19 2002
+++ linux/include/linux/ide.h	Wed Apr 17 21:42:48 2002
@@ -342,12 +342,10 @@
 	unsigned long PADAM_timeout;		/* max time to wait for irq */
 
 	special_t	special;	/* special action flags */
-	byte     keep_settings;		/* restore settings after drive reset */
 	byte     using_dma;		/* disk is using dma for read/write */
 	byte	 using_tcq;		/* disk is using queued dma operations*/
 	byte	 retry_pio;		/* retrying dma capable host in pio */
 	byte	 state;			/* retry state */
-	byte     unmask;		/* flag: okay to unmask other irqs */
 	byte     dsc_overlap;		/* flag: DSC overlap */
 
 	unsigned waiting_for_dma: 1;	/* dma currently in progress */
@@ -358,7 +356,6 @@
 	unsigned noprobe	: 1;	/* from:  hdx=noprobe */
 	unsigned removable	: 1;	/* 1 if need to do check_media_change */
 	unsigned forced_geom	: 1;	/* 1 if hdx=c,h,s was given at boot */
-	unsigned no_unmask	: 1;	/* disallow setting unmask bit */
 	unsigned nobios		: 1;	/* flag: do not probe bios for drive */
 	unsigned revalidate	: 1;	/* request revalidation */
 	unsigned atapi_overlap	: 1;	/* flag: ATAPI overlap (not supported) */
@@ -388,13 +385,6 @@
 	unsigned long long capacity48;	/* total number of sectors */
 	unsigned int	drive_data;	/* for use by tuneproc/selectproc as needed */
 
-	/* FIXME: Those are properties of a channel and not a drive!  Move them
-	 * later there.
-	 */
-	byte		slow;		/* flag: slow data port */
-	unsigned no_io_32bit	: 1;	/* disallow enabling 32bit I/O */
-	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
-
 	wait_queue_head_t wqueue;	/* used to wait for drive in open() */
 
 	struct hd_driveid *id;		/* drive model identification info */
@@ -523,6 +513,12 @@
 	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
 	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
 	unsigned	highmem	   : 1; /* can do full 32-bit dma */
+	byte		slow;		/* flag: slow data port */
+	unsigned no_io_32bit	   : 1;	/* disallow enabling 32bit I/O */
+	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
+	unsigned no_unmask	   : 1;	/* disallow setting unmask bit */
+	byte		unmask;		/* flag: okay to unmask other irqs */
+
 #if (DISK_RECOVERY_TIME > 0)
 	unsigned long	last_time;	/* time when previous rq was done */
 #endif

--------------040705060106010604020701--

