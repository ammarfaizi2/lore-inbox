Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283337AbRK2RgB>; Thu, 29 Nov 2001 12:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283348AbRK2Rfw>; Thu, 29 Nov 2001 12:35:52 -0500
Received: from zeus.kernel.org ([204.152.189.113]:26841 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283337AbRK2Rfi>;
	Thu, 29 Nov 2001 12:35:38 -0500
Date: Thu, 29 Nov 2001 09:35:14 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [PATCH] Hooks for new fbdev api
In-Reply-To: <Pine.GSO.4.21.0111290851320.6747-100000@mullein.sonytel.be>
Message-ID: <Pine.LNX.4.10.10111290933240.2693-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And x and y here?
> 
> I'd vote for either x/y or dx/dy (destinatation x/y).

I named them dx.

I have a new patch here. If you approve of it I will send it to Linus
then.

--- linux-2.5.0/include/linux/fb.h	Wed Nov 28 16:43:10 2001
+++ linux/include/linux/fb.h	Thu Nov 29 10:30:41 2001
@@ -241,6 +241,65 @@
 	__u32 reserved[4];		/* reserved for future compatibility */
 };
 
+/*
+ * hardware cursor control
+ */
+
+#define FB_CUR_SETCUR   0x01
+#define FB_CUR_SETPOS   0x02
+#define FB_CUR_SETHOT   0x04
+#define FB_CUR_SETCMAP  0x08
+#define FB_CUR_SETSHAPE 0x10
+#define FB_CUR_SETALL   0x1F
+
+struct fbcurpos {
+	__u16 x, y;
+};
+
+struct fbcursor {
+	__u16 set;		/* what to set */
+	__u16 enable;/* cursor on/off */
+	struct fbcurpos pos;/* cursor position */
+	struct fbcurpos hot;/* cursor hot spot */
+	struct fb_cmap cmap;/* color map info */
+	struct fbcurpos size;/* cursor bit map size */
+	char *image;/* cursor image bits */
+	char *mask;/* cursor mask bits */
+};
+
+/* Internal HW accel */
+#define ROP_COPY 0
+#define ROP_XOR  1
+
+struct fb_copyarea {
+	__u32 sx;	/* screen-relative */
+	__u32 sy;
+	__u32 width;
+	__u32 height;
+	__u32 dx;
+	__u32 dy;
+};
+
+struct fb_fillrect {
+	__u32 dx;	/* screen-relative */
+	__u32 dy;
+	__u32 width;
+	__u32 height;
+	__u32 color;
+	__u32 rop;
+};
+
+struct fb_image {
+	__u32 width;	/* Size of image */
+	__u32 height;
+	__u16 dx;	/* Where to place image */
+	__u16 dy;
+	__u32 fg_color;	/* Only used when a mono bitmap */
+	__u32 bg_color;
+	__u8  depth;	/* Dpeth of the image */
+	char  *data;	/* Pointer to image data */
+};
+
 #ifdef __KERNEL__
 
 #if 1 /* to go away in 2.5.0 */
@@ -250,10 +309,10 @@
 #endif
 
 #include <linux/fs.h>
+#include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 
-
 struct fb_info;
 struct fb_info_gen;
 struct vm_area_struct;
@@ -283,9 +342,27 @@
     /* set colormap */
     int (*fb_set_cmap)(struct fb_cmap *cmap, int kspc, int con,
 		       struct fb_info *info);
-    /* pan display (optional) */
-    int (*fb_pan_display)(struct fb_var_screeninfo *var, int con,
-			  struct fb_info *info);
+    /* checks var and creates a par based on it */
+    int (*fb_check_var)(struct fb_var_screeninfo *var, struct fb_info *info);
+    /* set the video mode according to par */
+    int (*fb_set_par)(struct fb_info *info);
+    /* cursor control */
+    int (*fb_cursor)(struct fb_info *info, struct fbcursor *cursor);
+    /* set color register */
+    int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
+                        unsigned blue, unsigned transp, struct fb_info *info);
+    /* blank display */
+    int (*fb_blank)(int blank, struct fb_info *info);
+    /* pan display */
+    int (*fb_pan_display)(struct fb_var_screeninfo *var, int con, struct fb_info *info);
+    /* draws a rectangle */
+    void (*fb_fillrect)(struct fb_info *p, struct fb_fillrect *rect); 
+    /* Copy data from area to another */
+    void (*fb_copyarea)(struct fb_info *p, struct fb_copyarea *region); 
+    /* Draws a image to the display */
+    void (*fb_imageblit)(struct fb_info *p, struct fb_image *image);
+    /* perform polling on fb device */
+    int (*fb_poll)(struct fb_info *info, poll_table *wait);
     /* perform fb specific ioctl (optional) */
     int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
 		    unsigned long arg, int con, struct fb_info *info);
@@ -309,6 +386,7 @@
    char *screen_base;                   /* Virtual address */
    struct display *disp;		/* initial display variable */
    struct vc_data *display_fg;		/* Console visible on this display */
+   int currcon;				/* Current VC. */	
    char fontname[40];			/* default font name */
    devfs_handle_t devfs_handle;         /* Devfs handle for new name         */
    devfs_handle_t devfs_lhandle;        /* Devfs handle for compat. symlink  */
@@ -387,6 +465,9 @@
 			  struct fb_info *info);
 extern int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
 			     struct fb_info *info);
+extern void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect); 
+extern void cfb_copyarea(struct fb_info *p, struct fb_copyarea *region); 
+extern void cfb_imageblit(struct fb_info *p, struct fb_image *image);
 
     /*
      *  Helper functions
@@ -400,6 +481,7 @@
 extern int fbgen_switch(int con, struct fb_info *info);
 extern void fbgen_blank(int blank, struct fb_info *info);
 
+extern void fbgen2_set_disp(int con, struct fb_info *info);
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);

