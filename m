Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbTJIIDl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 04:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbTJIIDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 04:03:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:52236 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261914AbTJIIDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 04:03:38 -0400
Date: Thu, 9 Oct 2003 09:03:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [RFC] disable_irq()/enable_irq() semantics and ide-probe.c
Message-ID: <20031009090332.A9542@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
References: <20031009024334.GA7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0310081947330.19510-100000@home.osdl.org>; from torvalds@osdl.org on Wed, Oct 08, 2003 at 07:53:36PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 08, 2003 at 07:53:36PM -0700, Linus Torvalds wrote:
> On Thu, 9 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > ObOtherFun:  There's another bogosity in quoted ide-probe.c code, according
> > to dwmw2 - he says that there are PCI IDE cards that get IRQ 0, so the
> > test for hwif->irq is b0rken.  We probably should stop overloading
> > ->irq == 0 for "none given", but I'm not sure that we *have* a value
> > that would never be used as an IRQ number on all platforms...
> 
> The BIOS defines irq 0 in the PCI config space to be "no irq" as far as I
> know, and on all PC platforms I've ever heard of it's not a usable irq for
> generic PCI devices (it's wired to the timer thing). 
> 
> All PCI routing chipsets I know about also make "irq0" mean "disabled". 

Correct for x86.  For other architectures, it many not be so.  On ARM for
example, it is quite normal for IRQ0 to be used.  Hopefully it'll be
something which generic code won't see, but that isn't always true.
Someone else might actually follow the PCI specs and use "255" to mean
"no irq" on their PCI bus.

Irregardless of all that, ARM has always had the following in asm/irq.h:

/*
 * Use this value to indicate lack of interrupt
 * capability
 */
#ifndef NO_IRQ
#define NO_IRQ  ((unsigned int)(-1))
#endif

and each time this topic comes up, I always suggest that this idea needs
to be propagated to the rest of the kernel - a method by which an interrupt
number can be tested to check whether it is real.  I don't particularly
care if its a constant, or a function-like thing, eg for x86:

#define no_irq(irq) ((irq) == 0)

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
