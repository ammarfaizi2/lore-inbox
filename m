Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWFUGTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWFUGTQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbWFUGTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:19:16 -0400
Received: from i154-235.nv.iinet.net.au ([203.59.154.235]:63134 "EHLO
	raven.themaw.net") by vger.kernel.org with ESMTP id S1750765AbWFUGTP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:19:15 -0400
Date: Wed, 21 Jun 2006 14:18:15 +0800
Message-Id: <200606210618.k5L6IFDr008176@raven.themaw.net>
From: Ian Kent <raven@themaw.net>
To: akpm@osdl.org
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] autofs4 needs to force fail return revalidate
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

I didn't get any adverse (or other feedback) for this patch after posting
an RFC to LKML so here it is.

For a long time now I have had a problem with not being able to return a 
lookup failure on an existsing directory. In autofs this corresponds to a 
mount failure on a autofs managed mount entry that is browsable (and so 
the mount point directory exists).

While this problem has been present for a long time I've avoided resolving 
it because it was not very visible. But now that autofs v5 has "mount and 
expire on demand" of nested multiple mounts, such as is found when 
mounting an export list from a server, solving the problem cannot be 
avoided any longer.

I've tried very hard to find a way to do this entirely within the 
autofs4 module but have not been able to find a satisfactory way to 
achieve it.

So, I need to propose a change to the VFS.

Signed-off-by: Ian Kent <raven@themaw.net>

Ian

--

--- linux-2.6.17/include/linux/dcache.h.dcache-revalidate-return-fail	2006-06-19 13:26:27.000000000 +0800
+++ linux-2.6.17/include/linux/dcache.h	2006-06-19 13:29:25.000000000 +0800
@@ -163,6 +163,7 @@ d_iput:		no		no		no       yes
 #define DCACHE_UNHASHED		0x0010	
 
 #define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
+#define DCACHE_REVAL_FORCE_FAIL 0x0040	/* Force revalidate fail on valid dentry */
 
 extern spinlock_t dcache_lock;
 
--- linux-2.6.17/fs/autofs4/root.c.dcache-revalidate-return-fail	2006-06-19 13:26:27.000000000 +0800
+++ linux-2.6.17/fs/autofs4/root.c	2006-06-19 13:26:51.000000000 +0800
@@ -421,8 +421,15 @@ static int autofs4_revalidate(struct den
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
-		if (!oz_mode)
+		if (!oz_mode) {
 			status = try_to_fill_dentry(dentry, flags);
+			if (status) {
+				spin_lock(&dentry->d_lock);
+				dentry->d_flags |= DCACHE_REVAL_FORCE_FAIL;
+				spin_unlock(&dentry->d_lock);
+				return 0;
+			}
+		}
 		return !status;
 	}
 	spin_unlock(&dcache_lock);
--- linux-2.6.17/fs/namei.c.dcache-revalidate-return-fail	2006-06-19 13:26:27.000000000 +0800
+++ linux-2.6.17/fs/namei.c	2006-06-19 13:31:31.000000000 +0800
@@ -380,9 +380,24 @@ static struct dentry * cached_lookup(str
 		dentry = d_lookup(parent, name);
 
 	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
-			dput(dentry);
-			dentry = NULL;
+		if (!dentry->d_op->d_revalidate(dentry, nd)) {
+			if (!d_invalidate(dentry)) {
+				dput(dentry);
+				return NULL;
+			}
+			/*
+			 * As well as the normal validation, check if we need
+			 * to force a fail on a valid dentry (autofs4 browsable
+			 * mounts).
+			 */
+			spin_lock(&dentry->d_lock);
+			if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
+				dentry->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
+				spin_unlock(&dentry->d_lock);
+				dput(dentry);
+				return ERR_PTR(-ENOENT);
+			}
+			spin_unlock(&dentry->d_lock);
 		}
 	}
 	return dentry;
@@ -477,9 +492,24 @@ static struct dentry * real_lookup(struc
 	 */
 	mutex_unlock(&dir->i_mutex);
 	if (result->d_op && result->d_op->d_revalidate) {
-		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
-			dput(result);
-			result = ERR_PTR(-ENOENT);
+		if (!result->d_op->d_revalidate(result, nd)) {
+			if (!d_invalidate(result)) {
+				dput(result);
+				return ERR_PTR(-ENOENT);
+			}
+			/*
+		 	* d_revalidate failed but the dentry is still valid so
+			* check if we need to force a fail on the dentry (autofs4
+			* browsable mounts).
+		 	*/
+			spin_lock(&result->d_lock);
+		    	if (result->d_flags & DCACHE_REVAL_FORCE_FAIL) {
+				result->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
+				spin_unlock(&result->d_lock);
+				dput(result);
+				return ERR_PTR(-ENOENT);
+			}
+			spin_unlock(&result->d_lock);
 		}
 	}
 	return result;
@@ -762,8 +792,21 @@ need_lookup:
 need_revalidate:
 	if (dentry->d_op->d_revalidate(dentry, nd))
 		goto done;
-	if (d_invalidate(dentry))
+	if (d_invalidate(dentry)) {
+		/*
+		 * d_revalidate failed but the dentry is still valid so check
+		 * if we need to return a fail (autofs4 browsable mounts).
+		 */
+		spin_lock(&dentry->d_lock);
+		if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
+			dentry->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
+			spin_unlock(&dentry->d_lock);
+			dput(dentry);
+			return -ENOENT;
+		}
+		spin_unlock(&dentry->d_lock);
 		goto done;
+	}
 	dput(dentry);
 	goto need_lookup;
 

