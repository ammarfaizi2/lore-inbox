Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422764AbWHEIbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422764AbWHEIbF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 04:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422765AbWHEIbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 04:31:05 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:516 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1422764AbWHEIbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 04:31:04 -0400
Date: Sat, 5 Aug 2006 10:31:13 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Komal Shah" <komal_shah802003@yahoo.com>
Cc: tony@atomide.com, David Brownell <david-b@pacbell.net>, r-woodruff2@ti.com,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <gregkh@suse.de>, i2c@lm-sensors.org
Subject: Re: [PATCH] OMAP: I2C driver for TI OMAP boards #3
Message-Id: <20060805103113.058ce8fe.khali@linux-fr.org>
In-Reply-To: <1154689868.12791.267626769@webmail.messagingengine.com>
References: <1154689868.12791.267626769@webmail.messagingengine.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Komal,

Your post ended up in my spam box once again... I really think you
should send your patches as text attachements (or inline) rather than
binary attachements. Using real names in To: and Cc: fields might help
as well.

> I have attached the updated patch, which addresses the most of review
> comments.

I'll review that new version later today, or tomorrow.

> >The comment is confusing, as this address is usually known as the
> >"slave address" in the I2C world. Masters don't need no address on an
> >I2C bus. "own" is not a very explicit parameter name, what about
> >"slave_addr"? Ideally this should be retrieved from platform_data too,
> >else you can't be sure you won't collide with a device on the bus.
> 
> >"0 for default" doesn't make sense, as the default is, by definition,
> >when the user doesn't speficiy anything. That this is internally coded
> >as 0 is an implementation detail user-space doesn't need to know.
> 
> Updated the comment and changed to slave_addr , and default is changed to "3".

Slightly better, though I still don't get why you worry setting an
address that will never be used.

> >> +		if (armxor_rate > 16000000)
> >> +			psc = (armxor_rate + 8000000) / 12000000;
> >> +		else
> >> +			psc = 0;
> 
> >Can you please explain this formula?
> 
> The OMAP core uses 8-bit value to divide the system clock (SCLK) and
> generates its own sampling clock (ICLK), and the core logic is sampled
> at clock rate of the system clock for the module, divided by (prescaler value + 1)

I should have been more precise, I guess. What surprises me are the
numbers themselves. It's frequent to see forumlae of the form
"a = (b + c/2) / c" to divide with proper rounding, but here you have
2c/3 instread of c/2. My question was more like: is it intentional, or a
typo? Also, with the code above, psc will never have value 1. The "if"
part will always compute to at least 2, and the "else" part to 0. Is
this OK?

> I think it is better to remove those lines and return error if length is zero.
> Is that ok?

Yes. This can be revisited later when/if someone finds a hack to work
around the problem.

> >> +	/* We have an error */
> >> +	if (dev->cmd_err & OMAP_I2C_STAT_NACK) {
> >> +		if (msg->flags & I2C_M_IGNORE_NAK)
> >> +			return 0;
> 
> >Couldn't you have other error bits set as well? I2C_M_IGNORE_NAK means
> >you can ignore OMAP_I2C_STAT_NACK, not other errors.
> 
> This is now being handled by first checking remaining errors first and then
> NACK. Is that ok?

Yes.

> >> +	r = omap_i2c_read_reg(dev, OMAP_I2C_REV_REG) & 0xff;
> >> +	dev_info(dev->dev, "bus %d rev%d.%d at %d kHz\n",
> >> +		 pdev->id - 1, r >> 4, r & 0xf, clock);
> 
> >This "- 1" is error prone IMHO.
> 
> Only if omap devices.c maintainer pushes the values less than one in device
> structure ;)

No, what I meant was rather that printing a bus number which differs
from the internal numbering might confuse the user at some point.

-- 
Jean Delvare
