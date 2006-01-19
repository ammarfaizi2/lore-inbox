Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161261AbWASP7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161261AbWASP7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWASP7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:59:20 -0500
Received: from rtr.ca ([64.26.128.89]:29592 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1161261AbWASP7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:59:19 -0500
Message-ID: <43CFB747.3000807@rtr.ca>
Date: Thu, 19 Jan 2006 10:59:03 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Helge Hafting <helge.hafting@aitel.hist.no>,
       Cynbe ru Taren <cynbe@muq.org>, linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org>	 <43CE1E52.3030907@aitel.hist.no>  <43CE6997.6090005@rtr.ca> <1137605541.29681.13.camel@localhost.localdomain>
In-Reply-To: <1137605541.29681.13.camel@localhost.localdomain>
Content-Type: multipart/mixed;
 boundary="------------010902020602080403020308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010902020602080403020308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Alan Cox wrote:
> PS: How is the delkin_cb driver - does it know how to do modes and stuff
> yet ? Just wondering if I should pull a version for libata whacking

I whacked at it for libata a while back, and then shelved it while awaiting
PIO to appear in a released libata version.  Now that we've got PIO, I ought
to add a couple of lines to bind in the right functions and release it.

No knowledge of "modes" and stuff -- but the basic register settings I
reverse engineered seem to work adequately on the cards I have here.

But the card is a total slug unless the host does 32-bit PIO to/from it.
Do we have that capability in libata yet?

My last hack at it (without the necessary libata PIO bindings) is attached,
but this is several revisions behind libata now, and probably needs some
updates to compile.  Suggestions welcomed.

Cheers


--------------010902020602080403020308
Content-Type: text/x-csrc;
 name="pata_delkin_cb.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pata_delkin_cb.c"

/*
 *  Delkin CardBus IDE CompactFlash Adapter
 *
 *  This program is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU General Public License
 *  as published by the Free Software Foundation; either version
 *  2 of the License, or (at your option) any later version.
 *
 *  Written by Mark Lord, Real-Time Remedies Inc.
 *  Copyright (C) 2005 	Mark Lord <mlord@pobox.com>
 *  Released under terms of General Public License
 * 
 */
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/delay.h>
#include "scsi.h"
#include <scsi/scsi_host.h>
#include <linux/libata.h>
#include <asm/io.h>

#define DRV_NAME	"delkin_cb"
#define DRV_VERSION	"0.01"

static int  delkin_cb_init_one(struct pci_dev *pdev, const struct pci_device_id *ent);
static void delkin_cb_remove_one(struct pci_dev *pdev);

static struct pci_device_id delkin_cb_pci_tbl[] = {
	{ PCI_VENDOR_ID_WORKBIT, PCI_DEVICE_ID_WORKBIT_CB, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
	{ }	/* terminate list */
};

static struct pci_driver delkin_cb_pci_driver = {
	.name			= DRV_NAME,
	.id_table		= delkin_cb_pci_tbl,
	.probe			= delkin_cb_init_one,
	.remove			= __devexit_p(delkin_cb_remove_one),
};

static Scsi_Host_Template delkin_cb_sht = {
	.module			= THIS_MODULE,
	.name			= DRV_NAME,
	.ioctl			= ata_scsi_ioctl,
	.queuecommand		= ata_scsi_queuecmd,
	.eh_strategy_handler	= ata_scsi_error,
	.can_queue		= ATA_DEF_QUEUE,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= 256,
	.max_sectors		= 256,
	.cmd_per_lun		= 1,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= ENABLE_CLUSTERING,
	.proc_name		= DRV_NAME,
	.bios_param		= ata_std_bios_param,
	.resume			= ata_scsi_device_resume,
	.suspend		= ata_scsi_device_suspend,
};

static int no_check_atapi_dma(struct ata_queued_cmd *qc)
{
	printk("no_check_atapi_dma\n");
	return 1; /* atapi DMA not okay */
}

static void no_bmdma_stop(struct ata_port *ap)
{
	printk("no_bmdma_stop\n");
}

static u8 no_bmdma_status(struct ata_port *ap)
{
	printk("no_bmdma_status\n");
	return 0;
}

static void no_irq_clear(struct ata_port *ap)
{
	printk("no_irq_clear\n");
}

static void no_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
{
	printk("no_scr_write\n");
}

static u32 no_scr_read (struct ata_port *ap, unsigned int sc_reg)
{
	printk("no_scr_read\n");
	return ~0U;
}

static void no_phy_reset(struct ata_port *ap)
{
	printk("no_phy_reset\n");
	ap->flags &= ~ATA_FLAG_PORT_DISABLED;
	ata_bus_reset(ap);
}

static int delkin_cb_qc_issue(struct ata_queued_cmd *qc)
{
	printk("qc_issue: cmd=0x%02x proto=%d\n", qc->tf.command, qc->tf.protocol);
	switch (qc->tf.protocol) {
	case ATA_PROT_NODATA:
	case ATA_PROT_PIO:
		return ata_qc_issue_prot(qc);
	default:
		printk("qc_issue: bad protocol: %d\n", qc->tf.protocol);
		return -1;
	}
}

static struct ata_port_operations delkin_cb_ops = {
	.port_disable		= ata_port_disable,
	.tf_load		= ata_tf_load,
	.tf_read		= ata_tf_read,
	.check_status		= ata_check_status,
	.check_atapi_dma	= no_check_atapi_dma,
	.exec_command		= ata_exec_command,
	.dev_select		= ata_std_dev_select,
	.phy_reset		= no_phy_reset,
	.qc_prep		= ata_qc_prep,
	.qc_issue		= delkin_cb_qc_issue,
	.eng_timeout		= ata_eng_timeout,
	.irq_handler		= ata_interrupt,
	.irq_clear		= no_irq_clear,
	.scr_read		= no_scr_read,
	.scr_write		= no_scr_write,
	.port_start		= ata_port_start,
	.port_stop		= ata_port_stop,
	.bmdma_stop		= no_bmdma_stop,
	.bmdma_status		= no_bmdma_status,
};

static struct ata_port_info delkin_cb_port_info[] = {
	{
		.sht		= &delkin_cb_sht,
		.host_flags	= ATA_FLAG_SRST,
		.pio_mask	= 0x1f, /* pio0-4 */
		.port_ops	= &delkin_cb_ops,
	},
};

MODULE_AUTHOR("Mark Lord");
MODULE_DESCRIPTION("Basic support for Delkin-ASKA-Workbit Cardbus IDE");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, delkin_cb_pci_tbl);

/*
 * No chip documentation has yet been found,
 * so these configuration values were pulled from
 * a running Win98 system using "debug".
 * This gives around 3MByte/second read performance,
 * which is about 1/3 of what the chip is capable of.
 *
 * There is also a 4KByte mmio region on the card,
 * but its purpose has yet to be reverse-engineered.
 */
static const u8 delkin_cb_setup[] = {
	0x00, 0x05, 0xbe, 0x01, 0x20, 0x8f, 0x00, 0x00,
	0xa4, 0x1f, 0xb3, 0x1b, 0x00, 0x00, 0x00, 0x80,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0xa4, 0x83, 0x02, 0x13,
};

/**
 * delkin_cb_init_one - PCI probe function
 * Called when an instance of cardbus adapter is inserted.
 * 
 * @pdev: instance of pci_dev found
 * @ent:  matching entry in the id_tbl[]
 */
static int __devinit delkin_cb_init_one(struct pci_dev *pdev,
					const struct pci_device_id *ent)
{
	static int printed_version;
	struct ata_probe_ent *probe_ent = NULL;
	unsigned long io_base;
	unsigned int board_idx = (unsigned int) ent->driver_data;
	int i, rc;

	if (!printed_version++)
		printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");

	rc = pci_enable_device(pdev);
	if (rc)
		return rc;

	rc = pci_request_regions(pdev, DRV_NAME);
	if (rc)
		goto err_out;

	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
	if (probe_ent == NULL) {
		rc = -ENOMEM;
		goto err_out_regions;
	}

	memset(probe_ent, 0, sizeof(*probe_ent));
	probe_ent->dev = pci_dev_to_dev(pdev);
	INIT_LIST_HEAD(&probe_ent->node);

	probe_ent->sht		= delkin_cb_port_info[board_idx].sht;
	probe_ent->host_flags	= delkin_cb_port_info[board_idx].host_flags;
	probe_ent->pio_mask	= delkin_cb_port_info[board_idx].pio_mask;
	probe_ent->port_ops	= delkin_cb_port_info[board_idx].port_ops;

       	probe_ent->irq = pdev->irq;
       	probe_ent->irq_flags = SA_SHIRQ;
	io_base = pci_resource_start(pdev, 0);
	probe_ent->n_ports = 1;

	/* Initialize the device configuration registers */
	outb(0x02, io_base + 0x1e);	/* set nIEN to block interrupts */
	inb(io_base + 0x17);		/* read status to clear interrupts */
	for (i = 0; i < sizeof(delkin_cb_setup); ++i) {
		if (delkin_cb_setup[i])
			outb(delkin_cb_setup[i], io_base + i);
	}
	inb(io_base + 0x17);		/* read status to clear interrupts */

	probe_ent->port[0].cmd_addr = io_base + 0x10;
	ata_std_ports(&probe_ent->port[0]);
	probe_ent->port[0].altstatus_addr =
		probe_ent->port[0].ctl_addr = io_base + 0x1e;

	ata_device_add(probe_ent);
	kfree(probe_ent);

	// drive->io_32bit = 1;
	// drive->unmask   = 1;

	return 0;

err_out_regions:
	pci_release_regions(pdev);
err_out:
	pci_disable_device(pdev);
	return rc;
}

/**
 * delkin_cb_remove_one - Called to remove a single instance of the
 * adapter.
 *
 * @dev: The PCI device to remove.
 * FIXME: module load/unload not working yet
 */
static void __devexit delkin_cb_remove_one(struct pci_dev *pdev)
{
	ata_pci_remove_one(pdev);
}
/**
 * delkin_cb_init - Called after this module is loaded into the kernel.
 */
static int __init delkin_cb_init(void)
{
	return pci_module_init(&delkin_cb_pci_driver);
}
/**
 * delkin_cb_exit - Called before this module unloaded from the kernel
 */
static void __exit delkin_cb_exit(void)
{
	pci_unregister_driver(&delkin_cb_pci_driver);
}

module_init(delkin_cb_init);
module_exit(delkin_cb_exit);

--------------010902020602080403020308--
