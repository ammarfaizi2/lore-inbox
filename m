Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbVKEQfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbVKEQfc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVKEQev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:13260 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932117AbVKEQej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:39 -0500
Message-Id: <20051105162718.406210000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:09 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, gregkh@suse.de,
       linux-usb-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 19/25] usbdevfs: move ioctl32 into devio.c
Content-Disposition: inline; filename=usbdevfs-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

usbdevfs already has support for some compat ioctl code
by handling it directly in its ioctl function and marking
the numbers as compatible.

This patch moves over all remaining conversion handlers
to the same file into a new compat_ioctl function.
It should be further unified with the existing ioctl
implementation in the future.

CC: gregkh@suse.de
CC: linux-usb-devel@lists.sourceforge.net
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/usb/core/devio.c
===================================================================
--- linux-cg.orig/drivers/usb/core/devio.c	2005-11-05 15:46:57.000000000 +0100
+++ linux-cg/drivers/usb/core/devio.c	2005-11-05 16:16:06.000000000 +0100
@@ -1392,7 +1392,7 @@
 }
 
 #ifdef CONFIG_COMPAT
-static int proc_ioctl_compat(struct dev_state *ps, void __user *arg)
+static int proc_ioctl_compat(struct dev_state *ps, unsigned long arg)
 {
 	struct usbdevfs_ioctl32 __user *uioc;
 	struct usbdevfs_ioctl ctrl;
@@ -1511,7 +1511,7 @@
 
 	case USBDEVFS_IOCTL32:
 		snoop(&dev->dev, "%s: IOCTL\n", __FUNCTION__);
-		ret = proc_ioctl_compat(ps, p);
+		ret = proc_ioctl_compat(ps, arg);
 		break;
 #endif
 
@@ -1556,6 +1556,138 @@
 	return ret;
 }
 
+#ifdef CONFIG_COMPAT
+/* FIXME: put the conversion handlers into usbdev_ioctl() */
+
+struct usbdevfs_ctrltransfer32 {
+	u8 bRequestType;
+	u8 bRequest;
+	u16 wValue;
+	u16 wIndex;
+	u16 wLength;
+	u32 timeout;		/* in milliseconds */
+	compat_caddr_t data;
+};
+
+#define USBDEVFS_CONTROL32           _IOWR('U', 0, struct usbdevfs_ctrltransfer32)
+
+static int do_usbdevfs_control(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	struct usbdevfs_ctrltransfer32 __user *p32 = compat_ptr(arg);
+	struct usbdevfs_ctrltransfer __user *p;
+	__u32 udata;
+	p = compat_alloc_user_space(sizeof(*p));
+	if (copy_in_user(p, p32, (sizeof(*p32) - sizeof(compat_caddr_t)))
+	    || get_user(udata, &p32->data)
+	    || put_user(compat_ptr(udata), &p->data))
+		return -EFAULT;
+	return usbdev_ioctl(inode, file, USBDEVFS_CONTROL, (unsigned long) p);
+}
+
+struct usbdevfs_bulktransfer32 {
+	compat_uint_t ep;
+	compat_uint_t len;
+	compat_uint_t timeout;	/* in milliseconds */
+	compat_caddr_t data;
+};
+
+#define USBDEVFS_BULK32              _IOWR('U', 2, struct usbdevfs_bulktransfer32)
+
+static int do_usbdevfs_bulk(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	struct usbdevfs_bulktransfer32 __user *p32 = compat_ptr(arg);
+	struct usbdevfs_bulktransfer __user *p;
+	compat_uint_t n;
+	compat_caddr_t addr;
+
+	p = compat_alloc_user_space(sizeof(*p));
+
+	if (get_user(n, &p32->ep) || put_user(n, &p->ep) ||
+	    get_user(n, &p32->len) || put_user(n, &p->len) ||
+	    get_user(n, &p32->timeout) || put_user(n, &p->timeout) ||
+	    get_user(addr, &p32->data)
+	    || put_user(compat_ptr(addr), &p->data))
+		return -EFAULT;
+
+	return usbdev_ioctl(inode, file, USBDEVFS_BULK, (unsigned long) p);
+}
+
+struct usbdevfs_disconnectsignal32 {
+	compat_int_t signr;
+	compat_caddr_t context;
+};
+
+#define USBDEVFS_DISCSIGNAL32      _IOR('U', 14, struct usbdevfs_disconnectsignal32)
+
+static int do_usbdevfs_discsignal(struct inode *inode, struct file *file,
+					unsigned int cmd, unsigned long arg)
+{
+	struct usbdevfs_disconnectsignal kdis;
+	struct usbdevfs_disconnectsignal32 __user *udis;
+	mm_segment_t old_fs;
+	u32 uctx;
+	int err;
+
+	udis = compat_ptr(arg);
+
+	if (get_user(kdis.signr, &udis->signr) ||
+	    __get_user(uctx, &udis->context))
+		return -EFAULT;
+
+	kdis.context = compat_ptr(uctx);
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = usbdev_ioctl(inode, file, USBDEVFS_DISCSIGNAL, (unsigned long) &kdis);
+	set_fs(old_fs);
+
+	return err;
+}
+
+static long
+usbdev_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret = -ENOIOCTLCMD;
+
+	lock_kernel();
+	switch (cmd) {
+	case USBDEVFS_CONTROL32:
+		ret = do_usbdevfs_control(inode, file, cmd, arg);
+		break;
+	case USBDEVFS_BULK32:
+		ret = do_usbdevfs_bulk(inode, file, cmd, arg);
+		break;
+	case USBDEVFS_DISCSIGNAL32:
+		ret = do_usbdevfs_discsignal(inode, file, cmd, arg);
+		break;
+	case USBDEVFS_RESETEP:
+	case USBDEVFS_SETINTERFACE:
+	case USBDEVFS_SETCONFIGURATION:
+	case USBDEVFS_GETDRIVER:
+	case USBDEVFS_DISCARDURB:
+	case USBDEVFS_CLAIMINTERFACE:
+	case USBDEVFS_RELEASEINTERFACE:
+	case USBDEVFS_CONNECTINFO:
+	case USBDEVFS_HUB_PORTINFO:
+	case USBDEVFS_RESET:
+	case USBDEVFS_SUBMITURB32:
+	case USBDEVFS_REAPURB32:
+	case USBDEVFS_REAPURBNDELAY32:
+	case USBDEVFS_IOCTL32:
+	case USBDEVFS_CLEAR_HALT:
+		arg = (unsigned long) compat_ptr(arg);
+		ret = usbdev_ioctl(inode, file, cmd, arg);
+		break;
+	}
+	unlock_kernel();
+	return ret;
+}
+#endif
+
+
 /* No kernel lock - fine */
 static unsigned int usbdev_poll(struct file *file, struct poll_table_struct *wait)
 {
@@ -1575,6 +1707,9 @@
 	.read =		usbdev_read,
 	.poll =		usbdev_poll,
 	.ioctl =	usbdev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = usbdev_compat_ioctl,
+#endif
 	.open =		usbdev_open,
 	.release =	usbdev_release,
 };
Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 15:48:02.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 16:44:00.000000000 +0100
@@ -427,96 +427,6 @@
         return err;
 }
 
-struct usbdevfs_ctrltransfer32 {
-        u8 bRequestType;
-        u8 bRequest;
-        u16 wValue;
-        u16 wIndex;
-        u16 wLength;
-        u32 timeout;  /* in milliseconds */
-        compat_caddr_t data;
-};
-
-#define USBDEVFS_CONTROL32           _IOWR('U', 0, struct usbdevfs_ctrltransfer32)
-
-static int do_usbdevfs_control(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-        struct usbdevfs_ctrltransfer32 __user *p32 = compat_ptr(arg);
-        struct usbdevfs_ctrltransfer __user *p;
-        __u32 udata;
-        p = compat_alloc_user_space(sizeof(*p));
-        if (copy_in_user(p, p32, (sizeof(*p32) - sizeof(compat_caddr_t))) ||
-            get_user(udata, &p32->data) ||
-	    put_user(compat_ptr(udata), &p->data))
-		return -EFAULT;
-        return sys_ioctl(fd, USBDEVFS_CONTROL, (unsigned long)p);
-}
-
-
-struct usbdevfs_bulktransfer32 {
-        compat_uint_t ep;
-        compat_uint_t len;
-        compat_uint_t timeout; /* in milliseconds */
-        compat_caddr_t data;
-};
-
-#define USBDEVFS_BULK32              _IOWR('U', 2, struct usbdevfs_bulktransfer32)
-
-static int do_usbdevfs_bulk(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-        struct usbdevfs_bulktransfer32 __user *p32 = compat_ptr(arg);
-        struct usbdevfs_bulktransfer __user *p;
-        compat_uint_t n;
-        compat_caddr_t addr;
-
-        p = compat_alloc_user_space(sizeof(*p));
-
-        if (get_user(n, &p32->ep) || put_user(n, &p->ep) ||
-            get_user(n, &p32->len) || put_user(n, &p->len) ||
-            get_user(n, &p32->timeout) || put_user(n, &p->timeout) ||
-            get_user(addr, &p32->data) || put_user(compat_ptr(addr), &p->data))
-                return -EFAULT;
-
-        return sys_ioctl(fd, USBDEVFS_BULK, (unsigned long)p);
-}
-
-
-/*
- *  USBDEVFS_SUBMITURB, USBDEVFS_REAPURB and USBDEVFS_REAPURBNDELAY
- *  are handled in usbdevfs core.			-Christopher Li
- */
-
-struct usbdevfs_disconnectsignal32 {
-        compat_int_t signr;
-        compat_caddr_t context;
-};
-
-#define USBDEVFS_DISCSIGNAL32      _IOR('U', 14, struct usbdevfs_disconnectsignal32)
-
-static int do_usbdevfs_discsignal(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-        struct usbdevfs_disconnectsignal kdis;
-        struct usbdevfs_disconnectsignal32 __user *udis;
-        mm_segment_t old_fs;
-        u32 uctx;
-        int err;
-
-        udis = compat_ptr(arg);
-
-        if (get_user(kdis.signr, &udis->signr) ||
-            __get_user(uctx, &udis->context))
-                return -EFAULT;
-
-        kdis.context = compat_ptr(uctx);
-
-        old_fs = get_fs();
-        set_fs(KERNEL_DS);
-        err = sys_ioctl(fd, USBDEVFS_DISCSIGNAL, (unsigned long) &kdis);
-        set_fs(old_fs);
-
-        return err;
-}
-
 /*
  * I2C layer ioctls
  */
@@ -624,11 +534,6 @@
 COMPATIBLE_IOCTL(TIOCGLTC)
 COMPATIBLE_IOCTL(TIOCSLTC)
 #endif
-/* Usbdevfs */
-HANDLE_IOCTL(USBDEVFS_CONTROL32, do_usbdevfs_control)
-HANDLE_IOCTL(USBDEVFS_BULK32, do_usbdevfs_bulk)
-HANDLE_IOCTL(USBDEVFS_DISCSIGNAL32, do_usbdevfs_discsignal)
-COMPATIBLE_IOCTL(USBDEVFS_IOCTL32)
 /* i2c */
 HANDLE_IOCTL(I2C_FUNCS, w_long)
 HANDLE_IOCTL(I2C_RDWR, do_i2c_rdwr_ioctl)
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 15:48:02.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 16:44:00.000000000 +0100
@@ -456,21 +456,6 @@
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* USB */
-COMPATIBLE_IOCTL(USBDEVFS_RESETEP)
-COMPATIBLE_IOCTL(USBDEVFS_SETINTERFACE)
-COMPATIBLE_IOCTL(USBDEVFS_SETCONFIGURATION)
-COMPATIBLE_IOCTL(USBDEVFS_GETDRIVER)
-COMPATIBLE_IOCTL(USBDEVFS_DISCARDURB)
-COMPATIBLE_IOCTL(USBDEVFS_CLAIMINTERFACE)
-COMPATIBLE_IOCTL(USBDEVFS_RELEASEINTERFACE)
-COMPATIBLE_IOCTL(USBDEVFS_CONNECTINFO)
-COMPATIBLE_IOCTL(USBDEVFS_HUB_PORTINFO)
-COMPATIBLE_IOCTL(USBDEVFS_RESET)
-COMPATIBLE_IOCTL(USBDEVFS_SUBMITURB32)
-COMPATIBLE_IOCTL(USBDEVFS_REAPURB32)
-COMPATIBLE_IOCTL(USBDEVFS_REAPURBNDELAY32)
-COMPATIBLE_IOCTL(USBDEVFS_CLEAR_HALT)
 /* NBD */
 ULONG_IOCTL(NBD_SET_SOCK)
 ULONG_IOCTL(NBD_SET_BLKSIZE)

--

