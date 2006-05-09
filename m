Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751431AbWEIG7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWEIG7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 02:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWEIG7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 02:59:18 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5568 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751431AbWEIG7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 02:59:18 -0400
Date: Tue, 9 May 2006 12:29:17 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: linux-kernel@vger.kernel.org, systemtap@sources.redhat.com
Cc: akpm@osdl.org, Andi Kleen <ak@suse.de>, davem@davemloft.net,
       suparna@in.ibm.com, richardj_moore@uk.ibm.com
Subject: Re: [RFC] [PATCH 1/6] Kprobes: Allow/deny exclusive write access to inodes
Message-ID: <20060509065917.GA22493@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20060509065455.GA11630@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060509065455.GA11630@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds two new wrapper routines to namei.c file
to decrement and increment the inode writecount. Other
routine deny_write_access() decrements the inode
writecount for a given file pointer. But there is no
wrapper routine that decrement's the inode writecount
for a given inode pointer. Also there is no routine that
increment's the inode writecount, if it less than zero.
Even the existing deny_write_access() is modified to use
the new wrapper routine. Kprobe's user-space probes uses
these wrapper routines to get and release exclusive
write access to the probed binary.

Signed-off-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>


 fs/namei.c            |   34 +++++++++++++++++++++++++++++++---
 include/linux/namei.h |    2 ++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff -puN fs/namei.c~kprobes_userspace_probes-denywrite-to-inode fs/namei.c
--- linux-2.6.17-rc3-mm1/fs/namei.c~kprobes_userspace_probes-denywrite-to-inode	2006-05-09 10:08:38.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/fs/namei.c	2006-05-09 10:08:39.000000000 +0530
@@ -322,10 +322,13 @@ int get_write_access(struct inode * inod
 	return 0;
 }
 
-int deny_write_access(struct file * file)
+/* This routine decrements the writecount for a given inode to
+ * get exclusive write access, so that the file on which probes
+ * are currently applied does not change. User-space probes
+ * uses this routine.
+ */
+int deny_write_access_to_inode(struct inode *inode)
 {
-	struct inode *inode = file->f_dentry->d_inode;
-
 	spin_lock(&inode->i_lock);
 	if (atomic_read(&inode->i_writecount) > 0) {
 		spin_unlock(&inode->i_lock);
@@ -337,6 +340,31 @@ int deny_write_access(struct file * file
 	return 0;
 }
 
+/* This routine increments the writecount for a given inode.
+ * to release the write lock. User-space probes uses this
+ * routine.
+ */
+int write_access_to_inode(struct inode *inode)
+{
+	spin_lock(&inode->i_lock);
+	if (atomic_read(&inode->i_writecount) >= 0) {
+		spin_unlock(&inode->i_lock);
+		return -ETXTBSY;
+	}
+	atomic_inc(&inode->i_writecount);
+	spin_unlock(&inode->i_lock);
+
+	return 0;
+}
+
+/* Wrapper routine that decrements the writecount for a given file pointer. */
+int deny_write_access(struct file * file)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+
+	return deny_write_access_to_inode(inode);
+}
+
 void path_release(struct nameidata *nd)
 {
 	dput(nd->dentry);
diff -puN include/linux/namei.h~kprobes_userspace_probes-denywrite-to-inode include/linux/namei.h
--- linux-2.6.17-rc3-mm1/include/linux/namei.h~kprobes_userspace_probes-denywrite-to-inode	2006-05-09 10:08:38.000000000 +0530
+++ linux-2.6.17-rc3-mm1-prasanna/include/linux/namei.h	2006-05-09 10:08:39.000000000 +0530
@@ -81,6 +81,8 @@ extern int follow_up(struct vfsmount **,
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
+extern int deny_write_access_to_inode(struct inode *inode);
+extern int write_access_to_inode(struct inode *inode);
 
 static inline void nd_set_link(struct nameidata *nd, char *path)
 {

_
-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
