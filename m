Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936316AbWK3MQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936316AbWK3MQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936296AbWK3MQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:16:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44168 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936298AbWK3MPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:15:35 -0500
Subject: [GFS2] Change argument to gfs2_dinode_print [20/70]
From: Steven Whitehouse <swhiteho@redhat.com>
To: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Thu, 30 Nov 2006 12:15:51 +0000
Message-Id: <1164888951.3752.344.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From 4cc14f0b88bf3e0b508143e091eb5a8dff3e3b9c Mon Sep 17 00:00:00 2001
From: Steven Whitehouse <swhiteho@redhat.com>
Date: Tue, 31 Oct 2006 19:00:24 -0500
Subject: [PATCH] [GFS2] Change argument to gfs2_dinode_print

Change argument for gfs2_dinode_print in order to prepare
for removal of duplicate fields between struct inode and
struct gfs2_dinode_host.

Signed-off-by: Steven Whitehouse <swhiteho@redhat.com>
---
 fs/gfs2/inode.c             |    8 ++++----
 fs/gfs2/ondisk.c            |    4 +++-
 fs/gfs2/ops_inode.c         |    4 ++--
 include/linux/gfs2_ondisk.h |    2 +-
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index b39cfcf..4c5d286 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -269,7 +269,7 @@ int gfs2_inode_refresh(struct gfs2_inode
 
 	if (ip->i_num.no_addr != ip->i_di.di_num.no_addr) {
 		if (gfs2_consist_inode(ip))
-			gfs2_dinode_print(&ip->i_di);
+			gfs2_dinode_print(ip);
 		return -EIO;
 	}
 	if (ip->i_num.no_formal_ino != ip->i_di.di_num.no_formal_ino)
@@ -289,7 +289,7 @@ int gfs2_dinode_dealloc(struct gfs2_inod
 
 	if (ip->i_di.di_blocks != 1) {
 		if (gfs2_consist_inode(ip))
-			gfs2_dinode_print(&ip->i_di);
+			gfs2_dinode_print(ip);
 		return -EIO;
 	}
 
@@ -359,7 +359,7 @@ int gfs2_change_nlink(struct gfs2_inode 
 	   bigger than the old one, we must have underflowed. */
 	if (diff < 0 && nlink > ip->i_di.di_nlink) {
 		if (gfs2_consist_inode(ip))
-			gfs2_dinode_print(&ip->i_di);
+			gfs2_dinode_print(ip);
 		return -EIO;
 	}
 
@@ -1010,7 +1010,7 @@ int gfs2_rmdiri(struct gfs2_inode *dip, 
 
 	if (ip->i_di.di_entries != 2) {
 		if (gfs2_consist_inode(ip))
-			gfs2_dinode_print(&ip->i_di);
+			gfs2_dinode_print(ip);
 		return -EIO;
 	}
 
diff --git a/fs/gfs2/ondisk.c b/fs/gfs2/ondisk.c
index 062a44f..77bed44 100644
--- a/fs/gfs2/ondisk.c
+++ b/fs/gfs2/ondisk.c
@@ -190,8 +190,10 @@ void gfs2_dinode_out(const struct gfs2_i
 
 }
 
-void gfs2_dinode_print(const struct gfs2_dinode_host *di)
+void gfs2_dinode_print(const struct gfs2_inode *ip)
 {
+	const struct gfs2_dinode_host *di = &ip->i_di;
+
 	gfs2_meta_header_print(&di->di_header);
 	gfs2_inum_print(&di->di_num);
 
diff --git a/fs/gfs2/ops_inode.c b/fs/gfs2/ops_inode.c
index bd26885..b2c2fe6 100644
--- a/fs/gfs2/ops_inode.c
+++ b/fs/gfs2/ops_inode.c
@@ -467,7 +467,7 @@ static int gfs2_rmdir(struct inode *dir,
 
 	if (ip->i_di.di_entries < 2) {
 		if (gfs2_consist_inode(ip))
-			gfs2_dinode_print(&ip->i_di);
+			gfs2_dinode_print(ip);
 		error = -EIO;
 		goto out_gunlock;
 	}
@@ -640,7 +640,7 @@ static int gfs2_rename(struct inode *odi
 		if (S_ISDIR(nip->i_di.di_mode)) {
 			if (nip->i_di.di_entries < 2) {
 				if (gfs2_consist_inode(nip))
-					gfs2_dinode_print(&nip->i_di);
+					gfs2_dinode_print(nip);
 				error = -EIO;
 				goto out_gunlock;
 			}
diff --git a/include/linux/gfs2_ondisk.h b/include/linux/gfs2_ondisk.h
index 4fc297a..cf4c655 100644
--- a/include/linux/gfs2_ondisk.h
+++ b/include/linux/gfs2_ondisk.h
@@ -549,7 +549,7 @@ extern void gfs2_quota_change_in(struct 
 /* Printing functions */
 
 extern void gfs2_rindex_print(const struct gfs2_rindex_host *ri);
-extern void gfs2_dinode_print(const struct gfs2_dinode_host *di);
+extern void gfs2_dinode_print(const struct gfs2_inode *ip);
 
 #endif /* __KERNEL__ */
 
-- 
1.4.1



