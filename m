Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbWEMDpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbWEMDpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 23:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWEMDpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 23:45:06 -0400
Received: from c-67-177-57-20.hsd1.ut.comcast.net ([67.177.57.20]:23540 "EHLO
	sshock.homelinux.net") by vger.kernel.org with ESMTP
	id S932272AbWEMDpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 23:45:04 -0400
Date: Fri, 12 May 2006 21:45:07 -0600
From: Phillip Hellewell <phillip@hellewell.homeip.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@ftp.linux.org.uk, mike@halcrow.us, mhalcrow@us.ibm.com,
       mcthomps@us.ibm.com, toml@us.ibm.com, yoder1@us.ibm.com,
       James Morris <jmorris@namei.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
Subject: [PATCH 7/13: eCryptfs] Dentry operations
Message-ID: <20060513034507.GG18631@hellewell.homeip.net>
References: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
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
+++ linux-2.6.17-rc3-mm1-ecryptfs/fs/ecryptfs/dentry.c	2006-05-12 20:00:26.000000000 -0600
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
+ * ecryptfs_d_revalidate - revalidate an ecryptfs dentry
+ * @dentry: The ecryptfs dentry
+ * @nd: The associated nameidata
+ *
+ * Called when the VFS needs to revalidate a dentry. This
+ * is called whenever a name lookup finds a dentry in the
+ * dcache. Most filesystems leave this as NULL, because all their
+ * dentries in the dcache are valid.
+ * 
+ * Returns 1 if valid, 0 otherwise.
+ *
+ */
+static int ecryptfs_d_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	int err = 1;
+	struct dentry *lower_dentry;
+	struct dentry *saved_dentry;
+	struct vfsmount *saved_vfsmount;
+
+	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	if (!lower_dentry) {
+		err = 0;
+		goto out;
+	}
+	if (!lower_dentry->d_op || !lower_dentry->d_op->d_revalidate)
+		goto out;
+	saved_dentry = nd->dentry;
+	saved_vfsmount = nd->mnt;
+	nd->dentry = lower_dentry;
+	nd->mnt = ecryptfs_superblock_to_private(dentry->d_sb)->lower_mnt;
+	err = lower_dentry->d_op->d_revalidate(lower_dentry, nd);
+	nd->dentry = saved_dentry;
+	nd->mnt = saved_vfsmount;
+out:
+	return err;
+}
+
+struct kmem_cache *ecryptfs_dentry_info_cache;
+
+/**
+ * ecryptfs_d_release
+ * @dentry: The ecryptfs dentry
+ *
+ * Called when a dentry is really deallocated.
+ */
+static void ecryptfs_d_release(struct dentry *dentry)
+{
+	struct dentry *lower_dentry;
+
+	lower_dentry = ecryptfs_dentry_to_lower(dentry);
+	if (ecryptfs_dentry_to_private(dentry))
+		kmem_cache_free(ecryptfs_dentry_info_cache,
+				ecryptfs_dentry_to_private(dentry));
+	if (lower_dentry)
+		dput(lower_dentry);
+	return;
+}
+
+struct dentry_operations ecryptfs_dops = {
+	.d_revalidate = ecryptfs_d_revalidate,
+	.d_release = ecryptfs_d_release,
+};
