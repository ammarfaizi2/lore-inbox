Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269109AbUIRDrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269109AbUIRDrg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 23:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUIRDrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 23:47:35 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:60808 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S269109AbUIRDr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 23:47:28 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/4] fbdev: Add iomem annotations to fbmem.c
Date: Sat, 18 Sep 2004 11:47:57 +0800
User-Agent: KMail/1.5.4
Cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200409181134.32510.adaplas@hotpop.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add iomem annotations to fbmem.c

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

fbmem.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff -uprN linux-2.6.9-rc2-mm1-orig/drivers/video/fbmem.c linux-2.6.9-rc2-mm1/drivers/video/fbmem.c
--- linux-2.6.9-rc2-mm1-orig/drivers/video/fbmem.c	2004-09-16 19:40:05.000000000 +0800
+++ linux-2.6.9-rc2-mm1/drivers/video/fbmem.c	2004-09-18 11:25:10.855986768 +0800
@@ -507,7 +507,8 @@ fb_read(struct file *file, char __user *
 	struct inode *inode = file->f_dentry->d_inode;
 	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
-	u32 *buffer, *dst, *src;
+	u32 *buffer, *dst;
+	u32 __iomem *src;
 	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
@@ -537,7 +538,7 @@ fb_read(struct file *file, char __user *
 	if (!buffer)
 		return -ENOMEM;
 
-	src = (u32 *) (info->screen_base + p);
+	src = (u32 __iomem *) (info->screen_base + p);
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
@@ -549,12 +550,12 @@ fb_read(struct file *file, char __user *
 			*dst++ = fb_readl(src++);
 		if (c & 3) {
 			u8 *dst8 = (u8 *) dst;
-			u8 *src8 = (u8 *) src;
+			u8 __iomem *src8 = (u8 __iomem *) src;
 
 			for (i = c & 3; i--;)
 				*dst8++ = fb_readb(src8++);
 
-			src = (u32 *) src8;
+			src = (u32 __iomem *) src8;
 		}
 
 		if (copy_to_user(buf, buffer, c)) {
@@ -578,7 +579,8 @@ fb_write(struct file *file, const char _
 	struct inode *inode = file->f_dentry->d_inode;
 	int fbidx = iminor(inode);
 	struct fb_info *info = registered_fb[fbidx];
-	u32 *buffer, *dst, *src;
+	u32 *buffer, *src;
+	u32 __iomem *dst;
 	int c, i, cnt = 0, err;
 	unsigned long total_size;
 
@@ -610,7 +612,7 @@ fb_write(struct file *file, const char _
 	if (!buffer)
 		return -ENOMEM;
 
-	dst = (u32 *) (info->screen_base + p);
+	dst = (u32 __iomem *) (info->screen_base + p);
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
@@ -626,12 +628,12 @@ fb_write(struct file *file, const char _
 			fb_writel(*src++, dst++);
 		if (c & 3) {
 			u8 *src8 = (u8 *) src;
-			u8 *dst8 = (u8 *) dst;
+			u8 __iomem *dst8 = (u8 __iomem *) dst;
 
 			for (i = c & 3; i--; )
 				fb_writeb(*src8++, dst8++);
 
-			dst = (u32 *) dst8;
+			dst = (u32 __iomem *) dst8;
 		}
 		*ppos += c;
 		buf += c;
@@ -657,7 +659,8 @@ fb_load_cursor_image(struct fb_info *inf
 	u8 *data = (u8 *) info->cursor.image.data;
 
 	if (info->sprite.outbuf)
-	    info->sprite.outbuf(info, info->sprite.addr, data, width);
+	    info->sprite.outbuf(info, info->sprite.addr, data,
+				width);
 	else
 	    memcpy(info->sprite.addr, data, width);
 }
@@ -851,20 +854,28 @@ int
 fb_blank(struct fb_info *info, int blank)
 {	
 	/* ??? Variable sized stack allocation.  */
-	u16 black[info->cmap.len];
 	struct fb_cmap cmap;
+	u16 *black = NULL;
+	int err = 0;
 	
 	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
 		return 0;
 	if (blank) { 
-		memset(black, 0, info->cmap.len * sizeof(u16));
-		cmap.red = cmap.green = cmap.blue = black;
-		cmap.transp = info->cmap.transp ? black : NULL;
-		cmap.start = info->cmap.start;
-		cmap.len = info->cmap.len;
+		black = kmalloc(sizeof(u16) * info->cmap.len, GFP_KERNEL);
+		if (!black) {
+			memset(black, 0, info->cmap.len * sizeof(u16));
+			cmap.red = cmap.green = cmap.blue = black;
+			cmap.transp = info->cmap.transp ? black : NULL;
+			cmap.start = info->cmap.start;
+			cmap.len = info->cmap.len;
+		}
 	} else
 		cmap = info->cmap;
-	return fb_set_cmap(&cmap, info);
+
+	err = fb_set_cmap(&cmap, info);
+	kfree(black);
+
+	return err;
 }
 
 static int 


