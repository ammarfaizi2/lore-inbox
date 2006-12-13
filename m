Return-Path: <linux-kernel-owner+w=401wt.eu-S965130AbWLMT41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbWLMT41 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWLMTyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:54:15 -0500
Received: from ns.suse.de ([195.135.220.2]:45498 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965112AbWLMTyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:54:06 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <compudj@krystal.dyndns.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 11/14] DebugFS : file/directory removal fix
Date: Wed, 13 Dec 2006 11:53:02 -0800
Message-Id: <11660396233517-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.2
In-Reply-To: <11660396202644-git-send-email-greg@kroah.com>
References: <20061213195226.GA6736@kroah.com> <1166039585152-git-send-email-greg@kroah.com> <11660395913232-git-send-email-greg@kroah.com> <11660395951158-git-send-email-greg@kroah.com> <11660395998-git-send-email-greg@kroah.com> <11660396032350-git-send-email-greg@kroah.com> <1166039606191-git-send-email-greg@kroah.com> <11660396091326-git-send-email-greg@kroah.com> <11660396133624-git-send-email-greg@kroah.com> <11660396163757-git-send-email-greg@kroah.com> <11660396202644-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <compudj@krystal.dyndns.org>

Fix file and directory removal in debugfs. Add inotify support for file removal.

The following scenario :
create dir a
create dir a/b

cd a/b (some process goes in cwd a/b)

rmdir a/b
rmdir a

fails due to the fact that "a" appears to be non empty. It is because
the "b" dentry is not deleted from "a" and still in use. The same
problem happens if "b" is a file. d_delete is nice enough to know when
it needs to unhash and free the dentry if nothing else is using it or,
if someone is using it, to remove it from the hash queues and wait for
it to be deleted when it has no users.

The nice side-effect of this fix is that it calls the file removal
notification.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/debugfs/inode.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 554f4a9..c692487 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -286,6 +286,7 @@ void debugfs_remove(struct dentry *dentry)
 	mutex_lock(&parent->d_inode->i_mutex);
 	if (debugfs_positive(dentry)) {
 		if (dentry->d_inode) {
+			dget(dentry);
 			if (S_ISDIR(dentry->d_inode->i_mode)) {
 				ret = simple_rmdir(parent->d_inode, dentry);
 				if (ret)
@@ -295,6 +296,9 @@ void debugfs_remove(struct dentry *dentry)
 						dentry->d_name.name);
 			} else
 				simple_unlink(parent->d_inode, dentry);
+			if (!ret)
+				d_delete(dentry);
+			dput(dentry);
 		}
 	}
 	mutex_unlock(&parent->d_inode->i_mutex);
-- 
1.4.4.2

