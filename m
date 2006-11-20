Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966872AbWKTWQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966872AbWKTWQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 17:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966868AbWKTWQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 17:16:09 -0500
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:46423 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S966860AbWKTWPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 17:15:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=wE0oyPZSnPnNqK9mq6/M1g9ZBQIY4WgmQXICchemu4XtofZfakFGYHBs/5AL74g94g0dVtQ70PHosocnPiJw78IAqsDuj+tiTTZL95ZjCCl4NOmgSHbHBgTV1qxdZe11Gkw0VXWiTzoGkXDgBiIHma3nLc0rAP7tyisqiBCeOro=  ;
X-YMail-OSG: kisshc8VM1l8UQNT.2BvB_SGTO4E9JyEmEwrs8aDmZ.amaPfswKUCHciR709vKMEZxiqvN3pgnH_P1TDEem9Ri5qt695mz.SpcPWYNQeZbQ7S55JUFYlSbkBvK9HRrgUqaj19CBE2tYXavUg93bjZ2tcIqcYHBHqb98-
From: David Brownell <david-b@pacbell.net>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 20 Nov 2006 13:49:28 -0800
User-Agent: KMail/1.7.1
Cc: Bill Gatliff <bgat@billgatliff.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <4558C794.90602@billgatliff.com> <20061113201535.GA20388@linux-sh.org>
In-Reply-To: <20061113201535.GA20388@linux-sh.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611201349.29999.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 12:15 pm, Paul Mundt wrote:
> On Mon, Nov 13, 2006 at 01:29:24PM -0600, Bill Gatliff wrote:
> 
> Pin muxing is somewhat of a decoupled issue,

I'll continue to read that as "100% orthogonal to any GPIO API since it's
so thoroughly platform-specific".  :)


>	 but it's quite related when 
> "GPIO" is just another pin state depending on the mux. The primary
> concern here is where we end up doing the refcounting for the pins, so we
> don't run in to a situation where a pin is toggled out from an existing
> user with regards to drivers contending for pin functions. 

A fine example of two platform-specific notions.  First, that GPIO signals
are muxed in that way ... they could easily have dedicated pins!!  Second,
that there's even a one-to-one association between pins and GPIOs ... I'll
repeat the previous example of OMAP1, where certain GPIOs could come out on
any of several pins.  And where some pins can be muxed to work with more
than one GPIO (but only one at a time, of course).  Clearly, neither pin
refcounting nor GPIO claiming can be sufficient to prevent such problems ...


Another issue that's orthogonal to a GPIO API is IRQ trigger modes:

> > Think: today, most drivers don't know or care if an IRQ line is
> > edge-triggered or level-triggered.  That code is in the domain of the
> > IRQ subsystem.  What David is proposing is the same sort of thing for
> > GPIO.
> > 
> I would suggest that it's exactly the opposite, other than the blatantly
> obvious cases (edge-triggered NMI, controllers with fixed detection
> logic, etc.) it's _specifically_ up to the drivers to indicate where to
> do the detection, as to allow the IRQ controller to adjust the sense
> selection for that particular IRQ. Grepping drivers/ for IRQF_TRIGGER is
> a pretty good indicator of this.

It's easy to think that way, but then it's just as easy to assemble boards
that happen to route IRQs through an inverting buffer because of signal
level or strength issues.  And with discrete controllers, I've certainly
had to cope with drivers running on systems that don't support the ideal
triggering mode ... typically there'd be an edge trigger mode (e.g. only
"both edges" supported) for a chip whose IRQ is active low.

It's better to make the board setup include the right IRQ triggering mode
for each IRQ, so that drivers don't have to embed board-specific knowledge
like that.  It's bad enough to have to write the driver to cope with some
unnatural trigger mode ... but it's really rude to make them have to try
guess several times before they can find which one works!!

Boards can pass the IORESOURCE_IRQ_* flags in irq resources, though it
seems not many do.

- Dave

