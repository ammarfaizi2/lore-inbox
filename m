Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262890AbUKRS7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbUKRS7h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 13:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262876AbUKRS51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 13:57:27 -0500
Received: from atorelbas04.hp.com ([156.153.255.238]:41403 "EHLO
	palrel13.hp.com") by vger.kernel.org with ESMTP id S262886AbUKRSzE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 13:55:04 -0500
Date: Thu, 18 Nov 2004 10:55:03 -0800
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org, syrjala@sci.fi,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] smsc-ircc2: Add PnP support.
Message-ID: <20041118185503.GA5584@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <419CECFF.2090608@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419CECFF.2090608@free.fr>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 07:42:07PM +0100, matthieu castet wrote:
> Hi,
> 
> I had also done a pnp patch for the smsc-ircc2 and irport 3 months ago.
> Unfortunaly I don't remember where I put the patches, certainly on the 
> laptop that it is in my parent home.

	I've never seen you patches on the irda mailing list...

> try to do an "echo auto > /sys/bus/pnp/device_number/resources"
> 
> It will reenable the device.

	Thanks for the tip.

> > I have a machine with nsc-ircc here so I think I'll try that too.
> >
> > > OnThe issue there is that if a smsc chipset has a valid PnP ID
> > > but somehow the pnp_probe fails to set it up, then the regular probe
> > > won't be able to configure it. This makes me nervous.
> > >
> Yes that's the problem this pnp, if the probe failed it disable the 
> device resource.
> When I do my patch I encounter the problem : I called pnp driver after 
> smsc_ircc_look_for_chips, so all the resources where already reserved, 
> and the pnp probe failed and it disable the resource, and the device 
> found with the traditional smsc_ircc_look_for_chips doesn't work.
> 
> So in my patch if I register pnp devices, I don't run 
> smsc_ircc_look_for_chips like it is done for (ircc_fir>0)&&(ircc_sir>0) 
> case.

	smsc_ircc_look_for_chips won't re-register the devices
configured via PnP, as smsc_ircc_present won't be able to request the
region. So, I don't see the problem. And you could imagine having
multiple SMSC in the box, some PnP, some not.
	Note that we could put the region check earlier, but I like
the fact that the driver is still able to probe completely the chip
even if the serial driver has grabbed the regions. Maybe we could
split the difference and request the FIR region early on (so to fail
on SMC devices already registered) and request the other ressources
late (so as to completely probe even when serial is loaded).

> > > On3) If the ressources are markes as disabled, you just quit
> > > with an error. Compouded with (2), this makes me doubly
> > > nervous. Wouldn't it be possible to forcefully enable those 
> ressources ?
> pnp should call automatiquely pnp_activate_dev() before probing the 
> driver, so the resource should be activated. Have you got an example 
> where the resource wheren't activated ?

	No, it was more that I don't understand what PnP does for
us. I don't have a SMS chipset to test on. Also, I would like to know
if it remove the need of smcinit.

	Thanks, have fun...

	Jean
