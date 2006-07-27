Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWG0BIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWG0BIP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 21:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWG0BIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 21:08:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:58843 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750759AbWG0BIO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 21:08:14 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: reference: ncpfs: move ioctl32 code to fs/ncpfs/ioctl.c
Date: Thu, 27 Jul 2006 03:08:12 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270303.42959.arnd.bergmann@de.ibm.com>
In-Reply-To: <200607270303.42959.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270308.13007.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 July 2006 03:03, Arnd Bergmann wrote:

> 
> I'm also posting the two patches I made a long time ago as a reference.
> 

Ok, I just realized that this was not using a merged 
->compat_ioctl/->unlocked_ioctl function yet, but wth, here
it is anyway.


Subject: ncpfs: move ioctl32 code to fs/ncpfs/ioctl.c

The ncp specific compat ioctls are clearly local to one
file system, so the code can better live there.

This could be further improved by getting rid of get_fs/set_fs
in the future.

CC: vandrove@vc.cvut.cz
CC: linware@sh.cvut.cz
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 15:47:28.000000000 +0100
@@ -718,193 +718,6 @@
 	return sys_ioctl(fd, cmd, (unsigned long)tdata);
 }
 
-#if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
-struct ncp_ioctl_request_32 {
-	u32 function;
-	u32 size;
-	compat_caddr_t data;
-};
-
-struct ncp_fs_info_v2_32 {
-	s32 version;
-	u32 mounted_uid;
-	u32 connection;
-	u32 buffer_size;
-
-	u32 volume_number;
-	u32 directory_id;
-
-	u32 dummy1;
-	u32 dummy2;
-	u32 dummy3;
-};
-
-struct ncp_objectname_ioctl_32
-{
-	s32		auth_type;
-	u32		object_name_len;
-	compat_caddr_t	object_name;	/* an userspace data, in most cases user name */
-};
-
-struct ncp_privatedata_ioctl_32
-{
-	u32		len;
-	compat_caddr_t	data;		/* ~1000 for NDS */
-};
-
-#define	NCP_IOC_NCPREQUEST_32		_IOR('n', 1, struct ncp_ioctl_request_32)
-#define NCP_IOC_GETMOUNTUID2_32		_IOW('n', 2, u32)
-#define NCP_IOC_GET_FS_INFO_V2_32	_IOWR('n', 4, struct ncp_fs_info_v2_32)
-#define NCP_IOC_GETOBJECTNAME_32	_IOWR('n', 9, struct ncp_objectname_ioctl_32)
-#define NCP_IOC_SETOBJECTNAME_32	_IOR('n', 9, struct ncp_objectname_ioctl_32)
-#define NCP_IOC_GETPRIVATEDATA_32	_IOWR('n', 10, struct ncp_privatedata_ioctl_32)
-#define NCP_IOC_SETPRIVATEDATA_32	_IOR('n', 10, struct ncp_privatedata_ioctl_32)
-
-static int do_ncp_ncprequest(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ncp_ioctl_request_32 n32;
-	struct ncp_ioctl_request __user *p = compat_alloc_user_space(sizeof(*p));
-
-	if (copy_from_user(&n32, compat_ptr(arg), sizeof(n32)) ||
-	    put_user(n32.function, &p->function) ||
-	    put_user(n32.size, &p->size) ||
-	    put_user(compat_ptr(n32.data), &p->data))
-		return -EFAULT;
-
-	return sys_ioctl(fd, NCP_IOC_NCPREQUEST, (unsigned long)p);
-}
-
-static int do_ncp_getmountuid2(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	__kernel_uid_t kuid;
-	int err;
-
-	cmd = NCP_IOC_GETMOUNTUID2;
-
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long)&kuid);
-	set_fs(old_fs);
-
-	if (!err)
-		err = put_user(kuid,
-			       (unsigned int __user *) compat_ptr(arg));
-
-	return err;
-}
-
-static int do_ncp_getfsinfo2(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	struct ncp_fs_info_v2_32 n32;
-	struct ncp_fs_info_v2 n;
-	int err;
-
-	if (copy_from_user(&n32, compat_ptr(arg), sizeof(n32)))
-		return -EFAULT;
-	if (n32.version != NCP_GET_FS_INFO_VERSION_V2)
-		return -EINVAL;
-	n.version = NCP_GET_FS_INFO_VERSION_V2;
-
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, NCP_IOC_GET_FS_INFO_V2, (unsigned long)&n);
-	set_fs(old_fs);
-
-	if (!err) {
-		n32.version = n.version;
-		n32.mounted_uid = n.mounted_uid;
-		n32.connection = n.connection;
-		n32.buffer_size = n.buffer_size;
-		n32.volume_number = n.volume_number;
-		n32.directory_id = n.directory_id;
-		n32.dummy1 = n.dummy1;
-		n32.dummy2 = n.dummy2;
-		n32.dummy3 = n.dummy3;
-		err = copy_to_user(compat_ptr(arg), &n32, sizeof(n32)) ? -EFAULT : 0;
-	}
-	return err;
-}
-
-static int do_ncp_getobjectname(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ncp_objectname_ioctl_32 n32, __user *p32 = compat_ptr(arg);
-	struct ncp_objectname_ioctl __user *p = compat_alloc_user_space(sizeof(*p));
-	s32 auth_type;
-	u32 name_len;
-	int err;
-
-	if (copy_from_user(&n32, p32, sizeof(n32)) ||
-	    put_user(n32.object_name_len, &p->object_name_len) ||
-	    put_user(compat_ptr(n32.object_name), &p->object_name))
-		return -EFAULT;
-
-	err = sys_ioctl(fd, NCP_IOC_GETOBJECTNAME, (unsigned long)p);
-        if (err)
-		return err;
-
-	if (get_user(auth_type, &p->auth_type) ||
-	    put_user(auth_type, &p32->auth_type) ||
-	    get_user(name_len, &p->object_name_len) ||
-	    put_user(name_len, &p32->object_name_len))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int do_ncp_setobjectname(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ncp_objectname_ioctl_32 n32, __user *p32 = compat_ptr(arg);
-	struct ncp_objectname_ioctl __user *p = compat_alloc_user_space(sizeof(*p));
-
-	if (copy_from_user(&n32, p32, sizeof(n32)) ||
-	    put_user(n32.auth_type, &p->auth_type) ||
-	    put_user(n32.object_name_len, &p->object_name_len) ||
-	    put_user(compat_ptr(n32.object_name), &p->object_name))
-		return -EFAULT;
-
-	return sys_ioctl(fd, NCP_IOC_SETOBJECTNAME, (unsigned long)p);
-}
-
-static int do_ncp_getprivatedata(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ncp_privatedata_ioctl_32 n32, __user *p32 = compat_ptr(arg);
-	struct ncp_privatedata_ioctl __user *p =
-		compat_alloc_user_space(sizeof(*p));
-	u32 len;
-	int err;
-
-	if (copy_from_user(&n32, p32, sizeof(n32)) ||
-	    put_user(n32.len, &p->len) ||
-	    put_user(compat_ptr(n32.data), &p->data))
-		return -EFAULT;
-
-	err = sys_ioctl(fd, NCP_IOC_GETPRIVATEDATA, (unsigned long)p);
-        if (err)
-		return err;
-
-	if (get_user(len, &p->len) ||
-	    put_user(len, &p32->len))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int do_ncp_setprivatedata(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct ncp_privatedata_ioctl_32 n32;
-	struct ncp_privatedata_ioctl_32 __user *p32 = compat_ptr(arg);
-	struct ncp_privatedata_ioctl __user *p =
-		compat_alloc_user_space(sizeof(*p));
-
-	if (copy_from_user(&n32, p32, sizeof(n32)) ||
-	    put_user(n32.len, &p->len) ||
-	    put_user(compat_ptr(n32.data), &p->data))
-		return -EFAULT;
-
-	return sys_ioctl(fd, NCP_IOC_SETPRIVATEDATA, (unsigned long)p);
-}
-#endif
-
 #undef CODE
 #endif
 
@@ -937,15 +750,5 @@
 HANDLE_IOCTL(I2C_RDWR, do_i2c_rdwr_ioctl)
 HANDLE_IOCTL(I2C_SMBUS, do_i2c_smbus_ioctl)
 
-#if defined(CONFIG_NCP_FS) || defined(CONFIG_NCP_FS_MODULE)
-HANDLE_IOCTL(NCP_IOC_NCPREQUEST_32, do_ncp_ncprequest)
-HANDLE_IOCTL(NCP_IOC_GETMOUNTUID2_32, do_ncp_getmountuid2)
-HANDLE_IOCTL(NCP_IOC_GET_FS_INFO_V2_32, do_ncp_getfsinfo2)
-HANDLE_IOCTL(NCP_IOC_GETOBJECTNAME_32, do_ncp_getobjectname)
-HANDLE_IOCTL(NCP_IOC_SETOBJECTNAME_32, do_ncp_setobjectname)
-HANDLE_IOCTL(NCP_IOC_GETPRIVATEDATA_32, do_ncp_getprivatedata)
-HANDLE_IOCTL(NCP_IOC_SETPRIVATEDATA_32, do_ncp_setprivatedata)
-#endif
-
 #undef DECLARES
 #endif
Index: linux-cg/fs/ncpfs/dir.c
===================================================================
--- linux-cg.orig/fs/ncpfs/dir.c	2005-11-05 14:19:13.000000000 +0100
+++ linux-cg/fs/ncpfs/dir.c	2005-11-05 14:22:34.000000000 +0100
@@ -54,6 +54,9 @@
 	.read		= generic_read_dir,
 	.readdir	= ncp_readdir,
 	.ioctl		= ncp_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ncp_compat_ioctl,
+#endif
 };
 
 struct inode_operations ncp_dir_inode_operations =
Index: linux-cg/fs/ncpfs/file.c
===================================================================
--- linux-cg.orig/fs/ncpfs/file.c	2005-11-05 14:19:13.000000000 +0100
+++ linux-cg/fs/ncpfs/file.c	2005-11-05 14:22:34.000000000 +0100
@@ -9,6 +9,7 @@
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
+#include <linux/config.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -289,6 +290,9 @@
 	.read		= ncp_file_read,
 	.write		= ncp_file_write,
 	.ioctl		= ncp_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ncp_compat_ioctl,
+#endif
 	.mmap		= ncp_mmap,
 	.release	= ncp_release,
 	.fsync		= ncp_fsync,
Index: linux-cg/fs/ncpfs/ioctl.c
===================================================================
--- linux-cg.orig/fs/ncpfs/ioctl.c	2005-11-05 14:19:13.000000000 +0100
+++ linux-cg/fs/ncpfs/ioctl.c	2005-11-05 15:44:12.000000000 +0100
@@ -8,8 +8,7 @@
  */
 
 #include <linux/config.h>
-
-#include <asm/uaccess.h>
+#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
@@ -20,6 +19,8 @@
 
 #include <linux/ncp_fs.h>
 
+#include <asm/uaccess.h>
+
 #include "ncplib_kernel.h"
 
 /* maximum limit for ncp_objectname_ioctl */
@@ -647,3 +648,239 @@
 /* #endif */
 	return -EINVAL;
 }
+
+#ifdef CONFIG_COMPAT
+struct ncp_ioctl_request_32 {
+	u32 function;
+	u32 size;
+	compat_caddr_t data;
+};
+
+struct ncp_fs_info_v2_32 {
+	s32 version;
+	u32 mounted_uid;
+	u32 connection;
+	u32 buffer_size;
+
+	u32 volume_number;
+	u32 directory_id;
+
+	u32 dummy1;
+	u32 dummy2;
+	u32 dummy3;
+};
+
+struct ncp_objectname_ioctl_32
+{
+	s32		auth_type;
+	u32		object_name_len;
+	compat_caddr_t	object_name;	/* an userspace data, in most cases user name */
+};
+
+struct ncp_privatedata_ioctl_32
+{
+	u32		len;
+	compat_caddr_t	data;		/* ~1000 for NDS */
+};
+
+#define	NCP_IOC_NCPREQUEST_32		_IOR('n', 1, struct ncp_ioctl_request_32)
+#define NCP_IOC_GETMOUNTUID2_32		_IOW('n', 2, u32)
+#define NCP_IOC_GET_FS_INFO_V2_32	_IOWR('n', 4, struct ncp_fs_info_v2_32)
+#define NCP_IOC_GETOBJECTNAME_32	_IOWR('n', 9, struct ncp_objectname_ioctl_32)
+#define NCP_IOC_SETOBJECTNAME_32	_IOR('n', 9, struct ncp_objectname_ioctl_32)
+#define NCP_IOC_GETPRIVATEDATA_32	_IOWR('n', 10, struct ncp_privatedata_ioctl_32)
+#define NCP_IOC_SETPRIVATEDATA_32	_IOR('n', 10, struct ncp_privatedata_ioctl_32)
+
+static int do_ncp_ncprequest(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ncp_ioctl_request_32 n32;
+	struct ncp_ioctl_request __user *p = compat_alloc_user_space(sizeof(*p));
+
+	if (copy_from_user(&n32, compat_ptr(arg), sizeof(n32)) ||
+	    put_user(n32.function, &p->function) ||
+	    put_user(n32.size, &p->size) ||
+	    put_user(compat_ptr(n32.data), &p->data))
+		return -EFAULT;
+
+	return ncp_ioctl(inode, file, NCP_IOC_NCPREQUEST, (unsigned long)p);
+}
+
+static int do_ncp_getmountuid2(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	__kernel_uid_t kuid;
+	int err;
+
+	cmd = NCP_IOC_GETMOUNTUID2;
+
+	set_fs(KERNEL_DS);
+	err = ncp_ioctl(inode, file, cmd, (unsigned long)&kuid);
+	set_fs(old_fs);
+
+	if (!err)
+		err = put_user(kuid,
+			       (unsigned int __user *) compat_ptr(arg));
+
+	return err;
+}
+
+static int do_ncp_getfsinfo2(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	struct ncp_fs_info_v2_32 n32;
+	struct ncp_fs_info_v2 n;
+	int err;
+
+	if (copy_from_user(&n32, compat_ptr(arg), sizeof(n32)))
+		return -EFAULT;
+	if (n32.version != NCP_GET_FS_INFO_VERSION_V2)
+		return -EINVAL;
+	n.version = NCP_GET_FS_INFO_VERSION_V2;
+
+	set_fs(KERNEL_DS);
+	err = ncp_ioctl(inode, file, NCP_IOC_GET_FS_INFO_V2, (unsigned long)&n);
+	set_fs(old_fs);
+
+	if (!err) {
+		n32.version = n.version;
+		n32.mounted_uid = n.mounted_uid;
+		n32.connection = n.connection;
+		n32.buffer_size = n.buffer_size;
+		n32.volume_number = n.volume_number;
+		n32.directory_id = n.directory_id;
+		n32.dummy1 = n.dummy1;
+		n32.dummy2 = n.dummy2;
+		n32.dummy3 = n.dummy3;
+		err = copy_to_user(compat_ptr(arg), &n32, sizeof(n32)) ? -EFAULT : 0;
+	}
+	return err;
+}
+
+static int do_ncp_getobjectname(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ncp_objectname_ioctl_32 n32, __user *p32 = compat_ptr(arg);
+	struct ncp_objectname_ioctl __user *p = compat_alloc_user_space(sizeof(*p));
+	s32 auth_type;
+	u32 name_len;
+	int err;
+
+	if (copy_from_user(&n32, p32, sizeof(n32)) ||
+	    put_user(n32.object_name_len, &p->object_name_len) ||
+	    put_user(compat_ptr(n32.object_name), &p->object_name))
+		return -EFAULT;
+
+	err = ncp_ioctl(inode, file, NCP_IOC_GETOBJECTNAME, (unsigned long)p);
+        if (err)
+		return err;
+
+	if (get_user(auth_type, &p->auth_type) ||
+	    put_user(auth_type, &p32->auth_type) ||
+	    get_user(name_len, &p->object_name_len) ||
+	    put_user(name_len, &p32->object_name_len))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int do_ncp_setobjectname(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ncp_objectname_ioctl_32 n32, __user *p32 = compat_ptr(arg);
+	struct ncp_objectname_ioctl __user *p = compat_alloc_user_space(sizeof(*p));
+
+	if (copy_from_user(&n32, p32, sizeof(n32)) ||
+	    put_user(n32.auth_type, &p->auth_type) ||
+	    put_user(n32.object_name_len, &p->object_name_len) ||
+	    put_user(compat_ptr(n32.object_name), &p->object_name))
+		return -EFAULT;
+
+	return ncp_ioctl(inode, file, NCP_IOC_SETOBJECTNAME, (unsigned long)p);
+}
+
+static int do_ncp_getprivatedata(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ncp_privatedata_ioctl_32 n32, __user *p32 = compat_ptr(arg);
+	struct ncp_privatedata_ioctl __user *p =
+		compat_alloc_user_space(sizeof(*p));
+	u32 len;
+	int err;
+
+	if (copy_from_user(&n32, p32, sizeof(n32)) ||
+	    put_user(n32.len, &p->len) ||
+	    put_user(compat_ptr(n32.data), &p->data))
+		return -EFAULT;
+
+	err = ncp_ioctl(inode, file, NCP_IOC_GETPRIVATEDATA, (unsigned long)p);
+        if (err)
+		return err;
+
+	if (get_user(len, &p->len) ||
+	    put_user(len, &p32->len))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int do_ncp_setprivatedata(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ncp_privatedata_ioctl_32 n32;
+	struct ncp_privatedata_ioctl_32 __user *p32 = compat_ptr(arg);
+	struct ncp_privatedata_ioctl __user *p =
+		compat_alloc_user_space(sizeof(*p));
+
+	if (copy_from_user(&n32, p32, sizeof(n32)) ||
+	    put_user(n32.len, &p->len) ||
+	    put_user(compat_ptr(n32.data), &p->data))
+		return -EFAULT;
+
+	return ncp_ioctl(inode, file, NCP_IOC_SETPRIVATEDATA, (unsigned long)p);
+}
+
+long ncp_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret;
+
+	ret = -ENOIOCTLCMD;
+	lock_kernel();
+	switch (cmd) {
+	case NCP_IOC_NCPREQUEST_32:
+		ret = do_ncp_ncprequest(inode, file, cmd, arg);
+		break;
+	case NCP_IOC_GETMOUNTUID2_32:
+		ret = do_ncp_getmountuid2(inode, file, cmd, arg);
+		break;
+	case NCP_IOC_GET_FS_INFO_V2_32:
+		ret = do_ncp_getfsinfo2(inode, file, cmd, arg);
+		break;
+	case NCP_IOC_GETOBJECTNAME_32:
+		ret = do_ncp_getobjectname(inode, file, cmd, arg);
+		break;
+	case NCP_IOC_SETOBJECTNAME_32:
+		ret = do_ncp_setobjectname(inode, file, cmd, arg);
+		break;
+	case NCP_IOC_GETPRIVATEDATA_32:
+		ret = do_ncp_getprivatedata(inode, file, cmd, arg);
+		break;
+	case NCP_IOC_SETPRIVATEDATA_32:
+		ret = do_ncp_setprivatedata(inode, file, cmd, arg);
+		break;
+	/* NCP ioctls which do not need any translations */
+	case NCP_IOC_CONN_LOGGED_IN:
+	case NCP_IOC_SIGN_INIT:
+	case NCP_IOC_SIGN_WANTED:
+	case NCP_IOC_SET_SIGN_WANTED:
+	case NCP_IOC_LOCKUNLOCK:
+	case NCP_IOC_GETROOT:
+	case NCP_IOC_SETROOT:
+	case NCP_IOC_GETCHARSETS:
+	case NCP_IOC_SETCHARSETS:
+	case NCP_IOC_GETDENTRYTTL:
+	case NCP_IOC_SETDENTRYTTL:
+		arg = (unsigned long) compat_ptr(arg);
+		ret = ncp_ioctl(inode, file, cmd, arg);
+		break;
+	}
+	unlock_kernel();
+	return ret;
+}
+#endif
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 14:22:34.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 15:47:28.000000000 +0100
@@ -368,18 +368,6 @@
 /* Raw devices */
 COMPATIBLE_IOCTL(RAW_SETBIND)
 COMPATIBLE_IOCTL(RAW_GETBIND)
-/* NCP ioctls which do not need any translations */
-COMPATIBLE_IOCTL(NCP_IOC_CONN_LOGGED_IN)
-COMPATIBLE_IOCTL(NCP_IOC_SIGN_INIT)
-COMPATIBLE_IOCTL(NCP_IOC_SIGN_WANTED)
-COMPATIBLE_IOCTL(NCP_IOC_SET_SIGN_WANTED)
-COMPATIBLE_IOCTL(NCP_IOC_LOCKUNLOCK)
-COMPATIBLE_IOCTL(NCP_IOC_GETROOT)
-COMPATIBLE_IOCTL(NCP_IOC_SETROOT)
-COMPATIBLE_IOCTL(NCP_IOC_GETCHARSETS)
-COMPATIBLE_IOCTL(NCP_IOC_SETCHARSETS)
-COMPATIBLE_IOCTL(NCP_IOC_GETDENTRYTTL)
-COMPATIBLE_IOCTL(NCP_IOC_SETDENTRYTTL)
 /* Little a */
 COMPATIBLE_IOCTL(ATMSIGD_CTRL)
 COMPATIBLE_IOCTL(ATMARPD_CTRL)
Index: linux-cg/include/linux/ncp_fs.h
===================================================================
--- linux-cg.orig/include/linux/ncp_fs.h	2005-11-05 14:19:13.000000000 +0100
+++ linux-cg/include/linux/ncp_fs.h	2005-11-05 14:22:34.000000000 +0100
@@ -244,6 +244,7 @@
 
 /* linux/fs/ncpfs/ioctl.c */
 int ncp_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+long ncp_compat_ioctl(struct file *, unsigned int, unsigned long);
 
 /* linux/fs/ncpfs/sock.c */
 int ncp_request2(struct ncp_server *server, int function,
