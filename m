Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933186AbWKNDVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933186AbWKNDVo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 22:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933188AbWKNDVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 22:21:43 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:25004 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S933186AbWKNDVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 22:21:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=E9cr0KOvWooOV/0f9JM7gGXBicKVxsFG58xhAVZnZ/QDmmgJIsDO7DguUuxO32nOv+KUI4BwFUJ/Uf5rY+dSETH38qwbbJUP9Eu9JxDAIenN0wKoG/ckKhRJGQb18e+iT0pbcS1VfnrtfplEWGm/UWIQKCnreCIJon5c+oP7qGc=  ;
X-YMail-OSG: xWpNl.AVM1n6AnceFwtQ0reHsyA744qH_2eSTlk0GOeMj_M3cgOdQBLyAd9tHwgBxtsWWnWvChqic9S8VTNvZBvKg5TUGOAA9T2elrMMnlqqihfpUBYDu60GELSKDU9wmpMHk7XkLpkzJa2dHlL5mMeA5cVNCmXC.wY-
From: David Brownell <david-b@pacbell.net>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 13 Nov 2006 19:21:37 -0800
User-Agent: KMail/1.7.1
Cc: Bill Gatliff <bgat@billgatliff.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611131200.02032.david-b@pacbell.net> <20061113213011.GA20507@linux-sh.org>
In-Reply-To: <20061113213011.GA20507@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131921.37737.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 1:30 pm, Paul Mundt wrote:
> I think we're talking past each other but effectively in agreement. Bill
> was suggesting that multiple controllers were out of scope for the
> proposal, which is what I was objecting to. If the API is handling a GPIO
> cookie and allows for multiple controllers, I have no objections.

It's out of scope in the sense that it doesn't say "here's how to do it".

But it's in-scope in that what it _does_ say makes sure it can be done;
the example implementation does it.


> > ... pin mux is 100% out of scope for managing/using GPIOs, since pin
> > mux kicks in for pins that aren't even GPIO-capable ...
> 
> I disagree. Pin muxing kicks in for pins that aren't GPIO-capable, but
> for many cases GPIO-capable is just another pin state that can be handled
> via muxing.

So?  You're still confusing GPIOs with pins/balls.  They're quite distinct,
in the general case, though maybe not on SH?

Some balls can be used for multiple GPIOs, some GPIOs can be mapped to one
of several balls... there's no general way to infer mux data from knowing
what GPIOs are needed.


> Pin refcounting is obviously not within the scope of your 
> proposed API (nor should it be), but we do need to allow for pin muxing
> to be reconfigured in the GPIO case if nothing else is using the pin in
> question that the GPIO maps to. Most of this will be platform specific
> and layered, though.

Well, especially since it will be platform-specific, it can't really
be part of the GPIO framework.  I'll repeat the example of OMAP1,
which lets some GPIOs come out on multiple pins ... pin configuration
and GPIOs really **must** be orthogonal.  There is just no way to
infer the right mux setup even given a complete list of GPIOS that
will be used.  Ditto pullup/pulldown config, multi-drive options,
and so forth.

But it's straightforward to talk about "use <this GPIO> as an input",
and "set <this output GPIO> to high".  That doesn't require any
knowledge of how the pins are configured, and is a model that works
with every GPIO controller ever built.


> > >	 since it's ultimately up to the system and driver 
> > > inserted at the time to grab and configure the pin as necessary, the
> > > board or CPU code is not going to have any notion of the "preferred" pin
> > > state, especially in the heavily muxed case.
> > 
> > I don't see this either.
> > 
> > In the primary "production board" use case, there is absolutely a "preferred"
> > pin mux config state:  each pin is connected to one peripheral in one way.
> > And typically its configuration is never changed; if it is, that's something
> > the pin mux API would need to handle.  (One example:  using a UART's RXD
> > pin as a wakeup GPIO while the system sleeps.  Presumably there are others.)
>
> Your definition of "typical" seems to vary considerably from mine.

Maybe.  I'm looking at the type of clearly defined system for which
Linux has good support:  one board, or a standard board stack; or
sometimes there's PCI-ish autoconfiguration on an expansion bus.


> The 
> typical case more and more is having multiple functions per pin, where a
> GPIO state is just another function.

Sure, but that's exactly what I've been saying and isn't in conflict with it.


> If muxing happens within the board 
> setup code, then we've already effectively locked out the other
> functions. This is also not something that can be resolved at build time.

See above; if the system is clearly defined, it _can_ be resolved then.
Or at worst, by some platform-specific autoconfiguration scheme.

 
> For example, I happen to have a UART RX and an MMC DMA request on the
> same pin (GPIO-configured for certain implementations). Both of these can
> be provided as modules for a "production" board where the pin can then be
> grabbed and toggled depending on which module is inserted, doing any sort
> of pin setup on the board side will not help in this case, it's something
> that needs to happen higher up.

You're bringing in a new problem though:  autoconfiguring a board stack.

The classic approach is to formalize the module bus and teach that bus how
to enumerate according to the "hotplug" model (like PCI, PNP, etc) ... for
example, consulting an I2C EEPROM with board IDs, with the EEPROM address
depending on which slot it's plugged in to.  At the moment you know what
boards are connected, surely you know how to mux those pins ... and what
devices to register, etc.

That's another set of problems that's nicely distinct from GPIOs.  :)

- Dave

