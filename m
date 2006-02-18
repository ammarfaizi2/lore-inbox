Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751835AbWBRBAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbWBRBAb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbWBRBAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:00:07 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:58857 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751837AbWBRBAB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:00:01 -0500
Message-ID: <43F6718E.2000908@us.ibm.com>
Date: Fri, 17 Feb 2006 16:59:58 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>, dm-devel@redhat.com,
       Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
References: <43F38D83.3040702@us.ibm.com> <20060217151650.GC12173@agk.surrey.redhat.com>
In-Reply-To: <20060217151650.GC12173@agk.surrey.redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060109050004080605040208"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060109050004080605040208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alasdair, et. al.,

Actually, I was not aware that a device could exist without a table. 
However, I suppose that geometry is a property of a device, not its 
underlying configuration, so the forced_geometry is better off in struct 
mapped_device.

Here's the third revision, with the geometry pushed into mapped_device 
as well as fixes for the problems that you pointed out wrt string 
passing, lack of warning messages, etc.  Thanks for all the great feedback!

Also, the v2 patch should have had the appropriate entries in 
include/linux/compat_ioctl.h.  Maybe it fell off?  In any case, it is 
present in this v3.

--D

--------------060109050004080605040208
Content-Type: text/x-patch;
 name="device-mapper-geometry_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="device-mapper-geometry_3.patch"

diff -aurp device-mapper-cvs/dmsetup/dmsetup.c device-mapper/dmsetup/dmsetup.c
--- device-mapper-cvs/dmsetup/dmsetup.c	2006-02-03 06:23:22.000000000 -0800
+++ device-mapper/dmsetup/dmsetup.c	2006-02-17 16:31:25.000000000 -0800
@@ -508,6 +508,49 @@ static int _message(int argc, char **arg
 	return r;
 }
 
+static int _setgeo(int argc, char **argv, void *data)
+{
+	int r = 0;
+	struct dm_task *dmt;
+	char *geo = NULL;
+
+	if (!(dmt = dm_task_create(DM_DEVICE_SETGEO)))
+		return 0;
+
+	if (_switches[UUID_ARG] || _switches[MAJOR_ARG]) {
+		if (!_set_task_device(dmt, NULL, 0))
+			goto out;
+	} else {
+		if (!_set_task_device(dmt, argv[1], 0))
+			goto out;
+		argc--;
+		argv++;
+	}
+
+	geo = malloc(strlen(argv[1]) + strlen(argv[2]) +
+		     strlen(argv[3]) + strlen(argv[4]) + 4);
+	if (!geo)
+		goto out;
+
+	r = sprintf(geo, "%s %s %s %s", argv[1], argv[2], argv[3], argv[4]);
+
+	if (!dm_task_set_newname(dmt, geo))
+		goto out;
+
+	/* run the task */
+	if (!dm_task_run(dmt))
+		goto out;
+
+	r = 1;
+
+      out:
+	if (geo)
+		free(geo);
+	dm_task_destroy(dmt);
+
+	return r;
+}
+
 static int _version(int argc, char **argv, void *data)
 {
 	char version[80];
@@ -1326,6 +1369,7 @@ static struct command _commands[] = {
 	{"mknodes", "[<device>]", 0, 1, _mknodes},
 	{"targets", "", 0, 0, _targets},
 	{"version", "", 0, 0, _version},
+	{"setgeometry", "<device> <cyl> <head> <sect> <start>", 5, 5, _setgeo},
 	{NULL, NULL, 0, 0, NULL}
 };
 
diff -aurp device-mapper-cvs/kernel/ioctl/dm-ioctl.h device-mapper/kernel/ioctl/dm-ioctl.h
--- device-mapper-cvs/kernel/ioctl/dm-ioctl.h	2005-10-04 13:12:32.000000000 -0700
+++ device-mapper/kernel/ioctl/dm-ioctl.h	2006-02-17 16:57:33.000000000 -0800
@@ -82,6 +82,17 @@
  *
  * DM_TARGET_MSG:
  * Pass a message string to the target at a specific offset of a device.
+ *
+ * DM_DEV_SETGEO:
+ * Set the geometry of a device by passing in a string.  The
+ * string should have this format:
+ *
+ * "cylinders heads sectors_per_track start_sector"
+ * 
+ * Beware that CHS geometry is nearly obsolete and only provided
+ * for compatibility with dm devices that can be booted by a PC
+ * BIOS.  See struct hd_geometry for range limits.  Also note that
+ * the geometry is erased if the device size changes.
  */
 
 /*
@@ -220,6 +231,7 @@ enum {
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
 	DM_TARGET_MSG_CMD,
+	DM_DEV_SETGEO_CMD
 };
 
 /*
@@ -249,6 +261,7 @@ typedef char ioctl_struct[308];
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
+#define DM_DEV_SETGEO_32    _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -272,11 +285,12 @@ typedef char ioctl_struct[308];
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+#define DM_DEV_SETGEO	 _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	5
+#define DM_VERSION_MINOR	6
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2005-10-04)"
+#define DM_VERSION_EXTRA	"-ioctl (2006-02-17)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
diff -aurp device-mapper-cvs/lib/ioctl/libdm-iface.c device-mapper/lib/ioctl/libdm-iface.c
--- device-mapper-cvs/lib/ioctl/libdm-iface.c	2006-02-03 06:23:22.000000000 -0800
+++ device-mapper/lib/ioctl/libdm-iface.c	2006-02-14 14:23:16.000000000 -0800
@@ -103,6 +103,9 @@ static struct cmd_data _cmd_data_v4[] = 
 #ifdef DM_TARGET_MSG
 	{"message",	DM_TARGET_MSG,		{4, 2, 0}},
 #endif
+#ifdef DM_DEV_SETGEO
+	{"setgeo",	DM_DEV_SETGEO,		{4, 2, 0}},
+#endif
 };
 /* *INDENT-ON* */
 
diff -aurp device-mapper-cvs/lib/libdevmapper.h device-mapper/lib/libdevmapper.h
--- device-mapper-cvs/lib/libdevmapper.h	2006-02-03 06:23:22.000000000 -0800
+++ device-mapper/lib/libdevmapper.h	2006-02-14 14:04:55.000000000 -0800
@@ -80,7 +80,9 @@ enum {
 
 	DM_DEVICE_LIST_VERSIONS,
 	
-	DM_DEVICE_TARGET_MSG
+	DM_DEVICE_TARGET_MSG,
+
+	DM_DEVICE_SETGEO
 };
 
 struct dm_task;

--------------060109050004080605040208
Content-Type: text/x-patch;
 name="dm-getgeo_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-getgeo_3.patch"

diff -aurp old/drivers/md/dm.c linux-2.6.16-rc4/drivers/md/dm.c
--- old/drivers/md/dm.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc4/drivers/md/dm.c	2006-02-17 16:54:43.000000000 -0800
@@ -17,6 +17,7 @@
 #include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/hdreg.h>
 
 static const char *_name = DM_NAME;
 
@@ -100,6 +101,9 @@ struct mapped_device {
 	 */
 	struct super_block *frozen_sb;
 	struct block_device *suspended_bdev;
+
+	/* forced geometry settings */
+	struct hd_geometry forced_geometry;
 };
 
 #define MIN_IOS 256
@@ -225,6 +229,13 @@ static int dm_blk_close(struct inode *in
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
@@ -311,6 +322,41 @@ struct dm_table *dm_get_table(struct map
 	return t;
 }
 
+/*
+ * Get the geometry associated with a dm device, if one has been set.
+ */
+int dm_get_geometry(struct mapped_device *md, struct hd_geometry *geo)
+{
+	sector_t sects;
+
+	sects = (sector_t)md->forced_geometry.cylinders *
+		md->forced_geometry.heads * md->forced_geometry.sectors;
+
+	if (!sects)
+		return -ENOTTY;
+
+	memcpy(geo, &md->forced_geometry, sizeof(*geo));
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
+		DMWARN("Start sector is beyond the geometry limits!");
+		return -EINVAL;
+	}
+
+	memcpy(&md->forced_geometry, geo, sizeof(*geo));
+
+	return 0;
+}
+
 /*-----------------------------------------------------------------
  * CRUD START:
  *   A more elegant soln is in the works that uses the queue
@@ -881,10 +927,13 @@ static void __set_size(struct mapped_dev
 static int __bind(struct mapped_device *md, struct dm_table *t)
 {
 	request_queue_t *q = md->queue;
-	sector_t size;
+	sector_t size, oldsize;
 
+	oldsize = get_capacity(md->disk);
 	size = dm_table_get_size(t);
 	__set_size(md, size);
+	if (size != oldsize)
+		memset(&md->forced_geometry, 0, sizeof(md->forced_geometry));
 	if (size == 0)
 		return 0;
 
@@ -1242,6 +1291,7 @@ int dm_suspended(struct mapped_device *m
 static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
+	.getgeo = dm_blk_getgeo,
 	.owner = THIS_MODULE
 };
 
diff -aurp old/drivers/md/dm.h linux-2.6.16-rc4/drivers/md/dm.h
--- old/drivers/md/dm.h	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc4/drivers/md/dm.h	2006-02-17 16:23:51.000000000 -0800
@@ -14,6 +14,7 @@
 #include <linux/device-mapper.h>
 #include <linux/list.h>
 #include <linux/blkdev.h>
+#include <linux/hdreg.h>
 
 #define DM_NAME "device-mapper"
 #define DMWARN(f, x...) printk(KERN_WARNING DM_NAME ": " f "\n" , ## x)
@@ -95,6 +96,12 @@ int dm_wait_event(struct mapped_device *
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
diff -aurp old/drivers/md/dm-ioctl.c linux-2.6.16-rc4/drivers/md/dm-ioctl.c
--- old/drivers/md/dm-ioctl.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc4/drivers/md/dm-ioctl.c	2006-02-17 16:14:24.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
+#include <linux/hdreg.h>
 
 #include <asm/uaccess.h>
 
@@ -690,6 +691,58 @@ static int dev_rename(struct dm_ioctl *p
 	return dm_hash_rename(param->name, new_name);
 }
 
+static int dev_setgeo(struct dm_ioctl *param, size_t param_size)
+{
+	int r = 0, x;
+	struct mapped_device *md;
+	struct hd_geometry dgm;
+	char *geostr;
+	unsigned long indata[4];
+
+	r = -ENXIO;
+
+	md = find_device(param);
+	if (!md)
+		goto out;
+
+	r = -EINVAL;
+	geostr = (char *) param + param->data_start;
+	if (geostr < (char *) (param + 1) ||
+	    invalid_str(geostr, (void *) param + param_size)) {
+		DMWARN("Invalid geometry supplied.");
+		goto out2;
+	}
+
+	x = sscanf(geostr, "%lu %lu %lu %lu", indata,
+		   indata + 1, indata + 2, indata + 3);
+
+	if (x != 4) {
+		DMWARN("Unable to interpret geometry settings.");
+		goto out2;
+	}
+
+	if (indata[0] > 65535 || indata[1] > 255 ||
+	    indata[2] > 255 || indata[3] > ULONG_MAX) {
+		DMWARN("Geometry exceeds range limits.");
+		goto out2;
+	}
+
+	dgm.cylinders = indata[0];
+	dgm.heads = indata[1];
+	dgm.sectors = indata[2];
+	dgm.start = indata[3];
+
+	r = dm_set_geometry(md, &dgm);
+
+	if (!r)
+		r = __dev_status(md, param);
+out2:
+	param->data_size = 0;
+	dm_put(md);
+out:
+	return r;
+}
+
 static int do_suspend(struct dm_ioctl *param)
 {
 	int r = 0;
@@ -1214,7 +1267,8 @@ static ioctl_fn lookup_ioctl(unsigned in
 
 		{DM_LIST_VERSIONS_CMD, list_versions},
 
-		{DM_TARGET_MSG_CMD, target_message}
+		{DM_TARGET_MSG_CMD, target_message},
+		{DM_DEV_SETGEO_CMD, dev_setgeo}
 	};
 
 	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
diff -aurp old/include/linux/compat_ioctl.h linux-2.6.16-rc4/include/linux/compat_ioctl.h
--- old/include/linux/compat_ioctl.h	2006-02-15 10:49:47.000000000 -0800
+++ linux-2.6.16-rc4/include/linux/compat_ioctl.h	2006-02-16 11:48:53.000000000 -0800
@@ -151,6 +151,7 @@ COMPATIBLE_IOCTL(DM_TABLE_DEPS)
 COMPATIBLE_IOCTL(DM_TABLE_STATUS)
 COMPATIBLE_IOCTL(DM_LIST_VERSIONS)
 COMPATIBLE_IOCTL(DM_TARGET_MSG)
+COMPATIBLE_IOCTL(DM_DEV_SETGEO)
 /* Big K */
 COMPATIBLE_IOCTL(PIO_FONT)
 COMPATIBLE_IOCTL(GIO_FONT)
diff -aurp old/include/linux/dm-ioctl.h linux-2.6.16-rc4/include/linux/dm-ioctl.h
--- old/include/linux/dm-ioctl.h	2006-02-15 10:49:47.000000000 -0800
+++ linux-2.6.16-rc4/include/linux/dm-ioctl.h	2006-02-17 16:55:44.000000000 -0800
@@ -80,6 +80,17 @@
  *
  * DM_TARGET_MSG:
  * Pass a message string to the target at a specific offset of a device.
+ *
+ * DM_DEV_SETGEO:
+ * Set the geometry of a device by passing in a string.  The
+ * string should have this format:
+ *
+ * "cylinders heads sectors_per_track start_sector"
+ * 
+ * Beware that CHS geometry is nearly obsolete and only provided
+ * for compatibility with dm devices that can be booted by a PC
+ * BIOS.  See struct hd_geometry for range limits.  Also note that
+ * the geometry is erased if the device size changes.
  */
 
 /*
@@ -218,6 +229,7 @@ enum {
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
 	DM_TARGET_MSG_CMD,
+	DM_DEV_SETGEO_CMD
 };
 
 /*
@@ -247,6 +259,7 @@ typedef char ioctl_struct[308];
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
+#define DM_DEV_SETGEO_32    _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -270,11 +283,12 @@ typedef char ioctl_struct[308];
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+#define DM_DEV_SETGEO	 _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	5
+#define DM_VERSION_MINOR	6
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2005-10-04)"
+#define DM_VERSION_EXTRA	"-ioctl (2006-02-17)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */

--------------060109050004080605040208--
