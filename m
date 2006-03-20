Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbWCTNEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWCTNEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 08:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWCTNEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 08:04:25 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:48819 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932277AbWCTNEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 08:04:24 -0500
Date: Mon, 20 Mar 2006 15:04:14 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: nathans@sgi.com, xfs-masters@oss.sgi.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] xfs: kill kmem_zone init
Message-ID: <Pine.LNX.4.58.0603201501540.18684@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This patch changes kmem_zone_init() callers to use kmem_cache_alloc() so
we can kill the wrapper.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 linux-2.6/kmem.h      |    6 ----
 linux-2.6/xfs_buf.c   |    3 +-
 linux-2.6/xfs_super.c |    3 +-
 quota/xfs_qm.c        |   10 ++++----
 support/ktrace.c      |   10 ++++----
 xfs_acl.h             |    2 -
 xfs_vfsops.c          |   61 +++++++++++++++++++++++++++++++-------------------
 7 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/fs/xfs/linux-2.6/kmem.h b/fs/xfs/linux-2.6/kmem.h
index c64a29c..20ab643 100644
--- a/fs/xfs/linux-2.6/kmem.h
+++ b/fs/xfs/linux-2.6/kmem.h
@@ -92,12 +92,6 @@ static __inline gfp_t kmem_flags_convert
         return lflags;
 }
 
-static __inline kmem_zone_t *
-kmem_zone_init(int size, char *zone_name)
-{
-	return kmem_cache_create(zone_name, size, 0, 0, NULL, NULL);
-}
-
 static __inline void
 kmem_zone_free(kmem_zone_t *zone, void *ptr)
 {
diff --git a/fs/xfs/linux-2.6/xfs_buf.c b/fs/xfs/linux-2.6/xfs_buf.c
index bfb4f29..1f04ef1 100644
--- a/fs/xfs/linux-2.6/xfs_buf.c
+++ b/fs/xfs/linux-2.6/xfs_buf.c
@@ -1811,7 +1811,8 @@ xfs_buf_init(void)
 	xfs_buf_trace_buf = ktrace_alloc(XFS_BUF_TRACE_SIZE, KM_SLEEP);
 #endif
 
-	xfs_buf_zone = kmem_zone_init(sizeof(xfs_buf_t), "xfs_buf");
+	xfs_buf_zone = kmem_cache_create("xfs_buf", sizeof(xfs_buf_t), 0, 0,
+					 NULL, NULL);
 	if (!xfs_buf_zone)
 		goto out_free_trace_buf;
 
diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.c
index f22e426..f464b0d 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -374,7 +374,8 @@ linvfs_init_zones(void)
 	if (!xfs_vnode_zone)
 		goto out;
 
-	xfs_ioend_zone = kmem_zone_init(sizeof(xfs_ioend_t), "xfs_ioend");
+	xfs_ioend_zone = kmem_cache_create("xfs_ioend", sizeof(xfs_ioend_t),
+					   0, 0, NULL, NULL);
 	if (!xfs_ioend_zone)
 		goto out_destroy_vnode_zone;
 
diff --git a/fs/xfs/quota/xfs_qm.c b/fs/xfs/quota/xfs_qm.c
index 7c0e39d..8dcf9b9 100644
--- a/fs/xfs/quota/xfs_qm.c
+++ b/fs/xfs/quota/xfs_qm.c
@@ -148,8 +148,9 @@ xfs_Gqm_init(void)
 	 * dquot zone. we register our own low-memory callback.
 	 */
 	if (!qm_dqzone) {
-		xqm->qm_dqzone = kmem_zone_init(sizeof(xfs_dquot_t),
-						"xfs_dquots");
+		xqm->qm_dqzone = kmem_cache_create("xfs_dquots",
+						   sizeof(xfs_dquot_t),
+						   0, 0, NULL, NULL);
 		qm_dqzone = xqm->qm_dqzone;
 	} else
 		xqm->qm_dqzone = qm_dqzone;
@@ -160,8 +161,9 @@ xfs_Gqm_init(void)
 	 * The t_dqinfo portion of transactions.
 	 */
 	if (!qm_dqtrxzone) {
-		xqm->qm_dqtrxzone = kmem_zone_init(sizeof(xfs_dquot_acct_t),
-						   "xfs_dqtrx");
+		xqm->qm_dqtrxzone = kmem_cache_create("xfs_dqtrx",
+						      sizeof(xfs_dquot_acct_t),
+						      0, 0, NULL, NULL);
 		qm_dqtrxzone = xqm->qm_dqtrxzone;
 	} else
 		xqm->qm_dqtrxzone = qm_dqtrxzone;
diff --git a/fs/xfs/support/ktrace.c b/fs/xfs/support/ktrace.c
index 841aa4c..33fbe74 100644
--- a/fs/xfs/support/ktrace.c
+++ b/fs/xfs/support/ktrace.c
@@ -26,13 +26,13 @@ ktrace_init(int zentries)
 {
 	ktrace_zentries = zentries;
 
-	ktrace_hdr_zone = kmem_zone_init(sizeof(ktrace_t),
-					"ktrace_hdr");
+	ktrace_hdr_zone = kmem_cache_create("ktrace_hdr", sizeof(ktrace_t),
+					    0, 0, NULL, NULL);
 	ASSERT(ktrace_hdr_zone);
 
-	ktrace_ent_zone = kmem_zone_init(ktrace_zentries
-					* sizeof(ktrace_entry_t),
-					"ktrace_ent");
+	ktrace_ent_zone = kmem_cache_create("ktrace_ent",
+				ktrace_zentries * sizeof(ktrace_entry_t),
+				0, 0, NULL, NULL);
 	ASSERT(ktrace_ent_zone);
 }
 
diff --git a/fs/xfs/xfs_acl.h b/fs/xfs/xfs_acl.h
index f9315bc..af83064 100644
--- a/fs/xfs/xfs_acl.h
+++ b/fs/xfs/xfs_acl.h
@@ -55,7 +55,7 @@ struct xfs_inode;
 
 extern struct kmem_zone *xfs_acl_zone;
 #define xfs_acl_zone_init(zone, name)	\
-		(zone) = kmem_zone_init(sizeof(xfs_acl_t), name)
+		(zone) = kmem_cache_create(name, sizeof(xfs_acl_t), 0, 0, NULL, NULL)
 #define xfs_acl_zone_destroy(zone)	kmem_cache_destroy(zone)
 
 extern int xfs_acl_inherit(struct vnode *, struct vattr *, xfs_acl_t *);
diff --git a/fs/xfs/xfs_vfsops.c b/fs/xfs/xfs_vfsops.c
index b6ad370..52f9073 100644
--- a/fs/xfs/xfs_vfsops.c
+++ b/fs/xfs/xfs_vfsops.c
@@ -65,6 +65,9 @@ xfs_init(void)
 	extern kmem_zone_t	*xfs_trans_zone;
 	extern kmem_zone_t	*xfs_buf_item_zone;
 	extern kmem_zone_t	*xfs_dabuf_zone;
+	unsigned long		buf_item_zone_size;
+	unsigned long		edf_zone_size;
+	unsigned long		efi_zone_size;
 #ifdef XFS_DABUF_DEBUG
 	extern lock_t	        xfs_dabuf_global_lock;
 	spinlock_init(&xfs_dabuf_global_lock, "xfsda");
@@ -73,36 +76,50 @@ xfs_init(void)
 	/*
 	 * Initialize all of the zone allocators we use.
 	 */
-	xfs_bmap_free_item_zone = kmem_zone_init(sizeof(xfs_bmap_free_item_t),
-						 "xfs_bmap_free_item");
-	xfs_btree_cur_zone = kmem_zone_init(sizeof(xfs_btree_cur_t),
-					    "xfs_btree_cur");
-	xfs_inode_zone = kmem_zone_init(sizeof(xfs_inode_t), "xfs_inode");
-	xfs_trans_zone = kmem_zone_init(sizeof(xfs_trans_t), "xfs_trans");
+	xfs_bmap_free_item_zone =
+		kmem_cache_create("xfs_bmap_free_item",
+				sizeof(xfs_bmap_free_item_t),
+				0, 0, NULL, NULL);
+	xfs_btree_cur_zone =
+		kmem_cache_create("xfs_btree_cur", sizeof(xfs_btree_cur_t),
+				0, 0, NULL, NULL);
+	xfs_inode_zone = kmem_cache_create("xfs_inode", sizeof(xfs_inode_t),
+				0, 0, NULL, NULL);
+	xfs_trans_zone = kmem_cache_create("xfs_trans", sizeof(xfs_trans_t),
+				0, 0, NULL, NULL);
 	xfs_da_state_zone =
-		kmem_zone_init(sizeof(xfs_da_state_t), "xfs_da_state");
-	xfs_dabuf_zone = kmem_zone_init(sizeof(xfs_dabuf_t), "xfs_dabuf");
+		kmem_cache_create("xfs_da_state", sizeof(xfs_da_state_t),
+				0, 0, NULL, NULL);
+	xfs_dabuf_zone = kmem_cache_create("xfs_dabuf", sizeof(xfs_dabuf_t),
+				0, 0, NULL, NULL);
 
 	/*
 	 * The size of the zone allocated buf log item is the maximum
 	 * size possible under XFS.  This wastes a little bit of memory,
 	 * but it is much faster.
 	 */
+	buf_item_zone_size = (sizeof(xfs_buf_log_item_t) +
+			     (((XFS_MAX_BLOCKSIZE / XFS_BLI_CHUNK) /
+			       NBWORD) * sizeof(int)));
+	edf_zone_size = (sizeof(xfs_efd_log_item_t) +
+			((XFS_EFD_MAX_FAST_EXTENTS-1) * sizeof(xfs_extent_t)));
+	efi_zone_size = (sizeof(xfs_efi_log_item_t) +
+			((XFS_EFI_MAX_FAST_EXTENTS-1) * sizeof(xfs_extent_t)));
+
 	xfs_buf_item_zone =
-		kmem_zone_init((sizeof(xfs_buf_log_item_t) +
-				(((XFS_MAX_BLOCKSIZE / XFS_BLI_CHUNK) /
-				  NBWORD) * sizeof(int))),
-			       "xfs_buf_item");
-	xfs_efd_zone = kmem_zone_init((sizeof(xfs_efd_log_item_t) +
-				       ((XFS_EFD_MAX_FAST_EXTENTS - 1) * sizeof(xfs_extent_t))),
-				      "xfs_efd_item");
-	xfs_efi_zone = kmem_zone_init((sizeof(xfs_efi_log_item_t) +
-				       ((XFS_EFI_MAX_FAST_EXTENTS - 1) * sizeof(xfs_extent_t))),
-				      "xfs_efi_item");
-	xfs_ifork_zone = kmem_zone_init(sizeof(xfs_ifork_t), "xfs_ifork");
-	xfs_ili_zone = kmem_zone_init(sizeof(xfs_inode_log_item_t), "xfs_ili");
-	xfs_chashlist_zone = kmem_zone_init(sizeof(xfs_chashlist_t),
-					    "xfs_chashlist");
+		kmem_cache_create("xfs_buf_item", buf_item_zone_size,
+				0, 0, NULL, NULL);
+	xfs_efd_zone = kmem_cache_create("xfs_efd_item", edf_zone_size,
+				0, 0, NULL, NULL);
+	xfs_efi_zone = kmem_cache_create("xfs_efi_item", efi_zone_size,
+				0, 0, NULL, NULL);
+	xfs_ifork_zone = kmem_cache_create("xfs_ifork", sizeof(xfs_ifork_t),
+				0, 0, NULL, NULL);
+	xfs_ili_zone = kmem_cache_create("xfs_ili", sizeof(xfs_inode_log_item_t),
+				0, 0, NULL, NULL);
+	xfs_chashlist_zone =
+		kmem_cache_create("xfs_chashlist", sizeof(xfs_chashlist_t),
+				  0, 0, NULL, NULL);
 	xfs_acl_zone_init(xfs_acl_zone, "xfs_acl");
 
 	/*
