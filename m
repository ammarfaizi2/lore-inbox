Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWELWfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWELWfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 18:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbWELWfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 18:35:38 -0400
Received: from waste.org ([64.81.244.121]:29332 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751018AbWELWfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 18:35:38 -0400
Date: Fri, 12 May 2006 17:29:52 -0500
From: Matt Mackall <mpm@selenic.com>
To: akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl
Cc: liux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Make number of IDE interfaces configurable
Message-ID: <20060512222952.GQ6616@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make IDE_HWIFS configurable if EMBEDDED

This lets us lop as much as 16k off an x86 build. It's a little ugly,
but it's dead simple. Note the fix for HWIFS < 2.

Sizing interfaces dynamically unfortunately turns out to be pretty
major surgery.

add/remove: 0/1 grow/shrink: 0/11 up/down: 0/-16182 (-16182)
function                                     old     new   delta
ide_hwifs                                  16920    1692  -15228
init_irq                                    1113     750    -363
ideprobe_init                                283     138    -145
ide_pci_setup_ports                         1329    1193    -136
save_match                                    85       -     -85
ide_register_hw_with_fixup                   367     287     -80
ide_setup                                   1364    1308     -56
is_chipset_set                                40       4     -36
create_proc_ide_interfaces                   225     205     -20
init_ide_data                                 84      67     -17
ide_probe_for_cmd640x                       1198    1183     -15
ide_unregister                              1452    1451      -1

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6/drivers/ide/Kconfig
===================================================================
--- 2.6.orig/drivers/ide/Kconfig	2006-04-20 17:01:05.000000000 -0500
+++ 2.6/drivers/ide/Kconfig	2006-05-11 15:10:58.000000000 -0500
@@ -54,7 +54,7 @@ if IDE
 
 config IDE_MAX_HWIFS
 	int "Max IDE interfaces"
-	depends on ALPHA || SUPERH || IA64
+	depends on ALPHA || SUPERH || IA64 || EMBEDDED
 	default 4
 	help
 	  This is the maximum number of IDE hardware interfaces that will
Index: 2.6/drivers/ide/setup-pci.c
===================================================================
--- 2.6.orig/drivers/ide/setup-pci.c	2006-05-11 15:07:32.000000000 -0500
+++ 2.6/drivers/ide/setup-pci.c	2006-05-11 15:13:51.000000000 -0500
@@ -102,7 +102,7 @@ static ide_hwif_t *ide_match_hwif(unsign
 				return hwif;	/* pick an unused entry */
 		}
 	}
-	for (h = 0; h < 2; ++h) {
+	for (h = 0; h < 2 && h < MAX_HWIFS; ++h) {
 		hwif = ide_hwifs + h;
 		if (hwif->chipset == ide_unknown)
 			return hwif;	/* pick an unused entry */
Index: 2.6/include/linux/ide.h
===================================================================
--- 2.6.orig/include/linux/ide.h	2006-05-11 15:07:32.000000000 -0500
+++ 2.6/include/linux/ide.h	2006-05-12 14:01:53.000000000 -0500
@@ -252,7 +252,8 @@ static inline void ide_std_init_ports(hw
 
 #include <asm/ide.h>
 
-#ifndef MAX_HWIFS
+#if !defined(MAX_HWIFS) || defined(CONFIG_EMBEDDED)
+#undef MAX_HWIFS
 #define MAX_HWIFS	CONFIG_IDE_MAX_HWIFS
 #endif
 

-- 
Mathematics is the supreme nostalgia of our time.
