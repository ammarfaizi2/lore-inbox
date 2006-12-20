Return-Path: <linux-kernel-owner+w=401wt.eu-S965159AbWLTXni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWLTXni (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 18:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWLTXni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 18:43:38 -0500
Received: from stargate.chelsio.com ([12.22.49.110]:32151 "EHLO
	stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965159AbWLTXnh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 18:43:37 -0500
Message-ID: <4589CA9C.80007@chelsio.com>
Date: Wed, 20 Dec 2006 15:43:24 -0800
From: Divy Le Ray <divy@chelsio.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Divy Le Ray <None@chelsio.com>, jeff@garzik.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, swise@opengridcomputing.com
Subject: Re: [PATCH 2/10] cxgb3 - main source file
References: <20061220124134.6299.29373.stgit@localhost.localdomain> <1166623330.3365.1397.camel@laptopd505.fenrus.org>
In-Reply-To: <1166623330.3365.1397.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2006 23:43:26.0514 (UTC) FILETIME=[A4FAD120:01C72490]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan,

Thanks for the review. Please see my replies inline.

Arjan van de Ven wrote:
>> +/*
>> + * Interrupt handler for asynchronous events used with MSI-X.
>> + */
>> +static irqreturn_t t3_async_intr_handler(int irq, void *cookie)
>> +{
>> +	t3_slow_intr_handler(cookie);
>> +	return IRQ_HANDLED;
>> +}
>
> this looks very wrong; why is t3_slow_intr_handler a void rather than
> returning IRQ_HANDLED etc? And why wrap around it ?
t3_slow_intr_handler() processes non-data events such as board errors.
In line interupt and MSI mode, the intr handler deals with both data
and non-data events and calls t3_slow_intr_handler for the latter.
In MSI-X mode, t3_async_intr_handler() is registered to deal with these
non-data interrupts exclusively.

>> +
>> +static ssize_t attr_show(struct class_device *cd, char *buf,
>> +			 ssize_t(*format) (struct adapter *, char *))
>> +{
>> +	ssize_t len;
>> +	struct adapter *adap = to_net_dev(cd)->priv;
>> +
>> +	/* Synchronize with ioctls that may shut down the device */
>> +	rtnl_lock();
>> +	len = (*format) (adap, buf);
>> +	rtnl_unlock();
>> +	return len;
>> +}
>
> I'm usually kind of nervous with drivers taking the rtnl_lock; to me
> that sounds like a layering violation.. why shouldn't your attributes
> etc live in the net layer instead?

These attributes are really device specific.
The net layer does not support device specific attributes.

>> +#ifdef ETHTOOL_GPERMADDR
>> +	.get_perm_addr = ethtool_op_get_perm_addr
>> +#endif
>
> what is this ifdef for?
it will be removed.
>> +static int cxgb_extension_ioctl(struct net_device *dev, void __user *useraddr)
>> +{
>> +	int ret;
>> +	u32 cmd;
>> +	struct adapter *adapter = dev->priv;
>> +
>> +	if (copy_from_user(&cmd, useraddr, sizeof(cmd)))
>> +		return -EFAULT;
>> +
>> +	switch (cmd) {
>> +	case CHELSIO_SETREG:{
>
> what are these for ?
They are used to parameter the HW:
register access, configuration of queue sets, on board memory 
configuration,
firmware load, etc ...
>> +
>> +	/*
>> +	 * Can't use pci_request_regions() here because some kernels want to
>> +	 * request the MSI-X BAR in pci_enable_msix.
>
> are these "some kernels" actual current mainline kernels?
Will fix both comment and related code.
>> +	if (!pci_set_dma_mask(pdev, DMA_64BIT_MASK)) {
>> +		pci_using_dac = 1;
>> +		err = pci_set_consistent_dma_mask(pdev, DMA_64BIT_MASK);
>> +		if (err) {
>> +			dev_err(&pdev->dev, "unable to obtain 64-bit DMA for "
>> +			       "coherent allocations\n");
>> +			goto out_release_regions;
>
> this looks wrong; if you can't get 64 bit coherent allocs but can get 32
> bit ones.. why error out ?
This is how most of the existing drivers behave.

Cheers,
Divy
