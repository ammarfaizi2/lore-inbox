Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266031AbUGOAej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266031AbUGOAej (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266025AbUGOAeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:34:36 -0400
Received: from mail.kroah.org ([69.55.234.183]:42112 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266072AbUGOAUJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:09 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <10898507032467@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:24 -0700
Message-Id: <1089850704407@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1784.12.8, 2004/07/14 16:20:29-07:00, olh@suse.de

[PATCH] add removeable sysfs block device attribute

This patch adds a /block/*/removeable sysfs attribute. A value of 1
indicates the media can change anytime. This is a hint for userland
to poll such devices for possible media changes, and leave all others alone.
There is currently no way to see if a connected usb-storage device is a
disk or a card reader. It will also show 1 for CD and ZIP drives.

It was done by Patrick Mansfield a while ago. I can probably not
sigh-off his work. ;)


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/block/genhd.c |   11 +++++++++++
 1 files changed, 11 insertions(+)


diff -Nru a/drivers/block/genhd.c b/drivers/block/genhd.c
--- a/drivers/block/genhd.c	2004-07-14 17:10:38 -07:00
+++ b/drivers/block/genhd.c	2004-07-14 17:10:38 -07:00
@@ -352,6 +352,12 @@
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
@@ -384,6 +390,10 @@
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
@@ -396,6 +406,7 @@
 static struct attribute * default_attrs[] = {
 	&disk_attr_dev.attr,
 	&disk_attr_range.attr,
+	&disk_attr_removable.attr,
 	&disk_attr_size.attr,
 	&disk_attr_stat.attr,
 	NULL,

