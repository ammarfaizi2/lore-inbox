Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936349AbWK3Mfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936349AbWK3Mfx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936359AbWK3Mex
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:34:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59273 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936259AbWK3MRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:17:03 -0500
Subject: [GFS2] Shrink gfs2_inode (7) - di_payload_format [27/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:16:35 +0000
Message-Id: <1164888995.3752.358.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From a9583c7983cbba9726bfe64ee46613d654fc9e26 Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Wed, 1 Nov 2006 20:09:14 -0500
Subject: [PATCH] [GFS2] Shrink gfs2_inode (7) - di_payload_format

This is almost never used. Its there for backward
compatibility with GFS1. It doesn't need its own
field since it can always be calculated from the
inode mode & flags. This saves a bit more space
in the gfs2_inode.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/dir.c               |    1 -
 fs/gfs2/inode.c             |    3 +--
 fs/gfs2/ondisk.c            |    6 +++---
 fs/gfs2/ops_inode.c         |    1 -
 include/linux/gfs2_ondisk.h |    1 -
 5 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index ca23c8b..c82d7cb 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -902,7 +902,6 @@ static int dir_make_exhash(struct inode 
 	dip->i_di.di_size = sdp->sd_sb.sb_bsize / 2;
 	dip->i_di.di_blocks++;
 	dip->i_di.di_flags |= GFS2_DIF_EXHASH;
-	dip->i_di.di_payload_format = 0;
 
 	for (x = sdp->sd_hash_ptrs, y = -1; x; x >>= 1, y++) ;
 	dip->i_di.di_depth = y;
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c22ae3c..f6177fc 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -210,7 +210,6 @@ static int gfs2_dinode_in(struct gfs2_in
 	di->di_generation = be64_to_cpu(str->di_generation);
 
 	di->di_flags = be32_to_cpu(str->di_flags);
-	di->di_payload_format = be32_to_cpu(str->di_payload_format);
 	di->di_height = be16_to_cpu(str->di_height);
 
 	di->di_depth = be16_to_cpu(str->di_depth);
@@ -699,7 +698,7 @@ static void init_dinode(struct gfs2_inod
 	}
 
 	di->__pad1 = 0;
-	di->di_payload_format = cpu_to_be32(0);
+	di->di_payload_format = cpu_to_be32(S_ISDIR(mode) ? GFS2_FORMAT_DE : 0);
 	di->di_height = cpu_to_be32(0);
 	di->__pad2 = 0;
 	di->__pad3 = 0;
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 82003e8..b2baba5 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -176,9 +176,10 @@ void gfs2_dinode_out(const struct gfs2_i
 	str->di_generation = cpu_to_be64(di->di_generation);
 
 	str->di_flags = cpu_to_be32(di->di_flags);
-	str->di_payload_format = cpu_to_be32(di->di_payload_format);
 	str->di_height = cpu_to_be16(di->di_height);
-
+	str->di_payload_format = cpu_to_be32(S_ISDIR(ip->i_inode.i_mode) &&
+					     !(ip->i_di.di_flags & GFS2_DIF_EXHASH) ?
+					     GFS2_FORMAT_DE : 0);
 	str->di_depth = cpu_to_be16(di->di_depth);
 	str->di_entries = cpu_to_be32(di->di_entries);
 
@@ -197,7 +198,6 @@ void gfs2_dinode_print(const struct gfs2
 	printk(KERN_INFO "  di_goal_data = %llu\n", (unsigned long long)di->di_goal_data);
 
 	pv(di, di_flags, "0x%.8X");
-	pv(di, di_payload_format, "%u");
 	pv(di, di_height, "%u");
 
 	pv(di, di_depth, "%u");
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index 585b43a..0e4eade 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -389,7 +389,6 @@ static int gfs2_mkdir(struct inode *dir,
 	ip->i_inode.i_nlink = 2;
 	ip->i_di.di_size = sdp->sd_sb.sb_bsize - sizeof(struct gfs2_dinode);
 	ip->i_di.di_flags |= GFS2_DIF_JDATA;
-	ip->i_di.di_payload_format = GFS2_FORMAT_DE;
 	ip->i_di.di_entries = 2;
 
 	error = gfs2_meta_inode_buffer(ip, &dibh);
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 7f5a4a1..536575e 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -333,7 +333,6 @@ struct gfs2_dinode_host {
 	__u64 di_generation;	/* generation number for NFS */
 
 	__u32 di_flags;	/* GFS2_DIF_... */
-	__u32 di_payload_format;  /* GFS2_FORMAT_... */
 	__u16 di_height;	/* height of metadata */
 
 	/* These only apply to directories  */
-- 
1.4.1



