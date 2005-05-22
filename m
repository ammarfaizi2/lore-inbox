Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVEVU0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVEVU0u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 16:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVEVU0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 16:26:50 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:30125 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261648AbVEVU0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 16:26:31 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       jamie@shareable.org
In-Reply-To: <E1DZTmi-0006up-00@dorka.pomaz.szeredi.hu>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
	 <1116660380.4397.66.camel@localhost>
	 <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
	 <1116665101.4397.71.camel@localhost>
	 <E1DZPzS-0006kw-00@dorka.pomaz.szeredi.hu>
	 <1116670073.4397.77.camel@localhost>
	 <E1DZTmi-0006up-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-pqKjchb1K3LP/hvRMPBt"
Organization: IBM 
Message-Id: <1116793554.4397.102.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 22 May 2005 13:25:54 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pqKjchb1K3LP/hvRMPBt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-05-21 at 06:12, Miklos Szeredi wrote:
> > Ok. look at the enclosed patch. Does it look any better? The special
> > casing for detached mounts ate up some brain cells and made the code
> > less simpler.
> 
> Yes, this isn't trivial stuff.
> 
> I realized one more thing: nd->mnt (the destination vfsmount) might be
> detached while waiting for the semaphore.  So that needs to be
> rechecked after taking the semaphores.

Ok. fixed that. that was surprisingly trivial though initially it looked
like some complex locking.

> 
> And the same for old_nd->mnt in case of rbind.  Though I'm
> not sure what the semantics should be in this case:
> 
>   1) rbind always fails if the source is detached
>   2) rbind always succeeds, and if the source is detached it just
>      copies that single mount

> I like 2) better.  Is there anything against it?

sure. as much functionality as we can get. I have incorporated (2).

Take a look at the enclosed patch,
RP
> 
> Miklos
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=-pqKjchb1K3LP/hvRMPBt
Content-Disposition: attachment; filename=rbind_across_namespace3.patch
Content-Type: text/x-patch; name=rbind_across_namespace3.patch
Content-Transfer-Encoding: 7bit

--- /home/linux/views/linux-2.6.12-rc4/fs/namespace.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/namespace.c	2005-05-22 13:22:46.000000000 -0700
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
@@ -631,15 +634,54 @@ static int do_loopback(struct nameidata 
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
 
 	if (mnt) {
 		/* stop bind mounts from expiring */
@@ -656,7 +698,15 @@ static int do_loopback(struct nameidata 
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

--=-pqKjchb1K3LP/hvRMPBt--

