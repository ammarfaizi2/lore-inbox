Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966634AbWKUFHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966634AbWKUFHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 00:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934309AbWKUFHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 00:07:09 -0500
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:46485 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S934308AbWKUFHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 00:07:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=XwGd4dLlnVIzhaoduPeQlWtZ5BQjAgQQc2m9UMXFAhAhMHwLs4p8BMNJ24IJyFeWMy4rpLHGlpwBWRmWpZJ4xrSiYzO2l6VilD+mDSymg1Q8dVK9D7AYh88qG5BtjEUMHiZ1vCWSYFfPtWOxd4wIV0rDTBRL+Ze+aEkZXaYqYTg=  ;
X-YMail-OSG: S6RF1kAVM1mTsJyqmsF4leuHepLGymsvKb1anr5Jcc2_qy65.Fbdh3D7dxG5xGuGLfl8l6Jrne8h9Dw._p6zKmuQUbFEa3gNQFvXcFeseIf_Z5ouPoD5pP_jDlSmK613nB.4L954pXtTYgO9ri9S3HUL.mfwXWJkuyw-
From: David Brownell <david-b@pacbell.net>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [RFC/PATCH] arch-neutral GPIO calls: AVR32 implementation
Date: Mon, 20 Nov 2006 21:06:58 -0800
User-Agent: KMail/1.7.1
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       jamey.hicks@hp.com, Kevin Hilman <khilman@mvista.com>,
       Nicolas Pitre <nico@cam.org>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
References: <200611111541.34699.david-b@pacbell.net> <200611201347.10331.david-b@pacbell.net> <45626E7F.8000100@billgatliff.com>
In-Reply-To: <45626E7F.8000100@billgatliff.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611202107.00754.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 November 2006 7:11 pm, Bill Gatliff wrote:
> 
> In fact, at least at first glance there's really no need for a static 
> array at all on many chips that I can think of.  At most, the 
> gpio_request() function should build up a temporary bitmask using 
> information read from the hardware, then discard that temporary bitmask 
> after the request is completed and the hardware actually configured.

Let's go back to what gpio_request() is defined to do, though:  it very
explicitly "does NOT cause it to be configured in any way", and succeeds
unless the specified GPIO has "already been claimed".


It's addressing problems related only to software configuration:

> + These APIs serve two basic purposes.  One is marking the signals which
> + are actually in use as GPIOs, for better diagnostics; systems may have
> + several hundred potential GPIOs, but often only a dozen are used on any
> + given board.  Another is to catch confusion between drivers, reporting
> + errors when drivers wrongly think they have exclusive use of that signal.

Example, it's a bug if two drivers both thinking they manage GPIO 17.


> >No, but letting the second one report the fatal error is a big help.
> >And heck, you've got reasonable chance the first driver will work,
> >if the second doesn't interfere with it!  (Or maybe it's the other
> >way around.  At least you'd have logged a fatal error message ...)
> >  
> >
> 
> If the gpio_request() is reading from the hardware,

... which it must not do ...

> it could determine  
> that a GPIO line was assigned to a peripheral function by the 
> bootloader; 

On AT91, and AVR32, yes ... since those GPIO controllers are also
involved in pin muxing, and they use a very simple mux model.
(And if the pin were assigned as a GPIO, or not ... so what?  That
doesn't mean that's how Linux must use it.)

But in general, no ... the general case is that GPIO controller(s)
and pin muxing are two separate units in the silicon, and there's
no one-to-one coupling possible.


> >Admittedly, the GPIO controller in those Atmel chips (AVR32,
> >AT91) does have a one-to-one mapping for muxable pins and GPIOs,
> >but that's not a portable notion.
> >  
> >
> 
> Can you refer me to a specific chip that is contrary to the AVR32/AT91 
> notion, so that I can be sure I'm understanding what you're saying?

See my previous email, which gives detailed and very specific examples
with respect to OMAP 5912 chips you get overnight from e.g. Digikey,
and where the pin-to-gpio mapping space is many-to-many.

- Dave

