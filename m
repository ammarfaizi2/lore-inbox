Return-Path: <linux-kernel-owner+w=401wt.eu-S965057AbWLMRxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWLMRxM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965058AbWLMRxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:53:12 -0500
Received: from 87-194-8-8.bethere.co.uk ([87.194.8.8]:58332 "EHLO
	aeryn.fluff.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965057AbWLMRxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:53:11 -0500
Date: Wed, 13 Dec 2006 17:51:43 +0000
From: Ben Dooks <ben-fbdev@fluff.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ben Dooks <ben-fbdev@fluff.org>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: SM501: core (mfd) driver
Message-ID: <20061213175143.GA11394@home.fluff.org>
References: <20061213155134.GA10097@home.fluff.org> <1166030491.27217.844.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166030491.27217.844.camel@laptopd505.fenrus.org>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 06:21:31PM +0100, Arjan van de Ven wrote:
> Hi,
> 
> some review comments below
> > +
> > +struct sm501_devdata {
> > +	spinlock_t			 reg_lock;
> > +	struct semaphore		 clock_lock;
> 
> can't this be a mutex instead ?

I wasn't sure what context the callers would be when I originally
wrote this code. I will have a careful think of what this will be
used in, and then have a look at changing it.

> > +#ifdef CONFIG_DEBUG
> > +static unsigned int misc_div[] = {
> > +	[0]		= 1,
> > +	[1]		= 2,
> 
> can this be const ?

Yes, will change.
 
> > +
> > +int sm501_unit_power(struct device *dev, unsigned int unit, unsigned int to)
> > +{
> > +	struct sm501_devdata *sm = dev_get_drvdata(dev);
> > +	unsigned long mode = readl(sm->regs + SM501_POWER_MODE_CONTROL);
> > +	unsigned long gate = readl(sm->regs + SM501_CURRENT_GATE);
> > +	unsigned long clock = readl(sm->regs + SM501_CURRENT_CLOCK);
> > +
> > +	mode &= 3;		/* get current power mode */
> > +
> > +	down(&sm->clock_lock);
> 
> eh shouldn't you do the readl()'s inside the semaphore (or mutex) area?

Thanks, mistake when fitting locking in, fixed for next release.

> > +
> > +	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
> > +
> > +	dev_dbg(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
> > +		gate, clock, mode);
> > +
> > +	msleep(16);
> 
> you're missing a PCI posting flush here
> (if you don't know what this is please ask)

Is this a read from an device register to cause the PCI writes
to happen? Would reading SM501_POWER_MODE_CONTROL be ok, or does
it require a different register?
 
> > +	sm->dev = &dev->dev;
> > +	sm->irq = dev->irq;
> 
> you shouldn't look at dev->irq ...
> 
> > +
> > +	/* set a hopefully unique id for our child platform devices */
> > +	sm->pdev_id = 32 + dev->devfn;
> > +
> > +	pci_set_drvdata(dev, sm);
> > +
> > +	err = pci_enable_device(dev);
> 
> .. before calling pci_enable_device() since pci_enable_device() may be
> the one that sets the dev->irq value to it's final value in the first
> place

Ok, fixed.

> > +	sm->io_res = &dev->resource[1];
> > +	sm->mem_res = &dev->resource[0];
> > +
> > +	sm->regs = ioremap(pci_resource_start(dev, 1),
> > +			   pci_resource_len(dev, 1));
> 
> you know how to use pci_resource_start() and co.. why not use them 3
> lines higher ? ;)

These pointers where meant to be kept for setting new resources'
parent pointers, will check what happened.

> 
> the driver looks quite clean otherwise btw, great work!

Thanks for the prompt and useful reply.

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
