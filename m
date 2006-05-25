Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWEYTR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWEYTR5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 15:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWEYTR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 15:17:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59532 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030359AbWEYTR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 15:17:56 -0400
Date: Thu, 25 May 2006 20:17:52 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 7/10] dm: fix mapped device ref counting
Message-ID: <20060525191752.GY4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Mahoney <jeffm@suse.com>

To avoid races, _minor_lock must be held while changing mapped device
reference counts.

There are a few paths where a mapped_device pointer is returned before
a reference is taken.  This patch fixes them.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17-rc4/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/md/dm-ioctl.c	2006-05-23 17:05:30.000000000 +0100
+++ linux-2.6.17-rc4/drivers/md/dm-ioctl.c	2006-05-23 18:48:33.000000000 +0100
@@ -102,8 +102,10 @@ static struct hash_cell *__get_name_cell
 	unsigned int h = hash_str(str);
 
 	list_for_each_entry (hc, _name_buckets + h, name_list)
-		if (!strcmp(hc->name, str))
+		if (!strcmp(hc->name, str)) {
+			dm_get(hc->md);
 			return hc;
+		}
 
 	return NULL;
 }
@@ -114,8 +116,10 @@ static struct hash_cell *__get_uuid_cell
 	unsigned int h = hash_str(str);
 
 	list_for_each_entry (hc, _uuid_buckets + h, uuid_list)
-		if (!strcmp(hc->uuid, str))
+		if (!strcmp(hc->uuid, str)) {
+			dm_get(hc->md);
 			return hc;
+		}
 
 	return NULL;
 }
@@ -191,7 +195,7 @@ static int unregister_with_devfs(struct 
  */
 static int dm_hash_insert(const char *name, const char *uuid, struct mapped_device *md)
 {
-	struct hash_cell *cell;
+	struct hash_cell *cell, *hc;
 
 	/*
 	 * Allocate the new cells.
@@ -204,14 +208,19 @@ static int dm_hash_insert(const char *na
 	 * Insert the cell into both hash tables.
 	 */
 	down_write(&_hash_lock);
-	if (__get_name_cell(name))
+	hc = __get_name_cell(name);
+	if (hc) {
+		dm_put(hc->md);
 		goto bad;
+	}
 
 	list_add(&cell->name_list, _name_buckets + hash_str(name));
 
 	if (uuid) {
-		if (__get_uuid_cell(uuid)) {
+		hc = __get_uuid_cell(uuid);
+		if (hc) {
 			list_del(&cell->name_list);
+			dm_put(hc->md);
 			goto bad;
 		}
 		list_add(&cell->uuid_list, _uuid_buckets + hash_str(uuid));
@@ -289,6 +298,7 @@ static int dm_hash_rename(const char *ol
 	if (hc) {
 		DMWARN("asked to rename to an already existing name %s -> %s",
 		       old, new);
+		dm_put(hc->md);
 		up_write(&_hash_lock);
 		kfree(new_name);
 		return -EBUSY;
@@ -328,6 +338,7 @@ static int dm_hash_rename(const char *ol
 		dm_table_put(table);
 	}
 
+	dm_put(hc->md);
 	up_write(&_hash_lock);
 	kfree(old_name);
 	return 0;
@@ -611,10 +622,8 @@ static struct hash_cell *__find_device_h
 		return __get_name_cell(param->name);
 
 	md = dm_get_md(huge_decode_dev(param->dev));
-	if (md) {
+	if (md)
 		mdptr = dm_get_mdptr(md);
-		dm_put(md);
-	}
 
 	return mdptr;
 }
@@ -628,7 +637,6 @@ static struct mapped_device *find_device
 	hc = __find_device_hash_cell(param);
 	if (hc) {
 		md = hc->md;
-		dm_get(md);
 
 		/*
 		 * Sneakily write in both the name and the uuid
@@ -653,6 +661,7 @@ static struct mapped_device *find_device
 static int dev_remove(struct dm_ioctl *param, size_t param_size)
 {
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 	hc = __find_device_hash_cell(param);
@@ -663,8 +672,11 @@ static int dev_remove(struct dm_ioctl *p
 		return -ENXIO;
 	}
 
+	md = hc->md;
+
 	__hash_remove(hc);
 	up_write(&_hash_lock);
+	dm_put(md);
 	param->data_size = 0;
 	return 0;
 }
@@ -790,7 +802,6 @@ static int do_resume(struct dm_ioctl *pa
 	}
 
 	md = hc->md;
-	dm_get(md);
 
 	new_map = hc->new_map;
 	hc->new_map = NULL;
@@ -1078,6 +1089,7 @@ static int table_clear(struct dm_ioctl *
 {
 	int r;
 	struct hash_cell *hc;
+	struct mapped_device *md;
 
 	down_write(&_hash_lock);
 
@@ -1096,7 +1108,9 @@ static int table_clear(struct dm_ioctl *
 	param->flags &= ~DM_INACTIVE_PRESENT_FLAG;
 
 	r = __dev_status(hc->md, param);
+	md = hc->md;
 	up_write(&_hash_lock);
+	dm_put(md);
 	return r;
 }
 
