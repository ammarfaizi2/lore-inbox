Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262572AbSI0SJK>; Fri, 27 Sep 2002 14:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262569AbSI0SIF>; Fri, 27 Sep 2002 14:08:05 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:47286 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262568AbSI0SHz>;
	Fri, 27 Sep 2002 14:07:55 -0400
Date: Fri, 27 Sep 2002 21:27:52 -0400
From: Christoph Hellwig <hch@sgi.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix drm ioctl ABI default
Message-ID: <20020927212752.E4733@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a config option to make the i810 drm ioctl ABI XFree4.1 compatible
by default (currently that's a module parameter).  The XFree folks fucked
this up by adding members in the middle of a struct and we have to work
around it now.  At least we should have the pre-2.4.20 behaviour as default.
(And I'd suggest you add that option as y to the defconfig)


--- linux-2.4.20-pre5/drivers/char/drm/Config.in	Thu Aug 29 02:58:43 2002
+++ linux/drivers/char/drm/Config.in	Fri Sep  6 21:19:07 2002
@@ -10,6 +10,7 @@ tristate '  3dfx Banshee/Voodoo3+' CONFI
 tristate '  ATI Rage 128' CONFIG_DRM_R128
 dep_tristate '  ATI Radeon' CONFIG_DRM_RADEON $CONFIG_AGP
 dep_tristate '  Intel I810' CONFIG_DRM_I810 $CONFIG_AGP
+dep_mbool    '    Enabled XFree 4.1 ioctl interface by default' CONFIG_DRM_I810_XFREE_41 $CONFIG_DRM_I810
 dep_tristate '  Intel 830M' CONFIG_DRM_I830 $CONFIG_AGP
 dep_tristate '  Matrox g200/g400' CONFIG_DRM_MGA $CONFIG_AGP
 dep_tristate '  SiS' CONFIG_DRM_SIS $CONFIG_AGP
--- linux-2.4.20-pre5/drivers/char/drm/i810_dma.c	Thu Aug 29 02:58:43 2002
+++ linux/drivers/char/drm/i810_dma.c	Fri Sep  6 21:18:07 2002
@@ -30,6 +30,7 @@
  *
  */
 
+#include <linux/config.h>
 #include "i810.h"
 #include "drmP.h"
 #include "i810_drv.h"
@@ -466,8 +467,11 @@ static int i810_dma_initialize(drm_devic
    	return 0;
 }
 
-
+#ifdef CONFIG_DRM_I810_XFREE_41
+int xfreeversion = 41;
+#else
 int xfreeversion = -1;
+#endif
 
 MODULE_PARM(xfreeversion, "i");
 MODULE_PARM_DESC(xfreeversion, "The version of XFree86 that needs to be supported");
