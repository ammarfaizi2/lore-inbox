Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266227AbUBDBMf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 20:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUBDBMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 20:12:35 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:34831 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266227AbUBDBMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 20:12:07 -0500
Date: Wed, 4 Feb 2004 01:12:04 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: fb.h header fix.
Message-ID: <Pine.LNX.4.44.0402040109570.11656-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The XFree86 fbdev server build breaks with the current fb.h. This patch 
fixes that.

--- linus-2.6/include/linux/fb.h	2004-01-27 19:50:11.000000000 -0800
+++ fbdev-2.6/include/linux/fb.h	2004-01-30 18:09:12.000000000 -0800
@@ -1,10 +1,7 @@
 #ifndef _LINUX_FB_H
 #define _LINUX_FB_H
 
-#include <linux/tty.h>
-#include <linux/workqueue.h>
 #include <asm/types.h>
-#include <asm/io.h>
 
 /* Definitions of frame buffers						*/
 
@@ -326,32 +323,49 @@
 	struct fb_image	image;	/* Cursor image */
 };
 
+#ifdef __KERNEL__
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/tty.h>
+#include <linux/device.h>
+#include <linux/workqueue.h>
+#include <linux/devfs_fs_kernel.h>
+#include <linux/notifier.h>
+#include <asm/io.h>
+
+struct vm_area_struct;
+struct fb_info;
+struct device;
+struct file;
+
+/*
+ * Pixmap structure definition
+ *
+ * The purpose of this structure is to translate data
+ * from the hardware independent format of fbdev to what
+ * format the hardware needs.
+ */
+
 #define FB_PIXMAP_DEFAULT 1     /* used internally by fbcon */
 #define FB_PIXMAP_SYSTEM  2     /* memory is in system RAM  */
 #define FB_PIXMAP_IO      4     /* memory is iomapped       */
 #define FB_PIXMAP_SYNC    256   /* set if GPU can DMA       */
 
 struct fb_pixmap {
-        __u8  *addr;                      /* pointer to memory             */  
-	__u32 size;                       /* size of buffer in bytes       */
-	__u32 offset;                     /* current offset to buffer      */
-	__u32 buf_align;                  /* byte alignment of each bitmap */
-	__u32 scan_align;                 /* alignment per scanline        */
-	__u32 flags;                      /* see FB_PIXMAP_*               */
+	u8 *addr;		/* pointer to memory                    */
+	u32 size;		/* size of buffer in bytes              */
+	u32 offset;		/* current offset to buffer             */
+	u32 buf_align;		/* byte alignment of each bitmap        */
+	u32 scan_align;		/* alignment per scanline               */
+	u32 access_align;	/* alignment per read/write             */
+	u32 flags;		/* see FB_PIXMAP_*                      */
 					  /* access methods                */
 	void (*outbuf)(u8 *dst, u8 *addr, unsigned int size); 
 	u8   (*inbuf) (u8 *addr);
 	spinlock_t lock;                  /* spinlock                      */
 	atomic_t count;
 };
-#ifdef __KERNEL__
-
-#include <linux/fs.h>
-#include <linux/init.h>
-
-struct fb_info;
-struct vm_area_struct;
-struct file;
 
     /*
      *  Frame buffer operations
@@ -362,37 +376,60 @@
     struct module *owner;
     int (*fb_open)(struct fb_info *info, int user);
     int (*fb_release)(struct fb_info *info, int user);
+
     /* For framebuffers with strange non linear layouts */	
-    ssize_t (*fb_read)(struct file *file, char *buf, size_t count, loff_t *ppos);
-    ssize_t (*fb_write)(struct file *file, const char *buf, size_t count, loff_t *ppos);	
-    /* checks var and creates a par based on it */
-    int (*fb_check_var)(struct fb_var_screeninfo *var, struct fb_info *info);
-    /* set the video mode according to par */
+	ssize_t(*fb_read) (struct file * file, char *buf, size_t count,
+			   loff_t * ppos);
+	ssize_t(*fb_write) (struct file * file, const char *buf,
+			    size_t count, loff_t * ppos);
+	
+	/* checks var and eventually tweaks it to something supported, 
+	 * DO NOT MODIFY PAR */
+	int (*fb_check_var) (struct fb_var_screeninfo * var,
+			     struct fb_info * info);
+	/* set the video mode according to info->var */
     int (*fb_set_par)(struct fb_info *info);
+
     /* set color register */
     int (*fb_setcolreg)(unsigned regno, unsigned red, unsigned green,
-                        unsigned blue, unsigned transp, struct fb_info *info);
+			     unsigned blue, unsigned transp,
+			     struct fb_info * info);
+
     /* blank display */
     int (*fb_blank)(int blank, struct fb_info *info);
+
     /* pan display */
-    int (*fb_pan_display)(struct fb_var_screeninfo *var, struct fb_info *info);
+	int (*fb_pan_display) (struct fb_var_screeninfo * var,
+			       struct fb_info * info);
+
     /* draws a rectangle */
-    void (*fb_fillrect)(struct fb_info *info, const struct fb_fillrect *rect); 
+	void (*fb_fillrect) (struct fb_info * info,
+			     const struct fb_fillrect * rect);
     /* Copy data from area to another */
-    void (*fb_copyarea)(struct fb_info *info,const struct fb_copyarea *region); 
+	void (*fb_copyarea) (struct fb_info * info,
+			     const struct fb_copyarea * region);
     /* Draws a image to the display */
-    void (*fb_imageblit)(struct fb_info *info, const struct fb_image *image);
+	void (*fb_imageblit) (struct fb_info * info,
+			      const struct fb_image * image);
+
     /* Draws cursor */
-    int (*fb_cursor)(struct fb_info *info, struct fb_cursor *cursor);
+	int (*fb_cursor) (struct fb_info * info,
+			  struct fb_cursor * cursor);
+
     /* Rotates the display */
     void (*fb_rotate)(struct fb_info *info, int angle);
+
     /* wait for blit idle, optional */
     int (*fb_sync)(struct fb_info *info);		
+
     /* perform fb specific ioctl (optional) */
-    int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
-		    unsigned long arg, struct fb_info *info);
+	int (*fb_ioctl) (struct inode * inode, struct file * file,
+			 unsigned int cmd, unsigned long arg,
+			 struct fb_info * info);
+
     /* perform fb specific mmap */
-    int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
+	int (*fb_mmap) (struct fb_info * info, struct file * file,
+			struct vm_area_struct * vma);
 };
 
 struct fb_info {
@@ -405,7 +442,7 @@
    struct fb_monspecs monspecs;         /* Current Monitor specs */
    struct fb_cursor cursor;		/* Current cursor */	
    struct work_struct queue;		/* Framebuffer event queue */
-   struct fb_pixmap pixmap;	        /* Current pixmap */
+	struct fb_pixmap pixmap;	/* Image Hardware Mapper */
    struct fb_cmap cmap;                 /* Current cmap */
    struct fb_ops *fbops;
    char *screen_base;                   /* Virtual address */
@@ -438,7 +475,7 @@
 #define fb_writeq sbus_writeq
 #define fb_memset sbus_memset_io
 
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || defined(__powerpc__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
@@ -482,11 +519,12 @@
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern u32 fb_get_buffer_offset(struct fb_info *info, u32 size);
-extern void move_buf_unaligned(struct fb_info *info, u8 *dst, u8 *src, u32 d_pitch,
-			     	u32 height, u32 mask, u32 shift_high, u32 shift_low,
-				u32 mod, u32 idx);
-extern void move_buf_aligned(struct fb_info *info, u8 *dst, u8 *src, u32 d_pitch,
-			     u32 s_pitch, u32 height);
+extern void move_buf_unaligned(struct fb_info *info, u8 * dst, u8 * src,
+				u32 d_pitch, u32 height, u32 mask,
+				u32 shift_high, u32 shift_low, u32 mod,
+				u32 idx);
+extern void move_buf_aligned(struct fb_info *info, u8 * dst, u8 * src,
+				u32 d_pitch, u32 s_pitch, u32 height);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 
@@ -517,8 +555,7 @@
 /* drivers/video/fbcmap.c */
 extern int fb_alloc_cmap(struct fb_cmap *cmap, int len, int transp);
 extern void fb_dealloc_cmap(struct fb_cmap *cmap);
-extern int fb_copy_cmap(struct fb_cmap *from, struct fb_cmap *to,
-			int fsfromto);
+extern int fb_copy_cmap(struct fb_cmap *from, struct fb_cmap *to, int fsfromto);
 extern int fb_set_cmap(struct fb_cmap *cmap, int kspc, struct fb_info *fb_info);
 extern struct fb_cmap *fb_default_cmap(int len);
 extern void fb_invert_cmaps(void);
@@ -541,7 +578,8 @@
 
 #ifdef MODULE
 static inline int fb_find_mode(struct fb_var_screeninfo *var,
-			       struct fb_info *info, const char *mode_option,
+			       struct fb_info *info,
+			       const char *mode_option,
 			       const struct fb_videomode *db,
 			       unsigned int dbsize,
 			       const struct fb_videomode *default_mode,
@@ -568,7 +606,8 @@
 }
 #else
 extern int __init fb_find_mode(struct fb_var_screeninfo *var,
-			       struct fb_info *info, const char *mode_option,
+			       struct fb_info *info,
+			       const char *mode_option,
 			       const struct fb_videomode *db,
 			       unsigned int dbsize,
 			       const struct fb_videomode *default_mode,

