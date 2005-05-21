Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVEUH1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVEUH1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 03:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEUH1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 03:27:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50864 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261684AbVEUH0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 03:26:52 -0400
Subject: Re: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       jamie@shareable.org
In-Reply-To: <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
References: <1116627099.4397.43.camel@localhost>
	 <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu>
Content-Type: multipart/mixed; boundary="=-S09cCfwaXfZJikH7iXvy"
Organization: IBM 
Message-Id: <1116660380.4397.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 May 2005 00:26:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-S09cCfwaXfZJikH7iXvy
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-05-20 at 23:27, Miklos Szeredi wrote:
> > I have enclosed a patch that allows rbinds across any two namespaces.
> > NOTE: currenly bind from foriegn namespace to current namespace is
> > allowed. This patch now allows:
> 
> Note: you are accessing ->mnt_namespace without holding vfsmount_lock.

I realized that just after sending the patch :( . Have corrected it in
the new patch.

> 
> Also why check current->namespace?  It doesn't hurt to do
> get_namespace() even if it's not strictly needed.  And it would
> simplify the code.

however get_namespace() will chew up some extra cycles
sometimes unnecessarily. I did incorporate your comment and
got much simpler code.

 

> 
> In fact all uses of current->namespace and check_mnt() could be
> eliminated from namespace.c.  The only use of ->namespace would be in
> copy_namespace() and exit_namespace().

Yes. I will make this a separate patch, which I will send out soon.
Will have to look at each of the cases deeply.

Enclosed the simplified patch,
RP

--=-S09cCfwaXfZJikH7iXvy
Content-Disposition: attachment; filename=rbind_across_namespace1.patch
Content-Type: text/x-patch; name=rbind_across_namespace1.patch
Content-Transfer-Encoding: 7bit


Summary:

Allows rbinds across any two namespaces.  NOTE: currenly bind from foriegn
namespace to current namespace is allowed. This patch now allows:

binds/rbinds from any namespace to any other namespace, under the assumption
that if a process has access to a namespace, it ought to have permission to
manipulate that namespace.

The patch incorporates ideas from Miklos and Jamie, and is dependent on
Miklos's "fix race in mark_mounts_for_expiry" patch to function correctly. Also
it depends on Miklos's "fix bind mount from foreign namespace" patch, because
without that patch umounts would fail.


Signed off by Ram Pai <linuxram@us.ibm.com>

--- /home/linux/views/linux-2.6.12-rc4/fs/namespace.c	2005-05-06 23:22:29.000000000 -0700
+++ linux-2.6.12-rc4/fs/namespace.c	2005-05-21 00:17:31.000000000 -0700
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
@@ -631,16 +634,39 @@ static int do_loopback(struct nameidata 
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
+	mntpt_ns = nd->mnt->mnt_namespace;
+	old_ns = old_nd.mnt->mnt_namespace;
+	if (!mntpt_ns || !mntpt_ns->root || !old_ns || !old_ns->root) {
+		spin_unlock(&vfsmount_lock);
+		goto out;
+	}
+	get_namespace(mntpt_ns);
+	get_namespace(old_ns);
+
+	spin_unlock(&vfsmount_lock);
+
+	/* 
+	 * make sure we don't race with some
+	 * other thread manipulating the
+	 * namespaces.
+	 */
+	if (old_ns < mntpt_ns) {
+		down_write(&old_ns->sem);
+	}
+	down_write(&mntpt_ns->sem);
+	if (old_ns > mntpt_ns) {
+		down_write(&old_ns->sem);
 	}
 
+	err = -ENOMEM;
+	if (recurse)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+
 	if (mnt) {
 		/* stop bind mounts from expiring */
 		spin_lock(&vfsmount_lock);
@@ -656,7 +682,17 @@ static int do_loopback(struct nameidata 
 			mntput(mnt);
 	}
 
-	up_write(&current->namespace->sem);
+	if (old_ns < mntpt_ns) {
+		up_write(&old_ns->sem);
+	}
+	up_write(&mntpt_ns->sem);
+	if (old_ns > mntpt_ns) {
+		up_write(&old_ns->sem);
+	}
+
+	put_namespace(old_ns);
+	put_namespace(mntpt_ns);
+out:
 	path_release(&old_nd);
 	return err;
 }

--=-S09cCfwaXfZJikH7iXvy--

