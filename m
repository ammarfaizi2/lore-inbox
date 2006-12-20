Return-Path: <linux-kernel-owner+w=401wt.eu-S965068AbWLTOC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965068AbWLTOC3 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 09:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965073AbWLTOC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 09:02:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53786 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965066AbWLTOC2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 09:02:28 -0500
Subject: Re: [PATCH 2/10] cxgb3 - main source file
From: Arjan van de Ven <arjan@infradead.org>
To: Divy Le Ray <None@chelsio.com>
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com
In-Reply-To: <20061220124134.6299.29373.stgit@localhost.localdomain>
References: <20061220124134.6299.29373.stgit@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 20 Dec 2006 15:02:09 +0100
Message-Id: <1166623330.3365.1397.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +/*
> + * Interrupt handler for asynchronous events used with MSI-X.
> + */
> +static irqreturn_t t3_async_intr_handler(int irq, void *cookie)
> +{
> +	t3_slow_intr_handler(cookie);
> +	return IRQ_HANDLED;
> +}

this looks very wrong; why is t3_slow_intr_handler a void rather than
returning IRQ_HANDLED etc? And why wrap around it ?

> +
> +static ssize_t attr_show(struct class_device *cd, char *buf,
> +			 ssize_t(*format) (struct adapter *, char *))
> +{
> +	ssize_t len;
> +	struct adapter *adap = to_net_dev(cd)->priv;
> +
> +	/* Synchronize with ioctls that may shut down the device */
> +	rtnl_lock();
> +	len = (*format) (adap, buf);
> +	rtnl_unlock();
> +	return len;
> +}

I'm usually kind of nervous with drivers taking the rtnl_lock; to me
that sounds like a layering violation.. why shouldn't your attributes
etc live in the net layer instead?

> +#ifdef ETHTOOL_GPERMADDR
> +	.get_perm_addr = ethtool_op_get_perm_addr
> +#endif

what is this ifdef for?


> +static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
> +{
> +	int ret;
> +	u32 cmd;
> +	struct adapter *adapter = dev->priv;
> +
> +	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
> +		return -EFAULT;
> +
> +	switch (cmd) {
> +	case CHELSIO_SETREG:{

what are these for ?

> +
> +	/*
> +	 * Can't use pci_request_regions() here because some kernels want to
> +	 * request the MSI-X BAR in pci_enable_msix.

are these "some kernels" actual current mainline kernels?

> +	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
> +		pci_using_dac = 1;
> +		err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
> +		if (err) {
> +			dev_err(&pdev->dev, "unable to obtain 64-bit DMA for "
> +			       "coherent allocations\n");
> +			goto out_release_regions;

this looks wrong; if you can't get 64 bit coherent allocs but can get 32
bit ones.. why error out ?




-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

