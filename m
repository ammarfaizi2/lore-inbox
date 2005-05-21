Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVEUKIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVEUKIk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 06:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEUKIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 06:08:39 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:63403 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261504AbVEUKIV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 06:08:21 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       jamie@shareable.org
In-Reply-To: <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <1116665101.4397.71.camel@localhost>
	 <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-Z2dCJykWFJiY4djqYQml"
Organization: IBM 
Message-Id: <1116670073.4397.77.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 May 2005 03:07:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z2dCJykWFJiY4djqYQml
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-05-21 at 02:09, Miklos Szeredi wrote:
> > > I still see a problem: what if old_nd.mnt is already detached, and
> > > bind is non-recursive.  Now it fails with EINVAL, though it used to
> > > work (and I think is very useful).
> > 
> > I am not getting this comment.  R u assuming that a detached mount
> > will have NULL namespace?
> 
> Yes.
> 
> > If so I dont see it being the case.
> 
> See this patch:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111627383207049&w=2

Ok. look at the enclosed patch. Does it look any better? The special
casing for detached mounts ate up some brain cells and made the code
less simpler.

RP

--=-Z2dCJykWFJiY4djqYQml
Content-Disposition: attachment; filename=rbind_across_namespace2.patch
Content-Type: text/x-patch; name=rbind_across_namespace2.patch
Content-Transfer-Encoding: 7bit

Summary:

Allows rbinds across any two namespaces.  NOTE: currenly bind from foriegn
namespace to current namespace is allowed. This patch now allows:

binds/rbinds from any namespace to any other namespace, under the assumption
that if a process has access to a namespace, it ought to have permission to
manipulate that namespace. The only case disallowed is a recursive bind to a
detached mount.

The patch incorporates ideas from Miklos and Jamie, and is dependent on
Miklos's "fix race in mark_mounts_for_expiry" patch to function correctly. Also
it depends on Miklos's "fix bind mount from foreign namespace" patch, because
without that patch umounts would fail.


Signed off by Ram Pai <linuxram@us.ibm.com>

--- /home/linux/views/linux-2.6.12-rc4/fs/namespace.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/namespace.c	2005-05-21 02:58:48.000000000 -0700
@@ -616,11 +616,14 @@ out_unlock:
 }
 
 /*
- * do loopback mount.
+ * do loopback mount.  The loopback mount can be done from any namespace
+ * to any other namespace including the current namespace, as long as
+ * the task acquired rights to manipulate them.
  */
 static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
 {
 	struct nameidata old_nd;
+	struct namespace *mntpt_ns, *old_ns;
 	struct vfsmount *mnt = NULL;
 	int err = mount_is_safe(nd);
 	if (err)
@@ -631,15 +634,41 @@ static int do_loopback(struct nameidata 
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
-		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
-		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+	spin_lock(&vfsmount_lock);
+
+	/* 
+	 * Allow all kinds of binds and rbinds except
+	 * recursive bind to a detached mount
+	 */
+	mntpt_ns = nd->mnt->mnt_namespace;
+	old_ns = old_nd.mnt->mnt_namespace;
+	if (!mntpt_ns || !mntpt_ns->root || 
+		(recurse && (!old_ns || !old_ns->root))) {
+		spin_unlock(&vfsmount_lock);
+		goto out;
 	}
+	get_namespace(mntpt_ns);
+	if (recurse && old_ns != mntpt_ns)
+		get_namespace(old_ns);
+
+	spin_unlock(&vfsmount_lock);
+
+	/* 
+	 * make sure we don't race with some other thread manipulating the
+	 * namespaces.
+	 */
+	if (recurse && (old_ns < mntpt_ns))
+		down_write(&old_ns->sem);
+	down_write(&mntpt_ns->sem);
+	if (recurse && (old_ns > mntpt_ns))
+		down_write(&old_ns->sem);
+
+	err = -ENOMEM;
+	if (recurse)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
 
 	if (mnt) {
 		/* stop bind mounts from expiring */
@@ -656,7 +685,14 @@ static int do_loopback(struct nameidata 
 			mntput(mnt);
 	}
 
-	up_write(&current->namespace->sem);
+	up_write(&mntpt_ns->sem);
+	if (recurse && (old_ns != mntpt_ns)) {
+		up_write(&old_ns->sem);
+		put_namespace(old_ns);
+	}
+	put_namespace(mntpt_ns);
+
+out:
 	path_release(&old_nd);
 	return err;
 }

--=-Z2dCJykWFJiY4djqYQml--

