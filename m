Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750967AbWHGO7c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbWHGO7c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 10:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWHGO7c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 10:59:32 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:45542 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750957AbWHGO7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 10:59:31 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 7 Aug 2006 17:58:33 +0300
From: Tony Lindgren <tony@atomide.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Komal Shah <komal_shah802003@yahoo.com>,
       David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
Message-ID: <20060807145832.GF10387@atomide.com>
References: <1154689868.12791.267626769@webmail.messagingengine.com> <20060805103113.058ce8fe.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060805103113.058ce8fe.khali@linux-fr.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Jean Delvare <khali@linux-fr.org> [060805 11:31]:
> 
> > >> +		if (armxor_rate > 16000000)
> > >> +			psc = (armxor_rate + 8000000) / 12000000;
> > >> +		else
> > >> +			psc = 0;
> > 
> > >Can you please explain this formula?
> > 
> > The OMAP core uses 8-bit value to divide the system clock (SCLK) and
> > generates its own sampling clock (ICLK), and the core logic is sampled
> > at clock rate of the system clock for the module, divided by (prescaler value + 1)
> 
> I should have been more precise, I guess. What surprises me are the
> numbers themselves. It's frequent to see forumlae of the form
> "a = (b + c/2) / c" to divide with proper rounding, but here you have
> 2c/3 instread of c/2. My question was more like: is it intentional, or a
> typo? Also, with the code above, psc will never have value 1. The "if"
> part will always compute to at least 2, and the "else" part to 0. Is
> this OK?
> 

Hmmm, this sounds like a bug somewhere. TRM for 5912 says the I2C clock
must be prescaled to be between 7 - 12 MHz [1]. The XOR input clock is
typically 12, 13 or 19.2 MHz. So we should have code that produces:

XOR Mhz	Divider	Prescaler
12	1	0
13	2	1
19.2	2	1

Then again the original old code produces something different too [2]...

I suspect the original code had some hw workarounds and and later code
may have a conversion bug somewhere :)

I suggest we keep the code as is for now since it's known to work on
all omaps, and then submit a follow-up patch later once we have
verified that that code based on the TRM works on all omaps.

Regards,

Tony

[1] http://focus.ti.com/general/docs/lit/getliterature.tsp?baseLiteratureNumber=spru681
[2] http://linux-omap.bkbits.net:8080/main/diffs/drivers/i2c/busses/i2c-omap.c@1.12?nav=index.html|src/|src/drivers|src/drivers/i2c|src/drivers/i2c/busses|hist/drivers/i2c/busses/i2c-omap.c
