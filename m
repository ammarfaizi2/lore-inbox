Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVJ3UCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVJ3UCq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 15:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVJ3UCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 15:02:46 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38928 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750711AbVJ3UCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 15:02:44 -0500
Date: Sun, 30 Oct 2005 21:02:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: xfs-masters@oss.sgi.com, nathans@sgi.com
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/xfs/: possible cleanups
Message-ID: <20051030200242.GK4180@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- xfs_trans_item.c should #include "xfs_trans_priv.h" for getting the
  prototypes of it's global functions.

Please review which of these changes do make sense.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/xfs/linux-2.6/xfs_vfs.c     |    2 -
 fs/xfs/linux-2.6/xfs_vfs.h     |    1 
 fs/xfs/linux-2.6/xfs_vnode.c   |    6 ++--
 fs/xfs/linux-2.6/xfs_vnode.h   |    1 
 fs/xfs/quota/xfs_qm.c          |    4 ++-
 fs/xfs/quota/xfs_qm.h          |    2 -
 fs/xfs/quota/xfs_qm_syscalls.c |    4 +--
 fs/xfs/support/uuid.c          |    2 -
 fs/xfs/support/uuid.h          |    1 
 fs/xfs/xfs_bmap.c              |    2 -
 fs/xfs/xfs_bmap_btree.h        |   15 -----------
 fs/xfs/xfs_dir2.c              |    6 +++-
 fs/xfs/xfs_dir2.h              |    6 ----
 fs/xfs/xfs_dir2_data.c         |    5 +++
 fs/xfs/xfs_dir2_data.h         |    4 ---
 fs/xfs/xfs_dir2_node.c         |    2 -
 fs/xfs/xfs_dir2_node.h         |    4 ---
 fs/xfs/xfs_iget.c              |    7 +++--
 fs/xfs/xfs_inode.h             |    2 -
 fs/xfs/xfs_log_priv.h          |    9 -------
 fs/xfs/xfs_log_recover.c       |   12 ++++-----
 fs/xfs/xfs_mount.h             |    2 -
 fs/xfs/xfs_trans.c             |   42 ++++++++++++++++-----------------
 fs/xfs/xfs_trans.h             |    1 
 fs/xfs/xfs_trans_item.c        |    1 
 fs/xfs/xfs_vfsops.c            |    6 +++-
 fs/xfs/xfs_vnodeops.c          |    2 -
 27 files changed, 58 insertions(+), 93 deletions(-)

--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_trans_item.c.old	2005-10-30 19:55:03.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_trans_item.c	2005-10-30 19:55:18.000000000 +0100
@@ -36,6 +36,7 @@
 #include "xfs_inum.h"
 #include "xfs_log.h"
 #include "xfs_trans.h"
+#include "xfs_trans_priv.h"
 
 STATIC int	xfs_trans_unlock_chunk(xfs_log_item_chunk_t *,
 					int, int, xfs_lsn_t);
--- linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vfs.h.old	2005-10-30 19:58:01.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vfs.h	2005-10-30 19:58:06.000000000 +0100
@@ -209,7 +209,6 @@
 extern vfs_t *vfs_allocate(void);
 extern void vfs_deallocate(vfs_t *);
 extern void vfs_insertops(vfs_t *, bhv_vfsops_t *);
-extern void vfs_insertbhv(vfs_t *, bhv_desc_t *, vfsops_t *, void *);
 
 extern void bhv_insert_all_vfsops(struct vfs *);
 extern void bhv_remove_all_vfsops(struct vfs *, int);
--- linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vfs.c.old	2005-10-30 19:58:19.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vfs.c	2005-10-30 19:58:25.000000000 +0100
@@ -275,7 +275,7 @@
 	bhv_insert(&vfsp->vfs_bh, bdp);
 }
 
-void
+static void
 vfs_insertbhv(
 	struct vfs		*vfsp,
 	struct bhv_desc		*bdp,
--- linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vnode.h.old	2005-10-30 20:00:40.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vnode.h	2005-10-30 20:00:46.000000000 +0100
@@ -503,7 +503,6 @@
 			 (vmap).v_ino	 = (vp)->v_inode.i_ino; }
 
 extern int	vn_revalidate(struct vnode *);
-extern void	vn_revalidate_core(struct vnode *, vattr_t *);
 
 extern void	vn_iowait(struct vnode *vp);
 extern void	vn_iowake(struct vnode *vp);
--- linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vnode.c.old	2005-10-30 20:00:02.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/linux-2.6/xfs_vnode.c	2005-10-30 20:01:07.000000000 +0100
@@ -33,8 +33,8 @@
 #include "xfs.h"
 
 
-uint64_t vn_generation;		/* vnode generation number */
-DEFINE_SPINLOCK(vnumber_lock);
+static uint64_t vn_generation;		/* vnode generation number */
+static DEFINE_SPINLOCK(vnumber_lock);
 
 /*
  * Dedicated vnode inactive/reclaim sync semaphores.
@@ -109,7 +109,7 @@
  * Note: i_size _not_ updated; we must hold the inode
  * semaphore when doing that - callers responsibility.
  */
-void
+static void
 vn_revalidate_core(
 	struct vnode	*vp,
 	vattr_t		*vap)
--- linux-2.6.14-rc5-mm1-full/fs/xfs/quota/xfs_qm.h.old	2005-10-30 20:01:47.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/quota/xfs_qm.h	2005-10-30 20:04:26.000000000 +0100
@@ -187,7 +187,6 @@
 extern void		xfs_qm_destroy_quotainfo(xfs_mount_t *);
 extern int		xfs_qm_mount_quotas(xfs_mount_t *, int);
 extern void		xfs_qm_mount_quotainit(xfs_mount_t *, uint);
-extern int		xfs_qm_quotacheck(xfs_mount_t *);
 extern void		xfs_qm_unmount_quotadestroy(xfs_mount_t *);
 extern int		xfs_qm_unmount_quotas(xfs_mount_t *);
 extern int		xfs_qm_write_sb_changes(xfs_mount_t *, __int64_t);
@@ -198,7 +197,6 @@
 extern int		xfs_qm_dqattach(xfs_inode_t *, uint);
 extern void		xfs_qm_dqdetach(xfs_inode_t *);
 extern int		xfs_qm_dqpurge_all(xfs_mount_t *, uint);
-extern void		xfs_qm_dqrele_all_inodes(xfs_mount_t *, uint);
 
 /* vop stuff */
 extern int		xfs_qm_vop_dqalloc(xfs_mount_t *, xfs_inode_t *,
--- linux-2.6.14-rc5-mm1-full/fs/xfs/quota/xfs_qm.c.old	2005-10-30 20:02:10.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/quota/xfs_qm.c	2005-10-30 20:03:41.000000000 +0100
@@ -95,6 +95,8 @@
 STATIC int	xfs_qm_init_quotainfo(xfs_mount_t *);
 STATIC int	xfs_qm_shake(int, unsigned int);
 
+STATIC int	xfs_qm_quotacheck(xfs_mount_t *mp);
+
 #ifdef DEBUG
 extern mutex_t	qcheck_lock;
 #endif
@@ -1885,7 +1887,7 @@
  * Walk thru all the filesystem inodes and construct a consistent view
  * of the disk quota world. If the quotacheck fails, disable quotas.
  */
-int
+STATIC int
 xfs_qm_quotacheck(
 	xfs_mount_t	*mp)
 {
--- linux-2.6.14-rc5-mm1-full/fs/xfs/quota/xfs_qm_syscalls.c.old	2005-10-30 20:04:34.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/quota/xfs_qm_syscalls.c	2005-10-30 20:05:29.000000000 +0100
@@ -90,7 +90,7 @@
 STATIC uint	xfs_qm_export_qtype_flags(uint);
 STATIC void	xfs_qm_export_dquot(xfs_mount_t *, xfs_disk_dquot_t *,
 					fs_disk_quota_t *);
-
+STATIC void	xfs_qm_dqrele_all_inodes(struct xfs_mount *mp, uint flags);
 
 /*
  * The main distribution switch of all XFS quotactl system calls.
@@ -1048,7 +1048,7 @@
  * AFTER this, in the case of quotaoff. This also gets called from
  * xfs_rootumount.
  */
-void
+STATIC void
 xfs_qm_dqrele_all_inodes(
 	struct xfs_mount *mp,
 	uint		 flags)
--- linux-2.6.14-rc5-mm1-full/fs/xfs/support/uuid.h.old	2005-10-30 20:05:54.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/support/uuid.h	2005-10-30 20:05:59.000000000 +0100
@@ -37,7 +37,6 @@
 } uuid_t;
 
 void uuid_init(void);
-void uuid_create_nil(uuid_t *uuid);
 int uuid_is_nil(uuid_t *uuid);
 int uuid_equal(uuid_t *uuid1, uuid_t *uuid2);
 void uuid_getnodeuniq(uuid_t *uuid, int fsid [2]);
--- linux-2.6.14-rc5-mm1-full/fs/xfs/support/uuid.c.old	2005-10-30 20:06:07.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/support/uuid.c	2005-10-30 20:06:15.000000000 +0100
@@ -63,7 +63,7 @@
 	fsid[1] =  INT_GET(*(u_int32_t*)(uu  ), ARCH_CONVERT);
 }
 
-void
+static void
 uuid_create_nil(uuid_t *uuid)
 {
 	memset(uuid, 0, sizeof(*uuid));
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_bmap_btree.h.old	2005-10-30 20:07:31.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_bmap_btree.h	2005-10-30 20:07:45.000000000 +0100
@@ -673,21 +673,6 @@
 #endif
 
 
-/*
- * Search an extent list for the extent which includes block
- * bno.
- */
-xfs_bmbt_rec_t *
-xfs_bmap_do_search_extents(
-	xfs_bmbt_rec_t *,
-	xfs_extnum_t,
-	xfs_extnum_t,
-	xfs_fileoff_t,
-	int *,
-	xfs_extnum_t *,
-	xfs_bmbt_irec_t *,
-	xfs_bmbt_irec_t *);
-
 #endif	/* __KERNEL__ */
 
 #endif	/* __XFS_BMAP_BTREE_H__ */
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_bmap.c.old	2005-10-30 20:07:53.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_bmap.c	2005-10-30 20:08:08.000000000 +0100
@@ -3424,7 +3424,7 @@
 	return error;
 }
 
-xfs_bmbt_rec_t *			/* pointer to found extent entry */
+static xfs_bmbt_rec_t *			/* pointer to found extent entry */
 xfs_bmap_do_search_extents(
 	xfs_bmbt_rec_t	*base,		/* base of extent list */
 	xfs_extnum_t	lastx,		/* last extent index used */
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2.h.old	2005-10-30 20:09:36.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2.h	2005-10-30 20:11:21.000000000 +0100
@@ -97,12 +97,6 @@
 			    xfs_dir2_db_t *dbp);
 
 extern int
-	xfs_dir2_isblock(struct xfs_trans *tp, struct xfs_inode *dp, int *vp);
-
-extern int
-	xfs_dir2_isleaf(struct xfs_trans *tp, struct xfs_inode *dp, int *vp);
-
-extern int
 	xfs_dir2_shrink_inode(struct xfs_da_args *args, xfs_dir2_db_t db,
 			      struct xfs_dabuf *bp);
 
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2.c.old	2005-10-30 20:09:56.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2.c	2005-10-30 20:12:08.000000000 +0100
@@ -95,6 +95,8 @@
 static int	xfs_dir2_shortform_validate_ondisk(xfs_mount_t *mp,
 						   xfs_dinode_t *dip);
 
+static int	xfs_dir2_isblock(xfs_trans_t *tp, xfs_inode_t *dp, int *vp);
+static int	xfs_dir2_isleaf( xfs_trans_t *tp, xfs_inode_t *dp, int *vp);
 /*
  * Utility routine declarations.
  */
@@ -666,7 +668,7 @@
 /*
  * See if the directory is a single-block form directory.
  */
-int					/* error */
+static int				/* error */
 xfs_dir2_isblock(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_inode_t	*dp,		/* incore directory inode */
@@ -689,7 +691,7 @@
 /*
  * See if the directory is a single-leaf form directory.
  */
-int					/* error */
+static int				/* error */
 xfs_dir2_isleaf(
 	xfs_trans_t	*tp,		/* transaction pointer */
 	xfs_inode_t	*dp,		/* incore directory inode */
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_data.h.old	2005-10-30 20:12:28.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_data.h	2005-10-30 20:12:36.000000000 +0100
@@ -185,10 +185,6 @@
 #endif
 
 extern xfs_dir2_data_free_t *
-	xfs_dir2_data_freefind(xfs_dir2_data_t *d,
-			       xfs_dir2_data_unused_t *dup);
-
-extern xfs_dir2_data_free_t *
 	xfs_dir2_data_freeinsert(xfs_dir2_data_t *d,
 				 xfs_dir2_data_unused_t *dup, int *loghead);
 
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_data.c.old	2005-10-30 20:12:45.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_data.c	2005-10-30 20:13:52.000000000 +0100
@@ -61,6 +61,9 @@
 #include "xfs_dir2_block.h"
 #include "xfs_error.h"
 
+static xfs_dir2_data_free_t
+*xfs_dir2_data_freefind(xfs_dir2_data_t *d, xfs_dir2_data_unused_t *dup);
+
 #ifdef DEBUG
 /*
  * Check the consistency of the data block.
@@ -193,7 +196,7 @@
  * Given a data block and an unused entry from that block,
  * return the bestfree entry if any that corresponds to it.
  */
-xfs_dir2_data_free_t *
+static xfs_dir2_data_free_t *
 xfs_dir2_data_freefind(
 	xfs_dir2_data_t		*d,		/* data block */
 	xfs_dir2_data_unused_t	*dup)		/* data unused entry */
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_node.h.old	2005-10-30 20:14:18.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_node.h	2005-10-30 20:14:26.000000000 +0100
@@ -108,10 +108,6 @@
  * Functions.
  */
 
-extern void
-	xfs_dir2_free_log_bests(struct xfs_trans *tp, struct xfs_dabuf *bp,
-				int first, int last);
-
 extern int
 	xfs_dir2_leaf_to_node(struct xfs_da_args *args, struct xfs_dabuf *lbp);
 
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_node.c.old	2005-10-30 20:14:34.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_dir2_node.c	2005-10-30 20:14:42.000000000 +0100
@@ -88,7 +88,7 @@
 /*
  * Log entries from a freespace block.
  */
-void
+static void
 xfs_dir2_free_log_bests(
 	xfs_trans_t		*tp,		/* transaction pointer */
 	xfs_dabuf_t		*bp,		/* freespace buffer */
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_inode.h.old	2005-10-30 20:15:16.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_inode.h	2005-10-30 20:16:21.000000000 +0100
@@ -461,7 +461,6 @@
 void		xfs_chash_free(struct xfs_mount *);
 xfs_inode_t	*xfs_inode_incore(struct xfs_mount *, xfs_ino_t,
 				  struct xfs_trans *);
-void            xfs_inode_lock_init(xfs_inode_t *, struct vnode *);
 int		xfs_iget(struct xfs_mount *, struct xfs_trans *, xfs_ino_t,
 			 uint, uint, xfs_inode_t **, xfs_daddr_t);
 void		xfs_iput(xfs_inode_t *, uint);
@@ -508,7 +507,6 @@
 void		xfs_idestroy_fork(xfs_inode_t *, int);
 void		xfs_idestroy(xfs_inode_t *);
 void		xfs_idata_realloc(xfs_inode_t *, int, int);
-void		xfs_iextract(xfs_inode_t *);
 void		xfs_iext_realloc(xfs_inode_t *, int, int);
 void		xfs_iroot_realloc(xfs_inode_t *, int, int);
 void		xfs_ipin(xfs_inode_t *);
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_iget.c.old	2005-10-30 20:15:30.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_iget.c	2005-10-30 20:16:53.000000000 +0100
@@ -59,6 +59,9 @@
 #include "xfs_utils.h"
 #include "xfs_bit.h"
 
+static void xfs_iextract(xfs_inode_t *ip);
+static void xfs_inode_lock_init(xfs_inode_t *ip, vnode_t *vp);
+
 /*
  * Initialize the inode hash table for the newly mounted file system.
  * Choose an initial table size based on user specified value, else
@@ -558,7 +561,7 @@
 /*
  * Do the setup for the various locks within the incore inode.
  */
-void
+static void
 xfs_inode_lock_init(
 	xfs_inode_t	*ip,
 	vnode_t		*vp)
@@ -709,7 +712,7 @@
  * all of the lists in which it is located with the exception
  * of the behavior chain.
  */
-void
+static void
 xfs_iextract(
 	xfs_inode_t	*ip)
 {
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_log_priv.h.old	2005-10-30 20:18:02.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_log_priv.h	2005-10-30 20:20:23.000000000 +0100
@@ -579,18 +579,9 @@
 
 /* common routines */
 extern xfs_lsn_t xlog_assign_tail_lsn(struct xfs_mount *mp);
-extern int	 xlog_find_tail(xlog_t	*log,
-				xfs_daddr_t *head_blk,
-				xfs_daddr_t *tail_blk,
-				int readonly);
 extern int	 xlog_recover(xlog_t *log, int readonly);
 extern int	 xlog_recover_finish(xlog_t *log, int mfsi_flags);
 extern void	 xlog_pack_data(xlog_t *log, xlog_in_core_t *iclog, int);
-extern void	 xlog_recover_process_iunlinks(xlog_t *log);
-
-extern struct xfs_buf *xlog_get_bp(xlog_t *, int);
-extern void	 xlog_put_bp(struct xfs_buf *);
-extern int	 xlog_bread(xlog_t *, xfs_daddr_t, int, struct xfs_buf *);
 
 /* iclog tracing */
 #define XLOG_TRACE_GRAB_FLUSH  1
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_log_recover.c.old	2005-10-30 20:18:21.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_log_recover.c	2005-10-30 20:20:29.000000000 +0100
@@ -86,7 +86,7 @@
 	((bbs + (log)->l_sectbb_mask + 1) & ~(log)->l_sectbb_mask) : (bbs) )
 #define XLOG_SECTOR_ROUNDDOWN_BLKNO(log, bno)	((bno) & ~(log)->l_sectbb_mask)
 
-xfs_buf_t *
+STATIC xfs_buf_t *
 xlog_get_bp(
 	xlog_t		*log,
 	int		num_bblks)
@@ -101,7 +101,7 @@
 	return xfs_buf_get_noaddr(BBTOB(num_bblks), log->l_mp->m_logdev_targp);
 }
 
-void
+STATIC void
 xlog_put_bp(
 	xfs_buf_t	*bp)
 {
@@ -112,7 +112,7 @@
 /*
  * nbblks should be uint, but oh well.  Just want to catch that 32-bit length.
  */
-int
+STATIC int
 xlog_bread(
 	xlog_t		*log,
 	xfs_daddr_t	blk_no,
@@ -310,7 +310,7 @@
  * Note that the algorithm can not be perfect because the disk will not
  * necessarily be perfect.
  */
-int
+STATIC int
 xlog_find_cycle_start(
 	xlog_t		*log,
 	xfs_buf_t	*bp,
@@ -794,7 +794,7 @@
  * We could speed up search by using current head_blk buffer, but it is not
  * available.
  */
-int
+STATIC int
 xlog_find_tail(
 	xlog_t			*log,
 	xfs_daddr_t		*head_blk,
@@ -3205,7 +3205,7 @@
  * freeing of the inode and its removal from the list must be
  * atomic.
  */
-void
+STATIC void
 xlog_recover_process_iunlinks(
 	xlog_t		*log)
 {
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_trans.h.old	2005-10-30 20:20:48.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_trans.h	2005-10-30 20:20:53.000000000 +0100
@@ -984,7 +984,6 @@
  */
 void		xfs_trans_init(struct xfs_mount *);
 xfs_trans_t	*xfs_trans_alloc(struct xfs_mount *, uint);
-xfs_trans_t	*_xfs_trans_alloc(struct xfs_mount *, uint);
 xfs_trans_t	*xfs_trans_dup(xfs_trans_t *);
 int		xfs_trans_reserve(xfs_trans_t *, uint, uint, uint,
 				  uint, uint);
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_trans.c.old	2005-10-30 20:21:01.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_trans.c	2005-10-30 20:21:40.000000000 +0100
@@ -118,27 +118,7 @@
 	resp->tr_growrtfree = (uint)XFS_CALC_GROWRTFREE_LOG_RES(mp);
 }
 
-/*
- * This routine is called to allocate a transaction structure.
- * The type parameter indicates the type of the transaction.  These
- * are enumerated in xfs_trans.h.
- *
- * Dynamically allocate the transaction structure from the transaction
- * zone, initialize it, and return it to the caller.
- */
-xfs_trans_t *
-xfs_trans_alloc(
-	xfs_mount_t	*mp,
-	uint		type)
-{
-	fs_check_frozen(XFS_MTOVFS(mp), SB_FREEZE_TRANS);
-	atomic_inc(&mp->m_active_trans);
-
-	return (_xfs_trans_alloc(mp, type));
-
-}
-
-xfs_trans_t *
+static xfs_trans_t *
 _xfs_trans_alloc(
 	xfs_mount_t	*mp,
 	uint		type)
@@ -163,6 +143,26 @@
 }
 
 /*
+ * This routine is called to allocate a transaction structure.
+ * The type parameter indicates the type of the transaction.  These
+ * are enumerated in xfs_trans.h.
+ *
+ * Dynamically allocate the transaction structure from the transaction
+ * zone, initialize it, and return it to the caller.
+ */
+xfs_trans_t *
+xfs_trans_alloc(
+	xfs_mount_t	*mp,
+	uint		type)
+{
+	fs_check_frozen(XFS_MTOVFS(mp), SB_FREEZE_TRANS);
+	atomic_inc(&mp->m_active_trans);
+
+	return (_xfs_trans_alloc(mp, type));
+
+}
+
+/*
  * This is called to create a new transaction which will share the
  * permanent log reservation of the given transaction.  The remaining
  * unused block and rt extent reservations are also inherited.  This
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_mount.h.old	2005-10-30 20:22:07.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_mount.h	2005-10-30 20:23:33.000000000 +0100
@@ -546,7 +546,6 @@
 extern int	xfs_unmountfs(xfs_mount_t *, struct cred *);
 extern void	xfs_unmountfs_close(xfs_mount_t *, struct cred *);
 extern int	xfs_unmountfs_writesb(xfs_mount_t *);
-extern int	xfs_unmount_flush(xfs_mount_t *, int);
 extern int	xfs_mod_incore_sb(xfs_mount_t *, xfs_sb_field_t, int, int);
 extern int	xfs_mod_incore_sb_batch(xfs_mount_t *, xfs_mod_sb_t *,
 			uint, int);
@@ -554,7 +553,6 @@
 extern int	xfs_readsb(xfs_mount_t *mp);
 extern void	xfs_freesb(xfs_mount_t *);
 extern void	xfs_do_force_shutdown(bhv_desc_t *, int, char *, int);
-extern int	xfs_syncsub(xfs_mount_t *, int, int, int *);
 extern xfs_agnumber_t	xfs_initialize_perag(xfs_mount_t *, xfs_agnumber_t);
 extern void	xfs_xlatesb(void *, struct xfs_sb *, int, __int64_t);
 
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_vfsops.c.old	2005-10-30 20:22:23.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_vfsops.c	2005-10-30 20:29:12.000000000 +0100
@@ -71,6 +71,8 @@
 #include "xfs_log_priv.h"
 
 STATIC int xfs_sync(bhv_desc_t *, int, cred_t *);
+STATIC int xfs_syncsub(xfs_mount_t *mp, int flags, int xflags, int *bypassed);
+STATIC int xfs_unmount_flush(xfs_mount_t *mp, int relocation);
 
 int
 xfs_init(void)
@@ -679,7 +681,7 @@
  * inodes, which are needed as a separate set of operations so that
  * they can be called as part of relocation process.
  */
-int
+STATIC int
 xfs_unmount_flush(
 	xfs_mount_t	*mp,		/* Mount structure we are getting
 					   rid of. */
@@ -1413,7 +1415,7 @@
  * only available by calling this routine.
  *
  */
-int
+STATIC int
 xfs_syncsub(
 	xfs_mount_t	*mp,
 	int		flags,
--- linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_vnodeops.c.old	2005-10-30 20:24:50.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/fs/xfs/xfs_vnodeops.c	2005-10-30 20:25:04.000000000 +0100
@@ -284,7 +284,7 @@
 /*
  * xfs_setattr
  */
-int
+STATIC int
 xfs_setattr(
 	bhv_desc_t		*bdp,
 	vattr_t			*vap,

