Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161195AbVKRUoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161195AbVKRUoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVKRUoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:44:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19338 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964806AbVKRUoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:44:19 -0500
Date: Fri, 18 Nov 2005 20:44:11 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper ioctl: add skip lock_fs flag
Message-ID: <20051118204411.GV11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ioctl DM_SKIP_LOCKFS_FLAG for userspace to request that lock_fs
is bypassed when suspending a device.

There's no change to the behaviour of existing code that doesn't 
know about the new flag.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-ioctl.c	2005-11-18 20:35:24.000000000 +0000
+++ linux-2.6.14/drivers/md/dm-ioctl.c	2005-11-18 20:36:57.000000000 +0000
@@ -693,14 +693,18 @@ static int dev_rename(struct dm_ioctl *p
 static int do_suspend(struct dm_ioctl *param)
 {
 	int r = 0;
+	int do_lockfs = 1;
 	struct mapped_device *md;
 
 	md = find_device(param);
 	if (!md)
 		return -ENXIO;
 
+	if (param->flags & DM_SKIP_LOCKFS_FLAG)
+		do_lockfs = 0;
+
 	if (!dm_suspended(md))
-		r = dm_suspend(md, 1);
+		r = dm_suspend(md, do_lockfs);
 
 	if (!r)
 		r = __dev_status(md, param);
@@ -712,6 +716,7 @@ static int do_suspend(struct dm_ioctl *p
 static int do_resume(struct dm_ioctl *param)
 {
 	int r = 0;
+	int do_lockfs = 1;
 	struct hash_cell *hc;
 	struct mapped_device *md;
 	struct dm_table *new_map;
@@ -737,8 +742,10 @@ static int do_resume(struct dm_ioctl *pa
 	/* Do we need to load a new map ? */
 	if (new_map) {
 		/* Suspend if it isn't already suspended */
+		if (param->flags & DM_SKIP_LOCKFS_FLAG)
+			do_lockfs = 0;
 		if (!dm_suspended(md))
-			dm_suspend(md, 1);
+			dm_suspend(md, do_lockfs);
 
 		r = dm_swap_table(md, new_map);
 		if (r) {
Index: linux-2.6.14/include/linux/dm-ioctl.h
===================================================================
--- linux-2.6.14.orig/include/linux/dm-ioctl.h	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/include/linux/dm-ioctl.h	2005-11-18 20:36:57.000000000 +0000
@@ -272,9 +272,9 @@ typedef char ioctl_struct[308];
 #define DM_TARGET_MSG	 _IOWR(DM_IOCTL, DM_TARGET_MSG_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	4
+#define DM_VERSION_MINOR	5
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2005-01-12)"
+#define DM_VERSION_EXTRA	"-ioctl (2005-10-04)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
@@ -301,8 +301,13 @@ typedef char ioctl_struct[308];
 #define DM_BUFFER_FULL_FLAG	(1 << 8) /* Out */
 
 /*
- * Set this to improve performance when you aren't going to use open_count
+ * Set this to improve performance when you aren't going to use open_count.
  */
 #define DM_SKIP_BDGET_FLAG	(1 << 9) /* In */
 
+/*
+ * Set this to avoid attempting to freeze any filesystem when suspending.
+ */
+#define DM_SKIP_LOCKFS_FLAG	(1 << 10) /* In */
+
 #endif				/* _LINUX_DM_IOCTL_H */

