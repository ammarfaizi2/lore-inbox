Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161415AbWKUVUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161415AbWKUVUG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWKUVTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:19:53 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:18876 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161369AbWKUVTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:19:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=T2YNqrColAbXWpiY+bUEWrPaEdPeMF7kfLNE/Ytbk5AyhSg/CkAB7VU39DQJPTMP1xTwBkc7+GwYmMxB6PJDEbszwm3zq3tH4qAZ1eVtX16oB3Es5Vprl4wa1w2y31doplSKAht1bnKjp8jALqz8jjo5ZO66UpQN+c3edEEIYMY=  ;
X-YMail-OSG: Dpdxj8AVM1kaZ8vhIlRnX8Yjf.8Wj401bm73I7ZJ5I_ErrxnVUnq6vB5Hm2X0Hr2QtqkfZm6QzDQq_Xf5mXC89QeDRzHoLttJUHv8SAjdMrP5r6Y6XdJemdk8OfPU6WMdr2GMLPG.eV_3FAOCHtdrHnG5LpUkMuEOOU-
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
Date: Tue, 21 Nov 2006 10:19:02 -0800
User-Agent: KMail/1.7.1
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       jamey.hicks@hp.com, Kevin Hilman <khilman@mvista.com>,
       Nicolas Pitre <nico@cam.org>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611202107.00754.david-b@pacbell.net> <456293D4.2030103@billgatliff.com>
In-Reply-To: <456293D4.2030103@billgatliff.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611211019.04603.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 9:51 pm, Bill Gatliff wrote:

> In OMAP, as far as I can tell after skimming the datasheet (and being 
> reminded why I avoid TI's microcontrollers!),

Microcontroller??  Hah!  That'd be MSP430, or AVR8, or an ARM7 ... when
it can run vmlinux, it seems far away from being a microcontroller!
Despite how long it can run on a teeny weeny battery.

You'd like OMAP2 better though, in terms of pin setup it's way nicer.
Each GPIO seems to correspond to a single pin.  Nobody much liked the
consequences of how OMAP1 did it.


> someone has to set up the  
> MUX so that a given GPIO can get to a specified pin.  And practically 
> speaking, what's soldered to a pin is nearly immutable for a given board 
> (or at least a particular revision; you won't change it in software 
> anyway!).

Yep; though there _is_ the model of "SOC-on-a-card" plugging into a
custom chassis (maybe an industrial app), as opposed to using custom
boards for everything.  Though if you think of the "board" as being
that whole chassis-plus-CPUcard assembly, it's still more or less
immutable as you described.


>      So for sanity's sake the GPIO "resource manager" would have  
> to refuse a request for a GPIO line assigned to a pin that had already 
> been committed to something else, be it another GPIO line or a 
> peripheral function.  So I think having the notion of a resource manager 
> _at all_ implies that you're into some amount of MUX analysis/management 
> on machines that have them.

That's a big "if".  There's no such "manager" right now, other than the
people designing a given board and putting Linux onto it.


> Aside: You state that there are many-to-many possibilities.  In theory 
> yes, but for OMAP and any other practical machine, no.  You never have 
> an infinite number of pins or GPIOs, so even with some kind of radical 
> "switch fabric" the number of unique combinations of GPIO+pin still 
> would be bounded.  In the case of OMAP, it looks like most of the GPIOs 
> can be assigned to one of two pins, and each pin can be assigned to one 
> of two GPIOs.  So, "some-to-some".  :)

My point was more that it's "not one-to-one".  And clearly a given system
will only use one mapping (Paul's comments aside) ... the issue is that
knowing you're using a particular GPIO doesn't mean you know what pin is
involved, and contrariwise that knowing what pin doesn't mean you know what
GPIO to use.

Yes it's a PITA ... and I've seen boards that needed to get re-spun because
the board desigersn goofed, with two different interfaces expecting to mux a
(different) pin to GPIO7.  Didn't get discovered till late since each of the
two interfaces worked fine by themselves; system integration testing found it.
I suspect that's one reason OMAP2 is different in how it does the pin setup!


> The "multiplexing" that I was wishing to leave out of the GPIO API was 
> the part where you assign pins to peripheral functions *or* GPIO, a'la 
> AT91.  The existing kernel code for that chip provides a number of 
> functions to help board authors get all the routing and configuration 
> right for each pin ("peripheral A function, or peripheral B, or GPIO?  
> Input, or output?  Pullup resistor, or no?  Input filtering, or no?") 
> (*).  I'm ok with not trying to consolidate that functionality in an 
> arch-neutral GPIO-only API right now, since machines do that so differently.

Yes, I think we're seeing agreement on that now.


> But I was assuming all along that we were overloading the notion of a 
> "gpio number" enumeration, such that each enumeration ultimately 
> referred to a unique combination of GPIO+pin for the instant machine.  

Well, none of the existing software does that, or has needed to.

To the extent that the $SUBJECT calls are just common syntax for
what many platforms are already doing, they all use the same notion
of a "gpio number" which doesn't reference pinout ... there's a
direct mapping to a bit in a gpio controller register, that's it.


> And once you've got that, there's no reason why the underlying 
> implementation couldn't assert the proper routing at the time a specific 
> GPIO+pin was requested.  Maybe that's up to the individual authors as to 
> whether they want to provide this in their implementations, or choose 
> instead to leave out the MUX configuration and just map GPIO 
> enumerations to physical GPIO line numbers (and hope for the best at 
> runtime).  But I still don't see a reason why they shouldn't if they're 
> willing to do the code.

They could; the GPIO numbers, and interpretation, are platform-specific.

 
> Sorry to recycle on all of this again.  Maybe I'm just a slow learner, 
> maybe I just was misunderstanding some of the terminology we were 
> throwing around.  Maybe it's something else entirely.

Who knows.  I thought you were most likely wishing everything was as
simple and straightforward as it is on AT91, AVR32, and OMAP2.  ;)

In the restricted context of GPIO numbers, I think it is.  And it might
even be practical to come up with a widely used pin mux API ... it's
just that significant platforms like OMAP1 would be unlikely to fit.

- Dave



> 
> 
> * - Most of which was written by Dave Brownell.  Thanks!
> 
> 
> 
> b.g.
> 
> -- 
> Bill Gatliff
> bgat@billgatliff.com
> 
