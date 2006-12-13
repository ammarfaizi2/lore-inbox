Return-Path: <linux-kernel-owner+w=401wt.eu-S965109AbWLMTyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWLMTyy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965110AbWLMTyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:54:16 -0500
Received: from cantor.suse.de ([195.135.220.2]:45488 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965109AbWLMTyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:54:01 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 10/14] DebugFS : more file/directory creation error handling
Date: Wed, 13 Dec 2006 11:53:01 -0800
Message-Id: <11660396202644-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396163757-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com> <11660396091326-git-send-email-greg@kroah.com> <11660396133624-git-send-email-greg@kroah.com> <11660396163757-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <compudj@krystal.dyndns.org>

Correct dentry count to handle creation errors.

This patch puts a dput at the file creation instead of the file removal :
lookup_one_len already returns a dentry with reference count of 1. Then,
the dget() in simple_mknod increments it when the dentry is associated
with a file. In a scenario where simple_create or simple_mkdir returns
an error, this would lead to an unwanted increment of the reference
counter, therefore making file removal impossible.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/debugfs/inode.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index d6c5fb5..554f4a9 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -162,6 +162,7 @@ static int debugfs_create_by_name(const char *name, mode_t mode,
 			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
 		else 
 			error = debugfs_create(parent->d_inode, *dentry, mode);
+		dput(*dentry);
 	} else
 		error = PTR_ERR(*dentry);
 	mutex_unlock(&parent->d_inode->i_mutex);
@@ -273,6 +274,7 @@ EXPORT_SYMBOL_GPL(debugfs_create_dir);
 void debugfs_remove(struct dentry *dentry)
 {
 	struct dentry *parent;
+	int ret = 0;
 	
 	if (!dentry)
 		return;
@@ -284,11 +286,15 @@ void debugfs_remove(struct dentry *dentry)
 	mutex_lock(&parent->d_inode->i_mutex);
 	if (debugfs_positive(dentry)) {
 		if (dentry->d_inode) {
-			if (S_ISDIR(dentry->d_inode->i_mode))
-				simple_rmdir(parent->d_inode, dentry);
-			else
+			if (S_ISDIR(dentry->d_inode->i_mode)) {
+				ret = simple_rmdir(parent->d_inode, dentry);
+				if (ret)
+					printk(KERN_ERR
+						"DebugFS rmdir on %s failed : "
+						"directory not empty.\n",
+						dentry->d_name.name);
+			} else
 				simple_unlink(parent->d_inode, dentry);
-		dput(dentry);
 		}
 	}
 	mutex_unlock(&parent->d_inode->i_mutex);
-- 
1.4.4.2

