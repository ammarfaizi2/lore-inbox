Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265590AbUAZXLC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbUAZXLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:11:02 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:57539 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S265590AbUAZXJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:09:48 -0500
Date: Mon, 26 Jan 2004 18:07:51 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: [PATCH 2/2] vfsmount_lock / mnt_parent
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk
Message-id: <40159DC7.9080504@sun.com>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------010300030406010206030602
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122
 Debian/1.6-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010300030406010206030602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch ensures that we grab vfsmount_lock when grabbing a 
reference to mnt_parent in follow_up and follow_dotdot.

We also don't need to access ->mnt_parent in follow_mount and 
__follow_down to mntput because we already the parent pointer on the stack.


-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

--------------010300030406010206030602
Content-Type: text/x-patch;
 name="follow_friends_vfsmount_lock.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="follow_friends_vfsmount_lock.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1521  -> 1.1522 
#	          fs/namei.c	1.87    -> 1.88   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/26	michael.waychison@sun.com	1.1522
# namei.c:
#   - protect references to vfsmount->mnt_parent with vfsmount_lock
# --------------------------------------------
#
diff -Nru a/fs/namei.c b/fs/namei.c
--- a/fs/namei.c	Mon Jan 26 21:39:45 2004
+++ b/fs/namei.c	Mon Jan 26 21:39:45 2004
@@ -420,15 +420,15 @@
 {
 	struct vfsmount *parent;
 	struct dentry *mountpoint;
-	spin_lock(&dcache_lock);
+	spin_lock(&vfsmount_lock);
 	parent=(*mnt)->mnt_parent;
 	if (parent == *mnt) {
-		spin_unlock(&dcache_lock);
+		spin_unlock(&vfsmount_lock);
 		return 0;
 	}
 	mntget(parent);
 	mountpoint=dget((*mnt)->mnt_mountpoint);
-	spin_unlock(&dcache_lock);
+	spin_unlock(&vfsmount_lock);
 	dput(*dentry);
 	*dentry = mountpoint;
 	mntput(*mnt);
@@ -446,9 +446,9 @@
 		struct vfsmount *mounted = lookup_mnt(*mnt, *dentry);
 		if (!mounted)
 			break;
+		mntput(*mnt);
 		*mnt = mounted;
 		dput(*dentry);
-		mntput(mounted->mnt_parent);
 		*dentry = dget(mounted->mnt_root);
 		res = 1;
 	}
@@ -464,9 +464,9 @@
 
 	mounted = lookup_mnt(*mnt, *dentry);
 	if (mounted) {
+		mntput(*mnt);
 		*mnt = mounted;
 		dput(*dentry);
-		mntput(mounted->mnt_parent);
 		*dentry = dget(mounted->mnt_root);
 		return 1;
 	}
@@ -498,14 +498,16 @@
 			dput(old);
 			break;
 		}
+		spin_unlock(&dcache_lock);
+		spin_lock(&vfsmount_lock);
 		parent = (*mnt)->mnt_parent;
 		if (parent == *mnt) {
-			spin_unlock(&dcache_lock);
+			spin_unlock(&vfsmount_lock);
 			break;
 		}
 		mntget(parent);
 		*dentry = dget((*mnt)->mnt_mountpoint);
-		spin_unlock(&dcache_lock);
+		spin_unlock(&vfsmount_lock);
 		dput(old);
 		mntput(*mnt);
 		*mnt = parent;

--------------010300030406010206030602--
