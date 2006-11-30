Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936260AbWK3MMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936260AbWK3MMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936264AbWK3MMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:12:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50053 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936261AbWK3MMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:12:09 -0500
Subject: [GFS2] split gfs2_sb [3/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:12:51 +0000
Message-Id: <1164888771.3752.307.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From f50dfaf78c01df3cc2d8819f07d6661915567bae Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 13 Oct 2006 20:45:02 -0400
Subject: [PATCH] [GFS2] split gfs2_sb

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/incore.h            |    2 +-
 fs/gfs2/ondisk.c            |    2 +-
 fs/gfs2/super.c             |    2 +-
 fs/gfs2/super.h             |    2 +-
 include/linux/gfs2_ondisk.h |   22 +++++++++++++++++++++-
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 1c876e0..bd596ba 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -450,7 +450,7 @@ struct gfs2_sbd {
 	struct super_block *sd_vfs_meta;
 	struct kobject sd_kobj;
 	unsigned long sd_flags;	/* SDF_... */
-	struct gfs2_sb sd_sb;
+	struct gfs2_sb_host sd_sb;
 
 	/* Constants computed on mount */
 
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 52cb9a2..5b32f1a 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -79,7 +79,7 @@ static void gfs2_meta_header_print(const
 	pv(mh, mh_format, "%u");
 }
 
-void gfs2_sb_in(struct gfs2_sb *sb, const void *buf)
+void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf)
 {
 	const struct gfs2_sb *str = buf;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 6a78b1b..52aa322 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -97,7 +97,7 @@ void gfs2_tune_init(struct gfs2_tune *gt
  * changed.
  */
 
-int gfs2_check_sb(struct gfs2_sbd *sdp, struct gfs2_sb *sb, int silent)
+int gfs2_check_sb(struct gfs2_sbd *sdp, struct gfs2_sb_host *sb, int silent)
 {
 	unsigned int x;
 
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index 5bb443a..ac95064 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -14,7 +14,7 @@ #include "incore.h"
 
 void gfs2_tune_init(struct gfs2_tune *gt);
 
-int gfs2_check_sb(struct gfs2_sbd *sdp, struct gfs2_sb *sb, int silent);
+int gfs2_check_sb(struct gfs2_sbd *sdp, struct gfs2_sb_host *sb, int silent);
 int gfs2_read_sb(struct gfs2_sbd *sdp, struct gfs2_glock *gl, int silent);
 struct page *gfs2_read_super(struct super_block *sb, sector_t sector);
 
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 0e67a89..b7bdfef 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -128,6 +128,26 @@ struct gfs2_sb {
 	/* In gfs1, quota and license dinodes followed */
 };
 
+struct gfs2_sb_host {
+	struct gfs2_meta_header sb_header;
+
+	__be32 sb_fs_format;
+	__be32 sb_multihost_format;
+	__u32  __pad0;	/* Was superblock flags in gfs1 */
+
+	__be32 sb_bsize;
+	__be32 sb_bsize_shift;
+	__u32 __pad1;	/* Was journal segment size in gfs1 */
+
+	struct gfs2_inum sb_master_dir; /* Was jindex dinode in gfs1 */
+	struct gfs2_inum __pad2; /* Was rindex dinode in gfs1 */
+	struct gfs2_inum sb_root_dir;
+
+	char sb_lockproto[GFS2_LOCKNAME_LEN];
+	char sb_locktable[GFS2_LOCKNAME_LEN];
+	/* In gfs1, quota and license dinodes followed */
+};
+
 /*
  * resource index structure
  */
@@ -450,7 +470,7 @@ #ifdef __KERNEL__
 
 extern void gfs2_inum_in(struct gfs2_inum *no, const void *buf);
 extern void gfs2_inum_out(const struct gfs2_inum *no, void *buf);
-extern void gfs2_sb_in(struct gfs2_sb *sb, const void *buf);
+extern void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf);
 extern void gfs2_rindex_in(struct gfs2_rindex *ri, const void *buf);
 extern void gfs2_rindex_out(const struct gfs2_rindex *ri, void *buf);
 extern void gfs2_rgrp_in(struct gfs2_rgrp *rg, const void *buf);
-- 
1.4.1



