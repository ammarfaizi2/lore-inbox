Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290519AbSAQXcq>; Thu, 17 Jan 2002 18:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290522AbSAQXcj>; Thu, 17 Jan 2002 18:32:39 -0500
Received: from nat.transgeek.com ([66.92.79.28]:65262 "EHLO smtp.transgeek.com")
	by vger.kernel.org with ESMTP id <S290519AbSAQXcc>;
	Thu, 17 Jan 2002 18:32:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Craig Christophel <merlin@transgeek.com>
To: linux-kernel@vger.kernel.org
Subject: attr.c::notify_change() -- locking_change
Date: Thu, 17 Jan 2002 18:33:42 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020118043308.B9A75B581@smtp.transgeek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok this is a first attempt at changing notify_change().....

please look at the following code for any obvious issues.  especially the 
wait_on_inode functions.  I am not sure if a new specific wait_on_attr_inode 
should be created or if this change is OK.  I am trying to remove the BKL (-- 
so any "please review all filesystems" comments are unneeded as I know this.) 
from the VFS layer and this is just one small portion of that effort. 

Craig

Index: linux/fs//attr.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/attr.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 attr.c
--- linux/fs//attr.c	16 Jan 2002 18:26:33 -0000	1.1.1.1
+++ linux/fs//attr.c	17 Jan 2002 23:30:14 -0000
@@ -111,10 +111,13 @@
 	return dn_mask;
 }
 
+/* inode_lock is needed to protect i_state */
+
+extern spinlock_t inode_lock;
 int notify_change(struct dentry * dentry, struct iattr * attr)
 {
 	struct inode *inode = dentry->d_inode;
-	int error;
+	int error,tflag;
 	time_t now = CURRENT_TIME;
 	unsigned int ia_valid = attr->ia_valid;
 
@@ -127,7 +130,25 @@
 	if (!(ia_valid & ATTR_MTIME_SET))
 		attr->ia_mtime = now;
 
-	lock_kernel();
+	/*
+	 * The special i_state flag I_ATTR_LOCK protects
+	 * the following code block  this is for serialization
+	 * purposes previously managed by lock_kernel();
+	 */
+
+	do {
+		wait_on_inode(inode,I_ATTR_LOCK);
+		spin_lock(&inode_lock);
+		if(inode->i_state & I_ATTR_LOCK) {
+			spin_unlock(&inode_lock);
+		}
+		else {
+			inode->i_state =| I_ATTR_LOCK;
+			tflag = 1;
+			spin_unlock(&inode_lock);
+		}
+	} while(!tflag);
+
 	if (inode->i_op && inode->i_op->setattr) 
 		error = inode->i_op->setattr(dentry, attr);
 	else {
@@ -140,7 +161,9 @@
 				error = inode_setattr(inode, attr);
 		}
 	}
-	unlock_kernel();
+	spin_lock(&inode_lock);
+	inode->i_state =& ~I_ATTR_LOCK;
+	spin_unlock(&inode_lock);
 	if (!error) {
 		unsigned long dn_mask = setattr_mask(ia_valid);
 		if (dn_mask)
Index: linux/fs//inode.c
===================================================================
RCS file: /home/Media/cvs/linux/fs/inode.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 inode.c
--- linux/fs//inode.c	16 Jan 2002 18:26:32 -0000	1.1.1.1
+++ linux/fs//inode.c	17 Jan 2002 23:01:57 -0000
@@ -163,14 +163,14 @@
 	spin_unlock(&inode_lock);
 }
 
-static void __wait_on_inode(struct inode * inode)
+static void __wait_on_inode(struct inode * inode,int flag)
 {
 	DECLARE_WAITQUEUE(wait, current);
 
 	add_wait_queue(&inode->i_wait, &wait);
 repeat:
 	set_current_state(TASK_UNINTERRUPTIBLE);
-	if (inode->i_state & I_LOCK) {
+	if (inode->i_state & flag) {
 		schedule();
 		goto repeat;
 	}
@@ -178,13 +178,6 @@
 	current->state = TASK_RUNNING;
 }
 
-static inline void wait_on_inode(struct inode *inode)
-{
-	if (inode->i_state & I_LOCK)
-		__wait_on_inode(inode);
-}
-
-
 static inline void write_inode(struct inode *inode, int sync)
 {
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->write_inode && 
!is_bad_inode(inode))
@@ -250,7 +243,7 @@
 	if (inode->i_state & I_LOCK) {
 		__iget(inode);
 		spin_unlock(&inode_lock);
-		__wait_on_inode(inode);
+		__wait_on_inode(inode,I_LOCK);
 		iput(inode);
 		spin_lock(&inode_lock);
 	} else {
@@ -273,7 +266,7 @@
 		struct inode *inode = list_entry(tmp, struct inode, i_list);
 		__iget(inode);
 		spin_unlock(&inode_lock);
-		__wait_on_inode(inode);
+		__wait_on_inode(inode,I_LOCK);
 		iput(inode);
 		spin_lock(&inode_lock);
 	}
@@ -435,7 +428,7 @@
 			sync_one(inode, sync);
 		spin_unlock(&inode_lock);
 		if (sync)
-			wait_on_inode(inode);
+			wait_on_inode(inode,I_LOCK);
 	}
 	else
 		printk(KERN_ERR "write_inode_now: no super block\n");
@@ -491,7 +484,7 @@
 	if (need_write_inode_now)
 		write_inode_now(inode, 1);
 	else
-		wait_on_inode(inode);
+		wait_on_inode(inode,I_LOCK);
 
 	return err;
 }
@@ -515,7 +508,7 @@
 		BUG();
 	if (inode->i_state & I_CLEAR)
 		BUG();
-	wait_on_inode(inode);
+	wait_on_inode(inode,I_LOCK);
 	DQUOT_DROP(inode);
 	if (inode->i_sb && inode->i_sb->s_op && inode->i_sb->s_op->clear_inode)
 		inode->i_sb->s_op->clear_inode(inode);
@@ -904,7 +897,7 @@
 		spin_unlock(&inode_lock);
 		destroy_inode(inode);
 		inode = old;
-		wait_on_inode(inode);
+		wait_on_inode(inode,I_LOCK);
 	}
 	return inode;
 }
@@ -982,7 +975,7 @@
 	if (inode) {
 		__iget(inode);
 		spin_unlock(&inode_lock);
-		wait_on_inode(inode);
+		wait_on_inode(inode,I_LOCK);
 		return inode;
 	}
 	spin_unlock(&inode_lock);
Index: linux/include/linux//fs.h
===================================================================
RCS file: /home/Media/cvs/linux/include/linux/fs.h,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fs.h
--- linux/include/linux//fs.h	16 Jan 2002 18:28:27 -0000	1.1.1.1
+++ linux/include/linux//fs.h	17 Jan 2002 22:45:23 -0000
@@ -915,9 +915,15 @@
 #define I_LOCK			8
 #define I_FREEING		16
 #define I_CLEAR			32
+#define I_ADDR_LOCK		64
 
 #define I_DIRTY (I_DIRTY_SYNC | I_DIRTY_DATASYNC | I_DIRTY_PAGES)
-
+extern void __wait_on_inode(struct inode *,int);
+static inline void wait_on_inode(struct inode *inode, int flag);
+{
+	if (inode->i_state & flag)
+		__wait_on_inode(inode,flag);
+}
 extern void __mark_inode_dirty(struct inode *, int);
 static inline void mark_inode_dirty(struct inode *inode)
 {

