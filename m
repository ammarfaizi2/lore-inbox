Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbVKHCBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbVKHCBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVKHCBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:01:37 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:23245 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965173AbVKHCBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:01:36 -0500
To: torvalds@osdl.org
Subject: [PATCH 6/18] sanitize the interface of graft_tree().
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linuxram@us.ibm.com
Message-Id: <E1EZInj-0001En-AM@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 08 Nov 2005 02:01:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ram Pai <linuxram@us.ibm.com>
Date: 1131401789 -0500

Old semanitcs: graft_tree() grabs a reference on the vfsmount before
returning success.
New one: graft_tree() leaves that to caller.

All the callers of graft_tree() immediately dropped that reference anyway.
Changing the interface takes care of this unnecessary overhead.

Idea proposed by Al-Viro.

Signed-off-by: Ram Pai (linuxram@us.ibm.com)
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 fs/namespace.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

e43480493368cfdc525357e242bcd01a3bfdc5db
diff --git a/fs/namespace.c b/fs/namespace.c
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -650,7 +650,6 @@ static int graft_tree(struct vfsmount *m
 		attach_mnt(mnt, nd);
 		list_add_tail(&head, &mnt->mnt_list);
 		list_splice(&head, current->namespace->list.prev);
-		mntget(mnt);
 		err = 0;
 		touch_namespace(current->namespace);
 	}
@@ -702,8 +701,7 @@ static int do_loopback(struct nameidata 
 		spin_lock(&vfsmount_lock);
 		umount_tree(mnt);
 		spin_unlock(&vfsmount_lock);
-	} else
-		mntput(mnt);
+	}
 
 out:
 	up_write(&current->namespace->sem);
@@ -857,15 +855,17 @@ int do_add_mount(struct vfsmount *newmnt
 		goto unlock;
 
 	newmnt->mnt_flags = mnt_flags;
-	newmnt->mnt_namespace = current->namespace;
-	err = graft_tree(newmnt, nd);
+	if ((err = graft_tree(newmnt, nd)))
+		goto unlock;
 
-	if (err == 0 && fslist) {
+	if (fslist) {
 		/* add to the specified expiration list */
 		spin_lock(&vfsmount_lock);
 		list_add_tail(&newmnt->mnt_expire, fslist);
 		spin_unlock(&vfsmount_lock);
 	}
+	up_write(&current->namespace->sem);
+	return 0;
 
 unlock:
 	up_write(&current->namespace->sem);
