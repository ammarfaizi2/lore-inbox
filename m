Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTDYWkn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTDYWkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 18:40:43 -0400
Received: from verein.lst.de ([212.34.181.86]:18 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S264535AbTDYWki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 18:40:38 -0400
Date: Sat, 26 Apr 2003 00:52:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] a better bdevname
Message-ID: <20030426005246.A11834@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the recent devfs surgery disk_name has become useable
in all contexts (it doesn't do anything but copying a string anymore),
so we can use it in all contexts.

Switch over bdevname to use it instead of going through the major
list.


--- 1.106/fs/partitions/check.c	Sun Apr 20 17:52:10 2003
+++ edited/fs/partitions/check.c	Fri Apr 25 22:32:45 2003
@@ -118,6 +118,12 @@
 	return buf;
 }
 
+const char *bdevname(struct block_device *bdev, char *buf)
+{
+	int part = MINOR(bdev->bd_dev) - bdev->bd_disk->first_minor;
+	return disk_name(bdev->bd_disk, part, buf);
+}
+
 static struct parsed_partitions *
 check_partition(struct gendisk *hd, struct block_device *bdev)
 {
--- 1.233/include/linux/fs.h	Thu Apr 24 06:30:41 2003
+++ edited/include/linux/fs.h	Fri Apr 25 22:29:53 2003
@@ -1067,10 +1067,7 @@
 /* fs/block_dev.c */
 #define BDEVNAME_SIZE	32	/* Largest string for a blockdev identifier */
 extern const char *__bdevname(dev_t, char *buffer);
-extern inline const char *bdevname(struct block_device *bdev, char *buffer)
-{
-	return __bdevname(bdev->bd_dev, buffer);
-}
+extern const char *bdevname(struct block_device *bdev, char *buffer);
 extern struct block_device *lookup_bdev(const char *);
 extern struct block_device *open_bdev_excl(const char *, int, int, void *);
 extern void close_bdev_excl(struct block_device *, int);
--- 1.190/kernel/ksyms.c	Thu Apr 24 06:30:41 2003
+++ edited/kernel/ksyms.c	Fri Apr 25 22:32:56 2003
@@ -512,6 +512,7 @@
 EXPORT_SYMBOL(vsnprintf);
 EXPORT_SYMBOL(vsscanf);
 EXPORT_SYMBOL(__bdevname);
+EXPORT_SYMBOL(bdevname);
 EXPORT_SYMBOL(cdevname);
 EXPORT_SYMBOL(simple_strtoull);
 EXPORT_SYMBOL(simple_strtoul);
