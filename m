Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbWBOUWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbWBOUWf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 15:22:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWBOUWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 15:22:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60291 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751286AbWBOUWd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 15:22:33 -0500
Message-ID: <43F38D83.3040702@us.ibm.com>
Date: Wed, 15 Feb 2006 12:22:27 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: dm-devel@redhat.com
CC: Chris McDermott <lcm@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] User-configurable HDIO_GETGEO for dm volumes
Content-Type: multipart/mixed;
 boundary="------------050009090802040106030209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050009090802040106030209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi everyone,

Here's a rework of last week's HDIO_GETGEO patch.  Based on all the 
feedback that I received last week, it seems that a better way to 
approach this problem is:

- Store a hd_geometry structure with each dm_table entry.
- Provide a dm getgeo method that returns that geometry (or
   -ENOTTY if there is no geometry).
- Add a dm control ioctl to set the geometry of an arbitrary dm device.
- Modify dmsetup to be able to set geometries.

This way, dmraid can associate geometries with bootable fakeraid 
devices, and dmsetup can be told to assign a geometry to a single-device 
linear/multipath setup as desired.  Furthermore, HDIO_GETGEO callers 
will go away empty-handed if the userspace config tools do not set up a 
geometry, as is the case now.  The decision to assign a geometry (and 
what that should be) is totally deferred to userspace.

So, dm-getgeo_1.patch is a patch to 2.6.16-rc3 that modifies the dm 
driver to store and retrieve geometries.  I chose to attach the 
hd_geometry structure to dm_table because it seemed like a convenient 
place to attach config data.  The only part of this patch that I think 
to be particularly dodgy is the dev_setgeo function, because I'm using 
the dm_target_msg struct to pass the user's hd_geometry into the kernel. 
  I'm not really sure if or how I'm supposed to send binary blobs into 
the dm code, though the piggyback method works adequately.  Obviously, 
this introduces a new dm control ioctl DM_DEV_SETGEO.

The second patch (device-mapper-geometry_1.patch), unsurprisingly, is a 
patch to the userspace libdevmapper/dmsetup code to enable the passing 
of hd_geometry structures to the kernel.

Questions?  Comments?

--D

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--------------050009090802040106030209
Content-Type: text/x-patch;
 name="device-mapper-geometry_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="device-mapper-geometry_1.patch"

diff -Naurp -x '*CVS*' device-mapper-cvs/dmsetup/dmsetup.c device-mapper/dmsetup/dmsetup.c
--- device-mapper-cvs/dmsetup/dmsetup.c	2006-02-03 06:23:22.000000000 -0800
+++ device-mapper/dmsetup/dmsetup.c	2006-02-15 10:57:56.000000000 -0800
@@ -35,6 +35,7 @@
 #include <sys/param.h>
 #include <locale.h>
 #include <langinfo.h>
+#include <linux/hdreg.h>
 
 #ifdef HAVE_SYS_IOCTL_H
 #  include <sys/ioctl.h>
@@ -508,6 +509,73 @@ static int _message(int argc, char **arg
 	return r;
 }
 
+static int _setgeo(int argc, char **argv, void *data)
+{
+	int r = 0, i;
+	struct dm_task *dmt;
+	struct hd_geometry *geo = NULL;
+	long long x;
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
+	for (i = 0; i < argc; i++) {
+		printf("_setgeo[%d] = %s\n", i, argv[i]);
+	}
+
+	geo = calloc(1, sizeof(*geo) + 1);
+	if (!geo)
+		goto out;
+
+	/* Now start filling out the geometry structure. */
+	x = strtoll(argv[1], NULL, 10);
+	if (x > USHRT_MAX || x < 0)
+		goto out;
+	geo->cylinders = (unsigned long)x;
+
+	x = strtoll(argv[2], NULL, 10);
+	if (x > UCHAR_MAX || x < 0)
+		goto out;
+	geo->heads = x;
+
+	x = strtoll(argv[3], NULL, 10);
+	if (x > UCHAR_MAX || x < 0)
+		goto out;
+	geo->sectors = x;
+	
+	x = strtoll(argv[4], NULL, 10);
+	if (x > UINT_MAX || x < 0)
+		goto out;
+	geo->start = x;
+
+	/* FIXME: Is piggybacking a structure as a string too evil? */
+	if (!dm_task_set_message(dmt, (char *)geo))
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
@@ -1326,6 +1394,7 @@ static struct command _commands[] = {
 	{"mknodes", "[<device>]", 0, 1, _mknodes},
 	{"targets", "", 0, 0, _targets},
 	{"version", "", 0, 0, _version},
+	{"setgeometry", "<device> <cyl> <head> <sect> <start>", 5, 5, _setgeo},
 	{NULL, NULL, 0, 0, NULL}
 };
 
diff -Naurp -x '*CVS*' device-mapper-cvs/kernel/ioctl/dm-ioctl.h device-mapper/kernel/ioctl/dm-ioctl.h
--- device-mapper-cvs/kernel/ioctl/dm-ioctl.h	2005-10-04 13:12:32.000000000 -0700
+++ device-mapper/kernel/ioctl/dm-ioctl.h	2006-02-14 14:24:08.000000000 -0800
@@ -220,6 +220,8 @@ enum {
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
 	DM_TARGET_MSG_CMD,
+
+	DM_DEV_SETGEO_CMD
 };
 
 /*
@@ -249,6 +251,7 @@ typedef char ioctl_struct[308];
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
+#define DM_DEV_SETGEO_32    _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -272,6 +275,7 @@ typedef char ioctl_struct[308];
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+#define DM_DEV_SETGEO	 _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
 #define DM_VERSION_MINOR	5
diff -Naurp -x '*CVS*' device-mapper-cvs/lib/ioctl/libdm-iface.c device-mapper/lib/ioctl/libdm-iface.c
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
 
diff -Naurp -x '*CVS*' device-mapper-cvs/lib/libdevmapper.h device-mapper/lib/libdevmapper.h
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

--------------050009090802040106030209
Content-Type: text/x-patch;
 name="dm-getgeo_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-getgeo_1.patch"

diff -Naurp old/drivers/md/dm.c linux-2.6.16-rc3/drivers/md/dm.c
--- old/drivers/md/dm.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc3/drivers/md/dm.c	2006-02-15 10:42:14.000000000 -0800
@@ -17,6 +17,7 @@
 #include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/hdreg.h>
 
 static const char *_name = DM_NAME;
 
@@ -225,6 +226,16 @@ static int dm_blk_close(struct inode *in
 	return 0;
 }
 
+static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	int ret;
+	struct mapped_device *md = bdev->bd_disk->private_data;
+
+	ret = dm_table_get_geometry(md->map, geo);
+
+	return (ret ? 0 : -ENOTTY);
+}	
+
 static inline struct dm_io *alloc_io(struct mapped_device *md)
 {
 	return mempool_alloc(md->io_pool, GFP_NOIO);
@@ -1242,6 +1253,7 @@ int dm_suspended(struct mapped_device *m
 static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
+	.getgeo = dm_blk_getgeo,
 	.owner = THIS_MODULE
 };
 
diff -Naurp old/drivers/md/dm.h linux-2.6.16-rc3/drivers/md/dm.h
--- old/drivers/md/dm.h	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc3/drivers/md/dm.h	2006-02-13 17:35:24.000000000 -0800
@@ -123,6 +123,8 @@ void dm_table_resume_targets(struct dm_t
 int dm_table_any_congested(struct dm_table *t, int bdi_bits);
 void dm_table_unplug_all(struct dm_table *t);
 int dm_table_flush_all(struct dm_table *t);
+int dm_table_get_geometry(struct dm_table *t, struct hd_geometry *geo);
+int dm_table_set_geometry(struct dm_table *t, struct hd_geometry *geo);
 
 /*-----------------------------------------------------------------
  * A registry of target types.
diff -Naurp old/drivers/md/dm-ioctl.c linux-2.6.16-rc3/drivers/md/dm-ioctl.c
--- old/drivers/md/dm-ioctl.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc3/drivers/md/dm-ioctl.c	2006-02-15 10:51:19.000000000 -0800
@@ -690,6 +690,35 @@ static int dev_rename(struct dm_ioctl *p
 	return dm_hash_rename(param->name, new_name);
 }
 
+static int dev_setgeo(struct dm_ioctl *param, size_t param_size)
+{
+	int r = 0;
+	size_t len;
+	struct mapped_device *md;
+	struct dm_table *tbl;
+	struct dm_geometry_msg *dgm;
+	struct dm_target_msg *tmsg;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	/*
+	 * Grab our output buffer.
+	 */
+	tmsg = get_result_buffer(param, param_size, &len);
+	dgm = (struct dm_geometry_msg *)tmsg->message;
+
+	tbl = dm_get_table(md);
+
+	r = dm_table_set_geometry(tbl, &dgm->geo);
+
+	dm_table_put(tbl);
+	dm_put(md);
+
+	return (r ? 0 : -EINVAL);
+}
+
 static int do_suspend(struct dm_ioctl *param)
 {
 	int r = 0;
@@ -1214,7 +1243,8 @@ static ioctl_fn lookup_ioctl(unsigned in
 
 		{DM_LIST_VERSIONS_CMD, list_versions},
 
-		{DM_TARGET_MSG_CMD, target_message}
+		{DM_TARGET_MSG_CMD, target_message},
+		{DM_DEV_SETGEO_CMD, dev_setgeo}
 	};
 
 	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
diff -Naurp old/drivers/md/dm-table.c linux-2.6.16-rc3/drivers/md/dm-table.c
--- old/drivers/md/dm-table.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc3/drivers/md/dm-table.c	2006-02-15 10:42:37.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <asm/atomic.h>
+#include <linux/hdreg.h>
 
 #define MAX_DEPTH 16
 #define NODE_SIZE L1_CACHE_BYTES
@@ -53,6 +54,9 @@ struct dm_table {
 	/* events get handed up using this callback */
 	void (*event_fn)(void *);
 	void *event_context;
+
+	/* forced geometry settings */
+	struct hd_geometry forced_geometry;
 };
 
 /*
@@ -945,6 +949,29 @@ int dm_table_flush_all(struct dm_table *
 	return ret;
 }
 
+int dm_table_get_geometry(struct dm_table *t, struct hd_geometry *geo)
+{
+	sector_t sects;
+
+	sects = t->forced_geometry.cylinders * t->forced_geometry.heads
+		* t->forced_geometry.sectors;
+
+	if (!sects) {
+		return 0;
+	}
+
+	memcpy(geo, &t->forced_geometry, sizeof(*geo));
+
+	return 1;
+}
+
+int dm_table_set_geometry(struct dm_table *t, struct hd_geometry *geo)
+{
+	memcpy(&t->forced_geometry, geo, sizeof(*geo));
+
+	return 1;
+}
+
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
diff -Naurp old/include/linux/dm-ioctl.h linux-2.6.16-rc3/include/linux/dm-ioctl.h
--- old/include/linux/dm-ioctl.h	2006-02-15 10:49:47.000000000 -0800
+++ linux-2.6.16-rc3/include/linux/dm-ioctl.h	2006-02-13 18:05:45.000000000 -0800
@@ -9,6 +9,7 @@
 #define _LINUX_DM_IOCTL_V4_H
 
 #include <linux/types.h>
+#include <linux/hdreg.h>
 
 #define DM_DIR "mapper"		/* Slashes not supported */
 #define DM_MAX_TYPE_NAME 16
@@ -191,6 +192,11 @@ struct dm_target_msg {
 	char message[0];
 };
 
+/* Used to force a geometry */
+struct dm_geometry_msg {
+	struct hd_geometry geo;
+};
+
 /*
  * If you change this make sure you make the corresponding change
  * to dm-ioctl.c:lookup_ioctl()
@@ -218,6 +224,7 @@ enum {
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
 	DM_TARGET_MSG_CMD,
+	DM_DEV_SETGEO_CMD,
 };
 
 /*
@@ -247,6 +254,7 @@ typedef char ioctl_struct[308];
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
+#define DM_DEV_SETGEO_32    _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -270,6 +278,7 @@ typedef char ioctl_struct[308];
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+#define DM_DEV_SETGEO	 _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
 #define DM_VERSION_MINOR	5

--------------050009090802040106030209--
