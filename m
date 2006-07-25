Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWGYAR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWGYAR7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWGYAR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:17:59 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:5043 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932350AbWGYAR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:17:58 -0400
Subject: [PATCH] [ufs] Remove incorrect unlock_kernel from failure path in
	ufs_symlink
From: Josh Triplett <josht@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Daniel Pirkl <daniel.pirkl@email.cz>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 17:17:59 -0700
Message-Id: <1153786679.31581.27.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ufs_symlink, in one of its error paths, calls unlock_kernel without ever
having called lock_kernel(); fix this by creating and jumping to a new label
out_notlocked rather than the out label used after calling lock_kernel().

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 fs/ufs/namei.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index abd5f23..d344b41 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -129,7 +129,7 @@ static int ufs_symlink (struct inode * d
 	struct inode * inode;
 
 	if (l > sb->s_blocksize)
-		goto out;
+		goto out_notlocked;
 
 	lock_kernel();
 	inode = ufs_new_inode(dir, S_IFLNK | S_IRWXUGO);
@@ -155,6 +155,7 @@ static int ufs_symlink (struct inode * d
 	err = ufs_add_nondir(dentry, inode);
 out:
 	unlock_kernel();
+out_notlocked:
 	return err;
 
 out_fail:


