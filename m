Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbTIVTkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 15:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbTIVTkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 15:40:18 -0400
Received: from verein.lst.de ([212.34.189.10]:39586 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262617AbTIVTkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 15:40:09 -0400
Date: Mon, 22 Sep 2003 21:40:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: maz@wild-wind.fr.eu.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kill CONFIG_EISA_ALWAYS
Message-ID: <20030922194005.GA29357@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, maz@wild-wind.fr.eu.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -3 () PATCH_UNIFIED_DIFF,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to kill willy's CONFIG_EISA_ALWAYS kludge.  So make
EISA_bus a variable always when CONFIG_EISA is set and initialize
it to 1 for alpha.  We probably want to do that only if the system
actually supports eisa, but I keep the old behaviour for now.

Also remove the CONFIG_EISA helptext on alpha as it's not user-visible.



--- 1.28/arch/alpha/Kconfig	Tue Sep  9 23:16:03 2003
+++ edited/arch/alpha/Kconfig	Sun Sep 21 21:28:48 2003
@@ -471,21 +471,6 @@
 	bool
 	depends on ALPHA_GENERIC || ALPHA_JENSEN || ALPHA_ALCOR || ALPHA_MIKASA || ALPHA_SABLE || ALPHA_LYNX || ALPHA_NORITAKE || ALPHA_RAWHIDE
 	default y
-	---help---
-	  The Extended Industry Standard Architecture (EISA) bus was
-	  developed as an open alternative to the IBM MicroChannel bus.
-
-	  The EISA bus provided some of the features of the IBM MicroChannel
-	  bus while maintaining backward compatibility with cards made for
-	  the older ISA bus.  The EISA bus saw limited use between 1988 and
-	  1995 when it was made obsolete by the PCI bus.
-
-	  Say Y here if you are building a kernel for an EISA-based machine.
-
-	  Otherwise, say N.
-
-config EISA_ALWAYS
-	def_bool EISA
 
 config SMP
 	bool "Symmetric multi-processing support"
===== arch/alpha/kernel/setup.c 1.36 vs edited =====
--- 1.36/arch/alpha/kernel/setup.c	Sun Aug 17 10:06:24 2003
+++ edited/arch/alpha/kernel/setup.c	Mon Sep 22 11:12:13 2003
@@ -33,6 +33,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/initrd.h>
+#include <linux/eisa.h>
 #ifdef CONFIG_MAGIC_SYSRQ
 #include <linux/sysrq.h>
 #include <linux/reboot.h>
@@ -679,6 +680,11 @@
 
 	/* Default root filesystem to sda2.  */
 	ROOT_DEV = Root_SDA2;
+
+#ifdef CONFIG_EISA
+	/* FIXME:  only set this when we actually have EISA in this box? */
+	EISA_bus = 1;
+#endif
 
  	/*
 	 * Check ASN in HWRPB for validity, report if bad.
--- 1.12/drivers/eisa/eisa-bus.c	Tue Sep  9 23:38:12 2003
+++ edited/drivers/eisa/eisa-bus.c	Sun Sep 21 21:27:26 2003
@@ -427,11 +427,8 @@
 
 postcore_initcall (eisa_init);
 
-#ifndef CONFIG_EISA_ALWAYS
-int EISA_bus;
-EXPORT_SYMBOL(EISA_bus);
-#endif
-
+int EISA_bus;		/* for legacy drivers */
+EXPORT_SYMBOL (EISA_bus);
 EXPORT_SYMBOL (eisa_bus_type);
 EXPORT_SYMBOL (eisa_driver_register);
 EXPORT_SYMBOL (eisa_driver_unregister);
--- 1.7/include/linux/eisa.h	Tue Sep  9 23:23:44 2003
+++ edited/include/linux/eisa.h	Sun Sep 21 21:28:05 2003
@@ -4,16 +4,6 @@
 #include <linux/ioport.h>
 #include <linux/device.h>
 
-#ifdef CONFIG_EISA
-# ifdef CONFIG_EISA_ALWAYS
-#  define EISA_bus 1
-# else
-   extern int EISA_bus;
-# endif
-#else
-# define EISA_bus 0
-#endif
-
 #define EISA_SIG_LEN   8
 #define EISA_MAX_SLOTS 8
 
@@ -107,5 +97,11 @@
 };
 
 int eisa_root_register (struct eisa_root_device *root);
+
+#ifdef CONFIG_EISA
+extern int EISA_bus;
+#else
+# define EISA_bus 0
+#endif
 
 #endif
