Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264029AbUDFWGy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264036AbUDFWGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:06:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2783 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264029AbUDFWFD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:05:03 -0400
Subject: [PATCH] make ibmasm driver uart support depend on SERIAL_8250
From: Max Asbock <masbock@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1081289097.6129.58.camel@DYN318100BLD.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 06 Apr 2004 15:04:57 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes serial line registration in the ibmasm 
service processor driver depend on CONFIG_SERIAL_8250.
Previously the driver wouldn't compile when serial driver
support wasn't enabled.

regards,
max

diff -urN linux-2.6.5/drivers/misc/ibmasm/ibmasm.h linux-2.6.5-ibmasm/drivers/misc/ibmasm/ibmasm.h
--- linux-2.6.5/drivers/misc/ibmasm/ibmasm.h	2004-04-03 19:36:18.000000000 -0800
+++ linux-2.6.5-ibmasm/drivers/misc/ibmasm/ibmasm.h	2004-04-06 10:56:31.000000000 -0700
@@ -220,5 +220,10 @@
 extern void ibmasmfs_add_sp(struct service_processor *sp);
 
 /* uart */
+#ifdef CONFIG_SERIAL_8250
 extern void ibmasm_register_uart(struct service_processor *sp);
 extern void ibmasm_unregister_uart(struct service_processor *sp);
+#else
+#define ibmasm_register_uart(sp)	do { } while(0)
+#define ibmasm_unregister_uart(sp)	do { } while(0)
+#endif
diff -urN linux-2.6.5/drivers/misc/ibmasm/Makefile linux-2.6.5-ibmasm/drivers/misc/ibmasm/Makefile
--- linux-2.6.5/drivers/misc/ibmasm/Makefile	2004-04-03 19:37:37.000000000 -0800
+++ linux-2.6.5-ibmasm/drivers/misc/ibmasm/Makefile	2004-04-06 13:07:54.000000000 -0700
@@ -1,7 +1,7 @@
 
 obj-$(CONFIG_IBM_ASM) := ibmasm.o
 
-ibmasm-objs :=	module.o      \
+ibmasm-y :=	module.o      \
 		ibmasmfs.o    \
 		event.o       \
 		command.o     \
@@ -9,5 +9,7 @@
 		heartbeat.o   \
 		r_heartbeat.o \
 		dot_command.o \
-		lowlevel.o    \
-		uart.o
+		lowlevel.o
+
+ibmasm-$(CONFIG_SERIAL_8250) += uart.o
+
diff -urN linux-2.6.5/drivers/misc/Kconfig linux-2.6.5-ibmasm/drivers/misc/Kconfig
--- linux-2.6.5/drivers/misc/Kconfig	2004-04-03 19:36:26.000000000 -0800
+++ linux-2.6.5-ibmasm/drivers/misc/Kconfig	2004-04-06 13:50:49.924254952 -0700
@@ -16,7 +16,9 @@
 	  processor. The driver is meant to be used in conjunction with
 	  a user space API.
 	  The ibmasm driver also enables the OS to use the UART on the
-          service processor board as a regular serial port.
+	  service processor board as a regular serial port. To make use of
+	  this feature serial driver support (CONFIG_SERIAL_8250) must be
+	  enabled.
 	  
 
 	  If unsure, say N.


