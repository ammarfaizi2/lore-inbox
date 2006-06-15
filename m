Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWFOGy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWFOGy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 02:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWFOGy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 02:54:29 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750721AbWFOGy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 02:54:28 -0400
Date: Wed, 14 Jun 2006 23:54:04 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: greg@kroah.com
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, aviro@www.linux.org.uk,
       axboe@suse.de, <nigel@suspend2.net>
Subject: Sparse minor space in ub
Message-Id: <20060614235404.31b70e00.zaitcev@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a patch which allows to expand the number of partitions in ub
without breaking compatibility with the existing non-udev based
distributions.

I do not know if I want this in the kernel or not. Looks pretty fishy,
and its reason to exist is my lack of foresight. So far I heard from
one user only who hit the limit, so obviously it's not something
vitally important.

But I thought I'd just throw this out in case anyone wants something
similar in the future for any reason.

Here how it looks in shell:

[zaitcev@lembas ~]$ cat /proc/partitions
major minor  #blocks  name

   3     0   39070080 hda
   3     1    5935986 hda1
   3     2    5936017 hda2
   3     3     554242 hda3
   3     4          1 hda4
   3     5   26643771 hda5
 180     0     253440 uba
 180     1     253424 uba1
 180     8     128000 ubb
 180     9        752 ubb1
 180    10          1 ubb2
 180    13        752 ubb5
 180    14        752 ubb6
 180    15        752 ubb7
 180   264        752 ubb8
 180   265       1008 ubb9
[zaitcev@lembas ~]$ ls -l /dev/ub*
brw-r----- 1 root disk 180,   0 Jun 14 23:18 /dev/uba
brw-r----- 1 root disk 180,   1 Jun 14 23:18 /dev/uba1
brw-r----- 1 root disk 180,   8 Jun 14 23:18 /dev/ubb
brw-r----- 1 root disk 180,   9 Jun 14 23:18 /dev/ubb1
brw-r----- 1 root disk 180,  10 Jun 14 23:18 /dev/ubb2
brw-r----- 1 root disk 180,  13 Jun 14 23:18 /dev/ubb5
brw-r----- 1 root disk 180,  14 Jun 14 23:18 /dev/ubb6
brw-r----- 1 root disk 180,  15 Jun 14 23:18 /dev/ubb7
brw-r----- 1 root disk 180, 264 Jun 14 23:18 /dev/ubb8
brw-r----- 1 root disk 180, 265 Jun 14 23:18 /dev/ubb9
[zaitcev@lembas ~]$

By the way, when I looked at the way things work in kobj_lookup(),
a thought occured to me. If floppy ever returns NULL from its match
function floppy_find(), the whole thing is going to loop endlessly.
This happens because we restart the search, which, I suspect, was
done to accomodate md. The md_probe() always returns NULL, and
inserts new arrays into the list of regions. Thus, it needs a rescan.
Someone needs to think about this mechanism, it seems a little
underdeveloped. I have no idea if my patch below implements the
lock/match API correctly, especially in regards to locking.

-- Pete

diff -urp -X dontdiff linux-2.6.17-rc5/block/genhd.c linux-2.6.17-rc5-lem/block/genhd.c
--- linux-2.6.17-rc5/block/genhd.c	2006-05-25 14:03:19.000000000 -0700
+++ linux-2.6.17-rc5-lem/block/genhd.c	2006-06-14 22:57:28.000000000 -0700
@@ -183,7 +183,8 @@ static int exact_lock(dev_t dev, void *d
 void add_disk(struct gendisk *disk)
 {
 	disk->flags |= GENHD_FL_UP;
-	blk_register_region(MKDEV(disk->major, disk->first_minor),
+	if (!(disk->flags & GENHD_FL_SPARSE_MINORS))
+		blk_register_region(MKDEV(disk->major, disk->first_minor),
 			    disk->minors, NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
 	blk_register_queue(disk);
@@ -195,8 +196,9 @@ EXPORT_SYMBOL(del_gendisk);	/* in partit
 void unlink_gendisk(struct gendisk *disk)
 {
 	blk_unregister_queue(disk);
-	blk_unregister_region(MKDEV(disk->major, disk->first_minor),
-			      disk->minors);
+	if (!(disk->flags & GENHD_FL_SPARSE_MINORS))
+		blk_unregister_region(MKDEV(disk->major, disk->first_minor),
+				      disk->minors);
 }
 
 #define to_disk(obj) container_of(obj,struct gendisk,kobj)
@@ -268,7 +270,7 @@ static int show_partition(struct seq_fil
 		if (sgp->part[n]->nr_sects == 0)
 			continue;
 		seq_printf(part, "%4d  %4d %10llu %s\n",
-			sgp->major, n + 1 + sgp->first_minor,
+			sgp->major, sgp->part[n]->partmin,
 			(unsigned long long)sgp->part[n]->nr_sects >> 1 ,
 			disk_name(sgp, n + 1, buf));
 	}
@@ -466,8 +468,7 @@ static int block_uevent(struct kset *kse
 		disk = container_of(kobj->parent, struct gendisk, kobj);
 		part = container_of(kobj, struct hd_struct, kobj);
 		add_uevent_var(envp, num_envp, &i, buffer, buffer_size,
-			       &length, "MINOR=%u",
-			       disk->first_minor + part->partno);
+			       &length, "MINOR=%u", part->partmin);
 	} else
 		return 0;
 
@@ -586,7 +587,7 @@ static int diskstats_show(struct seq_fil
 
 		if (hd && hd->nr_sects)
 			seq_printf(s, "%4d %4d %s %u %u %u %u\n",
-				gp->major, n + gp->first_minor + 1,
+				gp->major, hd->partmin,
 				disk_name(gp, n + 1, buf),
 				hd->ios[0], hd->sectors[0],
 				hd->ios[1], hd->sectors[1]);
diff -urp -X dontdiff linux-2.6.17-rc5/Documentation/devices.txt linux-2.6.17-rc5-lem/Documentation/devices.txt
--- linux-2.6.17-rc5/Documentation/devices.txt	2006-05-25 14:02:59.000000000 -0700
+++ linux-2.6.17-rc5-lem/Documentation/devices.txt	2006-05-25 15:45:34.000000000 -0700
@@ -2552,10 +2552,10 @@ Your cooperation is appreciated.
 		 66 = /dev/usb/cpad0	Synaptics cPad (mouse/LCD)
 
 180 block	USB block devices
-		0 = /dev/uba		First USB block device
-		8 = /dev/ubb		Second USB block device
-		16 = /dev/ubc		Thrid USB block device
-		...
+		  0 = /dev/uba		First USB block device
+		 16 = /dev/ubb		Second USB block device
+		 32 = /dev/ubc		Third USB block device
+		    ...
 
 181 char	Conrad Electronic parallel port radio clocks
 		  0 = /dev/pcfclock0	First Conrad radio clock
diff -urp -X dontdiff linux-2.6.17-rc5/drivers/block/ub.c linux-2.6.17-rc5-lem/drivers/block/ub.c
--- linux-2.6.17-rc5/drivers/block/ub.c	2006-05-25 14:03:20.000000000 -0700
+++ linux-2.6.17-rc5-lem/drivers/block/ub.c	2006-06-14 23:16:10.000000000 -0700
@@ -111,9 +107,18 @@
 #define UB_MAX_LUNS   9
 
 /*
- */
+ * The minor layout is:
+ *   19 - 11  0xFF800
+ *   10 -  8    0x700   Upper 3 bits of partition number
+ *    7 -  3     0xF8   Host index, or same as "id". UB_MAX_HOSTS fit here.
+ *    2 -  0      0x7   Lower 3 bits of partition number
+ */
+#define UB_PARTS_PER_LUN     64
+#define UB_PARTS_LOW          8
+#define UB_MINORS          2048
 
-#define UB_PARTS_PER_LUN      8
+/*
+ */
 
 #define UB_MAX_CDB_SIZE      16		/* Corresponds to Bulk */
 
@@ -384,6 +389,7 @@ static int ub_submit_clear_stall(struct 
 static void ub_top_sense_done(struct ub_dev *sc, struct ub_scsi_cmd *scmd);
 static void ub_reset_enter(struct ub_dev *sc, int try);
 static void ub_reset_task(void *arg);
+static unsigned int ub_bd_map(struct gendisk *disk, int partno);
 static int ub_sync_tur(struct ub_dev *sc, struct ub_lun *lun);
 static int ub_sync_read_cap(struct ub_dev *sc, struct ub_lun *lun,
     struct ub_capacity *ret);
@@ -407,14 +413,10 @@ MODULE_DEVICE_TABLE(usb, ub_usb_ids);
 #endif /* CONFIG_USB_LIBUSUAL */
 
 /*
- * Find me a way to identify "next free minor" for add_disk(),
- * and the array disappears the next day. However, the number of
- * hosts has something to do with the naming and /proc/partitions.
- * This has to be thought out in detail before changing.
- * If UB_MAX_HOST was 1000, we'd use a bitmap. Or a better data structure.
+ * If UB_MAX_HOST were 1000, we'd use a better data structure.
  */
 #define UB_MAX_HOSTS  26
-static char ub_hostv[UB_MAX_HOSTS];
+static struct ub_lun *ub_hostv[UB_MAX_HOSTS];
 
 #define UB_QLOCK_NUM 5
 static spinlock_t ub_qlockv[UB_QLOCK_NUM];
@@ -434,8 +436,8 @@ static int ub_id_get(void)
 
 	spin_lock_irqsave(&ub_lock, flags);
 	for (i = 0; i < UB_MAX_HOSTS; i++) {
-		if (ub_hostv[i] == 0) {
-			ub_hostv[i] = 1;
+		if (ub_hostv[i] == NULL) {
+			ub_hostv[i] = (struct ub_lun *) 1;
 			spin_unlock_irqrestore(&ub_lock, flags);
 			return i;
 		}
@@ -444,6 +446,15 @@ static int ub_id_get(void)
 	return -1;
 }
 
+static void ub_id_commit(int id, struct ub_lun *lun)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ub_lock, flags);
+	ub_hostv[id] = lun;
+	spin_unlock_irqrestore(&ub_lock, flags);
+}
+
 static void ub_id_put(int id)
 {
 	unsigned long flags;
@@ -454,12 +465,12 @@ static void ub_id_put(int id)
 	}
 
 	spin_lock_irqsave(&ub_lock, flags);
-	if (ub_hostv[id] == 0) {
+	if (ub_hostv[id] == NULL) {
 		spin_unlock_irqrestore(&ub_lock, flags);
 		printk(KERN_ERR DRV_NAME ": freeing free host ID %d\n", id);
 		return;
 	}
-	ub_hostv[id] = 0;
+	ub_hostv[id] = NULL;
 	spin_unlock_irqrestore(&ub_lock, flags);
 }
 
@@ -1781,9 +1786,80 @@ static struct block_device_operations ub
 	.ioctl		= ub_bd_ioctl,
 	.media_changed	= ub_bd_media_changed,
 	.revalidate_disk = ub_bd_revalidate,
+	.partmap	= ub_bd_map,
 };
 
 /*
+ * Since we want to remap minor bits, we have to use this weird API.
+ * It consists of two entries: lock and probe. Lock is called first
+ * grabs the relevant gendisk. The probe (usually called "match")
+ * remaps minor bits into an index for the array of partitions.
+ *
+ * The weird part is, if the lock succeeded, the match must not
+ * return NULL, or else kobj_lookup will try to lock again and things
+ * quickly unravel. All those NULL-returning paths are fake.
+ */
+
+static int ub_blk_lock(dev_t dev, void *data)
+{
+	unsigned int minor = MINOR(dev);
+	unsigned int host;
+	struct ub_lun *lun;
+	unsigned long flags;
+
+	host = (minor >> 3) & 0x1f;
+	if (host >= UB_MAX_HOSTS)
+		return -1;
+
+	spin_lock_irqsave(&ub_lock, flags);
+	lun = ub_hostv[host];
+	if (lun == NULL || (unsigned long)lun == 1) {
+		spin_unlock_irqrestore(&ub_lock, flags);
+		return -1;
+	}
+	spin_unlock_irqrestore(&ub_lock, flags);
+
+	if (atomic_read(&lun->udev->poison))
+		return -1;
+
+	if (!get_disk(lun->disk))
+		return -1;
+	return 0;
+}
+
+static struct kobject *ub_blk_match(dev_t dev, int *part, void *data)
+{
+	unsigned int minor = MINOR(dev);
+	unsigned int host;
+	struct ub_lun *lun;
+	unsigned long flags;
+
+	host = (minor >> 3) & 0x1f;
+	if (host >= UB_MAX_HOSTS)
+		return NULL;	/* This never happens, no need for a printk */
+
+	spin_lock_irqsave(&ub_lock, flags);
+	lun = ub_hostv[host];
+	if (lun == NULL || (unsigned long)lun == 1) {
+		spin_unlock_irqrestore(&ub_lock, flags);
+		printk(KERN_ERR DRV_NAME ": NULL lun for %u:%u\n",
+		    (unsigned int) MAJOR(dev), minor);
+		return NULL;
+	}
+	spin_unlock_irqrestore(&ub_lock, flags);
+
+	*part = ((minor & 0x700) >> 5) | (minor & 0x7);
+	return &lun->disk->kobj;
+}
+
+static unsigned int ub_bd_map(struct gendisk *disk, int partno)
+{
+	struct ub_lun *lun = disk->private_data;
+
+	return ((partno & 0x38) << 5) | (lun->id << 3) | (partno & 0x7);
+}
+
+/*
  * Common ->done routine for commands executed synchronously.
  */
 static void ub_probe_done(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
@@ -2318,7 +2368,6 @@ static int ub_probe_lun(struct ub_dev *s
 		goto err_id;
 
 	lun->udev = sc;
-	list_add(&lun->link, &sc->luns);
 
 	snprintf(lun->name, 16, DRV_NAME "%c(%d.%d.%d)",
 	    lun->id + 'a', sc->dev->bus->busnum, sc->dev->devnum, lun->num);
@@ -2331,14 +2380,14 @@ static int ub_probe_lun(struct ub_dev *s
 	if ((disk = alloc_disk(UB_PARTS_PER_LUN)) == NULL)
 		goto err_diskalloc;
 
-	lun->disk = disk;
 	sprintf(disk->disk_name, DRV_NAME "%c", lun->id + 'a');
 	sprintf(disk->devfs_name, DEVFS_NAME "/%c", lun->id + 'a');
 	disk->major = UB_MAJOR;
-	disk->first_minor = lun->id * UB_PARTS_PER_LUN;
+	disk->first_minor = lun->id * UB_PARTS_LOW;
 	disk->fops = &ub_bd_fops;
 	disk->private_data = lun;
 	disk->driverfs_dev = &sc->intf->dev;
+	disk->flags |= GENHD_FL_SPARSE_MINORS;
 
 	rc = -ENOMEM;
 	if ((q = blk_init_queue(ub_request_fn, sc->lock)) == NULL)
@@ -2353,12 +2402,15 @@ static int ub_probe_lun(struct ub_dev *s
 	blk_queue_max_sectors(q, UB_MAX_SECTORS);
 	blk_queue_hardsect_size(q, lun->capacity.bsize);
 
+	lun->disk = disk;
 	q->queuedata = lun;
+	list_add(&lun->link, &sc->luns);
 
 	set_capacity(disk, lun->capacity.nsec);
 	if (lun->removable)
 		disk->flags |= GENHD_FL_REMOVABLE;
 
+	ub_id_commit(lun->id, lun);
 	add_disk(disk);
 
 	return 0;
@@ -2366,7 +2418,6 @@ static int ub_probe_lun(struct ub_dev *s
 err_blkqinit:
 	put_disk(disk);
 err_diskalloc:
-	list_del(&lun->link);
 	ub_id_put(lun->id);
 err_id:
 	kfree(lun);
@@ -2487,6 +2535,8 @@ static int __init ub_init(void)
 	for (i = 0; i < UB_QLOCK_NUM; i++)
 		spin_lock_init(&ub_qlockv[i]);
 
+	blk_register_region(MKDEV(UB_MAJOR, 0), UB_MINORS, THIS_MODULE,
+					ub_blk_match, ub_blk_lock, NULL);
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
 	devfs_mk_dir(DEVFS_NAME);
@@ -2501,6 +2551,7 @@ err_register:
 	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
 err_regblkdev:
+	blk_unregister_region(MKDEV(UB_MAJOR, 0), UB_MINORS);
 	return rc;
 }
 
@@ -2511,6 +2562,7 @@ static void __exit ub_exit(void)
 	devfs_remove(DEVFS_NAME);
 	unregister_blkdev(UB_MAJOR, DRV_NAME);
 	usb_usual_clear_present(USB_US_TYPE_UB);
+	blk_unregister_region(MKDEV(UB_MAJOR, 0), UB_MINORS);
 }
 
 module_init(ub_init);
diff -urp -X dontdiff linux-2.6.17-rc5/fs/partitions/check.c linux-2.6.17-rc5-lem/fs/partitions/check.c
--- linux-2.6.17-rc5/fs/partitions/check.c	2006-05-25 14:04:00.000000000 -0700
+++ linux-2.6.17-rc5-lem/fs/partitions/check.c	2006-06-14 22:50:23.000000000 -0700
@@ -236,7 +236,7 @@ static ssize_t part_uevent_store(struct 
 static ssize_t part_dev_read(struct hd_struct * p, char *page)
 {
 	struct gendisk *disk = container_of(p->kobj.parent,struct gendisk,kobj);
-	dev_t dev = MKDEV(disk->major, disk->first_minor + p->partno); 
+	dev_t dev = MKDEV(disk->major, p->partmin); 
 	return print_dev_t(page, dev);
 }
 static ssize_t part_start_read(struct hd_struct * p, char *page)
@@ -347,7 +347,10 @@ void add_partition(struct gendisk *disk,
 	memset(p, 0, sizeof(*p));
 	p->start_sect = start;
 	p->nr_sects = len;
-	p->partno = part;
+	if (disk->fops->partmap)
+		p->partmin = disk->fops->partmap(disk, part);
+	else
+		p->partmin = disk->first_minor + part;
 
 	devfs_mk_bdev(MKDEV(disk->major, disk->first_minor + part),
 			S_IFBLK|S_IRUSR|S_IWUSR,
diff -urp -X dontdiff linux-2.6.17-rc5/include/linux/fs.h linux-2.6.17-rc5-lem/include/linux/fs.h
--- linux-2.6.17-rc5/include/linux/fs.h	2006-05-25 14:04:10.000000000 -0700
+++ linux-2.6.17-rc5-lem/include/linux/fs.h	2006-06-14 22:47:23.000000000 -0700
@@ -977,6 +977,7 @@ struct block_device_operations {
 	int (*media_changed) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
+	unsigned (*partmap)(struct gendisk *, int partno);
 	struct module *owner;
 };
 
diff -urp -X dontdiff linux-2.6.17-rc5/include/linux/genhd.h linux-2.6.17-rc5-lem/include/linux/genhd.h
--- linux-2.6.17-rc5/include/linux/genhd.h	2006-05-25 14:04:10.000000000 -0700
+++ linux-2.6.17-rc5-lem/include/linux/genhd.h	2006-06-14 22:22:37.000000000 -0700
@@ -80,7 +80,8 @@ struct hd_struct {
 	struct kobject kobj;
 	struct kobject *holder_dir;
 	unsigned ios[2], sectors[2];	/* READs and WRITEs */
-	int policy, partno;
+	int policy;
+	unsigned int partmin;
 };
 
 #define GENHD_FL_REMOVABLE			1
@@ -88,6 +89,7 @@ struct hd_struct {
 #define GENHD_FL_CD				8
 #define GENHD_FL_UP				16
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	32
+#define GENHD_FL_SPARSE_MINORS			64
 
 struct disk_stats {
 	unsigned long sectors[2];	/* READs and WRITEs */
