Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbVKCDwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbVKCDwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 22:52:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbVKCDwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 22:52:50 -0500
Received: from c-67-182-200-232.hsd1.ut.comcast.net ([67.182.200.232]:44782
	"EHLO sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1030339AbVKCDwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 22:52:49 -0500
Date: Wed, 2 Nov 2005 20:53:11 -0700
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: phillip@hellewell.homeip.net, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, yoder1@us.ibm.com
Subject: [PATCH 8/12: eCryptfs] Dentry operations
Message-ID: <20051103035311.GH3005@sshock.rn.byu.edu>
References: <20051103033220.GD2772@sshock.rn.byu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103033220.GD2772@sshock.rn.byu.edu>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eCryptfs dentry operations.

Signed off by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed off by: Michael Halcrow <mhalcrow@us.ibm.com>
Signed off by: Michael Thompson <mmcthomps@us.ibm.com>
Signed off by: Kent Yoder <yoder1@us.ibm.com>

 dentry.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 110 insertions(+)
--- linux-2.6.14-rc5-mm1/fs/ecryptfs/dentry.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.14-rc5-mm1-ecryptfs/fs/ecryptfs/dentry.c	2005-11-01 14:40:09.000000000 -0600
@@ -0,0 +1,110 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (c) 1997-2003 Erez Zadok
+ * Copyright (c) 2001-2003 Stony Brook University
+ * Copyright (c) 2005 International Business Machines Corp.
+ *   Author(s): Michael A. Halcrow <mahalcro@us.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
+ * 02111-1307, USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+# include <config.h>
+#endif				/* HAVE_CONFIG_H */
+#include <linux/dcache.h>
+#include <linux/namei.h>
+#include "ecryptfs_kernel.h"
+
+/**
+ * called when the VFS needs to revalidate a dentry. This
+ * is called whenever a name lookup finds a dentry in the
+ * dcache. Most filesystems leave this as NULL, because all their
+ * dentries in the dcache are valid.
+ *
+ *
+ * @param dentry	ecryptfs dentry
+ * @param nd		
+ * @return 		1 if valid, 0 otherwise
+ */
+static int ecryptfs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	int err = 1;
+	struct dentry *lower_dentry;
+	struct dentry *saved_dentry;
+	struct vfsmount *saved_vfsmount;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dentry->d_name.name = [%s]\n",
+			dentry->d_name.name);
+	lower_dentry = ecryptfs_lower_dentry(dentry);
+	if (!lower_dentry) {
+		err = 0;
+		goto out;
+	}
+	if (!lower_dentry->d_op || !lower_dentry->d_op->d_revalidate)
+		goto out;
+	/* Call the lower dentry's d_revalidate (assuming it has one) */
+	saved_dentry = nd->dentry;
+	saved_vfsmount = nd->mnt;
+	nd->dentry = lower_dentry;
+	nd->mnt = SUPERBLOCK_TO_PRIVATE(dentry->d_sb)->lower_mnt;
+	err = lower_dentry->d_op->d_revalidate(lower_dentry, nd);
+	nd->dentry = saved_dentry;
+	nd->mnt = saved_vfsmount;
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit; err = [%d]\n", err);
+	return err;
+}
+
+kmem_cache_t *ecryptfs_dentry_info_cache;
+
+/* Notes:
+ * Called when a dentry is really deallocated
+ * Sanity check? wrapper around ecryptfs_dput()
+ */
+static void ecryptfs_d_release(struct dentry *dentry)
+{
+	struct dentry *lower_dentry;
+	ecryptfs_printk(1, KERN_NOTICE, "Enter; dentry->d_name->name = [%s]\n",
+			dentry->d_name.name);
+	if (!dentry) {
+		ecryptfs_printk(0, KERN_ERR, "NULL dentry\n");
+		goto out;
+	}
+	if (!DENTRY_TO_PRIVATE(dentry)) {
+		ecryptfs_printk(1, KERN_ERR, "dentry without private data: "
+				"[%*s]\n", dentry->d_name.len,
+				dentry->d_name.name);
+		goto out;
+	}
+	lower_dentry = DENTRY_TO_LOWER(dentry);
+	/* TODO: Why do we look for an inode here? We should be
+	 * freeing regardless */
+	/* OLD: if (lower_dentry && lower_dentry->d_inode) { */
+	if (DENTRY_TO_PRIVATE(dentry)) {
+		ecryptfs_kmem_cache_free(ecryptfs_dentry_info_cache,
+					 DENTRY_TO_PRIVATE(dentry));
+	}
+	if (lower_dentry)
+		ecryptfs_dput(lower_dentry);
+out:
+	ecryptfs_printk(1, KERN_NOTICE, "Exit\n");
+	return;
+}
+
+struct dentry_operations ecryptfs_dops = {
+	.d_revalidate = ecryptfs_d_revalidate,
+	.d_release = ecryptfs_d_release,
+};
