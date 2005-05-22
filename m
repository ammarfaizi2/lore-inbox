Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261688AbVEVUvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbVEVUvz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 16:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVEVUvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 16:51:55 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:41141 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261688AbVEVUvb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 16:51:31 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       jamie@shareable.org
In-Reply-To: <1116793554.4397.102.camel@localhost>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <1116665101.4397.71.camel@localhost>
	 <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
	 <1116670073.4397.77.camel@localhost>
	 <E1DZTmi-0006up-00@dorka.pomaz.szeredi.hu>
	 <1116793554.4397.102.camel@localhost>
Content-Type: multipart/mixed; boundary="=-4ofLeChH8fGgZrGRxMoa"
Organization: IBM 
Message-Id: <1116795059.4397.111.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 May 2005 13:51:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4ofLeChH8fGgZrGRxMoa
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, 2005-05-22 at 13:25, Ram wrote:
> On Sat, 2005-05-21 at 06:12, Miklos Szeredi wrote:
> > > Ok. look at the enclosed patch. Does it look any better? The special
> > > casing for detached mounts ate up some brain cells and made the code
> > > less simpler.
> > 
> > Yes, this isn't trivial stuff.
> > 
> > I realized one more thing: nd->mnt (the destination vfsmount) might be
> > detached while waiting for the semaphore.  So that needs to be
> > rechecked after taking the semaphores.
> 
> Ok. fixed that. that was surprisingly trivial though initially it looked
> like some complex locking.
> 
> > 
> > And the same for old_nd->mnt in case of rbind.  Though I'm
> > not sure what the semantics should be in this case:
> > 
> >   1) rbind always fails if the source is detached
> >   2) rbind always succeeds, and if the source is detached it just
> >      copies that single mount
> 
> > I like 2) better.  Is there anything against it?
> 
> sure. as much functionality as we can get. I have incorporated (2).
> 
> Take a look at the enclosed patch,
 
The patch failed rbinds in some cases. Fixed it. The enclosed patch
has a high chance of being bug free.

RP


> RP
> > 
> > Miklos
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-4ofLeChH8fGgZrGRxMoa
Content-Disposition: attachment; filename=rbind_across_namespace4.patch
Content-Type: text/x-patch; name=rbind_across_namespace4.patch
Content-Transfer-Encoding: 7bit

Summary:

Allows rbinds across any two namespaces.  NOTE: currenly bind from foriegn
namespace to current namespace is allowed. This patch now allows:

binds/rbinds from any namespace to any other namespace, under the assumption
that if a process has access to a namespace, it ought to have permission to
manipulate that namespace. The only case disallowed is binds/rbinds
to a detached vfsmount.

The patch incorporates ideas from Miklos and Jamie, and is dependent on
Miklos's "fix race in mark_mounts_for_expiry" patch to function correctly. Also
it depends on Miklos's "fix bind mount from foreign namespace" patch, because
without that patch umounts would fail.


Signed off by Ram Pai <linuxram@us.ibm.com>

--- /home/linux/views/linux-2.6.12-rc4/fs/namespace.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/namespace.c	2005-05-22 13:40:12.000000000 -0700
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
@@ -631,16 +634,58 @@ static int do_loopback(struct nameidata 
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
+	if (!mntpt_ns || !mntpt_ns->root) {
+		spin_unlock(&vfsmount_lock);
+		goto out;
 	}
 
+	if (!old_ns || !old_ns->root)
+		recurse = 0;
+
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
+
+	/* 
+	 * well... mounts might have detached while we acquired
+	 * the semaphores. Revalidate that the destination mount 
+	 * is still attached. 
+	 */
+	if (!nd->mnt->mnt_namespace)
+		goto error_out;
+
+	/* 
+	 * and if the source mount is detached, than just do
+	 * a bind, instead of a rbind
+	 */
+	err = -ENOMEM;
+	if (recurse && old_nd.mnt->mnt_namespace)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+
 	if (mnt) {
 		/* stop bind mounts from expiring */
 		spin_lock(&vfsmount_lock);
@@ -656,7 +701,15 @@ static int do_loopback(struct nameidata 
 			mntput(mnt);
 	}
 
-	up_write(&current->namespace->sem);
+error_out:
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

--=-4ofLeChH8fGgZrGRxMoa--

