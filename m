Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266340AbUFPWv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266340AbUFPWv2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 18:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266339AbUFPWv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 18:51:27 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:41580 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264297AbUFPWvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 18:51:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 0/3] Couple of sysfs patches
Date: Wed, 16 Jun 2004 17:51:03 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20040610144658.31403.qmail@web81309.mail.yahoo.com> <20040610191740.B6833@flint.arm.linux.org.uk> <20040610212552.C6833@flint.arm.linux.org.uk>
In-Reply-To: <20040610212552.C6833@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406161751.03574.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 June 2004 03:25 pm, Russell King wrote:
> On Thu, Jun 10, 2004 at 07:17:40PM +0100, Russell King wrote:
> > On Thu, Jun 10, 2004 at 09:14:42AM -0700, Greg KH wrote:
> > > On Thu, Jun 10, 2004 at 05:06:07PM +0100, Russell King wrote:
> > > > 
> > > > Now that I can see the platform device interfaces multipling like rabbits,
> > > > (to GregKH) I think that the patch I submitted for platform_add_device
> > > > suffers from this problem as well, and I should've thrown that code
> > > > into platform_register_device itself.
> > > > 
> > > > Greg - comments?  Would you like a new patch which does that, or do you
> > > > think that's too risky?
> > > 
> > > Hm, I don't think it's too risky.  Make up a patch and let's see how it
> > > looks.
> > > 
> > > I'm just worried that this "simple" interface really isn't so simple, as
> > > it's almost just as much work to manage it as a normal platform device.
> > 
> > Ok, here's a patch so you can see what I'm suggesting above.  This is
> > on top of the previous patch I sent.  Merely discards one over-eager
> > rabbit [1] and moves the code into platform_device_register().
> > 
> > [1]: No animals were harmed in the creation of this patch.
> 
> And for added good behaviour, particularly when things go wrong.
> 
>  
> +	for (i = 0; i < pdev->num_resources; i++) {
> +		struct resource *p, *r = &pdev->resource[i];
> +
> +		r->name = pdev->dev.bus_id;
> +
> +		p = NULL;
> +		if (r->flags & IORESOURCE_MEM)
> +			p = &iomem_resource;
> +		else if (r->flags & IORESOURCE_IO)
> +			p = &ioport_resource;
> +
> +		if (p && request_resource(p, r)) {
> +			printk(KERN_ERR
> +			       "%s: failed to claim resource %d\n",
> +			       pdev->dev.bus_id, i);
> +			ret = -EBUSY;
> +			goto failed;
> +		}
> +	}
> +

What about freeing the resources? Can it be put in platform_device_unregister
or is it release handler task? I'd put it in unregister because when I call
unregister I expect device be half-dead and release as much resources as it
can.

-- 
Dmitry
