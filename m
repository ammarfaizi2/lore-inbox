Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135345AbRDZLva>; Thu, 26 Apr 2001 07:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135344AbRDZLvT>; Thu, 26 Apr 2001 07:51:19 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38552 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135339AbRDZLvM>;
	Thu, 26 Apr 2001 07:51:12 -0400
Message-ID: <3AE80BAC.494F096B@mandrakesoft.com>
Date: Thu, 26 Apr 2001 07:51:08 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: tytso@mit.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: Steven Walter <srwalter@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PATCH 2.4.4.7: serial PCI fixes and cleanup
Content-Type: multipart/mixed;
 boundary="------------88B6EDF5FFDA145B2FFCE1D2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------88B6EDF5FFDA145B2FFCE1D2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The attached patch, against 2.4.4-pre7, cleans up the huge pci_board
list in serial.c to remove PCI id information.  In the process, it (a)
demonstrates more complex new-style PCI probing, and (b) fixes a logical
disconnect bug which was causing bug reports.  The bug caused by me,
when I added hotplugging to the serial driver (merging serial_cb in
function, but not literally).  The bug causes any PCI board which is
listed in the serial.c PCI table, but was not
PCI_CLASS_COMMUNICATION_SERIAL or PCI_CLASS_COMMUNICATION_MODEM, to be
missed in the PCI probe.

Linus - do not apply just yet.  I would prefer this patch go into 2.4.5
not 2.4.4, so that we can have a bit more public testing first.
tytso - a quick eyeball would be awesome.  Ask away with any questions
you have.
Alan - please consider applying to your tree.
Steven - please test, this patch removes the need for your serial.c
patch.

Others - all testing is welcome.

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
--------------88B6EDF5FFDA145B2FFCE1D2
Content-Type: text/plain; charset=us-ascii;
 name="serial-2.4.4.7.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-2.4.4.7.patch"

Index: linux_2_4/include/linux/serialP.h
diff -u linux_2_4/include/linux/serialP.h:1.1.1.25 linux_2_4/include/linux/serialP.h:1.1.1.25.24.1
--- linux_2_4/include/linux/serialP.h:1.1.1.25	Fri Apr 13 16:11:34 2001
+++ linux_2_4/include/linux/serialP.h	Thu Apr 26 04:35:12 2001
@@ -142,10 +142,6 @@
  */
 struct pci_dev;
 struct pci_board {
-	unsigned short vendor;
-	unsigned short device;
-	unsigned short subvendor;
-	unsigned short subdevice;
 	int flags;
 	int num_ports;
 	int base_baud;
Index: linux_2_4/drivers/char/serial.c
diff -u linux_2_4/drivers/char/serial.c:1.1.1.45 linux_2_4/drivers/char/serial.c:1.1.1.45.20.2
--- linux_2_4/drivers/char/serial.c:1.1.1.45	Fri Apr 13 18:31:51 2001
+++ linux_2_4/drivers/char/serial.c	Thu Apr 26 04:42:47 2001
@@ -59,8 +59,8 @@
  *
  */
 
-static char *serial_version = "5.05a";
-static char *serial_revdate = "2001-03-20";
+static char *serial_version = "5.05b";
+static char *serial_revdate = "2001-04-26";
 
 /*
  * Serial driver configuration section.  Here are the various options:
@@ -3912,14 +3912,14 @@
 
        if (PREPARE_FUNC(dev) && (PREPARE_FUNC(dev))(dev) < 0) {
 	       printk("serial: PNP device '");
-	       printk_pnp_dev_id(board->vendor, board->device);
+	       printk_pnp_dev_id(dev->vendor, dev->device);
 	       printk("' prepare failed\n");
 	       return;
        }
 
        if (ACTIVATE_FUNC(dev) && (ACTIVATE_FUNC(dev))(dev) < 0) {
 	       printk("serial: PNP device '");
-	       printk_pnp_dev_id(board->vendor, board->device);
+	       printk_pnp_dev_id(dev->vendor, dev->device);
 	       printk("' activate failed\n");
 	       return;
        }
@@ -4107,7 +4107,7 @@
 {
 	unsigned long oldval;
 	
-	if (!(board->subdevice & 0x1000))
+	if (!(pci_get_subvendor(dev) & 0x1000))
 		return(-1);
 
 	if (!enable) /* is there something to deinit? */
@@ -4185,527 +4185,640 @@
 
 /*
  * This is the configuration table for all of the PCI serial boards
- * which we support.
- */
+ * which we support.  It is directly indexed by the pci_board_num_t enum
+ * value, which is encoded in the pci_device_id PCI probe table's
+ * driver_data member.
+ */
+enum pci_board_num_t {
+	pbn_b0_1_115200,
+	pbn_default = 0,
+
+	pbn_b0_2_115200,
+	pbn_b0_4_115200,
+
+	pbn_b0_1_921600,
+	pbn_b0_2_921600,
+	pbn_b0_4_921600,
+
+	pbn_b0_bt_1_115200,
+	pbn_b0_bt_2_115200,
+	pbn_b0_bt_1_460800,
+	pbn_b0_bt_2_460800,
+
+	pbn_b1_1_115200,
+	pbn_b1_2_115200,
+	pbn_b1_4_115200,
+	pbn_b1_8_115200,
+
+	pbn_b1_2_921600,
+	pbn_b1_4_921600,
+	pbn_b1_8_921600,
+
+	pbn_b1_2_1382400,
+	pbn_b1_4_1382400,
+	pbn_b1_8_1382400,
+
+	pbn_b2_8_115200,
+	pbn_b2_4_460800,
+	pbn_b2_8_460800,
+	pbn_b2_16_460800,
+	pbn_b2_4_921600,
+	pbn_b2_8_921600,
+
+	pbn_b2_bt_1_115200,
+	pbn_b2_bt_2_115200,
+	pbn_b2_bt_4_115200,
+	pbn_b2_bt_2_921600,
+
+	pbn_panacom,
+	pbn_panacom2,
+	pbn_panacom4,
+	pbn_plx_romulus,
+	pbn_oxsemi,
+	pbn_timedia,
+	pbn_intel_i960,
+	pbn_sgi_ioc3,
+#ifdef CONFIG_DDB5074
+	pbn_nec_nile4,
+#endif
+#if 0
+	pbn_dci_pccom8,
+#endif
+
+	pbn_siig10x_0,
+	pbn_siig10x_1,
+	pbn_siig10x_2,
+	pbn_siig10x_4,
+	pbn_siig20x_0,
+	pbn_siig20x_2,
+	pbn_siig20x_4,
+	
+	pbn_computone_4,
+	pbn_computone_6,
+	pbn_computone_8,
+};
+
 static struct pci_board pci_boards[] __devinitdata = {
 	/*
-	 * Vendor ID, 	Device ID,
-	 * Subvendor ID,	Subdevice ID,
 	 * PCI Flags, Number of Ports, Base (Maximum) Baud Rate,
 	 * Offset to get to next UART's registers,
 	 * Register shift to use for memory-mapped I/O,
 	 * Initialization function, first UART offset
 	 */
+
+	/* Generic serial board, pbn_b0_1_115200, pbn_default */
+	{ SPCI_FL_BASE0, 1, 115200 },		/* pbn_b0_1_115200,
+						   pbn_default */
+
+	{ SPCI_FL_BASE0, 2, 115200 },		/* pbn_b0_2_115200 */
+	{ SPCI_FL_BASE0, 4, 115200 },		/* pbn_b0_4_115200 */
+
+	{ SPCI_FL_BASE0, 1, 921600 },		/* pbn_b0_1_921600 */
+	{ SPCI_FL_BASE0, 2, 921600 },		/* pbn_b0_2_921600 */
+	{ SPCI_FL_BASE0, 4, 921600 },		/* pbn_b0_4_921600 */
+
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 }, /* pbn_b0_bt_1_115200 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b0_bt_2_115200 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 }, /* pbn_b0_bt_1_460800 */
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 }, /* pbn_b0_bt_2_460800 */
+
+	{ SPCI_FL_BASE1, 1, 115200 },		/* pbn_b1_1_115200 */
+	{ SPCI_FL_BASE1, 2, 115200 },		/* pbn_b1_2_115200 */
+	{ SPCI_FL_BASE1, 4, 115200 },		/* pbn_b1_4_115200 */
+	{ SPCI_FL_BASE1, 8, 115200 },		/* pbn_b1_8_115200 */
+
+	{ SPCI_FL_BASE1, 2, 921600 },		/* pbn_b1_2_921600 */
+	{ SPCI_FL_BASE1, 4, 921600 },		/* pbn_b1_4_921600 */
+	{ SPCI_FL_BASE1, 8, 921600 },		/* pbn_b1_8_921600 */
+
+	{ SPCI_FL_BASE1, 2, 1382400 },		/* pbn_b1_2_1382400 */
+	{ SPCI_FL_BASE1, 4, 1382400 },		/* pbn_b1_4_1382400 */
+	{ SPCI_FL_BASE1, 8, 1382400 },		/* pbn_b1_8_1382400 */
+
+	{ SPCI_FL_BASE2, 8, 115200 },		/* pbn_b2_8_115200 */
+	{ SPCI_FL_BASE2, 4, 460800 },		/* pbn_b2_4_460800 */
+	{ SPCI_FL_BASE2, 8, 460800 },		/* pbn_b2_8_460800 */
+	{ SPCI_FL_BASE2, 16, 460800 },		/* pbn_b2_16_460800 */
+	{ SPCI_FL_BASE2, 4, 921600 },		/* pbn_b2_4_921600 */
+	{ SPCI_FL_BASE2, 8, 921600 },		/* pbn_b2_8_921600 */
+
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 1, 115200 }, /* pbn_b2_bt_1_115200 */
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 115200 }, /* pbn_b2_bt_2_115200 */
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 }, /* pbn_b2_bt_4_115200 */
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 }, /* pbn_b2_bt_2_921600 */
+
+	{ SPCI_FL_BASE2, 2, 921600, /* IOMEM */		   /* pbn_panacom */
+		0x400, 7, pci_plx9050_fn },
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_panacom2 */
+		0x400, 7, pci_plx9050_fn },
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_panacom4 */
+		0x400, 7, pci_plx9050_fn },
+	{ SPCI_FL_BASE2, 4, 921600,			   /* pbn_plx_romulus */
+		0x20, 2, pci_plx9050_fn, 0x03 },
+		/* This board uses the size of PCI Base region 0 to
+		 * signal now many ports are available */
+	{ SPCI_FL_BASE0 | SPCI_FL_REGION_SZ_CAP, 32, 115200 }, /* pbn_oxsemi */
+	{ SPCI_FL_BASE_TABLE, 1, 921600,		   /* pbn_timedia */
+		0, 0, pci_timedia_fn },
+	/* EKF addition for i960 Boards form EKF with serial port */
+	{ SPCI_FL_BASE0, 32, 921600, /* max 256 ports */   /* pbn_intel_i960 */
+		8<<2, 2, pci_inteli960ni_fn, 0x10000},
+	{ SPCI_FL_BASE0 | SPCI_FL_IRQRESOURCE,		   /* pbn_sgi_ioc3 */
+		1, 458333, 0, 0, 0, 0x20178 },
+#ifdef CONFIG_DDB5074
+	/*
+	 * NEC Vrc-5074 (Nile 4) builtin UART.
+	 * Conditionally compiled in since this is a motherboard device.
+	 */
+	{ SPCI_FL_BASE0, 1, 520833,			   /* pbn_nec_nile4 */
+		64, 3, NULL, 0x300 },
+#endif
+#if 0	/* PCI_DEVICE_ID_DCI_PCCOM8 ? */		   /* pbn_dci_pccom8 */
+	{ SPCI_FL_BASE3, 8, 115200, 8 },
+#endif
+
+	{ SPCI_FL_BASE2, 1, 460800,			   /* pbn_siig10x_0 */
+		0, 0, pci_siig10x_fn },
+	{ SPCI_FL_BASE2, 1, 921600,			   /* pbn_siig10x_1 */
+		0, 0, pci_siig10x_fn },
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_siig10x_2 */
+		0, 0, pci_siig10x_fn },
+	{ SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_siig10x_4 */
+		0, 0, pci_siig10x_fn },
+	{ SPCI_FL_BASE0, 1, 921600,			   /* pbn_siix20x_0 */
+		0, 0, pci_siig20x_fn },
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,   /* pbn_siix20x_2 */
+		0, 0, pci_siig20x_fn },
+	{ SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 921600,   /* pbn_siix20x_4 */
+		0, 0, pci_siig20x_fn },
+
+	{ SPCI_FL_BASE0, 4, 921600, /* IOMEM */		   /* pbn_computone_4 */
+		0x40, 2, NULL, 0x200 },
+	{ SPCI_FL_BASE0, 6, 921600, /* IOMEM */		   /* pbn_computone_6 */
+		0x40, 2, NULL, 0x200 },
+	{ SPCI_FL_BASE0, 8, 921600, /* IOMEM */		   /* pbn_computone_8 */
+		0x40, 2, NULL, 0x200 },
+};
+
+/*
+ * Given a complete unknown PCI device, try to use some heuristics to
+ * guess what the configuration might be, based on the pitiful PCI
+ * serial specs.  Returns 0 on success, 1 on failure.
+ */
+static int __devinit serial_pci_guess_board(struct pci_dev *dev,
+					   struct pci_board *board)
+{
+	int	num_iomem = 0, num_port = 0, first_port = -1;
+	int	i;
+	
+	/*
+	 * If it is not a communications device or the programming
+	 * interface is greater than 6, give up.
+	 *
+	 * (Should we try to make guesses for multiport serial devices
+	 * later?) 
+	 */
+	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
+	    ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
+	    (dev->class & 0xff) > 6)
+		return 1;
+
+	for (i=0; i < 6; i++) {
+		if (IS_PCI_REGION_IOPORT(dev, i)) {
+			num_port++;
+			if (first_port == -1)
+				first_port = i;
+		}
+		if (IS_PCI_REGION_IOMEM(dev, i))
+			num_iomem++;
+	}
+
+	/*
+	 * If there is 1 or 0 iomem regions, and exactly one port, use
+	 * it.
+	 */
+	if (num_iomem <= 1 && num_port == 1) {
+		board->flags = first_port;
+		return 0;
+	}
+	return 1;
+}
+
+static int __devinit serial_init_one(struct pci_dev *dev,
+				     const struct pci_device_id *ent)
+{
+	struct pci_board *board, tmp;
+	int rc;
+
+	board = &pci_boards[ent->driver_data];
+
+	rc = pci_enable_device(dev);
+	if (rc) return rc;
+
+	if (ent->driver_data == pbn_default &&
+	    serial_pci_guess_board(dev, board))
+		return -ENODEV;
+	else if (serial_pci_guess_board(dev, &tmp) == 0) {
+		printk(KERN_INFO "Redundant entry in serial pci_table.  "
+		       "Please send the output of\n"
+		       "lspci -vv, this message (%d,%d,%d,%d)\n"
+		       "and the manufacturer and name of "
+		       "serial board or modem board\n"
+		       "to serial-pci-info@lists.sourceforge.net.\n",
+		       dev->vendor, dev->device,
+		       pci_get_subvendor(dev), pci_get_subdevice(dev));
+	}
+		       
+	start_pci_pnp_board(dev, board);
+
+	return 0;
+}
+
+static void __devexit serial_remove_one(struct pci_dev *dev)
+{
+	int	i;
+
+	/*
+	 * Iterate through all of the ports finding those that belong
+	 * to this PCI device.
+	 */
+	for(i = 0; i < NR_PORTS; i++) {
+		if (rs_table[i].dev != dev)
+			continue;
+		unregister_serial(i);
+		rs_table[i].dev = 0;
+	}
+	/*
+	 * Now execute any board-specific shutdown procedure
+	 */
+	for (i=0; i < NR_PCI_BOARDS; i++) {
+		struct pci_board_inst *brd = &serial_pci_board[i];
+
+		if (serial_pci_board[i].dev != dev)
+			continue;
+		if (brd->board.init_fn)
+			(brd->board.init_fn)(brd->dev, &brd->board, 0);
+		if (DEACTIVATE_FUNC(brd->dev))
+			(DEACTIVATE_FUNC(brd->dev))(brd->dev);
+		serial_pci_board[i].dev = 0;
+	}
+}
+
+
+static struct pci_device_id serial_pci_tbl[] __devinitdata = {
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232,
-		SPCI_FL_BASE1, 8, 1382400 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
+		pbn_b1_8_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232,
-		SPCI_FL_BASE1, 4, 1382400 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232, 0, 0,
+		pbn_b1_4_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232,
-		SPCI_FL_BASE1, 2, 1382400 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232, 0, 0,
+		pbn_b1_2_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232,
-		SPCI_FL_BASE1, 8, 1382400 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
+		pbn_b1_8_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232,
-		SPCI_FL_BASE1, 4, 1382400 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_232, 0, 0,
+		pbn_b1_4_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232,
-		SPCI_FL_BASE1, 2, 1382400 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_232, 0, 0,
+		pbn_b1_2_1382400 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485,
-		SPCI_FL_BASE1, 8, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485, 0, 0,
+		pbn_b1_8_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4,
-		SPCI_FL_BASE1, 8, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_4_4, 0, 0,
+		pbn_b1_8_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485,
-		SPCI_FL_BASE1, 4, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485, 0, 0,
+		pbn_b1_4_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2,
-		SPCI_FL_BASE1, 4, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH4_485_2_2, 0, 0,
+		pbn_b1_4_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485,
-		SPCI_FL_BASE1, 2, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH2_485, 0, 0,
+		pbn_b1_2_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6,
-		SPCI_FL_BASE1, 8, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_485_2_6, 0, 0,
+		pbn_b1_8_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1,
-		SPCI_FL_BASE1, 8, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH081101V1, 0, 0,
+		pbn_b1_8_921600 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V351,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
-		PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1,
-		SPCI_FL_BASE1, 4, 921600 },
+		PCI_SUBDEVICE_ID_CONNECT_TECH_BH041101V1, 0, 0,
+		pbn_b1_4_921600 },
+
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_U530,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 1, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_bt_1_115200 },
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_bt_2_115200 },
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM422,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_bt_4_115200 },
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_UCOMM232,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_bt_2_115200 },
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM4,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_bt_4_115200 },
 	{	PCI_VENDOR_ID_SEALEVEL, PCI_DEVICE_ID_SEALEVEL_COMM8,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 8, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_8_115200 },
+
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_GTEK_SERIAL2,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_bt_2_115200 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM200,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_bt_2_921600 },
 	/* VScom SPCOM800, from sl@s.pl */
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_SPCOM800, 
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 8, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_8_921600 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_1077,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 4, 921600 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b2_4_921600 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_KEYSPAN,
-		PCI_SUBDEVICE_ID_KEYSPAN_SX2,
-		SPCI_FL_BASE2, 2, 921600, /* IOMEM */
-		0x400, 7, pci_plx9050_fn },
+		PCI_SUBDEVICE_ID_KEYSPAN_SX2, 0, 0,
+		pbn_panacom },
 	{	PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_QUADMODEM,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,
-		0x400, 7, pci_plx9050_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_panacom4 },
 	{	PCI_VENDOR_ID_PANACOM, PCI_DEVICE_ID_PANACOM_DUALMODEM,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0x400, 7, pci_plx9050_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_panacom2 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST4,
-		SPCI_FL_BASE2, 4, 460800 },
+		PCI_SUBDEVICE_ID_CHASE_PCIFAST4, 0, 0, 
+		pbn_b2_4_460800 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST8,
-		SPCI_FL_BASE2, 8, 460800 },
+		PCI_SUBDEVICE_ID_CHASE_PCIFAST8, 0, 0, 
+		pbn_b2_8_460800 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST16,
-		SPCI_FL_BASE2, 16, 460800 },
+		PCI_SUBDEVICE_ID_CHASE_PCIFAST16, 0, 0, 
+		pbn_b2_16_460800 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_CHASE_PCIFAST,
-		PCI_SUBDEVICE_ID_CHASE_PCIFAST16FMC,
-		SPCI_FL_BASE2, 16, 460800 },
+		PCI_SUBDEVICE_ID_CHASE_PCIFAST16FMC, 0, 0, 
+		pbn_b2_16_460800 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_CHASE_PCIRAS,
-		PCI_SUBDEVICE_ID_CHASE_PCIRAS4,
-		SPCI_FL_BASE2, 4, 460800 },
+		PCI_SUBDEVICE_ID_CHASE_PCIRAS4, 0, 0, 
+		pbn_b2_4_460800 },
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
 		PCI_SUBVENDOR_ID_CHASE_PCIRAS,
-		PCI_SUBDEVICE_ID_CHASE_PCIRAS8,
-		SPCI_FL_BASE2, 8, 460800 },
+		PCI_SUBDEVICE_ID_CHASE_PCIRAS8, 0, 0, 
+		pbn_b2_8_460800 },
 	/* Megawolf Romulus PCI Serial Card, from Mike Hudson */
 	/* (Exoray@isys.ca) */
 	{	PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_ROMULUS,
-		0x10b5, 0x106a,
-		SPCI_FL_BASE2, 4, 921600,
-		0x20, 2, pci_plx9050_fn, 0x03 },
+		0x10b5, 0x106a, 0, 0,
+		pbn_plx_romulus },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_QSC100,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 4, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b1_4_115200 },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_DSC100,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 2, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b1_2_115200 },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100D,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 8, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b1_8_115200 },
 	{	PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_ESC100M,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 8, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b1_8_115200 },
 	{	PCI_VENDOR_ID_SPECIALIX, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_VENDOR_ID_SPECIALIX, PCI_SUBDEVICE_ID_SPECIALIX_SPEED4,
-		SPCI_FL_BASE0 , 4, 921600 },
+		PCI_VENDOR_ID_SPECIALIX, PCI_SUBDEVICE_ID_SPECIALIX_SPEED4, 0, 0, 
+		pbn_b0_4_921600 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 , 4, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b0_4_115200 },
 	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI952,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 , 2, 115200 },
-		/* This board uses the size of PCI Base region 0 to
-		 * signal now many ports are available */
-	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_REGION_SZ_CAP, 32, 115200 },
-	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
-		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID,
-		SPCI_FL_BASE_TABLE, 1, 921600,
-		0, 0, pci_timedia_fn },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_A,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_A,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_B,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 460800 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_SSERIAL,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 115200 },
-	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 1, 460800 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b0_2_115200 },
+
+	/* Digitan DS560-558, from jimd@esoft.com */
+	{	PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b1_1_115200 },
+
+	/* 3Com US Robotics 56k Voice Internal PCI model 5610 */
+	{	PCI_VENDOR_ID_USR, 0x1008,
+		PCI_ANY_ID, PCI_ANY_ID, },
+
+	/* Titan Electronic cards */
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b0_1_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b0_2_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b0_4_921600 },
+	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 
+		pbn_b0_4_921600 },
+
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 1, 460800,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 1, 460800,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 1, 460800,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 1, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_1 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 1, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_1 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2, 1, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_1 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_4 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_4 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_10x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 4, 921600,
-		0, 0, pci_siig10x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig10x_4 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_1S1P_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2P1S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_0 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_2S1P_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 2, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_2 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_550,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_4 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_650,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_4 },
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0 | SPCI_FL_BASE_TABLE, 4, 921600,
-		0, 0, pci_siig20x_fn },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_siig20x_4 },
+
 	/* Computone devices submitted by Doug McNash dmcnash@computone.com */
 	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
 		PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG4,
-		SPCI_FL_BASE0, 4, 921600, /* IOMEM */
-		0x40, 2, NULL, 0x200 },
+		0, 0, pbn_computone_4 },
 	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
 		PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG8,
-		SPCI_FL_BASE0, 8, 921600, /* IOMEM */
-		0x40, 2, NULL, 0x200 },
+		0, 0, pbn_computone_8 },
 	{	PCI_VENDOR_ID_COMPUTONE, PCI_DEVICE_ID_COMPUTONE_PG,
 		PCI_SUBVENDOR_ID_COMPUTONE, PCI_SUBDEVICE_ID_COMPUTONE_PG6,
-		SPCI_FL_BASE0, 6, 921600, /* IOMEM */
-		0x40, 2, NULL, 0x200 },
-	/* Digitan DS560-558, from jimd@esoft.com */
-	{	PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE1, 1, 115200 },
-	/* 3Com US Robotics 56k Voice Internal PCI model 5610 */
-	{	PCI_VENDOR_ID_USR, 0x1008,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 115200 },
-	/* Titan Electronic cards */
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_100,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_200,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 2, 921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_400,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 4, 921600 },
-	{	PCI_VENDOR_ID_TITAN, PCI_DEVICE_ID_TITAN_800B,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 4, 921600 },
-	/* EKF addition for i960 Boards form EKF with serial port */
-	{	PCI_VENDOR_ID_INTEL, 0x1960,
-		0xE4BF, PCI_ANY_ID,
-		SPCI_FL_BASE0, 32, 921600, /* max 256 ports */
-		8<<2, 2, pci_inteli960ni_fn, 0x10000},
+		0, 0, pbn_computone_6 },
+
+	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI95N,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, pbn_oxsemi },
+	{	PCI_VENDOR_ID_TIMEDIA, PCI_DEVICE_ID_TIMEDIA_1889,
+		PCI_VENDOR_ID_TIMEDIA, PCI_ANY_ID, 0, 0, pbn_timedia },
+
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_DSERIAL,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_115200 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_115200 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUATRO_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_115200 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_PLUS,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_A,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_QUAD_B,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_2_460800 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_SSERIAL,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_1_115200 },
+	{	PCI_VENDOR_ID_LAVA, PCI_DEVICE_ID_LAVA_PORT_650,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_1_460800 },
+
 	/* RAStel 2 port modem, gerg@moreton.com.au */
 	{	PCI_VENDOR_ID_MORETON, PCI_DEVICE_ID_RASTEL_2PORT,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE2 | SPCI_FL_BASE_TABLE, 2, 115200 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b2_bt_2_115200 },
+
+	/* EKF addition for i960 Boards form EKF with serial port */
+	{	PCI_VENDOR_ID_INTEL, 0x1960,
+		0xE4BF, PCI_ANY_ID, 0, 0,
+		pbn_intel_i960 },
+
 	/*
 	 * Untested PCI modems, sent in from various folks...
 	 */
+
 	/* Elsa Model 56K PCI Modem, from Andreas Rath <arh@01019freenet.de> */
 	{	PCI_VENDOR_ID_ROCKWELL, 0x1004,
-		0x1048, 0x1500, 
-		SPCI_FL_BASE1, 1, 115200 },
+		0x1048, 0x1500, 0, 0,
+		pbn_b1_1_115200 },
+
 	{	PCI_VENDOR_ID_SGI, PCI_DEVICE_ID_SGI_IOC3,
-		0xFF00, 0, SPCI_FL_BASE0 | SPCI_FL_IRQRESOURCE,
-		1, 458333, 0, 0, 0, 0x20178 },
-#if CONFIG_DDB5074
+		0xFF00, 0, 0, 0,
+		pbn_sgi_ioc3 },
+
+#ifdef CONFIG_DDB5074
 	/*
 	 * NEC Vrc-5074 (Nile 4) builtin UART.
 	 * Conditionally compiled in since this is a motherboard device.
 	 */
 	{	PCI_VENDOR_ID_NEC, PCI_DEVICE_ID_NEC_NILE4,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE0, 1, 520833,
-		64, 3, NULL, 0x300 },
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_nec_nile4 },
 #endif
+
 #if 0	/* PCI_DEVICE_ID_DCI_PCCOM8 ? */
 	{	PCI_VENDOR_ID_DCI, PCI_DEVICE_ID_DCI_PCCOM8,
-		PCI_ANY_ID, PCI_ANY_ID,
-		SPCI_FL_BASE3, 8, 115200,
-		8 },
-#endif
-	/* Generic serial board */
-	{	0, 0,
-		0, 0,
-		SPCI_FL_BASE0, 1, 115200 },
-};
-
-/*
- * Given a complete unknown PCI device, try to use some heuristics to
- * guess what the configuration might be, based on the pitiful PCI
- * serial specs.  Returns 0 on success, 1 on failure.
- */
-static int _INLINE_ serial_pci_guess_board(struct pci_dev *dev,
-					   struct pci_board *board)
-{
-	int	num_iomem = 0, num_port = 0, first_port = -1;
-	int	i;
-	
-	/*
-	 * If it is not a communications device or the programming
-	 * interface is greater than 6, give up.
-	 *
-	 * (Should we try to make guesses for multiport serial devices
-	 * later?) 
-	 */
-	if ((((dev->class >> 8) != PCI_CLASS_COMMUNICATION_SERIAL) &&
-	    ((dev->class >> 8) != PCI_CLASS_COMMUNICATION_MODEM)) ||
-	    (dev->class & 0xff) > 6)
-		return 1;
-
-	for (i=0; i < 6; i++) {
-		if (IS_PCI_REGION_IOPORT(dev, i)) {
-			num_port++;
-			if (first_port == -1)
-				first_port = i;
-		}
-		if (IS_PCI_REGION_IOMEM(dev, i))
-			num_iomem++;
-	}
-
-	/*
-	 * If there is 1 or 0 iomem regions, and exactly one port, use
-	 * it.
-	 */
-	if (num_iomem <= 1 && num_port == 1) {
-		board->flags = first_port;
-		return 0;
-	}
-	return 1;
-}
-
-static int __devinit serial_init_one(struct pci_dev *dev,
-				     const struct pci_device_id *ent)
-{
-	struct pci_board *board, tmp;
-	int rc;
-
-	for (board = pci_boards; board->vendor; board++) {
-		if (board->vendor != (unsigned short) PCI_ANY_ID &&
-		    dev->vendor != board->vendor)
-			continue;
-		if (board->device != (unsigned short) PCI_ANY_ID &&
-		    dev->device != board->device)
-			continue;
-		if (board->subvendor != (unsigned short) PCI_ANY_ID &&
-		    pci_get_subvendor(dev) != board->subvendor)
-			continue;
-		if (board->subdevice != (unsigned short) PCI_ANY_ID &&
-		    pci_get_subdevice(dev) != board->subdevice)
-			continue;
-		break;
-	}
-
-	rc = pci_enable_device(dev);
-	if (rc) return rc;
-
-	if (board->vendor == 0 && serial_pci_guess_board(dev, board))
-		return -ENODEV;
-	else if (serial_pci_guess_board(dev, &tmp) == 0) {
-		printk(KERN_INFO "Redundant entry in serial pci_table.  "
-		       "Please send the output of\n"
-		       "lspci -vv, this message (%d,%d,%d,%d)\n"
-		       "and the manufacturer and name of "
-		       "serial board or modem board\n"
-		       "to serial-pci-info@lists.sourceforge.net.\n",
-		       dev->vendor, dev->device,
-		       pci_get_subvendor(dev), pci_get_subdevice(dev));
-	}
-		       
-	start_pci_pnp_board(dev, board);
-
-	return 0;
-}
-
-static void __devexit serial_remove_one(struct pci_dev *dev)
-{
-	int	i;
-
-	/*
-	 * Iterate through all of the ports finding those that belong
-	 * to this PCI device.
-	 */
-	for(i = 0; i < NR_PORTS; i++) {
-		if (rs_table[i].dev != dev)
-			continue;
-		unregister_serial(i);
-		rs_table[i].dev = 0;
-	}
-	/*
-	 * Now execute any board-specific shutdown procedure
-	 */
-	for (i=0; i < NR_PCI_BOARDS; i++) {
-		struct pci_board_inst *brd = &serial_pci_board[i];
-
-		if (serial_pci_board[i].dev != dev)
-			continue;
-		if (brd->board.init_fn)
-			(brd->board.init_fn)(brd->dev, &brd->board, 0);
-		if (DEACTIVATE_FUNC(brd->dev))
-			(DEACTIVATE_FUNC(brd->dev))(brd->dev);
-		serial_pci_board[i].dev = 0;
-	}
-}
-
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_dci_pccom8 },
+#endif
 
-static struct pci_device_id serial_pci_tbl[] __devinitdata = {
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,

--------------88B6EDF5FFDA145B2FFCE1D2--

