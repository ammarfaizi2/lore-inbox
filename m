Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRDSQeN>; Thu, 19 Apr 2001 12:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbRDSQeF>; Thu, 19 Apr 2001 12:34:05 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:8434 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S131323AbRDSQdy>; Thu, 19 Apr 2001 12:33:54 -0400
Date: Thu, 19 Apr 2001 17:33:52 +0100
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [patch, take 1] parport_serial (was Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport))
Message-ID: <20010419173352.E19831@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <3ACF6223.41F138CF@mandrakesoft.com> <20010408224540.C2623@albireo.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010408224540.C2623@albireo.ucw.cz>; from mj@suse.cz on Sun, Apr 08, 2001 at 10:45:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a first take on a module for providing a framework for
supporting parallel/serial multi-IO cards.

Tim.
*/

2001-04-19  Tim Waugh  <twaugh@redhat.com>
 
        * drivers/parport/parport_pc.c: Un-__devinit the probe function
        and export it.
        * drivers/parport/parport_serial.c: New file.
        * drivers/parport/Makefile: Build it.
        * drivers/char/Config.in: Configure it.
        * drivers/parport/ChangeLog: Updated.

--- linux/drivers/parport/parport_pc.c.multiio	Thu Apr 19 16:52:07 2001
+++ linux/drivers/parport/parport_pc.c	Thu Apr 19 16:52:50 2001
@@ -1983,10 +1983,10 @@
 
 /* --- Initialisation code -------------------------------- */
 
-struct parport *__devinit parport_pc_probe_port (unsigned long int base,
-						 unsigned long int base_hi,
-						 int irq, int dma,
-						 struct pci_dev *dev)
+struct parport *parport_pc_probe_port (unsigned long int base,
+				       unsigned long int base_hi,
+				       int irq, int dma,
+				       struct pci_dev *dev)
 {
 	struct parport_pc_private *priv;
 	struct parport_operations *ops;
@@ -2631,16 +2631,7 @@
 }
 
 /* Exported symbols. */
-#ifdef CONFIG_PARPORT_PC_PCMCIA
-
-/* parport_cs needs this in order to dyncamically get us to find ports. */
 EXPORT_SYMBOL (parport_pc_probe_port);
-
-#else
-
-EXPORT_NO_SYMBOLS;
-
-#endif
 
 #ifdef MODULE
 static int io[PARPORT_PC_MAX_PORTS+1] = { [0 ... PARPORT_PC_MAX_PORTS] = 0 };
--- linux/drivers/parport/Makefile.multiio	Tue Jan  2 15:01:47 2001
+++ linux/drivers/parport/Makefile	Thu Apr 19 16:52:50 2001
@@ -22,6 +22,7 @@
 
 obj-$(CONFIG_PARPORT)		+= parport.o
 obj-$(CONFIG_PARPORT_PC)	+= parport_pc.o
+obj-$(CONFIG_PARPORT_SERIAL)	+= parport_serial.o
 obj-$(CONFIG_PARPORT_AMIGA)	+= parport_amiga.o
 obj-$(CONFIG_PARPORT_MFC3)	+= parport_mfc3.o
 obj-$(CONFIG_PARPORT_ATARI)	+= parport_atari.o
--- linux/drivers/parport/ChangeLog.multiio	Thu Apr 19 16:52:07 2001
+++ linux/drivers/parport/ChangeLog	Thu Apr 19 16:52:50 2001
@@ -0,0 +1,5 @@
+2001-04-19  Tim Waugh  <twaugh@redhat.com>
+
+	* parport_pc.c (parport_pc_probe_port): Remove __devinit
+	attribute.  Export unconditionally.
+
--- linux/drivers/parport/parport_serial.c.multiio	Thu Apr 19 16:52:50 2001
+++ linux/drivers/parport/parport_serial.c	Thu Apr 19 17:02:28 2001
@@ -0,0 +1,301 @@
+/*
+ * Support for common PCI multi-I/O cards (which is most of them)
+ *
+ * Copyright (C) 2001  Tim Waugh <twaugh@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ *
+ * Multi-function PCI cards are supposed to present separate logical
+ * devices on the bus.  A common thing to do seems to be to just use
+ * one logical device with lots of base address registers for both
+ * parallel ports and serial ports.  This driver is for dealing with
+ * that.
+ * 
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/parport.h>
+#include <linux/parport_pc.h>
+#include <linux/serial.h>
+#include <linux/serialP.h>
+#include <linux/list.h>
+
+#include <asm/serial.h>
+
+enum parport_pc_pci_cards {
+	titan_110l = 0,
+	titan_210l,
+};
+
+
+/* each element directly indexed from enum list, above */
+static struct parport_pc_pci {
+	int numports;
+	struct { /* BAR (base address registers) numbers in the config
+                    space header */
+		int lo;
+		int hi; /* -1 if not there, >6 for offset-method (max
+                           BAR is 6) */
+	} addr[4];
+} cards[] __devinitdata = {
+	/* titan_110l */		{ 1, { { 3, -1 }, } },
+	/* titan_210l */		{ 1, { { 3, -1 }, } },
+};
+
+// For pci_ids.h:
+#define PCI_DEVICE_ID_TITAN_110L	0x8011
+#define PCI_DEVICE_ID_TITAN_210L	0x8021
+
+static struct pci_device_id parport_serial_pci_tbl[] __devinitdata = {
+	/* PCI cards */
+	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_110L,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_110l },
+	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
+	{ 0, } /* terminate list */
+};
+MODULE_DEVICE_TABLE(pci,parport_serial_pci_tbl);
+
+struct pci_board_no_ids {
+	int flags;
+	int num_ports;
+	int base_baud;
+	int uart_offset;
+	int reg_shift;
+	int (*init_fn)(struct pci_dev *dev, struct pci_board_no_ids *board,
+			int enable);
+	int first_uart_offset;
+};
+
+static struct pci_board_no_ids pci_boards[] __devinitdata = {
+	/*
+	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
+	 * Offset to get to next UART's registers,
+	 * Register shift to use for memory-mapped I/O,
+	 * Initialization function, first UART offset
+	 */
+
+/* titan_110l */	{ SPCI_FL_BASE1, 1, 921600 },
+/* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
+};
+
+struct parport_serial_private {
+	int num;
+	int line[20];
+	struct pci_board_no_ids ser;
+	struct parport *port;
+};
+
+static int __devinit get_pci_port (struct pci_dev *dev,
+				   struct pci_board_no_ids *board,
+				   struct serial_struct *req,
+				   int idx)
+{
+	unsigned long port;
+	int base_idx;
+	int max_port;
+	int offset;
+
+	base_idx = SPCI_FL_GET_BASE(board->flags);
+	if (board->flags & SPCI_FL_BASE_TABLE)
+		base_idx += idx;
+
+	if (board->flags & SPCI_FL_REGION_SZ_CAP) {
+		max_port = pci_resource_len(dev, base_idx) / 8;
+		if (idx >= max_port)
+			return 1;
+	}
+			
+	offset = board->first_uart_offset;
+
+	/* Timedia/SUNIX uses a mixture of BARs and offsets */
+	/* Ugh, this is ugly as all hell --- TYT */
+	if(dev->vendor == PCI_VENDOR_ID_TIMEDIA )  /* 0x1409 */
+		switch(idx) {
+			case 0: base_idx=0;
+				break;
+			case 1: base_idx=0; offset=8;
+				break;
+			case 2: base_idx=1; 
+				break;
+			case 3: base_idx=1; offset=8;
+				break;
+			case 4: /* BAR 2*/
+			case 5: /* BAR 3 */
+			case 6: /* BAR 4*/
+			case 7: base_idx=idx-2; /* BAR 5*/
+		}
+  
+	port =  pci_resource_start(dev, base_idx) + offset;
+
+	if ((board->flags & SPCI_FL_BASE_TABLE) == 0)
+		port += idx * (board->uart_offset ? board->uart_offset : 8);
+
+	if (pci_resource_flags (dev, base_idx) & IORESOURCE_IO) {
+		int high_bits_offset = ((sizeof(long)-sizeof(int))*8);
+		req->port = port;
+		if (high_bits_offset)
+			req->port_high = port >> high_bits_offset;
+		else
+			req->port_high = 0;
+		return 0;
+	}
+	req->io_type = SERIAL_IO_MEM;
+	req->iomem_base = ioremap(port, board->uart_offset);
+	req->iomem_reg_shift = board->reg_shift;
+	req->port = 0;
+	return req->iomem_base ? 0 : 1;
+}
+
+/* Register the serial port(s) of a PCI card. */
+static int __devinit serial_register (struct pci_dev *dev,
+				      const struct pci_device_id *id)
+{
+	struct pci_board_no_ids *board = &pci_boards[id->driver_data];
+	struct parport_serial_private *priv = pci_get_drvdata (dev);
+	struct serial_struct serial_req;
+	int base_baud;
+	int k;
+	int success = 0;
+
+	priv->ser = *board;
+	if (board->init_fn && ((board->init_fn) (dev, board, 1) != 0))
+		return 1;
+
+	base_baud = board->base_baud;
+	if (!base_baud)
+		base_baud = BASE_BAUD;
+	memset (&serial_req, 0, sizeof (serial_req));
+
+	for (k = 0; k < board->num_ports; k++) {
+		int line;
+		serial_req.irq = dev->irq;
+		if (get_pci_port (dev, board, &serial_req, k))
+			break;
+		serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
+		line = register_serial (&serial_req);
+		if (line < 0) {
+			printk (KERN_DEBUG
+				"parport_serial: register_serial failed\n");
+			continue;
+		}
+		priv->line[priv->num++] = line;
+		success = 1;
+	}
+
+	return success ? 0 : 1;
+}
+
+/* Register the parallel port(s) of a PCI card. */
+static int __devinit parport_register (struct pci_dev *dev,
+				       const struct pci_device_id *id)
+{
+	struct parport_serial_private *priv = pci_get_drvdata (dev);
+	int i = id->driver_data, n;
+	int success = 0;
+
+	for (n = 0; n < cards[i].numports; n++) {
+		int lo = cards[i].addr[n].lo;
+		int hi = cards[i].addr[n].hi;
+		unsigned long io_lo, io_hi;
+		io_lo = pci_resource_start (dev, lo);
+		io_hi = 0;
+		if ((hi >= 0) && (hi <= 6))
+			io_hi = pci_resource_start (dev, hi);
+		else if (hi > 6)
+			io_lo += hi; /* Reinterpret the meaning of
+                                        "hi" as an offset (see SYBA
+                                        def.) */
+		/* TODO: test if sharing interrupts works */
+		printk (KERN_DEBUG "PCI parallel port detected: %04x:%04x, "
+			"I/O at %#lx(%#lx)\n",
+			parport_serial_pci_tbl[i].vendor,
+			parport_serial_pci_tbl[i].device, io_lo, io_hi);
+		priv->port = parport_pc_probe_port (io_lo, io_hi,
+						    PARPORT_IRQ_NONE,
+						    PARPORT_DMA_NONE, dev);
+		if (priv->port)
+			success = 1;
+	}
+
+	return success ? 0 : 1;
+}
+
+static int __devinit parport_serial_pci_probe (struct pci_dev *dev,
+					       const struct pci_device_id *id)
+{
+	struct parport_serial_private *priv;
+	int err;
+
+	priv = kmalloc (sizeof *priv, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+	priv->num = 0;
+	pci_set_drvdata (dev, priv);
+
+	err = pci_enable_device (dev);
+	if (err) {
+		pci_set_drvdata (dev, NULL);
+		kfree (priv);
+		return err;
+	}
+
+	if (serial_register (dev, id) + parport_register (dev, id)) {
+		pci_set_drvdata (dev, NULL);
+		kfree (priv);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void __devexit parport_serial_pci_remove (struct pci_dev *dev)
+{
+	struct parport_serial_private *priv = pci_get_drvdata (dev);
+	int i;
+
+	for (i = 0; i < priv->num; i++) {
+		unregister_serial (priv->line[i]);
+
+		if (priv->ser.init_fn)
+			(priv->ser.init_fn) (dev, &priv->ser, 0);
+	}
+
+	parport_unregister_port (priv->port);
+
+	pci_set_drvdata (dev, NULL);
+	kfree (priv);
+	return;
+}
+
+static struct pci_driver parport_serial_pci_driver = {
+	name:		"parport_serial",
+	id_table:	parport_serial_pci_tbl,
+	probe:		parport_serial_pci_probe,
+	remove:		parport_serial_pci_remove,
+};
+
+
+static int __init parport_serial_init (void)
+{
+	return pci_module_init (&parport_serial_pci_driver);
+}
+
+static void __exit parport_serial_exit (void)
+{
+	pci_unregister_driver (&parport_serial_pci_driver);
+	return;
+}
+
+MODULE_AUTHOR("Tim Waugh <twaugh@redhat.com>");
+MODULE_DESCRIPTION("Driver for common parallel+serial multi-I/O PCI cards");
+
+module_init(parport_serial_init);
+module_exit(parport_serial_exit);
--- linux/Documentation/Configure.help.multiio	Thu Apr 19 16:51:40 2001
+++ linux/Documentation/Configure.help	Thu Apr 19 16:53:47 2001
@@ -3695,6 +3695,11 @@
   
   If unsure, say Y.
 
+Parallel+serial PCI card support
+CONFIG_PARPORT_SERIAL
+  You should say Y here.  If you say M, the module will be called
+  parport_serial.o.
+
 Use FIFO/DMA if available
 CONFIG_PARPORT_PC_FIFO
   Many parallel port chipsets provide hardware that can speed up
