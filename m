Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263177AbUDZSgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263177AbUDZSgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 14:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263191AbUDZSgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 14:36:42 -0400
Received: from web13004.mail.yahoo.com ([216.136.174.14]:23712 "HELO
	web13004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263177AbUDZSgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 14:36:06 -0400
Message-ID: <20040426183604.44231.qmail@web13004.mail.yahoo.com>
Date: Mon, 26 Apr 2004 19:36:04 +0100 (BST)
From: =?iso-8859-1?q?Robin=20Parker?= <parke1r@yahoo.co.uk>
Subject: Re: [sata] SiS driver fixes
To: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, uwe.koziolek@gmx.net,
       parke1r@yahoo.co.uk
In-Reply-To: <408C0AC2.7040705@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What can I say??  It worked like a charm.

Let me know if there's any specific tests you want me
to try.

Does the driver support RAID yet?? (sorry, couldn't
resist)

Many Thanks,

Robin

 --- Jeff Garzik <jgarzik@pobox.com> wrote: > 
> Attached is a patch, and the full 2.6.x version of
> the SiS driver, for 
> testing.
> 
> This should address the problem where people were
> having their SATA 
> drives not recognized at probe time.
> 
> Any feedback, including "you didn't break anything",
> would be great, as 
> I don't have any SiS test hardware up and running.
> 
> 
> > ===== drivers/scsi/sata_sis.c 1.3 vs edited =====
> --- 1.3/drivers/scsi/sata_sis.c	Thu Apr 22 00:49:04
> 2004
> +++ edited/drivers/scsi/sata_sis.c	Sun Apr 25
> 14:54:20 2004
> @@ -34,10 +34,18 @@
>  #include <linux/libata.h>
>  
>  #define DRV_NAME	"sata_sis"
> -#define DRV_VERSION	"0.04"
> +#define DRV_VERSION	"0.10"
>  
>  enum {
>  	sis_180			= 0,
> +	SIS_SCR_PCI_BAR		= 5,
> +
> +	/* PCI configuration registers */
> +	SIS_GENCTL		= 0x54, /* IDE General Control
> register */
> +
> +	/* random bits */
> +	SIS_FLAG_CFGSCR		= (1 << 30),
> +	GENCTL_IOMAPPED_SCR	= (1 << 26),
>  };
>  
>  static int sis_init_one (struct pci_dev *pdev,
> const struct pci_device_id *ent);
> @@ -99,20 +107,62 @@
>  MODULE_LICENSE("GPL");
>  MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
>  
> +static unsigned int get_scr_cfg_addr(unsigned int
> port_no, unsigned int sc_reg)
> +{
> +	unsigned int addr = 0;
> +	switch (sc_reg) {
> +	case SCR_STATUS:
> +		addr = 0xc0;
> +		break;
> +	case SCR_CONTROL:
> +		addr = 0xc8;
> +		break;
> +	default:
> +		return 0xffffffff;
> +	}
> +	if (port_no)
> +		addr += 0x10;
> +
> +	return addr;
> +}
> +
> +static u32 sis_scr_cfg_read (struct ata_port *ap,
> unsigned int sc_reg)
> +{
> +	u32 val;
> +	unsigned int cfg_addr =
> get_scr_cfg_addr(ap->port_no, sc_reg);
> +	if (cfg_addr == 0xffffffff)
> +		return 0xffffffff;
> +	pci_read_config_dword(ap->host_set->pdev,
> cfg_addr, &val);
> +	return val;
> +}
> +
> +static void sis_scr_cfg_write (struct ata_port *ap,
> unsigned int sc_reg, u32 val)
> +{
> +	unsigned int cfg_addr =
> get_scr_cfg_addr(ap->port_no, sc_reg);
> +	if (cfg_addr == 0xffffffff)
> +		return;
> +	pci_write_config_dword(ap->host_set->pdev,
> cfg_addr, val);
> +}
>  
>  static u32 sis_scr_read (struct ata_port *ap,
> unsigned int sc_reg)
>  {
> -	if (sc_reg >= 16)
> +	if (sc_reg > SCR_CONTROL)
>  		return 0xffffffffU;
>  
> +	if (ap->flags & SIS_FLAG_CFGSCR)
> +		return sis_scr_cfg_read(ap, sc_reg);
>  	return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
>  }
>  
>  static void sis_scr_write (struct ata_port *ap,
> unsigned int sc_reg, u32 val)
>  {
> -	if (sc_reg >= 16)
> +	if (sc_reg > SCR_CONTROL)
>  		return;
> -	outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
> +
> +	if (ap->flags & SIS_FLAG_CFGSCR)
> +		sis_scr_cfg_write(ap, sc_reg, val);
> +	else
> +		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
>  }
>  
>  /* move to PCI layer, integrate w/ MSI stuff */
> @@ -131,6 +181,7 @@
>  {
>  	struct ata_probe_ent *probe_ent = NULL;
>  	int rc;
> +	u32 genctl;
>  
>  	rc = pci_enable_device(pdev);
>  	if (rc)
> @@ -160,6 +211,23 @@
>  	probe_ent->sht = &sis_sht;
>  	probe_ent->host_flags = ATA_FLAG_SATA |
> ATA_FLAG_SATA_RESET |
>  				ATA_FLAG_NO_LEGACY;
> +
> +	/* check and see if the SCRs are in IO space or
> PCI cfg space */
> +	pci_read_config_dword(pdev, SIS_GENCTL, &genctl);
> +	if ((genctl & GENCTL_IOMAPPED_SCR) == 0)
> +		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
> +	
> +	/* if hardware thinks SCRs are in IO space, but
> there are
> +	 * no IO resources assigned, change to PCI cfg
> space.
> +	 */
> +	if ((!(probe_ent->host_flags & SIS_FLAG_CFGSCR))
> &&
> +	    ((pci_resource_start(pdev, SIS_SCR_PCI_BAR) ==
> 0) ||
> +	     (pci_resource_len(pdev, SIS_SCR_PCI_BAR) <
> 128))) {
> +		genctl &= ~GENCTL_IOMAPPED_SCR;
> +		pci_write_config_dword(pdev, SIS_GENCTL, genctl);
> +		probe_ent->host_flags |= SIS_FLAG_CFGSCR;
> +	}
> +
>  	probe_ent->pio_mask = 0x03;
>  	probe_ent->udma_mask = 0x7f;
>  	probe_ent->port_ops = &sis_ops;
> @@ -169,14 +237,18 @@
>  	probe_ent->port[0].ctl_addr =
>  		pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
>  	probe_ent->port[0].bmdma_addr =
> pci_resource_start(pdev, 4);
> -	probe_ent->port[0].scr_addr =
> pci_resource_start(pdev, 5);
> +	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR))
> +		probe_ent->port[0].scr_addr =
> +			pci_resource_start(pdev, SIS_SCR_PCI_BAR);
>  
>  	probe_ent->port[1].cmd_addr =
> pci_resource_start(pdev, 2);
>  	ata_std_ports(&probe_ent->port[1]);
>  	probe_ent->port[1].ctl_addr =
>  		pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
>  	probe_ent->port[1].bmdma_addr =
> pci_resource_start(pdev, 4) + 8;
> -	probe_ent->port[1].scr_addr =
> pci_resource_start(pdev, 5) + 64;
> +	if (!(probe_ent->host_flags & SIS_FLAG_CFGSCR))
> +		probe_ent->port[1].scr_addr =
> +			pci_resource_start(pdev, SIS_SCR_PCI_BAR) + 64;
>  
>  	probe_ent->n_ports = 2;
>  	probe_ent->irq = pdev->irq;
> > /*
>  *  sata_sis.c - Silicon Integrated Systems SATA
>  *
>  *  Copyright 2004 Uwe Koziolek
>  *
>  *  The contents of this file are subject to the
> Open
>  *  Software License version 1.1 that can be found
> at
>  *  http://www.opensource.org/licenses/osl-1.1.txt
> and is included herein
>  *  by reference.
>  *
>  *  Alternatively, the contents of this file may be
> used under the terms
>  *  of the GNU General Public License version 2 (the
> "GPL") as distributed
>  *  in the kernel source COPYING file, in which case
> the provisions of
>  *  the GPL are applicable instead of the above.  If
> you wish to allow
>  *  the use of your version of this file only under
> the terms of the
>  *  GPL and not to allow others to use your version
> of this file under
>  *  the OSL, indicate your decision by deleting the
> provisions above and
>  *  replace them with the notice and other
> provisions required by the GPL.
>  *  If you do not delete the provisions above, a
> recipient may use your
>  *  version of this file under either the OSL or the
> GPL.
>  *
>  */
> 
> #include <linux/config.h>
> #include <linux/kernel.h>
> #include <linux/module.h>
> #include <linux/pci.h>
> #include <linux/init.h>
> #include <linux/blkdev.h>
> #include <linux/delay.h>
> #include <linux/interrupt.h>
> #include "scsi.h"
> #include "hosts.h"
> #include <linux/libata.h>
> 
> #define DRV_NAME	"sata_sis"
> #define DRV_VERSION	"0.10"
> 
> enum {
> 	sis_180			= 0,
> 	SIS_SCR_PCI_BAR		= 5,
> 
> 	/* PCI configuration registers */
> 	SIS_GENCTL		= 0x54, /* IDE General Control register
> */
> 
> 	/* random bits */
> 	SIS_FLAG_CFGSCR		= (1 << 30),
> 	GENCTL_IOMAPPED_SCR	= (1 << 26),
> };
> 
> static int sis_init_one (struct pci_dev *pdev, const
> struct pci_device_id *ent);
> static u32 sis_scr_read (struct ata_port *ap,
> unsigned int sc_reg);
> static void sis_scr_write (struct ata_port *ap,
> unsigned int sc_reg, u32 val);
> 
> static struct pci_device_id sis_pci_tbl[] = {
> 	{ PCI_VENDOR_ID_SI, 0x180, PCI_ANY_ID, PCI_ANY_ID,
> 0, 0, sis_180 },
> 	{ PCI_VENDOR_ID_SI, 0x181, PCI_ANY_ID, PCI_ANY_ID,
> 0, 0, sis_180 },
> 	{ }	/* terminate list */
> };
> 
> 
> static struct pci_driver sis_pci_driver = {
> 	.name			= DRV_NAME,
> 	.id_table		= sis_pci_tbl,
> 	.probe			= sis_init_one,
> 	.remove			= ata_pci_remove_one,
> };
> 
> static Scsi_Host_Template sis_sht = {
> 	.module			= THIS_MODULE,
> 	.name			= DRV_NAME,
> 	.queuecommand		= ata_scsi_queuecmd,
> 	.eh_strategy_handler	= ata_scsi_error,
> 	.can_queue		= ATA_DEF_QUEUE,
> 	.this_id		= ATA_SHT_THIS_ID,
> 	.sg_tablesize		= ATA_MAX_PRD,
> 	.max_sectors		= ATA_MAX_SECTORS,
> 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
> 	.emulated		= ATA_SHT_EMULATED,
> 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
> 	.proc_name		= DRV_NAME,
> 	.dma_boundary		= ATA_DMA_BOUNDARY,
> 	.slave_configure	= ata_scsi_slave_config,
> 	.bios_param		= ata_std_bios_param,
> };
> 
> static struct ata_port_operations sis_ops = {
> 	.port_disable		= ata_port_disable,
> 	.tf_load		= ata_tf_load_pio,
> 	.tf_read		= ata_tf_read_pio,
> 	.check_status		= ata_check_status_pio,
> 	.exec_command		= ata_exec_command_pio,
> 	.phy_reset		= sata_phy_reset,
> 	.bmdma_start            = ata_bmdma_start_pio,
> 	.fill_sg		= ata_fill_sg,
> 	.eng_timeout		= ata_eng_timeout,
> 	.irq_handler		= ata_interrupt,
> 	.scr_read		= sis_scr_read,
> 	.scr_write		= sis_scr_write,
> 	.port_start		= ata_port_start,
> 	.port_stop		= ata_port_stop,
> };
> 
> 
> MODULE_AUTHOR("Uwe Koziolek");
> MODULE_DESCRIPTION("low-level driver for Silicon
> Integratad Systems SATA controller");
> MODULE_LICENSE("GPL");
> MODULE_DEVICE_TABLE(pci, sis_pci_tbl);
> 
> static unsigned int get_scr_cfg_addr(unsigned int
> port_no, unsigned int sc_reg)
> {
> 	unsigned int addr = 0;
> 	switch (sc_reg) {
> 	case SCR_STATUS:
> 		addr = 0xc0;
> 		break;
> 	case SCR_CONTROL:
> 		addr = 0xc8;
> 		break;
> 	default:
> 		return 0xffffffff;
> 	}
> 	if (port_no)
> 		addr += 0x10;
> 
> 	return addr;
> }
> 
> static u32 sis_scr_cfg_read (struct ata_port *ap,
> unsigned int sc_reg)
> {
> 	u32 val;
> 	unsigned int cfg_addr =
> get_scr_cfg_addr(ap->port_no, sc_reg);
> 	if (cfg_addr == 0xffffffff)
> 		return 0xffffffff;
> 	pci_read_config_dword(ap->host_set->pdev, cfg_addr,
> &val);
> 	return val;
> }
> 
> static void sis_scr_cfg_write (struct ata_port *ap,
> unsigned int sc_reg, u32 val)
> {
> 	unsigned int cfg_addr =
> get_scr_cfg_addr(ap->port_no, sc_reg);
> 	if (cfg_addr == 0xffffffff)
> 		return;
> 	pci_write_config_dword(ap->host_set->pdev,
> cfg_addr, val);
> }
> 
> static u32 sis_scr_read (struct ata_port *ap,
> unsigned int sc_reg)
> {
> 	if (sc_reg > SCR_CONTROL)
> 		return 0xffffffffU;
> 
> 	if (ap->flags & SIS_FLAG_CFGSCR)
> 		return sis_scr_cfg_read(ap, sc_reg);
> 	return inl(ap->ioaddr.scr_addr + (sc_reg * 4));
> }
> 
> static void sis_scr_write (struct ata_port *ap,
> unsigned int sc_reg, u32 val)
> {
> 	if (sc_reg > SCR_CONTROL)
> 		return;
> 
> 	if (ap->flags & SIS_FLAG_CFGSCR)
> 		sis_scr_cfg_write(ap, sc_reg, val);
> 	else
> 		outl(val, ap->ioaddr.scr_addr + (sc_reg * 4));
> }
> 
> /* move to PCI layer, integrate w/ MSI stuff */
> static void pci_enable_intx(struct pci_dev *pdev)
> {
> 	u16 pci_command;
> 
> 
=== message truncated === 


	
	
		
Chat instantly with your online friends?  Get the
FREE Yahoo! Messenger http://uk.messenger.yahoo.com/
