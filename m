Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261836AbUJZA1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbUJZA1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 20:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbUJYPDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:03:18 -0400
Received: from ip22-176.tor.istop.com ([66.11.176.22]:63144 "EHLO
	crlf.tor.istop.com") by vger.kernel.org with ESMTP id S261872AbUJYOsZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:48:25 -0400
Cc: raven@themaw.net
Subject: [PATCH 19/28] VFS: Mountpoint file descriptor expiry support
In-Reply-To: <1098715659264@sun.com>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Mon, 25 Oct 2004 10:48:10 -0400
Message-Id: <10987156903663@sun.com>
References: <1098715659264@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Mike Waychison <michael.waychison@sun.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for letting userspcae set the expiry information on a
given mountpoint.

Signed-off-by: Mike Waychison <michael.waychison@sun.com>
---

 fs/mountfd.c       |   10 ++++++++++
 include/linux/fs.h |    1 +
 2 files changed, 11 insertions(+)

Index: linux-2.6.9-quilt/include/linux/fs.h
===================================================================
--- linux-2.6.9-quilt.orig/include/linux/fs.h	2004-10-22 17:17:43.232891744 -0400
+++ linux-2.6.9-quilt/include/linux/fs.h	2004-10-22 17:17:43.766810576 -0400
@@ -228,6 +228,7 @@ extern int leases_enable, dir_notify_ena
 #define MOUNTFD_IOC_GETFSTYPE     _IOR('p', 0xa8, char [MOUNTFD_READSIZE])
 #define MOUNTFD_IOC_GETVFSOPTIONS _IOR('p', 0xa9, char [MOUNTFD_READSIZE])
 #define MOUNTFD_IOC_GETFSOPTIONS  _IOR('p', 0xaa, char [MOUNTFD_READSIZE])
+#define MOUNTFD_IOC_SETVFSEXPIRE  _IOW('p', 0xab, int)
 
 #ifdef __KERNEL__
 
Index: linux-2.6.9-quilt/fs/mountfd.c
===================================================================
--- linux-2.6.9-quilt.orig/fs/mountfd.c	2004-10-22 17:17:43.230892048 -0400
+++ linux-2.6.9-quilt/fs/mountfd.c	2004-10-22 17:17:43.767810424 -0400
@@ -393,6 +393,14 @@ static long mfd_nextchild(struct file *m
 	return ret;
 }
 
+static int mfd_vfsexpire(struct file *mountfilp, int arg)
+{
+	struct vfsmount *mnt;
+
+	mnt = VFSMOUNT(mountfilp);
+	return mnt_expire(mnt, arg);
+}
+
 static int mfd_ioctl_reads(struct inode *inode, struct file *filp,
 		     unsigned int cmd, unsigned long arg)
 {
@@ -455,6 +463,8 @@ static int mfd_ioctl(struct inode *inode
 		return mfd_firstchild(filp);
 	case MOUNTFD_IOC_GETNEXTCHILD:
 		return mfd_nextchild(filp);
+	case MOUNTFD_IOC_SETVFSEXPIRE:
+		return mfd_vfsexpire(filp, (int)arg);
 	}
 	ret = mfd_ioctl_reads(inode, filp, cmd, arg);
 	return ret;

