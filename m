Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283359AbRK2SI4>; Thu, 29 Nov 2001 13:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283357AbRK2SIr>; Thu, 29 Nov 2001 13:08:47 -0500
Received: from zeus.kernel.org ([204.152.189.113]:34017 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283363AbRK2SI2>;
	Thu, 29 Nov 2001 13:08:28 -0500
Date: Thu, 29 Nov 2001 10:08:18 -0800 (PST)
From: James Simmons <jsimmons@transvirtual.com>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: linux-fbdev-devel@lists.sourceforge.net,
        linuxconsole-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH] Hooks for new fbdev api
In-Reply-To: <A9484F0657A@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.10.10111291005200.2693-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >From what you wrote I assume that cmap.start must be 0 and cmap.len
> some length, and it must be always set, as otherwise it is impossible
> to guess image/mask depth from it.

[snip]...

I figured the cursor stuff would be something to work out more. I
shamefully stoled it from the sun fb implementation. I have another patch
patch for fb.h which removes the cursor stuff until we work something out.


Geert if I have your blessing on this I like to send it off to Linus.

--- linux-2.5.0/include/linux/fb.h	Wed Nov 28 16:43:10 2001
+++ linux/include/linux/fb.h	Thu Nov 29 11:02:26 2001
@@ -241,6 +241,39 @@
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
@@ -250,10 +283,10 @@
 #endif
 
 #include <linux/fs.h>
+#include <linux/poll.h>
 #include <linux/init.h>
 #include <linux/devfs_fs_kernel.h>
 
-
 struct fb_info;
 struct fb_info_gen;
 struct vm_area_struct;
@@ -283,9 +316,25 @@
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
@@ -309,6 +358,7 @@
    char *screen_base;                   /* Virtual address */
    struct display *disp;		/* initial display variable */
    struct vc_data *display_fg;		/* Console visible on this display */
+   int currcon;				/* Current VC. */	
    char fontname[40];			/* default font name */
    devfs_handle_t devfs_handle;         /* Devfs handle for new name         */
    devfs_handle_t devfs_lhandle;        /* Devfs handle for compat. symlink  */
@@ -387,6 +437,9 @@
 			  struct fb_info *info);
 extern int fbgen_pan_display(struct fb_var_screeninfo *var, int con,
 			     struct fb_info *info);
+extern void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect); 
+extern void cfb_copyarea(struct fb_info *p, struct fb_copyarea *region); 
+extern void cfb_imageblit(struct fb_info *p, struct fb_image *image);
 
     /*
      *  Helper functions
@@ -400,6 +453,7 @@
 extern int fbgen_switch(int con, struct fb_info *info);
 extern void fbgen_blank(int blank, struct fb_info *info);
 
+extern void fbgen2_set_disp(int con, struct fb_info *info);
 
 /* drivers/video/fbmem.c */
 extern int register_framebuffer(struct fb_info *fb_info);

