Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936263AbWLDMeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936263AbWLDMeg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 07:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936279AbWLDMeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 07:34:36 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:45278 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936263AbWLDMed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 07:34:33 -0500
From: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, viro@ftp.linux.org.uk,
       linux-fsdevel@vger.kernel.org, mhalcrow@us.ibm.com,
       Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Subject: [PATCH 01/35] fsstack: Introduce fsstack_copy_{attr,inode}_*
Date: Mon,  4 Dec 2006 07:30:34 -0500
Message-Id: <11652354681829-git-send-email-jsipek@cs.sunysb.edu>
X-Mailer: git-send-email 1.4.3.3
In-Reply-To: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

Introduce several fsstack_copy_* functions which allow stackable filesystems
(such as eCryptfs and Unionfs) to easily copy over (currently only) inode
attributes.  This prevents code duplication and allows for code reuse.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Cc: Michael Halcrow <mhalcrow@us.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---
 fs/Makefile              |    3 ++-
 fs/stack.c               |   39 +++++++++++++++++++++++++++++++++++++++
 include/linux/fs_stack.h |   39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/fs/Makefile b/fs/Makefile
index 9a5ce93..b9ffa63 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -10,7 +10,8 @@ obj-y :=	open.o read_write.o file_table.
 		ioctl.o readdir.o select.o fifo.o locks.o dcache.o inode.o \
 		attr.o bad_inode.o file.o filesystems.o namespace.o aio.o \
 		seq_file.o xattr.o libfs.o fs-writeback.o \
-		pnode.o drop_caches.o splice.o sync.o utimes.o
+		pnode.o drop_caches.o splice.o sync.o utimes.o \
+		stack.o
 
 ifeq ($(CONFIG_BLOCK),y)
 obj-y +=	buffer.o bio.o block_dev.o direct-io.o mpage.o ioprio.o
diff --git a/fs/stack.c b/fs/stack.c
new file mode 100644
index 0000000..5f6f12d
--- /dev/null
+++ b/fs/stack.c
@@ -0,0 +1,39 @@
+#include <linux/module.h>
+#include <linux/fs.h>
+
+/* does _NOT_ require i_mutex to be held.
+ *
+ * This function cannot be inlined since i_size_{read,write} is rather
+ * heavy-weight on 32-bit systems
+ */
+void fsstack_copy_inode_size(struct inode *dst, const struct inode *src)
+{
+	i_size_write(dst, i_size_read((struct inode *)src));
+	dst->i_blocks = src->i_blocks;
+}
+
+/* copy all attributes; get_nlinks is optional way to override the i_nlink
+ * copying
+ */
+void __fsstack_copy_attr_all(struct inode *dest,
+			     const struct inode *src,
+			     int (*get_nlinks)(struct inode *))
+{
+	if (!get_nlinks)
+		dest->i_nlink = src->i_nlink;
+	else
+		dest->i_nlink = (*get_nlinks)(dest);
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
+EXPORT_SYMBOL_GPL(fsstack_copy_inode_size);
+EXPORT_SYMBOL_GPL(__fsstack_copy_attr_all);
diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
new file mode 100644
index 0000000..56b3e09
--- /dev/null
+++ b/include/linux/fs_stack.h
@@ -0,0 +1,39 @@
+#ifndef _LINUX_FS_STACK_H
+#define _LINUX_FS_STACK_H
+
+/* This file defines generic functions used primarily by stackable
+ * filesystems; none of these functions require i_mutex to be held.
+ */
+
+#include <linux/fs.h>
+
+/* externs for fs/stack.c */
+extern void __fsstack_copy_attr_all(struct inode *dest,
+				    const struct inode *src,
+				    int (*get_nlinks)(struct inode *));
+
+extern void fsstack_copy_inode_size(struct inode *dst, const struct inode *src);
+
+/* inlines */
+static inline void fsstack_copy_attr_atime(struct inode *dest,
+					   const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+}
+
+static inline void fsstack_copy_attr_times(struct inode *dest,
+					   const struct inode *src)
+{
+	dest->i_atime = src->i_atime;
+	dest->i_mtime = src->i_mtime;
+	dest->i_ctime = src->i_ctime;
+}
+
+static inline void fsstack_copy_attr_all(struct inode *dest,
+					 const struct inode *src)
+{
+	__fsstack_copy_attr_all(dest, src, NULL);
+}
+
+#endif /* _LINUX_FS_STACK_H */
+
-- 
1.4.3.3

