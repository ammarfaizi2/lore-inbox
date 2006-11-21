Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030645AbWKUFvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030645AbWKUFvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030539AbWKUFvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:51:15 -0500
Received: from smtp2.mtco.com ([207.179.226.205]:14724 "EHLO smtp2.mtco.com")
	by vger.kernel.org with ESMTP id S1030645AbWKUFvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:51:14 -0500
Message-ID: <456293D4.2030103@billgatliff.com>
Date: Mon, 20 Nov 2006 23:51:16 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       jamey.hicks@hp.com, Kevin Hilman <khilman@mvista.com>,
       Nicolas Pitre <nico@cam.org>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
References: <200611111541.34699.david-b@pacbell.net> <200611201347.10331.david-b@pacbell.net> <45626E7F.8000100@billgatliff.com> <200611202107.00754.david-b@pacbell.net>
In-Reply-To: <200611202107.00754.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>But in general, no ... the general case is that GPIO controller(s)
>and pin muxing are two separate units in the silicon, and there's
>no one-to-one coupling possible.
>  
>

Not sure I believe that there's "no one-to-one coupling possible" 
anymore.  :)

In OMAP, as far as I can tell after skimming the datasheet (and being 
reminded why I avoid TI's microcontrollers!), someone has to set up the 
MUX so that a given GPIO can get to a specified pin.  And practically 
speaking, what's soldered to a pin is nearly immutable for a given board 
(or at least a particular revision; you won't change it in software 
anyway!).  So for sanity's sake the GPIO "resource manager" would have 
to refuse a request for a GPIO line assigned to a pin that had already 
been committed to something else, be it another GPIO line or a 
peripheral function.  So I think having the notion of a resource manager 
_at all_ implies that you're into some amount of MUX analysis/management 
on machines that have them.

Aside: You state that there are many-to-many possibilities.  In theory 
yes, but for OMAP and any other practical machine, no.  You never have 
an infinite number of pins or GPIOs, so even with some kind of radical 
"switch fabric" the number of unique combinations of GPIO+pin still 
would be bounded.  In the case of OMAP, it looks like most of the GPIOs 
can be assigned to one of two pins, and each pin can be assigned to one 
of two GPIOs.  So, "some-to-some".  :)

The "multiplexing" that I was wishing to leave out of the GPIO API was 
the part where you assign pins to peripheral functions *or* GPIO, a'la 
AT91.  The existing kernel code for that chip provides a number of 
functions to help board authors get all the routing and configuration 
right for each pin ("peripheral A function, or peripheral B, or GPIO?  
Input, or output?  Pullup resistor, or no?  Input filtering, or no?") 
(*).  I'm ok with not trying to consolidate that functionality in an 
arch-neutral GPIO-only API right now, since machines do that so differently.

But I was assuming all along that we were overloading the notion of a 
"gpio number" enumeration, such that each enumeration ultimately 
referred to a unique combination of GPIO+pin for the instant machine.  
And once you've got that, there's no reason why the underlying 
implementation couldn't assert the proper routing at the time a specific 
GPIO+pin was requested.  Maybe that's up to the individual authors as to 
whether they want to provide this in their implementations, or choose 
instead to leave out the MUX configuration and just map GPIO 
enumerations to physical GPIO line numbers (and hope for the best at 
runtime).  But I still don't see a reason why they shouldn't if they're 
willing to do the code.

Sorry to recycle on all of this again.  Maybe I'm just a slow learner, 
maybe I just was misunderstanding some of the terminology we were 
throwing around.  Maybe it's something else entirely.


* - Most of which was written by Dave Brownell.  Thanks!



b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

