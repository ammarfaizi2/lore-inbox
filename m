Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbWEDDjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbWEDDjL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 23:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbWEDDjL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 23:39:11 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:30954 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S1750988AbWEDDjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 23:39:08 -0400
Date: Wed, 3 May 2006 21:39:11 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 7/13: eCryptfs] Dentry operations
Message-ID: <20060504033911.GF28613@hellewell.homeip.net>
References: <20060504031755.GA28257@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504031755.GA28257@hellewell.homeip.net>
X-URL: http://hellewell.homeip.net/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 7th patch in a series of 13 constituting the kernel
components of the eCryptfs cryptographic filesystem.

eCryptfs dentry operations.

Signed-off-by: Phillip Hellewell <phillip@hellewell.homeip.net>
Signed-off-by: Michael Halcrow <mhalcrow@us.ibm.com>

---

 dentry.c |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+)

Index: linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/dentry.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/dentry.c	2006-05-02 19:36:00.000000000 -0600
@@ -0,0 +1,91 @@
+/**
+ * eCryptfs: Linux filesystem encryption layer
+ *
+ * Copyright (C) 1997-2003 Erez Zadok
+ * Copyright (C) 2001-2003 Stony Brook University
+ * Copyright (C) 2004-2006 International Business Machines Corp.
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
+#include <linux/dcache.h>
+#include <linux/namei.h>
+#include "ecryptfs_kernel.h"
+
+/**
+ * Called when the VFS needs to revalidate a dentry. This
+ * is called whenever a name lookup finds a dentry in the
+ * dcache. Most filesystems leave this as NULL, because all their
+ * dentries in the dcache are valid.
+ *
+ * @param dentry ecryptfs dentry
+ * @param nd
+ * @return 1 if valid, 0 otherwise
+ */
+static int ecryptfs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	int err = 1;
+	struct dentry *lower_dentry;
+	struct dentry *saved_dentry;
+	struct vfsmount *saved_vfsmount;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; dentry->d_name.name = [%s]\n",
+			dentry->d_name.name);
+	lower_dentry = ECRYPTFS_DENTRY_TO_LOWER(dentry);
+	if (!lower_dentry) {
+		err = 0;
+		goto out;
+	}
+	if (!lower_dentry->d_op || !lower_dentry->d_op->d_revalidate)
+		goto out;
+	saved_dentry = nd->dentry;
+	saved_vfsmount = nd->mnt;
+	nd->dentry = lower_dentry;
+	nd->mnt = ECRYPTFS_SUPERBLOCK_TO_PRIVATE(dentry->d_sb)->lower_mnt;
+	err = lower_dentry->d_op->d_revalidate(lower_dentry, nd);
+	nd->dentry = saved_dentry;
+	nd->mnt = saved_vfsmount;
+out:
+	ecryptfs_printk(KERN_DEBUG, "Exit; err = [%d]\n", err);
+	return err;
+}
+
+kmem_cache_t *ecryptfs_dentry_info_cache;
+
+/**
+ * Called when a dentry is really deallocated.
+ */
+static void ecryptfs_d_release(struct dentry *dentry)
+{
+	struct dentry *lower_dentry;
+
+	ecryptfs_printk(KERN_DEBUG, "Enter; dentry->d_name->name = [%s]\n",
+			dentry->d_name.name);
+	lower_dentry = ECRYPTFS_DENTRY_TO_LOWER(dentry);
+	if (ECRYPTFS_DENTRY_TO_PRIVATE(dentry))
+		kmem_cache_free(ecryptfs_dentry_info_cache,
+				ECRYPTFS_DENTRY_TO_PRIVATE(dentry));
+	if (lower_dentry)
+		dput(lower_dentry);
+	ecryptfs_printk(KERN_DEBUG, "Exit\n");
+	return;
+}
+
+struct dentry_operations ecryptfs_dops = {
+	.d_revalidate = ecryptfs_d_revalidate,
+	.d_release = ecryptfs_d_release,
+};
