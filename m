Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWITN5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWITN5d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 09:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWITN5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 09:57:33 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:40597 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751502AbWITN5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 09:57:32 -0400
Date: Wed, 20 Sep 2006 15:57:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] hypfs crashes with invalid mount option.
Message-ID: <20060920135730.GA24426@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] hypfs crashes with invalid mount option.

When an invalid mount option is specified, no root inode is created
for hypfs, hypfs_fill_super() returns with -EINVAL and then
hypfs_kill_super() is called. hypfs_kill_super() does not check if
the root inode has been initialized. This patch adds this check.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/hypfs/inode.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -urpN linux-2.6/arch/s390/hypfs/inode.c linux-2.6-patched/arch/s390/hypfs/inode.c
--- linux-2.6/arch/s390/hypfs/inode.c	2006-09-20 15:52:40.000000000 +0200
+++ linux-2.6-patched/arch/s390/hypfs/inode.c	2006-09-20 15:53:15.000000000 +0200
@@ -312,10 +312,12 @@ static void hypfs_kill_super(struct supe
 {
 	struct hypfs_sb_info *sb_info = sb->s_fs_info;
 
-	hypfs_delete_tree(sb->s_root);
-	hypfs_remove(sb_info->update_file);
-	kfree(sb->s_fs_info);
-	sb->s_fs_info = NULL;
+	if (sb->s_root) {
+		hypfs_delete_tree(sb->s_root);
+		hypfs_remove(sb_info->update_file);
+		kfree(sb->s_fs_info);
+		sb->s_fs_info = NULL;
+	}
 	kill_litter_super(sb);
 }
 
