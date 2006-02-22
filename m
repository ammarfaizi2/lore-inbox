Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWBVQMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWBVQMH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 11:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWBVQMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 11:12:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29399 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932345AbWBVQLz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 11:11:55 -0500
Message-ID: <43FC8D92.6010006@ce.jp.nec.com>
Date: Wed, 22 Feb 2006 11:13:06 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>, Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org,
       device-mapper development <dm-devel@redhat.com>
Subject: [PATCH 2/3] sysfs representation of stacked devices (dm) (rev.2)
References: <43FC8C00.5020600@ce.jp.nec.com>
In-Reply-To: <43FC8C00.5020600@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------020406090002080501030405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020406090002080501030405
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch modifies dm driver to call bd_claim_by_kobject
and bd_release_from_kobject.
To do that, reference to the mapped_device is added in
dm_table.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------020406090002080501030405
Content-Type: text/x-patch;
 name="dm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm.patch"

Exporting stacked device relationship to sysfs (dm)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15/drivers/md/dm.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm.h	2006-02-21 16:49:22.000000000 -0500
@@ -102,6 +102,8 @@ int dm_table_create(struct dm_table **re
 
 void dm_table_get(struct dm_table *t);
 void dm_table_put(struct dm_table *t);
+void dm_table_set_md(struct dm_table *t, struct mapped_device *md);
+struct mapped_device *dm_table_device(struct dm_table *t);
 
 int dm_table_add_target(struct dm_table *t, const char *type,
 			sector_t start,	sector_t len, char *params);
--- linux-2.6.15/drivers/md/dm-ioctl.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm-ioctl.c	2006-02-21 16:51:30.000000000 -0500
@@ -228,6 +228,16 @@ static int dm_hash_insert(const char *na
 	return -EBUSY;
 }
 
+/* called when the populated table is no longer needed */
+static void __release_new_map(struct dm_table *t)
+{
+	struct mapped_device *md = dm_table_device(t);
+
+	dm_table_put(t);
+	if (md)
+		dm_put(md);
+}
+
 static void __hash_remove(struct hash_cell *hc)
 {
 	struct dm_table *table;
@@ -246,7 +256,7 @@ static void __hash_remove(struct hash_ce
 
 	dm_put(hc->md);
 	if (hc->new_map)
-		dm_table_put(hc->new_map);
+		__release_new_map(hc->new_map);
 	free_cell(hc);
 }
 
@@ -719,6 +729,7 @@ static int do_resume(struct dm_ioctl *pa
 	dm_get(md);
 
 	new_map = hc->new_map;
+	dm_put(md); /* drop reference by dm_table_set_md() */
 	hc->new_map = NULL;
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
@@ -963,9 +974,19 @@ static int table_load(struct dm_ioctl *p
 	if (r)
 		return r;
 
+	down_read(&_hash_lock);
+	hc = __find_device_hash_cell(param);
+	if (!hc) {
+		DMWARN("device doesn't appear to be in the dev hash table.");
+		up_read(&_hash_lock);
+		return -ENXIO;
+	}
+	dm_table_set_md(t, hc->md);
+	up_read(&_hash_lock);
+
 	r = populate_table(t, param, param_size);
 	if (r) {
-		dm_table_put(t);
+		__release_new_map(t);
 		return r;
 	}
 
@@ -979,7 +1000,7 @@ static int table_load(struct dm_ioctl *p
 	}
 
 	if (hc->new_map)
-		dm_table_put(hc->new_map);
+		__release_new_map(hc->new_map);
 	hc->new_map = t;
 	param->flags |= DM_INACTIVE_PRESENT_FLAG;
 
@@ -1003,7 +1024,7 @@ static int table_clear(struct dm_ioctl *
 	}
 
 	if (hc->new_map) {
-		dm_table_put(hc->new_map);
+		__release_new_map(hc->new_map);
 		hc->new_map = NULL;
 	}
 
--- linux-2.6.15/drivers/md/dm-table.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm-table.c	2006-02-21 19:11:03.000000000 -0500
@@ -53,6 +53,8 @@ struct dm_table {
 	/* events get handed up using this callback */
 	void (*event_fn)(void *);
 	void *event_context;
+
+	struct mapped_device *md;
 };
 
 /*
@@ -345,7 +347,7 @@ static struct dm_dev *find_device(struct
 /*
  * Open a device so we can use it as a map destination.
  */
-static int open_dev(struct dm_dev *d, dev_t dev)
+static int open_dev(struct dm_dev *d, dev_t dev, struct mapped_device *md)
 {
 	static char *_claim_ptr = "I belong to device-mapper";
 	struct block_device *bdev;
@@ -358,7 +360,7 @@ static int open_dev(struct dm_dev *d, de
 	bdev = open_by_devnum(dev, d->mode);
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
-	r = bd_claim(bdev, _claim_ptr);
+	r = bd_claim_by_kobject(bdev, _claim_ptr, &dm_disk(md)->slave_dir);
 	if (r)
 		blkdev_put(bdev);
 	else
@@ -369,12 +371,12 @@ static int open_dev(struct dm_dev *d, de
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
@@ -395,7 +397,7 @@ static int check_device_area(struct dm_d
  * careful to leave things as they were if we fail to reopen the
  * device.
  */
-static int upgrade_mode(struct dm_dev *dd, int new_mode)
+static int upgrade_mode(struct dm_dev *dd, int new_mode, struct mapped_device *md)
 {
 	int r;
 	struct dm_dev dd_copy;
@@ -405,9 +407,9 @@ static int upgrade_mode(struct dm_dev *d
 
 	dd->mode |= new_mode;
 	dd->bdev = NULL;
-	r = open_dev(dd, dev);
+	r = open_dev(dd, dev, md);
 	if (!r)
-		close_dev(&dd_copy);
+		close_dev(&dd_copy, md);
 	else
 		*dd = dd_copy;
 
@@ -450,7 +452,7 @@ static int __table_get_device(struct dm_
 		dd->mode = mode;
 		dd->bdev = NULL;
 
-		if ((r = open_dev(dd, dev))) {
+		if ((r = open_dev(dd, dev, t->md))) {
 			kfree(dd);
 			return r;
 		}
@@ -461,7 +463,7 @@ static int __table_get_device(struct dm_
 		list_add(&dd->list, &t->devices);
 
 	} else if (dd->mode != (mode | dd->mode)) {
-		r = upgrade_mode(dd, mode);
+		r = upgrade_mode(dd, mode, t->md);
 		if (r)
 			return r;
 	}
@@ -536,7 +538,7 @@ int dm_get_device(struct dm_target *ti, 
 void dm_put_device(struct dm_target *ti, struct dm_dev *dd)
 {
 	if (atomic_dec_and_test(&dd->count)) {
-		close_dev(dd);
+		close_dev(dd, ti->table->md);
 		list_del(&dd->list);
 		kfree(dd);
 	}
@@ -945,6 +947,22 @@ int dm_table_flush_all(struct dm_table *
 	return ret;
 }
 
+void dm_table_set_md(struct dm_table *t, struct mapped_device *md)
+{
+	if (t->md) {
+		dm_put(t->md);
+		t->md = NULL;
+	}
+	if (md) {
+		dm_get(md);
+		t->md = md;
+	}
+}
+struct mapped_device *dm_table_device(struct dm_table *t)
+{
+	return t->md;
+}
+
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);

--------------020406090002080501030405--
