Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbVIAOLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbVIAOLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 10:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbVIAOLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 10:11:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23249 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965125AbVIAOLl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 10:11:41 -0400
Date: Thu, 1 Sep 2005 21:54:42 +0800
From: David Teigland <teigland@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] GFS: headers
Message-ID: <20050901135442.GA25581@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Central header files that are widely used.

Signed-off-by: Ken Preslan <ken@preslan.org>
Signed-off-by: David Teigland <teigland@redhat.com>

---

 fs/gfs2/gfs2.h              |   77 +++
 fs/gfs2/incore.h            |  691 +++++++++++++++++++++++++++
 include/linux/gfs2_ioctl.h  |   30 +
 include/linux/gfs2_ondisk.h | 1119 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1917 insertions(+)

--- a/fs/gfs2/gfs2.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/gfs2.h	2005-09-01 17:36:55.202132648 +0800
@@ -0,0 +1,77 @@
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
+#include "locking/harness/lm_interface.h"
+#include "lvb.h"
+#include "incore.h"
+#include "util.h"
+
+#ifndef TRUE
+#define TRUE 1
+#endif
+
+#ifndef FALSE
+#define FALSE 0
+#endif
+
+#define NO_CREATE 0
+#define CREATE 1
+
+#define NO_WAIT 0
+#define WAIT 1
+
+#define NO_FORCE 0
+#define FORCE 1
+
+#if (BITS_PER_LONG == 64)
+#define PRIu64 "lu"
+#define PRId64 "ld"
+#define PRIx64 "lx"
+#define PRIX64 "lX"
+#else
+#define PRIu64 "Lu"
+#define PRId64 "Ld"
+#define PRIx64 "Lx"
+#define PRIX64 "LX"
+#endif
+
+/*  Divide num by den.  Round up if there is a remainder.  */
+#define DIV_RU(num, den) (((num) + (den) - 1) / (den))
+#define MAKE_MULT8(x) (((x) + 7) & ~7)
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
+#define get_v2db(bh) ((struct gfs2_databuf *)(bh)->b_private)
+#define set_v2db(bh, db) (bh)->b_private = (db)
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
--- a/fs/gfs2/incore.h	1970-01-01 07:30:00.000000000 +0730
+++ b/fs/gfs2/incore.h	2005-09-01 17:36:55.283120336 +0800
@@ -0,0 +1,691 @@
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
+struct gfs2_databuf;
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
+				 struct gfs2_log_descriptor *ld, int pass);
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
+	struct semaphore rd_mutex;
+	uint32_t rd_free_clone;
+	struct gfs2_log_element rd_le;
+	uint32_t rd_last_alloc_data;
+	uint32_t rd_last_alloc_meta;
+	struct gfs2_sbd *rd_sbd;
+};
+
+enum gfs2_state_bits {
+	BH_Pinned = BH_PrivateStart,
+};
+
+BUFFER_FNS(Pinned, pinned)
+TAS_BUFFER_FNS(Pinned, pinned)
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
+struct gfs2_databuf {
+	struct gfs2_log_element db_le;
+	struct buffer_head *db_bh;
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
+/* Actions */
+#define HIF_MUTEX		0
+#define HIF_PROMOTE		1
+#define HIF_DEMOTE		2
+#define HIF_GREEDY		3
+
+/* States */
+#define HIF_ALLOCED		4
+#define HIF_DEALLOC		5
+#define HIF_HOLDER		6
+#define HIF_FIRST		7
+#define HIF_RECURSE		8
+#define HIF_ABORTED		9
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
+#define GLF_PLUG		0
+#define GLF_LOCK		1
+#define GLF_STICKY		2
+#define GLF_PREFETCH		3
+#define GLF_SYNC		4
+#define GLF_DIRTY		5
+#define GLF_SKIP_WAITERS2	6
+#define GLF_GREEDY		7
+
+struct gfs2_glock {
+	struct list_head gl_list;
+	unsigned long gl_flags;		/* GLF_... */
+	struct lm_lockname gl_name;
+	atomic_t gl_count;
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
+#define GIF_MIN_INIT		0
+#define GIF_QD_LOCKED		1
+#define GIF_PAGED		2
+#define GIF_SW_PAGED		3
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
+
+	struct gfs2_alloc *i_alloc;
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
+#define GFF_DID_DIRECT_ALLOC	0
+
+struct gfs2_file {
+	unsigned long f_flags;		/* GFF_... */
+
+	struct semaphore f_fl_mutex;
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
+#define ULF_LOCKED		0
+
+struct gfs2_unlinked {
+	struct list_head ul_list;
+	unsigned int ul_count;
+	struct gfs2_unlinked_tag ul_ut;
+	unsigned long ul_flags;		/* ULF_... */
+	unsigned int ul_slot;
+};
+
+#define QDF_USER		0
+#define QDF_CHANGE		1
+#define QDF_LOCKED		2
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
+	struct gfs2_inode *jd_inode;
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
+	int ar_ignore_local_fs; /* Don't optimize even if local_fs is TRUE */
+	int ar_localflocks; /* Let the VFS do flock|fcntl locks for us */
+	int ar_localcaching; /* Local-style caching (dangerous on multihost) */
+	int ar_oopses_ok; /* Allow oopses */
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
+#define SDF_JOURNAL_CHECKED	0
+#define SDF_JOURNAL_LIVE	1
+#define SDF_SHUTDOWN		2
+#define SDF_NOATIME		3
+
+#define GFS2_GL_HASH_SHIFT	13
+#define GFS2_GL_HASH_SIZE	(1 << GFS2_GL_HASH_SHIFT)
+#define GFS2_GL_HASH_MASK	(GFS2_GL_HASH_SIZE - 1)
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
+
+	/* Inode Stuff */
+
+	struct gfs2_inode *sd_master_dir;
+	struct gfs2_inode *sd_jindex;
+	struct gfs2_inode *sd_inum_inode;
+	struct gfs2_inode *sd_statfs_inode;
+	struct gfs2_inode *sd_ir_inode;
+	struct gfs2_inode *sd_sc_inode;
+	struct gfs2_inode *sd_ut_inode;
+	struct gfs2_inode *sd_qc_inode;
+	struct gfs2_inode *sd_rindex;
+	struct gfs2_inode *sd_quota_inode;
+	struct gfs2_inode *sd_root_dir;
+
+	/* Inum stuff */
+
+	struct semaphore sd_inum_mutex;
+
+	/* StatFS stuff */
+
+	spinlock_t sd_statfs_spin;
+	struct semaphore sd_statfs_mutex;
+	struct gfs2_statfs_change sd_statfs_master;
+	struct gfs2_statfs_change sd_statfs_local;
+	unsigned long sd_statfs_sync_time;
+
+	/* Resource group stuff */
+
+	uint64_t sd_rindex_vn;
+	spinlock_t sd_rindex_spin;
+	struct semaphore sd_rindex_mutex;
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
+	struct semaphore sd_jindex_mutex;
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
+	struct semaphore sd_unlinked_mutex;
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
+	struct semaphore sd_quota_mutex;
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
+	struct semaphore sd_log_flush_lock;
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
+	struct semaphore sd_freeze_lock;
+	unsigned int sd_freeze_count;
+
+	/* Counters */
+
+	atomic_t sd_glock_count;
+	atomic_t sd_glock_held_count;
+	atomic_t sd_inode_count;
+	atomic_t sd_bufdata_count;
+
+	atomic_t sd_fh2dentry_misses;
+	atomic_t sd_reclaimed;
+	atomic_t sd_log_flush_incore;
+	atomic_t sd_log_flush_ondisk;
+
+	atomic_t sd_glock_nq_calls;
+	atomic_t sd_glock_dq_calls;
+	atomic_t sd_glock_prefetch_calls;
+	atomic_t sd_lm_lock_calls;
+	atomic_t sd_lm_unlock_calls;
+	atomic_t sd_lm_callbacks;
+
+	atomic_t sd_bio_reads;
+	atomic_t sd_bio_writes;
+	atomic_t sd_bio_outstanding;
+
+	atomic_t sd_ops_address;
+	atomic_t sd_ops_dentry;
+	atomic_t sd_ops_export;
+	atomic_t sd_ops_file;
+	atomic_t sd_ops_inode;
+	atomic_t sd_ops_super;
+	atomic_t sd_ops_vm;
+
+	char sd_fsname[256];
+
+	/* Debugging crud */
+
+	unsigned long sd_last_warning;
+
+	struct list_head sd_list;
+};
+
+#endif /* __INCORE_DOT_H__ */
+
--- a/include/linux/gfs2_ioctl.h	1970-01-01 07:30:00.000000000 +0730
+++ b/include/linux/gfs2_ioctl.h	2005-09-01 17:36:55.202132648 +0800
@@ -0,0 +1,30 @@
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
+#define _GFS2C_(x)               (('G' << 16) | ('2' << 8) | (x))
+
+/* Ioctls implemented */
+
+#define GFS2_IOCTL_IDENTIFY      _GFS2C_(1)
+#define GFS2_IOCTL_SUPER         _GFS2C_(2)
+
+struct gfs2_ioctl {
+	unsigned int gi_argc;
+	char **gi_argv;
+
+        char __user *gi_data;
+	unsigned int gi_size;
+	uint64_t gi_offset;
+};
+
+#endif /* ___GFS2_IOCTL_DOT_H__ */
+
--- a/include/linux/gfs2_ondisk.h	1970-01-01 07:30:00.000000000 +0730
+++ b/include/linux/gfs2_ondisk.h	2005-09-01 17:36:55.208131736 +0800
@@ -0,0 +1,1119 @@
+/*
+ * Copyright (C) Sistina Software, Inc.  1997-2003 All rights reserved.
+ * Copyright (C) 2004-2005 Red Hat, Inc.  All rights reserved.
+ *
+ * This copyrighted material is made available to anyone wishing to use,
+ * modify, copy, or redistribute it subject to the terms and conditions
+ * of the GNU General Public License v.2.
+ */
+
+#ifndef __GFS2_ONDISK_DOT_H__
+#define __GFS2_ONDISK_DOT_H__
+
+#define GFS2_MAGIC		0x07131974
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
+#define GFS2_FORMAT_EA		1100
+#define GFS2_FORMAT_ED		1200
+#define GFS2_FORMAT_UT		1300
+#define GFS2_FORMAT_QC		1400
+/* These are format numbers for entities contained in files */
+#define GFS2_FORMAT_RI		1500
+#define GFS2_FORMAT_DE		1600
+#define GFS2_FORMAT_QU		1700
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
+	uint64_t no_formal_ino;
+	uint64_t no_addr;
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
+#define GFS2_METATYPE_LB	10
+#define GFS2_METATYPE_EA	11
+#define GFS2_METATYPE_ED	12
+#define GFS2_METATYPE_UT	13
+#define GFS2_METATYPE_QC	14
+
+struct gfs2_meta_header {
+	uint32_t mh_magic;
+	uint16_t mh_type;
+	uint16_t mh_format;
+	uint64_t mh_blkno;
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
+	uint32_t sb_fs_format;
+	uint32_t sb_multihost_format;
+
+	uint32_t sb_bsize;
+	uint32_t sb_bsize_shift;
+
+	struct gfs2_inum sb_master_dir;
+
+	char sb_lockproto[GFS2_LOCKNAME_LEN];
+	char sb_locktable[GFS2_LOCKNAME_LEN];
+};
+
+/*
+ * resource index structure
+ */
+
+struct gfs2_rindex {
+	uint64_t ri_addr;	/* grp block disk address */
+	uint32_t ri_length;	/* length of rgrp header in fs blocks */
+	uint32_t ri_pad;
+
+	uint64_t ri_data0;	/* first data location */
+	uint32_t ri_data;	/* num of data blocks in rgrp */
+
+	uint32_t ri_bitbytes;	/* number of bytes in data bitmaps */
+
+	char ri_reserved[32];
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
+	uint32_t rg_flags;
+	uint32_t rg_free;
+	uint32_t rg_dinodes;
+
+	char rg_reserved[36];
+};
+
+/*
+ * quota structure
+ */
+
+struct gfs2_quota {
+	uint64_t qu_limit;
+	uint64_t qu_warn;
+	int64_t qu_value;
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
+#define GFS2_DIF_SYSTEM			0x00000001
+#define GFS2_DIF_JDATA			0x00000002
+#define GFS2_DIF_EXHASH			0x00000004
+#define GFS2_DIF_EA_INDIRECT		0x00000008
+#define GFS2_DIF_DIRECTIO		0x00000010
+#define GFS2_DIF_IMMUTABLE		0x00000020
+#define GFS2_DIF_APPENDONLY		0x00000040
+#define GFS2_DIF_NOATIME		0x00000080
+#define GFS2_DIF_SYNC			0x00000100
+#define GFS2_DIF_INHERIT_DIRECTIO	0x00000200
+#define GFS2_DIF_INHERIT_JDATA		0x00000400
+#define GFS2_DIF_TRUNC_IN_PROG		0x00000800
+
+struct gfs2_dinode {
+	struct gfs2_meta_header di_header;
+
+	struct gfs2_inum di_num;
+
+	uint32_t di_mode;	/* mode of file */
+	uint32_t di_uid;	/* owner's user id */
+	uint32_t di_gid;	/* owner's group id */
+	uint32_t di_nlink;	/* number of links to this file */
+	uint64_t di_size;	/* number of bytes in file */
+	uint64_t di_blocks;	/* number of blocks in file */
+	int64_t di_atime;	/* time last accessed */
+	int64_t di_mtime;	/* time last modified */
+	int64_t di_ctime;	/* time last changed */
+	uint32_t di_major;	/* device major number */
+	uint32_t di_minor;	/* device minor number */
+
+	uint64_t di_goal_meta;	/* rgrp to alloc from next */
+	uint64_t di_goal_data;	/* data block goal */
+
+	uint32_t di_flags;	/* GFS2_DIF_... */
+	uint32_t di_payload_format;  /* GFS2_FORMAT_... */
+	uint16_t di_height;	/* height of metadata */
+
+	/* These only apply to directories  */
+	uint16_t di_depth;	/* Number of bits in the table */
+	uint32_t di_entries;	/* The number of entries in the directory */
+
+	uint64_t di_eattr;	/* extended attribute block number */
+
+	char di_reserved[32];
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
+	uint32_t de_hash;
+	uint32_t de_rec_len;
+	uint8_t de_name_len;
+	uint8_t de_type;
+	uint16_t de_pad1;
+	uint32_t de_pad2;
+};
+
+/*
+ * Header of leaf directory nodes
+ */
+
+struct gfs2_leaf {
+	struct gfs2_meta_header lf_header;
+
+	uint16_t lf_depth;		/* Depth of leaf */
+	uint16_t lf_entries;		/* Number of dirents in leaf */
+	uint32_t lf_dirent_format;	/* Format of the dirents */
+	uint64_t lf_next;		/* Next leaf, if overflow */
+
+	char lf_reserved[32];
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
+	uint32_t ea_rec_len;
+	uint32_t ea_data_len;
+	uint8_t ea_name_len;	/* no NULL pointer after the string */
+	uint8_t ea_type;	/* GFS2_EATYPE_... */
+	uint8_t ea_flags;	/* GFS2_EAFLAG_... */
+	uint8_t ea_num_ptrs;
+	uint32_t ea_pad;
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
+	uint64_t lh_sequence;	/* Sequence number of this transaction */
+	uint32_t lh_flags;	/* GFS2_LOG_HEAD_... */
+	uint32_t lh_tail;	/* Block number of log tail */
+	uint32_t lh_blkno;
+	uint32_t lh_hash;
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
+struct gfs2_log_descriptor {
+	struct gfs2_meta_header ld_header;
+
+	uint32_t ld_type;	/* GFS2_LOG_DESC_... */
+	uint32_t ld_length;	/* Number of buffers in this chunk */
+	uint32_t ld_data1;	/* descriptor-specific field */
+	uint32_t ld_data2;	/* descriptor-specific field */
+
+	char ld_reserved[32];
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
+	uint64_t ir_start;
+	uint64_t ir_length;
+};
+
+/*
+ * Statfs change
+ * Describes an change to the pool of free and allocated
+ * blocks.
+ */
+
+struct gfs2_statfs_change {
+	int64_t sc_total;
+	int64_t sc_free;
+	int64_t sc_dinodes;
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
+	uint32_t ut_flags;	/* GFS2_UTF_... */
+	uint32_t ut_pad;
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
+	int64_t qc_change;
+	uint32_t qc_flags;	/* GFS2_QCF_... */
+	uint32_t qc_id;
+};
+
+/* Endian functions */
+
+#undef GFS2_ENDIAN_BIG
+
+#ifdef GFS2_ENDIAN_BIG
+
+#define gfs2_16_to_cpu be16_to_cpu
+#define gfs2_32_to_cpu be32_to_cpu
+#define gfs2_64_to_cpu be64_to_cpu
+
+#define cpu_to_gfs2_16 cpu_to_be16
+#define cpu_to_gfs2_32 cpu_to_be32
+#define cpu_to_gfs2_64 cpu_to_be64
+
+#else /* GFS2_ENDIAN_BIG */
+
+#define gfs2_16_to_cpu le16_to_cpu
+#define gfs2_32_to_cpu le32_to_cpu
+#define gfs2_64_to_cpu le64_to_cpu
+
+#define cpu_to_gfs2_16 cpu_to_le16
+#define cpu_to_gfs2_32 cpu_to_le32
+#define cpu_to_gfs2_64 cpu_to_le64
+
+#endif /* GFS2_ENDIAN_BIG */
+
+/* Translation functions */
+
+void gfs2_inum_in(struct gfs2_inum *no, char *buf);
+void gfs2_inum_out(struct gfs2_inum *no, char *buf);
+void gfs2_meta_header_in(struct gfs2_meta_header *mh, char *buf);
+void gfs2_meta_header_out(struct gfs2_meta_header *mh, char *buf);
+void gfs2_sb_in(struct gfs2_sb *sb, char *buf);
+void gfs2_sb_out(struct gfs2_sb *sb, char *buf);
+void gfs2_rindex_in(struct gfs2_rindex *ri, char *buf);
+void gfs2_rindex_out(struct gfs2_rindex *ri, char *buf);
+void gfs2_rgrp_in(struct gfs2_rgrp *rg, char *buf);
+void gfs2_rgrp_out(struct gfs2_rgrp *rg, char *buf);
+void gfs2_quota_in(struct gfs2_quota *qu, char *buf);
+void gfs2_quota_out(struct gfs2_quota *qu, char *buf);
+void gfs2_dinode_in(struct gfs2_dinode *di, char *buf);
+void gfs2_dinode_out(struct gfs2_dinode *di, char *buf);
+void gfs2_dirent_in(struct gfs2_dirent *de, char *buf);
+void gfs2_dirent_out(struct gfs2_dirent *de, char *buf);
+void gfs2_leaf_in(struct gfs2_leaf *lf, char *buf);
+void gfs2_leaf_out(struct gfs2_leaf *lf, char *buf);
+void gfs2_ea_header_in(struct gfs2_ea_header *ea, char *buf);
+void gfs2_ea_header_out(struct gfs2_ea_header *ea, char *buf);
+void gfs2_log_header_in(struct gfs2_log_header *lh, char *buf);
+void gfs2_log_header_out(struct gfs2_log_header *lh, char *buf);
+void gfs2_log_descriptor_in(struct gfs2_log_descriptor *ld, char *buf);
+void gfs2_log_descriptor_out(struct gfs2_log_descriptor *ld, char *buf);
+void gfs2_inum_range_in(struct gfs2_inum_range *ir, char *buf);
+void gfs2_inum_range_out(struct gfs2_inum_range *ir, char *buf);
+void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, char *buf);
+void gfs2_statfs_change_out(struct gfs2_statfs_change *sc, char *buf);
+void gfs2_unlinked_tag_in(struct gfs2_unlinked_tag *ut, char *buf);
+void gfs2_unlinked_tag_out(struct gfs2_unlinked_tag *ut, char *buf);
+void gfs2_quota_change_in(struct gfs2_quota_change *qc, char *buf);
+void gfs2_quota_change_out(struct gfs2_quota_change *qc, char *buf);
+
+/* Printing functions */
+
+void gfs2_inum_print(struct gfs2_inum *no);
+void gfs2_meta_header_print(struct gfs2_meta_header *mh);
+void gfs2_sb_print(struct gfs2_sb *sb);
+void gfs2_rindex_print(struct gfs2_rindex *ri);
+void gfs2_rgrp_print(struct gfs2_rgrp *rg);
+void gfs2_quota_print(struct gfs2_quota *qu);
+void gfs2_dinode_print(struct gfs2_dinode *di);
+void gfs2_dirent_print(struct gfs2_dirent *de, char *name);
+void gfs2_leaf_print(struct gfs2_leaf *lf);
+void gfs2_ea_header_print(struct gfs2_ea_header *ea, char *name);
+void gfs2_log_header_print(struct gfs2_log_header *lh);
+void gfs2_log_descriptor_print(struct gfs2_log_descriptor *ld);
+void gfs2_inum_range_print(struct gfs2_inum_range *ir);
+void gfs2_statfs_change_print(struct gfs2_statfs_change *sc);
+void gfs2_unlinked_tag_print(struct gfs2_unlinked_tag *ut);
+void gfs2_quota_change_print(struct gfs2_quota_change *qc);
+
+#endif /* __GFS2_ONDISK_DOT_H__ */
+
+
+
+#ifdef WANT_GFS2_CONVERSION_FUNCTIONS
+
+#define CPIN_08(s1, s2, member, count) {memcpy((s1->member), (s2->member), (count));}
+#define CPOUT_08(s1, s2, member, count) {memcpy((s2->member), (s1->member), (count));}
+#define CPIN_16(s1, s2, member) {(s1->member) = gfs2_16_to_cpu((s2->member));}
+#define CPOUT_16(s1, s2, member) {(s2->member) = cpu_to_gfs2_16((s1->member));}
+#define CPIN_32(s1, s2, member) {(s1->member) = gfs2_32_to_cpu((s2->member));}
+#define CPOUT_32(s1, s2, member) {(s2->member) = cpu_to_gfs2_32((s1->member));}
+#define CPIN_64(s1, s2, member) {(s1->member) = gfs2_64_to_cpu((s2->member));}
+#define CPOUT_64(s1, s2, member) {(s2->member) = cpu_to_gfs2_64((s1->member));}
+
+#define pv(struct, member, fmt) printk("  "#member" = "fmt"\n", struct->member);
+#define pa(struct, member, count) print_array(#member, struct->member, count);
+
+/**
+ * print_array - Print out an array of bytes
+ * @title: what to print before the array
+ * @buf: the array
+ * @count: the number of bytes
+ *
+ */
+
+static void print_array(char *title, char *buf, int count)
+{
+	int x;
+
+	printk("  %s =\n", title);
+	for (x = 0; x < count; x++) {
+		printk("%.2X ", (unsigned char)buf[x]);
+		if (x % 16 == 15)
+			printk("\n");
+	}
+	if (x % 16)
+		printk("\n");
+}
+
+/*
+ * gfs2_xxx_in - read in an xxx struct
+ * first arg: the cpu-order structure
+ * buf: the disk-order buffer
+ *
+ * gfs2_xxx_out - write out an xxx struct
+ * first arg: the cpu-order structure
+ * buf: the disk-order buffer
+ *
+ * gfs2_xxx_print - print out an xxx struct
+ * first arg: the cpu-order structure
+ */
+
+void gfs2_inum_in(struct gfs2_inum *no, char *buf)
+{
+	struct gfs2_inum *str = (struct gfs2_inum *)buf;
+
+	CPIN_64(no, str, no_formal_ino);
+	CPIN_64(no, str, no_addr);
+}
+
+void gfs2_inum_out(struct gfs2_inum *no, char *buf)
+{
+	struct gfs2_inum *str = (struct gfs2_inum *)buf;
+
+	CPOUT_64(no, str, no_formal_ino);
+	CPOUT_64(no, str, no_addr);
+}
+
+void gfs2_inum_print(struct gfs2_inum *no)
+{
+	pv(no, no_formal_ino, "%"PRIu64);
+	pv(no, no_addr, "%"PRIu64);
+}
+
+void gfs2_meta_header_in(struct gfs2_meta_header *mh, char *buf)
+{
+	struct gfs2_meta_header *str = (struct gfs2_meta_header *)buf;
+
+	CPIN_32(mh, str, mh_magic);
+	CPIN_16(mh, str, mh_type);
+	CPIN_16(mh, str, mh_format);
+	CPIN_64(mh, str, mh_blkno);
+}
+
+void gfs2_meta_header_out(struct gfs2_meta_header *mh, char *buf)
+{
+	struct gfs2_meta_header *str = (struct gfs2_meta_header *)buf;
+
+	CPOUT_32(mh, str, mh_magic);
+	CPOUT_16(mh, str, mh_type);
+	CPOUT_16(mh, str, mh_format);
+	CPOUT_64(mh, str, mh_blkno);
+}
+
+void gfs2_meta_header_print(struct gfs2_meta_header *mh)
+{
+	pv(mh, mh_magic, "0x%.8X");
+	pv(mh, mh_type, "%u");
+	pv(mh, mh_format, "%u");
+	pv(mh, mh_blkno, "%"PRIu64);
+}
+
+void gfs2_sb_in(struct gfs2_sb *sb, char *buf)
+{
+	struct gfs2_sb *str = (struct gfs2_sb *)buf;
+
+	gfs2_meta_header_in(&sb->sb_header, buf);
+
+	CPIN_32(sb, str, sb_fs_format);
+	CPIN_32(sb, str, sb_multihost_format);
+
+	CPIN_32(sb, str, sb_bsize);
+	CPIN_32(sb, str, sb_bsize_shift);
+
+	gfs2_inum_in(&sb->sb_master_dir, (char *)&str->sb_master_dir);
+
+	CPIN_08(sb, str, sb_lockproto, GFS2_LOCKNAME_LEN);
+	CPIN_08(sb, str, sb_locktable, GFS2_LOCKNAME_LEN);
+}
+
+void gfs2_sb_out(struct gfs2_sb *sb, char *buf)
+{
+	struct gfs2_sb *str = (struct gfs2_sb *)buf;
+
+	gfs2_meta_header_out(&sb->sb_header, buf);
+
+	CPOUT_32(sb, str, sb_fs_format);
+	CPOUT_32(sb, str, sb_multihost_format);
+
+	CPOUT_32(sb, str, sb_bsize);
+	CPOUT_32(sb, str, sb_bsize_shift);
+
+	gfs2_inum_out(&sb->sb_master_dir, (char *)&str->sb_master_dir);
+
+	CPOUT_08(sb, str, sb_lockproto, GFS2_LOCKNAME_LEN);
+	CPOUT_08(sb, str, sb_locktable, GFS2_LOCKNAME_LEN);
+}
+
+void gfs2_sb_print(struct gfs2_sb *sb)
+{
+	gfs2_meta_header_print(&sb->sb_header);
+
+	pv(sb, sb_fs_format, "%u");
+	pv(sb, sb_multihost_format, "%u");
+
+	pv(sb, sb_bsize, "%u");
+	pv(sb, sb_bsize_shift, "%u");
+
+	gfs2_inum_print(&sb->sb_master_dir);
+
+	pv(sb, sb_lockproto, "%s");
+	pv(sb, sb_locktable, "%s");
+}
+
+void gfs2_rindex_in(struct gfs2_rindex *ri, char *buf)
+{
+	struct gfs2_rindex *str = (struct gfs2_rindex *)buf;
+
+	CPIN_64(ri, str, ri_addr);
+	CPIN_32(ri, str, ri_length);
+	CPIN_32(ri, str, ri_pad);
+
+	CPIN_64(ri, str, ri_data0);
+	CPIN_32(ri, str, ri_data);
+
+	CPIN_32(ri, str, ri_bitbytes);
+
+	CPIN_08(ri, str, ri_reserved, 32);
+}
+
+void gfs2_rindex_out(struct gfs2_rindex *ri, char *buf)
+{
+	struct gfs2_rindex *str = (struct gfs2_rindex *)buf;
+
+	CPOUT_64(ri, str, ri_addr);
+	CPOUT_32(ri, str, ri_length);
+	CPOUT_32(ri, str, ri_pad);
+
+	CPOUT_64(ri, str, ri_data0);
+	CPOUT_32(ri, str, ri_data);
+
+	CPOUT_32(ri, str, ri_bitbytes);
+
+	CPOUT_08(ri, str, ri_reserved, 32);
+}
+
+void gfs2_rindex_print(struct gfs2_rindex *ri)
+{
+	pv(ri, ri_addr, "%"PRIu64);
+	pv(ri, ri_length, "%u");
+	pv(ri, ri_pad, "%u");
+
+	pv(ri, ri_data0, "%"PRIu64);
+	pv(ri, ri_data, "%u");
+
+	pv(ri, ri_bitbytes, "%u");
+
+	pa(ri, ri_reserved, 32);
+}
+
+void gfs2_rgrp_in(struct gfs2_rgrp *rg, char *buf)
+{
+	struct gfs2_rgrp *str = (struct gfs2_rgrp *)buf;
+
+	gfs2_meta_header_in(&rg->rg_header, buf);
+	CPIN_32(rg, str, rg_flags);
+	CPIN_32(rg, str, rg_free);
+	CPIN_32(rg, str, rg_dinodes);
+
+	CPIN_08(rg, str, rg_reserved, 36);
+}
+
+void gfs2_rgrp_out(struct gfs2_rgrp *rg, char *buf)
+{
+	struct gfs2_rgrp *str = (struct gfs2_rgrp *)buf;
+
+	gfs2_meta_header_out(&rg->rg_header, buf);
+	CPOUT_32(rg, str, rg_flags);
+	CPOUT_32(rg, str, rg_free);
+	CPOUT_32(rg, str, rg_dinodes);
+
+	CPOUT_08(rg, str, rg_reserved, 36);
+}
+
+void gfs2_rgrp_print(struct gfs2_rgrp *rg)
+{
+	gfs2_meta_header_print(&rg->rg_header);
+	pv(rg, rg_flags, "%u");
+	pv(rg, rg_free, "%u");
+	pv(rg, rg_dinodes, "%u");
+
+	pa(rg, rg_reserved, 36);
+}
+
+void gfs2_quota_in(struct gfs2_quota *qu, char *buf)
+{
+	struct gfs2_quota *str = (struct gfs2_quota *)buf;
+
+	CPIN_64(qu, str, qu_limit);
+	CPIN_64(qu, str, qu_warn);
+	CPIN_64(qu, str, qu_value);
+}
+
+void gfs2_quota_out(struct gfs2_quota *qu, char *buf)
+{
+	struct gfs2_quota *str = (struct gfs2_quota *)buf;
+
+	CPOUT_64(qu, str, qu_limit);
+	CPOUT_64(qu, str, qu_warn);
+	CPOUT_64(qu, str, qu_value);
+}
+
+void gfs2_quota_print(struct gfs2_quota *qu)
+{
+	pv(qu, qu_limit, "%"PRIu64);
+	pv(qu, qu_warn, "%"PRIu64);
+	pv(qu, qu_value, "%"PRId64);
+}
+
+void gfs2_dinode_in(struct gfs2_dinode *di, char *buf)
+{
+	struct gfs2_dinode *str = (struct gfs2_dinode *)buf;
+
+	gfs2_meta_header_in(&di->di_header, buf);
+	gfs2_inum_in(&di->di_num, (char *)&str->di_num);
+
+	CPIN_32(di, str, di_mode);
+	CPIN_32(di, str, di_uid);
+	CPIN_32(di, str, di_gid);
+	CPIN_32(di, str, di_nlink);
+	CPIN_64(di, str, di_size);
+	CPIN_64(di, str, di_blocks);
+	CPIN_64(di, str, di_atime);
+	CPIN_64(di, str, di_mtime);
+	CPIN_64(di, str, di_ctime);
+	CPIN_32(di, str, di_major);
+	CPIN_32(di, str, di_minor);
+
+	CPIN_64(di, str, di_goal_meta);
+	CPIN_64(di, str, di_goal_data);
+
+	CPIN_32(di, str, di_flags);
+	CPIN_32(di, str, di_payload_format);
+	CPIN_16(di, str, di_height);
+
+	CPIN_16(di, str, di_depth);
+	CPIN_32(di, str, di_entries);
+
+	CPIN_64(di, str, di_eattr);
+
+	CPIN_08(di, str, di_reserved, 32);
+}
+
+void gfs2_dinode_out(struct gfs2_dinode *di, char *buf)
+{
+	struct gfs2_dinode *str = (struct gfs2_dinode *)buf;
+
+	gfs2_meta_header_out(&di->di_header, buf);
+	gfs2_inum_out(&di->di_num, (char *)&str->di_num);
+
+	CPOUT_32(di, str, di_mode);
+	CPOUT_32(di, str, di_uid);
+	CPOUT_32(di, str, di_gid);
+	CPOUT_32(di, str, di_nlink);
+	CPOUT_64(di, str, di_size);
+	CPOUT_64(di, str, di_blocks);
+	CPOUT_64(di, str, di_atime);
+	CPOUT_64(di, str, di_mtime);
+	CPOUT_64(di, str, di_ctime);
+	CPOUT_32(di, str, di_major);
+	CPOUT_32(di, str, di_minor);
+
+	CPOUT_64(di, str, di_goal_meta);
+	CPOUT_64(di, str, di_goal_data);
+
+	CPOUT_32(di, str, di_flags);
+	CPOUT_32(di, str, di_payload_format);
+	CPOUT_16(di, str, di_height);
+
+	CPOUT_16(di, str, di_depth);
+	CPOUT_32(di, str, di_entries);
+
+	CPOUT_64(di, str, di_eattr);
+
+	CPOUT_08(di, str, di_reserved, 32);
+}
+
+void gfs2_dinode_print(struct gfs2_dinode *di)
+{
+	gfs2_meta_header_print(&di->di_header);
+	gfs2_inum_print(&di->di_num);
+
+	pv(di, di_mode, "0%o");
+	pv(di, di_uid, "%u");
+	pv(di, di_gid, "%u");
+	pv(di, di_nlink, "%u");
+	pv(di, di_size, "%"PRIu64);
+	pv(di, di_blocks, "%"PRIu64);
+	pv(di, di_atime, "%"PRId64);
+	pv(di, di_mtime, "%"PRId64);
+	pv(di, di_ctime, "%"PRId64);
+	pv(di, di_major, "%u");
+	pv(di, di_minor, "%u");
+
+	pv(di, di_goal_meta, "%"PRIu64);
+	pv(di, di_goal_data, "%"PRIu64);
+
+	pv(di, di_flags, "0x%.8X");
+	pv(di, di_payload_format, "%u");
+	pv(di, di_height, "%u");
+
+	pv(di, di_depth, "%u");
+	pv(di, di_entries, "%u");
+
+	pv(di, di_eattr, "%"PRIu64);
+
+	pa(di, di_reserved, 32);
+}
+
+void gfs2_dirent_in(struct gfs2_dirent *de, char *buf)
+{
+	struct gfs2_dirent *str = (struct gfs2_dirent *)buf;
+
+	gfs2_inum_in(&de->de_inum, buf);
+	CPIN_32(de, str, de_hash);
+	CPIN_32(de, str, de_rec_len);
+	de->de_name_len = str->de_name_len;
+	de->de_type = str->de_type;
+	CPIN_16(de, str, de_pad1);
+	CPIN_32(de, str, de_pad2);
+}
+
+void gfs2_dirent_out(struct gfs2_dirent *de, char *buf)
+{
+	struct gfs2_dirent *str = (struct gfs2_dirent *)buf;
+
+	gfs2_inum_out(&de->de_inum, buf);
+	CPOUT_32(de, str, de_hash);
+	CPOUT_32(de, str, de_rec_len);
+	str->de_name_len = de->de_name_len;
+	str->de_type = de->de_type;
+	CPOUT_16(de, str, de_pad1);
+	CPOUT_32(de, str, de_pad2);
+}
+
+void gfs2_dirent_print(struct gfs2_dirent *de, char *name)
+{
+	char buf[GFS2_FNAMESIZE + 1];
+
+	gfs2_inum_print(&de->de_inum);
+	pv(de, de_hash, "0x%.8X");
+	pv(de, de_rec_len, "%u");
+	pv(de, de_name_len, "%u");
+	pv(de, de_type, "%u");
+	pv(de, de_pad1, "%u");
+	pv(de, de_pad2, "%u");
+
+	memset(buf, 0, GFS2_FNAMESIZE + 1);
+	memcpy(buf, name, de->de_name_len);
+	printk("  name = %s\n", buf);
+}
+
+void gfs2_leaf_in(struct gfs2_leaf *lf, char *buf)
+{
+	struct gfs2_leaf *str = (struct gfs2_leaf *)buf;
+
+	gfs2_meta_header_in(&lf->lf_header, buf);
+	CPIN_16(lf, str, lf_depth);
+	CPIN_16(lf, str, lf_entries);
+	CPIN_32(lf, str, lf_dirent_format);
+	CPIN_64(lf, str, lf_next);
+
+	CPIN_08(lf, str, lf_reserved, 32);
+}
+
+void gfs2_leaf_out(struct gfs2_leaf *lf, char *buf)
+{
+	struct gfs2_leaf *str = (struct gfs2_leaf *)buf;
+
+	gfs2_meta_header_out(&lf->lf_header, buf);
+	CPOUT_16(lf, str, lf_depth);
+	CPOUT_16(lf, str, lf_entries);
+	CPOUT_32(lf, str, lf_dirent_format);
+	CPOUT_64(lf, str, lf_next);
+
+	CPOUT_08(lf, str, lf_reserved, 32);
+}
+
+void gfs2_leaf_print(struct gfs2_leaf *lf)
+{
+	gfs2_meta_header_print(&lf->lf_header);
+	pv(lf, lf_depth, "%u");
+	pv(lf, lf_entries, "%u");
+	pv(lf, lf_dirent_format, "%u");
+	pv(lf, lf_next, "%"PRIu64);
+
+	pa(lf, lf_reserved, 32);
+}
+
+void gfs2_ea_header_in(struct gfs2_ea_header *ea, char *buf)
+{
+	struct gfs2_ea_header *str = (struct gfs2_ea_header *)buf;
+
+	CPIN_32(ea, str, ea_rec_len);
+	CPIN_32(ea, str, ea_data_len);
+	ea->ea_name_len = str->ea_name_len;
+	ea->ea_type = str->ea_type;
+	ea->ea_flags = str->ea_flags;
+	ea->ea_num_ptrs = str->ea_num_ptrs;
+	CPIN_32(ea, str, ea_pad);
+}
+
+void gfs2_ea_header_out(struct gfs2_ea_header *ea, char *buf)
+{
+	struct gfs2_ea_header *str = (struct gfs2_ea_header *)buf;
+
+	CPOUT_32(ea, str, ea_rec_len);
+	CPOUT_32(ea, str, ea_data_len);
+	str->ea_name_len = ea->ea_name_len;
+	str->ea_type = ea->ea_type;
+	str->ea_flags = ea->ea_flags;
+	str->ea_num_ptrs = ea->ea_num_ptrs;
+	CPOUT_32(ea, str, ea_pad);
+}
+
+void gfs2_ea_header_print(struct gfs2_ea_header *ea, char *name)
+{
+	char buf[GFS2_EA_MAX_NAME_LEN + 1];
+
+	pv(ea, ea_rec_len, "%u");
+	pv(ea, ea_data_len, "%u");
+	pv(ea, ea_name_len, "%u");
+	pv(ea, ea_type, "%u");
+	pv(ea, ea_flags, "%u");
+	pv(ea, ea_num_ptrs, "%u");
+	pv(ea, ea_pad, "%u");
+
+	memset(buf, 0, GFS2_EA_MAX_NAME_LEN + 1);
+	memcpy(buf, name, ea->ea_name_len);
+	printk("  name = %s\n", buf);
+}
+
+void gfs2_log_header_in(struct gfs2_log_header *lh, char *buf)
+{
+	struct gfs2_log_header *str = (struct gfs2_log_header *)buf;
+
+	gfs2_meta_header_in(&lh->lh_header, buf);
+	CPIN_64(lh, str, lh_sequence);
+	CPIN_32(lh, str, lh_flags);
+	CPIN_32(lh, str, lh_tail);
+	CPIN_32(lh, str, lh_blkno);
+	CPIN_32(lh, str, lh_hash);
+}
+
+void gfs2_log_header_out(struct gfs2_log_header *lh, char *buf)
+{
+	struct gfs2_log_header *str = (struct gfs2_log_header *)buf;
+
+	gfs2_meta_header_out(&lh->lh_header, buf);
+	CPOUT_64(lh, str, lh_sequence);
+	CPOUT_32(lh, str, lh_flags);
+	CPOUT_32(lh, str, lh_tail);
+	CPOUT_32(lh, str, lh_blkno);
+	CPOUT_32(lh, str, lh_hash);
+}
+
+void gfs2_log_header_print(struct gfs2_log_header *lh)
+{
+	gfs2_meta_header_print(&lh->lh_header);
+	pv(lh, lh_sequence, "%"PRIu64);
+	pv(lh, lh_flags, "0x%.8X");
+	pv(lh, lh_tail, "%u");
+	pv(lh, lh_blkno, "%u");
+	pv(lh, lh_hash, "0x%.8X");
+}
+
+void gfs2_log_descriptor_in(struct gfs2_log_descriptor *ld, char *buf)
+{
+	struct gfs2_log_descriptor *str = (struct gfs2_log_descriptor *)buf;
+
+	gfs2_meta_header_in(&ld->ld_header, buf);
+	CPIN_32(ld, str, ld_type);
+	CPIN_32(ld, str, ld_length);
+	CPIN_32(ld, str, ld_data1);
+	CPIN_32(ld, str, ld_data2);
+
+	CPIN_08(ld, str, ld_reserved, 32);
+}
+
+void gfs2_log_descriptor_out(struct gfs2_log_descriptor *ld, char *buf)
+{
+	struct gfs2_log_descriptor *str = (struct gfs2_log_descriptor *)buf;
+
+	gfs2_meta_header_out(&ld->ld_header, buf);
+	CPOUT_32(ld, str, ld_type);
+	CPOUT_32(ld, str, ld_length);
+	CPOUT_32(ld, str, ld_data1);
+	CPOUT_32(ld, str, ld_data2);
+
+	CPOUT_08(ld, str, ld_reserved, 32);
+}
+
+void gfs2_log_descriptor_print(struct gfs2_log_descriptor *ld)
+{
+	gfs2_meta_header_print(&ld->ld_header);
+	pv(ld, ld_type, "%u");
+	pv(ld, ld_length, "%u");
+	pv(ld, ld_data1, "%u");
+	pv(ld, ld_data2, "%u");
+
+	pa(ld, ld_reserved, 32);
+}
+
+void gfs2_inum_range_in(struct gfs2_inum_range *ir, char *buf)
+{
+	struct gfs2_inum_range *str = (struct gfs2_inum_range *)buf;
+
+	CPIN_64(ir, str, ir_start);
+	CPIN_64(ir, str, ir_length);
+}
+
+void gfs2_inum_range_out(struct gfs2_inum_range *ir, char *buf)
+{
+	struct gfs2_inum_range *str = (struct gfs2_inum_range *)buf;
+
+	CPOUT_64(ir, str, ir_start);
+	CPOUT_64(ir, str, ir_length);
+}
+
+void gfs2_inum_range_print(struct gfs2_inum_range *ir)
+{
+	pv(ir, ir_start, "%"PRIu64);
+	pv(ir, ir_length, "%"PRIu64);
+}
+
+void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, char *buf)
+{
+	struct gfs2_statfs_change *str = (struct gfs2_statfs_change *)buf;
+
+	CPIN_64(sc, str, sc_total);
+	CPIN_64(sc, str, sc_free);
+	CPIN_64(sc, str, sc_dinodes);
+}
+
+void gfs2_statfs_change_out(struct gfs2_statfs_change *sc, char *buf)
+{
+	struct gfs2_statfs_change *str = (struct gfs2_statfs_change *)buf;
+
+	CPOUT_64(sc, str, sc_total);
+	CPOUT_64(sc, str, sc_free);
+	CPOUT_64(sc, str, sc_dinodes);
+}
+
+void gfs2_statfs_change_print(struct gfs2_statfs_change *sc)
+{
+	pv(sc, sc_total, "%"PRId64);
+	pv(sc, sc_free, "%"PRId64);
+	pv(sc, sc_dinodes, "%"PRId64);
+}
+
+void gfs2_unlinked_tag_in(struct gfs2_unlinked_tag *ut, char *buf)
+{
+	struct gfs2_unlinked_tag *str = (struct gfs2_unlinked_tag *)buf;
+
+	gfs2_inum_in(&ut->ut_inum, buf);
+	CPIN_32(ut, str, ut_flags);
+	CPIN_32(ut, str, ut_pad);
+}
+
+void gfs2_unlinked_tag_out(struct gfs2_unlinked_tag *ut, char *buf)
+{
+	struct gfs2_unlinked_tag *str = (struct gfs2_unlinked_tag *)buf;
+
+	gfs2_inum_out(&ut->ut_inum, buf);
+	CPOUT_32(ut, str, ut_flags);
+	CPOUT_32(ut, str, ut_pad);
+}
+
+void gfs2_unlinked_tag_print(struct gfs2_unlinked_tag *ut)
+{
+	gfs2_inum_print(&ut->ut_inum);
+	pv(ut, ut_flags, "%u");
+	pv(ut, ut_pad, "%u");
+}
+
+void gfs2_quota_change_in(struct gfs2_quota_change *qc, char *buf)
+{
+	struct gfs2_quota_change *str = (struct gfs2_quota_change *)buf;
+
+	CPIN_64(qc, str, qc_change);
+	CPIN_32(qc, str, qc_flags);
+	CPIN_32(qc, str, qc_id);
+}
+
+void gfs2_quota_change_out(struct gfs2_quota_change *qc, char *buf)
+{
+	struct gfs2_quota_change *str = (struct gfs2_quota_change *)buf;
+
+	CPOUT_64(qc, str, qc_change);
+	CPOUT_32(qc, str, qc_flags);
+	CPOUT_32(qc, str, qc_id);
+}
+
+void gfs2_quota_change_print(struct gfs2_quota_change *qc)
+{
+	pv(qc, qc_change, "%"PRId64);
+	pv(qc, qc_flags, "0x%.8X");
+	pv(qc, qc_id, "%u");
+}
+
+#endif /* WANT_GFS2_CONVERSION_FUNCTIONS */
+
