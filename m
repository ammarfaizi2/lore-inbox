Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbUBTPjk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 10:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbUBTPiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 10:38:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51368 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261294AbUBTPeB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 10:34:01 -0500
Date: Fri, 20 Feb 2004 15:37:04 +0000
From: Joe Thornber <thornber@redhat.com>
To: Joe Thornber <thornber@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [Patch 5/6] dm: list targets cmd
Message-ID: <20040220153704.GS27549@reti>
References: <20040220153145.GN27549@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040220153145.GN27549@reti>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

List targets ioctl.  [Patrick Caulfield]
--- diff/drivers/md/dm-crypt.c	2004-02-18 15:16:36.000000000 +0000
+++ source/drivers/md/dm-crypt.c	2004-02-18 15:47:15.000000000 +0000
@@ -720,6 +720,7 @@ static int crypt_status(struct dm_target
 
 static struct target_type crypt_target = {
 	.name   = "crypt",
+	.version= {1, 0, 0},
 	.module = THIS_MODULE,
 	.ctr    = crypt_ctr,
 	.dtr    = crypt_dtr,
--- diff/drivers/md/dm-ioctl.c	2004-02-18 15:34:04.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2004-02-18 15:45:30.000000000 +0000
@@ -33,6 +33,14 @@ struct hash_cell {
 	struct dm_table *new_map;
 };
 
+struct vers_iter {
+    size_t param_size;
+    struct dm_target_versions *vers, *old_vers;
+    char *end;
+    uint32_t flags;
+};
+
+
 #define NUM_BUCKETS 64
 #define MASK_BUCKETS (NUM_BUCKETS - 1)
 static struct list_head _name_buckets[NUM_BUCKETS];
@@ -409,6 +417,80 @@ static int list_devices(struct dm_ioctl 
 	return 0;
 }
 
+static void list_version_get_needed(struct target_type *tt, void *param)
+{
+    int *needed = param;
+
+    *needed += strlen(tt->name);
+    *needed += sizeof(tt->version);
+    *needed += ALIGN_MASK;
+}
+
+static void list_version_get_info(struct target_type *tt, void *param)
+{
+    struct vers_iter *info = param;
+
+    /* Check space - it might have changed since the first iteration */
+    if ((char *)info->vers + sizeof(tt->version) + strlen(tt->name) + 1 >
+	info->end) {
+
+	info->flags = DM_BUFFER_FULL_FLAG;
+	return;
+    }
+
+    if (info->old_vers)
+	info->old_vers->next = (uint32_t) ((void *)info->vers -
+					   (void *)info->old_vers);
+    info->vers->version[0] = tt->version[0];
+    info->vers->version[1] = tt->version[1];
+    info->vers->version[2] = tt->version[2];
+    info->vers->next = 0;
+    strcpy(info->vers->name, tt->name);
+
+    info->old_vers = info->vers;
+    info->vers = align_ptr(((void *) ++info->vers) + strlen(tt->name) + 1);
+}
+
+static int list_versions(struct dm_ioctl *param, size_t param_size)
+{
+	size_t len, needed = 0;
+	struct dm_target_versions *vers;
+	struct vers_iter iter_info;
+
+	/*
+	 * Loop through all the devices working out how much
+	 * space we need.
+	 */
+	dm_target_iterate(list_version_get_needed, &needed);
+
+	/*
+	 * Grab our output buffer.
+	 */
+	vers = get_result_buffer(param, param_size, &len);
+	if (len < needed) {
+		param->flags |= DM_BUFFER_FULL_FLAG;
+		goto out;
+	}
+	param->data_size = param->data_start + needed;
+
+	iter_info.param_size = param_size;
+	iter_info.old_vers = NULL;
+	iter_info.vers = vers;
+	iter_info.flags = 0;
+	iter_info.end = (char *)vers+len;
+
+	/*
+	 * Now loop through filling out the names & versions.
+	 */
+	dm_target_iterate(list_version_get_info, &iter_info);
+	param->flags |= iter_info.flags;
+
+ out:
+	return 0;
+}
+
+
+
 static int check_name(const char *name)
 {
 	if (strchr(name, '/')) {
@@ -1038,7 +1120,9 @@ static ioctl_fn lookup_ioctl(unsigned in
 		{DM_TABLE_LOAD_CMD, table_load},
 		{DM_TABLE_CLEAR_CMD, table_clear},
 		{DM_TABLE_DEPS_CMD, table_deps},
-		{DM_TABLE_STATUS_CMD, table_status}
+		{DM_TABLE_STATUS_CMD, table_status},
+
+		{DM_LIST_VERSIONS_CMD, list_versions}
 	};
 
 	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
@@ -1112,7 +1196,9 @@ static int validate_params(uint cmd, str
 	param->flags &= ~DM_BUFFER_FULL_FLAG;
 
 	/* Ignores parameters */
-	if (cmd == DM_REMOVE_ALL_CMD || cmd == DM_LIST_DEVICES_CMD)
+	if (cmd == DM_REMOVE_ALL_CMD ||
+	    cmd == DM_LIST_DEVICES_CMD ||
+	    cmd == DM_LIST_VERSIONS_CMD)
 		return 0;
 
 	/* Unless creating, either name or uuid but not both */
--- diff/drivers/md/dm-linear.c	2004-02-18 15:16:23.000000000 +0000
+++ source/drivers/md/dm-linear.c	2004-02-18 15:44:06.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2001 Sistina Software (UK) Limited.
+ * Copyright (C) 2001-2003 Sistina Software (UK) Limited.
  *
  * This file is released under the GPL.
  */
@@ -97,6 +97,7 @@ static int linear_status(struct dm_targe
 
 static struct target_type linear_target = {
 	.name   = "linear",
+	.version= {1, 0, 1},
 	.module = THIS_MODULE,
 	.ctr    = linear_ctr,
 	.dtr    = linear_dtr,
--- diff/drivers/md/dm-stripe.c	2004-02-18 15:16:23.000000000 +0000
+++ source/drivers/md/dm-stripe.c	2004-02-18 15:44:06.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2001 Sistina Software (UK) Limited.
+ * Copyright (C) 2001-2003 Sistina Software (UK) Limited.
  *
  * This file is released under the GPL.
  */
@@ -212,6 +212,7 @@ static int stripe_status(struct dm_targe
 
 static struct target_type stripe_target = {
 	.name   = "striped",
+	.version= {1, 0, 1},
 	.module = THIS_MODULE,
 	.ctr    = stripe_ctr,
 	.dtr    = stripe_dtr,
--- diff/drivers/md/dm-target.c	2004-02-18 15:38:06.000000000 +0000
+++ source/drivers/md/dm-target.c	2004-02-18 15:44:06.000000000 +0000
@@ -96,6 +96,20 @@ static struct tt_internal *alloc_target(
 	return ti;
 }
 
+
+int dm_target_iterate(void (*iter_func)(struct target_type *tt,
+					void *param), void *param)
+{
+	struct tt_internal *ti;
+
+	down_read(&_lock);
+	list_for_each_entry (ti, &_targets, list)
+		iter_func(&ti->tt, param);
+	up_read(&_lock);
+
+	return 0;
+}
+
 int dm_register_target(struct target_type *t)
 {
 	int rv = 0;
@@ -161,6 +175,7 @@ static int io_err_map(struct dm_target *
 
 static struct target_type error_target = {
 	.name = "error",
+	.version = {1, 0, 1},
 	.ctr  = io_err_ctr,
 	.dtr  = io_err_dtr,
 	.map  = io_err_map,
--- diff/drivers/md/dm.h	2004-02-18 15:15:13.000000000 +0000
+++ source/drivers/md/dm.h	2004-02-18 15:44:06.000000000 +0000
@@ -123,6 +123,8 @@ int dm_target_init(void);
 void dm_target_exit(void);
 struct target_type *dm_get_target_type(const char *name);
 void dm_put_target_type(struct target_type *t);
+int dm_target_iterate(void (*iter_func)(struct target_type *tt,
+					void *param), void *param);
 
 
 /*-----------------------------------------------------------------
--- diff/include/linux/device-mapper.h	2004-02-18 15:16:23.000000000 +0000
+++ source/include/linux/device-mapper.h	2004-02-18 15:44:06.000000000 +0000
@@ -74,6 +74,7 @@ void dm_put_device(struct dm_target *ti,
 struct target_type {
 	const char *name;
 	struct module *module;
+        unsigned version[3];
 	dm_ctr_fn ctr;
 	dm_dtr_fn dtr;
 	dm_map_fn map;
@@ -104,7 +105,7 @@ struct dm_target {
 	sector_t split_io;
 
 	/*
-	 * These are automaticall filled in by
+	 * These are automatically filled in by
 	 * dm_table_get_device.
 	 */
 	struct io_restrictions limits;
--- diff/include/linux/dm-ioctl.h	2003-08-20 14:16:15.000000000 +0100
+++ source/include/linux/dm-ioctl.h	2004-02-18 15:44:17.000000000 +0000
@@ -163,6 +163,16 @@ struct dm_name_list {
 };
 
 /*
+ * Used to retrieve the target versions
+ */
+struct dm_target_versions {
+        uint32_t next;
+        uint32_t version[3];
+
+        char name[0];
+};
+
+/*
  * If you change this make sure you make the corresponding change
  * to dm-ioctl.c:lookup_ioctl()
  */
@@ -185,6 +195,9 @@ enum {
 	DM_TABLE_CLEAR_CMD,
 	DM_TABLE_DEPS_CMD,
 	DM_TABLE_STATUS_CMD,
+
+	/* Added later */
+	DM_LIST_VERSIONS_CMD,
 };
 
 #define DM_IOCTL 0xfd
@@ -205,10 +218,12 @@ enum {
 #define DM_TABLE_DEPS    _IOWR(DM_IOCTL, DM_TABLE_DEPS_CMD, struct dm_ioctl)
 #define DM_TABLE_STATUS  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, struct dm_ioctl)
 
+#define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
+
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	0
+#define DM_VERSION_MINOR	1
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2003-06-04)"
+#define DM_VERSION_EXTRA	"-ioctl (2003-12-10)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
