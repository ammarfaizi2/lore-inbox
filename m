Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932619AbVIHPG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932619AbVIHPG1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVIHPG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:06:26 -0400
Received: from tim.rpsys.net ([194.106.48.114]:24483 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S932611AbVIHPGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:06:25 -0400
Subject: Re: [-mm patch 2/5] SharpSL: Add cxx00 support to the Corgi LCD
	driver
From: Richard Purdie <rpurdie@rpsys.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050908133408.F31595@flint.arm.linux.org.uk>
References: <1126007628.8338.127.camel@localhost.localdomain>
	 <20050908133408.F31595@flint.arm.linux.org.uk>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 16:06:10 +0100
Message-Id: <1126191970.8147.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-09-08 at 13:34 +0100, Russell King wrote: 
> On Tue, Sep 06, 2005 at 12:53:48PM +0100, Richard Purdie wrote:
> > +/*
> > + * Corgi/Spitz Touchscreen to LCD interface
> > + */
> > +unsigned long inline corgi_get_hsync_len(void) 
> > +{
> > +	if (machine_is_corgi() || machine_is_shepherd() || machine_is_husky()) {
> > +#ifdef CONFIG_PXA_SHARP_C7xx
> > +		return w100fb_get_hsynclen(&corgifb_device.dev);
> > +#endif
> > +	} else if (machine_is_spitz() || machine_is_akita() || machine_is_borzoi()) {
> > +#ifdef CONFIG_PXA_SHARP_Cxx00
> > +		return pxafb_get_hsync_time(&pxafb_device.dev);
> > +#endif
> 
> This means you have to force these drivers to be built (since this file
> will always be built for sharp stuff.)  This doesn't seem like a good
> solution.

It was made inline so in theory only the touchscreen drivers had the
dependency. I then moved it to another file which kind of breaks things.

Would using symbol_put and symbol_get be a better solution? I was warned
off those functions in the past but this would appear to be an ideal use
as if the framebuffer drivers aren't loaded, we don't care about this.

> > +#define SyncHS(x)   while((GPLR(x) & GPIO_bit(x)) == 0); while((GPLR(x) & GPIO_bit(x)) != 0);
> 
> That's particularly gruesome - firstly, two statements inside a macro.
> Secondly, no barrier() or cpu_relax() in there (as the kernel janitors
> like to see.)  It won't make any difference to the generated code, but
> makes other folk happier.

This needs to be a fast piece of code as its in an interrupt handler and
we go to great lengths to time things to avoid interference from the
lcd. I need to check what timing overhead those functions have...

Richard

