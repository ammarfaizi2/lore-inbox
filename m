Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbVLWI2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbVLWI2J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 03:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030462AbVLWI2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 03:28:09 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:57446 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030459AbVLWI2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 03:28:08 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH 2.6-git] SPI: add set_clock() to bitbang
Date: Fri, 23 Dec 2005 00:28:03 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, spi-devel-general@sourceforge.net
References: <20051222180449.4335a8e6.vwool@ru.mvista.com> <200512221637.07895.david-b@pacbell.net> <43ABA27C.6020309@ru.mvista.com>
In-Reply-To: <43ABA27C.6020309@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512230028.03682.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >>No, suppose there're two devices behind the same SPI bus that have 
> >>different clock constraints. As active SPI device change may well happen 
> >>when each new message is processed, we'll need to set up clocks again 
> >>for each message. Right?
> >
> >Clock is coupled to chipselect/device.  When the bus controller
> >switches to the other device, it updates the clock accordingly.
> 
> Yeah, but chipselect is called on per-transfer basis what is likely to 
> be redundant for clock setting.

This is basic SPI protocol stuff ... chipselect activates once at
the start of a series ("message") of transfers, and deactivates
when the series completes.  It is NOT "per transfer" ... normally
it's active between transfers, as a basic protocol requirement.

There are exceptions related to cs_change, mostly so chipselect can
be dropped temporarily ... e.g. to terminate a protocol operation,
so the next one in that group can start; EEPROMs work that way.
But most devices keep chipselect active during the whole series
of transfers that make up a message.


> Per-message clock configuration is enough AFAIS.

It doesn't need to be reconfigured even that often; it's basically
once-per-device, except in rather exceptional case.

The controller does need to update its clock rate whenever it
starts talking to a different device, though.  Some devices max
out at 1 MHz, while others are happy at 40 MHz ... so when the
chipselect to one of those goes active, SCK has to match.


> >How exactly that's done is system-specific.  Many controllers
> >just have a register per chipselect, listing stuff like SPI mode,
> >clock divisor, and word size.  So switching to that chipselect
> >kicks those in automatically ... devices ignore the clock unless
> >they've been selected.
> 
> Hmm, usually clocks are configured for the bus not device.

Not a chance.  The clock is activated to talk to a given device;
and there's no requirement that all devices on the bus use the
same clock rate.  (If one chipselect gives access to a linked series
of devices, clearly they'll all need to be clocked alike.  But
that's not a bus, it's just a compound device ... like a big shift
register.)

I did my homework when putting that API together, and looked at
quite a few SPI controllers.  **Not one** of them forces all
their chipselets to use the same clock rate.

The closest thing to your description is the SSP hardware on PXA,
which doesn't _have_ the notion of device selection.  Chipselects
for SPI are layered on top of SSP, using GPIOs ... and, you may
have noticed in Stephen's PXA driver, updating the clock (and SPI
mode, etc) whenever the software starts talking to a new device.

- Dave

