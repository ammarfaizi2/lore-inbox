Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWIAB45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWIAB45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbWIAB45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:56:57 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:11400 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030183AbWIAB44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:56:56 -0400
Date: Thu, 31 Aug 2006 21:56:45 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 16/22][RFC] Unionfs: Handling of stale inodes
Message-ID: <20060901015645.GQ5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Provides nicer handling of stale inodes.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/stale_inode.c |  116 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/stale_inode.c linux-2.6-git-unionfs/fs/unionfs/stale_inode.c
--- linux-2.6-git/fs/unionfs/stale_inode.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/stale_inode.c	2006-08-31 19:04:01.000000000 -0400
@@ -0,0 +1,116 @@
+/*
+ *  Adpated from linux/fs/bad_inode.c
+ *
+ *  Copyright (C) 1997, Stephen Tweedie
+ *
+ *  Provide stub functions for "stale" inodes, a bit friendlier than the
+ *  -EIO that bad_inode.c does.
+ */
+
+#include <linux/config.h>
+#include <linux/version.h>
+
+#include <linux/fs.h>
+#include <linux/stat.h>
+#include <linux/sched.h>
+
+static struct address_space_operations unionfs_stale_aops;
+
+/* declarations for "sparse */
+extern struct inode_operations stale_inode_ops;
+
+/*
+ * The follow_link operation is special: it must behave as a no-op
+ * so that a stale root inode can at least be unmounted. To do this
+ * we must dput() the base and return the dentry with a dget().
+ */
+static void *stale_follow_link(struct dentry *dent, struct nameidata *nd)
+{
+	int err = vfs_follow_link(nd, ERR_PTR(-ESTALE));
+	return ERR_PTR(err);
+}
+
+static int return_ESTALE(void)
+{
+	return -ESTALE;
+}
+
+#define ESTALE_ERROR ((void *) (return_ESTALE))
+
+static struct file_operations stale_file_ops = {
+	.llseek = ESTALE_ERROR,
+	.read = ESTALE_ERROR,
+	.write = ESTALE_ERROR,
+	.readdir = ESTALE_ERROR,
+	.poll = ESTALE_ERROR,
+	.ioctl = ESTALE_ERROR,
+	.mmap = ESTALE_ERROR,
+	.open = ESTALE_ERROR,
+	.flush = ESTALE_ERROR,
+	.release = ESTALE_ERROR,
+	.fsync = ESTALE_ERROR,
+	.fasync = ESTALE_ERROR,
+	.lock = ESTALE_ERROR,
+};
+
+struct inode_operations stale_inode_ops = {
+	.create = ESTALE_ERROR,
+	.lookup = ESTALE_ERROR,
+	.link = ESTALE_ERROR,
+	.unlink = ESTALE_ERROR,
+	.symlink = ESTALE_ERROR,
+	.mkdir = ESTALE_ERROR,
+	.rmdir = ESTALE_ERROR,
+	.mknod = ESTALE_ERROR,
+	.rename = ESTALE_ERROR,
+	.readlink = ESTALE_ERROR,
+	.follow_link = stale_follow_link,
+	.truncate = ESTALE_ERROR,
+	.permission = ESTALE_ERROR,
+};
+
+/*
+ * When a filesystem is unable to read an inode due to an I/O error in
+ * its read_inode() function, it can call make_stale_inode() to return a
+ * set of stubs which will return ESTALE errors as required.
+ *
+ * We only need to do limited initialisation: all other fields are
+ * preinitialised to zero automatically.
+ */
+
+/**
+ *	make_stale_inode - mark an inode stale due to an I/O error
+ *	@inode: Inode to mark stale
+ *
+ *	When an inode cannot be read due to a media or remote network
+ *	failure this function makes the inode "stale" and causes I/O operations
+ *	on it to fail from this point on.
+ */
+
+void make_stale_inode(struct inode *inode)
+{
+	inode->i_mode = S_IFREG;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+	inode->i_op = &stale_inode_ops;
+	inode->i_fop = &stale_file_ops;
+	inode->i_mapping->a_ops = &unionfs_stale_aops;
+}
+
+/*
+ * This tests whether an inode has been flagged as stale. The test uses
+ * &stale_inode_ops to cover the case of invalidated inodes as well as
+ * those created by make_stale_inode() above.
+ */
+
+/**
+ *	is_stale_inode - is an inode errored
+ *	@inode: inode to test
+ *
+ *	Returns true if the inode in question has been marked as stale.
+ */
+
+int is_stale_inode(struct inode *inode)
+{
+	return (inode->i_op == &stale_inode_ops);
+}
+
