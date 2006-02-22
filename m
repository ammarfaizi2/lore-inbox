Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWBVWcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWBVWcv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWBVWcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:32:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41873 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751019AbWBVWcu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:32:50 -0500
Date: Wed, 22 Feb 2006 22:32:40 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [dm-devel] Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
Message-ID: <20060222223240.GI31641@agk.surrey.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <djwong@us.ibm.com>,
	device-mapper development <dm-devel@redhat.com>,
	Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <43F38D83.3040702@us.ibm.com> <20060217151650.GC12173@agk.surrey.redhat.com> <43F6718E.2000908@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F6718E.2000908@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:59:58PM -0800, Darrick J. Wong wrote:
> Here's the third revision, with the geometry pushed into mapped_device 
> as well as fixes for the problems that you pointed out wrt string 
> passing, lack of warning messages, etc.  Thanks for all the great feedback!
 
Almost there now: how does the version below look?
Corresponding userspace changes are in device-mapper CVS.

Alasdair



From: "Darrick J. Wong" <djwong@us.ibm.com>
 
Allow drive geometry to be stored with a new DM_DEV_SET_GEOMETRY ioctl.
Device-mapper will now respond to HDIO_GETGEO.
If the geometry information is not available, zero will 
be returned for all of the parameters.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.16-rc1/drivers/md/dm.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm.c	2006-02-22 20:44:55.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm.c	2006-02-22 20:44:57.000000000 +0000
@@ -17,6 +17,7 @@
 #include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/hdreg.h>
 
 static const char *_name = DM_NAME;
 
@@ -101,6 +102,9 @@ struct mapped_device {
 	 */
 	struct super_block *frozen_sb;
 	struct block_device *suspended_bdev;
+
+	/* forced geometry settings */
+	struct hd_geometry geometry;
 };
 
 #define MIN_IOS 256
@@ -226,6 +230,13 @@ static int dm_blk_close(struct inode *in
 	return 0;
 }
 
+static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct mapped_device *md = bdev->bd_disk->private_data;
+
+	return dm_get_geometry(md, geo);
+}
+
 static inline struct dm_io *alloc_io(struct mapped_device *md)
 {
 	return mempool_alloc(md->io_pool, GFP_NOIO);
@@ -312,6 +323,33 @@ struct dm_table *dm_get_table(struct map
 	return t;
 }
 
+/*
+ * Get the geometry associated with a dm device
+ */
+int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo)
+{
+	*geo = md->geometry;
+
+	return 0;
+}
+
+/*
+ * Set the geometry of a device.
+ */
+int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo)
+{
+	sector_t sz = (sector_t)geo->cylinders * geo->heads * geo->sectors;
+
+	if (geo->start > sz) {
+		DMWARN("Start sector is beyond the geometry limits.");
+		return -EINVAL;
+	}
+
+	md->geometry = *geo;
+
+	return 0;
+}
+
 /*-----------------------------------------------------------------
  * CRUD START:
  *   A more elegant soln is in the works that uses the queue
@@ -886,6 +924,13 @@ static int __bind(struct mapped_device *
 	sector_t size;
 
 	size = dm_table_get_size(t);
+
+	/*
+	 * Wipe any geometry if the size of the table changed.
+	 */
+	if (size != get_capacity(md->disk))
+		memset(&md->geometry, 0, sizeof(md->geometry));
+
 	__set_size(md, size);
 	if (size == 0)
 		return 0;
@@ -1238,6 +1283,7 @@ int dm_suspended(struct mapped_device *m
 static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
+	.getgeo = dm_blk_getgeo,
 	.owner = THIS_MODULE
 };
 
Index: linux-2.6.16-rc1/drivers/md/dm.h
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm.h	2006-02-22 20:44:56.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm.h	2006-02-22 20:44:57.000000000 +0000
@@ -14,6 +14,7 @@
 #include <linux/device-mapper.h>
 #include <linux/list.h>
 #include <linux/blkdev.h>
+#include <linux/hdreg.h>
 
 #define DM_NAME "device-mapper"
 #define DMWARN(f, x...) printk(KERN_WARNING DM_NAME ": " f "\n" , ## x)
@@ -85,6 +86,12 @@ int dm_wait_event(struct mapped_device *
 struct gendisk *dm_disk(struct mapped_device *md);
 int dm_suspended(struct mapped_device *md);
 
+/*
+ * Geometry functions.
+ */
+int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo);
+int dm_set_geometry(struct mapped_device *md, struct hd_geometry *geo);
+
 /*-----------------------------------------------------------------
  * Functions for manipulating a table.  Tables are also reference
  * counted.
Index: linux-2.6.16-rc1/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.16-rc1.orig/drivers/md/dm-ioctl.c	2006-02-22 20:44:56.000000000 +0000
+++ linux-2.6.16-rc1/drivers/md/dm-ioctl.c	2006-02-22 20:44:57.000000000 +0000
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
+#include <linux/hdreg.h>
 
 #include <asm/uaccess.h>
 
@@ -700,6 +701,54 @@ static int dev_rename(struct dm_ioctl *p
 	return dm_hash_rename(param->name, new_name);
 }
 
+static int dev_set_geometry(struct dm_ioctl *param, size_t param_size)
+{
+	int r = -EINVAL, x;
+	struct mapped_device *md;
+	struct hd_geometry geometry;
+	unsigned long indata[4];
+	char *geostr = (char *) param + param->data_start;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	if (geostr < (char *) (param + 1) ||
+	    invalid_str(geostr, (void *) param + param_size)) {
+		DMWARN("Invalid geometry supplied.");
+		goto out;
+	}
+
+	x = sscanf(geostr, "%lu %lu %lu %lu", indata,
+		   indata + 1, indata + 2, indata + 3);
+
+	if (x != 4) {
+		DMWARN("Unable to interpret geometry settings.");
+		goto out;
+	}
+
+	if (indata[0] > 65535 || indata[1] > 255 ||
+	    indata[2] > 255 || indata[3] > ULONG_MAX) {
+		DMWARN("Geometry exceeds range limits.");
+		goto out;
+	}
+
+	geometry.cylinders = indata[0];
+	geometry.heads = indata[1];
+	geometry.sectors = indata[2];
+	geometry.start = indata[3];
+
+	r = dm_set_geometry(md, &geometry);
+	if (!r)
+		r = __dev_status(md, param);
+
+	param->data_size = 0;
+
+out:
+	dm_put(md);
+	return r;
+}
+
 static int do_suspend(struct dm_ioctl *param)
 {
 	int r = 0;
@@ -1233,7 +1282,8 @@ static ioctl_fn lookup_ioctl(unsigned in
 
 		{DM_LIST_VERSIONS_CMD, list_versions},
 
-		{DM_TARGET_MSG_CMD, target_message}
+		{DM_TARGET_MSG_CMD, target_message},
+		{DM_DEV_SET_GEOMETRY_CMD, dev_set_geometry}
 	};
 
 	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
Index: linux-2.6.16-rc1/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.16-rc1.orig/include/linux/compat_ioctl.h	2006-02-22 20:42:48.000000000 +0000
+++ linux-2.6.16-rc1/include/linux/compat_ioctl.h	2006-02-22 20:44:57.000000000 +0000
@@ -136,6 +136,7 @@ COMPATIBLE_IOCTL(DM_TABLE_DEPS_32)
 COMPATIBLE_IOCTL(DM_TABLE_STATUS_32)
 COMPATIBLE_IOCTL(DM_LIST_VERSIONS_32)
 COMPATIBLE_IOCTL(DM_TARGET_MSG_32)
+COMPATIBLE_IOCTL(DM_DEV_SET_GEOMETRY_32)
 COMPATIBLE_IOCTL(DM_VERSION)
 COMPATIBLE_IOCTL(DM_REMOVE_ALL)
 COMPATIBLE_IOCTL(DM_LIST_DEVICES)
@@ -151,6 +152,7 @@ COMPATIBLE_IOCTL(DM_TABLE_DEPS)
 COMPATIBLE_IOCTL(DM_TABLE_STATUS)
 COMPATIBLE_IOCTL(DM_LIST_VERSIONS)
 COMPATIBLE_IOCTL(DM_TARGET_MSG)
+COMPATIBLE_IOCTL(DM_DEV_SET_GEOMETRY)
 /* Big K */
 COMPATIBLE_IOCTL(PIO_FONT)
 COMPATIBLE_IOCTL(GIO_FONT)
Index: linux-2.6.16-rc1/include/linux/dm-ioctl.h
===================================================================
--- linux-2.6.16-rc1.orig/include/linux/dm-ioctl.h	2006-02-22 20:42:48.000000000 +0000
+++ linux-2.6.16-rc1/include/linux/dm-ioctl.h	2006-02-22 20:44:57.000000000 +0000
@@ -80,6 +80,16 @@
  *
  * DM_TARGET_MSG:
  * Pass a message string to the target at a specific offset of a device.
+ *
+ * DM_DEV_SET_GEOMETRY:
+ * Set the geometry of a device by passing in a string in this format:
+ *
+ * "cylinders heads sectors_per_track start_sector"
+ *
+ * Beware that CHS geometry is nearly obsolete and only provided
+ * for compatibility with dm devices that can be booted by a PC
+ * BIOS.  See struct hd_geometry for range limits.  Also note that
+ * the geometry is erased if the device size changes.
  */
 
 /*
@@ -218,6 +228,7 @@ enum {
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
 	DM_TARGET_MSG_CMD,
+	DM_DEV_SET_GEOMETRY_CMD
 };
 
 /*
@@ -247,6 +258,7 @@ typedef char ioctl_struct[308];
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
+#define DM_DEV_SET_GEOMETRY_32	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -270,11 +282,12 @@ typedef char ioctl_struct[308];
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+#define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	5
+#define DM_VERSION_MINOR	6
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2005-10-04)"
+#define DM_VERSION_EXTRA	"-ioctl (2006-02-17)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
