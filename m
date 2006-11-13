Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755254AbWKMUQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbWKMUQj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755255AbWKMUQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:16:39 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:8391 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1755254AbWKMUQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:16:37 -0500
Date: Tue, 14 Nov 2006 05:15:35 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Bill Gatliff <bgat@billgatliff.com>
Cc: David Brownell <david-b@pacbell.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Message-ID: <20061113201535.GA20388@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Bill Gatliff <bgat@billgatliff.com>,
	David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org> <4558B71F.9020502@billgatliff.com> <20061113183811.GA19979@linux-sh.org> <4558C794.90602@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4558C794.90602@billgatliff.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2006 at 01:29:24PM -0600, Bill Gatliff wrote:
> Paul Mundt wrote:
> >They're something that has to be accounted for in any sort of API, or we
> >just end up throwing it all out and starting over again. I was thinking
> >more of the SuperIO or mfd device scope, where this _is_ a requirement.
> 
> Right.  I don't know anything about SuperIO/SH, but the mfd stuff I've 
> worked with to date (UCB1400, SM501) all provide for the various 
> functions by mapping them into existing APIs like i2c, ALSA, etc. which 
> aren't disturbed by Dave's proposal.  They still have their limitations, 
> i.e. you wouldn't want to put an IDE controller out on one of the GPIO 
> lines of a UCB1400, a problem that Dave isn't trying to address.
> 
Yes, that wasn't my point, my point was that the mfd case itself is
already an example of where we have a real need for multiple GPIO
controllers, today.

> What the driver needs is an enumeration that it can hand to the GPIO 
> layer that says, "set this high" or "set this low", or "what is the 
> state on this line?".  The platform_device structure is a great place to 
> pass it the enumerations that, deep in the bowels of the platform/system 
> code, map into actual GPIO lines.  I don't think that's close to static 
> pin assignment any more than using the platform_device structure to pass 
> IRQ line enumerations is now.

The "static" configuration is not the GPIO number cookie so much as the
pre-configured state handled at the board-level. This will continue to be
an issue so long as the muxing is decoupled from the rest of the API.

Pin muxing is somewhat of a decoupled issue, but it's quite related when
"GPIO" is just another pin state depending on the mux. The primary
concern here is where we end up doing the refcounting for the pins, so we
don't run in to a situation where a pin is toggled out from an existing
user with regards to drivers contending for pin functions. On the other
hand, I'm not opposed to layering rather than trying to accomodate it all
in the same API.

I have some code for this already, but I suppose I'll have to plug it in
alongside David's API to see whether this will be workable for the use
cases in question.

> Think: today, most drivers don't know or care if an IRQ line is
> edge-triggered or level-triggered.  That code is in the domain of the
> IRQ subsystem.  What David is proposing is the same sort of thing for
> GPIO.
> 
I would suggest that it's exactly the opposite, other than the blatantly
obvious cases (edge-triggered NMI, controllers with fixed detection
logic, etc.) it's _specifically_ up to the drivers to indicate where to
do the detection, as to allow the IRQ controller to adjust the sense
selection for that particular IRQ. Grepping drivers/ for IRQF_TRIGGER is
a pretty good indicator of this.
