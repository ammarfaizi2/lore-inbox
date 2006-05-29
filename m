Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbWE2VfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWE2VfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWE2V0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:26:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9939 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751360AbWE2VZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:25:53 -0400
Date: Mon, 29 May 2006 23:26:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 38/61] lock validator: special locking: i_mutex
Message-ID: <20060529212613.GL3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

teach special (recursive) locking code to the lock validator. Has no
effect on non-lockdep kernels.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/usb/core/inode.c |    2 +-
 fs/namei.c               |   24 ++++++++++++------------
 include/linux/fs.h       |   14 ++++++++++++++
 3 files changed, 27 insertions(+), 13 deletions(-)

Index: linux/drivers/usb/core/inode.c
===================================================================
--- linux.orig/drivers/usb/core/inode.c
+++ linux/drivers/usb/core/inode.c
@@ -201,7 +201,7 @@ static void update_sb(struct super_block
 	if (!root)
 		return;
 
-	mutex_lock(&root->d_inode->i_mutex);
+	mutex_lock_nested(&root->d_inode->i_mutex, I_MUTEX_PARENT);
 
 	list_for_each_entry(bus, &root->d_subdirs, d_u.d_child) {
 		if (bus->d_inode) {
Index: linux/fs/namei.c
===================================================================
--- linux.orig/fs/namei.c
+++ linux/fs/namei.c
@@ -1422,7 +1422,7 @@ struct dentry *lock_rename(struct dentry
 	struct dentry *p;
 
 	if (p1 == p2) {
-		mutex_lock(&p1->d_inode->i_mutex);
+		mutex_lock_nested(&p1->d_inode->i_mutex, I_MUTEX_PARENT);
 		return NULL;
 	}
 
@@ -1430,30 +1430,30 @@ struct dentry *lock_rename(struct dentry
 
 	for (p = p1; p->d_parent != p; p = p->d_parent) {
 		if (p->d_parent == p2) {
-			mutex_lock(&p2->d_inode->i_mutex);
-			mutex_lock(&p1->d_inode->i_mutex);
+			mutex_lock_nested(&p2->d_inode->i_mutex, I_MUTEX_PARENT);
+			mutex_lock_nested(&p1->d_inode->i_mutex, I_MUTEX_CHILD);
 			return p;
 		}
 	}
 
 	for (p = p2; p->d_parent != p; p = p->d_parent) {
 		if (p->d_parent == p1) {
-			mutex_lock(&p1->d_inode->i_mutex);
-			mutex_lock(&p2->d_inode->i_mutex);
+			mutex_lock_nested(&p1->d_inode->i_mutex, I_MUTEX_PARENT);
+			mutex_lock_nested(&p2->d_inode->i_mutex, I_MUTEX_CHILD);
 			return p;
 		}
 	}
 
-	mutex_lock(&p1->d_inode->i_mutex);
-	mutex_lock(&p2->d_inode->i_mutex);
+	mutex_lock_nested(&p1->d_inode->i_mutex, I_MUTEX_PARENT);
+	mutex_lock_nested(&p2->d_inode->i_mutex, I_MUTEX_CHILD);
 	return NULL;
 }
 
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
-	mutex_unlock(&p1->d_inode->i_mutex);
+	mutex_unlock_non_nested(&p1->d_inode->i_mutex);
 	if (p1 != p2) {
-		mutex_unlock(&p2->d_inode->i_mutex);
+		mutex_unlock_non_nested(&p2->d_inode->i_mutex);
 		mutex_unlock(&p1->d_inode->i_sb->s_vfs_rename_mutex);
 	}
 }
@@ -1750,7 +1750,7 @@ struct dentry *lookup_create(struct name
 {
 	struct dentry *dentry = ERR_PTR(-EEXIST);
 
-	mutex_lock(&nd->dentry->d_inode->i_mutex);
+	mutex_lock_nested(&nd->dentry->d_inode->i_mutex, I_MUTEX_PARENT);
 	/*
 	 * Yucky last component or no last component at all?
 	 * (foo/., foo/.., /////)
@@ -2007,7 +2007,7 @@ static long do_rmdir(int dfd, const char
 			error = -EBUSY;
 			goto exit1;
 	}
-	mutex_lock(&nd.dentry->d_inode->i_mutex);
+	mutex_lock_nested(&nd.dentry->d_inode->i_mutex, I_MUTEX_PARENT);
 	dentry = lookup_hash(&nd);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
@@ -2081,7 +2081,7 @@ static long do_unlinkat(int dfd, const c
 	error = -EISDIR;
 	if (nd.last_type != LAST_NORM)
 		goto exit1;
-	mutex_lock(&nd.dentry->d_inode->i_mutex);
+	mutex_lock_nested(&nd.dentry->d_inode->i_mutex, I_MUTEX_PARENT);
 	dentry = lookup_hash(&nd);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h
+++ linux/include/linux/fs.h
@@ -558,6 +558,20 @@ struct inode {
 };
 
 /*
+ * inode->i_mutex nesting types for the LOCKDEP validator:
+ *
+ * 0: the object of the current VFS operation
+ * 1: parent
+ * 2: child/target
+ */
+enum inode_i_mutex_lock_type
+{
+	I_MUTEX_NORMAL,
+	I_MUTEX_PARENT,
+	I_MUTEX_CHILD
+};
+
+/*
  * NOTE: in a 32bit arch with a preemptable kernel and
  * an UP compile the i_size_read/write must be atomic
  * with respect to the local cpu (unlike with preempt disabled),
