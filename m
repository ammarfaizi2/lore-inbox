Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUJZA2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUJZA2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUJYPC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:02:57 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:61864 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261868AbUJYOry convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:47:54 -0400
Cc: raven@themaw.net
Subject: [PATCH 18/28] VFS: Mountpoint file descriptor read properties
In-Reply-To: <10987156292985@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:47:39 -0400
Message-Id: <1098715659264@sun.com>
References: <10987156292985@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows userspace to query a mountpoint file descriptor for
information using the ioctl interface.

The properties exported in this patch are for _example only_ to demonstrate
what the interface might look like.  This patch allows mountfds to show the
following information:

MOUNTFD_IOC_GETDEV        - Get the associated block device (if any)
MOUNTFD_IOC_GETFSTYPE     - Get the fstype of the mountpoint.
MOUNTFD_IOC_GETVFSOPTIONS - Get the vfs specific options of the
                            mountpoint/superblock
MOUNTFD_IOC_GETFSOPTIONS  - Get the fstype-specific options (if any)

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/mountfd.c       |  114 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/fs.h |    6 ++
 2 files changed, 119 insertions(+), 1 deletion(-)

Index: linux-2.6.9-quilt/fs/mountfd.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/mountfd.c	2004-10-22 17:17:42.625984008 -0400
+++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:43.230892048 -0400
@@ -160,6 +160,72 @@ static struct dentry *get_mfd_dentry(str
 	return dget(dentry);
 }
 
+static int mfd_read_fstype(struct vfsmount *mnt, char *buf)
+{
+	return scnprintf(buf, MOUNTFD_READSIZE-1, "%s", mnt->mnt_sb->s_type->name) + 1;
+}
+
+static int mfd_read_dev(struct vfsmount *mnt, char *buf)
+{
+	return scnprintf(buf, MOUNTFD_READSIZE-1, "%s", mnt->mnt_sb->s_id) + 1;
+}
+
+static int mfd_read_vfsoptions(struct vfsmount *mnt, char *buf)
+{
+	static struct vfs_info {
+		int flag;
+		char *str;
+	} vfs_info[] = {
+		{ MS_RDONLY, "ro" },
+		{ MS_DIRSYNC, "dirsync" },
+		{ MS_MANDLOCK, "mand" },
+		{ MS_NOATIME, "noatime" },
+		{ MS_NODIRATIME, "nodiratime" },
+		{ 0, NULL }
+	};
+	struct vfs_info *vfs_infop;
+	static struct mnt_info {
+		int flag;
+		char *str;
+	} mnt_info[] = {
+		{ MNT_NOSUID, "nosuid" },
+		{ MNT_NODEV, "nodev" },
+		{ MNT_NOEXEC, "noexec" },
+		{ 0, NULL }
+	};
+	struct mnt_info *mnt_infop;
+
+	char *p = buf;
+
+	int sb_flags = mnt->mnt_sb->s_flags;
+	int mnt_flags = mnt->mnt_flags;
+	int first = 0;
+
+	/*
+	 * Note: we skip length checks below because we assume we can't overrun
+	 * MOUNTFD_READSIZE.
+	 */
+
+	for (vfs_infop = vfs_info; vfs_infop->flag; vfs_infop++) {
+		if (sb_flags & vfs_infop->flag) {
+			if (first++)
+				*p++ = ',';
+			strcpy(p, vfs_infop->str);
+			p += strlen(vfs_infop->str);
+		}
+	}
+
+	for (mnt_infop = mnt_info; mnt_infop->flag; mnt_infop++) {
+		if (mnt_flags & mnt_infop->flag) {
+			if (first++)
+				*p++ = ',';
+			strcpy(p, mnt_infop->str);
+			p += strlen(mnt_infop->str);
+		}
+	}
+	return p - buf + 1;
+}
+
 static long open_mfd(struct vfsmount *mnt)
 {
 	struct file *file;
@@ -176,6 +242,7 @@ static long open_mfd(struct vfsmount *mn
 	if (fd < 0)
 		goto out_putfilp;
 
+	error = -ENOMEM;
 	file->private_data = mnt;
 	file->f_dentry = get_mfd_dentry(mnt);
 	if (IS_ERR(file->f_dentry)) {
@@ -326,9 +393,53 @@ static long mfd_nextchild(struct file *m
 	return ret;
 }
 
+static int mfd_ioctl_reads(struct inode *inode, struct file *filp,
+		     unsigned int cmd, unsigned long arg)
+{
+	char __user *user_buf = (char __user *)arg;
+	struct vfsmount *mnt;
+	char *buf;
+	int ret;
+
+	mnt = VFSMOUNT(filp);
+
+	buf = (char *)get_zeroed_page(GFP_KERNEL);
+	if (buf)
+		return -ENOMEM;
+	switch (cmd) {
+	/*
+	 * The following calls are expected to return the total number of bytes to write out, including '\0'.
+	 */
+	case MOUNTFD_IOC_GETDEV:
+		ret = mfd_read_dev(mnt, buf);
+		break;
+	case MOUNTFD_IOC_GETFSTYPE:
+		ret = mfd_read_fstype(mnt, buf);
+		break;
+	case MOUNTFD_IOC_GETVFSOPTIONS:
+		ret = mfd_read_vfsoptions(mnt, buf);
+		break;
+	case MOUNTFD_IOC_GETFSOPTIONS:
+		/* TODO: need super_block op that doesn't take a seq_file */
+		ret = -ENOSYS;
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	if (ret >= 0) {
+		if (copy_to_user(user_buf, buf, ret))
+			ret = -EFAULT;
+	}
+
+	free_page((unsigned long)buf);
+	return ret;
+}
+
 static int mfd_ioctl(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
 {
+	int ret;
 	switch (cmd) {
 	case MOUNTFD_IOC_GETDIRFD:
 		return mfd_getdirfd(filp);
@@ -345,7 +456,8 @@ static int mfd_ioctl(struct inode *inode
 	case MOUNTFD_IOC_GETNEXTCHILD:
 		return mfd_nextchild(filp);
 	}
-	return -ENOTTY;
+	ret = mfd_ioctl_reads(inode, filp, cmd, arg);
+	return ret;
 }
 
 asmlinkage long sys_mountfd(int dirfd)
Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-10-22 17:17:42.625984008 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:43.232891744 -0400
@@ -223,6 +223,12 @@ extern int leases_enable, dir_notify_ena
 /* TODO: change this interface to require the parent mfd as well */
 #define MOUNTFD_IOC_GETNEXTCHILD  _IO('p', 0xa6)
 
+#define MOUNTFD_READSIZE PAGE_SIZE
+#define MOUNTFD_IOC_GETDEV        _IOR('p', 0xa7, char [MOUNTFD_READSIZE])
+#define MOUNTFD_IOC_GETFSTYPE     _IOR('p', 0xa8, char [MOUNTFD_READSIZE])
+#define MOUNTFD_IOC_GETVFSOPTIONS _IOR('p', 0xa9, char [MOUNTFD_READSIZE])
+#define MOUNTFD_IOC_GETFSOPTIONS  _IOR('p', 0xaa, char [MOUNTFD_READSIZE])
+
 #ifdef __KERNEL__
 
 #include <linux/list.h>

