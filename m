Return-Path: <linux-kernel-owner+w=401wt.eu-S1753748AbWLWUj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753748AbWLWUj4 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 23 Dec 2006 15:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753743AbWLWUj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Dec 2006 15:39:56 -0500
Received: from smtp104.sbc.mail.mud.yahoo.com ([68.142.198.203]:28850 "HELO
	smtp104.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753747AbWLWUjz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Dec 2006 15:39:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=ATPjVVk1a/MXs9A3AGTSH+X7YvSbH8CXOdOzBBgif/dCYL2GvaQlA73ow5SemUnfPtzWLxzt/tAkv8pVUT4b35NcunnrzA85rI1uig2HWbUpQalmcUSWOlkdlfk1MSfgzRhzn7Ff1BIeVlY6tbug+mh1B94U4QK1Z/xXomB3ni4=  ;
X-YMail-OSG: l2ZFbQUVM1mvGT4CCr8iViYU6gZiixL72vW18ltMDLYNoHEwoX_pbSqQH5zZiofKTwx0mTqlDYoBOzN3a3Q3m3hrtaq_4LC3LE8jtLKZiu_Sbqis5AUTE9ucgNHxRPVMPnCM6FSdJhpNG8.KxajykXriCpAMqw6KfRHj6oGxRtIADyoIXuXDEGIGD_b9
From: David Brownell <david-b@pacbell.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 2.6.20-rc1 5/6] SA1100 GPIO wrappers
Date: Sat, 23 Dec 2006 12:39:50 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201313.22572.david-b@pacbell.net> <20061223113752.GA28306@flint.arm.linux.org.uk>
In-Reply-To: <20061223113752.GA28306@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612231239.52285.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 December 2006 3:37 am, Russell King wrote:

> Why do we need to convert between IRQ and PGIO numbers?

(I take it that's the only real issue you had with this patch, other
than maybe excessive #includes?)


I suppose we could do with a one way mapping:  GPIO-to-IRQ, then
require drivers map the other way themselves when they need to.
As they must do with DMA addresses.

Having that GPIO-to-IRQ mapping is quite routine; and necessary.

On the other hand, since it's a (small) one-to-one mapping, I don't
see any real issue with defining how to access it in both directions.
I can tell one direction (IRQ-to-GPIO) bothers you ... but not why.


> When the interrupt system is asked to claim a IRQ corresponding to a
> GPIO, it should deal with all the stuff necessary to ensure that the
> GPIO is in the required state.

IRQ framework can't do "all" the needed stuff on platforms (like OMAP1)
where knowing the GPIO (presumably from a private IRQ-to-GPIO mapping??)
doesn't tell you what pin to set up, or how.  Such setup needs to be in
place *before* request_irq() is called.  The genirq irqchip.startup()
call could potentially sanity check whether a GPIO is configured as an
input, but couldn't handle pin muxing or pullup/pulldown config; and
I'd argue it shouldn't try to change anyt of that, since it's an API
for managing IRQs not for pin configuration.


> 	are we expecting to add GPIO
> support to all Linux drivers which could possibly be used on ARM, just
> because their interrupt pin might possibly be connected to a GPIO?

I'd expect board-specific setup code to pass gpio_to_irq(gpio_num) to
drivers when the _only_ thing that matters is its IRQ-ness.  And to
have previousy set up the relevant pin as a GPIO input ... so that most
drivers would just see an IRQ, much like any other irq.

That's what most of them do now, I didn't propose changing any part of
that except defining a standard way to write the GPIO-to-IRQ mapping.


The overall goal is basically to let drivers which know they've got a
GPIO have a standard way to use it ... in the previous situation, the
lack of such a portable API means those drivers must be (needlessly)
platform-specific.


> This is NOT 
> something that drivers should even care about - it's something that the
> interrupt subsystem should know when being asked to claim an GPIO-based
> IRQ.

It's admittedly uncommon that drivers care about IRQ-to-GPIO, but it's
not a "never" thing.  Drivers often need to care more about the exact
state of the signal than "IRQ triggered a while back"; and that means
some kind of IRQ-to-GPIO mapping.

Examples: systems that only have "both edges" triggering, where the
hardware signal is level triggered; or the supported triggering modes
are otherwise not a good match for an external chip.  State when the
driver starts up may need to check signal level directly, when the
IRQ must use edge triggering.  Also, disabling an IRQ at the source
(vs. unsharably masking it in the local IRQ controller) can sometimes
take much of a millisecond because of I2C or similar delays, making
it likely that signal state changed since the irq triggered.  Oh, and
the reverse mapping could also be useful for diagnostics.


> Get real - if you're dealing with IRQs use _only_ IRQ numbers.  Don't
> even think that drivers should be able to convert between IRQ and GPIO
> numbers.

I was being real, and I gave some examples above where drivers need to
be able to detect the actual signal level.

On the other hand it'd also be practical to force drivers to do that
mapping from IRQ (they probably only handle a few!) to GPIO, when they
need to do that, if they're given a GPIO number directly.  Then they'd
just use the GPIO-to-IRQ mapping to request the IRQ (already a common
idiom) and directly access the gpio state.

- Dave

