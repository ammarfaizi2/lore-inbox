Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVBAANN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVBAANN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVAaX7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:59:23 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:7686 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261467AbVAaXml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:42:41 -0500
Date: Tue, 1 Feb 2005 00:42:39 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Philip.Blundell@pobox.com, tim@cyberelk.net,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] non-PC parport config change
Message-ID: <20050131234239.GV21437@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a config option PARPORT_NOT_PC (and removes the 
PARPORT_OTHER option) that get's selected if any non-PC hardware was 
chosen.

This way, the mega #if in parport.h is gone now.

Additionally, it removes the unneeded PARPORT_NEED_GENERIC_OPS #define.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/parport.h |   12 +++++-------
 drivers/parport/Kconfig |   20 +++++++++-----------
 drivers/usb/Kconfig     |    1 +
 3 files changed, 15 insertions(+), 18 deletions(-)

This patch was already sent on:
- 20 Jan 2005

--- linux-2.6.10-rc2-mm4-full/include/linux/parport.h.old	2004-12-09 04:50:26.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/parport.h	2004-12-09 12:59:06.000000000 +0100
@@ -105,8 +105,6 @@
 #include <asm/ptrace.h>
 #include <asm/semaphore.h>
 
-#define PARPORT_NEED_GENERIC_OPS
-
 /* Define this later. */
 struct parport;
 struct pardevice;
@@ -520,9 +518,8 @@
 extern int parport_device_proc_unregister(struct pardevice *device);
 
 /* If PC hardware is the only type supported, we can optimise a bit.  */
-#if (defined(CONFIG_PARPORT_PC) || defined(CONFIG_PARPORT_PC_MODULE)) && !(defined(CONFIG_PARPORT_ARC) || defined(CONFIG_PARPORT_ARC_MODULE)) && !(defined(CONFIG_PARPORT_AMIGA) || defined(CONFIG_PARPORT_AMIGA_MODULE)) && !(defined(CONFIG_PARPORT_MFC3) || defined(CONFIG_PARPORT_MFC3_MODULE)) && !(defined(CONFIG_PARPORT_ATARI) || defined(CONFIG_PARPORT_ATARI_MODULE)) && !(defined(CONFIG_USB_USS720) || defined(CONFIG_USB_USS720_MODULE)) && !(defined(CONFIG_PARPORT_SUNBPP) || defined(CONFIG_PARPORT_SUNBPP_MODULE)) && !defined(CONFIG_PARPORT_OTHER)
+#if !defined(CONFIG_PARPORT_NOT_PC)
 
-#undef PARPORT_NEED_GENERIC_OPS
 #include <linux/parport_pc.h>
 #define parport_write_data(p,x)            parport_pc_write_data(p,x)
 #define parport_read_data(p)               parport_pc_read_data(p)
@@ -534,9 +531,9 @@
 #define parport_disable_irq(p)             parport_pc_disable_irq(p)
 #define parport_data_forward(p)            parport_pc_data_forward(p)
 #define parport_data_reverse(p)            parport_pc_data_reverse(p)
-#endif
 
-#ifdef PARPORT_NEED_GENERIC_OPS
+#else  /*  !CONFIG_PARPORT_NOT_PC  */
+
 /* Generic operations vector through the dispatch table. */
 #define parport_write_data(p,x)            (p)->ops->write_data(p,x)
 #define parport_read_data(p)               (p)->ops->read_data(p)
@@ -548,7 +545,8 @@
 #define parport_disable_irq(p)             (p)->ops->disable_irq(p)
 #define parport_data_forward(p)            (p)->ops->data_forward(p)
 #define parport_data_reverse(p)            (p)->ops->data_reverse(p)
-#endif
+
+#endif /*  !CONFIG_PARPORT_NOT_PC  */
 
 #endif /* __KERNEL__ */
 #endif /* _PARPORT_H_ */
--- linux-2.6.11-rc1-mm2-full/drivers/parport/Kconfig.old	2005-01-20 17:45:13.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/drivers/parport/Kconfig	2005-01-20 17:46:39.000000000 +0100
@@ -88,13 +88,18 @@
 	  Say Y here if you need PCMCIA support for your PC-style parallel
 	  ports. If unsure, say N.
 
+config PARPORT_NOT_PC
+	bool
+
 config PARPORT_ARC
 	tristate "Archimedes hardware"
 	depends on ARM && PARPORT
+	select PARPORT_NOT_PC
 
 config PARPORT_AMIGA
 	tristate "Amiga builtin port"
 	depends on AMIGA && PARPORT
+	select PARPORT_NOT_PC
 	help
 	  Say Y here if you need support for the parallel port hardware on
 	  Amiga machines. This code is also available as a module (say M),
@@ -103,6 +108,7 @@
 config PARPORT_MFC3
 	tristate "Multiface III parallel port"
 	depends on ZORRO && PARPORT
+	select PARPORT_NOT_PC
 	help
 	  Say Y here if you need parallel port support for the MFC3 card.
 	  This code is also available as a module (say M), called
@@ -111,6 +117,7 @@
 config PARPORT_ATARI
 	tristate "Atari hardware"
 	depends on ATARI && PARPORT
+	select PARPORT_NOT_PC
 	help
 	  Say Y here if you need support for the parallel port hardware on
 	  Atari machines. This code is also available as a module (say M),
@@ -123,22 +130,13 @@
 
 config PARPORT_SUNBPP
 	tristate "Sparc hardware (EXPERIMENTAL)"
-	depends on SBUS && EXPERIMENTAL && PARPORT
+	depends on SBUS && PARPORT && EXPERIMENTAL
+	select PARPORT_NOT_PC
 	help
 	  This driver provides support for the bidirectional parallel port
 	  found on many Sun machines. Note that many of the newer Ultras
 	  actually have pc style hardware instead.
 
-# If exactly one hardware type is selected then parport will optimise away
-# support for loading any others.  Defeat this if the user is keen.
-config PARPORT_OTHER
-	bool "Support foreign hardware"
-	depends on PARPORT
-	help
-	  Say Y here if you want to be able to load driver modules to support
-	  other non-standard types of parallel ports. This causes a
-	  performance loss, so most people say N.
-
 config PARPORT_1284
 	bool "IEEE 1284 transfer modes"
 	depends on PARPORT
--- linux-2.6.11-rc1-mm2-full/drivers/usb/Kconfig.old	2005-01-20 17:49:04.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/drivers/usb/Kconfig	2005-01-20 17:45:17.000000000 +0100
@@ -62,6 +62,7 @@
 config USB_USS720
 	tristate "USS720 parport driver"
 	depends on USB && PARPORT
+	select PARPORT_NOT_PC
 	---help---
 	  This driver is for USB parallel port adapters that use the Lucent
 	  Technologies USS-720 chip. These cables are plugged into your USB

