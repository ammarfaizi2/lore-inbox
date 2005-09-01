Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965166AbVIAOaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965166AbVIAOaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbVIAOaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:30:20 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965155AbVIAO3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:29:10 -0400
Date: Thu, 1 Sep 2005 21:55:11 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02c/13] GFS: core fs
Message-ID: <20050901135511.GD25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core file system functions.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 fs/gfs2/ops_dentry.c |  117 +++
 fs/gfs2/ops_dentry.h |   15 
 fs/gfs2/ops_export.c |  311 ++++++++++
 fs/gfs2/ops_export.h |   15 
 fs/gfs2/ops_file.c   | 1522 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/ops_file.h   |   16 
 fs/gfs2/ops_fstype.c |  801 ++++++++++++++++++++++++++
 fs/gfs2/ops_fstype.h |   15 
 fs/gfs2/ops_inode.c  | 1270 ++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/ops_inode.h  |   18 
 10 files changed, 4100 insertions(+)

--- a/fs/gfs2/ops_dentry.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_dentry.c	2005-09-01 17:36:55.392103768 +0800
@@ -0,0 +1,117 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "dir.h"
+#include "glock.h"
+#include "ops_dentry.h"
+
+/**
+ * gfs2_drevalidate - Check directory lookup consistency
+ * @dentry: the mapping to check
+ * @nd:
+ *
+ * Check to make sure the lookup necessary to arrive at this inode from its
+ * parent is still good.
+ *
+ * Returns: 1 if the dentry is ok, 0 if it isn't
+ */
+
+static int gfs2_drevalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	struct dentry *parent = dget_parent(dentry);
+	struct gfs2_inode *dip = get_v2ip(parent->d_inode);
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct inode *inode;
+	struct gfs2_holder d_gh;
+	struct gfs2_inode *ip;
+	struct gfs2_inum inum;
+	unsigned int type;
+	int error;
+
+	lock_kernel();
+
+	atomic_inc(&sdp->sd_ops_dentry);
+
+	inode = dentry->d_inode;
+	if (inode && is_bad_inode(inode))
+		goto invalid;
+
+	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+	if (error)
+		goto fail;
+
+	error = gfs2_dir_search(dip, &dentry->d_name, &inum, &type);
+	switch (error) {
+	case 0:
+		if (!inode)
+			goto invalid_gunlock;
+		break;
+	case -ENOENT:
+		if (!inode)
+			goto valid_gunlock;
+		goto invalid_gunlock;
+	default:
+		goto fail_gunlock;
+	}
+
+	ip = get_v2ip(inode);
+
+	if (!gfs2_inum_equal(&ip->i_num, &inum))
+		goto invalid_gunlock;
+
+	if (IF2DT(ip->i_di.di_mode) != type) {
+		gfs2_consist_inode(dip);
+		goto fail_gunlock;
+	}
+
+ valid_gunlock:
+	gfs2_glock_dq_uninit(&d_gh);
+
+ valid:
+	unlock_kernel();
+	dput(parent);
+	return 1;
+
+ invalid_gunlock:
+	gfs2_glock_dq_uninit(&d_gh);
+
+ invalid:
+	if (inode && S_ISDIR(inode->i_mode)) {
+		if (have_submounts(dentry))
+			goto valid;
+		shrink_dcache_parent(dentry);
+	}
+	d_drop(dentry);
+
+	unlock_kernel();
+	dput(parent);
+	return 0;
+
+ fail_gunlock:
+	gfs2_glock_dq_uninit(&d_gh);
+
+ fail:
+	unlock_kernel();
+	dput(parent);
+	return 0;
+}
+
+struct dentry_operations gfs2_dops = {
+	.d_revalidate = gfs2_drevalidate,
+};
+
--- a/fs/gfs2/ops_dentry.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_dentry.h	2005-09-01 17:36:55.392103768 +0800
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_DENTRY_DOT_H__
+#define __OPS_DENTRY_DOT_H__
+
+extern struct dentry_operations gfs2_dops;
+
+#endif /* __OPS_DENTRY_DOT_H__ */
--- a/fs/gfs2/ops_export.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_export.c	2005-09-01 17:36:55.403102096 +0800
@@ -0,0 +1,311 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "dir.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "ops_export.h"
+#include "rgrp.h"
+
+static struct dentry *gfs2_decode_fh(struct super_block *sb,
+				     __u32 *fh,
+				     int fh_len,
+				     int fh_type,
+				     int (*acceptable)(void *context,
+						       struct dentry *dentry),
+				     void *context)
+{
+	struct gfs2_inum this, parent;
+
+	atomic_inc(&get_v2sdp(sb)->sd_ops_export);
+
+	if (fh_type != fh_len)
+		return NULL;
+
+	memset(&parent, 0, sizeof(struct gfs2_inum));
+
+	switch (fh_type) {
+	case 8:
+		parent.no_formal_ino = ((uint64_t)gfs2_32_to_cpu(fh[4])) << 32;
+		parent.no_formal_ino |= gfs2_32_to_cpu(fh[5]);
+		parent.no_addr = ((uint64_t)gfs2_32_to_cpu(fh[6])) << 32;
+		parent.no_addr |= gfs2_32_to_cpu(fh[7]);
+	case 4:
+		this.no_formal_ino = ((uint64_t)gfs2_32_to_cpu(fh[0])) << 32;
+		this.no_formal_ino |= gfs2_32_to_cpu(fh[1]);
+		this.no_addr = ((uint64_t)gfs2_32_to_cpu(fh[2])) << 32;
+		this.no_addr |= gfs2_32_to_cpu(fh[3]);
+		break;
+	default:
+		return NULL;
+	}
+
+	return gfs2_export_ops.find_exported_dentry(sb, &this, &parent,
+						    acceptable, context);
+}
+
+static int gfs2_encode_fh(struct dentry *dentry, __u32 *fh, int *len,
+			  int connectable)
+{
+	struct inode *inode = dentry->d_inode;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	atomic_inc(&sdp->sd_ops_export);
+
+	if (*len < 4 || (connectable && *len < 8))
+		return 255;
+
+	fh[0] = ip->i_num.no_formal_ino >> 32;
+	fh[0] = cpu_to_gfs2_32(fh[0]);
+	fh[1] = ip->i_num.no_formal_ino & 0xFFFFFFFF;
+	fh[1] = cpu_to_gfs2_32(fh[1]);
+	fh[2] = ip->i_num.no_addr >> 32;
+	fh[2] = cpu_to_gfs2_32(fh[2]);
+	fh[3] = ip->i_num.no_addr & 0xFFFFFFFF;
+	fh[3] = cpu_to_gfs2_32(fh[3]);
+	*len = 4;
+
+	if (!connectable || ip == sdp->sd_root_dir)
+		return *len;
+
+	spin_lock(&dentry->d_lock);
+	inode = dentry->d_parent->d_inode;
+	ip = get_v2ip(inode);
+	gfs2_inode_hold(ip);
+	spin_unlock(&dentry->d_lock);
+
+	fh[4] = ip->i_num.no_formal_ino >> 32;
+	fh[4] = cpu_to_gfs2_32(fh[4]);
+	fh[5] = ip->i_num.no_formal_ino & 0xFFFFFFFF;
+	fh[5] = cpu_to_gfs2_32(fh[5]);
+	fh[6] = ip->i_num.no_addr >> 32;
+	fh[6] = cpu_to_gfs2_32(fh[6]);
+	fh[7] = ip->i_num.no_addr & 0xFFFFFFFF;
+	fh[7] = cpu_to_gfs2_32(fh[7]);
+	*len = 8;
+
+	gfs2_inode_put(ip);
+
+	return *len;
+}
+
+struct get_name_filldir {
+	struct gfs2_inum inum;
+	char *name;
+};
+
+static int get_name_filldir(void *opaque, const char *name, unsigned int length,
+			    uint64_t offset, struct gfs2_inum *inum,
+			    unsigned int type)
+{
+	struct get_name_filldir *gnfd = (struct get_name_filldir *)opaque;
+
+	if (!gfs2_inum_equal(inum, &gnfd->inum))
+		return 0;
+
+	memcpy(gnfd->name, name, length);
+	gnfd->name[length] = 0;
+
+	return 1;
+}
+
+static int gfs2_get_name(struct dentry *parent, char *name,
+			 struct dentry *child)
+{
+	struct inode *dir = parent->d_inode;
+	struct inode *inode = child->d_inode;
+	struct gfs2_inode *dip, *ip;
+	struct get_name_filldir gnfd;
+	struct gfs2_holder gh;
+	uint64_t offset = 0;
+	int error;
+
+	if (!dir)
+		return -EINVAL;
+
+	atomic_inc(&get_v2sdp(dir->i_sb)->sd_ops_export);
+
+	if (!S_ISDIR(dir->i_mode) || !inode)
+		return -EINVAL;
+
+	dip = get_v2ip(dir);
+	ip = get_v2ip(inode);
+
+	*name = 0;
+	gnfd.inum = ip->i_num;
+	gnfd.name = name;
+
+	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &gh);
+	if (error)
+		return error;
+
+	error = gfs2_dir_read(dip, &offset, &gnfd, get_name_filldir);
+
+	gfs2_glock_dq_uninit(&gh);
+
+	if (!error && !*name)
+		error = -ENOENT;
+
+	return error;
+}
+
+static struct dentry *gfs2_get_parent(struct dentry *child)
+{
+	struct gfs2_inode *dip = get_v2ip(child->d_inode);
+	struct qstr dotdot = { .name = "..", .len = 2 };
+	struct gfs2_inode *ip;
+	struct inode *inode;
+	struct dentry *dentry;
+	int error;
+
+	atomic_inc(&dip->i_sbd->sd_ops_export);
+
+	error = gfs2_lookupi(dip, &dotdot, TRUE, &ip);
+	if (error)
+		return ERR_PTR(error);
+
+	inode = gfs2_ip2v(ip);
+	gfs2_inode_put(ip);
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	dentry = d_alloc_anon(inode);
+	if (!dentry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return dentry;
+}
+
+static struct dentry *gfs2_get_dentry(struct super_block *sb, void *inum_p)
+{
+	struct gfs2_sbd *sdp = get_v2sdp(sb);
+	struct gfs2_inum *inum = (struct gfs2_inum *)inum_p;
+	struct gfs2_holder i_gh, ri_gh, rgd_gh;
+	struct gfs2_rgrpd *rgd;
+	struct gfs2_inode *ip;
+	struct inode *inode;
+	struct dentry *dentry;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_export);
+
+	/* System files? */
+
+	inode = gfs2_iget(sb, inum);
+	if (inode) {
+		ip = get_v2ip(inode);
+		if (ip->i_num.no_formal_ino != inum->no_formal_ino) {
+			iput(inode);
+			return ERR_PTR(-ESTALE);
+		}
+		goto out_inode;
+	}
+
+	error = gfs2_glock_nq_num(sdp,
+				  inum->no_addr, &gfs2_inode_glops,
+				  LM_ST_SHARED, LM_FLAG_ANY | GL_LOCAL_EXCL,
+				  &i_gh);
+	if (error)
+		return ERR_PTR(error);
+
+	error = gfs2_inode_get(i_gh.gh_gl, inum, NO_CREATE, &ip);
+	if (error)
+		goto fail;
+	if (ip)
+		goto out_ip;
+
+	error = gfs2_rindex_hold(sdp, &ri_gh);
+	if (error)
+		goto fail;
+
+	error = -EINVAL;
+	rgd = gfs2_blk2rgrpd(sdp, inum->no_addr);
+	if (!rgd)
+		goto fail_rindex;
+
+	error = gfs2_glock_nq_init(rgd->rd_gl, LM_ST_SHARED, 0, &rgd_gh);
+	if (error)
+		goto fail_rindex;
+
+	error = -ESTALE;
+	if (gfs2_get_block_type(rgd, inum->no_addr) != GFS2_BLKST_DINODE)
+		goto fail_rgd;
+
+	gfs2_glock_dq_uninit(&rgd_gh);
+	gfs2_glock_dq_uninit(&ri_gh);
+
+	error = gfs2_inode_get(i_gh.gh_gl, inum, CREATE, &ip);
+	if (error)
+		goto fail;
+
+	error = gfs2_inode_refresh(ip);
+	if (error) {
+		gfs2_inode_put(ip);
+		goto fail;
+	}
+
+	atomic_inc(&sdp->sd_fh2dentry_misses);
+
+ out_ip:
+	error = -EIO;
+	if (ip->i_di.di_flags & GFS2_DIF_SYSTEM) {
+		gfs2_inode_put(ip);
+		goto fail;
+	}
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	inode = gfs2_ip2v(ip);
+	gfs2_inode_put(ip);
+
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+ out_inode:
+	dentry = d_alloc_anon(inode);
+	if (!dentry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return dentry;
+
+ fail_rgd:
+	gfs2_glock_dq_uninit(&rgd_gh);
+
+ fail_rindex:
+	gfs2_glock_dq_uninit(&ri_gh);
+
+ fail:
+	gfs2_glock_dq_uninit(&i_gh);
+	return ERR_PTR(error);
+}
+
+struct export_operations gfs2_export_ops = {
+	.decode_fh = gfs2_decode_fh,
+	.encode_fh = gfs2_encode_fh,
+	.get_name = gfs2_get_name,
+	.get_parent = gfs2_get_parent,
+	.get_dentry = gfs2_get_dentry,
+};
+
--- a/fs/gfs2/ops_export.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_export.h	2005-09-01 17:36:55.403102096 +0800
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_EXPORT_DOT_H__
+#define __OPS_EXPORT_DOT_H__
+
+extern struct export_operations gfs2_export_ops;
+
+#endif /* __OPS_EXPORT_DOT_H__ */
--- a/fs/gfs2/ops_file.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_file.c	2005-09-01 17:36:55.414100424 +0800
@@ -0,0 +1,1522 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/pagemap.h>
+#include <linux/uio.h>
+#include <linux/blkdev.h>
+#include <linux/mm.h>
+#include <linux/gfs2_ioctl.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "dir.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "ioctl.h"
+#include "jdata.h"
+#include "lm.h"
+#include "log.h"
+#include "meta_io.h"
+#include "ops_file.h"
+#include "ops_vm.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
+
+/* "bad" is for NFS support */
+struct filldir_bad_entry {
+	char *fbe_name;
+	unsigned int fbe_length;
+	uint64_t fbe_offset;
+	struct gfs2_inum fbe_inum;
+	unsigned int fbe_type;
+};
+
+struct filldir_bad {
+	struct gfs2_sbd *fdb_sbd;
+
+	struct filldir_bad_entry *fdb_entry;
+	unsigned int fdb_entry_num;
+	unsigned int fdb_entry_off;
+
+	char *fdb_name;
+	unsigned int fdb_name_size;
+	unsigned int fdb_name_off;
+};
+
+/* For regular, non-NFS */
+struct filldir_reg {
+	struct gfs2_sbd *fdr_sbd;
+	int fdr_prefetch;
+
+	filldir_t fdr_filldir;
+	void *fdr_opaque;
+};
+
+typedef ssize_t(*do_rw_t) (struct file *file,
+			   char *buf,
+			   size_t size, loff_t *offset,
+			   unsigned int num_gh, struct gfs2_holder *ghs);
+
+/**
+ * gfs2_llseek - seek to a location in a file
+ * @file: the file
+ * @offset: the offset
+ * @origin: Where to seek from (SEEK_SET, SEEK_CUR, or SEEK_END)
+ *
+ * SEEK_END requires the glock for the file because it references the
+ * file's size.
+ *
+ * Returns: The new offset, or errno
+ */
+
+static loff_t gfs2_llseek(struct file *file, loff_t offset, int origin)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	struct gfs2_holder i_gh;
+	loff_t error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_file);
+
+	if (origin == 2) {
+		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY,
+					   &i_gh);
+		if (!error) {
+			error = remote_llseek(file, offset, origin);
+			gfs2_glock_dq_uninit(&i_gh);
+		}
+	} else
+		error = remote_llseek(file, offset, origin);
+
+	return error;
+}
+
+static inline unsigned int vma2state(struct vm_area_struct *vma)
+{
+	if ((vma->vm_flags & (VM_MAYWRITE | VM_MAYSHARE)) ==
+	    (VM_MAYWRITE | VM_MAYSHARE))
+		return LM_ST_EXCLUSIVE;
+	return LM_ST_SHARED;
+}
+
+static ssize_t walk_vm_hard(struct file *file, char *buf, size_t size,
+			    loff_t *offset, do_rw_t operation)
+{
+	struct gfs2_holder *ghs;
+	unsigned int num_gh = 0;
+	ssize_t count;
+	struct super_block *sb = file->f_dentry->d_inode->i_sb;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	unsigned long start = (unsigned long)buf;
+	unsigned long end = start + size;
+	int dumping = (current->flags & PF_DUMPCORE);
+	unsigned int x = 0;
+
+	for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
+		if (end <= vma->vm_start)
+			break;
+		if (vma->vm_file &&
+		    vma->vm_file->f_dentry->d_inode->i_sb == sb) {
+			num_gh++;
+		}
+	}
+
+	ghs = kcalloc((num_gh + 1), sizeof(struct gfs2_holder), GFP_KERNEL);
+	if (!ghs) {
+		if (!dumping)
+			up_read(&mm->mmap_sem);
+		return -ENOMEM;
+	}
+
+	for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
+		if (end <= vma->vm_start)
+			break;
+		if (vma->vm_file) {
+			struct inode *inode = vma->vm_file->f_dentry->d_inode;
+			if (inode->i_sb == sb)
+				gfs2_holder_init(get_v2ip(inode)->i_gl,
+						 vma2state(vma), 0, &ghs[x++]);
+		}
+	}
+
+	if (!dumping)
+		up_read(&mm->mmap_sem);
+
+	gfs2_assert(get_v2sdp(sb), x == num_gh,);
+
+	count = operation(file, buf, size, offset, num_gh, ghs);
+
+	while (num_gh--)
+		gfs2_holder_uninit(&ghs[num_gh]);
+	kfree(ghs);
+
+	return count;
+}
+
+/**
+ * walk_vm - Walk the vmas associated with a buffer for read or write.
+ *    If any of them are gfs2, pass the gfs2 inode down to the read/write
+ *    worker function so that locks can be acquired in the correct order.
+ * @file: The file to read/write from/to
+ * @buf: The buffer to copy to/from
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ * @operation: The read or write worker function
+ *
+ * Outputs: Offset - updated according to number of bytes written
+ *
+ * Returns: The number of bytes written, errno on failure
+ */
+
+static ssize_t walk_vm(struct file *file, char *buf, size_t size,
+		       loff_t *offset, do_rw_t operation)
+{
+	struct gfs2_holder gh;
+
+	if (current->mm) {
+		struct super_block *sb = file->f_dentry->d_inode->i_sb;
+		struct mm_struct *mm = current->mm;
+		struct vm_area_struct *vma;
+		unsigned long start = (unsigned long)buf;
+		unsigned long end = start + size;
+		int dumping = (current->flags & PF_DUMPCORE);
+
+		if (!dumping)
+			down_read(&mm->mmap_sem);
+
+		for (vma = find_vma(mm, start); vma; vma = vma->vm_next) {
+			if (end <= vma->vm_start)
+				break;
+			if (vma->vm_file &&
+			    vma->vm_file->f_dentry->d_inode->i_sb == sb)
+				goto do_locks;
+		}
+
+		if (!dumping)
+			up_read(&mm->mmap_sem);
+	}
+
+	return operation(file, buf, size, offset, 0, &gh);
+
+ do_locks:
+	return walk_vm_hard(file, buf, size, offset, operation);
+}
+
+static ssize_t do_jdata_read(struct file *file, char *buf, size_t size,
+			     loff_t *offset)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	ssize_t count = 0;
+
+	if (*offset < 0)
+		return -EINVAL;
+	if (!access_ok(VERIFY_WRITE, buf, size))
+		return -EFAULT;
+
+	if (!(file->f_flags & O_LARGEFILE)) {
+		if (*offset >= MAX_NON_LFS)
+			return -EFBIG;
+		if (*offset + size > MAX_NON_LFS)
+			size = MAX_NON_LFS - *offset;
+	}
+
+	count = gfs2_jdata_read(ip, buf, *offset, size, gfs2_copy2user);
+
+	if (count > 0)
+		*offset += count;
+
+	return count;
+}
+
+/**
+ * do_read_direct - Read bytes from a file
+ * @file: The file to read from
+ * @buf: The buffer to copy into
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ * @num_gh: The number of other locks we need to do the read
+ * @ghs: the locks we need plus one for our lock
+ *
+ * Outputs: Offset - updated according to number of bytes read
+ *
+ * Returns: The number of bytes read, errno on failure
+ */
+
+static ssize_t do_read_direct(struct file *file, char *buf, size_t size,
+			      loff_t *offset, unsigned int num_gh,
+			      struct gfs2_holder *ghs)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	unsigned int state = LM_ST_DEFERRED;
+	int flags = 0;
+	unsigned int x;
+	ssize_t count = 0;
+	int error;
+
+	for (x = 0; x < num_gh; x++)
+		if (ghs[x].gh_gl == ip->i_gl) {
+			state = LM_ST_SHARED;
+			flags |= GL_LOCAL_EXCL;
+			break;
+		}
+
+	gfs2_holder_init(ip->i_gl, state, flags, &ghs[num_gh]);
+
+	error = gfs2_glock_nq_m(num_gh + 1, ghs);
+	if (error)
+		goto out;
+
+	error = -EINVAL;
+	if (gfs2_is_jdata(ip))
+		goto out_gunlock;
+
+	if (gfs2_is_stuffed(ip)) {
+		size_t mask = bdev_hardsect_size(inode->i_sb->s_bdev) - 1;
+
+		if (((*offset) & mask) || (((unsigned long)buf) & mask))
+			goto out_gunlock;
+
+		count = do_jdata_read(file, buf, size & ~mask, offset);
+	} else
+		count = generic_file_read(file, buf, size, offset);
+
+	error = 0;
+
+ out_gunlock:
+	gfs2_glock_dq_m(num_gh + 1, ghs);
+
+ out:
+	gfs2_holder_uninit(&ghs[num_gh]);
+
+	return (count) ? count : error;
+}
+
+/**
+ * do_read_buf - Read bytes from a file
+ * @file: The file to read from
+ * @buf: The buffer to copy into
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ * @num_gh: The number of other locks we need to do the read
+ * @ghs: the locks we need plus one for our lock
+ *
+ * Outputs: Offset - updated according to number of bytes read
+ *
+ * Returns: The number of bytes read, errno on failure
+ */
+
+static ssize_t do_read_buf(struct file *file, char *buf, size_t size,
+			   loff_t *offset, unsigned int num_gh,
+			   struct gfs2_holder *ghs)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	ssize_t count = 0;
+	int error;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &ghs[num_gh]);
+
+	error = gfs2_glock_nq_m_atime(num_gh + 1, ghs);
+	if (error)
+		goto out;
+
+	if (gfs2_is_jdata(ip) ||
+	    (gfs2_is_stuffed(ip) && !test_bit(GIF_PAGED, &ip->i_flags)))
+		count = do_jdata_read(file, buf, size, offset);
+	else
+		count = generic_file_read(file, buf, size, offset);
+
+	gfs2_glock_dq_m(num_gh + 1, ghs);
+
+ out:
+	gfs2_holder_uninit(&ghs[num_gh]);
+
+	return (count) ? count : error;
+}
+
+/**
+ * gfs2_read - Read bytes from a file
+ * @file: The file to read from
+ * @buf: The buffer to copy into
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ *
+ * Outputs: Offset - updated according to number of bytes read
+ *
+ * Returns: The number of bytes read, errno on failure
+ */
+
+static ssize_t gfs2_read(struct file *file, char *buf, size_t size,
+			 loff_t *offset)
+{
+	atomic_inc(&get_v2sdp(file->f_mapping->host->i_sb)->sd_ops_file);
+
+	if (file->f_flags & O_DIRECT)
+		return walk_vm(file, buf, size, offset, do_read_direct);
+	else
+		return walk_vm(file, buf, size, offset, do_read_buf);
+}
+
+/**
+ * grope_mapping - feel up a mapping that needs to be written
+ * @buf: the start of the memory to be written
+ * @size: the size of the memory to be written
+ *
+ * We do this after acquiring the locks on the mapping,
+ * but before starting the write transaction.  We need to make
+ * sure that we don't cause recursive transactions if blocks
+ * need to be allocated to the file backing the mapping.
+ *
+ * Returns: errno
+ */
+
+static int grope_mapping(char *buf, size_t size)
+{
+	unsigned long start = (unsigned long)buf;
+	unsigned long stop = start + size;
+	char c;
+
+	while (start < stop) {
+		if (copy_from_user(&c, (char *)start, 1))
+			return -EFAULT;
+		start += PAGE_CACHE_SIZE;
+		start &= PAGE_CACHE_MASK;
+	}
+
+	return 0;
+}
+
+/**
+ * do_write_direct_alloc - Write bytes to a file
+ * @file: The file to write to
+ * @buf: The buffer to copy from
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ *
+ * Outputs: Offset - updated according to number of bytes written
+ *
+ * Returns: The number of bytes written, errno on failure
+ */
+
+static ssize_t do_write_direct_alloc(struct file *file, char *buf, size_t size,
+				     loff_t *offset)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_alloc *al = NULL;
+	struct iovec local_iov = { .iov_base = buf, .iov_len = size };
+	struct buffer_head *dibh;
+	unsigned int data_blocks, ind_blocks;
+	ssize_t count;
+	int error;
+
+	gfs2_write_calc_reserv(ip, size, &data_blocks, &ind_blocks);
+
+	al = gfs2_alloc_get(ip);
+
+	error = gfs2_quota_lock(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+	if (error)
+		goto fail;
+
+	error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+	if (error)
+		goto fail_gunlock_q;
+
+	al->al_requested = data_blocks + ind_blocks;
+
+	error = gfs2_inplace_reserve(ip);
+	if (error)
+		goto fail_gunlock_q;
+
+	error = gfs2_trans_begin(sdp,
+				 al->al_rgd->rd_ri.ri_length + ind_blocks +
+				 RES_DINODE + RES_STATFS + RES_QUOTA, 0);
+	if (error)
+		goto fail_ipres;
+
+	if ((ip->i_di.di_mode & (S_ISUID | S_ISGID)) && !capable(CAP_FSETID)) {
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			goto fail_end_trans;
+
+		ip->i_di.di_mode &= (ip->i_di.di_mode & S_IXGRP) ?
+			(~(S_ISUID | S_ISGID)) : (~S_ISUID);
+
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	if (gfs2_is_stuffed(ip)) {
+		error = gfs2_unstuff_dinode(ip, gfs2_unstuffer_sync, NULL);
+		if (error)
+			goto fail_end_trans;
+	}
+
+	count = generic_file_write_nolock(file, &local_iov, 1, offset);
+	if (count < 0) {
+		error = count;
+		goto fail_end_trans;
+	}
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto fail_end_trans;
+
+	if (ip->i_di.di_size < inode->i_size)
+		ip->i_di.di_size = inode->i_size;
+	ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+	gfs2_trans_end(sdp);
+
+	if (file->f_flags & O_SYNC)
+		gfs2_log_flush_glock(ip->i_gl);
+
+	gfs2_inplace_release(ip);
+	gfs2_quota_unlock(ip);
+	gfs2_alloc_put(ip);
+
+	return count;
+
+ fail_end_trans:
+	gfs2_trans_end(sdp);
+
+ fail_ipres:
+	gfs2_inplace_release(ip);
+
+ fail_gunlock_q:
+	gfs2_quota_unlock(ip);
+
+ fail:
+	gfs2_alloc_put(ip);
+
+	return error;
+}
+
+/**
+ * do_write_direct - Write bytes to a file
+ * @file: The file to write to
+ * @buf: The buffer to copy from
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ * @num_gh: The number of other locks we need to do the read
+ * @gh: the locks we need plus one for our lock
+ *
+ * Outputs: Offset - updated according to number of bytes written
+ *
+ * Returns: The number of bytes written, errno on failure
+ */
+
+static ssize_t do_write_direct(struct file *file, char *buf, size_t size,
+			       loff_t *offset, unsigned int num_gh,
+			       struct gfs2_holder *ghs)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_file *fp = get_v2fp(file);
+	unsigned int state = LM_ST_DEFERRED;
+	int alloc_required;
+	unsigned int x;
+	size_t s;
+	ssize_t count = 0;
+	int error;
+
+	if (test_bit(GFF_DID_DIRECT_ALLOC, &fp->f_flags))
+		state = LM_ST_EXCLUSIVE;
+	else
+		for (x = 0; x < num_gh; x++)
+			if (ghs[x].gh_gl == ip->i_gl) {
+				state = LM_ST_EXCLUSIVE;
+				break;
+			}
+
+ restart:
+	gfs2_holder_init(ip->i_gl, state, 0, &ghs[num_gh]);
+
+	error = gfs2_glock_nq_m(num_gh + 1, ghs);
+	if (error)
+		goto out;
+
+	error = -EINVAL;
+	if (gfs2_is_jdata(ip))
+		goto out_gunlock;
+
+	if (num_gh) {
+		error = grope_mapping(buf, size);
+		if (error)
+			goto out_gunlock;
+	}
+
+	if (file->f_flags & O_APPEND)
+		*offset = ip->i_di.di_size;
+
+	if (!(file->f_flags & O_LARGEFILE)) {
+		error = -EFBIG;
+		if (*offset >= MAX_NON_LFS)
+			goto out_gunlock;
+		if (*offset + size > MAX_NON_LFS)
+			size = MAX_NON_LFS - *offset;
+	}
+
+	if (gfs2_is_stuffed(ip) ||
+	    *offset + size > ip->i_di.di_size ||
+	    ((ip->i_di.di_mode & (S_ISUID | S_ISGID)) && !capable(CAP_FSETID)))
+		alloc_required = TRUE;
+	else {
+		error = gfs2_write_alloc_required(ip, *offset, size,
+						 &alloc_required);
+		if (error)
+			goto out_gunlock;
+	}
+
+	if (alloc_required && state != LM_ST_EXCLUSIVE) {
+		gfs2_glock_dq_m(num_gh + 1, ghs);
+		gfs2_holder_uninit(&ghs[num_gh]);
+		state = LM_ST_EXCLUSIVE;
+		goto restart;
+	}
+
+	if (alloc_required) {
+		set_bit(GFF_DID_DIRECT_ALLOC, &fp->f_flags);
+
+		/* split large writes into smaller atomic transactions */
+		while (size) {
+			s = gfs2_tune_get(sdp, gt_max_atomic_write);
+			if (s > size)
+				s = size;
+
+			error = do_write_direct_alloc(file, buf, s, offset);
+			if (error < 0)
+				goto out_gunlock;
+
+			buf += error;
+			size -= error;
+			count += error;
+		}
+	} else {
+		struct iovec local_iov = { .iov_base = buf, .iov_len = size };
+		struct gfs2_holder t_gh;
+
+		clear_bit(GFF_DID_DIRECT_ALLOC, &fp->f_flags);
+
+		error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_SHARED,
+					   GL_NEVER_RECURSE, &t_gh);
+		if (error)
+			goto out_gunlock;
+
+		count = generic_file_write_nolock(file, &local_iov, 1, offset);
+
+		gfs2_glock_dq_uninit(&t_gh);
+	}
+
+	error = 0;
+
+ out_gunlock:
+	gfs2_glock_dq_m(num_gh + 1, ghs);
+
+ out:
+	gfs2_holder_uninit(&ghs[num_gh]);
+
+	return (count) ? count : error;
+}
+
+/**
+ * do_do_write_buf - Write bytes to a file
+ * @file: The file to write to
+ * @buf: The buffer to copy from
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ *
+ * Outputs: Offset - updated according to number of bytes written
+ *
+ * Returns: The number of bytes written, errno on failure
+ */
+
+static ssize_t do_do_write_buf(struct file *file, char *buf, size_t size,
+			       loff_t *offset)
+{
+	struct inode *inode = file->f_mapping->host;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct gfs2_alloc *al = NULL;
+	struct buffer_head *dibh;
+	unsigned int data_blocks, ind_blocks;
+	int alloc_required, journaled;
+	ssize_t count;
+	int error;
+
+	journaled = gfs2_is_jdata(ip);
+
+	gfs2_write_calc_reserv(ip, size, &data_blocks, &ind_blocks);
+
+	error = gfs2_write_alloc_required(ip, *offset, size, &alloc_required);
+	if (error)
+		return error;
+
+	if (alloc_required) {
+		al = gfs2_alloc_get(ip);
+
+		error = gfs2_quota_lock(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+		if (error)
+			goto fail;
+
+		error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+		if (error)
+			goto fail_gunlock_q;
+
+		al->al_requested = data_blocks + ind_blocks;
+
+		error = gfs2_inplace_reserve(ip);
+		if (error)
+			goto fail_gunlock_q;
+
+		error = gfs2_trans_begin(sdp,
+					 al->al_rgd->rd_ri.ri_length +
+					 ind_blocks +
+					 ((journaled) ? data_blocks : 0) +
+					 RES_DINODE + RES_STATFS + RES_QUOTA,
+					 0);
+		if (error)
+			goto fail_ipres;
+	} else {
+		error = gfs2_trans_begin(sdp,
+					((journaled) ? data_blocks : 0) +
+					RES_DINODE,
+					0);
+		if (error)
+			goto fail_ipres;
+	}
+
+	if ((ip->i_di.di_mode & (S_ISUID | S_ISGID)) && !capable(CAP_FSETID)) {
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			goto fail_end_trans;
+
+		ip->i_di.di_mode &= (ip->i_di.di_mode & S_IXGRP) ?
+					  (~(S_ISUID | S_ISGID)) : (~S_ISUID);
+
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	if (journaled ||
+	    (gfs2_is_stuffed(ip) && !test_bit(GIF_PAGED, &ip->i_flags) &&
+	     *offset + size <= sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode))) {
+
+		count = gfs2_jdata_write(ip, buf, *offset, size,
+					 gfs2_copy_from_user);
+		if (count < 0) {
+			error = count;
+			goto fail_end_trans;
+		}
+
+		*offset += count;
+	} else {
+		struct iovec local_iov = { .iov_base = buf, .iov_len = size };
+
+		count = generic_file_write_nolock(file, &local_iov, 1, offset);
+		if (count < 0) {
+			error = count;
+			goto fail_end_trans;
+		}
+
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			goto fail_end_trans;
+
+		if (ip->i_di.di_size < inode->i_size)
+			ip->i_di.di_size = inode->i_size;
+		ip->i_di.di_mtime = ip->i_di.di_ctime = get_seconds();
+
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	gfs2_trans_end(sdp);
+
+	if (file->f_flags & O_SYNC)
+		gfs2_log_flush_glock(ip->i_gl);
+
+	if (alloc_required) {
+		gfs2_assert_warn(sdp, count != size ||
+				 al->al_alloced);
+		gfs2_inplace_release(ip);
+		gfs2_quota_unlock(ip);
+		gfs2_alloc_put(ip);
+	}
+
+	return count;
+
+ fail_end_trans:
+	gfs2_trans_end(sdp);
+
+ fail_ipres:
+	if (alloc_required)
+		gfs2_inplace_release(ip);
+
+ fail_gunlock_q:
+	if (alloc_required)
+		gfs2_quota_unlock(ip);
+
+ fail:
+	if (alloc_required)
+		gfs2_alloc_put(ip);
+
+	return error;
+}
+
+/**
+ * do_write_buf - Write bytes to a file
+ * @file: The file to write to
+ * @buf: The buffer to copy from
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ * @num_gh: The number of other locks we need to do the read
+ * @gh: the locks we need plus one for our lock
+ *
+ * Outputs: Offset - updated according to number of bytes written
+ *
+ * Returns: The number of bytes written, errno on failure
+ */
+
+static ssize_t do_write_buf(struct file *file, char *buf, size_t size,
+			    loff_t *offset, unsigned int num_gh,
+			    struct gfs2_holder *ghs)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	size_t s;
+	ssize_t count = 0;
+	int error;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &ghs[num_gh]);
+
+	error = gfs2_glock_nq_m(num_gh + 1, ghs);
+	if (error)
+		goto out;
+
+	if (num_gh) {
+		error = grope_mapping(buf, size);
+		if (error)
+			goto out_gunlock;
+	}
+
+	if (file->f_flags & O_APPEND)
+		*offset = ip->i_di.di_size;
+
+	if (!(file->f_flags & O_LARGEFILE)) {
+		error = -EFBIG;
+		if (*offset >= MAX_NON_LFS)
+			goto out_gunlock;
+		if (*offset + size > MAX_NON_LFS)
+			size = MAX_NON_LFS - *offset;
+	}
+
+	/* split large writes into smaller atomic transactions */
+	while (size) {
+		s = gfs2_tune_get(sdp, gt_max_atomic_write);
+		if (s > size)
+			s = size;
+
+		error = do_do_write_buf(file, buf, s, offset);
+		if (error < 0)
+			goto out_gunlock;
+
+		buf += error;
+		size -= error;
+		count += error;
+	}
+
+	error = 0;
+
+ out_gunlock:
+	gfs2_glock_dq_m(num_gh + 1, ghs);
+
+ out:
+	gfs2_holder_uninit(&ghs[num_gh]);
+
+	return (count) ? count : error;
+}
+
+/**
+ * gfs2_write - Write bytes to a file
+ * @file: The file to write to
+ * @buf: The buffer to copy from
+ * @size: The amount of data requested
+ * @offset: The current file offset
+ *
+ * Outputs: Offset - updated according to number of bytes written
+ *
+ * Returns: The number of bytes written, errno on failure
+ */
+
+static ssize_t gfs2_write(struct file *file, const char *buf, size_t size,
+			  loff_t *offset)
+{
+	struct inode *inode = file->f_mapping->host;
+	ssize_t count;
+
+	atomic_inc(&get_v2sdp(inode->i_sb)->sd_ops_file);
+
+	if (*offset < 0)
+		return -EINVAL;
+	if (!access_ok(VERIFY_READ, buf, size))
+		return -EFAULT;
+
+	down(&inode->i_sem);
+	if (file->f_flags & O_DIRECT)
+		count = walk_vm(file, (char *)buf, size, offset,
+				do_write_direct);
+	else
+		count = walk_vm(file, (char *)buf, size, offset, do_write_buf);
+	up(&inode->i_sem);
+
+	return count;
+}
+
+/**
+ * filldir_reg_func - Report a directory entry to the caller of gfs2_dir_read()
+ * @opaque: opaque data used by the function
+ * @name: the name of the directory entry
+ * @length: the length of the name
+ * @offset: the entry's offset in the directory
+ * @inum: the inode number the entry points to
+ * @type: the type of inode the entry points to
+ *
+ * Returns: 0 on success, 1 if buffer full
+ */
+
+static int filldir_reg_func(void *opaque, const char *name, unsigned int length,
+			    uint64_t offset, struct gfs2_inum *inum,
+			    unsigned int type)
+{
+	struct filldir_reg *fdr = (struct filldir_reg *)opaque;
+	struct gfs2_sbd *sdp = fdr->fdr_sbd;
+	int error;
+
+	error = fdr->fdr_filldir(fdr->fdr_opaque, name, length, offset,
+				 inum->no_formal_ino, type);
+	if (error)
+		return 1;
+
+	if (fdr->fdr_prefetch && !(length == 1 && *name == '.')) {
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_inode_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY | LM_FLAG_ANY);
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_iopen_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY);
+	}
+
+	return 0;
+}
+
+/**
+ * readdir_reg - Read directory entries from a directory
+ * @file: The directory to read from
+ * @dirent: Buffer for dirents
+ * @filldir: Function used to do the copying
+ *
+ * Returns: errno
+ */
+
+static int readdir_reg(struct file *file, void *dirent, filldir_t filldir)
+{
+	struct gfs2_inode *dip = get_v2ip(file->f_mapping->host);
+	struct filldir_reg fdr;
+	struct gfs2_holder d_gh;
+	uint64_t offset = file->f_pos;
+	int error;
+
+	fdr.fdr_sbd = dip->i_sbd;
+	fdr.fdr_prefetch = TRUE;
+	fdr.fdr_filldir = filldir;
+	fdr.fdr_opaque = dirent;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_SHARED, GL_ATIME, &d_gh);
+	error = gfs2_glock_nq_atime(&d_gh);
+	if (error) {
+		gfs2_holder_uninit(&d_gh);
+		return error;
+	}
+
+	error = gfs2_dir_read(dip, &offset, &fdr, filldir_reg_func);
+
+	gfs2_glock_dq_uninit(&d_gh);
+
+	file->f_pos = offset;
+
+	return error;
+}
+
+/**
+ * filldir_bad_func - Report a directory entry to the caller of gfs2_dir_read()
+ * @opaque: opaque data used by the function
+ * @name: the name of the directory entry
+ * @length: the length of the name
+ * @offset: the entry's offset in the directory
+ * @inum: the inode number the entry points to
+ * @type: the type of inode the entry points to
+ *
+ * For supporting NFS.
+ *
+ * Returns: 0 on success, 1 if buffer full
+ */
+
+static int filldir_bad_func(void *opaque, const char *name, unsigned int length,
+			    uint64_t offset, struct gfs2_inum *inum,
+			    unsigned int type)
+{
+	struct filldir_bad *fdb = (struct filldir_bad *)opaque;
+	struct gfs2_sbd *sdp = fdb->fdb_sbd;
+	struct filldir_bad_entry *fbe;
+
+	if (fdb->fdb_entry_off == fdb->fdb_entry_num ||
+	    fdb->fdb_name_off + length > fdb->fdb_name_size)
+		return 1;
+
+	fbe = &fdb->fdb_entry[fdb->fdb_entry_off];
+	fbe->fbe_name = fdb->fdb_name + fdb->fdb_name_off;
+	memcpy(fbe->fbe_name, name, length);
+	fbe->fbe_length = length;
+	fbe->fbe_offset = offset;
+	fbe->fbe_inum = *inum;
+	fbe->fbe_type = type;
+
+	fdb->fdb_entry_off++;
+	fdb->fdb_name_off += length;
+
+	if (!(length == 1 && *name == '.')) {
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_inode_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY | LM_FLAG_ANY);
+		gfs2_glock_prefetch_num(sdp,
+				       inum->no_addr, &gfs2_iopen_glops,
+				       LM_ST_SHARED, LM_FLAG_TRY);
+	}
+
+	return 0;
+}
+
+/**
+ * readdir_bad - Read directory entries from a directory
+ * @file: The directory to read from
+ * @dirent: Buffer for dirents
+ * @filldir: Function used to do the copying
+ *
+ * For supporting NFS.
+ *
+ * Returns: errno
+ */
+
+static int readdir_bad(struct file *file, void *dirent, filldir_t filldir)
+{
+	struct gfs2_inode *dip = get_v2ip(file->f_mapping->host);
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct filldir_reg fdr;
+	unsigned int entries, size;
+	struct filldir_bad *fdb;
+	struct gfs2_holder d_gh;
+	uint64_t offset = file->f_pos;
+	unsigned int x;
+	struct filldir_bad_entry *fbe;
+	int error;
+
+	entries = gfs2_tune_get(sdp, gt_entries_per_readdir);
+	size = sizeof(struct filldir_bad) +
+	    entries * (sizeof(struct filldir_bad_entry) + GFS2_FAST_NAME_SIZE);
+
+	fdb = kzalloc(size, GFP_KERNEL);
+	if (!fdb)
+		return -ENOMEM;
+
+	fdb->fdb_sbd = sdp;
+	fdb->fdb_entry = (struct filldir_bad_entry *)(fdb + 1);
+	fdb->fdb_entry_num = entries;
+	fdb->fdb_name = ((char *)fdb) + sizeof(struct filldir_bad) +
+		entries * sizeof(struct filldir_bad_entry);
+	fdb->fdb_name_size = entries * GFS2_FAST_NAME_SIZE;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_SHARED, GL_ATIME, &d_gh);
+	error = gfs2_glock_nq_atime(&d_gh);
+	if (error) {
+		gfs2_holder_uninit(&d_gh);
+		goto out;
+	}
+
+	error = gfs2_dir_read(dip, &offset, fdb, filldir_bad_func);
+
+	gfs2_glock_dq_uninit(&d_gh);
+
+	fdr.fdr_sbd = sdp;
+	fdr.fdr_prefetch = FALSE;
+	fdr.fdr_filldir = filldir;
+	fdr.fdr_opaque = dirent;
+
+	for (x = 0; x < fdb->fdb_entry_off; x++) {
+		fbe = &fdb->fdb_entry[x];
+
+		error = filldir_reg_func(&fdr,
+					 fbe->fbe_name, fbe->fbe_length,
+					 fbe->fbe_offset,
+					 &fbe->fbe_inum, fbe->fbe_type);
+		if (error) {
+			file->f_pos = fbe->fbe_offset;
+			error = 0;
+			goto out;
+		}
+	}
+
+	file->f_pos = offset;
+
+ out:
+	kfree(fdb);
+
+	return error;
+}
+
+/**
+ * gfs2_readdir - Read directory entries from a directory
+ * @file: The directory to read from
+ * @dirent: Buffer for dirents
+ * @filldir: Function used to do the copying
+ *
+ * Returns: errno
+ */
+
+static int gfs2_readdir(struct file *file, void *dirent, filldir_t filldir)
+{
+	int error;
+
+	atomic_inc(&get_v2sdp(file->f_mapping->host->i_sb)->sd_ops_file);
+
+	if (strcmp(current->comm, "nfsd") != 0)
+		error = readdir_reg(file, dirent, filldir);
+	else
+		error = readdir_bad(file, dirent, filldir);
+
+	return error;
+}
+
+/**
+ * gfs2_ioctl - do an ioctl on a file
+ * @inode: the inode
+ * @file: the file pointer
+ * @cmd: the ioctl command
+ * @arg: the argument
+ *
+ * Returns: errno
+ */
+
+static int gfs2_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
+		      unsigned long arg)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+
+	atomic_inc(&ip->i_sbd->sd_ops_file);
+
+	switch (cmd) {
+	case GFS2_IOCTL_IDENTIFY: {
+		unsigned int x = GFS2_MAGIC;
+		if (copy_to_user((unsigned int *)arg, &x, sizeof(unsigned int)))
+			return -EFAULT;
+		return 0;
+	}
+
+	case GFS2_IOCTL_SUPER:
+		return gfs2_ioctl_i(ip, (void *)arg);
+
+	default:
+		return -ENOTTY;
+	}
+}
+
+/**
+ * gfs2_mmap -
+ * @file: The file to map
+ * @vma: The VMA which described the mapping
+ *
+ * Returns: 0 or error code
+ */
+
+static int gfs2_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	struct gfs2_holder i_gh;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_file);
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &i_gh);
+	error = gfs2_glock_nq_atime(&i_gh);
+	if (error) {
+		gfs2_holder_uninit(&i_gh);
+		return error;
+	}
+
+	if (gfs2_is_jdata(ip)) {
+		if (vma->vm_flags & VM_MAYSHARE)
+			error = -EOPNOTSUPP;
+		else
+			vma->vm_ops = &gfs2_vm_ops_private;
+	} else {
+		/* This is VM_MAYWRITE instead of VM_WRITE because a call
+		   to mprotect() can turn on VM_WRITE later. */
+
+		if ((vma->vm_flags & (VM_MAYSHARE | VM_MAYWRITE)) ==
+		    (VM_MAYSHARE | VM_MAYWRITE))
+			vma->vm_ops = &gfs2_vm_ops_sharewrite;
+		else
+			vma->vm_ops = &gfs2_vm_ops_private;
+	}
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return error;
+}
+
+/**
+ * gfs2_open - open a file
+ * @inode: the inode to open
+ * @file: the struct file for this opening
+ *
+ * Returns: errno
+ */
+
+static int gfs2_open(struct inode *inode, struct file *file)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_holder i_gh;
+	struct gfs2_file *fp;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_file);
+
+	fp = kzalloc(sizeof(struct gfs2_file), GFP_KERNEL);
+	if (!fp)
+		return -ENOMEM;
+
+	init_MUTEX(&fp->f_fl_mutex);
+
+	fp->f_inode = ip;
+	fp->f_vfile = file;
+
+	gfs2_assert_warn(ip->i_sbd, !get_v2fp(file));
+	set_v2fp(file, fp);
+
+	if (S_ISREG(ip->i_di.di_mode)) {
+		error = gfs2_glock_nq_init(ip->i_gl,
+					  LM_ST_SHARED, LM_FLAG_ANY,
+					  &i_gh);
+		if (error)
+			goto fail;
+
+		if (!(file->f_flags & O_LARGEFILE) &&
+		    ip->i_di.di_size > MAX_NON_LFS) {
+			error = -EFBIG;
+			goto fail_gunlock;
+		}
+
+		/* Listen to the Direct I/O flag */
+
+		if (ip->i_di.di_flags & GFS2_DIF_DIRECTIO)
+			file->f_flags |= O_DIRECT;
+
+		/* Don't let the user open O_DIRECT on a jdata file */
+
+		if ((file->f_flags & O_DIRECT) && gfs2_is_jdata(ip)) {
+			error = -EINVAL;
+			goto fail_gunlock;
+		}
+
+		gfs2_glock_dq_uninit(&i_gh);
+	}
+
+	return 0;
+
+ fail_gunlock:
+	gfs2_glock_dq_uninit(&i_gh);
+
+ fail:
+	set_v2fp(file, NULL);
+	kfree(fp);
+
+	return error;
+}
+
+/**
+ * gfs2_close - called to close a struct file
+ * @inode: the inode the struct file belongs to
+ * @file: the struct file being closed
+ *
+ * Returns: errno
+ */
+
+static int gfs2_close(struct inode *inode, struct file *file)
+{
+	struct gfs2_sbd *sdp = get_v2sdp(inode->i_sb);
+	struct gfs2_file *fp;
+
+	atomic_inc(&sdp->sd_ops_file);
+
+	fp = get_v2fp(file);
+	set_v2fp(file, NULL);
+
+	if (gfs2_assert_warn(sdp, fp))
+		return -EIO;
+
+	kfree(fp);
+
+	return 0;
+}
+
+/**
+ * gfs2_fsync - sync the dirty data for a file (across the cluster)
+ * @file: the file that points to the dentry (we ignore this)
+ * @dentry: the dentry that points to the inode to sync
+ *
+ * Returns: errno
+ */
+
+static int gfs2_fsync(struct file *file, struct dentry *dentry, int datasync)
+{
+	struct gfs2_inode *ip = get_v2ip(dentry->d_inode);
+
+	atomic_inc(&ip->i_sbd->sd_ops_file);
+	gfs2_log_flush_glock(ip->i_gl);
+
+	return 0;
+}
+
+/**
+ * gfs2_lock - acquire/release a posix lock on a file
+ * @file: the file pointer
+ * @cmd: either modify or retrieve lock state, possibly wait
+ * @fl: type and range of lock
+ *
+ * Returns: errno
+ */
+
+static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct lm_lockname name =
+		{ .ln_number = ip->i_num.no_addr,
+		  .ln_type = LM_TYPE_PLOCK };
+
+	atomic_inc(&sdp->sd_ops_file);
+
+	if (!(fl->fl_flags & FL_POSIX))
+		return -ENOLCK;
+	if ((ip->i_di.di_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+		return -ENOLCK;
+
+	if (sdp->sd_args.ar_localflocks) {
+		if (IS_GETLK(cmd)) {
+			struct file_lock *tmp;
+			lock_kernel();
+			tmp = posix_test_lock(file, fl);
+			fl->fl_type = F_UNLCK;
+			if (tmp)
+				memcpy(fl, tmp, sizeof(struct file_lock));
+			unlock_kernel();
+			return 0;
+		} else {
+			int error;
+			lock_kernel();
+			error = posix_lock_file_wait(file, fl);
+			unlock_kernel();
+			return error;
+		}
+	}
+
+	if (IS_GETLK(cmd))
+		return gfs2_lm_plock_get(sdp, &name, file, fl);
+	else if (fl->fl_type == F_UNLCK)
+		return gfs2_lm_punlock(sdp, &name, file, fl);
+	else
+		return gfs2_lm_plock(sdp, &name, file, cmd, fl);
+}
+
+/**
+ * gfs2_sendfile - Send bytes to a file or socket
+ * @in_file: The file to read from
+ * @out_file: The file to write to
+ * @count: The amount of data
+ * @offset: The beginning file offset
+ *
+ * Outputs: offset - updated according to number of bytes read
+ *
+ * Returns: The number of bytes sent, errno on failure
+ */
+
+static ssize_t gfs2_sendfile(struct file *in_file, loff_t *offset, size_t count,
+			     read_actor_t actor, void __user *target)
+{
+	struct gfs2_inode *ip = get_v2ip(in_file->f_mapping->host);
+	struct gfs2_holder gh;
+	ssize_t retval;
+
+	atomic_inc(&ip->i_sbd->sd_ops_file);
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, GL_ATIME, &gh);
+
+	retval = gfs2_glock_nq_atime(&gh);
+	if (retval)
+		goto out;
+
+	if (gfs2_is_jdata(ip))
+		retval = -EOPNOTSUPP;
+	else
+		retval = generic_file_sendfile(in_file, offset, count, actor,
+					       target);
+
+	gfs2_glock_dq(&gh);
+
+ out:
+	gfs2_holder_uninit(&gh);
+
+	return retval;
+}
+
+static int do_flock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct gfs2_file *fp = get_v2fp(file);
+	struct gfs2_holder *fl_gh = &fp->f_fl_gh;
+	struct gfs2_inode *ip = fp->f_inode;
+	struct gfs2_glock *gl;
+	unsigned int state;
+	int flags;
+	int error = 0;
+
+	state = (fl->fl_type == F_WRLCK) ? LM_ST_EXCLUSIVE : LM_ST_SHARED;
+	flags = ((IS_SETLKW(cmd)) ? 0 : LM_FLAG_TRY) | GL_EXACT | GL_NOCACHE;
+
+	down(&fp->f_fl_mutex);
+
+	gl = fl_gh->gh_gl;
+	if (gl) {
+		if (fl_gh->gh_state == state)
+			goto out;
+		gfs2_glock_hold(gl);
+		flock_lock_file_wait(file,
+				     &(struct file_lock){.fl_type = F_UNLCK});		
+		gfs2_glock_dq_uninit(fl_gh);
+	} else {
+		error = gfs2_glock_get(ip->i_sbd,
+				      ip->i_num.no_addr, &gfs2_flock_glops,
+				      CREATE, &gl);
+		if (error)
+			goto out;
+	}
+
+	gfs2_holder_init(gl, state, flags, fl_gh);
+	gfs2_glock_put(gl);
+
+	error = gfs2_glock_nq(fl_gh);
+	if (error) {
+		gfs2_holder_uninit(fl_gh);
+		if (error == GLR_TRYFAILED)
+			error = -EAGAIN;
+	} else {
+		error = flock_lock_file_wait(file, fl);
+		gfs2_assert_warn(ip->i_sbd, !error);
+	}
+
+ out:
+	up(&fp->f_fl_mutex);
+
+	return error;
+}
+
+static void do_unflock(struct file *file, struct file_lock *fl)
+{
+	struct gfs2_file *fp = get_v2fp(file);
+	struct gfs2_holder *fl_gh = &fp->f_fl_gh;
+
+	down(&fp->f_fl_mutex);
+	flock_lock_file_wait(file, fl);
+	if (fl_gh->gh_gl)
+		gfs2_glock_dq_uninit(fl_gh);
+	up(&fp->f_fl_mutex);
+}
+
+/**
+ * gfs2_flock - acquire/release a flock lock on a file
+ * @file: the file pointer
+ * @cmd: either modify or retrieve lock state, possibly wait
+ * @fl: type and range of lock
+ *
+ * Returns: errno
+ */
+
+static int gfs2_flock(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct gfs2_inode *ip = get_v2ip(file->f_mapping->host);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+
+	atomic_inc(&ip->i_sbd->sd_ops_file);
+
+	if (!(fl->fl_flags & FL_FLOCK))
+		return -ENOLCK;
+	if ((ip->i_di.di_mode & (S_ISGID | S_IXGRP)) == S_ISGID)
+		return -ENOLCK;
+
+	if (sdp->sd_args.ar_localflocks)
+		return flock_lock_file_wait(file, fl);
+
+	if (fl->fl_type == F_UNLCK) {
+		do_unflock(file, fl);
+		return 0;
+	} else
+		return do_flock(file, cmd, fl);
+}
+
+struct file_operations gfs2_file_fops = {
+	.llseek = gfs2_llseek,
+	.read = gfs2_read,
+	.write = gfs2_write,
+	.ioctl = gfs2_ioctl,
+	.mmap = gfs2_mmap,
+	.open = gfs2_open,
+	.release = gfs2_close,
+	.fsync = gfs2_fsync,
+	.lock = gfs2_lock,
+	.sendfile = gfs2_sendfile,
+	.flock = gfs2_flock,
+};
+
+struct file_operations gfs2_dir_fops = {
+	.readdir = gfs2_readdir,
+	.ioctl = gfs2_ioctl,
+	.open = gfs2_open,
+	.release = gfs2_close,
+	.fsync = gfs2_fsync,
+	.lock = gfs2_lock,
+	.flock = gfs2_flock,
+};
+
--- a/fs/gfs2/ops_file.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_file.h	2005-09-01 17:36:55.414100424 +0800
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_FILE_DOT_H__
+#define __OPS_FILE_DOT_H__
+
+extern struct file_operations gfs2_file_fops;
+extern struct file_operations gfs2_dir_fops;
+
+#endif /* __OPS_FILE_DOT_H__ */
--- a/fs/gfs2/ops_fstype.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_fstype.c	2005-09-01 17:36:55.415100272 +0800
@@ -0,0 +1,801 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/vmalloc.h>
+#include <linux/blkdev.h>
+#include <linux/kthread.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "daemon.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "lm.h"
+#include "mount.h"
+#include "ops_export.h"
+#include "ops_fstype.h"
+#include "ops_super.h"
+#include "recovery.h"
+#include "rgrp.h"
+#include "super.h"
+#include "unlinked.h"
+#include "sys.h"
+
+#define DO FALSE
+#define UNDO TRUE
+
+static struct gfs2_sbd *init_sbd(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp;
+	unsigned int x;
+
+	sdp = vmalloc(sizeof(struct gfs2_sbd));
+	if (!sdp)
+		return NULL;
+
+	memset(sdp, 0, sizeof(struct gfs2_sbd));
+
+	set_v2sdp(sb, sdp);
+	sdp->sd_vfs = sb;
+
+	gfs2_tune_init(&sdp->sd_tune);
+
+	for (x = 0; x < GFS2_GL_HASH_SIZE; x++) {
+		sdp->sd_gl_hash[x].hb_lock = RW_LOCK_UNLOCKED;
+		INIT_LIST_HEAD(&sdp->sd_gl_hash[x].hb_list);
+	}
+	INIT_LIST_HEAD(&sdp->sd_reclaim_list);
+	spin_lock_init(&sdp->sd_reclaim_lock);
+	init_waitqueue_head(&sdp->sd_reclaim_wq);
+
+	init_MUTEX(&sdp->sd_inum_mutex);
+	spin_lock_init(&sdp->sd_statfs_spin);
+	init_MUTEX(&sdp->sd_statfs_mutex);
+
+	spin_lock_init(&sdp->sd_rindex_spin);
+	init_MUTEX(&sdp->sd_rindex_mutex);
+	INIT_LIST_HEAD(&sdp->sd_rindex_list);
+	INIT_LIST_HEAD(&sdp->sd_rindex_mru_list);
+	INIT_LIST_HEAD(&sdp->sd_rindex_recent_list);
+
+	INIT_LIST_HEAD(&sdp->sd_jindex_list);
+	spin_lock_init(&sdp->sd_jindex_spin);
+	init_MUTEX(&sdp->sd_jindex_mutex);
+
+	INIT_LIST_HEAD(&sdp->sd_unlinked_list);
+	spin_lock_init(&sdp->sd_unlinked_spin);
+	init_MUTEX(&sdp->sd_unlinked_mutex);
+
+	INIT_LIST_HEAD(&sdp->sd_quota_list);
+	spin_lock_init(&sdp->sd_quota_spin);
+	init_MUTEX(&sdp->sd_quota_mutex);
+
+	spin_lock_init(&sdp->sd_log_lock);
+	init_waitqueue_head(&sdp->sd_log_trans_wq);
+	init_waitqueue_head(&sdp->sd_log_flush_wq);
+
+	INIT_LIST_HEAD(&sdp->sd_log_le_gl);
+	INIT_LIST_HEAD(&sdp->sd_log_le_buf);
+	INIT_LIST_HEAD(&sdp->sd_log_le_revoke);
+	INIT_LIST_HEAD(&sdp->sd_log_le_rg);
+	INIT_LIST_HEAD(&sdp->sd_log_le_databuf);
+
+	INIT_LIST_HEAD(&sdp->sd_log_blks_list);
+	init_waitqueue_head(&sdp->sd_log_blks_wait);
+
+	INIT_LIST_HEAD(&sdp->sd_ail1_list);
+	INIT_LIST_HEAD(&sdp->sd_ail2_list);
+
+	init_MUTEX(&sdp->sd_log_flush_lock);
+	INIT_LIST_HEAD(&sdp->sd_log_flush_list);
+
+	INIT_LIST_HEAD(&sdp->sd_revoke_list);
+
+	init_MUTEX(&sdp->sd_freeze_lock);
+
+	return sdp;
+}
+
+static void init_vfs(struct gfs2_sbd *sdp)
+{
+	struct super_block *sb = sdp->sd_vfs;
+
+	sb->s_magic = GFS2_MAGIC;
+	sb->s_op = &gfs2_super_ops;
+	sb->s_export_op = &gfs2_export_ops;
+	sb->s_maxbytes = MAX_LFS_FILESIZE;
+
+	if (sb->s_flags & (MS_NOATIME | MS_NODIRATIME))
+		set_bit(SDF_NOATIME, &sdp->sd_flags);
+
+	/* Don't let the VFS update atimes.  GFS2 handles this itself. */
+	sb->s_flags |= MS_NOATIME | MS_NODIRATIME;
+
+	/* Set up the buffer cache and fill in some fake block size values
+	   to allow us to read-in the on-disk superblock. */
+	sdp->sd_sb.sb_bsize = sb_min_blocksize(sb, GFS2_BASIC_BLOCK);
+	sdp->sd_sb.sb_bsize_shift = sb->s_blocksize_bits;
+	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT;
+	sdp->sd_fsb2bb = 1 << sdp->sd_fsb2bb_shift;
+}
+
+static int init_locking(struct gfs2_sbd *sdp, struct gfs2_holder *mount_gh,
+			int undo)
+{
+	struct task_struct *p;
+	int error = 0;
+
+	if (undo)
+		goto fail_trans;
+
+	p = kthread_run(gfs2_scand, sdp, "gfs2_scand");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start scand thread: %d\n", error);
+		return error;
+	}
+	sdp->sd_scand_process = p;
+
+	for (sdp->sd_glockd_num = 0;
+	     sdp->sd_glockd_num < sdp->sd_args.ar_num_glockd;
+	     sdp->sd_glockd_num++) {
+		p = kthread_run(gfs2_glockd, sdp, "gfs2_glockd");
+		error = IS_ERR(p);
+		if (error) {
+			fs_err(sdp, "can't start glockd thread: %d\n", error);
+			goto fail;
+		}
+		sdp->sd_glockd_process[sdp->sd_glockd_num] = p;
+	}
+
+	error = gfs2_glock_nq_num(sdp,
+				  GFS2_MOUNT_LOCK, &gfs2_nondisk_glops,
+				  LM_ST_EXCLUSIVE, LM_FLAG_NOEXP | GL_NOCACHE,
+				  mount_gh);
+	if (error) {
+		fs_err(sdp, "can't acquire mount glock: %d\n", error);
+		goto fail;
+	}
+
+	error = gfs2_glock_nq_num(sdp,
+				  GFS2_LIVE_LOCK, &gfs2_nondisk_glops,
+				  LM_ST_SHARED,
+				  LM_FLAG_NOEXP | GL_EXACT | GL_NEVER_RECURSE,
+				  &sdp->sd_live_gh);
+	if (error) {
+		fs_err(sdp, "can't acquire live glock: %d\n", error);
+		goto fail_mount;
+	}
+
+	error = gfs2_glock_get(sdp, GFS2_RENAME_LOCK, &gfs2_nondisk_glops,
+			       CREATE, &sdp->sd_rename_gl);
+	if (error) {
+		fs_err(sdp, "can't create rename glock: %d\n", error);
+		goto fail_live;
+	}
+
+	error = gfs2_glock_get(sdp, GFS2_TRANS_LOCK, &gfs2_trans_glops,
+			       CREATE, &sdp->sd_trans_gl);
+	if (error) {
+		fs_err(sdp, "can't create transaction glock: %d\n", error);
+		goto fail_rename;
+	}
+	set_bit(GLF_STICKY, &sdp->sd_trans_gl->gl_flags);
+
+	return 0;
+
+ fail_trans:
+	gfs2_glock_put(sdp->sd_trans_gl);
+
+ fail_rename:
+	gfs2_glock_put(sdp->sd_rename_gl);
+
+ fail_live:
+	gfs2_glock_dq_uninit(&sdp->sd_live_gh);
+
+ fail_mount:
+	gfs2_glock_dq_uninit(mount_gh);
+
+ fail:
+	while (sdp->sd_glockd_num--)
+		kthread_stop(sdp->sd_glockd_process[sdp->sd_glockd_num]);
+
+	kthread_stop(sdp->sd_scand_process);
+
+	return error;
+}
+
+static int init_sb(struct gfs2_sbd *sdp, int silent, int undo)
+{
+	struct super_block *sb = sdp->sd_vfs;
+	struct gfs2_holder sb_gh;
+	int error = 0;
+
+	if (undo) {
+		gfs2_inode_put(sdp->sd_master_dir);
+		return 0;
+	}
+	
+	error = gfs2_glock_nq_num(sdp,
+				 GFS2_SB_LOCK, &gfs2_meta_glops,
+				 LM_ST_SHARED, 0, &sb_gh);
+	if (error) {
+		fs_err(sdp, "can't acquire superblock glock: %d\n", error);
+		return error;
+	}
+
+	error = gfs2_read_sb(sdp, sb_gh.gh_gl, silent);
+	if (error) {
+		fs_err(sdp, "can't read superblock: %d\n", error);
+		goto out;
+	}
+
+	/* Set up the buffer cache and SB for real */
+	error = -EINVAL;
+	if (sdp->sd_sb.sb_bsize < bdev_hardsect_size(sb->s_bdev)) {
+		fs_err(sdp, "FS block size (%u) is too small for device "
+		       "block size (%u)\n",
+		       sdp->sd_sb.sb_bsize, bdev_hardsect_size(sb->s_bdev));
+		goto out;
+	}
+	if (sdp->sd_sb.sb_bsize > PAGE_SIZE) {
+		fs_err(sdp, "FS block size (%u) is too big for machine "
+		       "page size (%u)\n",
+		       sdp->sd_sb.sb_bsize, (unsigned int)PAGE_SIZE);
+		goto out;
+	}
+
+	/* Get rid of buffers from the original block size */
+	sb_gh.gh_gl->gl_ops->go_inval(sb_gh.gh_gl, DIO_METADATA | DIO_DATA);
+	sb_gh.gh_gl->gl_aspace->i_blkbits = sdp->sd_sb.sb_bsize_shift;
+
+	sb_set_blocksize(sb, sdp->sd_sb.sb_bsize);
+
+	error = gfs2_lookup_master_dir(sdp);
+	if (error)
+		fs_err(sdp, "can't read in master directory: %d\n", error);
+
+ out:
+	gfs2_glock_dq_uninit(&sb_gh);
+
+	return error;
+}
+
+static int init_journal(struct gfs2_sbd *sdp, int undo)
+{
+	struct gfs2_holder ji_gh;
+	struct task_struct *p;
+	int jindex = TRUE;
+	int error = 0;
+
+	if (undo) {
+		jindex = FALSE;
+		goto fail_recoverd;
+	}
+
+	error = gfs2_lookup_simple(sdp->sd_master_dir, "jindex",
+				   &sdp->sd_jindex);
+	if (error) {
+		fs_err(sdp, "can't lookup journal index: %d\n", error);
+		return error;
+	}
+	set_bit(GLF_STICKY, &sdp->sd_jindex->i_gl->gl_flags);
+
+	/* Load in the journal index special file */
+
+	error = gfs2_jindex_hold(sdp, &ji_gh);
+	if (error) {
+		fs_err(sdp, "can't read journal index: %d\n", error);
+		goto fail;
+	}
+
+	error = -EINVAL;
+	if (!gfs2_jindex_size(sdp)) {
+		fs_err(sdp, "no journals!\n");
+		goto fail_jindex;		
+	}
+
+	if (sdp->sd_args.ar_spectator) {
+		sdp->sd_jdesc = gfs2_jdesc_find(sdp, 0);
+		sdp->sd_log_blks_free = sdp->sd_jdesc->jd_blocks;
+	} else {
+		if (sdp->sd_lockstruct.ls_jid >= gfs2_jindex_size(sdp)) {
+			fs_err(sdp, "can't mount journal #%u\n",
+			       sdp->sd_lockstruct.ls_jid);
+			fs_err(sdp, "there are only %u journals (0 - %u)\n",
+			       gfs2_jindex_size(sdp),
+			       gfs2_jindex_size(sdp) - 1);
+			goto fail_jindex;
+		}
+		sdp->sd_jdesc = gfs2_jdesc_find(sdp, sdp->sd_lockstruct.ls_jid);
+
+		error = gfs2_glock_nq_num(sdp,
+					  sdp->sd_lockstruct.ls_jid,
+					  &gfs2_journal_glops,
+					  LM_ST_EXCLUSIVE, LM_FLAG_NOEXP,
+					  &sdp->sd_journal_gh);
+		if (error) {
+			fs_err(sdp, "can't acquire journal glock: %d\n", error);
+			goto fail_jindex;
+		}
+
+		error = gfs2_glock_nq_init(sdp->sd_jdesc->jd_inode->i_gl,
+					   LM_ST_SHARED,
+					   LM_FLAG_NOEXP | GL_EXACT,
+					   &sdp->sd_jinode_gh);
+		if (error) {
+			fs_err(sdp, "can't acquire journal inode glock: %d\n",
+			       error);
+			goto fail_journal_gh;
+		}
+
+		error = gfs2_jdesc_check(sdp->sd_jdesc);
+		if (error) {
+			fs_err(sdp, "my journal (%u) is bad: %d\n",
+			       sdp->sd_jdesc->jd_jid, error);
+			goto fail_jinode_gh;
+		}
+		sdp->sd_log_blks_free = sdp->sd_jdesc->jd_blocks;
+	}
+
+	if (sdp->sd_lockstruct.ls_first) {
+		unsigned int x;
+		for (x = 0; x < sdp->sd_journals; x++) {
+			error = gfs2_recover_journal(gfs2_jdesc_find(sdp, x),
+						     WAIT);
+			if (error) {
+				fs_err(sdp, "error recovering journal %u: %d\n",
+				       x, error);
+				goto fail_jinode_gh;
+			}
+		}
+
+		gfs2_lm_others_may_mount(sdp);
+	} else if (!sdp->sd_args.ar_spectator) {
+		error = gfs2_recover_journal(sdp->sd_jdesc, WAIT);
+		if (error) {
+			fs_err(sdp, "error recovering my journal: %d\n", error);
+			goto fail_jinode_gh;
+		}
+	}
+
+	set_bit(SDF_JOURNAL_CHECKED, &sdp->sd_flags);
+	gfs2_glock_dq_uninit(&ji_gh);
+	jindex = FALSE;
+
+	/* Disown my Journal glock */
+
+	sdp->sd_journal_gh.gh_owner = NULL;
+	sdp->sd_jinode_gh.gh_owner = NULL;
+
+	p = kthread_run(gfs2_recoverd, sdp, "gfs2_recoverd");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start recoverd thread: %d\n", error);
+		goto fail_jinode_gh;
+	}
+	sdp->sd_recoverd_process = p;
+
+	return 0;
+
+ fail_recoverd:
+	kthread_stop(sdp->sd_recoverd_process);
+
+ fail_jinode_gh:
+	if (!sdp->sd_args.ar_spectator)
+		gfs2_glock_dq_uninit(&sdp->sd_jinode_gh);
+
+ fail_journal_gh:
+	if (!sdp->sd_args.ar_spectator)
+		gfs2_glock_dq_uninit(&sdp->sd_journal_gh);
+
+ fail_jindex:
+	gfs2_jindex_free(sdp);
+	if (jindex)
+		gfs2_glock_dq_uninit(&ji_gh);
+
+ fail:
+	gfs2_inode_put(sdp->sd_jindex);
+
+	return error;
+}
+
+static int init_inodes(struct gfs2_sbd *sdp, int undo)
+{
+	struct inode *inode;
+	struct dentry **dentry = &sdp->sd_vfs->s_root;
+	int error = 0;
+
+	if (undo)
+		goto fail_dput;
+
+	/* Read in the master inode number inode */
+	error = gfs2_lookup_simple(sdp->sd_master_dir, "inum",
+				   &sdp->sd_inum_inode);
+	if (error) {
+		fs_err(sdp, "can't read in inum inode: %d\n", error);
+		return error;
+	}
+
+	/* Read in the master statfs inode */
+	error = gfs2_lookup_simple(sdp->sd_master_dir, "statfs",
+				   &sdp->sd_statfs_inode);
+	if (error) {
+		fs_err(sdp, "can't read in statfs inode: %d\n", error);
+		goto fail;
+	}
+
+	/* Read in the resource index inode */
+	error = gfs2_lookup_simple(sdp->sd_master_dir, "rindex",
+				   &sdp->sd_rindex);
+	if (error) {
+		fs_err(sdp, "can't get resource index inode: %d\n", error);
+		goto fail_statfs;
+	}
+	set_bit(GLF_STICKY, &sdp->sd_rindex->i_gl->gl_flags);
+	sdp->sd_rindex_vn = sdp->sd_rindex->i_gl->gl_vn - 1;
+
+	/* Read in the quota inode */
+	error = gfs2_lookup_simple(sdp->sd_master_dir, "quota",
+				   &sdp->sd_quota_inode);
+	if (error) {
+		fs_err(sdp, "can't get quota file inode: %d\n", error);
+		goto fail_rindex;
+	}
+
+	/* Get the root inode */
+	error = gfs2_lookup_simple(sdp->sd_master_dir, "root",
+				   &sdp->sd_root_dir);
+	if (error) {
+		fs_err(sdp, "can't read in root inode: %d\n", error);
+		goto fail_qinode;
+	}
+
+	/* Get the root inode/dentry */
+	inode = gfs2_ip2v(sdp->sd_root_dir);
+	if (!inode) {
+		fs_err(sdp, "can't get root inode\n");
+		error = -ENOMEM;
+		goto fail_rooti;
+	}
+
+	*dentry = d_alloc_root(inode);
+	if (!*dentry) {
+		iput(inode);
+		fs_err(sdp, "can't get root dentry\n");
+		error = -ENOMEM;
+		goto fail_rooti;
+	}
+
+	return 0;
+
+ fail_dput:
+	dput(*dentry);
+	*dentry = NULL;
+
+ fail_rooti:
+	gfs2_inode_put(sdp->sd_root_dir);
+
+ fail_qinode:
+	gfs2_inode_put(sdp->sd_quota_inode);
+
+ fail_rindex:
+	gfs2_clear_rgrpd(sdp);
+	gfs2_inode_put(sdp->sd_rindex);
+
+ fail_statfs:
+	gfs2_inode_put(sdp->sd_statfs_inode);
+
+ fail:
+	gfs2_inode_put(sdp->sd_inum_inode);
+
+	return error;
+}
+
+static int init_per_node(struct gfs2_sbd *sdp, int undo)
+{
+	struct gfs2_inode *pn = NULL;
+	char buf[30];
+	int error = 0;
+
+	if (sdp->sd_args.ar_spectator)
+		return 0;
+
+	if (undo)
+		goto fail_qc_gh;
+
+	error = gfs2_lookup_simple(sdp->sd_master_dir, "per_node", &pn);
+	if (error) {
+		fs_err(sdp, "can't find per_node directory: %d\n", error);
+		return error;
+	}
+
+	sprintf(buf, "inum_range%u", sdp->sd_jdesc->jd_jid);
+	error = gfs2_lookup_simple(pn, buf, &sdp->sd_ir_inode);
+	if (error) {
+		fs_err(sdp, "can't find local \"ir\" file: %d\n", error);
+		goto fail;
+	}
+
+	sprintf(buf, "statfs_change%u", sdp->sd_jdesc->jd_jid);
+	error = gfs2_lookup_simple(pn, buf, &sdp->sd_sc_inode);
+	if (error) {
+		fs_err(sdp, "can't find local \"sc\" file: %d\n", error);
+		goto fail_ir_i;
+	}
+
+	sprintf(buf, "unlinked_tag%u", sdp->sd_jdesc->jd_jid);
+	error = gfs2_lookup_simple(pn, buf, &sdp->sd_ut_inode);
+	if (error) {
+		fs_err(sdp, "can't find local \"ut\" file: %d\n", error);
+		goto fail_sc_i;
+	}
+
+	sprintf(buf, "quota_change%u", sdp->sd_jdesc->jd_jid);
+	error = gfs2_lookup_simple(pn, buf, &sdp->sd_qc_inode);
+	if (error) {
+		fs_err(sdp, "can't find local \"qc\" file: %d\n", error);
+		goto fail_ut_i;
+	}
+
+	gfs2_inode_put(pn);
+	pn = NULL;
+
+	error = gfs2_glock_nq_init(sdp->sd_ir_inode->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_ir_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"ir\" file: %d\n", error);
+		goto fail_qc_i;
+	}
+
+	error = gfs2_glock_nq_init(sdp->sd_sc_inode->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_sc_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"sc\" file: %d\n", error);
+		goto fail_ir_gh;
+	}
+
+	error = gfs2_glock_nq_init(sdp->sd_ut_inode->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_ut_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"ut\" file: %d\n", error);
+		goto fail_sc_gh;
+	}
+
+	error = gfs2_glock_nq_init(sdp->sd_qc_inode->i_gl,
+				   LM_ST_EXCLUSIVE, GL_NEVER_RECURSE,
+				   &sdp->sd_qc_gh);
+	if (error) {
+		fs_err(sdp, "can't lock local \"qc\" file: %d\n", error);
+		goto fail_ut_gh;
+	}
+
+	return 0;
+
+ fail_qc_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_qc_gh);
+
+ fail_ut_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_ut_gh);
+
+ fail_sc_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_sc_gh);
+
+ fail_ir_gh:
+	gfs2_glock_dq_uninit(&sdp->sd_ir_gh);
+
+ fail_qc_i:
+	gfs2_inode_put(sdp->sd_qc_inode);
+
+ fail_ut_i:
+	gfs2_inode_put(sdp->sd_ut_inode);
+
+ fail_sc_i:
+	gfs2_inode_put(sdp->sd_sc_inode);
+
+ fail_ir_i:
+	gfs2_inode_put(sdp->sd_ir_inode);
+
+ fail:
+	if (pn)
+		gfs2_inode_put(pn);
+	return error;
+}
+
+static int init_threads(struct gfs2_sbd *sdp, int undo)
+{
+	struct task_struct *p;
+	int error = 0;
+
+	if (undo)
+		goto fail_inoded;
+
+	sdp->sd_log_flush_time = jiffies;
+	sdp->sd_jindex_refresh_time = jiffies;
+
+	p = kthread_run(gfs2_logd, sdp, "gfs2_logd");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start logd thread: %d\n", error);
+		return error;
+	}
+	sdp->sd_logd_process = p;
+
+	sdp->sd_statfs_sync_time = jiffies;
+	sdp->sd_quota_sync_time = jiffies;
+
+	p = kthread_run(gfs2_quotad, sdp, "gfs2_quotad");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start quotad thread: %d\n", error);
+		goto fail;
+	}
+	sdp->sd_quotad_process = p;
+
+	p = kthread_run(gfs2_inoded, sdp, "gfs2_inoded");
+	error = IS_ERR(p);
+	if (error) {
+		fs_err(sdp, "can't start inoded thread: %d\n", error);
+		goto fail_quotad;
+	}
+	sdp->sd_inoded_process = p;
+
+	return 0;
+
+ fail_inoded:
+	kthread_stop(sdp->sd_inoded_process);
+
+ fail_quotad:
+	kthread_stop(sdp->sd_quotad_process);
+
+ fail:
+	kthread_stop(sdp->sd_logd_process);
+	
+	return error;
+}
+
+/**
+ * fill_super - Read in superblock
+ * @sb: The VFS superblock
+ * @data: Mount options
+ * @silent: Don't complain if it's not a GFS2 filesystem
+ *
+ * Returns: errno
+ */
+
+static int fill_super(struct super_block *sb, void *data, int silent)
+{
+	struct gfs2_sbd *sdp;
+	struct gfs2_holder mount_gh;
+	int error;
+
+	sdp = init_sbd(sb);
+	if (!sdp) {
+		printk("GFS2: can't alloc struct gfs2_sbd\n");
+		return -ENOMEM;
+	}
+
+	error = gfs2_mount_args(sdp, (char *)data, FALSE);
+	if (error) {
+		printk("GFS2: can't parse mount arguments\n");
+		goto fail;
+	}
+
+	init_vfs(sdp);
+
+	/* Mount an inter-node lock module, check for local optimizations */
+	error = gfs2_lm_mount(sdp, silent);
+	if (error)
+		goto fail;
+
+	error = init_locking(sdp, &mount_gh, DO);
+	if (error)
+		goto fail_lm;
+
+	error = init_sb(sdp, silent, DO);
+	if (error)
+		goto fail_locking;
+
+	error = init_journal(sdp, DO);
+	if (error)
+		goto fail_sb;
+
+	error = init_inodes(sdp, DO);
+	if (error)
+		goto fail_journals;
+
+	error = init_per_node(sdp, DO);
+	if (error)
+		goto fail_inodes;
+
+	error = gfs2_statfs_init(sdp);
+	if (error) {
+		fs_err(sdp, "can't initialize statfs subsystem: %d\n", error);
+		goto fail_per_node;
+	}
+
+	error = init_threads(sdp, DO);
+	if (error)
+		goto fail_per_node;
+
+	error = gfs2_sys_fs_add(sdp);
+	if (error)
+		goto fail_threads;
+
+	/* Make the FS read/write */
+	if (!(sb->s_flags & MS_RDONLY)) {
+		error = gfs2_make_fs_rw(sdp);
+		if (error) {
+			fs_err(sdp, "can't make FS RW: %d\n", error);
+			goto fail_sys;
+		}
+	}
+
+	gfs2_glock_dq_uninit(&mount_gh);
+
+	return 0;
+
+ fail_sys:
+	gfs2_sys_fs_del(sdp);
+
+ fail_threads:
+	init_threads(sdp, UNDO);
+
+ fail_per_node:
+	init_per_node(sdp, UNDO);
+
+ fail_inodes:
+	init_inodes(sdp, UNDO);
+
+ fail_journals:
+	init_journal(sdp, UNDO);
+
+ fail_sb:
+	init_sb(sdp, FALSE, UNDO);
+
+ fail_locking:
+	init_locking(sdp, &mount_gh, UNDO);
+
+ fail_lm:
+	gfs2_gl_hash_clear(sdp, WAIT);
+	gfs2_lm_unmount(sdp);
+	while (invalidate_inodes(sb))
+		yield();
+
+ fail:
+	vfree(sdp);
+	set_v2sdp(sb, NULL);
+
+	return error;
+}
+
+struct super_block *gfs2_get_sb(struct file_system_type *fs_type, int flags,
+				const char *dev_name, void *data)
+{
+	return get_sb_bdev(fs_type, flags, dev_name, data, fill_super);
+}
+
+struct file_system_type gfs2_fs_type = {
+	.name = "gfs2",
+	.fs_flags = FS_REQUIRES_DEV,
+	.get_sb = gfs2_get_sb,
+	.kill_sb = kill_block_super,
+	.owner = THIS_MODULE,
+};
+
--- a/fs/gfs2/ops_fstype.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_fstype.h	2005-09-01 17:36:55.418099816 +0800
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_FSTYPE_DOT_H__
+#define __OPS_FSTYPE_DOT_H__
+
+extern struct file_system_type gfs2_fs_type;
+
+#endif /* __OPS_FSTYPE_DOT_H__ */
--- a/fs/gfs2/ops_inode.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_inode.c	2005-09-01 17:36:55.426098600 +0800
@@ -0,0 +1,1270 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/namei.h>
+#include <linux/utsname.h>
+#include <linux/mm.h>
+#include <linux/xattr.h>
+#include <linux/posix_acl.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "acl.h"
+#include "bmap.h"
+#include "dir.h"
+#include "eaops.h"
+#include "eattr.h"
+#include "glock.h"
+#include "inode.h"
+#include "meta_io.h"
+#include "ops_dentry.h"
+#include "ops_inode.h"
+#include "page.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
+#include "unlinked.h"
+
+/**
+ * gfs2_create - Create a file
+ * @dir: The directory in which to create the file
+ * @dentry: The dentry of the new file
+ * @mode: The mode of the new file
+ *
+ * Returns: errno
+ */
+
+static int gfs2_create(struct inode *dir, struct dentry *dentry,
+		       int mode, struct nameidata *nd)
+{
+	struct gfs2_inode *dip = get_v2ip(dir), *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	int new = TRUE;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	for (;;) {
+		error = gfs2_createi(ghs, &dentry->d_name, S_IFREG | mode);
+		if (!error) {
+			ip = get_gl2ip(ghs[1].gh_gl);
+			gfs2_trans_end(sdp);
+			if (dip->i_alloc->al_rgd)
+				gfs2_inplace_release(dip);
+			gfs2_quota_unlock(dip);
+			gfs2_alloc_put(dip);
+			gfs2_glock_dq_uninit_m(2, ghs);
+			break;
+		} else if (error != -EEXIST ||
+			   (nd->intent.open.flags & O_EXCL)) {
+			gfs2_holder_uninit(ghs);
+			return error;
+		}
+
+		error = gfs2_lookupi(dip, &dentry->d_name, FALSE, &ip);
+		if (!error) {
+			new = FALSE;
+			gfs2_holder_uninit(ghs);
+			break;
+		} else if (error != -ENOENT) {
+			gfs2_holder_uninit(ghs);
+			return error;
+		}
+	}
+
+	inode = gfs2_ip2v(ip);
+	gfs2_inode_put(ip);
+
+	if (!inode)
+		return -ENOMEM;
+
+	d_instantiate(dentry, inode);
+	if (new)
+		mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_lookup - Look up a filename in a directory and return its inode
+ * @dir: The directory inode
+ * @dentry: The dentry of the new inode
+ * @nd: passed from Linux VFS, ignored by us
+ *
+ * Called by the VFS layer. Lock dir and call gfs2_lookupi()
+ *
+ * Returns: errno
+ */
+
+static struct dentry *gfs2_lookup(struct inode *dir, struct dentry *dentry,
+				  struct nameidata *nd)
+{
+	struct gfs2_inode *dip = get_v2ip(dir), *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct inode *inode = NULL;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	if (!sdp->sd_args.ar_localcaching)
+		dentry->d_op = &gfs2_dops;
+
+	error = gfs2_lookupi(dip, &dentry->d_name, FALSE, &ip);
+	if (!error) {
+		inode = gfs2_ip2v(ip);
+		gfs2_inode_put(ip);
+		if (!inode)
+			return ERR_PTR(-ENOMEM);
+
+	} else if (error != -ENOENT)
+		return ERR_PTR(error);
+
+	if (inode)
+		return d_splice_alias(inode, dentry);
+	d_add(dentry, inode);
+
+	return NULL;
+}
+
+/**
+ * gfs2_link - Link to a file
+ * @old_dentry: The inode to link
+ * @dir: Add link to this directory
+ * @dentry: The name of the link
+ *
+ * Link the inode in "old_dentry" into the directory "dir" with the
+ * name in "dentry".
+ *
+ * Returns: errno
+ */
+
+static int gfs2_link(struct dentry *old_dentry, struct inode *dir,
+		     struct dentry *dentry)
+{
+	struct gfs2_inode *dip = get_v2ip(dir);
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct inode *inode = old_dentry->d_inode;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_holder ghs[2];
+	int alloc_required;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	if (S_ISDIR(ip->i_di.di_mode))
+		return -EPERM;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+
+	error = gfs2_glock_nq_m(2, ghs);
+	if (error)
+		goto out;
+
+	error = gfs2_repermission(dir, MAY_WRITE | MAY_EXEC, NULL);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_dir_search(dip, &dentry->d_name, NULL, NULL);
+	switch (error) {
+	case -ENOENT:
+		break;
+	case 0:
+		error = -EEXIST;
+	default:
+		goto out_gunlock;
+	}
+
+	error = -EINVAL;
+	if (!dip->i_di.di_nlink)
+		goto out_gunlock;
+	error = -EFBIG;
+	if (dip->i_di.di_entries == (uint32_t)-1)
+		goto out_gunlock;
+	error = -EPERM;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		goto out_gunlock;
+	error = -EINVAL;
+	if (!ip->i_di.di_nlink)
+		goto out_gunlock;
+	error = -EMLINK;
+	if (ip->i_di.di_nlink == (uint32_t)-1)
+		goto out_gunlock;
+
+	error = gfs2_diradd_alloc_required(dip, &dentry->d_name,
+					   &alloc_required);
+	if (error)
+		goto out_gunlock;
+
+	if (alloc_required) {
+		struct gfs2_alloc *al = gfs2_alloc_get(dip);
+
+		error = gfs2_quota_lock(dip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+		if (error)
+			goto out_alloc;
+
+		error = gfs2_quota_check(dip, dip->i_di.di_uid,
+					 dip->i_di.di_gid);
+		if (error)
+			goto out_gunlock_q;
+
+		al->al_requested = sdp->sd_max_dirres;
+
+		error = gfs2_inplace_reserve(dip);
+		if (error)
+			goto out_gunlock_q;
+
+		error = gfs2_trans_begin(sdp,
+					 sdp->sd_max_dirres +
+					 al->al_rgd->rd_ri.ri_length +
+					 2 * RES_DINODE + RES_STATFS +
+					 RES_QUOTA, 0);
+		if (error)
+			goto out_ipres;
+	} else {
+		error = gfs2_trans_begin(sdp, 2 * RES_DINODE + RES_LEAF, 0);
+		if (error)
+			goto out_ipres;
+	}
+
+	error = gfs2_dir_add(dip, &dentry->d_name, &ip->i_num,
+			     IF2DT(ip->i_di.di_mode));
+	if (error)
+		goto out_end_trans;
+
+	error = gfs2_change_nlink(ip, +1);
+
+ out_end_trans:
+	gfs2_trans_end(sdp);
+
+ out_ipres:
+	if (alloc_required)
+		gfs2_inplace_release(dip);
+
+ out_gunlock_q:
+	if (alloc_required)
+		gfs2_quota_unlock(dip);
+
+ out_alloc:
+	if (alloc_required)
+		gfs2_alloc_put(dip);
+
+ out_gunlock:
+	gfs2_glock_dq_m(2, ghs);
+
+ out:
+	gfs2_holder_uninit(ghs);
+	gfs2_holder_uninit(ghs + 1);
+
+	if (!error) {
+		atomic_inc(&inode->i_count);
+		d_instantiate(dentry, inode);
+		mark_inode_dirty(inode);
+	}
+
+	return error;
+}
+
+/**
+ * gfs2_unlink - Unlink a file
+ * @dir: The inode of the directory containing the file to unlink
+ * @dentry: The file itself
+ *
+ * Unlink a file.  Call gfs2_unlinki()
+ *
+ * Returns: errno
+ */
+
+static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct gfs2_inode *dip = get_v2ip(dir);
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_inode *ip = get_v2ip(dentry->d_inode);
+	struct gfs2_unlinked *ul;
+	struct gfs2_holder ghs[2];
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	error = gfs2_unlinked_get(sdp, &ul);
+	if (error)
+		return error;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+
+	error = gfs2_glock_nq_m(2, ghs);
+	if (error)
+		goto out;
+
+	error = gfs2_unlink_ok(dip, &dentry->d_name, ip);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_trans_begin(sdp, 2 * RES_DINODE + RES_LEAF +
+				RES_UNLINKED, 0);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_unlinki(dip, &dentry->d_name, ip,ul);
+
+	gfs2_trans_end(sdp);
+
+ out_gunlock:
+	gfs2_glock_dq_m(2, ghs);
+
+ out:
+	gfs2_holder_uninit(ghs);
+	gfs2_holder_uninit(ghs + 1);
+
+	gfs2_unlinked_put(sdp, ul);
+
+	return error;
+}
+
+/**
+ * gfs2_symlink - Create a symlink
+ * @dir: The directory to create the symlink in
+ * @dentry: The dentry to put the symlink in
+ * @symname: The thing which the link points to
+ *
+ * Returns: errno
+ */
+
+static int gfs2_symlink(struct inode *dir, struct dentry *dentry,
+			const char *symname)
+{
+	struct gfs2_inode *dip = get_v2ip(dir), *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	struct buffer_head *dibh;
+	int size;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	/* Must be stuffed with a null terminator for gfs2_follow_link() */
+	size = strlen(symname);
+	if (size > sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode) - 1)
+		return -ENAMETOOLONG;
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	error = gfs2_createi(ghs, &dentry->d_name, S_IFLNK | S_IRWXUGO);
+	if (error) {
+		gfs2_holder_uninit(ghs);
+		return error;
+	}
+
+	ip = get_gl2ip(ghs[1].gh_gl);
+
+	ip->i_di.di_size = size;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+
+	if (!gfs2_assert_withdraw(sdp, !error)) {
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		memcpy(dibh->b_data + sizeof(struct gfs2_dinode), symname,
+		       size);
+		brelse(dibh);
+	}
+
+	gfs2_trans_end(sdp);
+	if (dip->i_alloc->al_rgd)
+		gfs2_inplace_release(dip);
+	gfs2_quota_unlock(dip);
+	gfs2_alloc_put(dip);
+
+	gfs2_glock_dq_uninit_m(2, ghs);
+
+	inode = gfs2_ip2v(ip);
+	gfs2_inode_put(ip);
+
+	if (!inode)
+		return -ENOMEM;
+
+	d_instantiate(dentry, inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_mkdir - Make a directory
+ * @dir: The parent directory of the new one
+ * @dentry: The dentry of the new directory
+ * @mode: The mode of the new directory
+ *
+ * Returns: errno
+ */
+
+static int gfs2_mkdir(struct inode *dir, struct dentry *dentry, int mode)
+{
+	struct gfs2_inode *dip = get_v2ip(dir), *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	struct buffer_head *dibh;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	error = gfs2_createi(ghs, &dentry->d_name, S_IFDIR | mode);
+	if (error) {
+		gfs2_holder_uninit(ghs);
+		return error;
+	}
+
+	ip = get_gl2ip(ghs[1].gh_gl);
+
+	ip->i_di.di_nlink = 2;
+	ip->i_di.di_size = sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
+	ip->i_di.di_flags |= GFS2_DIF_JDATA;
+	ip->i_di.di_payload_format = GFS2_FORMAT_DE;
+	ip->i_di.di_entries = 2;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+
+	if (!gfs2_assert_withdraw(sdp, !error)) {
+		struct gfs2_dinode *di = (struct gfs2_dinode *)dibh->b_data;
+		struct gfs2_dirent *dent;
+
+		gfs2_dirent_alloc(ip, dibh, 1, &dent);
+
+		dent->de_inum = di->di_num; /* already GFS2 endian */
+		dent->de_hash = gfs2_disk_hash(".", 1);
+		dent->de_hash = cpu_to_gfs2_32(dent->de_hash);
+		dent->de_type = DT_DIR;
+		memcpy((char *) (dent + 1), ".", 1);
+		di->di_entries = cpu_to_gfs2_32(1);
+
+		gfs2_dirent_alloc(ip, dibh, 2, &dent);
+
+		gfs2_inum_out(&dip->i_num, (char *) &dent->de_inum);
+		dent->de_hash = gfs2_disk_hash("..", 2);
+		dent->de_hash = cpu_to_gfs2_32(dent->de_hash);
+		dent->de_type = DT_DIR;
+		memcpy((char *) (dent + 1), "..", 2);
+
+		gfs2_dinode_out(&ip->i_di, (char *)di);
+
+		brelse(dibh);
+	}
+
+	error = gfs2_change_nlink(dip, +1);
+	gfs2_assert_withdraw(sdp, !error); /* dip already pinned */
+
+	gfs2_trans_end(sdp);
+	if (dip->i_alloc->al_rgd)
+		gfs2_inplace_release(dip);
+	gfs2_quota_unlock(dip);
+	gfs2_alloc_put(dip);
+
+	gfs2_glock_dq_uninit_m(2, ghs);
+
+	inode = gfs2_ip2v(ip);
+	gfs2_inode_put(ip);
+
+	if (!inode)
+		return -ENOMEM;
+
+	d_instantiate(dentry, inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_rmdir - Remove a directory
+ * @dir: The parent directory of the directory to be removed
+ * @dentry: The dentry of the directory to remove
+ *
+ * Remove a directory. Call gfs2_rmdiri()
+ *
+ * Returns: errno
+ */
+
+static int gfs2_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	struct gfs2_inode *dip = get_v2ip(dir);
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_inode *ip = get_v2ip(dentry->d_inode);
+	struct gfs2_unlinked *ul;
+	struct gfs2_holder ghs[2];
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	error = gfs2_unlinked_get(sdp, &ul);
+	if (error)
+		return error;
+
+	gfs2_holder_init(dip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+
+	error = gfs2_glock_nq_m(2, ghs);
+	if (error)
+		goto out;
+
+	error = gfs2_unlink_ok(dip, &dentry->d_name, ip);
+	if (error)
+		goto out_gunlock;
+
+	if (ip->i_di.di_entries < 2) {
+		if (gfs2_consist_inode(ip))
+			gfs2_dinode_print(&ip->i_di);
+		error = -EIO;
+		goto out_gunlock;
+	}
+	if (ip->i_di.di_entries > 2) {
+		error = -ENOTEMPTY;
+		goto out_gunlock;
+	}
+
+	error = gfs2_trans_begin(sdp, 2 * RES_DINODE + 3 * RES_LEAF +
+				RES_UNLINKED, 0);
+	if (error)
+		goto out_gunlock;
+
+	error = gfs2_rmdiri(dip, &dentry->d_name, ip, ul);
+
+	gfs2_trans_end(sdp);
+
+ out_gunlock:
+	gfs2_glock_dq_m(2, ghs);
+
+ out:
+	gfs2_holder_uninit(ghs);
+	gfs2_holder_uninit(ghs + 1);
+
+	gfs2_unlinked_put(sdp, ul);
+
+	return error;
+}
+
+/**
+ * gfs2_mknod - Make a special file
+ * @dir: The directory in which the special file will reside
+ * @dentry: The dentry of the special file
+ * @mode: The mode of the special file
+ * @rdev: The device specification of the special file
+ *
+ */
+
+static int gfs2_mknod(struct inode *dir, struct dentry *dentry, int mode,
+		      dev_t dev)
+{
+	struct gfs2_inode *dip = get_v2ip(dir), *ip;
+	struct gfs2_sbd *sdp = dip->i_sbd;
+	struct gfs2_holder ghs[2];
+	struct inode *inode;
+	struct buffer_head *dibh;
+	uint32_t major = 0, minor = 0;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	switch (mode & S_IFMT) {
+	case S_IFBLK:
+	case S_IFCHR:
+		major = MAJOR(dev);
+		minor = MINOR(dev);
+		break;
+	case S_IFIFO:
+	case S_IFSOCK:
+		break;
+	default:
+		return -EOPNOTSUPP;		
+	};
+
+	gfs2_holder_init(dip->i_gl, 0, 0, ghs);
+
+	error = gfs2_createi(ghs, &dentry->d_name, mode);
+	if (error) {
+		gfs2_holder_uninit(ghs);
+		return error;
+	}
+
+	ip = get_gl2ip(ghs[1].gh_gl);
+
+	ip->i_di.di_major = major;
+	ip->i_di.di_minor = minor;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+
+	if (!gfs2_assert_withdraw(sdp, !error)) {
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	gfs2_trans_end(sdp);
+	if (dip->i_alloc->al_rgd)
+		gfs2_inplace_release(dip);
+	gfs2_quota_unlock(dip);
+	gfs2_alloc_put(dip);
+
+	gfs2_glock_dq_uninit_m(2, ghs);
+
+	inode = gfs2_ip2v(ip);
+	gfs2_inode_put(ip);
+
+	if (!inode)
+		return -ENOMEM;
+
+	d_instantiate(dentry, inode);
+	mark_inode_dirty(inode);
+
+	return 0;
+}
+
+/**
+ * gfs2_rename - Rename a file
+ * @odir: Parent directory of old file name
+ * @odentry: The old dentry of the file
+ * @ndir: Parent directory of new file name
+ * @ndentry: The new dentry of the file
+ *
+ * Returns: errno
+ */
+
+static int gfs2_rename(struct inode *odir, struct dentry *odentry,
+		       struct inode *ndir, struct dentry *ndentry)
+{
+	struct gfs2_inode *odip = get_v2ip(odir);
+	struct gfs2_inode *ndip = get_v2ip(ndir);
+	struct gfs2_inode *ip = get_v2ip(odentry->d_inode);
+	struct gfs2_inode *nip = NULL;
+	struct gfs2_sbd *sdp = odip->i_sbd;
+	struct gfs2_unlinked *ul;
+	struct gfs2_holder ghs[4], r_gh;
+	unsigned int num_gh;
+	int dir_rename = FALSE;
+	int alloc_required;
+	unsigned int x;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_inode);
+
+	if (ndentry->d_inode) {
+		nip = get_v2ip(ndentry->d_inode);
+		if (ip == nip)
+			return 0;
+	}
+
+	error = gfs2_unlinked_get(sdp, &ul);
+	if (error)
+		return error;
+
+	/* Make sure we aren't trying to move a dirctory into it's subdir */
+
+	if (S_ISDIR(ip->i_di.di_mode) && odip != ndip) {
+		dir_rename = TRUE;
+
+		error = gfs2_glock_nq_init(sdp->sd_rename_gl,
+					   LM_ST_EXCLUSIVE, 0,
+					   &r_gh);
+		if (error)
+			goto out;
+
+		error = gfs2_ok_to_move(ip, ndip);
+		if (error)
+			goto out_gunlock_r;
+	}
+
+	gfs2_holder_init(odip->i_gl, LM_ST_EXCLUSIVE, 0, ghs);
+	gfs2_holder_init(ndip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 1);
+	gfs2_holder_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + 2);
+	num_gh = 3;
+
+	if (nip)
+		gfs2_holder_init(nip->i_gl, LM_ST_EXCLUSIVE, 0, ghs + num_gh++);
+
+	error = gfs2_glock_nq_m(num_gh, ghs);
+	if (error)
+		goto out_uninit;
+
+	/* Check out the old directory */
+
+	error = gfs2_unlink_ok(odip, &odentry->d_name, ip);
+	if (error)
+		goto out_gunlock;
+
+	/* Check out the new directory */
+
+	if (nip) {
+		error = gfs2_unlink_ok(ndip, &ndentry->d_name, nip);
+		if (error)
+			goto out_gunlock;
+
+		if (S_ISDIR(nip->i_di.di_mode)) {
+			if (nip->i_di.di_entries < 2) {
+				if (gfs2_consist_inode(nip))
+					gfs2_dinode_print(&nip->i_di);
+				error = -EIO;
+				goto out_gunlock;
+			}
+			if (nip->i_di.di_entries > 2) {
+				error = -ENOTEMPTY;
+				goto out_gunlock;
+			}
+		}
+	} else {
+		error = gfs2_repermission(ndir, MAY_WRITE | MAY_EXEC, NULL);
+		if (error)
+			goto out_gunlock;
+
+		error = gfs2_dir_search(ndip, &ndentry->d_name, NULL, NULL);
+		switch (error) {
+		case -ENOENT:
+			error = 0;
+			break;
+		case 0:
+			error = -EEXIST;
+		default:
+			goto out_gunlock;
+		};
+
+		if (odip != ndip) {
+			if (!ndip->i_di.di_nlink) {
+				error = -EINVAL;
+				goto out_gunlock;
+			}
+			if (ndip->i_di.di_entries == (uint32_t)-1) {
+				error = -EFBIG;
+				goto out_gunlock;
+			}
+			if (S_ISDIR(ip->i_di.di_mode) &&
+			    ndip->i_di.di_nlink == (uint32_t)-1) {
+				error = -EMLINK;
+				goto out_gunlock;
+			}
+		}
+	}
+
+	/* Check out the dir to be renamed */
+
+	if (dir_rename) {
+		error = gfs2_repermission(odentry->d_inode, MAY_WRITE, NULL);
+		if (error)
+			goto out_gunlock;
+	}
+
+	error = gfs2_diradd_alloc_required(ndip, &ndentry->d_name,
+					   &alloc_required);
+	if (error)
+		goto out_gunlock;
+
+	if (alloc_required) {
+		struct gfs2_alloc *al = gfs2_alloc_get(ndip);
+
+		error = gfs2_quota_lock(ndip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+		if (error)
+			goto out_alloc;
+
+		error = gfs2_quota_check(ndip, ndip->i_di.di_uid,
+					 ndip->i_di.di_gid);
+		if (error)
+			goto out_gunlock_q;
+
+		al->al_requested = sdp->sd_max_dirres;
+
+		error = gfs2_inplace_reserve(ndip);
+		if (error)
+			goto out_gunlock_q;
+
+		error = gfs2_trans_begin(sdp,
+					 sdp->sd_max_dirres +
+					 al->al_rgd->rd_ri.ri_length +
+					 4 * RES_DINODE + 4 * RES_LEAF +
+					 RES_UNLINKED + RES_STATFS +
+					 RES_QUOTA, 0);
+		if (error)
+			goto out_ipreserv;
+	} else {
+		error = gfs2_trans_begin(sdp, 4 * RES_DINODE +
+					 5 * RES_LEAF +
+					 RES_UNLINKED, 0);
+		if (error)
+			goto out_gunlock;
+	}
+
+	/* Remove the target file, if it exists */
+
+	if (nip) {
+		if (S_ISDIR(nip->i_di.di_mode))
+			error = gfs2_rmdiri(ndip, &ndentry->d_name, nip, ul);
+		else
+			error = gfs2_unlinki(ndip, &ndentry->d_name, nip, ul);
+		if (error)
+			goto out_end_trans;
+	}
+
+	if (dir_rename) {
+		struct qstr name;
+		name.len = 2;
+		name.name = "..";
+
+		error = gfs2_change_nlink(ndip, +1);
+		if (error)
+			goto out_end_trans;
+		error = gfs2_change_nlink(odip, -1);
+		if (error)
+			goto out_end_trans;
+
+		error = gfs2_dir_mvino(ip, &name, &ndip->i_num, DT_DIR);
+		if (error)
+			goto out_end_trans;
+	} else {
+		struct buffer_head *dibh;
+		error = gfs2_meta_inode_buffer(ip, &dibh);
+		if (error)
+			goto out_end_trans;
+		ip->i_di.di_ctime = get_seconds();
+		gfs2_trans_add_bh(ip->i_gl, dibh);
+		gfs2_dinode_out(&ip->i_di, dibh->b_data);
+		brelse(dibh);
+	}
+
+	error = gfs2_dir_del(odip, &odentry->d_name);
+	if (error)
+		goto out_end_trans;
+
+	error = gfs2_dir_add(ndip, &ndentry->d_name, &ip->i_num,
+			     IF2DT(ip->i_di.di_mode));
+	if (error)
+		goto out_end_trans;
+
+ out_end_trans:
+	gfs2_trans_end(sdp);
+
+ out_ipreserv:
+	if (alloc_required)
+		gfs2_inplace_release(ndip);
+
+ out_gunlock_q:
+	if (alloc_required)
+		gfs2_quota_unlock(ndip);
+
+ out_alloc:
+	if (alloc_required)
+		gfs2_alloc_put(ndip);
+
+ out_gunlock:
+	gfs2_glock_dq_m(num_gh, ghs);
+
+ out_uninit:
+	for (x = 0; x < num_gh; x++)
+		gfs2_holder_uninit(ghs + x);
+
+ out_gunlock_r:
+	if (dir_rename)
+		gfs2_glock_dq_uninit(&r_gh);
+
+ out:
+	gfs2_unlinked_put(sdp, ul);
+
+	return error;
+}
+
+/**
+ * gfs2_readlink - Read the value of a symlink
+ * @dentry: the symlink
+ * @buf: the buffer to read the symlink data into
+ * @size: the size of the buffer
+ *
+ * Returns: errno
+ */
+
+static int gfs2_readlink(struct dentry *dentry, char __user *user_buf,
+			 int user_size)
+{
+	struct gfs2_inode *ip = get_v2ip(dentry->d_inode);
+	char array[GFS2_FAST_NAME_SIZE], *buf = array;
+	unsigned int len = GFS2_FAST_NAME_SIZE;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_inode);
+
+	error = gfs2_readlinki(ip, &buf, &len);
+	if (error)
+		return error;
+
+	if (user_size > len - 1)
+		user_size = len - 1;
+
+	if (copy_to_user(user_buf, buf, user_size))
+		error = -EFAULT;
+	else
+		error = user_size;
+
+	if (buf != array)
+		kfree(buf);
+
+	return error;
+}
+
+/**
+ * gfs2_follow_link - Follow a symbolic link
+ * @dentry: The dentry of the link
+ * @nd: Data that we pass to vfs_follow_link()
+ *
+ * This can handle symlinks of any size. It is optimised for symlinks
+ * under GFS2_FAST_NAME_SIZE.
+ *
+ * Returns: 0 on success or error code
+ */
+
+static void *gfs2_follow_link(struct dentry *dentry, struct nameidata *nd)
+{
+	struct gfs2_inode *ip = get_v2ip(dentry->d_inode);
+	char array[GFS2_FAST_NAME_SIZE], *buf = array;
+	unsigned int len = GFS2_FAST_NAME_SIZE;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_inode);
+
+	error = gfs2_readlinki(ip, &buf, &len);
+	if (!error) {
+		error = vfs_follow_link(nd, buf);
+		if (buf != array)
+			kfree(buf);
+	}
+
+	return ERR_PTR(error);
+}
+
+/**
+ * gfs2_permission -
+ * @inode:
+ * @mask:
+ * @nd: passed from Linux VFS, ignored by us
+ *
+ * Returns: errno
+ */
+
+static int gfs2_permission(struct inode *inode, int mask, struct nameidata *nd)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_holder i_gh;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_inode);
+
+	if (ip->i_vn == ip->i_gl->gl_vn)
+		return generic_permission(inode, mask, gfs2_check_acl);
+
+	error = gfs2_glock_nq_init(ip->i_gl,
+				   LM_ST_SHARED, LM_FLAG_ANY,
+				   &i_gh);
+	if (!error) {
+		error = generic_permission(inode, mask, gfs2_check_acl_locked);
+		gfs2_glock_dq_uninit(&i_gh);
+	}
+
+	return error;
+}
+
+static int setattr_size(struct inode *inode, struct iattr *attr)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	int error;
+
+	error = gfs2_repermission(inode, MAY_WRITE, NULL);
+	if (error)
+		return error;
+
+	if (attr->ia_size != ip->i_di.di_size) {
+		error = vmtruncate(inode, attr->ia_size);
+		if (error)
+			return error;
+	}
+
+	error = gfs2_truncatei(ip, attr->ia_size, gfs2_truncator_page);
+	if (error)
+		return error;
+
+	return error;
+}
+
+static int setattr_chown(struct inode *inode, struct iattr *attr)
+{
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct buffer_head *dibh;
+	uint32_t ouid, ogid, nuid, ngid;
+	int error;
+
+	ouid = ip->i_di.di_uid;
+	ogid = ip->i_di.di_gid;
+	nuid = attr->ia_uid;
+	ngid = attr->ia_gid;
+
+	if (!(attr->ia_valid & ATTR_UID) || ouid == nuid)
+		ouid = nuid = NO_QUOTA_CHANGE;
+	if (!(attr->ia_valid & ATTR_GID) || ogid == ngid)
+		ogid = ngid = NO_QUOTA_CHANGE;
+
+	gfs2_alloc_get(ip);
+
+	error = gfs2_quota_lock(ip, nuid, ngid);
+	if (error)
+		goto out_alloc;
+
+	if (ouid != NO_QUOTA_CHANGE || ogid != NO_QUOTA_CHANGE) {
+		error = gfs2_quota_check(ip, nuid, ngid);
+		if (error)
+			goto out_gunlock_q;
+	}
+
+	error = gfs2_trans_begin(sdp, RES_DINODE + 2 * RES_QUOTA, 0);
+	if (error)
+		goto out_gunlock_q;
+
+	error = gfs2_meta_inode_buffer(ip, &dibh);
+	if (error)
+		goto out_end_trans;
+
+	error = inode_setattr(inode, attr);
+	gfs2_assert_warn(sdp, !error);
+	gfs2_inode_attr_out(ip);
+
+	gfs2_trans_add_bh(ip->i_gl, dibh);
+	gfs2_dinode_out(&ip->i_di, dibh->b_data);
+	brelse(dibh);
+
+	if (ouid != NO_QUOTA_CHANGE || ogid != NO_QUOTA_CHANGE) {
+		gfs2_quota_change(ip, -ip->i_di.di_blocks,
+				 ouid, ogid);
+		gfs2_quota_change(ip, ip->i_di.di_blocks,
+				 nuid, ngid);
+	}
+
+ out_end_trans:
+	gfs2_trans_end(sdp);
+
+ out_gunlock_q:
+	gfs2_quota_unlock(ip);
+
+ out_alloc:
+	gfs2_alloc_put(ip);
+
+	return error;
+}
+
+/**
+ * gfs2_setattr - Change attributes on an inode
+ * @dentry: The dentry which is changing
+ * @attr: The structure describing the change
+ *
+ * The VFS layer wants to change one or more of an inodes attributes.  Write
+ * that change out to disk.
+ *
+ * Returns: errno
+ */
+
+static int gfs2_setattr(struct dentry *dentry, struct iattr *attr)
+{
+	struct inode *inode = dentry->d_inode;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_holder i_gh;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_inode);
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	if (error)
+		return error;
+
+	error = -EPERM;
+	if (IS_IMMUTABLE(inode) || IS_APPEND(inode))
+		goto out;
+
+	error = inode_change_ok(inode, attr);
+	if (error)
+		goto out;
+
+	if (attr->ia_valid & ATTR_SIZE)
+		error = setattr_size(inode, attr);
+	else if (attr->ia_valid & (ATTR_UID | ATTR_GID))
+		error = setattr_chown(inode, attr);
+	else if ((attr->ia_valid & ATTR_MODE) && IS_POSIXACL(inode))
+		error = gfs2_acl_chmod(ip, attr);
+	else
+		error = gfs2_setattr_simple(ip, attr);
+
+ out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	if (!error)
+		mark_inode_dirty(inode);
+
+	return error;
+}
+
+/**
+ * gfs2_getattr - Read out an inode's attributes
+ * @mnt: ?
+ * @dentry: The dentry to stat
+ * @stat: The inode's stats
+ *
+ * Returns: errno
+ */
+
+static int gfs2_getattr(struct vfsmount *mnt, struct dentry *dentry,
+			struct kstat *stat)
+{
+	struct inode *inode = dentry->d_inode;
+	struct gfs2_inode *ip = get_v2ip(inode);
+	struct gfs2_holder gh;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_inode);
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, LM_FLAG_ANY, &gh);
+	if (!error) {
+		generic_fillattr(inode, stat);
+		gfs2_glock_dq_uninit(&gh);
+	}
+
+	return error;
+}
+
+static int gfs2_setxattr(struct dentry *dentry, const char *name,
+			 const void *data, size_t size, int flags)
+{
+	struct gfs2_inode *ip = get_v2ip(dentry->d_inode);
+	struct gfs2_ea_request er;
+
+	atomic_inc(&ip->i_sbd->sd_ops_inode);
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_type = gfs2_ea_name2type(name, &er.er_name);
+	if (er.er_type == GFS2_EATYPE_UNUSED)
+		return -EOPNOTSUPP;
+	er.er_data = (char *)data;
+	er.er_name_len = strlen(er.er_name);
+	er.er_data_len = size;
+	er.er_flags = flags;
+
+	gfs2_assert_warn(ip->i_sbd, !(er.er_flags & GFS2_ERF_MODE));
+
+	return gfs2_ea_set(ip, &er);
+}
+
+static ssize_t gfs2_getxattr(struct dentry *dentry, const char *name,
+			     void *data, size_t size)
+{
+	struct gfs2_ea_request er;
+
+	atomic_inc(&get_v2sdp(dentry->d_inode->i_sb)->sd_ops_inode);
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_type = gfs2_ea_name2type(name, &er.er_name);
+	if (er.er_type == GFS2_EATYPE_UNUSED)
+		return -EOPNOTSUPP;
+	er.er_data = data;
+	er.er_name_len = strlen(er.er_name);
+	er.er_data_len = size;
+
+	return gfs2_ea_get(get_v2ip(dentry->d_inode), &er);
+}
+
+static ssize_t gfs2_listxattr(struct dentry *dentry, char *buffer, size_t size)
+{
+	struct gfs2_ea_request er;
+
+	atomic_inc(&get_v2sdp(dentry->d_inode->i_sb)->sd_ops_inode);
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_data = (size) ? buffer : NULL;
+	er.er_data_len = size;
+
+	return gfs2_ea_list(get_v2ip(dentry->d_inode), &er);
+}
+
+static int gfs2_removexattr(struct dentry *dentry, const char *name)
+{
+	struct gfs2_ea_request er;
+
+	atomic_inc(&get_v2sdp(dentry->d_inode->i_sb)->sd_ops_inode);
+
+	memset(&er, 0, sizeof(struct gfs2_ea_request));
+	er.er_type = gfs2_ea_name2type(name, &er.er_name);
+	if (er.er_type == GFS2_EATYPE_UNUSED)
+		return -EOPNOTSUPP;
+	er.er_name_len = strlen(er.er_name);
+
+	return gfs2_ea_remove(get_v2ip(dentry->d_inode), &er);
+}
+
+struct inode_operations gfs2_file_iops = {
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
+struct inode_operations gfs2_dev_iops = {
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
+struct inode_operations gfs2_dir_iops = {
+	.create = gfs2_create,
+	.lookup = gfs2_lookup,
+	.link = gfs2_link,
+	.unlink = gfs2_unlink,
+	.symlink = gfs2_symlink,
+	.mkdir = gfs2_mkdir,
+	.rmdir = gfs2_rmdir,
+	.mknod = gfs2_mknod,
+	.rename = gfs2_rename,
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
+struct inode_operations gfs2_symlink_iops = {
+	.readlink = gfs2_readlink,
+	.follow_link = gfs2_follow_link,
+	.permission = gfs2_permission,
+	.setattr = gfs2_setattr,
+	.getattr = gfs2_getattr,
+	.setxattr = gfs2_setxattr,
+	.getxattr = gfs2_getxattr,
+	.listxattr = gfs2_listxattr,
+	.removexattr = gfs2_removexattr,
+};
+
--- a/fs/gfs2/ops_inode.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_inode.h	2005-09-01 17:36:55.427098448 +0800
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_INODE_DOT_H__
+#define __OPS_INODE_DOT_H__
+
+extern struct inode_operations gfs2_file_iops;
+extern struct inode_operations gfs2_dir_iops;
+extern struct inode_operations gfs2_symlink_iops;
+extern struct inode_operations gfs2_dev_iops;
+
+#endif /* __OPS_INODE_DOT_H__ */
