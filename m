Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVIAO3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVIAO3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVIAO3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:29:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38875 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965150AbVIAO3A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:29:00 -0400
Date: Thu, 1 Sep 2005 21:55:18 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02d/13] GFS: core fs
Message-ID: <20050901135518.GE25581@redhat.com>
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

 fs/gfs2/ops_super.c |  404 ++++++++++++++++++++++
 fs/gfs2/ops_super.h |   15 
 fs/gfs2/ops_vm.c    |  200 +++++++++++
 fs/gfs2/ops_vm.h    |   16 
 fs/gfs2/page.c      |  274 +++++++++++++++
 fs/gfs2/page.h      |   23 +
 fs/gfs2/super.c     |  945 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/gfs2/super.h     |   55 +++
 fs/gfs2/trans.c     |  215 +++++++++++
 fs/gfs2/trans.h     |   40 ++
 fs/gfs2/unlinked.c  |  454 ++++++++++++++++++++++++
 fs/gfs2/unlinked.h  |   25 +
 fs/gfs2/util.c      |  355 +++++++++++++++++++
 fs/gfs2/util.h      |  201 +++++++++++
 14 files changed, 3222 insertions(+)

--- a/fs/gfs2/ops_super.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_super.c	2005-09-01 17:36:55.433097536 +0800
@@ -0,0 +1,404 @@
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
+#include <linux/statfs.h>
+#include <linux/seq_file.h>
+#include <linux/mount.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "glock.h"
+#include "inode.h"
+#include "lm.h"
+#include "log.h"
+#include "mount.h"
+#include "ops_super.h"
+#include "page.h"
+#include "quota.h"
+#include "recovery.h"
+#include "rgrp.h"
+#include "super.h"
+#include "sys.h"
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
+	struct gfs2_inode *ip = get_v2ip(inode);
+
+	atomic_inc(&ip->i_sbd->sd_ops_super);
+
+	if (current->flags & PF_MEMALLOC)
+		return 0;
+	if (ip && sync)
+		gfs2_log_flush_glock(ip->i_gl);
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
+	struct gfs2_sbd *sdp = get_v2sdp(sb);
+	int error;
+
+	if (!sdp)
+		return;
+
+	atomic_inc(&sdp->sd_ops_super);
+
+	gfs2_sys_fs_del(sdp);
+
+	/*  Unfreeze the filesystem, if we need to  */
+
+	down(&sdp->sd_freeze_lock);
+	if (sdp->sd_freeze_count)
+		gfs2_glock_dq_uninit(&sdp->sd_freeze_gh);
+	up(&sdp->sd_freeze_lock);
+
+	kthread_stop(sdp->sd_inoded_process);
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
+
+	/*  At this point, we're through modifying the disk  */
+
+	/*  Release stuff  */
+
+	gfs2_inode_put(sdp->sd_master_dir);
+	gfs2_inode_put(sdp->sd_jindex);
+	gfs2_inode_put(sdp->sd_inum_inode);
+	gfs2_inode_put(sdp->sd_statfs_inode);
+	gfs2_inode_put(sdp->sd_rindex);
+	gfs2_inode_put(sdp->sd_quota_inode);
+	gfs2_inode_put(sdp->sd_root_dir);
+
+	gfs2_glock_put(sdp->sd_rename_gl);
+	gfs2_glock_put(sdp->sd_trans_gl);
+
+	if (!sdp->sd_args.ar_spectator) {
+		gfs2_glock_dq_uninit(&sdp->sd_journal_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_jinode_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_ir_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_sc_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_ut_gh);
+		gfs2_glock_dq_uninit(&sdp->sd_qc_gh);
+		gfs2_inode_put(sdp->sd_ir_inode);
+		gfs2_inode_put(sdp->sd_sc_inode);
+		gfs2_inode_put(sdp->sd_ut_inode);
+		gfs2_inode_put(sdp->sd_qc_inode);
+	}
+
+	gfs2_glock_dq_uninit(&sdp->sd_live_gh);
+
+	gfs2_clear_rgrpd(sdp);
+	gfs2_jindex_free(sdp);
+
+	/*  Take apart glock structures and buffer lists  */
+	gfs2_gl_hash_clear(sdp, WAIT);
+
+	/*  Unmount the locking protocol  */
+	gfs2_lm_unmount(sdp);
+
+	/*  At this point, we're through participating in the lockspace  */
+
+	/*  Get rid of any extra inodes  */
+	while (invalidate_inodes(sb))
+		yield();
+
+	vfree(sdp);
+
+	set_v2sdp(sb, NULL);
+}
+
+/**
+ * gfs2_write_super - disk commit all incore transactions
+ * @sb: the filesystem
+ *
+ * This function is called every time sync(2) is called.
+ * After this exits, all dirty buffers and synced.
+ */
+
+static void gfs2_write_super(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = get_v2sdp(sb);
+	atomic_inc(&sdp->sd_ops_super);
+	gfs2_log_flush(sdp);
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
+	struct gfs2_sbd *sdp = get_v2sdp(sb);
+	int error;
+
+	atomic_inc(&sdp->sd_ops_super);
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
+	struct gfs2_sbd *sdp = get_v2sdp(sb);
+
+	atomic_inc(&sdp->sd_ops_super);
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
+static int gfs2_statfs(struct super_block *sb, struct kstatfs *buf)
+{
+	struct gfs2_sbd *sdp = get_v2sdp(sb);
+	struct gfs2_statfs_change sc;
+	int error;
+
+	atomic_inc(&sdp->sd_ops_super);
+
+	if (gfs2_tune_get(sdp, gt_statfs_slow))
+		error = gfs2_statfs_slow(sdp, &sc);
+	else
+		error = gfs2_statfs_i(sdp, &sc);
+
+	if (error)
+		return error;
+
+	memset(buf, 0, sizeof(struct kstatfs));
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
+	struct gfs2_sbd *sdp = get_v2sdp(sb);
+	int error;
+
+	atomic_inc(&sdp->sd_ops_super);
+
+	error = gfs2_mount_args(sdp, data, TRUE);
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
+	struct gfs2_inode *ip = get_v2ip(inode);
+
+	atomic_inc(&get_v2sdp(inode->i_sb)->sd_ops_super);
+
+	if (ip) {
+		spin_lock(&ip->i_spin);
+		ip->i_vnode = NULL;
+		set_v2ip(inode, NULL);
+		spin_unlock(&ip->i_spin);
+
+		gfs2_glock_schedule_for_reclaim(ip->i_gl);
+		gfs2_inode_put(ip);
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
+	struct gfs2_sbd *sdp = get_v2sdp(mnt->mnt_sb);
+	struct gfs2_args *args = &sdp->sd_args;
+
+	atomic_inc(&sdp->sd_ops_super);
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
+	if (args->ar_oopses_ok)
+		seq_printf(s, ",oopses_ok");
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
+struct super_operations gfs2_super_ops = {
+	.write_inode = gfs2_write_inode,
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
--- a/fs/gfs2/ops_super.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_super.h	2005-09-01 17:36:55.433097536 +0800
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
+#ifndef __OPS_SUPER_DOT_H__
+#define __OPS_SUPER_DOT_H__
+
+extern struct super_operations gfs2_super_ops;
+
+#endif /* __OPS_SUPER_DOT_H__ */
--- a/fs/gfs2/ops_vm.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_vm.c	2005-09-01 17:36:55.433097536 +0800
@@ -0,0 +1,200 @@
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
+#include <linux/mm.h>
+#include <linux/pagemap.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "glock.h"
+#include "inode.h"
+#include "ops_vm.h"
+#include "page.h"
+#include "quota.h"
+#include "rgrp.h"
+#include "trans.h"
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
+	gfs2_inode_hold(ip);
+	if (gfs2_glock_be_greedy(ip->i_gl, time))
+		gfs2_inode_put(ip);
+}
+
+static struct page *gfs2_private_nopage(struct vm_area_struct *area,
+					unsigned long address, int *type)
+{
+	struct gfs2_inode *ip = get_v2ip(area->vm_file->f_mapping->host);
+	struct gfs2_holder i_gh;
+	struct page *result;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_vm);
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_SHARED, 0, &i_gh);
+	if (error)
+		return NULL;
+
+	set_bit(GIF_PAGED, &ip->i_flags);
+
+	result = filemap_nopage(area, address, type);
+
+	if (result && result != NOPAGE_OOM)
+		pfault_be_greedy(ip);
+
+	gfs2_glock_dq_uninit(&i_gh);
+
+	return result;
+}
+
+static int alloc_page_backing(struct gfs2_inode *ip, struct page *page)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	unsigned long index = page->index;
+	uint64_t lblock = index << (PAGE_CACHE_SHIFT - sdp->sd_sb.sb_bsize_shift);
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
+	gfs2_write_calc_reserv(ip, PAGE_CACHE_SIZE,
+			      &data_blocks, &ind_blocks);
+
+	al->al_requested = data_blocks + ind_blocks;
+
+	error = gfs2_inplace_reserve(ip);
+	if (error)
+		goto out_gunlock_q;
+
+	error = gfs2_trans_begin(sdp,
+				 al->al_rgd->rd_ri.ri_length +
+				 ind_blocks + RES_DINODE +
+				 RES_STATFS + RES_QUOTA, 0);
+	if (error)
+		goto out_ipres;
+
+	if (gfs2_is_stuffed(ip)) {
+		error = gfs2_unstuff_dinode(ip, gfs2_unstuffer_page, NULL);
+		if (error)
+			goto out_trans;
+	}
+
+	for (x = 0; x < blocks; ) {
+		uint64_t dblock;
+		unsigned int extlen;
+		int new = TRUE;
+
+		error = gfs2_block_map(ip, lblock, &new, &dblock, &extlen);
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
+	struct gfs2_inode *ip = get_v2ip(area->vm_file->f_mapping->host);
+	struct gfs2_holder i_gh;
+	struct page *result = NULL;
+	unsigned long index = ((address - area->vm_start) >> PAGE_CACHE_SHIFT) + area->vm_pgoff;
+	int alloc_required;
+	int error;
+
+	atomic_inc(&ip->i_sbd->sd_ops_vm);
+
+	error = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &i_gh);
+	if (error)
+		return NULL;
+
+	if (gfs2_is_jdata(ip))
+		goto out;
+
+	set_bit(GIF_PAGED, &ip->i_flags);
+	set_bit(GIF_SW_PAGED, &ip->i_flags);
+
+	error = gfs2_write_alloc_required(ip,
+					  (uint64_t)index << PAGE_CACHE_SHIFT,
+					  PAGE_CACHE_SIZE, &alloc_required);
+	if (error)
+		goto out;
+
+	result = filemap_nopage(area, address, type);
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
+
+ out:
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
--- a/fs/gfs2/ops_vm.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/ops_vm.h	2005-09-01 17:36:55.434097384 +0800
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
+#ifndef __OPS_VM_DOT_H__
+#define __OPS_VM_DOT_H__
+
+extern struct vm_operations_struct gfs2_vm_ops_private;
+extern struct vm_operations_struct gfs2_vm_ops_sharewrite;
+
+#endif /* __OPS_VM_DOT_H__ */
--- a/fs/gfs2/page.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/page.c	2005-09-01 17:36:55.434097384 +0800
@@ -0,0 +1,274 @@
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
+#include <linux/mm.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "inode.h"
+#include "page.h"
+#include "trans.h"
+
+/**
+ * gfs2_pte_inval - Sync and invalidate all PTEs associated with a glock
+ * @gl: the glock
+ *
+ */
+
+void gfs2_pte_inval(struct gfs2_glock *gl)
+{
+	struct gfs2_inode *ip;
+	struct inode *inode;
+
+	ip = get_gl2ip(gl);
+	if (!ip || !S_ISREG(ip->i_di.di_mode))
+		return;
+
+	if (!test_bit(GIF_PAGED, &ip->i_flags))
+		return;
+
+	inode = gfs2_ip2v_lookup(ip);
+	if (inode) {
+		unmap_shared_mapping_range(inode->i_mapping, 0, 0);
+		iput(inode);
+
+		if (test_bit(GIF_SW_PAGED, &ip->i_flags))
+			set_bit(GLF_DIRTY, &gl->gl_flags);
+	}
+
+	clear_bit(GIF_SW_PAGED, &ip->i_flags);
+}
+
+/**
+ * gfs2_page_inval - Invalidate all pages associated with a glock
+ * @gl: the glock
+ *
+ */
+
+void gfs2_page_inval(struct gfs2_glock *gl)
+{
+	struct gfs2_inode *ip;
+	struct inode *inode;
+
+	ip = get_gl2ip(gl);
+	if (!ip || !S_ISREG(ip->i_di.di_mode))
+		return;
+
+	inode = gfs2_ip2v_lookup(ip);
+	if (inode) {
+		struct address_space *mapping = inode->i_mapping;
+
+		truncate_inode_pages(mapping, 0);
+		gfs2_assert_withdraw(ip->i_sbd, !mapping->nrpages);
+
+		iput(inode);
+	}
+
+	clear_bit(GIF_PAGED, &ip->i_flags);
+}
+
+/**
+ * gfs2_page_sync - Sync the data pages (not metadata) associated with a glock
+ * @gl: the glock
+ * @flags: DIO_START | DIO_WAIT
+ *
+ * Syncs data (not metadata) for a regular file.
+ * No-op for all other types.
+ */
+
+void gfs2_page_sync(struct gfs2_glock *gl, int flags)
+{
+	struct gfs2_inode *ip;
+	struct inode *inode;
+
+	ip = get_gl2ip(gl);
+	if (!ip || !S_ISREG(ip->i_di.di_mode))
+		return;
+
+	inode = gfs2_ip2v_lookup(ip);
+	if (inode) {
+		struct address_space *mapping = inode->i_mapping;
+		int error = 0;
+
+		if (flags & DIO_START)
+			filemap_fdatawrite(mapping);
+		if (!error && (flags & DIO_WAIT))
+			error = filemap_fdatawait(mapping);
+
+		/* Put back any errors cleared by filemap_fdatawait()
+		   so they can be caught by someone who can pass them
+		   up to user space. */
+
+		if (error == -ENOSPC)
+			set_bit(AS_ENOSPC, &mapping->flags);
+		else if (error)
+			set_bit(AS_EIO, &mapping->flags);
+
+		iput(inode);
+	}
+}
+
+/**
+ * gfs2_unstuffer_page - unstuff a stuffed inode into a block cached by a page
+ * @ip: the inode
+ * @dibh: the dinode buffer
+ * @block: the block number that was allocated
+ * @private: any locked page held by the caller process
+ *
+ * Returns: errno
+ */
+
+int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
+			uint64_t block, void *private)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct inode *inode = ip->i_vnode;
+	struct page *page = (struct page *)private;
+	struct buffer_head *bh;
+	int release = FALSE;
+
+	if (!page || page->index) {
+		page = grab_cache_page(inode->i_mapping, 0);
+		if (!page)
+			return -ENOMEM;
+		release = TRUE;
+	}
+
+	if (!PageUptodate(page)) {
+		void *kaddr = kmap(page);
+
+		memcpy(kaddr,
+		       dibh->b_data + sizeof(struct gfs2_dinode),
+		       ip->i_di.di_size);
+		memset(kaddr + ip->i_di.di_size,
+		       0,
+		       PAGE_CACHE_SIZE - ip->i_di.di_size);
+		kunmap(page);
+
+		SetPageUptodate(page);
+	}
+
+	if (!page_has_buffers(page))
+		create_empty_buffers(page, 1 << inode->i_blkbits,
+				     (1 << BH_Uptodate));
+
+	bh = page_buffers(page);
+
+	if (!buffer_mapped(bh))
+		map_bh(bh, inode->i_sb, block);
+
+	set_buffer_uptodate(bh);
+	if (sdp->sd_args.ar_data == GFS2_DATA_ORDERED)
+		gfs2_trans_add_databuf(sdp, bh);
+	mark_buffer_dirty(bh);
+
+	if (release) {
+		unlock_page(page);
+		page_cache_release(page);
+	}
+
+	return 0;
+}
+
+/**
+ * gfs2_truncator_page - truncate a partial data block in the page cache
+ * @ip: the inode
+ * @size: the size the file should be
+ *
+ * Returns: errno
+ */
+
+int gfs2_truncator_page(struct gfs2_inode *ip, uint64_t size)
+{
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	struct inode *inode = ip->i_vnode;
+	struct page *page;
+	struct buffer_head *bh;
+	void *kaddr;
+	uint64_t lbn, dbn;
+	unsigned long index;
+	unsigned int offset;
+	unsigned int bufnum;
+	int new = FALSE;
+	int error;
+
+	lbn = size >> inode->i_blkbits;
+	error = gfs2_block_map(ip, lbn, &new, &dbn, NULL);
+	if (error || !dbn)
+		return error;
+
+	index = size >> PAGE_CACHE_SHIFT;
+	offset = size & (PAGE_CACHE_SIZE - 1);
+	bufnum = lbn - (index << (PAGE_CACHE_SHIFT - inode->i_blkbits));
+
+	page = read_cache_page(inode->i_mapping, index,
+			       (filler_t *)inode->i_mapping->a_ops->readpage,
+			       NULL);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	lock_page(page);
+
+	if (!PageUptodate(page) || PageError(page)) {
+		error = -EIO;
+		goto out;
+	}
+
+	kaddr = kmap(page);
+	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
+	kunmap(page);
+
+	if (!page_has_buffers(page))
+		create_empty_buffers(page, 1 << inode->i_blkbits,
+				     (1 << BH_Uptodate));
+
+	for (bh = page_buffers(page); bufnum--; bh = bh->b_this_page)
+		/* Do nothing */;
+
+	if (!buffer_mapped(bh))
+		map_bh(bh, inode->i_sb, dbn);
+
+	set_buffer_uptodate(bh);
+	if (sdp->sd_args.ar_data == GFS2_DATA_ORDERED)
+		gfs2_trans_add_databuf(sdp, bh);
+	mark_buffer_dirty(bh);
+
+ out:
+	unlock_page(page);
+	page_cache_release(page);
+
+	return error;
+}
+
+void gfs2_page_add_databufs(struct gfs2_sbd *sdp, struct page *page,
+			    unsigned int from, unsigned int to)
+{
+	struct buffer_head *head = page_buffers(page);
+	unsigned int bsize = head->b_size;
+	struct buffer_head *bh;
+	unsigned int start, end;
+
+	for (bh = head, start = 0;
+	     bh != head || !start;
+	     bh = bh->b_this_page, start = end) {
+		end = start + bsize;
+		if (end <= from || start >= to)
+			continue;
+		gfs2_trans_add_databuf(sdp, bh);
+	}
+}
+
--- a/fs/gfs2/page.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/page.h	2005-09-01 17:36:55.434097384 +0800
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __PAGE_DOT_H__
+#define __PAGE_DOT_H__
+
+void gfs2_pte_inval(struct gfs2_glock *gl);
+void gfs2_page_inval(struct gfs2_glock *gl);
+void gfs2_page_sync(struct gfs2_glock *gl, int flags);
+
+int gfs2_unstuffer_page(struct gfs2_inode *ip, struct buffer_head *dibh,
+			uint64_t block, void *private);
+int gfs2_truncator_page(struct gfs2_inode *ip, uint64_t size);
+void gfs2_page_add_databufs(struct gfs2_sbd *sdp, struct page *page,
+			    unsigned int from, unsigned int to);
+
+#endif /* __PAGE_DOT_H__ */
--- a/fs/gfs2/super.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/super.c	2005-09-01 17:36:55.494088264 +0800
@@ -0,0 +1,945 @@
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
+#include "unlinked.h"
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
+	gt->gt_inoded_secs = 15;
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
+			printk("GFS2: not a GFS2 filesystem\n");
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
+			printk("GFS2: code version (%u, %u) is incompatible "
+			       "with ondisk format (%u, %u)\n",
+			       GFS2_FORMAT_FS, GFS2_FORMAT_MULTI,
+			       sb->sb_fs_format, sb->sb_multihost_format);
+			printk("GFS2: I don't know how to upgrade this FS\n");
+			return -EINVAL;
+		}
+	}
+
+	if (sb->sb_multihost_format != GFS2_FORMAT_MULTI) {
+		for (x = 0; gfs2_old_multihost_formats[x]; x++)
+			if (gfs2_old_multihost_formats[x] == sb->sb_multihost_format)
+				break;
+
+		if (!gfs2_old_multihost_formats[x]) {
+			printk("GFS2: code version (%u, %u) is incompatible "
+			       "with ondisk format (%u, %u)\n",
+			       GFS2_FORMAT_FS, GFS2_FORMAT_MULTI,
+			       sb->sb_fs_format, sb->sb_multihost_format);
+			printk("GFS2: I don't know how to upgrade this FS\n");
+			return -EINVAL;
+		}
+	}
+
+	if (!sdp->sd_args.ar_upgrade) {
+		printk("GFS2: code version (%u, %u) is incompatible "
+		       "with ondisk format (%u, %u)\n",
+		       GFS2_FORMAT_FS, GFS2_FORMAT_MULTI,
+		       sb->sb_fs_format, sb->sb_multihost_format);
+		printk("GFS2: Use the \"upgrade\" mount option to upgrade "
+		       "the FS\n");
+		printk("GFS2: See the manual for more details\n");
+		return -EINVAL;
+	}
+
+	return 0;
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
+	struct buffer_head *bh;
+	uint32_t hash_blocks, ind_blocks, leaf_blocks;
+	uint32_t tmp_blocks;
+	unsigned int x;
+	int error;
+
+	error = gfs2_meta_read(gl, GFS2_SB_ADDR >> sdp->sd_fsb2bb_shift,
+			       DIO_FORCE | DIO_START | DIO_WAIT, &bh);
+	if (error) {
+		if (!silent)
+			fs_err(sdp, "can't read superblock\n");
+		return error;
+	}
+
+	gfs2_assert(sdp, sizeof(struct gfs2_sb) <= bh->b_size,);
+	gfs2_sb_in(&sdp->sd_sb, bh->b_data);
+	brelse(bh);
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
+	sdp->sd_ut_per_block = (sdp->sd_sb.sb_bsize -
+				sizeof(struct gfs2_meta_header)) /
+			       sizeof(struct gfs2_unlinked_tag);
+	sdp->sd_qc_per_block = (sdp->sd_sb.sb_bsize -
+				sizeof(struct gfs2_meta_header)) /
+			       sizeof(struct gfs2_quota_change);
+
+	/* Compute maximum reservation required to add a entry to a directory */
+
+	hash_blocks = DIV_RU(sizeof(uint64_t) * (1 << GFS2_DIR_MAX_DEPTH),
+			     sdp->sd_jbsize);
+
+	ind_blocks = 0;
+	for (tmp_blocks = hash_blocks; tmp_blocks > sdp->sd_diptrs;) {
+		tmp_blocks = DIV_RU(tmp_blocks, sdp->sd_inptrs);
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
+	gfs2_assert(sdp, sdp->sd_max_height <= GFS2_MAX_META_HEIGHT,);
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
+	gfs2_assert(sdp, sdp->sd_max_jheight <= GFS2_MAX_META_HEIGHT,);
+
+	return 0;
+}
+
+int gfs2_do_upgrade(struct gfs2_sbd *sdp, struct gfs2_glock *sb_gl)
+{
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
+	struct gfs2_inode *dip = sdp->sd_jindex;
+	struct qstr name;
+	char buf[20];
+	struct gfs2_jdesc *jd;
+	int error;
+
+	name.name = buf;
+
+	down(&sdp->sd_jindex_mutex);
+
+	for (;;) {
+		error = gfs2_glock_nq_init(dip->i_gl, LM_ST_SHARED,
+					   GL_LOCAL_EXCL, ji_gh);
+		if (error)
+			break;
+
+		name.len = sprintf(buf, "journal%u", sdp->sd_journals);
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
+		error = gfs2_lookupi(dip, &name, TRUE, &jd->jd_inode);
+		if (error) {
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
+	up(&sdp->sd_jindex_mutex);
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
+		gfs2_inode_put(jd->jd_inode);
+		kfree(jd);
+	}
+}
+
+static struct gfs2_jdesc *jdesc_find_i(struct list_head *head, unsigned int jid)
+{
+	struct gfs2_jdesc *jd;
+	int found = FALSE;
+
+	list_for_each_entry(jd, head, jd_list) {
+		if (jd->jd_jid == jid) {
+			found = TRUE;
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
+		jd->jd_dirty = TRUE;
+	spin_unlock(&sdp->sd_jindex_spin);
+}
+
+struct gfs2_jdesc *gfs2_jdesc_find_dirty(struct gfs2_sbd *sdp)
+{
+	struct gfs2_jdesc *jd;
+	int found = FALSE;
+
+	spin_lock(&sdp->sd_jindex_spin);
+
+	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
+		if (jd->jd_dirty) {
+			jd->jd_dirty = FALSE;
+			found = TRUE;
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
+	struct gfs2_inode *ip = jd->jd_inode;
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	int ar;
+	int error;
+
+	if (ip->i_di.di_size < (8 << 20) ||
+	    ip->i_di.di_size > (1 << 30) ||
+	    (ip->i_di.di_size & (sdp->sd_sb.sb_bsize - 1))) {
+		gfs2_consist_inode(ip);
+		return -EIO;
+	}
+	jd->jd_blocks = ip->i_di.di_size >> sdp->sd_sb.sb_bsize_shift;
+
+	error = gfs2_write_alloc_required(ip,
+					  0, ip->i_di.di_size,
+					  &ar);
+	if (!error && ar) {
+		gfs2_consist_inode(ip);
+		error = -EIO;
+	}
+
+	return error;
+}
+
+int gfs2_lookup_master_dir(struct gfs2_sbd *sdp)
+{
+	struct gfs2_glock *gl;
+	int error;
+
+	error = gfs2_glock_get(sdp,
+			       sdp->sd_sb.sb_master_dir.no_addr,
+			       &gfs2_inode_glops, CREATE, &gl);
+	if (!error) {
+		error = gfs2_inode_get(gl, &sdp->sd_sb.sb_master_dir, CREATE,
+				       &sdp->sd_master_dir);
+		gfs2_glock_put(gl);
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
+	struct gfs2_glock *j_gl = sdp->sd_jdesc->jd_inode->i_gl;
+	struct gfs2_holder t_gh;
+	struct gfs2_log_header head;
+	int error;
+
+	error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_SHARED,
+				   GL_LOCAL_EXCL | GL_NEVER_RECURSE, &t_gh);
+	if (error)
+		return error;
+
+	gfs2_meta_cache_flush(sdp->sd_jdesc->jd_inode);
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
+	error = gfs2_unlinked_init(sdp);
+	if (error)
+		goto fail;
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
+	gfs2_unlinked_cleanup(sdp);
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
+	gfs2_unlinked_dealloc(sdp);
+	gfs2_quota_sync(sdp);
+	gfs2_statfs_sync(sdp);
+
+	error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_SHARED,
+				GL_LOCAL_EXCL | GL_NEVER_RECURSE | GL_NOCACHE,
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
+	gfs2_unlinked_cleanup(sdp);
+	gfs2_quota_cleanup(sdp);
+
+	return error;
+}
+
+int gfs2_statfs_init(struct gfs2_sbd *sdp)
+{
+	struct gfs2_inode *m_ip = sdp->sd_statfs_inode;
+	struct gfs2_statfs_change *m_sc = &sdp->sd_statfs_master;
+	struct gfs2_inode *l_ip = sdp->sd_sc_inode;
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
+	struct gfs2_inode *l_ip = sdp->sd_sc_inode;
+	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct buffer_head *l_bh;
+	int error;
+
+	error = gfs2_meta_inode_buffer(l_ip, &l_bh);
+	if (error)
+		return;
+
+	down(&sdp->sd_statfs_mutex);
+	gfs2_trans_add_bh(l_ip->i_gl, l_bh);
+	up(&sdp->sd_statfs_mutex);
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
+	struct gfs2_inode *m_ip = sdp->sd_statfs_inode;
+	struct gfs2_inode *l_ip = sdp->sd_sc_inode;
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
+	down(&sdp->sd_statfs_mutex);
+	gfs2_trans_add_bh(l_ip->i_gl, l_bh);
+	up(&sdp->sd_statfs_mutex);
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
+	gfs2_trans_add_bh(m_ip->i_gl, m_bh);
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
+		done = TRUE;
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
+						error = statfs_slow_fill(get_gl2rgd(gh->gh_gl), sc);
+					gfs2_glock_dq_uninit(gh);
+				}
+			}
+
+			if (gh->gh_gl)
+				done = FALSE;
+			else if (rgd_next && !error) {
+				error = gfs2_glock_nq_init(rgd_next->rd_gl,
+							   LM_ST_SHARED,
+							   GL_ASYNC,
+							   gh);
+				rgd_next = gfs2_rgrpd_get_next(rgd_next);
+				done = FALSE;
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
+int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp, struct gfs2_holder *t_gh)
+{
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
+		error = gfs2_glock_nq_init(jd->jd_inode->i_gl, LM_ST_SHARED, 0,
+					   &lfcc->gh);
+		if (error) {
+			kfree(lfcc);
+			goto out;
+		}
+		list_add(&lfcc->list, &list);
+	}
+
+	error = gfs2_glock_nq_init(sdp->sd_trans_gl, LM_ST_DEFERRED,
+			       LM_FLAG_PRIORITY | GL_NEVER_RECURSE | GL_NOCACHE,
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
+	down(&sdp->sd_freeze_lock);
+
+	if (!sdp->sd_freeze_count++) {
+		error = gfs2_lock_fs_check_clean(sdp, &sdp->sd_freeze_gh);
+		if (error)
+			sdp->sd_freeze_count--;
+	}
+
+	up(&sdp->sd_freeze_lock);
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
+	down(&sdp->sd_freeze_lock);
+
+	if (sdp->sd_freeze_count && !--sdp->sd_freeze_count)
+		gfs2_glock_dq_uninit(&sdp->sd_freeze_gh);
+
+	up(&sdp->sd_freeze_lock);
+}
+
--- a/fs/gfs2/super.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/super.h	2005-09-01 17:36:55.494088264 +0800
@@ -0,0 +1,55 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
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
+int gfs2_do_upgrade(struct gfs2_sbd *sdp, struct gfs2_glock *gl_sb);
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
+int gfs2_lookup_master_dir(struct gfs2_sbd *sdp);
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
+int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp, struct gfs2_holder *t_gh);
+int gfs2_freeze_fs(struct gfs2_sbd *sdp);
+void gfs2_unfreeze_fs(struct gfs2_sbd *sdp);
+
+#endif /* __SUPER_DOT_H__ */
+
--- a/fs/gfs2/trans.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/trans.c	2005-09-01 17:36:55.528083096 +0800
@@ -0,0 +1,215 @@
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
+#include "glock.h"
+#include "log.h"
+#include "lops.h"
+#include "meta_io.h"
+#include "trans.h"
+
+int gfs2_trans_begin_i(struct gfs2_sbd *sdp, unsigned int blocks,
+		       unsigned int revokes, char *file, unsigned int line)
+{
+	struct gfs2_trans *tr;
+	int error;
+
+	if (gfs2_assert_warn(sdp, !get_transaction) ||
+	    gfs2_assert_warn(sdp, blocks || revokes)) {
+		fs_warn(sdp, "(%s, %u)\n", file, line);
+		return -EINVAL;
+	}
+
+	tr = kzalloc(sizeof(struct gfs2_trans), GFP_KERNEL);
+	if (!tr)
+		return -ENOMEM;
+
+	tr->tr_file = file;
+	tr->tr_line = line;
+	tr->tr_blocks = blocks;
+	tr->tr_revokes = revokes;
+	tr->tr_reserved = 1;
+	if (blocks)
+		tr->tr_reserved += 1 + blocks;
+	if (revokes)
+		tr->tr_reserved += gfs2_struct2blk(sdp, revokes,
+						   sizeof(uint64_t));
+	INIT_LIST_HEAD(&tr->tr_list_buf);
+
+	error = -ENOMEM;
+	tr->tr_t_gh = gfs2_holder_get(sdp->sd_trans_gl, LM_ST_SHARED,
+				      GL_NEVER_RECURSE, 0);
+	if (!tr->tr_t_gh)
+		goto fail;
+
+	error = gfs2_glock_nq(tr->tr_t_gh);
+	if (error)
+		goto fail_holder_put;
+
+	if (!test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		tr->tr_t_gh->gh_flags |= GL_NOCACHE;
+		error = -EROFS;
+		goto fail_gunlock;
+	}
+
+	error = gfs2_log_reserve(sdp, tr->tr_reserved);
+	if (error)
+		goto fail_gunlock;
+
+	set_transaction(tr);
+
+	return 0;
+
+ fail_gunlock:
+	gfs2_glock_dq(tr->tr_t_gh);
+
+ fail_holder_put:
+	gfs2_holder_put(tr->tr_t_gh);
+
+ fail:
+	kfree(tr);
+
+	return error;
+}
+
+void gfs2_trans_end(struct gfs2_sbd *sdp)
+{
+	struct gfs2_trans *tr;
+	struct gfs2_holder *t_gh;
+
+	tr = get_transaction;
+	set_transaction(NULL);
+
+	if (gfs2_assert_warn(sdp, tr))
+		return;
+
+	t_gh = tr->tr_t_gh;
+	tr->tr_t_gh = NULL;
+
+	if (!tr->tr_touched) {
+		gfs2_log_release(sdp, tr->tr_reserved);
+		kfree(tr);
+
+		gfs2_glock_dq(t_gh);
+		gfs2_holder_put(t_gh);
+
+		return;
+	}
+
+	if (gfs2_assert_withdraw(sdp, tr->tr_num_buf <= tr->tr_blocks))
+		fs_err(sdp, "tr_num_buf = %u, tr_blocks = %u "
+		       "tr_file = %s, tr_line = %u\n",
+		       tr->tr_num_buf, tr->tr_blocks,
+		       tr->tr_file, tr->tr_line);
+	if (gfs2_assert_withdraw(sdp, tr->tr_num_revoke <= tr->tr_revokes))
+		fs_err(sdp, "tr_num_revoke = %u, tr_revokes = %u "
+		       "tr_file = %s, tr_line = %u\n",
+		       tr->tr_num_revoke, tr->tr_revokes,
+		       tr->tr_file, tr->tr_line);
+
+	gfs2_log_commit(sdp, tr);
+
+	gfs2_glock_dq(t_gh);
+	gfs2_holder_put(t_gh);
+
+	if (sdp->sd_vfs->s_flags & MS_SYNCHRONOUS)
+		gfs2_log_flush(sdp);
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
+ *
+ */
+
+void gfs2_trans_add_bh(struct gfs2_glock *gl, struct buffer_head *bh)
+{
+	struct gfs2_sbd *sdp = gl->gl_sbd;
+	struct gfs2_bufdata *bd;
+
+	bd = get_v2bd(bh);
+	if (bd)
+		gfs2_assert(sdp, bd->bd_gl == gl,);
+	else {
+		gfs2_meta_attach_bufdata(gl, bh);
+		bd = get_v2bd(bh);
+	}
+
+	lops_add(sdp, &bd->bd_le);
+}
+
+void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, uint64_t blkno)
+{
+	struct gfs2_revoke *rv = kmalloc(sizeof(struct gfs2_revoke),
+					 GFP_KERNEL | __GFP_NOFAIL);
+	lops_init_le(&rv->rv_le, &gfs2_revoke_lops);
+	rv->rv_blkno = blkno;
+	lops_add(sdp, &rv->rv_le);
+}
+
+void gfs2_trans_add_unrevoke(struct gfs2_sbd *sdp, uint64_t blkno)
+{
+	struct gfs2_revoke *rv;
+	int found = FALSE;
+
+	gfs2_log_lock(sdp);
+
+	list_for_each_entry(rv, &sdp->sd_log_le_revoke, rv_le.le_list) {
+		if (rv->rv_blkno == blkno) {
+			list_del(&rv->rv_le.le_list);
+			gfs2_assert_withdraw(sdp, sdp->sd_log_num_revoke);
+			sdp->sd_log_num_revoke--;
+			found = TRUE;
+			break;
+		}
+	}
+
+	gfs2_log_unlock(sdp);
+
+	if (found) {
+		kfree(rv);
+		get_transaction->tr_num_revoke_rm++;
+	}
+}
+
+void gfs2_trans_add_rg(struct gfs2_rgrpd *rgd)
+{
+	lops_add(rgd->rd_sbd, &rgd->rd_le);
+}
+
+void gfs2_trans_add_databuf(struct gfs2_sbd *sdp, struct buffer_head *bh)
+{
+	struct gfs2_databuf *db;
+
+	db = get_v2db(bh);
+	if (!db) {
+		db = kmalloc(sizeof(struct gfs2_databuf),
+			     GFP_KERNEL | __GFP_NOFAIL);
+		lops_init_le(&db->db_le, &gfs2_databuf_lops);
+		get_bh(bh);
+		db->db_bh = bh;
+		set_v2db(bh, db);
+		lops_add(sdp, &db->db_le);
+	}
+}
+
--- a/fs/gfs2/trans.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/trans.h	2005-09-01 17:36:55.538081576 +0800
@@ -0,0 +1,40 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
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
+#define RES_UNLINKED	1
+#define RES_STATFS	1
+#define RES_QUOTA	2
+
+#define gfs2_trans_begin(sdp, blocks, revokes) \
+gfs2_trans_begin_i((sdp), (blocks), (revokes), __FILE__, __LINE__)
+
+int gfs2_trans_begin_i(struct gfs2_sbd *sdp,
+		      unsigned int blocks, unsigned int revokes,
+		      char *file, unsigned int line);
+
+void gfs2_trans_end(struct gfs2_sbd *sdp);
+
+void gfs2_trans_add_gl(struct gfs2_glock *gl);
+void gfs2_trans_add_bh(struct gfs2_glock *gl, struct buffer_head *bh);
+void gfs2_trans_add_revoke(struct gfs2_sbd *sdp, uint64_t blkno);
+void gfs2_trans_add_unrevoke(struct gfs2_sbd *sdp, uint64_t blkno);
+void gfs2_trans_add_rg(struct gfs2_rgrpd *rgd);
+void gfs2_trans_add_databuf(struct gfs2_sbd *sdp, struct buffer_head *bh);
+
+#endif /* __TRANS_DOT_H__ */
--- a/fs/gfs2/unlinked.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/unlinked.c	2005-09-01 17:36:55.557078688 +0800
@@ -0,0 +1,454 @@
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
+#include <linux/kthread.h>
+#include <asm/semaphore.h>
+
+#include "gfs2.h"
+#include "bmap.h"
+#include "inode.h"
+#include "meta_io.h"
+#include "trans.h"
+#include "unlinked.h"
+
+static int munge_ondisk(struct gfs2_sbd *sdp, unsigned int slot,
+			struct gfs2_unlinked_tag *ut)
+{
+	struct gfs2_inode *ip = sdp->sd_ut_inode;
+	unsigned int block, offset;
+	uint64_t dblock;
+	int new = FALSE;
+	struct buffer_head *bh;
+	int error;
+
+	block = slot / sdp->sd_ut_per_block;
+	offset = slot % sdp->sd_ut_per_block;
+
+	error = gfs2_block_map(ip, block, &new, &dblock, NULL);
+	if (error)
+		return error;
+	error = gfs2_meta_read(ip->i_gl, dblock, DIO_START | DIO_WAIT, &bh);
+	if (error)
+		return error;
+	if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_UT)) {
+		error = -EIO;
+		goto out;
+	}
+
+	down(&sdp->sd_unlinked_mutex);
+	gfs2_trans_add_bh(ip->i_gl, bh);
+	gfs2_unlinked_tag_out(ut, bh->b_data +
+				  sizeof(struct gfs2_meta_header) +
+				  offset * sizeof(struct gfs2_unlinked_tag));
+	up(&sdp->sd_unlinked_mutex);
+
+ out:
+	brelse(bh);
+
+	return error;
+}
+
+static void ul_hash(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	spin_lock(&sdp->sd_unlinked_spin);
+	list_add(&ul->ul_list, &sdp->sd_unlinked_list);
+	gfs2_assert(sdp, ul->ul_count,);
+	ul->ul_count++;
+	atomic_inc(&sdp->sd_unlinked_count);
+	spin_unlock(&sdp->sd_unlinked_spin);
+}
+
+static void ul_unhash(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	spin_lock(&sdp->sd_unlinked_spin);
+	list_del_init(&ul->ul_list);
+	gfs2_assert(sdp, ul->ul_count > 1,);
+	ul->ul_count--;
+	gfs2_assert_warn(sdp, atomic_read(&sdp->sd_unlinked_count) > 0);
+	atomic_dec(&sdp->sd_unlinked_count);
+	spin_unlock(&sdp->sd_unlinked_spin);
+}
+
+static struct gfs2_unlinked *ul_fish(struct gfs2_sbd *sdp)
+{
+	struct list_head *head;
+	struct gfs2_unlinked *ul;
+	int found = FALSE;
+
+	if (sdp->sd_vfs->s_flags & MS_RDONLY)
+		return NULL;
+
+	spin_lock(&sdp->sd_unlinked_spin);
+
+	head = &sdp->sd_unlinked_list;
+
+	list_for_each_entry(ul, head, ul_list) {
+		if (test_bit(ULF_LOCKED, &ul->ul_flags))
+			continue;
+
+		list_move_tail(&ul->ul_list, head);
+		ul->ul_count++;
+		set_bit(ULF_LOCKED, &ul->ul_flags);
+		found = TRUE;
+
+		break;
+	}
+
+	if (!found)
+		ul = NULL;
+
+	spin_unlock(&sdp->sd_unlinked_spin);
+
+	return ul;
+}
+
+/**
+ * enforce_limit - limit the number of inodes waiting to be deallocated
+ * @sdp: the filesystem
+ *
+ * Returns: errno
+ */
+
+static void enforce_limit(struct gfs2_sbd *sdp)
+{
+	unsigned int tries = 0, min = 0;
+	int error;
+
+	if (atomic_read(&sdp->sd_unlinked_count) >=
+	    gfs2_tune_get(sdp, gt_ilimit)) {
+		tries = gfs2_tune_get(sdp, gt_ilimit_tries);
+		min = gfs2_tune_get(sdp, gt_ilimit_min);
+	}
+
+	while (tries--) {
+		struct gfs2_unlinked *ul = ul_fish(sdp);
+		if (!ul)
+			break;
+		error = gfs2_inode_dealloc(sdp, ul);
+		gfs2_unlinked_put(sdp, ul);
+
+		if (!error) {
+			if (!--min)
+				break;
+		} else if (error != 1)
+			break;
+	}
+}
+
+static struct gfs2_unlinked *ul_alloc(struct gfs2_sbd *sdp)
+{
+	struct gfs2_unlinked *ul;
+
+	ul = kzalloc(sizeof(struct gfs2_unlinked), GFP_KERNEL);
+	if (ul) {
+		INIT_LIST_HEAD(&ul->ul_list);
+		ul->ul_count = 1;
+		set_bit(ULF_LOCKED, &ul->ul_flags);
+	}
+
+	return ul;
+}
+
+int gfs2_unlinked_get(struct gfs2_sbd *sdp, struct gfs2_unlinked **ul)
+{
+	unsigned int c, o = 0, b;
+	unsigned char byte = 0;
+
+	enforce_limit(sdp);
+
+	*ul = ul_alloc(sdp);
+	if (!*ul)
+		return -ENOMEM;
+
+	spin_lock(&sdp->sd_unlinked_spin);
+
+	for (c = 0; c < sdp->sd_unlinked_chunks; c++)
+		for (o = 0; o < PAGE_SIZE; o++) {
+			byte = sdp->sd_unlinked_bitmap[c][o];
+			if (byte != 0xFF)
+				goto found;
+		}
+
+	goto fail;
+
+ found:
+	for (b = 0; b < 8; b++)
+		if (!(byte & (1 << b)))
+			break;
+	(*ul)->ul_slot = c * (8 * PAGE_SIZE) + o * 8 + b;
+
+	if ((*ul)->ul_slot >= sdp->sd_unlinked_slots)
+		goto fail;
+
+	sdp->sd_unlinked_bitmap[c][o] |= 1 << b;
+
+	spin_unlock(&sdp->sd_unlinked_spin);
+
+	return 0;
+
+ fail:
+	spin_unlock(&sdp->sd_unlinked_spin);
+	kfree(*ul);
+	return -ENOSPC;
+}
+
+void gfs2_unlinked_put(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	gfs2_assert_warn(sdp, test_and_clear_bit(ULF_LOCKED, &ul->ul_flags));
+
+	spin_lock(&sdp->sd_unlinked_spin);
+	gfs2_assert(sdp, ul->ul_count,);
+	ul->ul_count--;
+	if (!ul->ul_count) {
+		gfs2_icbit_munge(sdp, sdp->sd_unlinked_bitmap, ul->ul_slot, 0);
+		spin_unlock(&sdp->sd_unlinked_spin);
+		kfree(ul);
+	} else
+		spin_unlock(&sdp->sd_unlinked_spin);
+}
+
+int gfs2_unlinked_ondisk_add(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	int error;
+
+	gfs2_assert_warn(sdp, test_bit(ULF_LOCKED, &ul->ul_flags));
+	gfs2_assert_warn(sdp, list_empty(&ul->ul_list));
+
+	error = munge_ondisk(sdp, ul->ul_slot, &ul->ul_ut);
+	if (!error)
+		ul_hash(sdp, ul);
+
+	return error;
+}
+
+int gfs2_unlinked_ondisk_munge(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	int error;
+
+	gfs2_assert_warn(sdp, test_bit(ULF_LOCKED, &ul->ul_flags));
+	gfs2_assert_warn(sdp, !list_empty(&ul->ul_list));
+
+	error = munge_ondisk(sdp, ul->ul_slot, &ul->ul_ut);
+
+	return error;
+}
+
+int gfs2_unlinked_ondisk_rm(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul)
+{
+	struct gfs2_unlinked_tag ut;
+	int error;
+
+	gfs2_assert_warn(sdp, test_bit(ULF_LOCKED, &ul->ul_flags));
+	gfs2_assert_warn(sdp, !list_empty(&ul->ul_list));
+
+	memset(&ut, 0, sizeof(struct gfs2_unlinked_tag));
+
+	error = munge_ondisk(sdp, ul->ul_slot, &ut);
+	if (error)
+		return error;
+
+	ul_unhash(sdp, ul);
+
+	return 0;
+}
+
+/**
+ * gfs2_unlinked_dealloc - Go through the list of inodes to be deallocated
+ * @sdp: the filesystem
+ *
+ * Returns: errno
+ */
+
+int gfs2_unlinked_dealloc(struct gfs2_sbd *sdp)
+{
+	unsigned int hits, strikes;
+	int error;
+
+	for (;;) {
+		hits = 0;
+		strikes = 0;
+
+		for (;;) {
+			struct gfs2_unlinked *ul = ul_fish(sdp);
+			if (!ul)
+				return 0;
+			error = gfs2_inode_dealloc(sdp, ul);
+			gfs2_unlinked_put(sdp, ul);
+
+			if (!error) {
+				hits++;
+				if (strikes)
+					strikes--;
+			} else if (error == 1) {
+				strikes++;
+				if (strikes >=
+				    atomic_read(&sdp->sd_unlinked_count)) {
+					error = 0;
+					break;
+				}
+			} else
+				return error;
+		}
+
+		if (!hits || kthread_should_stop())
+			break;
+
+		cond_resched();
+	}
+
+	return 0;
+}
+
+int gfs2_unlinked_init(struct gfs2_sbd *sdp)
+{
+	struct gfs2_inode *ip = sdp->sd_ut_inode;
+	unsigned int blocks = ip->i_di.di_size >> sdp->sd_sb.sb_bsize_shift;
+	unsigned int x, slot = 0;
+	unsigned int found = 0;
+	uint64_t dblock;
+	uint32_t extlen = 0;
+	int error;
+
+	if (!ip->i_di.di_size ||
+	    ip->i_di.di_size > (64 << 20) ||
+	    ip->i_di.di_size & (sdp->sd_sb.sb_bsize - 1)) {
+		gfs2_consist_inode(ip);
+		return -EIO;		
+	}
+	sdp->sd_unlinked_slots = blocks * sdp->sd_ut_per_block;
+	sdp->sd_unlinked_chunks = DIV_RU(sdp->sd_unlinked_slots, 8 * PAGE_SIZE);
+
+	error = -ENOMEM;
+
+	sdp->sd_unlinked_bitmap = kcalloc(sdp->sd_unlinked_chunks,
+					  sizeof(unsigned char *),
+					  GFP_KERNEL);
+	if (!sdp->sd_unlinked_bitmap)
+		return error;
+
+	for (x = 0; x < sdp->sd_unlinked_chunks; x++) {
+		sdp->sd_unlinked_bitmap[x] = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!sdp->sd_unlinked_bitmap[x])
+			goto fail;
+	}
+
+	for (x = 0; x < blocks; x++) {
+		struct buffer_head *bh;
+		unsigned int y;
+
+		if (!extlen) {
+			int new = FALSE;
+			error = gfs2_block_map(ip, x, &new, &dblock, &extlen);
+			if (error)
+				goto fail;
+		}
+		gfs2_meta_ra(ip->i_gl, dblock, extlen);
+		error = gfs2_meta_read(ip->i_gl, dblock, DIO_START | DIO_WAIT,
+				       &bh);
+		if (error)
+			goto fail;
+		error = -EIO;
+		if (gfs2_metatype_check(sdp, bh, GFS2_METATYPE_UT)) {
+			brelse(bh);
+			goto fail;
+		}
+
+		for (y = 0;
+		     y < sdp->sd_ut_per_block && slot < sdp->sd_unlinked_slots;
+		     y++, slot++) {
+			struct gfs2_unlinked_tag ut;
+			struct gfs2_unlinked *ul;
+
+			gfs2_unlinked_tag_in(&ut, bh->b_data +
+					  sizeof(struct gfs2_meta_header) +
+					  y * sizeof(struct gfs2_unlinked_tag));
+			if (!ut.ut_inum.no_addr)
+				continue;
+
+			error = -ENOMEM;
+			ul = ul_alloc(sdp);
+			if (!ul) {
+				brelse(bh);
+				goto fail;
+			}
+			ul->ul_ut = ut;
+			ul->ul_slot = slot;
+
+			spin_lock(&sdp->sd_unlinked_spin);
+			gfs2_icbit_munge(sdp, sdp->sd_unlinked_bitmap, slot, 1);
+			spin_unlock(&sdp->sd_unlinked_spin);
+			ul_hash(sdp, ul);
+
+			gfs2_unlinked_put(sdp, ul);
+			found++;
+		}
+
+		brelse(bh);
+		dblock++;
+		extlen--;
+	}
+
+	if (found)
+		fs_info(sdp, "found %u unlinked inodes\n", found);
+
+	return 0;
+
+ fail:
+	gfs2_unlinked_cleanup(sdp);
+	return error;
+}
+
+/**
+ * gfs2_unlinked_cleanup - get rid of any extra struct gfs2_unlinked structures
+ * @sdp: the filesystem
+ *
+ */
+
+void gfs2_unlinked_cleanup(struct gfs2_sbd *sdp)
+{
+	struct list_head *head = &sdp->sd_unlinked_list;
+	struct gfs2_unlinked *ul;
+	unsigned int x;
+
+	spin_lock(&sdp->sd_unlinked_spin);
+	while (!list_empty(head)) {
+		ul = list_entry(head->next, struct gfs2_unlinked, ul_list);
+
+		if (ul->ul_count > 1) {
+			list_move_tail(&ul->ul_list, head);
+			spin_unlock(&sdp->sd_unlinked_spin);
+			schedule();
+			spin_lock(&sdp->sd_unlinked_spin);
+			continue;
+		}
+
+		list_del_init(&ul->ul_list);
+		atomic_dec(&sdp->sd_unlinked_count);
+
+		gfs2_assert_warn(sdp, ul->ul_count == 1);
+		gfs2_assert_warn(sdp, !test_bit(ULF_LOCKED, &ul->ul_flags));
+		kfree(ul);
+	}
+	spin_unlock(&sdp->sd_unlinked_spin);
+
+	gfs2_assert_warn(sdp, !atomic_read(&sdp->sd_unlinked_count));
+
+	if (sdp->sd_unlinked_bitmap) {
+		for (x = 0; x < sdp->sd_unlinked_chunks; x++)
+			kfree(sdp->sd_unlinked_bitmap[x]);
+		kfree(sdp->sd_unlinked_bitmap);
+	}
+}
+
--- a/fs/gfs2/unlinked.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/unlinked.h	2005-09-01 17:36:55.558078536 +0800
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __UNLINKED_DOT_H__
+#define __UNLINKED_DOT_H__
+
+int gfs2_unlinked_get(struct gfs2_sbd *sdp, struct gfs2_unlinked **ul);
+void gfs2_unlinked_put(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul);
+
+int gfs2_unlinked_ondisk_add(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul);
+int gfs2_unlinked_ondisk_munge(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul);
+int gfs2_unlinked_ondisk_rm(struct gfs2_sbd *sdp, struct gfs2_unlinked *ul);
+
+int gfs2_unlinked_dealloc(struct gfs2_sbd *sdp);
+
+int gfs2_unlinked_init(struct gfs2_sbd *sdp);
+void gfs2_unlinked_cleanup(struct gfs2_sbd *sdp);
+
+#endif /* __UNLINKED_DOT_H__ */
--- a/fs/gfs2/util.c	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/util.c	2005-09-01 17:36:55.566077320 +0800
@@ -0,0 +1,355 @@
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
+#include <linux/crc32.h>
+#include <asm/semaphore.h>
+#include <asm/uaccess.h>
+
+#include "gfs2.h"
+#include "glock.h"
+#include "lm.h"
+
+kmem_cache_t *gfs2_glock_cachep;
+kmem_cache_t *gfs2_inode_cachep;
+kmem_cache_t *gfs2_bufdata_cachep;
+
+uint32_t gfs2_disk_hash(const char *data, int len)
+{
+	return crc32_le(0xFFFFFFFF, data, len) ^ 0xFFFFFFFF;
+}
+
+/**
+ * gfs2_assert_i - Cause the machine to panic if @assertion is false
+ *
+ */
+
+void gfs2_assert_i(struct gfs2_sbd *sdp, char *assertion, const char *function,
+		   char *file, unsigned int line)
+{
+	if (sdp->sd_args.ar_oopses_ok) {
+		printk(KERN_ERR
+		       "GFS2: fsid=%s: fatal: assertion \"%s\" failed\n"
+		       "GFS2: fsid=%s:   function = %s\n"
+		       "GFS2: fsid=%s:   file = %s, line = %u\n"
+		       "GFS2: fsid=%s:   time = %lu\n",
+		       sdp->sd_fsname, assertion,
+		       sdp->sd_fsname, function,
+		       sdp->sd_fsname, file, line,
+		       sdp->sd_fsname, get_seconds());
+		BUG();
+	}
+	dump_stack();
+	panic("GFS2: fsid=%s: fatal: assertion \"%s\" failed\n"
+	      "GFS2: fsid=%s:   function = %s\n"
+	      "GFS2: fsid=%s:   file = %s, line = %u\n"
+	      "GFS2: fsid=%s:   time = %lu\n",
+	      sdp->sd_fsname, assertion,
+	      sdp->sd_fsname, function,
+	      sdp->sd_fsname, file, line,
+	      sdp->sd_fsname, get_seconds());
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
+			     "GFS2: fsid=%s: fatal: assertion \"%s\" failed\n"
+			     "GFS2: fsid=%s:   function = %s\n"
+			     "GFS2: fsid=%s:   file = %s, line = %u\n"
+			     "GFS2: fsid=%s:   time = %lu\n",
+			     sdp->sd_fsname, assertion,
+			     sdp->sd_fsname, function,
+			     sdp->sd_fsname, file, line,
+			     sdp->sd_fsname, get_seconds());
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
+	       "GFS2: fsid=%s:   function = %s\n"
+	       "GFS2: fsid=%s:   file = %s, line = %u\n"
+	       "GFS2: fsid=%s:   time = %lu\n",
+	       sdp->sd_fsname, assertion,
+	       sdp->sd_fsname, function,
+	       sdp->sd_fsname, file, line,
+	       sdp->sd_fsname, get_seconds());
+
+	if (sdp->sd_args.ar_debug)
+		BUG();
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
+	return gfs2_lm_withdraw(sdp,
+			"GFS2: fsid=%s: fatal: filesystem consistency error\n"
+			"GFS2: fsid=%s:   function = %s\n"
+			"GFS2: fsid=%s:   file = %s, line = %u\n"
+			"GFS2: fsid=%s:   time = %lu\n",
+			sdp->sd_fsname,
+			sdp->sd_fsname, function,
+			sdp->sd_fsname, file, line,
+			sdp->sd_fsname, get_seconds());
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
+	struct gfs2_sbd *sdp = ip->i_sbd;
+	return gfs2_lm_withdraw(sdp,
+			"GFS2: fsid=%s: fatal: filesystem consistency error\n"
+			"GFS2: fsid=%s:   inode = %"PRIu64"/%"PRIu64"\n"
+			"GFS2: fsid=%s:   function = %s\n"
+			"GFS2: fsid=%s:   file = %s, line = %u\n"
+			"GFS2: fsid=%s:   time = %lu\n",
+			sdp->sd_fsname,
+			sdp->sd_fsname,
+			ip->i_num.no_formal_ino, ip->i_num.no_addr,
+			sdp->sd_fsname, function,
+			sdp->sd_fsname, file, line,
+			sdp->sd_fsname, get_seconds());
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
+	return gfs2_lm_withdraw(sdp,
+			"GFS2: fsid=%s: fatal: filesystem consistency error\n"
+			"GFS2: fsid=%s:   RG = %"PRIu64"\n"
+			"GFS2: fsid=%s:   function = %s\n"
+			"GFS2: fsid=%s:   file = %s, line = %u\n"
+			"GFS2: fsid=%s:   time = %lu\n",
+			sdp->sd_fsname,
+			sdp->sd_fsname, rgd->rd_ri.ri_addr,
+			sdp->sd_fsname, function,
+			sdp->sd_fsname, file, line,
+			sdp->sd_fsname, get_seconds());
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
+			     "GFS2: fsid=%s: fatal: invalid metadata block\n"
+			     "GFS2: fsid=%s:   bh = %"PRIu64" (%s)\n"
+			     "GFS2: fsid=%s:   function = %s\n"
+			     "GFS2: fsid=%s:   file = %s, line = %u\n"
+			     "GFS2: fsid=%s:   time = %lu\n",
+			     sdp->sd_fsname,
+			     sdp->sd_fsname, (uint64_t)bh->b_blocknr, type,
+			     sdp->sd_fsname, function,
+			     sdp->sd_fsname, file, line,
+			     sdp->sd_fsname, get_seconds());
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
+		"GFS2: fsid=%s:   bh = %"PRIu64" (type: exp=%u, found=%u)\n"
+		"GFS2: fsid=%s:   function = %s\n"
+		"GFS2: fsid=%s:   file = %s, line = %u\n"
+		"GFS2: fsid=%s:   time = %lu\n",
+		sdp->sd_fsname,
+		sdp->sd_fsname, (uint64_t)bh->b_blocknr, type, t,
+		sdp->sd_fsname, function,
+		sdp->sd_fsname, file, line,
+		sdp->sd_fsname, get_seconds());
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
+	return gfs2_lm_withdraw(sdp,
+			       "GFS2: fsid=%s: fatal: I/O error\n"
+			       "GFS2: fsid=%s:   function = %s\n"
+			       "GFS2: fsid=%s:   file = %s, line = %u\n"
+			       "GFS2: fsid=%s:   time = %lu\n",
+			       sdp->sd_fsname,
+			       sdp->sd_fsname, function,
+			       sdp->sd_fsname, file, line,
+			       sdp->sd_fsname, get_seconds());
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
+	return gfs2_lm_withdraw(sdp,
+			       "GFS2: fsid=%s: fatal: I/O error\n"
+			       "GFS2: fsid=%s:   block = %"PRIu64"\n"
+			       "GFS2: fsid=%s:   function = %s\n"
+			       "GFS2: fsid=%s:   file = %s, line = %u\n"
+			       "GFS2: fsid=%s:   time = %lu\n",
+			       sdp->sd_fsname,
+			       sdp->sd_fsname, (uint64_t)bh->b_blocknr,
+			       sdp->sd_fsname, function,
+			       sdp->sd_fsname, file, line,
+			       sdp->sd_fsname, get_seconds());
+}
+
+/**
+ * gfs2_add_bh_to_ub - copy a buffer up to user space
+ * @ub: the structure representing where to copy
+ * @bh: the buffer
+ *
+ * Returns: errno
+ */
+
+int gfs2_add_bh_to_ub(struct gfs2_user_buffer *ub, struct buffer_head *bh)
+{
+	uint64_t blkno = bh->b_blocknr;
+
+	if (ub->ub_count + sizeof(uint64_t) + bh->b_size > ub->ub_size)
+		return -ENOMEM;
+
+	if (copy_to_user(ub->ub_data + ub->ub_count,
+			  &blkno,
+			  sizeof(uint64_t)))
+		return -EFAULT;
+	ub->ub_count += sizeof(uint64_t);
+
+	if (copy_to_user(ub->ub_data + ub->ub_count,
+			  bh->b_data,
+			  bh->b_size))
+		return -EFAULT;
+	ub->ub_count += bh->b_size;
+
+	return 0;
+}
+
+int gfs2_printf_i(char *buf, unsigned int size, unsigned int *count,
+		  char *fmt, ...)
+{
+	va_list args;
+	int left, out;
+
+	if (!buf) {
+		va_start(args, fmt);
+		vprintk(fmt, args);
+		va_end(args);
+		return 0;
+	}
+
+	left = size - *count;
+	if (left <= 0)
+		return 1;
+
+	va_start(args, fmt);
+	out = vsnprintf(buf + *count, left, fmt, args);
+	va_end(args);
+
+	if (out < left)
+		*count += out;
+	else
+		return 1;
+
+	return 0;
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
--- a/fs/gfs2/util.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/util.h	2005-09-01 17:36:55.566077320 +0800
@@ -0,0 +1,201 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __UTIL_DOT_H__
+#define __UTIL_DOT_H__
+
+uint32_t gfs2_disk_hash(const char *data, int len);
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
+void gfs2_assert_i(struct gfs2_sbd *sdp, char *assertion, const char *function,
+		   char *file, unsigned int line) __attribute__ ((noreturn));
+
+#define gfs2_assert(sdp, assertion, todo) \
+do { \
+	if (unlikely(!(assertion))) { \
+		{todo} \
+		gfs2_assert_i((sdp), #assertion, \
+			      __FUNCTION__, __FILE__, __LINE__); \
+	} \
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
+gfs2_consist_i((sdp), FALSE, __FUNCTION__, __FILE__, __LINE__)
+
+
+int gfs2_consist_inode_i(struct gfs2_inode *ip, int cluster_wide,
+			 const char *function, char *file, unsigned int line);
+
+#define gfs2_consist_inode(ip) \
+gfs2_consist_inode_i((ip), FALSE, __FUNCTION__, __FILE__, __LINE__)
+
+
+int gfs2_consist_rgrpd_i(struct gfs2_rgrpd *rgd, int cluster_wide,
+			 const char *function, char *file, unsigned int line);
+
+#define gfs2_consist_rgrpd(rgd) \
+gfs2_consist_rgrpd_i((rgd), FALSE, __FUNCTION__, __FILE__, __LINE__)
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
+	uint64_t blkno = mh->mh_blkno;
+	magic = gfs2_32_to_cpu(magic);
+	blkno = gfs2_64_to_cpu(blkno);
+	if (unlikely(magic != GFS2_MAGIC))
+		return gfs2_meta_check_ii(sdp, bh, "magic number", function,
+					  file, line);
+	if (unlikely(blkno != bh->b_blocknr))
+		return gfs2_meta_check_ii(sdp, bh, "block number", function,
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
+	uint16_t t = mh->mh_type;
+	uint64_t blkno = mh->mh_blkno;
+	magic = gfs2_32_to_cpu(magic);
+	blkno = gfs2_64_to_cpu(blkno);
+	if (unlikely(magic != GFS2_MAGIC))
+		return gfs2_meta_check_ii(sdp, bh, "magic number", function,
+					  file, line);
+	if (unlikely(blkno != bh->b_blocknr))
+		return gfs2_meta_check_ii(sdp, bh, "block number", function,
+					  file, line);
+	t = gfs2_16_to_cpu(t);
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
+	mh->mh_type = cpu_to_gfs2_16(type);
+	mh->mh_format = cpu_to_gfs2_16(format);
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
+struct gfs2_user_buffer {
+	char __user *ub_data;
+	unsigned int ub_size;
+	unsigned int ub_count;
+};
+
+int gfs2_add_bh_to_ub(struct gfs2_user_buffer *ub, struct buffer_head *bh);
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
+int gfs2_printf_i(char *buf, unsigned int size, unsigned int *count,
+		  char *fmt, ...) __attribute__ ((format(printf, 4, 5)));
+
+#define gfs2_printf(fmt, args...) \
+do { \
+	if (gfs2_printf_i(buf, size, count, fmt, ##args)) \
+		goto out; \
+} while(0)
+
+void gfs2_icbit_munge(struct gfs2_sbd *sdp, unsigned char **bitmap,
+		      unsigned int bit, int new_value);
+
+#endif /* __UTIL_DOT_H__ */
+
