Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932175AbWFWEPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWFWEPb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 00:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWFWEPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 00:15:31 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:51206 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751240AbWFWEPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 00:15:30 -0400
Date: Fri, 23 Jun 2006 12:14:09 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: autofs mailing list <autofs@linux.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
In-Reply-To: <20060620233941.49ba2223.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606231159540.2904@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060620233941.49ba2223.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here's another try at this.

On Tue, 20 Jun 2006, Andrew Morton wrote:

> On Wed, 21 Jun 2006 14:18:15 +0800
> Ian Kent <raven@themaw.net> wrote:
> 
> > 
> > Hi Andrew,
> > 
> > I didn't get any adverse (or other feedback) for this patch after posting
> > an RFC to LKML so here it is.
> > 
> > For a long time now I have had a problem with not being able to return a 
> > lookup failure on an existsing directory. In autofs this corresponds to a 
> > mount failure on a autofs managed mount entry that is browsable (and so 
> > the mount point directory exists).
> > 
> > While this problem has been present for a long time I've avoided resolving 
> > it because it was not very visible. But now that autofs v5 has "mount and 
> > expire on demand" of nested multiple mounts, such as is found when 
> > mounting an export list from a server, solving the problem cannot be 
> > avoided any longer.
> > 
> > I've tried very hard to find a way to do this entirely within the 
> > autofs4 module but have not been able to find a satisfactory way to 
> > achieve it.
> > 
> > So, I need to propose a change to the VFS.
> > 

snip ...

> 
> Also, did you consider broadening the ->d_revalidate() semantics?  It
> appears that all implementations return 0 or 1.  You could teach the VFS to
> also recognise and act upon a -ve return value, and do this trickery within
> the autofs d_revalidate(), perhaps?
> 

Yep and I've now done this.
I think this is in fact the only way to do it.

Signed-off-by: Ian Kent <raven@themaw.net>

--

--- linux-2.6.17-mm1/include/linux/dcache.h.dcache-revalidate-return-fail	2006-06-22 11:51:18.000000000 +0800
+++ linux-2.6.17-mm1/include/linux/dcache.h	2006-06-22 11:51:38.000000000 +0800
@@ -175,7 +175,6 @@ d_iput:		no		no		no       yes
 #define DCACHE_UNHASHED		0x0010	
 
 #define DCACHE_INOTIFY_PARENT_WATCHED	0x0020 /* Parent inode is watched */
-#define DCACHE_REVAL_FORCE_FAIL 0x0040	/* Force revalidate fail on valid dentry */
 
 extern spinlock_t dcache_lock;
 
--- linux-2.6.17-mm1/fs/autofs4/root.c.dcache-revalidate-return-fail	2006-06-22 11:54:24.000000000 +0800
+++ linux-2.6.17-mm1/fs/autofs4/root.c	2006-06-22 22:50:32.000000000 +0800
@@ -137,7 +137,9 @@ static int autofs4_dir_open(struct inode
 		nd.flags = LOOKUP_DIRECTORY;
 		ret = (dentry->d_op->d_revalidate)(dentry, &nd);
 
-		if (!ret) {
+		if (ret <= 0) {
+			if (ret < 0)
+				status = ret;
 			dcache_dir_close(inode, file);
 			goto out;
 		}
@@ -400,13 +402,23 @@ static int autofs4_revalidate(struct den
 	struct autofs_sb_info *sbi = autofs4_sbi(dir->i_sb);
 	int oz_mode = autofs4_oz_mode(sbi);
 	int flags = nd ? nd->flags : 0;
-	int status = 0;
+	int status = 1;
 
 	/* Pending dentry */
 	if (autofs4_ispending(dentry)) {
-		if (!oz_mode)
-			status = try_to_fill_dentry(dentry, flags);
-		return !status;
+		/* The daemon never causes a mount to trigger */
+		if (oz_mode)
+			return 1;
+
+		/*
+		 * A zero status is success otherwise we have a
+		 * negative error code.
+		 */
+		status = try_to_fill_dentry(dentry, flags);
+		if (status == 0)
+				return 1;
+
+		return status;
 	}
 
 	/* Negative dentry.. invalidate if "old" */
@@ -421,16 +433,19 @@ static int autofs4_revalidate(struct den
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
-		if (!oz_mode) {
-			status = try_to_fill_dentry(dentry, flags);
-			if (status) {
-				spin_lock(&dentry->d_lock);
-				dentry->d_flags |= DCACHE_REVAL_FORCE_FAIL;
-				spin_unlock(&dentry->d_lock);
-				return 0;
-			}
-		}
-		return !status;
+		/* The daemon never causes a mount to trigger */
+		if (oz_mode)
+			return 1;
+
+		/*
+		 * A zero status is success otherwise we have a
+		 * negative error code.
+		 */
+		status = try_to_fill_dentry(dentry, flags);
+		if (status == 0)
+			return 1;
+
+		return status;
 	}
 	spin_unlock(&dcache_lock);
 
--- linux-2.6.17-mm1/fs/namei.c.dcache-revalidate-return-fail	2006-06-22 11:50:13.000000000 +0800
+++ linux-2.6.17-mm1/fs/namei.c	2006-06-22 13:01:02.000000000 +0800
@@ -365,6 +365,29 @@ void release_open_intent(struct nameidat
 		fput(nd->intent.open.file);
 }
 
+static __always_inline struct dentry *do_revalidate(struct dentry *dentry, struct nameidata *nd)
+{
+	int status = dentry->d_op->d_revalidate(dentry, nd);
+	if (unlikely(status <= 0)) {
+		/*
+		 * The dentry failed validation.
+		 * If d_revalidate returned 0 attempt to invalidate
+		 * the dentry otherwise d_revalidate is asking us
+		 * to return a fail status.
+		 */
+		if (!status) {
+			if (!d_invalidate(dentry)) {
+				dput(dentry);
+				dentry = NULL;
+			}
+		} else {
+			dput(dentry);
+			dentry = ERR_PTR(status);
+		}
+	}
+	return dentry;
+}
+
 /*
  * Internal lookup() using the new generic dcache.
  * SMP-safe
@@ -379,27 +402,9 @@ static struct dentry * cached_lookup(str
 	if (!dentry)
 		dentry = d_lookup(parent, name);
 
-	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-		if (!dentry->d_op->d_revalidate(dentry, nd)) {
-			if (!d_invalidate(dentry)) {
-				dput(dentry);
-				return NULL;
-			}
-			/*
-			 * As well as the normal validation, check if we need
-			 * to force a fail on a valid dentry (autofs4 browsable
-			 * mounts).
-			 */
-			spin_lock(&dentry->d_lock);
-			if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
-				dentry->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
-				spin_unlock(&dentry->d_lock);
-				dput(dentry);
-				return ERR_PTR(-ENOENT);
-			}
-			spin_unlock(&dentry->d_lock);
-		}
-	}
+	if (dentry && dentry->d_op && dentry->d_op->d_revalidate)
+		dentry = do_revalidate(dentry, nd);
+
 	return dentry;
 }
 
@@ -492,25 +497,9 @@ static struct dentry * real_lookup(struc
 	 */
 	mutex_unlock(&dir->i_mutex);
 	if (result->d_op && result->d_op->d_revalidate) {
-		if (!result->d_op->d_revalidate(result, nd)) {
-			if (!d_invalidate(result)) {
-				dput(result);
-				return ERR_PTR(-ENOENT);
-			}
-			/*
-		 	* d_revalidate failed but the dentry is still valid so
-			* check if we need to force a fail on the dentry (autofs4
-			* browsable mounts).
-		 	*/
-			spin_lock(&result->d_lock);
-		    	if (result->d_flags & DCACHE_REVAL_FORCE_FAIL) {
-				result->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
-				spin_unlock(&result->d_lock);
-				dput(result);
-				return ERR_PTR(-ENOENT);
-			}
-			spin_unlock(&result->d_lock);
-		}
+		result = do_revalidate(result, nd);
+		if (!result)
+			result = ERR_PTR(-ENOENT);
 	}
 	return result;
 }
@@ -790,25 +779,12 @@ need_lookup:
 	goto done;
 
 need_revalidate:
-	if (dentry->d_op->d_revalidate(dentry, nd))
-		goto done;
-	if (d_invalidate(dentry)) {
-		/*
-		 * d_revalidate failed but the dentry is still valid so check
-		 * if we need to return a fail (autofs4 browsable mounts).
-		 */
-		spin_lock(&dentry->d_lock);
-		if (dentry->d_flags & DCACHE_REVAL_FORCE_FAIL) {
-			dentry->d_flags &= ~DCACHE_REVAL_FORCE_FAIL;
-			spin_unlock(&dentry->d_lock);
-			dput(dentry);
-			return -ENOENT;
-		}
-		spin_unlock(&dentry->d_lock);
-		goto done;
-	}
-	dput(dentry);
-	goto need_lookup;
+	dentry = do_revalidate(dentry, nd);
+	if (!dentry)
+		goto need_lookup;
+	if (IS_ERR(dentry))
+		goto fail;
+	goto done;
 
 fail:
 	return PTR_ERR(dentry);
