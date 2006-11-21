Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934302AbWKUEpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934302AbWKUEpR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 23:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934306AbWKUEpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 23:45:17 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:30135 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S934302AbWKUEpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 23:45:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=v3+OeMbQ5VPvkhkMF6NBGx8wTiLMz5U55oNik+8/0gJxVHwVIrRs4zfL7NOsM7lk/9ji68sQSTD5h4yXuYG3cGq5wYScW8h0vTf6B0pUN/Rzkmxa5hqVRRqJwOLRUr8t9JMopPwJTGF7RbZ2KFt+5eEztnQ1vdC226PplcNuKkc=  ;
X-YMail-OSG: XrsLRAwVM1kbdAk7ae4.kXbvQjAk0hF59NEDJ2I.lIrt36zCOVoZY7mD_TGcHtmdsPsJiXPmyAGKIKOcvDl0y3LeCtg1P9vnOUksq0WRxudi8fepbngLnQ--
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 20 Nov 2006 20:45:07 -0800
User-Agent: KMail/1.7.1
Cc: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611201349.29999.david-b@pacbell.net> <4562760E.3000906@billgatliff.com>
In-Reply-To: <4562760E.3000906@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202045.09760.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 7:44 pm, Bill Gatliff wrote:
> David Brownell wrote:
> 
> >A fine example of two platform-specific notions.  First, that GPIO signals
> >are muxed in that way ... they could easily have dedicated pins!!  Second,
> >that there's even a one-to-one association between pins and GPIOs ... I'll
> >repeat the previous example of OMAP1, where certain GPIOs could come out on
> >any of several pins.  And where some pins can be muxed to work with more
> >than one GPIO (but only one at a time, of course).  Clearly, neither pin
> >refcounting nor GPIO claiming can be sufficient to prevent such problems ...
> >
> 
> So, you're saying that if GPIOA1 can come out on pins ZZ1 and BB6, then 
> there would be two unique "GPIO numbers", one for each possibility?

No; one number, since it's controlled by the same set of bits in the GPIO
controller (e.g. bit 12 in the registers of bank 3) regardless of how the
signals are routed out through pins.  That's my point:  GPIO number need
not imply a particular pin, and vice versa.


Have a look at table 2-5 starting on page 81 of the OMAP 5912 datasheet
("Rev E", omap5912.pdf) linked at the top of

   http://focus.ti.com/docs/prod/folders/print/omap5912.html

GPIOs start at p. 91; there are four banks of GPIO controllers, 16 gpios
each, and also a bank of MPUIOs starting at p. 95 ... half the MPUIO pins
can come out on two different balls, some of the GPIOs can be routed to any
of three different balls.  (A omap5912 is more or less an omap1611, fyi.)


So regardless of whether GPIO_62 is routed to ball M7 or G20, it's still
going to use number 62, which is bit 14 in various registers of the GPIO4
module, starting at 0xfffbb400 ... and for good fun, the muxing API will
refer to the balls on the (smaller) ZZG package even if your board uses
the larger ZDY package (so your schematics might say J5 not M7, that table
is very handy in such cases).

And if you consult table 2-2 on pg. 33 you'll be able to notice things
like ball R13 working for either MPUIO_0 or GPIO_36, ball V10 working
for MPUIO_10 or MPUIO_7, and so on.

- Dave


