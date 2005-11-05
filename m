Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVKEQjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVKEQjO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVKEQio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:38:44 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:61383 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751291AbVKEQeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:14 -0500
Message-Id: <20051105162713.724672000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:26:58 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/25] tty: move ioctl32 code over to vt_ioctl.c and tty_io.c
Content-Disposition: inline; filename=compat-vt-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces line discipline specific and tty device specific
compat_ioctl callbacks as well as moving over all generic tty ioctl
and vt ioctl conversion handlers over to the local files that are
already responsible for the native ioctls.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/drivers/char/vt.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/char/vt.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/drivers/char/vt.c	2005-11-05 02:41:32.000000000 +0100
@@ -2614,6 +2614,9 @@
 	.flush_chars = con_flush_chars,
 	.chars_in_buffer = con_chars_in_buffer,
 	.ioctl = vt_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = vt_compat_ioctl,
+#endif
 	.stop = con_stop,
 	.start = con_start,
 	.throttle = con_throttle,
Index: linux-2.6.14-rc/drivers/char/vt_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/char/vt_ioctl.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/drivers/char/vt_ioctl.c	2005-11-05 02:41:32.000000000 +0100
@@ -26,6 +26,7 @@
 #include <linux/console.h>
 #include <linux/signal.h>
 #include <linux/timex.h>
+#include <linux/compat.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1201,3 +1202,197 @@
 
 	complete_change_console(new_vc);
 }
+
+#ifdef CONFIG_COMPAT
+
+static int vt_check(struct file *file, struct tty_struct *tty)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+
+	if (tty_paranoia_check(tty, inode, "tty_ioctl"))
+		return -EINVAL;
+	/*
+	 * To have permissions to do most of the vt ioctls, we either have
+	 * to be the owner of the tty, or super-user.
+	 */
+	if (current->signal->tty == tty || capable(CAP_SYS_ADMIN))
+		return 1;
+	return 0;
+}
+
+struct consolefontdesc32 {
+	unsigned short charcount;       /* characters in font (256 or 512) */
+	unsigned short charheight;      /* scan lines per character (1-32) */
+	compat_caddr_t chardata;	/* font data in expanded form */
+};
+
+static int compat_fontx_ioctl(struct tty_struct *tty, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	struct consolefontdesc32 __user *user_cfd = compat_ptr(arg);
+	struct console_font_op op;
+	compat_caddr_t data;
+	int i, perm;
+
+	perm = vt_check(file, tty);
+	if (perm < 0) return perm;
+
+	switch (cmd) {
+	case PIO_FONTX:
+		if (!perm)
+			return -EPERM;
+		op.op = KD_FONT_OP_SET;
+		op.flags = 0;
+		op.width = 8;
+		if (get_user(op.height, &user_cfd->charheight) ||
+		    get_user(op.charcount, &user_cfd->charcount) ||
+		    get_user(data, &user_cfd->chardata))
+			return -EFAULT;
+		op.data = compat_ptr(data);
+		return con_font_op(vc_cons[fg_console].d, &op);
+	case GIO_FONTX:
+		op.op = KD_FONT_OP_GET;
+		op.flags = 0;
+		op.width = 8;
+		if (get_user(op.height, &user_cfd->charheight) ||
+		    get_user(op.charcount, &user_cfd->charcount) ||
+		    get_user(data, &user_cfd->chardata))
+			return -EFAULT;
+		if (!data)
+			return 0;
+		op.data = compat_ptr(data);
+		i = con_font_op(vc_cons[fg_console].d, &op);
+		if (i)
+			return i;
+		if (put_user(op.height, &user_cfd->charheight) ||
+		    put_user(op.charcount, &user_cfd->charcount) ||
+		    put_user((compat_caddr_t)(unsigned long)op.data,
+				&user_cfd->chardata))
+			return -EFAULT;
+		return 0;
+	}
+	return -EINVAL;
+}
+
+struct console_font_op32 {
+	compat_uint_t op;        /* operation code KD_FONT_OP_* */
+	compat_uint_t flags;     /* KD_FONT_FLAG_* */
+	compat_uint_t width, height;     /* font size */
+	compat_uint_t charcount;
+	compat_caddr_t data;    /* font data with height fixed to 32 */
+};
+
+static int compat_kdfontop_ioctl(struct tty_struct *tty, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	struct console_font_op op;
+	struct console_font_op32 __user *fontop = compat_ptr(arg);
+	int perm = vt_check(file, tty), i;
+	struct vc_data *vc;
+
+	if (perm < 0) return perm;
+
+	if (copy_from_user(&op, fontop, sizeof(struct console_font_op32)))
+		return -EFAULT;
+	if (!perm && op.op != KD_FONT_OP_GET)
+		return -EPERM;
+	op.data = compat_ptr(((struct console_font_op32 *)&op)->data);
+	op.flags |= KD_FONT_FLAG_OLD;
+	vc = ((struct tty_struct *)file->private_data)->driver_data;
+	i = con_font_op(vc, &op);
+	if (i)
+		return i;
+	((struct console_font_op32 *)&op)->data = (unsigned long)op.data;
+	if (copy_to_user(fontop, &op, sizeof(struct console_font_op32)))
+		return -EFAULT;
+	return 0;
+}
+
+struct unimapdesc32 {
+	unsigned short entry_ct;
+	compat_caddr_t entries;
+};
+
+static int compat_unimap_ioctl(struct tty_struct *tty, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	struct unimapdesc32 tmp;
+	struct unimapdesc32 __user *user_ud = compat_ptr(arg);
+	int perm = vt_check(file, tty);
+
+	if (perm < 0) return perm;
+	if (copy_from_user(&tmp, user_ud, sizeof tmp))
+		return -EFAULT;
+	switch (cmd) {
+	case PIO_UNIMAP:
+		if (!perm) return -EPERM;
+		return con_set_unimap(vc_cons[fg_console].d, tmp.entry_ct, compat_ptr(tmp.entries));
+	case GIO_UNIMAP:
+		return con_get_unimap(vc_cons[fg_console].d, tmp.entry_ct, &(user_ud->entry_ct), compat_ptr(tmp.entries));
+	}
+	return 0;
+}
+
+int vt_compat_ioctl(struct tty_struct *tty, struct file * file,
+		    unsigned int cmd, unsigned long arg)
+{
+	int ret = -ENOIOCTLCMD;
+	lock_kernel();
+	switch (cmd) {
+	case PIO_FONTX:
+	case GIO_FONTX:
+		ret = compat_fontx_ioctl(tty, file, cmd, arg);
+		break;
+	case PIO_UNIMAP:
+	case GIO_UNIMAP:
+		ret = compat_unimap_ioctl(tty, file, cmd, arg);
+		break;
+	case KDFONTOP:
+		ret = compat_kdfontop_ioctl(tty, file, cmd, arg);
+		break;
+	case KDGETKEYCODE:
+	case KDGETLED:
+	case KDGETMODE:
+	case KDGKBLED:
+	case KDGKBMETA:
+	case KDGKBMODE:
+	case KDKBDREP:
+	case KDSETKEYCODE:
+	case PIO_FONT:
+	case PIO_FONTRESET:
+	case PIO_SCRNMAP:
+	case PIO_UNIMAPCLR:
+	case PIO_UNISCRNMAP:
+	case GIO_FONT:
+	case GIO_SCRNMAP:
+	case GIO_UNISCRNMAP:
+	case VT_SETMODE:
+	case VT_GETMODE:
+	case VT_GETSTATE:
+	case VT_OPENQRY:
+	case VT_RESIZE:
+	case VT_RESIZEX:
+	case VT_LOCKSWITCH:
+	case VT_UNLOCKSWITCH:
+		ret = vt_ioctl(tty, file, cmd,
+			(unsigned long)(compat_ptr(arg)));
+		break;
+	case KDMKTONE:
+	case KDSETLED:
+	case KDSETMODE:
+	case KDSIGACCEPT:
+	case KDSKBLED:
+	case KDSKBMETA:
+	case KDSKBMODE:
+	case KIOCSOUND:
+	case VT_ACTIVATE:
+	case VT_WAITACTIVE:
+	case VT_RELDISP:
+	case VT_DISALLOCATE:
+		ret = vt_ioctl(tty, file, cmd, arg);
+		break;
+	}
+	unlock_kernel();
+	return ret;
+}
+#endif
Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:31.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:32.000000000 +0100
@@ -938,146 +938,6 @@
 	return err;
 }
 
-extern int tty_ioctl(struct inode * inode, struct file * file, unsigned int cmd, unsigned long arg);
-
-#ifdef CONFIG_VT
-
-static int vt_check(struct file *file)
-{
-	struct tty_struct *tty;
-	struct inode *inode = file->f_dentry->d_inode;
-	
-	if (file->f_op->ioctl != tty_ioctl)
-		return -EINVAL;
-	                
-	tty = (struct tty_struct *)file->private_data;
-	if (tty_paranoia_check(tty, inode, "tty_ioctl"))
-		return -EINVAL;
-	                                                
-	if (tty->driver->ioctl != vt_ioctl)
-		return -EINVAL;
-	
-	/*
-	 * To have permissions to do most of the vt ioctls, we either have
-	 * to be the owner of the tty, or super-user.
-	 */
-	if (current->signal->tty == tty || capable(CAP_SYS_ADMIN))
-		return 1;
-	return 0;                                                    
-}
-
-struct consolefontdesc32 {
-	unsigned short charcount;       /* characters in font (256 or 512) */
-	unsigned short charheight;      /* scan lines per character (1-32) */
-	compat_caddr_t chardata;	/* font data in expanded form */
-};
-
-static int do_fontx_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
-{
-	struct consolefontdesc32 __user *user_cfd = compat_ptr(arg);
-	struct console_font_op op;
-	compat_caddr_t data;
-	int i, perm;
-
-	perm = vt_check(file);
-	if (perm < 0) return perm;
-	
-	switch (cmd) {
-	case PIO_FONTX:
-		if (!perm)
-			return -EPERM;
-		op.op = KD_FONT_OP_SET;
-		op.flags = 0;
-		op.width = 8;
-		if (get_user(op.height, &user_cfd->charheight) ||
-		    get_user(op.charcount, &user_cfd->charcount) ||
-		    get_user(data, &user_cfd->chardata))
-			return -EFAULT;
-		op.data = compat_ptr(data);
-		return con_font_op(vc_cons[fg_console].d, &op);
-	case GIO_FONTX:
-		op.op = KD_FONT_OP_GET;
-		op.flags = 0;
-		op.width = 8;
-		if (get_user(op.height, &user_cfd->charheight) ||
-		    get_user(op.charcount, &user_cfd->charcount) ||
-		    get_user(data, &user_cfd->chardata))
-			return -EFAULT;
-		if (!data)
-			return 0;
-		op.data = compat_ptr(data);
-		i = con_font_op(vc_cons[fg_console].d, &op);
-		if (i)
-			return i;
-		if (put_user(op.height, &user_cfd->charheight) ||
-		    put_user(op.charcount, &user_cfd->charcount) ||
-		    put_user((compat_caddr_t)(unsigned long)op.data,
-				&user_cfd->chardata))
-			return -EFAULT;
-		return 0;
-	}
-	return -EINVAL;
-}
-
-struct console_font_op32 {
-	compat_uint_t op;        /* operation code KD_FONT_OP_* */
-	compat_uint_t flags;     /* KD_FONT_FLAG_* */
-	compat_uint_t width, height;     /* font size */
-	compat_uint_t charcount;
-	compat_caddr_t data;    /* font data with height fixed to 32 */
-};
-                                        
-static int do_kdfontop_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
-{
-	struct console_font_op op;
-	struct console_font_op32 __user *fontop = compat_ptr(arg);
-	int perm = vt_check(file), i;
-	struct vc_data *vc;
-	
-	if (perm < 0) return perm;
-	
-	if (copy_from_user(&op, fontop, sizeof(struct console_font_op32)))
-		return -EFAULT;
-	if (!perm && op.op != KD_FONT_OP_GET)
-		return -EPERM;
-	op.data = compat_ptr(((struct console_font_op32 *)&op)->data);
-	op.flags |= KD_FONT_FLAG_OLD;
-	vc = ((struct tty_struct *)file->private_data)->driver_data;
-	i = con_font_op(vc, &op);
-	if (i)
-		return i;
-	((struct console_font_op32 *)&op)->data = (unsigned long)op.data;
-	if (copy_to_user(fontop, &op, sizeof(struct console_font_op32)))
-		return -EFAULT;
-	return 0;
-}
-
-struct unimapdesc32 {
-	unsigned short entry_ct;
-	compat_caddr_t entries;
-};
-
-static int do_unimap_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg, struct file *file)
-{
-	struct unimapdesc32 tmp;
-	struct unimapdesc32 __user *user_ud = compat_ptr(arg);
-	int perm = vt_check(file);
-	
-	if (perm < 0) return perm;
-	if (copy_from_user(&tmp, user_ud, sizeof tmp))
-		return -EFAULT;
-	switch (cmd) {
-	case PIO_UNIMAP:
-		if (!perm) return -EPERM;
-		return con_set_unimap(vc_cons[fg_console].d, tmp.entry_ct, compat_ptr(tmp.entries));
-	case GIO_UNIMAP:
-		return con_get_unimap(vc_cons[fg_console].d, tmp.entry_ct, &(user_ud->entry_ct), compat_ptr(tmp.entries));
-	}
-	return 0;
-}
-
-#endif /* CONFIG_VT */
-
 static int do_smb_getmountuid(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	mm_segment_t old_fs = get_fs();
@@ -1691,13 +1551,6 @@
 HANDLE_IOCTL(LOOP_GET_STATUS, loop_status)
 #define AUTOFS_IOC_SETTIMEOUT32 _IOWR(0x93,0x64,unsigned int)
 HANDLE_IOCTL(AUTOFS_IOC_SETTIMEOUT32, ioc_settimeout)
-#ifdef CONFIG_VT
-HANDLE_IOCTL(PIO_FONTX, do_fontx_ioctl)
-HANDLE_IOCTL(GIO_FONTX, do_fontx_ioctl)
-HANDLE_IOCTL(PIO_UNIMAP, do_unimap_ioctl)
-HANDLE_IOCTL(GIO_UNIMAP, do_unimap_ioctl)
-HANDLE_IOCTL(KDFONTOP, do_kdfontop_ioctl)
-#endif
 HANDLE_IOCTL(EXT2_IOC32_GETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_SETFLAGS, do_ext2_ioctl)
 HANDLE_IOCTL(EXT2_IOC32_GETVERSION, do_ext2_ioctl)
Index: linux-2.6.14-rc/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/compat_ioctl.h	2005-11-05 02:41:31.000000000 +0100
+++ linux-2.6.14-rc/include/linux/compat_ioctl.h	2005-11-05 02:41:32.000000000 +0100
@@ -10,48 +10,6 @@
 #define ULONG_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
 #endif
 
-/* Big T */
-COMPATIBLE_IOCTL(TCGETA)
-COMPATIBLE_IOCTL(TCSETA)
-COMPATIBLE_IOCTL(TCSETAW)
-COMPATIBLE_IOCTL(TCSETAF)
-COMPATIBLE_IOCTL(TCSBRK)
-ULONG_IOCTL(TCSBRKP)
-COMPATIBLE_IOCTL(TCXONC)
-COMPATIBLE_IOCTL(TCFLSH)
-COMPATIBLE_IOCTL(TCGETS)
-COMPATIBLE_IOCTL(TCSETS)
-COMPATIBLE_IOCTL(TCSETSW)
-COMPATIBLE_IOCTL(TCSETSF)
-COMPATIBLE_IOCTL(TIOCLINUX)
-COMPATIBLE_IOCTL(TIOCSBRK)
-COMPATIBLE_IOCTL(TIOCCBRK)
-ULONG_IOCTL(TIOCMIWAIT)
-COMPATIBLE_IOCTL(TIOCGICOUNT)
-/* Little t */
-COMPATIBLE_IOCTL(TIOCGETD)
-COMPATIBLE_IOCTL(TIOCSETD)
-COMPATIBLE_IOCTL(TIOCEXCL)
-COMPATIBLE_IOCTL(TIOCNXCL)
-COMPATIBLE_IOCTL(TIOCCONS)
-COMPATIBLE_IOCTL(TIOCGSOFTCAR)
-COMPATIBLE_IOCTL(TIOCSSOFTCAR)
-COMPATIBLE_IOCTL(TIOCSWINSZ)
-COMPATIBLE_IOCTL(TIOCGWINSZ)
-COMPATIBLE_IOCTL(TIOCMGET)
-COMPATIBLE_IOCTL(TIOCMBIC)
-COMPATIBLE_IOCTL(TIOCMBIS)
-COMPATIBLE_IOCTL(TIOCMSET)
-COMPATIBLE_IOCTL(TIOCPKT)
-COMPATIBLE_IOCTL(TIOCNOTTY)
-COMPATIBLE_IOCTL(TIOCSTI)
-COMPATIBLE_IOCTL(TIOCOUTQ)
-COMPATIBLE_IOCTL(TIOCSPGRP)
-COMPATIBLE_IOCTL(TIOCGPGRP)
-ULONG_IOCTL(TIOCSCTTY)
-COMPATIBLE_IOCTL(TIOCGPTN)
-COMPATIBLE_IOCTL(TIOCSPTLCK)
-COMPATIBLE_IOCTL(TIOCSERGETLSR)
 /* Big F */
 COMPATIBLE_IOCTL(FBIOBLANK)
 COMPATIBLE_IOCTL(FBIOGET_VSCREENINFO)
@@ -121,37 +79,13 @@
 COMPATIBLE_IOCTL(DM_LIST_VERSIONS)
 COMPATIBLE_IOCTL(DM_TARGET_MSG)
 /* Big K */
-COMPATIBLE_IOCTL(PIO_FONT)
-COMPATIBLE_IOCTL(GIO_FONT)
-ULONG_IOCTL(KDSIGACCEPT)
-COMPATIBLE_IOCTL(KDGETKEYCODE)
-COMPATIBLE_IOCTL(KDSETKEYCODE)
-ULONG_IOCTL(KIOCSOUND)
-ULONG_IOCTL(KDMKTONE)
 COMPATIBLE_IOCTL(KDGKBTYPE)
-ULONG_IOCTL(KDSETMODE)
-COMPATIBLE_IOCTL(KDGETMODE)
-ULONG_IOCTL(KDSKBMODE)
-COMPATIBLE_IOCTL(KDGKBMODE)
-ULONG_IOCTL(KDSKBMETA)
-COMPATIBLE_IOCTL(KDGKBMETA)
 COMPATIBLE_IOCTL(KDGKBENT)
 COMPATIBLE_IOCTL(KDSKBENT)
 COMPATIBLE_IOCTL(KDGKBSENT)
 COMPATIBLE_IOCTL(KDSKBSENT)
 COMPATIBLE_IOCTL(KDGKBDIACR)
 COMPATIBLE_IOCTL(KDSKBDIACR)
-COMPATIBLE_IOCTL(KDKBDREP)
-COMPATIBLE_IOCTL(KDGKBLED)
-ULONG_IOCTL(KDSKBLED)
-COMPATIBLE_IOCTL(KDGETLED)
-ULONG_IOCTL(KDSETLED)
-COMPATIBLE_IOCTL(GIO_SCRNMAP)
-COMPATIBLE_IOCTL(PIO_SCRNMAP)
-COMPATIBLE_IOCTL(GIO_UNISCRNMAP)
-COMPATIBLE_IOCTL(PIO_UNISCRNMAP)
-COMPATIBLE_IOCTL(PIO_FONTRESET)
-COMPATIBLE_IOCTL(PIO_UNIMAPCLR)
 /* Big S */
 COMPATIBLE_IOCTL(SCSI_IOCTL_GET_IDLUN)
 COMPATIBLE_IOCTL(SCSI_IOCTL_DOORLOCK)
@@ -166,19 +100,6 @@
 COMPATIBLE_IOCTL(TUNSETDEBUG)
 COMPATIBLE_IOCTL(TUNSETPERSIST)
 COMPATIBLE_IOCTL(TUNSETOWNER)
-/* Big V */
-COMPATIBLE_IOCTL(VT_SETMODE)
-COMPATIBLE_IOCTL(VT_GETMODE)
-COMPATIBLE_IOCTL(VT_GETSTATE)
-COMPATIBLE_IOCTL(VT_OPENQRY)
-ULONG_IOCTL(VT_ACTIVATE)
-ULONG_IOCTL(VT_WAITACTIVE)
-ULONG_IOCTL(VT_RELDISP)
-ULONG_IOCTL(VT_DISALLOCATE)
-COMPATIBLE_IOCTL(VT_RESIZE)
-COMPATIBLE_IOCTL(VT_RESIZEX)
-COMPATIBLE_IOCTL(VT_LOCKSWITCH)
-COMPATIBLE_IOCTL(VT_UNLOCKSWITCH)
 /* Little v */
 /* Little v, the video4linux ioctls (conflict?) */
 COMPATIBLE_IOCTL(VIDIOCGCAP)
Index: linux-2.6.14-rc/include/linux/tty.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/tty.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/linux/tty.h	2005-11-05 02:41:32.000000000 +0100
@@ -404,6 +404,8 @@
 
 extern int vt_ioctl(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
+extern int vt_compat_ioctl(struct tty_struct *tty, struct file * file,
+			   unsigned int cmd, unsigned long arg);
 
 static inline dev_t tty_devnum(struct tty_struct *tty)
 {
Index: linux-2.6.14-rc/include/linux/tty_driver.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/tty_driver.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/linux/tty_driver.h	2005-11-05 02:41:32.000000000 +0100
@@ -132,6 +132,8 @@
 	int  (*chars_in_buffer)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
+	int  (*compat_ioctl)(struct tty_struct *tty, struct file * file,
+			unsigned int cmd, unsigned long arg);
 	void (*set_termios)(struct tty_struct *tty, struct termios * old);
 	void (*throttle)(struct tty_struct * tty);
 	void (*unthrottle)(struct tty_struct * tty);
@@ -194,6 +196,8 @@
 	int  (*chars_in_buffer)(struct tty_struct *tty);
 	int  (*ioctl)(struct tty_struct *tty, struct file * file,
 		    unsigned int cmd, unsigned long arg);
+	int  (*compat_ioctl)(struct tty_struct *tty, struct file * file,
+		    unsigned int cmd, unsigned long arg);
 	void (*set_termios)(struct tty_struct *tty, struct termios * old);
 	void (*throttle)(struct tty_struct * tty);
 	void (*unthrottle)(struct tty_struct * tty);
Index: linux-2.6.14-rc/drivers/char/tty_io.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/char/tty_io.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/drivers/char/tty_io.c	2005-11-05 02:41:32.000000000 +0100
@@ -95,6 +95,7 @@
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/compat.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -152,6 +153,7 @@
 static int tty_release(struct inode *, struct file *);
 int tty_ioctl(struct inode * inode, struct file * file,
 	      unsigned int cmd, unsigned long arg);
+long tty_compat_ioctl(struct file * file, unsigned int cmd, unsigned long arg);
 static int tty_fasync(int fd, struct file * filp, int on);
 static void release_mem(struct tty_struct *tty, int idx);
 
@@ -680,7 +682,7 @@
 	return POLLIN | POLLOUT | POLLERR | POLLHUP | POLLRDNORM | POLLWRNORM;
 }
 
-static int hung_up_tty_ioctl(struct inode * inode, struct file * file,
+static long hung_up_tty_ioctl(struct file * file,
 			     unsigned int cmd, unsigned long arg)
 {
 	return cmd == TIOCSPGRP ? -ENOTTY : -EIO;
@@ -692,6 +694,9 @@
 	.write		= tty_write,
 	.poll		= tty_poll,
 	.ioctl		= tty_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= tty_compat_ioctl,
+#endif
 	.open		= tty_open,
 	.release	= tty_release,
 	.fasync		= tty_fasync,
@@ -704,6 +709,9 @@
 	.write		= tty_write,
 	.poll		= tty_poll,
 	.ioctl		= tty_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= tty_compat_ioctl,
+#endif
 	.open		= ptmx_open,
 	.release	= tty_release,
 	.fasync		= tty_fasync,
@@ -716,6 +724,9 @@
 	.write		= redirected_tty_write,
 	.poll		= tty_poll,
 	.ioctl		= tty_ioctl,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl	= tty_compat_ioctl,
+#endif
 	.open		= tty_open,
 	.release	= tty_release,
 	.fasync		= tty_fasync,
@@ -726,7 +737,8 @@
 	.read		= hung_up_tty_read,
 	.write		= hung_up_tty_write,
 	.poll		= hung_up_tty_poll,
-	.ioctl		= hung_up_tty_ioctl,
+	.unlocked_ioctl	= hung_up_tty_ioctl,
+	.compat_ioctl	= hung_up_tty_ioctl,
 	.release	= tty_release,
 };
 
@@ -2424,6 +2436,99 @@
 }
 
 
+#ifdef CONFIG_COMPAT
+long tty_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file->f_dentry->d_inode;
+	struct tty_struct *tty;
+	struct tty_ldisc *ld;
+	int ret = -ENOIOCTLCMD;
+
+	/* first handle those that need special treatment */
+	switch (cmd) {
+	case FIONBIO:
+	case TCSBRK:
+	case TIOCCBRK:
+	case TIOCCONS:
+	case TIOCEXCL:
+	case TIOCGETD:
+	case TIOCGPGRP:
+	case TIOCGSID:
+	case TIOCGWINSZ:
+	case TIOCLINUX:
+	case TIOCMBIC:
+	case TIOCMBIS:
+	case TIOCMGET:
+	case TIOCMSET:
+	case TIOCNOTTY:
+	case TIOCNXCL:
+	case TIOCSBRK:
+	case TIOCSETD:
+	case TIOCSPGRP:
+	case TIOCSTI:
+	case TIOCSWINSZ:
+		arg = (unsigned long)compat_ptr(arg);
+	case TCSBRKP:
+	case TIOCSCTTY:
+		lock_kernel();
+		ret = tty_ioctl(inode, file, cmd, arg);
+		unlock_kernel();
+		goto out;
+	}
+
+	/* try to call down to tty specific compat_ioctl method */
+	tty = (struct tty_struct *)file->private_data;
+	if (tty_paranoia_check(tty, inode, "tty_compat_ioctl"))
+		return -EINVAL;
+
+	if (tty->driver->compat_ioctl) {
+		ret = tty->driver->compat_ioctl(tty, file, cmd, arg);
+		if (ret != -ENOIOCTLCMD)
+			goto out;
+	}
+
+	ld = tty_ldisc_ref_wait(tty);
+	if (ld->compat_ioctl) {
+		ret = ld->compat_ioctl(tty, file, cmd, arg);
+	}
+	tty_ldisc_deref(ld);
+
+	if (ret != -ENOIOCTLCMD)
+		goto out;
+
+	/* enter the native code path for those numbers known
+	 * to be compatible */
+	switch (cmd) {
+	case TCFLSH:
+	case TCGETA:
+	case TCGETS:
+	case TCSETA:
+	case TCSETAF:
+	case TCSETAW:
+	case TCSETS:
+	case TCSETSF:
+	case TCSETSW:
+	case TCXONC:
+	case TIOCGICOUNT:
+	case TIOCGPTN:
+	case TIOCGSOFTCAR:
+	case TIOCOUTQ:
+	case TIOCPKT:
+	case TIOCSERGETLSR:
+	case TIOCSPTLCK:
+	case TIOCSSOFTCAR:
+		arg = (unsigned long)compat_ptr(arg);
+	case TIOCMIWAIT:
+		lock_kernel();
+		ret = tty_ioctl(inode, file, cmd, arg);
+		unlock_kernel();
+		break;
+	}
+out:
+	return ret;
+}
+#endif
+
 /*
  * This implements the "Secure Attention Key" ---  the idea is to
  * prevent trojan horses by killing all processes associated with this
@@ -2777,6 +2882,7 @@
 	driver->write_room = op->write_room;
 	driver->chars_in_buffer = op->chars_in_buffer;
 	driver->ioctl = op->ioctl;
+	driver->compat_ioctl = op->compat_ioctl;
 	driver->set_termios = op->set_termios;
 	driver->throttle = op->throttle;
 	driver->unthrottle = op->unthrottle;
Index: linux-2.6.14-rc/include/linux/tty_ldisc.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/tty_ldisc.h	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/include/linux/tty_ldisc.h	2005-11-05 02:41:32.000000000 +0100
@@ -126,6 +126,8 @@
 			 const unsigned char * buf, size_t nr);	
 	int	(*ioctl)(struct tty_struct * tty, struct file * file,
 			 unsigned int cmd, unsigned long arg);
+	int	(*compat_ioctl)(struct tty_struct * tty, struct file * file,
+			 unsigned int cmd, unsigned long arg);
 	void	(*set_termios)(struct tty_struct *tty, struct termios * old);
 	unsigned int (*poll)(struct tty_struct *, struct file *,
 			     struct poll_table_struct *);
Index: linux-2.6.14-rc/drivers/char/n_tty.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/char/n_tty.c	2005-11-05 02:41:10.000000000 +0100
+++ linux-2.6.14-rc/drivers/char/n_tty.c	2005-11-05 02:41:32.000000000 +0100
@@ -1549,6 +1549,7 @@
 	read_chan,		/* read */
 	write_chan,		/* write */
 	n_tty_ioctl,		/* ioctl */
+	NULL,			/* compat_ioctl */
 	n_tty_set_termios,	/* set_termios */
 	normal_poll,		/* poll */
 	NULL,			/* hangup */

--

