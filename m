Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261797AbVCHCGh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbVCHCGh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCHCFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:05:15 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:18893 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261797AbVCHCCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:02:23 -0500
Date: Tue, 8 Mar 2005 03:02:20 +0100
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [announce 1/7] fbsplash - the core interface
Message-ID: <20050308020218.GB26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
X-PGP-Key: http://dev.gentoo.org/~spock/spock.gpg
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The core splash interface handles interaction with the userspace helper.
All communication is done via ioctls on the fbsplash device, which is a 
misc character device.

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/drivers/video/fbsplash.c b/drivers/video/fbsplash.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/fbsplash.c	2005-03-07 16:50:34 +01:00
@@ -0,0 +1,406 @@
+/* 
+ *  linux/drivers/video/fbsplash.c -- Framebuffer splash core interface
+ *
+ *  Copyright (C) 2004-2005 Michael Januszewski <spock@gentoo.org>
+ *
+ *  Code based upon "Bootsplash" (C) 2001-2003 
+ *       Volker Poplawski <volker@poplawski.de>,
+ *       Stefan Reinauer <stepan@suse.de>,
+ *       Steffen Winterfeldt <snwint@suse.de>,
+ *       Michael Schroeder <mls@suse.de>,
+ *       Ken Wimer <wimer@suse.de>.
+ *
+ *  Splash render routines are located in /linux/drivers/video/cfbsplash.c
+ * 
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ * 
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/fb.h>
+#include <linux/vt_kern.h>
+#include <linux/vmalloc.h>
+#include <linux/unistd.h>
+#include <linux/syscalls.h>
+#include <linux/init.h>
+#include <linux/proc_fs.h>
+#include <linux/workqueue.h>
+#include <linux/kmod.h>
+#include <linux/miscdevice.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+
+#include <asm/uaccess.h>
+#include <asm/irq.h>
+#include <asm/system.h>
+
+#include "console/fbcon.h"
+#include "fbsplash.h"
+
+#define SPLASH_VERSION 		"0.9.2"
+
+extern signed char con2fb_map[];
+static int fbsplash_enable(struct vc_data *vc);
+char fbsplash_path[KMOD_PATH_LEN] = "/sbin/splash_helper";
+
+int fbsplash_call_helper(char* cmd, unsigned short vc)
+{
+	char *envp[] = {
+		"HOME=/",
+		"PATH=/sbin:/bin",
+		NULL
+	};
+
+	char tfb[5];
+	char tcons[5];
+	unsigned char fb = (int) con2fb_map[vc];
+
+	char *argv[] = {
+		fbsplash_path,
+		"2",
+		cmd,
+		tcons,
+		tfb,
+		vc_cons[vc].d->vc_splash.theme,
+		NULL
+	};
+
+	snprintf(tfb,5,"%d",fb);
+	snprintf(tcons,5,"%d",vc);
+
+	return call_usermodehelper(fbsplash_path, argv, envp, 1);
+}
+
+/* Disables fbsplash on a virtual console; called with console sem held. */
+int fbsplash_disable(struct vc_data *vc, unsigned char redraw)
+{
+	struct fb_info* info;
+
+	if (!vc->vc_splash.state)
+		return -EINVAL;
+
+	info = registered_fb[(int) con2fb_map[vc->vc_num]];
+
+	if (info == NULL)
+		return -EINVAL;
+
+	vc->vc_splash.state = 0; 
+	vc_resize(vc->vc_num, info->var.xres / vc->vc_font.width, 
+		  info->var.yres / vc->vc_font.height);
+
+	if (fg_console == vc->vc_num && redraw) {
+		redraw_screen(fg_console, 0);
+		update_region(fg_console, vc->vc_origin + 
+			      vc->vc_size_row * vc->vc_top, 
+			      vc->vc_size_row * (vc->vc_bottom - vc->vc_top) / 2);
+	}
+
+	printk(KERN_INFO "fbsplash: switched splash state to 'off' on console %d\n", 
+			 vc->vc_num);
+
+	return 0;
+}
+
+/* Enables fbsplash on a virtual console; called with console sem held. */
+static int fbsplash_enable(struct vc_data *vc)
+{
+	struct fb_info* info;
+
+	info = registered_fb[(int) con2fb_map[vc->vc_num]];
+		
+	if (vc->vc_splash.twidth == 0 || vc->vc_splash.theight == 0 || 
+	    info == NULL || vc->vc_splash.state || (!info->splash.data &&
+	    vc->vc_num == fg_console))
+		return -EINVAL;
+	
+	vc->vc_splash.state = 1;
+	vc_resize(vc->vc_num, vc->vc_splash.twidth / vc->vc_font.width, 
+		  vc->vc_splash.theight / vc->vc_font.height);
+
+	if (fg_console == vc->vc_num) {
+		redraw_screen(fg_console, 0);
+		update_region(fg_console, vc->vc_origin + 
+			      vc->vc_size_row * vc->vc_top, 
+			      vc->vc_size_row * (vc->vc_bottom - vc->vc_top) / 2);
+		fbsplash_clear_margins(vc, info, 0);
+	}
+
+	printk(KERN_INFO "fbsplash: switched splash state to 'on' on console %d\n", 
+			 vc->vc_num);
+
+	return 0;
+}
+
+static inline int fbsplash_ioctl_dosetstate(struct vc_data *vc, unsigned int __user* state, unsigned char origin)
+{
+	int tmp, ret;
+
+	if (get_user(tmp, state))
+		return -EFAULT;
+
+	if (origin == FB_SPLASH_IO_ORIG_USER)
+		acquire_console_sem();
+	if (!tmp)
+		ret = fbsplash_disable(vc, 1);
+	else
+		ret = fbsplash_enable(vc);
+	if (origin == FB_SPLASH_IO_ORIG_USER)
+		release_console_sem();
+
+	return ret;
+}
+
+static inline int fbsplash_ioctl_dogetstate(struct vc_data *vc, unsigned int __user *state)
+{
+	return put_user(vc->vc_splash.state, (unsigned int __user*) state);
+}
+
+static int fbsplash_ioctl_dosetcfg(struct vc_data *vc, struct vc_splash __user *arg, unsigned char origin)
+{
+	struct vc_splash cfg;
+	struct fb_info *info;
+	int len;
+	char *tmp;
+	
+	info = registered_fb[(int) con2fb_map[vc->vc_num]];
+
+	if (copy_from_user(&cfg, arg, sizeof(struct vc_splash)))
+		return -EFAULT;
+	if (info == NULL || !cfg.twidth || !cfg.theight || 
+	    cfg.tx + cfg.twidth  > info->var.xres ||
+	    cfg.ty + cfg.theight > info->var.yres)
+		return -EINVAL;
+
+	len = strlen_user(cfg.theme);
+	if (!len || len > FB_SPLASH_THEME_LEN)
+		return -EINVAL;
+	tmp = kmalloc(len, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+	if (copy_from_user(tmp, (void __user *)cfg.theme, len))
+		return -EFAULT;
+	cfg.theme = tmp;
+	cfg.state = 0;
+
+	/* If this ioctl is a response to a request from kernel, the console sem
+	 * is already held; we also don't need to disable splash because either the
+	 * new config and background picture will be successfully loaded, and the 
+	 * splash will stay on, or in case of a failure it'll be turned off in fbcon. */
+	if (origin == FB_SPLASH_IO_ORIG_USER) {
+		acquire_console_sem();
+		if (vc->vc_splash.state)
+			fbsplash_disable(vc, 1);
+	}
+
+	if (vc->vc_splash.theme)
+		kfree(vc->vc_splash.theme);
+
+	vc->vc_splash = cfg;
+
+	if (origin == FB_SPLASH_IO_ORIG_USER)
+		release_console_sem();
+
+	printk(KERN_INFO "fbsplash: console %d using theme '%s'\n", 
+			 vc->vc_num, vc->vc_splash.theme);
+	return 0;	
+}
+
+static int fbsplash_ioctl_dogetcfg(struct vc_data *vc, struct vc_splash __user *arg)
+{
+	struct vc_splash splash;
+	char __user *tmp;
+
+	if (get_user(tmp, &arg->theme))
+		return -EFAULT;
+	
+	splash = vc->vc_splash;
+	splash.theme = tmp;
+
+	if (vc->vc_splash.theme) {
+		if (copy_to_user(tmp, vc->vc_splash.theme, strlen(vc->vc_splash.theme) + 1))
+			return -EFAULT;
+	} else
+		if (put_user(0, tmp))
+			return -EFAULT;
+
+	if (copy_to_user(arg, &splash, sizeof(struct vc_splash)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int fbsplash_ioctl_dosetpic(struct vc_data *vc, struct fb_image __user *arg, unsigned char origin)
+{
+	struct fb_image img;
+	struct fb_info *info;
+	int len;
+	u8 *tmp;
+	
+	if (vc->vc_num != fg_console) 
+		return -EINVAL;
+
+	info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	
+	if (info == NULL)
+		return -EINVAL;
+	
+	if (copy_from_user(&img, arg, sizeof(struct fb_image)))
+		return -EFAULT;
+	
+	if (img.width != info->var.xres || img.height != info->var.yres) {
+		printk(KERN_ERR "fbsplash: picture dimensions mismatch\n");
+		return -EINVAL;
+	}
+
+	if (img.depth != info->var.bits_per_pixel) {
+		printk(KERN_ERR "fbsplash: picture depth mismatch\n");
+		return -EINVAL;
+	}
+		
+	if (img.depth == 8) {
+		if (!img.cmap.len || !img.cmap.red || !img.cmap.green || 
+		    !img.cmap.blue)
+			return -EINVAL;
+		
+		tmp = vmalloc(img.cmap.len * 3 * 2);
+		if (!tmp)
+			return -ENOMEM;
+
+		if (copy_from_user(tmp, (void __user*)img.cmap.red, img.cmap.len * 2) ||
+		    copy_from_user(tmp + (img.cmap.len << 1),
+			    	   (void __user*)img.cmap.green, (img.cmap.len << 1)) ||
+		    copy_from_user(tmp + (img.cmap.len << 2),
+			    	   (void __user*)img.cmap.blue, (img.cmap.len << 1))) {
+			vfree(tmp);
+			return -EFAULT;
+		}
+			
+		img.cmap.transp = NULL;
+		img.cmap.red = (u16*)tmp;
+		img.cmap.green = img.cmap.red + img.cmap.len;
+		img.cmap.blue = img.cmap.green + img.cmap.len;
+	} else {
+		img.cmap.red = NULL;
+	}
+		
+	len = ((img.depth + 7) >> 3) * img.width * img.height;
+	tmp = vmalloc(len);
+
+	if (!tmp)
+		goto out;
+
+	if (copy_from_user(tmp, (void __user*)img.data, len))
+		goto out;
+		
+	img.data = tmp;
+
+	/* If this ioctl is a response to a request from kernel, the console sem
+	 * is already held. */
+	if (origin == FB_SPLASH_IO_ORIG_USER)
+		acquire_console_sem();
+	
+	if (info->splash.data)
+		vfree((u8*)info->splash.data);
+	if (info->splash.cmap.red)
+		vfree(info->splash.cmap.red);
+	
+	info->splash = img;
+
+	if (origin == FB_SPLASH_IO_ORIG_USER)
+		release_console_sem();
+
+	return 0;
+
+out:	if (img.cmap.red)
+		vfree(img.cmap.red);
+	if (tmp)
+		vfree(tmp);
+	return -ENOMEM;
+}
+
+static int splash_ioctl(struct inode * inode, struct file *filp, u_int cmd, 
+			u_long arg)
+{
+	struct fb_splash_iowrapper __user *wrapper = (void __user*) arg;
+	struct vc_data *vc = NULL;
+	unsigned short vc_num = 0;
+	unsigned char origin = 0;
+	void __user *data = NULL;
+	
+	if (verify_area(VERIFY_READ, wrapper, 
+			sizeof(struct fb_splash_iowrapper)))
+		return -EFAULT;
+	
+	__get_user(vc_num, &wrapper->vc);
+	__get_user(origin, &wrapper->origin);
+	__get_user(data, &wrapper->data);
+		
+	if (!vc_cons_allocated(vc_num))
+		return -EINVAL;
+
+	vc = vc_cons[vc_num].d;
+	
+	switch (cmd) {
+	case FBIOSPLASH_SETPIC:
+		return fbsplash_ioctl_dosetpic(vc, (struct fb_image __user*)data, origin);
+	case FBIOSPLASH_SETCFG:
+		return fbsplash_ioctl_dosetcfg(vc, (struct vc_splash*)data, origin);
+	case FBIOSPLASH_GETCFG:
+		return fbsplash_ioctl_dogetcfg(vc, (struct vc_splash*)data);
+	case FBIOSPLASH_SETSTATE:
+		return fbsplash_ioctl_dosetstate(vc, (unsigned int *)data, origin);
+	case FBIOSPLASH_GETSTATE:
+		return fbsplash_ioctl_dogetstate(vc, (unsigned int *)data);
+	default:
+		return -ENOIOCTLCMD;
+	}	
+}
+
+static struct file_operations splash_ops = {
+	.owner = THIS_MODULE,
+	.ioctl = splash_ioctl
+};
+
+static struct miscdevice splash_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "fbsplash",
+	.fops = &splash_ops
+};
+
+int fbsplash_init(void)
+{
+	struct fb_info *info;
+	struct vc_data *vc;
+	int i;
+	
+	vc = vc_cons[0].d;
+	info = registered_fb[0];
+
+	for (i = 0; i < num_registered_fb; i++) {
+		registered_fb[i]->splash.data = NULL;
+		registered_fb[i]->splash.cmap.red = NULL;
+	}
+
+	for (i = 0; i < MAX_NR_CONSOLES && vc_cons[i].d; i++) {
+		vc_cons[i].d->vc_splash.state = vc_cons[i].d->vc_splash.twidth = 
+						vc_cons[i].d->vc_splash.theight = 0;
+		vc_cons[i].d->vc_splash.theme = NULL;
+	}
+
+	i = misc_register(&splash_dev);
+	if (i) {
+		printk(KERN_ERR "fbsplash: failed to register device\n");
+		return i;
+	}
+
+	fbsplash_call_helper("init", 0);
+	
+	return 0;
+}
+
+EXPORT_SYMBOL(fbsplash_path);

