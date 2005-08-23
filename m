Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVHWWR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVHWWR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 18:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVHWWR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 18:17:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:202 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932461AbVHWWR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 18:17:58 -0400
Date: Tue, 23 Aug 2005 17:17:45 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] external interrupts: IOC4 driver
In-Reply-To: <20050820095209.GD21698@infradead.org>
Message-ID: <20050823170346.D7236@chenjesu.americas.sgi.com>
References: <20050819161213.B87000@chenjesu.americas.sgi.com>
 <20050820095209.GD21698@infradead.org>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Aug 2005, Christoph Hellwig wrote:

> > +config EXTINT_SGI_IOC4
> > +	tristate "Device driver for SGI IOC4 external interrupts"
> > +	depends on (IA64_GENERIC || IA64_SGI_SN2) && EXTINT && BLK_DEV_SGIIOC4
> 
> Is the ioc4 core abstraction config symbol really BLK_DEV_SGIIOC4?
> That probably wants fixing in a separate patch.

Oops.  Yes, in the past BLK_DEV_SGIIOC4 was the core abstraction config
symbol.  That was fixed a release or two ago, but obviously I've been
working on the external interrupt stuff for a while.  Fixed.

> > +	  This option enables support for the external interrupt ingest
> > +	  and generation capabilities of SGI IOC4 IO controllers.  If
> > +	  you have an SGI Altix with an IOC4 based IO card, say Y.
> > +	  Otherwise, say N.
> 
> Is there any Altix without an ioc4?

Yes, the Altix 330 uses third-party chips to provide base I/O functions.
Other future Altix products will similarly lack IOC4 (at least in their
base configuration).

> > +static ssize_t ioc4_extint_get_modelist(struct extint_device *ed, char *buf) {
> 
> opening brace on a separate line please.

Sorry.  Lindent took to mungeing my source (indenting in structure
definitions in particular) in unreadable ways, so I stopped using it.
Old coding styles die hard and all.

> > +#if PAGE_SIZE <= IOC4_A_INT_OUT_LENGTH
> > +	/* Only set up INT_OUT register alias page if the system page size
> > +	 * is equal to or less than the register alias page size.  Otherwise
> > +	 * the user would have access to registers other than INT_OUT.
> > +	 */
> > +	a_int_out = pci_resource_start(ied->idd->idd_pdev, 0) +
> > +	    IOC4_A_INT_OUT_OFFSET;
> > +	if (!a_int_out) {
> > +		printk(KERN_WARNING
> > +		       "%s: Unable to get IOC4 int_out alias mapping "
> > +		       "for pci_dev 0x%p.\n", __FUNCTION__, ied->idd->idd_pdev);
> > +		goto skip_alias;
> > +	}
> > +	if (!request_region(a_int_out, IOC4_A_INT_OUT_LENGTH,
> > +			    "ioc4_a_int_out")) {
> 
> This looks rather bad.  So the driver silently has less functionality
> when using a bigger page size?

For security correctness we cannot allow this page to be mapped by
anything larger than a 16K page, as that would allow the user access
to control registers which are not harmless if exposed.

However, the loss of functionality isn't silent.  In ioc4_extint_mmap()
we return -ENXIO if the mapping cannot be performed for the aforementioned
reason.  A well-written application will check for failures from mmap(2).

> > +static int ioc4_extint_remove(struct ioc4_driver_data *idd)
> > +{
> > +	struct extint_device *ed = idd->idd_extint_data;
> > +	struct ioc4_extint_device *ied;
> > +
> > +	/* If probe failed, avoid trying to remove */
> > +	if (ed)
> > +		ied = extint_get_devdata(ed);
> > +	else
> > +		return -ENXIO;
> 
> This should at lease be written:
> 
> 	if (!ed)
> 		return -ENXIO;
> 	ied = extint_get_devdata(ed);
> 
> but I don't understand how it can happen anyway.  ->remove shoould
> never be called unless ->probe initialized the device fully and
> returned 0

It was just one of many things where I coded defensively and intended
to revisit it later.  Unfortunately the revisit never took place.
Thanks for the catch -- fixed now.

Thanks,
Brent

-- 
Brent Casavant                          If you had nothing to fear,
bcasavan@sgi.com                        how then could you be brave?
Silicon Graphics, Inc.                    -- Queen Dama, Source Wars
