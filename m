Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129610AbQLRNks>; Mon, 18 Dec 2000 08:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131271AbQLRNki>; Mon, 18 Dec 2000 08:40:38 -0500
Received: from r1873.muc.dial.surf-callino.de ([213.21.8.95]:2308 "EHLO
	notebook.diehl.home") by vger.kernel.org with ESMTP
	id <S129610AbQLRNkd>; Mon, 18 Dec 2000 08:40:33 -0500
Date: Mon, 18 Dec 2000 14:10:50 +0100 (CET)
From: Martin Diehl <mdiehlcs@compuserve.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Mares <mj@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] yenta, pm - part 2
In-Reply-To: <Pine.LNX.4.10.10012151042170.2255-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012181345371.579-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is part 2 of the yenta+pm updates for 2.4.0-t12 - to be applied after
part 1. Touching yenta.c only it provides:

- yenta_validate_base() to check and try to fix in case the BIOS has
  mapped the cardbus base registers to the legacy area <1M.
  IMHO, this would be better placed in the early pci initialization,
  but I prefered keeping all changes inside yenta_socket at pre-2.4.0.
- writing back the cardbus bridges' memory and io windows at resume in
  case they were lost. As it turned out this is the only additional thing
  to do for the TI1131, I've put that in the general yenta_config_init()
  as there might be other controllers with the same problem and it should
  not hurt anyway.
- adding pci_set_master() to yenta_open().

This should fix problems caused by bad BIOS configuration or
configuration loss at suspend.

Testing: Both parts together on HP Omnibook 800: Regardless what the BIOS
has done (Cardbus enable/disable, PnP OS yes/no), bad things are detected
and fixed and yenta is now working with pm, even when suspending
immediately after boot and modprobing the yenta stuff later - i.e. we do
not depend on saving something to restore before we suspend for the first
time. Tested with 16bit modem and ne2k card.

Thank you for pointing me in the right direction.

Regards
Martin

-----
--- v2.4.0-t12-yenta1/driver/pcmcia/yenta.c	Sun Dec 17 20:00:17 2000
+++ v2.4.0-t12-yenta2/driver/pcmcia/yenta.c	Mon Dec 18 11:50:42 2000
@@ -623,14 +623,24 @@
 
 /*
  * Initialize the standard cardbus registers
+ * and write back bridge windows in case controller forgot it.
  */
 static void yenta_config_init(pci_socket_t *socket)
 {
 	u16 bridge;
 	struct pci_dev *dev = socket->dev;
+	struct resource *res;
+	u32 offset;
+	unsigned i;
 
 	config_writel(socket, CB_LEGACY_MODE_BASE, 0);
 	config_writel(socket, PCI_BASE_ADDRESS_0, dev->resource[0].start);
+	for (i = 0; i < 4; i++) {
+		res = socket->dev->resource + PCI_BRIDGE_RESOURCES + i;
+		offset = PCI_CB_MEMORY_BASE_0 + 8 * i;
+		config_writel(socket, offset, res->start);
+		config_writel(socket, offset+4, res->end);
+	}
 	config_writew(socket, PCI_COMMAND,
 			PCI_COMMAND_IO |
 			PCI_COMMAND_MEMORY |
@@ -676,17 +686,6 @@
 static int yenta_suspend(pci_socket_t *socket)
 {
 	yenta_set_socket(socket, &dead_socket);
-
-	/*
-	 * This does not work currently. The controller
-	 * loses too much informationduring D3 to come up
-	 * cleanly. We should probably fix yenta_init()
-	 * to update all the critical registers, notably
-	 * the IO and MEM bridging region data.. That is
-	 * something that pci_set_power_state() should
-	 * probably know about bridges anyway.
-	 */
-
 	return 0;
 }
 
@@ -796,11 +795,66 @@
 
 #define NR_OVERRIDES (sizeof(cardbus_override)/sizeof(struct cardbus_override_struct))
 
+/* BIOS might have mapped devices' base resource to a bogus memory area
+ * and - even worse - the hostbridge looses this window during suspend.
+ * So we try to detect and fix this by re-assigning the resource if we
+ * find the base resource mapped to legacy area <1M. But we don't try
+ * this, if the obsolete MEM_TYPE_1M flag is set, just in case...
+ */
+
+static void yenta_validate_base(struct pci_dev *dev)
+{
+	struct resource *res;
+	u32 temp, size;
+
+	res = &dev->resource[0];
+	if (!res || !(res->flags&IORESOURCE_MEM) || res->start>=0x00100000)
+		return;
+
+	pci_set_power_state(dev,0);
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+	if (temp & PCI_BASE_ADDRESS_MEM_TYPE_1M) {
+		printk("yenta: found pci memory mapped to <1M legacy area\n");
+		printk("yenta: not touched since (obsolete) 1M type set\n");
+		return;
+	}
+	printk("yenta: fixing bogus pci memory mapping %08lx\n", res->start);
+
+	pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, ~0x0);
+	pci_read_config_dword(dev, PCI_BASE_ADDRESS_0, &temp);
+	if (temp & PCI_BASE_ADDRESS_SPACE_IO) {
+		printk("yenta: pci memory mutated to io - giving up!\n");
+		pci_write_config_dword(dev, PCI_BASE_ADDRESS_0, res->start);
+		return;
+	}
+
+	/* semi-optimal - old values lost if failure (pretty unlikely).
+	 * save & restore would require access to the resource list lock,
+	 * which is private in kernel/resource.c
+	 */
+
+	release_resource(res);
+
+	size =  ~(u32)(temp & PCI_BASE_ADDRESS_MEM_MASK);
+	res->name = dev->name;
+	res->start = 0;
+	res->end = res->start + size;
+	res->flags = IORESOURCE_MEM;
+	if (temp & PCI_BASE_ADDRESS_MEM_PREFETCH)
+		res->flags |= IORESOURCE_PREFETCH; 
+	res->parent = res->child = res->sibling = NULL;
+	pci_assign_resource(dev,0);	
+}
+
 /*
  * Initialize a cardbus controller. Make sure we have a usable
  * interrupt, and that we can map the cardbus area. Fill in the
  * socket information structure..
+ * Validating the BIOS-provided base resource mapping before the device
+ * is enabled helps to resolve conflicts with the cardbus bridge windows,
+ * which might already been set but not yet requested.
  */
+
 static int yenta_open(pci_socket_t *socket)
 {
 	int i;
@@ -809,12 +863,14 @@
 	/*
 	 * Do some basic sanity checking..
 	 */
+	yenta_validate_base(dev);
 	if (pci_enable_device(dev))
 		return -1;
 	if (!pci_resource_start(dev, 0)) {
 		printk("No cardbus resource!\n");
 		return -1;
 	}
+	pci_set_master(dev);
 
 	/*
 	 * Ok, start setup.. Map the cardbus registers,



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
