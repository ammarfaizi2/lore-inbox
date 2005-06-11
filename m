Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbVFKI1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbVFKI1e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVFKI1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:27:33 -0400
Received: from mail.kroah.org ([69.55.234.183]:3780 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261656AbVFKHsu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:50 -0400
Subject: [PATCH] Remove devfs_mk_bdev() function from the kernel tree
In-Reply-To: <11184761111851@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:31 -0700
Message-Id: <1118476111230@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removes the devfs_mk_bdev() function and all callers of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/block/floppy.c          |   19 -------------------
 drivers/md/dm-ioctl.c           |   14 --------------
 drivers/md/md.c                 |   13 -------------
 fs/partitions/check.c           |    4 ----
 include/linux/devfs_fs_kernel.h |    4 ----
 5 files changed, 54 deletions(-)

--- gregkh-2.6.orig/drivers/block/floppy.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/drivers/block/floppy.c	2005-06-10 23:38:15.000000000 -0700
@@ -222,7 +222,6 @@
 static unsigned short virtual_dma_port = 0x3f0;
 irqreturn_t floppy_interrupt(int irq, void *dev_id, struct pt_regs *regs);
 static int set_dor(int fdc, char mask, char data);
-static void register_devfs_entries(int drive) __init;
 
 #define K_64	0x10000		/* 64KB */
 
@@ -3662,7 +3661,6 @@
 				first = 0;
 			}
 			printk("%s fd%d is %s", prepend, drive, name);
-			register_devfs_entries(drive);
 		}
 		*UDP = *params;
 	}
@@ -3955,23 +3953,6 @@
 static int *table_sup[] =
     { NULL, t360, t1200, t3in + 5 + 8, t3in + 5, t3in, t3in };
 
-static void __init register_devfs_entries(int drive)
-{
-	int base_minor = (drive < 4) ? drive : (124 + drive);
-
-	if (UDP->cmos < NUMBER(default_drive_params)) {
-		int i = 0;
-		do {
-			int minor = base_minor + (table_sup[UDP->cmos][i] << 2);
-
-			devfs_mk_bdev(MKDEV(FLOPPY_MAJOR, minor),
-				      S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP |
-				      S_IWGRP, "floppy/%d%s", drive,
-				      table[table_sup[UDP->cmos][i]]);
-		} while (table_sup[UDP->cmos][i++]);
-	}
-}
-
 /*
  * Floppy Driver initialization
  * =============================
--- gregkh-2.6.orig/drivers/md/dm-ioctl.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/drivers/md/dm-ioctl.c	2005-06-10 23:38:15.000000000 -0700
@@ -175,16 +175,6 @@
 /*
  * devfs stuff.
  */
-static int register_with_devfs(struct hash_cell *hc)
-{
-	struct gendisk *disk = dm_disk(hc->md);
-
-	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor),
-		      S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
-		      DM_DIR "/%s", hc->name);
-	return 0;
-}
-
 static int unregister_with_devfs(struct hash_cell *hc)
 {
 	devfs_remove(DM_DIR"/%s", hc->name);
@@ -222,7 +212,6 @@
 		}
 		list_add(&cell->uuid_list, _uuid_buckets + hash_str(uuid));
 	}
-	register_with_devfs(cell);
 	dm_get(md);
 	dm_set_mdptr(md, cell);
 	up_write(&_hash_lock);
@@ -312,9 +301,6 @@
 	hc->name = new_name;
 	list_add(&hc->name_list, _name_buckets + hash_str(new_name));
 
-	/* rename the device node in devfs */
-	register_with_devfs(hc);
-
 	up_write(&_hash_lock);
 	kfree(old_name);
 	return 0;
--- gregkh-2.6.orig/drivers/md/md.c	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/drivers/md/md.c	2005-06-10 23:38:15.000000000 -0700
@@ -3618,8 +3618,6 @@
 
 static int __init md_init(void)
 {
-	int minor;
-
 	printk(KERN_INFO "md: md driver %d.%d.%d MAX_MD_DEVS=%d,"
 			" MD_SB_DISKS=%d\n",
 			MD_MAJOR_VERSION, MD_MINOR_VERSION,
@@ -3636,17 +3634,6 @@
 	blk_register_region(MKDEV(mdp_major, 0), MAX_MD_DEVS<<MdpMinorShift, THIS_MODULE,
 			    md_probe, NULL, NULL);
 
-	for (minor=0; minor < MAX_MD_DEVS; ++minor)
-		devfs_mk_bdev(MKDEV(MAJOR_NR, minor),
-				S_IFBLK|S_IRUSR|S_IWUSR,
-				"md/%d", minor);
-
-	for (minor=0; minor < MAX_MD_DEVS; ++minor)
-		devfs_mk_bdev(MKDEV(mdp_major, minor<<MdpMinorShift),
-			      S_IFBLK|S_IRUSR|S_IWUSR,
-			      "md/mdp%d", minor);
-
-
 	register_reboot_notifier(&md_notifier);
 	raid_table_header = register_sysctl_table(raid_root_table, 1);
 
--- gregkh-2.6.orig/fs/partitions/check.c	2005-06-10 23:36:39.000000000 -0700
+++ gregkh-2.6/fs/partitions/check.c	2005-06-10 23:38:15.000000000 -0700
@@ -291,10 +291,6 @@
 	p->nr_sects = len;
 	p->partno = part;
 
-	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor + part),
-			S_IFBLK|S_IRUSR|S_IWUSR,
-			"%s/part%d", disk->devfs_name, part);
-
 	if (isdigit(disk->kobj.name[strlen(disk->kobj.name)-1]))
 		snprintf(p->kobj.name,KOBJ_NAME_LEN,"%sp%d",disk->kobj.name,part);
 	else
--- gregkh-2.6.orig/include/linux/devfs_fs_kernel.h	2005-06-10 23:37:17.000000000 -0700
+++ gregkh-2.6/include/linux/devfs_fs_kernel.h	2005-06-10 23:38:18.000000000 -0700
@@ -7,10 +7,6 @@
 #include <linux/types.h>
 #include <asm/semaphore.h>
 
-static inline int devfs_mk_bdev(dev_t dev, umode_t mode, const char *fmt, ...)
-{
-	return 0;
-}
 static inline int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
 {
 	return 0;

