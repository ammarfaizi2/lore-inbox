Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266286AbSKGCDS>; Wed, 6 Nov 2002 21:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266287AbSKGCDS>; Wed, 6 Nov 2002 21:03:18 -0500
Received: from dhcp024-209-039-058.neo.rr.com ([24.209.39.58]:41604 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S266286AbSKGCDQ>;
	Wed, 6 Nov 2002 21:03:16 -0500
Date: Wed, 6 Nov 2002 21:13:14 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH] Update serial PnP driver - 2.5.46 (6/6)
Message-ID: <20021106211314.GQ316@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates the serial PnP driver to the changes.

Thanks,
Adam



--- a/drivers/serial/8250_pnp.c	Thu Oct 31 00:41:37 2002
+++ b/drivers/serial/8250_pnp.c	Sun Nov  3 15:44:43 2002
@@ -316,6 +316,8 @@
 	{	"",			0	}
 };
 
+MODULE_DEVICE_TABLE(pnp, pnp_dev_table);
+
 static void inline avoid_irq_share(struct pnp_dev *dev)
 {
 	unsigned int map = 0x1FF8;
@@ -393,10 +395,10 @@
 	if (flags & SPCI_FL_NO_SHIRQ)
 		avoid_irq_share(dev);
 	memset(&serial_req, 0, sizeof(serial_req));
-	serial_req.irq = dev->irq_resource[0].start;
-	serial_req.port = pci_resource_start(dev, 0);
+	serial_req.irq = pnp_irq(dev,0);
+	serial_req.port = pnp_port_start(dev, 0);
 	if (HIGH_BITS_OFFSET)
-		serial_req.port = dev->resource[0].start >> HIGH_BITS_OFFSET;
+		serial_req.port = pnp_port_start(dev, 0) >> HIGH_BITS_OFFSET;
 #ifdef SERIAL_DEBUG_PNP
 	printk("Setup PNP port: port %x, irq %d, type %d\n",
 	       serial_req.port, serial_req.irq, serial_req.io_type);
@@ -407,7 +409,7 @@
 	line = register_serial(&serial_req);
 
 	if (line >= 0)
-		dev->driver_data = (void *)(line + 1);
+		pnp_set_drvdata(dev, (void *)(line + 1));
 	return line >= 0 ? 0 : -ENODEV;
 
 }
@@ -442,5 +444,3 @@
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Generic 8250/16x50 PnP serial driver");
-/* FIXME */
-/*MODULE_DEVICE_TABLE(pnpbios, pnp_dev_table);*/
