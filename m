Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVBPOQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVBPOQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 09:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbVBPOQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 09:16:51 -0500
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:59483 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S262020AbVBPOQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 09:16:43 -0500
Message-ID: <421355A4.6000305@tu-harburg.de>
Date: Wed, 16 Feb 2005 15:16:04 +0100
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, raven@themaw.net,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] dcache d_drop() bug fix / __d_drop() use fix
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------010301090402040904030608"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010301090402040904030608
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This is a re-submission of the patch I sent about a month ago.

While working on my code I realized that d_drop() might race against 
__d_lookup(). __d_drop() (which is called by d_drop() after acquiring 
the dcache_lock) is accessing dentry->d_flags to set the DCACHE_UNHASHED 
flag. This shouldn't be done without holding dentry->d_lock, like stated 
in dcache.h:

struct dentry {
	...
	unsigned int d_flags;		/* protected by d_lock */
         ...
};

Therefore d_drop() must acquire the dentry->d_lock. Likewise every use 
of __d_drop() must acquire that lock.

This patch fixes d_drop() and every grep'able __d_drop() use. This patch 
is against today's http://linux.bkbits.net/linux-2.5.

Comments please,
Jan



--------------010301090402040904030608
Content-Type: text/x-patch;
 name="d_drop-locking.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d_drop-locking.diff"

Signed-off-by: Jan Blunck <j.blunck@tu-harburg.de>

 fs/autofs4/root.c      |    2 ++
 fs/dcache.c            |    3 +++
 fs/namei.c             |   14 +++++---------
 fs/proc/base.c         |    6 +++++-
 fs/sysfs/inode.c       |    6 +++++-
 include/linux/dcache.h |    2 ++
 6 files changed, 22 insertions(+), 11 deletions(-)

Index: testing-um/include/linux/dcache.h
===================================================================
--- testing-um.orig/include/linux/dcache.h
+++ testing-um/include/linux/dcache.h
@@ -186,7 +186,9 @@ static inline void __d_drop(struct dentr
 static inline void d_drop(struct dentry *dentry)
 {
 	spin_lock(&dcache_lock);
+	spin_lock(&dentry->d_lock);
  	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 }
 
Index: testing-um/fs/namei.c
===================================================================
--- testing-um.orig/fs/namei.c
+++ testing-um/fs/namei.c
@@ -1685,17 +1685,13 @@ out:
 void dentry_unhash(struct dentry *dentry)
 {
 	dget(dentry);
-	spin_lock(&dcache_lock);
-	switch (atomic_read(&dentry->d_count)) {
-	default:
-		spin_unlock(&dcache_lock);
+	if (atomic_read(&dentry->d_count))
 		shrink_dcache_parent(dentry);
-		spin_lock(&dcache_lock);
-		if (atomic_read(&dentry->d_count) != 2)
-			break;
-	case 2:
+	spin_lock(&dcache_lock);
+	spin_lock(&dentry->d_lock);
+	if (atomic_read(&dentry->d_count) == 2)
 		__d_drop(dentry);
-	}
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 }
 
Index: testing-um/fs/sysfs/inode.c
===================================================================
--- testing-um.orig/fs/sysfs/inode.c
+++ testing-um/fs/sysfs/inode.c
@@ -129,13 +129,17 @@ void sysfs_drop_dentry(struct sysfs_dire
 
 	if (dentry) {
 		spin_lock(&dcache_lock);
+		spin_lock(&dentry->d_lock);
 		if (!(d_unhashed(dentry) && dentry->d_inode)) {
 			dget_locked(dentry);
 			__d_drop(dentry);
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			simple_unlink(parent->d_inode, dentry);
-		} else
+		} else {
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
+		}
 	}
 }
 
Index: testing-um/fs/dcache.c
===================================================================
--- testing-um.orig/fs/dcache.c
+++ testing-um/fs/dcache.c
@@ -340,13 +340,16 @@ restart:
 	tmp = head;
 	while ((tmp = tmp->next) != head) {
 		struct dentry *dentry = list_entry(tmp, struct dentry, d_alias);
+		spin_lock(&dentry->d_lock);
 		if (!atomic_read(&dentry->d_count)) {
 			__dget_locked(dentry);
 			__d_drop(dentry);
+			spin_unlock(&dentry->d_lock);
 			spin_unlock(&dcache_lock);
 			dput(dentry);
 			goto restart;
 		}
+		spin_unlock(&dentry->d_lock);
 	}
 	spin_unlock(&dcache_lock);
 }
Index: testing-um/fs/autofs4/root.c
===================================================================
--- testing-um.orig/fs/autofs4/root.c
+++ testing-um/fs/autofs4/root.c
@@ -605,7 +605,9 @@ static int autofs4_dir_rmdir(struct inod
 		spin_unlock(&dcache_lock);
 		return -ENOTEMPTY;
 	}
+	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
+	spin_unlock(&dentry->d_lock);
 	spin_unlock(&dcache_lock);
 
 	dput(ino->dentry);
Index: testing-um/fs/proc/base.c
===================================================================
--- testing-um.orig/fs/proc/base.c
+++ testing-um/fs/proc/base.c
@@ -1630,11 +1630,15 @@ struct dentry *proc_pid_unhash(struct ta
 	if (proc_dentry != NULL) {
 
 		spin_lock(&dcache_lock);
+		spin_lock(&proc_dentry->d_lock);
 		if (!d_unhashed(proc_dentry)) {
 			dget_locked(proc_dentry);
 			__d_drop(proc_dentry);
-		} else
+			spin_unlock(&proc_dentry->d_lock);
+		} else {
+			spin_unlock(&proc_dentry->d_lock);
 			proc_dentry = NULL;
+		}
 		spin_unlock(&dcache_lock);
 	}
 	return proc_dentry;

--------------010301090402040904030608--
