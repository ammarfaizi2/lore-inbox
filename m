Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262180AbSIZEsM>; Thu, 26 Sep 2002 00:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262185AbSIZEsM>; Thu, 26 Sep 2002 00:48:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:12163 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262180AbSIZEsK>;
	Thu, 26 Sep 2002 00:48:10 -0400
Date: Wed, 25 Sep 2002 21:47:15 -0700 (PDT)
Message-Id: <20020925.214715.34484070.davem@redhat.com>
To: alex_williamson@attbi.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] raid autodetect for sun disk labels
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D928D7C.6000800@attbi.com>
References: <3D928D7C.6000800@attbi.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nice work, I put this into my tree and I will pass it on
to Marcelo and Linus.

The only changes I made were:

1) Include linux/config.h
2) Use LINUX_RAID_PARTITION instead of magic constant

Thanks again.

--- fs/partitions/sun.c.~1~	Wed Sep 25 21:41:22 2002
+++ fs/partitions/sun.c	Wed Sep 25 21:45:34 2002
@@ -7,6 +7,7 @@
  *  Re-organised Feb 1998 Russell King
  */
 
+#include <linux/config.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
 #include <linux/kernel.h>
@@ -19,6 +20,10 @@
 #include "check.h"
 #include "sun.h"
 
+#ifdef CONFIG_BLK_DEV_MD
+extern void md_autodetect_dev(kdev_t dev);
+#endif
+
 int sun_partition(struct gendisk *hd, struct block_device *bdev, unsigned long first_sector, int first_part_minor)
 {
 	int i, csum;
@@ -27,7 +32,14 @@
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	struct sun_disklabel {
 		unsigned char info[128];   /* Informative text string */
-		unsigned char spare[292];  /* Boot information etc. */
+		unsigned char sparc0[14];
+		struct sun_info {
+			unsigned char spare1;
+			unsigned char id;
+			unsigned char spare2;
+			unsigned char flags;
+		} infos[8];
+		unsigned char spare[246];  /* Boot information etc. */
 		unsigned short rspeed;     /* Disk rotational speed */
 		unsigned short pcylcount;  /* Physical cylinder count */
 		unsigned short sparecyl;   /* extra sects per cylinder */
@@ -63,22 +75,30 @@
 	ush = ((unsigned short *) (label+1)) - 1;
 	for (csum = 0; ush >= ((unsigned short *) label);)
 		csum ^= *ush--;
-	if(csum) {
+	if (csum) {
 		printk("Dev %s Sun disklabel: Csum bad, label corrupted\n",
 		       bdevname(dev));
 		put_dev_sector(sect);
 		return 0;
 	}
+
 	/* All Sun disks have 8 partition entries */
 	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
-	for(i=0; i < 8; i++, p++) {
+	for (i = 0; i < 8; i++, p++) {
 		unsigned long st_sector;
 		int num_sectors;
 
 		st_sector = first_sector + be32_to_cpu(p->start_cylinder) * spc;
 		num_sectors = be32_to_cpu(p->num_sectors);
-		if (num_sectors)
-			add_gd_partition(hd, first_part_minor, st_sector, num_sectors);
+		if (num_sectors) {
+			add_gd_partition(hd, first_part_minor,
+					 st_sector, num_sectors);
+#ifdef CONFIG_BLK_DEV_MD
+			if (label->infos[i].id == LINUX_RAID_PARTITION)
+				md_autodetect_dev(MKDEV(hd->major,
+							first_part_minor));
+#endif
+		}
 		first_part_minor++;
 	}
 	printk("\n");
