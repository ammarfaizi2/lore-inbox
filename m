Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264742AbTE1OHx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 10:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264743AbTE1OHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 10:07:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23057 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264742AbTE1OHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 10:07:36 -0400
Date: Wed, 28 May 2003 15:20:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Al Viro <viro@ftp.uk.linux.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Update Acorn partition parsing
Message-ID: <20030528152048.C5586@flint.arm.linux.org.uk>
Mail-Followup-To: Al Viro <viro@ftp.uk.linux.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch:
- re-enables cumana partition parsing
- adds eesox partition parsing
- makes the powertec partition parsing fail if sector 0 looks like
  a PC bios partition table

Rather than having a single "acorn_partition" parser for all these
types, we list them explicitly in check.c instead, along with some
explaination about why they're where they are.

--- orig/fs/partitions/Kconfig	Mon Mar 24 23:47:27 2003
+++ linux/fs/partitions/Kconfig	Mon Mar 24 23:57:55 2003
@@ -20,7 +20,17 @@
 	help
 	  Support hard disks partitioned under Acorn operating systems.
 
-#      bool '    Cumana partition support' CONFIG_ACORN_PARTITION_CUMANA
+config ACORN_PARTITION_CUMANA
+	bool "Cumana partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	help
+	  Say Y here if you would like to use hard disks under Linux which
+	  were partitioned using the Cumana interface on Acorn machines.
+
+config ACORN_PARTITION_EESOX
+	bool "EESOX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	default y if !PARTITION_ADVANCED && ARCH_ACORN
+
 config ACORN_PARTITION_ICS
 	bool "ICS partition support" if PARTITION_ADVANCED && ACORN_PARTITION
 	default y if !PARTITION_ADVANCED && ARCH_ACORN
--- orig/fs/partitions/acorn.c	Thu Jul 25 20:13:49 2002
+++ linux/fs/partitions/acorn.c	Wed May 28 14:53:24 2003
@@ -7,14 +7,25 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- *  Scan ADFS partitions on hard disk drives.
+ *  Scan ADFS partitions on hard disk drives.  Unfortunately, there
+ *  isn't a standard for partitioning drives on Acorn machines, so
+ *  every single manufacturer of SCSI and IDE cards created their own
+ *  method.
  */
 #include <linux/config.h>
 #include <linux/buffer_head.h>
+#include <linux/adfs_fs.h>
 
 #include "check.h"
 #include "acorn.h"
 
+/*
+ * Partition types. (Oh for reusability)
+ */
+#define PARTITION_RISCIX_MFM	1
+#define PARTITION_RISCIX_SCSI	2
+#define PARTITION_LINUX		9
+
 static struct adfs_discrecord *
 adfs_partition(struct parsed_partitions *state, char *name, char *data,
 	       unsigned long first_sector, int slot)
@@ -40,6 +51,21 @@
 }
 
 #ifdef CONFIG_ACORN_PARTITION_RISCIX
+
+struct riscix_part {
+	__u32	start;
+	__u32	length;
+	__u32	one;
+	char	name[16];
+};
+
+struct riscix_record {
+	__u32	magic;
+#define RISCIX_MAGIC	(0x4a657320)
+	__u32	date;
+	struct riscix_part part[8];
+};
+
 static int
 riscix_partition(struct parsed_partitions *state, struct block_device *bdev,
 		unsigned long first_sect, int slot, unsigned long nr_sects)
@@ -81,6 +107,15 @@
 }
 #endif
 
+#define LINUX_NATIVE_MAGIC 0xdeafa1de
+#define LINUX_SWAP_MAGIC   0xdeafab1e
+
+struct linux_part {
+	__u32 magic;
+	__u32 start_sect;
+	__u32 nr_sects;
+};
+
 static int
 linux_partition(struct parsed_partitions *state, struct block_device *bdev,
 		unsigned long first_sect, int slot, unsigned long nr_sects)
@@ -114,7 +149,7 @@
 }
 
 #ifdef CONFIG_ACORN_PARTITION_CUMANA
-static int
+int
 adfspart_check_CUMANA(struct parsed_partitions *state, struct block_device *bdev)
 {
 	unsigned long first_sector = 0;
@@ -126,7 +161,7 @@
 	int slot = 1;
 
 	/*
-	 * Try Cumana style partitions - sector 3 contains ADFS boot block
+	 * Try Cumana style partitions - sector 6 contains ADFS boot block
 	 * with pointer to next 'drive'.
 	 *
 	 * There are unknowns in this code - is the 'cylinder number' of the
@@ -206,7 +241,7 @@
  *	    hda1 = ADFS partition on first drive.
  *	    hda2 = non-ADFS partition.
  */
-static int
+int
 adfspart_check_ADFS(struct parsed_partitions *state, struct block_device *bdev)
 {
 	unsigned long start_sect, nr_sects, sectscyl, heads;
@@ -263,11 +298,18 @@
 			break;
 		}
 	}
+	printk("\n");
 	return 1;
 }
 #endif
 
 #ifdef CONFIG_ACORN_PARTITION_ICS
+
+struct ics_part {
+	__u32 start;
+	__s32 size;
+};
+
 static int adfspart_check_ICSLinux(struct block_device *bdev, unsigned long block)
 {
 	Sector sect;
@@ -284,6 +326,22 @@
 }
 
 /*
+ * Check for a valid ICS partition using the checksum.
+ */
+static inline int valid_ics_sector(const unsigned char *data)
+{
+	unsigned long sum;
+	int i;
+
+	for (i = 0, sum = 0x50617274; i < 508; i++)
+		sum += data[i];
+
+	sum -= le32_to_cpu(*(__u32 *)(&data[508]));
+
+	return sum == 0;
+}
+
+/*
  * Purpose: allocate ICS partitions.
  * Params : hd		- pointer to gendisk structure to store partition info.
  *	    dev		- device number to access.
@@ -293,15 +351,13 @@
  *	    hda2 = ADFS partition 1 on first drive.
  *		..etc..
  */
-static int
+int
 adfspart_check_ICS(struct parsed_partitions *state, struct block_device *bdev)
 {
-	Sector sect;
-	unsigned char *data;
-	unsigned long sum;
-	unsigned int i;
+	const unsigned char *data;
+	const struct ics_part *p;
 	int slot;
-	struct ics_part *p;
+	Sector sect;
 
 	/*
 	 * Try ICS style partitions - sector 0 contains partition info.
@@ -310,33 +366,33 @@
 	if (!data)
 	    	return -1;
 
-	/*
-	 * check for a valid checksum
-	 */
-	for (i = 0, sum = 0x50617274; i < 508; i++)
-		sum += data[i];
-
-	sum -= le32_to_cpu(*(__u32 *)(&data[508]));
-	if (sum) {
+	if (!valid_ics_sector(data)) {
 	    	put_dev_sector(sect);
-		return 0; /* not ICS partition table */
+		return 0;
 	}
 
 	printk(" [ICS]");
 
-	for (slot = 1, p = (struct ics_part *)data; p->size; p++) {
+	for (slot = 1, p = (const struct ics_part *)data; p->size; p++) {
 		u32 start = le32_to_cpu(p->start);
-		u32 size = le32_to_cpu(p->size);
+		s32 size = le32_to_cpu(p->size); /* yes, it's signed. */
 
 		if (slot == state->limit)
 			break;
 
+		/*
+		 * Negative sizes tell the RISC OS ICS driver to ignore
+		 * this partition - in effect it says that this does not
+		 * contain an ADFS filesystem.
+		 */
 		if (size < 0) {
 			size = -size;
 
 			/*
-			 * We use the first sector to identify what type
-			 * this partition is...
+			 * Our own extension - We use the first sector
+			 * of the partition to identify what type this
+			 * partition is.  We must not make this visible
+			 * to the filesystem.
 			 */
 			if (size > 1 && adfspart_check_ICSLinux(bdev, start)) {
 				start += 1;
@@ -349,10 +405,39 @@
 	}
 
 	put_dev_sector(sect);
+	printk("\n");
 	return 1;
 }
 #endif
 
+#ifdef CONFIG_ACORN_PARTITION_POWERTEC
+struct ptec_part {
+	__u32 unused1;
+	__u32 unused2;
+	__u32 start;
+	__u32 size;
+	__u32 unused5;
+	char type[8];
+};
+
+static inline int valid_ptec_sector(const unsigned char *data)
+{
+	unsigned char checksum = 0x2a;
+	int i;
+
+	/*
+	 * If it looks like a PC/BIOS partition, then it
+	 * probably isn't PowerTec.
+	 */
+	if (data[510] == 0x55 && data[511] == 0xaa)
+		return 0;
+
+	for (i = 0; i < 511; i++)
+		checksum += data[i];
+
+	return checksum == data[511];
+}
+
 /*
  * Purpose: allocate ICS partitions.
  * Params : hd		- pointer to gendisk structure to store partition info.
@@ -363,14 +448,12 @@
  *	    hda2 = ADFS partition 1 on first drive.
  *		..etc..
  */
-#ifdef CONFIG_ACORN_PARTITION_POWERTEC
-static int
+int
 adfspart_check_POWERTEC(struct parsed_partitions *state, struct block_device *bdev)
 {
 	Sector sect;
-	unsigned char *data;
-	struct ptec_partition *p;
-	unsigned char checksum;
+	const unsigned char *data;
+	const struct ptec_part *p;
 	int slot = 1;
 	int i;
 
@@ -378,17 +461,14 @@
 	if (!data)
 		return -1;
 
-	for (checksum = 0x2a, i = 0; i < 511; i++)
-		checksum += data[i];
-
-	if (checksum != data[511]) {
+	if (!valid_ptec_sector(data)) {
 		put_dev_sector(sect);
 		return 0;
 	}
 
 	printk(" [POWERTEC]");
 
-	for (i = 0, p = (struct ptec_partition *)data; i < 12; i++, p++) {
+	for (i = 0, p = (const struct ptec_part *)data; i < 12; i++, p++) {
 		u32 start = le32_to_cpu(p->start);
 		u32 size = le32_to_cpu(p->size);
 
@@ -397,46 +477,81 @@
 	}
 
 	put_dev_sector(sect);
+	printk("\n");
 	return 1;
 }
 #endif
 
-static int (*partfn[])(struct parsed_partitions *, struct block_device *) = {
-#ifdef CONFIG_ACORN_PARTITION_ICS
-	adfspart_check_ICS,
-#endif
-#ifdef CONFIG_ACORN_PARTITION_POWERTEC
-	adfspart_check_POWERTEC,
-#endif
-#ifdef CONFIG_ACORN_PARTITION_CUMANA
-	adfspart_check_CUMANA,
-#endif
-#ifdef CONFIG_ACORN_PARTITION_ADFS
-	adfspart_check_ADFS,
-#endif
-	NULL
+#ifdef CONFIG_ACORN_PARTITION_EESOX
+struct eesox_part {
+	char	magic[6];
+	char	name[10];
+	u32	start;
+	u32	unused6;
+	u32	unused7;
+	u32	unused8;
+};
+
+/*
+ * Guess who created this format?
+ */
+static const char eesox_name[] = {
+	'N', 'e', 'i', 'l', ' ',
+	'C', 'r', 'i', 't', 'c', 'h', 'e', 'l', 'l', ' ', ' '
 };
+
 /*
- * Purpose: initialise all the partitions on an ADFS drive.
- *          These may be other ADFS partitions or a Linux/RiscBSD/RISCiX
- *	    partition.
+ * EESOX SCSI partition format.
  *
- * Params : hd		- pointer to gendisk structure
- *          dev		- device number to access
+ * This is a goddamned awful partition format.  We don't seem to store
+ * the size of the partition in this table, only the start addresses.
  *
- * Returns: -1 on error, 0 if not ADFS format, 1 if ok.
+ * There are two possibilities where the size comes from:
+ *  1. The individual ADFS boot block entries that are placed on the disk.
+ *  2. The start address of the next entry.
  */
-int acorn_partition(struct parsed_partitions *state, struct block_device *bdev)
+int
+adfspart_check_EESOX(struct parsed_partitions *state, struct block_device *bdev)
 {
-	int i;
+	Sector sect;
+	const unsigned char *data;
+	unsigned char buffer[256];
+	struct eesox_part *p;
+	u32 start = 0;
+	int i, slot = 1;
 
-	for (i = 0; partfn[i]; i++) {
-		int r = partfn[i](state, bdev);
-		if (r) {
-			if (r > 0)
-				printk("\n");
-			return r;
-		}
+	data = read_dev_sector(bdev, 7, &sect);
+	if (!data)
+		return -1;
+
+	/*
+	 * "Decrypt" the partition table.  God knows why...
+	 */
+	for (i = 0; i < 256; i++)
+		buffer[i] = data[i] ^ eesox_name[i & 15];
+
+	put_dev_sector(sect);
+
+	for (i = 0, p = (struct eesox_part *)buffer; i < 8; i++, p++) {
+		u32 next;
+
+		if (memcmp(p->magic, "Eesox", 6))
+			break;
+
+		next = le32_to_cpu(p->start) + first_sector;
+		if (i)
+			put_partition(state, slot++, start, next - start);
+		start = next;
 	}
-	return 0;
+
+	if (i != 0) {
+		unsigned long size;
+
+		size = hd->part[minor(to_kdev_t(bdev->bd_dev))].nr_sects;
+		add_gd_partition(hd, minor++, start, size - start);
+		printk("\n");
+	}
+
+	return i ? 1 : 0;
 }
+#endif
--- orig/fs/partitions/acorn.h	Thu Jul 25 20:13:49 2002
+++ linux/fs/partitions/acorn.h	Thu Jul 25 20:19:05 2002
@@ -1,53 +1,14 @@
 /*
- * fs/partitions/acorn.h
+ * linux/fs/partitions/acorn.h
  *
- * Copyright (C) 1996-1998 Russell King
- */
-#include <linux/adfs_fs.h>
-
-/*
- * Partition types. (Oh for reusability)
+ * Copyright (C) 1996-2001 Russell King.
+ *
+ *  I _hate_ this partitioning mess - why can't we have one defined
+ *  format, and everyone stick to it?
  */
-#define PARTITION_RISCIX_MFM	1
-#define PARTITION_RISCIX_SCSI	2
-#define PARTITION_LINUX		9
-
-struct riscix_part {
-	__u32  start;
-	__u32  length;
-	__u32  one;
-	char name[16];
-};
-
-struct riscix_record {
-	__u32  magic;
-#define RISCIX_MAGIC	(0x4a657320)
-	__u32  date;
-	struct riscix_part part[8];
-};
-
-#define LINUX_NATIVE_MAGIC 0xdeafa1de
-#define LINUX_SWAP_MAGIC   0xdeafab1e
-
-struct linux_part {
-	__u32 magic;
-	__u32 start_sect;
-	__u32 nr_sects;
-};
-
-struct ics_part {
-	__u32 start;
-	__s32 size;
-};
-
-struct ptec_partition {
-	__u32 unused1;
-	__u32 unused2;
-	__u32 start;
-	__u32 size;
-	__u32 unused5;
-	char type[8];
-};
-	
 
-int acorn_partition(struct parsed_partitions *state, struct block_device *bdev);
+int adfspart_check_CUMANA(struct parsed_partitions *state, struct block_device *bdev);
+int adfspart_check_ADFS(struct parsed_partitions *state, struct block_device *bdev);
+int adfspart_check_ICS(struct parsed_partitions *state, struct block_device *bdev);
+int adfspart_check_POWERTEC(struct parsed_partitions *state, struct block_device *bdev);
+int adfspart_check_EESOX(struct parsed_partitions *state, struct block_device *bdev);
--- orig/fs/partitions/check.c	Tue May 27 10:05:28 2003
+++ linux/fs/partitions/check.c	Wed May 28 15:18:52 2003
@@ -45,9 +45,33 @@
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
 
 static int (*check_part[])(struct parsed_partitions *, struct block_device *) = {
-#ifdef CONFIG_ACORN_PARTITION
-	acorn_partition,
+	/*
+	 * Probe partition formats with tables at disk address 0
+	 * that also have an ADFS boot block at 0xdc0.
+	 */
+#ifdef CONFIG_ACORN_PARTITION_ICS
+	adfspart_check_ICS,
 #endif
+#ifdef CONFIG_ACORN_PARTITION_POWERTEC
+	adfspart_check_POWERTEC,
+#endif
+#ifdef CONFIG_ACORN_PARTITION_EESOX
+	adfspart_check_EESOX,
+#endif
+
+	/*
+	 * Now move on to formats that only have partition info at
+	 * disk address 0xdc0.  Since these may also have stale
+	 * PC/BIOS partition tables, they need to come before
+	 * the msdos entry.
+	 */
+#ifdef CONFIG_ACORN_PARTITION_CUMANA
+	adfspart_check_CUMANA,
+#endif
+#ifdef CONFIG_ACORN_PARTITION_ADFS
+	adfspart_check_ADFS,
+#endif
+
 #ifdef CONFIG_EFI_PARTITION
 	efi_partition,		/* this must come before msdos */
 #endif

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

