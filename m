Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbTHVWLx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 18:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTHVWLw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 18:11:52 -0400
Received: from codepoet.org ([166.70.99.138]:17387 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S261208AbTHVWLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 18:11:12 -0400
Date: Fri, 22 Aug 2003 16:11:09 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Backport recent IDE updates, take 2
Message-ID: <20030822221109.GB3802@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andries Brouwer <aebr@win.tue.nl>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030817061225.GA17621@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817061225.GA17621@codepoet.org>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is version #2 of my backport of the recent IDE geometry
detection changes that went into 2.6.  I have removed the bits
that people objected to, and merged in an alternative fix in one
case from the -ac tree.  This patch fixes CONFIG_IDEDISK_STROKE
so it works again, reworks and sanitizes detection of IDE disk
geometry and detection of device addressing (LBA48 / LBA28 /
CHS), and sanely clamps LBA48 when not doing DMA, preventing data
corruption, and avoids idedisk_supports_host_protected_area()
for drives that do not support the host protected area feature
set (current code makes old drives either whine or lock up).

This is solid stuff and has all been agreed to for inclusion 
in 2.4.x.  Please apply.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--


diff -urN linux-2.4.22-rc2.orig/drivers/ide/ide-disk.c linux-2.4.22-rc2/drivers/ide/ide-disk.c
--- linux-2.4.22-rc2.orig/drivers/ide/ide-disk.c	2003-06-13 08:51:33.000000000 -0600
+++ linux-2.4.22-rc2/drivers/ide/ide-disk.c	2003-08-22 02:52:11.000000000 -0600
@@ -1,5 +1,5 @@
 /*
- *  linux/drivers/ide/ide-disk.c	Version 1.18	Mar 05, 2003
+ *  linux/drivers/ide/ide-disk.c	Version 1.18	Aug 16, 2003
  *
  *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
  *  Copyright (C) 1998-2002  Linux ATA Developemt
@@ -41,9 +41,12 @@
  * Version 1.16		added suspend-resume-checkpower
  * Version 1.17		do flush on standy, do flush on ATA < ATA6
  *			fix wcache setup.
+ * Version 1.18		Fix CONFIG_IDEDISK_STROKE so it works again.
+ *			Reworked detection of geometry and LBA48/LBA28/CHS
+ *			LBA48 clamping fixes.
  */
 
-#define IDEDISK_VERSION	"1.17"
+#define IDEDISK_VERSION	"1.18"
 
 #undef REALLY_SLOW_IO		/* most systems can safely undef this */
 
@@ -69,6 +72,7 @@
 #include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 /* FIXME: some day we shouldnt need to look in here! */
 
@@ -105,11 +109,6 @@
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		printk("48-bit Drive: %llu \n", id->lba_capacity_2);
-		return 1;
-	}
-
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.
@@ -1029,8 +1028,8 @@
 		     | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
 		     | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
 		     | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	return addr;
 }
 
@@ -1057,8 +1056,8 @@
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
 		addr = ((__u64)high << 24) | low;
+		addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	}
-	addr++;	/* since the return value is (maxlba - 1), we add 1 */
 	return addr;
 }
 
@@ -1089,8 +1088,8 @@
 			 | ((args.tfRegister[  IDE_HCYL_OFFSET]       ) << 16)
 			 | ((args.tfRegister[  IDE_LCYL_OFFSET]       ) <<  8)
 			 | ((args.tfRegister[IDE_SECTOR_OFFSET]       ));
+		addr_set++;
 	}
-	addr_set++;
 	return addr_set;
 }
 
@@ -1124,22 +1123,69 @@
 			   ((args.tfRegister[IDE_LCYL_OFFSET])<<8) |
 			    (args.tfRegister[IDE_SECTOR_OFFSET]);
 		addr_set = ((__u64)high << 24) | low;
+		addr_set++;
 	}
 	return addr_set;
 }
 
 #endif /* CONFIG_IDEDISK_STROKE */
 
+static unsigned long long sectors_to_MB(unsigned long long n)
+{
+	n <<= 9;		/* make it bytes */
+	do_div(n, 1000000);	/* make it MB */
+	return n;
+}
+
 /*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
+ * Bits 10 of command_set_1 and cfs_enable_1 must be equal,
+ * so on non-buggy drives we need test only one.
+ * However, we should also check whether these fields are valid.
  */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
+static inline int idedisk_supports_hpa(const struct hd_driveid *id)
 {
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk("%s: host protected area => %d\n", drive->name, flag);
-	return flag;
+	return (id->command_set_1 & 0x0400) && (id->cfs_enable_1 & 0x0400);
+}
+
+/*
+ * The same here.
+ */
+static inline int idedisk_supports_lba48(const struct hd_driveid *id)
+{
+	return (id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400);
+}
+
+static inline void idedisk_check_hpa(ide_drive_t *drive)
+{
+	unsigned long long capacity, set_max;
+	int lba48 = idedisk_supports_lba48(drive->id);
+
+	capacity = drive->capacity64;
+	if (lba48)
+		set_max = idedisk_read_native_max_address_ext(drive);
+	else
+		set_max = idedisk_read_native_max_address(drive);
+
+	if (set_max <= capacity)
+		return;
+
+	printk(KERN_INFO "%s: Host Protected Area detected.\n"
+			 "\tcurrent capacity is %llu sectors (%llu MB)\n"
+			 "\tnative  capacity is %llu sectors (%llu MB)\n",
+			 drive->name,
+			 capacity, sectors_to_MB(capacity),
+			 set_max, sectors_to_MB(set_max));
+#ifdef CONFIG_IDEDISK_STROKE
+	if (lba48)
+		set_max = idedisk_set_max_address_ext(drive, set_max);
+	else
+		set_max = idedisk_set_max_address(drive, set_max);
+	if (set_max) {
+		drive->capacity64 = set_max;
+		printk(KERN_INFO "%s: Host Protected Area disabled.\n",
+				 drive->name);
+	}
+#endif
 }
 
 /*
@@ -1156,85 +1202,43 @@
  * in above order (i.e., if value of higher priority is available,
  * reset will be ignored).
  */
-#define IDE_STROKE_LIMIT	(32000*1024*2)
 static void init_idedisk_capacity (ide_drive_t  *drive)
 {
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity = drive->cyl * drive->head * drive->sect;
-	unsigned long set_max = idedisk_read_native_max_address(drive);
-	unsigned long long capacity_2 = capacity;
-	unsigned long long set_max_ext;
-
-	drive->capacity48 = 0;
-	drive->select.b.lba = 0;
-
-	(void) idedisk_supports_host_protected_area(drive);
-
-	if (id->cfs_enable_2 & 0x0400) {
-		capacity_2 = id->lba_capacity_2;
-		drive->head		= drive->bios_head = 255;
-		drive->sect		= drive->bios_sect = 63;
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->select.b.lba	= 1;
-		set_max_ext = idedisk_read_native_max_address_ext(drive);
-		if (set_max_ext > capacity_2 && capacity_2 > IDE_STROKE_LIMIT) {
-#ifdef CONFIG_IDEDISK_STROKE
-			set_max_ext = idedisk_read_native_max_address_ext(drive);
-			set_max_ext = idedisk_set_max_address_ext(drive, set_max_ext);
-			if (set_max_ext) {
-				drive->capacity48 = capacity_2 = set_max_ext;
-				drive->cyl = (unsigned int) set_max_ext / (drive->head * drive->sect);
-				drive->select.b.lba = 1;
-				drive->id->lba_capacity_2 = capacity_2;
-                        }
-#else /* !CONFIG_IDEDISK_STROKE */
-			printk(KERN_INFO "%s: setmax_ext LBA %llu, native  %llu\n",
-				drive->name, set_max_ext, capacity_2);
-#endif /* CONFIG_IDEDISK_STROKE */
+	/*
+	 * If this drive supports the Host Protected Area feature set,
+	 * then we may need to change our opinion about the drive's capacity.
+	 */
+	int hpa = idedisk_supports_hpa(id);
+
+	if (idedisk_supports_lba48(id)) {
+		/* drive speaks 48-bit LBA */
+		drive->select.b.lba = 1;
+		drive->capacity64 = id->lba_capacity_2;
+		if (hpa)
+			idedisk_check_hpa(drive);
+		if (drive->addressing == 0 && drive->capacity64 > (1ULL)<<28) {
+			/* FIXME:  most controllers that won't do LBA48 with
+			 * DMA will do it via PIO so we ought to implement a
+			 * PIO fallback...   For now, punt and limit the drive
+			 * to 128 GiB to prevent bad things from happening... */
+			drive->capacity64 = (1ULL)<<28;
 		}
-		drive->cyl = (unsigned int) capacity_2 / (drive->head * drive->sect);
-		drive->bios_cyl		= drive->cyl;
-		drive->capacity48	= capacity_2;
-		drive->capacity		= (unsigned long) capacity_2;
-		return;
-	/* Determine capacity, and use LBA if the drive properly supports it */
 	} else if ((id->capability & 2) && lba_capacity_is_ok(id)) {
-		capacity = id->lba_capacity;
-		drive->cyl = capacity / (drive->head * drive->sect);
+		/* drive speaks 28-bit LBA */
 		drive->select.b.lba = 1;
-	}
-
-	if (set_max > capacity && capacity > IDE_STROKE_LIMIT) {
-#ifdef CONFIG_IDEDISK_STROKE
-		set_max = idedisk_read_native_max_address(drive);
-		set_max = idedisk_set_max_address(drive, set_max);
-		if (set_max) {
-			drive->capacity = capacity = set_max;
-			drive->cyl = set_max / (drive->head * drive->sect);
-			drive->select.b.lba = 1;
-			drive->id->lba_capacity = capacity;
-		}
-#else /* !CONFIG_IDEDISK_STROKE */
-		printk(KERN_INFO "%s: setmax LBA %lu, native  %lu\n",
-			drive->name, set_max, capacity);
-#endif /* CONFIG_IDEDISK_STROKE */
-	}
-
-	drive->capacity = capacity;
-
-	if ((id->command_set_2 & 0x0400) && (id->cfs_enable_2 & 0x0400)) {
-		drive->capacity48 = id->lba_capacity_2;
-		drive->head = 255;
-		drive->sect = 63;
-		drive->cyl = (unsigned long)(drive->capacity48) / (drive->head * drive->sect);
+		drive->capacity64 = id->lba_capacity;
+		if (hpa)
+			idedisk_check_hpa(drive);
+	} else {
+		/* drive speaks boring old 28-bit CHS */
+		drive->capacity64 = drive->cyl * drive->head * drive->sect;
 	}
 }
 
-static unsigned long idedisk_capacity (ide_drive_t *drive)
+static u64 idedisk_capacity (ide_drive_t *drive)
 {
-	if (drive->id->cfs_enable_2 & 0x0400)
-		return (drive->capacity48 - drive->sect0);
-	return (drive->capacity - drive->sect0);
+	return drive->capacity64 - drive->sect0;
 }
 
 static ide_startstop_t idedisk_special (ide_drive_t *drive)
@@ -1558,7 +1562,7 @@
 	if (HWIF(drive)->addressing)
 		return 0;
 
-	if (!(drive->id->cfs_enable_2 & 0x0400))
+	if (!idedisk_supports_lba48(drive->id))
                 return -EIO;
 	drive->addressing = arg;
 	return 0;
@@ -1615,7 +1619,7 @@
 	int i;
 	
 	struct hd_driveid *id = drive->id;
-	unsigned long capacity;
+	unsigned long long capacity;
 
 	idedisk_add_settings(drive);
 
@@ -1682,14 +1686,32 @@
 	 * by correcting bios_cyls:
 	 */
 	capacity = idedisk_capacity (drive);
-	if ((capacity >= (drive->bios_cyl * drive->bios_sect * drive->bios_head)) &&
-	    (!drive->forced_geom) && drive->bios_sect && drive->bios_head)
-		drive->bios_cyl = (capacity / drive->bios_sect) / drive->bios_head;
-	printk (KERN_INFO "%s: %ld sectors", drive->name, capacity);
-
-	/* Give size in megabytes (MB), not mebibytes (MiB). */
-	/* We compute the exact rounded value, avoiding overflow. */
-	printk (" (%ld MB)", (capacity - capacity/625 + 974)/1950);
+	if (!drive->forced_geom) {
+
+		if (idedisk_supports_lba48(drive->id)) {
+			/* compatibility */
+			drive->bios_sect = 63;
+			drive->bios_head = 255;
+		}
+
+		if (drive->bios_sect && drive->bios_head) {
+			unsigned int cap0 = capacity; /* truncate to 32 bits */
+			unsigned int cylsz, cyl;
+
+			if (cap0 != capacity)
+				drive->bios_cyl = 65535;
+			else {
+				cylsz = drive->bios_sect * drive->bios_head;
+				cyl = cap0 / cylsz;
+				if (cyl > 65535)
+					cyl = 65535;
+				if (cyl > drive->bios_cyl)
+					drive->bios_cyl = cyl;
+			}
+		}
+	}
+	printk(KERN_INFO "%s: %llu sectors (%llu MB)",
+			 drive->name, capacity, sectors_to_MB(capacity));
 
 	/* Only print cache size when it was specified */
 	if (id->buf_size)
diff -urN linux-2.4.22-rc2.orig/drivers/ide/raid/hptraid.c linux-2.4.22-rc2/drivers/ide/raid/hptraid.c
--- linux-2.4.22-rc2.orig/drivers/ide/raid/hptraid.c	2003-08-22 02:00:20.000000000 -0600
+++ linux-2.4.22-rc2/drivers/ide/raid/hptraid.c	2003-08-22 02:50:02.000000000 -0600
@@ -594,7 +594,7 @@
 		return 0;
 	if (ideinfo->sect==0)
 		return 0;
-	lba = (ideinfo->capacity);
+	lba = (ideinfo->capacity64);
 
 	return lba;
 }
diff -urN linux-2.4.22-rc2.orig/drivers/ide/raid/pdcraid.c linux-2.4.22-rc2/drivers/ide/raid/pdcraid.c
--- linux-2.4.22-rc2.orig/drivers/ide/raid/pdcraid.c	2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.22-rc2/drivers/ide/raid/pdcraid.c	2003-08-22 02:50:02.000000000 -0600
@@ -28,6 +28,7 @@
 
 #include <linux/ide.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #include "ataraid.h"
 
@@ -345,7 +346,7 @@
 
 static unsigned long calc_pdcblock_offset (int major,int minor)
 {
-	unsigned long lba = 0;
+	u64 lba = 0;
 	kdev_t dev;
 	ide_drive_t *ideinfo;
 	
@@ -360,11 +361,13 @@
 		return 0;
 	if (ideinfo->sect==0)
 		return 0;
-	lba = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+	lba = ideinfo->capacity64;
+	do_div(lba, ideinfo->head*ideinfo->sect); /* macro warning, cannot combine steps */
 	lba = lba * (ideinfo->head*ideinfo->sect);
 	lba = lba - ideinfo->sect;
 
-	return lba;
+	/* I guess pdc raids do not get especially large... */ 
+	return (unsigned long)lba;
 }
 
 
diff -urN linux-2.4.22-rc2.orig/drivers/ide/raid/silraid.c linux-2.4.22-rc2/drivers/ide/raid/silraid.c
--- linux-2.4.22-rc2.orig/drivers/ide/raid/silraid.c	2003-06-13 08:51:34.000000000 -0600
+++ linux-2.4.22-rc2/drivers/ide/raid/silraid.c	2003-08-22 02:50:02.000000000 -0600
@@ -34,6 +34,7 @@
 
 #include <linux/ide.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 #include "ataraid.h"
 
@@ -248,7 +249,7 @@
 
 static unsigned long calc_silblock_offset (int major,int minor)
 {
-	unsigned long lba = 0, cylinders;
+	u64 lba = 0, cylinders;
 	kdev_t dev;
 	ide_drive_t *ideinfo;
 	
@@ -263,13 +264,15 @@
 		return 0;
 	if (ideinfo->sect==0)
 		return 0;
-	cylinders = (ideinfo->capacity / (ideinfo->head*ideinfo->sect));
+	cylinders = ideinfo->capacity64;
+	do_div(cylinders, ideinfo->head*ideinfo->sect); /* macro warning, cannot combine steps */
 	lba = (cylinders - 1) * (ideinfo->head*ideinfo->sect);
 	lba = lba - ideinfo->head -1;
 	
 //	return 80417215;  
-	printk("Guestimating sector %li for superblock\n",lba);
-	return lba;
+	printk("Guestimating sector %llu for superblock\n",lba);
+	/* I guess sil raids do not get especially large... */ 
+	return (unsigned long)lba;
 
 }
 
diff -urN linux-2.4.22-rc2.orig/include/linux/ide.h linux-2.4.22-rc2/include/linux/ide.h
--- linux-2.4.22-rc2.orig/include/linux/ide.h	2003-08-22 02:00:24.000000000 -0600
+++ linux-2.4.22-rc2/include/linux/ide.h	2003-08-22 02:50:02.000000000 -0600
@@ -785,8 +785,7 @@
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 
-	u32		capacity;	/* total number of sectors */
-	u64		capacity48;	/* total number of sectors */
+	u64		capacity64;	/* total number of sectors */
 
 	int		last_lun;	/* last logical unit */
 	int		forced_lun;	/* if hdxlun was given at boot */
