Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWKUVTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWKUVTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWKUVTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:19:52 -0500
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:45500 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161374AbWKUVTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:19:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=AODbPxcCYSCLQmhB6wqSlIYeQZqF9JLFUSgaDny/ZZ1nkaZU3O/+9PNa4Lw0N1XYRZeZiII9AxOnYqOa96Fzxro3CHxT+LiPYZ4Z1ssIiPck2YACLZ9WkOD9iJq6A+gx34dE2KdAx/cZGK6t5m5hSo+sE6s4DI5O5Q66kk5/vYU=  ;
X-YMail-OSG: c2AbmewVM1msTWa7E1C31ZgX9S9U16obtZsXkyR2PZAmjS6p6vQtbAawEMWCWt7vt9kLj9FPiJ1BixeqFPRGb1tuxfOSfcQOwEDrMR2s6ZBKLp_cUFqQDPh2rzOAKYtX_a5TMSx8VLPX8lthEysuhVK7UQeEwZirHQw-
From: David Brownell <david-b@pacbell.net>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
Date: Tue, 21 Nov 2006 11:03:41 -0800
User-Agent: KMail/1.7.1
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611201347.10331.david-b@pacbell.net> <20061121101103.47add0cf@dhcp-252-105.norway.atmel.com>
In-Reply-To: <20061121101103.47add0cf@dhcp-252-105.norway.atmel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611211103.43757.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 November 2006 1:11 am, Haavard Skinnemoen wrote:

> > Or if you want to track the identifiers and provide a debugfs dump
> > of the active GPIOs and their status, use an array of strings (and
> > spinlock its updates) or nuls as "fat bits", instead of a bit array.  
> 
> Might be useful. Maybe we should add a "struct device" parameter to
> gpio_request() as well, to allow platforms to associate pins with the
> devices using them through sysfs? Or perhaps just to generate an
> appropriate name (otherwise, each driver would have to generate a
> unique string by themselves, for each device it controls.)

I'm not so keeen on putting sysfs everywhere; it's not free!
The notion of passing a device node makes some sense, except
that a lot of the places I'm used to seeing GPIO requests are
so early in the boot code that there _is_ no device node yet.
Let me think about that one a bit...



> I think I understand now. I have to use separate bitmasks for GPIO and
> port mux setup.
> 
> If gpio_request() could do port mux configuration, one bitmask would be
> enough to trap all errors. But after reading the rest of this thread,
> I think separating the gpio and portmux APIs is a good idea, so I'm not
> going to try to do this. Although I might set a bit in both masks when
> configuring a pin for peripheral I/O, just to indicate that it isn't
> usable for gpio at all.

On your hardware, you could just read the hardware when setting
the gpio direction ... don't need an extra mask to catch that
class of error.


> > > Of course, if other arches want gpio_request()/gpio_free(), I'm all
> > > for keeping them.
> > 
> > I thought you were someone who _wanted_ this mechanism?
> > Or were you instead thinking of a pin mux mechanism?
> 
> Yes and yes ;)
> 
> Which is of course the source of all this confusion. I just had to
> realize that the final definition of gpio_request was I little bit
> different than I originally expected. This means that gpio_request() is
> no longer _essential_ on avr32 (which corresponds nicely with its
> classification as "optional" in your api proposal) but very nice to
> have.

Right; I think I've had the OMAP analogue of gpio_request() turn
up errors only once (that code base was once a lot dirtier), but
some newish debug dump code worked a lot better with that.


> > Aren't you going to want to add AVR-specific extensions so that
> > drivers (or more typically, board init code) can manage pullups
> > and input de-glitching?
> 
> Yeah, I will definitely do that, but I thought that was supposed to be
> part of the portmux api?

Yes it is.  I suppose I shouldn't have assumed it would go into
that gpio.h header file, even though that's where it started out
on the at91 platform.  :)

- Dave

