Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319083AbSH1Wbj>; Wed, 28 Aug 2002 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319084AbSH1Wbj>; Wed, 28 Aug 2002 18:31:39 -0400
Received: from dp.samba.org ([66.70.73.150]:34514 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319083AbSH1Wbi>;
	Wed, 28 Aug 2002 18:31:38 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15725.20387.572658.456699@argo.ozlabs.ibm.com>
Date: Thu, 29 Aug 2002 08:33:07 +1000 (EST)
To: James Simmons <jsimmons@infradead.org>
Cc: "Clemens 'Gullevek' Schwaighofer" <schwaigl@eunet.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: still ati fb errors with 2.5.31, thought patch applied
In-Reply-To: <15725.17098.681128.713398@argo.ozlabs.ibm.com>
References: <46344979984.20020828090546@eunet.at>
	<Pine.LNX.4.33.0208281114420.1459-100000@maxwell.earthlink.net>
	<15725.17098.681128.713398@argo.ozlabs.ibm.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:

> > This driver has not been ported to the new api.
> 
> I sent you a patch to convert aty128fb.c to the new API, and I posted
> a message to lkml saying that it was available at:

But of course those error messages were *with* my patch.  I just
cross-compiled a kernel for i386 and got the same errors.  Here is a
patch to go on top of my other patch which should fix things, though I
haven't tried running it on an x86 box yet.

Paul.

diff -urN pmac-ptep/drivers/video/Makefile pmac-2.5/drivers/video/Makefile
--- pmac-ptep/drivers/video/Makefile	Fri Aug 16 09:08:34 2002
+++ pmac-2.5/drivers/video/Makefile	Thu Aug 29 08:26:47 2002
@@ -44,7 +44,7 @@
 obj-$(CONFIG_FB_APOLLO)           += dnfb.o cfbfillrect.o cfbimgblt.o
 obj-$(CONFIG_FB_Q40)              += q40fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_ATARI)            += atafb.o
-obj-$(CONFIG_FB_ATY128)           += aty128fb.o
+obj-$(CONFIG_FB_ATY128)           += aty128fb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_RADEON)		  += radeonfb.o
 obj-$(CONFIG_FB_NEOMAGIC)         += neofb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_IGA)              += igafb.o
diff -urN pmac-ptep/drivers/video/aty128fb.c pmac-2.5/drivers/video/aty128fb.c
--- pmac-ptep/drivers/video/aty128fb.c	Mon Aug 19 21:02:30 2002
+++ pmac-2.5/drivers/video/aty128fb.c	Thu Aug 29 08:22:13 2002
@@ -360,7 +360,9 @@
 static int aty128fb_blank(int blank, struct fb_info *fb);
 static int aty128fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
 			  u_long arg, int con, struct fb_info *info);
+#if 0
 static int aty128fb_rasterimg(struct fb_info *info, int start);
+#endif
 
     /*
      *  Interface to the low level console driver
@@ -1397,6 +1399,7 @@
 	aty_st_le32(PALETTE_DATA, (red<<16)|(green<<8)|blue);
 }
 
+#if 0
 static int
 aty128fb_rasterimg(struct fb_info *info, int start)
 {
@@ -1407,7 +1410,7 @@
 
 	return 0;
 }
-
+#endif
 
 int __init
 aty128fb_setup(char *options)
@@ -1727,13 +1730,13 @@
 	}
 
 #if !defined(CONFIG_PPC) && !defined(__sparc__)
-	if (!(bios_seg = aty128find_ROM(info)))
+	if (!(bios_seg = aty128find_ROM()))
 		printk(KERN_INFO "aty128fb: Rage128 BIOS not located. "
 					"Guessing...\n");
 	else {
 		printk(KERN_INFO "aty128fb: Rage128 BIOS located at "
 				"segment %4.4X\n", (unsigned int)bios_seg);
-		aty128_get_pllinfo(info, bios_seg);
+		aty128_get_pllinfo(par, bios_seg);
 	}
 #endif
 	aty128_timings(par);
@@ -1746,9 +1749,9 @@
 
 #ifdef CONFIG_MTRR
 	if (mtrr) {
-		info->mtrr.vram = mtrr_add(info->fix.smem_start,
-				info->vram_size, MTRR_TYPE_WRCOMB, 1);
-		info->mtrr.vram_valid = 1;
+		par->mtrr.vram = mtrr_add(info->fix.smem_start,
+				par->vram_size, MTRR_TYPE_WRCOMB, 1);
+		par->mtrr.vram_valid = 1;
 		/* let there be speed */
 		printk(KERN_INFO "aty128fb: Rage128 MTRR set to ON\n");
 	}
