Return-Path: <linux-kernel-owner+w=401wt.eu-S1753923AbWL2A2X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbWL2A2X (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 19:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753924AbWL2A2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 19:28:23 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57854 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753923AbWL2A2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 19:28:22 -0500
Date: Fri, 29 Dec 2006 01:27:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [patch 2.6.20-rc1 1/6] GPIO core
Message-ID: <20061229002752.GA3543@elf.ucw.cz>
References: <200611111541.34699.david-b@pacbell.net> <200612201308.41900.david-b@pacbell.net> <20061227174953.GB4088@ucw.cz> <200612281405.37143.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612281405.37143.david-b@pacbell.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Good afternoon.  :)

Good after-midnight :-).

> > > +Identifying GPIOs
> > > +-----------------
> > > +GPIOs are identified by unsigned integers in the range 0..MAX_INT.  That
> > > +reserves "negative" numbers for other purposes like marking signals as
> > > +"not available on this board", or indicating faults.
> > > +
> > > +Platforms define how they use those integers, and usually #define symbols
> > > +for the GPIO lines so that board-specific setup code directly corresponds
> > > +to the relevant schematics.  In contrast, drivers should only use GPIO
> > 
> > Perhaps these should not be integers, then?
> 
> Thing is, the platforms **DO** identify them as integers.

> Go through OMAP, PXA, StrongARM chip docs ... what you see is
> references to GPIO numbers, 0..MAX, and oh by the way those map to
> bit offsets within gpio controller banks.

Well. when you see (something) = gpio_number + 5 ... you most likely
have an error. That means that they are close to integers, but not
quite. I'd use

typedef int gpio_t;

...it also serves as a nice documentation.

> When they don't identify them as integers, as with AT91, AVR32, and
> S3C -- all of which present GPIOs as a lettered bank plus a bit offset
> within that bank, isn't that structure familiar -- then the Linux
> platform support already #defines them as integers.  The naming matches

Great, except that mechanism should not #define them but "enum gpio {
} " them...

> > inside, allows you to typecheck, and allows expansion in (unlikely) case where
> > more than int is needed? ...hotpluggable gpio pins?
> 
> If some system wants that kind of infrastructure, it can easily
> implement it behind this API.  There's the IDR infrastructure, for

No, that's a wrong way. I want you to admit that gpio numbers are
opaque cookies noone should look at, and use (something like)
gpio_t... so that we can teach sparse to check them.


> > > +The get/set calls have no error returns because "invalid GPIO" should have
> > > +been reported earlier in gpio_set_direction().  However, note that not all
> > > +platforms can read the value of output pins; those that can't should always
> > > +return zero.  Also, these calls will be ignored for GPIOs that can't safely
> > > +be accessed without sleeping (see below).
> > 
> > 'Silently ignored' is ugly. BUG() would be okay there.
> 
> The reason for "silently ignored" is that we really don't want to be
> cluttering up the code (source or object) with logic to test for this
> kind of "can't happen" failure, especially since there's not going to
> be any way to _resolve_ such failures cleanly.

You may not want to clutter up code for one arch, but for some of them
maybe it is okay and welcome. Please do not document "silently
ignored" into API.

> And per Linus' rule about BUG(), "silently ignored" is clearly better
> than needlessly stopping the whole system.

You are perverting what Linus said. "Do not bother detecting errors"
is not what he had in mind.. but perhaps it should be WARN() not
BUG().

> > > +Those return either the corresponding number in the other namespace, or
> > > +else a negative errno code if the mapping can't be done.  (For example,
> > > +some GPIOs can't used as IRQs.)  It is an unchecked error to use a GPIO
> > > +number that hasn't been marked as an input using gpio_set_direction(), or
> > 
> > It should be valid to do irqs on outputs,
> 
> Good point -- it _might_ be valid to do that, on some platforms.
> Such things have been used as a software IRQ trigger, which can
> make bootstrapping some things easier.
> 
> That's not incompatible with it being an error for portable code to

I believe your text suggests it _is_ incompatible. Plus that seems to
mean that  architecture must not check for that error...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
