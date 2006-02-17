Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWBQSCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWBQSCv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 13:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWBQSCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 13:02:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22161 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750755AbWBQSCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 13:02:50 -0500
Message-ID: <43F6100B.4000001@ce.jp.nec.com>
Date: Fri, 17 Feb 2006 13:03:55 -0500
From: "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>, Alasdair Kergon <agk@redhat.com>,
       Lars Marowsky-Bree <lmb@suse.de>
CC: device-mapper development <dm-devel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] sysfs representation of stacked devices (dm)
References: <43F60F31.1030507@ce.jp.nec.com>
In-Reply-To: <43F60F31.1030507@ce.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------080307080201050907090904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080307080201050907090904
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

This patch modifies dm driver to create symlinks to/from
underlying devices.

-- 
Jun'ichi Nomura, NEC Solutions (America), Inc.

--------------080307080201050907090904
Content-Type: text/x-patch;
 name="stacked-device-representation-in-sysfs-1-dm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stacked-device-representation-in-sysfs-1-dm.patch"

Exporting stacked device relationship to sysfs (dm)

Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>

--- linux-2.6.15.orig/drivers/md/dm.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm.c	2006-02-14 12:18:13.000000000 -0500
@@ -853,6 +853,7 @@ static int __bind(struct mapped_device *
 
 	dm_table_get(t);
 	dm_table_event_callback(t, event_callback, md);
+	dm_link_device(md, t);
 
 	write_lock(&md->map_lock);
 	md->map = t;
@@ -873,6 +874,7 @@ static void __unbind(struct mapped_devic
 	write_lock(&md->map_lock);
 	md->map = NULL;
 	write_unlock(&md->map_lock);
+	dm_unlink_device(md, map);
 	dm_table_put(map);
 }
 
--- linux-2.6.15.orig/drivers/md/dm.h	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm.h	2006-02-14 12:21:10.000000000 -0500
@@ -94,6 +94,12 @@ int dm_wait_event(struct mapped_device *
 struct gendisk *dm_disk(struct mapped_device *md);
 int dm_suspended(struct mapped_device *md);
 
+/*
+ * kobject linking functions
+ */
+int dm_link_device(struct mapped_device *md, struct dm_table *t);
+int dm_unlink_device(struct mapped_device *md, struct dm_table *t);
+
 /*-----------------------------------------------------------------
  * Functions for manipulating a table.  Tables are also reference
  * counted.
--- linux-2.6.15.orig/drivers/md/dm-table.c	2006-01-02 22:21:10.000000000 -0500
+++ linux-2.6.15/drivers/md/dm-table.c	2006-02-16 23:25:49.000000000 -0500
@@ -53,6 +53,9 @@ struct dm_table {
 	/* events get handed up using this callback */
 	void (*event_fn)(void *);
 	void *event_context;
+
+	/* sysfs deptree */
+	struct kobject slave_dir;
 };
 
 /*
@@ -945,6 +948,43 @@ int dm_table_flush_all(struct dm_table *
 	return ret;
 }
 
+/* create sysfs symlinks between mapped device and underlying devices */
+int dm_link_device(struct mapped_device *md, struct dm_table *t)
+{
+	struct list_head *d, *devices;
+	struct kobject *md_kobj;
+
+	md_kobj = &dm_disk(md)->kobj;
+	stackdev_init(&t->slave_dir, md_kobj);
+
+	devices = dm_table_get_devices(t);
+	for (d = devices->next; d != devices; d = d->next) {
+		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
+		stackdev_link(dd->bdev, &t->slave_dir, md_kobj);
+	}
+
+	return 0;
+}
+
+/* remove sysfs symlinks between mapped device and underlying devices */
+int dm_unlink_device(struct mapped_device *md, struct dm_table *t)
+{
+	struct list_head *d, *devices;
+	struct kobject *md_kobj;
+
+	md_kobj = &dm_disk(md)->kobj;
+
+	devices = dm_table_get_devices(t);
+	for (d = devices->next; d != devices; d = d->next) {
+		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
+		stackdev_unlink(dd->bdev, &t->slave_dir, md_kobj);
+	}
+
+	stackdev_clear(&t->slave_dir);
+
+	return 0;
+}
+
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);

--------------080307080201050907090904--
