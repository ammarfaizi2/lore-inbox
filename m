Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUCNWUx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUCNWUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:20:53 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:44006 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261850AbUCNWUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:20:51 -0500
Date: Sun, 14 Mar 2004 23:20:43 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>, nufan_wfk@yahoo.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: [patch] 2.6.4-mjb1: ivtv non-modular compile broken
Message-ID: <20040314222042.GK14833@fs.tum.de>
References: <23500000.1079289089@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <23500000.1079289089@[10.10.2.4]>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 10:31:29AM -0800, Martin J. Bligh wrote:
>...
> New:
>...
> ~ ivtv						Kevin Thayer / Steven Fuerst
> 	Driver for ivtv (includes Hauppauge PVR 250 / 350)
> 	Written by Kevin Thayer, ported to 2.6 by Steven Fuerst
> 	New version 0.1.9
>...

I got the following compile error:

<--  snip  -->

...
  CC      drivers/media/video/ivtv-driver.o
In file included from drivers/media/video/ivtv.h:14,
                 from drivers/media/video/ivtv-driver.c:10:
include/linux/module.h:489: variable `__this_module' has initializer but 
incomplete type
...
make[3]: *** [drivers/media/video/ivtv-driver.o] Error 1

<--  snip  -->


The patch below fixes the braindead #define MODULE.
Additionally, it changes a PCI dependency from an error to a Kconfig 
dependency.

cu
Adrian

--- linux-2.6.4-mjb1/drivers/media/video/ivtv.h.old	2004-03-14 23:11:04.000000000 +0100
+++ linux-2.6.4-mjb1/drivers/media/video/ivtv.h	2004-03-14 23:11:41.000000000 +0100
@@ -7,9 +7,6 @@
  * License: GPL
  * http://www.sourceforge.net/projects/ivtv/
  */
-#ifndef MODULE
- #define MODULE
-#endif
 
 #include <linux/module.h>
 #include <linux/init.h>
@@ -38,10 +35,6 @@
 #include <linux/byteorder/swab.h>
 #include <media/tuner.h>
 
-#ifndef CONFIG_PCI
-#  error "This driver requires kernel PCI support."
-#endif
-
 #define IVTV_ENCODER_OFFSET	0x00000000
 #define IVTV_ENCODER_SIZE	0x01000000
 
--- linux-2.6.4-mjb1/drivers/media/video/Kconfig.old	2004-03-14 23:12:07.000000000 +0100
+++ linux-2.6.4-mjb1/drivers/media/video/Kconfig	2004-03-14 23:12:53.000000000 +0100
@@ -35,7 +35,7 @@
 
 config VIDEO_IVTV_FB
 	tristate "IVTV Video For Linux Framebuffer"
-	depends on VIDEO_IVTV && FB
+	depends on VIDEO_IVTV && FB && PCI
 	---help---
 	  Support for Hauppauge WinTv PVR 350 boards TV Out via framebuffer.
 
