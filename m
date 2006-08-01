Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750777AbWHBABQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWHBABQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWHAXwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:52:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:14799 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750759AbWHAXwq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:46 -0400
Subject: [PATCH 04/28] OCFS2 is screwy
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:43 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235243.EA4890B4@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OCFS2 plays some games with i_nlink.  It modifies it a bunch in
its unlink function, but rolls back the changes if an error
occurs.  So, we can't just assume that iput_final() will happen
whenever i_nlink hits 0 in ocfs's unlink().

Create a helper function to do the hard work of i_nlink hitting
zero, and use it in ocfs2.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/libfs.c         |    6 ++++++
 lxc-dave/fs/ocfs2/namei.c   |    8 +++++---
 lxc-dave/include/linux/fs.h |    9 +++++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

diff -puN fs/ocfs2/namei.c~ofcfs-is-screwy fs/ocfs2/namei.c
--- lxc/fs/ocfs2/namei.c~ofcfs-is-screwy	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/ocfs2/namei.c	2006-08-01 16:35:16.000000000 -0700
@@ -909,6 +909,8 @@ static int ocfs2_unlink(struct inode *di
 leave:
 	if (status < 0 && saved_nlink)
 		inode->i_nlink = saved_nlink;
+	if (inode->i_nlink == 0)
+		__inode_set_awaiting_final_iput(inode);
 
 	if (handle)
 		ocfs2_commit_trans(handle);
@@ -1329,7 +1331,7 @@ static int ocfs2_rename(struct inode *ol
 	}
 
 	if (new_inode) {
-		new_inode->i_nlink--;
+		inode_drop_nlink(new_inode);
 		new_inode->i_ctime = CURRENT_TIME;
 	}
 	old_dir->i_ctime = old_dir->i_mtime = CURRENT_TIME;
@@ -1340,9 +1342,9 @@ static int ocfs2_rename(struct inode *ol
 		PARENT_INO(old_inode_de_bh->b_data) =
 			cpu_to_le64(OCFS2_I(new_dir)->ip_blkno);
 		status = ocfs2_journal_dirty(handle, old_inode_de_bh);
-		old_dir->i_nlink--;
+		inode_drop_nlink(old_dir);
 		if (new_inode) {
-			new_inode->i_nlink--;
+			inode_drop_nlink(new_inode);
 		} else {
 			new_dir->i_nlink++;
 			mark_inode_dirty(new_dir);
diff -puN fs/libfs.c~ofcfs-is-screwy fs/libfs.c
--- lxc/fs/libfs.c~ofcfs-is-screwy	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-08-01 16:35:16.000000000 -0700
@@ -270,6 +270,11 @@ out:
 	return ret;
 }
 
+void __inode_set_awaiting_final_iput(struct inode *inode)
+{
+}
+EXPORT_SYMBOL_GPL(inode_drop_nlink);
+
 int simple_unlink(struct inode *dir, struct dentry *dentry)
 {
 	struct inode *inode = dentry->d_inode;
@@ -617,6 +622,7 @@ EXPORT_SYMBOL(simple_commit_write);
 EXPORT_SYMBOL(simple_dir_inode_operations);
 EXPORT_SYMBOL(simple_dir_operations);
 EXPORT_SYMBOL(simple_empty);
+EXPORT_SYMBOL(__inode_set_awaiting_final_iput);
 EXPORT_SYMBOL(d_alloc_name);
 EXPORT_SYMBOL(simple_fill_super);
 EXPORT_SYMBOL(simple_getattr);
diff -puN drivers/usb/core/inode.c~ofcfs-is-screwy drivers/usb/core/inode.c
diff -puN include/linux/fs.h~ofcfs-is-screwy include/linux/fs.h
--- lxc/include/linux/fs.h~ofcfs-is-screwy	2006-08-01 16:35:15.000000000 -0700
+++ lxc-dave/include/linux/fs.h	2006-08-01 16:35:16.000000000 -0700
@@ -1257,9 +1257,18 @@ static inline void inode_inc_link_count(
 }
 
 extern void __inode_set_awaiting_final_iput(struct inode *inode);
+static inline void inode_clear_nlink(struct inode *inode)
+{
+	if (inode->i_nlink)
+		__inode_set_awaiting_final_iput(inode);
+	inode->i_nlink = 0;
+}
+
 static inline void inode_drop_nlink(struct inode *inode)
 {
 	inode->i_nlink--;
+	if (!inode->i_nlink)
+		__inode_set_awaiting_final_iput(inode);
 }
 
 static inline void inode_dec_link_count(struct inode *inode)
_
