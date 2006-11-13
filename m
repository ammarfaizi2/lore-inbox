Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755285AbWKMRjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755285AbWKMRjH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 12:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbWKMRjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 12:39:06 -0500
Received: from smtp.ocgnet.org ([64.20.243.3]:21698 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1755285AbWKMRjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 12:39:03 -0500
Date: Tue, 14 Nov 2006 02:38:00 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Message-ID: <20061113173800.GA19553@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	David Brownell <david-b@pacbell.net>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
	Bill Gatliff <bgat@billgatliff.com>,
	Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
	Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
	Russell King <rmk@arm.linux.org.uk>,
	Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611111541.34699.david-b@pacbell.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 03:41:32PM -0800, David Brownell wrote:
> I know there have been discussions about standardizing GPIOs before,
> but nothing quite "took".  One of the more recent ones was
> 
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=110873454720555&w=2
> 
> Below, find what I think is a useful proposal, trivially implementable on
> many ARMs (at91, omap, pxa, ep93xx, ixp2000, pnx4008, davinci, more) as well
> as the new AVR32.
> 
> Compared to the proposal above, key differences include:
> 
>   - Only intended for use with "real" GPIOs that work from IRQ context;
>     e.g. pins on a SOC that are controlled by chip register access.
> 
>   - Can be trivially implemented today, on many systems (see partial
>     list above) ... no "provider" or gpiochip API necessary.
> 
>   - Provided in the form of a working patch, with sample implementation;
>     known to be viable on multiple architectures and platforms.
> 
>   - Includes Documentation/gpio.txt
> 
> Comments?
> 
I'm not convinced that exposing the pin number to drivers is the way to
go. The pin numbers themselves are rarely portable across "similar" CPUs
with identical peripherals, while the pin function itself may be
portable (or simply unecessary). Pin muxing also needs to be handled in a
much more transparent and intelligent fashion, which is something else
that is fairly easy to do when looking at a symbolic name for the pin
function rather than the pin # itself.

Exposing the pin # abstraction any higher than the CPU-specific code
hidden away in an architecture backend is just asking for abuse,
specifically for drivers that are shared across different architectures
(or where the peripheral may only be conditionally hooked to a GPIO or
require demuxing).

Any API also needs to allow for multiple GPIO controllers, as it's rarely
just the CPU that has these or needs to manipulate them.
