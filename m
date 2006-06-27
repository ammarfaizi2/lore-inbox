Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWF0WV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWF0WV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 18:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422656AbWF0WUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 18:20:00 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:40873 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030437AbWF0WOq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 18:14:46 -0400
Subject: [PATCH 05/20] elevate write count during entire ncp_ioctl()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, herbert@13thfloor.at, viro@ftp.linux.org.uk,
       serue@us.ibm.com, Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 27 Jun 2006 15:14:40 -0700
References: <20060627221436.77CCB048@localhost.localdomain>
In-Reply-To: <20060627221436.77CCB048@localhost.localdomain>
Message-Id: <20060627221440.6CE54313@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some ioctls need write access, but others don't.  Make a helper
function to decide when write access is needed, and take it.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/ncpfs/ioctl.c |   55 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 54 insertions(+), 1 deletion(-)

diff -puN fs/ncpfs/ioctl.c~C-elevate-writers-file_permission-callers fs/ncpfs/ioctl.c
--- lxc/fs/ncpfs/ioctl.c~C-elevate-writers-file_permission-callers	2006-06-27 10:40:26.000000000 -0700
+++ lxc-dave/fs/ncpfs/ioctl.c	2006-06-27 10:40:26.000000000 -0700
@@ -16,6 +16,7 @@
 #include <linux/ioctl.h>
 #include <linux/time.h>
 #include <linux/mm.h>
+#include <linux/mount.h>
 #include <linux/highuid.h>
 #include <linux/vmalloc.h>
 
@@ -183,7 +184,7 @@ ncp_get_charsets(struct ncp_server* serv
 }
 #endif /* CONFIG_NCPFS_NLS */
 
-int ncp_ioctl(struct inode *inode, struct file *filp,
+static int __ncp_ioctl(struct inode *inode, struct file *filp,
 	      unsigned int cmd, unsigned long arg)
 {
 	struct ncp_server *server = NCP_SERVER(inode);
@@ -654,3 +655,55 @@ outrel:			
 /* #endif */
 	return -EINVAL;
 }
+
+static int ncp_ioctl_need_write(unsigned int cmd)
+{
+	switch (cmd) {
+        case NCP_IOC_GET_FS_INFO:
+        case NCP_IOC_GET_FS_INFO_V2:
+        case NCP_IOC_NCPREQUEST:
+        case NCP_IOC_SETDENTRYTTL:
+        case NCP_IOC_SIGN_INIT:
+        case NCP_IOC_LOCKUNLOCK:
+        case NCP_IOC_SET_SIGN_WANTED:
+		return 1;
+        case NCP_IOC_GETOBJECTNAME:
+        case NCP_IOC_SETOBJECTNAME:
+        case NCP_IOC_GETPRIVATEDATA:
+        case NCP_IOC_SETPRIVATEDATA:
+        case NCP_IOC_SETCHARSETS:
+        case NCP_IOC_GETCHARSETS:
+        case NCP_IOC_CONN_LOGGED_IN:
+        case NCP_IOC_GETDENTRYTTL:
+        case NCP_IOC_GETMOUNTUID2:
+        case NCP_IOC_SIGN_WANTED:
+        case NCP_IOC_GETROOT:
+        case NCP_IOC_SETROOT:
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
