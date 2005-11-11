Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbVKKIgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbVKKIgk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVKKIgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:36:40 -0500
Received: from i121.durables.org ([64.81.244.121]:11726 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932274AbVKKIgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:22 -0500
Date: Fri, 11 Nov 2005 02:35:56 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <14.282480653@selenic.com>
Message-Id: <15.282480653@selenic.com>
Subject: [PATCH 14/15] misc: Configurable number of supported IDE interfaces
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Configurable number of supported IDE interfaces

This overrides the default limit (which may be set per arch with
CONFIG_IDE_MAX_HWIFS). This is the result of setting interfaces to 1:

   text    data     bss     dec     hex filename
3330172  529036  190556 4049764  3dcb64 vmlinux-baseline
3329352  528928  172124 4030404  3d7fc4 vmlinux

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/drivers/ide/setup-pci.c
===================================================================
--- 2.6.14-misc.orig/drivers/ide/setup-pci.c	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/drivers/ide/setup-pci.c	2005-11-09 11:27:23.000000000 -0800
@@ -102,7 +102,7 @@ static ide_hwif_t *ide_match_hwif(unsign
 				return hwif;	/* pick an unused entry */
 		}
 	}
-	for (h = 0; h < 2; ++h) {
+	for (h = 0; h < 2 && h < MAX_HWIFS; ++h) {
 		hwif = ide_hwifs + h;
 		if (hwif->chipset == ide_unknown)
 			return hwif;	/* pick an unused entry */
Index: 2.6.14-misc/include/linux/ide.h
===================================================================
--- 2.6.14-misc.orig/include/linux/ide.h	2005-11-01 10:54:33.000000000 -0800
+++ 2.6.14-misc/include/linux/ide.h	2005-11-09 11:27:23.000000000 -0800
@@ -309,6 +309,11 @@ static inline void ide_init_hwif_ports(h
 }
 #endif /* IDE_ARCH_OBSOLETE_INIT */
 
+#if defined(CONFIG_IDE_HWIFS) && CONFIG_IDE_HWIFS > 0
+#undef MAX_HWIFS
+#define MAX_HWIFS CONFIG_IDE_HWIFS
+#endif
+
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR
 # define ide_ack_intr(hwif) (1)
Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:27:20.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-09 11:27:23.000000000 -0800
@@ -457,6 +457,15 @@ config CC_ALIGN_JUMPS
 	  no dummy operations need be executed.
 	  Zero means use compiler's default.
 
+config IDE_HWIFS
+	depends IDE
+	int "Number of IDE hardware interfaces (0 for default)" if EMBEDDED
+	range 0 20
+	default 0
+	help
+	  Select the maximum number of IDE interfaces (0 for default).
+          Saves up to 14k.
+
 endmenu		# General setup
 
 config TINY_SHMEM
