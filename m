Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbUKKSXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbUKKSXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKKSXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:23:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262323AbUKKSV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:21:59 -0500
Date: Thu, 11 Nov 2004 18:21:51 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: [2/2] Allow referencing by device number
Message-ID: <20041111182151.GE8857@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently userspace code using the dm ioctls must refer to a 
mapped device by either its name or its uuid.  But in some 
circumstances you know neither of those directly.

This patch lets you reference devices by their major/minor 
numbers as an alternative.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-ioctl.c	2004-11-10 15:05:36.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2004-11-10 15:05:43.000000000 +0000
@@ -18,7 +18,7 @@
 
 #include <asm/uaccess.h>
 
-#define DM_DRIVER_EMAIL "dm@uk.sistina.com"
+#define DM_DRIVER_EMAIL "dm-devel@redhat.com"
 
 /*-----------------------------------------------------------------
  * The ioctl interface needs to be able to look up devices by
@@ -225,6 +225,7 @@
 	}
 	register_with_devfs(cell);
 	dm_get(md);
+	dm_set_mdptr(md, cell);
 	up_write(&_hash_lock);
 
 	return 0;
@@ -241,6 +242,7 @@
 	list_del(&hc->uuid_list);
 	list_del(&hc->name_list);
 	unregister_with_devfs(hc);
+	dm_set_mdptr(hc->md, NULL);
 	dm_put(hc->md);
 	if (hc->new_map)
 		dm_table_put(hc->new_map);
@@ -580,12 +582,16 @@
 }
 
 /*
- * Always use UUID for lookups if it's present, otherwise use name.
+ * Always use UUID for lookups if it's present, otherwise use name or dev.
  */
 static inline struct hash_cell *__find_device_hash_cell(struct dm_ioctl *param)
 {
-	return *param->uuid ?
-	    __get_uuid_cell(param->uuid) : __get_name_cell(param->name);
+	if (*param->uuid)
+		return __get_uuid_cell(param->uuid);
+	else if (*param->name)
+		return __get_name_cell(param->name);
+	else
+		return dm_get_mdptr(huge_decode_dev(param->dev));
 }
 
 static inline struct mapped_device *find_device(struct dm_ioctl *param)
@@ -597,6 +603,7 @@
 	hc = __find_device_hash_cell(param);
 	if (hc) {
 		md = hc->md;
+		dm_get(md);
 
 		/*
 		 * Sneakily write in both the name and the uuid
@@ -612,8 +619,6 @@
 			param->flags |= DM_INACTIVE_PRESENT_FLAG;
 		else
 			param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
-
-		dm_get(md);
 	}
 	up_read(&_hash_lock);
 
@@ -1266,14 +1271,14 @@
 	    cmd == DM_LIST_VERSIONS_CMD)
 		return 0;
 
-	/* Unless creating, either name or uuid but not both */
-	if (cmd != DM_DEV_CREATE_CMD) {
-		if ((!*param->uuid && !*param->name) ||
-		    (*param->uuid && *param->name)) {
-			DMWARN("one of name or uuid must be supplied, cmd(%u)",
-			       cmd);
+	if ((cmd == DM_DEV_CREATE_CMD)) {
+		if (!*param->name) {
+			DMWARN("name not supplied when creating device");
 			return -EINVAL;
 		}
+	} else if ((*param->uuid && *param->name)) {
+		DMWARN("only supply one of name or uuid, cmd(%u)", cmd);
+		return -EINVAL;
 	}
 
 	/* Ensure strings are terminated */
--- diff/drivers/md/dm.c	2004-11-10 15:05:11.000000000 +0000
+++ source/drivers/md/dm.c	2004-11-10 15:05:43.000000000 +0000
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the GPL.
  */
@@ -59,6 +60,8 @@
 	request_queue_t *queue;
 	struct gendisk *disk;
 
+	void *interface_ptr;
+
 	/*
 	 * A list of ios that arrived while we were suspended.
 	 */
@@ -643,7 +646,7 @@
 /*
  * See if the device with a specific minor # is free.
  */
-static int specific_minor(unsigned int minor)
+static int specific_minor(struct mapped_device *md, unsigned int minor)
 {
 	int r, m;
 
@@ -663,7 +666,7 @@
 		goto out;
 	}
 
-	r = idr_get_new_above(&_minor_idr, specific_minor, minor, &m);
+	r = idr_get_new_above(&_minor_idr, md, minor, &m);
 	if (r) {
 		goto out;
 	}
@@ -679,7 +682,7 @@
 	return r;
 }
 
-static int next_free_minor(unsigned int *minor)
+static int next_free_minor(struct mapped_device *md, unsigned int *minor)
 {
 	int r;
 	unsigned int m;
@@ -692,7 +695,7 @@
 		goto out;
 	}
 
-	r = idr_get_new(&_minor_idr, next_free_minor, &m);
+	r = idr_get_new(&_minor_idr, md, &m);
 	if (r) {
 		goto out;
 	}
@@ -726,7 +729,7 @@
 	}
 
 	/* get a minor number for the dev */
-	r = persistent ? specific_minor(minor) : next_free_minor(&minor);
+	r = persistent ? specific_minor(md, minor) : next_free_minor(md, &minor);
 	if (r < 0)
 		goto bad1;
 
@@ -883,6 +886,32 @@
 	return create_aux(minor, 1, result);
 }
 
+void *dm_get_mdptr(dev_t dev)
+{
+	struct mapped_device *md;
+	void *mdptr = NULL;
+	unsigned minor = MINOR(dev);
+
+	if (MAJOR(dev) != _major || minor >= (1 << MINORBITS))
+		return NULL;
+
+	down(&_minor_lock);
+
+	md = idr_find(&_minor_idr, minor);
+
+	if (md && (dm_disk(md)->first_minor == minor))
+		mdptr = md->interface_ptr;
+
+	up(&_minor_lock);
+
+	return mdptr;
+}
+
+void dm_set_mdptr(struct mapped_device *md, void *ptr)
+{
+	md->interface_ptr = ptr;
+}
+
 void dm_get(struct mapped_device *md)
 {
 	atomic_inc(&md->holders);
@@ -1142,5 +1171,5 @@
 module_param(major, uint, 0);
 MODULE_PARM_DESC(major, "The major number of the device mapper");
 MODULE_DESCRIPTION(DM_NAME " driver");
-MODULE_AUTHOR("Joe Thornber <thornber@sistina.com>");
+MODULE_AUTHOR("Joe Thornber <dm-devel@redhat.com>");
 MODULE_LICENSE("GPL");
--- diff/drivers/md/dm.h	2004-11-10 15:05:36.000000000 +0000
+++ source/drivers/md/dm.h	2004-11-10 15:05:43.000000000 +0000
@@ -55,6 +55,8 @@
  *---------------------------------------------------------------*/
 int dm_create(struct mapped_device **md);
 int dm_create_with_minor(unsigned int minor, struct mapped_device **md);
+void dm_set_mdptr(struct mapped_device *md, void *ptr);
+void *dm_get_mdptr(dev_t dev);
 
 /*
  * Reference counting for md.
--- diff/include/linux/dm-ioctl.h	2004-11-10 15:05:36.000000000 +0000
+++ source/include/linux/dm-ioctl.h	2004-11-10 15:05:43.000000000 +0000
@@ -272,9 +272,9 @@
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	2
+#define DM_VERSION_MINOR	3
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2004-06-08)"
+#define DM_VERSION_EXTRA	"-ioctl (2004-09-30)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
