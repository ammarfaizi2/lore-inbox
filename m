Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVHTJwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVHTJwM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 05:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVHTJwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 05:52:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:35201 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751078AbVHTJwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 05:52:10 -0400
Date: Sat, 20 Aug 2005 10:52:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] external interrupts: IOC4 driver
Message-ID: <20050820095209.GD21698@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <20050819161213.B87000@chenjesu.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819161213.B87000@chenjesu.americas.sgi.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +config EXTINT_SGI_IOC4
> +	tristate "Device driver for SGI IOC4 external interrupts"
> +	depends on (IA64_GENERIC || IA64_SGI_SN2) && EXTINT && BLK_DEV_SGIIOC4

Is the ioc4 core abstraction config symbol really BLK_DEV_SGIIOC4?
That probably wants fixing in a separate patch.

> +	  This option enables support for the external interrupt ingest
> +	  and generation capabilities of SGI IOC4 IO controllers.  If
> +	  you have an SGI Altix with an IOC4 based IO card, say Y.
> +	  Otherwise, say N.

Is there any Altix without an ioc4?

> + */
> +static ssize_t ioc4_extint_get_modelist(struct extint_device *ed, char *buf) {

opening brace on a separate line please.

> +#if PAGE_SIZE <= IOC4_A_INT_OUT_LENGTH
> +	/* Only set up INT_OUT register alias page if the system page size
> +	 * is equal to or less than the register alias page size.  Otherwise
> +	 * the user would have access to registers other than INT_OUT.
> +	 */
> +	a_int_out = pci_resource_start(ied->idd->idd_pdev, 0) +
> +	    IOC4_A_INT_OUT_OFFSET;
> +	if (!a_int_out) {
> +		printk(KERN_WARNING
> +		       "%s: Unable to get IOC4 int_out alias mapping "
> +		       "for pci_dev 0x%p.\n", __FUNCTION__, ied->idd->idd_pdev);
> +		goto skip_alias;
> +	}
> +	if (!request_region(a_int_out, IOC4_A_INT_OUT_LENGTH,
> +			    "ioc4_a_int_out")) {

This looks rather bad.  So the driver silently has less functionality
when using a bigger page size?

> +	/* Enable interrupt input */
> +	ret = ioc4_extint_input_enable(ied);
> +	if (ret)
> +		goto out_enable;
> +
> +	return 0;
> +
> +out_enable:
> +	extint_device_unregister(idd->idd_extint_data);
> +out_register:
> +	ioc4_extint_device_destroy(ied);
> +out_device:
> +	ioc4_extint_input_teardown(ied);
> +	ioc4_extint_output_teardown(ied);
> +	kfree(ied);
> +out:
> +	return ret;
> +}
> +
> +static int ioc4_extint_remove(struct ioc4_driver_data *idd)
> +{
> +	struct extint_device *ed = idd->idd_extint_data;
> +	struct ioc4_extint_device *ied;
> +
> +	/* If probe failed, avoid trying to remove */
> +	if (ed)
> +		ied = extint_get_devdata(ed);
> +	else
> +		return -ENXIO;

This should at lease be written:

	if (!ed)
		return -ENXIO;
	ied = extint_get_devdata(ed);

but I don't understand how it can happen anyway.  ->remove shoould
never be called unless ->probe initialized the device fully and
returned 0

