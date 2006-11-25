Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967125AbWKYTVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967125AbWKYTVF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967137AbWKYTVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:21:05 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:6669 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S967133AbWKYTVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:21:01 -0500
Date: Sat, 25 Nov 2006 20:21:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/reiser4/: more possible cleanups
Message-ID: <20061125192104.GM3702@stusta.de>
References: <20061123021703.8550e37e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123021703.8550e37e.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly global functions static
- #if 0 unused functions
- #if REISER4_DEBUG functions that are only used with debugging enabled

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/reiser4/coord.c                |    8 ++----
 fs/reiser4/debug.c                |    6 ++++
 fs/reiser4/debug.h                |    4 ---
 fs/reiser4/plugin/cluster.h       |    8 ------
 fs/reiser4/plugin/item/ctail.c    |   10 ++++++-
 fs/reiser4/plugin/item/ctail.h    |    1 
 fs/reiser4/plugin/item/internal.c |    4 +++
 fs/reiser4/plugin/item/item.c     |    4 +++
 fs/reiser4/super.c                |    4 +++
 fs/reiser4/txnmgr.c               |   40 ++++++++++++++++--------------
 fs/reiser4/txnmgr.h               |    6 ----
 11 files changed, 52 insertions(+), 43 deletions(-)

--- linux-2.6.19-rc6-mm1/fs/reiser4/debug.h.old	2006-11-25 02:02:17.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/debug.h	2006-11-25 02:02:25.000000000 +0100
@@ -223,10 +223,6 @@
 extern void reiser4_do_panic(const char *format, ...)
     __attribute__ ((noreturn, format(printf, 1, 2)));
 
-extern void reiser4_print_prefix(const char *level, int reperr, const char *mid,
-				 const char *function,
-				 const char *file, int lineno);
-
 extern int reiser4_preempt_point(void);
 extern void reiser4_print_stats(void);
 
--- linux-2.6.19-rc6-mm1/fs/reiser4/debug.c.old	2006-11-25 02:02:33.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/debug.c	2006-11-25 02:45:37.000000000 +0100
@@ -40,11 +40,13 @@
 #include <linux/sysctl.h>
 #include <linux/hardirq.h>
 
+#if 0
 #if REISER4_DEBUG
 static void reiser4_report_err(void);
 #else
 #define reiser4_report_err() noop
 #endif
+#endif  /*  0  */
 
 /*
  * global buffer where message given to reiser4_panic is formatted.
@@ -95,6 +97,7 @@
 	panic("%s", panic_buf);
 }
 
+#if 0
 void
 reiser4_print_prefix(const char *level, int reperr, const char *mid,
 		     const char *function, const char *file, int lineno)
@@ -114,6 +117,7 @@
 	if (reperr)
 		reiser4_report_err();
 }
+#endif  /*  0  */
 
 /* Preemption point: this should be called periodically during long running
    operations (carry, allocate, and squeeze are best examples) */
@@ -258,6 +262,7 @@
 	}
 }
 
+#if 0
 /*
  * report error information recorder by reiser4_return_err().
  */
@@ -272,6 +277,7 @@
 		}
 	}
 }
+#endif  /*  0  */
 
 #endif				/* REISER4_DEBUG */
 
--- linux-2.6.19-rc6-mm1/fs/reiser4/plugin/cluster.h.old	2006-11-25 02:06:24.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/plugin/cluster.h	2006-11-25 02:49:53.000000000 +0100
@@ -226,14 +226,6 @@
 	return hint->ext_coord.extension.ctail.shift;
 }
 
-static inline void dclust_set_extension_shift(hint_t * hint)
-{
-	assert("edward-1270",
-	       item_id_by_coord(&hint->ext_coord.coord) == CTAIL_ID);
-	hint->ext_coord.extension.ctail.shift =
-	    cluster_shift_by_coord(&hint->ext_coord.coord);
-}
-
 static inline int hint_is_unprepped_dclust(hint_t * hint)
 {
 	assert("edward-1451", hint_is_valid(hint));
--- linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/ctail.h.old	2006-11-25 02:10:13.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/ctail.h	2006-11-25 02:10:21.000000000 +0100
@@ -78,7 +78,6 @@
 int scan_ctail(flush_scan *);
 int convert_ctail(flush_pos_t *);
 size_t inode_scaled_cluster_size(struct inode *);
-int cluster_shift_by_coord(const coord_t * coord);
 
 #endif				/* __FS_REISER4_CTAIL_H__ */
 
--- linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/ctail.c.old	2006-11-25 02:06:45.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/ctail.c	2006-11-25 02:50:04.000000000 +0100
@@ -45,11 +45,19 @@
 	return item_body_by_coord(coord);
 }
 
-int cluster_shift_by_coord(const coord_t * coord)
+static int cluster_shift_by_coord(const coord_t * coord)
 {
 	return get_unaligned(&ctail_formatted_at(coord)->cluster_shift);
 }
 
+static inline void dclust_set_extension_shift(hint_t * hint)
+{
+	assert("edward-1270",
+	       item_id_by_coord(&hint->ext_coord.coord) == CTAIL_ID);
+	hint->ext_coord.extension.ctail.shift =
+	    cluster_shift_by_coord(&hint->ext_coord.coord);
+}
+
 static loff_t off_by_coord(const coord_t * coord)
 {
 	reiser4_key key;
--- linux-2.6.19-rc6-mm1/fs/reiser4/txnmgr.h.old	2006-11-25 02:12:19.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/txnmgr.h	2006-11-25 02:17:18.000000000 +0100
@@ -695,12 +695,6 @@
 void protected_jnodes_done(protected_jnodes * list);
 void reiser4_invalidate_list(struct list_head * head);
 
-#if REISER4_DEBUG
-void reiser4_info_atom(const char *prefix, const txn_atom * atom);
-#else
-#define reiser4_info_atom(p,a) noop
-#endif
-
 # endif				/* __REISER4_TXNMGR_H__ */
 
 /* Make Linus happy.
--- linux-2.6.19-rc6-mm1/fs/reiser4/txnmgr.c.old	2006-11-25 02:12:32.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/txnmgr.c	2006-11-25 02:17:20.000000000 +0100
@@ -977,6 +977,28 @@
 	return current_atom_finish_all_fq();
 }
 
+#if REISER4_DEBUG
+
+static void reiser4_info_atom(const char *prefix, const txn_atom * atom)
+{
+	if (atom == NULL) {
+		printk("%s: no atom\n", prefix);
+		return;
+	}
+
+	printk("%s: refcount: %i id: %i flags: %x txnh_count: %i"
+	       " capture_count: %i stage: %x start: %lu, flushed: %i\n", prefix,
+	       atomic_read(&atom->refcount), atom->atom_id, atom->flags,
+	       atom->txnh_count, atom->capture_count, atom->stage,
+	       atom->start_time, atom->flushed);
+}
+
+#else  /*  REISER4_DEBUG  */
+
+static inline void reiser4_info_atom(const char *prefix, const txn_atom * atom) {}
+
+#endif  /*  REISER4_DEBUG  */
+
 #define TOOMANYFLUSHES (1 << 13)
 
 /* Called with the atom locked and no open "active" transaction handlers except
@@ -3094,24 +3116,6 @@
 	ON_DEBUG(count_jnode(atom, node, NODE_LIST(node), OVRWR_LIST, 1));
 }
 
-#if REISER4_DEBUG
-
-void reiser4_info_atom(const char *prefix, const txn_atom * atom)
-{
-	if (atom == NULL) {
-		printk("%s: no atom\n", prefix);
-		return;
-	}
-
-	printk("%s: refcount: %i id: %i flags: %x txnh_count: %i"
-	       " capture_count: %i stage: %x start: %lu, flushed: %i\n", prefix,
-	       atomic_read(&atom->refcount), atom->atom_id, atom->flags,
-	       atom->txnh_count, atom->capture_count, atom->stage,
-	       atom->start_time, atom->flushed);
-}
-
-#endif
-
 static int count_deleted_blocks_actor(txn_atom * atom,
 				      const reiser4_block_nr * a,
 				      const reiser4_block_nr * b, void *data)
--- linux-2.6.19-rc6-mm1/fs/reiser4/coord.c.old	2006-11-25 17:06:59.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/coord.c	2006-11-25 17:09:03.000000000 +0100
@@ -568,11 +568,6 @@
 }
 
 #if REISER4_DEBUG
-#define DEBUG_COORD_FIELDS (sizeof(c1->plug_v) + sizeof(c1->body_v))
-#else
-#define DEBUG_COORD_FIELDS (0)
-#endif
-
 int coords_equal(const coord_t * c1, const coord_t * c2)
 {
 	assert("nikita-2840", c1 != NULL);
@@ -583,6 +578,7 @@
 	    c1->item_pos == c2->item_pos &&
 	    c1->unit_pos == c2->unit_pos && c1->between == c2->between;
 }
+#endif  /*  REISER4_DEBUG  */
 
 /* If coord_is_after_rightmost return NCOORD_ON_THE_RIGHT, if coord_is_after_leftmost
    return NCOORD_ON_THE_LEFT, otherwise return NCOORD_INSIDE. */
@@ -683,6 +679,7 @@
 	return 0;
 }
 
+#if REISER4_DEBUG
 /* Returns true if the coordinates are positioned at adjacent units, regardless of
    before-after or item boundaries. */
 int coord_are_neighbors(coord_t * c1, coord_t * c2)
@@ -721,6 +718,7 @@
 		return 0;
 	}
 }
+#endif  /*  REISER4_DEBUG  */
 
 /* Assuming two coordinates are positioned in the same node, return COORD_CMP_ON_RIGHT,
    COORD_CMP_ON_LEFT, or COORD_CMP_SAME depending on c1's position relative to c2.  */
--- linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/internal.c.old	2006-11-25 17:11:50.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/internal.c	2006-11-25 17:30:51.000000000 +0100
@@ -144,6 +144,8 @@
 	return 0;
 }
 
+#if REISER4_DEBUG
+
 static void check_link(znode * left, znode * right)
 {
 	znode *scan;
@@ -209,6 +211,8 @@
 	return 0;
 }
 
+#endif  /*  REISER4_DEBUG  */
+
 /* return true only if this item really points to "block" */
 /* Audited by: green(2002.06.14) */
 int has_pointer_to_internal(const coord_t * coord /* coord of item */ ,
--- linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/item.c.old	2006-11-25 17:12:59.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/plugin/item/item.c	2006-11-25 17:15:11.000000000 +0100
@@ -271,6 +271,8 @@
 	return item_id_by_coord(item) == FORMATTING_ID;
 }
 
+#if REISER4_DEBUG
+
 int item_is_statdata(const coord_t * item)
 {
 	assert("vs-516", coord_is_existing_item(item));
@@ -283,6 +285,8 @@
 	return item_id_by_coord(item) == CTAIL_ID;
 }
 
+#endif  /*  REISER4_DEBUG  */
+
 static int change_item(struct inode *inode,
 		       reiser4_plugin * plugin,
 		       pset_member memb)
--- linux-2.6.19-rc6-mm1/fs/reiser4/super.c.old	2006-11-25 17:19:27.000000000 +0100
+++ linux-2.6.19-rc6-mm1/fs/reiser4/super.c	2006-11-25 17:36:54.000000000 +0100
@@ -47,6 +47,7 @@
 	return get_super_private(super)->block_count;
 }
 
+#if REISER4_DEBUG
 /*
  * number of blocks in the current file system
  */
@@ -54,6 +55,7 @@
 {
 	return get_current_super_private()->block_count;
 }
+#endif  /*  REISER4_DEBUG  */
 
 /* set number of block in filesystem */
 void reiser4_set_block_count(const struct super_block *super, __u64 nr)
@@ -293,6 +295,7 @@
 	return *blk < sbinfo->block_count;
 }
 
+#if REISER4_DEBUG
 /*
  * true, if block number @blk makes sense for the current file system
  */
@@ -300,6 +303,7 @@
 {
 	return reiser4_blocknr_is_sane_for(reiser4_get_current_sb(), blk);
 }
+#endif  /*  REISER4_DEBUG  */
 
 /* Make Linus happy.
    Local variables:

