Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbUE1Eic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbUE1Eic (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 00:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265794AbUE1Eic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 00:38:32 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:18118 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262213AbUE1Eib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 00:38:31 -0400
From: NeilBrown <neilb@cse.unsw.edu.au>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 28 May 2004 14:38:26 +1000
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
cc: linux-kernel@vger.kernel.org
Subject: [PATCH]  Avoid race when updating nr_unused count of unused dentries.
References: <20040528143740.31687.patches@notabene>
Message-Id: <E1BTZ8U-0008FT-RU@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


d_count == 1 is no guarantee that dentry is on the dentry_unused list,
even if it has just been incremented inside dcache_lock, as dput can
decrement at any time.

This test from Greg Banks is much safer, and is more transparently correct.

From: Greg Banks <gnb@melbourne.sgi.com>
Signed-off-by: Neil Brown <neilb@cse.unsw.edu.au>

 ----------- Diffstat output ------------
 ./fs/dcache.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff ./fs/dcache.c~current~ ./fs/dcache.c
--- ./fs/dcache.c~current~	2004-05-28 14:20:00.000000000 +1000
+++ ./fs/dcache.c	2004-05-28 14:20:16.000000000 +1000
@@ -259,7 +259,7 @@ int d_invalidate(struct dentry * dentry)
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
-	if (atomic_read(&dentry->d_count) == 1) {
+	if (!list_empty(&dentry->d_lru)) {
 		dentry_stat.nr_unused--;
 		list_del_init(&dentry->d_lru);
 	}
@@ -935,8 +935,9 @@ struct dentry *d_splice_alias(struct ino
  * lookup is going on.
  *
  * dentry_unused list is not updated even if lookup finds the required dentry
- * in there. It is updated in places such as prune_dcache, shrink_dcache_sb and
- * select_parent. This laziness saves lookup from dcache_lock acquisition.
+ * in there. It is updated in places such as prune_dcache, shrink_dcache_sb,
+ * select_parent and __dget_locked. This laziness saves lookup from dcache_lock
+ * acquisition.
  *
  * d_lookup() is protected against the concurrent renames in some unrelated
  * directory using the seqlockt_t rename_lock.
