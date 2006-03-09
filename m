Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWCIRNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWCIRNE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 12:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbWCIRNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 12:13:04 -0500
Received: from tim.rpsys.net ([194.106.48.114]:29073 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750822AbWCIRNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 12:13:02 -0500
Subject: Re: [rfc] Collie battery status sensing code
From: Richard Purdie <rpurdie@rpsys.net>
To: Pavel Machek <pavel@ucw.cz>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060305001254.GA2423@ucw.cz>
References: <20060309123842.GA3619@elf.ucw.cz>
	 <1141910391.10107.49.camel@localhost.localdomain>
	 <20060305001254.GA2423@ucw.cz>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 17:12:51 +0000
Message-Id: <1141924371.10107.75.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-05 at 00:12 +0000, Pavel Machek wrote:
> > Just for my interest, can you summarise the status of PM and charging on
> > collie with this code?
> 
> Well, with heavy ifdefs into sharpsl_pm, it can correctly sense
> AC/battery. Voltmeters seem to return *some* values. Temperature is
> probably okay, battery level is *extremely* noisy, and outside range
> where sharp code expects it, but seems to correlate with actual
> battery levels.

The sharp code often had delays in it to allow voltages to stablise etc.
I still see noise issues on one of the devices. A particularly puzzling
spitz noise issue is when I make the battery reading whilst suspended
without loading the power supply line with an LED :-/. (the sharp code
didn't do this but I can find now other way to make it work).

> > > +#include "../drivers/mfd/ucb1x00.h"
> > > +#include <asm/mach/sharpsl_param.h>
> > > +
> > > +#ifdef CONFIG_MCP_UCB1200_TS
> > > +#error Battery interferes with touchscreen
> > > +#endif
> > 
> > Is this a case of bad locking or something more serious?
> 
> Original sharp code does some magic between TS and battery reading. It
> seems AD0 is used by both, or something similary ugly. I'll have to
> decipher sharp code and figure out how to do it properly.

ok.

> > > +static int __init collie_pm_add(struct ucb1x00_dev *pdev)
> > > +{
> > > +	sharpsl_pm.dev = NULL;
> > > +	sharpsl_pm.machinfo = &collie_pm_machinfo;
> > > +	ucb = pdev->ucb;
> > > +	return sharpsl_pm_init();
> > > +}
> > 
> > I don't understand how this is supposed to work at all. For a start,
> > sharpsl_pm.c says "static int __devinit sharpsl_pm_init(void)" so that
> > function isn't available. I've just noticed your further patches
> > although I still don't like this.
> > 
> > The correct approach is to register a platform device called
> > "sharpsl-pm" in collie_pm_add() which the driver will then see and
> > attach to. I'd also not register the platform device if ucb is NULL for
> > whatever reason.
> 
> I thought about it, and considered it quite ugly. Result would be all
> data on the platform bus with half-empty device on ucb1x00 "bus". It
> would bring me some problems with registering order: if platform
> device is registered too soon, ucb will be NULL and it will crash and
> burn. OTOH I already have static *ucb, so it is doable, and I can do
> it if you prefer it that way...

If you register the sharpsl-pm device in the collie_pm_add() function,
ucb should always have registered by that point? As you say, you already
have the static *ucb and I'm hoping using the platform device will mean
less invasive changes in sharpsl_pm itself in the future?

For the record, this patch from Dirk Opfer also exists. He's working on
using sharpsl-pm on tosa.

http://www.rpsys.net/openzaurus/patches/archive/sharpsl_pm-do-r2.patch

Richard


