Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUFJQGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUFJQGQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbUFJQGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:06:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4620 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261786AbUFJQGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:06:12 -0400
Date: Thu, 10 Jun 2004 17:06:07 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Message-ID: <20040610170607.A5830@flint.arm.linux.org.uk>
Mail-Followup-To: Dmitry Torokhov <dtor_core@ameritech.net>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20040610144658.31403.qmail@web81309.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040610144658.31403.qmail@web81309.mail.yahoo.com>; from dtor_core@ameritech.net on Thu, Jun 10, 2004 at 07:46:58AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 07:46:58AM -0700, Dmitry Torokhov wrote:
> Russell King wrote:
> > On Thu, Jun 10, 2004 at 07:55:59AM -0500, Dmitry Torokhov wrote:
> > > On Thursday 10 June 2004 05:16 am, Russell King wrote:
> > > >
> > > > As this currently stands, you have no chance to add resources to the
> > > > platform device before it's made available to the driver.  It's likely
> > > > that any attached resources will have the same lifetime as the
> > > > device itself, so it makes sense to allocate them together with the
> > > > platform device.
> > > >
> > >
> > > Are you suggesting adding pointer to resources as a 3rd argument and
> > > automotically release it for the user? It probably could be done but users
> > > will be tempted to use static module data and bad things would happen.
> > 
> > Please read my second sentence again.  It implies a copy of the resources
> > is kept with the platform device, so both have the same lifetime.
> > 
> 
> Ok, so function pointer to allocate resources and associate with the
> device? You can't just allocate memory for resources structure, you
> need to populate it with data if you want it to be used by a driver
> immediately after registration... And have actually release all
> resources, not only memory? It is getting beyond the "*_simple"
> approach though.
> 
> Or do I still misunderstand you?

Something like:

struct platform_object {
	struct platform_device pdev;
	struct resource resources[0];
};

struct platform_device *platform_device_register_simple(char *name, unsigned int id, struct resource *res, int num)
{
	struct platform_object *pobj;
	int retval;

	pobj = kmalloc(sizeof(struct platform_object) + sizeof(struct resource) * num, GFP_KERNEL);
	if (!pobj) {
		retval = -ENOMEM;
		goto error;
	}

	memset(pobj, 0, sizeof(*pdev));
	pobj->pdev.name = name;
	pobj->pdev.id = id;
	pobj->pdev.dev.release = platform_device_release_simple;

	if (num) {
		memcpy(pobj->resources, res, sizeof(struct resource) * num);
		pobj->pdev.resource = pobj->resources;
		pobj->pdev.num_resources = num;
	}

ARM is going very much down this route, and we're also going to need these
things dynamically allocated as you do, but with the resource stuff.  So
rather than putting in something which only satisfies your problem, and
then adding yet more interfaces to cover the extra resources, we should
be thinking about something sane from the beginning.

Now that I can see the platform device interfaces multipling like rabbits,
(to GregKH) I think that the patch I submitted for platform_add_device
suffers from this problem as well, and I should've thrown that code
into platform_register_device itself.

Greg - comments?  Would you like a new patch which does that, or do you
think that's too risky?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
