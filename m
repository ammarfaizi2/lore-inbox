Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263080AbTDYNNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 09:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbTDYNNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 09:13:42 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:28036 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263080AbTDYNNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 09:13:38 -0400
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] 2.5.68 small generic HDLC update
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 25 Apr 2003 01:57:35 +0200
Message-ID: <m3y91zbg9c.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Hi,

This small and probably obvious update should apply cleanly to Linux
2.5.68. Please apply. Thanks.
-- 
Krzysztof Halasa
Network Administrator

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=hdlc-2.5.68.patch

--- linux-2.5.orig/drivers/net/wan/n2.c	2003-04-18 22:54:41.000000000 +0200
+++ linux-2.5/drivers/net/wan/n2.c	2003-04-18 23:26:56.000000000 +0200
@@ -217,15 +217,9 @@
 	int io = port->card->io;
 	u8 mcr = inb(io + N2_MCR) | (port->phy_node ? TX422_PORT1:TX422_PORT0);
 
-
-	if (!try_module_get(THIS_MODULE))
-		return -EFAULT;	/* rmmod in progress */
-
 	int result = hdlc_open(hdlc);
-	if (result) {
+	if (result)
 		return result;
-		module_put(THIS_MODULE);
-	}
 
 	mcr &= port->phy_node ? ~DTR_PORT1 : ~DTR_PORT0; /* set DTR ON */
 	outb(mcr, io + N2_MCR);
@@ -250,7 +244,6 @@
 	mcr |= port->phy_node ? DTR_PORT1 : DTR_PORT0; /* set DTR OFF */
 	outb(mcr, io + N2_MCR);
 	hdlc_close(hdlc);
-	module_put(THIS_MODULE);
 	return 0;
 }
 
@@ -450,6 +443,7 @@
 			port->log_node = 1;
 
 		spin_lock_init(&port->lock);
+		SET_MODULE_OWNER(dev);
 		dev->irq = irq;
 		dev->mem_start = winbase;
 		dev->mem_end = winbase + USE_WINDOWSIZE-1;
--- linux-2.5.orig/drivers/net/wan/c101.c	2003-04-18 22:54:41.000000000 +0200
+++ linux-2.5/drivers/net/wan/c101.c	2003-04-18 23:27:02.000000000 +0200
@@ -156,14 +156,9 @@
 	hdlc_device *hdlc = dev_to_hdlc(dev);
 	port_t *port = hdlc_to_port(hdlc);
 
-	if (!try_module_get(THIS_MODULE))
-		return -EFAULT;	/* rmmod in progress */
-
 	int result = hdlc_open(hdlc);
-	if (result) {
+	if (result)
 		return result;
-		module_put(THIS_MODULE);
-	}
 
 	writeb(1, port->win0base + C101_DTR);
 	sca_out(0, MSCI1_OFFSET + CTL, port); /* RTS uses ch#2 output */
@@ -182,7 +177,6 @@
 	writeb(0, port->win0base + C101_DTR);
 	sca_out(CTL_NORTS, MSCI1_OFFSET + CTL, port);
 	hdlc_close(hdlc);
-	module_put(THIS_MODULE);
 	return 0;
 }
 
@@ -318,6 +312,7 @@
 	dev = hdlc_to_dev(&card->hdlc);
 
 	spin_lock_init(&card->lock);
+	SET_MODULE_OWNER(dev);
 	dev->irq = irq;
 	dev->mem_start = winbase;
 	dev->mem_end = winbase + C101_MAPPED_RAM_SIZE - 1;
--- linux-2.5.orig/drivers/net/wan/Kconfig	2003-04-18 22:54:41.000000000 +0200
+++ linux-2.5/drivers/net/wan/Kconfig	2003-04-25 01:50:52.000000000 +0200
@@ -255,8 +255,8 @@
 
  	  If you want to compile the driver as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
-	  say M here and read Documentation/modules.txt.  The module
-	  will be called hdlc.o.
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called hdlc.
 
 	  If unsure, say N here.
 
@@ -363,7 +363,7 @@
 	  If you want to compile the driver as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
 	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called n2.o.
+	  will be called n2.
 
 	  If unsure, say N here.
 
@@ -378,7 +378,7 @@
 	  If you want to compile the driver as a module ( = code which can be
 	  inserted in and removed from the running kernel whenever you want),
 	  say M here and read <file:Documentation/modules.txt>.  The module
-	  will be called c101.o.
+	  will be called c101.
 
 	  If unsure, say N here.
 

--=-=-=--
