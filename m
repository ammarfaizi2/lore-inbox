Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSHOScq>; Thu, 15 Aug 2002 14:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317083AbSHOScq>; Thu, 15 Aug 2002 14:32:46 -0400
Received: from mnh-1-06.mv.com ([207.22.10.38]:35589 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315946AbSHOSch>;
	Thu, 15 Aug 2002 14:32:37 -0400
Message-Id: <200208151939.OAA02778@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@karaya.com>
Subject: [PATCH] Eliminate root_dev_names - part 2 of 2
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 15 Aug 2002 14:39:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes root_dev_names.

get_gendisk_by_name is added to genhd.c.

root_dev_setup now only initializes root_device_name.

name_to_kdev_t is called from prepare_namespace in order to initialize
ROOT_DEV.

With this patch applied, a number of devices will fail to boot.  For the
most part, they need to register gendisks.  My plan is to launder patches
through the maintainers.

nfs - not a block device, but registering a dummy gendisk probably won't hurt

loop - I didn't know you could boot from a loop device, needs a dummy gendisk

ram - needs a dummy gendisk

fd, mcd, cdu535, aztcd, gscd, sbpcd, pcd, pf, jsfd, mtdblock, scd, cm206cd - need gendisks

sonycd - synonym for cdu535, needs an extra gendisk

apblock, ddv - can't find these anywhere in the pool, I think they need to
be garbage-collected out of existence

				Jeff

diff -Naur um-31-2/drivers/block/genhd.c um/drivers/block/genhd.c
--- um-31-2/drivers/block/genhd.c	Thu Aug 15 11:33:59 2002
+++ um/drivers/block/genhd.c	Thu Aug 15 11:24:00 2002
@@ -124,6 +124,29 @@
 
 EXPORT_SYMBOL(get_gendisk_by_kdev_t);
 
+/**
+ * get_gendisk_by_name - get partitioning information for a given device
+ * @name: device name to get partitioning information for
+ *
+ * This function gets the structure containing partitioning
+ * information for the given device name @name.
+ */
+struct gendisk *
+get_gendisk_by_name(char *name)
+{
+	struct gendisk *gp = NULL;
+
+	read_lock(&gendisk_lock);
+	for (gp = gendisk_head; gp; gp = gp->next) {
+	        if (strncmp(name, gp->major_name, strlen(gp->major_name)))
+		        continue;
+		read_unlock(&gendisk_lock);
+		return gp;
+	}
+	read_unlock(&gendisk_lock);
+	return NULL;
+}
+
 #ifdef CONFIG_PROC_FS
 /* iterator */
 static void *part_start(struct seq_file *part, loff_t *pos)
diff -Naur um-31-2/include/linux/genhd.h um/include/linux/genhd.h
--- um-31-2/include/linux/genhd.h	Thu Aug 15 13:06:49 2002
+++ um/include/linux/genhd.h	Thu Aug 15 11:24:59 2002
@@ -90,6 +90,7 @@
 extern void add_gendisk(struct gendisk *gp);
 extern void del_gendisk(struct gendisk *gp);
 extern struct gendisk *get_gendisk_by_kdev_t(kdev_t dev);
+extern struct gendisk *get_gendisk_by_name(char *name);
 static inline unsigned long get_start_sect(struct block_device *bdev)
 {
 	return bdev->bd_offset;
diff -Naur um-31-2/init/do_mounts.c um/init/do_mounts.c
--- um-31-2/init/do_mounts.c	Thu Aug 15 11:37:29 2002
+++ um/init/do_mounts.c	Thu Aug 15 13:01:20 2002
@@ -6,6 +6,7 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/unistd.h>
 #include <linux/ctype.h>
+#include <linux/genhd.h>
 #include <linux/blk.h>
 #include <linux/fd.h>
 #include <linux/tty.h>
@@ -86,153 +87,17 @@
 __setup("ro", readonly);
 __setup("rw", readwrite);
 
-static struct dev_name_struct {
-	const char *name;
-	const int num;
-} root_dev_names[] __initdata = {
-	{ "nfs",     0x00ff },
-	{ "hda",     0x0300 },
-	{ "hdb",     0x0340 },
-	{ "loop",    0x0700 },
-	{ "hdc",     0x1600 },
-	{ "hdd",     0x1640 },
-	{ "hde",     0x2100 },
-	{ "hdf",     0x2140 },
-	{ "hdg",     0x2200 },
-	{ "hdh",     0x2240 },
-	{ "hdi",     0x3800 },
-	{ "hdj",     0x3840 },
-	{ "hdk",     0x3900 },
-	{ "hdl",     0x3940 },
-	{ "hdm",     0x5800 },
-	{ "hdn",     0x5840 },
-	{ "hdo",     0x5900 },
-	{ "hdp",     0x5940 },
-	{ "hdq",     0x5A00 },
-	{ "hdr",     0x5A40 },
-	{ "hds",     0x5B00 },
-	{ "hdt",     0x5B40 },
-	{ "sda",     0x0800 },
-	{ "sdb",     0x0810 },
-	{ "sdc",     0x0820 },
-	{ "sdd",     0x0830 },
-	{ "sde",     0x0840 },
-	{ "sdf",     0x0850 },
-	{ "sdg",     0x0860 },
-	{ "sdh",     0x0870 },
-	{ "sdi",     0x0880 },
-	{ "sdj",     0x0890 },
-	{ "sdk",     0x08a0 },
-	{ "sdl",     0x08b0 },
-	{ "sdm",     0x08c0 },
-	{ "sdn",     0x08d0 },
-	{ "sdo",     0x08e0 },
-	{ "sdp",     0x08f0 },
-	{ "ada",     0x1c00 },
-	{ "adb",     0x1c10 },
-	{ "adc",     0x1c20 },
-	{ "add",     0x1c30 },
-	{ "ade",     0x1c40 },
-	{ "fd",      0x0200 },
-	{ "md",      0x0900 },	     
-	{ "xda",     0x0d00 },
-	{ "xdb",     0x0d40 },
-	{ "ram",     0x0100 },
-	{ "scd",     0x0b00 },
-	{ "mcd",     0x1700 },
-	{ "cdu535",  0x1800 },
-	{ "sonycd",  0x1800 },
-	{ "aztcd",   0x1d00 },
-	{ "cm206cd", 0x2000 },
-	{ "gscd",    0x1000 },
-	{ "sbpcd",   0x1900 },
-	{ "eda",     0x2400 },
-	{ "edb",     0x2440 },
-	{ "pda",	0x2d00 },
-	{ "pdb",	0x2d10 },
-	{ "pdc",	0x2d20 },
-	{ "pdd",	0x2d30 },
-	{ "pcd",	0x2e00 },
-	{ "pf",		0x2f00 },
-	{ "apblock", APBLOCK_MAJOR << 8},
-	{ "ddv", DDV_MAJOR << 8},
-	{ "jsfd",    JSFD_MAJOR << 8},
-#if defined(CONFIG_ARCH_S390)
-	{ "dasda", (DASD_MAJOR << MINORBITS) },
-	{ "dasdb", (DASD_MAJOR << MINORBITS) + (1 << 2) },
-	{ "dasdc", (DASD_MAJOR << MINORBITS) + (2 << 2) },
-	{ "dasdd", (DASD_MAJOR << MINORBITS) + (3 << 2) },
-	{ "dasde", (DASD_MAJOR << MINORBITS) + (4 << 2) },
-	{ "dasdf", (DASD_MAJOR << MINORBITS) + (5 << 2) },
-	{ "dasdg", (DASD_MAJOR << MINORBITS) + (6 << 2) },
-	{ "dasdh", (DASD_MAJOR << MINORBITS) + (7 << 2) },
-#endif
-#if defined(CONFIG_BLK_CPQ_DA) || defined(CONFIG_BLK_CPQ_DA_MODULE)
-	{ "ida/c0d0p",0x4800 },
-	{ "ida/c0d1p",0x4810 },
-	{ "ida/c0d2p",0x4820 },
-	{ "ida/c0d3p",0x4830 },
-	{ "ida/c0d4p",0x4840 },
-	{ "ida/c0d5p",0x4850 },
-	{ "ida/c0d6p",0x4860 },
-	{ "ida/c0d7p",0x4870 },
-	{ "ida/c0d8p",0x4880 },
-	{ "ida/c0d9p",0x4890 },
-	{ "ida/c0d10p",0x48A0 },
-	{ "ida/c0d11p",0x48B0 },
-	{ "ida/c0d12p",0x48C0 },
-	{ "ida/c0d13p",0x48D0 },
-	{ "ida/c0d14p",0x48E0 },
-	{ "ida/c0d15p",0x48F0 },
-#endif
-#if defined(CONFIG_BLK_CPQ_CISS_DA) || defined(CONFIG_BLK_CPQ_CISS_DA_MODULE)
-	{ "cciss/c0d0p",0x6800 },
-	{ "cciss/c0d1p",0x6810 },
-	{ "cciss/c0d2p",0x6820 },
-	{ "cciss/c0d3p",0x6830 },
-	{ "cciss/c0d4p",0x6840 },
-	{ "cciss/c0d5p",0x6850 },
-	{ "cciss/c0d6p",0x6860 },
-	{ "cciss/c0d7p",0x6870 },
-	{ "cciss/c0d8p",0x6880 },
-	{ "cciss/c0d9p",0x6890 },
-	{ "cciss/c0d10p",0x68A0 },
-	{ "cciss/c0d11p",0x68B0 },
-	{ "cciss/c0d12p",0x68C0 },
-	{ "cciss/c0d13p",0x68D0 },
-	{ "cciss/c0d14p",0x68E0 },
-	{ "cciss/c0d15p",0x68F0 },
-#endif
-	{ "nftla", 0x5d00 },
-	{ "nftlb", 0x5d10 },
-	{ "nftlc", 0x5d20 },
-	{ "nftld", 0x5d30 },
-	{ "ftla", 0x2c00 },
-	{ "ftlb", 0x2c08 },
-	{ "ftlc", 0x2c10 },
-	{ "ftld", 0x2c18 },
-	{ "mtdblock", 0x1f00 },
-	{ NULL, 0 }
-};
-
-kdev_t __init name_to_kdev_t(char *line)
+kdev_t name_to_kdev_t(char *dev)
 {
+        struct gendisk *gp = get_gendisk_by_name(dev);
 	int base = 0;
 
-	if (strncmp(line,"/dev/",5) == 0) {
-		struct dev_name_struct *dev = root_dev_names;
-		line += 5;
-		do {
-			int len = strlen(dev->name);
-			if (strncmp(line,dev->name,len) == 0) {
-				line += len;
-				base = dev->num;
-				break;
-			}
-			dev++;
-		} while (dev->name);
-	}
-	return to_kdev_t(base + simple_strtoul(line,NULL,base?10:16));
+	if(gp != NULL){
+	        base = MKDEV(gp->major, gp->first_minor);
+		dev += strlen(gp->major_name);
+ 	}
+
+	return to_kdev_t(base + simple_strtoul(dev, NULL, base ? 10 : 16));
 }
 
 static int __init root_dev_setup(char *line)
@@ -240,7 +105,6 @@
 	int i;
 	char ch;
 
-	ROOT_DEV = kdev_t_to_nr(name_to_kdev_t(line));
 	memset (root_device_name, 0, sizeof root_device_name);
 	if (strncmp (line, "/dev/", 5) == 0) line += 5;
 	for (i = 0; i < sizeof root_device_name - 1; ++i)
@@ -814,7 +678,10 @@
  */
 void prepare_namespace(void)
 {
-	int is_floppy = MAJOR(ROOT_DEV) == FLOPPY_MAJOR;
+	int is_floppy;
+
+	ROOT_DEV = kdev_t_to_nr(name_to_kdev_t(root_device_name));
+	is_floppy = (MAJOR(ROOT_DEV) == FLOPPY_MAJOR);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (!initrd_start)
 		mount_initrd = 0;

