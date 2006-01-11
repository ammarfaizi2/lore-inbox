Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWAKBOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWAKBOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWAKBOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:14:33 -0500
Received: from cpe-70-112-167-32.austin.res.rr.com ([70.112.167.32]:990 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932579AbWAKBOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:14:32 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH]: v9fs: add readpage support
Cc: akpm@osdl.org, v9fs-developer@lists.sourceforge.org
Message-Id: <20060111011437.451FD5A809A@localhost.localdomain>
Date: Tue, 10 Jan 2006 19:14:37 -0600 (CST)
From: ericvh@gmail.com (Eric Van Hensbergen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] v9fs: add readpage support

v9fs mmap support was originally removed from v9fs at Al Viro's request,
but recently there have been requests from folks who want readpage
functionality (primarily to enable execution of files mounted via 9P).
This patch adds readpage support (but not writepage which contained most of
the objectionable code).  It passes FSX (and other regressions) so it
should be relatively safe.

Signed-off-by: Eric Van Hensbergen <ericvh@gmail.com>

---

 fs/9p/Makefile    |    1 
 fs/9p/v9fs_vfs.h  |    1 
 fs/9p/vfs_addr.c  |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/9p/vfs_file.c  |    3 +
 fs/9p/vfs_inode.c |    1 
 5 files changed, 115 insertions(+), 0 deletions(-)
 create mode 100644 fs/9p/vfs_addr.c

2d3190fce2418fc07d672ceb9d072b1cffb8be7f
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
index 3d02308..2f4ce43 100644
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_9P_FS) := 9p2000.o
 	conv.o \
 	vfs_super.o \
 	vfs_inode.o \
+	vfs_addr.o \
 	vfs_file.o \
 	vfs_dir.o \
 	vfs_dentry.o \
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index c78502a..69cf290 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -39,6 +39,7 @@
  */
 
 extern struct file_system_type v9fs_fs_type;
+extern struct address_space_operations v9fs_addr_operations;
 extern struct file_operations v9fs_file_operations;
 extern struct file_operations v9fs_dir_operations;
 extern struct dentry_operations v9fs_dentry_operations;
diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
new file mode 100644
index 0000000..6ec1d64
--- /dev/null
+++ b/fs/9p/vfs_addr.c
@@ -0,0 +1,109 @@
+/*
+ *  linux/fs/9p/vfs_addr.c
+ *
+ * This file contians vfs address (mmap) ops for 9P2000. 
+ *
+ *  Copyright (C) 2005 by Eric Van Hensbergen <ericvh@gmail.com>
+ *  Copyright (C) 2002 by Ron Minnich <rminnich@lanl.gov>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to:
+ *  Free Software Foundation
+ *  51 Franklin Street, Fifth Floor
+ *  Boston, MA  02111-1301  USA
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/file.h>
+#include <linux/stat.h>
+#include <linux/string.h>
+#include <linux/smp_lock.h>
+#include <linux/inet.h>
+#include <linux/version.h>
+#include <linux/pagemap.h>
+#include <linux/idr.h>
+
+#include "debug.h"
+#include "v9fs.h"
+#include "9p.h"
+#include "v9fs_vfs.h"
+#include "fid.h"
+
+/**
+ * v9fs_vfs_readpage - read an entire page in from 9P
+ *
+ * @file: file being read 
+ * @page: structure to page
+ *
+ */
+
+static int v9fs_vfs_readpage(struct file *filp, struct page *page)
+{  
+	char *buffer = NULL;
+	int retval = -EIO;
+	loff_t offset = page_offset(page);
+	int count = PAGE_CACHE_SIZE;
+	struct inode *inode = filp->f_dentry->d_inode;
+	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
+	int rsize = v9ses->maxdata - V9FS_IOHDRSZ;
+	struct v9fs_fid *v9f = filp->private_data;
+	struct v9fs_fcall *fcall = NULL;
+	int fid = v9f->fid;
+	int total = 0;
+	int result = 0;
+
+	buffer = kmap(page);
+	do {
+		if (count < rsize)
+			rsize = count;
+
+		result = v9fs_t_read(v9ses, fid, offset, rsize, &fcall);
+
+		if (result < 0) {
+			printk(KERN_ERR "v9fs_t_read returned %d\n",
+			       result);
+
+			kfree(fcall);
+			goto UnmapAndUnlock;
+		} else
+			offset += result;
+
+		memcpy(buffer, fcall->params.rread.data, result);
+
+		count -= result;
+		buffer += result;
+		total += result;
+
+		kfree(fcall);
+
+		if (result < rsize)
+			break;
+	} while (count);
+
+	memset(buffer, 0, count);
+	flush_dcache_page(page);
+	SetPageUptodate(page);
+	retval = 0;
+
+      UnmapAndUnlock:
+	kunmap(page);
+	unlock_page(page);
+	return retval;
+}
+
+struct address_space_operations v9fs_addr_operations = {
+      .readpage = v9fs_vfs_readpage,
+};
diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 6852f0e..feddc5c 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -289,6 +289,8 @@ v9fs_file_write(struct file *filp, const
 		total += result;
 	} while (count);
 
+	invalidate_inode_pages2(inode->i_mapping);
+
 	return total;
 }
 
@@ -299,4 +301,5 @@ struct file_operations v9fs_file_operati
 	.open = v9fs_file_open,
 	.release = v9fs_dir_release,
 	.lock = v9fs_file_lock,
+	.mmap = generic_file_mmap,
 };
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index a17b288..91f5524 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -177,6 +177,7 @@ struct inode *v9fs_get_inode(struct supe
 		inode->i_blocks = 0;
 		inode->i_rdev = 0;
 		inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+		inode->i_mapping->a_ops = &v9fs_addr_operations;
 
 		switch (mode & S_IFMT) {
 		case S_IFIFO:
-- 
1.1.0
