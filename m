Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262670AbVAKXz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262670AbVAKXz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 18:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVAKXzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:55:21 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:21463 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S262670AbVAKXwd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:52:33 -0500
Subject: [PATCH] include PNP device names in /proc/ioports and debug output
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: ambx1@neo.rr.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 11 Jan 2005 16:52:24 -0700
Message-Id: <1105487544.31942.70.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Include PNP device names in /proc/ioports and when matching
driver with devices.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== drivers/pnp/driver.c 1.14 vs edited =====
--- 1.14/drivers/pnp/driver.c	2003-03-09 16:44:14 -07:00
+++ edited/drivers/pnp/driver.c	2005-01-11 14:57:28 -07:00
@@ -94,7 +94,7 @@
 	pnp_dev = to_pnp_dev(dev);
 	pnp_drv = to_pnp_driver(dev->driver);
 
-	pnp_dbg("match found with the PnP device '%s' and the driver '%s'", dev->bus_id,pnp_drv->name);
+	pnp_dbg("match found with the PnP device '%s' (%s) and the driver '%s'", dev->bus_id, pnp_dev->name, pnp_drv->name);
 
 	error = pnp_device_attach(pnp_dev);
 	if (error < 0)
===== drivers/pnp/system.c 1.12 vs edited =====
--- 1.12/drivers/pnp/system.c	2004-10-19 10:54:38 -06:00
+++ edited/drivers/pnp/system.c	2005-01-11 11:21:49 -07:00
@@ -21,18 +21,19 @@
 	{	"",			0	}
 };
 
-static void reserve_ioport_range(char *pnpid, int start, int end)
+static void reserve_ioport_range(struct pnp_dev *dev, int start, int end)
 {
 	struct resource *res;
 	char *regionid;
+	int length = strlen(dev->dev.bus_id) + strlen(dev->name) + 8;
 
-	regionid = kmalloc(16, GFP_KERNEL);
-	if ( regionid == NULL )
+	regionid = kmalloc(length, GFP_KERNEL);
+	if (regionid == NULL)
 		return;
-	snprintf(regionid, 16, "pnp %s", pnpid);
-	res = request_region(start,end-start+1,regionid);
-	if ( res == NULL )
-		kfree( regionid );
+	snprintf(regionid, length, "pnp %s (%s)", dev->dev.bus_id, dev->name);
+	res = request_region(start, end - start + 1, regionid);
+	if (res == NULL)
+		kfree(regionid);
 	else
 		res->flags &= ~IORESOURCE_BUSY;
 	/*
@@ -41,15 +42,15 @@
 	 * have double reservations.
 	 */
 	printk(KERN_INFO
-		"pnp: %s: ioport range 0x%x-0x%x %s reserved\n",
-		pnpid, start, end,
+		"pnp: %s (%s): ioport range 0x%x-0x%x %s reserved\n",
+		dev->dev.bus_id, dev->name, start, end,
 		NULL != res ? "has been" : "could not be"
 	);
 
 	return;
 }
 
-static void reserve_resources_of_dev( struct pnp_dev *dev )
+static void reserve_resources_of_dev(struct pnp_dev *dev)
 {
 	int i;
 
@@ -76,7 +77,7 @@
 			/* Do nothing */
 			continue;
 		reserve_ioport_range(
-			dev->dev.bus_id,
+			dev,
 			pnp_port_start(dev, i),
 			pnp_port_end(dev, i)
 		);


