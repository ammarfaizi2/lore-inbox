Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTKSNRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 08:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTKSNRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 08:17:30 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:22023 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264039AbTKSNQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 08:16:44 -0500
Date: Wed, 19 Nov 2003 13:16:27 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jason Holmes <jholmes@psu.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make 2.6 megaraid recognize intel vendor id
Message-ID: <20031119131627.A12116@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Domsch <Matt_Domsch@dell.com>, Jeff Garzik <jgarzik@pobox.com>,
	Jason Holmes <jholmes@psu.edu>, linux-kernel@vger.kernel.org
References: <3FB3BBE0.D4D0EACC@psu.edu> <3FB3D5B1.5080904@pobox.com> <20031113153552.A20514@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031113153552.A20514@lists.us.dell.com>; from Matt_Domsch@dell.com on Thu, Nov 13, 2003 at 03:35:52PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13, 2003 at 03:35:52PM -0600, Matt Domsch wrote:
> > ewwww.
> > 
> > I don't object to your patch, but I'm disappointed that megaraid doesn't 
> > use the normal PCI probing mechanism.
> 
> It's on their TODO list I know.  I've been pushing for that too.

Here's a patch.  If someone who has access to the hardware could actually
test it it would be a nice candidate for 2.6.1..

--- 1.56/drivers/scsi/megaraid.c	Thu Nov 13 07:58:04 2003
+++ edited/drivers/scsi/megaraid.c	Wed Nov 19 10:06:32 2003
@@ -14,6 +14,9 @@
  *	  - speed-ups (list handling fixes, issued_list, optimizations.)
  *	  - lots of cleanups.
  *
+ * Copyright (c) 2003  Christoph Hellwig  <hch@lst.de>
+ *	  - new-style, hotplug-aware pci probing and scsi registration
+ *
  * Version : v2.00.3 (Feb 19, 2003) - Atul Mukker <Atul.Mukker@lsil.com>
  *
  * Description: Linux device driver for LSI Logic MegaRAID controller
@@ -79,10 +82,6 @@
 static adapter_t *hba_soft_state[MAX_CONTROLLERS];
 static struct proc_dir_entry *mega_proc_dir_entry;
 
-static struct notifier_block mega_notifier = {
-	.notifier_call = megaraid_reboot_notify
-};
-
 /* For controller re-ordering */
 static struct mega_hbas mega_hbas[MAX_CONTROLLERS];
 
@@ -116,548 +115,6 @@
  */
 static int trace_level;
 
-/*
- * megaraid_validate_parms()
- *
- * Validate that any module parms passed in
- * have proper values.
- */
-static void
-megaraid_validate_parms(void)
-{
-	if( (max_cmd_per_lun <= 0) || (max_cmd_per_lun > MAX_CMD_PER_LUN) )
-		max_cmd_per_lun = MAX_CMD_PER_LUN;
-	if( max_mbox_busy_wait > MBOX_BUSY_WAIT )
-		max_mbox_busy_wait = MBOX_BUSY_WAIT;
-}
-
-
-/**
- * megaraid_detect()
- * @host_template - Our soft state maintained by mid-layer
- *
- * the detect entry point for the mid-layer.
- * We scan the PCI bus for our controllers and start them.
- *
- * Note: PCI_DEVICE_ID_PERC4_DI below represents the PERC4/Di class of
- * products. All of them share the same vendor id, device id, and subsystem
- * vendor id but different subsystem ids. As of now, driver does not use the
- * subsystem id.
- */
-static int
-megaraid_detect(Scsi_Host_Template *host_template)
-{
-	int	i;
-	u16	dev_sw_table[] = {	/* Table of all supported
-					   vendor/device ids */
-
-		PCI_VENDOR_ID_DELL,		PCI_DEVICE_ID_DISCOVERY, 
-		PCI_VENDOR_ID_DELL,		PCI_DEVICE_ID_PERC4_DI, 
-		PCI_VENDOR_ID_LSI_LOGIC,	PCI_DEVICE_ID_PERC4_QC_VERDE, 
-		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID, 
-		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID2, 
-		PCI_VENDOR_ID_AMI,		PCI_DEVICE_ID_AMI_MEGARAID3, 
-		PCI_VENDOR_ID_INTEL,		PCI_DEVICE_ID_AMI_MEGARAID3, 
-		PCI_VENDOR_ID_LSI_LOGIC,	PCI_DEVICE_ID_AMI_MEGARAID3 };
-
-	host_template->proc_name = "megaraid";
-
-	printk(KERN_NOTICE "megaraid: " MEGARAID_VERSION);
-
-	megaraid_validate_parms();
-
-	memset(mega_hbas, 0, sizeof (mega_hbas));
-
-	hba_count = 0;
-
-	/*
-	 * Scan PCI bus for our all devices.
-	 */
-	for( i = 0; i < sizeof(dev_sw_table)/sizeof(u16); i += 2 ) {
-
-		mega_find_card(host_template, dev_sw_table[i],
-				dev_sw_table[i+1]);
-	}
-
-	if(hba_count) {
-		/*
-		 * re-order hosts so that one with bootable logical drive
-		 * comes first
-		 */
-#ifdef CONFIG_PROC_FS
-		mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
-
-		if(!mega_proc_dir_entry) {
-			printk(KERN_WARNING
-				"megaraid: failed to create megaraid root\n");
-		}
-		else {
-			for(i = 0; i < hba_count; i++) {
-				mega_create_proc_entry(i, mega_proc_dir_entry);
-			}
-		}
-#endif
-
-		/*
-		 * Register the driver as a character device, for applications
-		 * to access it for ioctls.
-		 * First argument (major) to register_chrdev implies a dynamic
-		 * major number allocation.
-		 */
-		major = register_chrdev(0, "megadev", &megadev_fops);
-
-		/*
-		 * Register the Shutdown Notification hook in kernel
-		 */
-		if(register_reboot_notifier(&mega_notifier)) {
-			printk(KERN_WARNING
-				"MegaRAID Shutdown routine not registered!!\n");
-		}
-
-	}
-
-	return hba_count;
-}
-
-
-
-/**
- * mega_find_card() - find and start this controller
- * @host_template - Our soft state maintained by mid-layer
- * @pci_vendor - pci vendor id for this controller
- * @pci_device - pci device id for this controller
- *
- * Scans the PCI bus for this vendor and device id combination, setup the
- * resources, and register ourselves as a SCSI HBA driver, and setup all
- * parameters for our soft state.
- *
- * This routine also checks for some buggy firmware and ajust the flags
- * accordingly.
- */
-static void
-mega_find_card(Scsi_Host_Template *host_template, u16 pci_vendor,
-	u16 pci_device)
-{
-	struct Scsi_Host	*host = NULL;
-	adapter_t	*adapter = NULL;
-	u32	magic64;
-	unsigned long	mega_baseport;
-	u16	subsysid, subsysvid;
-	u8	pci_bus;
-	u8	pci_dev_func;
-	u8	irq;
-	struct pci_dev	*pdev = NULL;
-	u8	did_ioremap_f = 0;
-	u8	did_req_region_f = 0;
-	u8	did_scsi_reg_f = 0;
-	u8	alloc_int_buf_f = 0;
-	u8	alloc_scb_f = 0;
-	u8	got_irq_f = 0;
-	u8	did_setup_mbox_f = 0;
-	unsigned long	tbase;
-	unsigned long	flag = 0;
-	int	i, j;
-
-	while((pdev = pci_find_device(pci_vendor, pci_device, pdev))) {
-
-		if(pci_enable_device (pdev)) continue;
-
-		pci_bus = pdev->bus->number;
-		pci_dev_func = pdev->devfn;
-
-		/*
-		 * For these vendor and device ids, signature offsets are not
-		 * valid and 64 bit is implicit
-		 */
-		if( (pci_vendor == PCI_VENDOR_ID_DELL &&
-			pci_device == PCI_DEVICE_ID_PERC4_DI) ||
-			(pci_vendor == PCI_VENDOR_ID_LSI_LOGIC &&
-			pci_device == PCI_DEVICE_ID_PERC4_QC_VERDE) ) {
-
-			flag |= BOARD_64BIT;
-		}
-		else {
-			pci_read_config_dword(pdev, PCI_CONF_AMISIG64,
-					&magic64);
-
-			if (magic64 == HBA_SIGNATURE_64BIT)
-				flag |= BOARD_64BIT;
-		}
-
-		subsysvid = pdev->subsystem_vendor;
-		subsysid = pdev->subsystem_device;
-
-		/*
-		 * If we do not find the valid subsys vendor id, refuse to
-		 * load the driver. This is part of PCI200X compliance
-		 * We load the driver if subsysvid is 0.
-		 */
-		if( subsysvid && (subsysvid != AMI_SUBSYS_VID) &&
-				(subsysvid != DELL_SUBSYS_VID) &&
-				(subsysvid != HP_SUBSYS_VID) &&
-				(subsysvid != INTEL_SUBSYS_VID) &&
-				(subsysvid != LSI_SUBSYS_VID) ) continue;
-
-
-		printk(KERN_NOTICE "megaraid: found 0x%4.04x:0x%4.04x:bus %d:",
-			pci_vendor, pci_device, pci_bus);
-
-		printk("slot %d:func %d\n",
-			PCI_SLOT(pci_dev_func), PCI_FUNC(pci_dev_func));
-
-		/* Read the base port and IRQ from PCI */
-		mega_baseport = pci_resource_start(pdev, 0);
-		irq = pdev->irq;
-
-		tbase = mega_baseport;
-
-		if( pci_resource_flags(pdev, 0) & IORESOURCE_MEM ) {
-
-			if (!request_mem_region(mega_baseport, 128,
-					"MegaRAID: LSI Logic Corporation.")) {
-				printk(KERN_WARNING
-					"megaraid: mem region busy!\n");
-				continue;
-			}
-
-			mega_baseport =
-				(unsigned long)ioremap(mega_baseport, 128);
-
-			if( !mega_baseport ) {
-				printk(KERN_WARNING
-					"megaraid: could not map hba memory\n");
-
-				release_mem_region(tbase, 128);
-
-				continue;
-			}
-
-			flag |= BOARD_MEMMAP;
-
-			did_ioremap_f = 1;
-		}
-		else {
-			mega_baseport += 0x10;
-
-			if( !request_region(mega_baseport, 16, "megaraid") )
-				goto fail_attach;
-
-			flag |= BOARD_IOMAP;
-
-			did_req_region_f = 1;
-		}
-
-		/* Initialize SCSI Host structure */
-		host = scsi_register(host_template, sizeof(adapter_t));
-
-		if(!host) goto fail_attach;
-
-		did_scsi_reg_f = 1;
-
-		scsi_set_device(host, &pdev->dev);
-
-		adapter = (adapter_t *)host->hostdata;
-		memset(adapter, 0, sizeof(adapter_t));
-
-		printk(KERN_NOTICE
-			"scsi%d:Found MegaRAID controller at 0x%lx, IRQ:%d\n",
-			host->host_no, mega_baseport, irq);
-
-		adapter->base = mega_baseport;
-
-		/* Copy resource info into structure */
-		INIT_LIST_HEAD(&adapter->free_list);
-		INIT_LIST_HEAD(&adapter->pending_list);
-		INIT_LIST_HEAD(&adapter->completed_list);
-
-		adapter->flag = flag;
-		spin_lock_init(&adapter->lock);
-		scsi_assign_lock(host, &adapter->lock);
-
-		host->cmd_per_lun = max_cmd_per_lun;
-		host->max_sectors = max_sectors_per_io;
-
-		adapter->dev = pdev;
-		adapter->host = host;
-
-		adapter->host->irq = irq;
-
-		if( flag & BOARD_MEMMAP ) {
-			adapter->host->base = tbase;
-		}
-		else {
-			adapter->host->io_port = tbase;
-			adapter->host->n_io_port = 16;
-		}
-
-		adapter->host->unique_id = (pci_bus << 8) | pci_dev_func;
-
-		/*
-		 * Allocate buffer to issue internal commands.
-		 */
-		adapter->mega_buffer = pci_alloc_consistent(adapter->dev,
-			MEGA_BUFFER_SIZE, &adapter->buf_dma_handle);
-
-		if( !adapter->mega_buffer ) {
-			printk(KERN_WARNING "megaraid: out of RAM.\n");
-			goto fail_attach;
-		}
-		alloc_int_buf_f = 1;
-
-		adapter->scb_list = kmalloc(sizeof(scb_t)*MAX_COMMANDS,
-				GFP_KERNEL);
-
-		if(!adapter->scb_list) {
-			printk(KERN_WARNING "megaraid: out of RAM.\n");
-			goto fail_attach;
-		}
-
-		alloc_scb_f = 1;
-
-		/* Request our IRQ */
-		if( adapter->flag & BOARD_MEMMAP ) {
-			if(request_irq(irq, megaraid_isr_memmapped, SA_SHIRQ,
-						"megaraid", adapter)) {
-				printk(KERN_WARNING
-					"megaraid: Couldn't register IRQ %d!\n",
-					irq);
-				goto fail_attach;
-			}
-		}
-		else {
-			if(request_irq(irq, megaraid_isr_iomapped, SA_SHIRQ,
-						"megaraid", adapter)) {
-				printk(KERN_WARNING
-					"megaraid: Couldn't register IRQ %d!\n",
-					irq);
-				goto fail_attach;
-			}
-		}
-		got_irq_f = 1;
-
-		if( mega_setup_mailbox(adapter) != 0 )
-			goto fail_attach;
-
-		did_setup_mbox_f = 1;
-
-		if( mega_query_adapter(adapter) != 0 )
-			goto fail_attach;
-
-		/*
-		 * Have checks for some buggy f/w
-		 */
-		if((subsysid == 0x1111) && (subsysvid == 0x1111)) {
-			/*
-			 * Which firmware
-			 */
-			if (!strcmp(adapter->fw_version, "3.00") ||
-					!strcmp(adapter->fw_version, "3.01")) {
-
-				printk( KERN_WARNING
-					"megaraid: Your  card is a Dell PERC "
-					"2/SC RAID controller with  "
-					"firmware\nmegaraid: 3.00 or 3.01.  "
-					"This driver is known to have "
-					"corruption issues\nmegaraid: with "
-					"those firmware versions on this "
-					"specific card.  In order\nmegaraid: "
-					"to protect your data, please upgrade "
-					"your firmware to version\nmegaraid: "
-					"3.10 or later, available from the "
-					"Dell Technical Support web\n"
-					"megaraid: site at\nhttp://support."
-					"dell.com/us/en/filelib/download/"
-					"index.asp?fileid=2940\n"
-				);
-			}
-		}
-
-		/*
-		 * If we have a HP 1M(0x60E7)/2M(0x60E8) controller with
-		 * firmware H.01.07, H.01.08, and H.01.09 disable 64 bit
-		 * support, since this firmware cannot handle 64 bit
-		 * addressing
-		 */
-
-		if((subsysvid == HP_SUBSYS_VID) &&
-				((subsysid == 0x60E7)||(subsysid == 0x60E8))) {
-
-			/*
-			 * which firmware
-			 */
-			if( !strcmp(adapter->fw_version, "H01.07") ||
-				!strcmp(adapter->fw_version, "H01.08") ||
-				!strcmp(adapter->fw_version, "H01.09") ) {
-
-				printk(KERN_WARNING
-					"megaraid: Firmware H.01.07, "
-					"H.01.08, and H.01.09 on 1M/2M "
-					"controllers\n"
-					"megaraid: do not support 64 bit "
-					"addressing.\nmegaraid: DISABLING "
-					"64 bit support.\n");
-				adapter->flag &= ~BOARD_64BIT;
-			}
-		}
-
-
-		if(mega_is_bios_enabled(adapter)) {
-			mega_hbas[hba_count].is_bios_enabled = 1;
-		}
-		mega_hbas[hba_count].hostdata_addr = adapter;
-
-		/*
-		 * Find out which channel is raid and which is scsi. This is
-		 * for ROMB support.
-		 */
-		mega_enum_raid_scsi(adapter);
-
-		/*
-		 * Find out if a logical drive is set as the boot drive. If
-		 * there is one, will make that as the first logical drive.
-		 * ROMB: Do we have to boot from a physical drive. Then all
-		 * the physical drives would appear before the logical disks.
-		 * Else, all the physical drives would be exported to the mid
-		 * layer after logical drives.
-		 */
-		mega_get_boot_drv(adapter);
-
-		if( ! adapter->boot_pdrv_enabled ) {
-			for( i = 0; i < NVIRT_CHAN; i++ )
-				adapter->logdrv_chan[i] = 1;
-
-			for( i = NVIRT_CHAN; i<MAX_CHANNELS+NVIRT_CHAN; i++ )
-				adapter->logdrv_chan[i] = 0;
-
-			adapter->mega_ch_class <<= NVIRT_CHAN;
-		}
-		else {
-			j = adapter->product_info.nchannels;
-			for( i = 0; i < j; i++ )
-				adapter->logdrv_chan[i] = 0;
-
-			for( i = j; i < NVIRT_CHAN + j; i++ )
-				adapter->logdrv_chan[i] = 1;
-		}
-
-
-		/*
-		 * Do we support random deletion and addition of logical
-		 * drives
-		 */
-		adapter->read_ldidmap = 0;	/* set it after first logdrv
-						   delete cmd */
-		adapter->support_random_del = mega_support_random_del(adapter);
-
-		/* Initialize SCBs */
-		if(mega_init_scb(adapter)) {
-			goto fail_attach;
-		}
-
-		/*
-		 * Reset the pending commands counter
-		 */
-		atomic_set(&adapter->pend_cmds, 0);
-
-		/*
-		 * Reset the adapter quiescent flag
-		 */
-		atomic_set(&adapter->quiescent, 0);
-
-		hba_soft_state[hba_count] = adapter;
-
-		/*
-		 * Fill in the structure which needs to be passed back to the
-		 * application when it does an ioctl() for controller related
-		 * information.
-		 */
-		i = hba_count;
-
-		mcontroller[i].base = mega_baseport;
-		mcontroller[i].irq = irq;
-		mcontroller[i].numldrv = adapter->numldrv;
-		mcontroller[i].pcibus = pci_bus;
-		mcontroller[i].pcidev = pci_device;
-		mcontroller[i].pcifun = PCI_FUNC (pci_dev_func);
-		mcontroller[i].pciid = -1;
-		mcontroller[i].pcivendor = pci_vendor;
-		mcontroller[i].pcislot = PCI_SLOT (pci_dev_func);
-		mcontroller[i].uid = (pci_bus << 8) | pci_dev_func;
-
-
-		/* Set the Mode of addressing to 64 bit if we can */
-		if((adapter->flag & BOARD_64BIT)&&(sizeof(dma_addr_t) == 8)) {
-			pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
-			adapter->has_64bit_addr = 1;
-		}
-		else  {
-			pci_set_dma_mask(pdev, 0xffffffff);
-			adapter->has_64bit_addr = 0;
-		}
-		
-		init_MUTEX(&adapter->int_mtx);
-		init_waitqueue_head(&adapter->int_waitq);
-
-		adapter->this_id = DEFAULT_INITIATOR_ID;
-		adapter->host->this_id = DEFAULT_INITIATOR_ID;
-
-#if MEGA_HAVE_CLUSTERING
-		/*
-		 * Is cluster support enabled on this controller
-		 * Note: In a cluster the HBAs ( the initiators ) will have
-		 * different target IDs and we cannot assume it to be 7. Call
-		 * to mega_support_cluster() will get the target ids also if
-		 * the cluster support is available
-		 */
-		adapter->has_cluster = mega_support_cluster(adapter);
-
-		if( adapter->has_cluster ) {
-			printk(KERN_NOTICE
-				"megaraid: Cluster driver, initiator id:%d\n",
-				adapter->this_id);
-		}
-#endif
-
-		hba_count++;
-		continue;
-
-fail_attach:
-		if( did_setup_mbox_f ) {
-			pci_free_consistent(adapter->dev, sizeof(mbox64_t),
-					(void *)adapter->una_mbox64,
-					adapter->una_mbox64_dma);
-		}
-
-		if( got_irq_f ) {
-			irq_disable(adapter);
-			free_irq(adapter->host->irq, adapter);
-		}
-
-		if( alloc_scb_f ) {
-			kfree(adapter->scb_list);
-		}
-
-		if( alloc_int_buf_f ) {
-			pci_free_consistent(adapter->dev, MEGA_BUFFER_SIZE,
-					(void *)adapter->mega_buffer,
-					adapter->buf_dma_handle);
-		}
-
-		if( did_scsi_reg_f ) scsi_unregister(host);
-
-		if( did_ioremap_f ) {
-			iounmap((void *)mega_baseport);
-			release_mem_region(tbase, 128);
-		}
-
-		if( did_req_region_f )
-			release_region(mega_baseport, 16);
-	}
-
-	return;
-}
-
-
 /**
  * mega_setup_mailbox()
  * @adapter - pointer to our soft state
@@ -2396,126 +1853,6 @@
 		enquiry3->pdrv_state[i] = inquiry->pdrv_info.pdrv_state[i];
 }
 
-/*
- * Release the controller's resources
- */
-static int
-megaraid_release(struct Scsi_Host *host)
-{
-	adapter_t	*adapter;
-	mbox_t	*mbox;
-	u_char	raw_mbox[sizeof(struct mbox_out)];
-	char	buf[12] = { 0 };
-
-	adapter = (adapter_t *)host->hostdata;
-	mbox = (mbox_t *)raw_mbox;
-
-	printk(KERN_NOTICE "megaraid: being unloaded...");
-
-	/* Flush adapter cache */
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
-	raw_mbox[0] = FLUSH_ADAPTER;
-
-	irq_disable(adapter);
-	free_irq(adapter->host->irq, adapter);
-
-	/* Issue a blocking (interrupts disabled) command to the card */
-	issue_scb_block(adapter, raw_mbox);
-
-	/* Flush disks cache */
-	memset(&mbox->m_out, 0, sizeof(raw_mbox));
-	raw_mbox[0] = FLUSH_SYSTEM;
-
-	/* Issue a blocking (interrupts disabled) command to the card */
-	issue_scb_block(adapter, raw_mbox);
-
-
-	/* Free our resources */
-	if( adapter->flag & BOARD_MEMMAP ) {
-		iounmap((void *)adapter->base);
-		release_mem_region(adapter->host->base, 128);
-	}
-	else {
-		release_region(adapter->base, 16);
-	}
-
-	mega_free_sgl(adapter);
-
-#ifdef CONFIG_PROC_FS
-	if( adapter->controller_proc_dir_entry ) {
-		remove_proc_entry("stat", adapter->controller_proc_dir_entry);
-		remove_proc_entry("config",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("mailbox",
-				adapter->controller_proc_dir_entry);
-#if MEGA_HAVE_ENH_PROC
-		remove_proc_entry("rebuild-rate",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("battery-status",
-				adapter->controller_proc_dir_entry);
-
-		remove_proc_entry("diskdrives-ch0",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch1",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch2",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("diskdrives-ch3",
-				adapter->controller_proc_dir_entry);
-
-		remove_proc_entry("raiddrives-0-9",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-10-19",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-20-29",
-				adapter->controller_proc_dir_entry);
-		remove_proc_entry("raiddrives-30-39",
-				adapter->controller_proc_dir_entry);
-#endif
-
-		sprintf(buf, "hba%d", adapter->host->host_no);
-		remove_proc_entry(buf, mega_proc_dir_entry);
-	}
-#endif
-
-	pci_free_consistent(adapter->dev, MEGA_BUFFER_SIZE,
-			adapter->mega_buffer, adapter->buf_dma_handle);
-	kfree(adapter->scb_list);
-	pci_free_consistent(adapter->dev, sizeof(mbox64_t),
-			(void *)adapter->una_mbox64, adapter->una_mbox64_dma);
-
-	hba_count--;
-
-	if( hba_count == 0 ) {
-
-		/*
-		 * Unregister the character device interface to the driver.
-		 */
-		unregister_chrdev(major, "megadev");
-
-		unregister_reboot_notifier(&mega_notifier);
-
-#ifdef CONFIG_PROC_FS
-		if( adapter->controller_proc_dir_entry ) {
-			remove_proc_entry ("megaraid", &proc_root);
-		}
-#endif
-
-	}
-
-	/*
-	 * Release the controller memory. A word of warning this frees
-	 * hostdata and that includes adapter-> so be careful what you
-	 * dereference beyond this point
-	 */
-	scsi_unregister(host);
-
-
-	printk("ok.\n");
-
-	return 0;
-}
-
 static inline void
 mega_free_sgl(adapter_t *adapter)
 {
@@ -3850,76 +3187,6 @@
 }
 
 /**
- * megaraid_reboot_notify()
- * @this - unused
- * @code - shutdown code
- * @unused - unused
- *
- * This routine will be called when the use has done a forced shutdown on the
- * system. Flush the Adapter and disks cache.
- */
-static int
-megaraid_reboot_notify (struct notifier_block *this, unsigned long code,
-		void *unused)
-{
-	adapter_t *adapter;
-	struct Scsi_Host *host;
-	u8 raw_mbox[sizeof(struct mbox_out)];
-	mbox_t *mbox;
-	int i,j;
-
-	/*
-	 * Flush the controller's cache irrespective of the codes coming down.
-	 * SYS_DOWN, SYS_HALT, SYS_RESTART, SYS_POWER_OFF
-	 */
-	for( i = 0; i < hba_count; i++ ) {
-		printk(KERN_INFO "megaraid: flushing adapter %d..", i);
-		host = hba_soft_state[i]->host;
-
-		adapter = (adapter_t *)host->hostdata;
-		mbox = (mbox_t *)raw_mbox;
-
-		/* Flush adapter cache */
-		memset(&mbox->m_out, 0, sizeof(raw_mbox));
-		raw_mbox[0] = FLUSH_ADAPTER;
-
-		irq_disable(adapter);
-		free_irq(adapter->host->irq, adapter);
-
-		/*
-		 * Issue a blocking (interrupts disabled) command to
-		 * the card
-		 */
-		issue_scb_block(adapter, raw_mbox);
-
-		/* Flush disks cache */
-		memset(&mbox->m_out, 0, sizeof(raw_mbox));
-		raw_mbox[0] = FLUSH_SYSTEM;
-
-		issue_scb_block(adapter, raw_mbox);
-
-		printk("Done.\n");
-
-		if( atomic_read(&adapter->pend_cmds) > 0 ) {
-			printk(KERN_WARNING "megaraid: pending commands!!\n");
-		}
-	}
-
-	/*
-	 * Have a delibrate delay to make sure all the caches are
-	 * actually flushed.
-	 */
-	printk("megaraid: cache flush delay: ");
-	for( j = 10; j >= 0; j-- ) {
-		printk("[%d] ", j);
-		mdelay(1000);
-	}
-	printk("\n");
-
-	return NOTIFY_DONE;
-}
-
-/**
  * mega_init_scb()
  * @adapter - pointer to our soft state
  *
@@ -5345,24 +4612,553 @@
 	kfree(pdev);
 }
 
-static Scsi_Host_Template driver_template = {
-	.name =				"MegaRAID",
-	.detect =			megaraid_detect,
-	.release =			megaraid_release,
-	.info =				megaraid_info,
-	.queuecommand =			megaraid_queue,	
-	.bios_param =			megaraid_biosparam,
-	.max_sectors =			MAX_SECTORS_PER_IO,
-	.can_queue =			MAX_COMMANDS,
-	.this_id =			DEFAULT_INITIATOR_ID,
-	.sg_tablesize =			MAX_SGLIST,
-	.cmd_per_lun =			DEF_CMD_PER_LUN,
-	.use_clustering =		ENABLE_CLUSTERING,
-	.eh_abort_handler =		megaraid_abort,
-	.eh_device_reset_handler =	megaraid_reset,
-	.eh_bus_reset_handler =		megaraid_reset,
-	.eh_host_reset_handler =	megaraid_reset,
+static struct scsi_host_template megaraid_template = {
+	.name				= "MegaRAID",
+	.proc_name			= "megaraid",
+	.info				= megaraid_info,
+	.queuecommand			= megaraid_queue,	
+	.bios_param			= megaraid_biosparam,
+	.max_sectors			= MAX_SECTORS_PER_IO,
+	.can_queue			= MAX_COMMANDS,
+	.this_id			= DEFAULT_INITIATOR_ID,
+	.sg_tablesize			= MAX_SGLIST,
+	.cmd_per_lun			= DEF_CMD_PER_LUN,
+	.use_clustering			= ENABLE_CLUSTERING,
+	.eh_abort_handler		= megaraid_abort,
+	.eh_device_reset_handler	= megaraid_reset,
+	.eh_bus_reset_handler		= megaraid_reset,
+	.eh_host_reset_handler		= megaraid_reset,
 };
-#include "scsi_module.c"
+
+static int __devinit
+megaraid_probe_one(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct Scsi_Host *host;
+	adapter_t *adapter;
+	unsigned long mega_baseport, tbase, flag = 0;
+	u16 subsysid, subsysvid;
+	u8 pci_bus, pci_dev_func;
+	int irq, i, j;
+	int error = -ENODEV;
+
+	if (pci_enable_device(pdev))
+		goto out;
+
+	pci_bus = pdev->bus->number;
+	pci_dev_func = pdev->devfn;
+
+	/*
+	 * For these vendor and device ids, signature offsets are not
+	 * valid and 64 bit is implicit
+	 */
+	if (id->driver_data & BOARD_64BIT)
+		flag |= BOARD_64BIT;
+	else {
+		u32 magic64;
+
+		pci_read_config_dword(pdev, PCI_CONF_AMISIG64, &magic64);
+		if (magic64 == HBA_SIGNATURE_64BIT)
+			flag |= BOARD_64BIT;
+	}
+
+	subsysvid = pdev->subsystem_vendor;
+	subsysid = pdev->subsystem_device;
+
+	printk(KERN_NOTICE "megaraid: found 0x%4.04x:0x%4.04x:bus %d:",
+		id->vendor, id->device, pci_bus);
+
+	printk("slot %d:func %d\n",
+		PCI_SLOT(pci_dev_func), PCI_FUNC(pci_dev_func));
+
+	/* Read the base port and IRQ from PCI */
+	mega_baseport = pci_resource_start(pdev, 0);
+	irq = pdev->irq;
+
+	tbase = mega_baseport;
+	if (pci_resource_flags(pdev, 0) & IORESOURCE_MEM) {
+		flag |= BOARD_MEMMAP;
+
+		if (!request_mem_region(mega_baseport, 128, "megaraid")) {
+			printk(KERN_WARNING "megaraid: mem region busy!\n");
+			goto out_disable_device;
+		}
+
+		mega_baseport = (unsigned long)ioremap(mega_baseport, 128);
+		if (!mega_baseport) {
+			printk(KERN_WARNING
+			       "megaraid: could not map hba memory\n");
+			goto out_release_region;
+		}
+	} else {
+		flag |= BOARD_IOMAP;
+		mega_baseport += 0x10;
+
+		if (!request_region(mega_baseport, 16, "megaraid"))
+			goto out_disable_device;
+	}
+
+	/* Initialize SCSI Host structure */
+	host = scsi_host_alloc(&megaraid_template, sizeof(adapter_t));
+	if (!host)
+		goto out_iounmap;
+
+	adapter = (adapter_t *)host->hostdata;
+	memset(adapter, 0, sizeof(adapter_t));
+
+	printk(KERN_NOTICE
+		"scsi%d:Found MegaRAID controller at 0x%lx, IRQ:%d\n",
+		host->host_no, mega_baseport, irq);
+
+	adapter->base = mega_baseport;
+
+	INIT_LIST_HEAD(&adapter->free_list);
+	INIT_LIST_HEAD(&adapter->pending_list);
+	INIT_LIST_HEAD(&adapter->completed_list);
+
+	adapter->flag = flag;
+	spin_lock_init(&adapter->lock);
+	scsi_assign_lock(host, &adapter->lock);
+
+	host->cmd_per_lun = max_cmd_per_lun;
+	host->max_sectors = max_sectors_per_io;
+
+	adapter->dev = pdev;
+	adapter->host = host;
+
+	adapter->host->irq = irq;
+
+	if (flag & BOARD_MEMMAP)
+		adapter->host->base = tbase;
+	else {
+		adapter->host->io_port = tbase;
+		adapter->host->n_io_port = 16;
+	}
+
+	adapter->host->unique_id = (pci_bus << 8) | pci_dev_func;
+
+	/*
+	 * Allocate buffer to issue internal commands.
+	 */
+	adapter->mega_buffer = pci_alloc_consistent(adapter->dev,
+		MEGA_BUFFER_SIZE, &adapter->buf_dma_handle);
+	if (!adapter->mega_buffer) {
+		printk(KERN_WARNING "megaraid: out of RAM.\n");
+		goto out_host_put;
+	}
+
+	adapter->scb_list = kmalloc(sizeof(scb_t) * MAX_COMMANDS, GFP_KERNEL);
+	if (!adapter->scb_list) {
+		printk(KERN_WARNING "megaraid: out of RAM.\n");
+		goto out_free_cmd_buffer;
+	}
+
+	if (request_irq(irq, (adapter->flag & BOARD_MEMMAP) ?
+				megaraid_isr_memmapped : megaraid_isr_iomapped,
+					SA_SHIRQ, "megaraid", adapter)) {
+		printk(KERN_WARNING
+			"megaraid: Couldn't register IRQ %d!\n", irq);
+		goto out_free_scb_list;
+	}
+
+	if (mega_setup_mailbox(adapter))
+		goto out_free_irq;
+
+	if (mega_query_adapter(adapter))
+		goto out_free_mbox;
+
+	/*
+	 * Have checks for some buggy f/w
+	 */
+	if ((subsysid == 0x1111) && (subsysvid == 0x1111)) {
+		/*
+		 * Which firmware
+		 */
+		if (!strcmp(adapter->fw_version, "3.00") ||
+				!strcmp(adapter->fw_version, "3.01")) {
+
+			printk( KERN_WARNING
+				"megaraid: Your  card is a Dell PERC "
+				"2/SC RAID controller with  "
+				"firmware\nmegaraid: 3.00 or 3.01.  "
+				"This driver is known to have "
+				"corruption issues\nmegaraid: with "
+				"those firmware versions on this "
+				"specific card.  In order\nmegaraid: "
+				"to protect your data, please upgrade "
+				"your firmware to version\nmegaraid: "
+				"3.10 or later, available from the "
+				"Dell Technical Support web\n"
+				"megaraid: site at\nhttp://support."
+				"dell.com/us/en/filelib/download/"
+				"index.asp?fileid=2940\n"
+			);
+		}
+	}
+
+	/*
+	 * If we have a HP 1M(0x60E7)/2M(0x60E8) controller with
+	 * firmware H.01.07, H.01.08, and H.01.09 disable 64 bit
+	 * support, since this firmware cannot handle 64 bit
+	 * addressing
+	 */
+	if ((subsysvid == HP_SUBSYS_VID) &&
+	    ((subsysid == 0x60E7) || (subsysid == 0x60E8))) {
+		/*
+		 * which firmware
+		 */
+		if (!strcmp(adapter->fw_version, "H01.07") ||
+		    !strcmp(adapter->fw_version, "H01.08") ||
+		    !strcmp(adapter->fw_version, "H01.09") ) {
+			printk(KERN_WARNING
+				"megaraid: Firmware H.01.07, "
+				"H.01.08, and H.01.09 on 1M/2M "
+				"controllers\n"
+				"megaraid: do not support 64 bit "
+				"addressing.\nmegaraid: DISABLING "
+				"64 bit support.\n");
+			adapter->flag &= ~BOARD_64BIT;
+		}
+	}
+
+	if (mega_is_bios_enabled(adapter))
+		mega_hbas[hba_count].is_bios_enabled = 1;
+	mega_hbas[hba_count].hostdata_addr = adapter;
+
+	/*
+	 * Find out which channel is raid and which is scsi. This is
+	 * for ROMB support.
+	 */
+	mega_enum_raid_scsi(adapter);
+
+	/*
+	 * Find out if a logical drive is set as the boot drive. If
+	 * there is one, will make that as the first logical drive.
+	 * ROMB: Do we have to boot from a physical drive. Then all
+	 * the physical drives would appear before the logical disks.
+	 * Else, all the physical drives would be exported to the mid
+	 * layer after logical drives.
+	 */
+	mega_get_boot_drv(adapter);
+
+	if (adapter->boot_pdrv_enabled) {
+		j = adapter->product_info.nchannels;
+		for( i = 0; i < j; i++ )
+			adapter->logdrv_chan[i] = 0;
+		for( i = j; i < NVIRT_CHAN + j; i++ )
+			adapter->logdrv_chan[i] = 1;
+	} else {
+		for (i = 0; i < NVIRT_CHAN; i++)
+			adapter->logdrv_chan[i] = 1;
+		for (i = NVIRT_CHAN; i < MAX_CHANNELS+NVIRT_CHAN; i++)
+			adapter->logdrv_chan[i] = 0;
+		adapter->mega_ch_class <<= NVIRT_CHAN;
+	}
+
+	/*
+	 * Do we support random deletion and addition of logical
+	 * drives
+	 */
+	adapter->read_ldidmap = 0;	/* set it after first logdrv
+						   delete cmd */
+	adapter->support_random_del = mega_support_random_del(adapter);
+
+	/* Initialize SCBs */
+	if (mega_init_scb(adapter))
+		goto out_free_mbox;
+
+	/*
+	 * Reset the pending commands counter
+	 */
+	atomic_set(&adapter->pend_cmds, 0);
+
+	/*
+	 * Reset the adapter quiescent flag
+	 */
+	atomic_set(&adapter->quiescent, 0);
+
+	hba_soft_state[hba_count] = adapter;
+
+	/*
+	 * Fill in the structure which needs to be passed back to the
+	 * application when it does an ioctl() for controller related
+	 * information.
+	 */
+	i = hba_count;
+
+	mcontroller[i].base = mega_baseport;
+	mcontroller[i].irq = irq;
+	mcontroller[i].numldrv = adapter->numldrv;
+	mcontroller[i].pcibus = pci_bus;
+	mcontroller[i].pcidev = id->device;
+	mcontroller[i].pcifun = PCI_FUNC (pci_dev_func);
+	mcontroller[i].pciid = -1;
+	mcontroller[i].pcivendor = id->vendor;
+	mcontroller[i].pcislot = PCI_SLOT(pci_dev_func);
+	mcontroller[i].uid = (pci_bus << 8) | pci_dev_func;
+
+
+	/* Set the Mode of addressing to 64 bit if we can */
+	if ((adapter->flag & BOARD_64BIT) && (sizeof(dma_addr_t) == 8)) {
+		pci_set_dma_mask(pdev, 0xffffffffffffffffULL);
+		adapter->has_64bit_addr = 1;
+	} else  {
+		pci_set_dma_mask(pdev, 0xffffffff);
+		adapter->has_64bit_addr = 0;
+	}
+		
+	init_MUTEX(&adapter->int_mtx);
+	init_waitqueue_head(&adapter->int_waitq);
+
+	adapter->this_id = DEFAULT_INITIATOR_ID;
+	adapter->host->this_id = DEFAULT_INITIATOR_ID;
+
+#if MEGA_HAVE_CLUSTERING
+	/*
+	 * Is cluster support enabled on this controller
+	 * Note: In a cluster the HBAs ( the initiators ) will have
+	 * different target IDs and we cannot assume it to be 7. Call
+	 * to mega_support_cluster() will get the target ids also if
+	 * the cluster support is available
+	 */
+	adapter->has_cluster = mega_support_cluster(adapter);
+	if (adapter->has_cluster) {
+		printk(KERN_NOTICE
+			"megaraid: Cluster driver, initiator id:%d\n",
+			adapter->this_id);
+	}
+#endif
+
+	pci_set_drvdata(pdev, host);
+
+	mega_create_proc_entry(hba_count, mega_proc_dir_entry);
+
+	error = scsi_add_host(host, &pdev->dev);
+	if (error)
+		goto out_free_mbox;
+
+	scsi_scan_host(host);
+	hba_count++;
+	return 0;
+
+ out_free_mbox:
+	pci_free_consistent(adapter->dev, sizeof(mbox64_t),
+			adapter->una_mbox64, adapter->una_mbox64_dma);
+ out_free_irq:
+	free_irq(adapter->host->irq, adapter);
+ out_free_scb_list:
+	kfree(adapter->scb_list);
+ out_free_cmd_buffer:
+	pci_free_consistent(adapter->dev, MEGA_BUFFER_SIZE,
+			adapter->mega_buffer, adapter->buf_dma_handle);
+ out_host_put:
+	scsi_host_put(host);
+ out_iounmap:
+	if (flag & BOARD_MEMMAP)
+		iounmap((void *)mega_baseport);
+ out_release_region:
+	if (flag & BOARD_MEMMAP)
+		release_mem_region(tbase, 128);
+	else
+		release_region(mega_baseport, 16);
+ out_disable_device:
+	pci_disable_device(pdev);
+ out:
+	return error;
+}
+
+static void
+__megaraid_shutdown(adapter_t *adapter)
+{
+	u_char	raw_mbox[sizeof(struct mbox_out)];
+	mbox_t	*mbox = (mbox_t *)raw_mbox;
+	int	i;
+
+	/* Flush adapter cache */
+	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	raw_mbox[0] = FLUSH_ADAPTER;
+
+	free_irq(adapter->host->irq, adapter);
+
+	/* Issue a blocking (interrupts disabled) command to the card */
+	issue_scb_block(adapter, raw_mbox);
+
+	/* Flush disks cache */
+	memset(&mbox->m_out, 0, sizeof(raw_mbox));
+	raw_mbox[0] = FLUSH_SYSTEM;
+
+	/* Issue a blocking (interrupts disabled) command to the card */
+	issue_scb_block(adapter, raw_mbox);
+	
+	if (atomic_read(&adapter->pend_cmds) > 0)
+		printk(KERN_WARNING "megaraid: pending commands!!\n");
+
+	/*
+	 * Have a delibrate delay to make sure all the caches are
+	 * actually flushed.
+	 */
+	for (i = 0; i <= 10; i++)
+		mdelay(1000);
+}
+
+static void
+megaraid_remove_one(struct pci_dev *pdev)
+{
+	struct Scsi_Host *host = pci_get_drvdata(pdev);
+	adapter_t *adapter = (adapter_t *)host->hostdata;
+	char	buf[12] = { 0 };
+
+	scsi_remove_host(host);
+
+	__megaraid_shutdown(adapter);
+
+	/* Free our resources */
+	if (adapter->flag & BOARD_MEMMAP) {
+		iounmap((void *)adapter->base);
+		release_mem_region(adapter->host->base, 128);
+	} else
+		release_region(adapter->base, 16);
+
+	mega_free_sgl(adapter);
+
+#ifdef CONFIG_PROC_FS
+	if (adapter->controller_proc_dir_entry) {
+		remove_proc_entry("stat", adapter->controller_proc_dir_entry);
+		remove_proc_entry("config",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("mailbox",
+				adapter->controller_proc_dir_entry);
+#if MEGA_HAVE_ENH_PROC
+		remove_proc_entry("rebuild-rate",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("battery-status",
+				adapter->controller_proc_dir_entry);
+
+		remove_proc_entry("diskdrives-ch0",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("diskdrives-ch1",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("diskdrives-ch2",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("diskdrives-ch3",
+				adapter->controller_proc_dir_entry);
+
+		remove_proc_entry("raiddrives-0-9",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("raiddrives-10-19",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("raiddrives-20-29",
+				adapter->controller_proc_dir_entry);
+		remove_proc_entry("raiddrives-30-39",
+				adapter->controller_proc_dir_entry);
+#endif
+		sprintf(buf, "hba%d", adapter->host->host_no);
+		remove_proc_entry(buf, mega_proc_dir_entry);
+	}
+#endif
+
+	pci_free_consistent(adapter->dev, MEGA_BUFFER_SIZE,
+			adapter->mega_buffer, adapter->buf_dma_handle);
+	kfree(adapter->scb_list);
+	pci_free_consistent(adapter->dev, sizeof(mbox64_t),
+			adapter->una_mbox64, adapter->una_mbox64_dma);
+
+	scsi_host_put(host);
+	pci_disable_device(pdev);
+
+	hba_count--;
+}
+
+static void
+megaraid_shutdown(struct device *dev)
+{
+	struct Scsi_Host *host = pci_get_drvdata(to_pci_dev(dev));
+	adapter_t *adapter = (adapter_t *)host->hostdata;
+
+	__megaraid_shutdown(adapter);
+}
+
+static struct pci_device_id megaraid_pci_tbl[] = {
+	{PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_DISCOVERY,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_DELL, PCI_DEVICE_ID_PERC4_DI,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, BOARD_64BIT},
+	{PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_PERC4_QC_VERDE,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, BOARD_64BIT},
+	{PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID2,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_AMI, PCI_DEVICE_ID_AMI_MEGARAID3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_AMI_MEGARAID3,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{PCI_VENDOR_ID_LSI_LOGIC, PCI_DEVICE_ID_AMI_MEGARAID,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, megaraid_pci_tbl);
+
+static struct pci_driver megaraid_pci_driver = {
+	.name		= "megaraid",
+	.id_table	= megaraid_pci_tbl,
+	.probe		= megaraid_probe_one,
+	.remove		= __devexit_p(megaraid_remove_one),
+	.driver		= {
+		.shutdown = megaraid_shutdown,
+	},
+};
+
+static int __init megaraid_init(void)
+{
+	int error;
+
+	if ((max_cmd_per_lun <= 0) || (max_cmd_per_lun > MAX_CMD_PER_LUN))
+		max_cmd_per_lun = MAX_CMD_PER_LUN;
+	if (max_mbox_busy_wait > MBOX_BUSY_WAIT)
+		max_mbox_busy_wait = MBOX_BUSY_WAIT;
+
+	error = pci_module_init(&megaraid_pci_driver);
+	if (error) 
+		return error;
+	
+#ifdef CONFIG_PROC_FS
+	mega_proc_dir_entry = proc_mkdir("megaraid", &proc_root);
+	if (!mega_proc_dir_entry) {
+		printk(KERN_WARNING
+				"megaraid: failed to create megaraid root\n");
+	}
+#endif
+
+	/*
+	 * Register the driver as a character device, for applications
+	 * to access it for ioctls.
+	 * First argument (major) to register_chrdev implies a dynamic
+	 * major number allocation.
+	 */
+	major = register_chrdev(0, "megadev", &megadev_fops);
+	if (!major) {
+		printk(KERN_WARNING
+				"megaraid: failed to register char device\n");
+	}
+
+	return 0;
+}
+
+static void __exit megaraid_exit(void)
+{
+	/*
+	 * Unregister the character device interface to the driver.
+	 */
+	unregister_chrdev(major, "megadev");
+
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("megaraid", &proc_root);
+#endif
+
+	pci_unregister_driver(&megaraid_pci_driver);
+}
+
+module_init(megaraid_init);
+module_exit(megaraid_exit);
 
 /* vi: set ts=8 sw=8 tw=78: */
===== drivers/scsi/megaraid.h 1.23 vs edited =====
--- 1.23/drivers/scsi/megaraid.h	Thu Nov 13 07:56:20 2003
+++ edited/drivers/scsi/megaraid.h	Mon Nov 17 22:14:23 2003
@@ -989,8 +989,6 @@
 
 const char *megaraid_info (struct Scsi_Host *);
 
-static int megaraid_detect(Scsi_Host_Template *);
-static void mega_find_card(Scsi_Host_Template *, u16, u16);
 static int mega_query_adapter(adapter_t *);
 static inline int issue_scb(adapter_t *, scb_t *);
 static int mega_setup_mailbox(adapter_t *);
@@ -1007,7 +1005,6 @@
 
 static void mega_free_scb(adapter_t *, scb_t *);
 
-static int megaraid_release (struct Scsi_Host *);
 static int megaraid_abort(Scsi_Cmnd *);
 static int megaraid_reset(Scsi_Cmnd *);
 static int megaraid_abort_and_reset(adapter_t *, Scsi_Cmnd *, int);
@@ -1025,8 +1022,6 @@
 static void mega_8_to_40ld (mraid_inquiry *inquiry,
 		mega_inquiry3 *enquiry3, mega_product_info *);
 
-static int megaraid_reboot_notify (struct notifier_block *,
-				   unsigned long, void *);
 static int megadev_open (struct inode *, struct file *);
 static int megadev_ioctl (struct inode *, struct file *, unsigned int,
 		unsigned long);
