Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbTDNMZ4 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 08:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbTDNMZ4 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 08:25:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:59281 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261191AbTDNMZw (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 08:25:52 -0400
Date: Mon, 14 Apr 2003 18:24:00 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       reiserfs-dev@namesys.com, owner-xfs@oss.sgi.com,
       chaffee@cs.berkeley.edu
Subject: [patch] DCACHE_REFERENCED uses
Message-ID: <20030414182400.C27092@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes the way DCACHE_REFERENCED flag is used. It 
got messed up in dcache_rcu iterations. I hope this will be ok now.

The flag was meant to be advisory flag which is used while 
prune_dcache() so as not to free dentries which have recently 
entered d_lru list. At first pass in prune_dcache the dentries 
marked DCACHE_REFERENCED are left with the flag reset. and they 
are freed in the next pass.

So, now we mark the dentry as DCACHE_REFERENCED when it is first 
entering the d_lru list in dput() and resetthe flag in prune_dcache().
If the flag remains reset in the next call to prune_dcache(), the 
dentry is then freed.

Also I don't think any file system have to use this flag as it is taken
care by the dcache layer. The patch removes such code from a few of file
systems. Moreover these filesystems were anyway doing worng thing as they
were changing the flag out of dcache_lock.


Changes:
o dput() marks dentry DCACHE_REFERENCED when it is added to the dentry_unused
  list
o no need to set the flag in dget, dget_locked, d_lookup as these guys anyway
  increments the ref count.
o check the ref count in prune_dcache and use DCACHE_REFERENCED flag just for
  two stage aging.
o remove code for setting DACACHE_REFERENCED from reiserfs, fat, xfs and 
  exportfs.

[maneesh@maze try]$ diffstat DCACHE_REF.patch 
 fs/dcache.c              |   20 ++++++++------------
 fs/exportfs/expfs.c      |    3 ---
 fs/fat/inode.c           |    1 -
 fs/reiserfs/inode.c      |    1 -
 fs/xfs/linux/xfs_super.c |    1 -
 include/linux/dcache.h   |    1 -
 6 files changed, 8 insertions(+), 19 deletions(-)


diff -urN linux-2.5.67-base/fs/dcache.c linux-2.5.67-DCACHE_REF/fs/dcache.c
--- linux-2.5.67-base/fs/dcache.c	Mon Apr  7 23:00:42 2003
+++ linux-2.5.67-DCACHE_REF/fs/dcache.c	Fri Apr 11 15:41:32 2003
@@ -155,12 +155,11 @@
  	if (d_unhashed(dentry))
 		goto kill_it;
   	if (list_empty(&dentry->d_lru)) {
-  		dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
+  		dentry->d_vfs_flags |= DCACHE_REFERENCED;
   		list_add(&dentry->d_lru, &dentry_unused);
   		dentry_stat.nr_unused++;
   	}
  	spin_unlock(&dentry->d_lock);
-	dentry->d_vfs_flags |= DCACHE_REFERENCED;
 	spin_unlock(&dcache_lock);
 	return;
 
@@ -250,7 +249,6 @@
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
-	dentry->d_vfs_flags |= DCACHE_REFERENCED;
 	if (atomic_read(&dentry->d_count) == 1) {
 		dentry_stat.nr_unused--;
 		list_del_init(&dentry->d_lru);
@@ -379,17 +377,16 @@
 		dentry = list_entry(tmp, struct dentry, d_lru);
 
  		spin_lock(&dentry->d_lock);
+		/* leave inuse dentries */
+ 		if (atomic_read(&dentry->d_count)) {
+ 			spin_unlock(&dentry->d_lock);
+			continue;
+		}
 		/* If the dentry was recently referenced, don't free it. */
 		if (dentry->d_vfs_flags & DCACHE_REFERENCED) {
 			dentry->d_vfs_flags &= ~DCACHE_REFERENCED;
-
-			/* don't add non zero d_count dentries 
-			 * back to d_lru list
-			 */
- 			if (!atomic_read(&dentry->d_count)) {
- 				list_add(&dentry->d_lru, &dentry_unused);
- 				dentry_stat.nr_unused++;
- 			}
+ 			list_add(&dentry->d_lru, &dentry_unused);
+ 			dentry_stat.nr_unused++;
  			spin_unlock(&dentry->d_lock);
 			continue;
 		}
@@ -1016,7 +1013,6 @@
 		if (likely(move_count == dentry->d_move_count)) {
 			if (!d_unhashed(dentry)) {
 				atomic_inc(&dentry->d_count);
-				dentry->d_vfs_flags |= DCACHE_REFERENCED;
 				found = dentry;
 			}
 		}
diff -urN linux-2.5.67-base/fs/exportfs/expfs.c linux-2.5.67-DCACHE_REF/fs/exportfs/expfs.c
--- linux-2.5.67-base/fs/exportfs/expfs.c	Mon Apr  7 23:02:26 2003
+++ linux-2.5.67-DCACHE_REF/fs/exportfs/expfs.c	Fri Apr 11 15:29:21 2003
@@ -91,7 +91,6 @@
 			if (dentry != result &&
 			    acceptable(context, dentry)) {
 				dput(result);
-				dentry->d_vfs_flags |= DCACHE_REFERENCED;
 				return dentry;
 			}
 			spin_lock(&dcache_lock);
@@ -271,7 +270,6 @@
 		if (dentry != result &&
 		    acceptable(context, dentry)) {
 			dput(result);
-			dentry->d_vfs_flags |= DCACHE_REFERENCED;
 			return dentry;
 		}
 		spin_lock(&dcache_lock);
@@ -434,7 +432,6 @@
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
-	result->d_vfs_flags |= DCACHE_REFERENCED;
 	return result;
 }
 
diff -urN linux-2.5.67-base/fs/fat/inode.c linux-2.5.67-DCACHE_REF/fs/fat/inode.c
--- linux-2.5.67-base/fs/fat/inode.c	Mon Apr  7 23:01:13 2003
+++ linux-2.5.67-DCACHE_REF/fs/fat/inode.c	Fri Apr 11 15:29:21 2003
@@ -608,7 +608,6 @@
 		return ERR_PTR(-ENOMEM);
 	}
 	result->d_op = sb->s_root->d_op;
-	result->d_vfs_flags |= DCACHE_REFERENCED;
 	return result;
 }
 
diff -urN linux-2.5.67-base/fs/reiserfs/inode.c linux-2.5.67-DCACHE_REF/fs/reiserfs/inode.c
--- linux-2.5.67-base/fs/reiserfs/inode.c	Mon Apr  7 23:01:00 2003
+++ linux-2.5.67-DCACHE_REF/fs/reiserfs/inode.c	Fri Apr 11 15:29:21 2003
@@ -1260,7 +1260,6 @@
 	    iput(inode);
 	    return ERR_PTR(-ENOMEM);
     }
-    result->d_vfs_flags |= DCACHE_REFERENCED;
     return result;
 }
 
diff -urN linux-2.5.67-base/fs/xfs/linux/xfs_super.c linux-2.5.67-DCACHE_REF/fs/xfs/linux/xfs_super.c
--- linux-2.5.67-base/fs/xfs/linux/xfs_super.c	Mon Apr  7 23:02:48 2003
+++ linux-2.5.67-DCACHE_REF/fs/xfs/linux/xfs_super.c	Fri Apr 11 15:29:21 2003
@@ -741,7 +741,6 @@
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
-	result->d_vfs_flags |= DCACHE_REFERENCED;
 	return result;
 }
 
diff -urN linux-2.5.67-base/include/linux/dcache.h linux-2.5.67-DCACHE_REF/include/linux/dcache.h
--- linux-2.5.67-base/include/linux/dcache.h	Mon Apr  7 23:03:01 2003
+++ linux-2.5.67-DCACHE_REF/include/linux/dcache.h	Fri Apr 11 15:29:21 2003
@@ -270,7 +270,6 @@
 		if (!atomic_read(&dentry->d_count))
 			BUG();
 		atomic_inc(&dentry->d_count);
-		dentry->d_vfs_flags |= DCACHE_REFERENCED;
 	}
 	return dentry;
 }

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
