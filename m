Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTKPFbs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 00:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKPFbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 00:31:48 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:36000 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262360AbTKPFbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 00:31:23 -0500
Date: Sun, 16 Nov 2003 00:27:18 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Fixes for 2.6.0-test9
Message-ID: <20031116002718.GD13220@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20031116002620.GB13220@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031116002620.GB13220@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# --------------------------------------------
# 03/11/15	ambx1@neo.rr.com	1.1449
# [PnPBIOS] make /proc interface an optional feature
# 
# The PnPBIOS /proc interface provides direct access to PnPBIOS calls.
# These calls can be potentially dangerous, especially on buggy systems.
# Therefore, this patch provides an option for PnPBIOS calls to be
# managed by the PnPBIOS driver exclusively.  This patch also updates
# the KConfig documentation accordingly.
# --------------------------------------------
#
diff -Nru a/drivers/pnp/Kconfig b/drivers/pnp/Kconfig
--- a/drivers/pnp/Kconfig	Sun Nov 16 00:25:01 2003
+++ b/drivers/pnp/Kconfig	Sun Nov 16 00:25:01 2003
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
 
diff -Nru a/drivers/pnp/isapnp/Kconfig b/drivers/pnp/isapnp/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pnp/isapnp/Kconfig	Sun Nov 16 00:25:01 2003
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
diff -Nru a/drivers/pnp/pnpbios/Kconfig b/drivers/pnp/pnpbios/Kconfig
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pnp/pnpbios/Kconfig	Sun Nov 16 00:25:01 2003
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
+	  in the PNPBIOS /proc interface (e.g. ESCD).
+
+	  See the latest pcmcia-cs (stand-alone package) for a nice set of
+	  PNPBIOS /proc interface tools (lspnp and setpnp).
+
+	  Unless you are debugging or have other specific reasons, it is
+	  recommended that you say N here.
+
diff -Nru a/drivers/pnp/pnpbios/Makefile b/drivers/pnp/pnpbios/Makefile
--- a/drivers/pnp/pnpbios/Makefile	Sun Nov 16 00:25:01 2003
+++ b/drivers/pnp/pnpbios/Makefile	Sun Nov 16 00:25:01 2003
@@ -2,6 +2,6 @@
 # Makefile for the kernel PNPBIOS driver.
 #
 
-pnpbios-proc-$(CONFIG_PROC_FS) = proc.o
+pnpbios-proc-$(CONFIG_PNPBIOS_PROC_FS) = proc.o
 
 obj-y := core.o bioscalls.o rsparser.o $(pnpbios-proc-y)
diff -Nru a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
--- a/drivers/pnp/pnpbios/pnpbios.h	Sun Nov 16 00:25:01 2003
+++ b/drivers/pnp/pnpbios/pnpbios.h	Sun Nov 16 00:25:01 2003
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
