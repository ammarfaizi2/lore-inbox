Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932950AbWKMT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932950AbWKMT31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbWKMT30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:29:26 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:13795 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S932950AbWKMT30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:29:26 -0500
Message-ID: <4558C794.90602@billgatliff.com>
Date: Mon, 13 Nov 2006 13:29:24 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mundt <lethal@linux-sh.org>
CC: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org> <4558B71F.9020502@billgatliff.com> <20061113183811.GA19979@linux-sh.org>
In-Reply-To: <20061113183811.GA19979@linux-sh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt wrote:

>On Mon, Nov 13, 2006 at 12:19:11PM -0600, Bill Gatliff wrote:
>  
>
>>True, but right now if the "multiple GPIO controllers" are on something 
>>like i2c/spi, they have the synch/asynch issues that Jamey mentioned and 
>>so are by definition out of scope for this proposal.  If the GPIO lines 
>>are in an MMIO controller (PLD/FPGA, perhaps), then there's no reason 
>>that the board implementer couldn't address that in their implementation 
>>of the proposed functions.
>>
>>    
>>
>They're something that has to be accounted for in any sort of API, or we
>just end up throwing it all out and starting over again. I was thinking
>more of the SuperIO or mfd device scope, where this _is_ a requirement.
>  
>

Right.  I don't know anything about SuperIO/SH, but the mfd stuff I've 
worked with to date (UCB1400, SM501) all provide for the various 
functions by mapping them into existing APIs like i2c, ALSA, etc. which 
aren't disturbed by Dave's proposal.  They still have their limitations, 
i.e. you wouldn't want to put an IDE controller out on one of the GPIO 
lines of a UCB1400, a problem that Dave isn't trying to address.

>>... except that I bet David is thinking that the implementations will be 
>>in arch/arm/irq-at91rm9200.c or something, and not in 
>>asm/arm/board-xyz.c, so it's the arch implementer's responsibility and 
>>not the platform author's.  Yea, I see your point now.
>>
>>    
>>
>The problem with this is that it gets in to something that's getting
>close to static pin state configuration. Setting up the mux from platform
>code is brain-damage, since it's ultimately up to the system and driver
>inserted at the time to grab and configure the pin as necessary, the
>board or CPU code is not going to have any notion of the "preferred" pin
>state, especially in the heavily muxed case.
>  
>

The platform _is_ the system, as far as the driver is concerned.  I 
think they're indistinguishable.

What the driver needs is an enumeration that it can hand to the GPIO 
layer that says, "set this high" or "set this low", or "what is the 
state on this line?".  The platform_device structure is a great place to 
pass it the enumerations that, deep in the bowels of the platform/system 
code, map into actual GPIO lines.  I don't think that's close to static 
pin assignment any more than using the platform_device structure to pass 
IRQ line enumerations is now.  Think: today, most drivers don't know or 
care if an IRQ line is edge-triggered or level-triggered.  That code is 
in the domain of the IRQ subsystem.  What David is proposing is the same 
sort of thing for GPIO.


>This is all too late for 2.6.19 regardless. We've gone this long without
>a generic API, I see no reason to merge a temporary hack now if it's not
>going to be satisfactory for people and require us to throw it all out
>and start over again anyways.
>  
>

I don't see what David is proposing as being a temporary hack.  Rather, 
it's a starting point.  We can add another layer on after the sync/async 
issues are sorted out--- which I think is a challenging problem that 
will take a while.  I'd rather have some uniformity today that we can 
use across ARM, and ultimately other arches as well.

>I have a real need for supporting multiple controllers and handling
>muxing dynamically from various drivers on various architectures, and
>anything that exposes the pin # higher than the controller mapping to
>function level is never going to work. Drivers have _zero_ interest in
>pin #, only in the desired function.
>  
>

Agreed.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

