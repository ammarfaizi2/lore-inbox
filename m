Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319020AbSHFIwG>; Tue, 6 Aug 2002 04:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319021AbSHFIwG>; Tue, 6 Aug 2002 04:52:06 -0400
Received: from [195.63.194.11] ([195.63.194.11]:61956 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319020AbSHFIwC>; Tue, 6 Aug 2002 04:52:02 -0400
Message-ID: <3D4F8DE2.8020904@evision.ag>
Date: Tue, 06 Aug 2002 10:50:42 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.30 IDE 112
Content-Type: multipart/mixed;
 boundary="------------040203060204040305080301"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040203060204040305080301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Just removaing dead obscure xlate_1024 code.

--------------040203060204040305080301
Content-Type: text/plain;
 name="ide-112.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="ide-112.diff"

diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/drivers/ide/cs5530.c linux/drivers/ide/cs5530.c
--- linux-2.5.30/drivers/ide/cs5530.c	2002-08-03 15:03:26.000000000 +0200
+++ linux/drivers/ide/cs5530.c	2002-08-02 02:24:32.000000000 +0200
@@ -204,8 +204,6 @@ static unsigned int __init pci_init_cs55
 {
 	struct pci_dev *master_0 = NULL;
 	struct pci_dev *cs5530_0 = NULL;
-	unsigned short pcicmd = 0;
-	unsigned long flags;
 
 	pci_for_each_dev(dev) {
 		if (dev->vendor == PCI_VENDOR_ID_CYRIX) {
@@ -233,7 +231,7 @@ static unsigned int __init pci_init_cs55
 	 * Enable BusMaster and MemoryWriteAndInvalidate for the cs5530:
 	 * -->  OR 0x14 into 16-bit PCI COMMAND reg of function 0 of the cs5530
 	 */
-	 
+
 	pci_set_master(cs5530_0);
 	pci_set_mwi(cs5530_0);
 
diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/drivers/ide/ide.c linux/drivers/ide/ide.c
--- linux-2.5.30/drivers/ide/ide.c	2002-08-03 15:03:26.000000000 +0200
+++ linux/drivers/ide/ide.c	2002-08-02 10:58:52.000000000 +0200
@@ -251,7 +251,7 @@ static struct ata_bit_messages ata_statu
 
 static struct ata_bit_messages ata_error_msgs[] = {
 	{ ICRC_ERR|ABRT_ERR,	ABRT_ERR,		"drive status error"	},
-	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR,		"bad sectorr"		},
+	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR,		"bad sector"		},
 	{ ICRC_ERR|ABRT_ERR,	ICRC_ERR|ABRT_ERR,	"invalid checksum"	},
 	{ ECC_ERR,		ECC_ERR,		"uncorrectable error"	},
 	{ ID_ERR,		ID_ERR,			"sector id not found"   },
diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/drivers/ide/Makefile linux/drivers/ide/Makefile
--- linux-2.5.30/drivers/ide/Makefile	2002-08-03 15:03:26.000000000 +0200
+++ linux/drivers/ide/Makefile	2002-08-02 02:28:01.000000000 +0200
@@ -1,15 +1,12 @@
 #
-# Makefile for the kernel ata, atapi, and ide block device drivers.
+# Makefile for the kernel ata and atapi block device drivers.
 #
-# 12 September 2000, Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
+# 12 September 2000, Bartłomiej Żołnierkiewicz <bkz@linux-ide.org>
 # Rewritten to use lists instead of if-statements.
 #
-# Note : at this point, these files are compiled on all systems.
-# In the future, some of these should be built conditionally.
-#
 
-export-objs	:= device.o ide-taskfile.o main.o ide.o probe.o quirks.o pcidma.o tcq.o \
-		   atapi.o ataraid.o
+export-objs :=	device.o ide-taskfile.o main.o ide.o probe.o quirks.o \
+		pcidma.o tcq.o atapi.o ataraid.o
 
 obj-$(CONFIG_BLK_DEV_HD)	+= hd.o
 obj-$(CONFIG_BLK_DEV_IDE)       += ide-mod.o
diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/drivers/ide/probe.c linux/drivers/ide/probe.c
--- linux-2.5.30/drivers/ide/probe.c	2002-08-03 15:03:26.000000000 +0200
+++ linux/drivers/ide/probe.c	2002-08-02 02:20:34.000000000 +0200
@@ -41,115 +41,6 @@
 extern struct ata_device * get_info_ptr(kdev_t);
 
 /*
- * This is called from the partition-table code in pt/msdos.c
- * to invent a translated geometry.
- *
- * This is suppressed if the user specifies an explicit geometry.
- *
- * The ptheads parameter is either 0 or tells about the number of
- * heads shown by the end of the first nonempty partition.
- * If this is either 16, 32, 64, 128, 240 or 255 we'll believe it.
- *
- * The xparm parameter has the following meaning:
- *	 0 = convert to CHS with fewer than 1024 cyls
- *	     using the same method as Ontrack DiskManager.
- *	 1 = same as "0", plus offset everything by 63 sectors.
- *	-1 = similar to "0", plus redirect sector 0 to sector 1.
- *	 2 = convert to a CHS geometry with "ptheads" heads.
- *
- * Returns 0 if the translation was not possible, if the device was not
- * an IDE disk drive, or if a geometry was "forced" on the commandline.
- * Returns 1 if the geometry translation was successful.
- */
-int ide_xlate_1024(kdev_t i_rdev, int xparm, int ptheads, const char *msg)
-{
-	struct ata_device *drive;
-	const char *msg1 = "";
-	int heads = 0;
-	int c, h, s;
-	int transl = 1;		/* try translation */
-	int ret = 0;
-
-	drive = get_info_ptr(i_rdev);
-	if (!drive)
-		return 0;
-
-	/* There used to be code here that assigned drive->id->CHS to
-	 * drive->CHS and that to drive->bios_CHS. However, some disks have
-	 * id->C/H/S = 4092/16/63 but are larger than 2.1 GB.  In such cases
-	 * that code was wrong.  Moreover, there seems to be no reason to do
-	 * any of these things.
-	 *
-	 * Please note that recent RedHat changes to the disk utils are bogous
-	 * and will report spurious errors.
-	 */
-
-	/* translate? */
-	if (drive->forced_geom)
-		transl = 0;
-
-	/* does ptheads look reasonable? */
-	if (ptheads == 32 || ptheads == 64 || ptheads == 128 ||
-	    ptheads == 240 || ptheads == 255)
-		heads = ptheads;
-
-	if (xparm == 2) {
-		if (!heads ||
-		   (drive->bios_head >= heads && drive->bios_sect == 63))
-			transl = 0;
-	}
-	if (xparm == -1) {
-		if (drive->bios_head > 16)
-			transl = 0;     /* we already have a translation */
-	}
-
-	if (transl) {
-		static const u8 dm_head_vals[] = {4, 8, 16, 32, 64, 128, 255, 0};
-		const u8 *headp = dm_head_vals;
-		unsigned long total;
-
-		/*
-		 * If heads is nonzero: find a translation with this many heads
-		 * and S=63.  Otherwise: find out how OnTrack Disk Manager
-		 * would translate the disk.
-		 *
-		 * The specs say: take geometry as obtained from Identify,
-		 * compute total capacity C*H*S from that, and truncate to
-		 * 1024*255*63. Now take S=63, H the first in the sequence 4,
-		 * 8, 16, 32, 64, 128, 255 such that 63*H*1024 >= total.
-		 * [Please tell aeb@cwi.nl in case this computes a geometry
-		 * different from what OnTrack uses.]
-		 */
-
-		total = ata_capacity(drive);
-
-		s = 63;
-
-		if (heads) {
-			h = heads;
-			c = total / (63 * heads);
-		} else {
-			while (63 * headp[0] * 1024 < total && headp[1] != 0)
-				headp++;
-			h = headp[0];
-			c = total / (63 * headp[0]);
-		}
-
-		drive->bios_cyl = c;
-		drive->bios_head = h;
-		drive->bios_sect = s;
-		ret = 1;
-	}
-
-	drive->part[0].nr_sects = ata_capacity(drive);
-
-	if (ret)
-		printk("%s%s [%d/%d/%d]", msg, msg1,
-		       drive->bios_cyl, drive->bios_head, drive->bios_sect);
-	return ret;
-}
-
-/*
  * Drive ID data come as little endian, it needs to be converted on big endian
  * machines.
  */
diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/drivers/ide/qd65xx.c linux/drivers/ide/qd65xx.c
--- linux-2.5.30/drivers/ide/qd65xx.c	2002-08-03 15:03:26.000000000 +0200
+++ linux/drivers/ide/qd65xx.c	2002-08-02 02:37:07.000000000 +0200
@@ -103,7 +103,7 @@ static void qd_select(struct ata_device 
  *	upper nibble represents recovery time, in count of VLB clocks
  */
 
-static u8 qd6500_compute_timing(struct ata_channel *hwif, int active_time, int recovery_time)
+static u8 qd6500_compute_timing(struct ata_channel *ch, int active_time, int recovery_time)
 {
 	u8 active_cycle,recovery_cycle;
 
@@ -172,15 +172,15 @@ static int qd_timing_ok(struct ata_devic
 
 static void qd_set_timing(struct ata_device *drive, u8 timing)
 {
-	struct ata_channel *hwif = drive->channel;
+	struct ata_channel *ch = drive->channel;
 
 	drive->drive_data &= 0xff00;
 	drive->drive_data |= timing;
-	if (qd_timing_ok(hwif->drives)) {
+	if (qd_timing_ok(ch->drives)) {
 		qd_select(drive); /* selects once */
-		hwif->selectproc = NULL;
+		ch->selectproc = NULL;
 	} else
-		hwif->selectproc = &qd_select;
+		ch->selectproc = &qd_select;
 
 	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
 }
@@ -279,61 +279,64 @@ static int __init qd_testreg(int port)
 }
 
 /*
- * called to setup an ata channel : adjusts attributes & links for tuning
+ * Adjusts attributes & links for tuning.
  */
 
-void __init qd_setup(int unit, int base, int config, unsigned int data0, unsigned int data1, void (*tuneproc) (struct ata_device *, u8 pio))
+static void __init qd_setup(int unit, int base, int config, unsigned int data0, unsigned int data1, void (*tuneproc) (struct ata_device *, u8 pio))
 {
-	struct ata_channel *hwif = &ide_hwifs[unit];
+	struct ata_channel *ch = &ide_hwifs[unit];
 
-	hwif->chipset = ide_qd65xx;
-	hwif->unit = unit;
-	hwif->select_data = base;
-	hwif->config_data = config;
-	hwif->drives[0].drive_data = data0;
-	hwif->drives[1].drive_data = data1;
-	hwif->io_32bit = 1;
-	hwif->tuneproc = tuneproc;
+	ch->chipset = ide_qd65xx;
+	ch->unit = unit;
+	ch->select_data = base;
+	ch->config_data = config;
+	ch->drives[0].drive_data = data0;
+	ch->drives[1].drive_data = data1;
+	ch->io_32bit = 1;
+	ch->tuneproc = tuneproc;
 }
 
+#ifdef MODULE
 /*
- * called to unsetup an ata channel : back to default values, unlinks tuning
+ * Called to unsetup an ata channel : back to default values, unlinks tuning.
  */
-void __init qd_unsetup(int unit) {
-	struct ata_channel *hwif = &ide_hwifs[unit];
-	u8 config = hwif->config_data;
-	int base = hwif->select_data;
-	void *tuneproc = (void *) hwif->tuneproc;
+static void __init qd_unsetup(int unit) {
+	struct ata_channel *ch = &ide_hwifs[unit];
+	u8 config = ch->config_data;
+	int base = ch->select_data;
+	void *tuneproc = (void *) ch->tuneproc;
 
-	if (!(hwif->chipset == ide_qd65xx)) return;
+	if (ch->chipset != ide_qd65xx)
+		return;
 
-	printk(KERN_NOTICE "%s: back to defaults\n", hwif->name);
+	printk(KERN_NOTICE "%s: back to defaults\n", ch->name);
 
-	hwif->selectproc = NULL;
-	hwif->tuneproc = NULL;
+	ch->selectproc = NULL;
+	ch->tuneproc = NULL;
 
 	if (tuneproc == (void *) qd6500_tune_drive) {
 		// will do it for both
-		outb(QD6500_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+		outb(QD6500_DEF_DATA, QD_TIMREG(&ch->drives[0]));
 	} else if (tuneproc == (void *) qd6580_tune_drive) {
-		if (QD_CONTROL(hwif) & QD_CONTR_SEC_DISABLED) {
-			outb(QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
-			outb(QD6580_DEF_DATA2, QD_TIMREG(&hwif->drives[1]));
+		if (QD_CONTROL(ch) & QD_CONTR_SEC_DISABLED) {
+			outb(QD6580_DEF_DATA, QD_TIMREG(&ch->drives[0]));
+			outb(QD6580_DEF_DATA2, QD_TIMREG(&ch->drives[1]));
 		} else {
-			outb(unit ? QD6580_DEF_DATA2 : QD6580_DEF_DATA, QD_TIMREG(&hwif->drives[0]));
+			outb(unit ? QD6580_DEF_DATA2 : QD6580_DEF_DATA, QD_TIMREG(&ch->drives[0]));
 		}
 	} else {
 		printk(KERN_WARNING "Unknown qd65xx tuning fonction !\n");
 		printk(KERN_WARNING "keeping settings !\n");
 	}
 }
+#endif
 
 /*
- * looks at the specified baseport, and if qd found, registers & initialises it
- * return 1 if another qd may be probed
+ * Looks at the specified baseport, and if qd found, registers & initialises it
+ * return 1 if another qd may be probed.
  */
 
-int __init qd_probe(int base)
+static int __init qd_probe(int base)
 {
 	u8 config;
 	int unit;
@@ -397,13 +400,10 @@ int __init qd_probe(int base)
 }
 
 #ifndef MODULE
-/*
- * called by ide.c when parsing command line
- */
-
 void __init init_qd65xx(void)
 {
-	if (qd_probe(0x30)) qd_probe(0xb0);
+	if (qd_probe(0x30))
+		qd_probe(0xb0);
 }
 
 #else
@@ -414,8 +414,12 @@ MODULE_LICENSE("GPL");
 
 int __init qd65xx_mod_init(void)
 {
-	if (qd_probe(0x30)) qd_probe(0xb0);
-	if (ide_hwifs[0].chipset != ide_qd65xx && ide_hwifs[1].chipset != ide_qd65xx) return -ENODEV;
+	if (qd_probe(0x30))
+		qd_probe(0xb0);
+	if (ide_hwifs[0].chipset != ide_qd65xx
+	 && ide_hwifs[1].chipset != ide_qd65xx)
+		return -ENODEV;
+
 	return 0;
 }
 module_init(qd65xx_mod_init);
diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/fs/partitions/Makefile linux/fs/partitions/Makefile
--- linux-2.5.30/fs/partitions/Makefile	2002-08-03 15:03:26.000000000 +0200
+++ linux/fs/partitions/Makefile	2002-08-02 02:22:20.000000000 +0200
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-export-objs := check.o msdos.o
+export-objs := check.o
 
 obj-y := check.o
 
diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/fs/partitions/msdos.c linux/fs/partitions/msdos.c
--- linux-2.5.30/fs/partitions/msdos.c	2002-08-03 15:03:26.000000000 +0200
+++ linux/fs/partitions/msdos.c	2002-08-02 02:22:25.000000000 +0200
@@ -22,17 +22,6 @@
 #include <linux/config.h>
 #include <linux/buffer_head.h>		/* for invalidate_bdev() */
 
-#ifdef CONFIG_BLK_DEV_IDE
-#include <linux/hdreg.h>
-#include <linux/ide.h>	/* IDE xlate */
-#elif defined(CONFIG_BLK_DEV_IDE_MODULE)
-#include <linux/module.h>
-
-int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);
-EXPORT_SYMBOL(ide_xlate_1024_hook);
-#define ide_xlate_1024 ide_xlate_1024_hook
-#endif
-
 #include "check.h"
 #include "msdos.h"
 #include "efi.h"
diff -durNp -X /tmp/diff.uRHk8V linux-2.5.30/include/linux/ide.h linux/include/linux/ide.h
--- linux-2.5.30/include/linux/ide.h	2002-08-03 15:03:26.000000000 +0200
+++ linux/include/linux/ide.h	2002-08-02 02:21:00.000000000 +0200
@@ -1091,12 +1091,6 @@ extern ide_startstop_t ata_error(struct 
 extern void ide_fixstring(char *s, const int bytecount, const int byteswap);
 
 /*
- * This routine is called from the partition-table code in genhd.c
- * to "convert" a drive to a logical geometry with fewer than 1024 cyls.
- */
-int ide_xlate_1024(kdev_t, int, int, const char *);
-
-/*
  * Convert kdev_t structure into struct ata_device * one.
  */
 struct ata_device *get_info_ptr(kdev_t i_rdev);

--------------040203060204040305080301--

