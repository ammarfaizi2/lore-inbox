Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262352AbUKKSP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbUKKSP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262350AbUKKSOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 13:14:50 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59020 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262301AbUKKSMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 13:12:09 -0500
Date: Thu, 11 Nov 2004 18:12:03 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: [1/2] Add DM_TARGET_MSG
Message-ID: <20041111181203.GD8857@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add DM_TARGET_MSG ioctl so data can be passed to a dm target 
after its table has been loaded.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
--- diff/drivers/md/dm-ioctl.c	2004-06-30 14:25:46.000000000 +0100
+++ source/drivers/md/dm-ioctl.c	2004-11-10 15:05:36.000000000 +0000
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2001, 2002 Sistina Software (UK) Limited.
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the GPL.
  */
@@ -1097,6 +1098,67 @@
 	return r;
 }
 
+/*
+ * Pass a message to the target that's at the supplied device offset.
+ */
+static int target_message(struct dm_ioctl *param, size_t param_size)
+{
+	int r, argc;
+	char **argv;
+	struct mapped_device *md;
+	struct dm_table *table;
+	struct dm_target *ti;
+	struct dm_target_msg *tmsg = (void *) param + param->data_start;
+
+	md = find_device(param);
+	if (!md)
+		return -ENXIO;
+
+	r = __dev_status(md, param);
+	if (r)
+		goto out;
+
+	if (tmsg < (struct dm_target_msg *) (param + 1) ||
+	    invalid_str(tmsg->message, (void *) param + param_size)) {
+		DMWARN("Invalid target message parameters.");
+		r = -EINVAL;
+		goto out;
+	}
+
+	r = dm_split_args(&argc, &argv, tmsg->message);
+	if (r) {
+		DMWARN("Failed to split target message parameters");
+		goto out;
+	}
+
+	table = dm_get_table(md);
+	if (!table)
+		goto out_argv;
+
+	if (tmsg->sector >= dm_table_get_size(table)) {
+		DMWARN("Target message sector outside device.");
+		r = -EINVAL;
+		goto out_table;
+	}
+
+	ti = dm_table_find_target(table, tmsg->sector);
+	if (ti->type->message)
+		r = ti->type->message(ti, argc, argv);
+	else {
+		DMWARN("Target type does not support messages");
+		r = -EINVAL;
+	}
+
+ out_table:
+	dm_table_put(table);
+ out_argv:
+	kfree(argv);
+ out:
+	param->data_size = 0;
+	dm_put(md);
+	return r;
+}
+
 /*-----------------------------------------------------------------
  * Implementation of open/close/ioctl on the special char
  * device.
@@ -1123,7 +1185,9 @@
 		{DM_TABLE_DEPS_CMD, table_deps},
 		{DM_TABLE_STATUS_CMD, table_status},
 
-		{DM_LIST_VERSIONS_CMD, list_versions}
+		{DM_LIST_VERSIONS_CMD, list_versions},
+
+		{DM_TARGET_MSG_CMD, target_message}
 	};
 
 	return (cmd >= ARRAY_SIZE(_ioctls)) ? NULL : _ioctls[cmd].fn;
--- diff/drivers/md/dm-table.c	2004-10-19 16:47:25.000000000 +0100
+++ source/drivers/md/dm-table.c	2004-11-10 15:05:36.000000000 +0000
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2001 Sistina Software (UK) Limited.
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the GPL.
  */
@@ -575,7 +576,7 @@
 /*
  * Destructively splits up the argument list to pass to ctr.
  */
-static int split_args(int *argc, char ***argvp, char *input)
+int dm_split_args(int *argc, char ***argvp, char *input)
 {
 	char *start, *end = input, *out, **argv = NULL;
 	unsigned array_size = 0;
@@ -688,7 +689,7 @@
 		goto bad;
 	}
 
-	r = split_args(&argc, &argv, params);
+	r = dm_split_args(&argc, &argv, params);
 	if (r) {
 		tgt->error = "couldn't split parameters (insufficient memory)";
 		goto bad;
--- diff/drivers/md/dm.h	2004-11-10 15:05:30.000000000 +0000
+++ source/drivers/md/dm.h	2004-11-10 15:05:36.000000000 +0000
@@ -2,6 +2,7 @@
  * Internal header file for device mapper
  *
  * Copyright (C) 2001, 2002 Sistina Software
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the LGPL.
  */
@@ -165,6 +166,8 @@
 	return (n << 9);
 }
 
+int dm_split_args(int *argc, char ***argvp, char *input);
+
 /*
  * The device-mapper can be driven through one of two interfaces;
  * ioctl or filesystem, depending which patch you have applied.
--- diff/include/linux/compat_ioctl.h	2004-10-28 23:14:44.000000000 +0100
+++ source/include/linux/compat_ioctl.h	2004-11-10 15:05:36.000000000 +0000
@@ -140,6 +140,7 @@
 COMPATIBLE_IOCTL(DM_TABLE_DEPS_32)
 COMPATIBLE_IOCTL(DM_TABLE_STATUS_32)
 COMPATIBLE_IOCTL(DM_LIST_VERSIONS_32)
+COMPATIBLE_IOCTL(DM_TARGET_MSG_32)
 COMPATIBLE_IOCTL(DM_VERSION)
 COMPATIBLE_IOCTL(DM_REMOVE_ALL)
 COMPATIBLE_IOCTL(DM_LIST_DEVICES)
@@ -154,6 +155,7 @@
 COMPATIBLE_IOCTL(DM_TABLE_DEPS)
 COMPATIBLE_IOCTL(DM_TABLE_STATUS)
 COMPATIBLE_IOCTL(DM_LIST_VERSIONS)
+COMPATIBLE_IOCTL(DM_TARGET_MSG)
 /* Big K */
 COMPATIBLE_IOCTL(PIO_FONT)
 COMPATIBLE_IOCTL(GIO_FONT)
--- diff/include/linux/device-mapper.h	2004-05-19 22:12:59.000000000 +0100
+++ source/include/linux/device-mapper.h	2004-11-10 15:05:36.000000000 +0000
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2001 Sistina Software (UK) Limited.
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the LGPL.
  */
@@ -57,6 +58,8 @@
 typedef int (*dm_status_fn) (struct dm_target *ti, status_type_t status_type,
 			     char *result, unsigned int maxlen);
 
+typedef int (*dm_message_fn) (struct dm_target *ti, unsigned argc, char **argv);
+
 void dm_error(const char *message);
 
 /*
@@ -82,6 +85,7 @@
 	dm_suspend_fn suspend;
 	dm_resume_fn resume;
 	dm_status_fn status;
+	dm_message_fn message;
 };
 
 struct io_restrictions {
--- diff/include/linux/dm-ioctl.h	2004-05-19 22:12:59.000000000 +0100
+++ source/include/linux/dm-ioctl.h	2004-11-10 15:05:36.000000000 +0000
@@ -1,5 +1,6 @@
 /*
  * Copyright (C) 2001 - 2003 Sistina Software (UK) Limited.
+ * Copyright (C) 2004 Red Hat, Inc. All rights reserved.
  *
  * This file is released under the LGPL.
  */
@@ -76,6 +77,9 @@
  *
  * DM_TABLE_STATUS:
  * Return the targets status for the 'active' table.
+ *
+ * DM_TARGET_MSG:
+ * Pass a message string to the target at a specific offset of a device.
  */
 
 /*
@@ -179,6 +183,15 @@
 };
 
 /*
+ * Used to pass message to a target
+ */
+struct dm_target_msg {
+	uint64_t sector;	/* Device sector */
+
+	char message[0];
+};
+
+/*
  * If you change this make sure you make the corresponding change
  * to dm-ioctl.c:lookup_ioctl()
  */
@@ -204,6 +217,7 @@
 
 	/* Added later */
 	DM_LIST_VERSIONS_CMD,
+	DM_TARGET_MSG_CMD,
 };
 
 /*
@@ -232,6 +246,7 @@
 #define DM_TABLE_DEPS_32    _IOWR(DM_IOCTL, DM_TABLE_DEPS_CMD, ioctl_struct)
 #define DM_TABLE_STATUS_32  _IOWR(DM_IOCTL, DM_TABLE_STATUS_CMD, ioctl_struct)
 #define DM_LIST_VERSIONS_32 _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, ioctl_struct)
+#define DM_TARGET_MSG_32    _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, ioctl_struct)
 #endif
 
 #define DM_IOCTL 0xfd
@@ -254,10 +269,12 @@
 
 #define DM_LIST_VERSIONS _IOWR(DM_IOCTL, DM_LIST_VERSIONS_CMD, struct dm_ioctl)
 
+#define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
+
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	1
+#define DM_VERSION_MINOR	2
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2003-12-10)"
+#define DM_VERSION_EXTRA	"-ioctl (2004-06-08)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
