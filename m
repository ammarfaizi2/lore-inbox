Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269873AbRHIXsJ>; Thu, 9 Aug 2001 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270619AbRHIXr6>; Thu, 9 Aug 2001 19:47:58 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:24339 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S269873AbRHIXrq>; Thu, 9 Aug 2001 19:47:46 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108092348.BAA08571@green.mif.pg.gda.pl>
Subject: [PATCH] double DRM - fixes
To: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
Date: Fri, 10 Aug 2001 01:48:31 +0200 (CEST)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   The following patch shold fix in -ac10
- configuration of DRM with xconfig
- build of ald drm driver

Andrzej
*************************************************
diff -uNr linux-2.4.7-ac10/Makefile linux/Makefile
--- linux-2.4.7-ac10/Makefile	Thu Aug  9 02:50:37 2001
+++ linux/Makefile	Fri Aug 10 00:40:31 2001
@@ -145,7 +145,8 @@
 	drivers/net/net.o \
 	drivers/media/media.o
 DRIVERS-$(CONFIG_AGP) += drivers/char/agp/agp.o
-DRIVERS-$(CONFIG_DRM) += drivers/char/drm/drm.o
+DRIVERS-$(CONFIG_DRM_NEW) += drivers/char/drm/drm.o
+DRIVERS-$(CONFIG_DRM_OLD) += drivers/char/drm-4.0/drm.o
 DRIVERS-$(CONFIG_NUBUS) += drivers/nubus/nubus.a
 DRIVERS-$(CONFIG_ISDN) += drivers/isdn/isdn.a
 DRIVERS-$(CONFIG_NET_FC) += drivers/net/fc/fc.o
diff -uNr linux-2.4.7-ac10/drivers/char/Config.in linux/drivers/char/Config.in
--- linux-2.4.7-ac10/drivers/char/Config.in	Thu Aug  9 02:50:37 2001
+++ linux/drivers/char/Config.in	Fri Aug 10 00:42:24 2001
@@ -203,6 +203,7 @@
    if [ "$CONFIG_DRM_NEW" = "y" ]; then
       source drivers/char/drm/Config.in
    else
+      define_bool CONFIG_DRM_OLD y
       source drivers/char/drm-4.0/Config.in
    fi
 fi
diff -uNr linux-2.4.7-ac10/drivers/char/Makefile linux/drivers/char/Makefile
--- linux-2.4.7-ac10/drivers/char/Makefile	Sun Aug  5 21:15:51 2001
+++ linux/drivers/char/Makefile	Fri Aug 10 00:41:19 2001
@@ -188,7 +188,8 @@
 obj-$(CONFIG_QIC02_TAPE) += tpqic02.o
 
 subdir-$(CONFIG_FTAPE) += ftape
-subdir-$(CONFIG_DRM) += drm
+subdir-$(CONFIG_DRM_NEW) += drm
+subdir-$(CONFIG_DRM_OLD) += drm-4.0
 subdir-$(CONFIG_PCMCIA) += pcmcia
 subdir-$(CONFIG_AGP) += agp
 
diff -uNr linux-2.4.7-ac10/drivers/char/drm-4.0/Config.in linux/drivers/char/drm-4.0/Config.in
--- linux-2.4.7-ac10/drivers/char/drm-4.0/Config.in	Thu Aug  9 02:50:37 2001
+++ linux/drivers/char/drm-4.0/Config.in	Thu Aug  9 22:55:50 2001
@@ -5,9 +5,9 @@
 # Direct Rendering Infrastructure (DRI) in XFree86 4.x.
 #
 
-tristate '  3dfx Banshee/Voodoo3+' CONFIG_DRM_TDFX
-tristate '  3dlabs GMX 2000' CONFIG_DRM_GAMMA
-dep_tristate '  ATI Rage 128' CONFIG_DRM_R128 $CONFIG_AGP
-dep_tristate '  ATI Radeon' CONFIG_DRM_RADEON $CONFIG_AGP
-dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP
-dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
+tristate '  3dfx Banshee/Voodoo3+' CONFIG_DRM40_TDFX
+tristate '  3dlabs GMX 2000' CONFIG_DRM40_GAMMA
+dep_tristate '  ATI Rage 128' CONFIG_DRM40_R128 $CONFIG_AGP
+dep_tristate '  ATI Radeon' CONFIG_DRM40_RADEON $CONFIG_AGP
+dep_tristate '  Intel I810' CONFIG_DRM40_I810 $CONFIG_AGP
+dep_tristate '  Matrox g200/g400' CONFIG_DRM40_MGA $CONFIG_AGP
diff -uNr linux-2.4.7-ac10/drivers/char/drm-4.0/Makefile linux/drivers/char/drm-4.0/Makefile
--- linux-2.4.7-ac10/drivers/char/drm-4.0/Makefile	Thu Aug  9 02:50:37 2001
+++ linux/drivers/char/drm-4.0/Makefile	Thu Aug  9 22:55:38 2001
@@ -49,13 +49,13 @@
 i810-objs   := i810_drv.o   i810_dma.o    i810_context.o i810_bufs.o
 radeon-objs := radeon_drv.o radeon_cp.o   radeon_context.o radeon_bufs.o radeon_state.o
 
-obj-$(CONFIG_DRM_GAMMA) += gamma.o
-obj-$(CONFIG_DRM_TDFX)  += tdfx.o
-obj-$(CONFIG_DRM_R128)  += r128.o
-obj-$(CONFIG_DRM_RADEON)+= radeon.o
-obj-$(CONFIG_DRM_FFB)   += ffb.o
-obj-$(CONFIG_DRM_MGA)   += mga.o
-obj-$(CONFIG_DRM_I810)  += i810.o
+obj-$(CONFIG_DRM40_GAMMA) += gamma.o
+obj-$(CONFIG_DRM40_TDFX)  += tdfx.o
+obj-$(CONFIG_DRM40_R128)  += r128.o
+obj-$(CONFIG_DRM40_RADEON)+= radeon.o
+obj-$(CONFIG_DRM40_FFB)   += ffb.o
+obj-$(CONFIG_DRM40_MGA)   += mga.o
+obj-$(CONFIG_DRM40_I810)  += i810.o
 
 
 # When linking into the kernel, link the library just once. 
diff -uNr linux-2.4.7-ac10/drivers/char/drm-4.0/drm.h linux/drivers/char/drm-4.0/drm.h
--- linux-2.4.7-ac10/drivers/char/drm-4.0/drm.h	Thu Aug  9 02:50:37 2001
+++ linux/drivers/char/drm-4.0/drm.h	Thu Aug  9 22:56:43 2001
@@ -84,7 +84,7 @@
 #include "i810_drm.h"
 #include "r128_drm.h"
 #include "radeon_drm.h"
-#ifdef CONFIG_DRM_SIS
+#ifdef CONFIG_DRM40_SIS
 #include "sis_drm.h"
 #endif
 
@@ -399,7 +399,7 @@
 #define DRM_IOCTL_RADEON_STIPPLE	DRM_IOW( 0x4c, drm_radeon_stipple_t)
 #define DRM_IOCTL_RADEON_INDIRECT	DRM_IOWR(0x4d, drm_radeon_indirect_t)
 
-#ifdef CONFIG_DRM_SIS
+#ifdef CONFIG_DRM40_SIS
 /* SiS specific ioctls */
 #define SIS_IOCTL_FB_ALLOC		DRM_IOWR(0x44, drm_sis_mem_t)
 #define SIS_IOCTL_FB_FREE		DRM_IOW( 0x45, drm_sis_mem_t)


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
