Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbTEDREp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbTEDREp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 13:04:45 -0400
Received: from verein.lst.de ([212.34.181.86]:27919 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S261232AbTEDREn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 13:04:43 -0400
Date: Sun, 4 May 2003 19:17:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make __bdevname output more similar to bdevname
Message-ID: <20030504191709.D10659@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently __bdevname walks the obsolete list of block majors to
find a name for the given dev_t and falls back to unknown-block(%u,%u)
if that's not possible.  Replace this with an attempted get_gendisk() +
disk_name.  This means __bdevname can't be called from irq context
anymore, but as all old irq context callers are using bdevname() now
that fine (and I've added a big comment).


--- 1.83/drivers/block/genhd.c	Fri Apr 25 18:16:28 2003
+++ edited/drivers/block/genhd.c	Sun May  4 08:38:05 2003
@@ -52,30 +52,6 @@
 	return major_to_index(MAJOR(dev));
 }
 
-/*
- * __bdevname may be called from interrupts, and must be atomic
- */
-const char *__bdevname(dev_t dev, char *buffer)
-{
-	char *name = "unknown-block";
-	unsigned int major = MAJOR(dev);
-	unsigned int minor = MINOR(dev);
-	int index = major_to_index(major);
-	struct blk_major_name *n;
-	unsigned long flags;
-
-	spin_lock_irqsave(&major_names_lock, flags);
-	for (n = major_names[index]; n; n = n->next)
-		if (n->major == major)
-			break;
-	if (n)
-		name = &(n->name[0]);
-	snprintf(buffer, BDEVNAME_SIZE, "%s(%u,%u)", name, major, minor);
-	spin_unlock_irqrestore(&major_names_lock, flags);
-
-	return buffer;
-}
-
 /* get block device names in somewhat random order */
 int get_blkdev_list(char *p)
 {
--- 1.108/fs/partitions/check.c	Tue Apr 29 17:42:50 2003
+++ edited/fs/partitions/check.c	Sun May  4 08:37:43 2003
@@ -125,6 +112,29 @@
 	return disk_name(bdev->bd_disk, part, buf);
 }
 
+/*
+ * NOTE: this cannot be called from interrupt context.
+ *
+ * But in interrupt context you should really have a struct
+ * block_device anyway and use bdevname() above.
+ */
+const char *__bdevname(dev_t dev, char *buffer)
+{
+	struct gendisk *disk;
+	int part;
+
+	disk = get_gendisk(dev, &part);
+	if (disk) {
+		buffer = disk_name(disk, part, buffer);
+		put_disk(disk);
+	} else {
+		snprintf(buffer, BDEVNAME_SIZE, "unknown-block(%u,%u)",
+				MAJOR(dev), MINOR(dev));
+	}
+
+	return buffer;
+}
+
 static struct parsed_partitions *
 check_partition(struct gendisk *hd, struct block_device *bdev)
 {
