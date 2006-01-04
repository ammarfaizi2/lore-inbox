Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWADVRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWADVRV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 16:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbWADVRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 16:17:21 -0500
Received: from xproxy.gmail.com ([66.249.82.198]:11133 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751797AbWADVRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 16:17:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=nbx3k6PUD5rXlXv+lHF1XpbeT0k1bc2t1os/v0mH3u3Qx/PpfQzTcMG/ZdhD87mATQgq9AsIesMRjZX6+IUnjrjdIQM/Pphkoa/0vEOTLLsZeXZM5LNK7Z3ZAyn5qUedWg5on01//EqXDMpBhQiHlcIgMLLqoAjq+ApaBL+11VI=
Subject: [PATCH] PXA2xx: build PCMCIA as a module
From: Florin Malita <fmalita@gmail.com>
To: rpurdie@rpsys.net
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Wed, 04 Jan 2006 16:16:29 -0500
Message-Id: <1136409389.14442.20.camel@scox.glenatl.glenayre.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for building the PCMCIA driver for pxa2xx Sharp
platforms as a module:

1) platform_scoop_config is currently declared in pxa2xx_sharpsl.c but
referenced in the platform code - move the declaration in the platform
code so pxa2xx_sharpsl.c can be built as a module.
2) export soc_common_drv_pcmcia_remove which is referenced in
pxa2xx_base.c.

Please apply.

Signed-off-by: Florin Malita <fmalita@gmail.com>
--
diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -45,6 +45,9 @@
 #include "generic.h"
 #include "sharpsl.h"
 
+/* PCMCIA to Scoop linkage */
+struct scoop_pcmcia_config *platform_scoop_config;
+EXPORT_SYMBOL(platform_scoop_config);
 
 /*
  * Corgi SCOOP Device
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -48,6 +48,10 @@
 #include "generic.h"
 #include "sharpsl.h"
 
+/* PCMCIA to Scoop linkage */
+struct scoop_pcmcia_config *platform_scoop_config;
+EXPORT_SYMBOL(platform_scoop_config);
+
 /*
  * Spitz SCOOP Device #1
  */
diff --git a/drivers/pcmcia/pxa2xx_sharpsl.c b/drivers/pcmcia/pxa2xx_sharpsl.c
--- a/drivers/pcmcia/pxa2xx_sharpsl.c
+++ b/drivers/pcmcia/pxa2xx_sharpsl.c
@@ -27,13 +27,6 @@
 
 #define	NO_KEEP_VS 0x0001
 
-/* PCMCIA to Scoop linkage
-
-   There is no easy way to link multiple scoop devices into one
-   single entity for the pxa2xx_pcmcia device so this structure
-   is used which is setup by the platform code
-*/
-struct scoop_pcmcia_config *platform_scoop_config;
 #define SCOOP_DEV platform_scoop_config->devs
 
 static void sharpsl_pcmcia_init_reset(struct scoop_pcmcia_dev *scoopdev)
diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -846,3 +846,5 @@ int soc_common_drv_pcmcia_remove(struct 
 
 	return 0;
 }
+
+EXPORT_SYMBOL(soc_common_drv_pcmcia_remove);


