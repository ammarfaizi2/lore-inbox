Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWBVTbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWBVTbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 14:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbWBVTbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 14:31:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964813AbWBVTbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 14:31:34 -0500
Message-ID: <43FCBC5A.3020204@ce.jp.nec.com>
Date: Wed, 22 Feb 2006 14:32:42 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alasdair G Kergon <agk@redhat.com>
CC: Neil Brown <neilb@suse.de>, Lars Marowsky-Bree <lmb@suse.de>,
       Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>,
       Mike Anderson <andmike@us.ibm.com>
Subject: Re: [PATCH 2/3] sysfs representation of stacked devices (dm) (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com> <43FC8D92.6010006@ce.jp.nec.com> <20060222163438.GC31641@agk.surrey.redhat.com> <43FC9BD4.1010901@ce.jp.nec.com> <20060222181305.GD31641@agk.surrey.redhat.com>
In-Reply-To: <20060222181305.GD31641@agk.surrey.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060901020002040706010108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060901020002040706010108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Alasdair G Kergon wrote:
> The global _hash_lock should not be held (thereby locking out most dm ioctl 
> operations on any device) while the slow populate_table() runs.
> 
> I'm trying out a variant of the patch that drops and reacquires that lock.

OK, thanks for the confirmation.

I guess the variant itself will need dm_get() to avoid md
being stolen. Depending on that, I might change my patch.

Attached is a revised patch based on Mike Anderson's patch.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------060901020002040706010108
Content-Type: text/x-patch;
 name="dm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm.patch"

--- linux-2.6.15/drivers/md/dm-table.c	2006-02-22 11:25:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm-table.c	2006-02-22 11:32:54.000000000 -0500
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
+	r = bd_claim_by_kobject(bdev, _claim_ptr, &dm_disk(md)->slave_dir);
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
+	bd_release_from_kobject(d->bdev, &dm_disk(md)->slave_dir);
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

--------------060901020002040706010108--
