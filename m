Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVARMec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVARMec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 07:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVARMec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 07:34:32 -0500
Received: from colin2.muc.de ([193.149.48.15]:1042 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261284AbVARMdn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 07:33:43 -0500
Date: 18 Jan 2005 13:33:40 +0100
Date: Tue, 18 Jan 2005 13:33:40 +0100
From: Andi Kleen <ak@muc.de>
To: thomas@winischhofer.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Convert sis fb driver to compat_ioctl
Message-ID: <20050118123340.GC68224@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sis framebuffer driver to compat ioctl.

Requires generic framebuffer compat_ioctl patch I posted
earlier on l-k.

Signed-off-by: Andi Kleen <ak@muc.de>

diff -u linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h-o linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h
--- linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h-o	2005-01-14 10:12:22.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/video/sis/sis.h	2005-01-17 11:27:41.000000000 +0100
@@ -527,10 +527,6 @@
 	int  		newrom;
 	int  		registered;
 	int		warncount;
-#ifdef SIS_CONFIG_COMPAT
-	int		ioctl32registered;
-	int		ioctl32vblankregistered;
-#endif
 
 	int 		sisvga_engine;
 	int 		hwcursor_size;
diff -u linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c-o linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c
--- linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c-o	2005-01-14 10:12:22.000000000 +0100
+++ linux-2.6.11-rc1-bk4/drivers/video/sis/sis_main.c	2005-01-18 05:27:29.000000000 +0100
@@ -2192,11 +2192,22 @@
 		break;
 
 	   default:
-		return -EINVAL;
+		return -ENOIOCTLCMD;
 	}
 	return 0;
 }
 
+#ifdef CONFIG_COMPAT
+static long sisfb_compat_ioctl(struct file *f, unsigned cmd, unsigned long arg, struct fb_info *info)
+{
+	int ret;
+	lock_kernel();
+	ret = sisfb_ioctl(NULL, f, cmd, arg, info);
+	unlock_kernel();
+	return ret;
+}
+#endif
+
 static int
 sisfb_get_fix(struct fb_fix_screeninfo *fix, int con, struct fb_info *info)
 {
@@ -2258,7 +2269,10 @@
 	.fb_imageblit   = cfb_imageblit,
 	.fb_cursor      = soft_cursor,
 	.fb_sync        = fbcon_sis_sync,
-	.fb_ioctl       = sisfb_ioctl
+	.fb_ioctl       = sisfb_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl = sisfb_compat_ioctl,
+#endif
 };
 #endif
 
@@ -4791,10 +4805,6 @@
 	ivideo->pcifunc = PCI_FUNC(pdev->devfn);
 	ivideo->subsysvendor = pdev->subsystem_vendor;
 	ivideo->subsysdevice = pdev->subsystem_device;
-#ifdef SIS_CONFIG_COMPAT
-	ivideo->ioctl32registered = 0;
-	ivideo->ioctl32vblankregistered = 0;
-#endif
 
 #ifndef MODULE
 	if(sisfb_mode_idx == -1) {
@@ -5594,30 +5604,6 @@
 		ivideo->next = card_list;
 		card_list = ivideo;
 
-#ifdef SIS_CONFIG_COMPAT
-		{
-		int ret;
-		/* Our ioctls are all "32/64bit compatible" */
-		if(register_ioctl32_conversion(FBIOGET_VBLANK, NULL)) {
-		   printk(KERN_ERR "sisfb: Error registering FBIOGET_VBLANK ioctl32 translation\n");
-		} else {
-		   ivideo->ioctl32vblankregistered = 1;
-		}
-		ret =  register_ioctl32_conversion(FBIO_ALLOC,             NULL);
-		ret |= register_ioctl32_conversion(FBIO_FREE,              NULL);
-		ret |= register_ioctl32_conversion(SISFB_GET_INFO_SIZE,    NULL);
-		ret |= register_ioctl32_conversion(SISFB_GET_INFO,         NULL);
-		ret |= register_ioctl32_conversion(SISFB_GET_TVPOSOFFSET,  NULL);
-		ret |= register_ioctl32_conversion(SISFB_SET_TVPOSOFFSET,  NULL);
-		ret |= register_ioctl32_conversion(SISFB_SET_LOCK,         NULL);
-		ret |= register_ioctl32_conversion(SISFB_GET_VBRSTATUS,    NULL);
-		ret |= register_ioctl32_conversion(SISFB_GET_AUTOMAXIMIZE, NULL);
-		ret |= register_ioctl32_conversion(SISFB_SET_AUTOMAXIMIZE, NULL);
-		if(ret)	printk(KERN_ERR "sisfb: Error registering ioctl32 translations\n");
-		else    ivideo->ioctl32registered = 1;
-		}
-#endif
-
 		printk(KERN_INFO "sisfb: 2D acceleration is %s, y-panning %s\n",
 		     ivideo->sisfb_accel ? "enabled" : "disabled",
 		     ivideo->sisfb_ypan  ?
@@ -5649,28 +5635,6 @@
 	struct fb_info        *sis_fb_info = ivideo->memyselfandi;
 	int                   registered = ivideo->registered;
 
-#ifdef SIS_CONFIG_COMPAT
-	if(ivideo->ioctl32vblankregistered) {
-		if(unregister_ioctl32_conversion(FBIOGET_VBLANK)) {
-			printk(KERN_ERR "sisfb: Error unregistering FBIOGET_VBLANK ioctl32 translation\n");
-		}
-	}
-	if(ivideo->ioctl32registered) {
-		int ret;
-		ret =  unregister_ioctl32_conversion(FBIO_ALLOC);
-		ret |= unregister_ioctl32_conversion(FBIO_FREE);
-		ret |= unregister_ioctl32_conversion(SISFB_GET_INFO_SIZE);
-		ret |= unregister_ioctl32_conversion(SISFB_GET_INFO);
-		ret |= unregister_ioctl32_conversion(SISFB_GET_TVPOSOFFSET);
-		ret |= unregister_ioctl32_conversion(SISFB_SET_TVPOSOFFSET);
-		ret |= unregister_ioctl32_conversion(SISFB_SET_LOCK);
-		ret |= unregister_ioctl32_conversion(SISFB_GET_VBRSTATUS);
-		ret |= unregister_ioctl32_conversion(SISFB_GET_AUTOMAXIMIZE);
-		ret |= unregister_ioctl32_conversion(SISFB_SET_AUTOMAXIMIZE);
-		if(ret)	printk(KERN_ERR "sisfb: Error unregistering ioctl32 translations\n");
-	}
-#endif
-
 	/* Unmap */
 	iounmap(ivideo->video_vbase);
 	iounmap(ivideo->mmio_vbase);
