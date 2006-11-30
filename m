Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936273AbWK3MOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936273AbWK3MOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936269AbWK3MOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:14:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46471 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936278AbWK3MOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:14:11 -0500
Subject: [GFS2] split and annotate gfs2_statfs_change [13/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:14:47 +0000
Message-Id: <1164888887.3752.329.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From bd209cc017f231e8536550bdab1bf5da93c32798 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 23:43:19 -0400
Subject: [PATCH] [GFS2] split and annotate gfs2_statfs_change

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/incore.h            |    4 ++--
 fs/gfs2/ondisk.c            |    4 ++--
 fs/gfs2/ops_super.c         |    2 +-
 fs/gfs2/super.c             |   22 +++++++++++-----------
 fs/gfs2/super.h             |    4 ++--
 include/linux/gfs2_ondisk.h |   10 ++++++++--
 6 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 20c9b4f..c0a8c3b 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -503,8 +503,8 @@ struct gfs2_sbd {
 
 	spinlock_t sd_statfs_spin;
 	struct mutex sd_statfs_mutex;
-	struct gfs2_statfs_change sd_statfs_master;
-	struct gfs2_statfs_change sd_statfs_local;
+	struct gfs2_statfs_change_host sd_statfs_master;
+	struct gfs2_statfs_change_host sd_statfs_local;
 	unsigned long sd_statfs_sync_time;
 
 	/* Resource group stuff */
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 5db0737..84c59b1 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -279,7 +279,7 @@ void gfs2_inum_range_out(const struct gf
 	str->ir_length = cpu_to_be64(ir->ir_length);
 }
 
-void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, const void *buf)
+void gfs2_statfs_change_in(struct gfs2_statfs_change_host *sc, const void *buf)
 {
 	const struct gfs2_statfs_change *str = buf;
 
@@ -288,7 +288,7 @@ void gfs2_statfs_change_in(struct gfs2_s
 	sc->sc_dinodes = be64_to_cpu(str->sc_dinodes);
 }
 
-void gfs2_statfs_change_out(const struct gfs2_statfs_change *sc, void *buf)
+void gfs2_statfs_change_out(const struct gfs2_statfs_change_host *sc, void *buf)
 {
 	struct gfs2_statfs_change *str = buf;
 
diff --git a/fs/gfs2/ops_super.c b/fs/gfs2/ops_super.c
index b47d959..9c786d1 100644
--- a/fs/gfs2/ops_super.c
+++ b/fs/gfs2/ops_super.c
@@ -215,7 +215,7 @@ static int gfs2_statfs(struct dentry *de
 {
 	struct super_block *sb = dentry->d_inode->i_sb;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
-	struct gfs2_statfs_change sc;
+	struct gfs2_statfs_change_host sc;
 	int error;
 
 	if (gfs2_tune_get(sdp, gt_statfs_slow))
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 0faf563..0ef8317 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -587,9 +587,9 @@ int gfs2_make_fs_ro(struct gfs2_sbd *sdp
 int gfs2_statfs_init(struct gfs2_sbd *sdp)
 {
 	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
-	struct gfs2_statfs_change *m_sc = &sdp->sd_statfs_master;
+	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
 	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
-	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 	struct buffer_head *m_bh, *l_bh;
 	struct gfs2_holder gh;
 	int error;
@@ -634,7 +634,7 @@ void gfs2_statfs_change(struct gfs2_sbd 
 			s64 dinodes)
 {
 	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
-	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 	struct buffer_head *l_bh;
 	int error;
 
@@ -660,8 +660,8 @@ int gfs2_statfs_sync(struct gfs2_sbd *sd
 {
 	struct gfs2_inode *m_ip = GFS2_I(sdp->sd_statfs_inode);
 	struct gfs2_inode *l_ip = GFS2_I(sdp->sd_sc_inode);
-	struct gfs2_statfs_change *m_sc = &sdp->sd_statfs_master;
-	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
+	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 	struct gfs2_holder gh;
 	struct buffer_head *m_bh, *l_bh;
 	int error;
@@ -727,10 +727,10 @@ out:
  * Returns: errno
  */
 
-int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc)
+int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host *sc)
 {
-	struct gfs2_statfs_change *m_sc = &sdp->sd_statfs_master;
-	struct gfs2_statfs_change *l_sc = &sdp->sd_statfs_local;
+	struct gfs2_statfs_change_host *m_sc = &sdp->sd_statfs_master;
+	struct gfs2_statfs_change_host *l_sc = &sdp->sd_statfs_local;
 
 	spin_lock(&sdp->sd_statfs_spin);
 
@@ -760,7 +760,7 @@ int gfs2_statfs_i(struct gfs2_sbd *sdp, 
  */
 
 static int statfs_slow_fill(struct gfs2_rgrpd *rgd,
-			    struct gfs2_statfs_change *sc)
+			    struct gfs2_statfs_change_host *sc)
 {
 	gfs2_rgrp_verify(rgd);
 	sc->sc_total += rgd->rd_ri.ri_data;
@@ -782,7 +782,7 @@ static int statfs_slow_fill(struct gfs2_
  * Returns: errno
  */
 
-int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc)
+int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host *sc)
 {
 	struct gfs2_holder ri_gh;
 	struct gfs2_rgrpd *rgd_next;
@@ -792,7 +792,7 @@ int gfs2_statfs_slow(struct gfs2_sbd *sd
 	int done;
 	int error = 0, err;
 
-	memset(sc, 0, sizeof(struct gfs2_statfs_change));
+	memset(sc, 0, sizeof(struct gfs2_statfs_change_host));
 	gha = kcalloc(slots, sizeof(struct gfs2_holder), GFP_KERNEL);
 	if (!gha)
 		return -ENOMEM;
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index ac95064..e590b2d 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -45,8 +45,8 @@ int gfs2_statfs_init(struct gfs2_sbd *sd
 void gfs2_statfs_change(struct gfs2_sbd *sdp,
 			s64 total, s64 free, s64 dinodes);
 int gfs2_statfs_sync(struct gfs2_sbd *sdp);
-int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc);
-int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change *sc);
+int gfs2_statfs_i(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host *sc);
+int gfs2_statfs_slow(struct gfs2_sbd *sdp, struct gfs2_statfs_change_host *sc);
 
 int gfs2_freeze_fs(struct gfs2_sbd *sdp);
 void gfs2_unfreeze_fs(struct gfs2_sbd *sdp);
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 431e03b..3ce3a47 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -497,6 +497,12 @@ struct gfs2_statfs_change {
 	__be64 sc_dinodes;
 };
 
+struct gfs2_statfs_change_host {
+	__u64 sc_total;
+	__u64 sc_free;
+	__u64 sc_dinodes;
+};
+
 /*
  * Quota change
  * Describes an allocation change for a particular
@@ -529,8 +535,8 @@ extern void gfs2_ea_header_out(const str
 extern void gfs2_log_header_in(struct gfs2_log_header_host *lh, const void *buf);
 extern void gfs2_inum_range_in(struct gfs2_inum_range_host *ir, const void *buf);
 extern void gfs2_inum_range_out(const struct gfs2_inum_range_host *ir, void *buf);
-extern void gfs2_statfs_change_in(struct gfs2_statfs_change *sc, const void *buf);
-extern void gfs2_statfs_change_out(const struct gfs2_statfs_change *sc, void *buf);
+extern void gfs2_statfs_change_in(struct gfs2_statfs_change_host *sc, const void *buf);
+extern void gfs2_statfs_change_out(const struct gfs2_statfs_change_host *sc, void *buf);
 extern void gfs2_quota_change_in(struct gfs2_quota_change *qc, const void *buf);
 
 /* Printing functions */
-- 
1.4.1



