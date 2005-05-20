Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVETWNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVETWNB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 18:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVETWNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 18:13:00 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:33173 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261434AbVETWMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 18:12:08 -0400
Subject: [RFC][PATCH] rbind across namespaces
From: Ram <linuxram@us.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org
Content-Type: multipart/mixed; boundary="=-rN9ols8Am5NrW+teKjJu"
Organization: IBM 
Message-Id: <1116627099.4397.43.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 20 May 2005 15:11:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rN9ols8Am5NrW+teKjJu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have enclosed a patch that allows rbinds across any two namespaces.
NOTE: currenly bind from foriegn namespace to current namespace is
allowed. This patch now allows:

binds/rbinds from any namespace to any other namespace, under the
assumption that if a process has access to a namespace, it ought to
have permission to manipulate that namespace.

The patch incorporates ideas from Miklos and Jamie, and is dependent
on Miklos's 'fix race in mark_mounts_for_expiry' patch to function
correctly. Also it depends on Miklos's 'fix bind mount from foreign
namespace' patch, because without that patch umounts would fail.

Though we have not come up with any security reason towards why
this functionality should not be allowed, I am sure it may open
up some concerns.


RP


--=-rN9ols8Am5NrW+teKjJu
Content-Disposition: attachment; filename=rbind_across_namespace.patch
Content-Type: text/x-patch; name=rbind_across_namespace.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit

Signed-off-by: Ram Pai <linuxram@us.ibm.com>

--- /home/linux/views/linux-2.6.12-rc4/fs/namespace.c	2005-05-06 23:22:29.000000000 -0700
+++ 2.6.12-rc4/fs/namespace.c	2005-05-20 14:44:57.000000000 -0700
@@ -616,11 +616,15 @@ out_unlock:
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
+	struct namespace *mntpt_ns = nd->mnt->mnt_namespace, *old_ns;
+	int mntpt_ns_flag=0, old_ns_flag=0;
 	struct vfsmount *mnt = NULL;
 	int err = mount_is_safe(nd);
 	if (err)
@@ -631,16 +635,54 @@ static int do_loopback(struct nameidata 
 	if (err)
 		return err;
 
-	down_write(&current->namespace->sem);
+	old_ns = old_nd.mnt->mnt_namespace;
+
+	/* 
+	 * make sure the namespaces do not disapper while
+	 * we operate on it
+	 */
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
-		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
-		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+	if (mntpt_ns != current->namespace) {
+		spin_lock(&vfsmount_lock);
+		if (!mntpt_ns->root) {
+			spin_unlock(&vfsmount_lock);
+			goto out;
+		}
+		get_namespace(mntpt_ns);
+		spin_unlock(&vfsmount_lock);
+		mntpt_ns_flag=1;
 	}
 
+	if (old_ns != current->namespace) {
+		spin_lock(&vfsmount_lock);
+		if (!old_ns->root) {
+			spin_unlock(&vfsmount_lock);
+			goto release_mntpt_ns;
+		}
+		get_namespace(old_ns);
+		spin_unlock(&vfsmount_lock);
+		old_ns_flag=1;
+	}
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
+	}
+
+	err = -ENOMEM;
+	if (recurse)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+
 	if (mnt) {
 		/* stop bind mounts from expiring */
 		spin_lock(&vfsmount_lock);
@@ -656,7 +698,23 @@ static int do_loopback(struct nameidata 
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
+	if (old_ns_flag) {
+		put_namespace(old_ns);
+	}
+
+release_mntpt_ns:
+	if (mntpt_ns_flag) {
+		put_namespace(mntpt_ns);
+	}
+out:
 	path_release(&old_nd);
 	return err;
 }

--=-rN9ols8Am5NrW+teKjJu--

