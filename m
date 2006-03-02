Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751688AbWCBXKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751688AbWCBXKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 18:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWCBXKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 18:10:20 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:41409 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751290AbWCBXJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 18:09:59 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH 9/9] PNP: adjust pnp_register_driver signature
Date: Thu, 2 Mar 2006 16:09:57 -0700
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@suse.cz>,
       Matthieu Castet <castet.matthieu@free.fr>,
       Li Shaohua <shaohua.li@intel.com>, Andrew Morton <akpm@osdl.org>
References: <200603021601.27467.bjorn.helgaas@hp.com>
In-Reply-To: <200603021601.27467.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021609.57333.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the assumption that pnp_register_driver() returns the number of
devices claimed.  Returning the count is unreliable because devices may
be hot-plugged in the future.

This changes the convention to "zero for success, or a negative error
value," which matches pci_register_driver(), acpi_bus_register_driver(),
and platform_driver_register().

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: work-mm4/drivers/pnp/driver.c
===================================================================
--- work-mm4.orig/drivers/pnp/driver.c	2006-03-02 12:40:45.000000000 -0700
+++ work-mm4/drivers/pnp/driver.c	2006-03-02 12:46:49.000000000 -0700
@@ -201,31 +201,14 @@
 	.resume = pnp_bus_resume,
 };
 
-
-static int count_devices(struct device * dev, void * c)
-{
-	int * count = c;
-	(*count)++;
-	return 0;
-}
-
 int pnp_register_driver(struct pnp_driver *drv)
 {
-	int count;
-
 	pnp_dbg("the driver '%s' has been registered", drv->name);
 
 	drv->driver.name = drv->name;
 	drv->driver.bus = &pnp_bus_type;
 
-	count = driver_register(&drv->driver);
-
-	/* get the number of initial matches */
-	if (count >= 0){
-		count = 0;
-		driver_for_each_device(&drv->driver, NULL, &count, count_devices);
-	}
-	return count;
+	return driver_register(&drv->driver);
 }
 
 void pnp_unregister_driver(struct pnp_driver *drv)
Index: work-mm4/drivers/pnp/card.c
===================================================================
--- work-mm4.orig/drivers/pnp/card.c	2006-03-02 12:40:45.000000000 -0700
+++ work-mm4/drivers/pnp/card.c	2006-03-02 12:46:49.000000000 -0700
@@ -47,7 +47,7 @@
 {
 	dev->card_link = NULL;
 }
- 
+
 static void card_remove_first(struct pnp_dev * dev)
 {
 	struct pnp_card_driver * drv = to_pnp_card_driver(dev->driver);
@@ -373,7 +373,7 @@
 
 int pnp_register_card_driver(struct pnp_card_driver * drv)
 {
-	int count;
+	int error;
 	struct list_head *pos, *temp;
 
 	drv->link.name = drv->name;
@@ -384,21 +384,19 @@
 	drv->link.suspend = drv->suspend ? card_suspend : NULL;
 	drv->link.resume = drv->resume ? card_resume : NULL;
 
-	count = pnp_register_driver(&drv->link);
-	if (count < 0)
-		return count;
+	error = pnp_register_driver(&drv->link);
+	if (error < 0)
+		return error;
 
 	spin_lock(&pnp_lock);
 	list_add_tail(&drv->global_list, &pnp_card_drivers);
 	spin_unlock(&pnp_lock);
 
-	count = 0;
-
 	list_for_each_safe(pos,temp,&pnp_cards){
 		struct pnp_card *card = list_entry(pos, struct pnp_card, global_list);
-		count += card_probe(card,drv);
+		card_probe(card,drv);
 	}
-	return count;
+	return 0;
 }
 
 /**
Index: work-mm4/Documentation/pnp.txt
===================================================================
--- work-mm4.orig/Documentation/pnp.txt	2006-03-02 12:40:45.000000000 -0700
+++ work-mm4/Documentation/pnp.txt	2006-03-02 12:48:01.000000000 -0700
@@ -115,6 +115,9 @@
 pnp_register_driver
 - adds a PnP driver to the Plug and Play Layer
 - this includes driver model integration
+- returns zero for success or a negative error number for failure; count
+  calls to the .add() method if you need to know how many devices bind to
+  the driver
 
 pnp_unregister_driver
 - removes a PnP driver from the Plug and Play Layer
