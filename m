Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWHVFph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWHVFph (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 01:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWHVFph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 01:45:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35264 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750767AbWHVFph (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 01:45:37 -0400
Date: Mon, 21 Aug 2006 22:44:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Prajakta Gudadhe <pgudadhe@nvidia.com>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Sgpio support in sata_nv
Message-Id: <20060821224457.65de5111.akpm@osdl.org>
In-Reply-To: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com>
References: <1156209426.2840.15.camel@dhcp-172-16-174-114.nvidia.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006 18:17:06 -0700
Prajakta Gudadhe <pgudadhe@nvidia.com> wrote:

> Description:
> Added support for enclosure management via SGPIO to sata_nv. This patch is based off of kernel-2.6.17.9.
> 
> Signed-off by: Prajakta Gudadhe <pgudadhe@nvidia.com>
> 
> 
> +union nv_sgpio_csr
> +{
> +	struct {
> +#if defined(__LITTLE_ENDIAN_BITFIELD)
> +		u8	sgpio_status:2;
> +		u8	sgpio_seq:1;
> +		u8	cmd_status:2;
> +		u8	cmd:3;
> +#elif defined(__BIG_ENDIAN_BITFIELD)
> +		u8	cmd:3;
> +		u8	cmd_status:2;
> +		u8	sgpio_seq:1;
> +		u8	sgpio_status:2;
> +#else
> +#error "Please fix <asm/byteorder.h>"
> +#endif
> +	} bit;
> +	u8	all;
> +};

I believe it's still unfashoinable to attempt to map hardware registers
onto compiler-controlled bitfields in this manner.

I'd suggest that you just pull the u32 out of PCI space and open-code the
shifting and masking in an endianness-independent fashion.  The macros
around line 508 of drivers/net/3c59x.c demonstrate one way of doing this.

> +static int nv_port_start(struct ata_port *ap)
> +{
> +	int stat;
> +    	struct nv_port *port;
> +
> +    	stat = ata_port_start(ap);
> +    	if (stat) {
> +        	return stat;
> +    	}
> +
> +    	port = kmalloc(sizeof(struct nv_port), GFP_KERNEL);
> +    	if (!port) 
> +		goto err_out_no_free;
> +
> +	memset(port, 0, sizeof(struct nv_port));

kzalloc().

> +    	ap->private_data = port;
> +    	return 0;
> +
> +err_out_no_free:
> +    	return 1;
> +}
> +
> +
>
> ..
>
>  static void nv_enable_hotplug(struct ata_probe_ent *probe_ent)
>  {
>  	u8 intr_mask;
> @@ -606,6 +877,238 @@ static int nv_check_hotplug_ck804(struct
>  	return 0;
>  }
>  
> +static void nv_sgpio_init(struct pci_dev *pdev, struct nv_host *phost)
> +{
> +    	u16 csr_add; 
> +	u32 cb_add, temp32;
> +	struct device *dev = pci_dev_to_dev(pdev);
> +	struct ata_host_set *host_set = dev_get_drvdata(dev);
> +
> +	pci_read_config_word(pdev, NV_SGPIO_PCI_CSR_OFFSET, &csr_add);
> +	pci_read_config_dword(pdev, NV_SGPIO_PCI_CB_OFFSET, &cb_add);
> +    	if (csr_add == 0 || cb_add == 0) {
> +        	return;
> +    	}
> +
> +	temp32 = csr_add;

temp32 came from a pci config space read.

> +    	phost->host_sgpio.pcsr = (union nv_sgpio_csr *)temp32;

And we copy that into a kernel pointer??  Really?

> +    	phost->host_sgpio.pcb = phys_to_virt(cb_add);
> +
> +    	if (phost->host_sgpio.pcb->scratch_space == 0) {
> +        	spin_lock_init(&nv_sgpio_lock);
> +        	phost->host_sgpio.share.plock = &nv_sgpio_lock;
> +        	phost->host_sgpio.share.ptstamp = &nv_sgpio_tstamp;
> +		phost->host_sgpio.pcb->scratch_space = 
> +			(unsigned long)&phost->host_sgpio.share;
> +        	spin_lock(phost->host_sgpio.share.plock);
> +        	nv_sgpio_reset(phost->host_sgpio.pcsr);
> +        	phost->host_sgpio.pcb->cr0.bit.enable = 1;
> +		spin_unlock(phost->host_sgpio.share.plock);
> +    	}
> +
> +    	phost->host_sgpio.share = 
> +		*(struct nv_sgpio_host_share *)(unsigned long)
> +		phost->host_sgpio.pcb->scratch_space;
> +    	phost->host_sgpio.flags.sgpio_enabled = 1;
> +
> +    	init_timer(&phost->host_sgpio.sgpio_timer);
> +    	phost->host_sgpio.sgpio_timer.data = (unsigned long)host_set;
> +    	nv_sgpio_set_timer(&phost->host_sgpio.sgpio_timer, 
> +				NV_SGPIO_UPDATE_TICK);
> +}
> +
>
> ...
>
> +
> +static void nv_sgpio_timer_handler(unsigned long context)
> +{
> +
> +    	struct ata_host_set *host_set = (struct ata_host_set *)context;
> +    	struct nv_host *host;
> +    	u8 count, host_offset, port_offset;
> +    	union nv_sgpio_tx tx;
> +    	bool on_off;
> +    	unsigned long mask = 0xFFFF;
> +	struct nv_port *port;
> +
> +    	if (!host_set)
> +		goto err_out;
> +	else 
> +		host = (struct nv_host *)host_set->private_data;

ata_host_set.parivate_data is void*, so this cast is unneeded.

> +	if (!host->host_sgpio.flags.sgpio_enabled)
> +	        goto err_out;
> +
> +	host_offset = nv_sgpio_tx_host_offset(host_set);
> +
> +    	spin_lock(host->host_sgpio.share.plock);
> +    	tx = host->host_sgpio.pcb->tx[host_offset];
> +    	spin_unlock(host->host_sgpio.share.plock);
> +
> +    	for (count = 0; count < host_set->n_ports; count++) {
> +        	struct ata_port *ap; 
> +
> +        	ap = host_set->ports[count];
> +        
> +        	if (!(ap && !(ap->flags & ATA_FLAG_PORT_DISABLED)))
> +			continue;
> +
> +            	port = (struct nv_port *)ap->private_data;

Ditto.

> +		if (!port)
> +			continue;            		
> +                port_offset = nv_sgpio_tx_port_offset(ap);

whitepsace went funny.

> +	        on_off = tx.bit.tx_port[port_offset].bit.activity;
> +         	if (nv_sgpio_update_led(&port->port_sgpio.activity, &on_off)) {
> +                    	tx.bit.tx_port[port_offset].bit.activity = on_off;
> +                    	host->host_sgpio.flags.need_update = 1;
> +                }

Ditto.  In fact in many places this patch uses spaces where it should be
using tabs.

> ...
>

	if (jiffies_to_msecs(jiffies - *ptstamp) >= NV_SGPIO_MIN_UPDATE_DELTA) {

I think this works OK in the presence of jiffies wraparound.  But it would
be more idiomatic to do

	if (time_after(jiffies,
		*ptstamp + msecs_to_jiffies(NV_SGPIO_MIN_UPDATE_DELTA)) {


> ...
>
> +
> +static bool nv_sgpio_update_led(struct nv_sgpio_led *led, bool *on_off)

Please remove the new private implementation of `bool' and just use `int'. 
There's ongoing discussion about how to do a kernel-wide implementation of
bool, and adding new driver-private ones now just complicates that.


