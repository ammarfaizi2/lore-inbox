Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265768AbUGMVKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265768AbUGMVKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 17:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265913AbUGMVKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 17:10:16 -0400
Received: from cantor.suse.de ([195.135.220.2]:927 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265768AbUGMVKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 17:10:07 -0400
Date: Tue, 13 Jul 2004 23:07:21 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: Patrick Mansfield <patmans@us.ibm.com>, Jens Axboe <axboe@suse.de>
Subject: [PATCH] add removeable sysfs block device attribute
Message-ID: <20040713210721.GA3399@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a /block/*/removeable sysfs attribute. A value of 1
indicates the media can change anytime. This is a hint for userland
to poll such devices for possible media changes, and leave all others alone.
There is currently no way to see if a connected usb-storage device is a
disk or a card reader. It will also show 1 for CD and ZIP drives.

It was done by Patrick Mansfield a while ago. I can probably not
sigh-off his work. ;)


diff -purN linux-2.6.8-rc1-bk2/drivers/block/genhd.c linux-2.6.8-rc1-bk2.removeable_media/drivers/block/genhd.c
--- linux-2.6.8-rc1-bk2/drivers/block/genhd.c	2004-07-13 20:14:17.326681737 +0000
+++ linux-2.6.8-rc1-bk2.removeable_media/drivers/block/genhd.c	2004-07-13 20:47:52.215560764 +0000
@@ -352,6 +352,12 @@ static ssize_t disk_range_read(struct ge
 {
 	return sprintf(page, "%d\n", disk->minors);
 }
+static ssize_t disk_removable_read(struct gendisk * disk, char *page)
+{
+	return sprintf(page, "%d\n",
+		       (disk->flags & GENHD_FL_REMOVABLE ? 1 : 0));
+
+}
 static ssize_t disk_size_read(struct gendisk * disk, char *page)
 {
 	return sprintf(page, "%llu\n", (unsigned long long)get_capacity(disk));
@@ -384,6 +390,10 @@ static struct disk_attribute disk_attr_r
 	.attr = {.name = "range", .mode = S_IRUGO },
 	.show	= disk_range_read
 };
+static struct disk_attribute disk_attr_removable = {
+	.attr = {.name = "removable", .mode = S_IRUGO },
+	.show	= disk_removable_read
+};
 static struct disk_attribute disk_attr_size = {
 	.attr = {.name = "size", .mode = S_IRUGO },
 	.show	= disk_size_read
@@ -396,6 +406,7 @@ static struct disk_attribute disk_attr_s
 static struct attribute * default_attrs[] = {
 	&disk_attr_dev.attr,
 	&disk_attr_range.attr,
+	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
 	NULL,

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
