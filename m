Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVA1P7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVA1P7i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 10:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVA1P7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 10:59:38 -0500
Received: from smtp2.rz.tu-harburg.de ([134.28.205.13]:13940 "EHLO
	smtp2.rz.tu-harburg.de") by vger.kernel.org with ESMTP
	id S261260AbVA1P7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 10:59:23 -0500
Message-ID: <41FA6136.20407@tu-harburg.de>
Date: Fri, 28 Jan 2005 16:58:46 +0100
From: Jan Blunck <j.blunck@tu-harburg.de>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       raven@themaw.net, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] d_drop should use per dentry lock
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------020508060801050800010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020508060801050800010101
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

d_drop() must use the dentry->d_lock spinlock. In some cases __d_drop() 
was used without holding the dentry->d_lock spinlock, too. This could 
end in a race with __d_lookup().

Regards,
Jan


--------------020508060801050800010101
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
--- testing-um.orig/include/linux/dcache.h	2005-01-28 15:06:27.000000000 +0100
+++ testing-um/include/linux/dcache.h	2005-01-28 15:58:15.000000000 +0100
@@ -186,7 +186,9 @@
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
--- testing-um.orig/fs/namei.c	2005-01-28 15:58:15.000000000 +0100
+++ testing-um/fs/namei.c	2005-01-28 15:58:15.000000000 +0100
@@ -1684,17 +1684,13 @@
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
--- testing-um.orig/fs/sysfs/inode.c	2005-01-28 15:06:24.000000000 +0100
+++ testing-um/fs/sysfs/inode.c	2005-01-28 15:58:15.000000000 +0100
@@ -129,13 +129,17 @@
 
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
--- testing-um.orig/fs/dcache.c	2005-01-28 15:53:19.000000000 +0100
+++ testing-um/fs/dcache.c	2005-01-28 16:52:49.609883016 +0100
@@ -340,13 +340,16 @@
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
--- testing-um.orig/fs/autofs4/root.c	2005-01-28 15:53:22.000000000 +0100
+++ testing-um/fs/autofs4/root.c	2005-01-28 16:04:35.000000000 +0100
@@ -605,7 +605,9 @@
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
--- testing-um.orig/fs/proc/base.c	2005-01-28 15:53:38.000000000 +0100
+++ testing-um/fs/proc/base.c	2005-01-28 16:29:14.000000000 +0100
@@ -1468,11 +1468,15 @@
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

--------------020508060801050800010101--
