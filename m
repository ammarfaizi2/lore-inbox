Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVCGWbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVCGWbN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 17:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVCGW3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 17:29:37 -0500
Received: from mail0.lsil.com ([147.145.40.20]:50345 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S261813AbVCGV2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 16:28:06 -0500
Message-ID: <0E3FA95632D6D047BA649F95DAB60E570230CC0E@exa-atlanta>
From: "Bagalkote, Sreenivas" <sreenib@lsil.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Cc: "'James Bottomley'" <James.Bottomley@SteelEye.com>,
       "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>,
       Andrew Morton <akpm@osdl.org>,
       "'Christoph Hellwig'" <hch@infradead.org>
Subject: [ANNOUNCE][PATCH 2.6.11 2/3] megaraid_sas: Announcing new module 
	for LSI Logic's SAS based MegaRAID controllers
Date: Mon, 7 Mar 2005 16:12:57 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 3:

diff -Naur linux-2.6.11-orig/drivers/scsi/megaraid/megaraid_sas.c
linux-2.6.11/drivers/scsi/megaraid/megaraid_sas.c
--- linux-2.6.11-orig/drivers/scsi/megaraid/megaraid_sas.c	1969-12-31
19:00:00.000000000 -0500
+++ linux-2.6.11/drivers/scsi/megaraid/megaraid_sas.c	2005-03-05
21:41:59.394225144 -0500
@@ -0,0 +1,2746 @@
+/*
+ *
+ *		Linux MegaRAID driver for SAS based RAID controllers
+ *
+ * Copyright (c) 2003-2005  LSI Logic Corporation.
+ *
+ *	   This program is free software; you can redistribute it and/or
+ *	   modify it under the terms of the GNU General Public License
+ *	   as published by the Free Software Foundation; either version
+ *	   2 of the License, or (at your option) any later version.
+ *
+ * FILE		: megaraid_sas.c
+ * Version	: v00.00.01.00
+ *
+ * Authors:
+ * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
+ *
+ * List of supported controllers
+ *
+ * OEM	Product Name			VID	DID	SSVID	SSID
+ * ---	------------			---	---	----	----
+ */
+
+#include "megaraid_sas.h"
+
+static int	megasas_init			(void);
+static void	megasas_exit			(void);
+
+static int	megasas_probe_one		(struct pci_dev*, 
+						const struct
pci_device_id*);
+static void	megasas_detach_one		(struct pci_dev*);
+static void	megasas_shutdown		(struct device*);
+static void	megasas_flush_cache		(struct megasas_instance*);
+static void	megasas_shutdown_controller	(struct megasas_instance*);
+
+static int	megasas_init_mfi		(struct megasas_instance*);
+static void	megasas_reset_mfi		(struct megasas_instance*);
+
+static int	megasas_transition_to_ready	(struct
megasas_register_set*);
+
+static int	megasas_alloc_cmds		(struct megasas_instance*);
+static void	megasas_free_cmds		(struct megasas_instance*);
+static int	megasas_create_frame_pool	(struct megasas_instance*);
+static void	megasas_teardown_frame_pool	(struct megasas_instance*);
+
+static int	megasas_start_aen		(struct megasas_instance*);
+static int	megasas_get_seq_num		(struct megasas_instance*, 
+						struct
megasas_evt_log_info*);
+static int	megasas_register_aen		(struct megasas_instance*,
+						uint32_t, uint32_t);
+static void	megasas_service_aen		(struct megasas_instance*,
+						struct megasas_cmd*);
+
+static int	megasas_io_attach		(struct megasas_instance*);
+static void	megasas_io_detach		(struct megasas_instance*);
+
+static int	megasas_abort_handler		(struct scsi_cmnd*);
+static int	megasas_reset_handler		(struct scsi_cmnd*);
+static int	megasas_queue_command		(struct scsi_cmnd*,
+						void (*) (struct
scsi_cmnd*));
+
+static int	megasas_issue_polled		(struct megasas_instance*, 
+						struct megasas_cmd*);
+static int	megasas_issue_blocked_cmd	(struct megasas_instance*,
+						struct megasas_cmd*);
+
+static int	megasas_sync_abort_cmd		(struct megasas_instance*,
+						struct megasas_cmd*);
+static void	megasas_complete_abort		(struct megasas_instance*,
+						struct megasas_cmd*);
+
+static struct megasas_cmd* megasas_build_cmd	(struct megasas_instance*, 
+						struct scsi_cmnd*, int*);
+static int	megasas_build_dcdb		(struct megasas_instance*, 
+						struct scsi_cmnd*,
+						struct megasas_cmd*);
+static int	megasas_build_ldio		(struct megasas_instance*,
+						struct scsi_cmnd*,
+						struct megasas_cmd*);
+
+static int	megasas_make_sgl32		(struct megasas_instance*,
+						struct scsi_cmnd*, 
+						union megasas_sgl*);
+static int	megasas_make_sgl64		(struct megasas_instance*,
+						struct scsi_cmnd*, 
+						union megasas_sgl*);
+
+static irqreturn_t megasas_isr			(int, void *, struct pt_regs
*);
+static void	megasas_complete_cmd		(struct megasas_instance*, 
+						struct megasas_cmd*);
+static void	megasas_complete_int_cmd	(struct megasas_instance*, 
+						struct megasas_cmd*);
+
+static int	megasas_mgmt_open		(struct inode*, struct
file*);
+static int	megasas_mgmt_release		(struct inode*, struct
file*);
+static int	megasas_mgmt_fasync		(int, struct file*, int);
+static int	megasas_mgmt_ioctl		(struct inode*, struct
file*,
+						unsigned int, unsigned
long);
+
+static int	megasas_mgmt_fw_ioctl		(struct megasas_instance*, 
+						void __user*);
+static int	megasas_mgmt_fw_dcmd		(struct megasas_instance*, 
+						struct iocpacket*, void
__user*,
+						struct megasas_cmd*);
+static int	megasas_mgmt_fw_smp		(struct megasas_instance*, 
+						struct iocpacket*, void
__user*,
+						struct megasas_cmd*);
+
+static ssize_t	megasas_sysfs_show_app_hndl	(struct class_device*,
char*);
+
+static void	megasas_fill_drv_ver		(struct megasas_drv_ver*);
+static int	megasas_get_ctrl_info		(struct megasas_instance*,
+						struct megasas_ctrl_info* );
+
+MODULE_LICENSE		("GPL");
+MODULE_VERSION		(MEGASAS_VERSION);
+MODULE_AUTHOR		("LSI Logic Corporation");
+MODULE_DESCRIPTION	("LSI Logic MegaRAID SAS Driver");
+
+/*
+ * PCI ID table for all supported controllers
+ */
+static struct pci_device_id megasas_pci_table_g[] = {
+
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_LSI_1064,
+		PCI_SUBVENDOR_x0000,
+		PCI_SUBSYSTEM_x0000,
+	},
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_LSI_1064,
+		PCI_SUBVENDOR_x1000,
+		PCI_SUBSYSTEM_x0002,
+	},
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_LSI_1064,
+		PCI_SUBVENDOR_x1000,
+		PCI_SUBSYSTEM_x1001,
+	},
+	{
+		PCI_VENDOR_ID_DELL,
+		PCI_DEVICE_ID_PERC5,
+		PCI_VENDOR_ID_DELL,
+		PCI_SUBSYSTEM_PERC5H,
+	},
+	{
+		PCI_VENDOR_ID_DELL,
+		PCI_DEVICE_ID_PERC5,
+		PCI_VENDOR_ID_DELL,
+		PCI_SUBSYSTEM_PERC5L,
+	},
+	{
+		PCI_VENDOR_ID_DELL,
+		PCI_DEVICE_ID_PERC5,
+		PCI_VENDOR_ID_DELL,
+		PCI_SUBSYSTEM_PERC5I,
+	},
+	{
+		PCI_VENDOR_ID_LSI_LOGIC,
+		PCI_DEVICE_LSI_1064,
+		PCI_SUB_DEVICEID_FSC,
+		PCI_SUB_VENDORID_FSC,
+	},
+	{ 0 }	/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(pci, megasas_pci_table_g);
+
+/*
+ * PCI hotplug support registration structure
+ */
+static struct pci_driver megasas_pci_driver = {
+	
+	.name		= "megaraid_sas",
+	.id_table	= megasas_pci_table_g,
+	.probe		= megasas_probe_one,
+	.remove		= __devexit_p(megasas_detach_one),
+	.driver		= {
+				.shutdown = megasas_shutdown,
+			  }
+};
+
+/*
+ * Sysfs attribute definition: Exports driver specific controller handle
+ */
+CLASS_DEVICE_ATTR(megaraid_sas_app_hndl, S_IRUSR,
megasas_sysfs_show_app_hndl,
+
NULL);
+/*
+ * Host template initializer for sysfs attributes
+ */
+static struct class_device_attribute* megasas_shost_attrs[] = {
+	&class_device_attr_megaraid_sas_app_hndl,
+	NULL,
+};
+
+/*
+ * Scsi host template for megaraid mfi driver
+ */
+static struct scsi_host_template megasas_template_g = {
+
+	.module				= THIS_MODULE,
+	.name				= "LSI Logic SAS based MegaRAID
driver",
+	.proc_name			= "megaraid_sas",
+	.queuecommand			= megasas_queue_command,
+	.eh_abort_handler		= megasas_abort_handler,
+	.eh_device_reset_handler	= megasas_reset_handler,
+	.eh_bus_reset_handler		= megasas_reset_handler,
+	.eh_host_reset_handler		= megasas_reset_handler,
+	.use_clustering			= ENABLE_CLUSTERING,
+	.shost_attrs			= megasas_shost_attrs,
+};
+
+/*
+ * File opereations structure for management interface
+ */
+static struct file_operations megasas_mgmt_fops = {
+	.owner		= THIS_MODULE,
+	.open		= megasas_mgmt_open,
+	.release	= megasas_mgmt_release,
+	.fasync		= megasas_mgmt_fasync,
+	.ioctl		= megasas_mgmt_ioctl,
+};
+
+static	int				megasas_mgmt_majorno;
+static	struct megasas_mgmt_info	megasas_mgmt_info;
+static	struct fasync_struct*		megasas_async_queue;
+static	DECLARE_MUTEX			(megasas_async_queue_mutex);
+static	int				is_dma64;
+
+/**
+ * megasas_get_cmd : Get a command from the free pool
+ */
+static inline struct megasas_cmd*
+megasas_get_cmd( struct megasas_instance* instance )
+{
+	unsigned long		flags;
+	struct megasas_cmd*	cmd;
+
+	spin_lock_irqsave(&instance->cmd_pool_lock, flags);
+
+	if ( list_empty(&instance->cmd_pool)) {
+		spin_unlock_irqrestore(&instance->cmd_pool_lock, flags);
+		return NULL;
+	}
+
+	cmd = list_entry((&instance->cmd_pool)->next, struct megasas_cmd,
list);
+
+	list_del_init( &cmd->list );
+
+	spin_unlock_irqrestore( &instance->cmd_pool_lock, flags );
+
+	return cmd;
+}
+
+/**
+ * megasas_return_cmd : Return a cmd to free command pool
+ */
+static inline void
+megasas_return_cmd( struct megasas_instance* instance, struct megasas_cmd*
cmd )
+{
+	unsigned long flags;
+
+	spin_lock_irqsave( &instance->cmd_pool_lock, flags );
+	
+	list_add( &cmd->list, &instance->cmd_pool );
+
+	spin_unlock_irqrestore( &instance->cmd_pool_lock, flags );
+}
+
+/**
+ * megasas_make_sgl32	: return -1 or sge_count
+ */
+static inline int
+megasas_make_sgl32( struct megasas_instance* instance, struct scsi_cmnd*
scp, 
+						union megasas_sgl* mfi_sgl )
+{
+	int			i;
+	int			sge_count;
+	struct scatterlist*	os_sgl;
+	struct page*		page;
+	unsigned long		offset;
+
+	/*
+	 * Return 0 if there is no data transfer
+	 */
+	if (!scp->request_buffer || !scp->request_bufflen)
+		return 0;
+
+	if (!scp->use_sg) {
+		page	= virt_to_page( scp->request_buffer );
+		offset	= ((unsigned long)scp->request_buffer & ~PAGE_MASK);
+
+		mfi_sgl->sge32[0].phys_addr	=
pci_map_page(instance->pdev, 
+							page, offset,
+
scp->request_bufflen, 
+
scp->sc_data_direction);
+		mfi_sgl->sge32[0].length	= scp->request_bufflen;
+
+		return 1;
+	}
+
+	os_sgl		= (struct scatterlist*) scp->request_buffer;
+	sge_count	= pci_map_sg(instance->pdev, os_sgl, scp->use_sg,
+					scp->sc_data_direction );
+
+	for( i = 0; i < sge_count; i++, os_sgl++ ) {
+		mfi_sgl->sge32[i].length	= sg_dma_len( os_sgl );
+		mfi_sgl->sge32[i].phys_addr	= sg_dma_address( os_sgl );
+	}
+
+	return sge_count;
+}
+
+/**
+ * megasas_make_sgl64	: return -1 or sge_count
+ */
+static inline int
+megasas_make_sgl64( struct megasas_instance* instance, struct scsi_cmnd*
scp, 
+						union megasas_sgl* mfi_sgl )
+{
+	int			i;
+	int			sge_count;
+	struct scatterlist*	os_sgl;
+	struct page*		page;
+	unsigned long		offset;
+
+	/*
+	 * Return 0 if there is no data transfer
+	 */
+	if (!scp->request_buffer || !scp->request_bufflen)
+		return 0;
+
+	if (!scp->use_sg) {
+		page	= virt_to_page( scp->request_buffer );
+		offset	= ((unsigned long)scp->request_buffer & ~PAGE_MASK);
+
+		mfi_sgl->sge64[0].phys_addr	=
pci_map_page(instance->pdev, 
+							page, offset,
+
scp->request_bufflen, 
+
scp->sc_data_direction);
+
+		mfi_sgl->sge64[0].length	= scp->request_bufflen;
+
+		return 1;
+	}
+
+	os_sgl		= (struct scatterlist*) scp->request_buffer;
+	sge_count	= pci_map_sg(instance->pdev, os_sgl, scp->use_sg,
+					scp->sc_data_direction );
+
+	for( i = 0; i < sge_count; i++, os_sgl++ ) {
+		mfi_sgl->sge64[i].length	= sg_dma_len( os_sgl );
+		mfi_sgl->sge64[i].phys_addr	= sg_dma_address( os_sgl );
+	}
+
+	return sge_count;
+}
+
+
+/**
+ * megasas_init	: Driver load entry point
+ */
+static int __init
+megasas_init( void )
+{
+	int rval;
+
+	/*
+	 * Announce driver version and other information
+	 */
+	printk( KERN_INFO "megasas: %s %s\n", MEGASAS_VERSION, 
+					MEGASAS_EXT_VERSION);
+
+	/*
+	 * Initialize driver-wide structures
+	 */
+	memset( &megasas_mgmt_info, 0, sizeof(struct megasas_mgmt_info));
+
+	is_dma64 = (sizeof(dma_addr_t) == 8) ? 1 : 0;
+
+	/*
+	 * Register character device node
+	 */
+	rval =  register_chrdev(0, "megaraid_sas_ioctl",
&megasas_mgmt_fops);
+
+	if (rval < 0) {
+		printk( KERN_ERR "megasas: failed to open device node\n" );
+		return rval;
+	}
+
+	megasas_mgmt_majorno = rval;
+
+	/*
+	 * Register ourselves as PCI hotplug module
+	 */
+	rval = pci_module_init( &megasas_pci_driver );
+
+	if( rval ) 
+		printk(KERN_ERR "megasas: PCI hotplug regisration failed
\n");
+
+	return rval;
+}
+
+/**
+ * megasas_exit : Driver unload entry point
+ */
+static void __exit 
+megasas_exit( void )
+{
+	pci_unregister_driver( &megasas_pci_driver );
+	unregister_chrdev( megasas_mgmt_majorno, "megaraid_sas_ioctl" );
+
+	printk( KERN_NOTICE "megasas: unloaded the driver\n" );
+
+	return;
+}
+
+/**
+ * megasas_probe_one
+ */
+static int __devinit
+megasas_probe_one( struct pci_dev *pdev, const struct pci_device_id *id )
+{
+	dma_addr_t			instance_h;
+	struct megasas_instance*	instance;
+
+	/*
+	 * Announce PCI information
+	 */
+	printk( KERN_INFO "megasas: probe new device "
+			"%#4.04x:%#4.04x:%#4.04x:%#4.04x: ",
+			pdev->vendor, pdev->device, 
+			pdev->subsystem_vendor,	pdev->subsystem_device);
+
+	printk( KERN_INFO "megasas: bus %d:slot %d:func %d\n", 
+		pdev->bus->number,
PCI_SLOT(pdev->devfn),PCI_FUNC(pdev->devfn));
+
+	/*
+	 * PCI prepping: enable device set bus mastering and dma mask
+	 */
+	if (pci_enable_device(pdev)) {
+		printk( KERN_ERR "megasas: pci_enable_device failed\n");
+		return -ENODEV;
+	}
+
+	pci_set_master(pdev);
+
+	/*
+	 * All our contollers are capable of performing 64-bit DMA
+	 */
+	if (is_dma64) {
+		if (pci_set_dma_mask( pdev, DMA_64BIT_MASK) != 0) {
+
+			printk( KERN_WARNING "megasas: failed to set 64 bit
\
+					dma mask; trying 32 bit mask\n" );
+
+			if (pci_set_dma_mask( pdev, DMA_32BIT_MASK ) != 0) {
+				printk( KERN_WARNING "megasas: failed to set
\
+							32 bit dma mask \n"
);
+
+				goto fail_set_dma_mask;
+			}
+		}
+	}
+	else {
+		if (pci_set_dma_mask( pdev, DMA_32BIT_MASK ) != 0) {
+
+			printk( KERN_WARNING "megasas: failed to set 32 bit
\
+								dma mask \n"
);
+			goto fail_set_dma_mask;
+		}
+	}
+
+	/*
+	 * We allocate DMA memory for instance soft state so that we can
+	 * can directly pass adp->{member variable} to FW to get FW data.
+	 * E.g, product information, configuration data etc.
+	 */
+	instance = pci_alloc_consistent( pdev, sizeof(struct
megasas_instance),
+								&instance_h
);
+
+	if (!instance) {
+		printk(KERN_WARNING "megasas: out of memory!\n" );
+		goto fail_alloc_instance;
+	}
+
+	memset( instance, 0, sizeof(struct megasas_instance) );
+
+	/* 
+	 * Initialize locks and queues 
+	 */
+	INIT_LIST_HEAD( &instance->cmd_pool );
+
+	init_waitqueue_head( &instance->int_cmd_wait_q );
+	init_waitqueue_head( &instance->abort_cmd_wait_q );
+
+	spin_lock_init( &instance->cmd_pool_lock );
+	spin_lock_init( &instance->lock );
+	
+	instance->host_lock = &instance->lock;
+
+	/* 
+	 * Initialize PCI related and misc parameters 
+	 */
+	instance->phys_addr	= instance_h;
+	instance->pdev		= pdev;
+	instance->unique_id	= pdev->bus->number << 8 | pdev->devfn;
+	instance->init_id	= MEGADRV_DEFAULT_INIT_ID;
+	instance->aen_cmd	= NULL;
+
+	/* 
+	 * Initialize MFI Firmware 
+	 */
+	if (megasas_init_mfi( instance ))
+		goto fail_init_mfi;
+
+	/* 
+	 * Register IRQ 
+	 */
+	if (request_irq(pdev->irq, megasas_isr, SA_SHIRQ, "megasas",
+							instance)) {
+		printk( KERN_ERR "megasas: Failed to register IRQ\n" );
+		goto fail_irq;
+	}
+
+	MFI_ENABLE_INTR( instance->reg_set );
+
+	/*
+	 * Store instance in PCI softstate
+	 */
+	pci_set_drvdata( pdev, instance );
+
+	/*
+	 * Add this controller to megasas_mgmt_info structure so that it
+	 * can be exported to management applications
+	 */
+	megasas_mgmt_info.count++;
+	megasas_mgmt_info.instance[megasas_mgmt_info.max_index] = instance;
+	megasas_mgmt_info.max_index++;
+
+	/*
+	 * Initiate AEN
+	 */
+	if (megasas_start_aen(instance)) {
+		printk( KERN_WARNING "megasas: failed to initiate aen\n" );
+	}
+
+	/* 
+	 * Register with SCSI mid-layer 
+	 */
+	if (megasas_io_attach( instance ))
+		goto fail_io_attach;
+
+	return 0;
+
+fail_io_attach:
+	megasas_mgmt_info.count--;
+	megasas_mgmt_info.instance[megasas_mgmt_info.max_index] = NULL;
+	megasas_mgmt_info.max_index--;
+
+	pci_set_drvdata( pdev, NULL );
+	MFI_DISABLE_INTR(instance->reg_set);	
+	free_irq( instance->pdev->irq, instance );
+
+	megasas_reset_mfi( instance );
+
+fail_irq:
+fail_init_mfi:
+	pci_free_consistent( pdev, sizeof(struct megasas_instance), 
+						instance, instance_h );
+fail_alloc_instance:
+fail_set_dma_mask:
+	pci_disable_device( pdev );
+
+	return -ENODEV;
+}
+
+/**
+ * megasas_detach_one
+ */
+static void
+megasas_detach_one( struct pci_dev *pdev )
+{
+	int				i;
+	struct Scsi_Host*		host;
+	struct megasas_instance*	instance;
+	dma_addr_t			instance_h;
+
+	instance	= pci_get_drvdata( pdev );
+
+	if( !instance ) {
+		printk( KERN_ERR "megasas: Invalid detach\n" );
+		return;
+	}
+
+	host		= instance->host;
+	instance_h	= instance->phys_addr;
+
+	megasas_io_detach( instance );
+
+	megasas_flush_cache( instance );
+	megasas_shutdown_controller( instance );
+
+	/*
+	 * Take the instance off the instance array. Note that we will not
+	 * decrement the max_index. We let this array be sparse array
+	 */
+	for (i = 0; i < megasas_mgmt_info.max_index; i++ ) {
+		if (megasas_mgmt_info.instance[i] == instance) {
+			megasas_mgmt_info.count--;
+			megasas_mgmt_info.instance[i] = NULL;
+
+			break;
+		}
+	}
+	
+	pci_set_drvdata( instance->pdev, NULL );
+
+	MFI_DISABLE_INTR(instance->reg_set);	
+
+	free_irq( instance->pdev->irq, instance );
+
+	megasas_reset_mfi( instance );
+
+	pci_free_consistent( instance->pdev, sizeof(struct
megasas_instance), 
+							instance, instance_h
);
+	scsi_host_put( host );
+
+	pci_set_drvdata( pdev, NULL );
+
+	pci_disable_device( pdev );
+
+	return;
+}
+
+/**
+ * megasas_shutdown
+ */
+static void
+megasas_shutdown( struct device* device )
+{	
+	int				i;
+	struct megasas_instance*	instance;
+	
+	printk( KERN_NOTICE "megasas: shutting down...\n" );
+
+	for( i = 0; i < megasas_mgmt_info.max_index; i++ ) {
+		instance = megasas_mgmt_info.instance[i];
+
+		if (instance) 
+			megasas_shutdown_controller( instance );
+	}
+}
+
+/**
+ * megasas_flush_cache
+ */
+static void
+megasas_flush_cache( struct megasas_instance* instance )
+{
+	struct megasas_cmd*		cmd;
+	struct megasas_dcmd_frame*	dcmd;
+
+	if (!(cmd = megasas_get_cmd( instance )))
+		return;
+
+	dcmd = &cmd->frame->dcmd;
+
+	memset( dcmd->mbox, 0, 12 );
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 0;
+	dcmd->flags			= MFI_FRAME_DIR_NONE;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= 0;
+	dcmd->opcode			= MR_DCMD_CTRL_CACHE_FLUSH;
+	dcmd->mbox[0]			= MR_FLUSH_CTRL_CACHE |
+						MR_FLUSH_DISK_CACHE;
+
+	megasas_issue_blocked_cmd( instance, cmd );
+
+	megasas_return_cmd( instance, cmd );
+
+	return;
+}
+
+/**
+ * megasas_shutdown_controller
+ */
+static void
+megasas_shutdown_controller( struct megasas_instance* instance )
+{
+	struct megasas_cmd*		cmd;
+	struct megasas_dcmd_frame*	dcmd;
+
+	if (!(cmd = megasas_get_cmd( instance )))
+		return;
+
+	dcmd = &cmd->frame->dcmd;
+
+	memset( dcmd->mbox, 0, 12 );
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 0;
+	dcmd->flags			= MFI_FRAME_DIR_NONE;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= 0;
+	dcmd->opcode			= MR_DCMD_CTRL_SHUTDOWN;
+	dcmd->mbox[0]			= MR_ENABLE_DRIVE_SPINDOWN;
+
+	megasas_issue_blocked_cmd( instance, cmd );
+
+	megasas_return_cmd( instance, cmd );
+
+	return;
+}
+
+/**
+ * megasas_init_mfi
+ */
+static int
+megasas_init_mfi( struct megasas_instance* instance )
+{
+	uint32_t			context_sz;
+	uint32_t			reply_q_sz;
+	struct megasas_register_set*	reg_set;
+
+	struct megasas_cmd*		cmd;
+	struct megasas_ctrl_info	ctrl_info;
+
+	struct megasas_init_frame*	init_frame;
+	struct megasas_init_queue_info*	initq_info;
+	dma_addr_t			init_frame_h;
+	dma_addr_t			initq_info_h;
+	dma_addr_t			instance_h;
+
+	/* 
+	 * Map the message registers 
+	 */
+	instance->base_addr = pci_resource_start(instance->pdev, 0);
+
+	if (pci_request_regions(instance->pdev, "megasas: LSI Logic")) {
+		printk( KERN_ERR "megasas: mem region busy!\n");
+		return -EBUSY;
+	}
+
+	instance->reg_set = (struct megasas_register_set*) ioremap_nocache(
+						instance->base_addr, 8192);
+
+	if (!instance->reg_set) {
+		printk( KERN_ERR "megasas: failed to map io mem\n" );
+		goto fail_ioremap;
+	}
+
+	reg_set = instance->reg_set;
+
+	/* 
+	 * We expect the FW state to be READY
+	 */
+	if (megasas_transition_to_ready(instance->reg_set))
+		goto fail_ready_state;
+
+	/* 
+	 * Get various operational parameters from status register 
+	 */
+	instance->max_num_sge	= MFI_MAX_SUPP_SGES(reg_set);
+	instance->max_fw_cmds	= MFI_MAX_SUPP_CMDS(reg_set);
+
+	/* 
+	 * Create a pool of commands 
+	 */
+	if (megasas_alloc_cmds(instance))
+		goto fail_alloc_cmds;
+
+	/* 
+	 * Allocate memory for reply queue. Length of reply queue should
+	 * be one more than the maximum commands handled by the firmware.
+	 */
+	context_sz = sizeof(uint32_t);
+	reply_q_sz = context_sz * (instance->max_fw_cmds + 1);
+
+	instance->reply_queue = pci_alloc_consistent( instance->pdev, 
+				reply_q_sz, &instance->reply_queue_phys_addr
);
+
+	if (!instance->reply_queue) {
+		printk( KERN_ERR "megasas: Out of DMA memory\n" );
+		goto fail_reply_queue;
+	}
+
+	/*
+	 * Prepare a init frame. Note the init frame points to queue info
+	 * structure. Each frame has SGL allocated after first 64 bytes. For
+	 * this frame - since we don't need any SGL - we use SGL's space as
+	 * queue info structure
+	 */
+	cmd = megasas_get_cmd( instance );
+
+	init_frame	= (struct megasas_init_frame*) cmd->frame;
+	initq_info	= (struct megasas_init_queue_info*)
+				((unsigned long)init_frame + 64);
+
+	instance_h	= instance->phys_addr;
+	init_frame_h	= cmd->frame_phys_addr;
+	initq_info_h	= init_frame_h + 64;
+
+	memset( init_frame, 0, MEGAMFI_FRAME_SIZE );
+	memset( initq_info, 0, sizeof(struct megasas_init_queue_info));
+
+	initq_info->init_flags = 0;
+
+	initq_info->reply_queue_entries	= instance->max_fw_cmds + 1;
+	initq_info->reply_queue_start_phys_addr_lo = 
+
instance->reply_queue_phys_addr;
+	initq_info->reply_queue_start_phys_addr_hi = 0;
+
+	initq_info->producer_index_phys_addr_hi	= 0;
+	initq_info->producer_index_phys_addr_lo = instance_h + offsetof(
+							struct
megasas_instance,
+							producer);
+
+	initq_info->consumer_index_phys_addr_hi = 0;
+	initq_info->consumer_index_phys_addr_lo = instance_h + offsetof(
+							struct
megasas_instance,
+							consumer);
+
+	init_frame->cmd				= MFI_CMD_INIT;
+	init_frame->cmd_status			= 0xFF;
+	init_frame->flags			= 0;
+	init_frame->queue_info_new_phys_addr_lo	= initq_info_h;
+	init_frame->queue_info_new_phys_addr_hi	= 0;
+
+	init_frame->data_xfer_len = sizeof( struct megasas_init_queue_info);
+
+	/*
+	 * Issue the init frame in polled mode
+	 */
+	if (megasas_issue_polled(instance, cmd )) {
+		printk( KERN_ERR "megasas: failed to init firmware\n" );
+		goto fail_fw_init;
+	}
+
+	megasas_return_cmd( instance, cmd );
+
+	/*
+	 * Gather misc FW related information
+	 */
+	if (!megasas_get_ctrl_info( instance, &ctrl_info ))
+		instance->max_sectors_per_req = ctrl_info.max_request_size;
+	else
+		instance->max_sectors_per_req = instance->max_num_sge *
+						PAGE_SIZE / 512;
+
+	return 0;
+
+fail_fw_init:
+	megasas_return_cmd( instance, cmd );
+
+	pci_free_consistent( instance->pdev, reply_q_sz, 
+				instance->reply_queue,
+				instance->reply_queue_phys_addr );
+fail_reply_queue:
+	megasas_free_cmds( instance );
+
+fail_alloc_cmds:
+fail_ready_state:
+	iounmap( instance->reg_set );
+
+fail_ioremap:
+	pci_release_regions( instance->pdev );
+	
+	return -EINVAL;
+}
+
+/**
+ * megasas_reset_mfi
+ */
+static void
+megasas_reset_mfi( struct megasas_instance* instance )
+{
+	uint32_t reply_q_sz = sizeof(uint32_t) * instance->max_fw_cmds;
+
+	pci_free_consistent( instance->pdev, reply_q_sz, 
+				instance->reply_queue,
+				instance->reply_queue_phys_addr );
+
+	megasas_free_cmds( instance );
+
+	iounmap( instance->reg_set );
+
+	pci_release_regions( instance->pdev );
+}
+
+/**
+ * megasas_transition_to_ready	: Move the FW to READY state
+ * 
+ * @reg_set			: MFI register set
+ */
+static int
+megasas_transition_to_ready( struct megasas_register_set* reg_set )
+{
+	int		i;
+	uint8_t		max_wait;
+	uint32_t	fw_state;
+	uint32_t	cur_state;
+
+	fw_state = RD_OB_MSG_0(reg_set) & MFI_STATE_MASK;
+
+	while( fw_state != MFI_STATE_READY ) {
+
+		switch( fw_state ) {
+
+		case MFI_STATE_FAULT:
+			
+			printk(KERN_WARNING "megasas: FW in FAULT
state!!\n");
+			return -ENODEV;
+
+		case MFI_STATE_WAIT_HANDSHAKE:
+			/*
+			 * Set the CLR bit in IMR0
+			 */
+			printk(KERN_INFO "megasas: FW waiting for
HANDSHAKE\n");
+			WR_IN_MSG_0( MFI_INIT_CLEAR_HANDSHAKE, reg_set );
+
+			max_wait	= 2;
+			cur_state	= MFI_STATE_WAIT_HANDSHAKE;
+			break;
+
+		case MFI_STATE_OPERATIONAL:
+			/*
+			 * Bring it to READY state; assuming max wait 2 secs
+			 */
+			MFI_DISABLE_INTR(reg_set);	
+			printk(KERN_INFO "megasas: FW in OPERATIONAL
state\n");
+			WR_IN_DOORBELL( MFI_INIT_READY, reg_set );
+
+			max_wait	= 10;
+			cur_state	= MFI_STATE_OPERATIONAL;
+			break;
+
+		case MFI_STATE_UNDEFINED:
+			/*
+			 * This state should not last for more than 2
seconds
+			 */
+			printk(KERN_INFO "FW state undefined\n");
+			max_wait	= 2;
+			cur_state	= MFI_STATE_UNDEFINED;
+			break;
+
+		case MFI_STATE_BB_INIT:
+			max_wait	= 2;
+			cur_state	= MFI_STATE_BB_INIT;
+			break;
+
+		case MFI_STATE_FW_INIT:
+			max_wait	= 2;
+			cur_state	= MFI_STATE_FW_INIT;
+			break;
+
+		case MFI_STATE_DEVICE_SCAN:
+			max_wait	= 10;
+			cur_state	= MFI_STATE_DEVICE_SCAN;
+			break;
+
+		default:
+			printk(KERN_ERR "megasas: Unknown state 0x%x\n", 
+								fw_state);
+			return -ENODEV;
+		}
+
+		/*
+		 * The cur_state should not last for more than max_wait secs
+		 */
+		for( i = 0; i < (max_wait * 1000); i++ ) {
+			fw_state = RD_OB_MSG_0(reg_set) & MFI_STATE_MASK;
+
+			if (fw_state == cur_state) {
+				msleep(1);
+			}
+			else
+				break;
+		}
+
+		/*
+		 * Return error if fw_state hasn't changed after max_wait
+		 */
+		if (fw_state == cur_state) {
+			printk(KERN_ERR "FW state hasn't changed in %d
secs\n",
+								max_wait);
+			return -ENODEV;
+		}
+	};
+
+	return 0;
+}
+
+/**
+ * megasas_alloc_cmds
+ */
+static int
+megasas_alloc_cmds( struct megasas_instance* instance )
+{
+	int			i;
+	uint32_t		max_cmd;
+	struct megasas_cmd*	cmd;
+
+	max_cmd = instance->max_fw_cmds;
+
+	/* 
+	 * Alloc mem for all cmds in one chunk 
+	 */
+	instance->cmd_list = kmalloc( sizeof(struct megasas_cmd) * max_cmd,
+								GFP_KERNEL);
+
+	if (!instance->cmd_list) {
+		printk( KERN_ERR "megasas: out of memory\n" );
+		return -ENOMEM;
+	}
+
+	memset( instance->cmd_list, 0, sizeof(struct megasas_cmd)*max_cmd );
+
+	/* 
+	 * Slice cmd_list into individual cmds and add to cmd_pool 
+	 */
+	for( i = 0, cmd = instance->cmd_list; i < max_cmd; i++, cmd++ ) {
+		cmd->index = i;
+		list_add_tail( &cmd->list, &instance->cmd_pool );
+	}
+
+	/* 
+	 * Create a frame pool and assign one frame to each cmd 
+	 */
+	if (megasas_create_frame_pool( instance )) {
+		printk(KERN_ERR "megasas: error creating DMA pool\n");
+		megasas_free_cmds( instance );
+	}
+
+	return 0;
+}
+
+/**
+ * megasas_free_cmds
+ */
+static void
+megasas_free_cmds( struct megasas_instance* instance )
+{
+	/* First free the MFI frame pool */
+	megasas_teardown_frame_pool( instance );
+
+	/* Free the cmd_list buffer itself */
+	if (instance->cmd_list ) {
+		kfree( instance->cmd_list );
+		instance->cmd_list = NULL;
+	}
+
+	INIT_LIST_HEAD( &instance->cmd_pool );
+}
+
+/**
+ * megasas_create_frame_pool
+ */
+static int
+megasas_create_frame_pool( struct megasas_instance* instance )
+{
+	int			i;
+	uint32_t		max_cmd;
+	uint32_t		sge_sz;
+	uint32_t		sgl_sz;
+	uint32_t		total_sz ;
+	uint32_t		frame_count;
+	struct megasas_cmd*	cmd;
+
+	max_cmd = instance->max_fw_cmds;
+
+	/*
+	 * Size of our frame is 64 bytes for MFI frame, followed by max SG
+	 * elements and finally SCSI_SENSE_BUFFERSIZE bytes for sense buffer
+	 */
+	sge_sz	= (is_dma64) ? sizeof(struct megasas_sge64) : 
+				sizeof(struct megasas_sge32);
+
+	/*
+	 * Calculated the number of 64byte frames required for SGL
+	 */
+	sgl_sz		= sge_sz * instance->max_num_sge;
+	frame_count	= (sgl_sz + MEGAMFI_FRAME_SIZE -
1)/MEGAMFI_FRAME_SIZE;
+
+	/*
+	 * We need one extra frame for the MFI command
+	 */
+	frame_count++;
+
+	total_sz = MEGAMFI_FRAME_SIZE * frame_count;
+	/*
+	 * Use DMA pool facility provided by PCI layer
+	 */
+	instance->frame_dma_pool = pci_pool_create( "megasas frame pool",
+					instance->pdev, total_sz, 64, 0 );
+
+	instance->sense_dma_pool = pci_pool_create( "megasas sense pool",
+					instance->pdev, 128, 4, 0 );
+
+	if (!instance->frame_dma_pool || !instance->sense_dma_pool) {
+		printk( KERN_ERR "megasas: failed to setup DMA pool\n" );
+		return -ENOMEM;
+	}
+
+	/*
+	 * Allocate and attach a frame to each of the commands in cmd_list.
+	 * By making cmd->index as the context instead of the &cmd, we can
+	 * always use 32bit context regardless of the architecture
+	 */
+	for( i = 0, cmd = instance->cmd_list; i < max_cmd; i++, cmd++ ) {
+
+		cmd->frame = pci_pool_alloc( instance->frame_dma_pool, 
+				GFP_KERNEL, &cmd->frame_phys_addr );
+
+		cmd->sense = pci_pool_alloc( instance->sense_dma_pool,
+				GFP_KERNEL, &cmd->sense_phys_addr );
+
+		if (!cmd->frame || !cmd->sense) {
+			printk(KERN_ERR "megasas: pci_pool_alloc failed
\n");
+			megasas_teardown_frame_pool( instance );
+			return -ENOMEM;
+		}
+
+		cmd->frame->io.context	= cmd->index;
+	}
+
+	return 0;
+}
+
+/**
+ * megasas_teardown_frame_pool
+ */
+static void
+megasas_teardown_frame_pool( struct megasas_instance* instance )
+{
+	int			i;
+	uint32_t		max_cmd = instance->max_fw_cmds;
+	struct megasas_cmd*	cmd;
+	
+	if (!instance->frame_dma_pool)
+		return;
+
+	/*
+	 * Return all frames to pool
+	 */
+	for( i = 0, cmd = instance->cmd_list; i < max_cmd; i++, cmd++ ) {
+		if( cmd->frame)
+			pci_pool_free( instance->frame_dma_pool, cmd->frame,
+					cmd->frame_phys_addr );
+
+		if (cmd->sense)
+			pci_pool_free( instance->sense_dma_pool, cmd->frame,
+					cmd->sense_phys_addr );
+	}
+
+	/*
+	 * Now destroy the pool itself
+	 */
+	pci_pool_destroy( instance->frame_dma_pool );
+	pci_pool_destroy( instance->sense_dma_pool );
+
+	instance->frame_dma_pool = NULL;
+	instance->sense_dma_pool = NULL;
+}
+
+/**
+ * megasas_start_aen
+ */
+static int
+megasas_start_aen( struct megasas_instance* instance )
+{
+	int				ret;
+	struct megasas_evt_log_info	eli;
+	union megasas_evt_class_locale	class_locale;
+	
+	/*
+	 * Get the latest sequence number from FW
+	 */
+	memset( &eli, 0, sizeof(struct megasas_evt_log_info) );
+	
+	if (megasas_get_seq_num( instance, &eli )) {
+		printk( KERN_WARNING "megasas: failed to get seq num\n" );
+		return -1;
+	}
+
+	/*
+	 * Register AEN with FW for latest sequence number plus 1
+	 */
+	class_locale.members.reserved	= 0;
+	class_locale.members.locale	= MR_EVT_LOCALE_ALL;
+	class_locale.members.class	= MR_EVT_CLASS_DEBUG;
+
+	ret = megasas_register_aen( instance, eli.newest_seq_num + 1,
+						class_locale.word );
+	if (ret) {
+		printk( KERN_WARNING "megasas: aen registration failed\n" );
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * megasas_get_seq_num
+ */
+static int
+megasas_get_seq_num( struct megasas_instance* instance, 
+			struct megasas_evt_log_info* eli)
+{
+	int				i;
+	int				ret = 0;
+	struct megasas_cmd*		cmd;
+	struct megasas_dcmd_frame*	dcmd;
+	struct megasas_evt_log_info*	el_info;
+	dma_addr_t			el_info_h;
+
+	cmd = megasas_get_cmd( instance );
+
+	if (!cmd) {
+		printk( KERN_ERR "megasas: failed to get a cmd\n" );
+		return -ENOMEM;
+	}
+
+	dcmd	= &cmd->frame->dcmd;
+	el_info	= pci_alloc_consistent( instance->pdev, 
+				sizeof(struct megasas_evt_log_info), 
+							&el_info_h );
+
+	if (!el_info) {
+		printk( KERN_ERR "megasas: cannot alloc mem for el_info\n"
);
+		
+		megasas_return_cmd( instance, cmd );
+		return -ENOMEM;
+	}
+
+	memset( el_info, 0, sizeof(struct megasas_evt_log_info) );
+	for( i = 0; i < 12; i++ ) dcmd->mbox[i] = 0;
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 1;
+	dcmd->flags			= MFI_FRAME_DIR_READ;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= sizeof(struct
megasas_evt_log_info);
+	dcmd->opcode			= MR_DCMD_CTRL_EVENT_GET_INFO;
+	dcmd->sgl.sge32[0].phys_addr	= el_info_h;
+	dcmd->sgl.sge32[0].length	= sizeof(struct
megasas_evt_log_info);
+
+	if (!megasas_issue_blocked_cmd( instance, cmd )) {
+		ret = 0;
+	}
+	else {
+		ret = -1;
+		printk( KERN_WARNING "megasas: failed to issue el_info\n" );
+	}
+
+	/*
+	 * Copy the data back into callers buffer
+	 */
+	if (!ret)
+		memcpy( eli, el_info, sizeof(struct megasas_evt_log_info) );
+
+	pci_free_consistent(instance->pdev, sizeof(struct
megasas_evt_log_info),
+							el_info, el_info_h);
+
+	megasas_return_cmd( instance, cmd );
+
+	return ret;
+}
+
+/**
+ * megasas_register_aen
+ */
+static int
+megasas_register_aen( struct megasas_instance* instance, uint32_t seq_num,
+							uint32_t locale )
+{
+	struct megasas_cmd*		cmd;
+	struct megasas_dcmd_frame*	dcmd;
+	struct megasas_evt_detail*	evt_detail;
+	dma_addr_t			evt_detail_h;
+	uint32_t*			mbox_word;
+
+	cmd = megasas_get_cmd( instance );
+
+	if (!cmd) {
+		printk( KERN_ERR "megasas: failed to get a cmd for aen\n" );
+		return -ENOMEM;
+	}
+
+	dcmd		= &cmd->frame->dcmd;
+	mbox_word	= (uint32_t*) dcmd->mbox;
+	evt_detail	= &instance->evt_detail;
+	evt_detail_h	= instance->phys_addr + 
+				offsetof(struct megasas_instance,
evt_detail);
+
+	memset( evt_detail, 0, sizeof(struct megasas_evt_detail));
+
+	/*
+	 * Prepare DCMD for aen registration
+	 */
+	memset( dcmd->mbox, 0, 12 );
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0x0;
+	dcmd->sge_count			= 1;
+	dcmd->flags			= MFI_FRAME_DIR_READ;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= sizeof(struct megasas_evt_detail);
+	dcmd->opcode			= MR_DCMD_CTRL_EVENT_WAIT;
+	mbox_word[0]			= seq_num;
+	mbox_word[1]			= locale;
+	dcmd->sgl.sge32[0].phys_addr	= (uint32_t)(evt_detail_h & 0xFFFF);
+	dcmd->sgl.sge32[0].length	= sizeof(struct megasas_evt_detail);
+
+	/*
+	 * Store reference to the cmd used to register for AEN. When an
+	 * application wants us to register for AEN, we have to abort this
+	 * cmd and re-register with a new EVENT LOCALE supplied by that app
+	 */
+	instance->aen_cmd = cmd;
+
+	/*
+	 * Issue the aen registration frame
+	 */
+	WR_IN_QPORT( (cmd->frame_phys_addr >> 3), instance->reg_set );
+
+	return 0;
+}
+
+/**
+ * megasas_service_aen
+ */
+static void
+megasas_service_aen(struct megasas_instance* instance, struct megasas_cmd*
cmd)
+{
+	/*
+	 * Don't signal app if it is just an aborted previously registered
aen
+	 */
+	if (!cmd->abort_aen) 
+		kill_fasync( &megasas_async_queue, SIGIO, POLL_IN );
+	else
+		cmd->abort_aen = 0;
+	
+	instance->aen_cmd = NULL;
+	megasas_return_cmd( instance, cmd );
+}
+
+/**
+ * megasas_ioc_attach
+ */
+static int
+megasas_io_attach( struct megasas_instance* instance )
+{
+	struct Scsi_Host* host;
+
+	host = scsi_host_alloc(&megasas_template_g, sizeof(void*));
+
+	if (!host) {
+		printk( KERN_ERR "megasas: scsi_host_alloc failed\n" );
+		return -ENODEV;
+	}
+
+	SCSIHOST2ADAP(host)	= (caddr_t) instance;
+	instance->host		= host;
+
+	/*
+	 * Export parameters required by SCSI mid-layer
+	 */
+	scsi_assign_lock( host, instance->host_lock );
+	scsi_set_device( host, &instance->pdev->dev );
+
+	host->irq		= instance->pdev->irq;
+	host->unique_id		= instance->unique_id;
+	host->can_queue		= instance->max_fw_cmds;
+	host->this_id		= instance->init_id;
+	host->sg_tablesize	= instance->max_num_sge;
+	host->max_sectors	= instance->max_sectors_per_req;
+	host->cmd_per_lun	= MEGADRV_MAX_CMD_PER_LUN;
+	host->max_channel	= MEGADRV_MAX_CHANNELS - 1;
+	host->max_id		= MEGADRV_MAX_DEV_PER_CHANNEL;
+	host->max_lun		= MEGADRV_MAX_LUN;
+
+	/*
+	 * Notify the mid-layer about the new controller
+	 */
+	if (scsi_add_host(host, &instance->pdev->dev)) {
+
+		printk( KERN_ERR "megasas: scsi_add_host failed\n" );
+		scsi_host_put( host );
+
+		return -ENODEV;
+	}
+
+	/*
+	 * Trigger SCSI to scan our drives
+	 */
+	scsi_scan_host( host );
+
+	return 0;
+}
+
+/**
+ * megasas_io_detach
+ */
+static void
+megasas_io_detach( struct megasas_instance* instance )
+{
+	if (instance->host)
+		scsi_remove_host( instance->host );
+}
+
+/**
+ * megasas_abort_handler
+ */
+static int
+megasas_abort_handler( struct scsi_cmnd* scmd )
+{
+	printk( KERN_NOTICE "megasas: ABORT -%ld cmd=%x <c=%d t=%d l=%d>\n",
+		scmd->serial_number, scmd->cmnd[0], SCP2CHANNEL(scmd),
+		SCP2TARGET(scmd), SCP2LUN(scmd));
+
+	return FAILED;
+}
+
+/**
+ * megasas_reset_handler
+ */
+static int
+megasas_reset_handler( struct scsi_cmnd* scmd )
+{
+	int				i;
+	uint32_t			wait_time = MEGADRV_RESET_WAIT_TIME;
+	uint32_t			outstanding;
+	struct megasas_instance*	instance = SCP2ADAPTER(scmd);
+
+	spin_unlock( instance->host_lock );
+	
+	printk( KERN_NOTICE "megasas: RESET -%ld cmd=%x <c=%d t=%d l=%d>\n",
+		scmd->serial_number, scmd->cmnd[0], SCP2CHANNEL(scmd),
+		SCP2TARGET(scmd), SCP2LUN(scmd));
+
+
+	for( i = 0; i < wait_time; i++ ) {
+
+		outstanding = instance->producer - instance->consumer;
+		
+		if (!outstanding)
+			break;
+
+		if (outstanding < 0)
+			outstanding = instance->max_fw_cmds + 1 
+							-
instance->consumer;
+		if (!(i % MEGADRV_RESET_NOTICE_INTERVAL)) {
+			printk( KERN_NOTICE "megasas: [%2d]waiting for %d \
+				commands to complete\n", i, outstanding );
+		}
+
+		msleep(1000);
+	}
+
+	spin_lock( instance->host_lock );
+
+	if (outstanding) {
+		printk( KERN_CRIT "megasas: failed to do reset\n");
+		return FAILED;
+	}
+
+	printk( KERN_NOTICE "megasas: reset successful \n" );
+	
+	return SUCCESS;
+}
+
+/**
+ * megasas_queue_command
+ */
+static int
+megasas_queue_command( struct scsi_cmnd* scmd, void (*done)(struct
scsi_cmnd*) )
+{
+	uint32_t			frame_count;
+	struct megasas_cmd*		cmd;
+	struct megasas_instance*	instance;
+	uint32_t			msg_frame;
+
+	instance	= SCP2ADAPTER(scmd);
+	scmd->scsi_done	= done;
+	scmd->result	= 0;
+
+	cmd = megasas_build_cmd( instance, scmd, &frame_count );
+
+	if (!cmd) {
+		done(scmd);
+		return 0;
+	}
+
+	cmd->scmd = scmd;
+
+	/*
+	 * Issue the command to the FW 
+	 */
+	msg_frame = (cmd->frame_phys_addr >> 3) | (cmd->frame_count - 1);
+
+	WR_IN_QPORT( msg_frame, instance->reg_set );
+
+	return 0;
+}
+
+/**
+ * megasas_issue_polled
+ */
+static int
+megasas_issue_polled(struct megasas_instance* instance, struct megasas_cmd*
cmd)
+{
+	int		i;
+	uint32_t	msecs = MFI_POLL_TIMEOUT_SECS * 1000;
+	
+	struct megasas_header* frame_hdr = (struct
megasas_header*)cmd->frame;
+	
+	frame_hdr->cmd_status	= 0xFF;
+	frame_hdr->flags 	|= MFI_FRAME_DONT_POST_IN_REPLY_QUEUE;
+
+	/*
+	 * Issue the frame using inbound queue port
+	 */
+	WR_IN_QPORT( (cmd->frame_phys_addr >> 3), instance->reg_set );
+
+	/*
+	 * Wait for cmd_status to change
+	 */
+	for( i=0; i < msecs && (frame_hdr->cmd_status == 0xff); i++ ) {
+		rmb();
+		msleep(1);
+	}
+
+	if (frame_hdr->cmd_status == 0xff)
+		return -ETIME;
+
+	return 0;
+}
+
+/**
+ * megasas_issue_blocked_cmd
+ */
+static int
+megasas_issue_blocked_cmd( struct megasas_instance* instance, 
+					struct megasas_cmd* cmd )
+{
+	uint32_t msg_frame;
+
+	cmd->cmd_status	= ENODATA;
+	msg_frame	= (cmd->frame_phys_addr >> 3);
+
+	WR_IN_QPORT( msg_frame, instance->reg_set );
+
+	wait_event( instance->int_cmd_wait_q, (cmd->cmd_status != ENODATA));
+
+	return 0;
+}
+
+/**
+ * megasas_sync_abort_cmd
+ */
+static int
+megasas_sync_abort_cmd( struct megasas_instance* instance, 
+			struct megasas_cmd* cmd_to_abort )
+{
+	struct megasas_cmd*		cmd;
+	struct megasas_abort_frame*	abort_fr;
+
+	cmd = megasas_get_cmd( instance );
+
+	if (!cmd)
+		return -1;
+
+	abort_fr = &cmd->frame->abort;
+
+	/*
+	 * Prepare and issue the abort frame
+	 */
+	abort_fr->cmd				= MFI_CMD_ABORT;
+	abort_fr->cmd_status			= 0xFF;
+	abort_fr->flags				= 0;
+	abort_fr->abort_context			= cmd_to_abort->index;
+	abort_fr->abort_mfi_phys_addr_lo	=
cmd_to_abort->frame_phys_addr;
+	abort_fr->abort_mfi_phys_addr_hi	= 0;
+
+	WR_IN_QPORT( (cmd->frame_phys_addr >> 3), instance->reg_set );
+
+	/*
+	 * Wait for this cmd to complete
+	 */
+	cmd->sync_cmd = 1;
+	wait_event( instance->abort_cmd_wait_q, (cmd->cmd_status != 0xFF));
+
+	megasas_return_cmd( instance, cmd );
+
+	return 0;	
+}
+
+/**
+ * megasas_complete_abort
+ */
+static void
+megasas_complete_abort( struct megasas_instance* instance, 
+				struct megasas_cmd* cmd )
+{
+	if (cmd->sync_cmd) {
+		cmd->sync_cmd = 0;
+		wake_up( &instance->abort_cmd_wait_q );
+	}
+
+	return;
+}
+
+/**
+ * megasas_build_cmd
+ */
+static struct megasas_cmd*
+megasas_build_cmd( struct megasas_instance* instance, struct scsi_cmnd*
scp,
+							int* frame_count )
+{
+	uint32_t		logical_cmd;
+	struct megasas_cmd*	cmd;
+
+	/*
+	 * Find out if this is logical or physical drive command. 
+	 */
+	logical_cmd	= MEGADRV_IS_LOGICAL(scp);
+	
+	/*
+	 * Logical drive command
+	 */
+	if (logical_cmd) {
+
+		if (SCP2TARGET(scp) >= MEGADRV_MAX_LD) {
+			scp->result = DID_BAD_TARGET << 16;
+			return NULL;
+		}
+
+		switch(scp->cmnd[0]) {
+
+		case READ_10:
+		case WRITE_10:
+		case READ_12:
+		case WRITE_12:
+		case READ_6:
+		case WRITE_6:
+		case READ_16:
+		case WRITE_16:
+			/*
+			 * Fail for LUN > 0
+			 */
+			if (SCP2LUN(scp)) {
+				scp->result = DID_BAD_TARGET << 16;
+				return NULL;
+			}
+
+			if (!(cmd = megasas_get_cmd(instance))) {
+				scp->result = DID_ERROR << 16;
+				return NULL;
+			}
+
+			*frame_count = megasas_build_ldio(instance, scp,
cmd);
+
+			if (! (*frame_count) ) {
+				printk( "megasas: build_ldio error\n" );
+				
+				megasas_return_cmd( instance, cmd );
+				
+				return NULL;
+			}
+
+			return cmd;
+
+		case REPORT_LUNS:
+			scp->result	= DID_ERROR << 16;
+			return NULL;
+
+		default:
+			/*
+			 * Fail for LUN > 0
+			 */
+			if (SCP2LUN(scp)) {
+				scp->result = DID_BAD_TARGET << 16;
+				return NULL;
+			}
+
+			if (!(cmd = megasas_get_cmd( instance ))) {
+				scp->result = DID_ERROR << 16;
+				return NULL;
+			}
+
+			*frame_count = megasas_build_dcdb(instance, scp,
cmd);
+
+			if (! (*frame_count) ) {
+				printk( "megasas: build_dcdb error\n" );
+				
+				megasas_return_cmd( instance, cmd );
+				
+				return NULL;
+			}
+
+			return cmd;
+		}
+	}
+	else {
+		scp->result = DID_BAD_TARGET << 16;
+		return NULL;
+	}
+
+	return NULL;
+}
+
+/**
+ * megasas_build_dcdb
+ */
+static int
+megasas_build_dcdb( struct megasas_instance* instance, struct scsi_cmnd*
scp,
+						struct megasas_cmd* cmd )
+{
+	uint32_t			sge_sz;
+	int				sge_bytes;
+	uint32_t			is_logical;
+	uint32_t			device_id;
+	uint16_t			flags = 0;
+	struct megasas_pthru_frame*	pthru;
+
+	is_logical		= MEGADRV_IS_LOGICAL(scp);
+	device_id		= MEGADRV_DEV_INDEX(instance, scp);
+	pthru			= (struct megasas_pthru_frame_t*)
cmd->frame;
+
+	if (scp->sc_data_direction == PCI_DMA_TODEVICE )
+		flags = MFI_FRAME_DIR_WRITE;
+	else if( scp->sc_data_direction == PCI_DMA_FROMDEVICE )
+		flags = MFI_FRAME_DIR_READ;
+	else if( scp->sc_data_direction == PCI_DMA_NONE )
+		flags = MFI_FRAME_DIR_NONE;
+
+	/*
+	 * Prepare the DCDB frame
+	 */
+	pthru->cmd		= (is_logical) ? MFI_CMD_LD_SCSI_IO : 
+							MFI_CMD_PD_SCSI_IO;
+	pthru->cmd_status	= 0x0;
+	pthru->scsi_status	= 0x0;
+	pthru->target_id	= device_id;
+	pthru->lun		= SCP2LUN(scp);
+	pthru->cdb_len		= scp->cmd_len;
+	pthru->timeout		= 0;
+	pthru->flags		= flags;
+	pthru->data_xfer_len	= scp->request_bufflen;
+
+	memcpy(pthru->cdb, scp->cmnd, scp->cmd_len);
+	
+	/*
+	 * Construct SGL
+	 */
+	sge_sz 	= (is_dma64) ? sizeof(struct megasas_sge64) : 
+				sizeof(struct megasas_sge32);
+
+	if (is_dma64) {
+		pthru->flags	|= MFI_FRAME_SGL64;
+		pthru->sge_count = megasas_make_sgl64( instance, scp, 
+								&pthru->sgl
);
+	}
+	else
+		pthru->sge_count = megasas_make_sgl32( instance, scp, 
+								&pthru->sgl
);
+
+	/*
+	 * Sense info specific
+	 */
+	pthru->sense_len		= SCSI_SENSE_BUFFERSIZE;
+	pthru->sense_buf_phys_addr_hi	= 0;
+	pthru->sense_buf_phys_addr_lo	= cmd->sense_phys_addr;
+
+	sge_bytes = sge_sz * pthru->sge_count;	
+
+	cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
+				((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) +
1;
+
+	if (cmd->frame_count > 7)
+		cmd->frame_count = 8;
+
+	return cmd->frame_count;
+}
+
+/**
+ * megasas_build_ldio
+ */
+static int
+megasas_build_ldio( struct megasas_instance* instance, struct scsi_cmnd*
scp,
+						struct megasas_cmd* cmd )
+{
+	uint32_t			sge_sz;
+	int				sge_bytes;
+	uint32_t			device_id;
+	uint8_t				sc = scp->cmnd[0];
+	uint16_t			flags = 0;
+
+	struct megasas_io_frame*	ldio;
+
+	device_id		= MEGADRV_DEV_INDEX(instance, scp);
+	ldio			= (struct megasas_io_frame*) cmd->frame;
+
+	if (scp->sc_data_direction == PCI_DMA_TODEVICE )
+		flags = MFI_FRAME_DIR_WRITE;
+	else if( scp->sc_data_direction == PCI_DMA_FROMDEVICE )
+		flags = MFI_FRAME_DIR_READ;
+
+	/*
+	 * Preare the Logical IO frame: 2nd bit is zero for all read cmds
+	 */
+	ldio->cmd		= (sc &
0x02)?MFI_CMD_LD_WRITE:MFI_CMD_LD_READ;
+	ldio->cmd_status	= 0x0;
+	ldio->scsi_status	= 0x0;
+	ldio->target_id		= device_id;
+	ldio->timeout		= 0;
+	ldio->reserved_0	= 0;
+	ldio->pad_0		= 0;
+	ldio->flags		= flags;
+	ldio->start_lba_hi	= 0;
+	ldio->access_byte	= (scp->cmd_len != 6) ? scp->cmnd[1] : 0;
+
+	/*
+	 * 6-byte READ(0x08) or WRITE(0x0A) cdb
+	 */
+	if (scp->cmd_len == 6) {
+		ldio->lba_count		=	(uint32_t)scp->cmnd[4];
+		ldio->start_lba_lo	= 	((uint32_t)scp->cmnd[1] <<
16)|
+						((uint32_t)scp->cmnd[2] <<
8) |
+						(uint32_t)scp->cmnd[3];
+
+		ldio->start_lba_lo 	&=	0x1FFFFF;
+	}
+
+	/*
+	 * 10-byte READ(0x28) or WRITE(0x2A) cdb
+	 */
+	else if (scp->cmd_len == 10) {
+		ldio->lba_count		=	(uint32_t)scp->cmnd[8] |
+						((uint32_t)scp->cmnd[7] <<
8);
+		ldio->start_lba_lo	=	((uint32_t)scp->cmnd[2] <<
24)|
+						((uint32_t)scp->cmnd[3] <<
16)|
+						((uint32_t)scp->cmnd[4] <<
8)|
+						(uint32_t)scp->cmnd[5];
+	}
+
+	/*
+	 * 12-byte READ(0xA8) or WRITE(0xAA) cdb
+	 */
+	else if (scp->cmd_len == 12) {
+		ldio->lba_count		=	((uint32_t)scp->cmnd[6] <<
24)|
+						((uint32_t)scp->cmnd[7] <<
16)|
+						((uint32_t)scp->cmnd[8] <<
8) |
+						(uint32_t)scp->cmnd[9];
+
+		ldio->start_lba_lo	=	((uint32_t)scp->cmnd[2] <<
24)|
+						((uint32_t)scp->cmnd[3] <<
16)|
+						((uint32_t)scp->cmnd[4] <<
8) |
+						(uint32_t)scp->cmnd[5];
+	}
+
+	/*
+	 * 16-byte READ(0x88) or WRITE(0x8A) cdb
+	 */
+	else if (scp->cmd_len == 16) {
+		ldio->lba_count		=	((uint32_t)scp->cmnd[10] <<
24)|
+						((uint32_t)scp->cmnd[11] <<
16)|
+						((uint32_t)scp->cmnd[12] <<
8) |
+						(uint32_t)scp->cmnd[13];
+
+		ldio->start_lba_lo	=	((uint32_t)scp->cmnd[6] <<
24)|
+						((uint32_t)scp->cmnd[7] <<
16)|
+						((uint32_t)scp->cmnd[8] <<
8) |
+						(uint32_t)scp->cmnd[9];
+
+		ldio->start_lba_hi	=	((uint32_t)scp->cmnd[2] <<
24)|
+						((uint32_t)scp->cmnd[3] <<
16)|
+						((uint32_t)scp->cmnd[4] <<
8) |
+						(uint32_t)scp->cmnd[5];
+
+	}
+
+	/*
+	 * Construct SGL
+	 */
+	sge_sz 	= (is_dma64) ? sizeof(struct megasas_sge64) : 
+					sizeof(struct megasas_sge32);
+
+	if (is_dma64) {
+		ldio->flags	|= MFI_FRAME_SGL64;
+		ldio->sge_count = megasas_make_sgl64( instance, scp, 
+								&ldio->sgl
);
+	}
+	else
+		ldio->sge_count = megasas_make_sgl32( instance, scp, 
+								&ldio->sgl
);
+
+	/*
+	 * Sense info specific
+	 */
+	ldio->sense_len			= SCSI_SENSE_BUFFERSIZE;
+	ldio->sense_buf_phys_addr_hi	= 0;
+	ldio->sense_buf_phys_addr_lo	= cmd->sense_phys_addr;
+
+	sge_bytes = sge_sz * ldio->sge_count;
+
+	cmd->frame_count = (sge_bytes / MEGAMFI_FRAME_SIZE) +
+				((sge_bytes % MEGAMFI_FRAME_SIZE) ? 1 : 0) +
1;
+
+	if (cmd->frame_count > 7) 
+		cmd->frame_count = 8;
+
+	return cmd->frame_count;
+}
+
+/**
+ * megasas_isr
+ */
+static irqreturn_t
+megasas_isr(int irq, void *devp, struct pt_regs *regs)
+{
+	uint32_t				status;
+	int32_t					completed;
+	uint32_t				producer;
+	uint32_t				consumer;
+	uint32_t				context;
+
+	struct megasas_instance*		instance;
+	struct megasas_register_set*		reg_set;
+	struct megasas_cmd*			cmd;
+
+	instance	= (struct megasas_instance*) devp;
+	reg_set		= instance->reg_set;
+
+	/*
+	 * Check if it is our interrupt
+	 */
+	status = RD_OB_INTR_STATUS(reg_set);
+
+	if (! (status & MFI_OB_INTR_STATUS_MASK)) {
+		return IRQ_NONE;
+	}
+
+	/*
+	 * Clear the interrupt by writing back the same value
+	 */
+	WR_OB_INTR_STATUS(status, reg_set);
+
+	producer	= instance->producer;
+	consumer	= instance->consumer;
+	completed	= producer - consumer;
+
+	if (completed < 0) {
+		completed = instance->max_fw_cmds + 1 - consumer;
+	}
+
+	while( completed-- ) {
+		context = instance->reply_queue[consumer];
+
+		cmd = &(instance->cmd_list)[context];
+
+		megasas_complete_cmd( instance, cmd );
+
+		consumer++;
+		if (consumer > instance->max_fw_cmds + 1) {
+			consumer = 0;
+		}
+	}
+
+	wmb();
+	instance->consumer = producer;
+	
+	return IRQ_HANDLED;
+}
+
+static inline void
+megasas_sync_buffers(struct megasas_instance* instance, struct megasas_cmd*
cmd)
+{
+	dma_addr_t	buf_h;
+	uint8_t		opcode;
+
+	if (cmd->scmd->use_sg) {
+		pci_unmap_sg( instance->pdev, cmd->scmd->request_buffer, 
+			cmd->scmd->use_sg, cmd->scmd->sc_data_direction );
+		return;
+	}
+
+	if (!cmd->scmd->request_bufflen)
+		return;
+
+	opcode = cmd->frame->hdr.cmd;
+
+	if ((opcode == MFI_CMD_LD_READ) || (opcode == MFI_CMD_LD_WRITE)) {
+		if (is_dma64)
+			buf_h = cmd->frame->io.sgl.sge64[0].phys_addr;
+		else
+			buf_h = cmd->frame->io.sgl.sge32[0].phys_addr;
+	}
+	else {
+		if (is_dma64)
+			buf_h = cmd->frame->pthru.sgl.sge64[0].phys_addr;
+		else
+			buf_h = cmd->frame->pthru.sgl.sge32[0].phys_addr;
+	}
+
+	pci_unmap_page( instance->pdev, buf_h, cmd->scmd->request_bufflen,
+						cmd->scmd->sc_data_direction
);
+	return;
+}
+
+/**
+ * megasas_complete_cmd
+ */
+static void
+megasas_complete_cmd(struct megasas_instance* instance, struct megasas_cmd*
cmd)
+{
+	struct megasas_header* hdr = &cmd->frame->hdr;
+
+	switch( hdr->cmd ) {
+
+	case MFI_CMD_LD_READ:
+	case MFI_CMD_LD_WRITE:
+	case MFI_CMD_LD_SCSI_IO:
+	case MFI_CMD_PD_SCSI_IO:
+
+		switch (hdr->cmd_status) {
+
+		case MFI_STAT_OK:
+			cmd->scmd->result = DID_OK << 16;
+			break;
+
+		case MFI_STAT_SCSI_DONE_WITH_ERROR:
+			cmd->scmd->result = hdr->scsi_status << 1 |
+						hdr->cmd_status << 8;
+
+			if (hdr->scsi_status == CHECK_CONDITION) {
+				memset( cmd->scmd->sense_buffer, 0,
+
SCSI_SENSE_BUFFERSIZE );
+				memcpy( cmd->scmd->sense_buffer, cmd->sense,

+							hdr->sense_len );
+				cmd->scmd->result |= DRIVER_SENSE << 24 |
+								DID_OK <<
16;
+			}
+			else
+				cmd->scmd->result |= DID_ERROR << 16;
+
+			break;
+
+		case MFI_STAT_DEVICE_NOT_FOUND:	
+			cmd->scmd->result = DID_BAD_TARGET << 16;
+			break;
+
+		default:
+			printk( KERN_NOTICE "megasas: unhandled status
%#x\n", 
+							hdr->cmd_status);
+			cmd->scmd->result = DID_ERROR << 16;
+		}
+
+		spin_lock( instance->host_lock );
+		cmd->scmd->scsi_done( cmd->scmd );
+		spin_unlock( instance->host_lock );
+
+		megasas_return_cmd( instance, cmd );
+
+		megasas_sync_buffers( instance, cmd );
+		break;
+
+	case MFI_CMD_DCMD:
+
+		/*
+		 * See if got an event notification
+		 */
+		if (cmd->frame->dcmd.opcode == MR_DCMD_CTRL_EVENT_WAIT) 
+			megasas_service_aen( instance, cmd );
+		else
+			megasas_complete_int_cmd( instance, cmd );
+	
+		break;
+
+	case MFI_CMD_ABORT:
+		/*
+		 * Cmd issued to abort another cmd returned
+		 */
+		megasas_complete_abort( instance, cmd );
+		break;
+
+	default:
+		printk(KERN_ERR "megasas isr: unknown cmd 0x%x\n
completed!!\n",
hdr->cmd );
+		break;
+	}
+}
+
+/**
+ * megasas_complete_int_cmd
+ */
+static void
+megasas_complete_int_cmd(struct megasas_instance* instance, 
+					struct megasas_cmd* cmd)
+{
+	cmd->cmd_status = cmd->frame->io.cmd_status;
+
+	if (cmd->cmd_status == ENODATA) {
+		cmd->cmd_status = 0;
+	}
+	wake_up( &instance->int_cmd_wait_q );
+}
+
+/**
+ * megasas_mgmt_open
+ */
+static int	
+megasas_mgmt_open( struct inode* inode, struct file* filep )
+{
+	/*
+	 * Allow only those users with admin rights
+	 */
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	return 0;
+}
+
+/**
+ * megasas_mgmt_release
+ */
+static int	
+megasas_mgmt_release( struct inode* inode, struct file* filep )
+{
+	return 0;
+}
+
+/**
+ * megasas_mgmt_fasync
+ */
+static int
+megasas_mgmt_fasync( int fd, struct file* filep, int mode )
+{
+	int rc;
+
+	down( &megasas_async_queue_mutex );
+
+	rc = fasync_helper( fd, filep, mode, &megasas_async_queue );
+
+	up( &megasas_async_queue_mutex );
+
+	if (rc >0)
+		return 0;
+
+	printk( KERN_WARNING "megasas: fasync_helper failed %d\n", rc );
+
+	return rc;
+}
+
+/**
+ * megasas_mgmt_ioctl
+ */
+static int	
+megasas_mgmt_ioctl( struct inode* inode, struct file* filep,
+			unsigned int cmd, unsigned long arg )
+{
+	int				i;
+	int				j;
+	int				rc;
+	uint8_t				fw_status;
+	struct iocpacket		uioc;
+	void __user*			argp;
+	void __user*			udata_addr;
+	uint8_t				user_64bit_sgl = 0;
+	uint32_t			opcode;
+	uint32_t			locale;
+	uint32_t			seq_num;
+	uint32_t*			mbox_word;
+	struct megasas_cmd*		old_cmd;
+
+	struct megasas_instance*		instance;
+	struct megasas_dcmd_frame*		kdcmd;
+	struct megasas_dcmd_frame __user*	udcmd;
+	struct megasas_drv_ver			dv;
+
+	argp = (void __user*) arg;
+
+	if (copy_from_user( &uioc, argp, sizeof(struct iocpacket))) {
+		printk( KERN_WARNING "megasas: copy_from_user failed\n" );
+		return -EINVAL;
+	}
+
+	if (strncmp(uioc.signature, IOC_SIGNATURE, strlen(IOC_SIGNATURE))
!=0){
+		printk( KERN_WARNING "megasas: invalid ioctl signature\n" );
+		return -EINVAL;
+	}
+
+	if (uioc.version != 0) {
+		printk( KERN_WARNING "megasas: invalid ioctl version %d\n", 
+								uioc.version
);
+		return -EINVAL;
+	}
+
+	instance	= NULL;
+	kdcmd		= (struct megasas_dcmd_frame*) uioc.frame;
+	udcmd		= (struct megasas_dcmd_frame*)
+				(((struct iocpacket*)argp)->frame);
+
+	/*
+	 * Find out if user has used 32 or 64 bit SGL
+	 */
+	if (kdcmd->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl)
+		udata_addr = (void __user *) kdcmd->sgl.sge32[0].phys_addr;
+	else
+		udata_addr = (void __user *) (unsigned long) 
+
kdcmd->sgl.sge64[0].phys_addr;
+
+	i = ((uioc.controller_id & 0xF0) >> 4) - 1;
+
+	if (i < megasas_mgmt_info.max_index)
+		instance = megasas_mgmt_info.instance[i];
+	else
+		instance = NULL;
+
+	if ((uioc.control_code == MR_DRIVER_IOCTL_LINUX) ||
+		(uioc.control_code == MR_DRIVER_IOCTL_COMMON)) {
+		/*
+		 * If MR_DRIVER_IOCTL_LINUX or MR_DRIVER_IOCTL_COMMON
+		 * look at dcmd->opcode for the actual operation
+		 */
+		opcode = kdcmd->opcode;
+	}
+	else {
+		/* FW Command */
+		opcode = uioc.control_code;
+	}
+
+	switch (opcode) {
+		
+	case MR_DRIVER_IOCTL_DRIVER_VERSION:
+
+		megasas_fill_drv_ver( &dv );
+
+		if (copy_to_user(udata_addr, &dv, sizeof(dv))) {
+			printk( KERN_WARNING "megasas: copy_to_user
failed\n" );
+			return -EFAULT;
+		}
+
+		rc		= 0;
+		fw_status	= MFI_STAT_OK;
+
+		if (copy_to_user( &udcmd->cmd_status, &fw_status,
+						sizeof(uint8_t))) {
+			rc = -EFAULT;
+			printk( KERN_WARNING "megasas: copy_to_user
failed\n" );
+		}
+
+		break;
+
+	case MR_LINUX_GET_ADAPTER_COUNT:
+
+		if (copy_to_user(udata_addr, &megasas_mgmt_info.count,
+							sizeof(uint16_t))) {
+			printk( KERN_WARNING "megasas: copy_to_user
failed\n" );
+			return -EFAULT;
+		}
+
+		rc		= 0;
+		fw_status	= MFI_STAT_OK;
+
+		if (copy_to_user( &udcmd->cmd_status, &fw_status,
+						sizeof(uint8_t))) {
+			rc = -EFAULT;
+			printk( KERN_WARNING "megasas: copy_to_user
failed\n" );
+		}
+
+		break;
+
+	case MR_LINUX_GET_ADAPTER_MAP:
+		/*
+		 * README: encrypting logic for adapter map
+		 * The adpater field size allows up to 16-bit adapter
number,
+		 * which translates into 65536 possible adapters, which
+		 * obviously is too much. So we reserve the lower 4-bits to
+		 * put the coding nibble (0xF) and add 1 to the adapter
+		 * number. Applications shall have (12-bits - 1) to provide
+		 * the adapter number. This still translates in 4095
possible
+		 * adapters, which should be  sufficient :-)
+		*/
+		memset(megasas_mgmt_info.map, 0,
+			sizeof(uint16_t) * MAX_MGMT_ADAPTERS);
+
+		j = 0;
+		for (i = 0; i < megasas_mgmt_info.max_index; i++) {
+			if (megasas_mgmt_info.instance[i]) {
+				megasas_mgmt_info.map[j++] =
+					((i + 1) << 4) | 0xF;
+			}
+		}
+
+		if ((j) && (copy_to_user(udata_addr, megasas_mgmt_info.map,
+				sizeof(uint16_t) * j))) {
+
+			printk(KERN_ERR "megasas:invalid uaddr for hba
map\n" );
+			return -EFAULT;
+		}
+
+		fw_status	= MFI_STAT_OK;
+		rc		= 0;
+
+		if (copy_to_user( &udcmd->cmd_status, &fw_status,
+						sizeof(uint8_t))) {
+			rc = -EFAULT;
+			printk( KERN_ERR "megasas: invalid uaddr\n" );
+		}
+
+		break;
+
+	case MR_LINUX_GET_AEN:
+
+		if (!instance) {
+			printk( KERN_WARNING "megasas: invalid instance \n"
);
+			return -ENODEV;
+		}
+
+		mbox_word	= (uint32_t*) kdcmd->mbox;
+		seq_num		= mbox_word[0];
+		locale		= mbox_word[1];
+		old_cmd		= instance->aen_cmd;
+
+		if (old_cmd) {
+			old_cmd->abort_aen = 1;
+			rc = megasas_sync_abort_cmd(instance, old_cmd);
+
+			if (rc) {
+				printk(KERN_WARNING "megasas: failed to
abort \
+								prev aen\n"
);
+				break;
+			}
+		}
+
+		rc = megasas_register_aen( instance, seq_num, locale );
+
+		break;
+
+	case IOC_CMD_FIRMWARE:
+
+		if (!instance) {
+			printk( KERN_WARNING "megasas: invalid instance \n"
);
+			return -ENODEV;
+		}
+
+		rc = megasas_mgmt_fw_ioctl( instance, argp );
+
+		break;
+
+	default:
+		printk( KERN_WARNING "megasas: unsupported ioctl %d\n", 
+							uioc.control_code );
+		return -ENOTTY;
+	}
+
+	return rc;
+}
+
+/**
+ * megasas_mgmt_fw_ioctl
+ */
+static int
+megasas_mgmt_fw_ioctl( struct megasas_instance* instance, void __user* argp
)
+{
+	struct iocpacket		uioc;
+	struct megasas_header*		hdr;
+	struct megasas_cmd*		cmd;
+
+	if (copy_from_user(&uioc, argp, sizeof(struct iocpacket))) {
+		printk( KERN_ERR "megasas ioctl: copy_from_user failed\n" );
+		return -EFAULT;
+	}
+
+	cmd = megasas_get_cmd( instance );
+
+	if (!cmd) {
+		printk( KERN_WARNING "megasas: failed to get a cmd packet\n"
);
+		return -ENOMEM;
+	}
+
+	hdr = (struct megasas_header*) &uioc.frame;
+
+	switch( hdr->cmd ) {
+
+		case MFI_CMD_DCMD:
+			return megasas_mgmt_fw_dcmd(instance, &uioc, argp,
cmd);
+
+		case MFI_CMD_SMP:
+			return megasas_mgmt_fw_smp(instance, &uioc, argp,
cmd);
+
+		default:
+			printk( KERN_WARNING "megasas: invalid fw ioctl \n"
);
+			return -EINVAL;
+	}
+
+	megasas_return_cmd( instance, cmd );
+	return 0;
+}
+
+/**
+ * megasas_mgmt_fw_dcmd
+ */
+static int
+megasas_mgmt_fw_dcmd( struct megasas_instance* instance, struct iocpacket*
uioc,
+				void __user* argp, struct megasas_cmd* cmd )
+{
+	int					rc = 0;
+	void __user*				ubuff;
+	struct megasas_dcmd_frame*		kdcmd;
+	struct megasas_dcmd_frame __user*	udcmd;
+	struct megasas_dcmd_frame*		cmd_dcmd;
+	caddr_t					kbuff;
+	dma_addr_t				kbuff_h;
+	uint32_t				xferlen;
+	uint8_t					user_64bit_sgl = 0;
+
+	cmd_dcmd	= &cmd->frame->dcmd;
+	kdcmd 		= (struct megasas_dcmd_frame_t*) &uioc->frame;
+	udcmd		= (struct megasas_dcmd_frame_t*) 
+				(((struct iocpacket*)argp)->frame);
+
+	if (kdcmd->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl) {
+		xferlen	= kdcmd->sgl.sge32[0].length;
+		ubuff	= (void __user*) udcmd->sgl.sge32[0].phys_addr;
+	}
+	else {
+		xferlen	= kdcmd->sgl.sge64[0].length;
+		ubuff	= (void __user*) (ulong)
udcmd->sgl.sge64[0].phys_addr;
+	}
+
+	/*
+	 * Allocate internal buffer for data transfer
+	 */
+	if (xferlen)
+		kbuff = pci_alloc_consistent(instance->pdev, xferlen,
&kbuff_h);
+	else
+		kbuff = NULL;
+
+	if (xferlen && !kbuff) {
+		printk( KERN_ERR "megasas: memalloc failed for int buff \n"
);
+		return -ENOMEM;
+	}
+
+	if (xferlen && (kdcmd->flags & MFI_FRAME_DIR_WRITE)) {
+
+		if (copy_from_user(kbuff, ubuff, xferlen)) {
+			printk( KERN_ERR "megasas: cp_from_usr failed\n" );
+			return -EFAULT;
+		}
+	}
+
+	cmd_dcmd->cmd				= kdcmd->cmd;
+	cmd_dcmd->cmd_status			= kdcmd->cmd_status;
+	cmd_dcmd->sge_count			= kdcmd->sge_count;
+	cmd_dcmd->timeout			= kdcmd->timeout;
+	cmd_dcmd->data_xfer_len			= kdcmd->data_xfer_len;
+	cmd_dcmd->opcode			= kdcmd->opcode;
+
+	memcpy( cmd_dcmd->mbox, kdcmd->mbox, 12 );
+
+	if (!user_64bit_sgl) {
+		cmd_dcmd->flags			= kdcmd->flags;
+		cmd_dcmd->sgl.sge32[0].length	=
kdcmd->sgl.sge32[0].length;
+		cmd_dcmd->sgl.sge32[0].phys_addr= kbuff_h;
+	}
+	else {
+		cmd_dcmd->flags			= kdcmd->flags
|MFI_FRAME_SGL64;
+		cmd_dcmd->sgl.sge64[0].length	=
kdcmd->sgl.sge64[0].length;
+		cmd_dcmd->sgl.sge64[0].phys_addr= kbuff_h;
+	}
+
+	if (!megasas_issue_blocked_cmd( instance, cmd )) {
+
+		if (xferlen && (kdcmd->flags & MFI_FRAME_DIR_READ)) {
+
+			if (copy_to_user( ubuff, kbuff, xferlen)) {
+
+				printk(KERN_ERR "megasas: cp_to_usr
failed\n");
+				rc = -EFAULT;
+				goto exit_label;
+			}
+		}
+
+		if (copy_to_user( &udcmd->cmd_status, &cmd_dcmd->cmd_status,

+							sizeof(uint8_t))) {
+			printk(KERN_ERR "megasas: cp_to_usr failed\n");
+			rc = -EFAULT;
+			goto exit_label;
+		}
+	}
+	else {
+		printk( KERN_WARNING "megasas: fw_ioctl failed\n" );
+	}
+
+exit_label:
+	pci_free_consistent( instance->pdev, xferlen, kbuff, kbuff_h );
+	return rc;
+}
+
+/**
+ * megasas_mgmt_fw_smp
+ */
+static int
+megasas_mgmt_fw_smp( struct megasas_instance* instance, struct iocpacket*
uioc,
+				void __user* argp, struct megasas_cmd* cmd )
+{
+	int					rc = 0;
+	struct megasas_smp_frame*		ksmp;
+	struct megasas_smp_frame __user*	usmp;
+	struct megasas_smp_frame*		cmd_smp;
+
+	caddr_t				kreq;
+	caddr_t				kresp;
+	dma_addr_t			kreq_h;
+	dma_addr_t			kresp_h;
+	void __user*			ureq;
+	void __user*			uresp;
+	uint32_t			req_len;
+	uint32_t			resp_len;
+
+	uint8_t				user_64bit_sgl = 0;
+
+	cmd_smp		= &cmd->frame->smp;
+	ksmp 		= (struct megasas_smp_frame*) &uioc->frame;
+	usmp		= (struct megasas_smp_frame_t*) 
+				(((struct iocpacket*)argp)->frame);
+
+	if (ksmp->flags & MFI_FRAME_SGL64 )
+		user_64bit_sgl = 1;
+
+	if (!user_64bit_sgl) {
+		req_len		= ksmp->request_sgl.sge32[0].length;
+		resp_len	= ksmp->response_sgl.sge32[0].length;
+
+		ureq	= (void __user*)
usmp->request_sgl.sge32[0].phys_addr;
+		uresp	= (void __user*)
usmp->response_sgl.sge32[0].phys_addr;
+	}
+	else {
+		req_len		= ksmp->request_sgl.sge64[0].length;
+		resp_len	= ksmp->response_sgl.sge64[0].length;
+
+		ureq	= (void __user*) (ulong) 
+
usmp->request_sgl.sge64[0].phys_addr;
+		uresp	= (void __user*) (ulong) 
+
usmp->response_sgl.sge64[0].phys_addr;
+	}
+
+	if (!req_len || !resp_len) {
+		printk( KERN_WARNING "megasas: invalid req/resp lenghth\n"
);
+		return -EINVAL;
+	}
+
+	/*
+	 * Allocate kernel buffers for SMP request and response
+	 */
+
+	kreq	= NULL;
+	kresp	= NULL;
+
+	if (!(kreq = pci_alloc_consistent(instance->pdev, req_len,
&kreq_h))){
+
+		printk( KERN_ERR "megasas: memalloc err for req\n" );
+		rc = -ENOMEM;
+		goto exit_label;
+	}
+
+	if(!(kresp = pci_alloc_consistent(instance->pdev, resp_len,
&kresp_h))){
+		printk( KERN_ERR "megasas: memalloc err for resp\n" );
+		rc = -ENOMEM;
+		goto exit_label;
+	}
+
+	if (copy_from_user(kreq, ureq, req_len)) {
+		printk( KERN_ERR "megasas: copy_from_user failed\n" );
+		rc = -EFAULT;
+		goto exit_label;
+	}
+
+	memcpy (cmd_smp, ksmp, MEGAMFI_FRAME_SIZE );
+	cmd_smp->context = cmd->index;
+			
+	if (!user_64bit_sgl) {
+		cmd_smp->flags					=
ksmp->flags;
+		cmd_smp->request_sgl.sge32[0].length		= req_len;
+		cmd_smp->request_sgl.sge32[0].phys_addr		= kreq_h;
+		cmd_smp->response_sgl.sge32[0].length		= resp_len;
+		cmd_smp->response_sgl.sge32[0].phys_addr	= kresp_h;
+	}
+	else {
+		cmd_smp->flags					=
ksmp->flags |
+
MFI_FRAME_SGL64;
+		cmd_smp->request_sgl.sge64[0].length		= req_len;
+		cmd_smp->request_sgl.sge64[0].phys_addr		= kreq_h;
+		cmd_smp->response_sgl.sge64[0].length		= resp_len;
+		cmd_smp->response_sgl.sge64[0].phys_addr	= kresp_h;
+	}
+
+	if (!megasas_issue_blocked_cmd( instance, cmd )) {
+
+		if (copy_to_user( uresp, kresp, resp_len)) {
+			printk( KERN_ERR "megasas: copy_to_user failed\n" );
+			rc = -EFAULT;
+			goto exit_label;
+		}
+
+		if (copy_to_user( &usmp->cmd_status, &cmd_smp->cmd_status, 
+							sizeof(uint8_t))) {
+			printk( KERN_ERR "megasas: copy_to_user failed\n" );
+			rc = -EFAULT;
+			goto exit_label;
+		}
+	}
+	else {
+		printk( KERN_WARNING "megasas: smp failed\n" );
+	}
+
+exit_label:
+
+	if (kreq)
+		pci_free_consistent(instance->pdev, req_len, kreq, kreq_h);
+	if (kresp)
+		pci_free_consistent(instance->pdev, resp_len, kresp,
kresp_h);
+
+	return rc;
+}
+
+/**
+ * megasas_sysfs_show_app_hndl
+ */
+static ssize_t
+megasas_sysfs_show_app_hndl( struct class_device* cdev, char* buf )
+{
+	int				i;
+	uint32_t			hndl = 0;
+	struct Scsi_Host*		shost;
+	struct megasas_instance*	instance;
+
+	shost		= class_to_shost( cdev );
+	instance	= (struct megasas_instance*)SCSIHOST2ADAP( shost );
+
+	for (i = 0; i < megasas_mgmt_info.max_index; i++ ) {
+
+		if (instance == megasas_mgmt_info.instance[i])
+			hndl = ((i + 1) << 4) | 0xF;
+	}
+
+	return snprintf( buf, 8, "%u\n", hndl );
+}
+
+/**
+ * megasas_fill_drv_ver
+ */
+static void
+megasas_fill_drv_ver( struct megasas_drv_ver* dv )
+{
+	memset( dv, 0, sizeof(struct megasas_drv_ver) );
+
+	memcpy(dv->signature,	"$LSI LOGIC$",	strlen("$LSI LOGIC$")	);
+	memcpy(dv->os_name,	"Linux",	strlen("Linux")		);
+	memcpy(dv->os_ver,	"Ver Indpndt",	strlen("ver indpndt")	);
+	memcpy(dv->drv_name,	"megaraid_sas",	strlen("megaraid_sas")	);
+	memcpy(dv->drv_ver,	MEGASAS_VERSION,strlen(MEGASAS_VERSION)	);
+	memcpy(dv->drv_rel_date,MEGASAS_RELDATE,strlen(MEGASAS_RELDATE)	);
+}
+
+/**
+ * megasas_get_controller_info
+ */
+static int
+megasas_get_ctrl_info( struct megasas_instance* instance,
+				struct megasas_ctrl_info* ctrl_info )
+{
+	int				i;
+	int				ret = 0;
+	struct megasas_cmd*		cmd;
+	struct megasas_dcmd_frame*	dcmd;
+	struct megasas_ctrl_info*	ci;
+	dma_addr_t			ci_h;
+
+	cmd = megasas_get_cmd( instance );
+
+	if (!cmd) {
+		printk( KERN_WARNING "Failed to get a cmd for ctrl info\n"
);
+		return -ENOMEM;
+	}
+
+	dcmd = &cmd->frame->dcmd;
+
+	ci = pci_alloc_consistent( instance->pdev, 
+				sizeof(struct megasas_ctrl_info), &ci_h );
+
+	if (!ci) {
+		printk( KERN_WARNING "Failed to alloc mem for ctrl info\n"
);
+		megasas_return_cmd( instance, cmd );
+		return -ENOMEM;
+	}
+
+	memset( ci, 0, sizeof(struct megasas_ctrl_info));
+	for( i = 0; i < 12; i++ ) dcmd->mbox[i] = 0;
+
+	dcmd->cmd			= MFI_CMD_DCMD;
+	dcmd->cmd_status		= 0xFF;
+	dcmd->sge_count			= 1;
+	dcmd->flags			= MFI_FRAME_DIR_READ;
+	dcmd->timeout			= 0;
+	dcmd->data_xfer_len		= sizeof(struct megasas_ctrl_info);
+	dcmd->opcode			= MR_DCMD_CTRL_GET_INFO;
+	dcmd->sgl.sge32[0].phys_addr	= ci_h;
+	dcmd->sgl.sge32[0].length	= sizeof(struct megasas_ctrl_info);
+
+	if (!megasas_issue_polled( instance, cmd )) {
+		ret = 0;
+		memcpy( ctrl_info, ci, sizeof(struct megasas_ctrl_info));
+	}
+	else {
+		printk( KERN_WARNING "Ctrl info failed\n" );
+		ret = -1;
+	}
+
+	pci_free_consistent( instance->pdev, sizeof(struct
megasas_ctrl_info),
+								ci, ci_h );
+		
+	megasas_return_cmd( instance, cmd );
+	return ret;
+}
+
+module_init( megasas_init );
+module_exit( megasas_exit );
+
+/* vim: set ts=8 sw=8 tw=78 ai si: */
