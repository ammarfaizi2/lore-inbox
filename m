Return-Path: <linux-kernel-owner+w=401wt.eu-S965000AbWL1WFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWL1WFl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 17:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965005AbWL1WFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 17:05:41 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:35699 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965000AbWL1WFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 17:05:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=bLIISp+V8ErNT4BOlmRd5LkqRzkwBrNWYk1gL6vGLJcrM1qV69msmwiEYHZXe2jWRQus95uo9NiV4lmc2arolibwUUdnNQiv0fO75x09w/kiNpQeoWdBbRF+Mb/yS0YFgwLCkyAAnZf7Cbe8nOD5TdFly8EiOfwAsfQ5+id8RZA=  ;
X-YMail-OSG: 97KyPW0VM1kB9Cl1OZbCuHo2XLZUgLimQJdAlJTw25hpYuuRbp4dED4.xEaH4YuSc.sKwklUn2wcpNrdciHp7Zai58UJpVfvsYh5PonR28SzrXvTyk8RG0YF6xLhCndETDpNVTy9S_G5pqxV_cFDttK7IGig1G6f8tavtbWU_6H3bwr8IKtDI9S_SlO3
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 2.6.20-rc1 1/6] GPIO core
Date: Thu, 28 Dec 2006 14:05:36 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>,
       pHilipp Zabel <philipp.zabel@gmail.com>
References: <200611111541.34699.david-b@pacbell.net> <200612201308.41900.david-b@pacbell.net> <20061227174953.GB4088@ucw.cz>
In-Reply-To: <20061227174953.GB4088@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612281405.37143.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 9:49 am, Pavel Machek wrote:
> Hi!

Good afternoon.  :)


> > +Identifying GPIOs
> > +-----------------
> > +GPIOs are identified by unsigned integers in the range 0..MAX_INT.  That
> > +reserves "negative" numbers for other purposes like marking signals as
> > +"not available on this board", or indicating faults.
> > +
> > +Platforms define how they use those integers, and usually #define symbols
> > +for the GPIO lines so that board-specific setup code directly corresponds
> > +to the relevant schematics.  In contrast, drivers should only use GPIO
> 
> Perhaps these should not be integers, then?

Thing is, the platforms **DO** identify them as integers.


Go through OMAP, PXA, StrongARM chip docs ... what you see is
references to GPIO numbers, 0..MAX, and oh by the way those map to
bit offsets within gpio controller banks.

When they don't identify them as integers, as with AT91, AVR32, and
S3C -- all of which present GPIOs as a lettered bank plus a bit offset
within that bank, isn't that structure familiar -- then the Linux
platform support already #defines them as integers.  The naming matches
chip docs, the _numbering_ works much the same as on OMAP, PXA, etc.

Fortunately, only OMAP1 seems to have that ugly many-to-many mapping
between chip pins and GPIOs.  On other current platforms, once you
know the GPIO number you know the pin, and vice versa.  (That does
not matter to drivers at all -- only board setup code talks "pins",
everything else talks about functions such as "GPIO" -- but hairy
board setup code can be a frelling HUGE time sink/waste.)


> typedef struct { int mydata } pin_t; prevents people from looking
> inside, allows you to typecheck, and allows expansion in (unlikely) case where
> more than int is needed? ...hotpluggable gpio pins?

If some system wants that kind of infrastructure, it can easily
implement it behind this API.  There's the IDR infrastructure, for
example, to allocate integers and map them to "more than int" data
for internal uses.

I could very easily imagine platforms that support the spinlock-safe
accessors for the SOC-integrated GPIOs, e.g. numbered below N, and
have a more dynamic "plug in your own external GPIO controller" way
to support GPIOs on i2c expanders, multifunction chips, and suchlike;
with that plugin stuff built over IDR and structures with ops vectors.


> > +Spinlock-Safe GPIO access
> > +-------------------------
> > ...
> > +
> > +	/* GPIO INPUT:  return zero or nonzero */
> > +	int gpio_get_value(unsigned gpio);
> > +
> > +	/* GPIO OUTPUT */
> > +	void gpio_set_value(unsigned gpio, int value);
> > +
> > ...
> > +
> > +The get/set calls have no error returns because "invalid GPIO" should have
> > +been reported earlier in gpio_set_direction().  However, note that not all
> > +platforms can read the value of output pins; those that can't should always
> > +return zero.  Also, these calls will be ignored for GPIOs that can't safely
> > +be accessed without sleeping (see below).
> 
> 'Silently ignored' is ugly. BUG() would be okay there.

The reason for "silently ignored" is that we really don't want to be
cluttering up the code (source or object) with logic to test for this
kind of "can't happen" failure, especially since there's not going to
be any way to _resolve_ such failures cleanly.

And per Linus' rule about BUG(), "silently ignored" is clearly better
than needlessly stopping the whole system.


And for spinlock-unsafe cases, like I2C based GPIO expanders;

> > +Platforms that support this type of GPIO distinguish them from other GPIOs
> > +by returning nonzero from this call:
> > +
> > +	int gpio_cansleep(unsigned gpio);
> 
> This is ugly :-(. But I don't see easy way around...

Me either.  Folk said earlier they want an API that can get/set
both types of GPIO, mostly to support userspace tweaking/config APIs,
but the only way I can see to have one of those is to include a
predicate like gpio_cansleep() to distinguish the two types.

 
> > +GPIOs mapped to IRQs
> > +--------------------
> > +GPIO numbers are unsigned integers; so are IRQ numbers.  These make up
> > +two logically distinct namespaces (GPIO 0 need not use IRQ 0).  You can
> > +map between them using calls like:
> > +
> > +	/* map GPIO numbers to IRQ numbers */
> > +	int gpio_to_irq(unsigned gpio);
> > +
> > +	/* map IRQ numbers to GPIO numbers */
> > +	int irq_to_gpio(unsigned irq);
> 
> . Don't we have irq_t already? 

Nope.  Such a type would likely get in the way of lowlevel IRQ
dispatch code too ... 


> > +Those return either the corresponding number in the other namespace, or
> > +else a negative errno code if the mapping can't be done.  (For example,
> > +some GPIOs can't used as IRQs.)  It is an unchecked error to use a GPIO
> > +number that hasn't been marked as an input using gpio_set_direction(), or
> 
> It should be valid to do irqs on outputs,

Good point -- it _might_ be valid to do that, on some platforms.
Such things have been used as a software IRQ trigger, which can
make bootstrapping some things easier.

That's not incompatible with it being an error for portable code to
try that, or with refusing to check it so that those platforms don't
needlessly cause trouble!

If I submit a patch against 2.6.20-rc2-mm1 to address Russell's
dislike of irq_to_gpio() calls (as yet un-explained), I'll try to
remember to mention this platform-specific issue.


> if those outputs are really 
> tristates (wire-or or how you call it?)?

That's not tristate.  An example of wire-OR would be a signal that
any of three different sources could drive high, but nobody drives
low (except an external pulldown).  Contrariwise, and maybe much
more common because it's what I2C does, is a signal that any source
can drive low, but nobody drives high (except one external pullup).

In both cases, drivers can notice an interesting case:  the value
they read from the pin doesn't match what they expected, meaning
that some other component is driving the signal.

Those kinds of mechanism support bidirectional I/O on one pin.
Examples include the I2C clock stretch mechanism, and also its
multi-master arbitration; and ISTR card address assignment with
pure MMC (if anyone really uses that in bus mode).

- Dave
