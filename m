Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755246AbWKMUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbWKMUAK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755247AbWKMUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:00:10 -0500
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:33393 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755246AbWKMUAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:00:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=2wnFsFkPXOs8Lqc+8PtDFya/5mIzM+WmEamtiNlnXPGAZFOFVsf6ZRyu7vrl/Yf3l/gBPlKbG/hX5V8rkcWhwE67HBrcEFeWwaBptIJoXypMb9x9Uwv9womMZMJUB+OnbvNBcsmjuv+hXddguBJ7asvXdvfcxbMiKB+3pLUt9EU=  ;
X-YMail-OSG: 8iYl6KoVM1kp4MSyeQZOV9q6_I1i0DG8R5KykDi5.mf5tAmA.aO.4XTsCqNj2qGYlpvtu1kBCxfcFwTq5z1KqNY90JWM1qrjbmkfUtXMQI9Gxj2HbbpNYxHstpar03YvD5HBzsEUE6SWhqlnJRK6qZcrNUWJQu.Adn8-
From: David Brownell <david-b@pacbell.net>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 13 Nov 2006 12:00:01 -0800
User-Agent: KMail/1.7.1
Cc: Bill Gatliff <bgat@billgatliff.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <4558B71F.9020502@billgatliff.com> <20061113183811.GA19979@linux-sh.org>
In-Reply-To: <20061113183811.GA19979@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131200.02032.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 10:38 am, Paul Mundt wrote:
> On Mon, Nov 13, 2006 at 12:19:11PM -0600, Bill Gatliff wrote:
> > True, but right now if the "multiple GPIO controllers" are on something 
> > like i2c/spi, they have the synch/asynch issues that Jamey mentioned and 
> > so are by definition out of scope for this proposal.  If the GPIO lines 
> > are in an MMIO controller (PLD/FPGA, perhaps), then there's no reason 
> > that the board implementer couldn't address that in their implementation 
> > of the proposed functions.
> > 
> They're something that has to be accounted for in any sort of API, or we
> just end up throwing it all out and starting over again. I was thinking
> more of the SuperIO or mfd device scope, where this _is_ a requirement.

Could you elaborate on these SuperIO and MFD thingies?  Especially with
reference to my point that multiple controllers *are* allowed, and that
this is just a platform-specific issue?  (As shown by the fact that the
API works fine with OMAP1, accessing both GPIO and MPUIO controllers
through those API calls ...)


> > ... except that I bet David is thinking that the implementations will be 
> > in arch/arm/irq-at91rm9200.c or something, and not in 
> > asm/arm/board-xyz.c, so it's the arch implementer's responsibility and 
> > not the platform author's.  Yea, I see your point now.
>
> The problem with this is that it gets in to something that's getting
> close to static pin state configuration.

I really don't see this at all (see previous email).


>	 Setting up the mux

... pin mux is 100% out of scope for managing/using GPIOs, since pin mux kicks
in for pins that aren't even GPIO-capable ...


>	 from platform code is brain-damage,

On the contrary, keeping board-specific pin configuration code out of otherwise
generic/portable device drivers is a Very Good Thing.  And that primarily means
moving that code into platform/board specific setup code.  (Today's Linux doesn't
have other places to put such code, especially if you don't want to demand much
from typically-sluggish boot loader teams.)


>	 since it's ultimately up to the system and driver 
> inserted at the time to grab and configure the pin as necessary, the
> board or CPU code is not going to have any notion of the "preferred" pin
> state, especially in the heavily muxed case.

I don't see this either.

In the primary "production board" use case, there is absolutely a "preferred"
pin mux config state:  each pin is connected to one peripheral in one way.
And typically its configuration is never changed; if it is, that's something
the pin mux API would need to handle.  (One example:  using a UART's RXD
pin as a wakeup GPIO while the system sleeps.  Presumably there are others.)

The only situation where there might not be a "preferred" mode is very much
a secondary use case:  the "development board", used to hook up many different
kinds of peripheral hardware.  Even in those cases, it makes perfect sense
for Kconfig options to define the _current_ "preferred" mode -- these pins
get muxed for the peripheral that's actually connected today, rather than the
one that we developed two months ago.  Because those drivers being developed
are going to be used with a "production board", where costs incurred for
dynamic configuration are undesirable...


> > I say that we go with David's proposal for 2.6.19 anyway, and maybe by 
> > 2.6.20 we'll have a consensus on how to address that with some 
> > behind-the-API magic.  :)  (functions added to the machine descriptor, 
> > maybe?)
>
> This is all too late for 2.6.19 regardless. We've gone this long without
> a generic API,

I'd be surprised to see it in 2.6.19, but that's what the patch is against;
though I'd not say it's "too late" in any absolute sense, it's certainly a
small and safe enough change (and bigger changes have gone in later).


> I see no reason to merge a temporary hack now if it's not 
> going to be satisfactory for people and require us to throw it all out
> and start over again anyways.

You've not shown any technical problems with the proposal though; nothing
about it is a "temporary hack".  The functionality in it is clearly
satisfactory enough to work for at least a dozen different platforms,
which are now using similar code.  I don't see why you're so negative...

 
> I have a real need for supporting multiple controllers and handling
> muxing dynamically from various drivers on various architectures, and
> anything that exposes the pin # higher than the controller mapping to
> function level is never going to work. Drivers have _zero_ interest in
> pin #, only in the desired function.

Sure, so what's the problem you have with this then?  It doesn't expose
pin numbers, just GPIO numbers.  It allows platforms to support multiple
controllers.  It doesn't even get in the way of whatever wierd pin mux
setup any given platforms needs.  You should be applauding!

- Dave

