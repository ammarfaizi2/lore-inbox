Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbUCPRFZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 12:05:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbUCPQrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:47:48 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:57872 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263334AbUCPQfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:35:30 -0500
Date: Tue, 16 Mar 2004 10:46:42 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: cpqarray patches for 2.6 [4 of 5]
Message-ID: <20040316164642.GE21377@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 4 of 5 for cpqarray. Please apply in order.

Thanks,
mikem
-------------------------------------------------------------------------------
   - Change to use pci APIs (change from 2.4.18 to 2.4.19)
     PS: This also includes eisa detection fix during initialization
     which was missing from 2.4.19 but fixed in 2.4.25



 drivers/block/cpqarray.c |  542 +++++++++++++++++++++++++++++------------------
 1 files changed, 344 insertions(+), 198 deletions(-)

--- linux-2.6.1/drivers/block/cpqarray.c~cpqarray_pci_register	2004-02-11 18:01:15.521444648 -0600
+++ linux-2.6.1-root/drivers/block/cpqarray.c	2004-02-11 18:01:15.527443736 -0600
@@ -97,6 +97,34 @@ static struct board_type products[] = {
 	{ 0x40580E11, "Smart Array 431",	&smart4_access },
 };
 
+/* define the PCI info for the PCI cards this driver can control */
+const struct pci_device_id cpqarray_pci_device_id[] =
+{
+	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_COMPAQ_42XX,
+		0x0E11, 0x4058, 0, 0, 0},       /* SA431 */
+	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_COMPAQ_42XX,
+		0x0E11, 0x4051, 0, 0, 0},      /* SA4250ES */
+	{ PCI_VENDOR_ID_DEC, PCI_DEVICE_ID_COMPAQ_42XX,
+		0x0E11, 0x4050, 0, 0, 0},      /* SA4200 */
+	{ PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C1510,
+		0x0E11, 0x4048, 0, 0, 0},       /* LC2 */
+	{ PCI_VENDOR_ID_NCR, PCI_DEVICE_ID_NCR_53C1510,
+		0x0E11, 0x4040, 0, 0, 0},      /* Integrated Array */
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_SMART2P,
+		0x0E11, 0x4034, 0, 0, 0},       /* SA 221 */
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_SMART2P,
+		0x0E11, 0x4033, 0, 0, 0},       /* SA 3100ES*/
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_SMART2P,
+		0x0E11, 0x4032, 0, 0, 0},       /* SA 3200*/
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_SMART2P,
+		0x0E11, 0x4031, 0, 0, 0},       /* SA 2SL*/
+	{ PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_SMART2P,
+		0x0E11, 0x4030, 0, 0, 0},       /* SA 2P */
+	{ 0 }
+};
+
+MODULE_DEVICE_TABLE(pci, cpqarray_pci_device_id);
+
 static struct gendisk *ida_gendisk[MAX_CTLR][NWD];
 
 /* Debug... */
@@ -108,7 +136,7 @@ static struct gendisk *ida_gendisk[MAX_C
 /* Debug Extra Paranoid... */
 #define DBGPX(s) do { } while(0)
 
-static int cpqarray_pci_detect(void);
+int cpqarray_init_step2(void);
 static int cpqarray_pci_init(ctlr_info_t *c, struct pci_dev *pdev);
 static void *remap_pci_mem(ulong base, ulong size);
 static int cpqarray_eisa_detect(void);
@@ -119,6 +147,9 @@ static void start_fwbk(int ctlr);
 static cmdlist_t * cmd_alloc(ctlr_info_t *h, int get_from_pool);
 static void cmd_free(ctlr_info_t *h, cmdlist_t *c, int got_from_pool);
 
+static void free_hba(int i);
+static int alloc_cpqarray_hba(void);
+
 static int sendcmd(
 	__u8	cmd,
 	int	ctlr,
@@ -145,6 +176,7 @@ static irqreturn_t do_ida_intr(int irq, 
 static void ida_timer(unsigned long tdata);
 static int ida_revalidate(struct gendisk *disk);
 static int revalidate_allvol(ctlr_info_t *host);
+static int cpqarray_register_ctlr(int ctlr, struct pci_dev *pdev);
 
 #ifdef CONFIG_PROC_FS
 static void ida_procinit(int i);
@@ -281,150 +313,190 @@ static int ida_proc_get_info(char *buffe
 
 MODULE_PARM(eisa, "1-8i");
 
-static void __exit cpqarray_exit(void)
+/* This is a bit of a hack, 
+ * necessary to support both eisa and pci
+ */
+int __init cpqarray_init(void)
 {
-	int i, j;
-	char buff[4]; 
+	if(cpqarray_init_step2() == 0) 	/* all the block dev num already used */
+		return -ENODEV;		/* or no controllers were found */
+	return 0;
+}
 
-	for(i=0; i<nr_ctlr; i++) {
+static void release_io_mem(ctlr_info_t *c)
+{
+	/* if IO mem was not protected do nothing */
+	if( c->io_mem_addr == 0)
+		return;
+	release_region(c->io_mem_addr, c->io_mem_length);
+	c->io_mem_addr = 0;
+	c->io_mem_length = 0;
+}
 
-		/* sendcmd will turn off interrupt, and send the flush... 
-		 * To write all data in the battery backed cache to disks    
-		 * no data returned, but don't want to send NULL to sendcmd */	
-		if( sendcmd(FLUSH_CACHE, i, buff, 4, 0, 0, 0))
-		{
-			printk(KERN_WARNING "Unable to flush cache on "
-				"controller %d\n", i);	
-		}
-		free_irq(hba[i]->intr, hba[i]);
-		iounmap(hba[i]->vaddr);
-		unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
-		del_timer(&hba[i]->timer);
-		remove_proc_entry(hba[i]->devname, proc_array);
-		pci_free_consistent(hba[i]->pci_dev, 
-			NR_CMDS * sizeof(cmdlist_t), (hba[i]->cmd_pool), 
+static void __devexit cpqarray_remove_one(int i)
+{
+	int j;
+	char buff[4];
+
+	/* sendcmd will turn off interrupt, and send the flush...
+	 * To write all data in the battery backed cache to disks
+	 * no data returned, but don't want to send NULL to sendcmd */
+	if( sendcmd(FLUSH_CACHE, i, buff, 4, 0, 0, 0))
+	{
+		printk(KERN_WARNING "Unable to flush cache on controller %d\n",
+				i);
+	}
+	free_irq(hba[i]->intr, hba[i]);
+	iounmap(hba[i]->vaddr);
+	unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
+	del_timer(&hba[i]->timer);
+	remove_proc_entry(hba[i]->devname, proc_array);
+	pci_free_consistent(hba[i]->pci_dev,
+			NR_CMDS * sizeof(cmdlist_t), (hba[i]->cmd_pool),
 			hba[i]->cmd_pool_dhandle);
-		kfree(hba[i]->cmd_pool_bits);
+	kfree(hba[i]->cmd_pool_bits);
+	for(j = 0; j < NWD; j++) {
+		if (ida_gendisk[i][j]->flags & GENHD_FL_UP)
+			del_gendisk(ida_gendisk[i][j]);
+		devfs_remove("ida/c%dd%d",i,j);
+		put_disk(ida_gendisk[i][j]);
+	}
+	blk_cleanup_queue(hba[i]->queue);
+	release_io_mem(hba[i]);
+	free_hba(i);
+}
 
-		for (j = 0; j < NWD; j++) {
-			if (ida_gendisk[i][j]->flags & GENHD_FL_UP)
-				del_gendisk(ida_gendisk[i][j]);
-			devfs_remove("ida/c%dd%d",i,j);
-			put_disk(ida_gendisk[i][j]);
-		}
-		blk_cleanup_queue(hba[i]->queue);
+static void __devexit cpqarray_remove_one_pci (struct pci_dev *pdev)
+{
+	int i;
+	ctlr_info_t *tmp_ptr;
+
+	if (pci_get_drvdata(pdev) == NULL) {
+		printk( KERN_ERR "cpqarray: Unable to remove device \n");
+		return;
 	}
-	devfs_remove("ida");
-	remove_proc_entry("cpqarray", proc_root_driver);
+
+	tmp_ptr = pci_get_drvdata(pdev);
+	i = tmp_ptr->ctlr;
+	if (hba[i] == NULL) {
+		printk(KERN_ERR "cpqarray: controller %d appears to have"
+			"already been removed \n", i);
+		return;
+        }
+	pci_set_drvdata(pdev, NULL);
+
+	cpqarray_remove_one(i);
 }
 
-/*
- *  This is it.  Find all the controllers and register them.  I really hate
- *  stealing all these major device numbers.
- *  returns the number of block devices registered.
+/* removing an instance that was not removed automatically..
+ * must be an eisa card.
  */
-static int __init cpqarray_init(void)
+static void __devexit cpqarray_remove_one_eisa (int i)
 {
-	request_queue_t *q;
-	int i,j;
-	int num_cntlrs_reg = 0;
-	/* detect controllers */
-	cpqarray_pci_detect();
-	cpqarray_eisa_detect();
-	
-	if (nr_ctlr == 0)
-		return -ENODEV;
+	if (hba[i] == NULL) {
+		printk(KERN_ERR "cpqarray: controller %d appears to have"
+			"already been removed \n", i);
+		return;
+        }
+	cpqarray_remove_one(i);
+}
 
-	printk(DRIVER_NAME "\n");
-	printk("Found %d controller(s)\n", nr_ctlr);
+/* pdev is NULL for eisa */
+static int cpqarray_register_ctlr( int i, struct pci_dev *pdev)
+{
+	request_queue_t *q;
+	int j;
 
-	/* allocate space for disk structs */
 	/* 
 	 * register block devices
 	 * Find disks and fill in structs
 	 * Get an interrupt, set the Q depth and get into /proc
 	 */
-	for(i=0; i < nr_ctlr; i++) {
-	  	/* If this successful it should insure that we are the only */
-		/* instance of the driver */	
-		if (register_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname))
-                        continue;
-
-		hba[i]->access.set_intr_mask(hba[i], 0);
-		if (request_irq(hba[i]->intr, do_ida_intr,
-			SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i])) {
-
-			printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n", 
+  	
+	/* If this successful it should insure that we are the only */
+	/* instance of the driver */	
+	if (register_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname)) {
+		goto Enomem4;
+	}
+	hba[i]->access.set_intr_mask(hba[i], 0);
+	if (request_irq(hba[i]->intr, do_ida_intr,
+		SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i]))
+	{
+		printk(KERN_ERR "cpqarray: Unable to get irq %d for %s\n", 
 				hba[i]->intr, hba[i]->devname);
-			unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
-			continue;
-		}
-		num_cntlrs_reg++;
-		for (j=0; j<NWD; j++) {
-			ida_gendisk[i][j] = alloc_disk(1 << NWD_SHIFT);
-			if (!ida_gendisk[i][j])
-				goto Enomem2;
-		}
-		hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
-				hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t), 
-				&(hba[i]->cmd_pool_dhandle));
-		hba[i]->cmd_pool_bits = kmalloc(((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long), GFP_KERNEL);
+		goto Enomem3;
+	}
 		
-		if (!hba[i]->cmd_pool_bits || !hba[i]->cmd_pool)
-			goto Enomem1;
-		memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
-		memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
-		printk(KERN_INFO "cpqarray: Finding drives on %s", 
-			hba[i]->devname);
-
-		spin_lock_init(&hba[i]->lock);
-		q = blk_init_queue(do_ida_request, &hba[i]->lock);
-		if (!q)
+	for (j=0; j<NWD; j++) {
+		ida_gendisk[i][j] = alloc_disk(1 << NWD_SHIFT);
+		if (!ida_gendisk[i][j])
+			goto Enomem2;
+	}
+
+	hba[i]->cmd_pool = (cmdlist_t *)pci_alloc_consistent(
+		hba[i]->pci_dev, NR_CMDS * sizeof(cmdlist_t),
+		&(hba[i]->cmd_pool_dhandle));
+	hba[i]->cmd_pool_bits = kmalloc(
+		((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long),
+		GFP_KERNEL);
+		
+	if (!hba[i]->cmd_pool_bits || !hba[i]->cmd_pool)
 			goto Enomem1;
 
-		hba[i]->queue = q;
-		q->queuedata = hba[i];
+	memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
+	memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+BITS_PER_LONG-1)/BITS_PER_LONG)*sizeof(unsigned long));
+	printk(KERN_INFO "cpqarray: Finding drives on %s", 
+		hba[i]->devname);
+
+	spin_lock_init(&hba[i]->lock);
+	q = blk_init_queue(do_ida_request, &hba[i]->lock);
+	if (!q)
+		goto Enomem1;
 
-		getgeometry(i);
-		start_fwbk(i); 
+	hba[i]->queue = q;
+	q->queuedata = hba[i];
 
-		ida_procinit(i);
+	getgeometry(i);
+	start_fwbk(i); 
 
+	ida_procinit(i);
+
+	if (pdev)
 		blk_queue_bounce_limit(q, hba[i]->pci_dev->dma_mask);
 
-		/* This is a hardware imposed limit. */
-		blk_queue_max_hw_segments(q, SG_MAX);
+	/* This is a hardware imposed limit. */
+	blk_queue_max_hw_segments(q, SG_MAX);
 
-		/* This is a driver limit and could be eliminated. */
-		blk_queue_max_phys_segments(q, SG_MAX);
+	/* This is a driver limit and could be eliminated. */
+	blk_queue_max_phys_segments(q, SG_MAX);
 	
-		init_timer(&hba[i]->timer);
-		hba[i]->timer.expires = jiffies + IDA_TIMER;
-		hba[i]->timer.data = (unsigned long)hba[i];
-		hba[i]->timer.function = ida_timer;
-		add_timer(&hba[i]->timer);
-
-		/* Enable IRQ now that spinlock and rate limit timer are set up */
-		hba[i]->access.set_intr_mask(hba[i], FIFO_NOT_EMPTY);
-
-		for(j=0; j<NWD; j++) {
-			struct gendisk *disk = ida_gendisk[i][j];
-			drv_info_t *drv = &hba[i]->drv[j];
-			sprintf(disk->disk_name, "ida/c%dd%d", i, j);
-			disk->major = COMPAQ_SMART2_MAJOR + i;
-			disk->first_minor = j<<NWD_SHIFT;
-			disk->fops = &ida_fops; 
-			if (j && !drv->nr_blks)
-				continue;
-			blk_queue_hardsect_size(hba[i]->queue, drv->blk_size);
-			set_capacity(disk, drv->nr_blks);
-			disk->queue = hba[i]->queue;
-			disk->private_data = drv;
-			add_disk(disk);
-		}
+	init_timer(&hba[i]->timer);
+	hba[i]->timer.expires = jiffies + IDA_TIMER;
+	hba[i]->timer.data = (unsigned long)hba[i];
+	hba[i]->timer.function = ida_timer;
+	add_timer(&hba[i]->timer);
+
+	/* Enable IRQ now that spinlock and rate limit timer are set up */
+	hba[i]->access.set_intr_mask(hba[i], FIFO_NOT_EMPTY);
+
+	for(j=0; j<NWD; j++) {
+		struct gendisk *disk = ida_gendisk[i][j];
+		drv_info_t *drv = &hba[i]->drv[j];
+		sprintf(disk->disk_name, "ida/c%dd%d", i, j);
+		disk->major = COMPAQ_SMART2_MAJOR + i;
+		disk->first_minor = j<<NWD_SHIFT;
+		disk->fops = &ida_fops; 
+		if (j && !drv->nr_blks)
+			continue;
+		blk_queue_hardsect_size(hba[i]->queue, drv->blk_size);
+		set_capacity(disk, drv->nr_blks);
+		disk->queue = hba[i]->queue;
+		disk->private_data = drv;
+		add_disk(disk);
 	}
+	
 	/* done ! */
-	return num_cntlrs_reg ? 0 : -ENODEV;
+	return(i);
 
 Enomem1:
 	nr_ctlr = i; 
@@ -438,83 +510,102 @@ Enomem2:
 		ida_gendisk[i][j] = NULL;
 	}
 	free_irq(hba[i]->intr, hba[i]);
+Enomem3:
 	unregister_blkdev(COMPAQ_SMART2_MAJOR+i, hba[i]->devname);
-	num_cntlrs_reg--;
+Enomem4:
+	if (pdev)	
+		pci_set_drvdata(pdev, NULL);
+	release_io_mem(hba[i]);
+	free_hba(i);
+
 	printk( KERN_ERR "cpqarray: out of memory");
 
-	if (!num_cntlrs_reg) {
-		remove_proc_entry("cpqarray", proc_root_driver);
-		return -ENODEV;
+	return -1;
+}
+
+static int __init cpqarray_init_one( struct pci_dev *pdev,
+	const struct pci_device_id *ent)
+{
+	int i;
+
+	printk(KERN_DEBUG "cpqarray: Device 0x%x has been found at"
+			" bus %d dev %d func %d\n",
+			pdev->device, pdev->bus->number, PCI_SLOT(pdev->devfn),
+			PCI_FUNC(pdev->devfn));
+	i = alloc_cpqarray_hba();
+	if( i < 0 )
+		return (-1);
+	memset(hba[i], 0, sizeof(ctlr_info_t));
+	sprintf(hba[i]->devname, "ida%d", i);
+	hba[i]->ctlr = i;
+	/* Initialize the pdev driver private data */
+	pci_set_drvdata(pdev, hba[i]);
+
+	if (cpqarray_pci_init(hba[i], pdev) != 0) {
+		pci_set_drvdata(pdev, NULL);
+		release_io_mem(hba[i]);
+		free_hba(i);
+		return -1;
 	}
-	return 0;
+
+	return (cpqarray_register_ctlr(i, pdev));
 }
 
+static struct pci_driver cpqarray_pci_driver = {
+	name:   "cpqarray",
+	probe:  cpqarray_init_one,
+	remove:  __devexit_p(cpqarray_remove_one_pci),
+	id_table:  cpqarray_pci_device_id,
+};
+
 /*
- * Find the controller and initialize it
- *  Cannot use the class code to search, because older array controllers use
- *    0x018000 and new ones use 0x010400.  So I might as well search for each
- *    each device IDs, being there are only going to be three of them. 
- */
-static int cpqarray_pci_detect(void)
-{
-	struct pci_dev *pdev;
-
-#define IDA_BOARD_TYPES 3
-	static int ida_vendor_id[IDA_BOARD_TYPES] = { PCI_VENDOR_ID_DEC, 
-		PCI_VENDOR_ID_NCR, PCI_VENDOR_ID_COMPAQ };
-	static int ida_device_id[IDA_BOARD_TYPES] = { PCI_DEVICE_ID_COMPAQ_42XX,		PCI_DEVICE_ID_NCR_53C1510, PCI_DEVICE_ID_COMPAQ_SMART2P };
-	int brdtype;
+ *  This is it.  Find all the controllers and register them.  I really hate
+ *  stealing all these major device numbers.
+ *  returns the number of block devices registered.
+ */
+int __init cpqarray_init_step2(void)
+{
+	int num_cntlrs_reg = 0;
+	int i;
+
+	/* detect controllers */
+	printk(DRIVER_NAME "\n");
+	pci_register_driver(&cpqarray_pci_driver);
+	cpqarray_eisa_detect();
 	
-	/* search for all PCI board types that could be for this driver */
-	for(brdtype=0; brdtype<IDA_BOARD_TYPES; brdtype++)
-	{
-		pdev = pci_find_device(ida_vendor_id[brdtype],
-				       ida_device_id[brdtype], NULL);
-		while (pdev) {
-			printk(KERN_DEBUG "cpqarray: Device 0x%x has"
-				" been found at bus %d dev %d func %d\n",
-				ida_vendor_id[brdtype],
-				pdev->bus->number, PCI_SLOT(pdev->devfn),
-				PCI_FUNC(pdev->devfn));
-			if (nr_ctlr == 8) {
-				printk(KERN_WARNING "cpqarray: This driver"
-				" supports a maximum of 8 controllers.\n");
-				break;
-			}
-			
-/* if it is a PCI_DEVICE_ID_NCR_53C1510, make sure it's 				the Compaq version of the chip */ 
+	for (i=0; i < MAX_CTLR; i++) {
+		if (hba[i] != NULL)
+			num_cntlrs_reg++;
+	}
 
-			if (ida_device_id[brdtype] == PCI_DEVICE_ID_NCR_53C1510)			{	
-				unsigned short subvendor=pdev->subsystem_vendor;
-				if(subvendor !=  PCI_VENDOR_ID_COMPAQ)
-				{
-					printk(KERN_DEBUG 
-						"cpqarray: not a Compaq integrated array controller\n");
-					continue;
-				}
-			}
+	return(num_cntlrs_reg);
+}
 
-			hba[nr_ctlr] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);			if(hba[nr_ctlr]==NULL)
-			{
+/* Function to find the first free pointer into our hba[] array */
+/* Returns -1 if no free entries are left.  */
+static int alloc_cpqarray_hba(void)
+{
+	int i;
+
+	for(i=0; i< MAX_CTLR; i++) {
+		if (hba[i] == NULL) {
+			hba[i] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
+			if(hba[i]==NULL) {
 				printk(KERN_ERR "cpqarray: out of memory.\n");
-				continue;
-			}
-			memset(hba[nr_ctlr], 0, sizeof(ctlr_info_t));
-			if (cpqarray_pci_init(hba[nr_ctlr], pdev) != 0)
-			{
-				kfree(hba[nr_ctlr]);
-				continue;
+				return (-1);
 			}
-			sprintf(hba[nr_ctlr]->devname, "ida%d", nr_ctlr);
-			hba[nr_ctlr]->ctlr = nr_ctlr;
-			nr_ctlr++;
-
-			pdev = pci_find_device(ida_vendor_id[brdtype],
-					       ida_device_id[brdtype], pdev);
+			return (i);
 		}
 	}
+	printk(KERN_WARNING "cpqarray: This driver supports a maximum"
+		" of 8 controllers.\n");
+	return(-1);
+}
 
-	return nr_ctlr;
+static void free_hba(int i)
+{
+	kfree(hba[i]);
+	hba[i]=NULL;
 }
 
 /*
@@ -555,6 +646,13 @@ static int cpqarray_pci_init(ctlr_info_t
 	pci_read_config_byte(pdev, PCI_LATENCY_TIMER, &latency_timer);
 
 	pci_read_config_dword(pdev, 0x2c, &board_id);
+	
+	/* check to see if controller has been disabled */
+	if(!(command & 0x02)) {
+		printk(KERN_WARNING 
+			"cpqarray: controller appears to be disabled\n");
+		return(-1);
+	}
 
 DBGINFO(
 	printk("vendor_id = %x\n", vendor_id);
@@ -570,11 +668,28 @@ DBGINFO(
 );
 
 	c->intr = irq;
-	c->io_mem_addr = addr[0];
+
+	for(i=0; i<6; i++) {
+		if (pci_resource_flags(pdev, i) & PCI_BASE_ADDRESS_SPACE_IO)
+		{ /* IO space */
+			c->io_mem_addr = addr[i];
+			c->io_mem_length = pci_resource_end(pdev, i)
+				- pci_resource_start(pdev, i) + 1;
+			if(!request_region( c->io_mem_addr, c->io_mem_length,
+				"cpqarray"))
+			{
+				printk( KERN_WARNING "cpqarray I/O memory range already in use addr %lx length = %ld\n", c->io_mem_addr, c->io_mem_length);
+				c->io_mem_addr = 0;
+				c->io_mem_length = 0;
+			}
+			break;
+		}
+	}
 
 	c->paddr = 0;
 	for(i=0; i<6; i++)
-		if (pci_resource_flags(pdev, i) & IORESOURCE_MEM) {
+		if (!(pci_resource_flags(pdev, i) &
+				PCI_BASE_ADDRESS_SPACE_IO)) {
 			c->paddr = pci_resource_start (pdev, i);
 			break;
 		}
@@ -654,13 +769,13 @@ static int cpqarray_eisa_detect(void)
 	int i=0, j;
 	__u32 board_id;
 	int intr;
+	int ctlr;
+	int num_ctlr = 0;
 
 	while(i<8 && eisa[i]) {
-		if (nr_ctlr == 8) {
-			printk(KERN_WARNING "cpqarray: This driver supports"
-				" a maximum of 8 controllers.\n");
+		ctlr = alloc_cpqarray_hba();
+		if(ctlr == -1)
 			break;
-		}
 		board_id = inl(eisa[i]+0xC80);
 		for(j=0; j < NR_PRODUCTS; j++)
 			if (board_id == products[j].board_id) 
@@ -671,14 +786,21 @@ static int cpqarray_eisa_detect(void)
 				" to access the SMART Array controller %08lx\n",				 (unsigned long)board_id);
 			continue;
 		}
-		hba[nr_ctlr] = (ctlr_info_t *) kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
-		if(hba[nr_ctlr]==NULL)
+		
+		memset(hba[ctlr], 0, sizeof(ctlr_info_t));
+		hba[ctlr]->io_mem_addr = eisa[i];
+		hba[ctlr]->io_mem_length = 0x7FF;
+		if(!request_region(hba[ctlr]->io_mem_addr,
+				hba[ctlr]->io_mem_length,
+				"cpqarray"))
 		{
-			printk(KERN_ERR "cpqarray: out of memory.\n");
+			printk(KERN_WARNING "cpqarray: I/O range already in "
+					"use addr = %lx length = %ld\n",
+					hba[ctlr]->io_mem_addr,
+					hba[ctlr]->io_mem_length);
+			free_hba(ctlr);
 			continue;
 		}
-		memset(hba[nr_ctlr], 0, sizeof(ctlr_info_t));
-		hba[nr_ctlr]->io_mem_addr = eisa[i];
 
 		/*
 		 * Read the config register to find our interrupt
@@ -689,13 +811,13 @@ static int cpqarray_eisa_detect(void)
 		else if (intr & 4) intr = 14;
 		else if (intr & 8) intr = 15;
 		
-		hba[nr_ctlr]->intr = intr;
-		sprintf(hba[nr_ctlr]->devname, "ida%d", nr_ctlr);
-		hba[nr_ctlr]->product_name = products[j].product_name;
-		hba[nr_ctlr]->access = *(products[j].access);
-		hba[nr_ctlr]->ctlr = nr_ctlr;
-		hba[nr_ctlr]->board_id = board_id;
-		hba[nr_ctlr]->pci_dev = NULL; /* not PCI */
+		hba[ctlr]->intr = intr;
+		sprintf(hba[ctlr]->devname, "ida%d", nr_ctlr);
+		hba[ctlr]->product_name = products[j].product_name;
+		hba[ctlr]->access = *(products[j].access);
+		hba[ctlr]->ctlr = ctlr;
+		hba[ctlr]->board_id = board_id;
+		hba[ctlr]->pci_dev = NULL; /* not PCI */
 
 DBGINFO(
 	printk("i = %d, j = %d\n", i, j);
@@ -704,14 +826,19 @@ DBGINFO(
 	printk("board_id = %x\n", board_id);
 );
 
-		nr_ctlr++;
+		num_ctlr++;
 		i++;
+
+		if (cpqarray_register_ctlr(ctlr, NULL) == -1)
+			printk(KERN_WARNING
+				"cpqarray: Can't register EISA controller %d\n",
+				ctlr);
+		
 	}
 
-	return nr_ctlr;
+	return num_ctlr;
 }
 
-
 /*
  * Open.  Make sure the device is really there.
  */
@@ -1721,5 +1848,24 @@ static void getgeometry(int ctlr)
 
 }
 
+static void __exit cpqarray_exit(void)
+{
+	int i;
+
+	pci_unregister_driver(&cpqarray_pci_driver);
+
+	/* Double check that all controller entries have been removed */
+	for(i=0; i<MAX_CTLR; i++) {
+		if (hba[i] != NULL) {
+			printk(KERN_WARNING "cpqarray: Removing EISA "
+					"controller %d\n", i);
+			cpqarray_remove_one_eisa(i);
+		}
+	}
+
+	devfs_remove("ida");
+	remove_proc_entry("cpqarray", proc_root_driver);
+}
+
 module_init(cpqarray_init)
 module_exit(cpqarray_exit)

_
