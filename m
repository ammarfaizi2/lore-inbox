Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265245AbUBOXzo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUBOXzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:55:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:6559 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265245AbUBOXzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:55:38 -0500
Subject: Re: Linux 2.6.3-rc3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: earny@net4u.de
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200402160033.43438.earny@net4u.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org>
	 <200402152357.25751.earny@net4u.de> <1076886481.6960.121.camel@gaston>
	 <200402160033.43438.earny@net4u.de>
Content-Type: text/plain
Message-Id: <1076889243.11392.130.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 16 Feb 2004 10:54:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-02-16 at 10:33, Ernst Herzberg wrote:
> On Montag, 16. Februar 2004 00:08, you wrote:
> 
> > It couldn't mmap the framebuffer, the problem is that you have run out
> > of kernel virtual space. I'll try to find a workaround, but in the
> > meantime, you need to change the lowmem/highmem ratio.

Can you try this patch ?

===== drivers/video/aty/radeon_base.c 1.3 vs edited =====
--- 1.3/drivers/video/aty/radeon_base.c	Sat Feb 14 23:00:22 2004
+++ edited/drivers/video/aty/radeon_base.c	Mon Feb 16 10:53:27 2004
@@ -99,6 +99,8 @@
 #include "ati_ids.h"
 #include "radeonfb.h"		    
 
+#define MAX_MAPPED_VRAM	(2048*2048*4)
+#define MIN_MAPPED_VRAM	(1024*768*1)
 
 #define CHIP_DEF(id, family, flags)					\
 	{ PCI_VENDOR_ID_ATI, id, PCI_ANY_ID, PCI_ANY_ID, 0, 0, (flags) | (CHIP_FAMILY_##family) }
@@ -566,8 +568,9 @@
 		break;
 	}
 
-	do_div(vclk, 1000);
-	xtal = (xtal * denom) / num;
+	vclk *= denom;
+	do_div(vclk, 1000 * num);
+	xtal = vclk; 
 
 	if ((xtal > 26900) && (xtal < 27100))
 		xtal = 2700;
@@ -825,6 +828,9 @@
 		v.xres_virtual = (pitch << 6) / ((v.bits_per_pixel + 1) / 8);
 	}
 
+	if (((v.xres_virtual * v.yres_virtual * nom) / den) > rinfo->mapped_vram)
+		return -EINVAL;
+
 	if (v.xres_virtual < v.xres)
 		v.xres = v.xres_virtual;
 
@@ -1685,6 +1691,67 @@
 
 
 
+static ssize_t radeonfb_read(struct file *file, char *buf, size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
+	struct fb_info *info = registered_fb[fbidx];
+	struct radeonfb_info *rinfo = info->par;
+	
+	if (p >= rinfo->mapped_vram)
+	    return 0;
+	if (count >= rinfo->mapped_vram)
+	    count = rinfo->mapped_vram;
+	if (count + p > rinfo->mapped_vram)
+		count = rinfo->mapped_vram - p;
+	radeonfb_sync(info);
+	if (count) {
+	    char *base_addr;
+
+	    base_addr = info->screen_base;
+	    count -= copy_to_user(buf, base_addr+p, count);
+	    if (!count)
+		return -EFAULT;
+	    *ppos += count;
+	}
+	return count;
+}
+
+static ssize_t radeonfb_write(struct file *file, const char *buf, size_t count,
+			      loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	struct inode *inode = file->f_dentry->d_inode;
+	int fbidx = iminor(inode);
+	struct fb_info *info = registered_fb[fbidx];
+	struct radeonfb_info *rinfo = info->par;
+	int err;
+
+	if (p > rinfo->mapped_vram)
+	    return -ENOSPC;
+	if (count >= rinfo->mapped_vram)
+	    count = rinfo->mapped_vram;
+	err = 0;
+	if (count + p > rinfo->mapped_vram) {
+	    count = rinfo->mapped_vram - p;
+	    err = -ENOSPC;
+	}
+	radeonfb_sync(info);
+	if (count) {
+	    char *base_addr;
+
+	    base_addr = info->screen_base;
+	    count -= copy_from_user(base_addr+p, buf, count);
+	    *ppos += count;
+	    err = -EFAULT;
+	}
+	if (count)
+		return count;
+	return err;
+}
+
+
 static struct fb_ops radeonfb_ops = {
 	.owner			= THIS_MODULE,
 	.fb_check_var		= radeonfb_check_var,
@@ -1697,6 +1764,8 @@
 	.fb_fillrect		= radeonfb_fillrect,
 	.fb_copyarea		= radeonfb_copyarea,
 	.fb_imageblit		= radeonfb_imageblit,
+	.fb_read		= radeonfb_read,
+	.fb_write		= radeonfb_write,
 	.fb_cursor		= soft_cursor,
 };
 
@@ -2121,11 +2190,27 @@
 
 	RTRACE("radeonfb: probed %s %ldk videoram\n", (rinfo->ram_type), (rinfo->video_ram/1024));
 
-	rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys, rinfo->video_ram);
+	rinfo->mapped_vram = MAX_MAPPED_VRAM;
+	if (rinfo->video_ram < rinfo->mapped_vram)
+		rinfo->mapped_vram = rinfo->video_ram;
+	for (;;) {
+		rinfo->fb_base = (unsigned long) ioremap (rinfo->fb_base_phys,
+							  rinfo->mapped_vram);
+		if (rinfo->fb_base == 0 && rinfo->mapped_vram > MIN_MAPPED_VRAM) {
+			rinfo->mapped_vram /= 2;
+			continue;
+		}
+		break;
+	}
+
 	if (!rinfo->fb_base) {
 		printk (KERN_ERR "radeonfb: cannot map FB\n");
 		goto unmap_rom;
 	}
+
+	RTRACE("radeonfb: mapped %ldk videoram\n", rinfo->mapped_vram/1024);
+
+
 	/* Argh. Scary arch !!! */
 #ifdef CONFIG_PPC64
 	rinfo->fb_base = IO_TOKEN_TO_ADDR(rinfo->fb_base);
===== drivers/video/aty/radeonfb.h 1.2 vs edited =====
--- 1.2/drivers/video/aty/radeonfb.h	Fri Feb 13 03:10:47 2004
+++ edited/drivers/video/aty/radeonfb.h	Mon Feb 16 10:50:42 2004
@@ -282,6 +282,7 @@
 	u8			family;
 	u8			rev;
 	unsigned long		video_ram;
+	unsigned long		mapped_vram;
 
 	int			pitch, bpp, depth;
 


