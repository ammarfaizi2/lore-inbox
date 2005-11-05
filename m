Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbVKEQev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbVKEQev (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbVKEQet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:11206 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932104AbVKEQeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:24 -0500
Message-Id: <20051105162712.645517000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:55 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-ppp@vger.kernel.org,
       netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 05/25] net: move ppp specific ioctl32 handlers
Content-Disposition: inline; filename=ppp-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This moves all ioctl32 code for ppp close to the
native ioctl implementation.

CC: linux-ppp@vger.kernel.org
CC: netdev@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/drivers/net/ppp_generic.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/net/ppp_generic.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/drivers/net/ppp_generic.c	2005-11-05 02:41:29.000000000 +0100
@@ -46,6 +46,8 @@
 #include <linux/rwsem.h>
 #include <linux/stddef.h>
 #include <linux/device.h>
+#include <linux/compat.h>
+
 #include <net/slhc_vj.h>
 #include <asm/atomic.h>
 
@@ -837,12 +839,189 @@
 	return err;
 }
 
+#ifdef CONFIG_COMPAT
+/* FIXME: These could be better integrated into the driver */
+
+struct sock_fprog32 {
+	unsigned short	len;
+	compat_caddr_t	filter;
+};
+
+#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
+#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
+
+static int ppp_sock_fprog_ioctl_trans(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct sock_fprog32 __user *u_fprog32 = compat_ptr(arg);
+	struct sock_fprog __user *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
+	void __user *fptr64;
+	u32 fptr32;
+	u16 flen;
+
+	if (get_user(flen, &u_fprog32->len) ||
+	    get_user(fptr32, &u_fprog32->filter))
+		return -EFAULT;
+
+	fptr64 = compat_ptr(fptr32);
+
+	if (put_user(flen, &u_fprog64->len) ||
+	    put_user(fptr64, &u_fprog64->filter))
+		return -EFAULT;
+
+	if (cmd == PPPIOCSPASS32)
+		cmd = PPPIOCSPASS;
+	else
+		cmd = PPPIOCSACTIVE;
+
+	return ppp_ioctl(file->f_dentry->d_inode, file, cmd,
+			 (unsigned long) u_fprog64);
+}
+
+struct ppp_option_data32 {
+	compat_caddr_t	ptr;
+	u32		length;
+	compat_int_t	transmit;
+};
+#define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
+
+struct ppp_idle32 {
+	compat_time_t xmit_idle;
+	compat_time_t recv_idle;
+};
+#define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
+
+static int ppp_gidle(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ppp_idle __user *idle;
+	struct ppp_idle32 __user *idle32;
+	__kernel_time_t xmit, recv;
+	int err;
+
+	idle = compat_alloc_user_space(sizeof(*idle));
+	idle32 = compat_ptr(arg);
+
+	err = ppp_ioctl(file->f_dentry->d_inode, file, PPPIOCGIDLE, (unsigned long) idle);
+
+	if (!err) {
+		if (get_user(xmit, &idle->xmit_idle) ||
+		    get_user(recv, &idle->recv_idle) ||
+		    put_user(xmit, &idle32->xmit_idle) ||
+		    put_user(recv, &idle32->recv_idle))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int ppp_scompress(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct ppp_option_data __user *odata;
+	struct ppp_option_data32 __user *odata32;
+	__u32 data;
+	void __user *datap;
+
+	odata = compat_alloc_user_space(sizeof(*odata));
+	odata32 = compat_ptr(arg);
+
+	if (get_user(data, &odata32->ptr))
+		return -EFAULT;
+
+	datap = compat_ptr(data);
+	if (put_user(datap, &odata->ptr))
+		return -EFAULT;
+
+	if (copy_in_user(&odata->length, &odata32->length,
+			 sizeof(__u32) + sizeof(int)))
+		return -EFAULT;
+
+	return ppp_ioctl(file->f_dentry->d_inode, file, PPPIOCSCOMPRESS, (unsigned long) odata);
+}
+
+static int ppp_ioctl_trans(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int err;
+
+	switch (cmd) {
+	case PPPIOCGIDLE32:
+		err = ppp_gidle(file, cmd, arg);
+		break;
+
+	case PPPIOCSCOMPRESS32:
+		err = ppp_scompress(file, cmd, arg);
+		break;
+
+	default:
+		do {
+			static int count;
+			if (++count <= 20)
+				printk("ppp_ioctl: Unknown cmd(%08x) arg(%08x)\n",
+				       (unsigned int)cmd, (unsigned int)arg);
+		} while(0);
+		err = -EINVAL;
+		break;
+	};
+
+	return err;
+}
+
+static long ppp_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int ret;
+	ret = -ENOIOCTLCMD;
+
+	lock_kernel();
+	switch (cmd) {
+	case PPPIOCGIDLE32:
+	case PPPIOCSCOMPRESS32:
+		ret = ppp_ioctl_trans(file, cmd, arg);
+		break;
+
+	case PPPIOCSPASS32:
+	case PPPIOCSACTIVE32:
+		ret = ppp_sock_fprog_ioctl_trans(file, cmd, arg);
+		break;
+
+	case PPPIOCGFLAGS:
+	case PPPIOCSFLAGS:
+	case PPPIOCGASYNCMAP:
+	case PPPIOCSASYNCMAP:
+	case PPPIOCGUNIT:
+	case PPPIOCGRASYNCMAP:
+	case PPPIOCSRASYNCMAP:
+	case PPPIOCGMRU:
+	case PPPIOCSMRU:
+	case PPPIOCSMAXCID:
+	case PPPIOCGXASYNCMAP:
+	case PPPIOCSXASYNCMAP:
+	case PPPIOCXFERUNIT:
+	case PPPIOCGNPMODE:
+	case PPPIOCSNPMODE:
+	case PPPIOCGDEBUG:
+	case PPPIOCSDEBUG:
+	case PPPIOCNEWUNIT:
+	case PPPIOCATTACH:
+	case PPPIOCDETACH:
+	case PPPIOCSMRRU:
+	case PPPIOCCONNECT:
+	case PPPIOCDISCONN:
+	case PPPIOCATTCHAN:
+	case PPPIOCGCHAN:
+		ret = ppp_ioctl(file->f_dentry->d_inode, file, cmd, arg);
+		break;
+	}
+	unlock_kernel();
+	return ret;
+}
+#endif
+
 static struct file_operations ppp_device_fops = {
 	.owner		= THIS_MODULE,
 	.read		= ppp_read,
 	.write		= ppp_write,
 	.poll		= ppp_poll,
 	.ioctl		= ppp_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= ppp_compat_ioctl,
+#endif
 	.open		= ppp_open,
 	.release	= ppp_release
 };
Index: linux-2.6.14-rc/net/compat.c
===================================================================
--- linux-2.6.14-rc.orig/net/compat.c	2005-11-05 02:41:28.000000000 +0100
+++ linux-2.6.14-rc/net/compat.c	2005-11-05 02:41:29.000000000 +0100
@@ -1016,126 +1016,6 @@
 	return ret;
 }
 
-struct sock_fprog32 {
-	unsigned short	len;
-	compat_caddr_t	filter;
-};
-
-#define PPPIOCSPASS32	_IOW('t', 71, struct sock_fprog32)
-#define PPPIOCSACTIVE32	_IOW('t', 70, struct sock_fprog32)
-
-static int ppp_sock_fprog_ioctl_trans(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct sock_fprog32 __user *u_fprog32 = compat_ptr(arg);
-	struct sock_fprog __user *u_fprog64 = compat_alloc_user_space(sizeof(struct sock_fprog));
-	void __user *fptr64;
-	u32 fptr32;
-	u16 flen;
-
-	if (get_user(flen, &u_fprog32->len) ||
-	    get_user(fptr32, &u_fprog32->filter))
-		return -EFAULT;
-
-	fptr64 = compat_ptr(fptr32);
-
-	if (put_user(flen, &u_fprog64->len) ||
-	    put_user(fptr64, &u_fprog64->filter))
-		return -EFAULT;
-
-	if (cmd == PPPIOCSPASS32)
-		cmd = PPPIOCSPASS;
-	else
-		cmd = PPPIOCSACTIVE;
-
-	return sock_ioctl(file, cmd, (unsigned long) u_fprog64);
-}
-
-struct ppp_option_data32 {
-	compat_caddr_t	ptr;
-	u32			length;
-	compat_int_t		transmit;
-};
-#define PPPIOCSCOMPRESS32	_IOW('t', 77, struct ppp_option_data32)
-
-struct ppp_idle32 {
-	compat_time_t xmit_idle;
-	compat_time_t recv_idle;
-};
-#define PPPIOCGIDLE32		_IOR('t', 63, struct ppp_idle32)
-
-static int ppp_gidle(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct ppp_idle __user *idle;
-	struct ppp_idle32 __user *idle32;
-	__kernel_time_t xmit, recv;
-	int err;
-
-	idle = compat_alloc_user_space(sizeof(*idle));
-	idle32 = compat_ptr(arg);
-
-	err = sock_ioctl(file, PPPIOCGIDLE, (unsigned long) idle);
-
-	if (!err) {
-		if (get_user(xmit, &idle->xmit_idle) ||
-		    get_user(recv, &idle->recv_idle) ||
-		    put_user(xmit, &idle32->xmit_idle) ||
-		    put_user(recv, &idle32->recv_idle))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int ppp_scompress(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct ppp_option_data __user *odata;
-	struct ppp_option_data32 __user *odata32;
-	__u32 data;
-	void __user *datap;
-
-	odata = compat_alloc_user_space(sizeof(*odata));
-	odata32 = compat_ptr(arg);
-
-	if (get_user(data, &odata32->ptr))
-		return -EFAULT;
-
-	datap = compat_ptr(data);
-	if (put_user(datap, &odata->ptr))
-		return -EFAULT;
-
-	if (copy_in_user(&odata->length, &odata32->length,
-			 sizeof(__u32) + sizeof(int)))
-		return -EFAULT;
-
-	return sock_ioctl(file, PPPIOCSCOMPRESS, (unsigned long) odata);
-}
-
-static int ppp_ioctl_trans(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	int err;
-
-	switch (cmd) {
-	case PPPIOCGIDLE32:
-		err = ppp_gidle(file, cmd, arg);
-		break;
-
-	case PPPIOCSCOMPRESS32:
-		err = ppp_scompress(file, cmd, arg);
-		break;
-
-	default:
-		do {
-			static int count;
-			if (++count <= 20)
-				printk("ppp_ioctl: Unknown cmd(%08x) arg(%08x)\n",
-				       (unsigned int)cmd, (unsigned int)arg);
-		} while(0);
-		err = -EINVAL;
-		break;
-	};
-
-	return err;
-}
-
 #ifdef WIRELESS_EXT
 struct compat_iw_point {
 	compat_caddr_t pointer;
@@ -1283,40 +1163,6 @@
 /* Note SIOCRTMSG is no longer, so this is safe and * the user would have seen just an -EINVAL anyways. */
 INVAL_IOCTL(SIOCRTMSG)
 HANDLE_IOCTL(SIOCGSTAMP, do_siocgstamp)
-/* ppp */
-HANDLE_IOCTL(PPPIOCGIDLE32, ppp_ioctl_trans)
-HANDLE_IOCTL(PPPIOCSCOMPRESS32, ppp_ioctl_trans)
-HANDLE_IOCTL(PPPIOCSPASS32, ppp_sock_fprog_ioctl_trans)
-HANDLE_IOCTL(PPPIOCSACTIVE32, ppp_sock_fprog_ioctl_trans)
-COMPATIBLE_IOCTL(PPPIOCGFLAGS)
-COMPATIBLE_IOCTL(PPPIOCSFLAGS)
-COMPATIBLE_IOCTL(PPPIOCGASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCGUNIT)
-COMPATIBLE_IOCTL(PPPIOCGRASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSRASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCGMRU)
-COMPATIBLE_IOCTL(PPPIOCSMRU)
-COMPATIBLE_IOCTL(PPPIOCSMAXCID)
-COMPATIBLE_IOCTL(PPPIOCGXASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCSXASYNCMAP)
-COMPATIBLE_IOCTL(PPPIOCXFERUNIT)
-/* PPPIOCSCOMPRESS is translated */
-COMPATIBLE_IOCTL(PPPIOCGNPMODE)
-COMPATIBLE_IOCTL(PPPIOCSNPMODE)
-COMPATIBLE_IOCTL(PPPIOCGDEBUG)
-COMPATIBLE_IOCTL(PPPIOCSDEBUG)
-/* PPPIOCSPASS is translated */
-/* PPPIOCSACTIVE is translated */
-/* PPPIOCGIDLE is translated */
-COMPATIBLE_IOCTL(PPPIOCNEWUNIT)
-COMPATIBLE_IOCTL(PPPIOCATTACH)
-COMPATIBLE_IOCTL(PPPIOCDETACH)
-COMPATIBLE_IOCTL(PPPIOCSMRRU)
-COMPATIBLE_IOCTL(PPPIOCCONNECT)
-COMPATIBLE_IOCTL(PPPIOCDISCONN)
-COMPATIBLE_IOCTL(PPPIOCATTCHAN)
-COMPATIBLE_IOCTL(PPPIOCGCHAN)
 /* PPPOX */
 COMPATIBLE_IOCTL(PPPOEIOCSFWD)
 COMPATIBLE_IOCTL(PPPOEIOCDFWD)

--

