Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbUJ3SYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbUJ3SYn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUJ3STA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 14:19:00 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:13065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261289AbUJ3SNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 14:13:39 -0400
Date: Sat, 30 Oct 2004 20:13:07 +0200
From: Adrian Bunk <bunk@stusta.de>
To: nathans@sgi.com
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] some XFS cleanups
Message-ID: <20041030181307.GV4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes the following cleanups in the XFS code:
- remove the unused global function vfs_dmapiops
- remove some unused #define's
- make several functions static


diffstat output:
 fs/xfs/linux-2.6/xfs_aops.c  |   17 ++++++++++++++++-
 fs/xfs/linux-2.6/xfs_buf.c   |    4 ++--
 fs/xfs/linux-2.6/xfs_iops.h  |    1 -
 fs/xfs/linux-2.6/xfs_linux.h |   14 --------------
 fs/xfs/linux-2.6/xfs_super.c |    2 +-
 fs/xfs/linux-2.6/xfs_super.h |   12 ------------
 fs/xfs/linux-2.6/xfs_vfs.c   |   29 ++++++++++++++---------------
 fs/xfs/linux-2.6/xfs_vfs.h   |    5 -----
 8 files changed, 33 insertions(+), 51 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_linux.h.old	2004-10-30 15:33:15.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_linux.h	2004-10-30 16:54:04.000000000 +0200
@@ -115,20 +115,6 @@
 #undef  HAVE_REFCACHE	/* reference cache not needed for NFS in 2.6 */
 #define HAVE_SENDFILE	/* sendfile(2) exists in 2.6, but not in 2.4 */
 
-/*
- * State flag for unwritten extent buffers.
- *
- * We need to be able to distinguish between these and delayed
- * allocate buffers within XFS.  The generic IO path code does
- * not need to distinguish - we use the BH_Delay flag for both
- * delalloc and these ondisk-uninitialised buffers.
- */
-BUFFER_FNS(PrivateStart, unwritten);
-static inline void set_buffer_unwritten_io(struct buffer_head *bh)
-{
-	bh->b_end_io = linvfs_unwritten_done;
-}
-
 #define restricted_chown	xfs_params.restrict_chown.val
 #define irix_sgid_inherit	xfs_params.sgid_inherit.val
 #define irix_symlink_mode	xfs_params.symlink_mode.val
--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_iops.h.old	2004-10-30 15:30:36.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_iops.h	2004-10-30 15:32:26.000000000 +0200
@@ -43,7 +43,6 @@
 extern struct address_space_operations linvfs_aops;
 
 extern int linvfs_get_block(struct inode *, sector_t, struct buffer_head *, int);
-extern void linvfs_unwritten_done(struct buffer_head *, int);
 
 extern int xfs_ioctl(struct bhv_desc *, struct inode *, struct file *,
                         int, unsigned int, void __user *);
--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_aops.c.old	2004-10-30 15:26:37.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_aops.c	2004-10-30 16:56:46.000000000 +0200
@@ -55,10 +55,25 @@
 #include <linux/mpage.h>
 #include <linux/writeback.h>
 
+STATIC void linvfs_unwritten_done(struct buffer_head *, int);
 STATIC void xfs_count_page_state(struct page *, int *, int *, int *);
 STATIC void xfs_convert_page(struct inode *, struct page *, xfs_iomap_t *,
 		struct writeback_control *wbc, void *, int, int);
 
+/*
+ * State flag for unwritten extent buffers.
+ *
+ * We need to be able to distinguish between these and delayed
+ * allocate buffers within XFS.  The generic IO path code does
+ * not need to distinguish - we use the BH_Delay flag for both
+ * delalloc and these ondisk-uninitialised buffers.
+ */
+BUFFER_FNS(PrivateStart, unwritten);
+static inline void set_buffer_unwritten_io(struct buffer_head *bh)
+{
+	bh->b_end_io = linvfs_unwritten_done;
+}
+
 #if defined(XFS_RW_TRACE)
 void
 xfs_page_trace(
@@ -104,7 +119,7 @@
 #define xfs_page_trace(tag, inode, page, mask)
 #endif
 
-void
+STATIC void
 linvfs_unwritten_done(
 	struct buffer_head	*bh,
 	int			uptodate)
--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_buf.c.old	2004-10-30 15:33:58.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_buf.c	2004-10-30 15:40:03.000000000 +0200
@@ -1084,7 +1084,7 @@
  *	done with respect to that I/O.	The pb_iodone routine, if
  *	present, will be called as a side-effect.
  */
-void
+static void
 pagebuf_iodone_work(
 	void			*v)
 {
@@ -1263,7 +1263,7 @@
 	return 0;
 }
 
-void
+static void
 _pagebuf_ioapply(
 	xfs_buf_t		*pb)
 {
--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_super.h.old	2004-10-30 17:00:13.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_super.h	2004-10-30 17:00:30.000000000 +0200
@@ -32,24 +32,12 @@
 #ifndef __XFS_SUPER_H__
 #define __XFS_SUPER_H__
 
-#ifdef CONFIG_XFS_DMAPI
-# define vfs_insertdmapi(vfs)	vfs_insertops(vfsp, &xfs_dmops)
-# define vfs_initdmapi()	dmapi_init()
-# define vfs_exitdmapi()	dmapi_uninit()
-#else
-# define vfs_insertdmapi(vfs)	do { } while (0)
-# define vfs_initdmapi()	do { } while (0)
-# define vfs_exitdmapi()	do { } while (0)
-#endif
-
 #ifdef CONFIG_XFS_QUOTA
-# define vfs_insertquota(vfs)	vfs_insertops(vfsp, &xfs_qmops)
 extern void xfs_qm_init(void);
 extern void xfs_qm_exit(void);
 # define vfs_initquota()	xfs_qm_init()
 # define vfs_exitquota()	xfs_qm_exit()
 #else
-# define vfs_insertquota(vfs)	do { } while (0)
 # define vfs_initquota()	do { } while (0)
 # define vfs_exitquota()	do { } while (0)
 #endif
--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_super.c.old	2004-10-30 16:58:45.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_super.c	2004-10-30 16:59:50.000000000 +0200
@@ -284,7 +284,7 @@
 	kmem_cache_free(linvfs_inode_zone, LINVFS_GET_VP(inode));
 }
 
-int
+STATIC int
 xfs_inode_shake(
 	int		priority,
 	unsigned int	gfp_mask)
--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_vfs.h.old	2004-10-30 17:08:34.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_vfs.h	2004-10-30 17:01:57.000000000 +0200
@@ -158,7 +158,6 @@
 #define VFS_STATVFS(v, sp,vp, rv)	((rv) = vfs_statvfs(VHEAD(v), sp,vp))
 #define VFS_SYNC(v, flag,cr, rv)	((rv) = vfs_sync(VHEAD(v), flag,cr))
 #define VFS_VGET(v, vpp,fidp, rv)	((rv) = vfs_vget(VHEAD(v), vpp,fidp))
-#define VFS_DMAPIOPS(v, p, rv)		((rv) = vfs_dmapiops(VHEAD(v), p))
 #define VFS_QUOTACTL(v, c,id,p, rv)	((rv) = vfs_quotactl(VHEAD(v), c,id,p))
 #define VFS_INIT_VNODE(v, vp,b,ul)	( vfs_init_vnode(VHEAD(v), vp,b,ul) )
 #define VFS_FORCE_SHUTDOWN(v, fl,f,l)	( vfs_force_shutdown(VHEAD(v), fl,f,l) )
@@ -176,7 +175,6 @@
 #define PVFS_STATVFS(b, sp,vp, rv)	((rv) = vfs_statvfs(b, sp,vp))
 #define PVFS_SYNC(b, flag,cr, rv)	((rv) = vfs_sync(b, flag,cr))
 #define PVFS_VGET(b, vpp,fidp, rv)	((rv) = vfs_vget(b, vpp,fidp))
-#define PVFS_DMAPIOPS(b, p, rv)		((rv) = vfs_dmapiops(b, p))
 #define PVFS_QUOTACTL(b, c,id,p, rv)	((rv) = vfs_quotactl(b, c,id,p))
 #define PVFS_INIT_VNODE(b, vp,b2,ul)	( vfs_init_vnode(b, vp,b2,ul) )
 #define PVFS_FORCE_SHUTDOWN(b, fl,f,l)	( vfs_force_shutdown(b, fl,f,l) )
@@ -191,7 +189,6 @@
 extern int vfs_statvfs(bhv_desc_t *, xfs_statfs_t *, struct vnode *);
 extern int vfs_sync(bhv_desc_t *, int, struct cred *);
 extern int vfs_vget(bhv_desc_t *, struct vnode **, struct fid *);
-extern int vfs_dmapiops(bhv_desc_t *, caddr_t);
 extern int vfs_quotactl(bhv_desc_t *, int, int, caddr_t);
 extern void vfs_init_vnode(bhv_desc_t *, struct vnode *, bhv_desc_t *, int);
 extern void vfs_force_shutdown(bhv_desc_t *, int, char *, int);
@@ -209,8 +206,6 @@
 
 extern vfs_t *vfs_allocate(void);
 extern void vfs_deallocate(vfs_t *);
-extern void vfs_insertops(vfs_t *, bhv_vfsops_t *);
-extern void vfs_insertbhv(vfs_t *, bhv_desc_t *, vfsops_t *, void *);
 
 extern void bhv_insert_all_vfsops(struct vfs *);
 extern void bhv_remove_all_vfsops(struct vfs *, int);
--- linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_vfs.c.old	2004-10-30 17:08:29.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/xfs/linux-2.6/xfs_vfs.c	2004-10-30 17:05:54.000000000 +0200
@@ -47,6 +47,18 @@
 #include "xfs_mount.h"
 #include "xfs_quota.h"
 
+#ifdef CONFIG_XFS_DMAPI
+# define vfs_insertdmapi(vfs)	vfs_insertops(vfsp, &xfs_dmops)
+#else
+# define vfs_insertdmapi(vfs)	do { } while (0)
+#endif
+
+#ifdef CONFIG_XFS_QUOTA
+# define vfs_insertquota(vfs)	vfs_insertops(vfsp, &xfs_qmops)
+#else
+# define vfs_insertquota(vfs)	do { } while (0)
+#endif
+
 int
 vfs_mount(
 	struct bhv_desc		*bdp,
@@ -173,19 +185,6 @@
 }
 
 int
-vfs_dmapiops(
-	struct bhv_desc		*bdp,
-	caddr_t			addr)
-{
-	struct bhv_desc		*next = bdp;
-
-	ASSERT(next);
-	while (! (bhvtovfsops(next))->vfs_dmapiops)
-		next = BHV_NEXT(next);
-	return ((*bhvtovfsops(next)->vfs_dmapiops)(next, addr));
-}
-
-int
 vfs_quotactl(
 	struct bhv_desc		*bdp,
 	int			cmd,
@@ -264,7 +263,7 @@
 	kmem_free(vfsp, sizeof(vfs_t));
 }
 
-void
+static void
 vfs_insertops(
 	struct vfs		*vfsp,
 	struct bhv_vfsops	*vfsops)
@@ -276,7 +275,7 @@
 	bhv_insert(&vfsp->vfs_bh, bdp);
 }
 
-void
+static void
 vfs_insertbhv(
 	struct vfs		*vfsp,
 	struct bhv_desc		*bdp,

