Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263634AbTKDE0k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 23:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTKDE0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 23:26:40 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:36003 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S263634AbTKDE0e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 23:26:34 -0500
Date: Mon, 3 Nov 2003 23:25:26 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gary Wolfe <gpwolfe@cableone.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [crash/panic] Linux-2.6.0-test9
Message-ID: <20031103232526.GC16854@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Gary Wolfe <gpwolfe@cableone.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3FA5FFF7.2020006@cableone.net> <Pine.LNX.4.44.0311030834230.20373-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311030834230.20373-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 03, 2003 at 08:37:30AM -0800, Linus Torvalds wrote:
>
> On Mon, 3 Nov 2003, Gary Wolfe wrote:
> >
> > Tried test8 and, now, test9 and both exhibit same problem.
> >
> > The issue seems to be related to the PnPBIOS support under the Plug and
> > Play Kconfig category.  When enabled I get a crash of the form:
>
> Yes. The crash happens inside the BIOS itself, and the kernel doesn't
> really have any control over it. The most Adam could possibly do is to
> avoid calling the BIOS (or at least avoid _certain_ calls), but that would
> require knowing what it is that triggers it.

One of the most common triggers is requesting for the dynamic (currently
assigned) resource information.  This tends to happen with particular device
nodes, from what I've seen typically the mouse controller, but I don't have a
large enough sample space to make a generalization.  I've made some
modifications to the PnPBIOS call function in the past and they seem to solve
this problem for many of the buggy systems.

>
> Has PnP support ever worked for you on this board? Sometimes the solution
> is to just say "it's dead, Jim", and just not enable it. There are few
> enough systems that actually want PnP.
>
> Adam, any ideas?
>
> 		Linus

I've included a patch that encourages the PnPBIOS to make more conservative
calls and it should help with situations such as this one.  I'd like to see a
dmi_scan for this system, if it is possible, so I can blacklist certain PnPBIOS
features on it.  I've also attached a patch that makes the pnpbios proc
interface an optional feature. The proc interface allows users to make PnPBIOS
calls without restrictions and as a result can cause problems on some buggy
systems. (one example is the recent ESCD problems posted on lkml)  Finally, the
Kconfig help has been updated to better reflect this viewpoint.

Please let me know if any of this helps.  I'd predict it will boot properly with
the first patch applied.

Thanks,
Adam


--- a/drivers/pnp/pnpbios/core.c	2003-10-25 18:42:49.000000000 +0000
+++ b/drivers/pnp/pnpbios/core.c	2003-11-03 20:12:08.000000000 +0000
@@ -353,16 +353,8 @@

 	for(nodenum=0; nodenum<0xff; ) {
 		u8 thisnodenum = nodenum;
-		/* eventually we will want to use PNPMODE_STATIC here but for now
-		 * dynamic will help us catch buggy bioses to add to the blacklist.
-		 */
-		if (!pnpbios_dont_use_current_config) {
-			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_DYNAMIC, node))
-				break;
-		} else {
-			if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
-				break;
-		}
+		if (pnp_bios_get_dev_node(&nodenum, (char )PNPMODE_STATIC, node))
+			break;
 		nodes_got++;
 		dev =  pnpbios_kmalloc(sizeof (struct pnp_dev), GFP_KERNEL);
 		if (!dev)



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
+++ b/drivers/pnp/pnpbios/Kconfig	2003-11-03 22:13:30.000000000 +0000
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
