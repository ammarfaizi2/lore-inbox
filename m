Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265973AbUIMEdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265973AbUIMEdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 00:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUIMEdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 00:33:44 -0400
Received: from gate.crashing.org ([63.228.1.57]:23937 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265973AbUIMEdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 00:33:07 -0400
Subject: [PATCH] fbdev/radeonfb: Remove bugus radeonfb_read/write
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linus Torvalds <torvalds@osdl.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Content-Type: text/plain
Message-Id: <1095049802.24290.260.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Sep 2004 14:30:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch kills the bogus radeonfb_read/write routines. In order to do so,
it adds a new member to fb_info, along with screen_base, which is screen_size,
indicating the mapped area. The default fb_read/write will now use that instead
of fix->smem_len if it is non-0, and radeonfb now sets it to the mapped size
of the framebuffer.

Ben.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

===== drivers/video/fbmem.c 1.127 vs edited =====
--- 1.127/drivers/video/fbmem.c	2004-09-08 16:33:07 +10:00
+++ edited/drivers/video/fbmem.c	2004-09-13 14:03:44 +10:00
@@ -506,6 +506,7 @@
 	struct fb_info *info = registered_fb[fbidx];
 	u32 *buffer, *dst, *src;
 	int c, i, cnt = 0, err = 0;
+	unsigned long total_size;
 
 	if (!info || ! info->screen_base)
 		return -ENODEV;
@@ -516,12 +517,16 @@
 	if (info->fbops->fb_read)
 		return info->fbops->fb_read(file, buf, count, ppos);
 	
-	if (p >= info->fix.smem_len)
+	total_size = info->screen_size;
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p >= total_size)
 	    return 0;
-	if (count >= info->fix.smem_len)
-	    count = info->fix.smem_len;
-	if (count + p > info->fix.smem_len)
-		count = info->fix.smem_len - p;
+	if (count >= total_size)
+	    count = total_size;
+	if (count + p > total_size)
+		count = total_size - p;
 
 	cnt = 0;
 	buffer = kmalloc((count > PAGE_SIZE) ? PAGE_SIZE : count,
@@ -572,6 +577,7 @@
 	struct fb_info *info = registered_fb[fbidx];
 	u32 *buffer, *dst, *src;
 	int c, i, cnt = 0, err;
+	unsigned long total_size;
 
 	if (!info || !info->screen_base)
 		return -ENODEV;
@@ -582,13 +588,17 @@
 	if (info->fbops->fb_write)
 		return info->fbops->fb_write(file, buf, count, ppos);
 	
-	if (p > info->fix.smem_len)
+	total_size = info->screen_size;
+	if (total_size == 0)
+		total_size = info->fix.smem_len;
+
+	if (p > total_size)
 	    return -ENOSPC;
-	if (count >= info->fix.smem_len)
-	    count = info->fix.smem_len;
+	if (count >= total_size)
+	    count = total_size;
 	err = 0;
-	if (count + p > info->fix.smem_len) {
-	    count = info->fix.smem_len - p;
+	if (count + p > total_size) {
+	    count = total_size - p;
 	    err = -ENOSPC;
 	}
 	cnt = 0;
===== drivers/video/aty/radeon_base.c 1.27 vs edited =====
--- 1.27/drivers/video/aty/radeon_base.c	2004-09-11 12:08:04 +10:00
+++ edited/drivers/video/aty/radeon_base.c	2004-09-13 14:05:55 +10:00
@@ -1702,68 +1702,6 @@
 }
 
 
-
-static ssize_t radeonfb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	struct inode *inode = file->f_dentry->d_inode;
-	int fbidx = iminor(inode);
-	struct fb_info *info = registered_fb[fbidx];
-	struct radeonfb_info *rinfo = info->par;
-	
-	if (p >= rinfo->mapped_vram)
-	    return 0;
-	if (count >= rinfo->mapped_vram)
-	    count = rinfo->mapped_vram;
-	if (count + p > rinfo->mapped_vram)
-		count = rinfo->mapped_vram - p;
-	radeonfb_sync(info);
-	if (count) {
-	    void __iomem *base_addr;
-
-	    base_addr = info->screen_base;
-	    count -= copy_to_user(buf, base_addr+p, count);	/* Ayee!! */
-	    if (!count)
-		return -EFAULT;
-	    *ppos += count;
-	}
-	return count;
-}
-
-static ssize_t radeonfb_write(struct file *file, const char __user *buf, size_t count,
-			      loff_t *ppos)
-{
-	unsigned long p = *ppos;
-	struct inode *inode = file->f_dentry->d_inode;
-	int fbidx = iminor(inode);
-	struct fb_info *info = registered_fb[fbidx];
-	struct radeonfb_info *rinfo = info->par;
-	int err;
-
-	if (p > rinfo->mapped_vram)
-	    return -ENOSPC;
-	if (count >= rinfo->mapped_vram)
-	    count = rinfo->mapped_vram;
-	err = 0;
-	if (count + p > rinfo->mapped_vram) {
-	    count = rinfo->mapped_vram - p;
-	    err = -ENOSPC;
-	}
-	radeonfb_sync(info);
-	if (count) {
-	    void __iomem *base_addr;
-
-	    base_addr = info->screen_base;
-	    count -= copy_from_user(base_addr+p, buf, count);	/* Ayee!! */
-	    *ppos += count;
-	    err = -EFAULT;
-	}
-	if (count)
-		return count;
-	return err;
-}
-
-
 static struct fb_ops radeonfb_ops = {
 	.owner			= THIS_MODULE,
 	.fb_check_var		= radeonfb_check_var,
@@ -1776,8 +1714,6 @@
 	.fb_fillrect		= radeonfb_fillrect,
 	.fb_copyarea		= radeonfb_copyarea,
 	.fb_imageblit		= radeonfb_imageblit,
-	.fb_read		= radeonfb_read,
-	.fb_write		= radeonfb_write,
 	.fb_cursor		= soft_cursor,
 };
 
@@ -1796,7 +1732,7 @@
 		    | FBINFO_HWACCEL_YPAN;
 	info->fbops = &radeonfb_ops;
 	info->screen_base = rinfo->fb_base;
-
+	info->screen_size = rinfo->mapped_vram;
 	/* Fill fix common fields */
 	strlcpy(info->fix.id, rinfo->name, sizeof(info->fix.id));
         info->fix.smem_start = rinfo->fb_base_phys;
@@ -2242,12 +2178,6 @@
 	}
 
 	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
-
-
-	/* Argh. Scary arch !!! */
-#ifdef CONFIG_PPC64
-	rinfo->fb_base = IO_TOKEN_TO_ADDR(rinfo->fb_base);
-#endif
 
 	/*
 	 * Check for required workaround for PLL accesses
===== include/linux/fb.h 1.82 vs edited =====
--- 1.82/include/linux/fb.h	2004-09-11 12:08:04 +10:00
+++ edited/include/linux/fb.h	2004-09-13 14:01:45 +10:00
@@ -603,6 +603,7 @@
 	struct fb_cmap cmap;		/* Current cmap */
 	struct fb_ops *fbops;
 	char __iomem *screen_base;	/* Virtual address */
+	unsigned long screen_size;	/* Amount of ioremapped VRAM or 0 */ 
 	int currcon;			/* Current VC. */
 	void *pseudo_palette;		/* Fake palette of 16 colors */ 
 #define FBINFO_STATE_RUNNING	0


