Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVKEQek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVKEQek (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbVKEQej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:39 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:6601 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932111AbVKEQeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:36 -0500
Message-Id: <20051105162718.794133000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:10 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, khali@linux-fr.org,
       lm-sensors@lm-sensors.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 20/25] i2c: move ioctl32 code to i2c-dev.c
Content-Disposition: inline; filename=i2c-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The conversion functions for i2c ioctl commands are
all related to code in i2cdev_ioctl, so introduce
move the conversion to a new i2cdev_compat_ioctl function
in the same file.

These can probably be improved by not using
compat_alloc_user_space.

In order to support I2C_SREAD, it might be necessary to
introduce a compat_algo_control method for i2c devices.

CC: khali@linux-fr.org
CC: lm-sensors@lm-sensors.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/drivers/i2c/i2c-dev.c
===================================================================
--- linux-cg.orig/drivers/i2c/i2c-dev.c	2005-11-05 14:02:26.000000000 +0100
+++ linux-cg/drivers/i2c/i2c-dev.c	2005-11-05 14:31:35.000000000 +0100
@@ -26,6 +26,8 @@
 
 /* The I2C_RDWR ioctl code is written by Kolja Waschk <waschk@telos.de> */
 
+#include <linux/config.h>
+#include <linux/compat.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/fs.h>
@@ -358,6 +360,142 @@
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+struct i2c_msg32 {
+	u16 addr;
+	u16 flags;
+	u16 len;
+	compat_caddr_t buf;
+};
+
+struct i2c_rdwr_ioctl_data32 {
+	compat_caddr_t msgs; /* struct i2c_msg __user *msgs */
+	u32 nmsgs;
+};
+
+struct i2c_smbus_ioctl_data32 {
+	u8 read_write;
+	u8 command;
+	u32 size;
+	compat_caddr_t data; /* union i2c_smbus_data *data */
+};
+
+struct i2c_rdwr_aligned {
+	struct i2c_rdwr_ioctl_data cmd;
+	struct i2c_msg msgs[0];
+};
+
+static int do_i2c_w_long(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	int err;
+	unsigned long val;
+
+	set_fs (KERNEL_DS);
+	err = i2cdev_ioctl(inode, file, cmd, (unsigned long)&val);
+	set_fs (old_fs);
+	if (!err && put_user(val, (u32 __user *)compat_ptr(arg)))
+		return -EFAULT;
+	return err;
+}
+
+static int do_i2c_rdwr_ioctl(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	struct i2c_rdwr_ioctl_data32	__user *udata = compat_ptr(arg);
+	struct i2c_rdwr_aligned		__user *tdata;
+	struct i2c_msg			__user *tmsgs;
+	struct i2c_msg32		__user *umsgs;
+	compat_caddr_t			datap;
+	int				nmsgs, i;
+
+	if (get_user(nmsgs, &udata->nmsgs))
+		return -EFAULT;
+	if (nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
+		return -EINVAL;
+
+	if (get_user(datap, &udata->msgs))
+		return -EFAULT;
+	umsgs = compat_ptr(datap);
+
+	tdata = compat_alloc_user_space(sizeof(*tdata) +
+				      nmsgs * sizeof(struct i2c_msg));
+	tmsgs = &tdata->msgs[0];
+
+	if (put_user(nmsgs, &tdata->cmd.nmsgs) ||
+	    put_user(tmsgs, &tdata->cmd.msgs))
+		return -EFAULT;
+
+	for (i = 0; i < nmsgs; i++) {
+		if (copy_in_user(&tmsgs[i].addr, &umsgs[i].addr, 3*sizeof(u16)))
+			return -EFAULT;
+		if (get_user(datap, &umsgs[i].buf) ||
+		    put_user(compat_ptr(datap), &tmsgs[i].buf))
+			return -EFAULT;
+	}
+	return i2cdev_ioctl(inode, file, cmd, (unsigned long)tdata);
+}
+
+static int do_i2c_smbus_ioctl(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	struct i2c_smbus_ioctl_data	__user *tdata;
+	struct i2c_smbus_ioctl_data32	__user *udata;
+	compat_caddr_t			datap;
+
+	tdata = compat_alloc_user_space(sizeof(*tdata));
+	if (tdata == NULL)
+		return -ENOMEM;
+	if (!access_ok(VERIFY_WRITE, tdata, sizeof(*tdata)))
+		return -EFAULT;
+
+	udata = compat_ptr(arg);
+	if (!access_ok(VERIFY_READ, udata, sizeof(*udata)))
+		return -EFAULT;
+
+	if (__copy_in_user(&tdata->read_write, &udata->read_write, 2 * sizeof(u8)))
+		return -EFAULT;
+	if (__copy_in_user(&tdata->size, &udata->size, 2 * sizeof(u32)))
+		return -EFAULT;
+	if (__get_user(datap, &udata->data) ||
+	    __put_user(compat_ptr(datap), &tdata->data))
+		return -EFAULT;
+
+	return i2cdev_ioctl(inode, file, cmd, (unsigned long)tdata);
+}
+
+static long i2cdev_compat_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	int ret = -ENOIOCTLCMD;
+
+	lock_kernel();
+	switch (cmd) {
+	case I2C_FUNCS:
+		ret = do_i2c_w_long(inode, file, cmd, arg);
+		break;
+	case I2C_RDWR:
+		ret = do_i2c_rdwr_ioctl(inode, file, cmd, arg);
+		break;
+	case I2C_SMBUS:
+		ret = do_i2c_smbus_ioctl(inode, file, cmd, arg);
+		break;
+	case I2C_SLAVE:
+	case I2C_SLAVE_FORCE:
+	case I2C_TENBIT:
+	case I2C_PEC:
+	case I2C_RETRIES:
+	case I2C_TIMEOUT:
+		arg = (unsigned long) compat_ptr(arg);
+		ret = i2cdev_ioctl(inode, file, cmd, arg);
+	}
+	unlock_kernel();
+	return ret;
+}
+#endif
+
 static int i2cdev_open(struct inode *inode, struct file *file)
 {
 	unsigned int minor = iminor(inode);
@@ -404,6 +542,9 @@
 	.read		= i2cdev_read,
 	.write		= i2cdev_write,
 	.ioctl		= i2cdev_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= i2cdev_compat_ioctl,
+#endif
 	.open		= i2cdev_open,
 	.release	= i2cdev_release,
 };
Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 14:28:04.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 14:28:05.000000000 +0100
@@ -427,97 +427,6 @@
         return err;
 }
 
-/*
- * I2C layer ioctls
- */
-
-struct i2c_msg32 {
-	u16 addr;
-	u16 flags;
-	u16 len;
-	compat_caddr_t buf;
-};
-
-struct i2c_rdwr_ioctl_data32 {
-	compat_caddr_t msgs; /* struct i2c_msg __user *msgs */
-	u32 nmsgs;
-};
-
-struct i2c_smbus_ioctl_data32 {
-	u8 read_write;
-	u8 command;
-	u32 size;
-	compat_caddr_t data; /* union i2c_smbus_data *data */
-};
-
-struct i2c_rdwr_aligned {
-	struct i2c_rdwr_ioctl_data cmd;
-	struct i2c_msg msgs[0];
-};
-
-static int do_i2c_rdwr_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct i2c_rdwr_ioctl_data32	__user *udata = compat_ptr(arg);
-	struct i2c_rdwr_aligned		__user *tdata;
-	struct i2c_msg			__user *tmsgs;
-	struct i2c_msg32		__user *umsgs;
-	compat_caddr_t			datap;
-	int				nmsgs, i;
-
-	if (get_user(nmsgs, &udata->nmsgs))
-		return -EFAULT;
-	if (nmsgs > I2C_RDRW_IOCTL_MAX_MSGS)
-		return -EINVAL;
-
-	if (get_user(datap, &udata->msgs))
-		return -EFAULT;
-	umsgs = compat_ptr(datap);
-
-	tdata = compat_alloc_user_space(sizeof(*tdata) +
-				      nmsgs * sizeof(struct i2c_msg));
-	tmsgs = &tdata->msgs[0];
-
-	if (put_user(nmsgs, &tdata->cmd.nmsgs) ||
-	    put_user(tmsgs, &tdata->cmd.msgs))
-		return -EFAULT;
-
-	for (i = 0; i < nmsgs; i++) {
-		if (copy_in_user(&tmsgs[i].addr, &umsgs[i].addr, 3*sizeof(u16)))
-			return -EFAULT;
-		if (get_user(datap, &umsgs[i].buf) ||
-		    put_user(compat_ptr(datap), &tmsgs[i].buf))
-			return -EFAULT;
-	}
-	return sys_ioctl(fd, cmd, (unsigned long)tdata);
-}
-
-static int do_i2c_smbus_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct i2c_smbus_ioctl_data	__user *tdata;
-	struct i2c_smbus_ioctl_data32	__user *udata;
-	compat_caddr_t			datap;
-
-	tdata = compat_alloc_user_space(sizeof(*tdata));
-	if (tdata == NULL)
-		return -ENOMEM;
-	if (!access_ok(VERIFY_WRITE, tdata, sizeof(*tdata)))
-		return -EFAULT;
-
-	udata = compat_ptr(arg);
-	if (!access_ok(VERIFY_READ, udata, sizeof(*udata)))
-		return -EFAULT;
-
-	if (__copy_in_user(&tdata->read_write, &udata->read_write, 2 * sizeof(u8)))
-		return -EFAULT;
-	if (__copy_in_user(&tdata->size, &udata->size, 2 * sizeof(u32)))
-		return -EFAULT;
-	if (__get_user(datap, &udata->data) ||
-	    __put_user(compat_ptr(datap), &tdata->data))
-		return -EFAULT;
-
-	return sys_ioctl(fd, cmd, (unsigned long)tdata);
-}
-
 #undef CODE
 #endif
 
@@ -534,10 +443,6 @@
 COMPATIBLE_IOCTL(TIOCGLTC)
 COMPATIBLE_IOCTL(TIOCSLTC)
 #endif
-/* i2c */
-HANDLE_IOCTL(I2C_FUNCS, w_long)
-HANDLE_IOCTL(I2C_RDWR, do_i2c_rdwr_ioctl)
-HANDLE_IOCTL(I2C_SMBUS, do_i2c_smbus_ioctl)
 
 #undef DECLARES
 #endif
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 14:28:04.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 14:28:05.000000000 +0100
@@ -466,13 +466,6 @@
 COMPATIBLE_IOCTL(NBD_PRINT_DEBUG)
 ULONG_IOCTL(NBD_SET_SIZE_BLOCKS)
 COMPATIBLE_IOCTL(NBD_DISCONNECT)
-/* i2c */
-COMPATIBLE_IOCTL(I2C_SLAVE)
-COMPATIBLE_IOCTL(I2C_SLAVE_FORCE)
-COMPATIBLE_IOCTL(I2C_TENBIT)
-COMPATIBLE_IOCTL(I2C_PEC)
-COMPATIBLE_IOCTL(I2C_RETRIES)
-COMPATIBLE_IOCTL(I2C_TIMEOUT)
 /* hiddev */
 COMPATIBLE_IOCTL(HIDIOCGVERSION)
 COMPATIBLE_IOCTL(HIDIOCAPPLICATION)

--

