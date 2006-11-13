Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933060AbWKMVbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933060AbWKMVbP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933067AbWKMVbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:31:15 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:29908 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S933060AbWKMVbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:31:13 -0500
Date: Tue, 14 Nov 2006 06:30:11 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: David Brownell <david-b@pacbell.net>
Cc: Bill Gatliff <bgat@billgatliff.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Message-ID: <20061113213011.GA20507@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	David Brownell <david-b@pacbell.net>,
	Bill Gatliff <bgat@billgatliff.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <4558B71F.9020502@billgatliff.com> <20061113183811.GA19979@linux-sh.org> <200611131200.02032.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611131200.02032.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 12:00:01PM -0800, David Brownell wrote:
> On Monday 13 November 2006 10:38 am, Paul Mundt wrote:
> > They're something that has to be accounted for in any sort of API, or we
> > just end up throwing it all out and starting over again. I was thinking
> > more of the SuperIO or mfd device scope, where this _is_ a requirement.
> 
> Could you elaborate on these SuperIO and MFD thingies?  Especially with
> reference to my point that multiple controllers *are* allowed, and that
> this is just a platform-specific issue?  (As shown by the fact that the
> API works fine with OMAP1, accessing both GPIO and MPUIO controllers
> through those API calls ...)
> 
I think we're talking past each other but effectively in agreement. Bill
was suggesting that multiple controllers were out of scope for the
proposal, which is what I was objecting to. If the API is handling a GPIO
cookie and allows for multiple controllers, I have no objections.

> ... pin mux is 100% out of scope for managing/using GPIOs, since pin
> mux kicks in for pins that aren't even GPIO-capable ...
> 
I disagree. Pin muxing kicks in for pins that aren't GPIO-capable, but
for many cases GPIO-capable is just another pin state that can be handled
via muxing. Pin refcounting is obviously not within the scope of your
proposed API (nor should it be), but we do need to allow for pin muxing
to be reconfigured in the GPIO case if nothing else is using the pin in
question that the GPIO maps to. Most of this will be platform specific
and layered, though.

> On the contrary, keeping board-specific pin configuration code out of
> otherwise generic/portable device drivers is a Very Good Thing.  And
> that primarily means moving that code into platform/board specific
> setup code.  (Today's Linux doesn't have other places to put such code,
> especially if you don't want to demand much from typically-sluggish
> boot loader teams.)
> 
This is exactly the sort of static configuration I was referring to.

> >	 since it's ultimately up to the system and driver 
> > inserted at the time to grab and configure the pin as necessary, the
> > board or CPU code is not going to have any notion of the "preferred" pin
> > state, especially in the heavily muxed case.
> 
> I don't see this either.
> 
> In the primary "production board" use case, there is absolutely a "preferred"
> pin mux config state:  each pin is connected to one peripheral in one way.
> And typically its configuration is never changed; if it is, that's something
> the pin mux API would need to handle.  (One example:  using a UART's RXD
> pin as a wakeup GPIO while the system sleeps.  Presumably there are others.)
> 
Your definition of "typical" seems to vary considerably from mine. The
typical case more and more is having multiple functions per pin, where a
GPIO state is just another function. If muxing happens within the board
setup code, then we've already effectively locked out the other
functions. This is also not something that can be resolved at build time.

For example, I happen to have a UART RX and an MMC DMA request on the
same pin (GPIO-configured for certain implementations). Both of these can
be provided as modules for a "production" board where the pin can then be
grabbed and toggled depending on which module is inserted, doing any sort
of pin setup on the board side will not help in this case, it's something
that needs to happen higher up.
