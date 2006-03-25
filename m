Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751967AbWCYX1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbWCYX1l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 18:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751968AbWCYX1l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 18:27:41 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:9400 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751967AbWCYX1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 18:27:39 -0500
Date: Sun, 26 Mar 2006 00:26:50 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
In-Reply-To: <20060321084619.E653275@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0603260024090.12891@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
 <20060321082327.B653275@wobbly.melbourne.sgi.com>
 <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
 <20060321084619.E653275@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the second patch in the row which tries to make every .h 'compile 
on its own'. It is not complete since the xfs directory (cvs copy) 
references things not present in ws (copy of 2.6.16, _not_ cvs).
(I know I should work on the full xfs cvs, but I did not want to download 
all that.)

diff --fast -pru ws~/fs/xfs/dmapi/xfs_dm.h ws/fs/xfs/dmapi/xfs_dm.h
--- ws~/fs/xfs/dmapi/xfs_dm.h	2006-02-15 03:48:07.000000000 +0100
+++ ws/fs/xfs/dmapi/xfs_dm.h	2006-03-25 23:46:04.315287000 +0100
@@ -18,9 +18,14 @@
 #ifndef __XFS_DM_H__
 #define __XFS_DM_H__
 
-extern int xfs_dm_get_fsys_vector(bhv_desc_t *, caddr_t);
+#include <linux/types.h>
+#include "xfs_types.h"
 
-extern xfs_dmops_t xfs_dmcore_xfs;
+struct bhv_desc;
+
+extern int xfs_dm_get_fsys_vector(struct bhv_desc *, caddr_t);
+
+extern struct xfs_dmops xfs_dmcore_xfs;
 extern struct file_system_type xfs_fs_type;
 extern struct filesystem_dmapi_operations xfs_dmapiops;
 
diff --fast -pru ws~/fs/xfs/linux-2.6/kmem.h ws/fs/xfs/linux-2.6/kmem.h
--- ws~/fs/xfs/linux-2.6/kmem.h	2006-03-06 15:18:30.000000000 +0100
+++ ws/fs/xfs/linux-2.6/kmem.h	2006-03-25 23:12:21.925287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_SUPPORT_KMEM_H__
 #define __XFS_SUPPORT_KMEM_H__
 
+#include <linux/compiler.h>
+#include <linux/gfp.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_aops.h ws/fs/xfs/linux-2.6/xfs_aops.h
--- ws~/fs/xfs/linux-2.6/xfs_aops.h	2006-03-06 15:19:18.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_aops.h	2006-03-25 23:19:08.925287000 +0100
@@ -18,6 +18,13 @@
 #ifndef __XFS_AOPS_H__
 #define __XFS_AOPS_H__
 
+#include <asm/atomic.h>
+#include <linux/mempool.h>
+#include <linux/workqueue.h>
+#include "xfs_types.h"
+
+struct inode;
+
 extern struct workqueue_struct *xfsdatad_workqueue;
 extern mempool_t *xfs_ioend_pool;
 
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_buf.h ws/fs/xfs/linux-2.6/xfs_buf.h
--- ws~/fs/xfs/linux-2.6/xfs_buf.h	2005-12-17 12:31:50.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_buf.h	2006-03-26 00:17:38.675287000 +0100
@@ -28,6 +28,9 @@
 #include <linux/buffer_head.h>
 #include <linux/uio.h>
 
+#include <xfs_lrw.h>
+#include "xfs_types.h"
+
 /*
  *	Base types
  */
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_export.h ws/fs/xfs/linux-2.6/xfs_export.h
--- ws~/fs/xfs/linux-2.6/xfs_export.h	2006-03-25 21:10:19.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_export.h	2006-03-25 23:29:33.815287000 +0100
@@ -18,6 +18,10 @@
 #ifndef __XFS_EXPORT_H__
 #define __XFS_EXPORT_H__
 
+#include <asm/types.h>
+#include <linux/fs.h>
+#include "xfs_fs.h"
+
 /*
  * Common defines for code related to exporting XFS filesystems over NFS.
  *
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_fs_subr.h ws/fs/xfs/linux-2.6/xfs_fs_subr.h
--- ws~/fs/xfs/linux-2.6/xfs_fs_subr.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/linux-2.6/xfs_fs_subr.h	2006-03-25 23:30:52.135287000 +0100
@@ -18,12 +18,17 @@
 #ifndef	__XFS_FS_SUBR_H__
 #define __XFS_FS_SUBR_H__
 
+#include <linux/types.h>
+#include "xfs_types.h"
+
+struct bhv_desc;
 struct cred;
+
 extern int  fs_noerr(void);
 extern int  fs_nosys(void);
 extern void fs_noval(void);
-extern void fs_tosspages(bhv_desc_t *, xfs_off_t, xfs_off_t, int);
-extern void fs_flushinval_pages(bhv_desc_t *, xfs_off_t, xfs_off_t, int);
-extern int  fs_flush_pages(bhv_desc_t *, xfs_off_t, xfs_off_t, uint64_t, int);
+extern void fs_tosspages(struct bhv_desc *, xfs_off_t, xfs_off_t, int);
+extern void fs_flushinval_pages(struct bhv_desc *, xfs_off_t, xfs_off_t, int);
+extern int  fs_flush_pages(struct bhv_desc *, xfs_off_t, xfs_off_t, uint64_t, int);
 
 #endif	/* __XFS_FS_SUBR_H__ */
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_globals.h ws/fs/xfs/linux-2.6/xfs_globals.h
--- ws~/fs/xfs/linux-2.6/xfs_globals.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/linux-2.6/xfs_globals.h	2006-03-25 23:31:10.535287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_GLOBALS_H__
 #define __XFS_GLOBALS_H__
 
+#include <linux/types.h>
+
 extern uint64_t	xfs_panic_mask;		/* set to cause more panics */
 extern unsigned long xfs_physmem;
 extern struct cred *sys_cred;
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_ioctl32.h ws/fs/xfs/linux-2.6/xfs_ioctl32.h
--- ws~/fs/xfs/linux-2.6/xfs_ioctl32.h	2006-03-20 03:46:07.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_ioctl32.h	2006-03-25 23:31:29.215287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_IOCTL32_H__
 #define __XFS_IOCTL32_H__
 
+struct file;
+
 extern long xfs_file_compat_ioctl(struct file *, unsigned, unsigned long);
 extern long xfs_file_compat_invis_ioctl(struct file *, unsigned, unsigned long);
 
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_iops.h ws/fs/xfs/linux-2.6/xfs_iops.h
--- ws~/fs/xfs/linux-2.6/xfs_iops.h	2006-03-06 15:20:54.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_iops.h	2006-03-25 23:32:29.695287000 +0100
@@ -18,6 +18,13 @@
 #ifndef __XFS_IOPS_H__
 #define __XFS_IOPS_H__
 
+#include <linux/compiler.h>
+
+struct bhv_desc;
+struct file;
+struct inode;
+struct xfs_inode;
+
 extern struct inode_operations xfs_inode_operations;
 extern struct inode_operations xfs_dir_inode_operations;
 extern struct inode_operations xfs_symlink_inode_operations;
@@ -29,7 +36,6 @@ extern struct file_operations xfs_invis_
 extern int xfs_ioctl(struct bhv_desc *, struct inode *, struct file *,
                         int, unsigned int, void __user *);
 
-struct xfs_inode;
 extern void xfs_ichgtime(struct xfs_inode *, int);
 extern void xfs_ichgtime_fast(struct xfs_inode *, struct inode *, int);
 
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_lrw.h ws/fs/xfs/linux-2.6/xfs_lrw.h
--- ws~/fs/xfs/linux-2.6/xfs_lrw.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/linux-2.6/xfs_lrw.h	2006-03-25 23:26:43.925287000 +0100
@@ -18,8 +18,15 @@
 #ifndef __XFS_LRW_H__
 #define __XFS_LRW_H__
 
+#include <linux/fs.h>           /* read_actor_t */
+#include <linux/types.h>        /* ssize_t */
+#include "xfs_types.h"
+
 struct vnode;
 struct bhv_desc;
+struct cred;
+struct iovec;
+struct kiocb;
 struct xfs_mount;
 struct xfs_iocore;
 struct xfs_inode;
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_stats.h ws/fs/xfs/linux-2.6/xfs_stats.h
--- ws~/fs/xfs/linux-2.6/xfs_stats.h	2005-12-17 12:31:50.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_stats.h	2006-03-25 23:37:39.235287000 +0100
@@ -21,7 +21,9 @@
 
 #if defined(CONFIG_PROC_FS) && !defined(XFS_STATS_OFF)
 
+#include <asm/types.h>
 #include <linux/percpu.h>
+#include "xfs_types.h"
 
 /*
  * XFS global statistics
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_super.h ws/fs/xfs/linux-2.6/xfs_super.h
--- ws~/fs/xfs/linux-2.6/xfs_super.h	2006-03-17 15:28:04.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_super.h	2006-03-25 23:38:47.435287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_SUPER_H__
 #define __XFS_SUPER_H__
 
+#include "xfs_types.h"
+
 #ifdef CONFIG_XFS_POSIX_ACL
 # define XFS_ACL_STRING		"ACLs, "
 # define set_posix_acl_flag(sb)	((sb)->s_flags |= MS_POSIXACL)
@@ -69,15 +71,17 @@
 				XFS_TRACE_STRING \
 				XFS_DBG_STRING /* DBG must be last */
 
+struct bhv_desc;
+struct block_device;
+struct vnode;
 struct xfs_inode;
 struct xfs_mount;
 struct xfs_buftarg;
-struct block_device;
 
 extern __uint64_t xfs_max_file_offset(unsigned int);
 
-extern struct inode *xfs_get_inode(bhv_desc_t *, xfs_ino_t, int);
-extern void xfs_initialize_vnode(bhv_desc_t *, vnode_t *, bhv_desc_t *, int);
+extern struct inode *xfs_get_inode(struct bhv_desc *, xfs_ino_t, int);
+extern void xfs_initialize_vnode(struct bhv_desc *, struct vnode *, struct bhv_desc *, int);
 
 extern void xfs_flush_inode(struct xfs_inode *);
 extern void xfs_flush_device(struct xfs_inode *);
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_vfs.h ws/fs/xfs/linux-2.6/xfs_vfs.h
--- ws~/fs/xfs/linux-2.6/xfs_vfs.h	2006-03-25 21:10:19.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_vfs.h	2006-03-25 23:41:08.605287000 +0100
@@ -18,14 +18,20 @@
 #ifndef __XFS_VFS_H__
 #define __XFS_VFS_H__
 
+#include <linux/list.h>
+#include <linux/spinlock.h>
 #include <linux/vfs.h>
+#include <linux/wait.h>
+#include "xfs_behavior.h"
 #include "xfs_fs.h"
+#include "xfs_types.h"
 
 struct fid;
 struct vfs;
 struct cred;
 struct vnode;
 struct kstatfs;
+struct module;
 struct seq_file;
 struct super_block;
 struct xfs_mount_args;
diff --fast -pru ws~/fs/xfs/linux-2.6/xfs_vnode.h ws/fs/xfs/linux-2.6/xfs_vnode.h
--- ws~/fs/xfs/linux-2.6/xfs_vnode.h	2006-03-17 15:28:04.000000000 +0100
+++ ws/fs/xfs/linux-2.6/xfs_vnode.h	2006-03-25 23:44:12.215287000 +0100
@@ -45,7 +45,15 @@
 #ifndef __XFS_VNODE_H__
 #define __XFS_VNODE_H__
 
+#include <linux/fs.h>
+#include <linux/spinlock.h>
+#include "xfs_behavior.h"
+#include "xfs_fs.h"
+#include "xfs_types.h"
+
 struct uio;
+struct cred;
+struct fid;
 struct file;
 struct vattr;
 struct xfs_iomap;
@@ -490,7 +498,7 @@ extern vnode_t	*vn_initialize(struct ino
  * vnode_map structures _must_ match vn_epoch and vnode structure sizes.
  */
 typedef struct vnode_map {
-	vfs_t		*v_vfsp;
+	struct vfs	*v_vfsp;
 	vnumber_t	v_number;		/* in-core vnode number */
 	xfs_ino_t	v_ino;			/* inode #	*/
 } vmap_t;
diff --fast -pru ws~/fs/xfs/quota/xfs_dquot.h ws/fs/xfs/quota/xfs_dquot.h
--- ws~/fs/xfs/quota/xfs_dquot.h	2005-09-26 05:46:03.000000000 +0200
+++ ws/fs/xfs/quota/xfs_dquot.h	2006-03-25 23:56:11.155287000 +0100
@@ -18,6 +18,12 @@
 #ifndef __XFS_DQUOT_H__
 #define __XFS_DQUOT_H__
 
+#include <mutex.h>
+#include <sv.h>
+#include "quota/xfs_dquot_item.h"
+#include "xfs_quota.h"
+#include "xfs_types.h"
+
 /*
  * Dquots are structures that hold quota information about a user or a group,
  * much like inodes are for files. In fact, dquots share many characteristics
@@ -44,9 +50,6 @@ typedef struct xfs_dqlink {
 	struct xfs_dquot **ql_prevp;	/* pointer to prev ql_next */
 } xfs_dqlink_t;
 
-struct xfs_mount;
-struct xfs_trans;
-
 /*
  * This is the marker which is designed to occupy the first few
  * bytes of the xfs_dquot_t structure. Even inside this, the freelist pointers
@@ -174,11 +177,11 @@ extern void		xfs_qm_dqunpin_wait(xfs_dqu
 extern int		xfs_qm_dqlock_nowait(xfs_dquot_t *);
 extern int		xfs_qm_dqflock_nowait(xfs_dquot_t *);
 extern void		xfs_qm_dqflock_pushbuf_wait(xfs_dquot_t *dqp);
-extern void		xfs_qm_adjust_dqtimers(xfs_mount_t *,
+extern void		xfs_qm_adjust_dqtimers(struct xfs_mount *,
 					xfs_disk_dquot_t *);
-extern void		xfs_qm_adjust_dqlimits(xfs_mount_t *,
+extern void		xfs_qm_adjust_dqlimits(struct xfs_mount *,
 					xfs_disk_dquot_t *);
-extern int		xfs_qm_dqget(xfs_mount_t *, xfs_inode_t *,
+extern int		xfs_qm_dqget(struct xfs_mount *, struct xfs_inode *,
 					xfs_dqid_t, uint, uint, xfs_dquot_t **);
 extern void		xfs_qm_dqput(xfs_dquot_t *);
 extern void		xfs_qm_dqrele(xfs_dquot_t *);
diff --fast -pru ws~/fs/xfs/quota/xfs_dquot_item.h ws/fs/xfs/quota/xfs_dquot_item.h
--- ws~/fs/xfs/quota/xfs_dquot_item.h	2005-09-26 05:46:03.000000000 +0200
+++ ws/fs/xfs/quota/xfs_dquot_item.h	2006-03-25 23:56:34.055287000 +0100
@@ -18,10 +18,8 @@
 #ifndef __XFS_DQUOT_ITEM_H__
 #define __XFS_DQUOT_ITEM_H__
 
-struct xfs_dquot;
-struct xfs_trans;
-struct xfs_mount;
-struct xfs_qoff_logitem;
+#include "xfs_quota.h"
+#include "xfs_trans.h"
 
 typedef struct xfs_dq_logitem {
 	xfs_log_item_t		 qli_item;	   /* common portion */
diff --fast -pru ws~/fs/xfs/quota/xfs_qm.h ws/fs/xfs/quota/xfs_qm.h
--- ws~/fs/xfs/quota/xfs_qm.h	2006-01-25 01:34:27.000000000 +0100
+++ ws/fs/xfs/quota/xfs_qm.h	2006-03-26 00:00:55.085287000 +0100
@@ -18,13 +18,13 @@
 #ifndef __XFS_QM_H__
 #define __XFS_QM_H__
 
+#include <spin.h>
 #include "xfs_dquot_item.h"
 #include "xfs_dquot.h"
 #include "xfs_quota_priv.h"
 #include "xfs_qm_stats.h"
 
-struct xfs_qm;
-struct xfs_inode;
+struct bhv_desc;
 
 extern uint		ndquot;
 extern mutex_t		xfs_Gqm_lock;
@@ -110,8 +110,8 @@ typedef struct xfs_qm {
  * The mount structure keeps a pointer to this.
  */
 typedef struct xfs_quotainfo {
-	xfs_inode_t	*qi_uquotaip;	 /* user quota inode */
-	xfs_inode_t	*qi_gquotaip;	 /* group quota inode */
+	struct xfs_inode	*qi_uquotaip;	 /* user quota inode */
+	struct xfs_inode	*qi_gquotaip;	 /* group quota inode */
 	lock_t		 qi_pinlock;	 /* dquot pinning mutex */
 	xfs_dqlist_t	 qi_dqlist;	 /* all dquots in filesys */
 	int		 qi_dqreclaims;	 /* a change here indicates
@@ -137,7 +137,7 @@ typedef struct xfs_quotainfo {
 extern xfs_dqtrxops_t	xfs_trans_dquot_ops;
 
 extern void	xfs_trans_mod_dquot(xfs_trans_t *, xfs_dquot_t *, uint, long);
-extern int	xfs_trans_reserve_quota_bydquots(xfs_trans_t *, xfs_mount_t *,
+extern int	xfs_trans_reserve_quota_bydquots(xfs_trans_t *, struct xfs_mount *,
 			xfs_dquot_t *, xfs_dquot_t *, long, long, uint);
 extern void	xfs_trans_dqjoin(xfs_trans_t *, xfs_dquot_t *);
 extern void	xfs_trans_log_dquot(xfs_trans_t *, xfs_dquot_t *);
@@ -170,33 +170,33 @@ typedef struct xfs_dquot_acct {
 #define XFS_QM_HOLD(xqm)	((xqm)->qm_nrefs++)
 #define XFS_QM_RELE(xqm)	((xqm)->qm_nrefs--)
 
-extern void		xfs_qm_destroy_quotainfo(xfs_mount_t *);
-extern int		xfs_qm_mount_quotas(xfs_mount_t *, int);
-extern void		xfs_qm_mount_quotainit(xfs_mount_t *, uint);
-extern int		xfs_qm_quotacheck(xfs_mount_t *);
-extern void		xfs_qm_unmount_quotadestroy(xfs_mount_t *);
-extern int		xfs_qm_unmount_quotas(xfs_mount_t *);
-extern int		xfs_qm_write_sb_changes(xfs_mount_t *, __int64_t);
-extern int		xfs_qm_sync(xfs_mount_t *, short);
+extern void		xfs_qm_destroy_quotainfo(struct xfs_mount *);
+extern int		xfs_qm_mount_quotas(struct xfs_mount *, int);
+extern void		xfs_qm_mount_quotainit(struct xfs_mount *, uint);
+extern int		xfs_qm_quotacheck(struct xfs_mount *);
+extern void		xfs_qm_unmount_quotadestroy(struct xfs_mount *);
+extern int		xfs_qm_unmount_quotas(struct xfs_mount *);
+extern int		xfs_qm_write_sb_changes(struct xfs_mount *, __int64_t);
+extern int		xfs_qm_sync(struct xfs_mount *, short);
 
 /* dquot stuff */
 extern boolean_t	xfs_qm_dqalloc_incore(xfs_dquot_t **);
-extern int		xfs_qm_dqattach(xfs_inode_t *, uint);
-extern void		xfs_qm_dqdetach(xfs_inode_t *);
-extern int		xfs_qm_dqpurge_all(xfs_mount_t *, uint);
-extern void		xfs_qm_dqrele_all_inodes(xfs_mount_t *, uint);
+extern int		xfs_qm_dqattach(struct xfs_inode *, uint);
+extern void		xfs_qm_dqdetach(struct xfs_inode *);
+extern int		xfs_qm_dqpurge_all(struct xfs_mount *, uint);
+extern void		xfs_qm_dqrele_all_inodes(struct xfs_mount *, uint);
 
 /* vop stuff */
-extern int		xfs_qm_vop_dqalloc(xfs_mount_t *, xfs_inode_t *,
+extern int		xfs_qm_vop_dqalloc(struct xfs_mount *, struct xfs_inode *,
 					uid_t, gid_t, prid_t, uint,
 					xfs_dquot_t **, xfs_dquot_t **);
 extern void		xfs_qm_vop_dqattach_and_dqmod_newinode(
-					xfs_trans_t *, xfs_inode_t *,
+					xfs_trans_t *, struct xfs_inode *,
 					xfs_dquot_t *, xfs_dquot_t *);
-extern int		xfs_qm_vop_rename_dqattach(xfs_inode_t **);
-extern xfs_dquot_t *	xfs_qm_vop_chown(xfs_trans_t *, xfs_inode_t *,
+extern int		xfs_qm_vop_rename_dqattach(struct xfs_inode **);
+extern xfs_dquot_t *	xfs_qm_vop_chown(xfs_trans_t *, struct xfs_inode *,
 					xfs_dquot_t **, xfs_dquot_t *);
-extern int		xfs_qm_vop_chown_reserve(xfs_trans_t *, xfs_inode_t *,
+extern int		xfs_qm_vop_chown_reserve(xfs_trans_t *, struct xfs_inode *,
 					xfs_dquot_t *, xfs_dquot_t *, uint);
 
 /* list stuff */
@@ -205,10 +205,10 @@ extern void		xfs_qm_freelist_unlink(xfs_
 extern int		xfs_qm_freelist_lock_nowait(xfs_qm_t *);
 
 /* system call interface */
-extern int		xfs_qm_quotactl(bhv_desc_t *, int, int, xfs_caddr_t);
+extern int		xfs_qm_quotactl(struct bhv_desc *, int, int, xfs_caddr_t);
 
 #ifdef DEBUG
-extern int		xfs_qm_internalqcheck(xfs_mount_t *);
+extern int		xfs_qm_internalqcheck(struct xfs_mount *);
 #else
 #define xfs_qm_internalqcheck(mp)	(0)
 #endif
diff --fast -pru ws~/fs/xfs/quota/xfs_qm_stats.h ws/fs/xfs/quota/xfs_qm_stats.h
--- ws~/fs/xfs/quota/xfs_qm_stats.h	2005-09-26 05:46:03.000000000 +0200
+++ ws/fs/xfs/quota/xfs_qm_stats.h	2006-03-26 00:01:13.795287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_QM_STATS_H__
 #define __XFS_QM_STATS_H__
 
+#include "xfs_types.h"
+
 #if defined(CONFIG_PROC_FS) && !defined(XFS_STATS_OFF)
 
 /*
diff --fast -pru ws~/fs/xfs/support/move.h ws/fs/xfs/support/move.h
--- ws~/fs/xfs/support/move.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/support/move.h	2006-03-26 00:03:26.295287000 +0100
@@ -47,6 +47,7 @@
 
 #include <linux/uio.h>
 #include <asm/uaccess.h>
+#include "xfs_types.h"
 
 /* Segment flag values. */
 enum uio_seg {
diff --fast -pru ws~/fs/xfs/support/qsort.h ws/fs/xfs/support/qsort.h
--- ws~/fs/xfs/support/qsort.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/support/qsort.h	2006-03-26 00:03:52.865287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_SUPPORT_QSORT_H__
 #define __XFS_SUPPORT_QSORT_H__
 
+#include <linux/types.h>
+
 extern void qsort(void *const pbase, size_t total_elems, size_t size,
 		  int (*cmp)(const void *, const void *));
 
diff --fast -pru ws~/fs/xfs/support/uuid.h ws/fs/xfs/support/uuid.h
--- ws~/fs/xfs/support/uuid.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/support/uuid.h	2006-03-26 00:04:16.305287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_SUPPORT_UUID_H__
 #define __XFS_SUPPORT_UUID_H__
 
+#include "xfs_types.h"
+
 typedef struct {
 	unsigned char	__u_bits[16];
 } uuid_t;
diff --fast -pru ws~/fs/xfs/xfs_acl.h ws/fs/xfs/xfs_acl.h
--- ws~/fs/xfs/xfs_acl.h	2006-03-25 21:10:18.000000000 +0100
+++ ws/fs/xfs/xfs_acl.h	2006-03-26 00:06:06.045287000 +0100
@@ -18,6 +18,9 @@
 #ifndef __XFS_ACL_H__
 #define __XFS_ACL_H__
 
+#include <linux/types.h>
+#include "xfs_types.h"
+
 /*
  * Access Control Lists
  */
@@ -49,6 +52,7 @@ typedef struct xfs_acl {
 
 #ifdef CONFIG_XFS_POSIX_ACL
 
+struct cred;
 struct vattr;
 struct vnode;
 struct xfs_inode;
@@ -59,7 +63,7 @@ extern struct kmem_zone *xfs_acl_zone;
 #define xfs_acl_zone_destroy(zone)	kmem_zone_destroy(zone)
 
 extern int xfs_acl_inherit(struct vnode *, struct vattr *, xfs_acl_t *);
-extern int xfs_acl_iaccess(struct xfs_inode *, mode_t, cred_t *);
+extern int xfs_acl_iaccess(struct xfs_inode *, mode_t, struct cred *);
 extern int xfs_acl_vtoacl(struct vnode *, xfs_acl_t *, xfs_acl_t *);
 extern int xfs_acl_vhasacl_access(struct vnode *);
 extern int xfs_acl_vhasacl_default(struct vnode *);
diff --fast -pru ws~/fs/xfs/xfs_ag.h ws/fs/xfs/xfs_ag.h
--- ws~/fs/xfs/xfs_ag.h	2006-03-25 21:10:18.000000000 +0100
+++ ws/fs/xfs/xfs_ag.h	2006-03-26 00:07:29.455287000 +0100
@@ -18,6 +18,11 @@
 #ifndef __XFS_AG_H__
 #define	__XFS_AG_H__
 
+#include <linux/types.h>
+#include <spin.h>
+#include "xfs_inum.h"
+#include "xfs_types.h"
+
 /*
  * Allocation group header
  * This is divided into three structures, placed in sequential 512-byte
diff --fast -pru ws~/fs/xfs/xfs_alloc.h ws/fs/xfs/xfs_alloc.h
--- ws~/fs/xfs/xfs_alloc.h	2006-03-25 21:10:18.000000000 +0100
+++ ws/fs/xfs/xfs_alloc.h	2006-03-26 00:08:07.455287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_ALLOC_H__
 #define	__XFS_ALLOC_H__
 
+#include "xfs_types.h"
+
 struct xfs_buf;
 struct xfs_mount;
 struct xfs_perag;
@@ -173,13 +175,13 @@ xfs_free_extent(
 	xfs_extlen_t	len);	/* length of extent */
 
 void
-xfs_alloc_mark_busy(xfs_trans_t *tp,
+xfs_alloc_mark_busy(struct xfs_trans *tp,
 		xfs_agnumber_t agno,
 		xfs_agblock_t bno,
 		xfs_extlen_t len);
 
 void
-xfs_alloc_clear_busy(xfs_trans_t *tp,
+xfs_alloc_clear_busy(struct xfs_trans *tp,
 		xfs_agnumber_t ag,
 		int idx);
 
diff --fast -pru ws~/fs/xfs/xfs_alloc_btree.h ws/fs/xfs/xfs_alloc_btree.h
--- ws~/fs/xfs/xfs_alloc_btree.h	2005-10-21 20:08:47.000000000 +0200
+++ ws/fs/xfs/xfs_alloc_btree.h	2006-03-26 00:08:31.585287000 +0100
@@ -18,6 +18,9 @@
 #ifndef __XFS_ALLOC_BTREE_H__
 #define	__XFS_ALLOC_BTREE_H__
 
+#include <linux/types.h>
+#include "xfs_types.h"
+
 /*
  * Freespace on-disk structures
  */
diff --fast -pru ws~/fs/xfs/xfs_arch.h ws/fs/xfs/xfs_arch.h
--- ws~/fs/xfs/xfs_arch.h	2006-03-25 22:24:11.255287000 +0100
+++ ws/fs/xfs/xfs_arch.h	2006-03-25 23:34:09.425287000 +0100
@@ -25,6 +25,8 @@
 #ifdef __KERNEL__
 
 #include <asm/byteorder.h>
+#include <asm/types.h>
+#include "xfs_types.h"
 
 #ifdef __BIG_ENDIAN
 #define	XFS_NATIVE_HOST	1
diff --fast -pru ws~/fs/xfs/xfs_attr.h ws/fs/xfs/xfs_attr.h
--- ws~/fs/xfs/xfs_attr.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/xfs_attr.h	2006-03-26 00:09:18.815287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_ATTR_H__
 #define	__XFS_ATTR_H__
 
+#include <linux/types.h>
+
 /*
  * xfs_attr.h
  *
@@ -35,6 +37,7 @@
  * External interfaces
  *========================================================================*/
 
+struct bhv_desc;
 struct cred;
 struct vnode;
 
@@ -158,10 +161,10 @@ struct xfs_da_args;
 /*
  * Overall external interface routines.
  */
-int xfs_attr_get(bhv_desc_t *, const char *, char *, int *, int, struct cred *);
-int xfs_attr_set(bhv_desc_t *, const char *, char *, int, int, struct cred *);
-int xfs_attr_remove(bhv_desc_t *, const char *, int, struct cred *);
-int xfs_attr_list(bhv_desc_t *, char *, int, int,
+int xfs_attr_get(struct bhv_desc *, const char *, char *, int *, int, struct cred *);
+int xfs_attr_set(struct bhv_desc *, const char *, char *, int, int, struct cred *);
+int xfs_attr_remove(struct bhv_desc *, const char *, int, struct cred *);
+int xfs_attr_list(struct bhv_desc *, char *, int, int,
 			 struct attrlist_cursor_kern *, struct cred *);
 int xfs_attr_inactive(struct xfs_inode *dp);
 
diff --fast -pru ws~/fs/xfs/xfs_attr_leaf.h ws/fs/xfs/xfs_attr_leaf.h
--- ws~/fs/xfs/xfs_attr_leaf.h	2006-03-17 15:44:48.000000000 +0100
+++ ws/fs/xfs/xfs_attr_leaf.h	2006-03-26 00:12:13.175287000 +0100
@@ -18,6 +18,10 @@
 #ifndef __XFS_ATTR_LEAF_H__
 #define	__XFS_ATTR_LEAF_H__
 
+#include <asm/byteorder.h>
+#include <linux/types.h>
+#include "xfs_da_btree.h"
+
 /*
  * Attribute storage layout, internal structure, access macros, etc.
  *
@@ -232,7 +236,7 @@ int	xfs_attr_shortform_to_leaf(struct xf
 int	xfs_attr_shortform_remove(struct xfs_da_args *args);
 int	xfs_attr_shortform_list(struct xfs_attr_list_context *context);
 int	xfs_attr_shortform_allfit(struct xfs_dabuf *bp, struct xfs_inode *dp);
-int	xfs_attr_shortform_bytesfit(xfs_inode_t *dp, int bytes);
+int	xfs_attr_shortform_bytesfit(struct xfs_inode *dp, int bytes);
 
 
 /*
diff --fast -pru ws~/fs/xfs/xfs_attr_sf.h ws/fs/xfs/xfs_attr_sf.h
--- ws~/fs/xfs/xfs_attr_sf.h	2006-03-17 15:45:34.000000000 +0100
+++ ws/fs/xfs/xfs_attr_sf.h	2006-03-26 00:12:33.025287000 +0100
@@ -18,6 +18,9 @@
 #ifndef __XFS_ATTR_SF_H__
 #define	__XFS_ATTR_SF_H__
 
+#include <linux/types.h>
+#include "xfs_types.h"
+
 /*
  * Attribute storage when stored inside the inode.
  *
diff --fast -pru ws~/fs/xfs/xfs_behavior.h ws/fs/xfs/xfs_behavior.h
--- ws~/fs/xfs/xfs_behavior.h	2006-03-25 21:10:18.000000000 +0100
+++ ws/fs/xfs/xfs_behavior.h	2006-03-25 23:35:45.865287000 +0100
@@ -78,7 +78,13 @@
  *
  */
 
+#include <asm/types.h>
+#include <linux/stddef.h>
+
 struct bhv_head_lock;
+struct vnode;
+struct vnodeops;
+struct xfs_inode;
 
 /*
  * Behavior head.  Head of the chain of behaviors.
@@ -183,6 +173,24 @@ extern bhv_desc_t *	bhv_lookup(bhv_head_
 extern bhv_desc_t *	bhv_lookup_range(bhv_head_t *bhp, int low, int high);
 extern bhv_desc_t *	bhv_base(bhv_head_t *bhp);
 
+/*
+ * Remove a behavior descriptor from a behavior chain.
+ */
+static inline void bhv_remove(bhv_head_t *bhp, struct bhv_desc *bdp) {
+    if(bhp->bh_first == bdp)
+        /*
+        * Remove from front of chain.
+        * Atomic wrt oip's.
+        */
+        bhp->bh_first = bdp->bd_next;
+    else
+        /* remove from non-front of chain */
+        bhv_remove_not_first(bhp, bdp);
+
+    bdp->bd_vobj = NULL;
+    return;
+}
+
 /* No bhv locking on Linux */
 #define bhv_lookup_unlocked	bhv_lookup
 #define bhv_base_unlocked	bhv_base
diff --fast -pru ws~/fs/xfs/xfs_bit.h ws/fs/xfs/xfs_bit.h
--- ws~/fs/xfs/xfs_bit.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/xfs_bit.h	2006-03-26 00:13:16.515287000 +0100
@@ -18,6 +18,9 @@
 #ifndef __XFS_BIT_H__
 #define	__XFS_BIT_H__
 
+#include <linux/types.h>
+#include "xfs_types.h"
+
 /*
  * XFS bit manipulation routines.
  */
diff --fast -pru ws~/fs/xfs/xfs_bmap.h ws/fs/xfs/xfs_bmap.h
--- ws~/fs/xfs/xfs_bmap.h	2006-03-03 01:40:32.000000000 +0100
+++ ws/fs/xfs/xfs_bmap.h	2006-03-26 00:14:07.995287000 +0100
@@ -18,6 +18,9 @@
 #ifndef __XFS_BMAP_H__
 #define	__XFS_BMAP_H__
 
+#include "xfs_inode.h"
+#include "xfs_types.h"
+
 struct getbmap;
 struct xfs_bmbt_irec;
 struct xfs_ifork;
diff --fast -pru ws~/fs/xfs/xfs_da_btree.h ws/fs/xfs/xfs_da_btree.h
--- ws~/fs/xfs/xfs_da_btree.h	2006-03-17 15:48:35.000000000 +0100
+++ ws/fs/xfs/xfs_da_btree.h	2006-03-26 00:10:50.305287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_DA_BTREE_H__
 #define	__XFS_DA_BTREE_H__
 
+#include "xfs_types.h"
+
 struct xfs_buf;
 struct xfs_bmap_free;
 struct xfs_inode;
diff --fast -pru ws~/fs/xfs/xfs_fs.h ws/fs/xfs/xfs_fs.h
--- ws~/fs/xfs/xfs_fs.h	2006-03-25 22:24:11.265287000 +0100
+++ ws/fs/xfs/xfs_fs.h	2006-03-25 23:28:56.635287000 +0100
@@ -18,6 +18,10 @@
 #ifndef __XFS_FS_H__
 #define __XFS_FS_H__
 
+#include <linux/types.h>
+
+struct inode;
+
 /*
  * SGI's XFS filesystem's major stuff (constants, structures)
  */
diff --fast -pru ws~/fs/xfs/xfs_inum.h ws/fs/xfs/xfs_inum.h
--- ws~/fs/xfs/xfs_inum.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/xfs_inum.h	2006-03-26 00:07:03.615287000 +0100
@@ -18,6 +18,8 @@
 #ifndef __XFS_INUM_H__
 #define	__XFS_INUM_H__
 
+#include "xfs_types.h"
+
 /*
  * Inode number format:
  * low inopblog bits - offset in block
diff --fast -pru ws~/fs/xfs/xfs_log.h ws/fs/xfs/xfs_log.h
--- ws~/fs/xfs/xfs_log.h	2006-03-25 21:10:18.000000000 +0100
+++ ws/fs/xfs/xfs_log.h	2006-03-25 23:53:46.815287000 +0100
@@ -18,6 +18,12 @@
 #ifndef	__XFS_LOG_H__
 #define __XFS_LOG_H__
 
+#include <linux/types.h>
+#include "xfs_types.h"
+
+struct xfs_buf;
+struct xfs_buftarg;
+
 /* get lsn fields */
 
 #define CYCLE_LSN(lsn) ((uint)((lsn)>>32))
diff --fast -pru ws~/fs/xfs/xfs_quota.h ws/fs/xfs/xfs_quota.h
--- ws~/fs/xfs/xfs_quota.h	2006-03-25 21:10:18.000000000 +0100
+++ ws/fs/xfs/xfs_quota.h	2006-03-25 23:49:42.575287000 +0100
@@ -18,6 +18,13 @@
 #ifndef __XFS_QUOTA_H__
 #define __XFS_QUOTA_H__
 
+#include <linux/types.h>
+#include "xfs_types.h"
+
+struct xfs_inode;
+struct xfs_mount;
+struct xfs_trans;
+
 /*
  * The ondisk form of a dquot structure.
  */
diff --fast -pru ws~/fs/xfs/xfs_trans.h ws/fs/xfs/xfs_trans.h
--- ws~/fs/xfs/xfs_trans.h	2006-03-25 21:10:18.000000000 +0100
+++ ws/fs/xfs/xfs_trans.h	2006-03-25 23:53:59.705287000 +0100
@@ -18,6 +18,11 @@
 #ifndef	__XFS_TRANS_H__
 #define	__XFS_TRANS_H__
 
+#include <linux/types.h>
+#include <sema.h>
+#include "xfs_log.h"
+#include "xfs_types.h"
+
 /*
  * This is the structure written in the log at the head of
  * every transaction. It identifies the type and id of the
diff --fast -pru ws~/fs/xfs/xfs_types.h ws/fs/xfs/xfs_types.h
--- ws~/fs/xfs/xfs_types.h	2005-09-23 05:51:28.000000000 +0200
+++ ws/fs/xfs/xfs_types.h	2006-03-25 23:25:11.955287000 +0100
@@ -20,6 +20,8 @@
 
 #ifdef __KERNEL__
 
+#include <asm/types.h>
+
 /*
  * POSIX Extensions
  */
#<eof>


Jan Engelhardt
-- 
