Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932685AbWFUTbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbWFUTbe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932686AbWFUTbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:31:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6049 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932685AbWFUTbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:31:33 -0400
Date: Wed, 21 Jun 2006 20:31:21 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Milan Broz <mbroz@redhat.com>
Subject: [PATCH 01/15] dm: support ioctls on mapped devices
Message-ID: <20060621193121.GP4521@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Milan Broz <mbroz@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Milan Broz <mbroz@redhat.com>
 
Extend the core device-mapper infrastructure to accept arbitrary ioctls
on a mapped device provided that it has exactly one target and it is 
capable of supporting ioctls.

[We can't use unlocked_ioctl because we need 'inode': 'file' might be NULL.
Is it worth changing this?]

Signed-off-by: Milan Broz <mbroz@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.17/drivers/md/dm.c
===================================================================
--- linux-2.6.17.orig/drivers/md/dm.c	2006-06-21 14:45:28.000000000 +0100
+++ linux-2.6.17/drivers/md/dm.c	2006-06-21 18:32:01.000000000 +0100
@@ -20,6 +20,7 @@
 #include <linux/idr.h>
 #include <linux/hdreg.h>
 #include <linux/blktrace_api.h>
+#include <linux/smp_lock.h>
 
 static const char *_name = DM_NAME;
 
@@ -257,6 +258,45 @@ static int dm_blk_getgeo(struct block_de
 	return dm_get_geometry(md, geo);
 }
 
+static int dm_blk_ioctl(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	struct mapped_device *md;
+	struct dm_table *map;
+	struct dm_target *tgt;
+	int r = -ENOTTY;
+
+	/* We don't really need this lock, but we do need 'inode'. */
+	unlock_kernel();
+
+	md = inode->i_bdev->bd_disk->private_data;
+
+	map = dm_get_table(md);
+
+	if (!map || !dm_table_get_size(map))
+		goto out;
+
+	/* We only support devices that have a single target */
+	if (dm_table_get_num_targets(map) != 1)
+		goto out;
+
+	tgt = dm_table_get_target(map, 0);
+
+	if (dm_suspended(md)) {
+		r = -EAGAIN;
+		goto out;
+	}
+
+	if (tgt->type->ioctl)
+		r = tgt->type->ioctl(tgt, inode, file, cmd, arg);
+
+out:
+	dm_table_put(map);
+
+	lock_kernel();
+	return r;
+}
+
 static inline struct dm_io *alloc_io(struct mapped_device *md)
 {
 	return mempool_alloc(md->io_pool, GFP_NOIO);
@@ -1348,6 +1388,7 @@ int dm_suspended(struct mapped_device *m
 static struct block_device_operations dm_blk_dops = {
 	.open = dm_blk_open,
 	.release = dm_blk_close,
+	.ioctl = dm_blk_ioctl,
 	.getgeo = dm_blk_getgeo,
 	.owner = THIS_MODULE
 };
Index: linux-2.6.17/include/linux/device-mapper.h
===================================================================
--- linux-2.6.17.orig/include/linux/device-mapper.h	2006-06-21 14:45:28.000000000 +0100
+++ linux-2.6.17/include/linux/device-mapper.h	2006-06-21 17:45:05.000000000 +0100
@@ -61,6 +61,10 @@ typedef int (*dm_status_fn) (struct dm_t
 
 typedef int (*dm_message_fn) (struct dm_target *ti, unsigned argc, char **argv);
 
+typedef int (*dm_ioctl_fn) (struct dm_target *ti, struct inode *inode,
+			    struct file *filp, unsigned int cmd,
+			    unsigned long arg);
+
 void dm_error(const char *message);
 
 /*
@@ -88,6 +92,7 @@ struct target_type {
 	dm_resume_fn resume;
 	dm_status_fn status;
 	dm_message_fn message;
+	dm_ioctl_fn ioctl;
 };
 
 struct io_restrictions {
Index: linux-2.6.17/include/linux/dm-ioctl.h
===================================================================
--- linux-2.6.17.orig/include/linux/dm-ioctl.h	2006-06-21 14:45:28.000000000 +0100
+++ linux-2.6.17/include/linux/dm-ioctl.h	2006-06-21 17:44:41.000000000 +0100
@@ -285,9 +285,9 @@ typedef char ioctl_struct[308];
 #define DM_DEV_SET_GEOMETRY	_IOWR(DM_IOCTL, DM_DEV_SET_GEOMETRY_CMD, struct dm_ioctl)
 
 #define DM_VERSION_MAJOR	4
-#define DM_VERSION_MINOR	6
+#define DM_VERSION_MINOR	7
 #define DM_VERSION_PATCHLEVEL	0
-#define DM_VERSION_EXTRA	"-ioctl (2006-02-17)"
+#define DM_VERSION_EXTRA	"-ioctl (2006-05-30)"
 
 /* Status bits */
 #define DM_READONLY_FLAG	(1 << 0) /* In/Out */
