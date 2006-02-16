Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWBPWlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWBPWlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 17:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBPWlV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 17:41:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:7108 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751056AbWBPWlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 17:41:19 -0500
Subject: Re: [PATCH 2.6.15.4 rel.2 1/1] libata: add hotswap to sata_svw
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Martin Devera <devik@cdi.cz>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org, lkosewsk@gmail.com
In-Reply-To: <E1F9klH-0004Fg-00@devix>
References: <E1F9klH-0004Fg-00@devix>
Content-Type: text/plain
Date: Fri, 17 Feb 2006 09:41:00 +1100
Message-Id: <1140129661.10065.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 16:09 +0100, Martin Devera wrote:
> From: Martin Devera <devik@cdi.cz>
> 
> Add hotswap capability to Serverworks/BroadCom SATA controlers. The
> controler has SIM register and it selects which bits in SATA_ERROR
> register fires interrupt.
> The solution hooks on COMWAKE (plug), PHYRDY change and 10B8B decode 
> error (unplug) and calls into Lukasz's hotswap framework.
> The code got one day testing on dual core Athlon64 H8SSL Supermicro 
> MoBo with HT-1000 SATA, SMP kernel and two CaviarRE SATA HDDs in
> hotswap bays.
> 
> Signed-off-by: Martin Devera <devik@cdi.cz>
> ---
> This patch depends on Lukasz Kosewski's:
> [PATCH 2.6.15-rc7-git3 2/3] libata: framework API for hotswapping drives on libata
> and its intent is mainly wider testing and review

Nice ! I'll review and test it asap. Just give me a few days as I'm
fairly busy lately.

Ben.

> --- a/drivers/scsi/sata_svw.c	Wed Feb 15 11:20:22 2006
> +++ b/drivers/scsi/sata_svw.c	Thu Feb 16 15:49:31 2006
> @@ -9,6 +9,7 @@
>   *  Copyright 2003 Benjamin Herrenschmidt <benh@kernel.crashing.org>
>   *
>   *  Bits from Jeff Garzik, Copyright RedHat, Inc.
> + *  Hotplug code by Martin Devera <devik@cdi.cz>
>   *
>   *  This driver probably works with non-Apple versions of the
>   *  Broadcom chipset...
> @@ -54,7 +55,7 @@
>  #endif /* CONFIG_PPC_OF */
>  
>  #define DRV_NAME	"sata_svw"
> -#define DRV_VERSION	"1.07"
> +#define DRV_VERSION	"1.08"
>  
>  /* Taskfile registers offsets */
>  #define K2_SATA_TF_CMD_OFFSET		0x00
> @@ -81,9 +82,18 @@
>  #define K2_SATA_SICR2_OFFSET		0x84
>  #define K2_SATA_SIM_OFFSET		0x88
>  
> +/* Hotplug interrupt masks */
> +#define K2_SIM_REMOVE_MASK		0x90000
> +#define K2_SIM_INSERT_MASK		0x40000
> +
>  /* Port stride */
>  #define K2_SATA_PORT_OFFSET		0x100
>  
> +struct svw_host 
> +{
> +	unsigned long not_in_reset_bitmap; /* see k2_hotplug_irq for explanation */
> +};
> +
>  static u8 k2_stat_check_status(struct ata_port *ap);
>  
> 
> @@ -282,6 +292,118 @@ static int k2_sata_proc_info(struct Scsi
>  }
>  #endif /* CONFIG_PPC_OF */
>  
> +/* This shall run every time for all ports when interrupt fires. It
> +   returns 1 if hotplug related event was handled. */
> +static int k2_hotplug_irq(struct ata_port *ap,struct svw_host *host)
> +{
> +	u32 error = scr_read(ap, SCR_ERROR);
> +	error &= K2_SIM_REMOVE_MASK | K2_SIM_INSERT_MASK;
> +	if (!error)
> +		return 0;
> +	
> +	/* clear error bits, this must be done in any case or we get
> +	   unhandled IRQ BUG */
> +	scr_write(ap, SCR_ERROR, error);
> +
> +	DPRINTK("K2 Got (un)plug event %X (status %X) on dev %d\n",
> +			error,scr_read(ap, SCR_STATUS),ap->port_no+1);
> +
> +	/* not_in_reset_bitmap has a bit set for each port when the port is
> +	   outside of reset routine. Because reset generates spurious events
> +	   we ignore them here. Because not_in_reset_bitmap is zero at init
> +	   time we also ignore these events until the port is first reset.
> +	   It is not possible simply to set SIM register to zero because
> +	   interrupt comming from other port still causes this routine run
> +	   for all ports and the event will be discovered. */
> +	if (!test_bit(ap->port_no,&host->not_in_reset_bitmap)) {
> +		DPRINTK("K2 ignoring the event\n");
> +		return 1;
> +	}
> +	
> +	if (error & K2_SIM_INSERT_MASK)
> +		sata_hot_plug(ap);
> +	else	/* make sure that the drive is really gone */
> +		if (!sata_dev_present(ap)) 
> +			sata_hot_unplug(ap);
> +	return 1;
> +}
> +
> +/* Essencialy the same as in libata, we only needed to hook hotplug events. */
> +static irqreturn_t k2_interrupt (int irq, void *dev_instance, struct pt_regs *regs)
> +{
> +	struct ata_host_set *host_set = dev_instance;
> +	struct svw_host *host = (struct svw_host *)host_set->private_data;
> +	unsigned int i;
> +	unsigned int handled = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host_set->lock, flags);
> +
> +	for (i = 0; i < host_set->n_ports; i++) {
> +		struct ata_port *ap;
> +
> +		ap = host_set->ports[i];
> +		if (!ap) 
> +			continue;
> +		
> +		if (!(ap->flags & (ATA_FLAG_PORT_DISABLED | ATA_FLAG_NOINTR))) {
> +			struct ata_queued_cmd *qc;
> +
> +			qc = ata_qc_from_tag(ap, ap->active_tag);
> +			if (qc && (!(qc->tf.ctl & ATA_NIEN)) &&
> +			    (qc->flags & ATA_QCFLAG_ACTIVE))
> +				handled |= ata_host_intr(ap, qc);
> +		}
> +		handled |= k2_hotplug_irq(ap,host);
> +	}
> +	
> +	spin_unlock_irqrestore(&host_set->lock, flags);
> +
> +	return IRQ_RETVAL(handled);
> +}
> +
> +/* Override phy_reset to setup SIM register. It must be done here because it
> +   can trigger IRQ and we must be sure that a handler is installed. And it is
> +   at the time when reset is called. */
> +static void k2_phy_reset(struct ata_port *ap)
> +{
> +	/* HACK: there is no standard place in port structure to record
> +	   base pointer - incidentaly cmd_addr is at offset zero ... */
> +	void *base = (void*)ap->ioaddr.cmd_addr;
> +	
> +	struct svw_host *host = (struct svw_host *)ap->host_set->private_data;
> +
> +	DPRINTK("K2 reset %d start\n",ap->port_no+1);
> +
> +	clear_bit(ap->port_no,&host->not_in_reset_bitmap);
> +	
> +	/* Not strictly neccessary but why to fire spurious interrupts
> +	   and then ignore them anyway */
> +	writel(0, base + K2_SATA_SIM_OFFSET);
> +	sata_phy_reset(ap);
> +
> +	/* Clear a magic bit in SCR1 according to Darwin, those help
> +	 * some funky seagate drives (though so far, those were already
> +	 * set by the firmware on the machines I had access to)
> +	 */
> +	writel(readl(base + K2_SATA_SICR1_OFFSET) & ~0x00040000,
> +	       base + K2_SATA_SICR1_OFFSET);
> +
> +	/* Make sure that interrupt is triggered when these XXX_MASK bits
> +	   in SCR_ERROR are set */
> +	scr_write(ap, SCR_ERROR, K2_SIM_INSERT_MASK | K2_SIM_REMOVE_MASK);
> +	writel(K2_SIM_INSERT_MASK | K2_SIM_REMOVE_MASK, base + K2_SATA_SIM_OFFSET);
> +
> +	set_bit(ap->port_no,&host->not_in_reset_bitmap);
> +
> +	DPRINTK("K2 reset done\n");
> +}
> +
> +static void k2_host_stop (struct ata_host_set *host_set)
> +{
> +	kfree(host_set->private_data);
> +	ata_pci_host_stop(host_set);
> +}
>  
>  static struct scsi_host_template k2_sata_sht = {
>  	.module			= THIS_MODULE,
> @@ -314,7 +436,7 @@ static const struct ata_port_operations 
>  	.check_status		= k2_stat_check_status,
>  	.exec_command		= ata_exec_command,
>  	.dev_select		= ata_std_dev_select,
> -	.phy_reset		= sata_phy_reset,
> +	.phy_reset		= k2_phy_reset,
>  	.bmdma_setup		= k2_bmdma_setup_mmio,
>  	.bmdma_start		= k2_bmdma_start_mmio,
>  	.bmdma_stop		= ata_bmdma_stop,
> @@ -322,13 +444,13 @@ static const struct ata_port_operations 
>  	.qc_prep		= ata_qc_prep,
>  	.qc_issue		= ata_qc_issue_prot,
>  	.eng_timeout		= ata_eng_timeout,
> -	.irq_handler		= ata_interrupt,
> +	.irq_handler		= k2_interrupt,
>  	.irq_clear		= ata_bmdma_irq_clear,
>  	.scr_read		= k2_sata_scr_read,
>  	.scr_write		= k2_sata_scr_write,
>  	.port_start		= ata_port_start,
>  	.port_stop		= ata_port_stop,
> -	.host_stop		= ata_pci_host_stop,
> +	.host_stop		= k2_host_stop,
>  };
>  
>  static void k2_sata_setup_port(struct ata_ioports *port, unsigned long base)
> @@ -354,6 +476,7 @@ static void k2_sata_setup_port(struct at
>  static int k2_sata_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
>  	static int printed_version;
> +	struct svw_host *host;
>  	struct ata_probe_ent *probe_ent = NULL;
>  	unsigned long base;
>  	void __iomem *mmio_base;
> @@ -408,17 +531,13 @@ static int k2_sata_init_one (struct pci_
>  		goto err_out_free_ent;
>  	}
>  	base = (unsigned long) mmio_base;
> -
> -	/* Clear a magic bit in SCR1 according to Darwin, those help
> -	 * some funky seagate drives (though so far, those were already
> -	 * set by the firmware on the machines I had access to)
> -	 */
> -	writel(readl(mmio_base + K2_SATA_SICR1_OFFSET) & ~0x00040000,
> -	       mmio_base + K2_SATA_SICR1_OFFSET);
> -
> -	/* Clear SATA error & interrupts we don't use */
> -	writel(0xffffffff, mmio_base + K2_SATA_SCR_ERROR_OFFSET);
> -	writel(0x0, mmio_base + K2_SATA_SIM_OFFSET);
> +	
> +	host = kmalloc(sizeof(struct svw_host), GFP_KERNEL);
> +	if (!host)
> +		goto err_out_free_ent;
> +	
> +	memset(host, 0, sizeof(struct svw_host));
> +	probe_ent->private_data = host;
>  
>  	probe_ent->sht = &k2_sata_sht;
>  	probe_ent->host_flags = ATA_FLAG_SATA | ATA_FLAG_SATA_RESET |

