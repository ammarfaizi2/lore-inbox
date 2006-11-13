Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932798AbWKMTVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798AbWKMTVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 14:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbWKMTVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 14:21:32 -0500
Received: from smtp111.sbc.mail.mud.yahoo.com ([68.142.198.210]:29627 "HELO
	smtp111.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932798AbWKMTVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 14:21:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=pKFXTAHczbOQ+MLxJc0r1b5wbioLocJEDg2ZpdFOS1xFgeVzKm9e4hdotQSTuLeFZUpAa3xIel3jozQl1M8CsdB9W4KqF6vjanLtrY88+OhYBT/Xy2G1grjW85G+M1+q1jXrVgE8QpIncyzwHZjbyrrR/JUot68wgdWa3Tsy8fY=  ;
X-YMail-OSG: PHa6sQ0VM1mn2UPPnM.Vfd6J1ay_RpTzQKyiAy7HokUk4NYf_dd6Ak9QnOdO97pqYz_GxjvC5a.yKSn8zaV6lkHUU7FfM3wbQ9srZ95tfc7LIN.0ILCFKf4kwgplyYfeHnyI4R225QOvX9tPppPIIsepOVXugwIOWYM-
From: David Brownell <david-b@pacbell.net>
To: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
Date: Mon, 13 Nov 2006 11:21:23 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <20061113173800.GA19553@linux-sh.org>
In-Reply-To: <20061113173800.GA19553@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611131121.23944.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 November 2006 9:38 am, Paul Mundt wrote:

> > Comments?
> 
> I'm not convinced that exposing the pin number to drivers is the way to
> go. The pin numbers themselves are rarely portable across "similar" CPUs
> with identical peripherals, 

Pin numbers are NOT exposed ... GPIO numbers are.  Drivers just get
a number and pass it around.  They're cookies with the same kinds of
portability attributes as IRQ numbers and register addresses.  (None of
which have particular portability problems when used properly.)

And all those existing ARM GPIO calls work just fine with numbers
for GPIOs.  The numbers are platform-specific, sometimes with board
specific additions (like FPGA outputs) ... but they're just numbers.


(And FWIW, I'm more familiar with "balls" like AA12 or J15 being relevant,
than pins like 1 or 332.  Of course one could assign numbers to balls,
but the mappings for a BGA-256 would be different from ones on a BGA-193
or a BGA-289.  And yet the same logical GPIO -- accessed through the same
software registers -- might be available with all of those packages!
Sometimes on more than one pin.  Such issues are associated with pin
mux/config, not GPIO numbering.)


>	 while the pin function itself may be 
> portable (or simply unecessary). Pin muxing also needs to be handled in a
> much more transparent and intelligent fashion, which is something else
> that is fairly easy to do when looking at a symbolic name for the pin
> function rather than the pin # itself.

This is explicitly _not_ addressing pin muxing.  The mux configuration on
OMAP1 is different from OMAP2 (the latter is pretty sane!), both are
different from PXA or AT91 or DaVinci, and so on.  Pin muxing needs to
happen even when GPIOs are not involved, so the two issues are logically
distinct.

If you'd like to propose a generic pin mux API, more power to you!  But
it doesn't seem like a simple problem to me, much less one that needs
solving before a basic GPIO framework could be adopted.


> Exposing the pin # abstraction any higher than the CPU-specific code
> hidden away in an architecture backend is just asking for abuse,

I thought I already said something about that ... yes, here it is:

> > +A given platform may want to define symbols corresponding to GPIO lines,
> > +primarily for use in board-specific setup code. Most drivers should use
> > +GPIO numbers passed to them from that setup code, using platform_data to
> > +hold board-specific pin configuration data (along with other board
> > +specific data they need).

I don't see a disagreement with your comments there, beyond maybe
the fuzziness between CPU/platform/architecture/board ... e.g. on
the same ARM926ejs CPU gets used on many chips with very different
GPIO controllers (which I referred to loosely as "platforms").


> specifically for drivers that are shared across different architectures
> (or where the peripheral may only be conditionally hooked to a GPIO or
> require demuxing).

See above; drivers that are portable -- rather than board-specific,
like a bitbanged I2C or SPI link -- would take GPIO numbers passed
to them from the board setup code.

Of course, such a board-specific bitbanger could know the GPIO as
a constant, not a variable.  Which should allow inlinable versions
of the primitives to kick in ... I've observed 2x-4x speedups in
the cases I've measured, just by making gpio get/set directly access
controller registers vs indirecting to short subroutines.


> Any API also needs to allow for multiple GPIO controllers, as it's rarely
> just the CPU that has these or needs to manipulate them.

This API absolutely allows for multiple GPIO controllers ... all it does
is say "here are the numbers, handle them".  The platform's implementation
of the API is allowed to map to the relevant controller.

You may be familiar with the way OMAP does it ... the example implementation
(sent with the original post in this thread) copes with two different types
of controller (on OMAP1), one of which has multiple instances as well as
cpu-specific variants (ISTR some having 32 bits per controller, while most
have 16).  That isn't exposed in the API.  Such issues are implementation
specific, and not all platforms have them.

- Dave

