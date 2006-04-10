Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWDJS34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWDJS34 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 14:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWDJS34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 14:29:56 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:55805 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932089AbWDJS3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 14:29:55 -0400
Message-ID: <443AA41E.2070207@blom.org>
Date: Mon, 10 Apr 2006 20:29:50 +0200
From: Martin Blom <martin@blom.org>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] AROS/Amithlon subpartition support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch adds support RDB/RDSK partitions ("Amiga
partitions") embedded in a DOS partition, as used by the AmigaOS
reimplementation AROS, Amithlon and E-UAE, for example.

Since none of these systems prevent such partitions from residing inside
logical DOS partitions (and not only primary partitions), the
"subpartitions inside logical DOS partitions" patch posted before makes
this patch much more useful.

Comments?



diff -ru linux-2.6.16/fs/partitions/amiga.c
rdb-in-msdos/fs/partitions/amiga.c
--- linux-2.6.16/fs/partitions/amiga.c	2006-04-10 14:05:43.000000000 +0200
+++ rdb-in-msdos/fs/partitions/amiga.c	2006-04-10 14:09:27.000000000 +0200
@@ -26,19 +26,25 @@
  int
  amiga_partition(struct parsed_partitions *state, struct block_device
*bdev)
  {
+	state->next = 1;
+	return parse_amiga_partition(state, bdev, 0);
+}
+
+int
+parse_amiga_partition(struct parsed_partitions *state, struct
block_device *bdev, u32 offset)
+{
  	Sector sect;
  	unsigned char *data;
  	struct RigidDiskBlock *rdb;
  	struct PartitionBlock *pb;
  	int start_sect, nr_sects, blk, part, res = 0;
  	int blksize = 1;	/* Multiplier for disk block size */
-	int slot = 1;
  	char b[BDEVNAME_SIZE];

  	for (blk = 0; ; blk++, put_dev_sector(sect)) {
  		if (blk == RDB_ALLOCATION_LIMIT)
  			goto rdb_done;
-		data = read_dev_sector(bdev, blk, &sect);
+		data = read_dev_sector(bdev, blk+offset, &sect);
  		if (!data) {
  			if (warn_no_part)
  				printk("Dev %s: unable to read RDB block %d\n",
@@ -74,7 +80,7 @@
  	put_dev_sector(sect);
  	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
  		blk *= blksize;	/* Read in terms partition table understands */
-		data = read_dev_sector(bdev, blk, &sect);
+		data = read_dev_sector(bdev, blk+offset, &sect);
  		if (!data) {
  			if (warn_no_part)
  				printk("Dev %s: unable to read partition block %d\n",
@@ -101,7 +107,7 @@
  			     be32_to_cpu(pb->pb_Environment[3]) *
  			     be32_to_cpu(pb->pb_Environment[5]) *
  			     blksize;
-		put_partition(state,slot++,start_sect,nr_sects);
+		put_partition(state,state->next++,start_sect+offset,nr_sects);
  		{
  			/* Be even more informative to aid mounting */
  			char dostype[4];
diff -ru linux-2.6.16/fs/partitions/amiga.h
rdb-in-msdos/fs/partitions/amiga.h
--- linux-2.6.16/fs/partitions/amiga.h	2006-04-10 14:05:43.000000000 +0200
+++ rdb-in-msdos/fs/partitions/amiga.h	2006-04-10 14:09:27.000000000 +0200
@@ -3,4 +3,5 @@
   */

  int amiga_partition(struct parsed_partitions *state, struct
block_device *bdev);
+int parse_amiga_partition(struct parsed_partitions *state, struct
block_device *bdev, u32 offset);

diff -ru linux-2.6.16/fs/partitions/Kconfig
rdb-in-msdos/fs/partitions/Kconfig
--- linux-2.6.16/fs/partitions/Kconfig	2006-04-10 14:05:43.000000000 +0200
+++ rdb-in-msdos/fs/partitions/Kconfig	2006-04-10 14:09:27.000000000 +0200
@@ -161,6 +161,15 @@

  	  If you don't know what all this is about, say N.

+config AROS_SUBPARTITION
+	bool "AROS/Amithlon RDB subpartitions support"
+	depends on PARTITION_ADVANCED && MSDOS_PARTITION && AMIGA_PARTITION
+	---help---
+	  AROS on x86 architecture and Amithlon use an Amiga RDB partition
+	  table inside an MSDOS partition (ID 0x30 for AROS and 0x76 for
+	  Amithlon).  Say Y here if you want to access such partitions under
+	  Linux.
+
  config LDM_PARTITION
  	bool "Windows Logical Disk Manager (Dynamic Disk) support"
  	depends on PARTITION_ADVANCED
diff -ru linux-2.6.16/fs/partitions/msdos.c
rdb-in-msdos/fs/partitions/msdos.c
--- linux-2.6.16/fs/partitions/msdos.c	2006-04-10 14:05:43.000000000 +0200
+++ rdb-in-msdos/fs/partitions/msdos.c	2006-04-10 14:14:37.000000000 +0200
@@ -22,6 +22,7 @@
  #include <linux/config.h>

  #include "check.h"
+#include "amiga.h"
  #include "msdos.h"
  #include "efi.h"

@@ -363,6 +364,20 @@
  #endif /* CONFIG_MINIX_SUBPARTITION */
  }

+/*
+ * AROS/Amithlon RDB subpartition support.
+ * Pavel Fedin <sonic_amiga@rambler.ru>, Martin Blom
+ */
+static void
+parse_aros(struct parsed_partitions *state, struct block_device *bdev,
+		u32 offset, u32 size, int origin)
+{
+#ifdef CONFIG_AROS_SUBPARTITION
+	printk(" %s%d:", state->name, origin);
+	parse_amiga_partition(state, bdev, offset);
+#endif /* CONFIG_AROS_SUBPARTITION */
+}
+
  static struct {
  	unsigned char id;
  	void (*parse)(struct parsed_partitions *, struct block_device *,
@@ -375,6 +390,8 @@
  	{UNIXWARE_PARTITION, parse_unixware},
  	{SOLARIS_X86_PARTITION, parse_solaris_x86},
  	{NEW_SOLARIS_X86_PARTITION, parse_solaris_x86},
+ 	{AROS_PARTITION, parse_aros},
+ 	{AMITHLON_PARTITION, parse_aros},
  	{0, NULL},
  };

diff -ru linux-2.6.16/include/linux/genhd.h
rdb-in-msdos/include/linux/genhd.h
--- linux-2.6.16/include/linux/genhd.h	2006-04-10 14:05:21.000000000 +0200
+++ rdb-in-msdos/include/linux/genhd.h	2006-04-10 14:09:27.000000000 +0200
@@ -41,6 +41,8 @@
  	BSDI_PARTITION = 0xb7,		/* BSDI Partition ID */
  	MINIX_PARTITION = 0x81,		/* Minix Partition ID */
  	UNIXWARE_PARTITION = 0x63,	/* Same as GNU_HURD and SCO Unix */
+	AROS_PARTITION = 0x30,		/* AROS Partition ID */
+	AMITHLON_PARTITION = 0x76,	/* Amithlon Partition ID */
  };

  #ifndef __KERNEL__


-- 
---- Martin Blom --------------------------- martin@blom.org ----
Eccl 1:18                                 http://martin.blom.org/


