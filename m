Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313502AbSC3QuY>; Sat, 30 Mar 2002 11:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313503AbSC3QuP>; Sat, 30 Mar 2002 11:50:15 -0500
Received: from www.wen-online.de ([212.223.88.39]:57605 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S313502AbSC3QuG>;
	Sat, 30 Mar 2002 11:50:06 -0500
Date: Sat, 30 Mar 2002 17:51:53 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alexander Viro <viro@math.psu.edu>
Subject: Re: vfs_unlink() >=2.5.5-pre1 question
In-Reply-To: <Pine.LNX.4.10.10203301401550.991-100000@mikeg.wen-online.de>
Message-ID: <Pine.LNX.4.10.10203301734490.649-100000@mikeg.wen-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Mar 2002, Mike Galbraith wrote:

> Hi,
> 
> d_delete() doesn't appear to ever create negative dentries when
> called via vfs_unlink() due to the extra reference on the dentry.
> In fact, a printk() in the d_delete() spot never ever triggers...

Well shoot.  I guess I've chased this about as far as I can, and
hope this thread wasn't a total waste.  I found a better way to
get my rm -r to work as before fwiw.  Rewinding the directory on
seek failure (yeah, could do in three lines, but not the point)
works, but is kinda b0rken.  I think the only interesting thing
in the below is the FIXME :)) but I'll post it anyway.

	EOT,

	-Mike

Private comments on this quite welcome.  Locking is a bitch :-)

--- fs/dcache.c.org	Sat Mar 30 12:27:34 2002
+++ fs/dcache.c	Sat Mar 30 17:32:43 2002
@@ -803,7 +803,10 @@
  * @dentry: The dentry to delete
  *
  * Turn the dentry into a negative dentry if possible, otherwise
- * remove it from the hash queues so it can be deleted later
+ * remove it from the hash queues so it can be deleted later.
+ * FIXME:  this assumes more than GOD allows :)
+ * This function must be called while holding an extra reference
+ * to the dentry, and with the dentry's d_inode pinned down.
  */
  
 void d_delete(struct dentry * dentry)
@@ -812,7 +815,7 @@
 	 * Are we the only user?
 	 */
 	spin_lock(&dcache_lock);
-	if (atomic_read(&dentry->d_count) == 1) {
+	if (atomic_read(&dentry->d_count) == 2) {
 		dentry_iput(dentry);
 		return;
 	}
--- fs/namei.c.org	Sat Mar 30 12:54:29 2002
+++ fs/namei.c	Sat Mar 30 17:17:02 2002
@@ -1453,6 +1453,7 @@
 int vfs_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int error = may_delete(dir, dentry, 0);
+	struct inode *inode;
 
 	if (error)
 		return error;
@@ -1463,7 +1464,12 @@
 	DQUOT_INIT(dir);
 
 	dget(dentry);
-	down(&dentry->d_inode->i_sem);
+	inode = igrab(dentry->d_inode);
+	if (!inode) {
+		dput(dentry);
+		return  -EBUSY;
+	}
+	down(&inode->i_sem);
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
@@ -1471,7 +1477,10 @@
 		if (!error)
 			d_delete(dentry);
 	}
-	up(&dentry->d_inode->i_sem);
+	if (inode) {
+		up(&inode->i_sem);
+		iput(inode);
+	}
 	dput(dentry);
 
 	if (!error)

(Hmm.  Actually, rewinding on seek failure is a more useful lie
than a NULL when the thing ain't empty, so I think I'll go apply
the three liner again and see if anything gripes)

