Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263284AbUCRXWj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbUCRXV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:21:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48342 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263284AbUCRXGG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:06:06 -0500
Message-ID: <405A2B4A.9090001@pobox.com>
Date: Thu, 18 Mar 2004 18:05:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zero10 <damouse@zero10.demon.co.uk>
CC: linux-kernel@vger.kernel.org, uwe.koziolek@gmx.net,
       linux-ide@vger.kernel.org
Subject: Re: Fw: SiS 964 SerialATA developers anywhere?
References: <003001c40d3b$dd275330$2200a8c0@glowworm>
In-Reply-To: <003001c40d3b$dd275330$2200a8c0@glowworm>
Content-Type: multipart/mixed;
 boundary="------------080505090704090400060507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080505090704090400060507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Zero10 wrote:
> Hey All,
>             Gonna be buying a 160GB SATA drive sometime 
> in the very near future and was wondering whether there
>  were any drivers in the works or anything for Linux? or
>  any way to get it working at all under Linux?

Uwe Koziolek has written a basic driver that works for him...  but it is 
only in PIO mode, and so it is --very-- slow.

I have documentation, but no time to work on SiS in the past month or so 
:(  I looked over Uwe's driver and didn't see anything wrong, I'll have 
to look again with a closer eye.

	Jeff



--------------080505090704090400060507
Content-Type: text/plain;
 name="sata_sis.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sata_sis.c"

/*
 *  sata_sis.c - Silicon Integrated Systems SATA
 *
 *  Copyright 2004 Uwe Koziolek <uwe.koziolek@gmx.net>
 *
 *  The contents of this file are subject to the Open
 *  Software License version 1.1 that can be found at
 *  http://www.opensource.org/licenses/osl-1.1.txt and is included herein
 *  by reference.
 *
 *  Alternatively, the contents of this file may be used under the terms
 *  of the GNU General Public License version 2 (the "GPL") as distributed
 *  in the kernel source COPYING file, in which case the provisions of
 *  the GPL are applicable instead of the above.  If you wish to allow
 *  the use of your version of this file only under the terms of the
 *  GPL and not to allow others to use your version of this file under
 *  the OSL, indicate your decision by deleting the provisions above and
 *  replace them with the notice and other provisions required by the GPL.
 *  If you do not delete the provisions above, a recipient may use your
 *  version of this file under either the OSL or the GPL.
 *
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/delay.h>
#include <linux/interrupt.h>
#include "scsi.h"
#include "hosts.h"
#include <linux/libata.h>

#define DRV_NAME	"sata_sis"
#define DRV_VERSION	"0.02"

enum {
	sis_180			= 0,
};

static void sis_set_piomode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int pio);
static void sis_set_udmamode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int udma);
static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg);
static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);

static struct pci_device_id sis_pci_tbl[] = {
	{ 0x1039, 0x0180, PCI_ANY_ID, PCI_ANY_ID, 0, 0, sis_180 },
	{ }	/* terminate list */
};


static struct pci_driver sis_pci_driver = {
	.name			= DRV_NAME,
	.id_table		= sis_pci_tbl,
	.probe			= sis_init_one,
	.remove			= ata_pci_remove_one,
};

static Scsi_Host_Template sis_sht = {
	.module			= THIS_MODULE,
	.name			= DRV_NAME,
	.queuecommand		= ata_scsi_queuecmd,
	.eh_strategy_handler	= ata_scsi_error,
	.can_queue		= ATA_DEF_QUEUE,
	.this_id		= ATA_SHT_THIS_ID,
	.sg_tablesize		= ATA_MAX_PRD,
	.max_sectors		= ATA_MAX_SECTORS,
	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
	.emulated		= ATA_SHT_EMULATED,
	.use_clustering		= ATA_SHT_USE_CLUSTERING,
	.proc_name		= DRV_NAME,
	.dma_boundary		= ATA_DMA_BOUNDARY,
	.slave_configure	= ata_scsi_slave_config,
	.bios_param		= ata_std_bios_param,
};

static struct ata_port_operations sis_ops = {
	.port_disable		= ata_port_disable,
	.set_piomode		= sis_set_piomode,
	.set_udmamode		= sis_set_udmamode,
	.tf_load		= ata_tf_load_pio,
	.tf_read		= ata_tf_read_pio,
	.check_status		= ata_check_status_pio,
	.exec_command		= ata_exec_command_pio,
	.phy_reset		= sata_phy_reset,
	.phy_config		= pata_phy_config,
	.bmdma_start            = ata_bmdma_start_pio,
	.fill_sg		= ata_fill_sg,
	.eng_timeout		= ata_eng_timeout,
	.irq_handler		= ata_interrupt,
	.scr_read		= sis_scr_read,
	.scr_write		= sis_scr_write,
	.port_start		= ata_port_start,
	.port_stop		= ata_port_stop,
};

static struct ata_port_info sis_port_info[] = {
	/* sis_180 */
	{
		.sht		= &sis_sht,
		.host_flags	= ATA_FLAG_SATA, ATA_FLAG_NO_LEGACY |
				  ATA_FLAG_SRST,
		.pio_mask	= 0x03,			/* pio3-4 */
		.udma_mask	= 0x7f,			/* udma0-6; FIXME */
		.port_ops	= &sis_ops,
	}
};

MODULE_AUTHOR("Uwe Koziolek");
MODULE_DESCRIPTION("low-level driver for Silicon Integratad Systems SATA controller");
MODULE_LICENSE("GPL");
MODULE_DEVICE_TABLE(pci, sis_pci_tbl);


static u32 sis_scr_read (struct ata_port *ap, unsigned int sc_reg)
{
	DPRINTK("ENTER/LEAVE sc_reg=%d\n", sc_reg);
	if (sc_reg >= 16) return 0xffffffffU;
	return inl(ap->ioaddr.scr_addr+(sc_reg*4));
}

static void sis_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val)
{
	DPRINTK("ENTER/LEAVE sc_reg=%d, val=%08x\n", sc_reg,  val);
	if (sc_reg >= 16) return;
	outl(val, ap->ioaddr.scr_addr+(sc_reg*4));
}

static void sis_set_piomode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int pio)
{
/* this hack forces IO to uses PIO intead of DMA, because the DMA code
 * for this chipset is not completed yet.
 */
	DPRINTK("ENTER/LEAVE\n");
	adev->flags |= ATA_DFLAG_PIO;
}

static void sis_set_udmamode (struct ata_port *ap, struct ata_device *adev,
			      unsigned int udma)
{
	DPRINTK("ENTER/LEAVE\n");
}

static int sis_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
{
	struct ata_probe_ent *probe_ent = NULL;
	struct ata_port_info *port0 = &sis_port_info[sis_180];
	int rc;

	DPRINTK("ENTER\n");

	rc = pci_enable_device(pdev);
	if (rc)
		return rc;

	rc = pci_request_regions(pdev, DRV_NAME);
	if (rc)
		goto err_out;

	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
	if (rc)
		goto err_out_regions;

	probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
	if (!probe_ent) {
		rc = -ENOMEM;
		goto err_out_regions;
	}

	memset(probe_ent, 0, sizeof(*probe_ent));
	probe_ent->pdev = pdev;
	INIT_LIST_HEAD(&probe_ent->node);

	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
	probe_ent->sht = port0->sht;
	probe_ent->host_flags = port0->host_flags;
	probe_ent->pio_mask = port0->pio_mask;
	probe_ent->udma_mask = port0->udma_mask;
	probe_ent->port_ops = port0->port_ops;

	probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
	ata_std_ports(&probe_ent->port[0]);
	probe_ent->port[0].ctl_addr =
		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
	probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
	probe_ent->port[0].scr_addr = pci_resource_start(pdev, 5);
	probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
	ata_std_ports(&probe_ent->port[1]);
	probe_ent->port[1].ctl_addr =
		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
	probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
	probe_ent->port[1].scr_addr = pci_resource_start(pdev, 5) + 64;

	probe_ent->n_ports = 2;
	probe_ent->irq = pdev->irq;
	probe_ent->irq_flags = SA_SHIRQ;

	pci_set_master(pdev);

	ata_device_add(probe_ent);
	kfree(probe_ent);

	DPRINTK("LEAVE\n");
	return 0;

err_out_regions:
	pci_release_regions(pdev);

err_out:
	pci_disable_device(pdev);
	return rc;

}

static int __init sis_init(void)
{
	int rc;

	rc = pci_module_init(&sis_pci_driver);
	if (rc)
		return rc;

	return 0;
}

static void __exit sis_exit(void)
{
	pci_unregister_driver(&sis_pci_driver);
}


module_init(sis_init);
module_exit(sis_exit);

--------------080505090704090400060507--

