Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932569AbWJIP67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932569AbWJIP67 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932819AbWJIP67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:58:59 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:40624 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932569AbWJIP66
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:58:58 -0400
Date: Mon, 9 Oct 2006 17:58:32 +0200
Message-id: <7865463434532543@muni.cz>
Subject: [PATCH 1/3] Char: mxser_new, compact structures, round2
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <support@moxa.com.tw>
X-Muni-Spam-TestIP: 147.251.51.201
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mxser_new, compact structures, round2

Too many structures are in the driver for each type of card. Make only one
for all cards and appropriate alter the code.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit e48623373bf13133bf9b76e54bc64f3ab5b46517
tree 11135fad25bf2eb551a1e9c9f6d164c8c5af3409
parent 3cbc3a3dd48ae68c4a936d161e5f256094fc2bef
author Jiri Slaby <jirislaby@gmail.com> Mon, 09 Oct 2006 14:54:19 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Mon, 09 Oct 2006 14:54:19 +0200

 drivers/char/mxser_new.c |  276 ++++++++++++++++++----------------------------
 1 files changed, 109 insertions(+), 167 deletions(-)

diff --git a/drivers/char/mxser_new.c b/drivers/char/mxser_new.c
index 7a47433..28c41a6 100644
--- a/drivers/char/mxser_new.c
+++ b/drivers/char/mxser_new.c
@@ -84,97 +84,11 @@ #define CI132_ASIC_ID	4
 #define CI134_ASIC_ID	3
 #define CI104J_ASIC_ID  5
 
-enum {
-	MXSER_BOARD_C168_ISA = 1,
-	MXSER_BOARD_C104_ISA,
-	MXSER_BOARD_CI104J,
-	MXSER_BOARD_C168_PCI,
-	MXSER_BOARD_C104_PCI,
-	MXSER_BOARD_C102_ISA,
-	MXSER_BOARD_CI132,
-	MXSER_BOARD_CI134,
-	MXSER_BOARD_CP132,
-	MXSER_BOARD_CP114,
-	MXSER_BOARD_CT114,
-	MXSER_BOARD_CP102,
-	MXSER_BOARD_CP104U,
-	MXSER_BOARD_CP168U,
-	MXSER_BOARD_CP132U,
-	MXSER_BOARD_CP134U,
-	MXSER_BOARD_CP104JU,
-	MXSER_BOARD_RC7000,
-	MXSER_BOARD_CP118U,
-	MXSER_BOARD_CP102UL,
-	MXSER_BOARD_CP102U,
-	MXSER_BOARD_CP118EL,
-	MXSER_BOARD_CP168EL,
-	MXSER_BOARD_CP104EL
-};
-
-static char *mxser_brdname[] = {
-	"C168 series",
-	"C104 series",
-	"CI-104J series",
-	"C168H/PCI series",
-	"C104H/PCI series",
-	"C102 series",
-	"CI-132 series",
-	"CI-134 series",
-	"CP-132 series",
-	"CP-114 series",
-	"CT-114 series",
-	"CP-102 series",
-	"CP-104U series",
-	"CP-168U series",
-	"CP-132U series",
-	"CP-134U series",
-	"CP-104JU series",
-	"Moxa UC7000 Serial",
-	"CP-118U series",
-	"CP-102UL series",
-	"CP-102U series",
-	"CP-118EL series",
-	"CP-168EL series",
-	"CP-104EL series"
-};
-
-static int mxser_numports[] = {
-	8,			/* C168-ISA */
-	4,			/* C104-ISA */
-	4,			/* CI104J */
-	8,			/* C168-PCI */
-	4,			/* C104-PCI */
-	2,			/* C102-ISA */
-	2,			/* CI132 */
-	4,			/* CI134 */
-	2,			/* CP132 */
-	4,			/* CP114 */
-	4,			/* CT114 */
-	2,			/* CP102 */
-	4,			/* CP104U */
-	8,			/* CP168U */
-	2,			/* CP132U */
-	4,			/* CP134U */
-	4,			/* CP104JU */
-	8,			/* RC7000 */
-	8,			/* CP118U */
-	2,			/* CP102UL */
-	2,			/* CP102U */
-	8,			/* CP118EL */
-	8,			/* CP168EL */
-	4			/* CP104EL */
-};
-
-#define UART_TYPE_NUM	2
-
-static const unsigned int Gmoxa_uart_id[UART_TYPE_NUM] = {
-	MOXA_MUST_MU150_HWID,
-	MOXA_MUST_MU860_HWID
-};
+#define MXSER_HIGHBAUD	1
+#define MXSER_HAS2	2
 
 /* This is only for PCI */
-#define UART_INFO_NUM	3
-struct mxpciuart_info {
+static const struct {
 	int type;
 	int tx_fifo;
 	int rx_fifo;
@@ -183,51 +97,85 @@ struct mxpciuart_info {
 	int rx_trigger;
 	int rx_low_water;
 	long max_baud;
-};
-
-static const struct mxpciuart_info Gpci_uart_info[UART_INFO_NUM] = {
+} Gpci_uart_info[] = {
 	{MOXA_OTHER_UART, 16, 16, 16, 14, 14, 1, 921600L},
 	{MOXA_MUST_MU150_HWID, 64, 64, 64, 48, 48, 16, 230400L},
 	{MOXA_MUST_MU860_HWID, 128, 128, 128, 96, 96, 32, 921600L}
 };
+#define UART_INFO_NUM	ARRAY_SIZE(Gpci_uart_info)
+
+struct mxser_cardinfo {
+	unsigned int nports;
+	char *name;
+	unsigned int flags;
+};
+
+static const struct mxser_cardinfo mxser_cards[] = {
+	{ 8, "C168 series", },			/* C168-ISA */
+	{ 4, "C104 series", },			/* C104-ISA */
+	{ 4, "CI-104J series", },		/* CI104J */
+	{ 8, "C168H/PCI series", },		/* C168-PCI */
+	{ 4, "C104H/PCI series", },		/* C104-PCI */
+	{ 4, "C102 series", MXSER_HAS2 },	/* C102-ISA */
+	{ 4, "CI-132 series", MXSER_HAS2 },	/* CI132 */
+	{ 4, "CI-134 series", },		/* CI134 */
+	{ 2, "CP-132 series", },		/* CP132 */
+	{ 4, "CP-114 series", },		/* CP114 */
+	{ 4, "CT-114 series", },		/* CT114 */
+	{ 2, "CP-102 series", MXSER_HIGHBAUD },	/* CP102 */
+	{ 4, "CP-104U series", },		/* CP104U */
+	{ 8, "CP-168U series", },		/* CP168U */
+	{ 2, "CP-132U series", },		/* CP132U */
+	{ 4, "CP-134U series", },		/* CP134U */
+	{ 4, "CP-104JU series", },		/* CP104JU */
+	{ 8, "Moxa UC7000 Serial", },		/* RC7000 */
+	{ 8, "CP-118U series", },		/* CP118U */
+	{ 2, "CP-102UL series", },		/* CP102UL */
+	{ 2, "CP-102U series", },		/* CP102U */
+	{ 8, "CP-118EL series", },		/* CP118EL */
+	{ 8, "CP-168EL series", },		/* CP168EL */
+	{ 4, "CP-104EL series", }		/* CP104EL */
+};
 
+/* driver_data correspond to the lines in the structure above
+   see also ISA probe function before you change something */
 static struct pci_device_id mxser_pcibrds[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C168),
-		.driver_data = MXSER_BOARD_C168_PCI },
+		.driver_data = 3 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_C104),
-		.driver_data = MXSER_BOARD_C104_PCI },
+		.driver_data = 4 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132),
-		.driver_data = MXSER_BOARD_CP132 },
+		.driver_data = 8 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP114),
-		.driver_data = MXSER_BOARD_CP114 },
+		.driver_data = 9 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CT114),
-		.driver_data = MXSER_BOARD_CT114 },
+		.driver_data = 10 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102),
-		.driver_data = MXSER_BOARD_CP102 },
+		.driver_data = 11 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104U),
-		.driver_data = MXSER_BOARD_CP104U },
+		.driver_data = 12 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168U),
-		.driver_data = MXSER_BOARD_CP168U },
+		.driver_data = 13 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP132U),
-		.driver_data = MXSER_BOARD_CP132U },
+		.driver_data = 14 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP134U),
-		.driver_data = MXSER_BOARD_CP134U },
+		.driver_data = 15 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104JU),
-		.driver_data = MXSER_BOARD_CP104JU },
+		.driver_data = 16 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_RC7000),
-		.driver_data = MXSER_BOARD_RC7000 },
+		.driver_data = 17 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118U),
-		.driver_data = MXSER_BOARD_CP118U },
+		.driver_data = 18 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102UL),
-		.driver_data = MXSER_BOARD_CP102UL },
+		.driver_data = 19 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP102U),
-		.driver_data = MXSER_BOARD_CP102U },
+		.driver_data = 20 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP118EL),
-		.driver_data = MXSER_BOARD_CP118EL },
+		.driver_data = 21 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP168EL),
-		.driver_data = MXSER_BOARD_CP168EL },
+		.driver_data = 22 },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MOXA, PCI_DEVICE_ID_MOXA_CP104EL),
-		.driver_data = MXSER_BOARD_CP104EL },
+		.driver_data = 23 },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, mxser_pcibrds);
@@ -338,8 +286,7 @@ struct mxser_board {
 	struct pci_dev *pdev; /* temporary (until pci probing) */
 
 	int irq;
-	int board_type;
-	unsigned int nports;
+	const struct mxser_cardinfo *info;
 	unsigned long vector;
 	unsigned long vector_mask;
 
@@ -392,8 +339,8 @@ static int CheckIsMoxaMust(int io)
 	}
 
 	GET_MOXA_MUST_HARDWARE_ID(io, &hwid);
-	for (i = 0; i < UART_TYPE_NUM; i++) {
-		if (hwid == Gmoxa_uart_id[i])
+	for (i = 1; i < UART_INFO_NUM; i++) { /* 0 = OTHER_UART */
+		if (hwid == Gpci_uart_info[i].type)
 			return (int)hwid;
 	}
 	return MOXA_OTHER_UART;
@@ -2447,7 +2394,7 @@ static irqreturn_t mxser_interrupt(int i
 		goto irq_stop;
 	if (brd == NULL)
 		goto irq_stop;
-	max = mxser_numports[brd->board_type - 1];
+	max = brd->info->nports;
 	while (1) {
 		irqbits = inb(brd->vector) & brd->vector_mask;
 		if (irqbits == brd->vector_mask)
@@ -2574,7 +2521,7 @@ static void mxser_release_res(struct mxs
 		pci_release_region(pdev, 3);
 		pci_dev_put(pdev);
 	} else {
-		release_region(brd->ports[0].ioaddr, 8 * brd->nports);
+		release_region(brd->ports[0].ioaddr, 8 * brd->info->nports);
 		release_region(brd->vector, 1);
 	}
 }
@@ -2587,7 +2534,7 @@ static int __devinit mxser_initbrd(struc
 
 	printk(KERN_INFO "max. baud rate = %d bps.\n", brd->ports[0].max_baud);
 
-	for (i = 0; i < brd->nports; i++) {
+	for (i = 0; i < brd->info->nports; i++) {
 		info = &brd->ports[i];
 		info->board = brd;
 		info->stop_rx = 0;
@@ -2628,7 +2575,7 @@ static int __devinit mxser_initbrd(struc
 	if (retval) {
 		printk(KERN_ERR "Board %s: Request irq failed, IRQ (%d) may "
 			"conflict with another device.\n",
-			mxser_brdname[brd->board_type - 1], brd->irq);
+			brd->info->name, brd->irq);
 		/* We hold resources, we need to release them. */
 		mxser_release_res(brd, 0);
 		return retval;
@@ -2645,40 +2592,44 @@ static int __init mxser_get_ISA_conf(int
 	brd->chip_flag = MOXA_OTHER_UART;
 
 	id = mxser_read_register(cap, regs);
-	if (id == C168_ASIC_ID) {
-		brd->board_type = MXSER_BOARD_C168_ISA;
-		brd->nports = 8;
-	} else if (id == C104_ASIC_ID) {
-		brd->board_type = MXSER_BOARD_C104_ISA;
-		brd->nports = 4;
-	} else if (id == C102_ASIC_ID) {
-		brd->board_type = MXSER_BOARD_C102_ISA;
-		brd->nports = 2;
-	} else if (id == CI132_ASIC_ID) {
-		brd->board_type = MXSER_BOARD_CI132;
-		brd->nports = 2;
-	} else if (id == CI134_ASIC_ID) {
-		brd->board_type = MXSER_BOARD_CI134;
-		brd->nports = 4;
-	} else if (id == CI104J_ASIC_ID) {
-		brd->board_type = MXSER_BOARD_CI104J;
-		brd->nports = 4;
-	} else
+	switch (id) {
+	case C168_ASIC_ID:
+		brd->info = &mxser_cards[0];
+		break;
+	case C104_ASIC_ID:
+		brd->info = &mxser_cards[1];
+		break;
+	case CI104J_ASIC_ID:
+		brd->info = &mxser_cards[2];
+		break;
+	case C102_ASIC_ID:
+		brd->info = &mxser_cards[5];
+		break;
+	case CI132_ASIC_ID:
+		brd->info = &mxser_cards[6];
+		break;
+	case CI134_ASIC_ID:
+		brd->info = &mxser_cards[7];
+		break;
+	default:
 		return 0;
+	}
 
 	irq = 0;
-	if (brd->nports == 2) {
+	/* some ISA cards have 2 ports, but we want to see them as 4-port (why?)
+	   Flag-hack checks if configuration should be read as 2-port here. */
+	if (brd->info->nports == 2 || (brd->info->flags & MXSER_HAS2)) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		if (irq != (regs[9] & 0xFF00))
 			return MXSER_ERR_IRQ_CONFLIT;
-	} else if (brd->nports == 4) {
+	} else if (brd->info->nports == 4) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		irq = irq | (irq >> 8);
 		if (irq != regs[9])
 			return MXSER_ERR_IRQ_CONFLIT;
-	} else if (brd->nports == 8) {
+	} else if (brd->info->nports == 8) {
 		irq = regs[9] & 0xF000;
 		irq = irq | (irq >> 4);
 		irq = irq | (irq >> 8);
@@ -2718,35 +2669,31 @@ static int __init mxser_get_ISA_conf(int
 		brd->uart_type = PORT_16550A;
 	else
 		brd->uart_type = PORT_16450;
-	if (id == 1)
-		brd->nports = 8;
-	else
-		brd->nports = 4;
-	if (!request_region(brd->ports[0].ioaddr, 8 * brd->nports, "mxser(IO)"))
+	if (!request_region(brd->ports[0].ioaddr, 8 * brd->info->nports,
+			"mxser(IO)"))
 		return MXSER_ERR_IOADDR;
 	if (!request_region(brd->vector, 1, "mxser(vector)")) {
-		release_region(brd->ports[0].ioaddr, 8 * brd->nports);
+		release_region(brd->ports[0].ioaddr, 8 * brd->info->nports);
 		return MXSER_ERR_VECTOR;
 	}
-	return brd->nports;
+	return brd->info->nports;
 }
 
-static int __init mxser_get_PCI_conf(int board_type, struct mxser_board *brd,
-		struct pci_dev *pdev)
+static int __init mxser_get_PCI_conf(const struct pci_device_id *ent,
+		struct mxser_board *brd, struct pci_dev *pdev)
 {
 	unsigned int i, j;
 	unsigned long ioaddress;
 	int retval;
 
 	/* io address */
-	brd->board_type = board_type;
-	brd->nports = mxser_numports[board_type - 1];
+	brd->info = &mxser_cards[ent->driver_data];
 	ioaddress = pci_resource_start(pdev, 2);
 	retval = pci_request_region(pdev, 2, "mxser(IO)");
 	if (retval)
 		goto err;
 
-	for (i = 0; i < brd->nports; i++)
+	for (i = 0; i < brd->info->nports; i++)
 		brd->ports[i].ioaddr = ioaddress + 8 * i;
 
 	/* vector */
@@ -2763,14 +2710,14 @@ static int __init mxser_get_PCI_conf(int
 	brd->uart_type = PORT_16550A;
 	brd->vector_mask = 0;
 
-	for (i = 0; i < brd->nports; i++) {
+	for (i = 0; i < brd->info->nports; i++) {
 		for (j = 0; j < UART_INFO_NUM; j++) {
 			if (Gpci_uart_info[j].type == brd->chip_flag) {
 				brd->ports[i].max_baud =
 					Gpci_uart_info[j].max_baud;
 
 				/* exception....CP-102 */
-				if (board_type == MXSER_BOARD_CP102)
+				if (brd->info->flags & MXSER_HIGHBAUD)
 					brd->ports[i].max_baud = 921600;
 				break;
 			}
@@ -2778,7 +2725,7 @@ static int __init mxser_get_PCI_conf(int
 	}
 
 	if (brd->chip_flag == MOXA_MUST_MU860_HWID) {
-		for (i = 0; i < brd->nports; i++) {
+		for (i = 0; i < brd->info->nports; i++) {
 			if (i < 4)
 				brd->ports[i].opmode_ioaddr = ioaddress + 4;
 			else
@@ -2788,7 +2735,7 @@ static int __init mxser_get_PCI_conf(int
 		outb(0, ioaddress + 0x0c);	/* default set to RS232 mode */
 	}
 
-	for (i = 0; i < brd->nports; i++) {
+	for (i = 0; i < brd->info->nports; i++) {
 		brd->vector_mask |= (1 << i);
 		brd->ports[i].baud_base = 921600;
 	}
@@ -2814,9 +2761,6 @@ static int __init mxser_module_init(void
 		return -ENOMEM;
 	spin_lock_init(&gm_lock);
 
-	for (i = 0; i < MXSER_BOARDS; i++)
-		mxser_boards[i].board_type = -1;
-
 	printk(KERN_INFO "MOXA Smartio/Industio family driver version %s\n",
 		MXSER_VERSION);
 
@@ -2863,8 +2807,7 @@ static int __init mxser_module_init(void
 			if (retval != 0)
 				printk(KERN_INFO "Found MOXA %s board "
 					"(CAP=0x%x)\n",
-					mxser_brdname[brd->board_type - 1],
-					ioaddr[b]);
+					brd->info->name, ioaddr[b]);
 
 			if (retval <= 0) {
 				if (retval == MXSER_ERR_IRQ)
@@ -2892,7 +2835,7 @@ static int __init mxser_module_init(void
 			if (mxser_initbrd(brd) < 0)
 				continue;
 
-			for (i = 0; i < brd->nports; i++)
+			for (i = 0; i < brd->info->nports; i++)
 				tty_register_device(mxvar_sdriver,
 					m * MXSER_PORTS_PER_BOARD + i, NULL);
 
@@ -2910,7 +2853,7 @@ static int __init mxser_module_init(void
 			continue;
 		}
 		printk(KERN_INFO "Found MOXA %s board(BusNo=%d,DevNo=%d)\n",
-			mxser_brdname[(int) (mxser_pcibrds[b].driver_data) - 1],
+			mxser_cards[mxser_pcibrds[b].driver_data].name,
 			pdev->bus->number, PCI_SLOT(pdev->devfn));
 		if (m >= MXSER_BOARDS)
 			printk(KERN_ERR
@@ -2925,8 +2868,7 @@ static int __init mxser_module_init(void
 			}
 			brd = &mxser_boards[m];
 			brd->pdev = pdev;
-			retval = mxser_get_PCI_conf(
-					(int)mxser_pcibrds[b].driver_data,
+			retval = mxser_get_PCI_conf(&mxser_pcibrds[b],
 					brd, pdev);
 			if (retval < 0) {
 				if (retval == MXSER_ERR_IRQ)
@@ -2950,7 +2892,7 @@ static int __init mxser_module_init(void
 			/* mxser_initbrd will hook ISR. */
 			if (mxser_initbrd(brd) < 0)
 				continue;
-			for (i = 0; i < brd->nports; i++)
+			for (i = 0; i < brd->info->nports; i++)
 				tty_register_device(mxvar_sdriver,
 					m * MXSER_PORTS_PER_BOARD + i,
 					&pdev->dev);
@@ -2989,7 +2931,7 @@ static void __exit mxser_module_exit(voi
 	put_tty_driver(mxvar_sdriver);
 
 	for (i = 0; i < MXSER_BOARDS; i++)
-		if (mxser_boards[i].board_type != -1)
+		if (mxser_boards[i].info != NULL)
 			mxser_release_res(&mxser_boards[i], 1);
 
 	pr_debug("Done.\n");
