Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265887AbSKFSVN>; Wed, 6 Nov 2002 13:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbSKFSVM>; Wed, 6 Nov 2002 13:21:12 -0500
Received: from packet.digeo.com ([12.110.80.53]:13250 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265887AbSKFSUv>;
	Wed, 6 Nov 2002 13:20:51 -0500
Message-ID: <3DC95F0A.50DB3C1@digeo.com>
Date: Wed, 06 Nov 2002 10:27:22 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org,
       Marco van Wieringen <mvw@planets.elm.net>
Subject: Re: [PATCH] remove extern inline from quotaops.h
References: <20021104141317.A29058@mookie.adilger.int> <200211061519.gA6FJXp13811@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Nov 2002 18:27:22.0078 (UTC) FILETIME=[2599C7E0:01C285C2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> For example,
> 
> static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
> {
>         lock_kernel();
>         if (sb_any_quota_enabled(inode->i_sb)) {

That's nuts.

Here you go.  Saves 7k in an ext2+ext3 build, and a lot of it is
fastpath.  This will significantly reduce the cache footprint
which the kernel presents to applications which are performing
filesystem operations.




 fs/Makefile              |    6 -
 fs/quotaops.c            |  193 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/quotaops.h |  188 +++------------------------------------------
 3 files changed, 212 insertions(+), 175 deletions(-)

--- 25/include/linux/quotaops.h~quota-scrog	Wed Nov  6 10:03:42 2002
+++ 25-akpm/include/linux/quotaops.h	Wed Nov  6 10:16:43 2002
@@ -42,139 +42,14 @@ extern struct quotactl_ops vfs_quotactl_
 #define sb_dquot_ops (&dquot_operations)
 #define sb_quotactl_ops (&vfs_quotactl_ops)
 
-static __inline__ void DQUOT_INIT(struct inode *inode)
-{
-	if (!inode->i_sb)
-		BUG();
-	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
-		inode->i_sb->dq_op->initialize(inode, -1);
-	unlock_kernel();
-}
-
-static __inline__ void DQUOT_DROP(struct inode *inode)
-{
-	lock_kernel();
-	if (IS_QUOTAINIT(inode)) {
-		if (!inode->i_sb)
-			BUG();
-		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
-	}
-	unlock_kernel();
-}
-
-static __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
-{
-	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb)) {
-		/* Used space is updated in alloc_space() */
-		if (inode->i_sb->dq_op->alloc_space(inode, nr, 1) == NO_QUOTA) {
-			unlock_kernel();
-			return 1;
-		}
-	}
-	else
-		inode_add_bytes(inode, nr);
-	unlock_kernel();
-	return 0;
-}
-
-static __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
-{
-	int ret;
-        if (!(ret =  DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr)))
-		mark_inode_dirty(inode);
-	return ret;
-}
-
-static __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
-{
-	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb)) {
-		/* Used space is updated in alloc_space() */
-		if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA) {
-			unlock_kernel();
-			return 1;
-		}
-	}
-	else
-		inode_add_bytes(inode, nr);
-	unlock_kernel();
-	return 0;
-}
-
-static __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
-{
-	int ret;
-	if (!(ret = DQUOT_ALLOC_SPACE_NODIRTY(inode, nr)))
-		mark_inode_dirty(inode);
-	return ret;
-}
-
-static __inline__ int DQUOT_ALLOC_INODE(struct inode *inode)
-{
-	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb)) {
-		DQUOT_INIT(inode);
-		if (inode->i_sb->dq_op->alloc_inode(inode, 1) == NO_QUOTA) {
-			unlock_kernel();
-			return 1;
-		}
-	}
-	unlock_kernel();
-	return 0;
-}
-
-static __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
-{
-	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb))
-		inode->i_sb->dq_op->free_space(inode, nr);
-	else
-		inode_sub_bytes(inode, nr);
-	unlock_kernel();
-}
-
-static __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
-{
-	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
-	mark_inode_dirty(inode);
-}
-
-static __inline__ void DQUOT_FREE_INODE(struct inode *inode)
-{
-	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb))
-		inode->i_sb->dq_op->free_inode(inode, 1);
-	unlock_kernel();
-}
-
-static __inline__ int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
-{
-	lock_kernel();
-	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode)) {
-		DQUOT_INIT(inode);
-		if (inode->i_sb->dq_op->transfer(inode, iattr) == NO_QUOTA) {
-			unlock_kernel();
-			return 1;
-		}
-	}
-	unlock_kernel();
-	return 0;
-}
-
 #define DQUOT_SYNC(sb)	sync_dquots(sb, -1)
 
-static __inline__ int DQUOT_OFF(struct super_block *sb)
-{
-	int ret = -ENOSYS;
-
-	lock_kernel();
-	if (sb->s_qcop && sb->s_qcop->quota_off)
-		ret = sb->s_qcop->quota_off(sb, -1);
-	unlock_kernel();
-	return ret;
-}
+void DQUOT_INIT(struct inode *inode);
+void DQUOT_DROP(struct inode *inode);
+int DQUOT_ALLOC_INODE(struct inode *inode);
+void DQUOT_FREE_INODE(struct inode *inode);
+int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr);
+int DQUOT_OFF(struct super_block *sb);
 
 #else
 
@@ -190,51 +65,18 @@ static __inline__ int DQUOT_OFF(struct s
 #define DQUOT_SYNC(sb)				do { } while(0)
 #define DQUOT_OFF(sb)				do { } while(0)
 #define DQUOT_TRANSFER(inode, iattr)		(0)
-extern __inline__ int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
-{
-	lock_kernel();
-	inode_add_bytes(inode, nr);
-	unlock_kernel();
-	return 0;
-}
-
-extern __inline__ int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
-{
-	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
-	mark_inode_dirty(inode);
-	return 0;
-}
-
-extern __inline__ int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
-{
-	lock_kernel();
-	inode_add_bytes(inode, nr);
-	unlock_kernel();
-	return 0;
-}
-
-extern __inline__ int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
-{
-	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
-	mark_inode_dirty(inode);
-	return 0;
-}
-
-extern __inline__ void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
-{
-	lock_kernel();
-	inode_sub_bytes(inode, nr);
-	unlock_kernel();
-}
-
-extern __inline__ void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
-{
-	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
-	mark_inode_dirty(inode);
-}	
 
 #endif /* CONFIG_QUOTA */
 
+/* fs/quotaops.c */
+
+int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr);
+int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr);
+int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr);
+int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr);
+void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr);
+void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr);
+
 #define DQUOT_PREALLOC_BLOCK_NODIRTY(inode, nr)	DQUOT_PREALLOC_SPACE_NODIRTY(inode, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
 #define DQUOT_PREALLOC_BLOCK(inode, nr)	DQUOT_PREALLOC_SPACE(inode, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
 #define DQUOT_ALLOC_BLOCK_NODIRTY(inode, nr) DQUOT_ALLOC_SPACE_NODIRTY(inode, ((qsize_t)(nr)) << (inode)->i_sb->s_blocksize_bits)
--- /dev/null	Thu Aug 30 13:30:55 2001
+++ 25-akpm/fs/quotaops.c	Wed Nov  6 10:18:38 2002
@@ -0,0 +1,193 @@
+#include <linux/config.h>
+#include <linux/smp_lock.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/quotaops.h>
+
+#if defined(CONFIG_QUOTA)
+
+void DQUOT_INIT(struct inode *inode)
+{
+	if (!inode->i_sb)
+		BUG();
+	lock_kernel();
+	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
+		inode->i_sb->dq_op->initialize(inode, -1);
+	unlock_kernel();
+}
+
+void DQUOT_DROP(struct inode *inode)
+{
+	lock_kernel();
+	if (IS_QUOTAINIT(inode)) {
+		if (!inode->i_sb)
+			BUG();
+		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
+	}
+	unlock_kernel();
+}
+
+int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+{
+	lock_kernel();
+	if (sb_any_quota_enabled(inode->i_sb)) {
+		/* Used space is updated in alloc_space() */
+		if (inode->i_sb->dq_op->alloc_space(inode, nr, 1) == NO_QUOTA) {
+			unlock_kernel();
+			return 1;
+		}
+	}
+	else
+		inode_add_bytes(inode, nr);
+	unlock_kernel();
+	return 0;
+}
+
+int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+{
+	int ret;
+        if (!(ret =  DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr)))
+		mark_inode_dirty(inode);
+	return ret;
+}
+
+int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+{
+	lock_kernel();
+	if (sb_any_quota_enabled(inode->i_sb)) {
+		/* Used space is updated in alloc_space() */
+		if (inode->i_sb->dq_op->alloc_space(inode, nr, 0) == NO_QUOTA) {
+			unlock_kernel();
+			return 1;
+		}
+	}
+	else
+		inode_add_bytes(inode, nr);
+	unlock_kernel();
+	return 0;
+}
+
+int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+{
+	int ret;
+	if (!(ret = DQUOT_ALLOC_SPACE_NODIRTY(inode, nr)))
+		mark_inode_dirty(inode);
+	return ret;
+}
+
+int DQUOT_ALLOC_INODE(struct inode *inode)
+{
+	lock_kernel();
+	if (sb_any_quota_enabled(inode->i_sb)) {
+		DQUOT_INIT(inode);
+		if (inode->i_sb->dq_op->alloc_inode(inode, 1) == NO_QUOTA) {
+			unlock_kernel();
+			return 1;
+		}
+	}
+	unlock_kernel();
+	return 0;
+}
+
+void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+{
+	lock_kernel();
+	if (sb_any_quota_enabled(inode->i_sb))
+		inode->i_sb->dq_op->free_space(inode, nr);
+	else
+		inode_sub_bytes(inode, nr);
+	unlock_kernel();
+}
+
+void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+{
+	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
+	mark_inode_dirty(inode);
+}
+
+void DQUOT_FREE_INODE(struct inode *inode)
+{
+	lock_kernel();
+	if (sb_any_quota_enabled(inode->i_sb))
+		inode->i_sb->dq_op->free_inode(inode, 1);
+	unlock_kernel();
+}
+
+int DQUOT_TRANSFER(struct inode *inode, struct iattr *iattr)
+{
+	lock_kernel();
+	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode)) {
+		DQUOT_INIT(inode);
+		if (inode->i_sb->dq_op->transfer(inode, iattr) == NO_QUOTA) {
+			unlock_kernel();
+			return 1;
+		}
+	}
+	unlock_kernel();
+	return 0;
+}
+
+int DQUOT_OFF(struct super_block *sb)
+{
+	int ret = -ENOSYS;
+
+	lock_kernel();
+	if (sb->s_qcop && sb->s_qcop->quota_off)
+		ret = sb->s_qcop->quota_off(sb, -1);
+	unlock_kernel();
+	return ret;
+}
+
+#else
+
+int DQUOT_PREALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+{
+	lock_kernel();
+	inode_add_bytes(inode, nr);
+	unlock_kernel();
+	return 0;
+}
+
+int DQUOT_PREALLOC_SPACE(struct inode *inode, qsize_t nr)
+{
+	DQUOT_PREALLOC_SPACE_NODIRTY(inode, nr);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+int DQUOT_ALLOC_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+{
+	lock_kernel();
+	inode_add_bytes(inode, nr);
+	unlock_kernel();
+	return 0;
+}
+
+int DQUOT_ALLOC_SPACE(struct inode *inode, qsize_t nr)
+{
+	DQUOT_ALLOC_SPACE_NODIRTY(inode, nr);
+	mark_inode_dirty(inode);
+	return 0;
+}
+
+void DQUOT_FREE_SPACE_NODIRTY(struct inode *inode, qsize_t nr)
+{
+	lock_kernel();
+	inode_sub_bytes(inode, nr);
+	unlock_kernel();
+}
+
+void DQUOT_FREE_SPACE(struct inode *inode, qsize_t nr)
+{
+	DQUOT_FREE_SPACE_NODIRTY(inode, nr);
+	mark_inode_dirty(inode);
+}	
+
+#endif /* CONFIG_QUOTA */
+
+EXPORT_SYMBOL(DQUOT_PREALLOC_SPACE_NODIRTY);
+EXPORT_SYMBOL(DQUOT_PREALLOC_SPACE);
+EXPORT_SYMBOL(DQUOT_ALLOC_SPACE_NODIRTY);
+EXPORT_SYMBOL(DQUOT_ALLOC_SPACE);
+EXPORT_SYMBOL(DQUOT_FREE_SPACE_NODIRTY);
+EXPORT_SYMBOL(DQUOT_FREE_SPACE);
--- 25/fs/Makefile~quota-scrog	Wed Nov  6 10:08:21 2002
+++ 25-akpm/fs/Makefile	Wed Nov  6 10:08:49 2002
@@ -6,14 +6,16 @@
 # 
 
 export-objs :=	open.o dcache.o buffer.o bio.o inode.o dquot.o mpage.o aio.o \
-                fcntl.o read_write.o dcookies.o mbcache.o posix_acl.o xattr_acl.o
+                fcntl.o read_write.o dcookies.o mbcache.o posix_acl.o xattr_acl.o \
+		quotaops.o
 
 obj-y :=	open.o read_write.o devices.o file_table.o buffer.o \
 		bio.o super.o block_dev.o char_dev.o stat.o exec.o pipe.o \
 		namei.o fcntl.o ioctl.o readdir.o select.o fifo.o locks.o \
 		dcache.o inode.o attr.o bad_inode.o file.o dnotify.o \
 		filesystems.o namespace.o seq_file.o xattr.o libfs.o \
-		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o
+		fs-writeback.o mpage.o direct-io.o aio.o eventpoll.o \
+		quotaops.o
 
 ifneq ($(CONFIG_NFSD),n)
 ifneq ($(CONFIG_NFSD),)

_
