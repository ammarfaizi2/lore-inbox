Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270727AbTGWRZZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270910AbTGWRZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:25:25 -0400
Received: from smtp-103-wednesday.noc.nerim.net ([62.4.17.103]:34067 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S270727AbTGWRZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:25:16 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 and SiS based laptop, patch included
Mail-Copies-To: nobody
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Wed, 23 Jul 2003 19:43:49 +0200
Message-ID: <plopm3y8ypxhnu.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


Hello,

I've  tested  the  2.6.0-test1  (and  -ac1 too)  kernels  on  my  both
computers  (an  Athlon  desktop  computer,  and  a  SiS-based  Celeron
laptop). I don't have any critical problem to report.

The SiS  DRM modules  are not  available by default,  and need  a very
small patch to compile. Attached with  this mail is a patch that makes
it  work. With this  patch, Tuxracer  works fine  on my  computer, and
glxgears gives  me even a better  frame rate than with  the 2.4 kernel
(XFree 4.3 from Debian IPv6).

I've a small bug to report on SiS framebuffer (compiled in the kernel,
not in module, I  like the small Tux at boot time  :p): if I force the
resolution to 1024x768 using the  kernel command line, then an area of
the screen (I  think it's 80x25 characters) is  white instead of black
by default.

While  I'm writing,  I've a  small question:  is there  a  driver from
Prism2  PCMCIA  wireless  cards  available somewhere  ?  linux-wlan-ng
doesn't compile (linux/modversions.h: no  such file or directory), and
there is no built-in driver either. This is the only thing stopping me 
from using 2.6 as my default kernel on this computer.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=sis-drm.patch
Content-Description: Patch to reenable SiS 630 drm

diff -ru -X dontdiff linux-2.6.0-test1/drivers/char/drm/Kconfig kernel-source-2.6.0-test1-ac1-kb1/drivers/char/drm/Kconfig
--- linux-2.6.0-test1/drivers/char/drm/Kconfig	2003-07-14 05:37:28.000000000 +0200
+++ kernel-source-2.6.0-test1-ac1-kb1/drivers/char/drm/Kconfig	2003-07-23 19:24:31.000000000 +0200
@@ -72,3 +72,12 @@
 	  Choose this option if you have a Matrox G200, G400 or G450 graphics
 	  card.  If M is selected, the module will be called mga.  AGP
 	  support is required for this driver to work.
+
+config DRM_SIS
+	tristate "SiS video cards"
+	depends on DRM && AGP
+	help
+	  Choose this option if you have a SiS 630 or compatibel video 
+          chipset. If M is selected the module will be called sis. AGP
+          support is required for this driver to work.
+
diff -ru -X dontdiff linux-2.6.0-test1/drivers/char/drm/Makefile kernel-source-2.6.0-test1-ac1-kb1/drivers/char/drm/Makefile
--- linux-2.6.0-test1/drivers/char/drm/Makefile	2003-07-14 05:38:38.000000000 +0200
+++ kernel-source-2.6.0-test1-ac1-kb1/drivers/char/drm/Makefile	2003-07-21 22:50:51.000000000 +0200
@@ -10,6 +10,7 @@
 i830-objs   := i830_drv.o i830_dma.o i830_irq.o
 radeon-objs := radeon_drv.o radeon_cp.o radeon_state.o radeon_mem.o radeon_irq.o
 ffb-objs    := ffb_drv.o ffb_context.o
+sis-objs    := sis_drv.o sis_ds.o sis_mm.o
 
 obj-$(CONFIG_DRM_GAMMA) += gamma.o
 obj-$(CONFIG_DRM_TDFX)	+= tdfx.o
@@ -19,3 +20,5 @@
 obj-$(CONFIG_DRM_I810)	+= i810.o
 obj-$(CONFIG_DRM_I830)	+= i830.o
 obj-$(CONFIG_DRM_FFB)   += ffb.o
+obj-$(CONFIG_DRM_SIS)   += sis.o
+
diff -ru -X dontdiff linux-2.6.0-test1/drivers/char/drm/sis_mm.c kernel-source-2.6.0-test1-ac1-kb1/drivers/char/drm/sis_mm.c
--- linux-2.6.0-test1/drivers/char/drm/sis_mm.c	2003-07-14 05:35:56.000000000 +0200
+++ kernel-source-2.6.0-test1-ac1-kb1/drivers/char/drm/sis_mm.c	2003-07-22 20:38:54.000000000 +0200
@@ -28,8 +28,9 @@
  * 
  */
 
+#include <linux/config.h>
 #include "sis.h"
-#include <linux/sisfb.h>
+#include "video/sisfb.h"
 #include "drmP.h"
 #include "sis_drm.h"
 #include "sis_drv.h"

--=-=-=


-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org

--=-=-=--
