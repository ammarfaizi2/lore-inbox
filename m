Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTJCQdJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 12:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTJCQdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 12:33:09 -0400
Received: from ee.oulu.fi ([130.231.61.23]:40625 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263529AbTJCQdF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 12:33:05 -0400
Date: Fri, 3 Oct 2003 19:33:01 +0300
From: Pekka Pietikainen <pp@ee.oulu.fi>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] b44 enable interrupts after tx timeout (2.6-test version)
Message-ID: <20031003163301.GA25032@ee.oulu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resending the patch I sent some time ago for b44.c that nukes the
2.4 compatibility cruft as well. 

I'll do one for 2.4.23pre6 ASAP, hopefully being able sync the driver fully
with the one in 2.6 (free_netdev() etc.).

--- linux-2.6.0-0.test6.1.47/drivers/net/b44.c.orig	2003-09-28 03:50:18.000000000 +0300
+++ linux-2.6.0-0.test6.1.47/drivers/net/b44.c	2003-10-03 18:55:29.000000000 +0300
@@ -25,8 +25,8 @@
 
 #define DRV_MODULE_NAME		"b44"
 #define PFX DRV_MODULE_NAME	": "
-#define DRV_MODULE_VERSION	"0.9"
-#define DRV_MODULE_RELDATE	"Jul 14, 2003"
+#define DRV_MODULE_VERSION	"0.91"
+#define DRV_MODULE_RELDATE	"Oct 3, 2003"
 
 #define B44_DEF_MSG_ENABLE	  \
 	(NETIF_MSG_DRV		| \
@@ -80,15 +80,6 @@
 
 static int b44_debug = -1;	/* -1 == use B44_DEF_MSG_ENABLE as value */
 
-#ifndef PCI_DEVICE_ID_BCM4401
-#define PCI_DEVICE_ID_BCM4401      0x4401
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
-#define IRQ_RETVAL(x) 
-#define irqreturn_t void
-#endif
-
 static struct pci_device_id b44_pci_tbl[] = {
 	{ PCI_VENDOR_ID_BROADCOM, PCI_DEVICE_ID_BCM4401,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0UL },
@@ -870,6 +861,8 @@
 
 	spin_unlock_irq(&bp->lock);
 
+	b44_enable_ints(bp);
+
 	netif_wake_queue(dev);
 }
 
