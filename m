Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbVCIP0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbVCIP0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVCIP0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 10:26:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:275 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261605AbVCIP0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:26:09 -0500
Date: Wed, 9 Mar 2005 15:26:05 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-parport@lists.infradead.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Hotplug parallel ports
Message-ID: <20050309152605.E25398@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-parport@lists.infradead.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is against 2.6.11.

----

The Mobility docking station provides a PCI-based parallel port.  Since
the docking station connects via Cardbus, such devices are removable.
Therefore, track which parallel ports are registered to each PCI device,
and remove them when the PCI device is removed.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/drivers/parport/parport_pc.c linux/drivers/parport/parport_pc.c
--- orig/drivers/parport/parport_pc.c	Wed Mar  2 14:40:15 2005
+++ linux/drivers/parport/parport_pc.c	Wed Mar  2 10:53:38 2005
@@ -2907,10 +2907,16 @@ static struct pci_device_id parport_pc_p
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
 
+struct pci_parport_data {
+	int num;
+	struct parport *ports[2];
+};
+
 static int parport_pc_pci_probe (struct pci_dev *dev,
 					   const struct pci_device_id *id)
 {
 	int err, count, n, i = id->driver_data;
+	struct pci_parport_data *data;
 
 	if (i < last_sio)
 		/* This is an onboard Super-IO and has already been probed */
@@ -2922,9 +2928,15 @@ static int parport_pc_pci_probe (struct 
 	if ((err = pci_enable_device (dev)) != 0)
 		return err;
 
+	data = kmalloc(sizeof(struct pci_parport_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	if (cards[i].preinit_hook &&
-	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
+	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE)) {
+		kfree(data);
 		return -ENODEV;
+	}
 
 	for (n = 0; n < cards[i].numports; n++) {
 		int lo = cards[i].addr[n].lo;
@@ -2943,21 +2955,46 @@ static int parport_pc_pci_probe (struct 
 			"I/O at %#lx(%#lx)\n",
 			parport_pc_pci_tbl[i + last_sio].vendor,
 			parport_pc_pci_tbl[i + last_sio].device, io_lo, io_hi);
-		if (parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
-					   PARPORT_DMA_NONE, dev))
+		data->ports[count] =
+			parport_pc_probe_port (io_lo, io_hi, PARPORT_IRQ_NONE,
+					       PARPORT_DMA_NONE, dev);
+		if (data->ports[count])
 			count++;
 	}
 
+	data->num = count;
+
 	if (cards[i].postinit_hook)
 		cards[i].postinit_hook (dev, count == 0);
 
-	return count == 0 ? -ENODEV : 0;
+	if (count) {
+		pci_set_drvdata(dev, data);
+		return 0;
+	}
+
+	kfree(data);
+
+	return -ENODEV;
+}
+
+static void __devexit parport_pc_pci_remove(struct pci_dev *dev)
+{
+	struct pci_parport_data *data = pci_get_drvdata(dev);
+	int i;
+
+	pci_set_drvdata(dev, NULL);
+
+	for (i = data->num - 1; i >= 0; i--)
+		parport_pc_unregister_port(data->ports[i]);
+
+	kfree(data);
 }
 
 static struct pci_driver parport_pc_pci_driver = {
 	.name		= "parport_pc",
 	.id_table	= parport_pc_pci_tbl,
 	.probe		= parport_pc_pci_probe,
+	.remove		= __devexit_p(parport_pc_pci_remove),
 };
 
 static int __init parport_pc_init_superio (int autoirq, int autodma)


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
