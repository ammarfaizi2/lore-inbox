Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261982AbVF0J0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVF0J0A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 05:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVF0J0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 05:26:00 -0400
Received: from styx.suse.cz ([82.119.242.94]:41686 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261982AbVF0JYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 05:24:50 -0400
Date: Mon, 27 Jun 2005 11:24:49 +0200
From: Zuzana Petrova <zpetrova@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: Michael Gaughen <mgaughen@polyserve.com>
Subject: [PATCH] fs:lock_rename()/unlock_rename() can lead to deadlock in distributed fs.
Message-ID: <20050627092448.GA8822@lilac.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem with lock_rename() is that it compares parent directory dentries  
when trying to decide how many inode i_sem semaphores to acquire.  That works  
fine on a single node system, but not in a distributed environment, on a  
distributed filesystem.  
  
The problem with rename(2) in a cluster, is that there is no guarantee that  
path_lookup()s will return a coherent path structure while at the same time  
renames, on another node, are executing on that same path hierarchy.  In our  
case, in do_rename(), the parent directory path_lookup()s find/create unique  
dentries for the old_dir and new_dir, however, because a rename(2) on another  
node was executing, both dentries end up pointing to the same inode.  
  
When lock_rename(new_dir, old_dir) is called, the dentries don't match, so we  
end up in a code path that tries to acquire the inode i_sem of both the  
old_dir and new_dir, but since they point to the same inode, the second  
attempt to acquire the same i_sem results in a deadlock.  
  
A fix would be to compare the dentries ->d_inode field instead.  Patch for  
kernel 2.6.12.1 attached.

Author of the patch is Michael Gaughen <mgaughen@polyserve.com>

--
Zuzana Petrova

===================================================================
#
# This patch changes lock_rename()/unlock_rename() to compare the inodes
# referenced by the dentries.  The problem with distributed filesystems is
# that there is no guarantee the path_lookup() will return valid path dentry 
# components at the same time rename(2)s of that same path hierarchy are 
# executing on another node.  So there are cases where the dentries, passed 
# to lock_rename()/unlock_rename(), are different, but refer to the same 
# inode.  In that case, the check for equivalent dentries will fail, and an
# attempt to acquire each of the dentries inode will be made, resulting in
# a deadlock since the inodes are the same.
#
--- linux-2.6.11.12.old/fs/namei.c	2005-03-11 13:56:30.877725438 +0100
+++ linux-2.6.11.12/fs/namei.c	2005-03-11 14:01:49.196080914 +0100
@@ -1197,7 +1197,7 @@ lock_rename(
 {
 	struct dentry *p;
 
-	if (p1 == p2) {
+	if (p1->d_inode == p2->d_inode) {
 		down(&p1->d_inode->i_sem);
 		return NULL;
 	}
@@ -1228,7 +1228,7 @@
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	up(&p1->d_inode->i_sem);
-	if (p1 != p2) {
+	if (p1->d_inode != p2->d_inode) {
 		up(&p2->d_inode->i_sem);
 		up(&p1->d_inode->i_sb->s_vfs_rename_sem);
 	}

