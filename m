Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWGZSZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWGZSZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWGZSZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 14:25:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:62157 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161012AbWGZSZW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 14:25:22 -0400
Subject: [PATCH] [xfs] Add lock annotations to xfs_trans_update_ail and
	xfs_trans_delete_ail
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, xfs-masters@oss.sgi.com, nathans@sgi.com,
       xfs@oss.sgi.com
Content-Type: text/plain
Date: Wed, 26 Jul 2006 11:25:23 -0700
Message-Id: <1153938323.12517.58.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xfs_trans_update_ail and xfs_trans_delete_ail get called with the AIL lock
held, and release it.  Add lock annotations to these two functions (abstracted
like the AIL lock itself) so that sparse can check callers for lock pairing,
and so that sparse will not complain about these functions since they
intentionally use locks in this manner.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/xfs/xfs_inode.c      |    2 +-
 fs/xfs/xfs_mount.h      |    3 ++-
 fs/xfs/xfs_trans_ail.c  |    2 ++
 fs/xfs/xfs_trans_priv.h |   12 +++++++-----
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 86c1bf0..0d118f0 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -23,12 +23,12 @@ #include "xfs_log.h"
 #include "xfs_inum.h"
 #include "xfs_imap.h"
 #include "xfs_trans.h"
-#include "xfs_trans_priv.h"
 #include "xfs_sb.h"
 #include "xfs_ag.h"
 #include "xfs_dir2.h"
 #include "xfs_dmapi.h"
 #include "xfs_mount.h"
+#include "xfs_trans_priv.h"
 #include "xfs_bmap_btree.h"
 #include "xfs_alloc_btree.h"
 #include "xfs_ialloc_btree.h"
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index b2bd4be..ed91fbb 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -74,7 +74,8 @@ #define	AIL_LOCKINIT(x,y)	spinlock_init(
 #define	AIL_LOCK_DESTROY(x)	spinlock_destroy(x)
 #define	AIL_LOCK(mp,s)		s=mutex_spinlock(&(mp)->m_ail_lock)
 #define	AIL_UNLOCK(mp,s)	mutex_spinunlock(&(mp)->m_ail_lock, s)
-
+#define	ACQUIRES_AIL_LOCK(mp)	__acquires((mp)->m_ail_lock)
+#define	RELEASES_AIL_LOCK(mp,s)	__releases((mp)->m_ail_lock)
 
 /*
  * Prototypes and functions for the Data Migration subsystem.
diff --git a/fs/xfs/xfs_trans_ail.c b/fs/xfs/xfs_trans_ail.c
index 558c87f..5c64909 100644
--- a/fs/xfs/xfs_trans_ail.c
+++ b/fs/xfs/xfs_trans_ail.c
@@ -277,6 +277,7 @@ xfs_trans_update_ail(
 	xfs_log_item_t	*lip,
 	xfs_lsn_t	lsn,
 	unsigned long	s)
+	RELEASES_AIL_LOCK(mp, s)
 {
 	xfs_ail_entry_t		*ailp;
 	xfs_log_item_t		*dlip=NULL;
@@ -329,6 +330,7 @@ xfs_trans_delete_ail(
 	xfs_mount_t	*mp,
 	xfs_log_item_t	*lip,
 	unsigned long	s)
+	RELEASES_AIL_LOCK(mp, s)
 {
 	xfs_ail_entry_t		*ailp;
 	xfs_log_item_t		*dlip;
diff --git a/fs/xfs/xfs_trans_priv.h b/fs/xfs/xfs_trans_priv.h
index 13edab8..fc8c440 100644
--- a/fs/xfs/xfs_trans_priv.h
+++ b/fs/xfs/xfs_trans_priv.h
@@ -46,11 +46,13 @@ xfs_log_busy_slot_t		*xfs_trans_add_busy
 /*
  * From xfs_trans_ail.c
  */
-void			xfs_trans_update_ail(struct xfs_mount *,
-				     struct xfs_log_item *, xfs_lsn_t,
-				     unsigned long);
-void			xfs_trans_delete_ail(struct xfs_mount *,
-				     struct xfs_log_item *, unsigned long);
+void			xfs_trans_update_ail(struct xfs_mount *mp,
+				     struct xfs_log_item *lip, xfs_lsn_t lsn,
+				     unsigned long s)
+				     RELEASES_AIL_LOCK(mp, s);
+void			xfs_trans_delete_ail(struct xfs_mount *mp,
+				     struct xfs_log_item *lip, unsigned long s)
+				     RELEASES_AIL_LOCK(mp, s);
 struct xfs_log_item	*xfs_trans_first_ail(struct xfs_mount *, int *);
 struct xfs_log_item	*xfs_trans_next_ail(struct xfs_mount *,
 				     struct xfs_log_item *, int *, int *);


