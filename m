Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263404AbVCKPrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263404AbVCKPrK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 10:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263398AbVCKPqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 10:46:38 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:34229 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263406AbVCKPig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 10:38:36 -0500
Message-ID: <4231BB7A.6030501@us.ltcfwd.linux.ibm.com>
Date: Fri, 11 Mar 2005 10:38:34 -0500
From: Wen Xiong <wendyx@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wen Xiong <wendyx@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 5/5] drivers/serial/jsm: new serial device driver
References: <20050228063954.GB23595@kroah.com> <4228CE41.2000102@us.ltcfwd.linux.ibm.com> <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com> <20050308235807.GA11807@kroah.com> <422F1A8A.4000106@us.ltcfwd.linux.ibm.com> <20050309163518.GC25079@kroah.com> <422F2FDD.4050908@us.ltcfwd.linux.ibm.com> <20050309185800.GA27268@kroah.com>
In-Reply-To: <20050309185800.GA27268@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------070601080609040508090603"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070601080609040508090603
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is fifth patch for jsm serial device driver.

Signed-off-by: Wen Xiong <wendyx@us.ltcfwd.linux.ibm.com>

--------------070601080609040508090603
Content-Type: text/plain;
 name="patch5.jasmine"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch5.jasmine"

diff -Nuar linux-2.6.11.org/drivers/serial/Kconfig linux-2.6.11.new/drivers/serial/Kconfig
--- linux-2.6.11.org/drivers/serial/Kconfig	2005-03-10 16:28:59.552930408 -0600
+++ linux-2.6.11.new/drivers/serial/Kconfig	2005-03-10 10:31:27.000000000 -0600
@@ -810,4 +810,19 @@
 	bool "TX39XX/49XX SIO act as standard serial"
 	depends on !SERIAL_8250 && SERIAL_TXX9
 
+config SERIAL_JSM
+        tristate "Digi International NEO PCI Support"
+        select SERIAL_CORE
+        help
+          This is a driver for Digi International's Neo series
+          of cards which provide multiple serial ports. You would need
+          something like this to connect more than two modems to your Linux
+          box, for instance in order to become a dial-in server. This driver
+          supports PCI boards only.
+          If you have a card like this, say Y here and read the file
+          <file:Documentation/jsm.txt>.
+
+          To compile this driver as a module, choose M here: the
+          module will be called jsm.
+
 endmenu
diff -Nuar linux-2.6.11.org/drivers/serial/Makefile linux-2.6.11.new/drivers/serial/Makefile
--- linux-2.6.11.org/drivers/serial/Makefile	2005-03-10 16:29:08.488901896 -0600
+++ linux-2.6.11.new/drivers/serial/Makefile	2005-03-10 10:31:39.000000000 -0600
@@ -49,3 +49,4 @@
 obj-$(CONFIG_SERIAL_MPSC) += mpsc.o
 obj-$(CONFIG_ETRAX_SERIAL) += crisv10.o
 obj-$(CONFIG_SERIAL_TXX9) += serial_txx9.o
+obj-$(CONFIG_SERIAL_JSM) += jsm/
diff -Nuar linux-2.6.11.org/drivers/serial/jsm/Makefile linux-2.6.11.new/drivers/serial/jsm/Makefile
--- linux-2.6.11.org/drivers/serial/jsm/Makefile	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6.11.new/drivers/serial/jsm/Makefile	2005-03-10 16:21:17.497884352 -0600
@@ -0,0 +1,8 @@
+#
+# Makefile for Jasmine adapter
+#
+
+obj-$(CONFIG_SERIAL_JSM) += jsm.o
+
+jsm-objs :=    jsm_driver.o jsm_neo.o jsm_tty.o
+
diff -Nuar linux-2.6.11.org/include/linux/pci_ids.h linux-2.6.11.new/include/linux/pci_ids.h
--- linux-2.6.11.org/include/linux/pci_ids.h	2005-03-10 16:31:13.891876144 -0600
+++ linux-2.6.11.new/include/linux/pci_ids.h	2005-03-10 16:24:43.854930712 -0600
@@ -1418,6 +1418,10 @@
 #define PCI_DEVICE_ID_DIGI_DF_M_E	0x0071
 #define PCI_DEVICE_ID_DIGI_DF_M_IOM2_A	0x0072
 #define PCI_DEVICE_ID_DIGI_DF_M_A	0x0073
+#define PCI_DEVICE_ID_NEO_2DB9          0x00C8
+#define PCI_DEVICE_ID_NEO_2DB9PRI       0x00C9
+#define PCI_DEVICE_ID_NEO_2RJ45         0x00CA
+#define PCI_DEVICE_ID_NEO_2RJ45PRI      0x00CB
 
 #define PCI_VENDOR_ID_MUTECH		0x1159
 #define PCI_DEVICE_ID_MUTECH_MV1000	0x0001
diff -Nuar linux-2.6.11.org/include/linux/serial_core.h linux-2.6.11.new/include/linux/serial_core.h
--- linux-2.6.11.org/include/linux/serial_core.h	2005-03-10 16:31:29.338924176 -0600
+++ linux-2.6.11.new/include/linux/serial_core.h	2005-03-10 16:23:42.031877360 -0600
@@ -106,6 +106,9 @@
 /* TXX9 type number */
 #define PORT_TXX9       64
 
+/*Digi jsm */
+#define PORT_JSM        65
+
 #ifdef __KERNEL__
 
 #include <linux/config.h>

--------------070601080609040508090603--

