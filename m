Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWIAB77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWIAB77 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 21:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWIAB77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 21:59:59 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:31368 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1750859AbWIAB75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 21:59:57 -0400
Date: Thu, 31 Aug 2006 21:59:46 -0400
From: Josef Sipek <jsipek@cs.sunysb.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: [PATCH 19/22][RFC] Unionfs: Helper macros/inlines
Message-ID: <20060901015945.GT5788@fsl.cs.sunysb.edu>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901013512.GA5788@fsl.cs.sunysb.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>

This patch contains many macros and inline functions used thoughout Unionfs.

Signed-off-by: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
Signed-off-by: David Quigley <dquigley@fsl.cs.sunysb.edu>
Signed-off-by: Erez Zadok <ezk@cs.sunysb.edu>

---

 fs/unionfs/fanout.h |  188 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff -Nur -x linux-2.6-git/Documentation/dontdiff linux-2.6-git/fs/unionfs/fanout.h linux-2.6-git-unionfs/fs/unionfs/fanout.h
--- linux-2.6-git/fs/unionfs/fanout.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6-git-unionfs/fs/unionfs/fanout.h	2006-08-31 19:04:00.000000000 -0400
@@ -0,0 +1,188 @@
+/*
+ * Copyright (c) 2003-2006 Erez Zadok
+ * Copyright (c) 2003-2006 Charles P. Wright
+ * Copyright (c) 2005-2006 Josef Sipek
+ * Copyright (c) 2005      Arun M. Krishnakumar
+ * Copyright (c) 2004-2006 David P. Quigley
+ * Copyright (c) 2003-2004 Mohammad Nayyer Zubair
+ * Copyright (c) 2003      Puja Gupta
+ * Copyright (c) 2003      Harikesavan Krishnan
+ * Copyright (c) 2003-2006 Stony Brook University
+ * Copyright (c) 2003-2006 The Research Foundation of State University of New York
+ *
+ * For specific licensing information, see the COPYING file distributed with
+ * this package.
+ *
+ * This Copyright notice must be kept intact and distributed with all sources.
+ */
+
+#ifndef _FANOUT_H_
+#define _FANOUT_H_
+
+/* Inode to private data */
+static inline struct unionfs_inode_info *itopd(const struct inode *inode)
+{
+	return
+	    &(container_of(inode, struct unionfs_inode_container, vfs_inode)->
+	      info);
+}
+
+#define itohi_ptr(ino) (itopd(ino)->uii_inode)
+#define ibstart(ino) (itopd(ino)->b_start)
+#define ibend(ino) (itopd(ino)->b_end)
+
+/* Superblock to private data */
+#define stopd(super) ((struct unionfs_sb_info *)(super)->s_fs_info)
+#define stopd_lhs(super) ((super)->s_fs_info)
+#define sbstart(sb) 0
+#define sbend(sb) stopd(sb)->b_end
+#define sbmax(sb) (stopd(sb)->b_end + 1)
+
+/* File to private Data */
+#define ftopd(file) ((struct unionfs_file_info *)((file)->private_data))
+#define ftopd_lhs(file) ((file)->private_data)
+#define ftohf_ptr(file)  (ftopd(file)->ufi_file)
+#define fbstart(file) (ftopd(file)->b_start)
+#define fbend(file) (ftopd(file)->b_end)
+
+/* File to hidden file. */
+static inline struct file *ftohf(struct file *f)
+{
+	return ftopd(f)->ufi_file[fbstart(f)];
+}
+
+static inline struct file *ftohf_index(const struct file *f, int index)
+{
+	return ftopd(f)->ufi_file[index];
+}
+
+static inline void set_ftohf_index(struct file *f, int index, struct file *val)
+{
+	ftopd(f)->ufi_file[index] = val;
+}
+
+static inline void set_ftohf(struct file *f, struct file *val)
+{
+	ftopd(f)->ufi_file[fbstart(f)] = val;
+}
+
+/* Inode to hidden inode. */
+static inline struct inode *itohi(const struct inode *i)
+{
+	return itopd(i)->uii_inode[ibstart(i)];
+}
+
+static inline struct inode *itohi_index(const struct inode *i, int index)
+{
+	return itopd(i)->uii_inode[index];
+}
+
+static inline void set_itohi_index(struct inode *i, int index,
+				   struct inode *val)
+{
+	itopd(i)->uii_inode[index] = val;
+}
+
+static inline void set_itohi(struct inode *i, struct inode *val)
+{
+	itopd(i)->uii_inode[ibstart(i)] = val;
+}
+
+/* Superblock to hidden superblock. */
+static inline struct super_block *stohs(const struct super_block *o)
+{
+	return stopd(o)->usi_data[sbstart(o)].sb;
+}
+
+static inline struct super_block *stohs_index(const struct super_block *o, int index)
+{
+	return stopd(o)->usi_data[index].sb;
+}
+
+static inline void set_stohs_index(struct super_block *o, int index,
+				   struct super_block *val)
+{
+	stopd(o)->usi_data[index].sb = val;
+}
+
+static inline void set_stohs(struct super_block *o, struct super_block *val)
+{
+	stopd(o)->usi_data[sbstart(o)].sb = val;
+}
+
+/* Super to hidden mount. */
+static inline struct vfsmount *stohiddenmnt_index(struct super_block *o,
+						  int index)
+{
+	return stopd(o)->usi_data[index].hidden_mnt;
+}
+
+static inline void set_stohiddenmnt_index(struct super_block *o, int index,
+					  struct vfsmount *val)
+{
+	stopd(o)->usi_data[index].hidden_mnt = val;
+}
+
+/* Branch count macros. */
+static inline int branch_count(struct super_block *o, int index)
+{
+	return atomic_read(&stopd(o)->usi_data[index].sbcount);
+}
+
+static inline void set_branch_count(struct super_block *o, int index, int val)
+{
+	atomic_set(&stopd(o)->usi_data[index].sbcount, val);
+}
+
+static inline void branchget(struct super_block *o, int index)
+{
+	atomic_inc(&stopd(o)->usi_data[index].sbcount);
+}
+
+static inline void branchput(struct super_block *o, int index)
+{
+	atomic_dec(&stopd(o)->usi_data[index].sbcount);
+}
+
+/* Dentry macros */
+static inline struct unionfs_dentry_info *dtopd(const struct dentry *dent)
+{
+	return (struct unionfs_dentry_info *)dent->d_fsdata;
+}
+
+#define dtopd_lhs(dent) ((dent)->d_fsdata)
+#define dtopd_nocheck(dent) dtopd(dent)
+#define dbstart(dent) (dtopd(dent)->udi_bstart)
+#define set_dbstart(dent, val) do { dtopd(dent)->udi_bstart = val; } while(0)
+#define dbend(dent) (dtopd(dent)->udi_bend)
+#define set_dbend(dent, val) do { dtopd(dent)->udi_bend = val; } while(0)
+#define dbopaque(dent) (dtopd(dent)->udi_bopaque)
+#define set_dbopaque(dent, val) do { dtopd(dent)->udi_bopaque = val; } while (0)
+
+static inline void set_dtohd_index(struct dentry *dent, int index,
+				   struct dentry *val)
+{
+	dtopd(dent)->udi_dentry[index] = val;
+}
+
+static inline struct dentry *dtohd_index(const struct dentry *dent, int index)
+{
+	return dtopd(dent)->udi_dentry[index];
+}
+
+static inline struct dentry *dtohd(const struct dentry *dent)
+{
+	return dtopd(dent)->udi_dentry[dbstart(dent)];
+}
+
+#define set_dtohd_index_nocheck(dent, index, val) set_dtohd_index(dent, index, val)
+#define dtohd_index_nocheck(dent, index) dtohd_index(dent, index)
+
+#define dtohd_ptr(dent) (dtopd_nocheck(dent)->udi_dentry)
+
+/* Macros for locking a dentry. */
+#define lock_dentry(d) down(&dtopd(d)->udi_sem)
+#define unlock_dentry(d) up(&dtopd(d)->udi_sem)
+#define verify_locked(d)
+
+#endif	/* _FANOUT_H */
