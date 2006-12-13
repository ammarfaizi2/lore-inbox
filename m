Return-Path: <linux-kernel-owner+w=401wt.eu-S965113AbWLMTyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbWLMTyx (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbWLMTyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:54:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:53203 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965105AbWLMTxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:53:51 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 7/14] DebugFS : inotify create/mkdir support
Date: Wed, 13 Dec 2006 11:52:58 -0800
Message-Id: <11660396091326-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <1166039606191-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <compudj@krystal.dyndns.org>

Add inotify create and mkdir events to DebugFS.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/debugfs/inode.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 137d76c..020da4c 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -24,6 +24,7 @@
 #include <linux/kobject.h>
 #include <linux/namei.h>
 #include <linux/debugfs.h>
+#include <linux/fsnotify.h>
 
 #define DEBUGFS_MAGIC	0x64626720
 
@@ -87,15 +88,22 @@ static int debugfs_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 
 	mode = (mode & (S_IRWXUGO | S_ISVTX)) | S_IFDIR;
 	res = debugfs_mknod(dir, dentry, mode, 0);
-	if (!res)
+	if (!res) {
 		inc_nlink(dir);
+		fsnotify_mkdir(dir, dentry);
+	}
 	return res;
 }
 
 static int debugfs_create(struct inode *dir, struct dentry *dentry, int mode)
 {
+	int res;
+
 	mode = (mode & S_IALLUGO) | S_IFREG;
-	return debugfs_mknod(dir, dentry, mode, 0);
+	res = debugfs_mknod(dir, dentry, mode, 0);
+	if (!res)
+		fsnotify_create(dir, dentry);
+	return res;
 }
 
 static inline int debugfs_positive(struct dentry *dentry)
-- 
1.4.4.2

