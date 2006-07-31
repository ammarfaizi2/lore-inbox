Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWGaX6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWGaX6c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWGaX6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:58:32 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:8367 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751490AbWGaX6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:58:31 -0400
From: David Brownell <david-b@pacbell.net>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [i2c] [patch 2.6.18-rc3] build fixes:  tps65010
Date: Mon, 31 Jul 2006 14:18:12 -0700
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, i2c@lm-sensors.org
References: <200607310725.34094.david-b@pacbell.net> <20060731205333.3d986eb6.khali@linux-fr.org>
In-Reply-To: <20060731205333.3d986eb6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607311418.12893.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 31 July 2006 11:53 am, Jean Delvare wrote:
> Hi David,
> 
> > The tps65010.c driver in the main tree never got updated with
> > build fixes since the last batch of I2C driver changes; and the
> > genirq trigger flags were updated wierdly too.
> 
> Typo, I guess you mean "weirdly".

OK, feel free to correct.  :)


 > @@ -520,15 +519,16 @@ tps65010_probe(struct i2c_adapter *bus, 
> >  		goto fail1;
> >  	}
> >  
> > +	/* IRQ is active low, but some gpio lines can't support that */
> > +	irqflags = IRQF_SAMPLE_RANDOM;
> >  #ifdef	CONFIG_ARM
> > -	irqflags = IRQF_SAMPLE_RANDOM | IRQF_TRIGGER_LOW;
> >  	if (machine_is_omap_h2()) {
> >  		tps->model = TPS65010;
> >  		omap_cfg_reg(W4_GPIO58);
> >  		tps->irq = OMAP_GPIO_IRQ(58);
> >  		omap_request_gpio(58);
> >  		omap_set_gpio_direction(58, 1);
> > -		irqflags |= IRQF_TRIGGER_FALLING;
> > +		irqflags |= IRQF_TRIGGER_LOW;
> >  	}
> >  	if (machine_is_omap_osk()) {
> >  		tps->model = TPS65010;
> > @@ -543,8 +543,6 @@ tps65010_probe(struct i2c_adapter *bus, 
> >  
> >  		// FIXME set up this board's IRQ ...
> >  	}
> > -#else
> > -	irqflags = IRQF_SAMPLE_RANDOM;
> >  #endif
> >  
> >  	if (tps->irq > 0) {
> 
> This is more surprising. How did the interrupt type suddenly change
> from "falling" to "low"? (Note that I am not an interrupt expert.)

The IRQ is always active-low ... but sometimes that signal line
will get hooked up to a type of GPIO pin that doesn't support
that type of trigger.  In that case the driver workaround is to
trigger on the falling edge ... "falling" always precedes "low".

However, I double checked and in this case my patch goofed.  It's
incorrect to set TRIGGER_LOW and then add TRIGGER_FALLING later,
so of course the previous code was buggy, but in this case the GPIO
should have been left at TRIGGER_FALLING.  So I'll resend this patch.

(The problem was that I misremembered the difference between MPUIO
and GPIO.  It's not that GPIO supports level triggering; it's that
GPIO also allows "both edges" triggers.)


> Anyway, thanks for fixing this. This is one of the i2c drivers that I
> can't compile on the architectures I work on, so I can't spot the
> breakage.

At some point it should be made to compile on non-OMAP systems,
if for no other reason than to address that problem!


> I guess you want this fix in 2.6.18?

Yes, please.  Fixes for build breakage and other "brown paper bag" errors
should have a high merge priority.

- Dave
