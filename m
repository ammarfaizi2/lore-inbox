Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752186AbWFLTJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbWFLTJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbWFLTJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:09:56 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:17377 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752186AbWFLTJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:09:55 -0400
Date: Mon, 12 Jun 2006 21:09:52 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Markus Biermaier <mbier@office-m.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: Can't Mount CF-Card on boot of 2.6.15 Kernel on EPIA - VFS:
 Cannot open root device
In-Reply-To: <6988083B-3A0E-41F2-A1E4-B4A953B88705@office-m.at>
Message-ID: <Pine.LNX.4.61.0606122105490.27755@yvahk01.tjqt.qr>
References: <0CB396BB-A11B-4191-982F-8C0B89F848D6@office-m.at>
 <Pine.LNX.4.61.0606122003190.7959@yvahk01.tjqt.qr>
 <6988083B-3A0E-41F2-A1E4-B4A953B88705@office-m.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > 
>> > I use an EPIA MII6000E motherboard with CF-Card as hard-drive.
>> > Since this device can't boot from CF-Card I boot from network via
>> > PXELINUX.
>> > Works fine for kernel 2.4.25.
>> > 
>> > Now I want to change to kernel 2.6.15.4.
>> > 
>> > I boot an initrd, execute "linuxrc" and at this point I can mount the
>> > CF-Card
>> > as "hde1", inspect the file-system, ...
>> > 
>> Is the proper IDE driver loaded, are you sure the drive is still at hde1
>> with 2.6?
>
> Hmm proper IDE driver...
> 1) I can mount the CF-Card "by hand" and inspect the filesystem. And it looks
> good. I can use the file-system in "near single-user-mode".
> 2) In my "linuxrc" I do the following to load the modules:
> ------------------------- [ BEGIN linuxrc ] -------------------------
> ...
> PCIC="ide_cs yenta_socket pcmcia_core pcmcia rsrc_nonstatic"
> for Module in $PCIC
> do
>        modprobe $Module
> done
> lsmod
> ...
> if [ "$DEBUG" != "" ] ; then
>    /bin/sh < /dev/console
> fi
> ...
> ------------------------- [ END   linuxrc ] -------------------------
> Is this indication enough, that I use the  proper IDE driver?

Hm. Maybe http://lkml.org/lkml/2005/2/26/92 (updated version for 
2.6.16/.17 below) can help you.

diff --fast -Ndpru linux-2.6.17-rc6~/block/genhd.c linux-2.6.17-rc6+/block/genhd.c
--- linux-2.6.17-rc6~/block/genhd.c	2006-06-06 02:57:02.000000000 +0200
+++ linux-2.6.17-rc6+/block/genhd.c	2006-06-08 22:29:16.607058000 +0200
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
+	mutex_lock(&block_subsys_lock);
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
+	mutex_unlock(&block_subsys_lock);
+  
+}
+
 #ifdef CONFIG_PROC_FS
 /* iterator */
 static void *part_start(struct seq_file *part, loff_t *pos)
diff --fast -Ndpru linux-2.6.17-rc6~/include/linux/genhd.h linux-2.6.17-rc6+/include/linux/genhd.h
--- linux-2.6.17-rc6~/include/linux/genhd.h	2006-06-06 02:57:02.000000000 +0200
+++ linux-2.6.17-rc6+/include/linux/genhd.h	2006-06-08 22:29:16.607058000 +0200
@@ -401,6 +401,7 @@ char *disk_name (struct gendisk *hd, int
 extern int rescan_partitions(struct gendisk *disk, struct block_device *bdev);
 extern void add_partition(struct gendisk *, int, sector_t, sector_t);
 extern void delete_partition(struct gendisk *, int);
+extern void printk_all_partitions(void);
 
 extern struct gendisk *alloc_disk_node(int minors, int node_id);
 extern struct gendisk *alloc_disk(int minors);
diff --fast -Ndpru linux-2.6.17-rc6~/init/do_mounts.c linux-2.6.17-rc6+/init/do_mounts.c
--- linux-2.6.17-rc6~/init/do_mounts.c	2006-06-06 02:57:02.000000000 +0200
+++ linux-2.6.17-rc6+/init/do_mounts.c	2006-06-08 22:29:16.607058000 +0200
@@ -7,6 +7,7 @@
 #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
+#include <linux/genhd.h>
 #include <linux/mount.h>
 
 #include <linux/nfs_fs.h>
@@ -302,15 +303,20 @@ retry:
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
+
 	printk("No filesystem could mount root, tried: ");
 	for (p = fs_names; *p; p += strlen(p)+1)
 		printk(" %s", p);
#<<eof>>


Jan Engelhardt
-- 
