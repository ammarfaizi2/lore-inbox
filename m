Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWECTPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWECTPI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 15:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWECTPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 15:15:08 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:27531 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750731AbWECTPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 15:15:07 -0400
Date: Wed, 3 May 2006 21:14:57 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andy Whitcroft <apw@shadowen.org>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] root mount failure emit filesystems attempted
In-Reply-To: <20060503164414.GA2456@shadowen.org>
Message-ID: <Pine.LNX.4.61.0605031846170.13546@yvahk01.tjqt.qr>
References: <20060503164414.GA2456@shadowen.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>root mount failure emit filesystems attempted

Something better was already submitted earlier, but it did not get merged.

URL:      http://tinyurl.com/pa4ap

Long URL: http://groups.google.com/group/linux.kernel/browse_thread/thread/81bfec7e96bd60cd/b3a7f8421fb7ca53?q=show+partitions+diff&amp;rnum=1#b3a7f8421fb7ca53

What it does:
When we fail to mount from a valid root device list out the 
block devices available.

>When we fail to mount from a valid root device list out the filesystems
>we have tried to mount it with.  This gives the user vital diagnostics
>as to what is missing from their kernel.

I think both should be merged. An updated version of the print-partitions 
patch that works with 2.6.17-rc3 is below.

>  No filesystem could mount root, tried: reiserfs ext3 ext2 msdos vfat
>    iso9660 jfs xfs
>  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(8,1)

Your patch: Acked-by: Jan Engelhardt <jengelh@gmx.de>


Patch below: Signed-off-by: Jan Engelhardt <jengelh@gmx.de>

diff --fast -Ndpru linux-2.6.17-rc3~/block/genhd.c linux-2.6.17-rc3+/block/genhd.c
--- linux-2.6.17-rc3~/block/genhd.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/block/genhd.c	2006-05-01 18:50:14.326821000 +0200
@@ -214,6 +214,52 @@ struct gendisk *get_gendisk(dev_t dev, i
 	return  kobj ? to_disk(kobj) : NULL;
 }
 
+/*
+ * printk a full list of all partitions - intended for
+ * places where the root filesystem can't be mounted and thus
+ * to give the victim some idea of what went wrong
+ */
+void printk_all_partitions(void)
+{
+	int n;
+        struct gendisk* sgp;
+	down(&block_subsys_sem);
+
+        /* For each block device... */
+	list_for_each_entry(sgp,&block_subsys.kset.list, kobj.entry) {
+		char buf[BDEVNAME_SIZE];
+	  	/* Don't show empty devices or things that have been surpressed */
+		if (get_capacity(sgp) && !(sgp->flags & GENHD_FL_SUPPRESS_PARTITION_INFO)) {
+			/* Note, unlike /proc/partitions I'm showing the numbers in hex
+			   in the same format as the root= option */
+			printk("%02x%02x %10llu %s",
+			       sgp->major, sgp->first_minor,
+			       (unsigned long long)get_capacity(sgp) >> 1,
+			       disk_name(sgp, 0, buf));
+			if ((sgp->driverfs_dev) && (sgp->driverfs_dev->driver)) {
+			  printk(" driver: %s\n", sgp->driverfs_dev->driver->name);
+			} else {
+			  printk(" (driver?)\n");
+			}
+
+			/* now show the partitions */
+			for (n = 0; n < sgp->minors - 1; n++) {
+				if (!sgp->part[n])
+					continue;
+				if (sgp->part[n]->nr_sects == 0)
+					continue;
+				printk("  %02x%02x %10llu %s\n",
+					sgp->major, n + 1 + sgp->first_minor,
+					(unsigned long long)sgp->part[n]->nr_sects >> 1 ,
+					disk_name(sgp, n + 1, buf));
+			} /* partition subloop */
+		} /* Non 0 size, not surpressed */
+	} /* Block device loop */
+
+	up(&block_subsys_sem);
+  
+}
+
 #ifdef CONFIG_PROC_FS
 /* iterator */
 static void *part_start(struct seq_file *part, loff_t *pos)
diff --fast -Ndpru linux-2.6.17-rc3~/include/linux/genhd.h linux-2.6.17-rc3+/include/linux/genhd.h
--- linux-2.6.17-rc3~/include/linux/genhd.h	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/include/linux/genhd.h	2006-05-01 18:50:14.326821000 +0200
@@ -401,6 +401,7 @@ char *disk_name (struct gendisk *hd, int
 extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev);
 extern void add_partition(struct gendisk *, int, sector_t, sector_t);
 extern void delete_partition(struct gendisk *, int);
+extern void printk_all_partitions(void);
 
 extern struct gendisk *alloc_disk_node(int minors, int node_id);
 extern struct gendisk *alloc_disk(int minors);
diff --fast -Ndpru linux-2.6.17-rc3~/init/do_mounts.c linux-2.6.17-rc3+/init/do_mounts.c
--- linux-2.6.17-rc3~/init/do_mounts.c	2006-04-27 04:19:25.000000000 +0200
+++ linux-2.6.17-rc3+/init/do_mounts.c	2006-05-01 18:50:14.326821000 +0200
@@ -7,6 +7,7 @@
 #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
+#include <linux/genhd.h>
 #include <linux/mount.h>
 
 #include <linux/nfs_fs.h>
@@ -302,14 +303,18 @@ retry:
 	        /*
 		 * Allow the user to distinguish between failed sys_open
 		 * and bad superblock on root device
+		 * and give them a list of the available devices
 		 */
 		__bdevname(ROOT_DEV, b);
 		printk("VFS: Cannot open root device \"%s\" or %s\n",
 				root_device_name, b);
-		printk("Please append a correct \"root=\" boot option\n");
+		printk("Please append a correct \"root=\" boot option; here are the partitions available:\n");
 
+		printk_all_partitions();
 		panic("VFS: Unable to mount root fs on %s", b);
 	}
+	printk("List of all partitions:\n");
+	printk_all_partitions();
 	panic("VFS: Unable to mount root fs on %s", __bdevname(ROOT_DEV, b));
 out:
 	putname(fs_names);
#<<eof>>

Jan Engelhardt
-- 
