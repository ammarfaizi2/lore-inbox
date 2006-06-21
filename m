Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932711AbWFUThy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbWFUThy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:37:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbWFUThf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:37:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22694 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932706AbWFUThD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:37:03 -0400
Date: Wed, 21 Jun 2006 20:36:57 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 12/15] dm: add exports
Message-ID: <20060621193657.GA4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Export core device-mapper functions for manipulating mapped devices
and their tables and move them to <linux/device-mapper.h>.

Protect the contents of device-mapper.h with ifdef __KERNEL__ FWIW,
and throw in a few formatting clean-ups and extra comments.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.c	2006-06-21 18:32:21.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.c	2006-06-21 18:32:25.000000000 +0100
@@ -51,10 +51,11 @@ struct target_io {
 
 union map_info *dm_get_mapinfo(struct bio *bio)
 {
-        if (bio && bio->bi_private)
-                return &((struct target_io *)bio->bi_private)->info;
-        return NULL;
+	if (bio && bio->bi_private)
+		return &((struct target_io *)bio->bi_private)->info;
+	return NULL;
 }
+EXPORT_SYMBOL_GPL(dm_get_mapinfo);
 
 #define MINOR_ALLOCED ((void *)-1)
 
@@ -382,6 +383,7 @@ struct dm_table *dm_get_table(struct map
 
 	return t;
 }
+EXPORT_SYMBOL_GPL(dm_get_table);
 
 /*
  * Get the geometry associated with a dm device
@@ -392,6 +394,7 @@ int dm_get_geometry(struct mapped_device
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dm_get_geometry);
 
 /*
  * Set the geometry of a device.
@@ -409,6 +412,7 @@ int dm_set_geometry(struct mapped_device
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dm_set_geometry);
 
 /*-----------------------------------------------------------------
  * CRUD START:
@@ -514,8 +518,8 @@ static void __map_bio(struct dm_target *
 	if (r > 0) {
 		/* the bio has been remapped so dispatch it */
 
-		blk_add_trace_remap(bdev_get_queue(clone->bi_bdev), clone, 
-				    tio->io->bio->bi_bdev->bd_dev, sector, 
+		blk_add_trace_remap(bdev_get_queue(clone->bi_bdev), clone,
+				    tio->io->bio->bi_bdev->bd_dev, sector,
 				    clone->bi_sector);
 
 		generic_make_request(clone);
@@ -1068,6 +1072,7 @@ int dm_create(int minor, struct mapped_d
 	*result = md;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dm_create);
 
 static struct mapped_device *dm_find_md(dev_t dev)
 {
@@ -1082,7 +1087,7 @@ static struct mapped_device *dm_find_md(
 	md = idr_find(&_minor_idr, minor);
 	if (md && (md == MINOR_ALLOCED ||
 		   (dm_disk(md)->first_minor != minor) ||
-	           test_bit(DMF_FREEING, &md->flags))) {
+		   test_bit(DMF_FREEING, &md->flags))) {
 		md = NULL;
 		goto out;
 	}
@@ -1102,16 +1107,19 @@ struct mapped_device *dm_get_md(dev_t de
 
 	return md;
 }
+EXPORT_SYMBOL_GPL(dm_get_md);
 
 void *dm_get_mdptr(struct mapped_device *md)
 {
 	return md->interface_ptr;
 }
+EXPORT_SYMBOL_GPL(dm_get_mdptr);
 
 void dm_set_mdptr(struct mapped_device *md, void *ptr)
 {
 	md->interface_ptr = ptr;
 }
+EXPORT_SYMBOL_GPL(dm_set_mdptr);
 
 void dm_get(struct mapped_device *md)
 {
@@ -1138,6 +1146,7 @@ void dm_put(struct mapped_device *md)
 		free_dev(md);
 	}
 }
+EXPORT_SYMBOL_GPL(dm_put);
 
 /*
  * Process the deferred bios
@@ -1174,6 +1183,7 @@ out:
 	up(&md->suspend_lock);
 	return r;
 }
+EXPORT_SYMBOL_GPL(dm_swap_table);
 
 /*
  * Functions to lock and unlock any filesystem running on the
@@ -1306,6 +1316,7 @@ out:
 	up(&md->suspend_lock);
 	return r;
 }
+EXPORT_SYMBOL_GPL(dm_suspend);
 
 int dm_resume(struct mapped_device *md)
 {
@@ -1347,6 +1358,7 @@ out:
 
 	return r;
 }
+EXPORT_SYMBOL_GPL(dm_resume);
 
 /*-----------------------------------------------------------------
  * Event notification.
@@ -1355,12 +1367,14 @@ uint32_t dm_get_event_nr(struct mapped_d
 {
 	return atomic_read(&md->event_nr);
 }
+EXPORT_SYMBOL_GPL(dm_get_event_nr);
 
 int dm_wait_event(struct mapped_device *md, int event_nr)
 {
 	return wait_event_interruptible(md->eventq,
 			(event_nr != atomic_read(&md->event_nr)));
 }
+EXPORT_SYMBOL_GPL(dm_wait_event);
 
 /*
  * The gendisk is only valid as long as you have a reference
@@ -1370,11 +1384,13 @@ struct gendisk *dm_disk(struct mapped_de
 {
 	return md->disk;
 }
+EXPORT_SYMBOL_GPL(dm_disk);
 
 int dm_suspended(struct mapped_device *md)
 {
 	return test_bit(DMF_SUSPENDED, &md->flags);
 }
+EXPORT_SYMBOL_GPL(dm_suspended);
 
 static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
@@ -1384,8 +1400,6 @@ static struct block_device_operations dm
 	.owner = THIS_MODULE
 };
 
-EXPORT_SYMBOL(dm_get_mapinfo);
-
 /*
  * module hooks
  */
Index: linux-2.6.17/include/linux/device-mapper.h
===================================================================
--- linux-2.6.17.orig/include/linux/device-mapper.h	2006-06-21 17:45:05.000000000 +0100
+++ linux-2.6.17/include/linux/device-mapper.h	2006-06-21 18:32:25.000000000 +0100
@@ -8,9 +8,12 @@
 #ifndef _LINUX_DEVICE_MAPPER_H
 #define _LINUX_DEVICE_MAPPER_H
 
+#ifdef __KERNEL__
+
 struct dm_target;
 struct dm_table;
 struct dm_dev;
+struct mapped_device;
 
 typedef enum { STATUSTYPE_INFO, STATUSTYPE_TABLE } status_type_t;
 
@@ -82,7 +85,7 @@ void dm_put_device(struct dm_target *ti,
 struct target_type {
 	const char *name;
 	struct module *module;
-        unsigned version[3];
+	unsigned version[3];
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
@@ -133,4 +136,101 @@ struct dm_target {
 int dm_register_target(struct target_type *t);
 int dm_unregister_target(struct target_type *t);
 
-#endif				/* _LINUX_DEVICE_MAPPER_H */
+
+/*-----------------------------------------------------------------
+ * Functions for creating and manipulating mapped devices.
+ * Drop the reference with dm_put when you finish with the object.
+ *---------------------------------------------------------------*/
+
+/*
+ * DM_ANY_MINOR chooses the next available minor number.
+ */
+#define DM_ANY_MINOR (-1)
+int dm_create(int minor, struct mapped_device **md);
+
+/*
+ * Reference counting for md.
+ */
+struct mapped_device *dm_get_md(dev_t dev);
+void dm_get(struct mapped_device *md);
+void dm_put(struct mapped_device *md);
+
+/*
+ * An arbitrary pointer may be stored alongside a mapped device.
+ */
+void dm_set_mdptr(struct mapped_device *md, void *ptr);
+void *dm_get_mdptr(struct mapped_device *md);
+
+/*
+ * A device can still be used while suspended, but I/O is deferred.
+ */
+int dm_suspend(struct mapped_device *md, int with_lockfs);
+int dm_resume(struct mapped_device *md);
+
+/*
+ * Event functions.
+ */
+uint32_t dm_get_event_nr(struct mapped_device *md);
+int dm_wait_event(struct mapped_device *md, int event_nr);
+
+/*
+ * Info functions.
+ */
+struct gendisk *dm_disk(struct mapped_device *md);
+int dm_suspended(struct mapped_device *md);
+
+/*
+ * Geometry functions.
+ */
+int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
+int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
+
+
+/*-----------------------------------------------------------------
+ * Functions for manipulating device-mapper tables.
+ *---------------------------------------------------------------*/
+
+/*
+ * First create an empty table.
+ */
+int dm_table_create(struct dm_table **result, int mode,
+		    unsigned num_targets, struct mapped_device *md);
+
+/*
+ * Then call this once for each target.
+ */
+int dm_table_add_target(struct dm_table *t, const char *type,
+			sector_t start, sector_t len, char *params);
+
+/*
+ * Finally call this to make the table ready for use.
+ */
+int dm_table_complete(struct dm_table *t);
+
+/*
+ * Table reference counting.
+ */
+struct dm_table *dm_get_table(struct mapped_device *md);
+void dm_table_get(struct dm_table *t);
+void dm_table_put(struct dm_table *t);
+
+/*
+ * Queries
+ */
+sector_t dm_table_get_size(struct dm_table *t);
+unsigned int dm_table_get_num_targets(struct dm_table *t);
+int dm_table_get_mode(struct dm_table *t);
+struct mapped_device *dm_table_get_md(struct dm_table *t);
+
+/*
+ * Trigger an event.
+ */
+void dm_table_event(struct dm_table *t);
+
+/*
+ * The device must be suspended before calling this method.
+ */
+int dm_swap_table(struct mapped_device *md, struct dm_table *t);
+
+#endif	/* __KERNEL__ */
+#endif	/* _LINUX_DEVICE_MAPPER_H */
Index: linux-2.6.17/drivers/md/dm.h
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.h	2006-06-21 18:32:21.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.h	2006-06-21 18:32:25.000000000 +0100
@@ -39,88 +39,16 @@ struct dm_dev {
 };
 
 struct dm_table;
-struct mapped_device;
 
 /*-----------------------------------------------------------------
- * Functions for manipulating a struct mapped_device.
- * Drop the reference with dm_put when you finish with the object.
+ * Internal table functions.
  *---------------------------------------------------------------*/
-
-/*
- * DM_ANY_MINOR allocates any available minor number.
- */
-#define DM_ANY_MINOR (-1)
-int dm_create(int minor, struct mapped_device **md);
-
-void dm_set_mdptr(struct mapped_device *md, void *ptr);
-void *dm_get_mdptr(struct mapped_device *md);
-
-/*
- * Reference counting for md.
- */
-void dm_get(struct mapped_device *md);
-struct mapped_device *dm_get_md(dev_t dev);
-void dm_put(struct mapped_device *md);
-
-/*
- * A device can still be used while suspended, but I/O is deferred.
- */
-int dm_suspend(struct mapped_device *md, int with_lockfs);
-int dm_resume(struct mapped_device *md);
-
-/*
- * The device must be suspended before calling this method.
- */
-int dm_swap_table(struct mapped_device *md, struct dm_table *t);
-
-/*
- * Drop a reference on the table when you've finished with the
- * result.
- */
-struct dm_table *dm_get_table(struct mapped_device *md);
-
-/*
- * Event functions.
- */
-uint32_t dm_get_event_nr(struct mapped_device *md);
-int dm_wait_event(struct mapped_device *md, int event_nr);
-
-/*
- * Info functions.
- */
-struct gendisk *dm_disk(struct mapped_device *md);
-int dm_suspended(struct mapped_device *md);
-
-/*
- * Geometry functions.
- */
-int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
-int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
-
-/*-----------------------------------------------------------------
- * Functions for manipulating a table.  Tables are also reference
- * counted.
- *---------------------------------------------------------------*/
-int dm_table_create(struct dm_table **result, int mode,
-		    unsigned num_targets, struct mapped_device *md);
-
-void dm_table_get(struct dm_table *t);
-void dm_table_put(struct dm_table *t);
-
-int dm_table_add_target(struct dm_table *t, const char *type,
-			sector_t start,	sector_t len, char *params);
-int dm_table_complete(struct dm_table *t);
 void dm_table_event_callback(struct dm_table *t,
 			     void (*fn)(void *), void *context);
-void dm_table_event(struct dm_table *t);
-sector_t dm_table_get_size(struct dm_table *t);
 struct dm_target *dm_table_get_target(struct dm_table *t, unsigned int index);
 struct dm_target *dm_table_find_target(struct dm_table *t, sector_t sector);
 void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q);
-unsigned int dm_table_get_num_targets(struct dm_table *t);
 struct list_head *dm_table_get_devices(struct dm_table *t);
-int dm_table_get_mode(struct dm_table *t);
-struct mapped_device *dm_table_get_md(struct dm_table *t);
 void dm_table_presuspend_targets(struct dm_table *t);
 void dm_table_postsuspend_targets(struct dm_table *t);
 void dm_table_resume_targets(struct dm_table *t);
@@ -138,7 +66,6 @@ void dm_put_target_type(struct target_ty
 int dm_target_iterate(void (*iter_func)(struct target_type *tt,
 					void *param), void *param);
 
-
 /*-----------------------------------------------------------------
  * Useful inlines.
  *---------------------------------------------------------------*/
Index: linux-2.6.17/drivers/md/dm-table.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm-table.c	2006-06-21 18:32:19.000000000 +0100
+++ linux-2.6.17/drivers/md/dm-table.c	2006-06-21 18:32:25.000000000 +0100
@@ -236,6 +236,7 @@ int dm_table_create(struct dm_table **re
 	*result = t;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dm_table_create);
 
 static void free_devices(struct list_head *devices)
 {
@@ -726,6 +727,7 @@ int dm_table_add_target(struct dm_table 
 	dm_put_target_type(tgt->type);
 	return r;
 }
+EXPORT_SYMBOL_GPL(dm_table_add_target);
 
 static int setup_indexes(struct dm_table *t)
 {
@@ -776,6 +778,7 @@ int dm_table_complete(struct dm_table *t
 
 	return r;
 }
+EXPORT_SYMBOL_GPL(dm_table_complete);
 
 static DEFINE_MUTEX(_event_lock);
 void dm_table_event_callback(struct dm_table *t,
@@ -857,6 +860,7 @@ unsigned int dm_table_get_num_targets(st
 {
 	return t->num_targets;
 }
+EXPORT_SYMBOL_GPL(dm_table_get_num_targets);
 
 struct list_head *dm_table_get_devices(struct dm_table *t)
 {
