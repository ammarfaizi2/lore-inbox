Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWBJM3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWBJM3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWBJM27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:28:59 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:61909 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751217AbWBJM27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:28:59 -0500
Date: Fri, 10 Feb 2006 13:28:58 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH] trivial cleanup to proc_check_chroot()
Message-ID: <20060210122858.GA21028@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Andrew! Folks!

the proc_check_chroot() function does the check
in a very unintuitive way (keeping a copy of the
argument, then modifying the argument), and has
uncommented sideeffects ...

please consider this 'trivial' cleanup so that
nobody gets confused there (as I was) ...

Signed-off-by: Herbert Poetzl <herbert@13thfloor.at>

---

--- linux-2.6.16-rc2/fs/proc/base.c	2006-02-07 11:53:02 +0100
+++ linux-2.6.16-rc2-mnt/fs/proc/base.c	2006-02-10 12:37:35 +0100
@@ -531,6 +531,8 @@ static int proc_oom_score
 
 /* If the process being read is separated by chroot from the reading process,
  * don't let the reader access the threads.
+ *
+ * note: this does dput(root) and mntput(vfsmnt) on exit.
  */
 static int proc_check_chroot(struct dentry *root, struct vfsmount *vfsmnt)
 {
@@ -537,6 +539,7 @@ static int proc_check_chroot
 	struct dentry *de, *base;
 	struct vfsmount *our_vfsmnt, *mnt;
 	int res = 0;
+
 	read_lock(&current->fs->lock);
 	our_vfsmnt = mntget(current->fs->rootmnt);
 	base = dget(current->fs->root);
@@ -546,11 +549,11 @@ static int proc_check_chroot
 	de = root;
 	mnt = vfsmnt;
 
-	while (vfsmnt != our_vfsmnt) {
-		if (vfsmnt == vfsmnt->mnt_parent)
+	while (mnt != our_vfsmnt) {
+		if (mnt == mnt->mnt_parent)
 			goto out;
-		de = vfsmnt->mnt_mountpoint;
-		vfsmnt = vfsmnt->mnt_parent;
+		de = mnt->mnt_mountpoint;
+		mnt = mnt->mnt_parent;
 	}
 
 	if (!is_subdir(de, base))
@@ -561,7 +564,7 @@ exit:
 	dput(base);
 	mntput(our_vfsmnt);
 	dput(root);
-	mntput(mnt);
+	mntput(vfsmnt);
 	return res;
 out:
 	spin_unlock(&vfsmount_lock);
