Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261286AbVBZXav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261286AbVBZXav (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 18:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVBZXav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 18:30:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55001 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261286AbVBZXa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 18:30:27 -0500
Date: Sat, 26 Feb 2005 23:30:22 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Dump partition list on inability to mount /
Message-ID: <20050226233022.GA4654@gallifrey>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.11-rc5 (i686)
X-Uptime: 23:18:23 up 12 min,  1 user,  load average: 0.21, 0.19, 0.17
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
  The attached patch dumps a list of partitions (in a similar
format to /proc/partitions) to the console just before the kernel
panics complaining that it can't mount /, the aim being to allow
the victim to see quickly if all his devices have been found
and to understand if they have the names he expects them to have.

This is especially useful when debugging problems on other
peoples machines, systems you don't know the hardware config of,
or machines where the config has just changed (who moved
that scsi device.....).  The patch displays the minor/major
numbers (in hex for use on a root=), the name and the name
of the device driver associated with it (e.g. ide-disk) -
suggestions on easy ways to get the model of the device
in a generic way would be appreciated.

One of the annoying things about the fail to mount / panics is that you
can no longer scroll up to find out what errors came from device driver
initialisation - I'm tempted to remove or delay the panics.  Thoughts?

The patch is against 2.6.11-rc5 and has been tested on Alpha and x86.
I ask that it be included in the main kernel tree.

Comments and reports welcome.

Dave

Signed off by: Dave Gilbert <linux@treblig.org>


 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rootpartitiondump-2.6.11rc5.diff"

diff -urN linux-2.6.11-rc5.orig/drivers/block/genhd.c linux-2.6.11-rc5/drivers/block/genhd.c
--- linux-2.6.11-rc5.orig/drivers/block/genhd.c	2005-02-24 16:40:25.000000000 +0000
+++ linux-2.6.11-rc5/drivers/block/genhd.c	2005-02-26 21:17:02.000000000 +0000
@@ -219,6 +219,52 @@
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
diff -urN linux-2.6.11-rc5.orig/include/linux/genhd.h linux-2.6.11-rc5/include/linux/genhd.h
--- linux-2.6.11-rc5.orig/include/linux/genhd.h	2005-02-24 16:39:54.000000000 +0000
+++ linux-2.6.11-rc5/include/linux/genhd.h	2005-02-26 19:41:13.000000000 +0000
@@ -250,6 +250,7 @@
 	disk->capacity = size;
 }
 
+
 #endif  /*  __KERNEL__  */
 
 #ifdef CONFIG_SOLARIS_X86_PARTITION
@@ -402,6 +403,7 @@
 extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev);
 extern void add_partition(struct gendisk *, int, sector_t, sector_t);
 extern void delete_partition(struct gendisk *, int);
+extern void printk_all_partitions(void);
 
 extern struct gendisk *alloc_disk(int minors);
 extern struct kobject *get_disk(struct gendisk *disk);
diff -urN linux-2.6.11-rc5.orig/init/do_mounts.c linux-2.6.11-rc5/init/do_mounts.c
--- linux-2.6.11-rc5.orig/init/do_mounts.c	2005-02-24 16:40:14.000000000 +0000
+++ linux-2.6.11-rc5/init/do_mounts.c	2005-02-26 20:20:45.000000000 +0000
@@ -7,6 +7,7 @@
 #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
+#include <linux/genhd.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -304,14 +305,18 @@
 	        /*
 		 * Allow the user to distinguish between failed sys_open
 		 * and bad superblock on root device.
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

--huq684BweRXVnRxX--
