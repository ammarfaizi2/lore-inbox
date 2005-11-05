Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbVKEQg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbVKEQg5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 11:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVKEQem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 11:34:42 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:64456 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932107AbVKEQee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 11:34:34 -0500
Message-Id: <20051105162714.961205000@b551138y.boeblingen.de.ibm.com>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
Date: Sat, 05 Nov 2005 17:27:01 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, adaplas@pol.net,
       linux-fbdev-devel@lists.sourceforge.net, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/25] framebuffer: move ioctl32 code to fbmem.c
Content-Disposition: inline; filename=fb-ioctl.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The frame buffer layer already had some code dealing with
compat ioctls, this patch moves over the remaining code
from fs/compat_ioctl.c

CC: adaplas@pol.net
CC: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6.14-rc/drivers/video/fbmem.c
===================================================================
--- linux-2.6.14-rc.orig/drivers/video/fbmem.c	2005-11-05 02:38:51.000000000 +0100
+++ linux-2.6.14-rc/drivers/video/fbmem.c	2005-11-05 02:41:37.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 
+#include <linux/compat.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -829,18 +830,154 @@
 }
 
 #ifdef CONFIG_COMPAT
+struct fb_fix_screeninfo32 {
+	char			id[16];
+	compat_caddr_t		smem_start;
+	u32			smem_len;
+	u32			type;
+	u32			type_aux;
+	u32			visual;
+	u16			xpanstep;
+	u16			ypanstep;
+	u16			ywrapstep;
+	u32			line_length;
+	compat_caddr_t		mmio_start;
+	u32			mmio_len;
+	u32			accel;
+	u16			reserved[3];
+};
+
+struct fb_cmap32 {
+	u32			start;
+	u32			len;
+	compat_caddr_t	red;
+	compat_caddr_t	green;
+	compat_caddr_t	blue;
+	compat_caddr_t	transp;
+};
+
+static int fb_getput_cmap(struct inode *inode, struct file *file,
+			unsigned int cmd, unsigned long arg)
+{
+	struct fb_cmap_user __user *cmap;
+	struct fb_cmap32 __user *cmap32;
+	__u32 data;
+	int err;
+
+	cmap = compat_alloc_user_space(sizeof(*cmap));
+	cmap32 = compat_ptr(arg);
+
+	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
+		return -EFAULT;
+
+	if (get_user(data, &cmap32->red) ||
+	    put_user(compat_ptr(data), &cmap->red) ||
+	    get_user(data, &cmap32->green) ||
+	    put_user(compat_ptr(data), &cmap->green) ||
+	    get_user(data, &cmap32->blue) ||
+	    put_user(compat_ptr(data), &cmap->blue) ||
+	    get_user(data, &cmap32->transp) ||
+	    put_user(compat_ptr(data), &cmap->transp))
+		return -EFAULT;
+
+	err = fb_ioctl(inode, file, cmd, (unsigned long) cmap);
+
+	if (!err) {
+		if (copy_in_user(&cmap32->start,
+				 &cmap->start,
+				 2 * sizeof(__u32)))
+			err = -EFAULT;
+	}
+	return err;
+}
+
+static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
+				  struct fb_fix_screeninfo32 __user *fix32)
+{
+	__u32 data;
+	int err;
+
+	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
+
+	data = (__u32) (unsigned long) fix->smem_start;
+	err |= put_user(data, &fix32->smem_start);
+
+	err |= put_user(fix->smem_len, &fix32->smem_len);
+	err |= put_user(fix->type, &fix32->type);
+	err |= put_user(fix->type_aux, &fix32->type_aux);
+	err |= put_user(fix->visual, &fix32->visual);
+	err |= put_user(fix->xpanstep, &fix32->xpanstep);
+	err |= put_user(fix->ypanstep, &fix32->ypanstep);
+	err |= put_user(fix->ywrapstep, &fix32->ywrapstep);
+	err |= put_user(fix->line_length, &fix32->line_length);
+
+	data = (__u32) (unsigned long) fix->mmio_start;
+	err |= put_user(data, &fix32->mmio_start);
+
+	err |= put_user(fix->mmio_len, &fix32->mmio_len);
+	err |= put_user(fix->accel, &fix32->accel);
+	err |= copy_to_user(fix32->reserved, fix->reserved,
+			    sizeof(fix->reserved));
+
+	return err;
+}
+
+static int fb_get_fscreeninfo(struct inode *inode, struct file *file,
+				unsigned int cmd, unsigned long arg)
+{
+	mm_segment_t old_fs;
+	struct fb_fix_screeninfo fix;
+	struct fb_fix_screeninfo32 __user *fix32;
+	int err;
+
+	fix32 = compat_ptr(arg);
+
+	old_fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = fb_ioctl(inode, file, cmd, (unsigned long) &fix);
+	set_fs(old_fs);
+
+	if (!err)
+		err = do_fscreeninfo_to_user(&fix, fix32);
+
+	return err;
+}
+
 static long
 fb_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
-	int fbidx = iminor(file->f_dentry->d_inode);
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
 	struct fb_ops *fb = info->fbops;
-	long ret;
+	long ret = -ENOIOCTLCMD;
 
-	if (fb->fb_compat_ioctl == NULL)
-		return -ENOIOCTLCMD;
 	lock_kernel();
-	ret = fb->fb_compat_ioctl(file, cmd, arg, info);
+	switch(cmd) {
+	case FBIOGET_VSCREENINFO:
+	case FBIOPUT_VSCREENINFO:
+	case FBIOPAN_DISPLAY:
+	case FBIOGET_CON2FBMAP:
+	case FBIOPUT_CON2FBMAP:
+		arg = (unsigned long) compat_ptr(arg);
+	case FBIOBLANK:
+		ret = fb_ioctl(inode, file, cmd, arg);
+		break;
+
+	case FBIOGET_FSCREENINFO:
+		ret = fb_get_fscreeninfo(inode, file, cmd, arg);
+		break;
+
+	case FBIOGETCMAP:
+	case FBIOPUTCMAP:
+		ret = fb_getput_cmap(inode, file, cmd, arg);
+		break;
+
+	default:
+		if (fb->fb_compat_ioctl)
+			ret = fb->fb_compat_ioctl(file, cmd, arg, info);
+		break;
+	}
 	unlock_kernel();
 	return ret;
 }
Index: linux-2.6.14-rc/fs/compat_ioctl.c
===================================================================
--- linux-2.6.14-rc.orig/fs/compat_ioctl.c	2005-11-05 02:41:35.000000000 +0100
+++ linux-2.6.14-rc/fs/compat_ioctl.c	2005-11-05 02:41:37.000000000 +0100
@@ -157,146 +157,6 @@
 	return err;
 }
 
-struct fb_fix_screeninfo32 {
-	char			id[16];
-        compat_caddr_t	smem_start;
-	u32			smem_len;
-	u32			type;
-	u32			type_aux;
-	u32			visual;
-	u16			xpanstep;
-	u16			ypanstep;
-	u16			ywrapstep;
-	u32			line_length;
-        compat_caddr_t	mmio_start;
-	u32			mmio_len;
-	u32			accel;
-	u16			reserved[3];
-};
-
-struct fb_cmap32 {
-	u32			start;
-	u32			len;
-	compat_caddr_t	red;
-	compat_caddr_t	green;
-	compat_caddr_t	blue;
-	compat_caddr_t	transp;
-};
-
-static int fb_getput_cmap(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	struct fb_cmap_user __user *cmap;
-	struct fb_cmap32 __user *cmap32;
-	__u32 data;
-	int err;
-
-	cmap = compat_alloc_user_space(sizeof(*cmap));
-	cmap32 = compat_ptr(arg);
-
-	if (copy_in_user(&cmap->start, &cmap32->start, 2 * sizeof(__u32)))
-		return -EFAULT;
-
-	if (get_user(data, &cmap32->red) ||
-	    put_user(compat_ptr(data), &cmap->red) ||
-	    get_user(data, &cmap32->green) ||
-	    put_user(compat_ptr(data), &cmap->green) ||
-	    get_user(data, &cmap32->blue) ||
-	    put_user(compat_ptr(data), &cmap->blue) ||
-	    get_user(data, &cmap32->transp) ||
-	    put_user(compat_ptr(data), &cmap->transp))
-		return -EFAULT;
-
-	err = sys_ioctl(fd, cmd, (unsigned long) cmap);
-
-	if (!err) {
-		if (copy_in_user(&cmap32->start,
-				 &cmap->start,
-				 2 * sizeof(__u32)))
-			err = -EFAULT;
-	}
-	return err;
-}
-
-static int do_fscreeninfo_to_user(struct fb_fix_screeninfo *fix,
-				  struct fb_fix_screeninfo32 __user *fix32)
-{
-	__u32 data;
-	int err;
-
-	err = copy_to_user(&fix32->id, &fix->id, sizeof(fix32->id));
-
-	data = (__u32) (unsigned long) fix->smem_start;
-	err |= put_user(data, &fix32->smem_start);
-
-	err |= put_user(fix->smem_len, &fix32->smem_len);
-	err |= put_user(fix->type, &fix32->type);
-	err |= put_user(fix->type_aux, &fix32->type_aux);
-	err |= put_user(fix->visual, &fix32->visual);
-	err |= put_user(fix->xpanstep, &fix32->xpanstep);
-	err |= put_user(fix->ypanstep, &fix32->ypanstep);
-	err |= put_user(fix->ywrapstep, &fix32->ywrapstep);
-	err |= put_user(fix->line_length, &fix32->line_length);
-
-	data = (__u32) (unsigned long) fix->mmio_start;
-	err |= put_user(data, &fix32->mmio_start);
-
-	err |= put_user(fix->mmio_len, &fix32->mmio_len);
-	err |= put_user(fix->accel, &fix32->accel);
-	err |= copy_to_user(fix32->reserved, fix->reserved,
-			    sizeof(fix->reserved));
-
-	return err;
-}
-
-static int fb_get_fscreeninfo(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	mm_segment_t old_fs;
-	struct fb_fix_screeninfo fix;
-	struct fb_fix_screeninfo32 __user *fix32;
-	int err;
-
-	fix32 = compat_ptr(arg);
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_ioctl(fd, cmd, (unsigned long) &fix);
-	set_fs(old_fs);
-
-	if (!err)
-		err = do_fscreeninfo_to_user(&fix, fix32);
-
-	return err;
-}
-
-static int fb_ioctl_trans(unsigned int fd, unsigned int cmd, unsigned long arg)
-{
-	int err;
-
-	switch (cmd) {
-	case FBIOGET_FSCREENINFO:
-		err = fb_get_fscreeninfo(fd,cmd, arg);
-		break;
-
-  	case FBIOGETCMAP:
-	case FBIOPUTCMAP:
-		err = fb_getput_cmap(fd, cmd, arg);
-		break;
-
-	default:
-		do {
-			static int count;
-			if (++count <= 20)
-				printk("%s: Unknown fb ioctl cmd fd(%d) "
-				       "cmd(%08x) arg(%08lx)\n",
-				       __FUNCTION__, fd, cmd, arg);
-		} while(0);
-		err = -ENOSYS;
-		break;
-	};
-
-	return err;
-}
-
 typedef struct sg_io_hdr32 {
 	compat_int_t interface_id;	/* [i] 'S' for SCSI generic (required) */
 	compat_int_t dxfer_direction;	/* [i] data transfer direction  */
@@ -1283,9 +1143,6 @@
 #endif
 
 #ifdef DECLARES
-HANDLE_IOCTL(FBIOGET_FSCREENINFO, fb_ioctl_trans)
-HANDLE_IOCTL(FBIOGETCMAP, fb_ioctl_trans)
-HANDLE_IOCTL(FBIOPUTCMAP, fb_ioctl_trans)
 HANDLE_IOCTL(SG_IO,sg_ioctl_trans)
 HANDLE_IOCTL(MTIOCGET32, mt_ioctl_trans)
 HANDLE_IOCTL(MTIOCPOS32, mt_ioctl_trans)
Index: linux-2.6.14-rc/include/linux/compat_ioctl.h
===================================================================
--- linux-2.6.14-rc.orig/include/linux/compat_ioctl.h	2005-11-05 02:41:33.000000000 +0100
+++ linux-2.6.14-rc/include/linux/compat_ioctl.h	2005-11-05 02:41:37.000000000 +0100
@@ -10,13 +10,6 @@
 #define ULONG_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
 #endif
 
-/* Big F */
-COMPATIBLE_IOCTL(FBIOBLANK)
-COMPATIBLE_IOCTL(FBIOGET_VSCREENINFO)
-COMPATIBLE_IOCTL(FBIOPUT_VSCREENINFO)
-COMPATIBLE_IOCTL(FBIOPAN_DISPLAY)
-COMPATIBLE_IOCTL(FBIOGET_CON2FBMAP)
-COMPATIBLE_IOCTL(FBIOPUT_CON2FBMAP)
 /* Little f */
 COMPATIBLE_IOCTL(FIOCLEX)
 COMPATIBLE_IOCTL(FIONCLEX)

--

