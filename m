Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbTE2QIJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTE2QIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:08:09 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:44813 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262390AbTE2QHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:07:54 -0400
Date: Thu, 29 May 2003 13:21:26 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: chas williams <chas@cmf.nrl.navy.mil>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] assorted he driver cleanup
Message-ID: <20030529162125.GU24054@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	chas williams <chas@cmf.nrl.navy.mil>, davem@redhat.com,
	linux-kernel@vger.kernel.org
References: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305291609.h4TG9rx01188@relax.cmf.nrl.navy.mil>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 29, 2003 at 12:09:54PM -0400, chas williams escreveu:
> the three following changesets attempt to bring the he atm
> driver into conformance with the accepted linux coding style,
> fix some chattiness the irq handler, and address the stack
> usage issue in he_init_cs_block_rcm().

great, comments below
 
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.1158  -> 1.1159 
> #	    drivers/atm/he.c	1.7     -> 1.8    
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/05/23	chas@relax.cmf.nrl.navy.mil	1.1159
> # he coding style conformance
> # --------------------------------------------
> #
> diff -Nru a/drivers/atm/he.c b/drivers/atm/he.c
> --- a/drivers/atm/he.c	Thu May 29 11:48:40 2003
> +++ b/drivers/atm/he.c	Thu May 29 11:48:40 2003
> @@ -132,9 +132,9 @@
>  
>  #undef DEBUG
>  #ifdef DEBUG
> -#define HPRINTK(fmt,args...)	hprintk(fmt,args)
> +#define HPRINTK(fmt,args...)	printk(KERN_DEBUG DEV_LABEL "%d: " fmt, he_dev->number , ##args)
>  #else
> -#define HPRINTK(fmt,args...)	do { } while(0)
> +#define HPRINTK(fmt,args...)	do { } while (0)
>  #endif /* DEBUG */
>  
>  
> @@ -179,9 +179,7 @@
>     phy_put:	he_phy_put,
>     phy_get:	he_phy_get,
>     proc_read:	he_proc_read,
> -#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,4,1)
>     owner:	THIS_MODULE
> -#endif
>  };
>  
>  /* see the comments in he.h about global_lock */
> @@ -189,7 +187,7 @@
>  #define HE_SPIN_LOCK(dev, flags)	spin_lock_irqsave(&(dev)->global_lock, flags)
>  #define HE_SPIN_UNLOCK(dev, flags)	spin_unlock_irqrestore(&(dev)->global_lock, flags)

Is the above really needed?
  
> -#define he_writel(dev, val, reg)	do { writel(val, (dev)->membase + (reg)); wmb(); } while(0)
> +#define he_writel(dev, val, reg)	do { writel(val, (dev)->membase + (reg)); wmb(); } while (0)
>  #define he_readl(dev, reg)		readl((dev)->membase + (reg))
>  
>  /* section 2.12 connection memory access */
> @@ -203,7 +201,7 @@
>  	(void) he_readl(he_dev, CON_DAT);
>  #endif
>  	he_writel(he_dev, flags | CON_CTL_WRITE | CON_CTL_ADDR(addr), CON_CTL);
> -	while(he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
> +	while (he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
>  }
>  
>  #define he_writel_rcm(dev, val, reg) 				\
> @@ -219,7 +217,7 @@
>  he_readl_internal(struct he_dev *he_dev, unsigned addr, unsigned flags)
>  {
>  	he_writel(he_dev, flags | CON_CTL_READ | CON_CTL_ADDR(addr), CON_CTL);
> -	while(he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
> +	while (he_readl(he_dev, CON_CTL) & CON_CTL_BUSY);
>  	return he_readl(he_dev, CON_DAT);
>  }
>  
> @@ -374,7 +372,8 @@
>  
>  	printk(KERN_INFO "he: %s\n", version);
>  
> -	if (pci_enable_device(pci_dev)) return -EIO;
> +	if (pci_enable_device(pci_dev))
> +		return -EIO;
>  	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0) {
>  		printk(KERN_WARNING "he: no suitable dma available\n");
>  		err = -EIO;
> @@ -407,7 +406,8 @@
>  		goto init_one_failure;
>  	}
>  	he_dev->next = NULL;
> -	if (he_devs) he_dev->next = he_devs;
> +	if (he_devs)
> +		he_dev->next = he_devs;
>  	he_devs = he_dev;
>  	return 0;
>  
> @@ -447,11 +447,11 @@
>  
>          unsigned exp = 0;
>  
> -        if (rate == 0) return(0);
> +        if (rate == 0)
> +		return(0);

return is not a function, so 'return 0;' is the preferred style

>  
>          rate <<= 9;
> -        while (rate > 0x3ff)
> -        {
> +        while (rate > 0x3ff) {
>                  ++exp;
>                  rate >>= 1;
>          }
> @@ -472,16 +472,14 @@
>  
>  	he_writel(he_dev, lbufd_index, RLBF0_H);
>  
> -        for (i = 0, lbuf_count = 0; i < he_dev->r0_numbuffs; ++i)
> -        {
> +        for (i = 0, lbuf_count = 0; i < he_dev->r0_numbuffs; ++i) {
>  		lbufd_index += 2;
>                  lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
>  
>  		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
>  		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
>  
> -                if (++lbuf_count == lbufs_per_row)
> -                {
> +                if (++lbuf_count == lbufs_per_row) {
>                          lbuf_count = 0;
>                          row_offset += he_dev->bytes_per_row;
>                  }
> @@ -505,16 +503,14 @@
>  
>  	he_writel(he_dev, lbufd_index, RLBF1_H);
>  
> -        for (i = 0, lbuf_count = 0; i < he_dev->r1_numbuffs; ++i)
> -        {
> +        for (i = 0, lbuf_count = 0; i < he_dev->r1_numbuffs; ++i) {
>  		lbufd_index += 2;
>                  lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
>  
>  		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
>  		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
>  
> -                if (++lbuf_count == lbufs_per_row)
> -                {
> +                if (++lbuf_count == lbufs_per_row) {
>                          lbuf_count = 0;
>                          row_offset += he_dev->bytes_per_row;
>                  }
> @@ -538,16 +534,14 @@
>  
>  	he_writel(he_dev, lbufd_index, TLBF_H);
>  
> -        for (i = 0, lbuf_count = 0; i < he_dev->tx_numbuffs; ++i)
> -        {
> +        for (i = 0, lbuf_count = 0; i < he_dev->tx_numbuffs; ++i) {
>  		lbufd_index += 1;
>                  lbuf_addr = (row_offset + (lbuf_count * lbuf_bufsize)) / 32;
>  
>  		he_writel_rcm(he_dev, lbuf_addr, lbm_offset);
>  		he_writel_rcm(he_dev, lbufd_index, lbm_offset + 1);
>  
> -                if (++lbuf_count == lbufs_per_row)
> -                {
> +                if (++lbuf_count == lbufs_per_row) {
>                          lbuf_count = 0;
>                          row_offset += he_dev->bytes_per_row;
>                  }
> @@ -562,8 +556,7 @@
>  {
>  	he_dev->tpdrq_base = pci_alloc_consistent(he_dev->pci_dev,
>  		CONFIG_TPDRQ_SIZE * sizeof(struct he_tpdrq), &he_dev->tpdrq_phys);
> -	if (he_dev->tpdrq_base == NULL) 
> -	{
> +	if (he_dev->tpdrq_base == NULL) {
>  		hprintk("failed to alloc tpdrq\n");
>  		return -ENOMEM;
>  	}
> @@ -588,7 +581,7 @@
>  
>  	/* 5.1.7 cs block initialization */
>  
> -	for(reg = 0; reg < 0x20; ++reg)
> +	for (reg = 0; reg < 0x20; ++reg)
>  		he_writel_mbox(he_dev, 0x0, CS_STTIM0 + reg);
>  
>  	/* rate grid timer reload values */
> @@ -597,8 +590,7 @@
>  	rate = he_dev->atm_dev->link_rate;
>  	delta = rate / 16 / 2;
>  
> -	for(reg = 0; reg < 0x10; ++reg)
> -	{
> +	for (reg = 0; reg < 0x10; ++reg) {
>  		/* 2.4 internal transmit function
>  		 *
>  	 	 * we initialize the first row in the rate grid.
> @@ -610,8 +602,7 @@
>  		rate -= delta;
>  	}
>  
> -	if (he_is622(he_dev))
> -	{
> +	if (he_is622(he_dev)) {
>  		/* table 5.2 (4 cells per lbuf) */
>  		he_writel_mbox(he_dev, 0x000800fa, CS_ERTHR0);
>  		he_writel_mbox(he_dev, 0x000c33cb, CS_ERTHR1);
> @@ -640,9 +631,7 @@
>  		/* table 5.9 */
>  		he_writel_mbox(he_dev, 0x5, CS_OTPPER);
>  		he_writel_mbox(he_dev, 0x14, CS_OTWPER);
> -	}
> -	else
> -	{
> +	} else {
>  		/* table 5.1 (4 cells per lbuf) */
>  		he_writel_mbox(he_dev, 0x000400ea, CS_ERTHR0);
>  		he_writel_mbox(he_dev, 0x00063388, CS_ERTHR1);
> @@ -671,12 +660,11 @@
>  		/* table 5.9 */
>  		he_writel_mbox(he_dev, 0x6, CS_OTPPER);
>  		he_writel_mbox(he_dev, 0x1e, CS_OTWPER);
> -
>  	}
>  
>  	he_writel_mbox(he_dev, 0x8, CS_OTTLIM);
>  
> -	for(reg = 0; reg < 0x8; ++reg)
> +	for (reg = 0; reg < 0x8; ++reg)
>  		he_writel_mbox(he_dev, 0x0, CS_HGRRT0 + reg);
>  
>  }
> @@ -720,8 +708,7 @@
>  	 * in order to construct the rate to group table below
>  	 */
>  
> -	for (j = 0; j < 16; j++)
> -	{
> +	for (j = 0; j < 16; j++) {
>  		rategrid[0][j] = rate;
>  		rate -= delta;
>  	}
> @@ -742,8 +729,7 @@
>  	 */
>  
>  	rate_atmf = 0;
> -	while (rate_atmf < 0x400)
> -	{
> +	while (rate_atmf < 0x400) {
>  		man = (rate_atmf & 0x1f) << 4;
>  		exp = rate_atmf >> 5;
>  
> @@ -753,12 +739,12 @@
>  		*/
>  		rate_cps = (unsigned long long) (1 << exp) * (man + 512) >> 9;
>  
> -		if (rate_cps < 10) rate_cps = 10;
> -				/* 2.2.1 minimum payload rate is 10 cps */
> +		if (rate_cps < 10)
> +			rate_cps = 10;	/* 2.2.1 minimum payload rate is 10 cps */
>  
>  		for (i = 255; i > 0; i--)
> -			if (rategrid[i/16][i%16] >= rate_cps) break;
> -				/* pick nearest rate instead? */
> +			if (rategrid[i/16][i%16] >= rate_cps)
> +				break;	 /* pick nearest rate instead? */
>  
>  		/*
>  		 * each table entry is 16 bits: (rate grid index (8 bits)
> @@ -773,12 +759,17 @@
>  		/* this is pretty, but avoids _divdu3 and is mostly correct */
>                  buf = 0;
>                  mult = he_dev->atm_dev->link_rate / ATM_OC3_PCR;
> -                if (rate_cps > (68 * mult)) buf = 1;
> -                if (rate_cps > (136 * mult)) buf = 2;
> -                if (rate_cps > (204 * mult)) buf = 3;
> -                if (rate_cps > (272 * mult)) buf = 4;
> +                if (rate_cps > (68 * mult))
> +			buf = 1;
> +                if (rate_cps > (136 * mult))
> +			buf = 2;
> +                if (rate_cps > (204 * mult))
> +			buf = 3;
> +                if (rate_cps > (272 * mult))
> +			buf = 4;
>  #endif
> -                if (buf > buf_limit) buf = buf_limit;
> +                if (buf > buf_limit)
> +			buf = buf_limit;
>  		reg = (reg<<16) | ((i<<8) | buf);
>  
>  #define RTGTBL_OFFSET 0x400
> @@ -801,8 +792,7 @@
>  #ifdef USE_RBPS_POOL
>  	he_dev->rbps_pool = pci_pool_create("rbps", he_dev->pci_dev,
>  			CONFIG_RBPS_BUFSIZE, 8, 0);
> -	if (he_dev->rbps_pool == NULL)
> -	{
> +	if (he_dev->rbps_pool == NULL) {
>  		hprintk("unable to create rbps pages\n");
>  		return -ENOMEM;
>  	}
> @@ -817,16 +807,14 @@
>  
>  	he_dev->rbps_base = pci_alloc_consistent(he_dev->pci_dev,
>  		CONFIG_RBPS_SIZE * sizeof(struct he_rbp), &he_dev->rbps_phys);
> -	if (he_dev->rbps_base == NULL)
> -	{
> +	if (he_dev->rbps_base == NULL) {
>  		hprintk("failed to alloc rbps\n");
>  		return -ENOMEM;
>  	}
>  	memset(he_dev->rbps_base, 0, CONFIG_RBPS_SIZE * sizeof(struct he_rbp));
>  	he_dev->rbps_virt = kmalloc(CONFIG_RBPS_SIZE * sizeof(struct he_virt), GFP_KERNEL);
>  
> -	for (i = 0; i < CONFIG_RBPS_SIZE; ++i)
> -	{
> +	for (i = 0; i < CONFIG_RBPS_SIZE; ++i) {
>  		dma_addr_t dma_handle;
>  		void *cpuaddr;
>  
> @@ -868,16 +856,14 @@
>  #ifdef USE_RBPL_POOL
>  	he_dev->rbpl_pool = pci_pool_create("rbpl", he_dev->pci_dev,
>  			CONFIG_RBPL_BUFSIZE, 8, 0);
> -	if (he_dev->rbpl_pool == NULL)
> -	{
> +	if (he_dev->rbpl_pool == NULL) {
>  		hprintk("unable to create rbpl pool\n");
>  		return -ENOMEM;
>  	}
>  #else /* !USE_RBPL_POOL */
>  	he_dev->rbpl_pages = (void *) pci_alloc_consistent(he_dev->pci_dev,
>  		CONFIG_RBPL_SIZE * CONFIG_RBPL_BUFSIZE, &he_dev->rbpl_pages_phys);
> -	if (he_dev->rbpl_pages == NULL)
> -	{
> +	if (he_dev->rbpl_pages == NULL) {
>  		hprintk("unable to create rbpl pages\n");
>  		return -ENOMEM;
>  	}
> @@ -885,16 +871,14 @@
>  
>  	he_dev->rbpl_base = pci_alloc_consistent(he_dev->pci_dev,
>  		CONFIG_RBPL_SIZE * sizeof(struct he_rbp), &he_dev->rbpl_phys);
> -	if (he_dev->rbpl_base == NULL)
> -	{
> +	if (he_dev->rbpl_base == NULL) {
>  		hprintk("failed to alloc rbpl\n");
>  		return -ENOMEM;
>  	}
>  	memset(he_dev->rbpl_base, 0, CONFIG_RBPL_SIZE * sizeof(struct he_rbp));
>  	he_dev->rbpl_virt = kmalloc(CONFIG_RBPL_SIZE * sizeof(struct he_virt), GFP_KERNEL);
>  
> -	for (i = 0; i < CONFIG_RBPL_SIZE; ++i)
> -	{
> +	for (i = 0; i < CONFIG_RBPL_SIZE; ++i) {
>  		dma_addr_t dma_handle;
>  		void *cpuaddr;
>  
> @@ -910,7 +894,6 @@
>  		he_dev->rbpl_virt[i].virt = cpuaddr;
>  		he_dev->rbpl_base[i].status = RBP_LOANED | (i << RBP_INDEX_OFF);
>  		he_dev->rbpl_base[i].phys = dma_handle;
> -
>  	}
>  	he_dev->rbpl_tail = &he_dev->rbpl_base[CONFIG_RBPL_SIZE-1];
>  
> @@ -929,8 +912,7 @@
>  
>  	he_dev->rbrq_base = pci_alloc_consistent(he_dev->pci_dev,
>  		CONFIG_RBRQ_SIZE * sizeof(struct he_rbrq), &he_dev->rbrq_phys);
> -	if (he_dev->rbrq_base == NULL)
> -	{
> +	if (he_dev->rbrq_base == NULL) {
>  		hprintk("failed to allocate rbrq\n");
>  		return -ENOMEM;
>  	}
> @@ -942,13 +924,11 @@
>  	he_writel(he_dev,
>  		RBRQ_THRESH(CONFIG_RBRQ_THRESH) | RBRQ_SIZE(CONFIG_RBRQ_SIZE-1),
>  						G0_RBRQ_Q + (group * 16));
> -	if (irq_coalesce)
> -	{
> +	if (irq_coalesce) {
>  		hprintk("coalescing interrupts\n");
>  		he_writel(he_dev, RBRQ_TIME(768) | RBRQ_COUNT(7),
>  						G0_RBRQ_I + (group * 16));
> -	}
> -	else
> +	} else
>  		he_writel(he_dev, RBRQ_TIME(0) | RBRQ_COUNT(1),
>  						G0_RBRQ_I + (group * 16));
>  
> @@ -956,8 +936,7 @@
>  
>  	he_dev->tbrq_base = pci_alloc_consistent(he_dev->pci_dev,
>  		CONFIG_TBRQ_SIZE * sizeof(struct he_tbrq), &he_dev->tbrq_phys);
> -	if (he_dev->tbrq_base == NULL)
> -	{
> +	if (he_dev->tbrq_base == NULL) {
>  		hprintk("failed to allocate tbrq\n");
>  		return -ENOMEM;
>  	}
> @@ -983,8 +962,7 @@
>  
>          he_dev->irq_base = pci_alloc_consistent(he_dev->pci_dev,
>  			(CONFIG_IRQ_SIZE+1) * sizeof(struct he_irq), &he_dev->irq_phys);
> -	if (he_dev->irq_base == NULL)
> -	{
> +	if (he_dev->irq_base == NULL) {
>  		hprintk("failed to allocate irq\n");
>  		return -ENOMEM;
>  	}
> @@ -994,7 +972,7 @@
>  	he_dev->irq_head = he_dev->irq_base;
>  	he_dev->irq_tail = he_dev->irq_base;
>  
> -	for(i=0; i < CONFIG_IRQ_SIZE; ++i)
> +	for (i=0; i < CONFIG_IRQ_SIZE; ++i)

use spaces before and after basic operators

	for (i = 0; i < CONFIG_IRQ_SIZE; ++i)

>  		he_dev->irq_base[i].isw = ITYPE_INVALID;
>  
>  	he_writel(he_dev, he_dev->irq_phys, IRQ0_BASE);
> @@ -1026,8 +1004,7 @@
>  	he_writel(he_dev, 0x0, GRP_54_MAP);
>  	he_writel(he_dev, 0x0, GRP_76_MAP);
>  
> -	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, SA_INTERRUPT|SA_SHIRQ, DEV_LABEL, he_dev))
> -	{
> +	if (request_irq(he_dev->pci_dev->irq, he_irq_handler, SA_INTERRUPT|SA_SHIRQ, DEV_LABEL, he_dev)) {
>  		hprintk("irq %d already in use\n", he_dev->pci_dev->irq);
>  		return -EINVAL;
>          }   
> @@ -1067,46 +1044,39 @@
>  	 */
>  
>  	/* 4.3 pci bus controller-specific initialization */
> -	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0)
> -	{
> +	if (pci_read_config_dword(pci_dev, GEN_CNTL_0, &gen_cntl_0) != 0) {
>  		hprintk("can't read GEN_CNTL_0\n");

Humm, shouldn't we release the irq here? What about using gotos for exception
handing?

>  		return -EINVAL;
>  	}
>  	gen_cntl_0 |= (MRL_ENB | MRM_ENB | IGNORE_TIMEOUT);
> -	if (pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0) != 0)
> -	{
> +	if (pci_write_config_dword(pci_dev, GEN_CNTL_0, gen_cntl_0) != 0) {
>  		hprintk("can't write GEN_CNTL_0.\n");

ditto

>  		return -EINVAL;
>  	}
>  
> -	if (pci_read_config_word(pci_dev, PCI_COMMAND, &command) != 0)
> -	{
> +	if (pci_read_config_word(pci_dev, PCI_COMMAND, &command) != 0) {
>  		hprintk("can't read PCI_COMMAND.\n");

ditto

>  		return -EINVAL;
>  	}
>  
>  	command |= (PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER | PCI_COMMAND_INVALIDATE);
> -	if (pci_write_config_word(pci_dev, PCI_COMMAND, command) != 0)
> -	{
> +	if (pci_write_config_word(pci_dev, PCI_COMMAND, command) != 0) {
>  		hprintk("can't enable memory.\n");

ditto

>  		return -EINVAL;
>  	}
>  
> -	if (pci_read_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, &cache_size))
> -	{
> +	if (pci_read_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, &cache_size)) {
>  		hprintk("can't read cache line size?\n");

ditto

>  		return -EINVAL;
>  	}
>  
> -	if (cache_size < 16)
> -	{
> +	if (cache_size < 16) {
>  		cache_size = 16;
>  		if (pci_write_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, cache_size))
>  			hprintk("can't set cache line size to %d\n", cache_size);
>  	}
>  
> -	if (pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &timer))
> -	{
> +	if (pci_read_config_byte(pci_dev, PCI_LATENCY_TIMER, &timer)) {
>  		hprintk("can't read latency timer?\n");

ditto

I'll stop here :-)
