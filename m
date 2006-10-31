Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422966AbWJaKlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422966AbWJaKlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWJaKlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:41:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:6342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751714AbWJaKlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:41:04 -0500
Date: Tue, 31 Oct 2006 10:40:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Peer Chen <pchen@nvidia.com>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Kuan Luo <kluo@nvidia.com>
Subject: Re: [PATCH] SCSI: Add the SGPIO support for sata_nv.c
Message-ID: <20061031104055.GA8898@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Peer Chen <pchen@nvidia.com>, jeff@garzik.org,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	Kuan Luo <kluo@nvidia.com>
References: <15F501D1A78BD343BE8F4D8DB854566B059FE0B3@hkemmail01.nvidia.com> <15F501D1A78BD343BE8F4D8DB854566B0C42D636@hkemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15F501D1A78BD343BE8F4D8DB854566B0C42D636@hkemmail01.nvidia.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 04:43:19PM +0800, Peer Chen wrote:
> The following SGPIO patch for sata_nv.c is based on 2.6.18 kernel.
> Signed-off by: Kuan Luo <kluo@nvidia.com>

First I'd like to say the patch subject isn't very informative.  For
a sata_nv patch it should read:

[PATCH] sata_nv: foooblah

and then the SGPIO in both the subject and description doesn't say anything
at all, what functionality or improvement does this patch actually add.

And in general send patches against latest git or -mm tree.  I don't know
how much the sata_nv driver changed since 2.6.18 but in general sending
patches against old kernel means they often can't be applied anymore.

> +//sgpio
> +// Sgpio defines
> +// SGPIO state defines

please use /* */ style comments.  Also these aren't exactly useful

> +#define NV_ON 1
> +#define NV_OFF 0
> +#ifndef bool
> +#define bool u8
> +#endif

please don't use your own bool types.

> +#define BF_EXTRACT(v, off, bc)	\
> +	((((u8)(v)) >> (off)) & ((1 << (bc)) - 1))
> +
> +#define BF_INS(v, ins, off, bc)				\
> +	(((v) & ~((((1 << (bc)) - 1)) << (off))) |	\
> +	(((u8)(ins)) << (off)))
> +
> +#define BF_EXTRACT_U32(v, off, bc)	\
> +	((((u32)(v)) >> (off)) & ((1 << (bc)) - 1))
> +
> +#define BF_INS_U32(v, ins, off, bc)			\
> +	(((v) & ~((((1 << (bc)) - 1)) << (off))) |	\
> +	(((u32)(ins)) << (off)))

please make such things inline functions.  Also they could have
more descriptive names.

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
> +
> +static spinlock_t	nv_sgpio_lock;

please use DEFINE_SPINLOCK to initialize the lock statically.

> +static unsigned long	nv_sgpio_tstamp;

> +static inline void nv_sgpio_set_csr(u8 csr, unsigned long pcsr)
> +{
> +	outb(csr, pcsr);
> +}
> +
> +static inline u8 nv_sgpio_get_csr(unsigned long pcsr)
> +{
> +	return inb(pcsr);
> +}

these helpers aren't useful at all, please remove them.

> +static inline u8 nv_sgpio_get_func(struct ata_host_set *host_set)
> +{
> +	u8 devfn = (to_pci_dev(host_set->dev))->devfn;
> +	return (PCI_FUNC(devfn));
> +}
> +
> +static inline u8 nv_sgpio_tx_host_offset(struct ata_host_set *host_set)
> +{
> +	return (nv_sgpio_get_func(host_set)/NV_CNTRLR_SHARE_INIT);
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
> +	u8 cntrlr = nv_sgpio_get_func(ap->host_set);
> +	return (nv_sgpio_calc_tx_offset(cntrlr, ap->port_no));
> +}
> +
> +static inline bool nv_sgpio_capable(const struct pci_device_id *ent)
> +{
> +	if (ent->device == PCI_DEVICE_ID_NVIDIA_NFORCE_MCP55_SATA2)
> +		return 1;
> +	else
> +		return 0;
> +}
>  static int nv_init_one (struct pci_dev *pdev, const struct
> pci_device_id *ent);
>  static void nv_ck804_host_stop(struct ata_host_set *host_set);
>  static irqreturn_t nv_generic_interrupt(int irq, void *dev_instance,
> @@ -90,7 +259,10 @@
>  				      struct pt_regs *regs);
>  static u32 nv_scr_read (struct ata_port *ap, unsigned int sc_reg);
>  static void nv_scr_write (struct ata_port *ap, unsigned int sc_reg, u32
> val);
> -
> +static void nv_host_stop (struct ata_host_set *host_set);
> +static int nv_port_start(struct ata_port *ap);
> +static void nv_port_stop(struct ata_port *ap);
> +static int nv_qc_issue(struct ata_queued_cmd *qc);
>  static void nv_nf2_freeze(struct ata_port *ap);
>  static void nv_nf2_thaw(struct ata_port *ap);
>  static void nv_ck804_freeze(struct ata_port *ap);
> @@ -147,6 +319,27 @@
>  	{ 0, } /* terminate list */
>  };
>  
> +struct nv_host
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
> +// SGPIO function prototypes
> +static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost);
> +static void nv_sgpio_reset(u8 *pcsr);
> +static void nv_sgpio_set_timer(struct timer_list *ptimer, 
> +				unsigned int timeout_msec);
> +static void nv_sgpio_timer_handler(unsigned long ptr);
> +static void nv_sgpio_host_cleanup(struct nv_host *host);
> +static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool
> *on_off);
> +static void nv_sgpio_clear_all_leds(struct ata_port *ap);
> +static bool nv_sgpio_send_cmd(struct nv_host *host, u8 cmd);
>  static struct pci_driver nv_pci_driver = {
>  	.name			= DRV_NAME,
>  	.id_table		= nv_pci_tbl,
> @@ -184,7 +377,7 @@
>  	.bmdma_stop		= ata_bmdma_stop,
>  	.bmdma_status		= ata_bmdma_status,
>  	.qc_prep		= ata_qc_prep,
> -	.qc_issue		= ata_qc_issue_prot,
> +	.qc_issue		= nv_qc_issue,
>  	.freeze			= ata_bmdma_freeze,
>  	.thaw			= ata_bmdma_thaw,
>  	.error_handler		= nv_error_handler,
> @@ -194,9 +387,9 @@
>  	.irq_clear		= ata_bmdma_irq_clear,
>  	.scr_read		= nv_scr_read,
>  	.scr_write		= nv_scr_write,
> -	.port_start		= ata_port_start,
> -	.port_stop		= ata_port_stop,
> -	.host_stop		= ata_pci_host_stop,
> +	.port_start		= nv_port_start,
> +	.port_stop		= nv_port_stop,
> +	.host_stop		= nv_host_stop,
>  };
>  
>  static const struct ata_port_operations nv_nf2_ops = {
> @@ -211,7 +404,7 @@
>  	.bmdma_stop		= ata_bmdma_stop,
>  	.bmdma_status		= ata_bmdma_status,
>  	.qc_prep		= ata_qc_prep,
> -	.qc_issue		= ata_qc_issue_prot,
> +	.qc_issue		= nv_qc_issue,
>  	.freeze			= nv_nf2_freeze,
>  	.thaw			= nv_nf2_thaw,
>  	.error_handler		= nv_error_handler,
> @@ -221,9 +414,9 @@
>  	.irq_clear		= ata_bmdma_irq_clear,
>  	.scr_read		= nv_scr_read,
>  	.scr_write		= nv_scr_write,
> -	.port_start		= ata_port_start,
> -	.port_stop		= ata_port_stop,
> -	.host_stop		= ata_pci_host_stop,
> +	.port_start		= nv_port_start,
> +	.port_stop		= nv_port_stop,
> +	.host_stop		= nv_host_stop,
>  };
>  
>  static const struct ata_port_operations nv_ck804_ops = {
> @@ -238,7 +431,7 @@
>  	.bmdma_stop		= ata_bmdma_stop,
>  	.bmdma_status		= ata_bmdma_status,
>  	.qc_prep		= ata_qc_prep,
> -	.qc_issue		= ata_qc_issue_prot,
> +	.qc_issue		= nv_qc_issue,
>  	.freeze			= nv_ck804_freeze,
>  	.thaw			= nv_ck804_thaw,
>  	.error_handler		= nv_error_handler,
> @@ -248,8 +441,8 @@
>  	.irq_clear		= ata_bmdma_irq_clear,
>  	.scr_read		= nv_scr_read,
>  	.scr_write		= nv_scr_write,
> -	.port_start		= ata_port_start,
> -	.port_stop		= ata_port_stop,
> +	.port_start		= nv_port_start,
> +	.port_stop		= nv_port_stop,
>  	.host_stop		= nv_ck804_host_stop,
>  };
>  
> @@ -480,10 +673,10 @@
>  	ata_bmdma_drive_eh(ap, ata_std_prereset, ata_std_softreset,
>  			   nv_hardreset, ata_std_postreset);
>  }
> -
>  static int nv_init_one (struct pci_dev *pdev, const struct
> pci_device_id *ent)
>  {
>  	static int printed_version = 0;
> +	struct nv_host *host;
>  	struct ata_port_info *ppi;
>  	struct ata_probe_ent *probe_ent;
>  	int pci_dev_busy = 0;
> @@ -525,6 +718,13 @@
>  	if (!probe_ent)
>  		goto err_out_regions;
>  
> +	host = kmalloc(sizeof(struct nv_host), GFP_KERNEL);
> +	if (!host)
> +		goto err_out_free_ent;
> +
> +	memset(host, 0, sizeof(struct nv_host));

Please use kzalloc().

> +static int nv_port_start(struct ata_port *ap)
> +{
> +	int stat;
> +	struct nv_port *port;
> +
> +	stat = ata_port_start(ap);
> +	if (stat) {
> +		return stat;
> +	}

useless braces.

> +
> +	port = kmalloc(sizeof(struct nv_port), GFP_KERNEL);
> +	if (!port) 
> +		goto err_out_no_free;
> +
> +	memset(port, 0, sizeof(struct nv_port));

Please use kzalloc again.

> +	return (ata_qc_issue_prot(qc));

no need for braces around the return value.

> +static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost)
> +{
> +	u16 csr_add; 
> +	u32 cb_add, temp32;
> +	struct device *dev = pci_dev_to_dev(pdev);
> +	struct ata_host_set *host_set = dev_get_drvdata(dev);
> +	u8 pro=0;

missing spacezs around the =.

> +	if (!(pro&0x40))

Again missing spaces.  Please take another look at Documentation/CodingStyle
for the preferred linux style.

> +		return;	
> +		
> +	temp32 = csr_add;
> +	phost->host_sgpio.pcsr = (void *)temp32;
> +	phost->host_sgpio.pcb = phys_to_virt(cb_add);

Use of phys_to_virt is generally a bug.  What are you trying to do here?

> +
> +	if (phost->host_sgpio.pcb->nvcr.bit.init_cnt!=0x2 ||
> phost->host_sgpio.pcb->nvcr.bit.cbver!=0x0)

in addition to the whitespace damage this line is far too long,
please break it up.


<skipping the rest of the file for now until it's made a little more
 readable>
