Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752078AbWCBXSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbWCBXSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbWCBXR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:17:59 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:50891 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1752078AbWCBXR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:17:58 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Marc Zyngier <maz@wild-wind.fr.eu.org>
Subject: [PATCH] EISA: tidy-up driver_register() return value
Date: Thu, 2 Mar 2006 16:17:55 -0700
User-Agent: KMail/1.8.3
Cc: Rick Richardson <rick@remotepoint.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021617.55396.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that driver_register() returns the number of
devices bound to the driver.  In fact, it returns zero for success
or a negative error value.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/eisa/eisa-bus.c
===================================================================
--- work-mm4.orig/drivers/eisa/eisa-bus.c	2006-03-01 15:37:40.000000000 -0700
+++ work-mm4/drivers/eisa/eisa-bus.c	2006-03-02 12:50:15.000000000 -0700
@@ -162,13 +162,8 @@
 
 int eisa_driver_register (struct eisa_driver *edrv)
 {
-	int r;
-	
 	edrv->driver.bus = &eisa_bus_type;
-	if ((r = driver_register (&edrv->driver)) < 0)
-		return r;
-
-	return 0;
+	return driver_register (&edrv->driver);
 }
 
 void eisa_driver_unregister (struct eisa_driver *edrv)
Index: work-mm4/drivers/net/3c59x.c
===================================================================
--- work-mm4.orig/drivers/net/3c59x.c	2006-03-01 15:37:41.000000000 -0700
+++ work-mm4/drivers/net/3c59x.c	2006-03-02 12:52:20.000000000 -0700
@@ -1087,9 +1087,11 @@
 {
 	int eisa_found = 0;
 	int orig_cards_found = vortex_cards_found;
+	int err;
 
 #ifdef CONFIG_EISA
-	if (eisa_driver_register (&vortex_eisa_driver) >= 0) {
+	err = eisa_driver_register (&vortex_eisa_driver);
+	if (!err) {
 			/* Because of the way EISA bus is probed, we cannot assume
 			 * any device have been found when we exit from
 			 * eisa_driver_register (the bus root driver may not be
Index: work-mm4/drivers/net/dgrs.c
===================================================================
--- work-mm4.orig/drivers/net/dgrs.c	2006-01-02 20:21:10.000000000 -0700
+++ work-mm4/drivers/net/dgrs.c	2006-03-02 12:54:20.000000000 -0700
@@ -1551,7 +1551,7 @@
 static int __init dgrs_init_module (void)
 {
 	int	i;
-	int	cardcount = 0;
+	int	err;
 
 	/*
 	 *	Command line variable overrides
@@ -1593,13 +1593,13 @@
 	 *	Find and configure all the cards
 	 */
 #ifdef CONFIG_EISA
-	cardcount = eisa_driver_register(&dgrs_eisa_driver);
-	if (cardcount < 0)
-		return cardcount;
+	err = eisa_driver_register(&dgrs_eisa_driver);
+	if (err)
+		return err;
 #endif
-	cardcount = pci_register_driver(&dgrs_pci_driver);
-	if (cardcount)
-		return cardcount;
+	err = pci_register_driver(&dgrs_pci_driver);
+	if (err)
+		return err;
 	return 0;
 }
 
