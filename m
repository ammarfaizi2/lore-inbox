Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUBKVxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 16:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266188AbUBKVw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 16:52:56 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:4575 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S266170AbUBKVwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 16:52:40 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] Add location clues to ttyS discovery
Date: Wed, 11 Feb 2004 14:52:37 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402111452.37656.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch against 2.6.3-rc2 adds a little descriptive information to
serial port discovery.  Sample output:

    ttyS0 at MMIO 0xf8030000 (HCDP PCI 0000:e0:01.1, irq = 49) is a 16550A
    ttyS1 at MMIO 0xf8031000 (PCI 0000:e0:01.0, irq = 49) is a 16550A
    ttyS2 at MMIO 0xf8030010 (PCI 0000:e0:01.1, irq = 49) is a 16550A
    ttyS3 at MMIO 0xf8030038 (PCI 0000:e0:01.1, irq = 49) is a 16550A
    ttyS4 at MMIO 0xff5e0000 (ACPI SER0, irq = 67) is a 16550A


===== drivers/serial/8250.c 1.43 vs edited =====
--- 1.43/drivers/serial/8250.c	Fri Jan  2 12:35:07 2004
+++ edited/drivers/serial/8250.c	Wed Feb 11 14:08:16 2004
@@ -2041,6 +2051,7 @@
 	port.iotype   = req->io_type;
 	port.flags    = req->flags | UPF_BOOT_AUTOCONF;
 	port.mapbase  = req->iomap_base;
+	port.desc     = req->desc;
 	port.line     = line;
 
 	if (share_irqs)
===== drivers/serial/8250_acpi.c 1.7 vs edited =====
--- 1.7/drivers/serial/8250_acpi.c	Fri Jan 16 15:01:45 2004
+++ edited/drivers/serial/8250_acpi.c	Wed Feb 11 14:43:07 2004
@@ -25,6 +25,7 @@
 struct serial_private {
 	int	line;
 	void	*iomem_base;
+	char	*desc;
 };
 
 static acpi_status acpi_serial_mmio(struct serial_struct *req,
@@ -106,7 +107,8 @@
 	struct serial_private *priv;
 	acpi_status status;
 	struct serial_struct serial_req;
-	int result;
+	char *prefix = "ACPI ";
+	int len, result;
 
 	memset(&serial_req, 0, sizeof(serial_req));
 
@@ -117,6 +119,14 @@
 	}
 	memset(priv, 0, sizeof(*priv));
 
+	len = strlen(prefix) + strlen(device->pnp.bus_id) + 1;
+	priv->desc = kmalloc(len, GFP_KERNEL);
+	if (!priv->desc) {
+		result = -ENOMEM;
+		goto fail;
+	}
+	snprintf(priv->desc, len, "%s%s", prefix, device->pnp.bus_id);
+
 	status = acpi_walk_resources(device->handle, METHOD_NAME__CRS,
 				     acpi_serial_resource, &serial_req);
 	if (ACPI_FAILURE(status)) {
@@ -136,6 +146,7 @@
 	serial_req.baud_base = BASE_BAUD;
 	serial_req.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF |
 			   UPF_AUTO_IRQ  | UPF_RESOURCES;
+	serial_req.desc = priv->desc;
 
 	priv->line = register_serial(&serial_req);
 	if (priv->line < 0) {
@@ -151,6 +162,8 @@
 fail:
 	if (serial_req.iomem_base)
 		iounmap(serial_req.iomem_base);
+	if (priv->desc)
+		kfree(priv->desc);
 	kfree(priv);
 
 	return result;
@@ -167,6 +180,7 @@
 	unregister_serial(priv->line);
 	if (priv->iomem_base)
 		iounmap(priv->iomem_base);
+	kfree(priv->desc);
 	kfree(priv);
 
 	return 0;
===== drivers/serial/8250_hcdp.c 1.2 vs edited =====
--- 1.2/drivers/serial/8250_hcdp.c	Sun Jan 11 16:27:13 2004
+++ edited/drivers/serial/8250_hcdp.c	Wed Feb 11 14:44:27 2004
@@ -28,6 +28,8 @@
 
 #undef SERIAL_DEBUG_HCDP
 
+static char hcdp_description[] = "HCDP PCI 0000:00:00.0";
+
 /*
  * Parse the HCDP table to find descriptions for headless console and debug
  * serial ports and add them to rs_table[]. A pointer to HCDP table is
@@ -188,6 +190,12 @@
 		port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_RESOURCES;
 		if (gsi)
 			port.flags |= ASYNC_AUTO_IRQ;
+
+		snprintf(hcdp_description, sizeof(hcdp_description),
+			"HCDP PCI %04x:%02x:%02x.%d",
+			hcdp_dev->pci_seg, hcdp_dev->pci_bus,
+			hcdp_dev->pci_dev, hcdp_dev->pci_func);
+		port.desc = hcdp_description;
 
 		/*
 		 * Note: the above memset() initializes port.line to 0,
===== drivers/serial/8250_pci.c 1.28 vs edited =====
--- 1.28/drivers/serial/8250_pci.c	Thu Jan 29 17:41:49 2004
+++ edited/drivers/serial/8250_pci.c	Wed Feb 11 14:42:54 2004
@@ -85,6 +85,7 @@
 	unsigned int		nr;
 	void			*remapped_bar[PCI_NUM_BAR_RESOURCES];
 	struct pci_serial_quirk	*quirk;
+	char			*desc;
 	int			line[0];
 };
 
@@ -1440,7 +1441,8 @@
 	struct pci_board *board, tmp;
 	struct pci_serial_quirk *quirk;
 	struct serial_struct serial_req;
-	int base_baud, rc, nr_ports, i;
+	int base_baud, rc, nr_ports, i, len;
+	char *prefix = "PCI ";
 
 	if (ent->driver_data >= ARRAY_SIZE(pci_boards)) {
 		printk(KERN_ERR "pci_init_one: invalid driver_data: %ld\n",
@@ -1516,6 +1518,13 @@
 			sizeof(unsigned int) * nr_ports);
 
 	priv->quirk = quirk;
+	len = strlen(prefix) + strlen(pci_name(dev)) + 1;
+	priv->desc = kmalloc(len, GFP_KERNEL);
+	if (!priv->desc) {
+		rc = -ENOMEM;
+		goto deinit;
+	}
+	sprintf(priv->desc, "%s%s", prefix, pci_name(dev));
 	pci_set_drvdata(dev, priv);
 
 	base_baud = board->base_baud;
@@ -1529,6 +1538,7 @@
 				   UPF_RESOURCES | UPF_SHARE_IRQ;
 		serial_req.baud_base = base_baud;
 		serial_req.irq = get_pci_irq(dev, board, i);
+		serial_req.desc = priv->desc;
 		if (quirk->setup(dev, board, &serial_req, i))
 			break;
 #ifdef SERIAL_DEBUG_PCI
@@ -1583,6 +1593,7 @@
 
 		pci_disable_device(dev);
 
+		kfree(priv->desc);
 		kfree(priv);
 	}
 }
===== drivers/serial/serial_core.c 1.78 vs edited =====
--- 1.78/drivers/serial/serial_core.c	Sat Jan 24 14:53:13 2004
+++ edited/drivers/serial/serial_core.c	Wed Feb 11 14:08:20 2004
@@ -1978,7 +1975,10 @@
 		printk("MMIO 0x%lx", port->mapbase);
 		break;
 	}
-	printk(" (irq = %d) is a %s\n", port->irq, uart_type(port));
+	printk(" (");
+	if (port->desc)
+		printk("%s, ", port->desc);
+	printk("irq = %d) is a %s\n", port->irq, uart_type(port));
 }
 
 static void
@@ -2382,6 +2382,7 @@
 			state->port->flags    = port->flags;
 			state->port->line     = state - drv->state;
 			state->port->mapbase  = port->mapbase;
+			state->port->desc     = port->desc;
 
 			uart_configure_port(drv, state, state->port);
 		}
===== include/linux/serial.h 1.10 vs edited =====
--- 1.10/include/linux/serial.h	Wed Oct  1 13:43:06 2003
+++ edited/include/linux/serial.h	Wed Feb 11 14:08:21 2004
@@ -49,6 +49,7 @@
 	unsigned short	iomem_reg_shift;
 	unsigned int	port_high;
 	unsigned long	iomap_base;	/* cookie passed into ioremap */
+	char	*desc;
 };
 
 /*
===== include/linux/serial_core.h 1.28 vs edited =====
--- 1.28/include/linux/serial_core.h	Tue Sep  9 06:14:17 2003
+++ edited/include/linux/serial_core.h	Wed Feb 11 14:08:22 2004
@@ -210,6 +210,7 @@
 	unsigned long		mapbase;		/* for ioremap */
 	unsigned char		hub6;			/* this should be in the 8250 driver */
 	unsigned char		unused[3];
+	char			*desc;
 };
 
 /*

