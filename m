Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752181AbWCJIzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbWCJIzr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbWCJIzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:55:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26050 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1752181AbWCJIzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:55:46 -0500
Date: Fri, 10 Mar 2006 09:55:30 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Collie battery status sensing code
Message-ID: <20060310085530.GA4903@elf.ucw.cz>
References: <20060309123842.GA3619@elf.ucw.cz> <1141910391.10107.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141910391.10107.49.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This is collie battery sensing code. It differs from sharpsl code a
> > bit -- because it is dependend on ucb1x00, not on platform bus.
> > 
> > I guess I should reorganize #include's and remove #if 0-ed
> > code. Anything else
> 
> Basically looks good. Could probably use a
> s/printk/dev_dbg(sharpsl_pm.dev, /. I've made a few other comments
> below. 

Ok, comments below.

> > +#include <asm/arch/collie.h>
> > +#include "../mach-pxa/sharpsl.h"
> 
> Do you need anything in the above header? If so, it should probably be
> in asm/hardware/sharpsl_pm.h

Thanks, fixed.

> > +#ifdef I_AM_SURE
> > +#define CF_BUF_CTRL_BASE 0xF0800000
> > +#define        SCOOP_REG(adr) (*(volatile unsigned short*)(CF_BUF_CTRL_BASE+(adr)))
> > +#define        SCOOP_REG_GPWR    SCOOP_REG(SCOOP_GPWR)
> > +
> > +	if (on) {
> > +		SCOOP_REG_GPWR |= COLLIE_SCP_CHARGE_ON;
> > +	} else {
> > +		SCOOP_REG_GPWR &= ~COLLIE_SCP_CHARGE_ON;
> 
> Ick. Use arch/arm/common/scoop.c to do this. Something like:

Thanks, fixed.

> > +extern struct sharpsl_pm_status sharpsl_pm;
> > +
> > +static int __init collie_pm_add(struct ucb1x00_dev *pdev)
> > +{
> > +	sharpsl_pm.dev = NULL;
> > +	sharpsl_pm.machinfo = &collie_pm_machinfo;
> > +	ucb = pdev->ucb;
> > +	return sharpsl_pm_init();
> > +}
> 
> I don't understand how this is supposed to work at all. For a start,
> sharpsl_pm.c says "static int __devinit sharpsl_pm_init(void)" so that
> function isn't available. I've just noticed your further patches
> although I still don't like this.
> 
> The correct approach is to register a platform device called
> "sharpsl-pm" in collie_pm_add() which the driver will then see and
> attach to. I'd also not register the platform device if ucb is NULL for
> whatever reason.
> 
> By setting sharpsl_pm.dev = NULL you're also going to miss out on
> suspend/resume calls and risk breaking things like
> dev_dbg(sharpsl_pm.dev, xxx). 

Ok, I'll try to switch it to two-device config.
								Pavel
-- 
28:class DeDRMS
