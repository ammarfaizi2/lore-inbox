Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279952AbRK1Svh>; Wed, 28 Nov 2001 13:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279951AbRK1Sv2>; Wed, 28 Nov 2001 13:51:28 -0500
Received: from www.transvirtual.com ([206.14.214.140]:37127 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S279798AbRK1SvN>; Wed, 28 Nov 2001 13:51:13 -0500
Date: Wed, 28 Nov 2001 10:50:59 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: [PATCH] Hooks for new fbdev api
Message-ID: <Pine.LNX.4.10.10111281036200.11130-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

   This is my first public release of the new api of the framebuffer
layer. The basic goal is to remove all the excess duplicate code and to
place all the console related code into fbcon.c. The second goal to allow
the framebuffer layer to exist without the console system. On embedded
devices that lack a keyboard it makes no sense plus it takes up valiable
space to have the VT system compiled in. The 3rd and finally goal is to
allow fbdev driver writing to be easy and yet flexiable.

This patch shows 3 basic things I like to change. 

1) Universal cursor api. This allows the fbcon layer to not be required
   hooks to program the cursor for every type of card avaliable. This
   allows a seperation of fbdev and fbcon. 

2) Move from framebuffer base to more accel engine base. This allows the
   complete removal of console code from the low level framebuffer drivers 
   and we get ride of those god forsaken fbcon-cfb* files. So we end up
   with a huge code reducution and this encourages the driver write to
   write much faster fbdev drivers. Note these our the basic accels needed
   for the fbcon layer. They are not used by userland in anyway. It also
   means you have only 3 basic functions to deal with instead of the 7 of
   struct display_switch.
    
3) Removal of duplicate code. Examples are the fb_cmap functions which are
   basically the same in every driver. So you will be seeing soon a
   fbgen2 that will have the same code that is duplicated over and over
   again in each driver. 

--- /usr/src/linux-2.5.0/include/linux/fb.h	Tue Nov 27 12:29:52 2001
+++ /usr/src/linux/include/linux/fb.h	Wed Nov 28 11:47:29 2001
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
+	__u32 x1;	/* screen-relative */
+	__u32 y1;
+	__u32 width;
+	__u32 height;
+	__u32 color;
+	__u32 rop;
+};
+
+struct fb_image {
+	__u32 width;	/* Size of image */
+	__u32 height;
+	__u16 x;	/* Where to place image */
+	__u16 y;
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
@@ -283,9 +342,29 @@
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
+    void (*fb_fillrect)(struct fb_info *p, int x1, int y1, unsigned int width,
+                        unsigned int height, unsigned long color, int rop);
+    /* Copy data from area to another */
+    void (*fb_copyarea)(struct fb_info *p, int sx, int sy, unsigned int width,
+                        unsigned int height, int dx, int dy);
+    /* Draws a image to the display */
+    void (*fb_imageblit)(struct fb_info *p, struct fb_image *image);
+    /* perform polling on fb device */
+    int (*fb_poll)(struct fb_info *info, poll_table *wait);
     /* perform fb specific ioctl (optional) */
     int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
 		    unsigned long arg, int con, struct fb_info *info);
@@ -309,6 +388,7 @@
    char *screen_base;                   /* Virtual address */
    struct display *disp;		/* initial display variable */
    struct vc_data *display_fg;		/* Console visible on this display */
+   int currcon;				/* Current VC. */	
    char fontname[40];			/* default font name */
    devfs_handle_t devfs_handle;         /* Devfs handle for new name         */
    devfs_handle_t devfs_lhandle;        /* Devfs handle for compat. symlink  */
@@ -387,6 +467,11 @@
 			  struct fb_info *info);
 extern int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
 			     struct fb_info *info);
+extern void cfb_fillrect(struct fb_info *p, int x1, int y1, unsigned int width,
+                         unsigned int rows, unsigned long color, int rop);
+extern void cfb_copyarea(struct fb_info *p, int sx, int sy, unsigned int width,
+                         unsigned int rows, int dx, int dy);
+extern void cfb_imageblit(struct fb_info *p, struct fb_image *image);
 
     /*
      *  Helper functions
@@ -400,6 +485,7 @@
 extern int fbgen_switch(int con, struct fb_info *info);
 extern void fbgen_blank(int blank, struct fb_info *info);
 
+extern void fbgen2_set_disp(int con, struct fb_info *info);
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);

