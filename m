Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269043AbTBWXzD>; Sun, 23 Feb 2003 18:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269044AbTBWXzD>; Sun, 23 Feb 2003 18:55:03 -0500
Received: from hera.cwi.nl ([192.16.191.8]:7056 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S269043AbTBWXy6>;
	Sun, 23 Feb 2003 18:54:58 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 24 Feb 2003 01:05:03 +0100 (MET)
Message-Id: <UTC200302240005.h1O053x20512.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] remove MAX_BLKDEV from genhd.c
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch for genhd.c:

- removed outdated comments
- removed MAX_BLKDEV

In genhd.c the variable MAX_BLKDEV was only the size of a hash
table, so I made it MAX_PROBE_HASH. It can be 1, or 23, or 256, or
whatever one wants.

Note that the current setup requires that every device number
in a given range is mapped by dev_to_index() to the same index
in the hash table, so this routine will have to be adapted in
case one wants to register multimajor ranges.

Discussion is possible about whether struct blk_probe needs
a dev_t or a kdev_t, but I left things this time.

If a range can end at precisely the end of [k]dev_t space,
the old code was wrong since (p->dev + p->range) would be 0.
That is why "p->dev + p->range <= dev" was replaced by
"p->dev + p->range - 1 < dev".

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	Sat Feb 15 20:41:56 2003
+++ b/drivers/block/genhd.c	Mon Feb 24 00:50:41 2003
@@ -1,17 +1,5 @@
 /*
- *  Code extracted from
- *  linux/kernel/hd.c
- *
- *  Copyright (C) 1991-1998  Linus Torvalds
- *
- *  devfs support - jj, rgooch, 980122
- *
- *  Moved partition checking code to fs/partitions* - Russell King
- *  (linux@arm.uk.linux.org)
- */
-
-/*
- * TODO:  rip out the remaining init crap from this file  --hch
+ *  gendisk handling
  */
 
 #include <linux/config.h>
@@ -29,8 +17,9 @@
 
 static struct subsystem block_subsys;
 
+#define MAX_PROBE_HASH 23	/* random */
 
-struct blk_probe {
+static struct blk_probe {
 	struct blk_probe *next;
 	dev_t dev;
 	unsigned long range;
@@ -38,21 +27,27 @@
 	struct gendisk *(*get)(dev_t dev, int *part, void *data);
 	int (*lock)(dev_t, void *);
 	void *data;
-} *probes[MAX_BLKDEV];
+} *probes[MAX_PROBE_HASH];
 
-/* index in the above */
+/* index in the above - for now: assume no multimajor ranges */
 static inline int dev_to_index(dev_t dev)
 {
-	return MAJOR(dev);
+	return MAJOR(dev) % MAX_PROBE_HASH;
 }
 
+/*
+ * Register device numbers dev..(dev+range-1)
+ * range must be nonzero
+ * The hash chain is sorted on range, so that subranges can override.
+ */
 void blk_register_region(dev_t dev, unsigned long range, struct module *module,
-		    struct gendisk *(*probe)(dev_t, int *, void *),
-		    int (*lock)(dev_t, void *), void *data)
+			 struct gendisk *(*probe)(dev_t, int *, void *),
+			 int (*lock)(dev_t, void *), void *data)
 {
 	int index = dev_to_index(dev);
 	struct blk_probe *p = kmalloc(sizeof(struct blk_probe), GFP_KERNEL);
 	struct blk_probe **s;
+
 	p->owner = module;
 	p->get = probe;
 	p->lock = lock;
@@ -71,6 +66,7 @@
 {
 	int index = dev_to_index(dev);
 	struct blk_probe **s;
+
 	down_write(&block_subsys.rwsem);
 	for (s = &probes[index]; *s; s = &(*s)->next) {
 		struct blk_probe *p = *s;
@@ -94,6 +90,7 @@
 static int exact_lock(dev_t dev, void *data)
 {
 	struct gendisk *p = data;
+
 	if (!get_disk(p))
 		return -1;
 	return 0;
@@ -109,14 +106,14 @@
 void add_disk(struct gendisk *disk)
 {
 	disk->flags |= GENHD_FL_UP;
-	blk_register_region(MKDEV(disk->major, disk->first_minor), disk->minors,
-			NULL, exact_match, exact_lock, disk);
+	blk_register_region(MKDEV(disk->major, disk->first_minor),
+			    disk->minors, NULL, exact_match, exact_lock, disk);
 	register_disk(disk);
 	elv_register_queue(disk);
 }
 
 EXPORT_SYMBOL(add_disk);
-EXPORT_SYMBOL(del_gendisk);
+EXPORT_SYMBOL(del_gendisk);	/* in partitions/check.c */
 
 void unlink_gendisk(struct gendisk *disk)
 {
@@ -146,18 +143,17 @@
 		struct gendisk *(*probe)(dev_t, int *, void *);
 		struct module *owner;
 		void *data;
-		if (p->dev > dev || p->dev + p->range <= dev)
+
+		if (p->dev > dev || p->dev + p->range - 1 < dev)
 			continue;
-		if (p->range >= best) {
-			up_read(&block_subsys.rwsem);
-			return NULL;
-		}
+		if (p->range - 1 >= best)
+			break;
 		if (!try_module_get(p->owner))
 			continue;
 		owner = p->owner;
 		data = p->data;
 		probe = p->get;
-		best = p->range;
+		best = p->range - 1;
 		*part = dev - p->dev;
 		if (p->lock && p->lock(dev, data) < 0) {
 			module_put(owner);
@@ -169,7 +165,7 @@
 		module_put(owner);
 		if (disk)
 			return disk;
-		goto retry;
+		goto retry;		/* this terminates: best decreases */
 	}
 	up_read(&block_subsys.rwsem);
 	return NULL;
@@ -245,7 +241,7 @@
 
 static struct gendisk *base_probe(dev_t dev, int *part, void *data)
 {
-	char name[20];
+	char name[30];
 	sprintf(name, "block-major-%d", MAJOR(dev));
 	request_module(name);
 	return NULL;
@@ -256,11 +252,11 @@
 	struct blk_probe *base = kmalloc(sizeof(struct blk_probe), GFP_KERNEL);
 	int i;
 	memset(base, 0, sizeof(struct blk_probe));
-	base->dev = MKDEV(1,0);
-	base->range = MKDEV(MAX_BLKDEV-1, 255) - base->dev + 1;
+	base->dev = 1;
+	base->range = ~0;		/* range 1 .. ~0 */
 	base->get = base_probe;
-	for (i = 1; i < MAX_BLKDEV; i++)
-		probes[i] = base;
+	for (i = 0; i < MAX_PROBE_HASH; i++)
+		probes[i] = base;	/* must remain last in chain */
 	blk_dev_init();
 	subsystem_register(&block_subsys);
 	return 0;
@@ -281,12 +277,14 @@
 	ssize_t (*show)(struct gendisk *, char *);
 };
 
-static ssize_t disk_attr_show(struct kobject * kobj, struct attribute * attr,
-			      char * page)
+static ssize_t disk_attr_show(struct kobject *kobj, struct attribute *attr,
+			      char *page)
 {
-	struct gendisk * disk = to_disk(kobj);
-	struct disk_attribute * disk_attr = container_of(attr,struct disk_attribute,attr);
+	struct gendisk *disk = to_disk(kobj);
+	struct disk_attribute *disk_attr =
+		container_of(attr,struct disk_attribute,attr);
 	ssize_t ret = 0;
+
 	if (disk_attr->show)
 		ret = disk_attr->show(disk,page);
 	return ret;
@@ -303,11 +301,11 @@
 }
 static ssize_t disk_range_read(struct gendisk * disk, char *page)
 {
-	return sprintf(page, "%d\n",disk->minors);
+	return sprintf(page, "%d\n", disk->minors);
 }
 static ssize_t disk_size_read(struct gendisk * disk, char *page)
 {
-	return sprintf(page, "%llu\n",(unsigned long long)get_capacity(disk));
+	return sprintf(page, "%llu\n", (unsigned long long)get_capacity(disk));
 }
 
 static inline unsigned jiffies_to_msec(unsigned jif)
