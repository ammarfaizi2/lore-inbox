Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbUL1RVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbUL1RVD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 12:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUL1RVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 12:21:03 -0500
Received: from smtp-102-tuesday.nerim.net ([62.4.16.102]:38930 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261192AbUL1RUt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 12:20:49 -0500
Date: Tue, 28 Dec 2004 18:22:29 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Philip Pokorny <ppokorny@penguincomputing.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
Subject: Re: [RFC] I2C: Remove the i2c_client id field
Message-Id: <20041228182229.67fc14e8.khali@linux-fr.org>
In-Reply-To: <41D18B9E.2080706@penguincomputing.com>
References: <20041227230402.272fafd0.khali@linux-fr.org>
	<41D0942B.8020109@penguincomputing.com>
	<20041228114258.35e9b5b7.khali@linux-fr.org>
	<41D18B9E.2080706@penguincomputing.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

> > Although this is a real use of the id, it only
> > matters if you use the module parameters for GPIO pins
> > reconfiguration and actually have more than one ADM1026 chip (a
> > quite rare chip if you remember).
>
> Not for me.  We ship hundreds of systems each month with a
> motherboard with that chip on it.  I think it's actually on two
> different motherboards we sell.

The two motherboards with ADM1026 I know of are (actually thanks to the
MBM site):
Iwill DK8S2
Accelertech HDAMA

I think I remember you ship HDAMA boards, right? Well, there must be a
reason why you (Penguin Computing) wrote the driver in the first place
and recently ported it to 2.6.

What I want to insist on is that, contrary to other chips which are used
on a wide range of different boards, the ADM1026 isn't so we can
concentrate of the specific use it has on these boards instead of
writing a full-featured driver.

> Wouldn't a force_xxx parameter cause a specific bus/id to be probed
> and  assigned first?

Ah, good question. Checking...

Hm, no it doesn't. The module parameters change the decision taken by
i2c_detect on each adapter/address combination, but doesn't affect the
order in which the chips are detected.

> > and I am not sure why one would want to reprogram only the
> > first chip. Unless someone comes with such a specific hardware setup
> > so that we can examine what is really needed,
> >

> Well, that's exactly the problem that I had.  The motherboard vendor's
> BIOS didn't set the chip up and I had to program it myself.  I got the
> schematics from the vendor for the part of the motherboard attached to
> the chip so that I could program it correctly.

Side note, it would probably be better to insist that the vendor should
fix the BIOS instead. Especially if you ship hundreds of these chips
each months, I guess you have some weight when asking them something.

Does you board really have 2 ADM1026 chips and only one needed
reprogramming?

> > I think we can get rid of the
> >"id == 0" test and reconfigure "all" ADM1026 chips (which really is
> > only one for the two known boards using an ADM1026).
>
> I think that would be a bad idea.  Reprogramming any chip is generally
> a  bad idea (as we can see from the recent removal of all the init
> code) and forcing any specified config to apply to all chips found in
> the system would be an even worse idea.

Agreed, but...

> I think a better idea that addresses your concerns about bus ordering 
> would be to add an additional parameter that is a bus/chip number
> pair which is the chip to initialize.  Something like:
> 
> static int gpio_target[2] = { -1, -1 }
> MODULE_PARM(gpio_target, "2i");
> MODULE_PARM_DESC(gpio_target,"Address of chip to whose GPIO is to be 
> programmed");
> 
> This would be similar to the bus/address pairs used in the 
> force_subclient parameters to the w83781d driver.

True. But again, do you have boards with *2* ADM1026 chips? Until
someone points out one boards which does, I see no benefit in
implementing this module parameter.

One question BTW, why don't you simply reprogram the chip(s) with i2cset
before loading the driver? That would save some kernel memory, and
solves the problem altogether.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
