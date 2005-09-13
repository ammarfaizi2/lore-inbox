Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVIMQyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVIMQyD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 12:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbVIMQx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 12:53:57 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:50824 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S964893AbVIMQxX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 12:53:23 -0400
Date: Tue, 13 Sep 2005 18:52:56 +0200
Message-Id: <200509131652.j8DGquXo022115@localhost.localdomain>
In-reply-to: <200509131649.j8DGnNnw021871@localhost.localdomain>
Subject: [PATCH 3/5] isicom: pci probing
From: Jiri Slaby <jirislaby@gmail.com>
To: akpm@osdl.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>

 drivers/char/isicom.c  |  598 +++++++++++++++++++++++++++----------------------
 include/linux/isicom.h |    3 
 2 files changed, 333 insertions(+), 268 deletions(-)

diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -91,6 +91,8 @@
  *	06/01/05  Alan Cox 		Merged the ISI and base kernel strands
  *					into a single 2.6 driver
  *
+ *	10/09/05  Jiri Slaby		driver rewritten to 2.6 API
+ *
  *	***********************************************************
  *
  *	To use this driver you also need the support package. You
@@ -107,7 +109,6 @@
  *	Omit those entries for boards you don't have installed.
  *
  *	TODO
- *		Hotplug
  *		Merge testing
  *		64-bit verification
  */
@@ -135,20 +136,41 @@
 
 #include <linux/isicom.h>
 
+#define InterruptTheCard(base) outw(0, (base) + 0xc)
+#define ClearInterrupt(base) inw((base) + 0x0a)
+
+#ifdef ISICOM_DEBUG
+#define pr_deb(str, ...) printk((str), ##args);
+#define isicom_paranoia_check(a, b, c) __isicom_paranoia_check((a), (b), (c))
+#else
+#define pr_deb(str, ...)
+#define isicom_paranoia_check(a, b, c) 0
+#endif
+
+static int isicom_probe(struct pci_dev*, const struct pci_device_id*);
+static void __devexit isicom_remove(struct pci_dev*);
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
 
@@ -160,8 +182,6 @@ static int ISILoad_ioctl(struct inode *i
 static void isicom_tx(unsigned long _data);
 static void isicom_start(struct tty_struct *tty);
 
-static unsigned char *tmp_buf;
-
 /*   baud index mappings from linux defns to isi */
 
 static signed char linuxb_to_isib[] = {
@@ -180,6 +200,7 @@ struct	isi_board {
 	u8			isa;
 	spinlock_t		card_lock; /* Card wide lock 11/5/00 -sameer */
 	unsigned long		flags;
+	struct device		device;
 };
 
 struct	isi_port {
@@ -598,23 +619,20 @@ static int ISILoad_ioctl(struct inode *i
  *
  */
 
-static inline int isicom_paranoia_check(struct isi_port const *port, char *name,
-	const char *routine)
+static inline int __isicom_paranoia_check(struct isi_port const *port,
+	char *name, const char *routine)
 {
-#ifdef ISICOM_DEBUG
-	static const char *badmagic =
-			KERN_WARNING "ISICOM: Warning: bad isicom magic for dev %s in %s.\n";
-	static const char *badport =
-			KERN_WARNING "ISICOM: Warning: NULL isicom port for dev %s in %s.\n";
 	if (!port) {
-		printk(badport, name, routine);
+		printk(KERN_WARNING "ISICOM: Warning: bad isicom magic for "
+			"dev %s in %s.\n", name, routine);
 		return 1;
 	}
 	if (port->magic != ISICOM_MAGIC) {
-		printk(badmagic, name, routine);
+		printk(KERN_WARNING "ISICOM: Warning: NULL isicom port for "
+			"dev %s in %s.\n", name, routine);
 		return 1;
 	}
-#endif
+
 	return 0;
 }
 
@@ -632,10 +650,6 @@ static void isicom_tx(unsigned long _dat
 	struct isi_port *port;
 	struct tty_struct *tty;
 
-#ifdef ISICOM_DEBUG
-	++tx_count;
-#endif
-
 	/*	find next active board	*/
 	card = (prev_card + 1) & 0x0003;
 	while(count-- > 0) {
@@ -677,12 +691,10 @@ static void isicom_tx(unsigned long _dat
 			unlock_card(&isi_card[card]);
 			continue;
 		}
-#ifdef ISICOM_DEBUG
-		printk(KERN_DEBUG "ISICOM: txing %d bytes, port%d.\n",
-				txcount, port->channel+1);
-#endif
-		outw((port->channel << isi_card[card].shift_count) | txcount
-					, base);
+		pr_deb(KERN_DEBUG "ISICOM: txing %d bytes, port%d.\n",
+			txcount, port->channel + 1);
+		outw((port->channel << isi_card[card].shift_count) | txcount,
+			base);
 		residue = NO;
 		wrd = 0;
 		while (1) {
@@ -728,8 +740,11 @@ static void isicom_tx(unsigned long _dat
 
 	/*	schedule another tx for hopefully in about 10ms	*/
 sched_again:
-	if (!re_schedule)
-		return;
+	if (!re_schedule) {
+		re_schedule = 2;
+ 		return;
+	}
+
 	init_timer(&tx);
 	tx.expires = jiffies + HZ/100;
 	tx.data = 0;
@@ -1374,7 +1389,7 @@ static int isicom_write(struct tty_struc
 	if (isicom_paranoia_check(port, tty->name, "isicom_write"))
 		return 0;
 
-	if (!tty || !port->xmit_buf || !tmp_buf)
+	if (!tty || !port->xmit_buf)
 		return 0;
 
 	spin_lock_irqsave(&card->card_lock, flags);
@@ -1740,32 +1755,36 @@ static void isicom_flush_buffer(struct t
 	tty_wakeup(tty);
 }
 
+/*
+ * Driver init and deinit functions
+ */
 
-static int __devinit register_ioregion(void)
+static int __devinit isicom_register_ioregion(struct isi_board *board,
+	const unsigned int index)
 {
-	int count, done=0;
-	for (count=0; count < BOARD_COUNT; count++ ) {
-		if (isi_card[count].base)
-			if (!request_region(isi_card[count].base,16,ISICOM_NAME)) {
-				printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x is busy. Card%d will be disabled.\n",
-					isi_card[count].base,isi_card[count].base+15,count+1);
-				isi_card[count].base=0;
-				done++;
-			}
-	}
-	return done;
+	if (!board->base)
+		return -EINVAL;
+
+	if (!request_region(board->base, 16, ISICOM_NAME)) {
+		printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x is busy. "
+			"Card%d will be disabled.\n", board->base,
+			board->base + 15, index + 1);
+		return -EBUSY;
+ 	}
+
+	return 0;
 }
 
-static void unregister_ioregion(void)
+static void isicom_unregister_ioregion(struct isi_board *board,
+	const unsigned int index)
 {
-	int count;
-	for (count=0; count < BOARD_COUNT; count++ )
-		if (isi_card[count].base) {
-			release_region(isi_card[count].base,16);
-#ifdef ISICOM_DEBUG
-			printk(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x released for Card%d.\n",isi_card[count].base,isi_card[count].base+15,count+1);
-#endif
-		}
+	if (!board->base)
+		return;
+
+	release_region(board->base, 16);
+	board->base = 0;
+	pr_deb(KERN_DEBUG "ISICOM: I/O Region 0x%x-0x%x released for Card%d.\n",
+		board->base, board->base + 15, index + 1);
 }
 
 static struct tty_operations isicom_ops = {
@@ -1788,134 +1807,238 @@ static struct tty_operations isicom_ops 
 	.tiocmset		= isicom_tiocmset,
 };
 
-static int __devinit register_drivers(void)
+static int __devinit isicom_register_tty_driver(void)
 {
-	int error;
+	int error = -ENOMEM;
 
 	/* tty driver structure initialization */
 	isicom_normal = alloc_tty_driver(PORT_COUNT);
 	if (!isicom_normal)
-		return -ENOMEM;
+		goto end;
 
-	isicom_normal->owner	= THIS_MODULE;
-	isicom_normal->name 	= "ttyM";
-	isicom_normal->devfs_name = "isicom/";
-	isicom_normal->major	= ISICOM_NMAJOR;
-	isicom_normal->minor_start	= 0;
-	isicom_normal->type	= TTY_DRIVER_TYPE_SERIAL;
-	isicom_normal->subtype	= SERIAL_TYPE_NORMAL;
-	isicom_normal->init_termios	= tty_std_termios;
-	isicom_normal->init_termios.c_cflag	=
-				B9600 | CS8 | CREAD | HUPCL |CLOCAL;
-	isicom_normal->flags	= TTY_DRIVER_REAL_RAW;
+	isicom_normal->owner			= THIS_MODULE;
+	isicom_normal->name 			= "ttyM";
+	isicom_normal->devfs_name	 	= "isicom/";
+	isicom_normal->major			= ISICOM_NMAJOR;
+	isicom_normal->minor_start		= 0;
+	isicom_normal->type			= TTY_DRIVER_TYPE_SERIAL;
+	isicom_normal->subtype			= SERIAL_TYPE_NORMAL;
+	isicom_normal->init_termios		= tty_std_termios;
+	isicom_normal->init_termios.c_cflag	= B9600 | CS8 | CREAD | HUPCL |
+		CLOCAL;
+	isicom_normal->flags			= TTY_DRIVER_REAL_RAW;
 	tty_set_operations(isicom_normal, &isicom_ops);
 
-	if ((error=tty_register_driver(isicom_normal))!=0) {
-		printk(KERN_DEBUG "ISICOM: Couldn't register the dialin driver, error=%d\n",
-			error);
+	if ((error = tty_register_driver(isicom_normal))) {
+		printk(KERN_DEBUG "ISICOM: Couldn't register the dialin "
+			"driver, error=%d\n", error);
 		put_tty_driver(isicom_normal);
-		return error;
 	}
-	return 0;
+end:
+	return error;
 }
 
-static void unregister_drivers(void)
+static void isicom_unregister_tty_driver(void)
 {
-	int error = tty_unregister_driver(isicom_normal);
-	if (error)
-		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver error=%d.\n",error);
+	int error;
+
+	if ((error = tty_unregister_driver(isicom_normal)))
+		printk(KERN_DEBUG "ISICOM: couldn't unregister normal driver, "
+			"error=%d.\n", error);
+
 	put_tty_driver(isicom_normal);
 }
 
-static int __devinit register_isr(void)
+static int __devinit isicom_register_isr(struct isi_board *board,
+	const unsigned int index)
 {
-	int count, done=0;
-	unsigned long irqflags;
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
-		}
+	if (board->isa == NO)
+		irqflags |= SA_SHIRQ;
+
+	retval = request_irq(board->irq, isicom_interrupt, irqflags,
+		ISICOM_NAME, board);
+	if (retval < 0) {
+		printk(KERN_WARNING "ISICOM: Could not install handler at Irq "
+			"%d. Card%d will be disabled.\n", board->irq,
+			index + 1);
+ 	} else
+		retval = 0;
+end:
+	return retval;
+}
+
+static void isicom_unregister_isr(struct isi_board *board)
+{
+	if (board->base)
+		free_irq(board->irq, board);
+}
+
+static int __devinit reset_card(struct isi_board *board,
+	const unsigned int card, unsigned int *signature)
+{
+	u16 base = board->base;
+	unsigned int portcount = 0;
+	int retval = 0;
+
+	printk(KERN_DEBUG "ISILoad:Resetting Card%d at 0x%x\n", card + 1, base);
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
+			pr_deb(KERN_DEBUG "base+0x2=0x%x, base+0xe=0x%x",
+				inw(base + 0x2), inw(base + 0xe));
+			printk(KERN_ERR "ISILoad:ISA Card%d reset failure "
+				"(Possible bad I/O Port Address 0x%x).\n",
+				card + 1, base);
+			retval = -EIO;
+			goto end;
+		}
+	} else {
+		portcount = inw(base + 0x2);
+		if (!(inw(base + 0xe) & 0x1) || ((portcount != 0) &&
+				(portcount != 4) && (portcount != 8))) {
+			pr_deb("\nbase+0x2=0x%x , base+0xe=0x%x",
+				inw(base + 0x2), inw(base + 0xe));
+			printk("\nISILoad:PCI Card%d reset failure (Possible "
+				"bad I/O Port Address 0x%x).\n", card + 1,
+				base);
+			retval = -EIO;
+			goto end;
+		}
+	}
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
+		printk(KERN_WARNING "ISILoad:Card%d reset failure (Possible "
+			"bad I/O Port Address 0x%x).\n", card + 1, base);
+		pr_deb(KERN_DEBUG "Sig=0x%x\n", signature);
+		retval = -EIO;
 	}
-	return done;
+	printk(KERN_INFO "-Done\n");
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
+	printk(KERN_INFO "ISI PCI Card(Device ID 0x%x)\n", ent->device);
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
+	board->device = pdev->dev;
+	card++;
+
+	retval = isicom_register_ioregion(board, index);
+	if (retval < 0)
+		goto err;
+
+	retval = isicom_register_isr(board, index);
+	if (retval < 0)
+		goto errunrr;
+
+	retval = reset_card(board, index, &signature);
+	if (retval < 0)
+		goto errunri;
+
+/*	retval = load_firmware(board, index, signature);
+	if (retval < 0)
+		goto errunri; */
+
+	return 0;
+
+errunri:
+	isicom_unregister_isr(board);
+errunrr:
+	isicom_unregister_ioregion(board, index);
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
+	unsigned int idx;
 
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
+	for (idx = 0; idx < BOARD_COUNT; idx++)
+		if (isi_card[idx].base == pci_resource_start(pdev, 3))
+			break;
 
-	if (!register_ioregion())
-	{
-		printk(KERN_ERR "ISICOM: All required I/O space found busy.\n");
-		free_page((unsigned long)tmp_buf);
-		return 0;
-	}
-	if (register_drivers())
-	{
-		unregister_ioregion();
-		free_page((unsigned long)tmp_buf);
-		return 0;
-	}
-	if (!register_isr())
-	{
-		unregister_drivers();
-		/*  ioports already uregistered in register_isr */
-		free_page((unsigned long)tmp_buf);
-		return 0;
-	}
+	if (idx == BOARD_COUNT)
+		return;
 
+	isicom_unregister_isr(&isi_card[idx]);
+	isicom_unregister_ioregion(&isi_card[idx], idx);
+}
+
+static int __devinit isicom_setup(void)
+{
+	int retval, idx, channel;
+	struct isi_port *port;
+
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
@@ -1925,117 +2048,44 @@ static int __devinit isicom_init(void)
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
-MODULE_AUTHOR("MultiTech");
-MODULE_DESCRIPTION("Driver for the ISI series of cards by MultiTech");
-MODULE_LICENSE("GPL");
-module_param_array(io, int, NULL, 0);
-MODULE_PARM_DESC(io, "I/O ports for the cards");
-module_param_array(irq, int, NULL, 0);
-MODULE_PARM_DESC(irq, "Interrupts for the cards");
+ 		}
+		isi_card[idx].base = 0;
+		isi_card[idx].irq = 0;
 
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
-
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
+			return -EIO;
+/*			isi_card[idx].base = io[idx];
+			isi_card[idx].irq = irq[idx];
+			isi_card[idx].isa = YES;
+ FIXME: which device for request_firmware use? if you know, uncomment this and
+ delete printk and return
+			isi_card[idx].device = ???;
+			card++;*/
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
@@ -2045,21 +2095,39 @@ static int __devinit isicom_setup(void)
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
 {
+	unsigned int index = 0;
+
 	re_schedule = 0;
-	/* FIXME */
-	msleep(1000);
-	unregister_isr();
-	unregister_drivers();
-	unregister_ioregion();
-	if (tmp_buf)
-		free_page((unsigned long)tmp_buf);
-	if (misc_deregister(&isiloader_device))
-		printk(KERN_ERR "ISICOM: Unable to unregister Firmware Loader driver\n");
+
+	while (re_schedule != 2 && index++ < 100)
+		msleep(10);
+
+	pci_unregister_driver(&isicom_driver);
+	isicom_unregister_tty_driver();
+
+	for (index = 0; index < BOARD_COUNT; index++) {
+		isicom_unregister_isr(&isi_card[index]);
+		isicom_unregister_ioregion(&isi_card[index], index);
+	}
 }
 
 module_init(isicom_setup);
 module_exit(isicom_exit);
+
+MODULE_AUTHOR("MultiTech");
+MODULE_DESCRIPTION("Driver for the ISI series of cards by MultiTech");
+MODULE_LICENSE("GPL");
+module_param_array(io, int, NULL, 0);
+MODULE_PARM_DESC(io, "I/O ports for the cards");
+module_param_array(irq, int, NULL, 0);
+MODULE_PARM_DESC(irq, "Interrupts for the cards");
diff --git a/include/linux/isicom.h b/include/linux/isicom.h
--- a/include/linux/isicom.h
+++ b/include/linux/isicom.h
@@ -98,9 +98,6 @@ typedef	struct	{
 #define		ISICOM_INITIATE_XONXOFF	0x04
 #define		ISICOM_RESPOND_XONXOFF	0x08
 
-#define InterruptTheCard(base) (outw(0,(base)+0xc)) 
-#define ClearInterrupt(base) (inw((base)+0x0a))	
-
 #define	BOARD(line)  (((line) >> 4) & 0x3)
 
 	/*	isi kill queue bitmap	*/
