Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750985AbWFSFw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbWFSFw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 01:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWFSFw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 01:52:56 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:261 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1750929AbWFSFwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 01:52:55 -0400
Date: Mon, 19 Jun 2006 13:51:14 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: autofs mailing list <autofs@linux.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [RFC:VFS] autofs4 needs to force fail return revalidate
Message-ID: <Pine.LNX.4.64.0606191332510.5732@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0,
	required 5, autolearn=not spam)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

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

Please offer comments and suggestions or if anyone has an idea how this 
could be done within the autofs4 filesystem then I'm all ears.

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
 

