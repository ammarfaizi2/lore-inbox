Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSHWFuM>; Fri, 23 Aug 2002 01:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318356AbSHWFuM>; Fri, 23 Aug 2002 01:50:12 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:8190 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S318333AbSHWFuH>; Fri, 23 Aug 2002 01:50:07 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15717.52741.48805.277541@wombat.chubb.wattle.id.au>
Date: Fri, 23 Aug 2002 15:54:13 +1000
To: torvalds@transmeta.com
CC: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au
Subject: Large Block Device patch part 5 of 9
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the software RAID devices to allow a larger total
size.
Individual members of the raid array still have to be less than 2TB.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.512   -> 1.513  
#	include/linux/raid/md_k.h	1.39    -> 1.40   
#	include/linux/raid/md.h	1.17    -> 1.18   
#	  drivers/md/raid5.c	1.38    -> 1.39   
#	     drivers/md/md.c	1.93    -> 1.94   
#	 drivers/md/linear.c	1.16    -> 1.17   
#	  drivers/md/raid0.c	1.14    -> 1.15   
#	    drivers/md/lvm.c	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/08/23	peterc@numbat.chubb.wattle.id.au	1.513
# Allow raid total size to be bigger than 2^32 sectors.
# --------------------------------------------
#
diff -Nru a/drivers/md/linear.c b/drivers/md/linear.c
--- a/drivers/md/linear.c	Fri Aug 23 15:08:33 2002
+++ b/drivers/md/linear.c	Fri Aug 23 15:08:33 2002
@@ -72,10 +72,12 @@
 		goto out;
 	}
 
-	nb_zone = conf->nr_zones =
-		md_size[mdidx(mddev)] / conf->smallest->size +
-		((md_size[mdidx(mddev)] % conf->smallest->size) ? 1 : 0);
-  
+	{
+		sector_t sz = md_size[mdidx(mddev)];
+		unsigned round = sector_div(sz, conf->smallest->size);
+		nb_zone = conf->nr_zones = sz + (round ? 1 : 0);
+	}
+			
 	conf->hash_table = kmalloc (sizeof (struct linear_hash) * nb_zone,
 					GFP_KERNEL);
 	if (!conf->hash_table)
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Fri Aug 23 15:08:33 2002
+++ b/drivers/md/lvm.c	Fri Aug 23 15:08:33 2002
@@ -370,7 +370,7 @@
 /* gendisk structures */
 static struct hd_struct lvm_hd_struct[MAX_LV];
 static int lvm_blocksizes[MAX_LV];
-static int lvm_size[MAX_LV];
+static sector_t lvm_size[MAX_LV];
 
 static struct gendisk lvm_gendisk =
 {
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Fri Aug 23 15:08:33 2002
+++ b/drivers/md/md.c	Fri Aug 23 15:08:33 2002
@@ -111,7 +111,7 @@
 static void md_recover_arrays(void);
 static mdk_thread_t *md_recovery_thread;
 
-int md_size[MAX_MD_DEVS];
+sector_t md_size[MAX_MD_DEVS];
 
 static struct block_device_operations md_fops;
 static devfs_handle_t devfs_handle;
@@ -300,35 +300,35 @@
 	return dname->name;
 }
 
-static unsigned int calc_dev_sboffset(struct block_device *bdev)
+static sector_t calc_dev_sboffset(struct block_device *bdev)
 {
-	unsigned int size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
+	sector_t size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
 	return MD_NEW_SIZE_BLOCKS(size);
 }
 
-static unsigned int calc_dev_size(struct block_device *bdev, mddev_t *mddev)
+static sector_t calc_dev_size(struct block_device *bdev, mddev_t *mddev)
 {
-	unsigned int size;
+	sector_t size;
 
 	if (mddev->persistent)
 		size = calc_dev_sboffset(bdev);
 	else
 		size = bdev->bd_inode->i_size >> BLOCK_SIZE_BITS;
 	if (mddev->chunk_size)
-		size &= ~(mddev->chunk_size/1024 - 1);
+		size &= ~((sector_t)mddev->chunk_size/1024 - 1);
 	return size;
 }
 
-static unsigned int zoned_raid_size(mddev_t *mddev)
+static sector_t zoned_raid_size(mddev_t *mddev)
 {
-	unsigned int mask;
+	sector_t mask;
 	mdk_rdev_t * rdev;
 	struct list_head *tmp;
 
 	/*
 	 * do size and offset calculations.
 	 */
-	mask = ~(mddev->chunk_size/1024 - 1);
+	mask = ~((sector_t)mddev->chunk_size/1024 - 1);
 
 	ITERATE_RDEV(mddev,rdev,tmp) {
 		rdev->size &= mask;
@@ -418,7 +418,7 @@
 
 static int read_disk_sb(mdk_rdev_t * rdev)
 {
-	unsigned long sb_offset;
+	sector_t sb_offset;
 
 	if (!rdev->sb) {
 		MD_BUG();
@@ -767,7 +767,8 @@
 
 static int write_disk_sb(mdk_rdev_t * rdev)
 {
-	unsigned long sb_offset, size;
+	sector_t sb_offset;
+	sector_t size;
 
 	if (!rdev->sb) {
 		MD_BUG();
@@ -994,7 +995,7 @@
 {
 	int err;
 	mdk_rdev_t *rdev;
-	unsigned int size;
+	sector_t size;
 
 	rdev = (mdk_rdev_t *) kmalloc(sizeof(*rdev), GFP_KERNEL);
 	if (!rdev) {
@@ -1949,7 +1950,7 @@
 
 static int add_new_disk(mddev_t * mddev, mdu_disk_info_t *info)
 {
-	int size;
+	sector_t size;
 	mdk_rdev_t *rdev;
 	dev_t dev;
 	dev = MKDEV(info->major,info->minor);
@@ -2439,9 +2440,9 @@
 		}
 
 		default:
-			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, "
-			       "upgrade your software to use new ictls.\n",
-			       current->comm, current->pid);
+			printk(KERN_WARNING "md: %s(pid %d) used obsolete MD ioctl, %x"
+			       "upgrade your software to use new ioctls.\n",
+			       current->comm, current->pid, cmd);
 			err = -EINVAL;
 			goto abort_unlock;
 	}
@@ -2738,7 +2739,8 @@
 static int md_status_read_proc(char *page, char **start, off_t off,
 			int count, int *eof, void *data)
 {
-	int sz = 0, j, size;
+	int sz = 0, j;
+	sector_t size;
 	struct list_head *tmp, *tmp2;
 	mdk_rdev_t *rdev;
 	mddev_t *mddev;
diff -Nru a/drivers/md/raid0.c b/drivers/md/raid0.c
--- a/drivers/md/raid0.c	Fri Aug 23 15:08:33 2002
+++ b/drivers/md/raid0.c	Fri Aug 23 15:08:33 2002
@@ -87,7 +87,7 @@
 	cnt = 0;
 	smallest = NULL;
 	ITERATE_RDEV(mddev, rdev1, tmp1) {
-		int j = rdev1->sb->this_disk.raid_disk;
+		int j = rdev1->raid_disk;
 
 		if (j < 0 || j >= mddev->raid_disks) {
 			printk("raid0: bad disk number %d - aborting!\n", j);
diff -Nru a/drivers/md/raid5.c b/drivers/md/raid5.c
--- a/drivers/md/raid5.c	Fri Aug 23 15:08:33 2002
+++ b/drivers/md/raid5.c	Fri Aug 23 15:08:33 2002
@@ -416,7 +416,7 @@
 }
 
 
-static unsigned long compute_blocknr(struct stripe_head *sh, int i);
+static sector_t compute_blocknr(struct stripe_head *sh, int i);
 	
 static void raid5_build_block (struct stripe_head *sh, int i)
 {
diff -Nru a/include/linux/raid/md.h b/include/linux/raid/md.h
--- a/include/linux/raid/md.h	Fri Aug 23 15:08:33 2002
+++ b/include/linux/raid/md.h	Fri Aug 23 15:08:33 2002
@@ -60,7 +60,7 @@
 #define MD_MINOR_VERSION                90
 #define MD_PATCHLEVEL_VERSION           0
 
-extern int md_size[MAX_MD_DEVS];
+extern sector_t md_size[MAX_MD_DEVS];
 extern struct hd_struct md_hd_struct[MAX_MD_DEVS];
 
 extern char * partition_name (kdev_t dev);
diff -Nru a/include/linux/raid/md_k.h b/include/linux/raid/md_k.h
--- a/include/linux/raid/md_k.h	Fri Aug 23 15:08:33 2002
+++ b/include/linux/raid/md_k.h	Fri Aug 23 15:08:33 2002
@@ -144,7 +144,7 @@
 {
 	struct list_head same_set;	/* RAID devices within the same set */
 
-	unsigned long size;		/* Device size (in blocks) */
+	sector_t size;			/* Device size (in blocks) */
 	mddev_t *mddev;			/* RAID array if running */
 	unsigned long last_events;	/* IO event timestamp */
 
@@ -152,7 +152,7 @@
 
 	struct page	*sb_page;
 	mdp_super_t	*sb;
-	unsigned long	sb_offset;
+	sector_t	sb_offset;
 
 	int alias_device;		/* device alias to the same disk */
 	int faulty;			/* if faulty do not issue IO requests */
@@ -348,5 +348,5 @@
 	__wait_disk_event(wq, condition);				\
 } while (0)
 
-#endif 
+#endif
 
