Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751156AbWBQBbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWBQBbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 20:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBQBbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 20:31:15 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:48288 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751080AbWBQBbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 20:31:11 -0500
Message-ID: <43F5275A.6070603@us.ibm.com>
Date: Thu, 16 Feb 2006 17:31:06 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: Linux Technology Center, IBM
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dm-devel@redhat.com, lcm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
References: <43F38D83.3040702@us.ibm.com> <20060215190556.59c343b4.akpm@osdl.org>
In-Reply-To: <20060215190556.59c343b4.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010502000305000408000901"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010502000305000408000901
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

> Normally kernel functions return zero on success.  So that they can return
> negative errno on failure.  Is that appropriate here?  Just propagate the
> dm_table_get_geometry() return value?

Fair enough, I've changed the functions to return 0 on success.  See the 
patches attached to the end.

> That's brave - we take the hd_geometry straight from userspace without
> checking anything?

My original approach didn't work anyway; libdevmapper thinks that a 
target message is a string and would stop copying at the first null it 
saw.  Since you're also concerned about being locked into a particular 
hd_geometry structure layout, I respun the patch so that dmsetup passes 
a string to the dm configuration code; now dm performs some basic 
range/sanity checks.  However, the patch doesn't check that the CHS 
values make sense or are even close to the real disk size; if somebody 
in userspace wants to configure a 150G dm device to have the same 
geometry as a 360K floppy disk, so be it.  Geometries seem to be rather 
inaccurate anyway.

Or, were you worried that I'm dereferencing a userspace pointer in the 
kernel?  The code that calls _setgeo handles that properly.

> Will this code dtrt if userspace is 32-bit and the kernel is 64-bit?

There shouldn't be any 32/64 mis-match issues with passing a string.  If 
one tries to pass too-large values, -EINVAL is returned.

> > struct hd_geometry looks like something which different compilers could lay
> out differently, perhaps even different gcc versions.  We're relying upon
> the userspace representation being identical to the kernel's
> representation.
> 
> It means that struct hd_geometry becomes part of the kernel ABI.  We can
> never again change it and neither we (nor the compiler) can ever change its
> layout.  That's dangerous.  I'd suggest that you not use hd_geometry in
> this way (unless we're already using it that way, which might be the case).

hd_geometry is already part of the kernel ABI because the HDIO_GETGEO 
ioctl takes a pointer to a struct hd_geometry in userspace and fills it 
out.  Though, now that I've changed the setgeo half to pass a string 
around, I suppose the point is partially moot.

> It'd be better to use some carefully laid-out and documented structure
> which is private to DM and which is designed for future-compatibility and
> for user<->kernel communication.

--D

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--------------010502000305000408000901
Content-Type: text/x-patch;
 name="device-mapper-geometry_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="device-mapper-geometry_2.patch"

diff -aurp -x '*CVS*' device-mapper-cvs/dmsetup/dmsetup.c device-mapper/dmsetup/dmsetup.c
--- device-mapper-cvs/dmsetup/dmsetup.c	2006-02-03 06:23:22.000000000 -0800
+++ device-mapper/dmsetup/dmsetup.c	2006-02-16 17:10:04.000000000 -0800
@@ -35,6 +35,7 @@
 #include <sys/param.h>
 #include <locale.h>
 #include <langinfo.h>
+#include <linux/hdreg.h>
 
 #ifdef HAVE_SYS_IOCTL_H
 #  include <sys/ioctl.h>
@@ -508,6 +509,49 @@ static int _message(int argc, char **arg
 	return r;
 }
 
+static int _setgeo(int argc, char **argv, void *data)
+{
+	int r = 0, i;
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
+	if (!dm_task_set_message(dmt, geo))
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
@@ -1326,6 +1370,7 @@ static struct command _commands[] = {
 	{"mknodes", "[<device>]", 0, 1, _mknodes},
 	{"targets", "", 0, 0, _targets},
 	{"version", "", 0, 0, _version},
+	{"setgeometry", "<device> <cyl> <head> <sect> <start>", 5, 5, _setgeo},
 	{NULL, NULL, 0, 0, NULL}
 };
 
diff -aurp -x '*CVS*' device-mapper-cvs/kernel/ioctl/dm-ioctl.h device-mapper/kernel/ioctl/dm-ioctl.h
--- device-mapper-cvs/kernel/ioctl/dm-ioctl.h	2005-10-04 13:12:32.000000000 -0700
+++ device-mapper/kernel/ioctl/dm-ioctl.h	2006-02-16 11:46:12.000000000 -0800
@@ -220,6 +220,7 @@ enum {
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
 	DM_TARGET_MSG_CMD,
+	DM_DEV_SETGEO_CMD
 };
 
 /*
@@ -249,6 +250,7 @@ typedef char ioctl_struct[308];
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
+#define DM_DEV_SETGEO_32    _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -272,6 +274,7 @@ typedef char ioctl_struct[308];
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+#define DM_DEV_SETGEO	 _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
 #define DM_VERSION_MINOR	5
diff -aurp -x '*CVS*' device-mapper-cvs/lib/ioctl/libdm-iface.c device-mapper/lib/ioctl/libdm-iface.c
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
 
diff -aurp -x '*CVS*' device-mapper-cvs/lib/libdevmapper.h device-mapper/lib/libdevmapper.h
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

--------------010502000305000408000901
Content-Type: text/x-patch;
 name="dm-getgeo_2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dm-getgeo_2.patch"

diff -aurp old/drivers/md/dm.c linux-2.6.16-rc3/drivers/md/dm.c
--- old/drivers/md/dm.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc3/drivers/md/dm.c	2006-02-16 10:23:54.000000000 -0800
@@ -17,6 +17,7 @@
 #include <linux/mempool.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
+#include <linux/hdreg.h>
 
 static const char *_name = DM_NAME;
 
@@ -225,6 +226,13 @@ static int dm_blk_close(struct inode *in
 	return 0;
 }
 
+static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+{
+	struct mapped_device *md = bdev->bd_disk->private_data;
+
+	return dm_table_get_geometry(md->map, geo);
+}	
+
 static inline struct dm_io *alloc_io(struct mapped_device *md)
 {
 	return mempool_alloc(md->io_pool, GFP_NOIO);
@@ -1242,6 +1250,7 @@ int dm_suspended(struct mapped_device *m
 static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
+	.getgeo = dm_blk_getgeo,
 	.owner = THIS_MODULE
 };
 
diff -aurp old/drivers/md/dm.h linux-2.6.16-rc3/drivers/md/dm.h
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
diff -aurp old/drivers/md/dm-ioctl.c linux-2.6.16-rc3/drivers/md/dm-ioctl.c
--- old/drivers/md/dm-ioctl.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc3/drivers/md/dm-ioctl.c	2006-02-16 11:49:26.000000000 -0800
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/dm-ioctl.h>
+#include <linux/hdreg.h>
 
 #include <asm/uaccess.h>
 
@@ -690,6 +691,51 @@ static int dev_rename(struct dm_ioctl *p
 	return dm_hash_rename(param->name, new_name);
 }
 
+static int dev_setgeo(struct dm_ioctl *param, size_t param_size)
+{
+	int r = 0, x;
+	size_t len;
+	struct mapped_device *md;
+	struct dm_table *tbl;
+	struct hd_geometry dgm;
+	struct dm_target_msg *tmsg;
+	unsigned long indata[4];
+
+	r = -ENXIO;
+
+	md = find_device(param);
+	if (!md)
+		goto out;
+
+	/*
+	 * Grab our input buffer.
+	 */
+	tmsg = get_result_buffer(param, param_size, &len);
+
+	r = -EINVAL;
+	x = sscanf(tmsg->message, "%lu %lu %lu %lu", indata, indata + 1, indata + 2, indata + 3);
+	if (x != 4)
+		goto out2;
+
+	if (indata[0] > 65535 || indata[1] > 255
+	    || indata[2] > 255 || indata[3] > ULONG_MAX)
+		goto out2;
+
+	dgm.cylinders = indata[0];
+	dgm.heads = indata[1];
+	dgm.sectors = indata[2];
+	dgm.start = indata[3];
+
+	tbl = dm_get_table(md);
+	r = dm_table_set_geometry(tbl, &dgm);
+
+	dm_table_put(tbl);
+out2:
+	dm_put(md);
+out:
+	return r;
+}
+
 static int do_suspend(struct dm_ioctl *param)
 {
 	int r = 0;
@@ -1214,7 +1260,8 @@ static ioctl_fn lookup_ioctl(unsigned in
 
 		{DM_LIST_VERSIONS_CMD, list_versions},
 
-		{DM_TARGET_MSG_CMD, target_message}
+		{DM_TARGET_MSG_CMD, target_message},
+		{DM_DEV_SETGEO_CMD, dev_setgeo}
 	};
 
 	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
diff -aurp old/drivers/md/dm-table.c linux-2.6.16-rc3/drivers/md/dm-table.c
--- old/drivers/md/dm-table.c	2006-02-15 10:49:46.000000000 -0800
+++ linux-2.6.16-rc3/drivers/md/dm-table.c	2006-02-16 11:43:05.000000000 -0800
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
@@ -945,6 +949,34 @@ int dm_table_flush_all(struct dm_table *
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
+		return -ENOTTY;
+	}
+
+	memcpy(geo, &t->forced_geometry, sizeof(*geo));
+
+	return 0;
+}
+
+int dm_table_set_geometry(struct dm_table *t, struct hd_geometry *geo)
+{
+	sector_t sz = (sector_t)geo->cylinders * geo->heads * geo->sectors;
+
+	if (geo->start > sz)
+		return -EINVAL;
+
+	memcpy(&t->forced_geometry, geo, sizeof(*geo));
+
+	return 0;
+}
+
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
 EXPORT_SYMBOL(dm_put_device);
diff -aurp old/include/linux/compat_ioctl.h linux-2.6.16-rc3/include/linux/compat_ioctl.h
--- old/include/linux/compat_ioctl.h	2006-02-15 10:49:47.000000000 -0800
+++ linux-2.6.16-rc3/include/linux/compat_ioctl.h	2006-02-16 11:48:53.000000000 -0800
@@ -151,6 +151,7 @@ COMPATIBLE_IOCTL(DM_TABLE_DEPS)
 COMPATIBLE_IOCTL(DM_TABLE_STATUS)
 COMPATIBLE_IOCTL(DM_LIST_VERSIONS)
 COMPATIBLE_IOCTL(DM_TARGET_MSG)
+COMPATIBLE_IOCTL(DM_DEV_SETGEO)
 /* Big K */
 COMPATIBLE_IOCTL(PIO_FONT)
 COMPATIBLE_IOCTL(GIO_FONT)
diff -aurp old/include/linux/dm-ioctl.h linux-2.6.16-rc3/include/linux/dm-ioctl.h
--- old/include/linux/dm-ioctl.h	2006-02-15 10:49:47.000000000 -0800
+++ linux-2.6.16-rc3/include/linux/dm-ioctl.h	2006-02-16 11:47:48.000000000 -0800
@@ -218,6 +218,7 @@ enum {
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
 	DM_TARGET_MSG_CMD,
+	DM_DEV_SETGEO_CMD
 };
 
 /*
@@ -247,6 +248,7 @@ typedef char ioctl_struct[308];
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
 #define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
+#define DM_DEV_SETGEO_32    _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -270,6 +272,7 @@ typedef char ioctl_struct[308];
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+#define DM_DEV_SETGEO	 _IOWR(DM_IOCTL, DM_DEV_SETGEO_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
 #define DM_VERSION_MINOR	5

--------------010502000305000408000901--
