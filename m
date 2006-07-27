Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWG0C4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWG0C4v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 22:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbWG0C4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 22:56:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:54663 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751219AbWG0C4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 22:56:50 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: Heiko Carstens <heiko.carstens@de.ibm.com>, vandrove@vc.cvut.cz,
       linware@sh.cvut.cz
Subject: [PATCH] ncpfs: move ioctl32 code to fs/ncpfs/ioctl.c
Date: Thu, 27 Jul 2006 04:56:47 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270303.42959.arnd.bergmann@de.ibm.com> <200607270309.58867.arnd.bergmann@de.ibm.com>
In-Reply-To: <200607270309.58867.arnd.bergmann@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607270456.48014.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ncp specific compat ioctls are clearly local to one
file system, so the code can better live there.

This version of the patch moves everything into the
generic ioctl handler and uses it for both 32 and 64
bit calls.

Petr, can you test this patch on a 64 bit system?

CC: vandrove@vc.cvut.cz
CC: linware@sh.cvut.cz
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2006-07-15 03:45:21.000000000 +0200
+++ linux-cg/fs/compat_ioctl.c	2006-07-27 03:12:25.000000000 +0200
@@ -2507,193 +2507,6 @@
 	}
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
 static int
 lp_timeout_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -2920,16 +2733,6 @@
 HANDLE_IOCTL(RTC_EPOCH_READ32, rtc_ioctl)
 HANDLE_IOCTL(RTC_EPOCH_SET32, rtc_ioctl)
 
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
 /* dvb */
 HANDLE_IOCTL(VIDEO_GET_EVENT, do_video_get_event)
 HANDLE_IOCTL(VIDEO_STILLPICTURE, do_video_stillpicture)
Index: linux-cg/fs/ncpfs/dir.c
===================================================================
--- linux-cg.orig/fs/ncpfs/dir.c	2006-07-15 03:45:21.000000000 +0200
+++ linux-cg/fs/ncpfs/dir.c	2006-07-27 03:10:46.000000000 +0200
@@ -53,6 +53,9 @@
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
--- linux-cg.orig/fs/ncpfs/file.c	2006-04-02 23:17:08.000000000 +0200
+++ linux-cg/fs/ncpfs/file.c	2006-07-27 03:10:46.000000000 +0200
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
--- linux-cg.orig/fs/ncpfs/ioctl.c	2006-07-15 03:45:21.000000000 +0200
+++ linux-cg/fs/ncpfs/ioctl.c	2006-07-27 04:38:18.000000000 +0200
@@ -7,19 +7,21 @@
  *
  */
 
-
-#include <asm/uaccess.h>
 #include <linux/capability.h>
+#include <linux/compat.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <linux/time.h>
 #include <linux/mm.h>
 #include <linux/highuid.h>
+#include <linux/smp_lock.h>
 #include <linux/vmalloc.h>
 
 #include <linux/ncp_fs.h>
 
+#include <asm/uaccess.h>
+
 #include "ncplib_kernel.h"
 
 /* maximum limit for ncp_objectname_ioctl */
@@ -89,6 +91,82 @@
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+struct compat_ncp_objectname_ioctl
+{
+	s32		auth_type;
+	u32		object_name_len;
+	compat_caddr_t	object_name;	/* an userspace data, in most cases user name */
+};
+
+struct compat_ncp_fs_info_v2 {
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
+struct compat_ncp_ioctl_request {
+	u32 function;
+	u32 size;
+	compat_caddr_t data;
+};
+
+struct compat_ncp_privatedata_ioctl
+{
+	u32		len;
+	compat_caddr_t	data;		/* ~1000 for NDS */
+};
+
+#define NCP_IOC_GET_FS_INFO_V2_32	_IOWR('n', 4, struct compat_ncp_fs_info_v2)
+#define NCP_IOC_NCPREQUEST_32		_IOR('n', 1, struct compat_ncp_ioctl_request)
+#define NCP_IOC_GETOBJECTNAME_32	_IOWR('n', 9, struct compat_ncp_objectname_ioctl)
+#define NCP_IOC_SETOBJECTNAME_32	_IOR('n', 9, struct compat_ncp_objectname_ioctl)
+#define NCP_IOC_GETPRIVATEDATA_32	_IOWR('n', 10, struct compat_ncp_privatedata_ioctl)
+#define NCP_IOC_SETPRIVATEDATA_32	_IOR('n', 10, struct compat_ncp_privatedata_ioctl)
+
+static int
+ncp_get_compat_fs_info_v2(struct ncp_server * server, struct file *file,
+		   struct compat_ncp_fs_info_v2 __user * arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct compat_ncp_fs_info_v2 info2;
+
+	if ((file_permission(file, MAY_WRITE) != 0)
+	    && (current->uid != server->m.mounted_uid)) {
+		return -EACCES;
+	}
+	if (copy_from_user(&info2, arg, sizeof(info2)))
+		return -EFAULT;
+
+	if (info2.version != NCP_GET_FS_INFO_VERSION_V2) {
+		DPRINTK("info.version invalid: %d\n", info2.version);
+		return -EINVAL;
+	}
+	info2.mounted_uid   = server->m.mounted_uid;
+	info2.connection    = server->connection;
+	info2.buffer_size   = server->buffer_size;
+	info2.volume_number = NCP_FINFO(inode)->volNumber;
+	info2.directory_id  = NCP_FINFO(inode)->DosDirNum;
+	info2.dummy1 = info2.dummy2 = info2.dummy3 = 0;
+
+	if (copy_to_user(arg, &info2, sizeof(info2)))
+		return -EFAULT;
+	return 0;
+}
+#endif
+
+#define NCP_IOC_GETMOUNTUID16		_IOW('n', 2, u16)
+#define NCP_IOC_GETMOUNTUID32		_IOW('n', 2, u32)
+#define NCP_IOC_GETMOUNTUID64		_IOW('n', 2, u64)
+
 #ifdef CONFIG_NCPFS_NLS
 /* Here we are select the iocharset and the codepage for NLS.
  * Thanks Petr Vandrovec for idea and many hints.
@@ -192,14 +270,27 @@
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
+#ifdef CONFIG_COMPAT
+	case NCP_IOC_NCPREQUEST_32:
+#endif
 	case NCP_IOC_NCPREQUEST:
-
 		if ((file_permission(filp, MAY_WRITE) != 0)
 		    && (current->uid != server->m.mounted_uid)) {
 			return -EACCES;
 		}
-		if (copy_from_user(&request, argp, sizeof(request)))
-			return -EFAULT;
+		if (cmd == NCP_IOC_NCPREQUEST) {
+			if (copy_from_user(&request, argp, sizeof(request)))
+				return -EFAULT;
+		} else {
+#ifdef CONFIG_COMPAT
+			struct compat_ncp_ioctl_request request32;
+			if (copy_from_user(&request32, argp, sizeof(request32)))
+				return -EFAULT;
+			request.function = request32.function;
+			request.size = request32.size;
+			request.data = compat_ptr(request32.data);
+#endif
+		}
 
 		if ((request.function > 255)
 		    || (request.size >
@@ -254,19 +345,35 @@
 	case NCP_IOC_GET_FS_INFO_V2:
 		return ncp_get_fs_info_v2(server, filp, argp);
 
-	case NCP_IOC_GETMOUNTUID2:
-		{
-			unsigned long tmp = server->m.mounted_uid;
-
-			if ((file_permission(filp, MAY_READ) != 0)
-			    && (current->uid != server->m.mounted_uid))
-			{
-				return -EACCES;
-			}
-			if (put_user(tmp, (unsigned long __user *)argp)) 
+#ifdef CONFIG_COMPAT
+	case NCP_IOC_GET_FS_INFO_V2_32:
+		return ncp_get_compat_fs_info_v2(server, filp, argp);
+#endif
+	/* we have too many combinations of CONFIG_COMPAT,
+	 * CONFIG_64BIT and CONFIG_UID16, so just handle
+	 * any of the possible ioctls */
+	case NCP_IOC_GETMOUNTUID16:
+	case NCP_IOC_GETMOUNTUID32:
+	case NCP_IOC_GETMOUNTUID64:
+		if ((file_permission(filp, MAY_READ) != 0)
+			&& (current->uid != server->m.mounted_uid)) {
+			return -EACCES;
+		}
+		if (cmd == NCP_IOC_GETMOUNTUID16) {
+			u16 uid;
+			SET_UID(uid, server->m.mounted_uid);
+			if (put_user(uid, (u16 __user *)argp))
+				return -EFAULT;
+		} else if (cmd == NCP_IOC_GETMOUNTUID32) {
+			if (put_user(server->m.mounted_uid,
+						(u32 __user *)argp))
+				return -EFAULT;
+		} else {
+			if (put_user(server->m.mounted_uid,
+						(u64 __user *)argp))
 				return -EFAULT;
-			return 0;
 		}
+		return 0;
 
 	case NCP_IOC_GETROOT:
 		{
@@ -476,6 +583,32 @@
 		}
 #endif	/* CONFIG_NCPFS_IOCTL_LOCKING */
 
+#ifdef CONFIG_COMPAT
+	case NCP_IOC_GETOBJECTNAME_32:
+		if (current->uid != server->m.mounted_uid) {
+			return -EACCES;
+		}
+		{
+			struct compat_ncp_objectname_ioctl user;
+			size_t outl;
+
+			if (copy_from_user(&user, argp, sizeof(user)))
+				return -EFAULT;
+			user.auth_type = server->auth.auth_type;
+			outl = user.object_name_len;
+			user.object_name_len = server->auth.object_name_len;
+			if (outl > user.object_name_len)
+				outl = user.object_name_len;
+			if (outl) {
+				if (copy_to_user(compat_ptr(user.object_name),
+						 server->auth.object_name,
+						 outl)) return -EFAULT;
+			}
+			if (copy_to_user(argp, &user, sizeof(user)))
+				return -EFAULT;
+			return 0;
+		}
+#endif
 	case NCP_IOC_GETOBJECTNAME:
 		if (current->uid != server->m.mounted_uid) {
 			return -EACCES;
@@ -500,6 +633,9 @@
 				return -EFAULT;
 			return 0;
 		}
+#ifdef CONFIG_COMPAT
+	case NCP_IOC_SETOBJECTNAME_32:
+#endif
 	case NCP_IOC_SETOBJECTNAME:
 		if (current->uid != server->m.mounted_uid) {
 			return -EACCES;
@@ -512,8 +648,19 @@
 			void* oldprivate;
 			size_t oldprivatelen;
 
-			if (copy_from_user(&user, argp, sizeof(user)))
-				return -EFAULT;
+			if (cmd == NCP_IOC_SETOBJECTNAME) {
+				if (copy_from_user(&user, argp, sizeof(user)))
+					return -EFAULT;
+			} else {
+#ifdef CONFIG_COMPAT
+				struct compat_ncp_objectname_ioctl user32;
+				if (copy_from_user(&user32, argp, sizeof(user32)))
+					return -EFAULT;
+				user.auth_type = user32.auth_type;
+				user.object_name_len = user32.object_name_len;
+				user.object_name = compat_ptr(user32.object_name);
+#endif
+			}
 			if (user.object_name_len > NCP_OBJECT_NAME_MAX_LEN)
 				return -ENOMEM;
 			if (user.object_name_len) {
@@ -544,6 +691,9 @@
 			kfree(oldname);
 			return 0;
 		}
+#ifdef CONFIG_COMPAT
+	case NCP_IOC_GETPRIVATEDATA_32:
+#endif
 	case NCP_IOC_GETPRIVATEDATA:
 		if (current->uid != server->m.mounted_uid) {
 			return -EACCES;
@@ -552,8 +702,18 @@
 			struct ncp_privatedata_ioctl user;
 			size_t outl;
 
-			if (copy_from_user(&user, argp, sizeof(user)))
-				return -EFAULT;
+			if (cmd == NCP_IOC_GETPRIVATEDATA) {
+				if (copy_from_user(&user, argp, sizeof(user)))
+					return -EFAULT;
+			} else {
+#ifdef CONFIG_COMPAT
+				struct compat_ncp_privatedata_ioctl user32;
+				if (copy_from_user(&user32, argp, sizeof(user32)))
+					return -EFAULT;
+				user.len = user32.len;
+				user.data = compat_ptr(user32.data);
+#endif
+			}
 			outl = user.len;
 			user.len = server->priv.len;
 			if (outl > user.len) outl = user.len;
@@ -562,10 +722,23 @@
 						 server->priv.data,
 						 outl)) return -EFAULT;
 			}
-			if (copy_to_user(argp, &user, sizeof(user)))
-				return -EFAULT;
+			if (cmd == NCP_IOC_GETPRIVATEDATA) {
+				if (copy_to_user(argp, &user, sizeof(user)))
+					return -EFAULT;
+			} else {
+#ifdef CONFIG_COMPAT
+				struct compat_ncp_privatedata_ioctl user32;
+				user32.len = user.len;
+				user32.data = (unsigned long) user.data;
+				if (copy_to_user(&user32, argp, sizeof(user32)))
+					return -EFAULT;
+#endif
+			}
 			return 0;
 		}
+#ifdef CONFIG_COMPAT
+	case NCP_IOC_SETPRIVATEDATA_32:
+#endif
 	case NCP_IOC_SETPRIVATEDATA:
 		if (current->uid != server->m.mounted_uid) {
 			return -EACCES;
@@ -576,8 +749,18 @@
 			void* old;
 			size_t oldlen;
 
-			if (copy_from_user(&user, argp, sizeof(user)))
-				return -EFAULT;
+			if (cmd == NCP_IOC_SETPRIVATEDATA) {
+				if (copy_from_user(&user, argp, sizeof(user)))
+					return -EFAULT;
+			} else {
+#ifdef CONFIG_COMPAT
+				struct compat_ncp_privatedata_ioctl user32;
+				if (copy_from_user(&user32, argp, sizeof(user32)))
+					return -EFAULT;
+				user.len = user32.len;
+				user.data = compat_ptr(user32.data);
+#endif
+			}
 			if (user.len > NCP_PRIVATE_DATA_MAX_LEN)
 				return -ENOMEM;
 			if (user.len) {
@@ -636,20 +819,19 @@
 		}
 
 	}
-/* #ifdef CONFIG_UID16 */
-	/* NCP_IOC_GETMOUNTUID may be same as NCP_IOC_GETMOUNTUID2,
-           so we have this out of switch */
-	if (cmd == NCP_IOC_GETMOUNTUID) {
-		__kernel_uid_t uid = 0;
-		if ((file_permission(filp, MAY_READ) != 0)
-		    && (current->uid != server->m.mounted_uid)) {
-			return -EACCES;
-		}
-		SET_UID(uid, server->m.mounted_uid);
-		if (put_user(uid, (__kernel_uid_t __user *)argp))
-			return -EFAULT;
-		return 0;
-	}
-/* #endif */
 	return -EINVAL;
 }
+
+#ifdef CONFIG_COMPAT
+long ncp_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret;
+
+	lock_kernel();
+	arg = (unsigned long) compat_ptr(arg);
+	ret = ncp_ioctl(inode, file, cmd, arg);
+	unlock_kernel();
+	return ret;
+}
+#endif
Index: linux-cg/include/linux/ncp_fs.h
===================================================================
--- linux-cg.orig/include/linux/ncp_fs.h	2006-06-21 01:19:20.000000000 +0200
+++ linux-cg/include/linux/ncp_fs.h	2006-07-27 03:10:46.000000000 +0200
@@ -215,6 +215,7 @@
 
 /* linux/fs/ncpfs/ioctl.c */
 int ncp_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+long ncp_compat_ioctl(struct file *, unsigned int, unsigned long);
 
 /* linux/fs/ncpfs/sock.c */
 int ncp_request2(struct ncp_server *server, int function,
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2006-07-15 03:45:22.000000000 +0200
+++ linux-cg/include/linux/compat_ioctl.h	2006-07-27 03:15:19.000000000 +0200
@@ -572,18 +572,6 @@
 COMPATIBLE_IOCTL(RAW_GETBIND)
 /* SMB ioctls which do not need any translations */
 COMPATIBLE_IOCTL(SMB_IOC_NEWCONN)
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
