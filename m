Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263375AbTC2Ba3>; Fri, 28 Mar 2003 20:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263374AbTC2Ba3>; Fri, 28 Mar 2003 20:30:29 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:3993 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263372AbTC2BaV>;
	Fri, 28 Mar 2003 20:30:21 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [patch for playing] 2.5.65 patch to support > 256 disks
Date: Fri, 28 Mar 2003 17:39:48 -0800
User-Agent: KMail/1.4.1
Cc: Jens Axboe <axboe@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@digeo.com>, dougg@torque.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <200303211056.04060.pbadari@us.ibm.com> <200303280904.41797.pbadari@us.ibm.com> <20030328184153.GA11941@win.tue.nl>
In-Reply-To: <20030328184153.GA11941@win.tue.nl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_CYLH8HSRV69DQCSZ646O"
Message-Id: <200303281739.48747.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_CYLH8HSRV69DQCSZ646O
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 28 March 2003 10:41 am, Andries Brouwer wrote:
> On Fri, Mar 28, 2003 at 09:04:41AM -0800, Badari Pulavarty wrote:
> > 2) Instead of allocating hd_struct structure for all possible partiti=
ons,
> > why not allocated them dynamically, as we see a partition ? This
> > way we could (in theory) support more than 16 partitions, if needed.
>
> This is what I plan to do.
> Of course you are welcome to do it first.
>
> Andries

Okay !! Here is my patch to add hd_structs dynamically as we add partitio=
ns.
Machine boots fine. I was able to add/delete partitions.

It is not polished yet, but any comments ?=20

Thanks,
Badari


--------------Boundary-00=_CYLH8HSRV69DQCSZ646O
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="dyn.part"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dyn.part"

--- linux/include/linux/genhd.h	Fri Mar 28 14:49:59 2003
+++ linux.new/include/linux/genhd.h	Fri Mar 28 18:17:55 2003
@@ -63,7 +63,7 @@ struct hd_struct {
 	devfs_handle_t de;              /* primary (master) devfs entry  */
 	struct kobject kobj;
 	unsigned reads, read_sectors, writes, write_sectors;
-	int policy;
+	int policy, partno;
 };
 
 #define GENHD_FL_REMOVABLE  1
@@ -89,7 +89,7 @@ struct gendisk {
 	int minor_shift;		/* number of times minor is shifted to
 					   get real minor */
 	char disk_name[16];		/* name of major driver */
-	struct hd_struct *part;		/* [indexed by minor] */
+	struct hd_struct **part;	/* [indexed by minor] */
 	struct block_device_operations *fops;
 	struct request_queue *queue;
 	void *private_data;
--- linux/drivers/block/genhd.c	Fri Mar 28 14:30:57 2003
+++ linux.new/drivers/block/genhd.c	Fri Mar 28 18:21:17 2003
@@ -365,11 +365,13 @@ static int show_partition(struct seq_fil
 		(unsigned long long)get_capacity(sgp) >> 1,
 		disk_name(sgp, 0, buf));
 	for (n = 0; n < sgp->minors - 1; n++) {
-		if (sgp->part[n].nr_sects == 0)
+		if (!sgp->part[n])
+			continue;
+		if (sgp->part[n]->nr_sects == 0)
 			continue;
 		seq_printf(part, "%4d  %4d %10llu %s\n",
 			sgp->major, n + 1 + sgp->first_minor,
-			(unsigned long long)sgp->part[n].nr_sects >> 1 ,
+			(unsigned long long)sgp->part[n]->nr_sects >> 1 ,
 			disk_name(sgp, n + 1, buf));
 	}
 
@@ -531,8 +533,6 @@ static decl_subsys(block,&ktype_block);
 
 struct gendisk *alloc_disk(int minors)
 {
-	int dbg = 0 ;
-
 	struct gendisk *disk = kmalloc(sizeof(struct gendisk), GFP_KERNEL);
 	if (disk) {
 		memset(disk, 0, sizeof(struct gendisk));
@@ -541,7 +541,7 @@ struct gendisk *alloc_disk(int minors)
 			return NULL;
 		}
 		if (minors > 1) {
-			int size = (minors - 1) * sizeof(struct hd_struct);
+			int size = (minors - 1) * sizeof(struct hd_struct *);
 			disk->part = kmalloc(size, GFP_KERNEL);
 			if (!disk->part) {
 				kfree(disk);
@@ -593,8 +593,8 @@ void set_device_ro(struct block_device *
 	struct gendisk *disk = bdev->bd_disk;
 	if (bdev->bd_contains != bdev) {
 		int part = bdev->bd_dev - MKDEV(disk->major, disk->first_minor);
-		struct hd_struct *p = &disk->part[part-1];
-		p->policy = flag;
+		struct hd_struct *p = disk->part[part-1];
+		if (p) p->policy = flag;
 	} else
 		disk->policy = flag;
 }
@@ -604,7 +604,7 @@ void set_disk_ro(struct gendisk *disk, i
 	int i;
 	disk->policy = flag;
 	for (i = 0; i < disk->minors - 1; i++)
-		disk->part[i].policy = flag;
+		if (disk->part[i]) disk->part[i]->policy = flag;
 }
 
 int bdev_read_only(struct block_device *bdev)
@@ -615,8 +615,9 @@ int bdev_read_only(struct block_device *
 	disk = bdev->bd_disk;
 	if (bdev->bd_contains != bdev) {
 		int part = bdev->bd_dev - MKDEV(disk->major, disk->first_minor);
-		struct hd_struct *p = &disk->part[part-1];
-		return p->policy;
+		struct hd_struct *p = disk->part[part-1];
+		if (p) return p->policy;
+		return 0;
 	} else
 		return disk->policy;
 }
--- linux/drivers/block/ioctl.c	Fri Mar 28 15:01:48 2003
+++ linux.new/drivers/block/ioctl.c	Fri Mar 28 18:16:55 2003
@@ -41,11 +41,11 @@ static int blkpg_ioctl(struct block_devi
 					return -EINVAL;
 			}
 			/* partition number in use? */
-			if (disk->part[part - 1].nr_sects != 0)
+			if (disk->part[part - 1])
 				return -EBUSY;
 			/* overlap? */
 			for (i = 0; i < disk->minors - 1; i++) {
-				struct hd_struct *s = &disk->part[i];
+				struct hd_struct *s = disk->part[i];
 				if (!(start+length <= s->start_sect ||
 				      start >= s->start_sect + s->nr_sects))
 					return -EBUSY;
@@ -54,7 +54,9 @@ static int blkpg_ioctl(struct block_devi
 			add_partition(disk, part, start, length);
 			return 0;
 		case BLKPG_DEL_PARTITION:
-			if (disk->part[part - 1].nr_sects == 0)
+			if (!disk->part[part-1])
+				return -ENXIO;
+			if (disk->part[part - 1]->nr_sects == 0)
 				return -ENXIO;
 			/* partition in use? Incomplete check for now. */
 			bdevp = bdget(MKDEV(disk->major, disk->first_minor) + part);
--- linux/drivers/block/ll_rw_blk.c	Fri Mar 28 14:58:48 2003
+++ linux.new/drivers/block/ll_rw_blk.c	Fri Mar 28 18:15:25 2003
@@ -1867,7 +1867,7 @@ static inline void blk_partition_remap(s
 	if (bdev == bdev->bd_contains)
 		return;
 
-	p = &disk->part[bdev->bd_dev-MKDEV(disk->major,disk->first_minor)-1];
+	p = disk->part[bdev->bd_dev-MKDEV(disk->major,disk->first_minor)-1];
 	switch (bio->bi_rw) {
 	case READ:
 		p->read_sectors += bio_sectors(bio);
--- linux/fs/block_dev.c	Fri Mar 28 17:36:28 2003
+++ linux.new/fs/block_dev.c	Fri Mar 28 18:15:08 2003
@@ -559,10 +559,10 @@ static int do_open(struct block_device *
 			bdev->bd_contains = whole;
 			down(&whole->bd_sem);
 			whole->bd_part_count++;
-			p = disk->part + part - 1;
+			p = disk->part[part - 1];
 			bdev->bd_inode->i_data.backing_dev_info =
 			   whole->bd_inode->i_data.backing_dev_info;
-			if (!(disk->flags & GENHD_FL_UP) || !p->nr_sects) {
+			if (!(disk->flags & GENHD_FL_UP) || !p || !p->nr_sects) {
 				whole->bd_part_count--;
 				up(&whole->bd_sem);
 				ret = -ENXIO;
--- linux/fs/partitions/check.c	Fri Mar 28 14:32:29 2003
+++ linux.new/fs/partitions/check.c	Fri Mar 28 18:22:56 2003
@@ -103,8 +103,8 @@ char *disk_name(struct gendisk *hd, int 
 		}
 		sprintf(buf, "%s", hd->disk_name);
 	} else {
-		if (hd->part[part-1].de) {
-			pos = devfs_generate_path(hd->part[part-1].de, buf, 64);
+		if (hd->part[part-1]->de) {
+			pos = devfs_generate_path(hd->part[part-1]->de, buf, 64);
 			if (pos >= 0)
 				return buf + pos;
 		}
@@ -160,7 +160,7 @@ static void devfs_register_partition(str
 {
 #ifdef CONFIG_DEVFS_FS
 	devfs_handle_t dir;
-	struct hd_struct *p = dev->part;
+	struct hd_struct *p = dev->parts;
 	char devname[16];
 
 	if (p[part-1].de)
@@ -203,7 +203,7 @@ static struct sysfs_ops part_sysfs_ops =
 static ssize_t part_dev_read(struct hd_struct * p, char *page)
 {
 	struct gendisk *disk = container_of(p->kobj.parent,struct gendisk,kobj);
-	int part = p - disk->part + 1;
+	int part = p->partno;
 	dev_t base = MKDEV(disk->major, disk->first_minor); 
 	return sprintf(page, "%04x\n", (unsigned)(base + part));
 }
@@ -255,19 +255,30 @@ static struct kobj_type ktype_part = {
 
 void delete_partition(struct gendisk *disk, int part)
 {
-	struct hd_struct *p = disk->part + part - 1;
+	struct hd_struct *p = disk->part[part-1];
+	if (!p)
+		return;
 	if (!p->nr_sects)
 		return;
+	printk("del_partition: disk:%x part:%d \n", disk, part);
 	p->start_sect = 0;
 	p->nr_sects = 0;
 	p->reads = p->writes = p->read_sectors = p->write_sectors = 0;
 	devfs_unregister(p->de);
 	kobject_unregister(&p->kobj);
+	disk->part[part-1] = NULL;
+	kfree(p);
 }
 
 void add_partition(struct gendisk *disk, int part, sector_t start, sector_t len)
 {
-	struct hd_struct *p = disk->part + part - 1;
+	struct hd_struct *p;
+	printk("add_partition: disk:%x part:%d start:%d len:%d\n", disk, part, (int)start, (int)len);
+
+	p = kmalloc(sizeof(struct hd_struct), GFP_KERNEL);
+	if (!p) return;
+
+	memset(p, 0, sizeof(struct hd_struct));
 
 	p->start_sect = start;
 	p->nr_sects = len;
@@ -276,6 +287,9 @@ void add_partition(struct gendisk *disk,
 	p->kobj.parent = &disk->kobj;
 	p->kobj.ktype = &ktype_part;
 	kobject_register(&p->kobj);
+
+	p->partno = part;
+	disk->part[part-1] = p;
 }
 
 static void disk_sysfs_symlinks(struct gendisk *disk)

--------------Boundary-00=_CYLH8HSRV69DQCSZ646O--

