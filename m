Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWAQNUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWAQNUm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 08:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWAQNUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 08:20:42 -0500
Received: from mail.dvmed.net ([216.237.124.58]:1963 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932336AbWAQNUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 08:20:41 -0500
Message-ID: <43CCEF25.2090902@pobox.com>
Date: Tue, 17 Jan 2006 08:20:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: PATCH: pata_oldpiix rev 0.2
References: <1136387989.4121.4.camel@localhost.localdomain>
In-Reply-To: <1136387989.4121.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Alan Cox wrote: > static void
	oldpiix_pata_phy_reset(struct ata_port *ap) > { > struct pci_dev *pdev
	= to_pci_dev(ap->host_set->dev); > static struct pci_bits
	oldpiix_enable_bits[] = { > { 0x41U, 1U, 0x80UL, 0x80UL }, /* port 0 */
	> { 0x43U, 1U, 0x80UL, 0x80UL }, /* port 1 */ > }; [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> static void oldpiix_pata_phy_reset(struct ata_port *ap)
> {
> 	struct pci_dev *pdev = to_pci_dev(ap->host_set->dev);
> 	static struct pci_bits oldpiix_enable_bits[] = {
> 		{ 0x41U, 1U, 0x80UL, 0x80UL },	/* port 0 */
> 		{ 0x43U, 1U, 0x80UL, 0x80UL },	/* port 1 */
> 	};

const

> 	if (!pci_test_config_bits(pdev, &oldpiix_enable_bits[ap->hard_port_no])) {
> 		ata_port_disable(ap);
> 		printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
> 		return;
> 	}
> 	ap->cbl = ATA_CBL_PATA40;
> 	ata_port_probe(ap);
> 	ata_bus_reset(ap);
> }
> 
> /**
>  *	oldpiix_set_piomode - Initialize host controller PATA PIO timings
>  *	@ap: Port whose timings we are configuring
>  *	@adev: um
>  *
>  *	Set PIO mode for device, in host controller PCI config space.
>  *
>  *	LOCKING:
>  *	None (inherited from caller).
>  */
> 
> static void oldpiix_set_piomode (struct ata_port *ap, struct ata_device *adev)
> {
> 	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
> 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
> 	unsigned int idetm_port= ap->hard_port_no ? 0x42 : 0x40;

space after '='?


> 	u16 idetm_data;
> 	int control = 0;
> 	
> 	/*
> 	 *	See Intel Document 298600-004 for the timing programing rules
> 	 *	for PIIX/ICH. Note that the early PIIX does not have the slave
> 	 *	timing port at 0x44.
> 	 */
> 
> 	static const	 /* ISP  RTC */
> 	u8 timings[][2]	= { { 0, 0 },
> 			    { 0, 0 },
> 			    { 1, 0 },
> 			    { 2, 1 },
> 			    { 2, 3 }, };
> 	if (pio > 2)
> 		control |= 1;	/* TIME1 enable */
> 	if (ata_pio_need_iordy(adev))
> 		control |= 2;	/* IE IORDY */
> 
> 	/* Intel specifies that the PPE functionality is for disk only */	   
> 	if (adev->class == ATA_DEV_ATA)
> 		control |= 4;	/* PPE enable */
> 		
> 	pci_read_config_word(dev, idetm_port, &idetm_data);
> 
> 	/* Enable PPE, IE and TIME as appropriate. Clear the other
> 	   drive timing bits */
> 	if (adev->devno == 0) {
> 		idetm_data &= 0xCCE0;
> 		idetm_data |= control;
> 	} else {
> 		idetm_data &= 0xCC0E;
> 		idetm_data |= (control << 4);
> 	}
> 	idetm_data |= (timings[pio][0] << 12) |
> 			(timings[pio][1] << 8);
> 	pci_write_config_word(dev, idetm_port, idetm_data);
> 
> 	/* Track which port is configured */
> 	ap->private_data = adev;
> }
> 
> /**
>  *	oldpiix_set_dmamode - Initialize host controller PATA DMA timings
>  *	@ap: Port whose timings we are configuring
>  *	@adev: Device to program
>  *	@isich: True if the device is an ICH and has IOCFG registers
>  *
>  *	Set MWDMA mode for device, in host controller PCI config space.
>  *
>  *	LOCKING:
>  *	None (inherited from caller).
>  */
> 
> /**
>  *	oldpiix_qc_issue_prot	-	command issue
>  *	@qc: command pending
>  *
>  *	Called when the libata layer is about to issue a command. We wrap
>  *	this interface so that we can load the correct ATA timings if
>  *	neccessary. Our logic also clears TIME0/TIME1 for the other device so
>  *	that, even if we get this wrong, cycles to the other device will
>  *	be made PIO0.
>  */
> 
> static int oldpiix_qc_issue_prot(struct ata_queued_cmd *qc)
> {
> 	struct ata_port *ap = qc->ap;
> 	struct ata_device *adev = qc->dev;
> 	
> 	if (adev != ap->private_data) {
> 		if (adev->dma_mode)
> 			oldpiix_set_dmamode(ap, adev);
> 		else if (adev->pio_mode)
> 			oldpiix_set_piomode(ap, adev);
> 	}
> 	return ata_qc_issue_prot(qc);
> }
> 
> 
> static struct scsi_host_template oldpiix_sht = {
> 	.module			= THIS_MODULE,
> 	.name			= DRV_NAME,
> 	.ioctl			= ata_scsi_ioctl,
> 	.queuecommand		= ata_scsi_queuecmd,
> 	.eh_strategy_handler	= ata_scsi_error,
> 	.can_queue		= ATA_DEF_QUEUE,
> 	.this_id		= ATA_SHT_THIS_ID,
> 	.sg_tablesize		= LIBATA_MAX_PRD,
> 	.max_sectors		= ATA_MAX_SECTORS,
> 	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
> 	.emulated		= ATA_SHT_EMULATED,
> 	.use_clustering		= ATA_SHT_USE_CLUSTERING,
> 	.proc_name		= DRV_NAME,
> 	.dma_boundary		= ATA_DMA_BOUNDARY,
> 	.slave_configure	= ata_scsi_slave_config,
> 	.bios_param		= ata_std_bios_param,
> 	.ordered_flush		= 1,
> };
> 
> static const struct ata_port_operations oldpiix_pata_ops = {
> 	.port_disable		= ata_port_disable,
> 	.set_piomode		= oldpiix_set_piomode,
> 	.set_dmamode		= oldpiix_set_dmamode,
> 
> 	.tf_load		= ata_tf_load,
> 	.tf_read		= ata_tf_read,
> 	.check_status		= ata_check_status,
> 	.exec_command		= ata_exec_command,
> 	.dev_select		= ata_std_dev_select,
> 
> 	.phy_reset		= oldpiix_pata_phy_reset,
> 
> 	.bmdma_setup		= ata_bmdma_setup,
> 	.bmdma_start		= ata_bmdma_start,
> 	.bmdma_stop		= ata_bmdma_stop,
> 	.bmdma_status		= ata_bmdma_status,
> 	.qc_prep		= ata_qc_prep,
> 	.qc_issue		= oldpiix_qc_issue_prot,
> 
> 	.eng_timeout		= ata_eng_timeout,
> 
> 	.irq_handler		= ata_interrupt,
> 	.irq_clear		= ata_bmdma_irq_clear,
> 
> 	.port_start		= ata_port_start,
> 	.port_stop		= ata_port_stop,
> 	.host_stop		= ata_host_stop,
> };
> 
> 
> /**
>  *	oldpiix_init_one - Register PIIX ATA PCI device with kernel services
>  *	@pdev: PCI device to register
>  *	@ent: Entry in oldpiix_pci_tbl matching with @pdev
>  *
>  *	Called from kernel PCI layer.
>  *
>  *	LOCKING:
>  *	Inherited from PCI layer (may sleep).
>  *
>  *	RETURNS:
>  *	Zero on success, or -ERRNO value.
>  */
> 
> static int oldpiix_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
> {
> 	static int printed_version;
> 	static struct ata_port_info info = {
> 		.sht		= &oldpiix_sht,
> 		.host_flags	= ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST,
> 		.pio_mask	= 0x1f,	/* pio0-4 */
> 		.mwdma_mask	= 0x07, /* mwdma1-2 */
> 		.port_ops	= &oldpiix_pata_ops,
> 	};
> 	static struct ata_port_info *port_info[2] = { &info, &info };
> 
> 	if (!printed_version++)
> 		dev_printk(KERN_DEBUG, &pdev->dev,
> 			   "version " DRV_VERSION "\n");
> 
> 	return ata_pci_init_one(pdev, port_info, 2);
> }
> 
> static const struct pci_device_id oldpiix_pci_tbl[] = {
> 	{ 0x8086, 0x1230, PCI_ANY_ID, PCI_ANY_ID, },
> 	{ }	/* terminate list */
> };
> 
> static struct pci_driver oldpiix_pci_driver = {
> 	.name			= DRV_NAME,
> 	.id_table		= oldpiix_pci_tbl,
> 	.probe			= oldpiix_init_one,
> 	.remove			= ata_pci_remove_one,
> };
> 
> static int __init oldpiix_init(void)
> {
> 	int rc;
> 
> 	DPRINTK("pci_module_init\n");
> 	rc = pci_module_init(&oldpiix_pci_driver);
> 	if (rc)
> 		return rc;
> 
> 	DPRINTK("done\n");
> 	return 0;
> }

same comment as before:

reduce this function to a single line, a call to pci_register_driver().

otherwise OK.

	Jeff


