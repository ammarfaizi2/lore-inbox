Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966611AbWK3Mac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966611AbWK3Mac (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936349AbWK3MVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:21:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40077 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936344AbWK3MVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:21:22 -0500
Subject: [GFS2] Make sentinel dirents compatible with gfs1 [51/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:21:18 +0000
Message-Id: <1164889278.3752.407.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 5e7d65cd9d3819512b059f4260de0119b985454c Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Fri, 17 Nov 2006 12:27:44 -0500
Subject: [PATCH] [GFS2] Make sentinel dirents compatible with gfs1

When deleting directory entries, we set the inum.no_addr to zero
in a dirent when its the first dirent in a block and thus cannot
be merged into the previous dirent as is the usual case. In gfs1,
inum.no_formal_ino was used instead.

This patch changes gfs2 to set both inum.no_addr and inum.no_formal_ino
to zero. It also changes the test from just looking at inum.no_addr to
look at both inum.no_addr and inum.no_formal_ino and a sentinel is
now considered to be a dirent in which _either_ (or both) of them
is set to zero.

This resolves Red Hat bugzillas: #215809, #211465

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/dir.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index a2923fb..0fdcb77 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -340,10 +340,15 @@ fail:
 	return (copied) ? copied : error;
 }
 
+static inline int gfs2_dirent_sentinel(const struct gfs2_dirent *dent)
+{
+	return dent->de_inum.no_addr == 0 || dent->de_inum.no_formal_ino == 0;
+}
+
 static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
 				     const struct qstr *name, int ret)
 {
-	if (dent->de_inum.no_addr != 0 &&
+	if (!gfs2_dirent_sentinel(dent) &&
 	    be32_to_cpu(dent->de_hash) == name->hash &&
 	    be16_to_cpu(dent->de_name_len) == name->len &&
 	    memcmp(dent+1, name->name, name->len) == 0)
@@ -388,7 +393,7 @@ static int gfs2_dirent_find_space(const 
 	unsigned actual = GFS2_DIRENT_SIZE(be16_to_cpu(dent->de_name_len));
 	unsigned totlen = be16_to_cpu(dent->de_rec_len);
 
-	if (!dent->de_inum.no_addr)
+	if (gfs2_dirent_sentinel(dent))
 		actual = GFS2_DIRENT_SIZE(0);
 	if (totlen - actual >= required)
 		return 1;
@@ -405,7 +410,7 @@ static int gfs2_dirent_gather(const stru
 			      void *opaque)
 {
 	struct dirent_gather *g = opaque;
-	if (dent->de_inum.no_addr) {
+	if (!gfs2_dirent_sentinel(dent)) {
 		g->pdent[g->offset++] = dent;
 	}
 	return 0;
@@ -433,10 +438,10 @@ static int gfs2_check_dirent(struct gfs2
 	if (unlikely(offset + size > len))
 		goto error;
 	msg = "zero inode number";
-	if (unlikely(!first && !dent->de_inum.no_addr))
+	if (unlikely(!first && gfs2_dirent_sentinel(dent)))
 		goto error;
 	msg = "name length is greater than space in dirent";
-	if (dent->de_inum.no_addr &&
+	if (!gfs2_dirent_sentinel(dent) &&
 	    unlikely(sizeof(struct gfs2_dirent)+be16_to_cpu(dent->de_name_len) >
 		     size))
 		goto error;
@@ -598,7 +603,7 @@ static int dirent_next(struct gfs2_inode
 		return ret;
 
         /* Only the first dent could ever have de_inum.no_addr == 0 */
-	if (!tmp->de_inum.no_addr) {
+	if (gfs2_dirent_sentinel(tmp)) {
 		gfs2_consist_inode(dip);
 		return -EIO;
 	}
@@ -621,7 +626,7 @@ static void dirent_del(struct gfs2_inode
 {
 	u16 cur_rec_len, prev_rec_len;
 
-	if (!cur->de_inum.no_addr) {
+	if (gfs2_dirent_sentinel(cur)) {
 		gfs2_consist_inode(dip);
 		return;
 	}
@@ -633,7 +638,8 @@ static void dirent_del(struct gfs2_inode
 	   out the inode number and return.  */
 
 	if (!prev) {
-		cur->de_inum.no_addr = 0;	/* No endianess worries */
+		cur->de_inum.no_addr = 0;
+		cur->de_inum.no_formal_ino = 0;
 		return;
 	}
 
@@ -664,7 +670,7 @@ static struct gfs2_dirent *gfs2_init_dir
 	struct gfs2_dirent *ndent;
 	unsigned offset = 0, totlen;
 
-	if (dent->de_inum.no_addr)
+	if (!gfs2_dirent_sentinel(dent))
 		offset = GFS2_DIRENT_SIZE(be16_to_cpu(dent->de_name_len));
 	totlen = be16_to_cpu(dent->de_rec_len);
 	BUG_ON(offset + name->len > totlen);
@@ -1002,7 +1008,7 @@ static int dir_split_leaf(struct inode *
 		if (dirent_next(dip, obh, &next))
 			next = NULL;
 
-		if (dent->de_inum.no_addr &&
+		if (!gfs2_dirent_sentinel(dent) &&
 		    be32_to_cpu(dent->de_hash) < divider) {
 			struct qstr str;
 			str.name = (char*)(dent+1);
-- 
1.4.1



