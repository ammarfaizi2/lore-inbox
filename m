Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWBXOsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWBXOsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWBXOsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:48:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27369 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932200AbWBXOsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:48:17 -0500
Subject: GFS2 Filesystem [1/16]
From: Steven Whitehouse <swhiteho@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Fri, 24 Feb 2006 14:52:25 +0000
Message-Id: <1140792745.6400.710.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 01/16] GFS2: 

The header files for the core of GFS2.



Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>


 fs/gfs2/gfs2.h              |   60 +++
 fs/gfs2/incore.h            |  682 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/gfs2_ioctl.h  |   17 +
 include/linux/gfs2_ondisk.h |  454 +++++++++++++++++++++++++++++
 4 files changed, 1213 insertions(+)

--- /dev/null
+++ b/fs/gfs2/gfs2.h
@@ -0,0 +1,60 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __GFS2_DOT_H__
+#define __GFS2_DOT_H__
+
+#include <linux/gfs2_ondisk.h>
+
+#include "lm_interface.h"
+#include "lvb.h"
+#include "incore.h"
+#include "util.h"
+
+enum {
+	NO_CREATE = 0,
+	CREATE = 1,
+};
+
+enum {
+	NO_WAIT = 0,
+	WAIT = 1,
+};
+
+enum {
+	NO_FORCE = 0,
+	FORCE = 1,
+};
+
+/*  Divide num by den.  Round up if there is a remainder.  */
+#define DIV_RU(num, den) (((num) + (den) - 1) / (den))
+
+#define GFS2_FAST_NAME_SIZE 8
+
+#define get_v2sdp(sb) ((struct gfs2_sbd *)(sb)->s_fs_info)
+#define set_v2sdp(sb, sdp) (sb)->s_fs_info = (sdp)
+#define get_v2ip(inode) ((struct gfs2_inode *)(inode)->u.generic_ip)
+#define set_v2ip(inode, ip) (inode)->u.generic_ip = (ip)
+#define get_v2fp(file) ((struct gfs2_file *)(file)->private_data)
+#define set_v2fp(file, fp) (file)->private_data = (fp)
+#define get_v2bd(bh) ((struct gfs2_bufdata *)(bh)->b_private)
+#define set_v2bd(bh, bd) (bh)->b_private = (bd)
+
+#define get_transaction ((struct gfs2_trans *)(current->journal_info))
+#define set_transaction(tr) (current->journal_info) = (tr)
+
+#define get_gl2ip(gl) ((struct gfs2_inode *)(gl)->gl_object)
+#define set_gl2ip(gl, ip) (gl)->gl_object = (ip)
+#define get_gl2rgd(gl) ((struct gfs2_rgrpd *)(gl)->gl_object)
+#define set_gl2rgd(gl, rgd) (gl)->gl_object = (rgd)
+#define get_gl2gl(gl) ((struct gfs2_glock *)(gl)->gl_object)
+#define set_gl2gl(gl, gl2) (gl)->gl_object = (gl2)
+
+#endif /* __GFS2_DOT_H__ */
+
--- /dev/null
+++ b/fs/gfs2/incore.h
@@ -0,0 +1,682 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __INCORE_DOT_H__
+#define __INCORE_DOT_H__
+
+#define DIO_FORCE	0x00000001
+#define DIO_CLEAN	0x00000002
+#define DIO_DIRTY	0x00000004
+#define DIO_START	0x00000008
+#define DIO_WAIT	0x00000010
+#define DIO_METADATA	0x00000020
+#define DIO_DATA	0x00000040
+#define DIO_RELEASE	0x00000080
+#define DIO_ALL		0x00000100
+
+struct gfs2_log_operations;
+struct gfs2_log_element;
+struct gfs2_bitmap;
+struct gfs2_rgrpd;
+struct gfs2_bufdata;
+struct gfs2_glock_operations;
+struct gfs2_holder;
+struct gfs2_glock;
+struct gfs2_alloc;
+struct gfs2_inode;
+struct gfs2_file;
+struct gfs2_revoke;
+struct gfs2_revoke_replay;
+struct gfs2_unlinked;
+struct gfs2_quota_data;
+struct gfs2_log_buf;
+struct gfs2_trans;
+struct gfs2_ail;
+struct gfs2_jdesc;
+struct gfs2_args;
+struct gfs2_tune;
+struct gfs2_gl_hash_bucket;
+struct gfs2_sbd;
+
+typedef void (*gfs2_glop_bh_t) (struct gfs2_glock *gl, unsigned int ret);
+
+/*
+ * Structure of operations that are associated with each
+ * type of element in the log.
+ */
+
+struct gfs2_log_operations {
+	void (*lo_add) (struct gfs2_sbd *sdp, struct gfs2_log_element *le);
+	void (*lo_incore_commit) (struct gfs2_sbd *sdp, struct gfs2_trans *tr);
+	void (*lo_before_commit) (struct gfs2_sbd *sdp);
+	void (*lo_after_commit) (struct gfs2_sbd *sdp, struct gfs2_ail *ai);
+	void (*lo_before_scan) (struct gfs2_jdesc *jd,
+				struct gfs2_log_header *head, int pass);
+	int (*lo_scan_elements) (struct gfs2_jdesc *jd, unsigned int start,
+				 struct gfs2_log_descriptor *ld, __be64 *ptr,
+				 int pass);
+	void (*lo_after_scan) (struct gfs2_jdesc *jd, int error, int pass);
+	char *lo_name;
+};
+
+struct gfs2_log_element {
+	struct list_head le_list;
+	struct gfs2_log_operations *le_ops;
+};
+
+struct gfs2_bitmap {
+	struct buffer_head *bi_bh;
+	char *bi_clone;
+	uint32_t bi_offset;
+	uint32_t bi_start;
+	uint32_t bi_len;
+};
+
+struct gfs2_rgrpd {
+	struct list_head rd_list;	/* Link with superblock */
+	struct list_head rd_list_mru;
+	struct list_head rd_recent;	/* Recently used rgrps */
+	struct gfs2_glock *rd_gl;	/* Glock for this rgrp */
+	struct gfs2_rindex rd_ri;
+	struct gfs2_rgrp rd_rg;
+	uint64_t rd_rg_vn;
+	struct gfs2_bitmap *rd_bits;
+	unsigned int rd_bh_count;
+	struct mutex rd_mutex;
+	uint32_t rd_free_clone;
+	struct gfs2_log_element rd_le;
+	uint32_t rd_last_alloc_data;
+	uint32_t rd_last_alloc_meta;
+	struct gfs2_sbd *rd_sbd;
+};
+
+enum gfs2_state_bits {
+	BH_Pinned = BH_PrivateStart,
+	BH_Escaped = BH_PrivateStart + 1,
+};
+
+BUFFER_FNS(Pinned, pinned)
+TAS_BUFFER_FNS(Pinned, pinned)
+BUFFER_FNS(Escaped, escaped)
+TAS_BUFFER_FNS(Escaped, escaped)
+
+struct gfs2_bufdata {
+	struct buffer_head *bd_bh;
+	struct gfs2_glock *bd_gl;
+
+	struct list_head bd_list_tr;
+	struct gfs2_log_element bd_le;
+
+	struct gfs2_ail *bd_ail;
+	struct list_head bd_ail_st_list;
+	struct list_head bd_ail_gl_list;
+};
+
+struct gfs2_glock_operations {
+	void (*go_xmote_th) (struct gfs2_glock * gl, unsigned int state,
+			     int flags);
+	void (*go_xmote_bh) (struct gfs2_glock * gl);
+	void (*go_drop_th) (struct gfs2_glock * gl);
+	void (*go_drop_bh) (struct gfs2_glock * gl);
+	void (*go_sync) (struct gfs2_glock * gl, int flags);
+	void (*go_inval) (struct gfs2_glock * gl, int flags);
+	int (*go_demote_ok) (struct gfs2_glock * gl);
+	int (*go_lock) (struct gfs2_holder * gh);
+	void (*go_unlock) (struct gfs2_holder * gh);
+	void (*go_callback) (struct gfs2_glock * gl, unsigned int state);
+	void (*go_greedy) (struct gfs2_glock * gl);
+	int go_type;
+};
+
+enum {
+	/* Actions */
+	HIF_MUTEX		= 0,
+	HIF_PROMOTE		= 1,
+	HIF_DEMOTE		= 2,
+	HIF_GREEDY		= 3,
+
+	/* States */
+	HIF_ALLOCED		= 4,
+	HIF_DEALLOC		= 5,
+	HIF_HOLDER		= 6,
+	HIF_FIRST		= 7,
+	HIF_RECURSE		= 8,
+	HIF_ABORTED		= 9,
+};
+
+struct gfs2_holder {
+	struct list_head gh_list;
+
+	struct gfs2_glock *gh_gl;
+	struct task_struct *gh_owner;
+	unsigned int gh_state;
+	int gh_flags;
+
+	int gh_error;
+	unsigned long gh_iflags;
+	struct completion gh_wait;
+};
+
+enum {
+	GLF_PLUG		= 0,
+	GLF_LOCK		= 1,
+	GLF_STICKY		= 2,
+	GLF_PREFETCH		= 3,
+	GLF_SYNC		= 4,
+	GLF_DIRTY		= 5,
+	GLF_SKIP_WAITERS2	= 6,
+	GLF_GREEDY		= 7,
+};
+
+struct gfs2_glock {
+	struct list_head gl_list;
+	unsigned long gl_flags;		/* GLF_... */
+	struct lm_lockname gl_name;
+	struct kref gl_ref;
+
+	spinlock_t gl_spin;
+
+	unsigned int gl_state;
+	struct list_head gl_holders;
+	struct list_head gl_waiters1;	/* HIF_MUTEX */
+	struct list_head gl_waiters2;	/* HIF_DEMOTE, HIF_GREEDY */
+	struct list_head gl_waiters3;	/* HIF_PROMOTE */
+
+	struct gfs2_glock_operations *gl_ops;
+
+	struct gfs2_holder *gl_req_gh;
+	gfs2_glop_bh_t gl_req_bh;
+
+	lm_lock_t *gl_lock;
+	char *gl_lvb;
+	atomic_t gl_lvb_count;
+
+	uint64_t gl_vn;
+	unsigned long gl_stamp;
+	void *gl_object;
+
+	struct gfs2_gl_hash_bucket *gl_bucket;
+	struct list_head gl_reclaim;
+
+	struct gfs2_sbd *gl_sbd;
+
+	struct inode *gl_aspace;
+	struct gfs2_log_element gl_le;
+	struct list_head gl_ail_list;
+	atomic_t gl_ail_count;
+};
+
+struct gfs2_alloc {
+	/* Quota stuff */
+
+	unsigned int al_qd_num;
+	struct gfs2_quota_data *al_qd[4];
+	struct gfs2_holder al_qd_ghs[4];
+
+	/* Filled in by the caller to gfs2_inplace_reserve() */
+
+	uint32_t al_requested;
+
+	/* Filled in by gfs2_inplace_reserve() */
+
+	char *al_file;
+	unsigned int al_line;
+	struct gfs2_holder al_ri_gh;
+	struct gfs2_holder al_rgd_gh;
+	struct gfs2_rgrpd *al_rgd;
+
+	/* Filled in by gfs2_alloc_*() */
+
+	uint32_t al_alloced;
+};
+
+enum {
+	GIF_MIN_INIT		= 0,
+	GIF_QD_LOCKED		= 1,
+	GIF_PAGED		= 2,
+	GIF_SW_PAGED		= 3,
+};
+
+struct gfs2_inode {
+	struct gfs2_inum i_num;
+
+	atomic_t i_count;
+	unsigned long i_flags;		/* GIF_... */
+
+	uint64_t i_vn;
+	struct gfs2_dinode i_di;
+
+	struct gfs2_glock *i_gl;
+	struct gfs2_sbd *i_sbd;
+	struct inode *i_vnode;
+
+	struct gfs2_holder i_iopen_gh;
+	struct gfs2_holder i_gh; /* for prepare/commit_write only */
+	struct gfs2_alloc i_alloc;
+	uint64_t i_last_rg_alloc;
+
+	spinlock_t i_spin;
+	struct rw_semaphore i_rw_mutex;
+
+	unsigned int i_greedy;
+	unsigned long i_last_pfault;
+
+	struct buffer_head *i_cache[GFS2_MAX_META_HEIGHT];
+};
+
+enum {
+	GFF_DID_DIRECT_ALLOC	= 0,
+};
+
+struct gfs2_file {
+	unsigned long f_flags;		/* GFF_... */
+
+	struct mutex f_fl_mutex;
+	struct gfs2_holder f_fl_gh;
+
+	struct gfs2_inode *f_inode;
+	struct file *f_vfile;
+};
+
+struct gfs2_revoke {
+	struct gfs2_log_element rv_le;
+	uint64_t rv_blkno;
+};
+
+struct gfs2_revoke_replay {
+	struct list_head rr_list;
+	uint64_t rr_blkno;
+	unsigned int rr_where;
+};
+
+enum {
+	ULF_LOCKED		= 0,
+};
+
+struct gfs2_unlinked {
+	struct list_head ul_list;
+	unsigned int ul_count;
+	struct gfs2_unlinked_tag ul_ut;
+	unsigned long ul_flags;		/* ULF_... */
+	unsigned int ul_slot;
+};
+
+enum {
+	QDF_USER		= 0,
+	QDF_CHANGE		= 1,
+	QDF_LOCKED		= 2,
+};
+
+struct gfs2_quota_data {
+	struct list_head qd_list;
+	unsigned int qd_count;
+
+	uint32_t qd_id;
+	unsigned long qd_flags;		/* QDF_... */
+
+	int64_t qd_change;
+	int64_t qd_change_sync;
+
+	unsigned int qd_slot;
+	unsigned int qd_slot_count;
+
+	struct buffer_head *qd_bh;
+	struct gfs2_quota_change *qd_bh_qc;
+	unsigned int qd_bh_count;
+
+	struct gfs2_glock *qd_gl;
+	struct gfs2_quota_lvb qd_qb;
+
+	uint64_t qd_sync_gen;
+	unsigned long qd_last_warn;
+	unsigned long qd_last_touched;
+};
+
+struct gfs2_log_buf {
+	struct list_head lb_list;
+	struct buffer_head *lb_bh;
+	struct buffer_head *lb_real;
+};
+
+struct gfs2_trans {
+	char *tr_file;
+	unsigned int tr_line;
+
+	unsigned int tr_blocks;
+	unsigned int tr_revokes;
+	unsigned int tr_reserved;
+
+	struct gfs2_holder *tr_t_gh;
+
+	int tr_touched;
+
+	unsigned int tr_num_buf;
+	unsigned int tr_num_buf_new;
+	unsigned int tr_num_buf_rm;
+	struct list_head tr_list_buf;
+
+	unsigned int tr_num_revoke;
+	unsigned int tr_num_revoke_rm;
+};
+
+struct gfs2_ail {
+	struct list_head ai_list;
+
+	unsigned int ai_first;
+	struct list_head ai_ail1_list;
+	struct list_head ai_ail2_list;
+
+	uint64_t ai_sync_gen;
+};
+
+struct gfs2_jdesc {
+	struct list_head jd_list;
+
+	struct inode *jd_inode;
+	unsigned int jd_jid;
+	int jd_dirty;
+
+	unsigned int jd_blocks;
+};
+
+#define GFS2_GLOCKD_DEFAULT	1
+#define GFS2_GLOCKD_MAX		16
+
+#define GFS2_QUOTA_DEFAULT	GFS2_QUOTA_OFF
+#define GFS2_QUOTA_OFF		0
+#define GFS2_QUOTA_ACCOUNT	1
+#define GFS2_QUOTA_ON		2
+
+#define GFS2_DATA_DEFAULT	GFS2_DATA_ORDERED
+#define GFS2_DATA_WRITEBACK	1
+#define GFS2_DATA_ORDERED	2
+
+struct gfs2_args {
+	char ar_lockproto[GFS2_LOCKNAME_LEN]; /* Name of the Lock Protocol */
+	char ar_locktable[GFS2_LOCKNAME_LEN]; /* Name of the Lock Table */
+	char ar_hostdata[GFS2_LOCKNAME_LEN]; /* Host specific data */
+	int ar_spectator; /* Don't get a journal because we're always RO */
+	int ar_ignore_local_fs; /* Don't optimize even if local_fs is 1 */
+	int ar_localflocks; /* Let the VFS do flock|fcntl locks for us */
+	int ar_localcaching; /* Local-style caching (dangerous on multihost) */
+	int ar_debug; /* Oops on errors instead of trying to be graceful */
+	int ar_upgrade; /* Upgrade ondisk/multihost format */
+	unsigned int ar_num_glockd; /* Number of glockd threads */
+	int ar_posix_acl; /* Enable posix acls */
+	int ar_quota; /* off/account/on */
+	int ar_suiddir; /* suiddir support */
+	int ar_data; /* ordered/writeback */
+};
+
+struct gfs2_tune {
+	spinlock_t gt_spin;
+
+	unsigned int gt_ilimit;
+	unsigned int gt_ilimit_tries;
+	unsigned int gt_ilimit_min;
+	unsigned int gt_demote_secs; /* Cache retention for unheld glock */
+	unsigned int gt_incore_log_blocks;
+	unsigned int gt_log_flush_secs;
+	unsigned int gt_jindex_refresh_secs; /* Check for new journal index */
+
+	unsigned int gt_scand_secs;
+	unsigned int gt_recoverd_secs;
+	unsigned int gt_logd_secs;
+	unsigned int gt_quotad_secs;
+	unsigned int gt_inoded_secs;
+
+	unsigned int gt_quota_simul_sync; /* Max quotavals to sync at once */
+	unsigned int gt_quota_warn_period; /* Secs between quota warn msgs */
+	unsigned int gt_quota_scale_num; /* Numerator */
+	unsigned int gt_quota_scale_den; /* Denominator */
+	unsigned int gt_quota_cache_secs;
+	unsigned int gt_quota_quantum; /* Secs between syncs to quota file */
+	unsigned int gt_atime_quantum; /* Min secs between atime updates */
+	unsigned int gt_new_files_jdata;
+	unsigned int gt_new_files_directio;
+	unsigned int gt_max_atomic_write; /* Split big writes into this size */
+	unsigned int gt_max_readahead; /* Max bytes to read-ahead from disk */
+	unsigned int gt_lockdump_size;
+	unsigned int gt_stall_secs; /* Detects trouble! */
+	unsigned int gt_complain_secs;
+	unsigned int gt_reclaim_limit; /* Max num of glocks in reclaim list */
+	unsigned int gt_entries_per_readdir;
+	unsigned int gt_prefetch_secs; /* Usage window for prefetched glocks */
+	unsigned int gt_greedy_default;
+	unsigned int gt_greedy_quantum;
+	unsigned int gt_greedy_max;
+	unsigned int gt_statfs_quantum;
+	unsigned int gt_statfs_slow;
+};
+
+struct gfs2_gl_hash_bucket {
+	rwlock_t hb_lock;
+	struct list_head hb_list;
+};
+
+enum {
+	SDF_JOURNAL_CHECKED	= 0,
+	SDF_JOURNAL_LIVE	= 1,
+	SDF_SHUTDOWN		= 2,
+	SDF_NOATIME		= 3,
+};
+
+#define GFS2_GL_HASH_SHIFT	13
+#define GFS2_GL_HASH_SIZE	(1 << GFS2_GL_HASH_SHIFT)
+#define GFS2_GL_HASH_MASK	(GFS2_GL_HASH_SIZE - 1)
+#define GFS2_FSNAME_LEN		256
+
+struct gfs2_sbd {
+	struct super_block *sd_vfs;
+	struct kobject sd_kobj;
+	unsigned long sd_flags;	/* SDF_... */
+	struct gfs2_sb sd_sb;
+
+	/* Constants computed on mount */
+
+	uint32_t sd_fsb2bb;
+	uint32_t sd_fsb2bb_shift;
+	uint32_t sd_diptrs;	/* Number of pointers in a dinode */
+	uint32_t sd_inptrs;	/* Number of pointers in a indirect block */
+	uint32_t sd_jbsize;	/* Size of a journaled data block */
+	uint32_t sd_hash_bsize;	/* sizeof(exhash block) */
+	uint32_t sd_hash_bsize_shift;
+	uint32_t sd_hash_ptrs;	/* Number of pointers in a hash block */
+	uint32_t sd_ut_per_block;
+	uint32_t sd_qc_per_block;
+	uint32_t sd_max_dirres;	/* Max blocks needed to add a directory entry */
+	uint32_t sd_max_height;	/* Max height of a file's metadata tree */
+	uint64_t sd_heightsize[GFS2_MAX_META_HEIGHT];
+	uint32_t sd_max_jheight; /* Max height of journaled file's meta tree */
+	uint64_t sd_jheightsize[GFS2_MAX_META_HEIGHT];
+
+	struct gfs2_args sd_args;	/* Mount arguments */
+	struct gfs2_tune sd_tune;	/* Filesystem tuning structure */
+
+	/* Lock Stuff */
+
+	struct lm_lockstruct sd_lockstruct;
+	struct gfs2_gl_hash_bucket sd_gl_hash[GFS2_GL_HASH_SIZE];
+	struct list_head sd_reclaim_list;
+	spinlock_t sd_reclaim_lock;
+	wait_queue_head_t sd_reclaim_wq;
+	atomic_t sd_reclaim_count;
+	struct gfs2_holder sd_live_gh;
+	struct gfs2_glock *sd_rename_gl;
+	struct gfs2_glock *sd_trans_gl;
+	struct mutex sd_invalidate_inodes_mutex;
+
+	/* Inode Stuff */
+
+	struct inode *sd_master_dir;
+	struct inode *sd_jindex;
+	struct inode *sd_inum_inode;
+	struct inode *sd_statfs_inode;
+	struct inode *sd_ir_inode;
+	struct inode *sd_sc_inode;
+	struct inode *sd_ut_inode;
+	struct inode *sd_qc_inode;
+	struct inode *sd_rindex;
+	struct inode *sd_quota_inode;
+	struct inode *sd_root_dir;
+
+	/* Inum stuff */
+
+	struct mutex sd_inum_mutex;
+
+	/* StatFS stuff */
+
+	spinlock_t sd_statfs_spin;
+	struct mutex sd_statfs_mutex;
+	struct gfs2_statfs_change sd_statfs_master;
+	struct gfs2_statfs_change sd_statfs_local;
+	unsigned long sd_statfs_sync_time;
+
+	/* Resource group stuff */
+
+	uint64_t sd_rindex_vn;
+	spinlock_t sd_rindex_spin;
+	struct mutex sd_rindex_mutex;
+	struct list_head sd_rindex_list;
+	struct list_head sd_rindex_mru_list;
+	struct list_head sd_rindex_recent_list;
+	struct gfs2_rgrpd *sd_rindex_forward;
+	unsigned int sd_rgrps;
+
+	/* Journal index stuff */
+
+	struct list_head sd_jindex_list;
+	spinlock_t sd_jindex_spin;
+	struct mutex sd_jindex_mutex;
+	unsigned int sd_journals;
+	unsigned long sd_jindex_refresh_time;
+
+	struct gfs2_jdesc *sd_jdesc;
+	struct gfs2_holder sd_journal_gh;
+	struct gfs2_holder sd_jinode_gh;
+
+	struct gfs2_holder sd_ir_gh;
+	struct gfs2_holder sd_sc_gh;
+	struct gfs2_holder sd_ut_gh;
+	struct gfs2_holder sd_qc_gh;
+
+	/* Daemon stuff */
+
+	struct task_struct *sd_scand_process;
+	struct task_struct *sd_recoverd_process;
+	struct task_struct *sd_logd_process;
+	struct task_struct *sd_quotad_process;
+	struct task_struct *sd_inoded_process;
+	struct task_struct *sd_glockd_process[GFS2_GLOCKD_MAX];
+	unsigned int sd_glockd_num;
+
+	/* Unlinked inode stuff */
+
+	struct list_head sd_unlinked_list;
+	atomic_t sd_unlinked_count;
+	spinlock_t sd_unlinked_spin;
+	struct mutex sd_unlinked_mutex;
+
+	unsigned int sd_unlinked_slots;
+	unsigned int sd_unlinked_chunks;
+	unsigned char **sd_unlinked_bitmap;
+
+	/* Quota stuff */
+
+	struct list_head sd_quota_list;
+	atomic_t sd_quota_count;
+	spinlock_t sd_quota_spin;
+	struct mutex sd_quota_mutex;
+
+	unsigned int sd_quota_slots;
+	unsigned int sd_quota_chunks;
+	unsigned char **sd_quota_bitmap;
+
+	uint64_t sd_quota_sync_gen;
+	unsigned long sd_quota_sync_time;
+
+	/* Log stuff */
+
+	spinlock_t sd_log_lock;
+	atomic_t sd_log_trans_count;
+	wait_queue_head_t sd_log_trans_wq;
+	atomic_t sd_log_flush_count;
+	wait_queue_head_t sd_log_flush_wq;
+
+	unsigned int sd_log_blks_reserved;
+	unsigned int sd_log_commited_buf;
+	unsigned int sd_log_commited_revoke;
+
+	unsigned int sd_log_num_gl;
+	unsigned int sd_log_num_buf;
+	unsigned int sd_log_num_revoke;
+	unsigned int sd_log_num_rg;
+	unsigned int sd_log_num_databuf;
+	unsigned int sd_log_num_jdata;
+
+	struct list_head sd_log_le_gl;
+	struct list_head sd_log_le_buf;
+	struct list_head sd_log_le_revoke;
+	struct list_head sd_log_le_rg;
+	struct list_head sd_log_le_databuf;
+
+	unsigned int sd_log_blks_free;
+	struct list_head sd_log_blks_list;
+	wait_queue_head_t sd_log_blks_wait;
+
+	uint64_t sd_log_sequence;
+	unsigned int sd_log_head;
+	unsigned int sd_log_tail;
+	uint64_t sd_log_wraps;
+	int sd_log_idle;
+
+	unsigned long sd_log_flush_time;
+	struct mutex sd_log_flush_lock;
+	struct list_head sd_log_flush_list;
+
+	unsigned int sd_log_flush_head;
+	uint64_t sd_log_flush_wrapped;
+
+	struct list_head sd_ail1_list;
+	struct list_head sd_ail2_list;
+	uint64_t sd_ail_sync_gen;
+
+	/* Replay stuff */
+
+	struct list_head sd_revoke_list;
+	unsigned int sd_replay_tail;
+
+	unsigned int sd_found_blocks;
+	unsigned int sd_found_revokes;
+	unsigned int sd_replayed_blocks;
+
+	/* For quiescing the filesystem */
+
+	struct gfs2_holder sd_freeze_gh;
+	struct mutex sd_freeze_lock;
+	unsigned int sd_freeze_count;
+
+	/* Counters */
+
+	atomic_t sd_glock_count;
+	atomic_t sd_glock_held_count;
+	atomic_t sd_inode_count;
+	atomic_t sd_reclaimed;
+
+	char sd_fsname[GFS2_FSNAME_LEN];
+	char sd_table_name[GFS2_FSNAME_LEN];
+	char sd_proto_name[GFS2_FSNAME_LEN];
+
+	/* Debugging crud */
+
+	unsigned long sd_last_warning;
+};
+
+#endif /* __INCORE_DOT_H__ */
+
--- /dev/null
+++ b/include/linux/gfs2_ioctl.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __GFS2_IOCTL_DOT_H__
+#define __GFS2_IOCTL_DOT_H__
+
+#define GFS2_IOCTL_SETFLAGS	_IOW('g', 3, long)
+#define GFS2_IOCTL_GETFLAGS	_IOR('g', 4, long)
+
+#endif /* ___GFS2_IOCTL_DOT_H__ */
+
--- /dev/null
+++ b/include/linux/gfs2_ondisk.h
@@ -0,0 +1,454 @@
+/*
+* Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+* Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+*
+* This copyrighted material is made available to anyone wishing to use,
+* modify, copy, or redistribute it subject to the terms and conditions
+* of the GNU General Public License v.2.
+*/
+
+#ifndef __GFS2_ONDISK_DOT_H__
+#define __GFS2_ONDISK_DOT_H__
+
+#define GFS2_MAGIC		0x01161970
+#define GFS2_BASIC_BLOCK	512
+#define GFS2_BASIC_BLOCK_SHIFT	9
+
+/* Lock numbers of the LM_TYPE_NONDISK type */
+
+#define GFS2_MOUNT_LOCK		0
+#define GFS2_LIVE_LOCK		1
+#define GFS2_TRANS_LOCK		2
+#define GFS2_RENAME_LOCK	3
+
+/* Format numbers for various metadata types */
+
+#define GFS2_FORMAT_NONE	0
+#define GFS2_FORMAT_SB		100
+#define GFS2_FORMAT_RG		200
+#define GFS2_FORMAT_RB		300
+#define GFS2_FORMAT_DI		400
+#define GFS2_FORMAT_IN		500
+#define GFS2_FORMAT_LF		600
+#define GFS2_FORMAT_JD		700
+#define GFS2_FORMAT_LH		800
+#define GFS2_FORMAT_LD		900
+#define GFS2_FORMAT_LB		1000
+#define GFS2_FORMAT_EA		1600
+#define GFS2_FORMAT_ED		1700
+#define GFS2_FORMAT_UT		1300
+#define GFS2_FORMAT_QC		1400
+/* These are format numbers for entities contained in files */
+#define GFS2_FORMAT_RI		1100
+#define GFS2_FORMAT_DE		1200
+#define GFS2_FORMAT_QU		1500
+/* These are part of the superblock */
+#define GFS2_FORMAT_FS		1801
+#define GFS2_FORMAT_MULTI	1900
+
+/*
+ * An on-disk inode number
+ */
+
+#define gfs2_inum_equal(ino1, ino2) \
+	(((ino1)->no_formal_ino == (ino2)->no_formal_ino) && \
+	((ino1)->no_addr == (ino2)->no_addr))
+
+struct gfs2_inum {
+	__be64 no_formal_ino;
+	__be64 no_addr;
+};
+
+/*
+ * Generic metadata head structure
+ * Every inplace buffer logged in the journal must start with this.
+ */
+
+#define GFS2_METATYPE_NONE	0
+#define GFS2_METATYPE_SB	1
+#define GFS2_METATYPE_RG	2
+#define GFS2_METATYPE_RB	3
+#define GFS2_METATYPE_DI	4
+#define GFS2_METATYPE_IN	5
+#define GFS2_METATYPE_LF	6
+#define GFS2_METATYPE_JD	7
+#define GFS2_METATYPE_LH	8
+#define GFS2_METATYPE_LD	9
+#define GFS2_METATYPE_LB	12
+#define GFS2_METATYPE_EA	10
+#define GFS2_METATYPE_ED	11
+#define GFS2_METATYPE_UT	13
+#define GFS2_METATYPE_QC	14
+
+struct gfs2_meta_header {
+	__be32 mh_magic;
+	__be32 mh_type;
+	__be64 __pad0;		/* Was generation number in gfs1 */
+	__be32 mh_format;
+	__be32 __pad1;		/* Was incarnation number in gfs1 */
+};
+
+/*
+ * super-block structure
+ *
+ * It's probably good if SIZEOF_SB <= GFS2_BASIC_BLOCK (512 bytes)
+ *
+ * Order is important, need to be able to read old superblocks to do on-disk
+ * version upgrades.
+ */
+
+/* Address of superblock in GFS2 basic blocks */
+#define GFS2_SB_ADDR		128
+
+/* The lock number for the superblock (must be zero) */
+#define GFS2_SB_LOCK		0
+
+/* Requirement:  GFS2_LOCKNAME_LEN % 8 == 0
+   Includes: the fencing zero at the end */
+#define GFS2_LOCKNAME_LEN	64
+
+struct gfs2_sb {
+	struct gfs2_meta_header sb_header;
+
+	__be32 sb_fs_format;
+	__be32 sb_multihost_format;
+	__u32  __pad0;	/* Was superblock flags in gfs1 */
+
+	__be32 sb_bsize;
+	__be32 sb_bsize_shift;
+	__u32 __pad1;	/* Was journal segment size in gfs1 */
+
+	struct gfs2_inum sb_master_dir; /* Was jindex dinode in gfs1 */
+	struct gfs2_inum __pad2; /* Was rindex dinode in gfs1 */
+	struct gfs2_inum sb_root_dir;
+
+	char sb_lockproto[GFS2_LOCKNAME_LEN];
+	char sb_locktable[GFS2_LOCKNAME_LEN];
+	/* In gfs1, quota and license dinodes followed */
+};
+
+/*
+ * resource index structure
+ */
+
+struct gfs2_rindex {
+	__be64 ri_addr;	/* grp block disk address */
+	__be32 ri_length;	/* length of rgrp header in fs blocks */
+	__u32 __pad;
+
+	__be64 ri_data0;	/* first data location */
+	__be32 ri_data;	/* num of data blocks in rgrp */
+
+	__be32 ri_bitbytes;	/* number of bytes in data bitmaps */
+
+	__u8 ri_reserved[64];
+};
+
+/*
+ * resource group header structure
+ */
+
+/* Number of blocks per byte in rgrp */
+#define GFS2_NBBY		4
+#define GFS2_BIT_SIZE		2
+#define GFS2_BIT_MASK		0x00000003
+
+#define GFS2_BLKST_FREE		0
+#define GFS2_BLKST_USED		1
+#define GFS2_BLKST_INVALID	2
+#define GFS2_BLKST_DINODE	3
+
+#define GFS2_RGF_JOURNAL	0x00000001
+#define GFS2_RGF_METAONLY	0x00000002
+#define GFS2_RGF_DATAONLY	0x00000004
+#define GFS2_RGF_NOALLOC	0x00000008
+
+struct gfs2_rgrp {
+	struct gfs2_meta_header rg_header;
+
+	__be32 rg_flags;
+	__be32 rg_free;
+	__be32 rg_dinodes;
+
+	__u8 rg_reserved[92]; /* Several fields from gfs1 now reserved */
+};
+
+/*
+ * quota structure
+ */
+
+struct gfs2_quota {
+	__be64 qu_limit;
+	__be64 qu_warn;
+	__be64 qu_value;
+	__u8 qu_reserved[64];
+};
+
+/*
+ * dinode structure
+ */
+
+#define GFS2_MAX_META_HEIGHT	10
+#define GFS2_DIR_MAX_DEPTH	17
+
+#define DT2IF(dt) (((dt) << 12) & S_IFMT)
+#define IF2DT(sif) (((sif) & S_IFMT) >> 12)
+
+/* Dinode flags */
+#define GFS2_DIF_JDATA			0x00000001
+#define GFS2_DIF_EXHASH			0x00000002
+#define GFS2_DIF_UNUSED			0x00000004  /* only in gfs1 */
+#define GFS2_DIF_EA_INDIRECT		0x00000008
+#define GFS2_DIF_DIRECTIO		0x00000010
+#define GFS2_DIF_IMMUTABLE		0x00000020
+#define GFS2_DIF_APPENDONLY		0x00000040
+#define GFS2_DIF_NOATIME		0x00000080
+#define GFS2_DIF_SYNC			0x00000100
+#define GFS2_DIF_SYSTEM			0x00000200 /* New in gfs2 */
+#define GFS2_DIF_TRUNC_IN_PROG		0x20000000 /* New in gfs2 */
+#define GFS2_DIF_INHERIT_DIRECTIO	0x40000000
+#define GFS2_DIF_INHERIT_JDATA		0x80000000
+
+struct gfs2_dinode {
+	struct gfs2_meta_header di_header;
+
+	struct gfs2_inum di_num;
+
+	__be32 di_mode;	/* mode of file */
+	__be32 di_uid;	/* owner's user id */
+	__be32 di_gid;	/* owner's group id */
+	__be32 di_nlink;	/* number of links to this file */
+	__be64 di_size;	/* number of bytes in file */
+	__be64 di_blocks;	/* number of blocks in file */
+	__be64 di_atime;	/* time last accessed */
+	__be64 di_mtime;	/* time last modified */
+	__be64 di_ctime;	/* time last changed */
+	__be32 di_major;	/* device major number */
+	__be32 di_minor;	/* device minor number */
+
+	/* This section varies from gfs1. Padding added to align with
+         * remainder of dinode
+	 */
+	__be64 di_goal_meta;	/* rgrp to alloc from next */
+	__be64 di_goal_data;	/* data block goal */
+	__u32 __pad[2];
+
+	__be32 di_flags;	/* GFS2_DIF_... */
+	__be32 di_payload_format;  /* GFS2_FORMAT_... */
+	__u16 __pad1;	/* Was ditype in gfs1 */
+	__be16 di_height;	/* height of metadata */
+	__u32 __pad2;	/* Unused incarnation number from gfs1 */
+
+	/* These only apply to directories  */
+	__u16 __pad3;	/* Padding */
+	__be16 di_depth;	/* Number of bits in the table */
+	__be32 di_entries;	/* The number of entries in the directory */
+
+	struct gfs2_inum __pad4; /* Unused even in current gfs1 */
+
+	__be64 di_eattr;	/* extended attribute block number */
+
+	__u8 di_reserved[56];
+};
+
+/*
+ * directory structure - many of these per directory file
+ */
+
+#define GFS2_FNAMESIZE		255
+#define GFS2_DIRENT_SIZE(name_len) ((sizeof(struct gfs2_dirent) + (name_len) + 7) & ~7)
+
+struct gfs2_dirent {
+	struct gfs2_inum de_inum;
+	__be32 de_hash;
+	__be16 de_rec_len;
+	__be16 de_name_len;
+	__be16 de_type;
+	__u8 __pad[14];
+};
+
+/*
+ * Header of leaf directory nodes
+ */
+
+struct gfs2_leaf {
+	struct gfs2_meta_header lf_header;
+
+	__be16 lf_depth;		/* Depth of leaf */
+	__be16 lf_entries;		/* Number of dirents in leaf */
+	__be32 lf_dirent_format;	/* Format of the dirents */
+	__be64 lf_next;			/* Next leaf, if overflow */
+
+	__u8 lf_reserved[64];
+};
+
+/*
+ * Extended attribute header format
+ */
+
+#define GFS2_EA_MAX_NAME_LEN	255
+#define GFS2_EA_MAX_DATA_LEN	65536
+
+#define GFS2_EATYPE_UNUSED	0
+#define GFS2_EATYPE_USR		1
+#define GFS2_EATYPE_SYS		2
+
+#define GFS2_EATYPE_LAST	2
+#define GFS2_EATYPE_VALID(x)	((x) <= GFS2_EATYPE_LAST)
+
+#define GFS2_EAFLAG_LAST	0x01	/* last ea in block */
+
+struct gfs2_ea_header {
+	__be32 ea_rec_len;
+	__be32 ea_data_len;
+	__u8 ea_name_len;	/* no NULL pointer after the string */
+	__u8 ea_type;		/* GFS2_EATYPE_... */
+	__u8 ea_flags;		/* GFS2_EAFLAG_... */
+	__u8 ea_num_ptrs;
+	__u32 __pad;
+};
+
+/*
+ * Log header structure
+ */
+
+#define GFS2_LOG_HEAD_UNMOUNT	0x00000001	/* log is clean */
+
+struct gfs2_log_header {
+	struct gfs2_meta_header lh_header;
+
+	__be64 lh_sequence;	/* Sequence number of this transaction */
+	__be32 lh_flags;	/* GFS2_LOG_HEAD_... */
+	__be32 lh_tail;		/* Block number of log tail */
+	__be32 lh_blkno;
+	__be32 lh_hash;
+};
+
+/*
+ * Log type descriptor
+ */
+
+#define GFS2_LOG_DESC_METADATA	300
+/* ld_data1 is the number of metadata blocks in the descriptor.
+   ld_data2 is unused. */
+
+#define GFS2_LOG_DESC_REVOKE	301
+/* ld_data1 is the number of revoke blocks in the descriptor.
+   ld_data2 is unused. */
+
+#define GFS2_LOG_DESC_JDATA	302
+/* ld_data1 is the number of data blocks in the descriptor.
+   ld_data2 is unused. */
+
+struct gfs2_log_descriptor {
+	struct gfs2_meta_header ld_header;
+
+	__be32 ld_type;		/* GFS2_LOG_DESC_... */
+	__be32 ld_length;	/* Number of buffers in this chunk */
+	__be32 ld_data1;	/* descriptor-specific field */
+	__be32 ld_data2;	/* descriptor-specific field */
+
+	__u8 ld_reserved[32];
+};
+
+/*
+ * Inum Range
+ * Describe a range of formal inode numbers allocated to
+ * one machine to assign to inodes.
+ */
+
+#define GFS2_INUM_QUANTUM	1048576
+
+struct gfs2_inum_range {
+	__be64 ir_start;
+	__be64 ir_length;
+};
+
+/*
+ * Statfs change
+ * Describes an change to the pool of free and allocated
+ * blocks.
+ */
+
+struct gfs2_statfs_change {
+	__be64 sc_total;
+	__be64 sc_free;
+	__be64 sc_dinodes;
+};
+
+/*
+ * Unlinked Tag
+ * Describes an allocated inode that isn't linked into
+ * the directory tree and might need to be deallocated.
+ */
+
+#define GFS2_UTF_UNINIT		0x00000001
+
+struct gfs2_unlinked_tag {
+	struct gfs2_inum ut_inum;
+	__be32 ut_flags;	/* GFS2_UTF_... */
+	__u32 __pad;
+};
+
+/*
+ * Quota change
+ * Describes an allocation change for a particular
+ * user or group.
+ */
+
+#define GFS2_QCF_USER		0x00000001
+
+struct gfs2_quota_change {
+	__be64 qc_change;
+	__be32 qc_flags;	/* GFS2_QCF_... */
+	__be32 qc_id;
+};
+
+#ifdef __KERNEL__
+/* Translation functions */
+
+extern void gfs2_inum_in(struct gfs2_inum *no, char *buf);
+extern void gfs2_inum_out(struct gfs2_inum *no, char *buf);
+extern void gfs2_sb_in(struct gfs2_sb *sb, char *buf);
+extern void gfs2_rindex_in(struct gfs2_rindex *ri, char *buf);
+extern void gfs2_rindex_out(struct gfs2_rindex *ri, char *buf);
+extern void gfs2_rgrp_in(struct gfs2_rgrp *rg, char *buf);
+extern void gfs2_rgrp_out(struct gfs2_rgrp *rg, char *buf);
+extern void gfs2_quota_in(struct gfs2_quota *qu, char *buf);
+extern void gfs2_quota_out(struct gfs2_quota *qu, char *buf);
+extern void gfs2_dinode_in(struct gfs2_dinode *di, char *buf);
+extern void gfs2_dinode_out(struct gfs2_dinode *di, char *buf);
+extern void gfs2_leaf_in(struct gfs2_leaf *lf, char *buf);
+extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, char *buf);
+extern void gfs2_ea_header_out(struct gfs2_ea_header *ea, char *buf);
+extern void gfs2_log_header_in(struct gfs2_log_header *lh, char *buf);
+extern void gfs2_inum_range_in(struct gfs2_inum_range *ir, char *buf);
+extern void gfs2_inum_range_out(struct gfs2_inum_range *ir, char *buf);
+extern void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, char *buf);
+extern void gfs2_statfs_change_out(struct gfs2_statfs_change *sc, char *buf);
+extern void gfs2_unlinked_tag_in(struct gfs2_unlinked_tag *ut, char *buf);
+extern void gfs2_unlinked_tag_out(struct gfs2_unlinked_tag *ut, char *buf);
+extern void gfs2_quota_change_in(struct gfs2_quota_change *qc, char *buf);
+
+/* Printing functions */
+
+extern void gfs2_inum_print(struct gfs2_inum *no);
+extern void gfs2_meta_header_print(struct gfs2_meta_header *mh);
+extern void gfs2_sb_print(struct gfs2_sb *sb);
+extern void gfs2_rindex_print(struct gfs2_rindex *ri);
+extern void gfs2_rgrp_print(struct gfs2_rgrp *rg);
+extern void gfs2_quota_print(struct gfs2_quota *qu);
+extern void gfs2_dinode_print(struct gfs2_dinode *di);
+extern void gfs2_dirent_print(struct gfs2_dirent *de, char *name);
+extern void gfs2_leaf_print(struct gfs2_leaf *lf);
+extern void gfs2_ea_header_print(struct gfs2_ea_header *ea, char *name);
+extern void gfs2_log_header_print(struct gfs2_log_header *lh);
+extern void gfs2_log_descriptor_print(struct gfs2_log_descriptor *ld);
+extern void gfs2_inum_range_print(struct gfs2_inum_range *ir);
+extern void gfs2_statfs_change_print(struct gfs2_statfs_change *sc);
+extern void gfs2_unlinked_tag_print(struct gfs2_unlinked_tag *ut);
+extern void gfs2_quota_change_print(struct gfs2_quota_change *qc);
+
+#endif /* __KERNEL__ */
+
+#endif /* __GFS2_ONDISK_DOT_H__ */


