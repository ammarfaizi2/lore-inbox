Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUA3FVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 00:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266524AbUA3FTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 00:19:34 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:57476 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S266531AbUA3FR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 00:17:56 -0500
Date: Fri, 30 Jan 2004 00:02:44 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.2-rc2
Message-ID: <20040130000244.GJ12308@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040129235304.GA12308@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129235304.GA12308@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up the kconfig options for the pnp subsystem.  It updates the
comments and makes pnpbios proc support an optional feature.

diff -urN a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
--- a/drivers/pnp/Kconfig	2003-10-25 18:43:39.000000000 +0000
+++ b/drivers/pnp/Kconfig	2003-11-03 22:01:26.000000000 +0000
@@ -30,33 +30,9 @@
 comment "Protocols"
 	depends on PNP

-config ISAPNP
-	bool "ISA Plug and Play support (EXPERIMENTAL)"
-	depends on PNP && EXPERIMENTAL
-	help
-	  Say Y here if you would like support for ISA Plug and Play devices.
-	  Some information is in <file:Documentation/isapnp.txt>.
+source "drivers/pnp/isapnp/Kconfig"

-	  If unsure, say Y.
-
-config PNPBIOS
-	bool "Plug and Play BIOS support (EXPERIMENTAL)"
-	depends on PNP && EXPERIMENTAL
-	---help---
-	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
-	  Specification Version 1.0A May 5, 1994" to autodetect built-in
-	  mainboard resources (e.g. parallel port resources).
-
-	  Some features (e.g. event notification, docking station information,
-	  ISAPNP services) are not used.
-
-	  Note: ACPI is expected to supersede PNPBIOS some day, currently it
-	  co-exists nicely.
-
-	  See latest pcmcia-cs (stand-alone package) for a nice "lspnp" tools,
-	  or have a look at /proc/bus/pnp.
-
-	  If unsure, say Y.
+source "drivers/pnp/pnpbios/Kconfig"

 endmenu

diff -urN a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
--- a/drivers/pnp/isapnp/Kconfig	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/pnp/isapnp/Kconfig	2003-11-03 22:01:54.000000000 +0000
@@ -0,0 +1,11 @@
+#
+# ISA Plug and Play configuration
+#
+config ISAPNP
+	bool "ISA Plug and Play support (EXPERIMENTAL)"
+	depends on PNP && EXPERIMENTAL
+	help
+	  Say Y here if you would like support for ISA Plug and Play devices.
+	  Some information is in <file:Documentation/isapnp.txt>.
+
+	  If unsure, say Y.
diff -urN a/drivers/pnp/pnpbios/Kconfig b/drivers/pnp/pnpbios/Kconfig
--- a/drivers/pnp/pnpbios/Kconfig	1970-01-01 00:00:00.000000000 +0000
+++ b/drivers/pnp/pnpbios/Kconfig	2003-11-03 22:55:41.000000000 +0000
@@ -0,0 +1,41 @@
+#
+# Plug and Play BIOS configuration
+#
+config PNPBIOS
+	bool "Plug and Play BIOS support (EXPERIMENTAL)"
+	depends on PNP && EXPERIMENTAL
+	---help---
+	  Linux uses the PNPBIOS as defined in "Plug and Play BIOS
+	  Specification Version 1.0A May 5, 1994" to autodetect built-in
+	  mainboard resources (e.g. parallel port resources).
+
+	  Some features (e.g. event notification, docking station information,
+	  ISAPNP services) are not currently implemented.
+
+	  If you would like the kernel to detect and allocate resources to
+	  your mainboard devices (on some systems they are disabled by the
+	  BIOS) say Y here.  Also the PNPBIOS can help prevent resource
+	  conflicts between mainboard devices and other bus devices.
+
+	  Note: ACPI is expected to supersede PNPBIOS some day, currently it
+	  co-exists nicely.  If you have a non-ISA system that supports ACPI,
+	  you probably don't need PNPBIOS support.
+
+config PNPBIOS_PROC_FS
+	bool "Plug and Play BIOS /proc interface"
+	depends on PNPBIOS && PROC_FS
+	---help---
+	  If you say Y here and to "/proc file system support", you will be
+	  able to directly access the PNPBIOS.  This includes resource
+	  allocation, ESCD, and other PNPBIOS services.  Using this
+	  interface is potentially dangerous because the PNPBIOS driver will
+	  not be notified of any resource changes made by writting directly.
+	  Also some buggy systems will fault when accessing certain features
+	  in the PNPBIOS /proc interface (e.g. "boot" configs).
+
+	  See the latest pcmcia-cs (stand-alone package) for a nice set of
+	  PNPBIOS /proc interface tools (lspnp and setpnp).
+
+	  Unless you are debugging or have other specific reasons, it is
+	  recommended that you say N here.
+
diff -urN a/drivers/pnp/pnpbios/Makefile b/drivers/pnp/pnpbios/Makefile
--- a/drivers/pnp/pnpbios/Makefile	2003-10-25 18:44:35.000000000 +0000
+++ b/drivers/pnp/pnpbios/Makefile	2003-11-03 22:10:53.000000000 +0000
@@ -2,6 +2,6 @@
 # Makefile for the kernel PNPBIOS driver.
 #

-pnpbios-proc-$(CONFIG_PROC_FS) = proc.o
+pnpbios-proc-$(CONFIG_PNPBIOS_PROC_FS) = proc.o

 obj-y := core.o bioscalls.o rsparser.o $(pnpbios-proc-y)
diff -urN a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
--- a/drivers/pnp/pnpbios/pnpbios.h	2003-10-25 18:43:17.000000000 +0000
+++ b/drivers/pnp/pnpbios/pnpbios.h	2003-11-03 22:11:38.000000000 +0000
@@ -36,7 +36,7 @@
 extern void pnpbios_print_status(const char * module, u16 status);
 extern void pnpbios_calls_init(union pnp_bios_install_struct * header);

-#ifdef CONFIG_PROC_FS
+#ifdef CONFIG_PNPBIOS_PROC_FS
 extern int pnpbios_interface_attach_device(struct pnp_bios_node * node);
 extern int pnpbios_proc_init (void);
 extern void pnpbios_proc_exit (void);
@@ -44,4 +44,4 @@
 static inline int pnpbios_interface_attach_device(struct pnp_bios_node * node) { return 0; }
 static inline int pnpbios_proc_init (void) { return 0; }
 static inline void pnpbios_proc_exit (void) { ; }
-#endif /* CONFIG_PROC */
+#endif /* CONFIG_PNPBIOS_PROC_FS */
