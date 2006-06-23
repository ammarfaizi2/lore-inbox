Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWFWEbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWFWEbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 00:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWFWEbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 00:31:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932211AbWFWEbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 00:31:22 -0400
Date: Thu, 22 Jun 2006 21:30:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
Message-Id: <20060622213050.fc753e91.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606231159540.2904@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
	<20060620233941.49ba2223.akpm@osdl.org>
	<Pine.LNX.4.64.0606231159540.2904@raven.themaw.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 12:14:09 +0800 (WST)
Ian Kent <raven@themaw.net> wrote:

> > 
> > Also, did you consider broadening the ->d_revalidate() semantics?  It
> > appears that all implementations return 0 or 1.  You could teach the VFS to
> > also recognise and act upon a -ve return value, and do this trickery within
> > the autofs d_revalidate(), perhaps?
> > 
> 
> Yep and I've now done this.
> I think this is in fact the only way to do it.

Below is the combined patch for reviewing purposes.

Removing that __always_inline saves 30-odd bytes.  I suspect that removing
it would be a performance loss in this case.  But I'll make it just
`inline' because __always_inline is peculiar, and people will wonder what's
special about this function.



 fs/autofs4/root.c |   38 ++++++++++++++++++++++++++--------
 fs/namei.c        |   49 ++++++++++++++++++++++++++++++--------------
 linux/dcache.h    |    0 
 3 files changed, 64 insertions(+), 23 deletions(-)

diff -puN fs/autofs4/root.c~autofs4-needs-to-force-fail-return-revalidate fs/autofs4/root.c
--- a/fs/autofs4/root.c~autofs4-needs-to-force-fail-return-revalidate
+++ a/fs/autofs4/root.c
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
@@ -421,9 +433,19 @@ static int autofs4_revalidate(struct den
 		DPRINTK("dentry=%p %.*s, emptydir",
 			 dentry, dentry->d_name.len, dentry->d_name.name);
 		spin_unlock(&dcache_lock);
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
+			return 1;
+
+		return status;
 	}
 	spin_unlock(&dcache_lock);
 
diff -puN fs/namei.c~autofs4-needs-to-force-fail-return-revalidate fs/namei.c
--- a/fs/namei.c~autofs4-needs-to-force-fail-return-revalidate
+++ a/fs/namei.c
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
@@ -379,12 +402,9 @@ static struct dentry * cached_lookup(str
 	if (!dentry)
 		dentry = d_lookup(parent, name);
 
-	if (dentry && dentry->d_op && dentry->d_op->d_revalidate) {
-		if (!dentry->d_op->d_revalidate(dentry, nd) && !d_invalidate(dentry)) {
-			dput(dentry);
-			dentry = NULL;
-		}
-	}
+	if (dentry && dentry->d_op && dentry->d_op->d_revalidate)
+		dentry = do_revalidate(dentry, nd);
+
 	return dentry;
 }
 
@@ -477,10 +497,9 @@ static struct dentry * real_lookup(struc
 	 */
 	mutex_unlock(&dir->i_mutex);
 	if (result->d_op && result->d_op->d_revalidate) {
-		if (!result->d_op->d_revalidate(result, nd) && !d_invalidate(result)) {
-			dput(result);
+		result = do_revalidate(result, nd);
+		if (!result)
 			result = ERR_PTR(-ENOENT);
-		}
 	}
 	return result;
 }
@@ -760,12 +779,12 @@ need_lookup:
 	goto done;
 
 need_revalidate:
-	if (dentry->d_op->d_revalidate(dentry, nd))
-		goto done;
-	if (d_invalidate(dentry))
-		goto done;
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
diff -puN include/linux/dcache.h~autofs4-needs-to-force-fail-return-revalidate include/linux/dcache.h
_

