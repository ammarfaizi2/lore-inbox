Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTDKTkV (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbTDKTkV (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:40:21 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:60884 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261625AbTDKTkS (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:40:18 -0400
Date: Fri, 11 Apr 2003 12:54:15 -0700
From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add i2c-viapro.c
Message-ID: <20030411195415.GN1821@kroah.com>
References: <20030411193216.GA9505@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411193216.GA9505@dreamland.darkstar.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 09:32:16PM +0200, Kronos wrote:
> Hi,
> the following patch  (against 2.5.67) adds support for the  SMBus bus on
> VIA  motherboard based  of 82C596,  82C686 and  823x. It is  needed, for
> example, for the eeprom driver and for w83781d. I've tested it on a 8233
> chipset.  Comments and feedback are welcome.

Looks good, with a few minor things that I can see:

> +/* Detect whether a compatible device can be found, and initialize it. */
> +int vt596_setup(void)

This function should take a struct pci_dev * as a paramater, that way we
don't have to do:

> +	/* First check whether we can access PCI at all */
> +	if (pci_present() == 0)
> +		return(-ENODEV);
> +
> +	/* Look for a supported device/function */
> +	do {
> +		if((VT596_dev = pci_find_device(PCI_VENDOR_ID_VIA, num->dev,
> +					        VT596_dev)))
> +			break;
> +	} while ((++num)->dev);
> +
> +	if (VT596_dev == NULL)
> +		return(-ENODEV);
> +	dev_info("Found Via %s device\n", num->name);

All of this is not necessary, as the pci core will give is a proper
pointer to a device that is in the pci device list that is passed to it.

> +#ifdef DEBUG
> +	if ((temp & 0x0E) == 8)
> +		dev_info(&VT596_dev->dev, "using Interrupt 9 for SMBus.\n");
> +	else if ((temp & 0x0E) == 0)
> +		dev_info(&VT596_dev->dev, "using Interrupt SMI# for SMBus.\n");
> +	else
> +		dev_warn(&VT596_dev->dev, "Illegal Interrupt configuration "
> +			"(or code out of date)!\n");
> +
> +	pci_read_config_byte(VT596_dev, SMBREV, &temp);
> +	dev_info(&VT596_dev->dev, "SMBREV = 0x%X\n", temp);
> +	dev_info(&VT596_dev->dev, "VT596_smba = 0x%X\n", vt596_smba);
> +#endif	/* DEBUG */

You can drop the #ifdef and change the dev_info() and dev_warn() calls
here to dev_dbg().


> +static int __devinit vt596_probe(struct pci_dev *dev, const struct pci_device_id *id)
> +{
> +	int retval;
> +
> +	retval = vt596_setup();

Here's where we can just pass the dev paramater to the function.


Other than those minor things, it looks very good.  Almost ready to add
to the tree.

thanks,

greg k-h
