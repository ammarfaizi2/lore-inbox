Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262176AbSIZEZi>; Thu, 26 Sep 2002 00:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262173AbSIZEZh>; Thu, 26 Sep 2002 00:25:37 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:65003 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S262172AbSIZEZe>; Thu, 26 Sep 2002 00:25:34 -0400
Message-ID: <3D928D7C.6000800@attbi.com>
Date: Wed, 25 Sep 2002 22:30:52 -0600
From: Alex Williamson <alex_williamson@attbi.com>
Reply-To: alex_williamson@attbi.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] raid autodetect for sun disk labels
Content-Type: multipart/mixed;
 boundary="------------060309000203000000070803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060309000203000000070803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


    I wasn't terribly fond of the idea of needing an initrd or weird
boot options to support root raid on a sparc, so I hacked on the sun
disk label support a bit to pass "Linux raid autodetect" partitions
up to md.  The extra breakout of the disk label struct is from the fdisk
source, hopefully it's not obsolete.  With this I can boot to a root
raid0 on a sparc 10, but it should of course work on any set of disks w/
proper magic.  Patch attached for 2.4.20-pre7/8.  Please CC on followup.
Thanks,

	Alex Williamson

--------------060309000203000000070803
Content-Type: text/plain;
 name="sun_autoraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sun_autoraid.patch"

--- linux-2.4.19/fs/partitions/sun.c~	Tue Sep 24 23:02:49 2002
+++ linux-2.4.19/fs/partitions/sun.c	Wed Sep 25 20:45:05 2002
@@ -19,6 +19,10 @@
 #include "check.h"
 #include "sun.h"
 
+#if CONFIG_BLK_DEV_MD
+extern void md_autodetect_dev(kdev_t dev);
+#endif
+
 int sun_partition(struct gendisk *hd, struct block_device *bdev, unsigned long first_sector, int first_part_minor)
 {
 	int i, csum;
@@ -27,7 +31,14 @@
 	kdev_t dev = to_kdev_t(bdev->bd_dev);
 	struct sun_disklabel {
 		unsigned char info[128];   /* Informative text string */
-		unsigned char spare[292];  /* Boot information etc. */
+		unsigned char spare0[14];
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
@@ -69,6 +80,7 @@
 		put_dev_sector(sect);
 		return 0;
 	}
+
 	/* All Sun disks have 8 partition entries */
 	spc = be16_to_cpu(label->ntrks) * be16_to_cpu(label->nsect);
 	for(i=0; i < 8; i++, p++) {
@@ -77,8 +89,14 @@
 
 		st_sector = first_sector + be32_to_cpu(p->start_cylinder) * spc;
 		num_sectors = be32_to_cpu(p->num_sectors);
-		if (num_sectors)
+		if (num_sectors) {
 			add_gd_partition(hd, first_part_minor, st_sector, num_sectors);
+#if CONFIG_BLK_DEV_MD
+			if (label->infos[i].id == 0xfd) { /* "Linux raid autodetect" */
+				md_autodetect_dev(MKDEV(hd->major, first_part_minor));
+			}
+#endif
+		}
 		first_part_minor++;
 	}
 	printk("\n");

--------------060309000203000000070803--

