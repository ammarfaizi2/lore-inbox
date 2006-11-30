Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936327AbWK3MSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936327AbWK3MSo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936303AbWK3MSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:18:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51594 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936311AbWK3MSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:18:05 -0500
Subject: [GFS2] Only set inode flags when required [33/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:17:44 +0000
Message-Id: <1164889064.3752.370.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 6b124d8dba1f46c5f2caf3b3159bbe627f75b9b6 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 8 Nov 2006 12:51:06 -0500
Subject: [PATCH] [GFS2] Only set inode flags when required

We were setting the inode flags from GFS2's flags far too often, even when they
couldn't possibly have changed. This patch reduces the amount of flag
setting going on so that we do it only when the inode is read in or
when the flags have changed. The create case is covered by the "when
the inode is read in" case.

This also fixes a bug where we didn't set S_SYNC correctly.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c    |   11 +----------
 fs/gfs2/ops_file.c |   19 +++++++++++++++++++
 fs/gfs2/ops_file.h |    2 +-
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index faf9b9e..56b39be 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -54,16 +54,6 @@ void gfs2_inode_attr_in(struct gfs2_inod
 	i_size_write(inode, di->di_size);
 	inode->i_blocks = di->di_blocks <<
 		(GFS2_SB(inode)->sd_sb.sb_bsize_shift - GFS2_BASIC_BLOCK_SHIFT);
-
-	if (di->di_flags & GFS2_DIF_IMMUTABLE)
-		inode->i_flags |= S_IMMUTABLE;
-	else
-		inode->i_flags &= ~S_IMMUTABLE;
-
-	if (di->di_flags & GFS2_DIF_APPENDONLY)
-		inode->i_flags |= S_APPEND;
-	else
-		inode->i_flags &= ~S_APPEND;
 }
 
 static int iget_test(struct inode *inode, void *opaque)
@@ -210,6 +200,7 @@ static int gfs2_dinode_in(struct gfs2_in
 	di->di_generation = be64_to_cpu(str->di_generation);
 
 	di->di_flags = be32_to_cpu(str->di_flags);
+	gfs2_set_inode_flags(&ip->i_inode);
 	di->di_height = be16_to_cpu(str->di_height);
 
 	di->di_depth = be16_to_cpu(str->di_depth);
diff --git a/fs/gfs2/ops_file.c b/fs/gfs2/ops_file.c
index b52b9db..eabf6c6 100644
--- a/fs/gfs2/ops_file.c
+++ b/fs/gfs2/ops_file.c
@@ -266,6 +266,24 @@ static int gfs2_get_flags(struct file *f
 	return error;
 }
 
+void gfs2_set_inode_flags(struct inode *inode)
+{
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_dinode_host *di = &ip->i_di;
+	unsigned int flags = inode->i_flags;
+
+	flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	if (di->di_flags & GFS2_DIF_IMMUTABLE)
+		flags |= S_IMMUTABLE;
+	if (di->di_flags & GFS2_DIF_APPENDONLY)
+		flags |= S_APPEND;
+	if (di->di_flags & GFS2_DIF_NOATIME)
+		flags |= S_NOATIME;
+	if (di->di_flags & GFS2_DIF_SYNC)
+		flags |= S_SYNC;
+	inode->i_flags = flags;
+}
+
 /* Flags that can be set by user space */
 #define GFS2_FLAGS_USER_SET (GFS2_DIF_JDATA|			\
 			     GFS2_DIF_DIRECTIO|			\
@@ -338,6 +356,7 @@ static int do_gfs2_set_flags(struct file
 	ip->i_di.di_flags = new_flags;
 	gfs2_dinode_out(ip, bh->b_data);
 	brelse(bh);
+	gfs2_set_inode_flags(inode);
 out_trans_end:
 	gfs2_trans_end(sdp);
 out:
diff --git a/fs/gfs2/ops_file.h b/fs/gfs2/ops_file.h
index ce319f8..7e5d8ec 100644
--- a/fs/gfs2/ops_file.h
+++ b/fs/gfs2/ops_file.h
@@ -17,7 +17,7 @@ extern struct file gfs2_internal_file_se
 extern int gfs2_internal_read(struct gfs2_inode *ip,
 			      struct file_ra_state *ra_state,
 			      char *buf, loff_t *pos, unsigned size);
-
+extern void gfs2_set_inode_flags(struct inode *inode);
 extern const struct file_operations gfs2_file_fops;
 extern const struct file_operations gfs2_dir_fops;
 
-- 
1.4.1



