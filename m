Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbVCLNHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbVCLNHi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 08:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVCLNHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 08:07:37 -0500
Received: from coderock.org ([193.77.147.115]:39122 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261888AbVCLNGw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 08:06:52 -0500
Date: Sat, 12 Mar 2005 14:06:37 +0100
From: Domen Puncer <domen@coderock.org>
To: Wen Xiong <wendyx@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [ patch 1/5] drivers/serial/jsm: new serial device driver
Message-ID: <20050312130637.GA8272@nd47.coderock.org>
References: <20050304220116.GA1201@kroah.com> <422CD9DB.10103@us.ltcfwd.linux.ibm.com> <20050308064424.GF17022@kroah.com> <422DF525.8030606@us.ltcfwd.linux.ibm.com> <20050308235807.GA11807@kroah.com> <422F1A8A.4000106@us.ltcfwd.linux.ibm.com> <20050309163518.GC25079@kroah.com> <422F2FDD.4050908@us.ltcfwd.linux.ibm.com> <20050309185800.GA27268@kroah.com> <4231B972.5070203@us.ltcfwd.linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4231B972.5070203@us.ltcfwd.linux.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just some nitpicking...

On 11/03/05 10:29 -0500, Wen Xiong wrote:
> + * Globals
> + */
> +int		jsm_driver_state = DRIVER_INITIALIZED;
> +spinlock_t	jsm_board_head_lock = SPIN_LOCK_UNLOCKED;

DEFINE_SPINLOCK()

> +LIST_HEAD(jsm_board_head);
> +
> +static struct pci_device_id jsm_pci_tbl[] = {
> +	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9),	0,	0,	0 },
> +	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2DB9PRI),	0,	0,	1 },
> +	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45),	0,	0,	2 },
> +	{ PCI_DEVICE (PCI_VENDOR_ID_DIGI, PCI_DEVICE_ID_NEO_2RJ45PRI),	0,	0,	3 },
> +	{ 0,}						/* 0 terminated list. */
> +};
> +MODULE_DEVICE_TABLE(pci, jsm_pci_tbl);
> +
> +static struct board_id jsm_Ids[] = {	

Trailing whitespace.

> +	{ PCI_DEVICE_NEO_2DB9_PCI_NAME,		2 },
> +	{ PCI_DEVICE_NEO_2DB9PRI_PCI_NAME,	2 },
> +	{ PCI_DEVICE_NEO_2RJ45_PCI_NAME,	2 },
> +	{ PCI_DEVICE_NEO_2RJ45PRI_PCI_NAME,	2 },
> +	{ NULL,					0 }
> +};
> +
> +char *jsm_driver_state_text[] = {
> +	"Driver Initialized",
> +	"Driver Ready."
> +};
> +
> +static int jsm_finalize_board_init(struct jsm_board *brd) 

Trailing whitespace.

> +{
> +	int rc = 0;
> +
> +	jsm_printk(INIT, INFO, &brd->pci_dev, "start\n");
> +
> +	if (brd->irq) {
> +		rc = request_irq(brd->irq, brd->bd_ops->intr, SA_INTERRUPT|SA_SHIRQ, "JSM", brd);
> +
> +		if (rc) {
> +			printk(KERN_WARNING "Failed to hook IRQ %d\n",brd->irq);
> +			brd->state = BOARD_FAILED;
> +			brd->dpastatus = BD_NOFEP;
> +			rc = -ENODEV;
> +		} else
> +			jsm_printk(INIT, INFO, &brd->pci_dev,
> +				"Requested and received usage of IRQ %d\n", brd->irq);
> +	}
> +	return rc;
> +}
> +
> +/*
> + * jsm_found_board()
> + *
> + * A board has been found, init it.
> + */
> +static int jsm_found_board(struct pci_dev *pdev, int id)
> +{
> +	struct jsm_board *brd;
> +	int i = 0;
> +	int rc = 0;
> +	struct list_head *tmp;
> +	struct jsm_board *cur_board_entry;
> +	unsigned long lock_flags;
> +	int adapter_count = 0;
> +
> +	brd = (struct jsm_board *)kmalloc(sizeof(struct jsm_board), GFP_KERNEL);

Don't cast void pointers.

> +	if (!brd) {
> +		dev_err(&pdev->dev, "memory allocation for board structure failed\n");
> +		return -ENOMEM;
> +	}
> +	memset(brd, 0, sizeof(struct jsm_board));

sizeof(*brd)?

> +
> +	spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
> +	list_for_each(tmp, &jsm_board_head) {
> +		cur_board_entry = 
> +			list_entry(tmp, struct jsm_board,
> +				jsm_board_entry);

list_for_each_entry would make it shorter.

> +		if (cur_board_entry->boardnum != adapter_count) {
> +			break;
> +		}
> +		adapter_count++;
> +	}
> +
> +	list_add_tail(&brd->jsm_board_entry, &jsm_board_head);
> +	spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
> +
> +	/* store the info for the board we've found */
> +	brd->boardnum = adapter_count;
> +	brd->pci_dev = pdev;
> +	brd->name = jsm_Ids[id].name;
> +	brd->maxports = jsm_Ids[id].maxports;
> +	brd->dpastatus = BD_NOFEP;
> +	init_waitqueue_head(&brd->state_wait);
> +
> +	spin_lock_init(&brd->bd_lock);
> +	spin_lock_init(&brd->bd_intr_lock);
> +
> +	brd->state = BOARD_FOUND;
> +
> +	for (i = 0; i < brd->maxports; i++) 

Trailing whitespace.

> +		brd->channels[i] = NULL;
> +
> +	/* store which revision we have */
> +	pci_read_config_byte(pdev, PCI_REVISION_ID, &brd->rev);
> +
> +	brd->irq = pdev->irq;
> +
> +	switch(brd->pci_dev->device) {
> +
> +	case PCI_DEVICE_ID_NEO_2DB9:
> +	case PCI_DEVICE_ID_NEO_2DB9PRI:
> +	case PCI_DEVICE_ID_NEO_2RJ45:
> +	case PCI_DEVICE_ID_NEO_2RJ45PRI:
> +
> +		/*
> +		 * This chip is set up 100% when we get to it.
> +		 * No need to enable global interrupts or anything. 
> +		 */
> +		brd->dpatype = T_NEO | T_PCIBUS;
> +
> +		jsm_printk(INIT, INFO, &brd->pci_dev,
> +			"jsm_found_board - NEO adapter\n");
> +
> +		/* get the PCI Base Address Registers */
> +		brd->membase	= pci_resource_start(pdev, 0);
> +		brd->membase_end = pci_resource_end(pdev, 0);
> +
> +		if (brd->membase & 1)
> +			brd->membase &= ~3;
> +		else
> +			brd->membase &= ~15;
> +
> +		/* Assign the board_ops struct */
> +		brd->bd_ops = &jsm_neo_ops;
> +
> +		brd->bd_uart_offset = 0x200;
> +		brd->bd_dividend = 921600;
> +
> +		brd->re_map_membase = ioremap(brd->membase, 0x1000);
> +		jsm_printk(INIT, INFO, &brd->pci_dev,
> +			"remapped mem: 0x%p\n", brd->re_map_membase);
> +		if (!brd->re_map_membase) {
> +			kfree(brd);
> +			dev_err(&pdev->dev, "card has no PCI Memory resources, failing board.\n");
> +			return -ENOMEM;
> +		}
> +		break;
> +
> +	default:
> +		dev_err(&pdev->dev, "Did not find any compatible Neo or Classic PCI boards in system.\n");
> +		kfree(brd);
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Do tty device initialization.
> +	 */
> +	rc = jsm_finalize_board_init(brd);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "Can't finalize board init (%d)\n", rc);
> +		brd->state = BOARD_FAILED;
> +		brd->dpastatus = BD_NOFEP;

I think it's already initialized to this.

> +		goto failed;
> +	}
> +
> +	rc = jsm_tty_init(brd);
> +	if (rc < 0) {
> +		dev_err(&pdev->dev, "Can't init tty devices (%d)\n", rc);
> +		brd->state = BOARD_FAILED;
> +		brd->dpastatus = BD_NOFEP;

Same here.

> +		free_irq(brd->irq, brd);
> +		goto failed;
> +	}
> +
> +	rc = jsm_uart_port_init(brd);
> +	if (rc < 0) {
> +		free_irq(brd->irq, brd);

Another label above "failed", that includes free_irq could be nicer.
Also... is brd->state == BOARD_FOUND intended here?

> +		goto failed;
> +	}
> +
> +	brd->state = BOARD_READY;
> +	brd->dpastatus = BD_RUNNING;
> +
> +	/* Log the information about the board */
> +	dev_info(&pdev->dev, "board %d: %s (rev %d), irq %d\n",adapter_count, brd->name, brd->rev, brd->irq);
> +
> +	/*
> +	 * allocate flip buffer for board.
> +	 *
> +	 * Okay to malloc with GFP_KERNEL, we are not at interrupt
> +	 * context, and there are no locks held.
> +	 */
> +	brd->flipbuf = kmalloc(MYFLIPLEN, GFP_KERNEL);
> +	if (!brd->flipbuf) {
> +		dev_err(&pdev->dev, "memory allocation for flipbuf failed\n");
> +		free_irq(brd->irq, brd);
> +		kfree(brd);
> +		iounmap((void *) brd->re_map_membase);
> +		return -ENOMEM;

Hmm... set retval and goto same?

> +	}
> +	memset(brd->flipbuf, 0, MYFLIPLEN);
> +
> +	jsm_create_driver_sysfiles(pdev->dev.driver);
> +
> +	wake_up_interruptible(&brd->state_wait);
> +	return 0;
> +
> +failed:
> +	kfree(brd);
> +	iounmap((void *) brd->re_map_membase);

Cast not needed, i believe.

> +	return -ENXIO;
> +}
> +
> +/* returns count (>= 0), or negative on error */
> +static int jsm_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	int rc;
> +
> +	rc = pci_enable_device(pdev);
> +	if (rc) {
> +		dev_err(&pdev->dev, "Device enable FAILED\n");
> +		return rc;
> +	} 

Trailing whitespace.

> +
> +	if ((rc = pci_request_regions(pdev, "jsm"))) {

JSM_DRIVER_NAME?

> +	dev_err(&pdev->dev, "pci_request_region FAILED\n");
> +		pci_disable_device(pdev);
> +		return rc;
> +	}
> +
> +	if ((rc = jsm_found_board(pdev, ent->driver_data))) {
> +		dev_err(&pdev->dev, "jsm_found_board FAILED\n");
> +		pci_release_regions(pdev);
> +		pci_disable_device(pdev);
> +	 	return rc;
> +	}
> +	return rc;
> +}
> +
> +
> +/*
> + * jsm_cleanup_board()
> + *
> + * Free all the memory associated with a board
> + */
> +static void jsm_cleanup_board(struct jsm_board *brd)
> +{
> +	int i = 0;
> +
> +	free_irq(brd->irq, brd);
> +	iounmap(brd->re_map_membase);
> +
> +	/* Free all allocated channels structs */
> +	for (i = 0; i < brd->maxports; i++) {
> +		if (brd->channels[i]) {
> +			if (brd->channels[i]->ch_rqueue)
> +				kfree(brd->channels[i]->ch_rqueue);
> +			if (brd->channels[i]->ch_equeue)
> +				kfree(brd->channels[i]->ch_equeue);
> +			if (brd->channels[i]->ch_wqueue)
> +				kfree(brd->channels[i]->ch_wqueue);

kfree() handles NULL just fine.

> +
> +			kfree(brd->channels[i]);
> +			brd->channels[i] = NULL;
> +		}
> +	}
> +
> +	pci_release_regions(brd->pci_dev);
> +	pci_disable_device(brd->pci_dev);
> +	kfree(brd->flipbuf);
> +	kfree(brd);
> +}
> +
> +static void jsm_remove_one(struct pci_dev *dev)
> +{
> +	unsigned long lock_flags;
> +	struct list_head *tmp;
> +	struct jsm_board *brd;
> +
> +	spin_lock_irqsave(&jsm_board_head_lock, lock_flags);
> +	list_for_each(tmp, &jsm_board_head) {

list_for_each_entry_safe?

> +		brd = list_entry(tmp, struct jsm_board,
> +					jsm_board_entry);
> +		if ( brd != NULL && brd->pci_dev == dev) {
> +			jsm_remove_uart_port(brd);
> +			jsm_cleanup_board(brd);
> +			list_del(&brd->jsm_board_entry);
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&jsm_board_head_lock, lock_flags);
> +	return;
> +}
> +
> +struct pci_driver jsm_driver = {
> +	.name		= "jsm",

JSM_DRIVER_NAME?

> +	.probe		= jsm_init_one,
> +	.id_table	= jsm_pci_tbl,
> +	.remove		= __devexit_p(jsm_remove_one),
> +};
> +
> +/*
> + * jsm_init_module()
> + *
> + * Module load.  This is where it all starts.
> + */
> +static int __init
> +jsm_init_module(void)

Only last two routines have return type in separate line.

> +{
> +	int rc = 0;
> +
> +	printk(KERN_INFO "%s, Digi International Part Number %s\n",
> +			JSM_VERSION, JSM_VERSION);

??

> +
> +	/*
> +	 * Initialize global stuff
> +	 */
> +
> +	rc = uart_register_driver(&jsm_uart_driver);
> +	if (rc < 0) {
> +		return rc;
> +	}
> +
> +	rc = pci_register_driver(&jsm_driver);
> +	if (rc < 0) {
> +		uart_unregister_driver(&jsm_uart_driver);
> +		return rc;
> +	}
> +	jsm_driver_state = DRIVER_READY;
> +
> +	return rc;
> +}
> +
> +module_init(jsm_init_module);
> +
> +/*
> + * jsm_exit_module()
> + *
> + * Module unload.  This is where it all ends.
> + */
> +static void __exit
> +jsm_exit_module(void)
> +{
> +	jsm_remove_driver_sysfiles(&(jsm_driver.driver));

No need for ().

> +
> +	pci_unregister_driver(&jsm_driver);
> +
> +	uart_unregister_driver(&jsm_uart_driver);
> +}
> +module_exit(jsm_exit_module);
> +MODULE_LICENSE("GPL");

