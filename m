Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWGLSVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWGLSVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWGLSVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:21:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:37529 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932347AbWGLSRX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:23 -0400
Subject: [RFC][PATCH 11/27] elevate write count during entire ncp_ioctl()
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:17 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181717.D47355F7@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some ioctls need write access, but others don't.  Make a helper
function to decide when write access is needed, and take it.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/ncpfs/ioctl.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletion(-)

diff -puN fs/ncpfs/ioctl.c~C-elevate-writers-file_permission-callers fs/ncpfs/ioctl.c
--- lxc/fs/ncpfs/ioctl.c~C-elevate-writers-file_permission-callers	2006-07-12 11:09:15.000000000 -0700
+++ lxc-dave/fs/ncpfs/ioctl.c	2006-07-12 11:09:28.000000000 -0700
@@ -15,6 +15,7 @@
 #include <linux/ioctl.h>
 #include <linux/time.h>
 #include <linux/mm.h>
+#include <linux/mount.h>
 #include <linux/highuid.h>
 #include <linux/vmalloc.h>
 
@@ -182,7 +183,7 @@ ncp_get_charsets(struct ncp_server* serv
 }
 #endif /* CONFIG_NCPFS_NLS */
 
-int ncp_ioctl(struct inode *inode, struct file *filp,
+static int __ncp_ioctl(struct inode *inode, struct file *filp,
 	      unsigned int cmd, unsigned long arg)
 {
 	struct ncp_server *server = NCP_SERVER(inode);
@@ -653,3 +654,55 @@ outrel:			
 /* #endif */
 	return -EINVAL;
 }
+
+static int ncp_ioctl_need_write(unsigned int cmd)
+{
+	switch (cmd) {
+	case NCP_IOC_GET_FS_INFO:
+	case NCP_IOC_GET_FS_INFO_V2:
+	case NCP_IOC_NCPREQUEST:
+	case NCP_IOC_SETDENTRYTTL:
+	case NCP_IOC_SIGN_INIT:
+	case NCP_IOC_LOCKUNLOCK:
+	case NCP_IOC_SET_SIGN_WANTED:
+		return 1;
+	case NCP_IOC_GETOBJECTNAME:
+	case NCP_IOC_SETOBJECTNAME:
+	case NCP_IOC_GETPRIVATEDATA:
+	case NCP_IOC_SETPRIVATEDATA:
+	case NCP_IOC_SETCHARSETS:
+	case NCP_IOC_GETCHARSETS:
+	case NCP_IOC_CONN_LOGGED_IN:
+	case NCP_IOC_GETDENTRYTTL:
+	case NCP_IOC_GETMOUNTUID2:
+	case NCP_IOC_SIGN_WANTED:
+	case NCP_IOC_GETROOT:
+	case NCP_IOC_SETROOT:
+		return 0;
+	default:
+		/* unkown IOCTL command, assume write */
+		WARN_ON(1);
+	}
+	return 1;
+}
+
+int ncp_ioctl(struct inode *inode, struct file *filp,
+	      unsigned int cmd, unsigned long arg)
+{
+	int ret;
+
+	if (ncp_ioctl_need_write(cmd)) {
+		/*
+		 * inside the ioctl(), any failures which
+		 * are because of file_permission() are
+		 * -EACCESS, so it seems consistent to keep
+		 *  that here.
+		 */
+		if (mnt_want_write(filp->f_vfsmnt))
+			return -EACCES;
+	}
+	ret = __ncp_ioctl(inode, filp, cmd, arg);
+	if (ncp_ioctl_need_write(cmd))
+		mnt_drop_write(filp->f_vfsmnt);
+	return ret;
+}
_
