Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030195AbWADJpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030195AbWADJpK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 04:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWADJpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 04:45:09 -0500
Received: from verein.lst.de ([213.95.11.210]:55241 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1030195AbWADJpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 04:45:06 -0500
Date: Wed, 4 Jan 2006 10:44:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sanitize ->fb_ioctl prototype
Message-ID: <20060104094446.GA26944@lst.de>
References: <20051111083457.GA26175@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051111083457.GA26175@lst.de>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3.849 () BAYES_00,DOMAIN_BODY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2005 at 09:34:57AM +0100, Christoph Hellwig wrote:
> The ioctl and file arguments to ->fb_ioctl are totally unused and there's
> not reason a driver should need them.
> 
> Also update the ->fb_compat_ioctl prototype to be the same as ->fb_ioctl.

ping?

Index: linux-2.6/drivers/video/amifb.c
===================================================================
--- linux-2.6.orig/drivers/video/amifb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/amifb.c	2005-11-10 01:28:56.000000000 +0100
@@ -1129,9 +1129,7 @@
 			   const struct fb_copyarea *region);
 static void amifb_imageblit(struct fb_info *info,
 			    const struct fb_image *image);
-static int amifb_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg,
-		       struct fb_info *info);
+static int amifb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg);
 
 
 	/*
@@ -2170,9 +2168,8 @@
 	 * Amiga Frame Buffer Specific ioctls
 	 */
 
-static int amifb_ioctl(struct inode *inode, struct file *file,
-		       unsigned int cmd, unsigned long arg,
-		       struct fb_info *info)
+static int amifb_ioctl(struct fb_info *info,
+		       unsigned int cmd, unsigned long arg)
 {
 	union {
 		struct fb_fix_cursorinfo fix;
Index: linux-2.6/drivers/video/arcfb.c
===================================================================
--- linux-2.6.orig/drivers/video/arcfb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/arcfb.c	2005-11-10 01:28:56.000000000 +0100
@@ -397,9 +397,8 @@
 				image->height);
 }
 
-static int arcfb_ioctl(struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg,
-			  struct fb_info *info)
+static int arcfb_ioctl(struct fb_info *info,
+			  unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	struct arcfb_par *par = info->par;
Index: linux-2.6/drivers/video/atafb.c
===================================================================
--- linux-2.6.orig/drivers/video/atafb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/atafb.c	2005-11-10 01:28:56.000000000 +0100
@@ -2571,8 +2571,7 @@
 }
 
 static int
-atafb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-	       unsigned long arg, int con, struct fb_info *info)
+atafb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	switch (cmd) {
 #ifdef FBCMD_GET_CURRENTPAR
Index: linux-2.6/drivers/video/aty/aty128fb.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/aty128fb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/aty/aty128fb.c	2005-11-10 01:28:56.000000000 +0100
@@ -431,8 +431,7 @@
 static int aty128fb_pan_display(struct fb_var_screeninfo *var,
 			   struct fb_info *fb);
 static int aty128fb_blank(int blank, struct fb_info *fb);
-static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, struct fb_info *info);
+static int aty128fb_ioctl(struct fb_info *info, u_int cmd);
 static int aty128fb_sync(struct fb_info *info);
 
     /*
@@ -2108,8 +2107,7 @@
 /* in param: u32*	backlight value: 0 to 15 */
 #define FBIO_ATY128_SET_MIRROR	_IOW('@', 2, __u32)
 
-static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, struct fb_info *info)
+static int aty128fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct aty128fb_par *par = info->par;
 	u32 value;
Index: linux-2.6/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/atyfb_base.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/aty/atyfb_base.c	2005-11-10 01:28:56.000000000 +0100
@@ -229,8 +229,7 @@
 	u_int transp, struct fb_info *info);
 static int atyfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
-static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-	u_long arg, struct fb_info *info);
+static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
 extern void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 extern void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void atyfb_imageblit(struct fb_info *info, const struct fb_image *image);
@@ -1706,8 +1705,7 @@
 #define FBIO_WAITFORVSYNC _IOW('F', 0x20, __u32)
 #endif
 
-static int atyfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-	u_long arg, struct fb_info *info)
+static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 #ifdef __sparc__
Index: linux-2.6/drivers/video/aty/radeon_base.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/radeon_base.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/aty/radeon_base.c	2005-11-10 01:28:56.000000000 +0100
@@ -864,8 +864,8 @@
 }
 
 
-static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
-                           unsigned long arg, struct fb_info *info)
+static int radeonfb_ioctl (struct fb_info *info, unsigned int cmd,
+                           unsigned long arg)
 {
         struct radeonfb_info *rinfo = info->par;
 	unsigned int tmp;
Index: linux-2.6/drivers/video/bw2.c
===================================================================
--- linux-2.6.orig/drivers/video/bw2.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/bw2.c	2005-11-10 01:28:56.000000000 +0100
@@ -36,8 +36,7 @@
 static int bw2_blank(int, struct fb_info *);
 
 static int bw2_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int bw2_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int bw2_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -179,8 +178,7 @@
 				  vma);
 }
 
-static int bw2_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int bw2_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct bw2_par *par = (struct bw2_par *) info->par;
 
Index: linux-2.6/drivers/video/cg14.c
===================================================================
--- linux-2.6.orig/drivers/video/cg14.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/cg14.c	2005-11-10 01:28:56.000000000 +0100
@@ -32,8 +32,7 @@
 			 unsigned, struct fb_info *);
 
 static int cg14_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int cg14_ioctl(struct inode *, struct file *, unsigned int,
-		      unsigned long, struct fb_info *);
+static int cg14_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int cg14_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -275,8 +274,7 @@
 				  par->iospace, vma);
 }
 
-static int cg14_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		      unsigned long arg, struct fb_info *info)
+static int cg14_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct cg14_par *par = (struct cg14_par *) info->par;
 	struct cg14_regs __iomem *regs = par->regs;
Index: linux-2.6/drivers/video/cg3.c
===================================================================
--- linux-2.6.orig/drivers/video/cg3.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/cg3.c	2005-11-10 01:28:56.000000000 +0100
@@ -34,8 +34,7 @@
 static int cg3_blank(int, struct fb_info *);
 
 static int cg3_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int cg3_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int cg3_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -238,8 +237,7 @@
 				  vma);
 }
 
-static int cg3_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int cg3_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct cg3_par *par = (struct cg3_par *) info->par;
 
Index: linux-2.6/drivers/video/cg6.c
===================================================================
--- linux-2.6.orig/drivers/video/cg6.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/cg6.c	2005-11-10 01:28:56.000000000 +0100
@@ -37,8 +37,7 @@
 static void cg6_fillrect(struct fb_info *, const struct fb_fillrect *);
 static int cg6_sync(struct fb_info *);
 static int cg6_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int cg6_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int cg6_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -532,8 +531,7 @@
 				  vma);
 }
 
-static int cg6_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int cg6_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct cg6_par *par = (struct cg6_par *) info->par;
 
Index: linux-2.6/drivers/video/fbmem.c
===================================================================
--- linux-2.6.orig/drivers/video/fbmem.c	2005-11-10 01:26:31.000000000 +0100
+++ linux-2.6/drivers/video/fbmem.c	2005-11-10 01:30:13.000000000 +0100
@@ -929,7 +929,7 @@
 	default:
 		if (fb->fb_ioctl == NULL)
 			return -EINVAL;
-		return fb->fb_ioctl(inode, file, cmd, arg, info);
+		return fb->fb_ioctl(info, cmd, arg);
 	}
 }
 
@@ -1079,7 +1079,7 @@
 
 	default:
 		if (fb->fb_compat_ioctl)
-			ret = fb->fb_compat_ioctl(file, cmd, arg, info);
+			ret = fb->fb_compat_ioctl(cmd, arg, info);
 		break;
 	}
 	unlock_kernel();
Index: linux-2.6/drivers/video/ffb.c
===================================================================
--- linux-2.6.orig/drivers/video/ffb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/ffb.c	2005-11-10 01:28:56.000000000 +0100
@@ -38,8 +38,7 @@
 static void ffb_copyarea(struct fb_info *, const struct fb_copyarea *);
 static int ffb_sync(struct fb_info *);
 static int ffb_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int ffb_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int ffb_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int ffb_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -846,8 +845,7 @@
 				  0, vma);
 }
 
-static int ffb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int ffb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct ffb_par *par = (struct ffb_par *) info->par;
 
Index: linux-2.6/drivers/video/imsttfb.c
===================================================================
--- linux-2.6.orig/drivers/video/imsttfb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/imsttfb.c	2005-11-10 01:28:56.000000000 +0100
@@ -1263,8 +1263,7 @@
 #define FBIMSTT_GETIDXREG	0x545406
 
 static int
-imsttfb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-	      u_long arg, struct fb_info *info)
+imsttfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct imstt_par *par = (struct imstt_par *) info->par;
 	void __user *argp = (void __user *)arg;
Index: linux-2.6/drivers/video/intelfb/intelfbdrv.c
===================================================================
--- linux-2.6.orig/drivers/video/intelfb/intelfbdrv.c	2005-11-10 01:26:31.000000000 +0100
+++ linux-2.6/drivers/video/intelfb/intelfbdrv.c	2005-11-10 01:28:56.000000000 +0100
@@ -160,9 +160,8 @@
 
 static int intelfb_sync(struct fb_info *info);
 
-static int intelfb_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, unsigned long arg,
-			 struct fb_info *info);
+static int intelfb_ioctl(struct fb_info *info,
+			 unsigned int cmd, unsigned long arg);
 
 static int __devinit intelfb_pci_register(struct pci_dev *pdev,
 					  const struct pci_device_id *ent);
@@ -1391,8 +1390,7 @@
 
 /* When/if we have our own ioctls. */
 static int
-intelfb_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-	      unsigned long arg, struct fb_info *info)
+intelfb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	int retval = 0;
 
Index: linux-2.6/drivers/video/kyro/fbdev.c
===================================================================
--- linux-2.6.orig/drivers/video/kyro/fbdev.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/kyro/fbdev.c	2005-11-10 01:28:56.000000000 +0100
@@ -586,9 +586,8 @@
 }
 #endif
 
-static int kyrofb_ioctl(struct inode *inode, struct file *file,
-			unsigned int cmd, unsigned long arg,
-			struct fb_info *info)
+static int kyrofb_ioctl(struct fb_info *info,
+			unsigned int cmd, unsigned long arg)
 {
 	overlay_create ol_create;
 	overlay_viewport_set ol_viewport_set;
Index: linux-2.6/drivers/video/leo.c
===================================================================
--- linux-2.6.orig/drivers/video/leo.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/leo.c	2005-11-10 01:28:56.000000000 +0100
@@ -33,8 +33,7 @@
 static int leo_blank(int, struct fb_info *);
 
 static int leo_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int leo_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int leo_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int leo_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -371,8 +370,7 @@
 				  vma);
 }
 
-static int leo_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int leo_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct leo_par *par = (struct leo_par *) info->par;
 
Index: linux-2.6/drivers/video/matrox/matroxfb_base.c
===================================================================
--- linux-2.6.orig/drivers/video/matrox/matroxfb_base.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/matrox/matroxfb_base.c	2005-11-10 01:28:56.000000000 +0100
@@ -865,9 +865,8 @@
 	.name	 = "Panellink output",
 };
 
-static int matroxfb_ioctl(struct inode *inode, struct file *file,
-			  unsigned int cmd, unsigned long arg,
-			  struct fb_info *info)
+static int matroxfb_ioctl(struct fb_info *info,
+			  unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
 	MINFO_FROM_INFO(info);
Index: linux-2.6/drivers/video/matrox/matroxfb_crtc2.c
===================================================================
--- linux-2.6.orig/drivers/video/matrox/matroxfb_crtc2.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/matrox/matroxfb_crtc2.c	2005-11-10 01:28:56.000000000 +0100
@@ -419,11 +419,10 @@
 	return 0;
 }
 
-static int matroxfb_dh_ioctl(struct inode* inode,
-		struct file* file,
+static int matroxfb_dh_ioctl(struct fb_info *info,
 		unsigned int cmd,
-		unsigned long arg,
-		struct fb_info* info) {
+		unsigned long arg)
+{
 #define m2info (container_of(info, struct matroxfb_dh_fb_info, fbcon))
 	MINFO_FROM(m2info->primary_dev);
 
@@ -457,7 +456,7 @@
 		case MATROXFB_GET_OUTPUT_MODE:
 		case MATROXFB_GET_ALL_OUTPUTS:
 			{
-				return ACCESS_FBINFO(fbcon.fbops)->fb_ioctl(inode, file, cmd, arg, &ACCESS_FBINFO(fbcon));
+				return ACCESS_FBINFO(fbcon.fbops)->fb_ioctl(&ACCESS_FBINFO(fbcon), cmd, arg);
 			}
 		case MATROXFB_SET_OUTPUT_CONNECTION:
 			{
Index: linux-2.6/drivers/video/p9100.c
===================================================================
--- linux-2.6.orig/drivers/video/p9100.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/p9100.c	2005-11-10 01:28:56.000000000 +0100
@@ -32,8 +32,7 @@
 static int p9100_blank(int, struct fb_info *);
 
 static int p9100_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int p9100_ioctl(struct inode *, struct file *, unsigned int,
-		       unsigned long, struct fb_info *);
+static int p9100_ioctl(struct fb_info *, unsigned int, unsigned long);
 
 /*
  *  Frame buffer operations
@@ -230,8 +229,8 @@
 				  vma);
 }
 
-static int p9100_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		       unsigned long arg, struct fb_info *info)
+static int p9100_ioctl(struct fb_info *info, unsigned int cmd,
+		       unsigned long arg)
 {
 	struct p9100_par *par = (struct p9100_par *) info->par;
 
Index: linux-2.6/drivers/video/pm3fb.c
===================================================================
--- linux-2.6.orig/drivers/video/pm3fb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/pm3fb.c	2005-11-10 01:28:56.000000000 +0100
@@ -657,9 +657,7 @@
 static void pm3fb_detect(void);
 static int pm3fb_pan_display(const struct fb_var_screeninfo *var,
 			     struct fb_info_gen *info);
-static int pm3fb_ioctl(struct inode *inode, struct file *file,
-                       u_int cmd, u_long arg, int con,
-		       struct fb_info *info);
+static int pm3fb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
 
 
 /* the struct that hold them together */
@@ -3438,9 +3436,7 @@
 	return 0;
 }
 
-static int pm3fb_ioctl(struct inode *inode, struct file *file,
-                       u_int cmd, u_long arg, int con,
-		       struct fb_info *info)
+static int pm3fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct pm3fb_info *l_fb_info = (struct pm3fb_info *) info;
 	u32 cm, i;
Index: linux-2.6/drivers/video/pmag-aa-fb.c
===================================================================
--- linux-2.6.orig/drivers/video/pmag-aa-fb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/pmag-aa-fb.c	2005-11-10 01:28:56.000000000 +0100
@@ -299,8 +299,7 @@
 		return -EINVAL;
 }
 
-static int aafb_ioctl(struct inode *inode, struct file *file, u32 cmd,
-		      unsigned long arg, int con, struct fb_info *info)
+static int aafb_ioctl(struct fb_info *info, u32 cmd, unsigned long arg)
 {
 	/* TODO: Not yet implemented */
 	return -ENOIOCTLCMD;
Index: linux-2.6/drivers/video/radeonfb.c
===================================================================
--- linux-2.6.orig/drivers/video/radeonfb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/radeonfb.c	2005-11-10 01:28:56.000000000 +0100
@@ -1497,8 +1497,8 @@
 }
 
 
-static int radeonfb_ioctl (struct inode *inode, struct file *file, unsigned int cmd,
-                           unsigned long arg, struct fb_info *info)
+static int radeonfb_ioctl (struct fb_info *info, unsigned int cmd,
+                           unsigned long arg)
 {
         struct radeonfb_info *rinfo = (struct radeonfb_info *) info;
 	unsigned int tmp;
Index: linux-2.6/drivers/video/sis/sis_main.c
===================================================================
--- linux-2.6.orig/drivers/video/sis/sis_main.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/sis/sis_main.c	2005-11-10 01:28:56.000000000 +0100
@@ -1744,12 +1744,8 @@
 /* ----------- FBDev related routines for all series ---------- */
 
 static int
-sisfb_ioctl(struct inode *inode, struct file *file,
-            unsigned int cmd, unsigned long arg,
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-	    int con,
-#endif
-	    struct fb_info *info)
+sisfb_ioctl(struct fb_info *info,
+            unsigned int cmd, unsigned long arg)
 {
 	struct sis_video_info	*ivideo = (struct sis_video_info *)info->par;
 	struct sis_memreq	sismemreq;
@@ -1924,19 +1920,6 @@
 	return 0;
 }
 
-#ifdef SIS_NEW_CONFIG_COMPAT
-static long
-sisfb_compat_ioctl(struct file *f, unsigned int cmd, unsigned long arg, struct fb_info *info)
-{
-	int ret;
-
-	lock_kernel();
-	ret = sisfb_ioctl(NULL, f, cmd, arg, info);
-	unlock_kernel();
-	return ret;
-}
-#endif
-
 static int
 sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
 {
@@ -2007,7 +1990,7 @@
 #endif
 	.fb_sync	= fbcon_sis_sync,
 #ifdef SIS_NEW_CONFIG_COMPAT
-	.fb_compat_ioctl= sisfb_compat_ioctl,
+	.fb_compat_ioctl= sisfb_ioctl,
 #endif
 	.fb_ioctl	= sisfb_ioctl
 };
Index: linux-2.6/drivers/video/sstfb.c
===================================================================
--- linux-2.6.orig/drivers/video/sstfb.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/sstfb.c	2005-11-10 01:28:56.000000000 +0100
@@ -770,8 +770,7 @@
 	return 0;
 }
 
-static int sstfb_ioctl(struct inode *inode, struct file *file,
-                       u_int cmd, u_long arg, struct fb_info *info )
+static int sstfb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 {
 	struct sstfb_par *par = (struct sstfb_par *) info->par;
 	struct pci_dev *sst_dev = par->dev;
Index: linux-2.6/drivers/video/tcx.c
===================================================================
--- linux-2.6.orig/drivers/video/tcx.c	2005-11-10 01:20:49.000000000 +0100
+++ linux-2.6/drivers/video/tcx.c	2005-11-10 01:28:56.000000000 +0100
@@ -34,8 +34,7 @@
 static int tcx_blank(int, struct fb_info *);
 
 static int tcx_mmap(struct fb_info *, struct file *, struct vm_area_struct *);
-static int tcx_ioctl(struct inode *, struct file *, unsigned int,
-		     unsigned long, struct fb_info *);
+static int tcx_ioctl(struct fb_info *, unsigned int, unsigned long);
 static int tcx_pan_display(struct fb_var_screeninfo *, struct fb_info *);
 
 /*
@@ -310,8 +309,8 @@
 				  vma);
 }
 
-static int tcx_ioctl(struct inode *inode, struct file *file, unsigned int cmd,
-		     unsigned long arg, struct fb_info *info)
+static int tcx_ioctl(struct fb_info *info, unsigned int cmd,
+		     unsigned long arg)
 {
 	struct tcx_par *par = (struct tcx_par *) info->par;
 
Index: linux-2.6/include/linux/fb.h
===================================================================
--- linux-2.6.orig/include/linux/fb.h	2005-11-10 01:26:32.000000000 +0100
+++ linux-2.6/include/linux/fb.h	2005-11-10 01:28:56.000000000 +0100
@@ -608,12 +608,12 @@
 	int (*fb_sync)(struct fb_info *info);
 
 	/* perform fb specific ioctl (optional) */
-	int (*fb_ioctl)(struct inode *inode, struct file *file, unsigned int cmd,
-			unsigned long arg, struct fb_info *info);
+	int (*fb_ioctl)(struct fb_info *info, unsigned int cmd,
+			unsigned long arg);
 
 	/* Handle 32bit compat ioctl (optional) */
-	long (*fb_compat_ioctl)(struct file *f, unsigned cmd, unsigned long arg,
-			       struct fb_info *info);
+	int (*fb_compat_ioctl)(struct fb_info *info, unsigned cmd,
+			unsigned long arg);
 
 	/* perform fb specific mmap */
 	int (*fb_mmap)(struct fb_info *info, struct file *file, struct vm_area_struct *vma);
