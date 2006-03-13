Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWCMWPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWCMWPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWCMWPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:15:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29640 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932507AbWCMWPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:15:30 -0500
Message-ID: <4415EF62.2060209@ce.jp.nec.com>
Date: Mon, 13 Mar 2006 17:17:06 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Alasdair Kergon <agk@redhat.com>,
       Greg KH <gregkh@suse.de>, Neil Brown <neilb@suse.de>
CC: Lars Marowsky-Bree <lmb@suse.de>,
       device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dm/md dependency tree in sysfs: dm to use bd_claim_by_disk
References: <4415EC4B.4010003@ce.jp.nec.com>
In-Reply-To: <4415EC4B.4010003@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------010507000103060302070401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010507000103060302070401
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch is part of dm/md dependency tree in sysfs.

Following symlinks are created if dm-0 maps to sda:
  /sys/block/dm-0/slaves/sda --> /sys/block/sda
  /sys/block/sda/holders/dm-0 --> /sys/block/dm-0

This patch depends on the following patches in mm tree:
  dm-tidy-mdptr.patch
  dm-table-store-md.patch

Thanks,
-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------010507000103060302070401
Content-Type: text/x-patch;
 name="06-dm_deptree.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="06-dm_deptree.patch"

Use bd_claim_by_disk.

Following symlinks are created if dm-0 maps to sda:
  /sys/block/dm-0/slaves/sda --> /sys/block/sda
  /sys/block/sda/holders/dm-0 --> /sys/block/dm-0

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

 drivers/md/dm-table.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2.6.16-rc6.orig/drivers/md/dm-table.c	2006-03-13 11:20:09.000000000 -0500
+++ linux-2.6.16-rc6/drivers/md/dm-table.c	2006-03-13 14:19:28.000000000 -0500
@@ -348,7 +348,7 @@ static struct dm_dev *find_device(struct
 /*
  * Open a device so we can use it as a map destination.
  */
-static int open_dev(struct dm_dev *d, dev_t dev)
+static int open_dev(struct dm_dev *d, dev_t dev, struct mapped_device *md)
 {
 	static char *_claim_ptr = "I belong to device-mapper";
 	struct block_device *bdev;
@@ -361,7 +361,7 @@ static int open_dev(struct dm_dev *d, de
 	bdev = open_by_devnum(dev, d->mode);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
-	r = bd_claim(bdev, _claim_ptr);
+	r = bd_claim_by_disk(bdev, _claim_ptr, dm_disk(md));
 	if (r)
 		blkdev_put(bdev);
 	else
@@ -372,12 +372,12 @@ static int open_dev(struct dm_dev *d, de
 /*
  * Close a device that we've been using.
  */
-static void close_dev(struct dm_dev *d)
+static void close_dev(struct dm_dev *d, struct mapped_device *md)
 {
 	if (!d->bdev)
 		return;
 
-	bd_release(d->bdev);
+	bd_release_from_disk(d->bdev, dm_disk(md));
 	blkdev_put(d->bdev);
 	d->bdev = NULL;
 }
@@ -398,7 +398,7 @@ static int check_device_area(struct dm_d
  * careful to leave things as they were if we fail to reopen the
  * device.
  */
-static int upgrade_mode(struct dm_dev *dd, int new_mode)
+static int upgrade_mode(struct dm_dev *dd, int new_mode, struct mapped_device *md)
 {
 	int r;
 	struct dm_dev dd_copy;
@@ -408,9 +408,9 @@ static int upgrade_mode(struct dm_dev *d
 
 	dd->mode |= new_mode;
 	dd->bdev = NULL;
-	r = open_dev(dd, dev);
+	r = open_dev(dd, dev, md);
 	if (!r)
-		close_dev(&dd_copy);
+		close_dev(&dd_copy, md);
 	else
 		*dd = dd_copy;
 
@@ -453,7 +453,7 @@ static int __table_get_device(struct dm_
 		dd->mode = mode;
 		dd->bdev = NULL;
 
-		if ((r = open_dev(dd, dev))) {
+		if ((r = open_dev(dd, dev, t->md))) {
 			kfree(dd);
 			return r;
 		}
@@ -464,7 +464,7 @@ static int __table_get_device(struct dm_
 		list_add(&dd->list, &t->devices);
 
 	} else if (dd->mode != (mode | dd->mode)) {
-		r = upgrade_mode(dd, mode);
+		r = upgrade_mode(dd, mode, t->md);
 		if (r)
 			return r;
 	}
@@ -539,7 +539,7 @@ int dm_get_device(struct dm_target *ti, 
 void dm_put_device(struct dm_target *ti, struct dm_dev *dd)
 {
 	if (atomic_dec_and_test(&dd->count)) {
-		close_dev(dd);
+		close_dev(dd, ti->table->md);
 		list_del(&dd->list);
 		kfree(dd);
 	}

--------------010507000103060302070401--
