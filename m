Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266289AbUIIRQQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266289AbUIIRQQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUIIRQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:16:16 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:31758 "EHLO
	cyclades.com.br") by vger.kernel.org with ESMTP id S266289AbUIIRP7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:15:59 -0400
Subject: including Cyclades pc400 board support
From: Germano Barreiro <germano.barreiro@cyclades.com>
Reply-To: germano.barreiro@cyclades.com
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-NlhV1MtOv3+XH/w0luDH"
Organization: Cyclades do Brasil
Message-Id: <1094750272.3348.4.camel@germano.cyclades.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 09 Sep 2004 14:17:52 -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NlhV1MtOv3+XH/w0luDH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Greetings,

This patch includes support in the kernel for pc400 Cyclades board,
which is the only Cyclades board that doesn't have the driver in the
official kernel tree yet, and is intended for review. 

Regards,
Germano



--=-NlhV1MtOv3+XH/w0luDH
Content-Disposition: attachment; filename=cyc-pc400-k2.6.9rc1.patch
Content-Type: text/x-patch; name=cyc-pc400-k2.6.9rc1.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -ruN linux-2.6.9-rc1.orig/Documentation/devices.txt linux-2.6.9-rc1/Documentation/devices.txt
--- linux-2.6.9-rc1.orig/Documentation/devices.txt	2004-09-09 13:08:30.000000000 -0300
+++ linux-2.6.9-rc1/Documentation/devices.txt	2004-09-09 13:14:38.000000000 -0300
@@ -2854,6 +2854,16 @@
 		196 = /dev/dvb/adapter3/video0    first video decoder of fourth card
 
 
+214 char       Cyclades-PC400 Digital RAS Card
+                 0 = /dev/ttyCM0               First PC400 port
+                 1 = /dev/ttyCM1               Second PC400 port
+                    ...
+
+215 char       Cyclades-PC400 Digital RAS Card - altarnate devices
+                 0 = /dev/cucm0                Callout device for ttyCM0
+                 1 = /dev/cucm1                Callout device for ttyCM1
+                    ...
+
 216 char	USB BlueTooth devices
 		  0 = /dev/ttyUB0		First USB BlueTooth device
 		  1 = /dev/ttyUB1		Second USB BlueTooth device
diff -ruN linux-2.6.9-rc1.orig/Documentation/magic-number.txt linux-2.6.9-rc1/Documentation/magic-number.txt
--- linux-2.6.9-rc1.orig/Documentation/magic-number.txt	2004-09-09 13:08:30.000000000 -0300
+++ linux-2.6.9-rc1/Documentation/magic-number.txt	2004-09-09 13:14:38.000000000 -0300
@@ -89,6 +89,7 @@
 TTY_DRIVER_MAGIC      0x5402      tty_driver        include/linux/tty_driver.h
 MGSLPC_MAGIC          0x5402      mgslpc_info       drivers/char/pcmcia/synclink_cs.c
 TTY_LDISC_MAGIC       0x5403      tty_ldisc         include/linux/tty_ldisc.h
+PC400_MAGIC           0x5874      pc400_port        include/linux/pc400.h
 USB_SERIAL_MAGIC      0x6702      usb_serial        drivers/usb/serial/usb-serial.h
 FULL_DUPLEX_MAGIC     0x6969                        drivers/net/tulip/de2104x.c
 USB_BLUETOOTH_MAGIC   0x6d02      usb_bluetooth     drivers/usb/class/bluetty.c
diff -ruN linux-2.6.9-rc1.orig/drivers/char/Kconfig linux-2.6.9-rc1/drivers/char/Kconfig
--- linux-2.6.9-rc1.orig/drivers/char/Kconfig	2004-09-09 13:08:06.000000000 -0300
+++ linux-2.6.9-rc1/drivers/char/Kconfig	2004-09-09 13:14:38.000000000 -0300
@@ -136,6 +136,30 @@
 	  status of the Cyclades-Z ports. The default op mode is polling. If
 	  unsure, say N.
 
+config DIGITAL_RAS
+	bool "Digital RAS Support"
+	depends on EXPERIMENTAL 
+	---help---
+	Support for adapters that turns a PC server into a digital Remote Access Server.
+	Common applications are:
+
+        * Internet Service Providers
+        * Remote Access / Telecommuting
+        * Specialized Communications Systems
+        * Dial-out servers
+
+config PC400_RAS
+	tristate "Cyclades-PC400 support"
+	depends on EXPERIMENTAL && DIGITAL_RAS
+	---help---
+        The Cyclades-PC400 is a digital PCI adapter that turns a PC server
+        into a digital Remote Access Server. It connects to 1 or 2 T1/E1/PRI 
+        trunks and has built-in digital modems and DSU/CSUs.
+        System Integrators and Internet Service Providers can use the PC400 
+        to build RAS solutions taking advantage of commodity hardware 
+        and Open Source software.
+
+
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
 	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
diff -ruN linux-2.6.9-rc1.orig/drivers/char/Makefile linux-2.6.9-rc1/drivers/char/Makefile
--- linux-2.6.9-rc1.orig/drivers/char/Makefile	2004-09-09 13:08:06.000000000 -0300
+++ linux-2.6.9-rc1/drivers/char/Makefile	2004-09-09 13:17:08.000000000 -0300
@@ -39,6 +39,7 @@
 obj-$(CONFIG_AMIGA_BUILTIN_SERIAL) += amiserial.o
 obj-$(CONFIG_SX)		+= sx.o generic_serial.o
 obj-$(CONFIG_RIO)		+= rio/ generic_serial.o
+obj-$(CONFIG_PC400_RAS)         += pc400.o
 obj-$(CONFIG_HVC_CONSOLE)	+= hvc_console.o hvsi.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o
diff -ruN linux-2.6.9-rc1.orig/include/linux/major.h linux-2.6.9-rc1/include/linux/major.h
--- linux-2.6.9-rc1.orig/include/linux/major.h	2004-09-09 13:08:35.000000000 -0300
+++ linux-2.6.9-rc1/include/linux/major.h	2004-09-09 13:14:38.000000000 -0300
@@ -160,6 +160,10 @@
 
 #define OSST_MAJOR		206	/* OnStream-SCx0 SCSI tape */
 
+#define PC400_CALLIN_MAJOR      214
+#define PC400_CALLOUT_MAJOR     215
+
 #define IBM_TTY3270_MAJOR	227
 #define IBM_FS3270_MAJOR	228
 
diff -ruN linux-2.6.9-rc1.orig/include/linux/pci_ids.h linux-2.6.9-rc1/include/linux/pci_ids.h
--- linux-2.6.9-rc1.orig/include/linux/pci_ids.h	2004-09-09 13:08:36.000000000 -0300
+++ linux-2.6.9-rc1/include/linux/pci_ids.h	2004-09-09 13:14:38.000000000 -0300
@@ -1575,6 +1575,8 @@
 #define PCI_DEVICE_ID_PC300_TE_1	0x0311
 #define PCI_DEVICE_ID_PC300_TE_M_2	0x0320
 #define PCI_DEVICE_ID_PC300_TE_M_1	0x0321
+#define PCI_DEVICE_ID_PC400             0x0400
 
 #define PCI_VENDOR_ID_ESSENTIAL		0x120f
 #define PCI_DEVICE_ID_ESSENTIAL_ROADRUNNER	0x0001

--=-NlhV1MtOv3+XH/w0luDH--

