Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263204AbTEMG1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 02:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTEMG1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 02:27:18 -0400
Received: from verein.lst.de ([212.34.181.86]:46341 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263204AbTEMG1P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 02:27:15 -0400
Date: Tue, 13 May 2003 08:39:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC] /proc/devices for block devices
Message-ID: <20030513083959.A20052@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the bdevname changes now in Linus' tree get_blkdev_list, the
routine that generates the block device output for /proc/devices is the
last consumer of the major_names list in drivers/block/genhd.c.  It's
the last left-over from the old-style per-major blockdevice registration
({,un}register_blkdev) and I don't think it's a good idea to keep this
crap around just to generate a list that can't fully describe the block
dev_t allocations anyway.

We could either

 (a) nuke it completly - if you need to find out the dev_t for your
     block driver with dynamic dev_t allocation you can look at
     /proc/partitions (portable to older kernels) or sysfs instead.
 (b) add some cludges to generate a list from the gendisk structures,
     this would mean every gendisk appears in the list so it would
     be a lot longer an contain slightly different names (with the
     gendisk name appended) - OTOH this is still enough for the
     simple string comparisms in the userspace tools I know that
     use it, like the libdisk volume manager detection code.

Personally I'd strongly prefer a.  Attached is a simple patch that
implements (b), the implementation of (a) is left as an exercise
to the reader.


--- 1.84/drivers/block/genhd.c	Sun May  4 10:38:05 2003
+++ edited/drivers/block/genhd.c	Sat May 10 23:03:05 2003
@@ -19,18 +19,14 @@
 static struct subsystem block_subsys;
 
 /*
- * Can be merged with blk_probe or deleted altogether. Later.
- *
- * Modified under both block_subsys.rwsem and major_names_lock.
+ * Will be deleted altogether. Later.
+ * Modified under block_subsys.rwsem.
  */
 static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
-	char name[16];
 } *major_names[MAX_PROBE_HASH];
 
-static spinlock_t major_names_lock = SPIN_LOCK_UNLOCKED;
-
 static struct blk_probe {
 	struct blk_probe *next;
 	dev_t dev;
@@ -52,22 +48,15 @@
 	return major_to_index(MAJOR(dev));
 }
 
-/* get block device names in somewhat random order */
 int get_blkdev_list(char *p)
 {
-	struct blk_major_name *n;
-	int i, len;
-
-	len = sprintf(p, "\nBlock devices:\n");
+	int len = sprintf(p, "\nBlock devices:\n");
+	struct gendisk *disk;
 
 	down_read(&block_subsys.rwsem);
-	for (i = 0; i < ARRAY_SIZE(major_names); i++) {
-		for (n = major_names[i]; n; n = n->next)
-			len += sprintf(p+len, "%3d %s\n",
-				       n->major, n->name);
-	}
+	list_for_each_entry(disk, &block_subsys.kset.list, kobj.entry)
+		len += sprintf(p+len, "%3d %s\n", disk->major, disk->disk_name);
 	up_read(&block_subsys.rwsem);
-
 	return len;
 }
 
@@ -75,7 +64,6 @@
 {
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
-	unsigned long flags;
 
 	down_write(&block_subsys.rwsem);
 
@@ -103,12 +91,9 @@
 	}
 
 	p->major = major;
-	strncpy(p->name, name, sizeof(p->name)-1);
-	p->name[sizeof(p->name)-1] = 0;
 	p->next = 0;
 	index = major_to_index(major);
 
-	spin_lock_irqsave(&major_names_lock, flags);
 	for (n = &major_names[index]; *n; n = &(*n)->next) {
 		if ((*n)->major == major)
 			break;
@@ -117,7 +102,6 @@
 		*n = p;
 	else
 		ret = -EBUSY;
-	spin_unlock_irqrestore(&major_names_lock, flags);
 
 	if (ret < 0) {
 		printk("register_blkdev: cannot get major %d for %s\n",
@@ -135,21 +119,18 @@
 	struct blk_major_name **n;
 	struct blk_major_name *p = NULL;
 	int index = major_to_index(major);
-	unsigned long flags;
 	int ret = 0;
 
 	down_write(&block_subsys.rwsem);
-	spin_lock_irqsave(&major_names_lock, flags);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
-	if (!*n || strcmp((*n)->name, name))
+	if (!*n)
 		ret = -EINVAL;
 	else {
 		p = *n;
 		*n = p->next;
 	}
-	spin_unlock_irqrestore(&major_names_lock, flags);
 	up_write(&block_subsys.rwsem);
 	kfree(p);
 
