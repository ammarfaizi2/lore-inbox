Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271936AbRIIJoP>; Sun, 9 Sep 2001 05:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271939AbRIIJoF>; Sun, 9 Sep 2001 05:44:05 -0400
Received: from alcatraz.fdf.net ([209.245.242.221]:7552 "HELO alcatraz.fdf.net")
	by vger.kernel.org with SMTP id <S271936AbRIIJnz>;
	Sun, 9 Sep 2001 05:43:55 -0400
Date: Sun, 9 Sep 2001 04:44:04 -0500 (CDT)
From: Dustin Marquess <jailbird@alcatraz.fdf.net>
To: <linux-kernel@vger.kernel.org>
Subject: PATCH - Software RAID Autodetection for OSF partitions
Message-ID: <Pine.LNX.4.33.0109090443440.369-100000@alcatraz.fdf.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's a quick patch that I wrote-up for 2.4.10-pre5 (should work with
other 2.4.x kernels too), so that the OSF partition code should
auto-detect partitions with a fstype of 0xFD (software RAID).

It seems to work for me, except that the software RAID code in 2.4.10-pre5
(both with and without my patch) keep dying with superblock errors on line
1574 of md.c.  If anybody knows how to fix this error, please let me know
:).

Thanks,
-Dustin

--- linux/fs/partitions/osf.c	Fri Feb 16 18:02:37 2001
+++ /usr/src/linux-2.4.10-pre5/fs/partitions/osf.c	Sat Sep  8 22:53:37 2001
@@ -17,6 +17,12 @@
 #include "check.h"
 #include "osf.h"

+#if CONFIG_BLK_DEV_MD
+extern void md_autodetect_dev(kdev_t dev);
+#include <asm/unaligned.h>
+#define P_FSTYPE(p)	(get_unaligned(&p->p_fstype))
+#endif
+
 int osf_partition(struct gendisk *hd, kdev_t dev, unsigned long first_sector,
 		  int current_minor)
 {
@@ -77,6 +83,12 @@
 			add_gd_partition(hd, current_minor,
 				first_sector+le32_to_cpu(partition->p_offset),
 				le32_to_cpu(partition->p_size));
+#if CONFIG_BLK_DEV_MD
+			if (P_FSTYPE(partition) == LINUX_RAID_PARTITION) {
+				md_autodetect_dev(MKDEV(hd->major,current_minor));
+			}
+#endif
+
 		current_minor++;
 	}
 	printk("\n");


