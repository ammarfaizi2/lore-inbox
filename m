Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTAOIFs>; Wed, 15 Jan 2003 03:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbTAOIFs>; Wed, 15 Jan 2003 03:05:48 -0500
Received: from pop-zh-7-1-dialup-253.freesurf.ch ([194.230.203.253]:6016 "EHLO
	valsheda.taprogge.wh") by vger.kernel.org with ESMTP
	id <S265843AbTAOIFr>; Wed, 15 Jan 2003 03:05:47 -0500
Date: Wed, 15 Jan 2003 09:11:09 +0100
From: Jens Taprogge <taprogge@idg.rwth-aachen.de>
To: mikpe@csd.uu.se, zwane@holomorphy.com, bvermeul@blackstar.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] cardbus/hotplugging still broken in 2.5.56
Message-ID: <20030115081109.GA3839@valsheda.taprogge.wh>
Mail-Followup-To: Jens Taprogge <taprogge@idg.rwth-aachen.de>,
	mikpe@csd.uu.se, zwane@holomorphy.com, bvermeul@blackstar.nl,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The cardbus problems are caused by 

ChangeSet@1.797.145.6  2002-11-25 18:31:10-08:00 davej@codemonkey.org.uk

as far as I can tell. 

pci_enable_device() will fail at least on i386 (see
arch/i386/pci/i386.c: pcibios_enable_resource (line 260)) if the
resources have not been assigned previously. Hence the ostensible
resource collisions.

The attached patch should fix the problem.

I have send the patch to Dave Jones some time ago but did not hear from
him yet.

I am not subscribed to the list so please cc me on replys. 

Jens

-- 
Jens Taprogge

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cardbus_fix_2.5.52.patch"

diff -ur linux-2.5.51/drivers/pcmcia/cardbus.c linux-2.5.51_jlt/drivers/pcmcia/cardbus.c
--- linux-2.5.51/drivers/pcmcia/cardbus.c	2002-12-10 03:45:52.000000000 +0100
+++ linux-2.5.51_jlt/drivers/pcmcia/cardbus.c	2002-12-10 22:19:46.000000000 +0100
@@ -229,6 +229,17 @@
     
 =====================================================================*/
 
+static void cb_free_resources(struct pci_dev *dev)
+{
+	int i;
+
+	for (i = 0; i < 7; i++) {
+		struct resource *res = dev->resource + i;
+		if (res->parent)
+			release_resource(res);
+	}
+}
+
 int cb_alloc(socket_info_t * s)
 {
 	struct pci_bus *bus;
@@ -283,25 +294,31 @@
 		dev->hdr_type = hdr & 0x7f;
 
 		pci_setup_device(dev);
-		if (pci_enable_device(dev))
-			continue;
 
 		strcpy(dev->dev.bus_id, dev->slot_name);
 
 		/* FIXME: Do we need to enable the expansion ROM? */
 		for (r = 0; r < 7; r++) {
 			struct resource *res = dev->resource + r;
-			if (res->flags)
-				pci_assign_resource(dev, r);
+			if (res->flags && pci_assign_resource(dev, r) < 0) {
+				cb_free_resources(dev);
+				continue;
+			}
 		}
 
 		/* Does this function have an interrupt at all? */
 		pci_readb(dev, PCI_INTERRUPT_PIN, &irq_pin);
-		if (irq_pin) {
+		if (irq_pin)
 			dev->irq = irq;
-			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
+
+		if (pci_enable_device(dev)) {
+			cb_free_resources(dev);
+			continue;
 		}
 
+		if (irq_pin)
+			pci_writeb(dev, PCI_INTERRUPT_LINE, irq);
+		
 		device_register(&dev->dev);
 		pci_insert_device(dev, bus);
 	}


--VbJkn9YxBvnuCH5J--
