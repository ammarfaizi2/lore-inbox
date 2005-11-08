Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVKHCJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVKHCJV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVKHCI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:08:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:26061 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965213AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 2/18] cleanups and bug fix in do_loopback()
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: 1131401704 -0500

- check_mnt() on the source of binding should've been unconditional from
the very beginning.  My fault - as far I could've trace it, that's an
old thinko made back in 2001.  Kudos to Miklos for spotting it...
Fixed.
- code cleaned up.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |   41 ++++++++++++++++++++++-------------------
 1 files changed, 22 insertions(+), 19 deletions(-)

aceb5c8912a85abd7a1a0f704bc742936cdad880
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -661,29 +661,32 @@ static int do_loopback(struct nameidata 
 
 	down_write(&current->namespace->sem);
 	err = -EINVAL;
-	if (check_mnt(nd->mnt) && (!recurse || check_mnt(old_nd.mnt))) {
-		err = -ENOMEM;
-		if (recurse)
-			mnt = copy_tree(old_nd.mnt, old_nd.dentry);
-		else
-			mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
-	}
+	if (!check_mnt(nd->mnt) || !check_mnt(old_nd.mnt))
+		goto out;
+
+	err = -ENOMEM;
+	if (recurse)
+		mnt = copy_tree(old_nd.mnt, old_nd.dentry);
+	else
+		mnt = clone_mnt(old_nd.mnt, old_nd.dentry);
+
+	if (!mnt)
+		goto out;
+
+	/* stop bind mounts from expiring */
+	spin_lock(&vfsmount_lock);
+	list_del_init(&mnt->mnt_expire);
+	spin_unlock(&vfsmount_lock);
 
-	if (mnt) {
-		/* stop bind mounts from expiring */
+	err = graft_tree(mnt, nd);
+	if (err) {
 		spin_lock(&vfsmount_lock);
-		list_del_init(&mnt->mnt_expire);
+		umount_tree(mnt);
 		spin_unlock(&vfsmount_lock);
+	} else
+		mntput(mnt);
 
-		err = graft_tree(mnt, nd);
-		if (err) {
-			spin_lock(&vfsmount_lock);
-			umount_tree(mnt);
-			spin_unlock(&vfsmount_lock);
-		} else
-			mntput(mnt);
-	}
-
+out:
 	up_write(&current->namespace->sem);
 	path_release(&old_nd);
 	return err;
