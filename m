Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWHaNab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWHaNab (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 09:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932274AbWHaNab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 09:30:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40326 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932251AbWHaNaU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 09:30:20 -0400
Subject: [PATCH 06/16] GFS2: dentry, export, super and vm operations
From: Steven Whitehouse <swhiteho@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 31 Aug 2006 14:34:05 +0100
Message-Id: <1157031245.3384.795.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 06/16] GFS2: dentry, export, super and vm operations

The GFS2 dentry interface, NFS operations, superblock operations, VM operaions,
transaction code, unlinked inode code and GFS2 utility routines.


Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 fs/gfs2/ops_dentry.c |  123 ++++++
 fs/gfs2/ops_dentry.h |   15 
 fs/gfs2/ops_export.c |  293 +++++++++++++++
 fs/gfs2/ops_export.h |   19 
 fs/gfs2/ops_super.c  |  472 ++++++++++++++++++++++++
 fs/gfs2/ops_super.h  |   15 
 fs/gfs2/ops_vm.c     |  188 +++++++++
 fs/gfs2/ops_vm.h     |   16 
 fs/gfs2/super.c      |  979 +++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/super.h      |   52 ++
 fs/gfs2/trans.c      |  184 +++++++++
 fs/gfs2/trans.h      |   34 +
 fs/gfs2/util.c       |  245 ++++++++++++
 fs/gfs2/util.h       |  169 ++++++++
 14 files changed, 2804 insertions(+)

--- /dev/null
+++ b/fs/gfs2/ops_dentry.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/smp_lock.h>
+#include <linux/gfs2_ondisk.h>
+#include <linux/crc32.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "dir.h"
+#include "glock.h"
+#include "ops_dentry.h"
+#include "util.h"
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
+	struct gfs2_sbd *sdp = GFS2_SB(parent->d_inode);
+	struct gfs2_inode *dip = GFS2_I(parent->d_inode);
+	struct inode *inode = dentry->d_inode;
+	struct gfs2_holder d_gh;
+	struct gfs2_inode *ip;
+	struct gfs2_inum inum;
+	unsigned int type;
+	int error;
+
+	if (inode && is_bad_inode(inode))
+		goto invalid;
+
+	if (sdp->sd_args.ar_localcaching)
+		goto valid;
+
+	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &d_gh);
+	if (error)
+		goto fail;
+
+	error = gfs2_dir_search(parent->d_inode, &dentry->d_name, &inum, &type);
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
+	ip = GFS2_I(inode);
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
+	dput(parent);
+	return 0;
+
+ fail_gunlock:
+	gfs2_glock_dq_uninit(&d_gh);
+
+ fail:
+	dput(parent);
+	return 0;
+}
+
+static int gfs2_dhash(struct dentry *dentry, struct qstr *str)
+{
+	str->hash = gfs2_disk_hash(str->name, str->len);
+	return 0;
+}
+
+struct dentry_operations gfs2_dops = {
+	.d_revalidate = gfs2_drevalidate,
+	.d_hash = gfs2_dhash,
+};
+
--- /dev/null
+++ b/fs/gfs2/ops_dentry.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
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
--- /dev/null
+++ b/fs/gfs2/ops_export.c
@@ -0,0 +1,293 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/gfs2_ondisk.h>
+#include <linux/crc32.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "dir.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "ops_export.h"
+#include "rgrp.h"
+#include "util.h"
+
+static struct dentry *gfs2_decode_fh(struct super_block *sb,
+				     __u32 *fh,
+				     int fh_len,
+				     int fh_type,
+				     int (*acceptable)(void *context,
+						       struct dentry *dentry),
+				     void *context)
+{
+	struct gfs2_fh_obj fh_obj;
+	struct gfs2_inum *this, parent;
+
+	if (fh_type != fh_len)
+		return NULL;
+
+	this 		= &fh_obj.this;
+	fh_obj.imode 	= DT_UNKNOWN;
+	memset(&parent, 0, sizeof(struct gfs2_inum));
+
+	switch (fh_type) {
+	case 10:
+		parent.no_formal_ino = ((uint64_t)be32_to_cpu(fh[4])) << 32;
+		parent.no_formal_ino |= be32_to_cpu(fh[5]);
+		parent.no_addr = ((uint64_t)be32_to_cpu(fh[6])) << 32;
+		parent.no_addr |= be32_to_cpu(fh[7]);
+		fh_obj.imode = be32_to_cpu(fh[8]);
+	case 4:
+		this->no_formal_ino = ((uint64_t)be32_to_cpu(fh[0])) << 32;
+		this->no_formal_ino |= be32_to_cpu(fh[1]);
+		this->no_addr = ((uint64_t)be32_to_cpu(fh[2])) << 32;
+		this->no_addr |= be32_to_cpu(fh[3]);
+		break;
+	default:
+		return NULL;
+	}
+
+	return gfs2_export_ops.find_exported_dentry(sb, &fh_obj, &parent,
+						    acceptable, context);
+}
+
+static int gfs2_encode_fh(struct dentry *dentry, __u32 *fh, int *len,
+			  int connectable)
+{
+	struct inode *inode = dentry->d_inode;
+	struct super_block *sb = inode->i_sb;
+	struct gfs2_inode *ip = GFS2_I(inode);
+
+	if (*len < 4 || (connectable && *len < 10))
+		return 255;
+
+	fh[0] = ip->i_num.no_formal_ino >> 32;
+	fh[0] = cpu_to_be32(fh[0]);
+	fh[1] = ip->i_num.no_formal_ino & 0xFFFFFFFF;
+	fh[1] = cpu_to_be32(fh[1]);
+	fh[2] = ip->i_num.no_addr >> 32;
+	fh[2] = cpu_to_be32(fh[2]);
+	fh[3] = ip->i_num.no_addr & 0xFFFFFFFF;
+	fh[3] = cpu_to_be32(fh[3]);
+	*len = 4;
+
+	if (!connectable || inode == sb->s_root->d_inode)
+		return *len;
+
+	spin_lock(&dentry->d_lock);
+	inode = dentry->d_parent->d_inode;
+	ip = GFS2_I(inode);
+	igrab(inode);
+	spin_unlock(&dentry->d_lock);
+
+	fh[4] = ip->i_num.no_formal_ino >> 32;
+	fh[4] = cpu_to_be32(fh[4]);
+	fh[5] = ip->i_num.no_formal_ino & 0xFFFFFFFF;
+	fh[5] = cpu_to_be32(fh[5]);
+	fh[6] = ip->i_num.no_addr >> 32;
+	fh[6] = cpu_to_be32(fh[6]);
+	fh[7] = ip->i_num.no_addr & 0xFFFFFFFF;
+	fh[7] = cpu_to_be32(fh[7]);
+
+	fh[8]  = cpu_to_be32(inode->i_mode);
+	fh[9]  = 0;	/* pad to double word */
+	*len = 10;
+
+	iput(inode);
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
+	if (!S_ISDIR(dir->i_mode) || !inode)
+		return -EINVAL;
+
+	dip = GFS2_I(dir);
+	ip = GFS2_I(inode);
+
+	*name = 0;
+	gnfd.inum = ip->i_num;
+	gnfd.name = name;
+
+	error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED, 0, &gh);
+	if (error)
+		return error;
+
+	error = gfs2_dir_read(dir, &offset, &gnfd, get_name_filldir);
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
+	struct qstr dotdot;
+	struct inode *inode;
+	struct dentry *dentry;
+
+	gfs2_str2qstr(&dotdot, "..");
+	inode = gfs2_lookupi(child->d_inode, &dotdot, 1, NULL);
+
+	if (!inode)
+		return ERR_PTR(-ENOENT);
+	if (IS_ERR(inode))
+		return ERR_PTR(PTR_ERR(inode));
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
+static struct dentry *gfs2_get_dentry(struct super_block *sb, void *inum_obj)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	struct gfs2_fh_obj *fh_obj = (struct gfs2_fh_obj *)inum_obj;
+	struct gfs2_inum *inum = &fh_obj->this;
+	struct gfs2_holder i_gh, ri_gh, rgd_gh;
+	struct gfs2_rgrpd *rgd;
+	struct inode *inode;
+	struct dentry *dentry;
+	int error;
+
+	/* System files? */
+
+	inode = gfs2_ilookup(sb, inum);
+	if (inode) {
+		if (GFS2_I(inode)->i_num.no_formal_ino != inum->no_formal_ino) {
+			iput(inode);
+			return ERR_PTR(-ESTALE);
+		}
+		goto out_inode;
+	}
+
+	error = gfs2_glock_nq_num(sdp, inum->no_addr, &gfs2_inode_glops,
+				  LM_ST_SHARED, LM_FLAG_ANY | GL_LOCAL_EXCL,
+				  &i_gh);
+	if (error)
+		return ERR_PTR(error);
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
+	inode = gfs2_inode_lookup(sb, inum, fh_obj->imode);
+	if (!inode)
+		goto fail;
+	if (IS_ERR(inode)) {
+		error = PTR_ERR(inode);
+		goto fail;
+	}
+
+	error = gfs2_inode_refresh(GFS2_I(inode));
+	if (error) {
+		iput(inode);
+		goto fail;
+	}
+
+	error = -EIO;
+	if (GFS2_I(inode)->i_di.di_flags & GFS2_DIF_SYSTEM) {
+		iput(inode);
+		goto fail;
+	}
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+out_inode:
+	dentry = d_alloc_anon(inode);
+	if (!dentry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return dentry;
+
+fail_rgd:
+	gfs2_glock_dq_uninit(&rgd_gh);
+
+fail_rindex:
+	gfs2_glock_dq_uninit(&ri_gh);
+
+fail:
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
--- /dev/null
+++ b/fs/gfs2/ops_export.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
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
+struct gfs2_fh_obj {
+	struct gfs2_inum this;
+	__u32            imode;
+};
+
+#endif /* __OPS_EXPORT_DOT_H__ */
--- /dev/null
+++ b/fs/gfs2/ops_super.c
@@ -0,0 +1,472 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/statfs.h>
+#include <linux/vmalloc.h>
+#include <linux/seq_file.h>
+#include <linux/mount.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <linux/gfs2_ondisk.h>
+#include <linux/crc32.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "glock.h"
+#include "inode.h"
+#include "lm.h"
+#include "log.h"
+#include "mount.h"
+#include "ops_super.h"
+#include "quota.h"
+#include "recovery.h"
+#include "rgrp.h"
+#include "super.h"
+#include "sys.h"
+#include "util.h"
+#include "trans.h"
+#include "dir.h"
+#include "eattr.h"
+#include "bmap.h"
+
+/**
+ * gfs2_write_inode - Make sure the inode is stable on the disk
+ * @inode: The inode
+ * @sync: synchronous write flag
+ *
+ * Returns: errno
+ */
+
+static int gfs2_write_inode(struct inode *inode, int sync)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+
+	/* Check this is a "normal" inode */
+	if (inode->u.generic_ip) {
+		if (current->flags & PF_MEMALLOC)
+			return 0;
+		if (sync)
+			gfs2_log_flush(GFS2_SB(inode), ip->i_gl);
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_put_super - Unmount the filesystem
+ * @sb: The VFS superblock
+ *
+ */
+
+static void gfs2_put_super(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	int error;
+
+	if (!sdp)
+		return;
+
+	if (!strncmp(sb->s_type->name, "gfs2meta", 8))
+		return; /* meta fs. don't do nothin' */
+
+	/*  Unfreeze the filesystem, if we need to  */
+
+	mutex_lock(&sdp->sd_freeze_lock);
+	if (sdp->sd_freeze_count)
+		gfs2_glock_dq_uninit(&sdp->sd_freeze_gh);
+	mutex_unlock(&sdp->sd_freeze_lock);
+
+	kthread_stop(sdp->sd_quotad_process);
+	kthread_stop(sdp->sd_logd_process);
+	kthread_stop(sdp->sd_recoverd_process);
+	while (sdp->sd_glockd_num--)
+		kthread_stop(sdp->sd_glockd_process[sdp->sd_glockd_num]);
+	kthread_stop(sdp->sd_scand_process);
+
+	if (!(sb->s_flags & MS_RDONLY)) {
+		error = gfs2_make_fs_ro(sdp);
+		if (error)
+			gfs2_io_error(sdp);
+	}
+	/*  At this point, we're through modifying the disk  */
+
+	/*  Release stuff  */
+
+	iput(sdp->sd_master_dir);
+	iput(sdp->sd_jindex);
+	iput(sdp->sd_inum_inode);
+	iput(sdp->sd_statfs_inode);
+	iput(sdp->sd_rindex);
+	iput(sdp->sd_quota_inode);
+
+	gfs2_glock_put(sdp->sd_rename_gl);
+	gfs2_glock_put(sdp->sd_trans_gl);
+
+	if (!sdp->sd_args.ar_spectator) {
+		gfs2_glock_dq_uninit(&sdp->sd_journal_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_jinode_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_ir_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_sc_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_qc_gh);
+		iput(sdp->sd_ir_inode);
+		iput(sdp->sd_sc_inode);
+		iput(sdp->sd_qc_inode);
+	}
+
+	gfs2_glock_dq_uninit(&sdp->sd_live_gh);
+	gfs2_clear_rgrpd(sdp);
+	gfs2_jindex_free(sdp);
+	/*  Take apart glock structures and buffer lists  */
+	gfs2_gl_hash_clear(sdp, WAIT);
+	/*  Unmount the locking protocol  */
+	gfs2_lm_unmount(sdp);
+
+	/*  At this point, we're through participating in the lockspace  */
+	gfs2_sys_fs_del(sdp);
+	vfree(sdp);
+	sb->s_fs_info = NULL;
+}
+
+/**
+ * gfs2_write_super - disk commit all incore transactions
+ * @sb: the filesystem
+ *
+ * This function is called every time sync(2) is called.
+ * After this exits, all dirty buffers are synced.
+ */
+
+static void gfs2_write_super(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	gfs2_log_flush(sdp, NULL);
+}
+
+/**
+ * gfs2_write_super_lockfs - prevent further writes to the filesystem
+ * @sb: the VFS structure for the filesystem
+ *
+ */
+
+static void gfs2_write_super_lockfs(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	int error;
+
+	for (;;) {
+		error = gfs2_freeze_fs(sdp);
+		if (!error)
+			break;
+
+		switch (error) {
+		case -EBUSY:
+			fs_err(sdp, "waiting for recovery before freeze\n");
+			break;
+
+		default:
+			fs_err(sdp, "error freezing FS: %d\n", error);
+			break;
+		}
+
+		fs_err(sdp, "retrying...\n");
+		msleep(1000);
+	}
+}
+
+/**
+ * gfs2_unlockfs - reallow writes to the filesystem
+ * @sb: the VFS structure for the filesystem
+ *
+ */
+
+static void gfs2_unlockfs(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	gfs2_unfreeze_fs(sdp);
+}
+
+/**
+ * gfs2_statfs - Gather and return stats about the filesystem
+ * @sb: The superblock
+ * @statfsbuf: The buffer
+ *
+ * Returns: 0 on success or error code
+ */
+
+static int gfs2_statfs(struct dentry *dentry, struct kstatfs *buf)
+{
+	struct super_block *sb = dentry->d_inode->i_sb;
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	struct gfs2_statfs_change sc;
+	int error;
+
+	if (gfs2_tune_get(sdp, gt_statfs_slow))
+		error = gfs2_statfs_slow(sdp, &sc);
+	else
+		error = gfs2_statfs_i(sdp, &sc);
+
+	if (error)
+		return error;
+
+	buf->f_type = GFS2_MAGIC;
+	buf->f_bsize = sdp->sd_sb.sb_bsize;
+	buf->f_blocks = sc.sc_total;
+	buf->f_bfree = sc.sc_free;
+	buf->f_bavail = sc.sc_free;
+	buf->f_files = sc.sc_dinodes + sc.sc_free;
+	buf->f_ffree = sc.sc_free;
+	buf->f_namelen = GFS2_FNAMESIZE;
+
+	return 0;
+}
+
+/**
+ * gfs2_remount_fs - called when the FS is remounted
+ * @sb:  the filesystem
+ * @flags:  the remount flags
+ * @data:  extra data passed in (not used right now)
+ *
+ * Returns: errno
+ */
+
+static int gfs2_remount_fs(struct super_block *sb, int *flags, char *data)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	int error;
+
+	error = gfs2_mount_args(sdp, data, 1);
+	if (error)
+		return error;
+
+	if (sdp->sd_args.ar_spectator)
+		*flags |= MS_RDONLY;
+	else {
+		if (*flags & MS_RDONLY) {
+			if (!(sb->s_flags & MS_RDONLY))
+				error = gfs2_make_fs_ro(sdp);
+		} else if (!(*flags & MS_RDONLY) &&
+			   (sb->s_flags & MS_RDONLY)) {
+			error = gfs2_make_fs_rw(sdp);
+		}
+	}
+
+	if (*flags & (MS_NOATIME | MS_NODIRATIME))
+		set_bit(SDF_NOATIME, &sdp->sd_flags);
+	else
+		clear_bit(SDF_NOATIME, &sdp->sd_flags);
+
+	/* Don't let the VFS update atimes.  GFS2 handles this itself. */
+	*flags |= MS_NOATIME | MS_NODIRATIME;
+
+	return error;
+}
+
+/**
+ * gfs2_clear_inode - Deallocate an inode when VFS is done with it
+ * @inode: The VFS inode
+ *
+ */
+
+static void gfs2_clear_inode(struct inode *inode)
+{
+	/* This tells us its a "real" inode and not one which only
+	 * serves to contain an address space (see rgrp.c, meta_io.c)
+	 * which therefore doesn't have its own glocks.
+	 */
+	if (inode->u.generic_ip) {
+		struct gfs2_inode *ip = GFS2_I(inode);
+		gfs2_glock_inode_squish(inode);
+		gfs2_assert(inode->i_sb->s_fs_info, ip->i_gl->gl_state == LM_ST_UNLOCKED);
+		ip->i_gl->gl_object = NULL;
+		gfs2_glock_schedule_for_reclaim(ip->i_gl);
+		gfs2_glock_put(ip->i_gl);
+		ip->i_gl = NULL;
+		if (ip->i_iopen_gh.gh_gl)
+			gfs2_glock_dq_uninit(&ip->i_iopen_gh);
+	}
+}
+
+/**
+ * gfs2_show_options - Show mount options for /proc/mounts
+ * @s: seq_file structure
+ * @mnt: vfsmount
+ *
+ * Returns: 0 on success or error code
+ */
+
+static int gfs2_show_options(struct seq_file *s, struct vfsmount *mnt)
+{
+	struct gfs2_sbd *sdp = mnt->mnt_sb->s_fs_info;
+	struct gfs2_args *args = &sdp->sd_args;
+
+	if (args->ar_lockproto[0])
+		seq_printf(s, ",lockproto=%s", args->ar_lockproto);
+	if (args->ar_locktable[0])
+		seq_printf(s, ",locktable=%s", args->ar_locktable);
+	if (args->ar_hostdata[0])
+		seq_printf(s, ",hostdata=%s", args->ar_hostdata);
+	if (args->ar_spectator)
+		seq_printf(s, ",spectator");
+	if (args->ar_ignore_local_fs)
+		seq_printf(s, ",ignore_local_fs");
+	if (args->ar_localflocks)
+		seq_printf(s, ",localflocks");
+	if (args->ar_localcaching)
+		seq_printf(s, ",localcaching");
+	if (args->ar_debug)
+		seq_printf(s, ",debug");
+	if (args->ar_upgrade)
+		seq_printf(s, ",upgrade");
+	if (args->ar_num_glockd != GFS2_GLOCKD_DEFAULT)
+		seq_printf(s, ",num_glockd=%u", args->ar_num_glockd);
+	if (args->ar_posix_acl)
+		seq_printf(s, ",acl");
+	if (args->ar_quota != GFS2_QUOTA_DEFAULT) {
+		char *state;
+		switch (args->ar_quota) {
+		case GFS2_QUOTA_OFF:
+			state = "off";
+			break;
+		case GFS2_QUOTA_ACCOUNT:
+			state = "account";
+			break;
+		case GFS2_QUOTA_ON:
+			state = "on";
+			break;
+		default:
+			state = "unknown";
+			break;
+		}
+		seq_printf(s, ",quota=%s", state);
+	}
+	if (args->ar_suiddir)
+		seq_printf(s, ",suiddir");
+	if (args->ar_data != GFS2_DATA_DEFAULT) {
+		char *state;
+		switch (args->ar_data) {
+		case GFS2_DATA_WRITEBACK:
+			state = "writeback";
+			break;
+		case GFS2_DATA_ORDERED:
+			state = "ordered";
+			break;
+		default:
+			state = "unknown";
+			break;
+		}
+		seq_printf(s, ",data=%s", state);
+	}
+
+	return 0;
+}
+
+/* 
+ * We have to (at the moment) hold the inodes main lock to cover
+ * the gap between unlocking the shared lock on the iopen lock and
+ * taking the exclusive lock. I'd rather do a shared -> exclusive
+ * conversion on the iopen lock, but we can change that later. This
+ * is safe, just less efficient.
+ */
+static void gfs2_delete_inode(struct inode *inode)
+{
+	struct gfs2_sbd *sdp = inode->i_sb->s_fs_info;
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_holder gh;
+	int error;
+
+	if (!inode->u.generic_ip)
+		goto out;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB | GL_NOCACHE, &gh);
+	if (unlikely(error)) {
+		gfs2_glock_dq_uninit(&ip->i_iopen_gh);
+		goto out;
+	}
+
+	gfs2_glock_dq(&ip->i_iopen_gh);
+	gfs2_holder_reinit(LM_ST_EXCLUSIVE, LM_FLAG_TRY_1CB | GL_NOCACHE, &ip->i_iopen_gh);
+	error = gfs2_glock_nq(&ip->i_iopen_gh);
+	if (error)
+		goto out_uninit;
+
+	if (S_ISDIR(ip->i_di.di_mode) &&
+	    (ip->i_di.di_flags & GFS2_DIF_EXHASH)) {
+		error = gfs2_dir_exhash_dealloc(ip);
+		if (error)
+			goto out_unlock;
+	}
+
+	if (ip->i_di.di_eattr) {
+		error = gfs2_ea_dealloc(ip);
+		if (error)
+			goto out_unlock;
+	}
+
+	if (!gfs2_is_stuffed(ip)) {
+		error = gfs2_file_dealloc(ip);
+		if (error)
+			goto out_unlock;
+	}
+
+	error = gfs2_dinode_dealloc(ip);
+
+out_unlock:
+	gfs2_glock_dq(&ip->i_iopen_gh);
+out_uninit:
+	gfs2_holder_uninit(&ip->i_iopen_gh);
+	gfs2_glock_dq_uninit(&gh);
+	if (error)
+		fs_warn(sdp, "gfs2_delete_inode: %d\n", error);
+out:
+	truncate_inode_pages(&inode->i_data, 0);
+	clear_inode(inode);
+}
+
+
+
+static struct inode *gfs2_alloc_inode(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+	struct gfs2_inode *ip;
+
+	ip = kmem_cache_alloc(gfs2_inode_cachep, GFP_KERNEL);
+	if (ip) {
+		ip->i_flags = 0;
+		ip->i_gl = NULL;
+		ip->i_greedy = gfs2_tune_get(sdp, gt_greedy_default);
+		ip->i_last_pfault = jiffies;
+	}
+	return &ip->i_inode;
+}
+
+static void gfs2_destroy_inode(struct inode *inode)
+{
+	kmem_cache_free(gfs2_inode_cachep, inode);
+}
+
+struct super_operations gfs2_super_ops = {
+	.alloc_inode = gfs2_alloc_inode,
+	.destroy_inode = gfs2_destroy_inode,
+	.write_inode = gfs2_write_inode,
+	.delete_inode = gfs2_delete_inode,
+	.put_super = gfs2_put_super,
+	.write_super = gfs2_write_super,
+	.write_super_lockfs = gfs2_write_super_lockfs,
+	.unlockfs = gfs2_unlockfs,
+	.statfs = gfs2_statfs,
+	.remount_fs = gfs2_remount_fs,
+	.clear_inode = gfs2_clear_inode,
+	.show_options = gfs2_show_options,
+};
+
--- /dev/null
+++ b/fs/gfs2/ops_super.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_SUPER_DOT_H__
+#define __OPS_SUPER_DOT_H__
+
+extern struct super_operations gfs2_super_ops;
+
+#endif /* __OPS_SUPER_DOT_H__ */
--- /dev/null
+++ b/fs/gfs2/ops_vm.c
@@ -0,0 +1,188 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <linux/gfs2_ondisk.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "bmap.h"
+#include "glock.h"
+#include "inode.h"
+#include "ops_vm.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
+#include "util.h"
+
+static void pfault_be_greedy(struct gfs2_inode *ip)
+{
+	unsigned int time;
+
+	spin_lock(&ip->i_spin);
+	time = ip->i_greedy;
+	ip->i_last_pfault = jiffies;
+	spin_unlock(&ip->i_spin);
+
+	igrab(&ip->i_inode);
+	if (gfs2_glock_be_greedy(ip->i_gl, time))
+		iput(&ip->i_inode);
+}
+
+static struct page *gfs2_private_nopage(struct vm_area_struct *area,
+					unsigned long address, int *type)
+{
+	struct gfs2_inode *ip = GFS2_I(area->vm_file->f_mapping->host);
+	struct page *result;
+
+	set_bit(GIF_PAGED, &ip->i_flags);
+
+	result = filemap_nopage(area, address, type);
+
+	if (result && result != NOPAGE_OOM)
+		pfault_be_greedy(ip);
+
+	return result;
+}
+
+static int alloc_page_backing(struct gfs2_inode *ip, struct page *page)
+{
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	unsigned long index = page->index;
+	uint64_t lblock = index << (PAGE_CACHE_SHIFT -
+				    sdp->sd_sb.sb_bsize_shift);
+	unsigned int blocks = PAGE_CACHE_SIZE >> sdp->sd_sb.sb_bsize_shift;
+	struct gfs2_alloc *al;
+	unsigned int data_blocks, ind_blocks;
+	unsigned int x;
+	int error;
+
+	al = gfs2_alloc_get(ip);
+
+	error = gfs2_quota_lock(ip, NO_QUOTA_CHANGE, NO_QUOTA_CHANGE);
+	if (error)
+		goto out;
+
+	error = gfs2_quota_check(ip, ip->i_di.di_uid, ip->i_di.di_gid);
+	if (error)
+		goto out_gunlock_q;
+
+	gfs2_write_calc_reserv(ip, PAGE_CACHE_SIZE, &data_blocks, &ind_blocks);
+
+	al->al_requested = data_blocks + ind_blocks;
+
+	error = gfs2_inplace_reserve(ip);
+	if (error)
+		goto out_gunlock_q;
+
+	error = gfs2_trans_begin(sdp, al->al_rgd->rd_ri.ri_length +
+				 ind_blocks + RES_DINODE +
+				 RES_STATFS + RES_QUOTA, 0);
+	if (error)
+		goto out_ipres;
+
+	if (gfs2_is_stuffed(ip)) {
+		error = gfs2_unstuff_dinode(ip, NULL);
+		if (error)
+			goto out_trans;
+	}
+
+	for (x = 0; x < blocks; ) {
+		uint64_t dblock;
+		unsigned int extlen;
+		int new = 1;
+
+		error = gfs2_extent_map(&ip->i_inode, lblock, &new, &dblock, &extlen);
+		if (error)
+			goto out_trans;
+
+		lblock += extlen;
+		x += extlen;
+	}
+
+	gfs2_assert_warn(sdp, al->al_alloced);
+
+ out_trans:
+	gfs2_trans_end(sdp);
+
+ out_ipres:
+	gfs2_inplace_release(ip);
+
+ out_gunlock_q:
+	gfs2_quota_unlock(ip);
+
+ out:
+	gfs2_alloc_put(ip);
+
+	return error;
+}
+
+static struct page *gfs2_sharewrite_nopage(struct vm_area_struct *area,
+					   unsigned long address, int *type)
+{
+	struct file *file = area->vm_file;
+	struct gfs2_file *gf = file->private_data;
+	struct gfs2_inode *ip = GFS2_I(file->f_mapping->host);
+	struct gfs2_holder i_gh;
+	struct page *result = NULL;
+	unsigned long index = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) +
+			      area->vm_pgoff;
+	int alloc_required;
+	int error;
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	if (error)
+		return NULL;
+
+	set_bit(GIF_PAGED, &ip->i_flags);
+	set_bit(GIF_SW_PAGED, &ip->i_flags);
+
+	error = gfs2_write_alloc_required(ip, (u64)index << PAGE_CACHE_SHIFT,
+					  PAGE_CACHE_SIZE, &alloc_required);
+	if (error)
+		goto out;
+
+	set_bit(GFF_EXLOCK, &gf->f_flags);
+	result = filemap_nopage(area, address, type);
+	clear_bit(GFF_EXLOCK, &gf->f_flags);
+	if (!result || result == NOPAGE_OOM)
+		goto out;
+
+	if (alloc_required) {
+		error = alloc_page_backing(ip, result);
+		if (error) {
+			page_cache_release(result);
+			result = NULL;
+			goto out;
+		}
+		set_page_dirty(result);
+	}
+
+	pfault_be_greedy(ip);
+out:
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return result;
+}
+
+struct vm_operations_struct gfs2_vm_ops_private = {
+	.nopage = gfs2_private_nopage,
+};
+
+struct vm_operations_struct gfs2_vm_ops_sharewrite = {
+	.nopage = gfs2_sharewrite_nopage,
+};
+
--- /dev/null
+++ b/fs/gfs2/ops_vm.h
@@ -0,0 +1,16 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __OPS_VM_DOT_H__
+#define __OPS_VM_DOT_H__
+
+extern struct vm_operations_struct gfs2_vm_ops_private;
+extern struct vm_operations_struct gfs2_vm_ops_sharewrite;
+
+#endif /* __OPS_VM_DOT_H__ */
--- /dev/null
+++ b/fs/gfs2/super.c
@@ -0,0 +1,979 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/crc32.h>
+#include <linux/gfs2_ondisk.h>
+#include <linux/bio.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "bmap.h"
+#include "dir.h"
+#include "format.h"
+#include "glock.h"
+#include "glops.h"
+#include "inode.h"
+#include "log.h"
+#include "meta_io.h"
+#include "quota.h"
+#include "recovery.h"
+#include "rgrp.h"
+#include "super.h"
+#include "trans.h"
+#include "util.h"
+
+/**
+ * gfs2_tune_init - Fill a gfs2_tune structure with default values
+ * @gt: tune
+ *
+ */
+
+void gfs2_tune_init(struct gfs2_tune *gt)
+{
+	spin_lock_init(&gt->gt_spin);
+
+	gt->gt_ilimit = 100;
+	gt->gt_ilimit_tries = 3;
+	gt->gt_ilimit_min = 1;
+	gt->gt_demote_secs = 300;
+	gt->gt_incore_log_blocks = 1024;
+	gt->gt_log_flush_secs = 60;
+	gt->gt_jindex_refresh_secs = 60;
+	gt->gt_scand_secs = 15;
+	gt->gt_recoverd_secs = 60;
+	gt->gt_logd_secs = 1;
+	gt->gt_quotad_secs = 5;
+	gt->gt_quota_simul_sync = 64;
+	gt->gt_quota_warn_period = 10;
+	gt->gt_quota_scale_num = 1;
+	gt->gt_quota_scale_den = 1;
+	gt->gt_quota_cache_secs = 300;
+	gt->gt_quota_quantum = 60;
+	gt->gt_atime_quantum = 3600;
+	gt->gt_new_files_jdata = 0;
+	gt->gt_new_files_directio = 0;
+	gt->gt_max_atomic_write = 4 << 20;
+	gt->gt_max_readahead = 1 << 18;
+	gt->gt_lockdump_size = 131072;
+	gt->gt_stall_secs = 600;
+	gt->gt_complain_secs = 10;
+	gt->gt_reclaim_limit = 5000;
+	gt->gt_entries_per_readdir = 32;
+	gt->gt_prefetch_secs = 10;
+	gt->gt_greedy_default = HZ / 10;
+	gt->gt_greedy_quantum = HZ / 40;
+	gt->gt_greedy_max = HZ / 4;
+	gt->gt_statfs_quantum = 30;
+	gt->gt_statfs_slow = 0;
+}
+
+/**
+ * gfs2_check_sb - Check superblock
+ * @sdp: the filesystem
+ * @sb: The superblock
+ * @silent: Don't print a message if the check fails
+ *
+ * Checks the version code of the FS is one that we understand how to
+ * read and that the sizes of the various on-disk structures have not
+ * changed.
+ */
+
+int gfs2_check_sb(struct gfs2_sbd *sdp, struct gfs2_sb *sb, int silent)
+{
+	unsigned int x;
+
+	if (sb->sb_header.mh_magic != GFS2_MAGIC ||
+	    sb->sb_header.mh_type != GFS2_METATYPE_SB) {
+		if (!silent)
+			printk(KERN_WARNING "GFS2: not a GFS2 filesystem\n");
+		return -EINVAL;
+	}
+
+	/*  If format numbers match exactly, we're done.  */
+
+	if (sb->sb_fs_format == GFS2_FORMAT_FS &&
+	    sb->sb_multihost_format == GFS2_FORMAT_MULTI)
+		return 0;
+
+	if (sb->sb_fs_format != GFS2_FORMAT_FS) {
+		for (x = 0; gfs2_old_fs_formats[x]; x++)
+			if (gfs2_old_fs_formats[x] == sb->sb_fs_format)
+				break;
+
+		if (!gfs2_old_fs_formats[x]) {
+			printk(KERN_WARNING
+			       "GFS2: code version (%u, %u) is incompatible "
+			       "with ondisk format (%u, %u)\n",
+			       GFS2_FORMAT_FS, GFS2_FORMAT_MULTI,
+			       sb->sb_fs_format, sb->sb_multihost_format);
+			printk(KERN_WARNING
+			       "GFS2: I don't know how to upgrade this FS\n");
+			return -EINVAL;
+		}
+	}
+
+	if (sb->sb_multihost_format != GFS2_FORMAT_MULTI) {
+		for (x = 0; gfs2_old_multihost_formats[x]; x++)
+			if (gfs2_old_multihost_formats[x] ==
+			    sb->sb_multihost_format)
+				break;
+
+		if (!gfs2_old_multihost_formats[x]) {
+			printk(KERN_WARNING
+			       "GFS2: code version (%u, %u) is incompatible "
+			       "with ondisk format (%u, %u)\n",
+			       GFS2_FORMAT_FS, GFS2_FORMAT_MULTI,
+			       sb->sb_fs_format, sb->sb_multihost_format);
+			printk(KERN_WARNING
+			       "GFS2: I don't know how to upgrade this FS\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!sdp->sd_args.ar_upgrade) {
+		printk(KERN_WARNING
+		       "GFS2: code version (%u, %u) is incompatible "
+		       "with ondisk format (%u, %u)\n",
+		       GFS2_FORMAT_FS, GFS2_FORMAT_MULTI,
+		       sb->sb_fs_format, sb->sb_multihost_format);
+		printk(KERN_INFO
+		       "GFS2: Use the \"upgrade\" mount option to upgrade "
+		       "the FS\n");
+		printk(KERN_INFO "GFS2: See the manual for more details\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+
+static int end_bio_io_page(struct bio *bio, unsigned int bytes_done, int error)
+{
+	struct page *page = bio->bi_private;
+	if (bio->bi_size)
+		return 1;
+
+	if (!error)
+		SetPageUptodate(page);
+	else
+		printk(KERN_WARNING "gfs2: error %d reading superblock\n", error);
+	unlock_page(page);
+	return 0;
+}
+
+static struct page *gfs2_read_super(struct super_block *sb, sector_t sector)
+{
+	struct page *page;
+	struct bio *bio;
+
+	page = alloc_page(GFP_KERNEL);
+	if (unlikely(!page))
+		return NULL;
+
+	ClearPageUptodate(page);
+	ClearPageDirty(page);
+	lock_page(page);
+
+	bio = bio_alloc(GFP_KERNEL, 1);
+	if (unlikely(!bio)) {
+		__free_page(page);
+		return NULL;
+	}
+
+	bio->bi_sector = sector;
+	bio->bi_bdev = sb->s_bdev;
+	bio_add_page(bio, page, PAGE_SIZE, 0);
+
+	bio->bi_end_io = end_bio_io_page;
+	bio->bi_private = page;
+	submit_bio(READ_SYNC, bio);
+	wait_on_page_locked(page);
+	bio_put(bio);
+	if (!PageUptodate(page)) {
+		__free_page(page);
+		return NULL;
+	}
+	return page;
+}
+
+/**
+ * gfs2_read_sb - Read super block
+ * @sdp: The GFS2 superblock
+ * @gl: the glock for the superblock (assumed to be held)
+ * @silent: Don't print message if mount fails
+ *
+ */
+
+int gfs2_read_sb(struct gfs2_sbd *sdp, struct gfs2_glock *gl, int silent)
+{
+	uint32_t hash_blocks, ind_blocks, leaf_blocks;
+	uint32_t tmp_blocks;
+	unsigned int x;
+	int error;
+	struct page *page;
+	char *sb;
+
+	page = gfs2_read_super(sdp->sd_vfs, GFS2_SB_ADDR >> sdp->sd_fsb2bb_shift);
+	if (!page) {
+		if (!silent)
+			fs_err(sdp, "can't read superblock\n");
+		return -EIO;
+	}
+	sb = kmap(page);
+	gfs2_sb_in(&sdp->sd_sb, sb);
+	kunmap(page);
+	__free_page(page);
+
+	error = gfs2_check_sb(sdp, &sdp->sd_sb, silent);
+	if (error)
+		return error;
+
+	sdp->sd_fsb2bb_shift = sdp->sd_sb.sb_bsize_shift -
+			       GFS2_BASIC_BLOCK_SHIFT;
+	sdp->sd_fsb2bb = 1 << sdp->sd_fsb2bb_shift;
+	sdp->sd_diptrs = (sdp->sd_sb.sb_bsize -
+			  sizeof(struct gfs2_dinode)) / sizeof(uint64_t);
+	sdp->sd_inptrs = (sdp->sd_sb.sb_bsize -
+			  sizeof(struct gfs2_meta_header)) / sizeof(uint64_t);
+	sdp->sd_jbsize = sdp->sd_sb.sb_bsize - sizeof(struct gfs2_meta_header);
+	sdp->sd_hash_bsize = sdp->sd_sb.sb_bsize / 2;
+	sdp->sd_hash_bsize_shift = sdp->sd_sb.sb_bsize_shift - 1;
+	sdp->sd_hash_ptrs = sdp->sd_hash_bsize / sizeof(uint64_t);
+	sdp->sd_qc_per_block = (sdp->sd_sb.sb_bsize -
+				sizeof(struct gfs2_meta_header)) /
+			        sizeof(struct gfs2_quota_change);
+
+	/* Compute maximum reservation required to add a entry to a directory */
+
+	hash_blocks = DIV_ROUND_UP(sizeof(uint64_t) * (1 << GFS2_DIR_MAX_DEPTH),
+			     sdp->sd_jbsize);
+
+	ind_blocks = 0;
+	for (tmp_blocks = hash_blocks; tmp_blocks > sdp->sd_diptrs;) {
+		tmp_blocks = DIV_ROUND_UP(tmp_blocks, sdp->sd_inptrs);
+		ind_blocks += tmp_blocks;
+	}
+
+	leaf_blocks = 2 + GFS2_DIR_MAX_DEPTH;
+
+	sdp->sd_max_dirres = hash_blocks + ind_blocks + leaf_blocks;
+
+	sdp->sd_heightsize[0] = sdp->sd_sb.sb_bsize -
+				sizeof(struct gfs2_dinode);
+	sdp->sd_heightsize[1] = sdp->sd_sb.sb_bsize * sdp->sd_diptrs;
+	for (x = 2;; x++) {
+		uint64_t space, d;
+		uint32_t m;
+
+		space = sdp->sd_heightsize[x - 1] * sdp->sd_inptrs;
+		d = space;
+		m = do_div(d, sdp->sd_inptrs);
+
+		if (d != sdp->sd_heightsize[x - 1] || m)
+			break;
+		sdp->sd_heightsize[x] = space;
+	}
+	sdp->sd_max_height = x;
+	gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT);
+
+	sdp->sd_jheightsize[0] = sdp->sd_sb.sb_bsize -
+				 sizeof(struct gfs2_dinode);
+	sdp->sd_jheightsize[1] = sdp->sd_jbsize * sdp->sd_diptrs;
+	for (x = 2;; x++) {
+		uint64_t space, d;
+		uint32_t m;
+
+		space = sdp->sd_jheightsize[x - 1] * sdp->sd_inptrs;
+		d = space;
+		m = do_div(d, sdp->sd_inptrs);
+
+		if (d != sdp->sd_jheightsize[x - 1] || m)
+			break;
+		sdp->sd_jheightsize[x] = space;
+	}
+	sdp->sd_max_jheight = x;
+	gfs2_assert(sdp, sdp->sd_max_jheight <= GFS2_MAX_META_HEIGHT);
+
+	return 0;
+}
+
+/**
+ * gfs2_jindex_hold - Grab a lock on the jindex
+ * @sdp: The GFS2 superblock
+ * @ji_gh: the holder for the jindex glock
+ *
+ * This is very similar to the gfs2_rindex_hold() function, except that
+ * in general we hold the jindex lock for longer periods of time and
+ * we grab it far less frequently (in general) then the rgrp lock.
+ *
+ * Returns: errno
+ */
+
+int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh)
+{
+	struct gfs2_inode *dip = GFS2_I(sdp->sd_jindex);
+	struct qstr name;
+	char buf[20];
+	struct gfs2_jdesc *jd;
+	int error;
+
+	name.name = buf;
+
+	mutex_lock(&sdp->sd_jindex_mutex);
+
+	for (;;) {
+		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED,
+					   GL_LOCAL_EXCL, ji_gh);
+		if (error)
+			break;
+
+		name.len = sprintf(buf, "journal%u", sdp->sd_journals);
+		name.hash = gfs2_disk_hash(name.name, name.len);
+
+		error = gfs2_dir_search(sdp->sd_jindex, &name, NULL, NULL);
+		if (error == -ENOENT) {
+			error = 0;
+			break;
+		}
+
+		gfs2_glock_dq_uninit(ji_gh);
+
+		if (error)
+			break;
+
+		error = -ENOMEM;
+		jd = kzalloc(sizeof(struct gfs2_jdesc), GFP_KERNEL);
+		if (!jd)
+			break;
+
+		jd->jd_inode = gfs2_lookupi(sdp->sd_jindex, &name, 1, NULL);
+		if (!jd->jd_inode || IS_ERR(jd->jd_inode)) {
+			if (!jd->jd_inode)
+				error = -ENOENT;
+			else
+				error = PTR_ERR(jd->jd_inode);
+			kfree(jd);
+			break;
+		}
+
+		spin_lock(&sdp->sd_jindex_spin);
+		jd->jd_jid = sdp->sd_journals++;
+		list_add_tail(&jd->jd_list, &sdp->sd_jindex_list);
+		spin_unlock(&sdp->sd_jindex_spin);
+	}
+
+	mutex_unlock(&sdp->sd_jindex_mutex);
+
+	return error;
+}
+
+/**
+ * gfs2_jindex_free - Clear all the journal index information
+ * @sdp: The GFS2 superblock
+ *
+ */
+
+void gfs2_jindex_free(struct gfs2_sbd *sdp)
+{
+	struct list_head list;
+	struct gfs2_jdesc *jd;
+
+	spin_lock(&sdp->sd_jindex_spin);
+	list_add(&list, &sdp->sd_jindex_list);
+	list_del_init(&sdp->sd_jindex_list);
+	sdp->sd_journals = 0;
+	spin_unlock(&sdp->sd_jindex_spin);
+
+	while (!list_empty(&list)) {
+		jd = list_entry(list.next, struct gfs2_jdesc, jd_list);
+		list_del(&jd->jd_list);
+		iput(jd->jd_inode);
+		kfree(jd);
+	}
+}
+
+static struct gfs2_jdesc *jdesc_find_i(struct list_head *head, unsigned int jid)
+{
+	struct gfs2_jdesc *jd;
+	int found = 0;
+
+	list_for_each_entry(jd, head, jd_list) {
+		if (jd->jd_jid == jid) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found)
+		jd = NULL;
+
+	return jd;
+}
+
+struct gfs2_jdesc *gfs2_jdesc_find(struct gfs2_sbd *sdp, unsigned int jid)
+{
+	struct gfs2_jdesc *jd;
+
+	spin_lock(&sdp->sd_jindex_spin);
+	jd = jdesc_find_i(&sdp->sd_jindex_list, jid);
+	spin_unlock(&sdp->sd_jindex_spin);
+
+	return jd;
+}
+
+void gfs2_jdesc_make_dirty(struct gfs2_sbd *sdp, unsigned int jid)
+{
+	struct gfs2_jdesc *jd;
+
+	spin_lock(&sdp->sd_jindex_spin);
+	jd = jdesc_find_i(&sdp->sd_jindex_list, jid);
+	if (jd)
+		jd->jd_dirty = 1;
+	spin_unlock(&sdp->sd_jindex_spin);
+}
+
+struct gfs2_jdesc *gfs2_jdesc_find_dirty(struct gfs2_sbd *sdp)
+{
+	struct gfs2_jdesc *jd;
+	int found = 0;
+
+	spin_lock(&sdp->sd_jindex_spin);
+
+	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
+		if (jd->jd_dirty) {
+			jd->jd_dirty = 0;
+			found = 1;
+			break;
+		}
+	}
+	spin_unlock(&sdp->sd_jindex_spin);
+
+	if (!found)
+		jd = NULL;
+
+	return jd;
+}
+
+int gfs2_jdesc_check(struct gfs2_jdesc *jd)
+{
+	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
+	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
+	int ar;
+	int error;
+
+	if (ip->i_di.di_size < (8 << 20) || ip->i_di.di_size > (1 << 30) ||
+	    (ip->i_di.di_size & (sdp->sd_sb.sb_bsize - 1))) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+	jd->jd_blocks = ip->i_di.di_size >> sdp->sd_sb.sb_bsize_shift;
+
+	error = gfs2_write_alloc_required(ip, 0, ip->i_di.di_size, &ar);
+	if (!error && ar) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+	}
+
+	return error;
+}
+
+/**
+ * gfs2_make_fs_rw - Turn a Read-Only FS into a Read-Write one
+ * @sdp: the filesystem
+ *
+ * Returns: errno
+ */
+
+int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
+{
+	struct gfs2_inode *ip = GFS2_I(sdp->sd_jdesc->jd_inode);
+	struct gfs2_glock *j_gl = ip->i_gl;
+	struct gfs2_holder t_gh;
+	struct gfs2_log_header head;
+	int error;
+
+	error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_SHARED,
+				   GL_LOCAL_EXCL, &t_gh);
+	if (error)
+		return error;
+
+	gfs2_meta_cache_flush(ip);
+	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA | DIO_DATA);
+
+	error = gfs2_find_jhead(sdp->sd_jdesc, &head);
+	if (error)
+		goto fail;
+
+	if (!(head.lh_flags & GFS2_LOG_HEAD_UNMOUNT)) {
+		gfs2_consist(sdp);
+		error = -EIO;
+		goto fail;
+	}
+
+	/*  Initialize some head of the log stuff  */
+	sdp->sd_log_sequence = head.lh_sequence + 1;
+	gfs2_log_pointers_init(sdp, head.lh_blkno);
+
+	error = gfs2_quota_init(sdp);
+	if (error)
+		goto fail_unlinked;
+
+	set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
+
+	gfs2_glock_dq_uninit(&t_gh);
+
+	return 0;
+
+ fail_unlinked:
+
+ fail:
+	t_gh.gh_flags |= GL_NOCACHE;
+	gfs2_glock_dq_uninit(&t_gh);
+
+	return error;
+}
+
+/**
+ * gfs2_make_fs_ro - Turn a Read-Write FS into a Read-Only one
+ * @sdp: the filesystem
+ *
+ * Returns: errno
+ */
+
+int gfs2_make_fs_ro(struct gfs2_sbd *sdp)
+{
+	struct gfs2_holder t_gh;
+	int error;
+
+	gfs2_quota_sync(sdp);
+	gfs2_statfs_sync(sdp);
+
+	error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_SHARED,
+				GL_LOCAL_EXCL | GL_NOCACHE,
+				&t_gh);
+	if (error && !test_bit(SDF_SHUTDOWN, &sdp->sd_flags))
+		return error;
+
+	gfs2_meta_syncfs(sdp);
+	gfs2_log_shutdown(sdp);
+
+	clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
+
+	if (t_gh.gh_gl)
+		gfs2_glock_dq_uninit(&t_gh);
+
+	gfs2_quota_cleanup(sdp);
+
+	return error;
+}
+
+int gfs2_statfs_init(struct gfs2_sbd *sdp)
+{
+	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
+	struct gfs2_statfs_change *m_sc = &sdp->sd_statfs_master;
+	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
+	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct buffer_head *m_bh, *l_bh;
+	struct gfs2_holder gh;
+	int error;
+
+	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
+				   &gh);
+	if (error)
+		return error;
+
+	error = gfs2_meta_inode_buffer(m_ip, &m_bh);
+	if (error)
+		goto out;
+
+	if (sdp->sd_args.ar_spectator) {
+		spin_lock(&sdp->sd_statfs_spin);
+		gfs2_statfs_change_in(m_sc, m_bh->b_data +
+				      sizeof(struct gfs2_dinode));
+		spin_unlock(&sdp->sd_statfs_spin);
+	} else {
+		error = gfs2_meta_inode_buffer(l_ip, &l_bh);
+		if (error)
+			goto out_m_bh;
+
+		spin_lock(&sdp->sd_statfs_spin);
+		gfs2_statfs_change_in(m_sc, m_bh->b_data +
+				      sizeof(struct gfs2_dinode));
+		gfs2_statfs_change_in(l_sc, l_bh->b_data +
+				      sizeof(struct gfs2_dinode));
+		spin_unlock(&sdp->sd_statfs_spin);
+
+		brelse(l_bh);
+	}
+
+ out_m_bh:
+	brelse(m_bh);
+
+ out:
+	gfs2_glock_dq_uninit(&gh);
+
+	return 0;
+}
+
+void gfs2_statfs_change(struct gfs2_sbd *sdp, int64_t total, int64_t free,
+			int64_t dinodes)
+{
+	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
+	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct buffer_head *l_bh;
+	int error;
+
+	error = gfs2_meta_inode_buffer(l_ip, &l_bh);
+	if (error)
+		return;
+
+	mutex_lock(&sdp->sd_statfs_mutex);
+	gfs2_trans_add_bh(l_ip->i_gl, l_bh, 1);
+	mutex_unlock(&sdp->sd_statfs_mutex);
+
+	spin_lock(&sdp->sd_statfs_spin);
+	l_sc->sc_total += total;
+	l_sc->sc_free += free;
+	l_sc->sc_dinodes += dinodes;
+	gfs2_statfs_change_out(l_sc, l_bh->b_data +
+			       sizeof(struct gfs2_dinode));	
+	spin_unlock(&sdp->sd_statfs_spin);
+
+	brelse(l_bh);
+}
+
+int gfs2_statfs_sync(struct gfs2_sbd *sdp)
+{
+	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
+	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
+	struct gfs2_statfs_change *m_sc = &sdp->sd_statfs_master;
+	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct gfs2_holder gh;
+	struct buffer_head *m_bh, *l_bh;
+	int error;
+
+	error = gfs2_glock_nq_init(m_ip->i_gl, LM_ST_EXCLUSIVE, GL_NOCACHE,
+				   &gh);
+	if (error)
+		return error;
+
+	error = gfs2_meta_inode_buffer(m_ip, &m_bh);
+	if (error)
+		goto out;
+
+	spin_lock(&sdp->sd_statfs_spin);
+	gfs2_statfs_change_in(m_sc, m_bh->b_data +
+			      sizeof(struct gfs2_dinode));	
+	if (!l_sc->sc_total && !l_sc->sc_free && !l_sc->sc_dinodes) {
+		spin_unlock(&sdp->sd_statfs_spin);
+		goto out_bh;
+	}
+	spin_unlock(&sdp->sd_statfs_spin);
+
+	error = gfs2_meta_inode_buffer(l_ip, &l_bh);
+	if (error)
+		goto out_bh;
+
+	error = gfs2_trans_begin(sdp, 2 * RES_DINODE, 0);
+	if (error)
+		goto out_bh2;
+
+	mutex_lock(&sdp->sd_statfs_mutex);
+	gfs2_trans_add_bh(l_ip->i_gl, l_bh, 1);
+	mutex_unlock(&sdp->sd_statfs_mutex);
+
+	spin_lock(&sdp->sd_statfs_spin);
+	m_sc->sc_total += l_sc->sc_total;
+	m_sc->sc_free += l_sc->sc_free;
+	m_sc->sc_dinodes += l_sc->sc_dinodes;
+	memset(l_sc, 0, sizeof(struct gfs2_statfs_change));
+	memset(l_bh->b_data + sizeof(struct gfs2_dinode),
+	       0, sizeof(struct gfs2_statfs_change));
+	spin_unlock(&sdp->sd_statfs_spin);
+
+	gfs2_trans_add_bh(m_ip->i_gl, m_bh, 1);
+	gfs2_statfs_change_out(m_sc, m_bh->b_data + sizeof(struct gfs2_dinode));
+
+	gfs2_trans_end(sdp);
+
+ out_bh2:
+	brelse(l_bh);
+
+ out_bh:
+	brelse(m_bh);
+
+ out:
+	gfs2_glock_dq_uninit(&gh);
+
+	return error;
+}
+
+/**
+ * gfs2_statfs_i - Do a statfs
+ * @sdp: the filesystem
+ * @sg: the sg structure
+ *
+ * Returns: errno
+ */
+
+int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc)
+{
+	struct gfs2_statfs_change *m_sc = &sdp->sd_statfs_master;
+	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+
+	spin_lock(&sdp->sd_statfs_spin);
+
+	*sc = *m_sc;
+	sc->sc_total += l_sc->sc_total;
+	sc->sc_free += l_sc->sc_free;
+	sc->sc_dinodes += l_sc->sc_dinodes;
+
+	spin_unlock(&sdp->sd_statfs_spin);
+
+	if (sc->sc_free < 0)
+		sc->sc_free = 0;
+	if (sc->sc_free > sc->sc_total)
+		sc->sc_free = sc->sc_total;
+	if (sc->sc_dinodes < 0)
+		sc->sc_dinodes = 0;
+
+	return 0;
+}
+
+/**
+ * statfs_fill - fill in the sg for a given RG
+ * @rgd: the RG
+ * @sc: the sc structure
+ *
+ * Returns: 0 on success, -ESTALE if the LVB is invalid
+ */
+
+static int statfs_slow_fill(struct gfs2_rgrpd *rgd,
+			    struct gfs2_statfs_change *sc)
+{
+	gfs2_rgrp_verify(rgd);
+	sc->sc_total += rgd->rd_ri.ri_data;
+	sc->sc_free += rgd->rd_rg.rg_free;
+	sc->sc_dinodes += rgd->rd_rg.rg_dinodes;
+	return 0;
+}
+
+/**
+ * gfs2_statfs_slow - Stat a filesystem using asynchronous locking
+ * @sdp: the filesystem
+ * @sc: the sc info that will be returned
+ *
+ * Any error (other than a signal) will cause this routine to fall back
+ * to the synchronous version.
+ *
+ * FIXME: This really shouldn't busy wait like this.
+ *
+ * Returns: errno
+ */
+
+int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc)
+{
+	struct gfs2_holder ri_gh;
+	struct gfs2_rgrpd *rgd_next;
+	struct gfs2_holder *gha, *gh;
+	unsigned int slots = 64;
+	unsigned int x;
+	int done;
+	int error = 0, err;
+
+	memset(sc, 0, sizeof(struct gfs2_statfs_change));
+	gha = kcalloc(slots, sizeof(struct gfs2_holder), GFP_KERNEL);
+	if (!gha)
+		return -ENOMEM;
+
+	error = gfs2_rindex_hold(sdp, &ri_gh);
+	if (error)
+		goto out;
+
+	rgd_next = gfs2_rgrpd_get_first(sdp);
+
+	for (;;) {
+		done = 1;
+
+		for (x = 0; x < slots; x++) {
+			gh = gha + x;
+
+			if (gh->gh_gl && gfs2_glock_poll(gh)) {
+				err = gfs2_glock_wait(gh);
+				if (err) {
+					gfs2_holder_uninit(gh);
+					error = err;
+				} else {
+					if (!error)
+						error = statfs_slow_fill(
+							gh->gh_gl->gl_object, sc);
+					gfs2_glock_dq_uninit(gh);
+				}
+			}
+
+			if (gh->gh_gl)
+				done = 0;
+			else if (rgd_next && !error) {
+				error = gfs2_glock_nq_init(rgd_next->rd_gl,
+							   LM_ST_SHARED,
+							   GL_ASYNC,
+							   gh);
+				rgd_next = gfs2_rgrpd_get_next(rgd_next);
+				done = 0;
+			}
+
+			if (signal_pending(current))
+				error = -ERESTARTSYS;
+		}
+
+		if (done)
+			break;
+
+		yield();
+	}
+
+	gfs2_glock_dq_uninit(&ri_gh);
+
+ out:
+	kfree(gha);
+
+	return error;
+}
+
+struct lfcc {
+	struct list_head list;
+	struct gfs2_holder gh;
+};
+
+/**
+ * gfs2_lock_fs_check_clean - Stop all writes to the FS and check that all
+ *                            journals are clean
+ * @sdp: the file system
+ * @state: the state to put the transaction lock into
+ * @t_gh: the hold on the transaction lock
+ *
+ * Returns: errno
+ */
+
+static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp,
+				    struct gfs2_holder *t_gh)
+{
+	struct gfs2_inode *ip;
+	struct gfs2_holder ji_gh;
+	struct gfs2_jdesc *jd;
+	struct lfcc *lfcc;
+	LIST_HEAD(list);
+	struct gfs2_log_header lh;
+	int error;
+
+	error = gfs2_jindex_hold(sdp, &ji_gh);
+	if (error)
+		return error;
+
+	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
+		lfcc = kmalloc(sizeof(struct lfcc), GFP_KERNEL);
+		if (!lfcc) {
+			error = -ENOMEM;
+			goto out;
+		}
+		ip = GFS2_I(jd->jd_inode);
+		error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &lfcc->gh);
+		if (error) {
+			kfree(lfcc);
+			goto out;
+		}
+		list_add(&lfcc->list, &list);
+	}
+
+	error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_DEFERRED,
+			       LM_FLAG_PRIORITY | GL_NOCACHE,
+			       t_gh);
+
+	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
+		error = gfs2_jdesc_check(jd);
+		if (error)
+			break;
+		error = gfs2_find_jhead(jd, &lh);
+		if (error)
+			break;
+		if (!(lh.lh_flags & GFS2_LOG_HEAD_UNMOUNT)) {
+			error = -EBUSY;
+			break;
+		}
+	}
+
+	if (error)
+		gfs2_glock_dq_uninit(t_gh);
+
+ out:
+	while (!list_empty(&list)) {
+		lfcc = list_entry(list.next, struct lfcc, list);
+		list_del(&lfcc->list);
+		gfs2_glock_dq_uninit(&lfcc->gh);
+		kfree(lfcc);
+	}
+	gfs2_glock_dq_uninit(&ji_gh);
+
+	return error;
+}
+
+/**
+ * gfs2_freeze_fs - freezes the file system
+ * @sdp: the file system
+ *
+ * This function flushes data and meta data for all machines by
+ * aquiring the transaction log exclusively.  All journals are
+ * ensured to be in a clean state as well.
+ *
+ * Returns: errno
+ */
+
+int gfs2_freeze_fs(struct gfs2_sbd *sdp)
+{
+	int error = 0;
+
+	mutex_lock(&sdp->sd_freeze_lock);
+
+	if (!sdp->sd_freeze_count++) {
+		error = gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_gh);
+		if (error)
+			sdp->sd_freeze_count--;
+	}
+
+	mutex_unlock(&sdp->sd_freeze_lock);
+
+	return error;
+}
+
+/**
+ * gfs2_unfreeze_fs - unfreezes the file system
+ * @sdp: the file system
+ *
+ * This function allows the file system to proceed by unlocking
+ * the exclusively held transaction lock.  Other GFS2 nodes are
+ * now free to acquire the lock shared and go on with their lives.
+ *
+ */
+
+void gfs2_unfreeze_fs(struct gfs2_sbd *sdp)
+{
+	mutex_lock(&sdp->sd_freeze_lock);
+
+	if (sdp->sd_freeze_count && !--sdp->sd_freeze_count)
+		gfs2_glock_dq_uninit(&sdp->sd_freeze_gh);
+
+	mutex_unlock(&sdp->sd_freeze_lock);
+}
+
--- /dev/null
+++ b/fs/gfs2/super.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __SUPER_DOT_H__
+#define __SUPER_DOT_H__
+
+void gfs2_tune_init(struct gfs2_tune *gt);
+
+int gfs2_check_sb(struct gfs2_sbd *sdp, struct gfs2_sb *sb, int silent);
+int gfs2_read_sb(struct gfs2_sbd *sdp, struct gfs2_glock *gl, int silent);
+
+static inline unsigned int gfs2_jindex_size(struct gfs2_sbd *sdp)
+{
+	unsigned int x;
+	spin_lock(&sdp->sd_jindex_spin);
+	x = sdp->sd_journals;
+	spin_unlock(&sdp->sd_jindex_spin);
+	return x;
+}
+
+int gfs2_jindex_hold(struct gfs2_sbd *sdp, struct gfs2_holder *ji_gh);
+void gfs2_jindex_free(struct gfs2_sbd *sdp);
+
+struct gfs2_jdesc *gfs2_jdesc_find(struct gfs2_sbd *sdp, unsigned int jid);
+void gfs2_jdesc_make_dirty(struct gfs2_sbd *sdp, unsigned int jid);
+struct gfs2_jdesc *gfs2_jdesc_find_dirty(struct gfs2_sbd *sdp);
+int gfs2_jdesc_check(struct gfs2_jdesc *jd);
+
+int gfs2_lookup_in_master_dir(struct gfs2_sbd *sdp, char *filename,
+			      struct gfs2_inode **ipp);
+
+int gfs2_make_fs_rw(struct gfs2_sbd *sdp);
+int gfs2_make_fs_ro(struct gfs2_sbd *sdp);
+
+int gfs2_statfs_init(struct gfs2_sbd *sdp);
+void gfs2_statfs_change(struct gfs2_sbd *sdp,
+			int64_t total, int64_t free, int64_t dinodes);
+int gfs2_statfs_sync(struct gfs2_sbd *sdp);
+int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc);
+int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc);
+
+int gfs2_freeze_fs(struct gfs2_sbd *sdp);
+void gfs2_unfreeze_fs(struct gfs2_sbd *sdp);
+
+#endif /* __SUPER_DOT_H__ */
+
--- /dev/null
+++ b/fs/gfs2/trans.c
@@ -0,0 +1,184 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/gfs2_ondisk.h>
+#include <linux/kallsyms.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "glock.h"
+#include "log.h"
+#include "lops.h"
+#include "meta_io.h"
+#include "trans.h"
+#include "util.h"
+
+int gfs2_trans_begin(struct gfs2_sbd *sdp, unsigned int blocks,
+		     unsigned int revokes)
+{
+	struct gfs2_trans *tr;
+	int error;
+
+	BUG_ON(current->journal_info);
+	BUG_ON(blocks == 0 && revokes == 0);
+
+	tr = kzalloc(sizeof(struct gfs2_trans), GFP_NOFS);
+	if (!tr)
+		return -ENOMEM;
+
+	tr->tr_ip = (unsigned long)__builtin_return_address(0);
+	tr->tr_blocks = blocks;
+	tr->tr_revokes = revokes;
+	tr->tr_reserved = 1;
+	if (blocks)
+		tr->tr_reserved += 6 + blocks;
+	if (revokes)
+		tr->tr_reserved += gfs2_struct2blk(sdp, revokes,
+						   sizeof(uint64_t));
+	INIT_LIST_HEAD(&tr->tr_list_buf);
+
+	gfs2_holder_init(sdp->sd_trans_gl, LM_ST_SHARED, 0, &tr->tr_t_gh);
+
+	error = gfs2_glock_nq(&tr->tr_t_gh);
+	if (error)
+		goto fail_holder_uninit;
+
+	if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		tr->tr_t_gh.gh_flags |= GL_NOCACHE;
+		error = -EROFS;
+		goto fail_gunlock;
+	}
+
+	error = gfs2_log_reserve(sdp, tr->tr_reserved);
+	if (error)
+		goto fail_gunlock;
+
+	current->journal_info = tr;
+
+	return 0;
+
+fail_gunlock:
+	gfs2_glock_dq(&tr->tr_t_gh);
+
+fail_holder_uninit:
+	gfs2_holder_uninit(&tr->tr_t_gh);
+	kfree(tr);
+
+	return error;
+}
+
+void gfs2_trans_end(struct gfs2_sbd *sdp)
+{
+	struct gfs2_trans *tr = current->journal_info;
+
+	BUG_ON(!tr);
+	current->journal_info = NULL;
+
+	if (!tr->tr_touched) {
+		gfs2_log_release(sdp, tr->tr_reserved);
+		gfs2_glock_dq(&tr->tr_t_gh);
+		gfs2_holder_uninit(&tr->tr_t_gh);
+		kfree(tr);
+		return;
+	}
+
+	if (gfs2_assert_withdraw(sdp, tr->tr_num_buf <= tr->tr_blocks)) {
+		fs_err(sdp, "tr_num_buf = %u, tr_blocks = %u ",
+		       tr->tr_num_buf, tr->tr_blocks);
+		print_symbol(KERN_WARNING "GFS2: Transaction created at: %s\n", tr->tr_ip);
+	}
+	if (gfs2_assert_withdraw(sdp, tr->tr_num_revoke <= tr->tr_revokes)) {
+		fs_err(sdp, "tr_num_revoke = %u, tr_revokes = %u ",
+		       tr->tr_num_revoke, tr->tr_revokes);
+		print_symbol(KERN_WARNING "GFS2: Transaction created at: %s\n", tr->tr_ip);
+	}
+
+	gfs2_log_commit(sdp, tr);
+        gfs2_glock_dq(&tr->tr_t_gh);
+        gfs2_holder_uninit(&tr->tr_t_gh);
+        kfree(tr);
+
+	if (sdp->sd_vfs->s_flags & MS_SYNCHRONOUS)
+		gfs2_log_flush(sdp, NULL);
+}
+
+void gfs2_trans_add_gl(struct gfs2_glock *gl)
+{
+	lops_add(gl->gl_sbd, &gl->gl_le);
+}
+
+/**
+ * gfs2_trans_add_bh - Add a to-be-modified buffer to the current transaction
+ * @gl: the glock the buffer belongs to
+ * @bh: The buffer to add
+ * @meta: True in the case of adding metadata
+ *
+ */
+
+void gfs2_trans_add_bh(struct gfs2_glock *gl, struct buffer_head *bh, int meta)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct gfs2_bufdata *bd;
+
+	bd = bh->b_private;
+	if (bd)
+		gfs2_assert(sdp, bd->bd_gl == gl);
+	else {
+		gfs2_attach_bufdata(gl, bh, meta);
+		bd = bh->b_private;
+	}
+	lops_add(sdp, &bd->bd_le);
+}
+
+void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, uint64_t blkno)
+{
+	struct gfs2_revoke *rv = kmalloc(sizeof(struct gfs2_revoke),
+					 GFP_NOFS | __GFP_NOFAIL);
+	lops_init_le(&rv->rv_le, &gfs2_revoke_lops);
+	rv->rv_blkno = blkno;
+	lops_add(sdp, &rv->rv_le);
+}
+
+void gfs2_trans_add_unrevoke(struct gfs2_sbd *sdp, uint64_t blkno)
+{
+	struct gfs2_revoke *rv;
+	int found = 0;
+
+	gfs2_log_lock(sdp);
+
+	list_for_each_entry(rv, &sdp->sd_log_le_revoke, rv_le.le_list) {
+		if (rv->rv_blkno == blkno) {
+			list_del(&rv->rv_le.le_list);
+			gfs2_assert_withdraw(sdp, sdp->sd_log_num_revoke);
+			sdp->sd_log_num_revoke--;
+			found = 1;
+			break;
+		}
+	}
+
+	gfs2_log_unlock(sdp);
+
+	if (found) {
+		struct gfs2_trans *tr = current->journal_info;
+		kfree(rv);
+		tr->tr_num_revoke_rm++;
+	}
+}
+
+void gfs2_trans_add_rg(struct gfs2_rgrpd *rgd)
+{
+	lops_add(rgd->rd_sbd, &rgd->rd_le);
+}
+
--- /dev/null
+++ b/fs/gfs2/trans.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __TRANS_DOT_H__
+#define __TRANS_DOT_H__
+
+#define RES_DINODE	1
+#define RES_INDIRECT	1
+#define RES_JDATA	1
+#define RES_DATA	1
+#define RES_LEAF	1
+#define RES_RG_BIT	2
+#define RES_EATTR	1
+#define RES_STATFS	1
+#define RES_QUOTA	2
+
+int gfs2_trans_begin(struct gfs2_sbd *sdp,
+		      unsigned int blocks, unsigned int revokes);
+
+void gfs2_trans_end(struct gfs2_sbd *sdp);
+
+void gfs2_trans_add_gl(struct gfs2_glock *gl);
+void gfs2_trans_add_bh(struct gfs2_glock *gl, struct buffer_head *bh, int meta);
+void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, uint64_t blkno);
+void gfs2_trans_add_unrevoke(struct gfs2_sbd *sdp, uint64_t blkno);
+void gfs2_trans_add_rg(struct gfs2_rgrpd *rgd);
+
+#endif /* __TRANS_DOT_H__ */
--- /dev/null
+++ b/fs/gfs2/util.c
@@ -0,0 +1,245 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/buffer_head.h>
+#include <linux/crc32.h>
+#include <linux/gfs2_ondisk.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "lm_interface.h"
+#include "incore.h"
+#include "glock.h"
+#include "lm.h"
+#include "util.h"
+
+kmem_cache_t *gfs2_glock_cachep __read_mostly;
+kmem_cache_t *gfs2_inode_cachep __read_mostly;
+kmem_cache_t *gfs2_bufdata_cachep __read_mostly;
+
+void gfs2_assert_i(struct gfs2_sbd *sdp)
+{
+	printk(KERN_EMERG "GFS2: fsid=%s: fatal assertion failed\n",
+	       sdp->sd_fsname);
+}
+
+/**
+ * gfs2_assert_withdraw_i - Cause the machine to withdraw if @assertion is false
+ * Returns: -1 if this call withdrew the machine,
+ *          -2 if it was already withdrawn
+ */
+
+int gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
+			   const char *function, char *file, unsigned int line)
+{
+	int me;
+	me = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: assertion \"%s\" failed\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname, assertion,
+		sdp->sd_fsname, function, file, line);
+	dump_stack();
+	return (me) ? -1 : -2;
+}
+
+/**
+ * gfs2_assert_warn_i - Print a message to the console if @assertion is false
+ * Returns: -1 if we printed something
+ *          -2 if we didn't
+ */
+
+int gfs2_assert_warn_i(struct gfs2_sbd *sdp, char *assertion,
+		       const char *function, char *file, unsigned int line)
+{
+	if (time_before(jiffies,
+			sdp->sd_last_warning +
+			gfs2_tune_get(sdp, gt_complain_secs) * HZ))
+		return -2;
+
+	printk(KERN_WARNING
+	       "GFS2: fsid=%s: warning: assertion \"%s\" failed\n"
+	       "GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+	       sdp->sd_fsname, assertion,
+	       sdp->sd_fsname, function, file, line);
+
+	if (sdp->sd_args.ar_debug)
+		BUG();
+	else
+		dump_stack();
+
+	sdp->sd_last_warning = jiffies;
+
+	return -1;
+}
+
+/**
+ * gfs2_consist_i - Flag a filesystem consistency error and withdraw
+ * Returns: -1 if this call withdrew the machine,
+ *          0 if it was already withdrawn
+ */
+
+int gfs2_consist_i(struct gfs2_sbd *sdp, int cluster_wide, const char *function,
+		   char *file, unsigned int line)
+{
+	int rv;
+	rv = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: filesystem consistency error\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, function, file, line);
+	return rv;
+}
+
+/**
+ * gfs2_consist_inode_i - Flag an inode consistency error and withdraw
+ * Returns: -1 if this call withdrew the machine,
+ *          0 if it was already withdrawn
+ */
+
+int gfs2_consist_inode_i(struct gfs2_inode *ip, int cluster_wide,
+			 const char *function, char *file, unsigned int line)
+{
+	struct gfs2_sbd *sdp = GFS2_SB(&ip->i_inode);
+	int rv;
+	rv = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: filesystem consistency error\n"
+		"GFS2: fsid=%s:   inode = %llu %llu\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, (unsigned long long)ip->i_num.no_formal_ino,
+		(unsigned long long)ip->i_num.no_addr,
+		sdp->sd_fsname, function, file, line);
+	return rv;
+}
+
+/**
+ * gfs2_consist_rgrpd_i - Flag a RG consistency error and withdraw
+ * Returns: -1 if this call withdrew the machine,
+ *          0 if it was already withdrawn
+ */
+
+int gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd, int cluster_wide,
+			 const char *function, char *file, unsigned int line)
+{
+	struct gfs2_sbd *sdp = rgd->rd_sbd;
+	int rv;
+	rv = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: filesystem consistency error\n"
+		"GFS2: fsid=%s:   RG = %llu\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, (unsigned long long)rgd->rd_ri.ri_addr,
+		sdp->sd_fsname, function, file, line);
+	return rv;
+}
+
+/**
+ * gfs2_meta_check_ii - Flag a magic number consistency error and withdraw
+ * Returns: -1 if this call withdrew the machine,
+ *          -2 if it was already withdrawn
+ */
+
+int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+		       const char *type, const char *function, char *file,
+		       unsigned int line)
+{
+	int me;
+	me = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: invalid metadata block\n"
+		"GFS2: fsid=%s:   bh = %llu (%s)\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, (unsigned long long)bh->b_blocknr, type,
+		sdp->sd_fsname, function, file, line);
+	return (me) ? -1 : -2;
+}
+
+/**
+ * gfs2_metatype_check_ii - Flag a metadata type consistency error and withdraw
+ * Returns: -1 if this call withdrew the machine,
+ *          -2 if it was already withdrawn
+ */
+
+int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+			   uint16_t type, uint16_t t, const char *function,
+			   char *file, unsigned int line)
+{
+	int me;
+	me = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: invalid metadata block\n"
+		"GFS2: fsid=%s:   bh = %llu (type: exp=%u, found=%u)\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, (unsigned long long)bh->b_blocknr, type, t,
+		sdp->sd_fsname, function, file, line);
+	return (me) ? -1 : -2;
+}
+
+/**
+ * gfs2_io_error_i - Flag an I/O error and withdraw
+ * Returns: -1 if this call withdrew the machine,
+ *          0 if it was already withdrawn
+ */
+
+int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function, char *file,
+		    unsigned int line)
+{
+	int rv;
+	rv = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: I/O error\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, function, file, line);
+	return rv;
+}
+
+/**
+ * gfs2_io_error_bh_i - Flag a buffer I/O error and withdraw
+ * Returns: -1 if this call withdrew the machine,
+ *          0 if it was already withdrawn
+ */
+
+int gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
+		       const char *function, char *file, unsigned int line)
+{
+	int rv;
+	rv = gfs2_lm_withdraw(sdp,
+		"GFS2: fsid=%s: fatal: I/O error\n"
+		"GFS2: fsid=%s:   block = %llu\n"
+		"GFS2: fsid=%s:   function = %s, file = %s, line = %u\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, (unsigned long long)bh->b_blocknr,
+		sdp->sd_fsname, function, file, line);
+	return rv;
+}
+
+void gfs2_icbit_munge(struct gfs2_sbd *sdp, unsigned char **bitmap,
+		      unsigned int bit, int new_value)
+{
+	unsigned int c, o, b = bit;
+	int old_value;
+
+	c = b / (8 * PAGE_SIZE);
+	b %= 8 * PAGE_SIZE;
+	o = b / 8;
+	b %= 8;
+
+	old_value = (bitmap[c][o] & (1 << b));
+	gfs2_assert_withdraw(sdp, !old_value != !new_value);
+
+	if (new_value)
+		bitmap[c][o] |= 1 << b;
+	else
+		bitmap[c][o] &= ~(1 << b);
+}
+
--- /dev/null
+++ b/fs/gfs2/util.h
@@ -0,0 +1,169 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2006 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __UTIL_DOT_H__
+#define __UTIL_DOT_H__
+
+
+#define fs_printk(level, fs, fmt, arg...) \
+	printk(level "GFS2: fsid=%s: " fmt , (fs)->sd_fsname , ## arg)
+
+#define fs_info(fs, fmt, arg...) \
+	fs_printk(KERN_INFO , fs , fmt , ## arg)
+
+#define fs_warn(fs, fmt, arg...) \
+	fs_printk(KERN_WARNING , fs , fmt , ## arg)
+
+#define fs_err(fs, fmt, arg...) \
+	fs_printk(KERN_ERR, fs , fmt , ## arg)
+
+
+void gfs2_assert_i(struct gfs2_sbd *sdp);
+
+#define gfs2_assert(sdp, assertion) \
+do { \
+	if (unlikely(!(assertion))) { \
+		gfs2_assert_i(sdp); \
+		BUG(); \
+        } \
+} while (0)
+
+
+int gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
+			   const char *function, char *file, unsigned int line);
+
+#define gfs2_assert_withdraw(sdp, assertion) \
+((likely(assertion)) ? 0 : gfs2_assert_withdraw_i((sdp), #assertion, \
+					__FUNCTION__, __FILE__, __LINE__))
+
+
+int gfs2_assert_warn_i(struct gfs2_sbd *sdp, char *assertion,
+		       const char *function, char *file, unsigned int line);
+
+#define gfs2_assert_warn(sdp, assertion) \
+((likely(assertion)) ? 0 : gfs2_assert_warn_i((sdp), #assertion, \
+					__FUNCTION__, __FILE__, __LINE__))
+
+
+int gfs2_consist_i(struct gfs2_sbd *sdp, int cluster_wide,
+		   const char *function, char *file, unsigned int line);
+
+#define gfs2_consist(sdp) \
+gfs2_consist_i((sdp), 0, __FUNCTION__, __FILE__, __LINE__)
+
+
+int gfs2_consist_inode_i(struct gfs2_inode *ip, int cluster_wide,
+			 const char *function, char *file, unsigned int line);
+
+#define gfs2_consist_inode(ip) \
+gfs2_consist_inode_i((ip), 0, __FUNCTION__, __FILE__, __LINE__)
+
+
+int gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd, int cluster_wide,
+			 const char *function, char *file, unsigned int line);
+
+#define gfs2_consist_rgrpd(rgd) \
+gfs2_consist_rgrpd_i((rgd), 0, __FUNCTION__, __FILE__, __LINE__)
+
+
+int gfs2_meta_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+		       const char *type, const char *function,
+		       char *file, unsigned int line);
+
+static inline int gfs2_meta_check_i(struct gfs2_sbd *sdp,
+				    struct buffer_head *bh,
+				    const char *function,
+				    char *file, unsigned int line)
+{
+	struct gfs2_meta_header *mh = (struct gfs2_meta_header *)bh->b_data;
+	uint32_t magic = mh->mh_magic;
+	magic = be32_to_cpu(magic);
+	if (unlikely(magic != GFS2_MAGIC))
+		return gfs2_meta_check_ii(sdp, bh, "magic number", function,
+					  file, line);
+	return 0;
+}
+
+#define gfs2_meta_check(sdp, bh) \
+gfs2_meta_check_i((sdp), (bh), __FUNCTION__, __FILE__, __LINE__)
+
+
+int gfs2_metatype_check_ii(struct gfs2_sbd *sdp, struct buffer_head *bh,
+			   uint16_t type, uint16_t t,
+			   const char *function,
+			   char *file, unsigned int line);
+
+static inline int gfs2_metatype_check_i(struct gfs2_sbd *sdp,
+					struct buffer_head *bh,
+					uint16_t type,
+					const char *function,
+					char *file, unsigned int line)
+{
+	struct gfs2_meta_header *mh = (struct gfs2_meta_header *)bh->b_data;
+	uint32_t magic = mh->mh_magic;
+	uint16_t t = be32_to_cpu(mh->mh_type);
+	magic = be32_to_cpu(magic);
+	if (unlikely(magic != GFS2_MAGIC))
+		return gfs2_meta_check_ii(sdp, bh, "magic number", function,
+					  file, line);
+        if (unlikely(t != type))
+		return gfs2_metatype_check_ii(sdp, bh, type, t, function,
+					      file, line);
+	return 0;
+}
+
+#define gfs2_metatype_check(sdp, bh, type) \
+gfs2_metatype_check_i((sdp), (bh), (type), __FUNCTION__, __FILE__, __LINE__)
+
+static inline void gfs2_metatype_set(struct buffer_head *bh, uint16_t type,
+				     uint16_t format)
+{
+	struct gfs2_meta_header *mh;
+	mh = (struct gfs2_meta_header *)bh->b_data;
+	mh->mh_type = cpu_to_be32(type);
+	mh->mh_format = cpu_to_be32(format);
+}
+
+
+int gfs2_io_error_i(struct gfs2_sbd *sdp, const char *function,
+		    char *file, unsigned int line);
+
+#define gfs2_io_error(sdp) \
+gfs2_io_error_i((sdp), __FUNCTION__, __FILE__, __LINE__);
+
+
+int gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
+		       const char *function, char *file, unsigned int line);
+
+#define gfs2_io_error_bh(sdp, bh) \
+gfs2_io_error_bh_i((sdp), (bh), __FUNCTION__, __FILE__, __LINE__);
+
+
+extern kmem_cache_t *gfs2_glock_cachep;
+extern kmem_cache_t *gfs2_inode_cachep;
+extern kmem_cache_t *gfs2_bufdata_cachep;
+
+static inline unsigned int gfs2_tune_get_i(struct gfs2_tune *gt,
+					   unsigned int *p)
+{
+	unsigned int x;
+	spin_lock(&gt->gt_spin);
+	x = *p;
+	spin_unlock(&gt->gt_spin);
+	return x;
+}
+
+#define gfs2_tune_get(sdp, field) \
+gfs2_tune_get_i(&(sdp)->sd_tune, &(sdp)->sd_tune.field)
+
+void gfs2_icbit_munge(struct gfs2_sbd *sdp, unsigned char **bitmap,
+		      unsigned int bit, int new_value);
+
+#endif /* __UTIL_DOT_H__ */
+


