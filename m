Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbVKEQeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbVKEQeF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbVKEQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:04 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:63468 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932105AbVKEQdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:33:36 -0500
Message-Id: <20051105162720.488514000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:14 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, tim@cyberelk.net,
       linux-parport@lists.infradead.org, linux-tape@vger.kernel.org,
       gadio@netvision.net.il, osst@riede.org,
       osst-users@lists.sourceforge.net, Kai.Makisara@kolumbus.fi,
       schwidefsky@de.ibm.com, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 24/25] tape: move mtio ioctl32 code to driver/char/compat_mtio.c
Content-Disposition: inline; filename=tape-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are currently seven drivers in linux that implement
MTIO ioctl methods. This patch introduces a new file doing
the conversion for compat_ioctl for all of them.

They then can all use the new compat_mtio_ioctl function
as their compat_ioctl handler.

CC: tim@cyberelk.net
CC: linux-parport@lists.infradead.org
CC: linux-tape@vger.kernel.org
CC: gadio@netvision.net.il
CC: osst@riede.org
CC: osst-users@lists.sourceforge.net
CC: Kai.Makisara@kolumbus.fi
CC: schwidefsky@de.ibm.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-cg/fs/compat_ioctl.c
===================================================================
--- linux-cg.orig/fs/compat_ioctl.c	2005-11-05 15:48:02.000000000 +0100
+++ linux-cg/fs/compat_ioctl.c	2005-11-05 16:43:44.000000000 +0100
@@ -158,76 +158,6 @@
 }
 
 
-struct mtget32 {
-	compat_long_t	mt_type;
-	compat_long_t	mt_resid;
-	compat_long_t	mt_dsreg;
-	compat_long_t	mt_gstat;
-	compat_long_t	mt_erreg;
-	compat_daddr_t	mt_fileno;
-	compat_daddr_t	mt_blkno;
-};
-#define MTIOCGET32	_IOR('m', 2, struct mtget32)
-
-struct mtpos32 {
-	compat_long_t	mt_blkno;
-};
-#define MTIOCPOS32	_IOR('m', 3, struct mtpos32)
-
-static int mt_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs = get_fs();
-	struct mtget get;
-	struct mtget32 __user *umget32;
-	struct mtpos pos;
-	struct mtpos32 __user *upos32;
-	unsigned long kcmd;
-	void *karg;
-	int err = 0;
-
-	switch(cmd) {
-	case MTIOCPOS32:
-		kcmd = MTIOCPOS;
-		karg = &pos;
-		break;
-	case MTIOCGET32:
-		kcmd = MTIOCGET;
-		karg = &get;
-		break;
-	default:
-		do {
-			static int count;
-			if (++count <= 20)
-				printk("mt_ioctl: Unknown cmd fd(%d) "
-				       "cmd(%08x) arg(%08x)\n",
-				       (int)fd, (unsigned int)cmd, (unsigned int)arg);
-		} while(0);
-		return -EINVAL;
-	}
-	set_fs (KERNEL_DS);
-	err = sys_ioctl (fd, kcmd, (unsigned long)karg);
-	set_fs (old_fs);
-	if (err)
-		return err;
-	switch (cmd) {
-	case MTIOCPOS32:
-		upos32 = compat_ptr(arg);
-		err = __put_user(pos.mt_blkno, &upos32->mt_blkno);
-		break;
-	case MTIOCGET32:
-		umget32 = compat_ptr(arg);
-		err = __put_user(get.mt_type, &umget32->mt_type);
-		err |= __put_user(get.mt_resid, &umget32->mt_resid);
-		err |= __put_user(get.mt_dsreg, &umget32->mt_dsreg);
-		err |= __put_user(get.mt_gstat, &umget32->mt_gstat);
-		err |= __put_user(get.mt_erreg, &umget32->mt_erreg);
-		err |= __put_user(get.mt_fileno, &umget32->mt_fileno);
-		err |= __put_user(get.mt_blkno, &umget32->mt_blkno);
-		break;
-	}
-	return err ? -EFAULT: 0;
-}
-
 static __attribute_used__ int 
 ret_einval(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
@@ -257,7 +187,5 @@
 #endif
 
 #ifdef DECLARES
-HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
-HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
 #undef DECLARES
 #endif
Index: linux-cg/drivers/block/paride/pt.c
===================================================================
--- linux-cg.orig/drivers/block/paride/pt.c	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/block/paride/pt.c	2005-11-05 15:48:02.000000000 +0100
@@ -238,6 +238,7 @@
 	.read = pt_read,
 	.write = pt_write,
 	.ioctl = pt_ioctl,
+	.compat_ioctl = compat_mtio_ioctl,
 	.open = pt_open,
 	.release = pt_release,
 };
Index: linux-cg/drivers/char/Makefile
===================================================================
--- linux-cg.orig/drivers/char/Makefile	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/char/Makefile	2005-11-05 15:48:02.000000000 +0100
@@ -9,6 +9,7 @@
 
 obj-y	 += mem.o random.o tty_io.o n_tty.o tty_ioctl.o
 
+obj-$(CONFIG_COMPAT)		+= compat_mtio.o
 obj-$(CONFIG_LEGACY_PTYS)	+= pty.o
 obj-$(CONFIG_UNIX98_PTYS)	+= pty.o
 obj-y				+= misc.o
Index: linux-cg/drivers/char/compat_mtio.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cg/drivers/char/compat_mtio.c	2005-11-05 16:08:02.000000000 +0100
@@ -0,0 +1,81 @@
+#include <linux/config.h>
+#include <linux/compat.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/mtio.h>
+
+#include <asm/uaccess.h>
+
+struct mtget32 {
+	compat_long_t	mt_type;
+	compat_long_t	mt_resid;
+	compat_long_t	mt_dsreg;
+	compat_long_t	mt_gstat;
+	compat_long_t	mt_erreg;
+	compat_daddr_t	mt_fileno;
+	compat_daddr_t	mt_blkno;
+};
+#define MTIOCGET32	_IOR('m', 2, struct mtget32)
+
+struct mtpos32 {
+	compat_long_t	mt_blkno;
+};
+#define MTIOCPOS32	_IOR('m', 3, struct mtpos32)
+
+long compat_mtio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs = get_fs();
+	struct mtget get;
+	struct mtget32 __user *umget32;
+	struct mtpos pos;
+	struct mtpos32 __user *upos32;
+	void *karg;
+	int err = 0;
+
+	switch(cmd) {
+	case MTIOCPOS32:
+		cmd = MTIOCPOS;
+		karg = &pos;
+		break;
+	case MTIOCGET32:
+		cmd = MTIOCGET;
+		karg = &get;
+		break;
+	case MTIOCTOP:
+		karg = compat_ptr(arg);
+		break;
+	default:
+		return -ENOIOCTLCMD;
+	}
+	set_fs (KERNEL_DS);
+	if (file->f_op->unlocked_ioctl) {
+		err = file->f_op->unlocked_ioctl(file, cmd,
+						 (unsigned long)karg);
+	} else if (file->f_op->ioctl) {
+		struct inode *inode = file->f_dentry->d_inode;
+		lock_kernel();
+		file->f_op->ioctl(inode, file, cmd, (unsigned long)karg);
+		unlock_kernel();
+	}
+	set_fs (old_fs);
+	if (err)
+		return err;
+	switch (cmd) {
+	case MTIOCPOS32:
+		upos32 = compat_ptr(arg);
+		err = __put_user(pos.mt_blkno, &upos32->mt_blkno);
+		break;
+	case MTIOCGET32:
+		umget32 = compat_ptr(arg);
+		err = __put_user(get.mt_type, &umget32->mt_type);
+		err |= __put_user(get.mt_resid, &umget32->mt_resid);
+		err |= __put_user(get.mt_dsreg, &umget32->mt_dsreg);
+		err |= __put_user(get.mt_gstat, &umget32->mt_gstat);
+		err |= __put_user(get.mt_erreg, &umget32->mt_erreg);
+		err |= __put_user(get.mt_fileno, &umget32->mt_fileno);
+		err |= __put_user(get.mt_blkno, &umget32->mt_blkno);
+		break;
+	}
+	return err ? -EFAULT: 0;
+}
+EXPORT_SYMBOL_GPL(compat_mtio_ioctl);
Index: linux-cg/drivers/char/ftape/zftape/zftape-init.c
===================================================================
--- linux-cg.orig/drivers/char/ftape/zftape/zftape-init.c	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/char/ftape/zftape/zftape-init.c	2005-11-05 15:48:02.000000000 +0100
@@ -94,6 +94,7 @@
 	.read		= zft_read,
 	.write		= zft_write,
 	.ioctl		= zft_ioctl,
+	.compat_ioctl	= compat_mtio_ioctl,
 	.mmap		= zft_mmap,
 	.open		= zft_open,
 	.release	= zft_close,
Index: linux-cg/drivers/char/viotape.c
===================================================================
--- linux-cg.orig/drivers/char/viotape.c	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/char/viotape.c	2005-11-05 15:48:02.000000000 +0100
@@ -881,6 +881,7 @@
 	read: viotap_read,
 	write: viotap_write,
 	ioctl: viotap_ioctl,
+	.compat_ioctl = compat_mtio_ioctl,
 	open: viotap_open,
 	release: viotap_release,
 };
Index: linux-cg/drivers/ide/ide-tape.c
===================================================================
--- linux-cg.orig/drivers/ide/ide-tape.c	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/ide/ide-tape.c	2005-11-05 15:48:02.000000000 +0100
@@ -4773,6 +4773,7 @@
 	.read		= idetape_chrdev_read,
 	.write		= idetape_chrdev_write,
 	.ioctl		= idetape_chrdev_ioctl,
+	.compat_ioctl	= compat_mtio_ioctl,
 	.open		= idetape_chrdev_open,
 	.release	= idetape_chrdev_release,
 };
Index: linux-cg/drivers/s390/char/tape_char.c
===================================================================
--- linux-cg.orig/drivers/s390/char/tape_char.c	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/s390/char/tape_char.c	2005-11-05 15:48:02.000000000 +0100
@@ -44,6 +44,7 @@
 	.read = tapechar_read,
 	.write = tapechar_write,
 	.ioctl = tapechar_ioctl,
+	.compat_ioctl = compat_mtio_ioctl,
 	.open = tapechar_open,
 	.release = tapechar_release,
 };
Index: linux-cg/drivers/scsi/osst.c
===================================================================
--- linux-cg.orig/drivers/scsi/osst.c	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/scsi/osst.c	2005-11-05 15:48:02.000000000 +0100
@@ -5135,6 +5135,8 @@
 		ret = sdev->host->hostt->compat_ioctl(sdev, cmd_in, (void __user *)arg);
 
 	}
+	if (ret == -ENOIOCTLCMD)
+		ret = compat_mtio_ioctl(file, cmd_in, arg);
 	return ret;
 }
 #endif
Index: linux-cg/drivers/scsi/st.c
===================================================================
--- linux-cg.orig/drivers/scsi/st.c	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/drivers/scsi/st.c	2005-11-05 15:48:02.000000000 +0100
@@ -3566,6 +3566,8 @@
 		ret = sdev->host->hostt->compat_ioctl(sdev, cmd, (void __user *)arg);
 
 	}
+	if (ret == -ENOIOCTLCMD)
+		ret = compat_mtio_ioctl(file, cmd, arg);
 	return ret;
 }
 #endif
Index: linux-cg/include/linux/mtio.h
===================================================================
--- linux-cg.orig/include/linux/mtio.h	2005-11-05 15:46:38.000000000 +0100
+++ linux-cg/include/linux/mtio.h	2005-11-05 15:48:02.000000000 +0100
@@ -348,4 +348,16 @@
 /* The offset for the arguments for the special HP changer load command. */
 #define MT_ST_HPLOADER_OFFSET 10000
 
+/* ioctl command conversion for 32 bit emulation */
+#ifdef __KERNEL__
+#include <linux/config.h>
+#ifdef CONFIG_COMPAT
+struct file;
+extern long compat_mtio_ioctl(struct file *file, unsigned int cmd,
+				unsigned long arg);
+#else
+#define compat_mtio_ioctl NULL
+#endif
+#endif
+
 #endif /* _LINUX_MTIO_H */
Index: linux-cg/include/linux/compat_ioctl.h
===================================================================
--- linux-cg.orig/include/linux/compat_ioctl.h	2005-11-05 15:48:02.000000000 +0100
+++ linux-cg/include/linux/compat_ioctl.h	2005-11-05 16:43:44.000000000 +0100
@@ -108,8 +108,6 @@
 COMPATIBLE_IOCTL(RTC_SET_TIME)
 COMPATIBLE_IOCTL(RTC_WKALM_SET)
 COMPATIBLE_IOCTL(RTC_WKALM_RD)
-/* Little m */
-COMPATIBLE_IOCTL(MTIOCTOP)
 /* SG stuff */
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)

--

