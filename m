Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964924AbVL3XrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964924AbVL3XrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbVL3XrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:47:14 -0500
Received: from mx.pathscale.com ([64.160.42.68]:38045 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964924AbVL3XrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:47:12 -0500
Subject: Re: [PATCH 8 of 20] ipath - core driver, part 1 of 4
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <20051230083928.GD7438@kroah.com>
References: <patchbomb.1135816279@eng-12.pathscale.com>
	 <ddd21709e12c0cd55bdc.1135816287@eng-12.pathscale.com>
	 <20051230083928.GD7438@kroah.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Fri, 30 Dec 2005 15:47:07 -0800
Message-Id: <1135986427.13318.79.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 00:39 -0800, Greg KH wrote:

> > +void ipath_chip_done(void)
> > +{
> > +}
> > +
> > +void ipath_chip_cleanup(struct ipath_devdata * dd)
> > +{
> > +}
> 
> What are these two empty functions for?

They're just as dead as they look.

> > +static ssize_t show_status_str(struct device *dev,

> how big can this "status string" be?

Just a few dozen bytes.

>   If it's even getting close to
> PAGE_SIZE, this doesn't need to be a sysfs attribute, but you should
> break it up into its individual pieces.

Do you think that's still warranted, given this?

> > +static ssize_t show_unit(struct device *dev,

> Don't you mean -ENODEV?

Yes, thanks.

> > +	snprintf(buf, PAGE_SIZE, "%u\n", dd->ipath_unit);
> > +	return strlen(buf);
> 
> return the snprintf() call instead of calling strlen() all the time
> please.

OK.

> > +const struct pci_device_id infinipath_pci_tbl[] = {
> > +	{
> > +	 PCI_VENDOR_ID_PATHSCALE, PCI_DEVICE_ID_PATHSCALE_INFINIPATH_HT,
> > +	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
> 
> PCI_DEVICE() instead?

OK.

> > +	{0,}
> 
>   {},
> is all that is needed here.

OK.

> > +	.driver.owner = THIS_MODULE,
> 
> This line is not needed, you can remove it.

OK.

> {} not needed here.

OK.

> > +#if defined (pgprot_writecombine) && defined(_PAGE_MA_WC)
> > +	printk("Remapping pages WC\n");
> 
> No KERN_ level?

That should just become a debug statement.

> > +	/*
> > +	 * set these up before registering the interrupt handler, just
> > +	 * in case
> > +	 */
> > +	devdata[dev].pcidev = pdev;
> > +	pci_set_drvdata(pdev, &(devdata[dev]));
> 
> It's not a "just in case" type thing, you have to do this before you
> register that interrupt handler, as you can be instantly called here.

OK, I'll remove the misleading comment.

> Are you sure everything else is set up properly here before calling that
> function?

I believe so.  I'll double check.

> > +	device_create_file(&(pdev->dev), &dev_attr_status);
> > +	device_create_file(&(pdev->dev), &dev_attr_status_str);
> > +	device_create_file(&(pdev->dev), &dev_attr_lid);
> > +	device_create_file(&(pdev->dev), &dev_attr_mlid);
> > +	device_create_file(&(pdev->dev), &dev_attr_guid);
> > +	device_create_file(&(pdev->dev), &dev_attr_nguid);
> > +	device_create_file(&(pdev->dev), &dev_attr_serial);
> > +	device_create_file(&(pdev->dev), &dev_attr_unit);
> 
> Why not use an attribute array?  Makes for proper error handling if one
> of those calls does not work...

OK, thanks.

> > +	/*
> > +	 * We used to cleanup here, with pci_release_regions, etc. but that
> > +	 * can cause other problems if we want to run diags, etc., so instead
> > +	 * defer that until driver unload.
> > +	 */
> 
> So memory leaks are acceptable?

That clearly needs a bit of attention.

> > +fail:	/* after we've done at least some of the pci setup */
> > +	if (ret == -EPERM) /* disabled device, don't want module load error;
> > +		* just want to carry status through to this point */
> > +		ret = 0;
> 
> Module load error does not happen no matter what kind of return value
> you send back from this function.  So the comment is wrong, and the fact
> that you failed initializing the device is also wrong, please don't do
> this.

OK.

Thanks for the extensive comments,

	<b

