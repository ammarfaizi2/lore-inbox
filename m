Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262379AbVCVXRW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbVCVXRW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 18:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVCVXRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 18:17:22 -0500
Received: from atlrel8.hp.com ([156.153.255.206]:37842 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S262379AbVCVXPB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 18:15:01 -0500
Subject: [PATCH] Netmos parallel/serial/combo support
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: linux-parport@lists.infradead.org
Cc: linux-serial@vger.kernel.org, darryl@netbauds.net, rjshaw@netspace.net.au,
       reinelt@eunet.at, rmk+serial@arm.linux.org.uk, dh@winterwolf.co.uk,
       wd@denx.de, giraffe@danubian.hu, kerry@theslavinfamily.com,
       darac@darac.org.uk, akpm@osdl.org, thor@math.TU-Berlin.DE,
       steven@brudenell.name, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 22 Mar 2005 16:14:13 -0700
Message-Id: <1111533253.22819.2.camel@eeyore>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another iteration of my patch for better Netmos support.
This is against 2.6.12-rc1-mm1.  Kerry and Darac have sucessfully
tested a similar patch with 9835 cards.  I think we're ready for
wider testing, such as -mm.

There's a bugzilla entry for this here:
    http://bugzilla.kernel.org/show_bug.cgi?id=4334

I'd like to hear about any problems or issues (or even better,
about successes, of course :-)).  If you encounter a problem,
please include the dmesg log and the output of "lspci -vvn".


This should fix all the problems I know about with Netmos combo cards:
    - 9735, 9835, and 9855 are not supported
    - combo cards with parallel are erroneously claimed by serial driver
    - serial and parport_serial blindly probe for ports

parport_pc:
    Sort Netmos device IDs, no functional change.
parport_serial:
    Previously supported 9735 and 9835.  Add 9745, 9845, 9855, and
    add init hooks to discover how many serial/parallel ports are
    actually present (the boards are available in various configs).
    Add protection for overflow of static tables.
quirks:
    Detect Netmos combo (parallel + serial) cards and change class from
    SERIAL to OTHER to prevent serial driver from claiming them.
8250:
    Add init hook to discover the number of serial ports present.
    This prevents us from poking at unused BARs.
pci_ids:
    Add Netmos 9745, 9845, and sort.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

diff -u -r 2.6.12-rc1-mm1/drivers/parport/parport_pc.c 2.6.12-rc1-mm1-netmos/drivers/parport/parport_pc.c
--- 2.6.12-rc1-mm1/drivers/parport/parport_pc.c	2005-03-21 14:45:57.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/drivers/parport/parport_pc.c	2005-03-21 14:52:40.000000000 -0700
@@ -2733,11 +2733,11 @@
 	aks_0100,
 	mobility_pp,
 	netmos_9705,
+	netmos_9715,
+	netmos_9755,
 	netmos_9805,
 	netmos_9815,
 	netmos_9855,
-	netmos_9755,
-	netmos_9715
 };
 
 
@@ -2808,11 +2808,11 @@
 	/* aks_0100 */                  { 1, { { 0, -1 }, } },
 	/* mobility_pp */		{ 1, { { 0, 1 }, } },
 	/* netmos_9705 */               { 1, { { 0, -1 }, } }, /* untested */
+        /* netmos_9715 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
+        /* netmos_9755 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
 	/* netmos_9805 */               { 1, { { 0, -1 }, } }, /* untested */
 	/* netmos_9815 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
 	/* netmos_9855 */               { 2, { { 0, -1 }, { 2, -1 }, } }, /* untested */
-        /* netmos_9755 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
-        /* netmos_9715 */               { 2, { { 0, 1 }, { 2, 3 },} }, /* untested */
 };
 
 static struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2885,16 +2885,16 @@
 	/* NetMos communication controllers */
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9705,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9705 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9715,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9755,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9805,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9805 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9815,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9815 },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9855 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9755,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9755 },
-	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9715,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9715 },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci,parport_pc_pci_tbl);
diff -u -r 2.6.12-rc1-mm1/drivers/parport/parport_serial.c 2.6.12-rc1-mm1-netmos/drivers/parport/parport_serial.c
--- 2.6.12-rc1-mm1/drivers/parport/parport_serial.c	2005-03-02 00:38:25.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/drivers/parport/parport_serial.c	2005-03-22 13:19:08.000000000 -0700
@@ -33,8 +33,7 @@
 enum parport_pc_pci_cards {
 	titan_110l = 0,
 	titan_210l,
-	netmos_9735,
-	netmos_9835,
+	netmos_9xx5_combo,
 	avlab_1s1p,
 	avlab_1s1p_650,
 	avlab_1s1p_850,
@@ -51,9 +50,8 @@
 	siig_2s1p_20x,
 };
 
-
 /* each element directly indexed from enum list, above */
-static struct parport_pc_pci {
+struct parport_pc_pci {
 	int numports;
 	struct { /* BAR (base address registers) numbers in the config
                     space header */
@@ -65,16 +63,30 @@
 	/* If set, this is called immediately after pci_enable_device.
 	 * If it returns non-zero, no probing will take place and the
 	 * ports will not be used. */
-	int (*preinit_hook) (struct pci_dev *pdev, int autoirq, int autodma);
+	int (*preinit_hook) (struct pci_dev *pdev, struct parport_pc_pci *card,
+				int autoirq, int autodma);
 
 	/* If set, this is called after probing for ports.  If 'failed'
 	 * is non-zero we couldn't use any of the ports. */
-	void (*postinit_hook) (struct pci_dev *pdev, int failed);
-} cards[] __devinitdata = {
+	void (*postinit_hook) (struct pci_dev *pdev,
+				struct parport_pc_pci *card, int failed);
+};
+
+static int __devinit netmos_parallel_init(struct pci_dev *dev, struct parport_pc_pci *card, int autoirq, int autodma)
+{
+	/*
+	 * Netmos uses the subdevice ID to indicate the number of parallel
+	 * and serial ports.  The form is 0x00PS, where <P> is the number of
+	 * parallel ports and <S> is the number of serial ports.
+	 */
+	card->numports = (dev->subsystem_device & 0xf0) >> 4;
+	return 0;
+}
+
+static struct parport_pc_pci cards[] __devinitdata = {
 	/* titan_110l */		{ 1, { { 3, -1 }, } },
 	/* titan_210l */		{ 1, { { 3, -1 }, } },
-	/* netmos_9735 (not tested) */	{ 1, { { 2, -1 }, } },
-	/* netmos_9835 */		{ 1, { { 2, -1 }, } },
+	/* netmos_9xx5_combo */		{ 1, { { 2, -1 }, }, netmos_parallel_init },
 	/* avlab_1s1p     */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_650 */		{ 1, { { 1, 2}, } },
 	/* avlab_1s1p_850 */		{ 1, { { 1, 2}, } },
@@ -98,9 +110,17 @@
 	{ PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_210L,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, titan_210l },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9735,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9735 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9745,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
 	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
-	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9835 },
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9845,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
+	{ PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9855,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, netmos_9xx5_combo },
 	/* PCI_VENDOR_ID_AVLAB/Intek21 has another bunch of cards ...*/
 	{ 0x14db, 0x2110, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p},
 	{ 0x14db, 0x2111, PCI_ANY_ID, PCI_ANY_ID, 0, 0, avlab_1s1p_650},
@@ -167,6 +187,12 @@
 	return pci_siig20x_fn(dev, enable);
 }
 
+static int __devinit netmos_serial_init(struct pci_dev *dev, struct pci_board_no_ids *board, int enable)
+{
+	board->num_ports = dev->subsystem_device & 0xf;
+	return 0;
+}
+
 static struct pci_board_no_ids pci_boards[] __devinitdata = {
 	/*
 	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
@@ -180,8 +206,7 @@
 
 /* titan_110l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 1, 921600 },
 /* titan_210l */	{ SPCI_FL_BASE1 | SPCI_FL_BASE_TABLE, 2, 921600 },
-/* netmos_9735 (n/t)*/	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-/* netmos_9835 */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
+/* netmos_9xx5_combo */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200, 0, 0, netmos_serial_init },
 /* avlab_1s1p (n/t) */	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_650 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
 /* avlab_1s1p_850 (nt)*/{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
@@ -204,6 +229,7 @@
 	struct pci_board_no_ids ser;
 	int num_par;
 	struct parport *port[PARPORT_MAX];
+	struct parport_pc_pci par;
 };
 
 static int __devinit get_pci_port (struct pci_dev *dev,
@@ -271,14 +297,15 @@
 static int __devinit serial_register (struct pci_dev *dev,
 				      const struct pci_device_id *id)
 {
-	struct pci_board_no_ids *board = &pci_boards[id->driver_data];
+	struct pci_board_no_ids *board;
 	struct parport_serial_private *priv = pci_get_drvdata (dev);
 	struct serial_struct serial_req;
 	int base_baud;
 	int k;
 	int success = 0;
 
-	priv->ser = *board;
+	priv->ser = pci_boards[id->driver_data];
+	board = &priv->ser;
 	if (board->init_fn && ((board->init_fn) (dev, board, 1) != 0))
 		return 1;
 
@@ -289,6 +316,15 @@
 
 	for (k = 0; k < board->num_ports; k++) {
 		int line;
+
+		if (priv->num_ser == ARRAY_SIZE (priv->line)) {
+			printk (KERN_WARNING
+				"parport_serial: %s: only %u serial lines "
+				"supported (%d reported)\n", pci_name (dev),
+				ARRAY_SIZE (priv->line), board->num_ports);
+			break;
+		}
+
 		serial_req.irq = dev->irq;
 		if (get_pci_port (dev, board, &serial_req, k))
 			break;
@@ -311,19 +347,31 @@
 static int __devinit parport_register (struct pci_dev *dev,
 				       const struct pci_device_id *id)
 {
+	struct parport_pc_pci *card;
 	struct parport_serial_private *priv = pci_get_drvdata (dev);
 	int i = id->driver_data, n;
 	int success = 0;
 
-	if (cards[i].preinit_hook &&
-	    cards[i].preinit_hook (dev, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
+	priv->par = cards[id->driver_data];
+	card = &priv->par;
+	if (card->preinit_hook &&
+	    card->preinit_hook (dev, card, PARPORT_IRQ_NONE, PARPORT_DMA_NONE))
 		return -ENODEV;
 
-	for (n = 0; n < cards[i].numports; n++) {
+	for (n = 0; n < card->numports; n++) {
 		struct parport *port;
-		int lo = cards[i].addr[n].lo;
-		int hi = cards[i].addr[n].hi;
+		int lo = card->addr[n].lo;
+		int hi = card->addr[n].hi;
 		unsigned long io_lo, io_hi;
+
+		if (priv->num_par == ARRAY_SIZE (priv->port)) {
+			printk (KERN_WARNING
+				"parport_serial: %s: only %u parallel ports "
+				"supported (%d reported)\n", pci_name (dev),
+				ARRAY_SIZE (priv->port), card->numports);
+			break;
+		}
+
 		io_lo = pci_resource_start (dev, lo);
 		io_hi = 0;
 		if ((hi >= 0) && (hi <= 6))
@@ -345,8 +393,8 @@
 		}
 	}
 
-	if (cards[i].postinit_hook)
-		cards[i].postinit_hook (dev, !success);
+	if (card->postinit_hook)
+		card->postinit_hook (dev, card, !success);
 
 	return success ? 0 : 1;
 }
diff -u -r 2.6.12-rc1-mm1/drivers/pci/pci.ids 2.6.12-rc1-mm1-netmos/drivers/pci/pci.ids
--- 2.6.12-rc1-mm1/drivers/pci/pci.ids	2005-03-21 14:46:00.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/drivers/pci/pci.ids	2005-03-22 13:21:27.000000000 -0700
@@ -9903,14 +9903,25 @@
 	6565  6565
 9710  NetMos Technology
 	7780  USB IRDA-port
-	9815  PCI 9815 Multi-I/O Controller
+	9705  PCI 9705 Parallel Port
+	9715  PCI 9715 Dual Parallel Port
+	9735  PCI 9735 Multi-I/O Controller
+		1000 0002  0P2S (2 serial)
+		1000 0012  1P2S (1 parallel + 2 serial)
+	9745  PCI 9745 Multi-I/O Controller
+		1000 0002  0P2S (2 serial)
+		1000 0012  1P2S (1 parallel + 2 serial)
+	9755  PCI 9755 Parallel Port and ISA Bridge
+	9805  PCI 9805 Parallel Port
+	9815  PCI 9815 Dual Parallel Port
 		1000 0020  2P0S (2 port parallel adaptor)
 	9835  PCI 9835 Multi-I/O Controller
-		1000 0002  2S (16C550 UART)
+		1000 0002  0P2S (16C550 UART)
 		1000 0012  1P2S
 	9845  PCI 9845 Multi-I/O Controller
 		1000 0004  0P4S (4 port 16550A serial card)
-		1000 0006  0P6S (6 port 16550a serial card)
+		1000 0006  0P6S (6 port 16550A serial card)
+		1000 0014  1P4S (4 port 16550A serial card + parallel)
 	9855  PCI 9855 Multi-I/O Controller
 		1000 0014  1P4S
 9902  Stargen Inc.
diff -u -r 2.6.12-rc1-mm1/drivers/pci/quirks.c 2.6.12-rc1-mm1-netmos/drivers/pci/quirks.c
--- 2.6.12-rc1-mm1/drivers/pci/quirks.c	2005-03-21 14:46:01.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/drivers/pci/quirks.c	2005-03-22 13:19:35.000000000 -0700
@@ -1259,6 +1259,40 @@
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7320_MCH,	quirk_pcie_mch );
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_E7525_MCH,	quirk_pcie_mch );
 
+static void __devinit quirk_netmos(struct pci_dev *dev)
+{
+	unsigned int num_parallel = (dev->subsystem_device & 0xf0) >> 4;
+	unsigned int num_serial = dev->subsystem_device & 0xf;
+
+	/*
+	 * These Netmos parts are multiport serial devices with optional
+	 * parallel ports.  Even when parallel ports are present, they
+	 * are identified as class SERIAL, which means the serial driver
+	 * will claim them.  To prevent this, mark them as class OTHER.
+	 * These combo devices should be claimed by parport_serial.
+	 *
+	 * The subdevice ID is of the form 0x00PS, where <P> is the number
+	 * of parallel ports and <S> is the number of serial ports.
+	 */
+	switch (dev->device) {
+	case PCI_DEVICE_ID_NETMOS_9735:
+	case PCI_DEVICE_ID_NETMOS_9745:
+	case PCI_DEVICE_ID_NETMOS_9835:
+	case PCI_DEVICE_ID_NETMOS_9845:
+	case PCI_DEVICE_ID_NETMOS_9855:
+		if ((dev->class >> 8) == PCI_CLASS_COMMUNICATION_SERIAL &&
+		    num_parallel) {
+			printk(KERN_INFO "PCI: Netmos %04x (%u parallel, "
+				"%u serial); changing class SERIAL to OTHER "
+				"(use parport_serial)\n",
+				dev->device, num_parallel, num_serial);
+			dev->class = (PCI_CLASS_COMMUNICATION_OTHER << 8) |
+			    (dev->class & 0xff);
+		}
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NETMOS, PCI_ANY_ID, quirk_netmos);
+
 static void pci_do_fixups(struct pci_dev *dev, struct pci_fixup *f, struct pci_fixup *end)
 {
 	while (f < end) {
diff -u -r 2.6.12-rc1-mm1/drivers/serial/8250_pci.c 2.6.12-rc1-mm1-netmos/drivers/serial/8250_pci.c
--- 2.6.12-rc1-mm1/drivers/serial/8250_pci.c	2005-03-21 14:46:02.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/drivers/serial/8250_pci.c	2005-03-22 13:27:24.000000000 -0700
@@ -577,6 +577,16 @@
 	return 0;
 }
 
+static int __devinit pci_netmos_init(struct pci_dev *dev)
+{
+	/* subdevice 0x00PS means <P> parallel, <S> serial */
+	unsigned int num_serial = dev->subsystem_device & 0xf;
+
+	if (num_serial == 0)
+		return -ENODEV;
+	return num_serial;
+}
+
 static int
 pci_default_setup(struct pci_dev *dev, struct pci_board *board,
 		  struct uart_port *port, int idx)
@@ -934,6 +944,17 @@
 		.setup		= pci_default_setup,
 	},
 	/*
+	 * Netmos cards
+	 */
+	{
+		.vendor		= PCI_VENDOR_ID_NETMOS,
+		.device		= PCI_ANY_ID,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.init		= pci_netmos_init,
+		.setup		= pci_default_setup,
+	},
+	/*
 	 * Default "match everything" terminator entry
 	 */
 	{
diff -u -r 2.6.12-rc1-mm1/include/linux/pci_ids.h 2.6.12-rc1-mm1-netmos/include/linux/pci_ids.h
--- 2.6.12-rc1-mm1/include/linux/pci_ids.h	2005-03-21 14:46:03.000000000 -0700
+++ 2.6.12-rc1-mm1-netmos/include/linux/pci_ids.h	2005-03-21 14:52:40.000000000 -0700
@@ -2533,13 +2533,15 @@
 
 #define PCI_VENDOR_ID_NETMOS		0x9710
 #define PCI_DEVICE_ID_NETMOS_9705	0x9705
+#define PCI_DEVICE_ID_NETMOS_9715	0x9715
 #define PCI_DEVICE_ID_NETMOS_9735	0x9735
+#define PCI_DEVICE_ID_NETMOS_9745	0x9745
+#define PCI_DEVICE_ID_NETMOS_9755	0x9755
 #define PCI_DEVICE_ID_NETMOS_9805	0x9805
 #define PCI_DEVICE_ID_NETMOS_9815	0x9815
 #define PCI_DEVICE_ID_NETMOS_9835	0x9835
+#define PCI_DEVICE_ID_NETMOS_9845	0x9845
 #define PCI_DEVICE_ID_NETMOS_9855	0x9855
-#define PCI_DEVICE_ID_NETMOS_9755	0x9755
-#define PCI_DEVICE_ID_NETMOS_9715	0x9715
 
 #define PCI_SUBVENDOR_ID_EXSYS		0xd84d
 #define PCI_SUBDEVICE_ID_EXSYS_4014	0x4014



