Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313260AbSDOU5m>; Mon, 15 Apr 2002 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313261AbSDOU5m>; Mon, 15 Apr 2002 16:57:42 -0400
Received: from www.transvirtual.com ([206.14.214.140]:17166 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S313260AbSDOU5l>; Mon, 15 Apr 2002 16:57:41 -0400
Date: Mon, 15 Apr 2002 13:57:20 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fbdev api cleanup.
Message-ID: <Pine.LNX.4.10.10204151356130.1204-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch is the start of the cleanup of the fbdev layer. It has been
approved by Geert and has been tested for some time in the Dave Jones
tree. Please apply it.

   . ---
   |o_o |
   |:_/ |   Give Micro$oft the Bird!!!!
  //   \ \  Use Linux!!!!
 (|     | )
 /'_   _/`\
 ___)=(___/

--- linux-2.5.7/include/linux/fb.h	Thu Mar 14 13:24:26 2002
+++ linux/include/linux/fb.h	Wed Apr  3 12:53:56 2002
@@ -253,19 +253,52 @@
 	__u32 reserved[4];		/* reserved for future compatibility */
 };
 
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
 extern int GET_FB_IDX(kdev_t rdev);
 #else
-#define GET_FB_IDX(node)	(MINOR(node))
+#define GET_FB_IDX(node)	(minor(node))
 #endif
 
 #include <linux/fs.h>
+#include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 
-
 struct fb_info;
 struct fb_info_gen;
 struct vm_area_struct;
@@ -295,9 +328,25 @@
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
+    /* set color register */
+    int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
+                        unsigned blue, unsigned transp, struct fb_info *info);
+    /* blank display */
+    int (*fb_blank)(int blank, struct fb_info *info);
+    /* pan display */
+    int (*fb_pan_display)(struct fb_var_screeninfo *var, int con, struct fb_info *info);
+    /* draws a rectangle */
+    void (*fb_fillrect)(struct fb_info *info, struct fb_fillrect *rect); 
+    /* Copy data from area to another */
+    void (*fb_copyarea)(struct fb_info *info, struct fb_copyarea *region); 
+    /* Draws a image to the display */
+    void (*fb_imageblit)(struct fb_info *info, struct fb_image *image);
+    /* perform polling on fb device */
+    int (*fb_poll)(struct fb_info *info, poll_table *wait);
     /* perform fb specific ioctl (optional) */
     int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
 		    unsigned long arg, int con, struct fb_info *info);
@@ -321,6 +370,7 @@
    char *screen_base;                   /* Virtual address */
    struct display *disp;		/* initial display variable */
    struct vc_data *display_fg;		/* Console visible on this display */
+   int currcon;				/* Current VC. */	
    char fontname[40];			/* default font name */
    devfs_handle_t devfs_handle;         /* Devfs handle for new name         */
    devfs_handle_t devfs_lhandle;        /* Devfs handle for compat. symlink  */
@@ -389,16 +439,29 @@
 
 extern int fbgen_get_fix(struct fb_fix_screeninfo *fix, int con,
 			 struct fb_info *info);
+extern int gen_get_fix(struct fb_fix_screeninfo *fix, int con,
+		       struct fb_info *info);
 extern int fbgen_get_var(struct fb_var_screeninfo *var, int con,
 			 struct fb_info *info);
+extern int gen_get_var(struct fb_var_screeninfo *var, int con,
+		       struct fb_info *info);
 extern int fbgen_set_var(struct fb_var_screeninfo *var, int con,
 			 struct fb_info *info);
+extern int gen_set_var(struct fb_var_screeninfo *var, int con,
+		       struct fb_info *info);
 extern int fbgen_get_cmap(struct fb_cmap *cmap, int kspc, int con,
 			  struct fb_info *info);
+extern int gen_get_cmap(struct fb_cmap *cmap, int kspc, int con,
+			struct fb_info *info);
 extern int fbgen_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 			  struct fb_info *info);
+extern int gen_set_cmap(struct fb_cmap *cmap, int kspc, int con,
+			struct fb_info *info);
 extern int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
 			     struct fb_info *info);
+extern void cfb_fillrect(struct fb_info *info, struct fb_fillrect *rect); 
+extern void cfb_copyarea(struct fb_info *info, struct fb_copyarea *region); 
+extern void cfb_imageblit(struct fb_info *info, struct fb_image *image);
 
     /*
      *  Helper functions
@@ -409,9 +472,12 @@
 extern void fbgen_set_disp(int con, struct fb_info_gen *info);
 extern void fbgen_install_cmap(int con, struct fb_info_gen *info);
 extern int fbgen_update_var(int con, struct fb_info *info);
+extern int gen_update_var(int con, struct fb_info *info);
 extern int fbgen_switch(int con, struct fb_info *info);
 extern void fbgen_blank(int blank, struct fb_info *info);
+extern int gen_switch(int con, struct fb_info *info);
 
+extern void gen_set_disp(int con, struct fb_info *info);
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);

