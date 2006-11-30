Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936293AbWK3MQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936293AbWK3MQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936298AbWK3MQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:16:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936293AbWK3MP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:15:27 -0500
Subject: [GFS2] Move gfs2_dinode_in to inode.c [19/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:15:46 +0000
Message-Id: <1164888946.3752.342.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From ea744d01c6a5acf1f6171b4c6e1658a742063613 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 31 Oct 2006 15:28:00 -0500
Subject: [PATCH] [GFS2] Move gfs2_dinode_in to inode.c

gfs2_dinode_in() is only ever called from one place, so move it
to that place (in inode.c) and make it static.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |   34 ++++++++++++++++++++++++++++++++++
 fs/gfs2/ondisk.c            |   36 +-----------------------------------
 include/linux/gfs2_ondisk.h |    2 +-
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 9875e93..b39cfcf 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -208,6 +208,40 @@ fail:
 	return ERR_PTR(error);
 }
 
+static void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
+{
+	struct gfs2_dinode_host *di = &ip->i_di;
+	const struct gfs2_dinode *str = buf;
+
+	gfs2_meta_header_in(&di->di_header, buf);
+	gfs2_inum_in(&di->di_num, &str->di_num);
+
+	di->di_mode = be32_to_cpu(str->di_mode);
+	di->di_uid = be32_to_cpu(str->di_uid);
+	di->di_gid = be32_to_cpu(str->di_gid);
+	di->di_nlink = be32_to_cpu(str->di_nlink);
+	di->di_size = be64_to_cpu(str->di_size);
+	di->di_blocks = be64_to_cpu(str->di_blocks);
+	di->di_atime = be64_to_cpu(str->di_atime);
+	di->di_mtime = be64_to_cpu(str->di_mtime);
+	di->di_ctime = be64_to_cpu(str->di_ctime);
+	di->di_major = be32_to_cpu(str->di_major);
+	di->di_minor = be32_to_cpu(str->di_minor);
+
+	di->di_goal_meta = be64_to_cpu(str->di_goal_meta);
+	di->di_goal_data = be64_to_cpu(str->di_goal_data);
+	di->di_generation = be64_to_cpu(str->di_generation);
+
+	di->di_flags = be32_to_cpu(str->di_flags);
+	di->di_payload_format = be32_to_cpu(str->di_payload_format);
+	di->di_height = be16_to_cpu(str->di_height);
+
+	di->di_depth = be16_to_cpu(str->di_depth);
+	di->di_entries = be32_to_cpu(str->di_entries);
+
+	di->di_eattr = be64_to_cpu(str->di_eattr);
+}
+
 /**
  * gfs2_inode_refresh - Refresh the incore copy of the dinode
  * @ip: The GFS2 inode
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index edf8756..062a44f 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -56,7 +56,7 @@ static void gfs2_inum_print(const struct
 	printk(KERN_INFO "  no_addr = %llu\n", (unsigned long long)no->no_addr);
 }
 
-static void gfs2_meta_header_in(struct gfs2_meta_header_host *mh, const void *buf)
+void gfs2_meta_header_in(struct gfs2_meta_header_host *mh, const void *buf)
 {
 	const struct gfs2_meta_header *str = buf;
 
@@ -155,40 +155,6 @@ void gfs2_quota_in(struct gfs2_quota_hos
 	qu->qu_value = be64_to_cpu(str->qu_value);
 }
 
-void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf)
-{
-	struct gfs2_dinode_host *di = &ip->i_di;
-	const struct gfs2_dinode *str = buf;
-
-	gfs2_meta_header_in(&di->di_header, buf);
-	gfs2_inum_in(&di->di_num, &str->di_num);
-
-	di->di_mode = be32_to_cpu(str->di_mode);
-	di->di_uid = be32_to_cpu(str->di_uid);
-	di->di_gid = be32_to_cpu(str->di_gid);
-	di->di_nlink = be32_to_cpu(str->di_nlink);
-	di->di_size = be64_to_cpu(str->di_size);
-	di->di_blocks = be64_to_cpu(str->di_blocks);
-	di->di_atime = be64_to_cpu(str->di_atime);
-	di->di_mtime = be64_to_cpu(str->di_mtime);
-	di->di_ctime = be64_to_cpu(str->di_ctime);
-	di->di_major = be32_to_cpu(str->di_major);
-	di->di_minor = be32_to_cpu(str->di_minor);
-
-	di->di_goal_meta = be64_to_cpu(str->di_goal_meta);
-	di->di_goal_data = be64_to_cpu(str->di_goal_data);
-	di->di_generation = be64_to_cpu(str->di_generation);
-
-	di->di_flags = be32_to_cpu(str->di_flags);
-	di->di_payload_format = be32_to_cpu(str->di_payload_format);
-	di->di_height = be16_to_cpu(str->di_height);
-
-	di->di_depth = be16_to_cpu(str->di_depth);
-	di->di_entries = be32_to_cpu(str->di_entries);
-
-	di->di_eattr = be64_to_cpu(str->di_eattr);
-}
-
 void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf)
 {
 	const struct gfs2_dinode_host *di = &ip->i_di;
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 08d8240..4fc297a 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -528,6 +528,7 @@ #ifdef __KERNEL__
 
 extern void gfs2_inum_in(struct gfs2_inum_host *no, const void *buf);
 extern void gfs2_inum_out(const struct gfs2_inum_host *no, void *buf);
+extern void gfs2_meta_header_in(struct gfs2_meta_header_host *mh, const void *buf);
 extern void gfs2_sb_in(struct gfs2_sb_host *sb, const void *buf);
 extern void gfs2_rindex_in(struct gfs2_rindex_host *ri, const void *buf);
 extern void gfs2_rindex_out(const struct gfs2_rindex_host *ri, void *buf);
@@ -535,7 +536,6 @@ extern void gfs2_rgrp_in(struct gfs2_rgr
 extern void gfs2_rgrp_out(const struct gfs2_rgrp_host *rg, void *buf);
 extern void gfs2_quota_in(struct gfs2_quota_host *qu, const void *buf);
 struct gfs2_inode;
-extern void gfs2_dinode_in(struct gfs2_inode *ip, const void *buf);
 extern void gfs2_dinode_out(const struct gfs2_inode *ip, void *buf);
 extern void gfs2_ea_header_in(struct gfs2_ea_header *ea, const void *buf);
 extern void gfs2_ea_header_out(const struct gfs2_ea_header *ea, void *buf);
-- 
1.4.1



