Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266985AbTGQTD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 15:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269237AbTGQTD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 15:03:58 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:34567 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S266985AbTGQTCX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 15:02:23 -0400
Date: Thu, 17 Jul 2003 21:17:06 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20 RTC Timer bug
Message-ID: <20030717191706.GA29208@alpha.home.local>
References: <Pine.LNX.4.53.0307161626240.30604@chaos> <20030716211805.GB643@alpha.home.local> <Pine.LNX.4.53.0307170709080.682@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307170709080.682@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dick,

On Thu, Jul 17, 2003 at 07:25:39AM -0400, Richard B. Johnson wrote:
> On Wed, 16 Jul 2003, Willy Tarreau wrote:
> 
> > Dick,
> >
> > 0x71 is the DATA register ! The thing that modifies what you read from it
> > is the RTC clock itself, because seconds are stored at index 0x00 IIRC, which
> > is often assumed if you read without writing.
> >
> > maybe it's time to go to bed ? :-)
> >
> > Cheers,
> > Willy
> 
> It's so easy to kill the messenger instead of finding the problem.

My apologies Dick, I didn't notice your mention of the range (0 to 89) in your
original mail. I agree with you, it cannot (or at least, should not) be the
clock, so there's certainly something playing with it.

> Most modern RTC emulations will return 0xff when you read the index
> register at 0x70 because it's a write-only register. Therefore, to
> discover what it has been set to, one must read the data register at
> 0x71. If it increments at one second intervals from 0 to 59 (BCD) ,
> (you change the "%d" to "%x" to read BCD within that range), then
> the index register has left at 0. This is okay except that the
> time may get trashed upon power off.

I agree. This reminds me of two (broken ?) clocks I encountered about 4 years
ago. One of them would increment hours up to 99 if you set it by hand to
something bigger than 23, and after that, it stuck to 99. This clearly shows
the event-driven mechanism which jumps to zero if it changes to 24 ! The other
one was funnier : it would cycle into the tens you initialize it (it could only
increment tens from 0 to 1 then 2). So if you initialized it to 35, it could
run forever from 30 to 39, then 30. And if you set it to 25, it would run up
to 29, then jump to 20 and get back to something normal.

I don't remember if I played with seconds, though.

> In machines tested here, running linux-2.4.20, the value read from
> 0x71 increments from 0 to 99 with a few missing codes in-between so
> it's not possible to guess what it's been set to, maybe the
> 'B' register (status), then something else. That something else
> is the killer.

just a silly question : have you tried within vmware, or on other hardware ?

> When the power fails, most all systems running Linux will fail to
> restart because of CMOS corruption. You can easily check. Run linux,
> `init 1`, dismount drives, then pull the plug. Don't use the
> front panel power switch because, again, modern power supplies
> protect devices during 'normal' shutdown by using the reset
> circuitry.

I never noticed, but will probably try harder. I'm interested in such problems
because I use PC-based semi-embedded boxes at work. If this is the case, it
clearly shows that Linux continually modifies checksummed portions of the CMOS.

BTW, while I was playing with the hours>24, I noticed that both DOS and
Windows95 got a divide error during boot under such condition. That's what lead
me to the real problem in fact, because only Linux booted OK and I was
beginning scratching my head a lot.

Cheers,
Willy

