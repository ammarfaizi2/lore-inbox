Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVB1AYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVB1AYv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVB1AYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:24:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35470 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261205AbVB1ATm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:19:42 -0500
Message-ID: <42226387.3090702@pobox.com>
Date: Sun, 27 Feb 2005 19:19:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wen Xiong <wendyx@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [ patch 1/7] drivers/serial/jsm: new serial device driver
References: <422259EF.90104@us.ltcfwd.linux.ibm.com>
In-Reply-To: <422259EF.90104@us.ltcfwd.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Xiong wrote:


General comment:  This driver has -way- too many global variables.

Normal drivers should associate state information with each instance of 
a device (e.g. each struct pci_dev), not globally.


> +/*
> + * Globals
> + */
> +uint		jsm_NumBoards,current_NumBoards;
> +struct board_t	*jsm_Board[MAXBOARDS];
> +char		*jsm_board_slot[MAXBOARDS];
> +spinlock_t	jsm_global_lock = SPIN_LOCK_UNLOCKED;
> +int		jsm_driver_state = DRIVER_INITIALIZED;
> +ulong		jsm_poll_counter;
> +uint		jsm_Major;
> +int		jsm_debug;
> +int		jsm_rawreadok;
> +int		jsm_trcbuf_size;

Eliminate MAXBOARDS.  Such static limits are completely unnecessary.


> +/*
> + * Static vars.
> + */
> +static uint	jsm_major_control_registered = FALSE;
> +static uint	jsm_driver_start = FALSE;

Eliminate jsm_driver_start.  This is unnecessary also.



> +/*
> + * Poller stuff
> + */
> +static spinlock_t	jsm_poll_lock = SPIN_LOCK_UNLOCKED;
> +static ulong		jsm_poll_time;				/* Time of next poll */
> +static ulong		jsm_poll_tick = 50;			/* Poll interval - 20 ms */
> +
> +static struct timer_list jsm_poll_timer = {
> +	.function =	jsm_poll_handler
> +};
> +
> +static struct pci_device_id jsm_pci_tbl[] = {
> +	{	DIGI_VID, PCI_DEVICE_NEO_4_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,		0 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_8_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,		1 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2DB9_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	2 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2DB9PRI_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	3 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2RJ45_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	4 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2RJ45PRI_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	5 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_1_422_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	6 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_1_422_485_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	7 },
> +	{	DIGI_VID, PCI_DEVICE_NEO_2_422_485_DID, PCI_ANY_ID, PCI_ANY_ID, 0, 0,	8 },
> +	{0,}						/* 0 terminated list. */

Don't create your own constants, use standard linux/pci_ids.h ones.


> +MODULE_DEVICE_TABLE(pci, jsm_pci_tbl);
> +
> +struct board_id {
> +	uchar *name;
> +	uint maxports;
> +};
> +
> +static struct board_id jsm_Ids[] = {	
> +	{	PCI_DEVICE_NEO_4_PCI_NAME,		4	},
> +	{	PCI_DEVICE_NEO_8_PCI_NAME,		8	},
> +	{	PCI_DEVICE_NEO_2DB9_PCI_NAME,		2	},
> +	{	PCI_DEVICE_NEO_2DB9PRI_PCI_NAME,	2	},
> +	{	PCI_DEVICE_NEO_2RJ45_PCI_NAME,		2	},
> +	{	PCI_DEVICE_NEO_2RJ45PRI_PCI_NAME,	2	},
> +	{	PCI_DEVICE_NEO_1_422_PCI_NAME,		1	},
> +	{	PCI_DEVICE_NEO_1_422_485_PCI_NAME,	1	},
> +	{	PCI_DEVICE_NEO_2_422_485_PCI_NAME,	2	},
> +	{	NULL,					0	}
> +};
> +
> +struct pci_driver jsm_driver = {
> +	.name		= "jsm",
> +	.probe		= jsm_init_one,
> +	.id_table	= jsm_pci_tbl,
> +	.remove		= __devexit_p(jsm_remove_one),
> +};
> +
> +char *jsm_state_text[] = {
> +	"Board Failed",
> +	"Board Found",
> +	"Board READY",
> +};
> +
> +char *jsm_driver_state_text[] = {
> +	"Driver Initialized",
> +	"Driver Ready."
> +};
> +
> +/*
> + * jsm_init_globals()
> + *
> + * This is where we initialize the globals from the static insmod
> + * configuration variables.  These are declared near the head of
> + * this file.
> + */
> +static void jsm_init_globals(void)
> +{
> +	int i = 0;
> +
> +	jsm_rawreadok		= rawreadok;
> +	jsm_trcbuf_size		= trcbuf_size;
> +	jsm_debug		= debug;
> +
> +	for (i = 0; i < MAXBOARDS; i++) {
> +		jsm_Board[i] = NULL;
> +		jsm_board_slot[i] = (char *)kmalloc(20, GFP_KERNEL);
> +		memset(jsm_board_slot[i], 0, 20);
> +	}
> +
> +	init_timer(&jsm_poll_timer);
> +}

When MAXBOARDS is eliminated, and the poll timer is made per-device, 
this code will go away.


> +/*
> + * jsm_poll_handler
> + *
> + *	As each timer expires, it determines (a) whether the "transmit"
> + * waiter needs to be woken up, and (b) whether the poller needs to
> + * be rescheduled.
> + */
> +static void jsm_poll_handler(ulong dummy)
> +{
> +	struct board_t *brd;
> +	unsigned long lock_flags;
> +	int i;
> +
> +	jsm_poll_counter++;
> +
> +	/*
> +	 * Do not start the board state machine until
> +	 * driver tells us its up and running, and has
> +	 * everything it needs.
> +	 */
> +	if (jsm_driver_state != DRIVER_READY)
> +		goto schedule_poller;
> +
> +	/* Go thru each board, kicking off a tasklet for each if needed */
> +	for (i = 0; i < jsm_NumBoards; i++) {
> +		if (jsm_Board[i] == NULL) continue;
> +		brd = jsm_Board[i];
> +
> +		spin_lock_irqsave(&brd->bd_lock, lock_flags);
> +
> +		/* If board is in a failed state, don't bother scheduling a tasklet */
> +		if (brd->state == BOARD_FAILED) {
> +			spin_lock_irqsave(&brd->bd_lock, lock_flags);
> +			continue;
> +		}
> +
> +		spin_unlock_irqrestore(&brd->bd_lock, lock_flags);
> +	}
> +
> +schedule_poller:
> +
> +	/*
> +	 * Schedule ourself back at the nominal wakeup interval.
> +	 */
> +	if (current_NumBoards >= 0) {
> +		ulong time;
> +
> +		spin_lock_irqsave(&jsm_poll_lock, lock_flags);
> +		jsm_poll_time += jsm_jiffies_from_ms(jsm_poll_tick);
> +
> +		time = jsm_poll_time - jiffies;
> +
> +		if ((ulong) time >= 2 * jsm_poll_tick)
> +			jsm_poll_time = jiffies +  jsm_jiffies_from_ms(jsm_poll_tick);
> +
> +		jsm_poll_timer.expires = jsm_poll_time;
> +		spin_unlock_irqrestore(&jsm_poll_lock, lock_flags);
> +
> +		add_timer(&jsm_poll_timer);
> +	}
> +}

Don't use a single timer for all boards.  This makes information 
needlessly global.


> +/*
> + * Start of driver.
> + */
> +static int jsm_start(void)
> +{
> +	int rc = 0;
> +	unsigned long lock_flags;
> +
> +	if (!jsm_driver_start) {
> +		jsm_driver_start = TRUE;

As noted earlier, jsm_driver_start is completely pointless.

jsm_start() is the first function called in module_init(), and is never 
called from anywhere else.


> +		/* make sure that the globals are init'd before we do anything else */
> +		jsm_init_globals();
> +		jsm_NumBoards = 0;
> +		current_NumBoards = -1;
> +
> +		APR(("For the tools package or updated drivers please visit http://www.digi.com\n"));
> +
> +		/*
> +		 * Register our base character device into the kernel.
> +		 * This allows the download daemon to connect to the downld device
> +		 * before any of the boards are init'ed.
> +		 */
> +		if (!jsm_major_control_registered) {
> +			/*
> +			 * Register management/dpa devices
> +			 */
> +			rc = register_chrdev(0, "jsm", &jsm_BoardFops);
> +			if (rc <= 0) {
> +				APR(("Can't register jsm driver device (%d)\n", rc));
> +				return -ENXIO;
> +			}
> +			jsm_Major = rc;
> +			jsm_major_control_registered = TRUE;
> +		}
> +
> +		/*
> +		 * Register our basic stuff in /proc/jsm
> +		 */
> +		jsm_proc_register_basic_prescan();
> +
> +		if (rc < 0) {
> +			APR(("tty preinit - not enough memory (%d)\n", rc));
> +			return rc;
> +		}

Why is this not in sysfs?


> +		/* Start the poller */
> +		spin_lock_irqsave(&jsm_poll_lock, lock_flags);
> +		jsm_poll_time = jiffies + jsm_jiffies_from_ms(jsm_poll_tick);
> +		jsm_poll_timer.expires = jsm_poll_time;
> +		spin_unlock_irqrestore(&jsm_poll_lock, lock_flags);
> +
> +		add_timer(&jsm_poll_timer);

It's silly to add a timer and start polling, when you have nothing to poll.

But that's ok... this code will go away when the poll timer is made 
per-device.


> +		jsm_driver_state = DRIVER_READY;
> +	}
> +	return rc;
> +}
> +
> +static int jsm_finalize_board_init(struct board_t *brd) 
> +{
> +	int rc = 0;
> +
> +	DPR_INIT(("jsm_finalize_board_init() - start\n"));
> +
> +	if (!brd || brd->magic != JSM_BOARD_MAGIC)
> +		return -ENODEV;
> +
> +	DPR_INIT(("jsm_finalize_board_init() - start #2\n"));
> +
> +	if (brd->irq) {
> +		rc = request_irq(brd->irq, brd->bd_ops->intr, SA_INTERRUPT|SA_SHIRQ, "JSM", brd);
> +
> +		if (rc) {
> +			printk(KERN_WARNING "Failed to hook IRQ %d\n",brd->irq);
> +			brd->state = BOARD_FAILED;
> +			brd->dpastatus = BD_NOFEP;
> +			rc = -ENODEV;
> +		} else {
> +			DPR_INIT(("Requested and received usage of IRQ %d\n", brd->irq));
> +		}
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
> +	struct board_t *brd;
> +	unsigned int pci_irq;
> +	int i = 0;
> +	int rc = 0;
> +	int index;
> +	int wen_board;
> +	int hotplug = 0;
> +
> +	wen_board = jsm_NumBoards;
> +	for (index = 0; index < jsm_NumBoards; index++) {
> +		if (!strcmp(jsm_board_slot[index], pdev->slot_name)) {
> +			wen_board = index;
> +			hotplug = 1;
> +			break;
> +		}
> +	}

It is very wrong to store boards based on pdev->slot_name.

However, this goes away when more state is made per-device.



> +	brd = jsm_Board[wen_board] =
> +	(struct board_t *)kmalloc(sizeof(struct board_t), GFP_KERNEL);
> +	if (!brd) {
> +		APR(("memory allocation for board structure failed\n"));
> +		return -ENOMEM;
> +	}
> +	memset(brd, 0, sizeof(struct board_t));
> +
> +	/* store the info for the board we've found */
> +	brd->magic = JSM_BOARD_MAGIC;
> +	brd->boardnum = wen_board;
> +	brd->vendor = jsm_pci_tbl[id].vendor;
> +	brd->device = jsm_pci_tbl[id].device;
> +	brd->pci_bus = pdev->bus->number;
> +	brd->pci_slot = PCI_SLOT(pdev->devfn);

You should not need this information.


> +	brd->pci_dev = pdev;
> +	brd->name = jsm_Ids[id].name;
> +	brd->maxports = jsm_Ids[id].maxports;
> +	brd->dpastatus = BD_NOFEP;
> +	strcpy(jsm_board_slot[wen_board],pdev->slot_name);
> +	init_waitqueue_head(&brd->state_wait);
> +
> +	spin_lock_init(&brd->bd_lock);
> +	spin_lock_init(&brd->bd_intr_lock);
> +
> +	brd->state = BOARD_FOUND;
> +
> +	for (i = 0; i < MAXPORTS; i++) 
> +		brd->channels[i] = NULL;
> +
> +	/* store which card & revision we have */
> +	pci_read_config_word(pdev, PCI_SUBSYSTEM_VENDOR_ID, &brd->subvendor);
> +	pci_read_config_word(pdev, PCI_SUBSYSTEM_ID, &brd->subdevice);

Obtain this information from struct pci_dev.  Do not read it manually.


> +	pci_irq = pdev->irq;
> +	brd->irq = pci_irq;
> +
> +	switch(brd->device) {
> +
> +	case PCI_DEVICE_NEO_4_DID:
> +	case PCI_DEVICE_NEO_8_DID:
> +	case PCI_DEVICE_NEO_2DB9_DID:
> +	case PCI_DEVICE_NEO_2DB9PRI_DID:
> +	case PCI_DEVICE_NEO_2RJ45_DID:
> +	case PCI_DEVICE_NEO_2RJ45PRI_DID:
> +	case PCI_DEVICE_NEO_1_422_DID:
> +	case PCI_DEVICE_NEO_1_422_485_DID:
> +	case PCI_DEVICE_NEO_2_422_485_DID:

use standard pci_ids.h constants.


> +		/*
> +		 * This chip is set up 100% when we get to it.
> +		 * No need to enable global interrupts or anything. 
> +		 */
> +		brd->dpatype = T_NEO | T_PCIBUS;
> +
> +		DPR_INIT(("jsm_found_board - NEO.\n"));
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
> +		DPR_INIT(("remapped mem: 0x%p\n", brd->re_map_membase));
> +		if (!brd->re_map_membase) {
> +			kfree(brd);
> +			APR(("card has no PCI Memory resources, failing board.\n"));
> +			return -ENOMEM;
> +		}
> +		break;
> +
> +	default:
> +		APR(("Did not find any compatible Neo or Classic PCI boards in system.\n"));
> +		kfree(brd);
> +		return -ENXIO;
> +	}
> +
> +	/*
> +	 * Do tty device initialization.
> +	 */
> +	rc = jsm_finalize_board_init(brd);
> +	if (rc < 0) {
> +		APR(("Can't finalize board init (%d)\n", rc));
> +		brd->state = BOARD_FAILED;
> +		brd->dpastatus = BD_NOFEP;
> +		goto failed;
> +	}
> +
> +	rc = jsm_tty_register(brd);
> +	if (rc < 0) {
> +		jsm_tty_uninit(brd);
> +		APR(("Can't register tty devices (%d)\n", rc));
> +		brd->state = BOARD_FAILED;
> +		brd->dpastatus = BD_NOFEP;
> +		goto failed;
> +	}
> +
> +	rc = jsm_tty_init(brd);
> +	if (rc < 0) {
> +		jsm_tty_uninit(brd);
> +		APR(("Can't init tty devices (%d)\n", rc));
> +		brd->state = BOARD_FAILED;
> +		brd->dpastatus = BD_NOFEP;
> +		goto failed;
> +	}
> +
> +	rc = jsm_uart_port_init(brd);
> +	if (rc < 0)
> +		goto failed;
> +
> +	brd->state = BOARD_READY;
> +	brd->dpastatus = BD_RUNNING;
> +
> +	/* init our poll helper tasklet */
> +	tasklet_init(&brd->helper_tasklet, brd->bd_ops->tasklet, (unsigned long) brd);
> +
> +	/* Log the information about the board */
> +	APR(("board %d: %s (rev %d), irq %d\n",wen_board, brd->name, brd->rev, brd->irq));
> +
> +	/*
> +	 * allocate flip buffer for board.
> +	 *
> +	 * Okay to malloc with GFP_KERNEL, we are not at interrupt
> +	 * context, and there are no locks held.
> +	 */
> +	brd->flipbuf = kmalloc(MYFLIPLEN, GFP_KERNEL);
> +	if (!brd->flipbuf) {
> +		APR(("memory allocation for flipbuf failed\n"));
> +		return -ENOMEM;
> +	}

leak on error


> +	memset(brd->flipbuf, 0, MYFLIPLEN);
> +
> +	jsm_proc_register_basic_postscan(wen_board);
> +	wake_up_interruptible(&brd->state_wait);
> +
> +	if (!hotplug)
> +		jsm_NumBoards++;
> +
> +	current_NumBoards++;
> +
> +	return 0;
> +
> +failed:
> +	kfree(brd);
> +	iounmap((void *) brd->re_map_membase);
> +	return -ENXIO;
> +}
> +
> +
> +static int jsm_probe1(struct pci_dev *pdev, int card_type)
> +{
> +	return jsm_found_board(pdev, card_type);
> +}

eliminate this needless function.


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
> +
> +	if ((rc = jsm_probe1(pdev, ent->driver_data))) {
> +		dev_err(&pdev->dev, "jsm_probe1 FAILED\n");
> +		pci_disable_device(pdev);
> +	 	return rc;
> +	}
> +	return rc;
> +}

Missing pci_request_regions().


> +/*
> + * jsm_cleanup_board()
> + *
> + * Free all the memory associated with a board
> + */
> +static void jsm_cleanup_board(struct board_t *brd)
> +{
> +	int i = 0;
> +
> +	if (!brd || brd->magic != JSM_BOARD_MAGIC)
> +		return ;
> +
> +	if (brd->irq)
> +		free_irq(brd->irq, brd);
> +
> +	tasklet_kill(&brd->helper_tasklet);
> +
> +	if (brd->re_map_membase) {
> +		iounmap(brd->re_map_membase);
> +		brd->re_map_membase = NULL;
> +	}

When will this 'if' test ever fail?


> +	/* Free all allocated channels structs */
> +	for (i = 0; i < MAXPORTS; i++) {
> +		if (brd->channels[i]) {
> +			if (brd->channels[i]->ch_rqueue)
> +				kfree(brd->channels[i]->ch_rqueue);
> +			if (brd->channels[i]->ch_equeue)
> +				kfree(brd->channels[i]->ch_equeue);
> +			if (brd->channels[i]->ch_wqueue)
> +				kfree(brd->channels[i]->ch_wqueue);
> +
> +			kfree(brd->channels[i]);
> +			brd->channels[i] = NULL;
> +		}
> +	}
> +
> +	if (brd->flipbuf)
> +		kfree(brd->flipbuf);
> +
> +	jsm_Board[brd->boardnum] = NULL;
> +
> +	kfree(brd);
> +	current_NumBoards--;
> +}
> +
> +static void jsm_remove_one(struct pci_dev *dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < jsm_NumBoards; i++) {
> +		if ((jsm_Board[i] != NULL) && (jsm_Board[i]->pci_dev == dev)) {
> +			jsm_proc_unregister_brd(i);
> +			jsm_remove_uart_port(jsm_Board[i]);
> +			jsm_tty_uninit(jsm_Board[i]);
> +			jsm_cleanup_board(jsm_Board[i]);
> +		}
> +	}
> +}

pci_disable_device(), pci_release_regions()


> +/*
> + * jsm_init_module()
> + *
> + * Module load.  This is where it all starts.
> + */
> +static int __init
> +jsm_init_module(void)
> +{
> +	int rc = 0;
> +
> +	APR(("%s, Digi International Part Number %s\n", "jsm: 1.1-1-INKERNEL", "40002438_A-INKERNEL"));
> +
> +	/*
> +	 * Initialize global stuff
> +	 */
> +	rc = jsm_start();
> +	if (rc < 0) 
> +		return rc;
> +
> +	rc = uart_register_driver(&jsm_uart_driver);
> +	if (rc)
> +		return rc;

leak on error


> +	rc = pci_register_driver(&jsm_driver);
> +	if (rc < 0)
> +		uart_unregister_driver(&jsm_uart_driver);

leak on error


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
> +	int i;
> +
> +	del_timer_sync(&jsm_poll_timer);
> +
> +	if (jsm_major_control_registered)
> +		unregister_chrdev(jsm_Major, "jsm");
> +
> +	pci_unregister_driver(&jsm_driver);
> +
> +	jsm_proc_unregister_all();
> +
> +	for (i = 0; i < MAXBOARDS; i++) {
> +		jsm_board_slot[i] = NULL;
> +		kfree(jsm_board_slot[i]);
> +	}
> +	uart_unregister_driver(&jsm_uart_driver);
> +}
> +module_exit(jsm_exit_module);
> +MODULE_LICENSE("GPL");
> +
> +/*
> + * jsm_ioctl_name()
> + *
> + * Returns a text version of each ioctl value.
> + */
> +char *jsm_ioctl_name(int cmd)
> +{
> +	switch(cmd) {
> +
> +	case TCGETA:		return("TCGETA");
> +	case TCGETS:		return("TCGETS");
> +	case TCSETA:		return("TCSETA");
> +	case TCSETS:		return("TCSETS");
> +	case TCSETAW:		return("TCSETAW");
> +	case TCSETSW:		return("TCSETSW");
> +	case TCSETAF:		return("TCSETAF");
> +	case TCSETSF:		return("TCSETSF");
> +	case TCSBRK:		return("TCSBRK");
> +	case TCXONC:		return("TCXONC");
> +	case TCFLSH:		return("TCFLSH");
> +	case TIOCGSID:		return("TIOCGSID");
> +
> +	case TIOCGETD:		return("TIOCGETD");
> +	case TIOCSETD:		return("TIOCSETD");
> +	case TIOCGWINSZ:	return("TIOCGWINSZ");
> +	case TIOCSWINSZ:	return("TIOCSWINSZ");
> +
> +	case TIOCMGET:		return("TIOCMGET");
> +	case TIOCMSET:		return("TIOCMSET");
> +	case TIOCMBIS:		return("TIOCMBIS");
> +	case TIOCMBIC:		return("TIOCMBIC");
> +
> +	/* from digi.h */
> +	case DIGI_SETA:		return("DIGI_SETA");
> +	case DIGI_SETAW:	return("DIGI_SETAW");
> +	case DIGI_SETAF:	return("DIGI_SETAF");
> +	case DIGI_SETFLOW:	return("DIGI_SETFLOW");
> +	case DIGI_SETAFLOW:	return("DIGI_SETAFLOW");
> +	case DIGI_GETFLOW:	return("DIGI_GETFLOW");
> +	case DIGI_GETAFLOW:	return("DIGI_GETAFLOW");
> +	case DIGI_GETA:		return("DIGI_GETA");
> +	case DIGI_GEDELAY:	return("DIGI_GEDELAY");
> +	case DIGI_SEDELAY:	return("DIGI_SEDELAY");
> +	case DIGI_GETCUSTOMBAUD: return("DIGI_GETCUSTOMBAUD");
> +	case DIGI_SETCUSTOMBAUD: return("DIGI_SETCUSTOMBAUD");
> +	case TIOCMODG:		return("TIOCMODG");
> +	case TIOCMODS:		return("TIOCMODS");
> +	case TIOCSDTR:		return("TIOCSDTR");
> +	case TIOCCDTR:		return("TIOCCDTR");
> +
> +	default:		return("unknown");
> +	}

Eliminate this, or make it debug-only.

	Jeff



