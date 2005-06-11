Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVFKIFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVFKIFW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVFKIEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:04:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:452 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261647AbVFKHsm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:42 -0400
Subject: [PATCH] Remove devfs from the partition code
In-Reply-To: <11184761102127@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:30 -0700
Message-Id: <11184761102475@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch removes the devfs code from the fs/partitions/ directory.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 fs/partitions/Makefile |    1 
 fs/partitions/check.c  |   26 +--------
 fs/partitions/devfs.c  |  130 -------------------------------------------------
 fs/partitions/devfs.h  |   10 ---
 4 files changed, 5 insertions(+), 162 deletions(-)

--- gregkh-2.6.orig/fs/partitions/devfs.c	2005-06-10 23:29:09.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,130 +0,0 @@
-/*
- * This tries to keep block devices away from devfs as much as possible.
- */
-#include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
-#include <linux/vmalloc.h>
-#include <linux/genhd.h>
-#include <linux/bitops.h>
-#include <asm/semaphore.h>
-
-
-struct unique_numspace {
-	u32		  num_free;          /*  Num free in bits       */
-	u32		  length;            /*  Array length in bytes  */
-	unsigned long	  *bits;
-	struct semaphore  mutex;
-};
-
-static DECLARE_MUTEX(numspace_mutex);
-
-static int expand_numspace(struct unique_numspace *s)
-{
-	u32 length;
-	void *bits;
-
-	if (s->length < 16)
-		length = 16;
-	else
-		length = s->length << 1;
-
-	bits = vmalloc(length);
-	if (!bits)
-		return -ENOMEM;
-	if (s->bits) {
-		memcpy(bits, s->bits, s->length);
-		vfree(s->bits);
-	}
-		
-	s->num_free = (length - s->length) << 3;
-	s->bits = bits;
-	memset(bits + s->length, 0, length - s->length);
-	s->length = length;
-
-	return 0;
-}
-
-static int alloc_unique_number(struct unique_numspace *s)
-{
-	int rval = 0;
-
-	down(&numspace_mutex);
-	if (s->num_free < 1)
-		rval = expand_numspace(s);
-	if (!rval) {
-		rval = find_first_zero_bit(s->bits, s->length << 3);
-		--s->num_free;
-		__set_bit(rval, s->bits);
-	}
-	up(&numspace_mutex);
-
-	return rval;
-}
-
-static void dealloc_unique_number(struct unique_numspace *s, int number)
-{
-	int old_val;
-
-	if (number >= 0) {
-		down(&numspace_mutex);
-		old_val = __test_and_clear_bit(number, s->bits);
-		if (old_val)
-			++s->num_free;
-		up(&numspace_mutex);
-	}
-}
-
-static struct unique_numspace disc_numspace;
-static struct unique_numspace cdrom_numspace;
-
-void devfs_add_partitioned(struct gendisk *disk)
-{
-	char dirname[64], symlink[16];
-
-	devfs_mk_dir(disk->devfs_name);
-	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor),
-			S_IFBLK|S_IRUSR|S_IWUSR,
-			"%s/disc", disk->devfs_name);
-
-	disk->number = alloc_unique_number(&disc_numspace);
-
-	sprintf(symlink, "discs/disc%d", disk->number);
-	sprintf(dirname, "../%s", disk->devfs_name);
-	devfs_mk_symlink(symlink, dirname);
-
-}
-
-void devfs_add_disk(struct gendisk *disk)
-{
-	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor),
-			(disk->flags & GENHD_FL_CD) ?
-				S_IFBLK|S_IRUGO|S_IWUGO :
-				S_IFBLK|S_IRUSR|S_IWUSR,
-			"%s", disk->devfs_name);
-
-	if (disk->flags & GENHD_FL_CD) {
-		char dirname[64], symlink[16];
-
-		disk->number = alloc_unique_number(&cdrom_numspace);
-
-		sprintf(symlink, "cdroms/cdrom%d", disk->number);
-		sprintf(dirname, "../%s", disk->devfs_name);
-		devfs_mk_symlink(symlink, dirname);
-	}
-}
-
-void devfs_remove_disk(struct gendisk *disk)
-{
-	if (disk->minors != 1) {
-		devfs_remove("discs/disc%d", disk->number);
-		dealloc_unique_number(&disc_numspace, disk->number);
-		devfs_remove("%s/disc", disk->devfs_name);
-	}
-	if (disk->flags & GENHD_FL_CD) {
-		devfs_remove("cdroms/cdrom%d", disk->number);
-		dealloc_unique_number(&cdrom_numspace, disk->number);
-	}
-	devfs_remove(disk->devfs_name);
-}
-
-
--- gregkh-2.6.orig/fs/partitions/devfs.h	2005-06-10 23:29:09.000000000 -0700
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,10 +0,0 @@
-
-#ifdef CONFIG_DEVFS_FS
-void devfs_add_disk(struct gendisk *dev);
-void devfs_add_partitioned(struct gendisk *dev);
-void devfs_remove_disk(struct gendisk *dev);
-#else
-# define devfs_add_disk(disk)			do { } while (0)
-# define devfs_add_partitioned(disk)		do { } while (0)
-# define devfs_remove_disk(disk)		do { } while (0)
-#endif
--- gregkh-2.6.orig/fs/partitions/Makefile	2005-06-10 23:29:09.000000000 -0700
+++ gregkh-2.6/fs/partitions/Makefile	2005-06-10 23:36:39.000000000 -0700
@@ -4,7 +4,6 @@
 
 obj-y := check.o
 
-obj-$(CONFIG_DEVFS_FS) += devfs.o
 obj-$(CONFIG_ACORN_PARTITION) += acorn.o
 obj-$(CONFIG_AMIGA_PARTITION) += amiga.o
 obj-$(CONFIG_ATARI_PARTITION) += atari.o
--- gregkh-2.6.orig/fs/partitions/check.c	2005-06-10 23:29:09.000000000 -0700
+++ gregkh-2.6/fs/partitions/check.c	2005-06-10 23:38:20.000000000 -0700
@@ -21,7 +21,6 @@
 #include <linux/devfs_fs_kernel.h>
 
 #include "check.h"
-#include "devfs.h"
 
 #include "acorn.h"
 #include "amiga.h"
@@ -160,18 +159,11 @@
 	if (!state)
 		return NULL;
 
-#ifdef CONFIG_DEVFS_FS
-	if (hd->devfs_name[0] != '\0') {
-		printk(KERN_INFO " /dev/%s:", hd->devfs_name);
+	disk_name(hd, 0, state->name);
+	printk(KERN_INFO " %s:", state->name);
+	if (isdigit(state->name[strlen(state->name)-1]))
 		sprintf(state->name, "p");
-	}
-#endif
-	else {
-		disk_name(hd, 0, state->name);
-		printk(KERN_INFO " %s:", state->name);
-		if (isdigit(state->name[strlen(state->name)-1]))
-			sprintf(state->name, "p");
-	}
+
 	state->limit = hd->minors;
 	i = res = 0;
 	while (!res && check_part[i]) {
@@ -340,14 +332,8 @@
 	kobject_hotplug(&disk->kobj, KOBJ_ADD);
 
 	/* No minors to use for partitions */
-	if (disk->minors == 1) {
-		if (disk->devfs_name[0] != '\0')
-			devfs_add_disk(disk);
+	if (disk->minors == 1)
 		return;
-	}
-
-	/* always add handle for the whole disk */
-	devfs_add_partitioned(disk);
 
 	/* No such device (e.g., media were just removed) */
 	if (!get_capacity(disk))
@@ -435,8 +421,6 @@
 	disk_stat_set_all(disk, 0);
 	disk->stamp = disk->stamp_idle = 0;
 
-	devfs_remove_disk(disk);
-
 	if (disk->driverfs_dev) {
 		sysfs_remove_link(&disk->kobj, "device");
 		sysfs_remove_link(&disk->driverfs_dev->kobj, "block");

