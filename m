Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVDMExj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVDMExj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 00:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVDLSrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:47:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:12234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262236AbVDLKc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:56 -0400
Message-Id: <200504121032.j3CAWfsd005653@shell0.pdx.osdl.net>
Subject: [patch 129/198] fix up newly added jsm driver
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@lst.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Christoph Hellwig <hch@lst.de>

 - plug various leaks and use after frees in the remove and
   initialization failure path (some still left)
 - remove useless global list of boards and use pci_set_drvdata instead
 - unobsfucate init path by merging functions together
 - kill various totally useless state variables
 - .. probably more I forgot

Note that the tty part still generates lots of sparse warnings and there's
still a totally useless layer of function pointer indirections, but maybe
someone else will fix that bit up.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/serial/jsm/jsm.h        |   38 ---
 25-akpm/drivers/serial/jsm/jsm_driver.c |  348 ++++++++------------------------
 25-akpm/drivers/serial/jsm/jsm_tty.c    |   24 --
 3 files changed, 95 insertions(+), 315 deletions(-)

diff -puN drivers/serial/jsm/jsm_driver.c~fixup-newly-added-jsm-driver drivers/serial/jsm/jsm_driver.c
--- 25/drivers/serial/jsm/jsm_driver.c~fixup-newly-added-jsm-driver	2005-04-12 03:21:34.728857312 -0700
+++ 25-akpm/drivers/serial/jsm/jsm_driver.c	2005-04-12 03:21:34.736856096 -0700
@@ -29,7 +29,9 @@
 #include "jsm.h"
 
 MODULE_AUTHOR("Digi International, http://www.digi.com");
-MODULE_DESCRIPTION("Driver for the Digi International Neo PCI based product line");
+MODULE_DESCRIPTION("Driver for the Digi International "
+		   "Neo PCI based product line");
+MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("jsm");
 
 #define JSM_DRIVER_NAME "jsm"
@@ -43,7 +45,6 @@ struct uart_driver jsm_uart_driver = {
 	.major		= 253,
 	.minor		= JSM_MINOR_START,
 	.nr		= NR_PORTS,
-	.cons		= NULL,
 };
 
 int jsm_debug;
@@ -53,193 +54,99 @@ module_param(jsm_rawreadok, int, 0);
 MODULE_PARM_DESC(jsm_debug, "Driver debugging level");
 MODULE_PARM_DESC(jsm_rawreadok, "Bypass flip buffers on input");
 
-/*
- * Globals
- */
-int		jsm_driver_state = DRIVER_INITIALIZED;
-spinlock_t	jsm_board_head_lock = SPIN_LOCK_UNLOCKED;
-LIST_HEAD(jsm_board_head);
-
-static struct pci_device_id jsm_pci_tbl[] = {
-	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9),	0,	0,	0 },
-	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI),	0,	0,	1 },
-	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45),	0,	0,	2 },
-	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI),	0,	0,	3 },
-	{ 0,}						/* 0 terminated list. */
-};
-MODULE_DEVICE_TABLE(pci, jsm_pci_tbl);
-
-static struct board_id jsm_Ids[] = {
-	{ PCI_DEVICE_NEO_2DB9_PCI_NAME,		2 },
-	{ PCI_DEVICE_NEO_2DB9PRI_PCI_NAME,	2 },
-	{ PCI_DEVICE_NEO_2RJ45_PCI_NAME,	2 },
-	{ PCI_DEVICE_NEO_2RJ45PRI_PCI_NAME,	2 },
-	{ NULL,					0 }
-};
-
-char *jsm_driver_state_text[] = {
-	"Driver Initialized",
-	"Driver Ready."
-};
-
-static int jsm_finalize_board_init(struct jsm_board *brd)
+static int jsm_probe_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	int rc = 0;
+	struct jsm_board *brd;
+	static int adapter_count = 0;
+	int retval;
 
-	jsm_printk(INIT, INFO, &brd->pci_dev, "start\n");
-
-	if (brd->irq) {
-		rc = request_irq(brd->irq, brd->bd_ops->intr, SA_INTERRUPT|SA_SHIRQ, "JSM", brd);
-
-		if (rc) {
-			printk(KERN_WARNING "Failed to hook IRQ %d\n",brd->irq);
-			brd->state = BOARD_FAILED;
-			brd->dpastatus = BD_NOFEP;
-			rc = -ENODEV;
-		} else
-			jsm_printk(INIT, INFO, &brd->pci_dev,
-				"Requested and received usage of IRQ %d\n", brd->irq);
+	rc = pci_enable_device(pdev);
+	if (rc) {
+		dev_err(&pdev->dev, "Device enable FAILED\n");
+		goto out;
 	}
-	return rc;
-}
 
-/*
- * jsm_found_board()
- *
- * A board has been found, init it.
- */
-static int jsm_found_board(struct pci_dev *pdev, int id)
-{
-	struct jsm_board *brd;
-	int i = 0;
-	int rc = 0;
-	struct list_head *tmp;
-	struct jsm_board *cur_board_entry;
-	unsigned long lock_flags;
-	int adapter_count = 0;
-	int retval;
+	rc = pci_request_regions(pdev, "jsm");
+	if (rc) {
+		dev_err(&pdev->dev, "pci_request_region FAILED\n");
+		goto out_disable_device;
+	}
 
 	brd = kmalloc(sizeof(struct jsm_board), GFP_KERNEL);
 	if (!brd) {
-		dev_err(&pdev->dev, "memory allocation for board structure failed\n");
-		return -ENOMEM;
+		dev_err(&pdev->dev,
+			"memory allocation for board structure failed\n");
+		rc = -ENOMEM;
+		goto out_release_regions;
 	}
 	memset(brd, 0, sizeof(struct jsm_board));
 
-	spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
-	list_for_each(tmp, &jsm_board_head) {
-		cur_board_entry =
-			list_entry(tmp, struct jsm_board,
-				jsm_board_entry);
-		if (cur_board_entry->boardnum != adapter_count) {
-			break;
-		}
-		adapter_count++;
-	}
-
-	list_add_tail(&brd->jsm_board_entry, &jsm_board_head);
-	spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
-
 	/* store the info for the board we've found */
-	brd->boardnum = adapter_count;
+	brd->boardnum = adapter_count++;
 	brd->pci_dev = pdev;
-	brd->name = jsm_Ids[id].name;
-	brd->maxports = jsm_Ids[id].maxports;
-	brd->dpastatus = BD_NOFEP;
-	init_waitqueue_head(&brd->state_wait);
+	brd->maxports = 2;
 
 	spin_lock_init(&brd->bd_lock);
 	spin_lock_init(&brd->bd_intr_lock);
 
-	brd->state = BOARD_FOUND;
-
-	for (i = 0; i < brd->maxports; i++)
-		brd->channels[i] = NULL;
-
 	/* store which revision we have */
 	pci_read_config_byte(pdev, PCI_REVISION_ID, &brd->rev);
 
 	brd->irq = pdev->irq;
 
-	switch(brd->pci_dev->device) {
+	jsm_printk(INIT, INFO, &brd->pci_dev,
+		"jsm_found_board - NEO adapter\n");
 
-	case PCI_DEVICE_ID_NEO_2DB9:
-	case PCI_DEVICE_ID_NEO_2DB9PRI:
-	case PCI_DEVICE_ID_NEO_2RJ45:
-	case PCI_DEVICE_ID_NEO_2RJ45PRI:
-
-		/*
-		 * This chip is set up 100% when we get to it.
-		 * No need to enable global interrupts or anything.
-		 */
-		brd->dpatype = T_NEO | T_PCIBUS;
-
-		jsm_printk(INIT, INFO, &brd->pci_dev,
-			"jsm_found_board - NEO adapter\n");
-
-		/* get the PCI Base Address Registers */
-		brd->membase	= pci_resource_start(pdev, 0);
-		brd->membase_end = pci_resource_end(pdev, 0);
-
-		if (brd->membase & 1)
-			brd->membase &= ~3;
-		else
-			brd->membase &= ~15;
-
-		/* Assign the board_ops struct */
-		brd->bd_ops = &jsm_neo_ops;
-
-		brd->bd_uart_offset = 0x200;
-		brd->bd_dividend = 921600;
-
-		brd->re_map_membase = ioremap(brd->membase, 0x1000);
-		jsm_printk(INIT, INFO, &brd->pci_dev,
-			"remapped mem: 0x%p\n", brd->re_map_membase);
-		if (!brd->re_map_membase) {
-			kfree(brd);
-			dev_err(&pdev->dev, "card has no PCI Memory resources, failing board.\n");
-			return -ENOMEM;
-		}
-		break;
-
-	default:
-		dev_err(&pdev->dev, "Did not find any compatible Neo or Classic PCI boards in system.\n");
-		kfree(brd);
-		return -ENXIO;
+	/* get the PCI Base Address Registers */
+	brd->membase	= pci_resource_start(pdev, 0);
+	brd->membase_end = pci_resource_end(pdev, 0);
+
+	if (brd->membase & 1)
+		brd->membase &= ~3;
+	else
+		brd->membase &= ~15;
+
+	/* Assign the board_ops struct */
+	brd->bd_ops = &jsm_neo_ops;
+
+	brd->bd_uart_offset = 0x200;
+	brd->bd_dividend = 921600;
+
+	brd->re_map_membase = ioremap(brd->membase, 0x1000);
+	if (!brd->re_map_membase) {
+		dev_err(&pdev->dev,
+			"card has no PCI Memory resources, "
+			"failing board.\n");
+		rc = -ENOMEM;
+		goto out_kfree_brd;
 	}
 
-	/*
-	 * Do tty device initialization.
-	 */
-	rc = jsm_finalize_board_init(brd);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "Can't finalize board init (%d)\n", rc);
-		brd->state = BOARD_FAILED;
-		retval = -ENXIO;
-		goto failed0;
+	rc = request_irq(brd->irq, brd->bd_ops->intr,
+			SA_INTERRUPT|SA_SHIRQ, "JSM", brd);
+	if (rc) {
+		printk(KERN_WARNING "Failed to hook IRQ %d\n",brd->irq);
+		goto out_iounmap;
 	}
 
 	rc = jsm_tty_init(brd);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Can't init tty devices (%d)\n", rc);
-		brd->state = BOARD_FAILED;
 		retval = -ENXIO;
-		goto failed1;
+		goto out_free_irq;
 	}
 
 	rc = jsm_uart_port_init(brd);
 	if (rc < 0) {
+		/* XXX: leaking all resources from jsm_tty_init here! */
 		dev_err(&pdev->dev, "Can't init uart port (%d)\n", rc);
-		brd->state = BOARD_FAILED;
 		retval = -ENXIO;
-		goto failed1;
+		goto out_free_irq;
 	}
 
-	brd->state = BOARD_READY;
-	brd->dpastatus = BD_RUNNING;
-
 	/* Log the information about the board */
-	dev_info(&pdev->dev, "board %d: %s (rev %d), irq %d\n",adapter_count, brd->name, brd->rev, brd->irq);
+	dev_info(&pdev->dev, "board %d: Digi Neo (rev %d), irq %d\n",
+			adapter_count, brd->rev, brd->irq);
 
 	/*
 	 * allocate flip buffer for board.
@@ -249,156 +156,91 @@ static int jsm_found_board(struct pci_de
 	 */
 	brd->flipbuf = kmalloc(MYFLIPLEN, GFP_KERNEL);
 	if (!brd->flipbuf) {
+		/* XXX: leaking all resources from jsm_tty_init and
+		 	jsm_uart_port_init here! */
 		dev_err(&pdev->dev, "memory allocation for flipbuf failed\n");
-		brd->state = BOARD_FAILED;
 		retval = -ENOMEM;
-		goto failed1;
+		goto out_free_irq;
 	}
 	memset(brd->flipbuf, 0, MYFLIPLEN);
 
-	jsm_create_driver_sysfiles(pdev->dev.driver);
+	pci_set_drvdata(pdev, brd);
 
-	wake_up_interruptible(&brd->state_wait);
 	return 0;
-failed1:
+ out_free_irq:
 	free_irq(brd->irq, brd);
-failed0:
-	kfree(brd);
+ out_iounmap:
 	iounmap(brd->re_map_membase);
-	return retval;
-}
-
-/* returns count (>= 0), or negative on error */
-static int jsm_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
-{
-	int rc;
-
-	rc = pci_enable_device(pdev);
-	if (rc) {
-		dev_err(&pdev->dev, "Device enable FAILED\n");
-		return rc;
-	}
-
-	if ((rc = pci_request_regions(pdev, "jsm"))) {
-	dev_err(&pdev->dev, "pci_request_region FAILED\n");
-		pci_disable_device(pdev);
-		return rc;
-	}
-
-	if ((rc = jsm_found_board(pdev, ent->driver_data))) {
-		dev_err(&pdev->dev, "jsm_found_board FAILED\n");
-		pci_release_regions(pdev);
-		pci_disable_device(pdev);
-	 	return rc;
-	}
+ out_kfree_brd:
+	kfree(brd);
+ out_release_regions:
+	pci_release_regions(pdev);
+ out_disable_device:
+	pci_disable_device(pdev);
+ out:
 	return rc;
 }
 
-
-/*
- * jsm_cleanup_board()
- *
- * Free all the memory associated with a board
- */
-static void jsm_cleanup_board(struct jsm_board *brd)
+static void jsm_remove_one(struct pci_dev *pdev)
 {
+	struct jsm_board *brd = pci_get_drvdata(pdev);
 	int i = 0;
 
+	jsm_remove_uart_port(brd);
+
 	free_irq(brd->irq, brd);
 	iounmap(brd->re_map_membase);
 
 	/* Free all allocated channels structs */
 	for (i = 0; i < brd->maxports; i++) {
 		if (brd->channels[i]) {
-			if (brd->channels[i]->ch_rqueue)
-				kfree(brd->channels[i]->ch_rqueue);
-			if (brd->channels[i]->ch_equeue)
-				kfree(brd->channels[i]->ch_equeue);
-			if (brd->channels[i]->ch_wqueue)
-				kfree(brd->channels[i]->ch_wqueue);
+			kfree(brd->channels[i]->ch_rqueue);
+			kfree(brd->channels[i]->ch_equeue);
+			kfree(brd->channels[i]->ch_wqueue);
 			kfree(brd->channels[i]);
 		}
 	}
 
-	pci_release_regions(brd->pci_dev);
-	pci_disable_device(brd->pci_dev);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
 	kfree(brd->flipbuf);
 	kfree(brd);
 }
 
-static void jsm_remove_one(struct pci_dev *dev)
-{
-	unsigned long lock_flags;
-	struct list_head *tmp;
-	struct jsm_board *brd;
-
-	spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
-	list_for_each(tmp, &jsm_board_head) {
-		brd = list_entry(tmp, struct jsm_board,
-					jsm_board_entry);
-		if ( brd != NULL && brd->pci_dev == dev) {
-			jsm_remove_uart_port(brd);
-			jsm_cleanup_board(brd);
-			list_del(&brd->jsm_board_entry);
-			break;
-		}
-	}
-	spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
-	return;
-}
+static struct pci_device_id jsm_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9), 0, 0, 0 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI), 0, 0, 1 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45), 0, 0, 2 },
+	{ PCI_DEVICE(PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI), 0, 0, 3 },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, jsm_pci_tbl);
 
-struct pci_driver jsm_driver = {
+static struct pci_driver jsm_driver = {
 	.name		= "jsm",
-	.probe		= jsm_init_one,
 	.id_table	= jsm_pci_tbl,
+	.probe		= jsm_probe_one,
 	.remove		= __devexit_p(jsm_remove_one),
 };
 
-/*
- * jsm_init_module()
- *
- * Module load.  This is where it all starts.
- */
 static int __init jsm_init_module(void)
 {
-	int rc = 0;
-
-	printk(KERN_INFO "%s, Digi International Part Number %s\n",
-			JSM_VERSION, JSM_VERSION);
-
-	/*
-	 * Initialize global stuff
-	 */
+	int rc;
 
 	rc = uart_register_driver(&jsm_uart_driver);
-	if (rc < 0) {
-		return rc;
+	if (!rc) {
+		rc = pci_register_driver(&jsm_driver);
+		if (rc)
+			uart_unregister_driver(&jsm_uart_driver);
 	}
-
-	rc = pci_register_driver(&jsm_driver);
-	if (rc < 0) {
-		uart_unregister_driver(&jsm_uart_driver);
-		return rc;
-	}
-	jsm_driver_state = DRIVER_READY;
-
 	return rc;
 }
 
-module_init(jsm_init_module);
-
-/*
- * jsm_exit_module()
- *
- * Module unload.  This is where it all ends.
- */
 static void __exit jsm_exit_module(void)
 {
-	jsm_remove_driver_sysfiles(&jsm_driver.driver);
-
 	pci_unregister_driver(&jsm_driver);
-
 	uart_unregister_driver(&jsm_uart_driver);
 }
+
+module_init(jsm_init_module);
 module_exit(jsm_exit_module);
-MODULE_LICENSE("GPL");
diff -puN drivers/serial/jsm/jsm.h~fixup-newly-added-jsm-driver drivers/serial/jsm/jsm.h
--- 25/drivers/serial/jsm/jsm.h~fixup-newly-added-jsm-driver	2005-04-12 03:21:34.730857008 -0700
+++ 25-akpm/drivers/serial/jsm/jsm.h	2005-04-12 03:21:34.737855944 -0700
@@ -93,28 +93,6 @@ enum {
 #define JSM_VERSION	"jsm: 1.1-1-INKERNEL"
 #define JSM_PARTNUM	"40002438_A-INKERNEL"
 
-/*
- * All the possible states the driver can be while being loaded.
- */
-enum {
-	DRIVER_INITIALIZED = 0,
-	DRIVER_READY
-};
-
-/*
- * All the possible states the board can be while booting up.
- */
-enum {
-	BOARD_FAILED = 0,
-	BOARD_FOUND,
-	BOARD_READY
-};
-
-struct board_id {
-	u8 *name;
-	u32 maxports;
-};
-
 struct jsm_board;
 struct jsm_channel;
 
@@ -149,7 +127,6 @@ struct jsm_board
 	int		boardnum;	/* Board number: 0-32 */
 
 	int		type;		/* Type of board */
-	char		*name;		/* Product Name */
 	u8		rev;		/* PCI revision ID */
 	struct pci_dev	*pci_dev;
 	u32		maxports;	/* MAX ports this board can handle */
@@ -160,9 +137,6 @@ struct jsm_board
 					 * the interrupt routine from each other.
 					 */
 
-	u32		state;		/* State of card. */
-	wait_queue_head_t state_wait;	/* Place to sleep on for state change */
-
 	u32		nasync;		/* Number of ports on card */
 
 	u32		irq;		/* Interrupt request number */
@@ -181,9 +155,6 @@ struct jsm_board
 	struct jsm_channel *channels[MAXPORTS]; /* array of pointers to our channels. */
 	char		*flipbuf;	/* Our flip buffer, alloced if board is found */
 
-	u16		dpatype;	/* The board "type", as defined by DPA */
-	u16		dpastatus;	/* The board "status", as defined by DPA */
-
 	u32		bd_dividend;	/* Board/UARTs specific dividend */
 
 	struct board_ops *bd_ops;
@@ -412,12 +383,6 @@ extern struct	board_ops jsm_neo_ops;
 extern int	jsm_debug;
 extern int	jsm_rawreadok;
 
-extern int	jsm_driver_state;	/* The state of the driver	*/
-extern char	*jsm_driver_state_text[];/* Array of driver state text */
-
-extern spinlock_t jsm_board_head_lock;
-extern struct list_head jsm_board_head;
-
 /*************************************************************************
  *
  * Prototypes for non-static functions used in more than one module
@@ -431,7 +396,4 @@ void jsm_input(struct jsm_channel *ch);
 void jsm_carrier(struct jsm_channel *ch);
 void jsm_check_queue_flow_control(struct jsm_channel *ch);
 
-void jsm_create_driver_sysfiles(struct device_driver *);
-void jsm_remove_driver_sysfiles(struct device_driver *);
-
 #endif
diff -puN drivers/serial/jsm/jsm_tty.c~fixup-newly-added-jsm-driver drivers/serial/jsm/jsm_tty.c
--- 25/drivers/serial/jsm/jsm_tty.c~fixup-newly-added-jsm-driver	2005-04-12 03:21:34.731856856 -0700
+++ 25-akpm/drivers/serial/jsm/jsm_tty.c	2005-04-12 03:21:34.738855792 -0700
@@ -1012,27 +1012,3 @@ int jsm_tty_write(struct uart_port *port
 
 	return data_count;
 }
-
-static ssize_t jsm_driver_version_show(struct device_driver *ddp, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s\n", JSM_VERSION);
-}
-static DRIVER_ATTR(version, S_IRUSR, jsm_driver_version_show, NULL);
-
-static ssize_t jsm_driver_state_show(struct device_driver *ddp, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%s\n", jsm_driver_state_text[jsm_driver_state]);
-}
-static DRIVER_ATTR(state, S_IRUSR, jsm_driver_state_show, NULL);
-
-void jsm_create_driver_sysfiles(struct device_driver *driverfs)
-{
-	driver_create_file(driverfs, &driver_attr_version);
-	driver_create_file(driverfs, &driver_attr_state);
-}
-
-void jsm_remove_driver_sysfiles(struct device_driver *driverfs)
-{
-	driver_remove_file(driverfs, &driver_attr_version);
-	driver_remove_file(driverfs, &driver_attr_state);
-}
_
