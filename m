Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTIPMg6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTIPMg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:36:58 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:24688 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id S261868AbTIPMg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:36:56 -0400
Date: Tue, 16 Sep 2003 07:36:53 -0500
From: Dave Kleikamp <shaggy@austin.ibm.com>
Message-Id: <200309161236.h8GCarV0024239@shaggy.austin.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [2.6.0-test5] Severe data corruption on JFS
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a severe data corruption problem in JFS on the
2.6.0-test5 kernel.

Andrew,
Please apply this to the -mm kernel.

Thanks,
Shaggy

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1315  -> 1.1316 
#	   fs/jfs/jfs_imap.c	1.25    -> 1.26   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/16	shaggy@shaggy.austin.ibm.com	1.1316
# JFS: Fix rampant data corruption
# 
# A recent change causes pervasive data corruption by over-writing inode
# metadata with a word of garbage.  The field, di_rdev, should only be set
# for a device inode.
# --------------------------------------------
#
diff -Nru a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
--- a/fs/jfs/jfs_imap.c	Tue Sep 16 07:25:50 2003
+++ b/fs/jfs/jfs_imap.c	Tue Sep 16 07:25:50 2003
@@ -3041,10 +3041,11 @@
 	jfs_ip->next_index = le32_to_cpu(dip->di_next_index);
 	jfs_ip->otime = le32_to_cpu(dip->di_otime.tv_sec);
 	jfs_ip->acltype = le32_to_cpu(dip->di_acltype);
-	jfs_ip->dev = le32_to_cpu(dip->di_rdev);
 
-	if (S_ISCHR(ip->i_mode) || S_ISBLK(ip->i_mode))
+	if (S_ISCHR(ip->i_mode) || S_ISBLK(ip->i_mode)) {
+		jfs_ip->dev = le32_to_cpu(dip->di_rdev);
 		ip->i_rdev = old_decode_dev(jfs_ip->dev);
+	}
 
 	if (S_ISDIR(ip->i_mode)) {
 		memcpy(&jfs_ip->i_dirtable, &dip->di_dirtable, 384);
@@ -3101,7 +3102,8 @@
 	dip->di_otime.tv_sec = cpu_to_le32(jfs_ip->otime);
 	dip->di_otime.tv_nsec = 0;
 	dip->di_acltype = cpu_to_le32(jfs_ip->acltype);
-	dip->di_rdev = cpu_to_le32(jfs_ip->dev);
+	if (S_ISCHR(ip->i_mode) || S_ISBLK(ip->i_mode))
+		dip->di_rdev = cpu_to_le32(jfs_ip->dev);
 }
 
 #ifdef	_JFS_DEBUG_IMAP
