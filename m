Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVCHCKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVCHCKk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVCHCKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:10:31 -0500
Received: from ipp23-131.piekary.net ([80.48.23.131]:64940 "EHLO spock.one.pl")
	by vger.kernel.org with ESMTP id S261876AbVCHCIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:08:51 -0500
Date: Tue, 8 Mar 2005 03:08:50 +0100
From: Michal Januszewski <spock@gentoo.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [announce 3/7] fbsplash - data structures
Message-ID: <20050308020850.GD26249@spock.one.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fbsplash uses a special iowrapper struct for communication with
userspace. That struct, along with some useful #define's is exported to
userspace programs in include/linux/fb.h. 

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/drivers/video/fbsplash.h b/drivers/video/fbsplash.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/video/fbsplash.h	2005-03-07 16:50:34 +01:00
@@ -0,0 +1,75 @@
+/* 
+ *  linux/drivers/video/fbsplash.h -- Framebuffer splash headers
+ *
+ *  Copyright (C) 2004-2005 Michael Januszewski <spock@gentoo.org>
+ *
+ */
+
+#ifndef __FB_SPLASH_H
+#define __FB_SPLASH_H
+
+#ifndef _LINUX_FB_H
+#include <linux/fb.h>
+#endif
+
+/* This is needed for vc_cons in fbcmap.c */
+#include <linux/vt_kern.h>
+
+struct fb_cursor;
+struct fb_info;
+struct vc_data;
+
+#ifdef CONFIG_FB_SPLASH
+/* fbsplash.c */
+int fbsplash_init(void);
+int fbsplash_call_helper(char* cmd, unsigned short cons);
+int fbsplash_disable(struct vc_data *vc, unsigned char redraw);
+
+/* cfbsplash.c */
+void fbsplash_putcs(struct vc_data *vc, struct fb_info *info, const unsigned short *s, int count, int yy, int xx);
+void fbsplash_cursor(struct fb_info *info, struct fb_cursor *cursor);
+void fbsplash_clear(struct vc_data *vc, struct fb_info *info, int sy, int sx, int height, int width);
+void fbsplash_clear_margins(struct vc_data *vc, struct fb_info *info, int bottom_only);
+void fbsplash_blank(struct vc_data *vc, struct fb_info *info, int blank);
+void fbsplash_bmove_redraw(struct vc_data *vc, struct fb_info *info, int y, int sx, int dx, int width);
+void fbsplash_copy(u8 *dst, u8 *src, int height, int width, int linebytes, int srclinesbytes, int bpp);
+void fbsplash_fix_pseudo_pal(struct fb_info *info, struct vc_data *vc);
+
+/* vt.c */
+void acquire_console_sem(void);
+void release_console_sem(void);
+void do_unblank_screen(int entering_gfx);
+
+/* struct vc_data *y */
+#define fbsplash_active_vc(y) (y->vc_splash.state && y->vc_splash.theme) 
+
+/* struct fb_info *x, struct vc_data *y */
+#define fbsplash_active_nores(x,y) (x->splash.data && fbsplash_active_vc(y))
+
+/* struct fb_info *x, struct vc_data *y */
+#define fbsplash_active(x,y) (fbsplash_active_nores(x,y) &&		\
+			      x->splash.width == x->var.xres && 	\
+			      x->splash.height == x->var.yres &&	\
+			      x->splash.depth == x->var.bits_per_pixel)
+
+
+#else /* CONFIG_FB_SPLASH */
+
+static inline void fbsplash_putcs(struct vc_data *vc, struct fb_info *info, const unsigned short *s, int count, int yy, int xx) {}
+static inline void fbsplash_putc(struct vc_data *vc, struct fb_info *info, int c, int ypos, int xpos) {}
+static inline void fbsplash_cursor(struct fb_info *info, struct fb_cursor *cursor) {}
+static inline void fbsplash_clear(struct vc_data *vc, struct fb_info *info, int sy, int sx, int height, int width) {}
+static inline void fbsplash_clear_margins(struct vc_data *vc, struct fb_info *info, int bottom_only) {}
+static inline void fbsplash_blank(struct vc_data *vc, struct fb_info *info, int blank) {}
+static inline void fbsplash_bmove_redraw(struct vc_data *vc, struct fb_info *info, int y, int sx, int dx, int width) {}
+static inline int fbsplash_call_helper(char* cmd, unsigned short cons) { return 0; }
+static inline int fbsplash_init(void) { return 0; }
+static inline int fbsplash_disable(struct vc_data *vc, unsigned char redraw) { return 0; }
+
+#define fbsplash_active_vc(y) (0)
+#define fbsplash_active_nores(x,y) (0)
+#define fbsplash_active(x,y) (0)
+
+#endif /* CONFIG_FB_SPLASH */
+
+#endif /* __FB_SPLASH_H */
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2005-03-07 16:50:34 +01:00
+++ b/include/linux/fb.h	2005-03-07 16:50:34 +01:00
@@ -8,6 +8,13 @@
 #define FB_MAJOR		29
 #define FB_MAX			32	/* sufficient for now */
 
+struct fb_splash_iowrapper
+{
+	unsigned short vc;		/* Virtual console */
+	unsigned char origin;		/* Point of origin of the request */
+	void *data;
+};
+
 /* ioctls
    0x46 is 'F'								*/
 #define FBIOGET_VSCREENINFO	0x4600
@@ -35,7 +42,15 @@
 #define FBIOGET_HWCINFO         0x4616
 #define FBIOPUT_MODEINFO        0x4617
 #define FBIOGET_DISPINFO        0x4618
-
+#define FBIOSPLASH_SETCFG	_IOWR('F', 0x19, struct fb_splash_iowrapper)
+#define FBIOSPLASH_GETCFG	_IOR('F', 0x1A, struct fb_splash_iowrapper)
+#define FBIOSPLASH_SETSTATE	_IOWR('F', 0x1B, struct fb_splash_iowrapper)
+#define FBIOSPLASH_GETSTATE	_IOR('F', 0x1C, struct fb_splash_iowrapper)
+#define FBIOSPLASH_SETPIC 	_IOWR('F', 0x1D, struct fb_splash_iowrapper)
+
+#define FB_SPLASH_THEME_LEN		128	/* Maximum lenght of a theme name */
+#define FB_SPLASH_IO_ORIG_KERNEL	0	/* Kernel ioctl origin */
+#define FB_SPLASH_IO_ORIG_USER		1 	/* User ioctl origin */
 
 #define FB_TYPE_PACKED_PIXELS		0	/* Packed Pixels	*/
 #define FB_TYPE_PLANES			1	/* Non interleaved planes */
@@ -724,6 +739,9 @@
 #define FBINFO_STATE_SUSPENDED	1
 	u32 state;			/* Hardware state i.e suspend */
 	void *fbcon_par;                /* fbcon use-only private area */
+
+	struct fb_image splash;
+
 	/* From here on everything is device dependent */
 	void *par;	
 };
diff -Nru a/include/linux/console_splash.h b/include/linux/console_splash.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/console_splash.h	2005-03-07 16:50:34 +01:00
@@ -0,0 +1,13 @@
+#ifndef _LINUX_CONSOLE_SPLASH_H_
+#define _LINUX_CONSOLE_SPLASH_H_ 1
+
+/* A structure used by the framebuffer splash code (drivers/video/fbsplash.c) */
+struct vc_splash {
+	__u8 bg_color;				/* The color that is to be treated as transparent */
+	__u8 state;				/* Current splash state: 0 = off, 1 = on */
+	__u16 tx, ty;				/* Top left corner coordinates of the text field */
+	__u16 twidth, theight;			/* Width and height of the text field */
+	char* theme;
+};
+
+#endif
diff -Nru a/include/linux/console_struct.h b/include/linux/console_struct.h
--- a/include/linux/console_struct.h	2005-03-07 16:50:34 +01:00
+++ b/include/linux/console_struct.h	2005-03-07 16:50:34 +01:00
@@ -12,6 +12,7 @@
 struct vt_struct;
 
 #define NPAR 16
+#include <linux/console_splash.h>
 
 struct vc_data {
 	unsigned short	vc_num;			/* Console number */
@@ -90,6 +91,8 @@
 	unsigned long	vc_uni_pagedir;
 	unsigned long	*vc_uni_pagedir_loc;  /* [!] Location of uni_pagedir variable for this console */
 	struct vt_struct *vc_vt;
+
+	struct vc_splash vc_splash;
 	/* additional information is in vt_kern.h */
 };
 
diff -Nru a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c	2005-03-07 16:50:34 +01:00
+++ b/kernel/sysctl.c	2005-03-07 16:50:34 +01:00
@@ -84,6 +84,9 @@
 #ifdef CONFIG_HOTPLUG
 extern char hotplug_path[];
 #endif
+#ifdef CONFIG_FB_SPLASH
+extern char fbsplash_path[];
+#endif
 #ifdef CONFIG_CHR_DEV_SG
 extern int sg_big_buff;
 #endif
@@ -395,6 +398,17 @@
 		.procname	= "hotplug",
 		.data		= &hotplug_path,
 		.maxlen		= HOTPLUG_PATH_LEN,
+		.mode		= 0644,
+		.proc_handler	= &proc_dostring,
+		.strategy	= &sysctl_string,
+	},
+#endif
+#ifdef CONFIG_FB_SPLASH
+	{
+		.ctl_name	= KERN_FBSPLASH,
+		.procname	= "fbsplash",
+		.data		= &fbsplash_path,
+		.maxlen		= KMOD_PATH_LEN,
 		.mode		= 0644,
 		.proc_handler	= &proc_dostring,
 		.strategy	= &sysctl_string,
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	2005-03-07 16:50:34 +01:00
+++ b/include/linux/sysctl.h	2005-03-07 16:50:34 +01:00
@@ -136,6 +136,7 @@
 	KERN_UNKNOWN_NMI_PANIC=66, /* int: unknown nmi panic flag */
 	KERN_BOOTLOADER_TYPE=67, /* int: boot loader type */
 	KERN_RANDOMIZE=68, /* int: randomize virtual address space */
+	KERN_FBSPLASH=69,	/* string: path to fbsplash helper */
 };
 
 


