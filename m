Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268745AbTGIXnX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 19:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268720AbTGIXkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 19:40:37 -0400
Received: from palrel12.hp.com ([156.153.255.237]:33229 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S268745AbTGIXhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 19:37:31 -0400
Date: Wed, 9 Jul 2003 16:52:10 -0700
To: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5 IrDA] setup dma fix
Message-ID: <20030709235210.GG12747@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ir254_setup_dma_fix-3.diff :
~~~~~~~~~~~~~~~~~~~~~~~~~~
	o [CORRECT] Make ISA drivers depend on ISA. This is the consequence
		from David's change to setup_dma().
	o [CORRECT] Make new dongle drivers depend on sir-dev (they require it)
	o [FEATURE] Make old dongle drivers depend on irtty/irport
	o [FEATURE] irda-usb driver is no longer experimental


diff -u -p linux/include/net/irda/irda_device.d2.h linux/include/net/irda/irda_device.h
--- linux/include/net/irda/irda_device.d2.h	Wed Jul  9 11:58:10 2003
+++ linux/include/net/irda/irda_device.h	Wed Jul  9 11:58:28 2003
@@ -230,7 +230,9 @@ int  irda_device_register_dongle(struct 
 dongle_t *irda_device_dongle_init(struct net_device *dev, int type);
 int irda_device_dongle_cleanup(dongle_t *dongle);
 
+#ifdef CONFIG_ISA
 void setup_dma(int channel, char *buffer, int count, int mode);
+#endif
 
 void irda_task_delete(struct irda_task *task);
 int  irda_task_kick(struct irda_task *task);
diff -u -p linux/drivers/net/irda/Kconfig.d2 linux/drivers/net/irda/Kconfig
--- linux/drivers/net/irda/Kconfig.d2	Wed Jul  9 11:56:56 2003
+++ linux/drivers/net/irda/Kconfig	Wed Jul  9 12:02:24 2003
@@ -22,6 +22,7 @@ comment "Dongle support"
 
 config DONGLE
 	bool "Serial dongle support"
+	depends on IRTTY_SIR
 	help
 	  Say Y here if you have an infrared device that connects to your
 	  computer's serial port. These devices are called dongles. Then say Y
@@ -69,7 +70,7 @@ comment "Old SIR device drivers"
 
 config IRTTY_OLD
 	tristate "Old IrTTY (broken)"
-	depends on IRDA
+	depends on IRDA && EXPERIMENTAL
 	help
 	  Say Y here if you want to build support for the IrTTY line
 	  discipline.  If you want to compile it as a module (irtty), say M
@@ -102,6 +103,7 @@ comment "Old Serial dongle support"
 
 config DONGLE_OLD
 	bool "Old Serial dongle support"
+	depends on IRTTY_OLD || IRPORT_SIR
 	help
 	  Say Y here if you have an infrared device that connects to your
 	  computer's serial port. These devices are called dongles. Then say Y
@@ -226,8 +228,8 @@ config MA600_DONGLE
 comment "FIR device drivers"
 
 config USB_IRDA
-	tristate "IrDA USB dongles (EXPERIMENTAL)"
-	depends on IRDA && USB && EXPERIMENTAL
+	tristate "IrDA USB dongles"
+	depends on IRDA && USB
 	---help---
 	  Say Y here if you want to build support for the USB IrDA FIR Dongle
 	  device driver.  If you want to compile it as a module (irda-usb),
@@ -243,7 +245,7 @@ config USB_IRDA
 
 config NSC_FIR
 	tristate "NSC PC87108/PC87338"
-	depends on IRDA
+	depends on IRDA && ISA
 	help
 	  Say Y here if you want to build support for the NSC PC87108 and
 	  PC87338 IrDA chipsets.  This driver supports SIR,
@@ -255,7 +257,7 @@ config NSC_FIR
 
 config WINBOND_FIR
 	tristate "Winbond W83977AF (IR)"
-	depends on IRDA
+	depends on IRDA && ISA
 	help
 	  Say Y here if you want to build IrDA support for the Winbond
 	  W83977AF super-io chipset.  This driver should be used for the IrDA
@@ -295,7 +297,7 @@ config AU1000_FIR
 
 config SMC_IRCC_OLD
 	tristate "SMC IrCC (old driver) (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA
+	depends on EXPERIMENTAL && IRDA && ISA
 	help
 	  Say Y here if you want to build support for the SMC Infrared
 	  Communications Controller.  It is used in the Fujitsu Lifebook 635t
@@ -307,7 +309,7 @@ config SMC_IRCC_OLD
 
 config SMC_IRCC_FIR
 	tristate "SMSC IrCC (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA
+	depends on EXPERIMENTAL && IRDA && ISA
 	help
 	  Say Y here if you want to build support for the SMC Infrared
 	  Communications Controller.  It is used in a wide variety of
@@ -318,7 +320,7 @@ config SMC_IRCC_FIR
 
 config ALI_FIR
 	tristate "ALi M5123 FIR (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && IRDA
+	depends on EXPERIMENTAL && IRDA && ISA
 	help
 	  Say Y here if you want to build support for the ALi M5123 FIR
 	  Controller.  The ALi M5123 FIR Controller is embedded in ALi M1543C,
