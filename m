Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751923AbWFLMgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923AbWFLMgd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:36:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751927AbWFLMgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:36:32 -0400
Received: from smtp-relay.dca.net ([216.158.48.66]:61154 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S1751923AbWFLMgc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:36:32 -0400
Date: Mon, 12 Jun 2006 08:36:26 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [PATCH] I2C: i2c_bit_add_bus should initialize SDA and SCL lines
Message-ID: <20060612123626.GA27429@jupiter.solarsys.private>
References: <m34pyyz0e1.fsf@defiant.localdomain> <20060609110546.GA26073@jupiter.solarsys.private> <m3lks4k5od.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3lks4k5od.fsf@defiant.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof:

> "Mark M. Hoffman" <mhoffman@lightlink.com> writes:
> > SCL and SDA must be pulled high by hardware.  If a driver inits to
> > setting them low, that's a bug in the driver.

* Krzysztof Halasa <khc@pm.waw.pl> [2006-06-11 00:27:14 +0200]:
> Thanks for your response.
> 
> The question is rather who inits the lines: a) the hw driver,
> b) the I2C algorithm driver.
> 
> With a) every hw driver has to know how to init them (duplicated
> code but there might be positive side).
> 
> With b) I2C algorithm driver inits the lines and hw driver
> doesn't worry about but it might have some limitations such
> as unknown SCL state.
> 
> I understand the current case is a) - right?

I think it should be, yes.

> The other question is _how_ to init the lines. There are 4 possible
> hardware initial conditions:
> 
>   SCL SDA
> a)  0   0 (outputs zeroed by default)
> b)  0   1 (uncommon but may be left in this state by previous operations)
> c)  1   0 (ditto)
> d)  1   1 (I/O lines configured as input by default)
> 
> The internal state of devices connected to the bus is potentially
> unknown. Some implementations just start with STOP to eliminate
> this problem, I don't know what Linux driver is supposed to do.

If you can read the line state, then yes... I would detect which of
the above four states you're in, and generate a STOP condition for
a, b, and c:

a) setscl(1), setsda(1)
b) setsda(0), setscl(1), setsda(1)
c) setsda(1)

If you can't read the line state... well, that's not actually a proper
I2C bus anyway.  At that point I suggest 'whatever works'.

But even if you need to generate a 'null transfer' (prohibited by spec)
to get reliable operation... that doesn't belong in the algorithm driver.

> (Other implementation I know are rather specialized and thus they
> know their hardware init state, Linux I2C algorithm handles many
> devices with potentially different initial state of hardware lines).
> 
> 
> To summarize questions:
> - is it the hw driver who has to init the bus
> - how to init the bus (depending on init state)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

