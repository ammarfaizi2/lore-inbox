Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934383AbWKUP5d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934383AbWKUP5d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934391AbWKUP5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:57:33 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:958 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S934383AbWKUP5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:57:32 -0500
Message-ID: <456321E9.2030308@billgatliff.com>
Date: Tue, 21 Nov 2006 09:57:29 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <200611202045.09760.david-b@pacbell.net> <45628A1A.8060101@billgatliff.com> <200611202135.39970.david-b@pacbell.net>
In-Reply-To: <200611202135.39970.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>On Monday 20 November 2006 9:09 pm, Bill Gatliff wrote:
>  
>
>>Why not have GPIO numbers refer to unique combinations of GPIO+pin? 
>>    
>>
>
>That sounds unduly complicated compared to just using the GPIO numbers
>which are used throughout the hardware and software docs.
>

Yes, and no.  On OMAP, they are indeed GPIO<m>-<n>.  On XScale they're 
GP<m>-<n>.

On AT91, they're P[ABCD][0-31].  On AVR32, they're P[ABCDE][0-31].  For 
AU1500 (MIPS), they're GP[0-215], with a lot of holes--- there are only 
48 lines actually available.  On MPC885 (PowerPC), they're 
P[ABCDE][random(0,31)].

Ok, I stretched the truth on that last one just a bit.  :)  Point is, 
many machines don't have a concept of a "gpio number" except within the 
context of a specific PIO controller.  On OMAP, apparently all the PIOs 
live in a unified space; on lots of other machines, they're organized 
differently, e.g. four independent spaces (controllers), each of which 
has 32 lines.  The only consistent theme is that there's no consistent 
theme.

I totally agree with you that the name assigned to GPIOs need to map as 
closely as possible to the names used in datasheets.  For OMAP, those 
names can map one-to-one to integers.  For AT91, something like this 
might work better:

    enum {PIOA0 = 0, PIOA1 = 1, ... PIOB0 = 32, PIOB1 = 1, ... PIOC0 = 
64, PIOC1 = 65, ...};

So the "gpio number" in AT91 would, as it turns out, also encode the 
line number in the lower 6 bits, and the controller number in the bits 
above that.

Once you're hiding the GPIO number behind an enumeration, you can create 
a bitmap with more information than a single integer.  That extra 
information could be used--- in my implementations, if any ever come 
about--- to store routing information.

So on OMAP, the gpio numbers could be defined something like this:

#define MUX(n)  ((n) << 24)       /* Reg4 setting */
#define BANK(n) ((n) << 16)      /* which GPIO register bank */
#define BIT(n) ((n) & 0xff)         /* which bit in the above register 
bank */

    enum {... GPIO57M8 = (MUX(7) | BANK(2) | BIT(3)), GPIO57H19 = 
(MUX(6) | BANK(2) | BIT(3)) ... };

(the above is mostly fiction, since I haven't fully grokk'ed the OMAP 
datasheet and am hoping to avoid the need to).

I was just assuming that this was implied by the proposal--- or at least 
it wasn't prohibited by it--- for machines that needed it.

And again, the fact that "GPIO57M8" would only be defined for OMAP 
wouldn't be a problem--- you wouldn't be building a platform_struct for 
a non-OMAP platform using the OMAP enumerations, anyway.  And if somehow 
you find that you are, a compiler error is probably the appropriate 
response.

>It'd also be a big (and needless) disruption to code that's been working fine for several years now ...
>

... all of which is using the current GPIO API, you mean?  :)

Perhaps yet another reason why the gpio_request function might want to 
look at the hardware state--- so that drivers that aren't using the new 
API are still known to the GPIO resource manager by virtue of the 
signature they leave behind in the hardware configuration (you might not 
be able to detect that they're using a GPIO line, but you would be able 
to detect that a pin had been assigned to a non-GPIO function).

> and there'd need to be some scheme to recognize
>that most GPIO numbers suddenly become invalid (since the space would
>become large and sparsely populated, vs small and dense).
>  
>

Not sure I understand you here, but if I do then I think this doesn't 
matter.  The drivers and platform_structs would be using the enumeration 
symbols, not raw integers, so they don't interact directly with gpio 
number space at all.

>Maybe if it were being done over from scratch, that'd be workable.
>But at this point I have a hard time seeing anyone want to change,
>even if there were a better argument.
>  
>

Waitaminit.  I thought this arch-neutral GPIO API *was* a from-scratch!  
Did I miss something?

>Pin muxing is set up once, early, and from then on it suffices to use
>the GPIO number.
>

Now that I understand how you're using the term "muxing" a little 
better, I think this statement oversimplifies things a bit.

>The mux problems are orthogonal to GPIOs.
>  
>

Again, now that I understand your usage of the term, I'm not so sure 
this is true anymore.  :)


>Updating the GPIO controller is always (all architectures!) done in terms
>of a number mapping to some controller and a bit number, not a pin.  The
>drivers never care about pins.
>  
>

Only to the extent that the signals the driver is producing get to where 
they're going.  HOW that is established is indeed explicitly left out of 
the driver itself, but it's awfully nice when there's a facility 
somewhere that can do it on the driver's behalf.

There's a ton of code in the AT91 tree that sets up pin routing on 
behalf of peripheral drivers like MMC, etc.  MMC also uses GPIO.  So 
you're suggesting that we should take the pin routing a.k.a "muxing" out 
of that driver?  I think it's kind of nice when the driver can ask that 
somebody, somewhere, assign the pins it needs to the peripheral 
functions.  Just one less headache for new authors.

And if that code exists somewhere, then it has to at least talk to the 
GPIO resource manager so that the manager knows those pins are 
off-limits as GPIO.

>The only thing that cares about pins is board setup code -- briefly.
>  
>

So, once the board setup code has run then pin assignments don't 
matter?  I think that a more accurate statement is that as a driver 
loads, it begins to care about pins.  And it does so until it unloads, 
at which point some other driver might care about them.

Arabella's PPC Linux kernels (which I'm working with at the moment) have 
a resource manager not unlike what we're discussing here.  It's very, 
very heavy and unpleasant in spots, so I won't offer code or examples, 
but it is pretty adept at getting pin routing right when a driver 
initializes.  And it can also prevent pin assignment conflicts--- which 
have saved me in a few situations, and made debugging easier in others.  
I don't like their implementation, but the functionality is much-needed.

None of what I'm suggesting affects the signatures of the functions 
specified by your API at all.  I'm just hiding more information behind 
the notion of "gpio number", in a way that lets the implementors also 
incorporate routing (both detection and assignment) into them.



b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

