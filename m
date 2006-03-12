Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWCLWuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWCLWuc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbWCLWuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:50:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:24240 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751409AbWCLWub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:50:31 -0500
Date: Sun, 12 Mar 2006 22:50:14 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] dm table: store md
Message-ID: <20060312225014.GH4724@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Anderson <andmike@us.ibm.com>

Store an up-pointer to the owning struct mapped_device in every table 
when it is created.

Access it with:
  struct mapped_device *dm_table_get_md(struct dm_table *t)

Tables linked to md must be destroyed before the md itself.

Signed-off-by: Mike Anderson <andmike@us.ibm.com>
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc5/drivers/md/dm.h
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm.h	2006-03-12 18:15:24.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm.h	2006-03-12 18:16:00.000000000 +0000
@@ -89,7 +89,8 @@ int dm_suspended(struct mapped_device *m
  * Functions for manipulating a table.  Tables are also reference
  * counted.
  *---------------------------------------------------------------*/
-int dm_table_create(struct dm_table **result, int mode, unsigned num_targets);
+int dm_table_create(struct dm_table **result, int mode,
+		    unsigned num_targets, struct mapped_device *md);
 
 void dm_table_get(struct dm_table *t);
 void dm_table_put(struct dm_table *t);
@@ -107,6 +108,7 @@ void dm_table_set_restrictions(struct dm
 unsigned int dm_table_get_num_targets(struct dm_table *t);
 struct list_head *dm_table_get_devices(struct dm_table *t);
 int dm_table_get_mode(struct dm_table *t);
+struct mapped_device *dm_table_get_md(struct dm_table *t);
 void dm_table_presuspend_targets(struct dm_table *t);
 void dm_table_postsuspend_targets(struct dm_table *t);
 void dm_table_resume_targets(struct dm_table *t);
Index: linux-2.6.16-rc5/drivers/md/dm-table.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm-table.c	2006-03-12 17:54:56.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm-table.c	2006-03-12 18:16:00.000000000 +0000
@@ -22,6 +22,7 @@
 #define CHILDREN_PER_NODE (KEYS_PER_NODE + 1)
 
 struct dm_table {
+	struct mapped_device *md;
 	atomic_t holders;
 
 	/* btree table */
@@ -206,7 +207,8 @@ static int alloc_targets(struct dm_table
 	return 0;
 }
 
-int dm_table_create(struct dm_table **result, int mode, unsigned num_targets)
+int dm_table_create(struct dm_table **result, int mode,
+		    unsigned num_targets, struct mapped_device *md)
 {
 	struct dm_table *t = kmalloc(sizeof(*t), GFP_KERNEL);
 
@@ -229,6 +231,7 @@ int dm_table_create(struct dm_table **re
 	}
 
 	t->mode = mode;
+	t->md = md;
 	*result = t;
 	return 0;
 }
@@ -954,12 +957,20 @@ int dm_table_flush_all(struct dm_table *
 	return ret;
 }
 
+struct mapped_device *dm_table_get_md(struct dm_table *t)
+{
+	dm_get(t->md);
+
+	return t->md;
+}
+
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
 EXPORT_SYMBOL(dm_table_event);
 EXPORT_SYMBOL(dm_table_get_size);
 EXPORT_SYMBOL(dm_table_get_mode);
+EXPORT_SYMBOL(dm_table_get_md);
 EXPORT_SYMBOL(dm_table_put);
 EXPORT_SYMBOL(dm_table_get);
 EXPORT_SYMBOL(dm_table_unplug_all);
Index: linux-2.6.16-rc5/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm-ioctl.c	2006-03-12 18:15:24.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm-ioctl.c	2006-03-12 18:16:00.000000000 +0000
@@ -244,9 +244,9 @@ static void __hash_remove(struct hash_ce
 		dm_table_put(table);
 	}
 
-	dm_put(hc->md);
 	if (hc->new_map)
 		dm_table_put(hc->new_map);
+	dm_put(hc->md);
 	free_cell(hc);
 }
 
@@ -985,33 +985,43 @@ static int table_load(struct dm_ioctl *p
 	int r;
 	struct hash_cell *hc;
 	struct dm_table *t;
+	struct mapped_device *md;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
 
-	r = dm_table_create(&t, get_mode(param), param->target_count);
+	r = dm_table_create(&t, get_mode(param), param->target_count, md);
 	if (r)
-		return r;
+		goto out;
 
 	r = populate_table(t, param, param_size);
 	if (r) {
 		dm_table_put(t);
-		return r;
+		goto out;
 	}
 
 	down_write(&_hash_lock);
-	hc = __find_device_hash_cell(param);
-	if (!hc) {
-		DMWARN("device doesn't appear to be in the dev hash table.");
-		up_write(&_hash_lock);
+	hc = dm_get_mdptr(md);
+	if (!hc || hc->md != md) {
+		DMWARN("device has been removed from the dev hash table.");
 		dm_table_put(t);
-		return -ENXIO;
+		up_write(&_hash_lock);
+		r = -ENXIO;
+		goto out;
 	}
 
 	if (hc->new_map)
 		dm_table_put(hc->new_map);
 	hc->new_map = t;
+	up_write(&_hash_lock);
+
 	param->flags |= DM_INACTIVE_PRESENT_FLAG;
+	r = __dev_status(md, param);
+
+out:
+	dm_put(md);
 
-	r = __dev_status(hc->md, param);
-	up_write(&_hash_lock);
 	return r;
 }
 
Index: linux-2.6.16-rc5/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc5.orig/drivers/md/dm.c	2006-03-12 18:15:24.000000000 +0000
+++ linux-2.6.16-rc5/drivers/md/dm.c	2006-03-12 18:16:00.000000000 +0000
@@ -993,18 +993,18 @@ void dm_get(struct mapped_device *md)
 
 void dm_put(struct mapped_device *md)
 {
-	struct dm_table *map = dm_get_table(md);
+	struct dm_table *map;
 
 	if (atomic_dec_and_test(&md->holders)) {
+		map = dm_get_table(md);
 		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
 			dm_table_postsuspend_targets(map);
 		}
 		__unbind(md);
+		dm_table_put(map);
 		free_dev(md);
 	}
-
-	dm_table_put(map);
 }
 
 /*
