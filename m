Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbWJMLtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbWJMLtf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 07:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWJMLtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 07:49:35 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:44201 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1751418AbWJMLtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 07:49:31 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 1 of 2] Stackfs: Introduce stackfs_copy_{attr,inode}_*
Message-Id: <ceb6edcac7047367ca16.1160738329@thor.fsl.cs.sunysb.edu>
In-Reply-To: <patchbomb.1160738328@thor.fsl.cs.sunysb.edu>
Date: Fri, 13 Oct 2006 07:18:49 -0400
From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, penberg@cs.helsinki.fi,
       ezk@cs.sunysb.edu, mhalcrow@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

The following patch introduces several stackfs_copy_* functions which allow
stackable filesystems (such as eCryptfs and Unionfs) to easily copy over
(currently only) inode attributes. This prevents code duplication and allows
for code reuse.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

---

1 file changed, 65 insertions(+)
include/linux/stack_fs.h |   65 ++++++++++++++++++++++++++++++++++++++++++++++

diff --git a/include/linux/stack_fs.h b/include/linux/stack_fs.h
new file mode 100644
--- /dev/null
+++ b/include/linux/stack_fs.h
@@ -0,0 +1,65 @@
+#ifndef _LINUX_STACK_FS_H
+#define _LINUX_STACK_FS_H
+
+/* This file defines generic functions used primarily by stackable
+ * filesystems
+ */
+
+static inline void stackfs_copy_inode_size(struct inode *dst,
+					   const struct inode *src)
+{
+	i_size_write(dst, i_size_read((struct inode *)src));
+	dst->i_blocks = src->i_blocks;
+}
+
+static inline void stackfs_copy_attr_atime(struct inode *dest,
+					   const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+}
+
+static inline void stackfs_copy_attr_times(struct inode *dest,
+					   const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+}
+
+static inline void stackfs_copy_attr_timesizes(struct inode *dest,
+					       const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+	stackfs_copy_inode_size(dest, src);
+}
+
+static inline void __stackfs_copy_attr_all(struct inode *dest,
+					   const struct inode *src,
+					   int (*get_nlinks)(struct inode *))
+{
+	if (!get_nlinks)
+		dest->i_nlink = src->i_nlink;
+	else
+		dest->i_nlink = get_nlinks(dest);
+
+	dest->i_mode = src->i_mode;
+	dest->i_uid = src->i_uid;
+	dest->i_gid = src->i_gid;
+	dest->i_rdev = src->i_rdev;
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+	dest->i_blkbits = src->i_blkbits;
+	dest->i_flags = src->i_flags;
+}
+
+static inline void stackfs_copy_attr_all(struct inode *dest,
+					 const struct inode *src)
+{
+	__stackfs_copy_attr_all(dest, src, NULL);
+}
+
+#endif /* _LINUX_STACK_FS_H */
+


