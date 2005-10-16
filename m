Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbVJPW13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbVJPW13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 18:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbVJPW13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 18:27:29 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:21198 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1751369AbVJPW1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 18:27:23 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Mon, 17 Oct 2005 00:27:15 +0200
In-reply-to: <200100919343.123456789ble@anxur.fi.muni.cz>
Subject: [PATCHv3 4/6] char, isicom: Pci probing added
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
Message-Id: <20051016222714.2CC2F22B375@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pci probing added

Pci probing functions added, most of functions rewrited because of it (some
for loops were redundant).
Used PCI_DEVICE macro.
dev_* used for printing wherever possible.
Renamed some functions to have isicom_ in the name.

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

---
commit 9cbacac63a2c267ec64835b914d7c4c4e54807d4
tree 3d7c9f03285234e79470e1a713d6ebb7317041ac
parent ef27dbef1dcc2b62a72b2c4bbb4e6c7229e48c43
author root <root@bellona.(none)> Sun, 16 Oct 2005 23:25:58 +0200
committer root <root@bellona.(none)> Sun, 16 Oct 2005 23:25:58 +0200

 drivers/char/isicom.c |  447 ++++++++++++++++++++++++++-----------------------
 1 files changed, 239 insertions(+), 208 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -107,7 +107,6 @@
  *	Omit those entries for boards you don't have installed.
  *
  *	TODO
- *		Hotplug
  *		Merge testing
  *		64-bit verification
  */
@@ -146,20 +145,30 @@
 #define isicom_paranoia_check(a, b, c) 0
 #endif
 
+static int isicom_probe(struct pci_dev *, const struct pci_device_id *);
+static void __devexit isicom_remove(struct pci_dev *);
+
 static struct pci_device_id isicom_pci_tbl[] = {
-	{ VENDOR_ID, 0x2028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2052, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2054, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2056, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2057, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
-	{ VENDOR_ID, 0x2058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_DEVICE(VENDOR_ID, 0x2028) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2051) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2052) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2053) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2054) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2055) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2056) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2057) },
+	{ PCI_DEVICE(VENDOR_ID, 0x2058) },
 	{ 0 }
 };
 MODULE_DEVICE_TABLE(pci, isicom_pci_tbl);
 
+static struct pci_driver isicom_driver = {
+	.name		= "isicom",
+	.id_table	= isicom_pci_tbl,
+	.probe		= isicom_probe,
+	.remove		= __devexit_p(isicom_remove)
+};
+
 static int prev_card = 3;	/*	start servicing isi_card[0]	*/
 static struct tty_driver *isicom_normal;
 
@@ -171,8 +180,6 @@ static int ISILoad_ioctl(struct inode *i
 static void isicom_tx(unsigned long _data);
 static void isicom_start(struct tty_struct *tty);
 
-static unsigned char *tmp_buf;
-
 /*   baud index mappings from linux defns to isi */
 
 static signed char linuxb_to_isib[] = {
@@ -1365,7 +1372,7 @@ static int isicom_write(struct tty_struc
 	if (isicom_paranoia_check(port, tty->name, "isicom_write"))
 		return 0;
 
-	if (!tty || !port->xmit_buf || !tmp_buf)
+	if (!tty || !port->xmit_buf)
 		return 0;
 
 	spin_lock_irqsave(&card->card_lock, flags);
@@ -1731,32 +1738,39 @@ static void isicom_flush_buffer(struct t
 	tty_wakeup(tty);
 }
 
+/*
+ * Driver init and deinit functions
+ */
 
-static int __devinit register_ioregion(void)
+static int __devinit isicom_register_ioregion(struct pci_dev *pdev,
+	const unsigned int index)
 {
-	int count, done=0;
-	for (count=0; count < BOARD_COUNT; count++ ) {
-		if (isi_card[count].base)
-			if (!request_region(isi_card[count].base,16,ISICOM_NAME)) {
-				printk(KERN_DEBUG "ISICOM: I/O Region 0x%lx-0x%lx is busy. Card%d will be disabled.\n",
-					isi_card[count].base,isi_card[count].base+15,count+1);
-				isi_card[count].base=0;
-				done++;
-			}
-	}
-	return done;
+	struct isi_board *board = pci_get_drvdata(pdev);
+
+	if (!board->base)
+		return -EINVAL;
+
+	if (!request_region(board->base, 16, ISICOM_NAME)) {
+		dev_dbg(&pdev->dev, "I/O Region 0x%lx-0x%lx is busy. Card%d "
+			"will be disabled.\n", board->base, board->base + 15,
+			index + 1);
+		return -EBUSY;
+ 	}
+
+	return 0;
 }
 
-static void unregister_ioregion(void)
+static void isicom_unregister_ioregion(struct pci_dev *pdev)
 {
-	int count;
-	for (count=0; count < BOARD_COUNT; count++ )
-		if (isi_card[count].base) {
-			release_region(isi_card[count].base,16);
-#ifdef ISICOM_DEBUG
-			printk(KERN_DEBUG "ISICOM: I/O Region 0x%lx-0x%lx released for Card%d.\n",isi_card[count].base,isi_card[count].base+15,count+1);
-#endif
-		}
+	struct isi_board *board = pci_get_drvdata(pdev);
+
+	if (!board->base)
+		return;
+
+	release_region(board->base, 16);
+	dev_dbg(&pdev->dev, "I/O Region 0x%lx-0x%lx released.\n",
+		board->base, board->base + 15);
+	board->base = 0;
 }
 
 static struct tty_operations isicom_ops = {
@@ -1820,95 +1834,182 @@ static void isicom_unregister_tty_driver
 	put_tty_driver(isicom_normal);
 }
 
-static int __devinit register_isr(void)
+static int __devinit isicom_register_isr(struct pci_dev *pdev,
+	const unsigned int index)
 {
-	int count, done=0;
-	unsigned long irqflags;
+	struct isi_board *board = pci_get_drvdata(pdev);
+	unsigned long irqflags = SA_INTERRUPT;
+	int retval = -EINVAL;
 
-	for (count=0; count < BOARD_COUNT; count++ ) {
-		if (isi_card[count].base) {
-			irqflags = (isi_card[count].isa == YES) ?
-					SA_INTERRUPT :
-					(SA_INTERRUPT | SA_SHIRQ);
-
-			if (request_irq(isi_card[count].irq,
-					isicom_interrupt,
-					irqflags,
-					ISICOM_NAME, &isi_card[count])) {
-
-				printk(KERN_WARNING "ISICOM: Could not"
-					" install handler at Irq %d."
-					" Card%d will be disabled.\n",
-					isi_card[count].irq, count+1);
+	if (!board->base)
+		goto end;
 
-				release_region(isi_card[count].base,16);
-				isi_card[count].base=0;
-			}
-			else
-				done++;
+	if (board->isa == NO)
+		irqflags |= SA_SHIRQ;
+
+	retval = request_irq(board->irq, isicom_interrupt, irqflags,
+		ISICOM_NAME, board);
+	if (retval < 0)
+		dev_warn(&pdev->dev, "Could not install handler at Irq %d. "
+			"Card%d will be disabled.\n", board->irq, index + 1);
+ 	else
+		retval = 0;
+end:
+	return retval;
+}
+
+static int __devinit reset_card(struct pci_dev *pdev,
+	const unsigned int card, unsigned int *signature)
+{
+	struct isi_board *board = pci_get_drvdata(pdev);
+	unsigned long base = board->base;
+	unsigned int portcount = 0;
+	int retval = 0;
+
+	dev_dbg(&pdev->dev, "ISILoad:Resetting Card%d at 0x%lx\n", card + 1,
+		base);
+
+	inw(base + 0x8);
+
+	mdelay(10);
+
+	outw(0, base + 0x8); /* Reset */
+
+	msleep(3000);
+
+	*signature = inw(base + 0x4) & 0xff;
+
+	if (board->isa == YES) {
+		if (!(inw(base + 0xe) & 0x1) || (inw(base + 0x2))) {
+			dev_dbg(&pdev->dev, "base+0x2=0x%lx, base+0xe=0x%lx\n",
+				inw(base + 0x2), inw(base + 0xe));
+			dev_err(&pdev->dev, "ISILoad:ISA Card%d reset failure "
+				"(Possible bad I/O Port Address 0x%lx).\n",
+				card + 1, base);
+			retval = -EIO;
+			goto end;
+		}
+	} else {
+		portcount = inw(base + 0x2);
+		if (!(inw(base + 0xe) & 0x1) || ((portcount != 0) &&
+				(portcount != 4) && (portcount != 8))) {
+			dev_dbg(&pdev->dev, "base+0x2=0x%lx, base+0xe=0x%lx\n",
+				inw(base + 0x2), inw(base + 0xe));
+			dev_err(&pdev->dev, "ISILoad:PCI Card%d reset failure "
+				"(Possible bad I/O Port Address 0x%lx).\n",
+				card + 1, base);
+			retval = -EIO;
+			goto end;
 		}
 	}
-	return done;
+
+	switch (*signature) {
+	case 0xa5:
+	case 0xbb:
+	case 0xdd:
+		board->port_count = (board->isa == NO && portcount == 4) ? 4 :
+			8;
+		board->shift_count = 12;
+		break;
+	case 0xcc:
+		board->port_count = 16;
+		board->shift_count = 11;
+		break;
+	default:
+		dev_warn(&pdev->dev, "ISILoad:Card%d reset failure (Possible "
+			"bad I/O Port Address 0x%lx).\n", card + 1, base);
+		dev_dbg(&pdev->dev, "Sig=0x%lx\n", signature);
+		retval = -EIO;
+	}
+	dev_info(&pdev->dev, "-Done\n");
+
+end:
+	return retval;
 }
 
-static void __exit unregister_isr(void)
+/*
+ *	Insmod can set static symbols so keep these static
+ */
+static int io[4];
+static int irq[4];
+static int card;
+
+static int __devinit isicom_probe(struct pci_dev *pdev,
+	const struct pci_device_id *ent)
 {
-	int count;
+	unsigned int ioaddr, signature, index;
+	int retval = -EPERM;
+	u8 pciirq;
+	struct isi_board *board = NULL;
+
+	if (card >= BOARD_COUNT)
+		goto err;
+
+	ioaddr = pci_resource_start(pdev, 3);
+	/* i.e at offset 0x1c in the PCI configuration register space. */
+	pciirq = pdev->irq;
+	dev_info(&pdev->dev, "ISI PCI Card(Device ID 0x%x)\n", ent->device);
+
+	/* allot the first empty slot in the array */
+	for (index = 0; index < BOARD_COUNT; index++)
+		if (isi_card[index].base == 0) {
+			board = &isi_card[index];
+			break;
+		}
 
-	for (count=0; count < BOARD_COUNT; count++ ) {
-		if (isi_card[count].base)
-			free_irq(isi_card[count].irq, &isi_card[count]);
-	}
+	board->base = ioaddr;
+	board->irq = pciirq;
+	board->isa = NO;
+	card++;
+
+	pci_set_drvdata(pdev, board);
+
+	retval = isicom_register_ioregion(pdev, index);
+	if (retval < 0)
+		goto err;
+
+	retval = isicom_register_isr(pdev, index);
+	if (retval < 0)
+		goto errunrr;
+
+	retval = reset_card(pdev, index, &signature);
+	if (retval < 0)
+		goto errunri;
+
+	return 0;
+
+errunri:
+	free_irq(board->irq, board);
+errunrr:
+	isicom_unregister_ioregion(pdev);
+err:
+	board->base = 0;
+	return retval;
 }
 
-static int __devinit isicom_init(void)
+static void __devexit isicom_remove(struct pci_dev *pdev)
 {
-	int card, channel, base;
-	struct isi_port *port;
-	unsigned long page;
+	struct isi_board *board = pci_get_drvdata(pdev);
 
-	if (!tmp_buf) {
-		page = get_zeroed_page(GFP_KERNEL);
-		if (!page) {
-#ifdef ISICOM_DEBUG
-			printk(KERN_DEBUG "ISICOM: Couldn't allocate page for tmp_buf.\n");
-#else
-			printk(KERN_ERR "ISICOM: Not enough memory...\n");
-#endif
-			return 0;
-		}
-		tmp_buf = (unsigned char *) page;
-	}
+	free_irq(board->irq, board);
+	isicom_unregister_ioregion(pdev);
+}
 
-	if (!register_ioregion())
-	{
-		printk(KERN_ERR "ISICOM: All required I/O space found busy.\n");
-		free_page((unsigned long)tmp_buf);
-		return 0;
-	}
-	if (isicom_register_tty_driver())
-	{
-		unregister_ioregion();
-		free_page((unsigned long)tmp_buf);
-		return 0;
-	}
-	if (!register_isr())
-	{
-		isicom_unregister_tty_driver();
-		/*  ioports already uregistered in register_isr */
-		free_page((unsigned long)tmp_buf);
-		return 0;
-	}
+static int __devinit isicom_setup(void)
+{
+	int retval, idx, channel;
+	struct isi_port *port;
 
+	card = 0;
 	memset(isi_ports, 0, sizeof(isi_ports));
-	for (card = 0; card < BOARD_COUNT; card++) {
-		port = &isi_ports[card * 16];
-		isi_card[card].ports = port;
-		spin_lock_init(&isi_card[card].card_lock);
-		base = isi_card[card].base;
+
+	for(idx = 0; idx < BOARD_COUNT; idx++) {
+		port = &isi_ports[idx * 16];
+		isi_card[idx].ports = port;
+		spin_lock_init(&isi_card[idx].card_lock);
 		for (channel = 0; channel < 16; channel++, port++) {
 			port->magic = ISICOM_MAGIC;
-			port->card = &isi_card[card];
+			port->card = &isi_card[idx];
 			port->channel = channel;
 			port->close_delay = 50 * HZ/100;
 			port->closing_wait = 3000 * HZ/100;
@@ -1918,109 +2019,38 @@ static int __devinit isicom_init(void)
 			init_waitqueue_head(&port->open_wait);
 			init_waitqueue_head(&port->close_wait);
 			/*  . . .  */
-		}
-	}
-
-	return 1;
-}
-
-/*
- *	Insmod can set static symbols so keep these static
- */
-
-static int io[4];
-static int irq[4];
-
-static int __devinit isicom_setup(void)
-{
-	struct pci_dev *dev = NULL;
-	int retval, card, idx, count;
-	unsigned char pciirq;
-	unsigned int ioaddr;
-
-	card = 0;
-	for (idx=0; idx < BOARD_COUNT; idx++) {
-		if (io[idx]) {
-			isi_card[idx].base=io[idx];
-			isi_card[idx].irq=irq[idx];
-			isi_card[idx].isa=YES;
-			card++;
-		}
-		else {
-			isi_card[idx].base = 0;
-			isi_card[idx].irq = 0;
-		}
-	}
-
-	for (idx=0 ;idx < card; idx++) {
-		if (!((isi_card[idx].irq==2)||(isi_card[idx].irq==3)||
-			(isi_card[idx].irq==4)||(isi_card[idx].irq==5)||
-			(isi_card[idx].irq==7)||(isi_card[idx].irq==10)||
-			(isi_card[idx].irq==11)||(isi_card[idx].irq==12)||
-			(isi_card[idx].irq==15))) {
-
-			if (isi_card[idx].base) {
-				printk(KERN_ERR "ISICOM: Irq %d unsupported. Disabling Card%d...\n",
-					isi_card[idx].irq, idx+1);
-				isi_card[idx].base=0;
-				card--;
-			}
-		}
-	}
-
-	if (card < BOARD_COUNT) {
-		for (idx=0; idx < DEVID_COUNT; idx++) {
-			dev = NULL;
-			for (;;){
-				if (!(dev = pci_find_device(VENDOR_ID, isicom_pci_tbl[idx].device, dev)))
-					break;
-				if (card >= BOARD_COUNT)
-					break;
-
-				if (pci_enable_device(dev))
-					break;
+ 		}
+		isi_card[idx].base = 0;
+		isi_card[idx].irq = 0;
 
-				/* found a PCI ISI card! */
-				ioaddr = pci_resource_start (dev, 3);
-				/* i.e at offset 0x1c in the
-				 * PCI configuration register
-				 * space.
-				 */
-				pciirq = dev->irq;
-				printk(KERN_INFO "ISI PCI Card(Device ID 0x%x)\n", isicom_pci_tbl[idx].device);
-				/*
-				 * allot the first empty slot in the array
-				 */
-				for (count=0; count < BOARD_COUNT; count++) {
-					if (isi_card[count].base == 0) {
-						isi_card[count].base = ioaddr;
-						isi_card[count].irq = pciirq;
-						isi_card[count].isa = NO;
-						card++;
-						break;
-					}
-				}
-			}
-			if (card >= BOARD_COUNT) break;
-		}
-	}
+		if (!io[idx])
+			continue;
 
-	if (!(isi_card[0].base || isi_card[1].base || isi_card[2].base || isi_card[3].base)) {
-		printk(KERN_ERR "ISICOM: No valid card configuration. Driver cannot be initialized...\n");
-		return -EIO;
-	}
+		if (irq[idx] == 2 || irq[idx] == 3 || irq[idx] == 4	||
+				irq[idx] == 5	|| irq[idx] == 7	||
+				irq[idx] == 10	|| irq[idx] == 11	||
+				irq[idx] == 12	|| irq[idx] == 15) {
+			printk(KERN_ERR "ISICOM: ISA not supported yet.\n");
+			retval = -EINVAL;
+			goto error;
+		} else
+			printk(KERN_ERR "ISICOM: Irq %d unsupported. "
+				"Disabling Card%d...\n", irq[idx], idx + 1);
+	}
+
+	retval = isicom_register_tty_driver();
+	if (retval < 0)
+		goto error;
 
-	retval = misc_register(&isiloader_device);
+	retval = pci_register_driver(&isicom_driver);
 	if (retval < 0) {
-		printk(KERN_ERR "ISICOM: Unable to register firmware loader driver.\n");
-		return retval;
+		printk(KERN_ERR "ISICOM: Unable to register pci driver.\n");
+		goto errtty;
 	}
 
-	if (!isicom_init()) {
-		if (misc_deregister(&isiloader_device))
-			printk(KERN_ERR "ISICOM: Unable to unregister Firmware Loader driver\n");
-		return -EIO;
-	}
+	retval = misc_register(&isiloader_device);
+	if (retval < 0)
+		goto errpci;
 
 	init_timer(&tx);
 	tx.expires = jiffies + 1;
@@ -2030,6 +2060,12 @@ static int __devinit isicom_setup(void)
 	add_timer(&tx);
 
 	return 0;
+errpci:
+	pci_unregister_driver(&isicom_driver);
+errtty:
+	isicom_unregister_tty_driver();
+error:
+	return retval;
 }
 
 static void __exit isicom_exit(void)
@@ -2041,13 +2077,8 @@ static void __exit isicom_exit(void)
 	while (re_schedule != 2 && index++ < 100)
 		msleep(10);
 
-	unregister_isr();
+	pci_unregister_driver(&isicom_driver);
 	isicom_unregister_tty_driver();
-	unregister_ioregion();
-	if (tmp_buf)
-		free_page((unsigned long)tmp_buf);
-	if (misc_deregister(&isiloader_device))
-		printk(KERN_ERR "ISICOM: Unable to unregister Firmware Loader driver\n");
 }
 
 module_init(isicom_setup);
