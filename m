Return-Path: <linux-kernel-owner+w=401wt.eu-S932686AbXAJCva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbXAJCva (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 21:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbXAJCva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 21:51:30 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:3641 "EHLO
	pd2mo3so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932683AbXAJCv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 21:51:28 -0500
Date: Tue, 09 Jan 2007 20:50:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
In-reply-to: <45A377D2.60401@garzik.org>
To: Jeff Garzik <jeff@garzik.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org, pchen@nvidia.com, kluo@nvidia.com
Message-id: <45A4548B.304@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <45A377D2.60401@garzik.org>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I've been the one making the most changes in sata_nv lately I
figured I would make some more comments on this patch:

> Subject:
> RE: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
> From:
> "Peer Chen" <pchen@nvidia.com>
> Date:
> Tue, 7 Nov 2006 17:55:11 +0800
> To:
> "Christoph Hellwig" <hch@infradead.org>
>
> To:
> "Christoph Hellwig" <hch@infradead.org>
> CC:
> <jeff@garzik.org>, <linux-kernel@vger.kernel.org>, 
> <linux-ide@vger.kernel.org>, "Kuan Luo" <kluo@nvidia.com>
>
>
> Modified and resent out the patch as attachment.
> Description about the patch:
> Add SGPIO support in sata_nv.c.
> SGPIO (Serial General Purpose Input Output) is a sideband serial 4-wire
> interface that a storage controller uses to communicate with a storage
> enclosure management controller, primarily to control activity and
> status LEDs that are located within drive bays or on a storage
> backplane. SGPIO is defined by [SFF8485].
> In this patch,we drive the LEDs to blink when read/write operation
> happen on SATA drives connect the corresponding ports on MCP55 board.
> ==========
> The patch will be applied to kernel 2.6.19-rc4-git9.
>
> Singed-off-by: Kuan Luo <kluo@nvidia.com>
> Singed-off-by: Peer Chen <pchen@nvidia.com>
>
>
> BRs
> Peer Chen
>
>   
> -----------------------------------------------------------------------------------
>   

> --- linux-2.6.19-rc4-git9/drivers/ata/sata_nv.c.orig	2006-11-06 08:47:49.000000000 +0800
> +++ linux-2.6.19-rc4-git9/drivers/ata/sata_nv.c	2006-11-07 08:36:54.000000000 +0800

First off, can you rebase against the current libata-dev version of 
sata_nv? There have been
a ton of changes since 2.6.19-rc4-git9.

Also, it would be best to make sure the code passes the checks from the 
"Sparse" tool
using make C=1. sata_nv now passes this, it would be a shame to break that.

> @@ -80,6 +80,176 @@
> 	NV_MCP_SATA_CFG_20_SATA_SPACE_EN = 0x04,
>  };
> 	+/* sgpio
> +* Sgpio defines
> +* SGPIO state defines
> +*/
> +#define NV_SGPIO_STATE_RESET		0
> +#define NV_SGPIO_STATE_OPERATIONAL	1
> +#define NV_SGPIO_STATE_ERROR		2
> +
> +/* SGPIO command opcodes */
> +#define NV_SGPIO_CMD_RESET		0
> +#define NV_SGPIO_CMD_READ_PARAMS	1
> +#define NV_SGPIO_CMD_READ_DATA		2
> +#define NV_SGPIO_CMD_WRITE_DATA		3
> +
> +/* SGPIO command status defines */
> +#define NV_SGPIO_CMD_OK			0
> +#define NV_SGPIO_CMD_ACTIVE		1
> +#define NV_SGPIO_CMD_ERR		2
> +
> +#define NV_SGPIO_UPDATE_TICK		90
> +#define NV_SGPIO_MIN_UPDATE_DELTA	33
> +#define NV_CNTRLR_SHARE_INIT		2
> +#define NV_SGPIO_MAX_ACTIVITY_ON	20
> +#define NV_SGPIO_MIN_FORCE_OFF		5
> +#define NV_SGPIO_PCI_CSR_OFFSET		0x58
> +#define NV_SGPIO_PCI_CB_OFFSET		0x5C
> +#define NV_SGPIO_DFLT_CB_SIZE		256
> +#define NV_ON 1
> +#define NV_OFF 0
> +
> +
> +
> +static inline u8 bf_extract(u8 value, u8 offset, u8 bit_count)
> +{
> +	return ((((u8)(value)) >> (offset)) & ((1 << (bit_count)) - 1));
> +}
> +
> +static inline u8 bf_ins(u8 value, u8 ins, u8 offset, u8 bit_count)
> +{
> +	return 	(((value) & ~((((1 << (bit_count)) - 1)) << (offset))) |
> +						(((u8)(ins)) << (offset)));
> +}
> +
> +static inline u32 bf_extract_u32(u32 value, u8 offset, u8 bit_count)
> +{
> +	return ((((u32)(value)) >> (offset)) & ((1 << (bit_count)) - 1));
> +
> +}
> +static inline u32 bf_ins_u32(u32 value, u32 ins, u8 offset, u8 bit_count)
> +{
> +	return 	(((value) & ~((((1 << (bit_count)) - 1)) << (offset))) |
> +						(((u32)(ins)) << (offset)));
> +}

Maybe some comment about what these functions do? It's not entirely obvious.

> +
> +#define GET_SGPIO_STATUS(v)	bf_extract(v, 0, 2)
> +#define GET_CMD_STATUS(v)	bf_extract(v, 3, 2)
> +#define GET_CMD(v)		bf_extract(v, 5, 3)
> +#define SET_CMD(v, cmd)		bf_ins(v, cmd, 5, 3) 
> +
> +#define GET_ENABLE(v)		bf_extract(v, 23, 1)
> +#define SET_ENABLE(v)		bf_ins_u32(v, 1, 23, 1)
> +
> +/* Needs to have a u8 bit-field insert. */
> +#define GET_ACTIVITY(v)		bf_extract(v, 5, 3)
> +#define SET_ACTIVITY(v, on_off)	bf_ins(v, on_off, 5, 3)
> +
> +
> +
> +union nv_sgpio_nvcr 
> +{
> +	struct {
> +		u8	init_cnt;
> +		u8	cb_size;
> +		u8	cbver;
> +		u8	rsvd;
> +	} bit;
> +	u32	all;
> +};
> +
> +union nv_sgpio_tx 
> +{
> +	u8	tx_port[4];
> +	u32 	all;
> +};
> +
> +struct nv_sgpio_cb 
> +{
> +	u64			scratch_space;
> +	union nv_sgpio_nvcr	nvcr;
> +	u32			cr0;
> +	u32                     rsvd[4];
> +	union nv_sgpio_tx       tx[2];
> +};
> +
> +struct nv_sgpio_host_share
> +{
> +	spinlock_t	*plock;
> +	unsigned long   *ptstamp;
> +};
> +
> +struct nv_sgpio_host_flags
> +{
> +	u8	sgpio_enabled:1;
> +	u8	need_update:1;
> +	u8	rsvd:6;
> +};
> +	
> +struct nv_host_sgpio
> +{
> +	struct nv_sgpio_host_flags	flags;
> +	u8				*pcsr;
> +	struct nv_sgpio_cb		*pcb;	
> +	struct nv_sgpio_host_share	share;
> +	struct timer_list		sgpio_timer;
> +};
> +
> +struct nv_sgpio_port_flags
> +{
> +	u8	last_state:1;
> +	u8	recent_activity:1;
> +	u8	rsvd:6;
> +};
> +
> +struct nv_sgpio_led 
> +{
> +	struct nv_sgpio_port_flags	flags;
> +	u8				force_off;
> +	u8      			last_cons_active;
> +};
> +
> +struct nv_port_sgpio
> +{
> +	struct nv_sgpio_led	activity;
> +};

Surely some of these structures can be combined into a smaller number..

> +
> +static DEFINE_SPINLOCK(nv_sgpio_lock);
> +
> +static unsigned long	nv_sgpio_tstamp;
> +
> +
> +static inline u8 nv_sgpio_get_func(struct ata_host *host)
> +{
> +	u8 devfn = (to_pci_dev(host->dev))->devfn;
> +	return (PCI_FUNC(devfn));
> +}
> +
> +static inline u8 nv_sgpio_tx_host_offset(struct ata_host *host)
> +{
> +	return (nv_sgpio_get_func(host)/NV_CNTRLR_SHARE_INIT);
> +}
> +
> +static inline u8 nv_sgpio_calc_tx_offset(u8 cntrlr, u8 channel)
> +{
> +	return (sizeof(union nv_sgpio_tx) - (NV_CNTRLR_SHARE_INIT *
> +		(cntrlr % NV_CNTRLR_SHARE_INIT)) - channel - 1);
> +}
> +
> +static inline u8 nv_sgpio_tx_port_offset(struct ata_port *ap)
> +{
> +	u8 cntrlr = nv_sgpio_get_func(ap->host);
> +	return (nv_sgpio_calc_tx_offset(cntrlr, ap->port_no));
> +}
> +
> +static inline u8 nv_sgpio_capable(const struct pci_device_id *ent)
> +{
> +	if (ent->device == PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2)
> +		return 1;
> +	else
> +		return 0;
> +}
>  static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
>  static void nv_ck804_host_stop(struct ata_host *host);
>  static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance);
> @@ -87,7 +257,10 @@
>  static irqreturn_t nv_ck804_interrupt(int irq, void *dev_instance);
>  static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
>  static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32 val);
> -
> +static void nv_host_stop (struct ata_host *host);
> +static int nv_port_start(struct ata_port *ap);
> +static void nv_port_stop(struct ata_port *ap);
> +static unsigned int nv_qc_issue(struct ata_queued_cmd *qc);
>  static void nv_nf2_freeze(struct ata_port *ap);
>  static void nv_nf2_thaw(struct ata_port *ap);
>  static void nv_ck804_freeze(struct ata_port *ap);
> @@ -135,6 +308,27 @@
> 	{ } /* terminate list */
>  };
> 	+struct nv_host
> +{
> +	unsigned long		host_flags;
> +	struct nv_host_sgpio	host_sgpio;
> +};
> +
> +struct nv_port
> +{
> +	struct nv_port_sgpio	port_sgpio;
> +};
> +
> +/* SGPIO function prototypes */
> +static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost);
> +static void nv_sgpio_reset(u8 *pcsr);
> +static void nv_sgpio_set_timer(struct timer_list *ptimer, 
> +				unsigned int timeout_msec);
> +static void nv_sgpio_timer_handler(unsigned long ptr);
> +static void nv_sgpio_host_cleanup(struct nv_host *host);
> +static u8 nv_sgpio_update_led(struct nv_sgpio_led *led, u8 *on_off);
> +static void nv_sgpio_clear_all_leds(struct ata_port *ap);
> +static u8 nv_sgpio_send_cmd(struct nv_host *host, u8 cmd);

Whenever possible you should just reorder the functions to make the
declaration unnecessary. I think you should be able to do that with
most of these.

>  static struct pci_driver nv_pci_driver = {
> 	.name			= DRV_NAME,
> 	.id_table		= nv_pci_tbl,
> @@ -172,7 +366,7 @@
> 	.bmdma_stop		= ata_bmdma_stop,
> 	.bmdma_status		= ata_bmdma_status,
> 	.qc_prep		= ata_qc_prep,
> -	.qc_issue		= ata_qc_issue_prot,
> +	.qc_issue		= nv_qc_issue,
> 	.freeze			= ata_bmdma_freeze,
> 	.thaw			= ata_bmdma_thaw,
> 	.error_handler		= nv_error_handler,
> @@ -182,9 +376,9 @@
> 	.irq_clear		= ata_bmdma_irq_clear,
> 	.scr_read		= nv_scr_read,
> 	.scr_write		= nv_scr_write,
> -	.port_start		= ata_port_start,
> -	.port_stop		= ata_port_stop,
> -	.host_stop		= ata_pci_host_stop,
> +	.port_start		= nv_port_start,
> +	.port_stop		= nv_port_stop,
> +	.host_stop		= nv_host_stop,
>  };
> 	 static const struct ata_port_operations nv_nf2_ops = {
> @@ -465,10 +659,10 @@
> 	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
> 			   nv_hardreset, ata_std_postreset);
>  }
> -
>  static int nv_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
>  {
> 	static int printed_version = 0;
> +	struct nv_host *host;
> 	struct ata_port_info *ppi[2];
> 	struct ata_probe_ent *probe_ent;
> 	int pci_dev_busy = 0;
> @@ -510,6 +704,11 @@
> 	if (!probe_ent)
> 		goto err_out_regions;
> 	+	host = kzalloc(sizeof(struct nv_host), GFP_KERNEL);
> +	if (!host)
> +		goto err_out_free_ent;
> +
> +	probe_ent->private_data = host;
> 	probe_ent->mmio_base = pci_iomap(pdev, 5, 0);
> 	if (!probe_ent->mmio_base) {
> 		rc = -EIO;
> @@ -535,6 +734,8 @@
> 	rc = ata_device_add(probe_ent);
> 	if (rc != NV_PORTS)
> 		goto err_out_iounmap;
> +	if (nv_sgpio_capable(ent))
> +		nv_sgpio_init(pdev, host);
> 		kfree(probe_ent);
> 	@@ -553,6 +754,45 @@
> 	return rc;
>  }
> 	+static int nv_port_start(struct ata_port *ap)
> +{
> +	int stat;
> +	struct nv_port *port;
> +
> +	stat = ata_port_start(ap);
> +	if (stat)
> +		return stat;
> +	
> +	port = kzalloc(sizeof(struct nv_port), GFP_KERNEL);
> +	if (!port) 
> +		goto err_out_no_free;
> +
> +	ap->private_data = port;
> +	return 0;
> +
> +err_out_no_free:
> +	return 1;
> +}
> +
> +static void nv_port_stop(struct ata_port *ap)
> +{
> +	nv_sgpio_clear_all_leds(ap);
> +
> +	if (ap->private_data) {
> +		kfree(ap->private_data);
> +		ap->private_data = NULL;
> +	}
> +	ata_port_stop(ap);
> +}
> +
> +static unsigned int nv_qc_issue(struct ata_queued_cmd *qc)
> +{
> +	struct nv_port *port = qc->ap->private_data;
> +
> +	if (port) 
> +		port->port_sgpio.activity.flags.recent_activity = 1;

Those excessively complex structures above also make these accessors too 
long.

> +	return ata_qc_issue_prot(qc);
> +}
>  static void nv_ck804_host_stop(struct ata_host *host)
>  {
> 	struct pci_dev *pdev = to_pci_dev(host->dev);
> @@ -566,6 +806,277 @@
> 	ata_pci_host_stop(host);
>  }
> 	+static void nv_host_stop (struct ata_host *host)
> +{
> +	struct nv_host *phost = host->private_data;
> +
> +
> +	nv_sgpio_host_cleanup(phost);
> +	kfree(phost);
> +	ata_pci_host_stop(host);
> +
> +}
> +
> +static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost)
> +{
> +	u16 csr_add; 
> +	u32 cb_add, temp32;
> +	struct device *dev = pci_dev_to_dev(pdev);
> +	struct ata_host *host = dev_get_drvdata(dev);
> +	u8 pro = 0;
> +	
> +	pci_read_config_word(pdev, NV_SGPIO_PCI_CSR_OFFSET, &csr_add);
> +	pci_read_config_dword(pdev, NV_SGPIO_PCI_CB_OFFSET, &cb_add);
> +	pci_read_config_byte(pdev, 0xA4, &pro);
> +	
> +	if (csr_add == 0 || cb_add == 0)
> +		return;
> +	
> +	if (!(pro & 0x40))
> +		return;	

Some magic numbers here which should be declared as named constants.
Also, would be nice to know why these values mean we bail out of the
function.

> +		
> +	temp32 = csr_add;
> +	phost->host_sgpio.pcsr = (void*)(unsigned long)temp32;

Looks like some really dubious stuff happening here. What is this trying
to accomplish? Looks like pcsr is being used as an IO port address, but
then why is it stored as a pointer? And why do we read its address out of
PCI configuration space?

> +	phost->host_sgpio.pcb = ioremap(cb_add, 256);

This looks equally dubious. cb_add also comes from PCI configuration space.
Is that really guaranteed to be the proper location? And what is this 
pointing
to, registers on the device? In this case, pcb needs to be an __iomem 
pointer,
and all accesses through that pointer need to use proper readX/writeX 
calls and
not access memory directly. This is something Sparse will yell about.

> +
> +	if (phost->host_sgpio.pcb->nvcr.bit.init_cnt != 0x2 ||
> +			phost->host_sgpio.pcb->nvcr.bit.cbver != 0x0)
> +		return;
> +		
> +	if (temp32 <= 0x200 || temp32 >= 0xFFFE )
> +		return;
> +		
> +	if (cb_add <= 0x80000 || cb_add >= 0x9FC00)
> +		return;

More magic numbers and no explanation of why we exit out here. Plus, 
since you
already iomapped something in this function, you need to unmap it before 
returning.

> +	
> +	if (phost->host_sgpio.pcb->scratch_space == 0) {
> +		spin_lock_init(&nv_sgpio_lock);

Don't think you need to initialize it, it's already been done by 
DEFINE_SPINLOCK.

> +		phost->host_sgpio.share.plock = &nv_sgpio_lock;
> +		phost->host_sgpio.share.ptstamp = &nv_sgpio_tstamp;
> +		phost->host_sgpio.pcb->scratch_space = 
> +			(unsigned long)&phost->host_sgpio.share;
> +		spin_lock(phost->host_sgpio.share.plock);
> +		nv_sgpio_reset(phost->host_sgpio.pcsr);
> +		phost->host_sgpio.pcb->cr0 = 
> +			SET_ENABLE(phost->host_sgpio.pcb->cr0);
> +
> +		spin_unlock(phost->host_sgpio.share.plock);
> +	}
> +
> +	phost->host_sgpio.share = 
> +		*(struct nv_sgpio_host_share *)(unsigned long)
> +		phost->host_sgpio.pcb->scratch_space;

What's the point of this scratch_space variable? It's set here and then 
never used
except when it's set to null in the cleanup function. If it's a pointer, 
then
use a pointer, not a u64.

> +	phost->host_sgpio.flags.sgpio_enabled = 1;
> +
> +	init_timer(&phost->host_sgpio.sgpio_timer);
> +	phost->host_sgpio.sgpio_timer.data = (unsigned long)host;
> +	nv_sgpio_set_timer(&phost->host_sgpio.sgpio_timer, 
> +				NV_SGPIO_UPDATE_TICK);
> +}
> +
> +static void nv_sgpio_set_timer(struct timer_list *ptimer, unsigned int timeout_msec)
> +{
> +	if (!ptimer)
> +		return;

ptimer should never be able to be null, so there's no point to this check.
It will only hide bugs.

> +	ptimer->function = nv_sgpio_timer_handler;
> +	ptimer->expires = msecs_to_jiffies(timeout_msec) + jiffies;
> +	add_timer(ptimer);
> +}
> +
> +static void nv_sgpio_timer_handler(unsigned long context)
> +{
> +
> +	struct ata_host *host = (struct ata_host *)context;
> +	struct nv_host *phost;
> +	u8 count, host_offset, port_offset;
> +	union nv_sgpio_tx tx;
> +	u8 on_off;
> +	unsigned long mask = 0xFFFF;
> +	struct nv_port *port;
> +
> +	if (!host)
> +		goto err_out;
> +	else 
> +		phost = (struct nv_host *)host->private_data;
> +
> +	if (!phost->host_sgpio.flags.sgpio_enabled)
> +		goto err_out;
> +
> +	host_offset = nv_sgpio_tx_host_offset(host);
> +
> +	spin_lock(phost->host_sgpio.share.plock);
> +	tx = phost->host_sgpio.pcb->tx[host_offset];
> +	spin_unlock(phost->host_sgpio.share.plock);
> +
> +	for (count = 0; count < host->n_ports; count++) {
> +		struct ata_port *ap; 
> +
> +		ap = host->ports[count];
> +	
> +		if (!(ap && !(ap->flags & ATA_FLAG_DISABLED)))
> +			continue;
> +
> +		port = (struct nv_port *)ap->private_data;
> +		if (!port)
> +			continue;            		
> +		port_offset = nv_sgpio_tx_port_offset(ap);
> +		on_off = GET_ACTIVITY(tx.tx_port[port_offset]);
> +		if (nv_sgpio_update_led(&port->port_sgpio.activity, &on_off)) {
> +			tx.tx_port[port_offset] = 
> +				SET_ACTIVITY(tx.tx_port[port_offset], on_off);
> +			phost->host_sgpio.flags.need_update = 1;
> +	       }
> +	}
> +
> +
> +	if (phost->host_sgpio.flags.need_update) {
> +		spin_lock(phost->host_sgpio.share.plock);    
> +		if (nv_sgpio_get_func(host) 
> +			% NV_CNTRLR_SHARE_INIT == 0) {
> +			phost->host_sgpio.pcb->tx[host_offset].all &= mask;
> +			mask = mask << 16;
> +			tx.all &= mask;
> +		} else {
> +			tx.all &= mask;
> +			mask = mask << 16;
> +			phost->host_sgpio.pcb->tx[host_offset].all &= mask;
> +		}
> +		phost->host_sgpio.pcb->tx[host_offset].all |= tx.all;
> +		spin_unlock(phost->host_sgpio.share.plock);     
> + 
> +		if (nv_sgpio_send_cmd(phost, NV_SGPIO_CMD_WRITE_DATA)) { 
> +			phost->host_sgpio.flags.need_update = 0;
> +			return;
> +		}
> +	} else {
> +		nv_sgpio_set_timer(&phost->host_sgpio.sgpio_timer, 
> +				NV_SGPIO_UPDATE_TICK);
> +	}
> +err_out:
> +	return;
> +}
> +
> +static u8 nv_sgpio_send_cmd(struct nv_host *host, u8 cmd)
> +{
> +	u8 csr;
> +	unsigned long *ptstamp;
> +
> +	spin_lock(host->host_sgpio.share.plock);    
> +	ptstamp = host->host_sgpio.share.ptstamp;
> +	if (jiffies_to_msecs(jiffies - *ptstamp) >= NV_SGPIO_MIN_UPDATE_DELTA) {
> +		csr = inb((unsigned long)host->host_sgpio.pcsr);
> +		if ((GET_SGPIO_STATUS(csr) != NV_SGPIO_STATE_OPERATIONAL) ||
> +			(GET_CMD_STATUS(csr) == NV_SGPIO_CMD_ACTIVE)) {
> +			
> +		} else {
> +			host->host_sgpio.pcb->cr0 = 
> +				SET_ENABLE(host->host_sgpio.pcb->cr0);
> +			csr = 0;
> +			csr = SET_CMD(csr, cmd);
> +			outb(csr, (unsigned long)host->host_sgpio.pcsr);
> +			*ptstamp = jiffies;
> +		}
> +		spin_unlock(host->host_sgpio.share.plock);
> +		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
> +			NV_SGPIO_UPDATE_TICK);
> +		return 1;
> +	} else {
> +		spin_unlock(host->host_sgpio.share.plock);
> +		nv_sgpio_set_timer(&host->host_sgpio.sgpio_timer, 
> +				(NV_SGPIO_MIN_UPDATE_DELTA - 
> +				jiffies_to_msecs(jiffies - *ptstamp)));
> +		return 0;
> +	}
> +}
> +
> +static u8 nv_sgpio_update_led(struct nv_sgpio_led *led, u8 *on_off)

Kind of a misleadingly named function, it doesn't really update the LED
state, just tells you if it needs updating.

> +{
> +	u8 need_update = 0;
> +
> +	if (led->force_off > 0) {
> +		led->force_off--;
> +	} else if (led->flags.recent_activity ^ led->flags.last_state) {
> +		*on_off = led->flags.recent_activity;
> +		led->flags.last_state = led->flags.recent_activity;
> +		need_update = 1;
> +	} else if ((led->flags.recent_activity & led->flags.last_state) &&
> +		(led->last_cons_active >= NV_SGPIO_MAX_ACTIVITY_ON)) {
> +		*on_off = NV_OFF;
> +		led->flags.last_state = NV_OFF;
> +		led->force_off = NV_SGPIO_MIN_FORCE_OFF;
> +		need_update = 1;
> +	}
> +
> +	if (*on_off) 
> +		led->last_cons_active++;	
> +	else
> +		led->last_cons_active = 0;
> +
> +	led->flags.recent_activity = 0;
> +	return need_update;
> +}
> +
> +static void nv_sgpio_reset(u8  *pcsr)
> +{
> +	u8 csr;
> +
> +	csr = inb((unsigned long)pcsr);
> +	if (GET_SGPIO_STATUS(csr) == NV_SGPIO_STATE_RESET) {
> +		csr = 0;
> +		csr = SET_CMD(csr, NV_SGPIO_CMD_RESET);
> +		outb(csr, (unsigned long)pcsr);
> +	}
> +	csr = 0;
> +	csr = SET_CMD(csr, NV_SGPIO_CMD_READ_PARAMS);
> +	outb(csr, (unsigned long)pcsr);
> +}
> +
> +static void nv_sgpio_host_cleanup(struct nv_host *host)
> +{
> +	u8 csr;
> +
> +	if (!host)
> +		return;
> +
> +	if (host->host_sgpio.flags.sgpio_enabled) {
> +		spin_lock(host->host_sgpio.share.plock);
> +		host->host_sgpio.pcb->cr0 = SET_ENABLE(host->host_sgpio.pcb->cr0);
> +		csr = 0;
> +		csr = SET_CMD(csr, NV_SGPIO_CMD_WRITE_DATA);
> +		outb(csr, (unsigned long)host->host_sgpio.pcsr);
> +		spin_unlock(host->host_sgpio.share.plock);
> +
> +		if (timer_pending(&host->host_sgpio.sgpio_timer))
> +			del_timer(&host->host_sgpio.sgpio_timer);

Should likely be del_timer_sync and remove the timer_pending check.
You don't want this timer still running on another CPU while you're
cleaning up.

> +		host->host_sgpio.flags.sgpio_enabled = 0;
> +		host->host_sgpio.pcb->scratch_space = 0;
> +	}
> +}
> +
> +static void nv_sgpio_clear_all_leds(struct ata_port *ap)
> +{
> +	struct nv_port *port = ap->private_data;
> +	struct nv_host *host;
> +	u8 host_offset, port_offset;
> +
> +	if (!port || !ap->host)
> +		return;
> +	if (!ap->host->private_data)
> +		return;
> +
> +	host = ap->host->private_data;
> +	if (!host->host_sgpio.flags.sgpio_enabled)
> +		return;
> +
> +	host_offset = nv_sgpio_tx_host_offset(ap->host);
> +	port_offset = nv_sgpio_tx_port_offset(ap);
> +
> +	spin_lock(host->host_sgpio.share.plock);
> +	host->host_sgpio.pcb->tx[host_offset].tx_port[port_offset] = 0;
> +	host->host_sgpio.flags.need_update = 1;
> +	spin_unlock(host->host_sgpio.share.plock);
> +}
> +
>  static int __init nv_init(void)
>  {
> 	return pci_register_driver(&nv_pci_driver);




