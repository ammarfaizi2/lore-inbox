Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbTIELfO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 07:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbTIELfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 07:35:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:19630 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262460AbTIELfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 07:35:03 -0400
Date: Fri, 5 Sep 2003 17:07:14 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: [PATCH] d_delete-d_lookup race fix
Message-ID: <20030905113714.GB1272@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viro,

Thanks for pointing out the race. The patch is appended. 

Andrew, please include this in next -mm, if Viro is ok with it.

Thanks
Maneesh


- d_delete() calls dentry_iput() after releasing the per dentry lock. This
  can race with __d_lookup and lead to situation where we can make dentry 
  negative with ref count > 1. The following patch makes dentry_iput() to hold
  per dentry lock till d_inode is NULL and dentry has been removed from 
  d_alias list.


 fs/dcache.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -puN fs/dcache.c~d_delete-d_lookup-race-fix fs/dcache.c
--- linux-2.6.0-test4-mm6/fs/dcache.c~d_delete-d_lookup-race-fix	2003-09-05 16:16:56.000000000 +0530
+++ linux-2.6.0-test4-mm6-maneesh/fs/dcache.c	2003-09-05 16:50:49.000000000 +0530
@@ -82,7 +82,7 @@ static void d_free(struct dentry *dentry
 /*
  * Release the dentry's inode, using the filesystem
  * d_iput() operation if defined.
- * Called with dcache_lock held, drops it.
+ * Called with dcache_lock and per dentry lock held, drops both.
  */
 static inline void dentry_iput(struct dentry * dentry)
 {
@@ -90,13 +90,16 @@ static inline void dentry_iput(struct de
 	if (inode) {
 		dentry->d_inode = NULL;
 		list_del_init(&dentry->d_alias);
+		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
 		if (dentry->d_op && dentry->d_op->d_iput)
 			dentry->d_op->d_iput(dentry, inode);
 		else
 			iput(inode);
-	} else
+	} else {
+		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
+	}
 }
 
 /* 
@@ -177,9 +180,8 @@ kill_it: {
   			dentry_stat.nr_unused--;
   		}
   		list_del(&dentry->d_child);
- 		spin_unlock(&dentry->d_lock);
 		dentry_stat.nr_dentry--;	/* For d_free, below */
-		/* drops the lock, at that point nobody can reach this dentry */
+		/*drops the locks, at that point nobody can reach this dentry */
 		dentry_iput(dentry);
 		parent = dentry->d_parent;
 		d_free(dentry);
@@ -341,7 +343,6 @@ static inline void prune_one_dentry(stru
 
 	__d_drop(dentry);
 	list_del(&dentry->d_child);
- 	spin_unlock(&dentry->d_lock);
 	dentry_stat.nr_dentry--;	/* For d_free, below */
 	dentry_iput(dentry);
 	parent = dentry->d_parent;
@@ -1116,7 +1117,6 @@ void d_delete(struct dentry * dentry)
 	spin_lock(&dcache_lock);
 	spin_lock(&dentry->d_lock);
 	if (atomic_read(&dentry->d_count) == 1) {
-		spin_unlock(&dentry->d_lock);
 		dentry_iput(dentry);
 		return;
 	}

_
-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
