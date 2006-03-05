Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751370AbWCIN7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751370AbWCIN7Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 08:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751895AbWCIN7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 08:59:16 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4617 "EHLO spitz.ucw.cz")
	by vger.kernel.org with ESMTP id S1751893AbWCIN7P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 08:59:15 -0500
Date: Sun, 5 Mar 2006 00:12:54 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Collie battery status sensing code
Message-ID: <20060305001254.GA2423@ucw.cz>
References: <20060309123842.GA3619@elf.ucw.cz> <1141910391.10107.49.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141910391.10107.49.camel@localhost.localdomain>
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

I'll just remove most printks before next merge attempt, I guess.

> Just for my interest, can you summarise the status of PM and charging on
> collie with this code?

Well, with heavy ifdefs into sharpsl_pm, it can correctly sense
AC/battery. Voltmeters seem to return *some* values. Temperature is
probably okay, battery level is *extremely* noisy, and outside range
where sharp code expects it, but seems to correlate with actual
battery levels.

Now... something does charge my battery, but it is definitely not my
code. I don't dare enabling charging yet. 

(More detailed reply will come later today, when I'm close to collie).

> > +#include "../drivers/mfd/ucb1x00.h"
> > +#include <asm/mach/sharpsl_param.h>
> > +
> > +#ifdef CONFIG_MCP_UCB1200_TS
> > +#error Battery interferes with touchscreen
> > +#endif
> 
> Is this a case of bad locking or something more serious?

Original sharp code does some magic between TS and battery reading. It
seems AD0 is used by both, or something similary ugly. I'll have to
decipher sharp code and figure out how to do it properly.

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

I thought about it, and considered it quite ugly. Result would be all
data on the platform bus with half-empty device on ucb1x00 "bus". It
would bring me some problems with registering order: if platform
device is registered too soon, ucb will be NULL and it will crash and
burn. OTOH I already have static *ucb, so it is doable, and I can do
it if you prefer it that way...
-- 
Thanks, Sharp!
