Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbUJZATc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbUJZATc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbUJYPDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:03:55 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:60328 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261865AbUJYOrY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:47:24 -0400
Cc: raven@themaw.net
Subject: [PATCH 17/28] VFS: Mountpoint file descriptor walking
In-Reply-To: <10987155992813@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:47:09 -0400
Message-Id: <10987156292985@sun.com>
References: <10987155992813@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows one to walk the mountpoint tree given a mountfd.  There are
two operations permitted:

MOUNTFD_IOC_GETFIRSTCHILD - Given a mountfd, return the first child mountpoint
                            as a mountfd.
MOUNTFD_IOC_GETNEXTCHILD  - Given a mountfd, return the next mountpoint sibling
                            to it. (*)

(*) XXX: This should be modified to also take a parent mountfd so that you
can't walk out of a chroot.

We explicitly don't allow walks to the parent of a mountpoint as that would
allow for a user to easily walk out of a chroot.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/mountfd.c       |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h |    3 +++
 2 files changed, 49 insertions(+)

Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-10-22 17:17:42.012077336 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:42.625984008 -0400
@@ -219,6 +219,9 @@ extern int leases_enable, dir_notify_ena
 #define MOUNTFD_IOC_DETACH        _IO('p', 0xa2)
 #define MOUNTFD_IOC_FORCEDUNMOUNT _IO('p', 0xa3)
 #define MOUNTFD_IOC_ATTACH        _IOW('p', 0xa4, int)
+#define MOUNTFD_IOC_GETFIRSTCHILD _IO('p', 0xa5)
+/* TODO: change this interface to require the parent mfd as well */
+#define MOUNTFD_IOC_GETNEXTCHILD  _IO('p', 0xa6)
 
 #ifdef __KERNEL__
 
Index: linux-2.6.9-quilt/fs/mountfd.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/mountfd.c	2004-10-22 17:17:42.011077488 -0400
+++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:42.625984008 -0400
@@ -284,6 +284,48 @@ out:
 	return ret;
 }
 
+static long mfd_firstchild(struct file *mountfilp)
+{
+	struct vfsmount *mnt, *childmnt = NULL;
+	int ret;
+	
+	mnt = mntget(VFSMOUNT(mountfilp));
+
+	spin_lock(&vfsmount_lock);
+	if (!list_empty(&mnt->mnt_mounts))
+		childmnt = mntget(container_of(mnt->mnt_mounts.next, struct vfsmount, mnt_child));
+	spin_unlock(&vfsmount_lock);
+
+	ret = -ENOENT;
+	if (childmnt)
+		ret = open_mfd(childmnt);
+
+	mntput(childmnt);
+	mntput(mnt);
+	return ret;
+}
+
+static long mfd_nextchild(struct file *mountfilp)
+{
+	struct vfsmount *mnt, *nextmnt = NULL;
+	int ret;
+
+	mnt = mntget(VFSMOUNT(mountfilp));
+
+	spin_lock(&vfsmount_lock);
+	if (mnt->mnt_child.next != &mnt->mnt_parent->mnt_mounts)
+		nextmnt = mntget(container_of(mnt->mnt_child.next, struct vfsmount, mnt_child));
+	spin_unlock(&vfsmount_lock);
+
+	ret = -ENOENT;
+	if (nextmnt)
+		ret = open_mfd(nextmnt);
+
+	mntput(nextmnt);
+	mntput(mnt);
+	return ret;
+}
+
 static int mfd_ioctl(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
 {
@@ -298,6 +340,10 @@ static int mfd_ioctl(struct inode *inode
 		return mfd_umount(filp, MNT_FORCE);
 	case MOUNTFD_IOC_ATTACH:
 		return mfd_attach(filp, arg);
+	case MOUNTFD_IOC_GETFIRSTCHILD:
+		return mfd_firstchild(filp);
+	case MOUNTFD_IOC_GETNEXTCHILD:
+		return mfd_nextchild(filp);
 	}
 	return -ENOTTY;
 }

