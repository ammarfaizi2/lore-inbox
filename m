Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263297AbVGOOei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263297AbVGOOei (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 10:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbVGOOeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 10:34:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:25823 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263297AbVGOOdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 10:33:47 -0400
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jon Smirl <jonsmirl@gmail.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050715014611.B613@den.park.msu.ru>
References: <20050714155344.A27478@jurassic.park.msu.ru>
	 <20050714145327.B7314@flint.arm.linux.org.uk>
	 <9e47339105071407073f07bed7@mail.gmail.com>
	 <20050715014611.B613@den.park.msu.ru>
Content-Type: text/plain
Date: Sat, 16 Jul 2005 00:33:21 +1000
Message-Id: <1121438001.5963.35.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 01:46 +0400, Ivan Kokshaysky wrote:
> On Thu, Jul 14, 2005 at 10:07:34AM -0400, Jon Smirl wrote:
> > I'm don't think it has ever been working in the 2.6 series. If you are
> > getting rid of it get rid of the #define PCI_BRIDGE_CTL_VGA in pci.h
> > too since this code was the only user.
> 
> No. The PCI_BRIDGE_CTL_VGA is not something artificial, it just describes
> some well defined hardware bit in the p2p bridge config header, so anyone
> working on VGA switching API will have to use it.
> 
> > This code is part of VGA arbitration which BenH is addressing with a
> > more globally comprehensive patch. Ben's code will probably replace
> > it.
> 
> Yes, I've heard Ben is working on this, but I've yet to see the code. ;-)
> Any pointers?

I posted an early untested implementation a while ago (I don't have it
at hand sorry) and then got distracted by other things. I'll be back on
it soon though. The main "issue" I have at the moment isn't the arbiter
itself, which is not too tricky, but making things cooperate with him.
That is mostly

 - Console subsystem &| vgacon. That needs some serious work to deal
with the fact that the HW may not be accessible due to arbitration
issues. I'm considering replacing the trylock() on the console semaphore
by a per-console lock() callback here, though I yet have to decide what
happens to data in the printk buffer if you have, for example, 2 console
drivers, one of them "eats" the data, but the second one fails (returns
-EAGAIN due to lost arbitration).

 - Existing X servers & other apps using fbdev and mmap'ing /dev/fb*
directly. The current fbdev API provides no arbitration mecanism and
existing X servers just bang the hardware and toggle VGA routing
directly. To work around that, I've started toying with the VT mode.
That is, define a new KD_GRAPHICS_NEW mode that is equivalent to today's
KD_GRAPHICS, and have the "old" KD_GRAPHICS "disengage" the arbiter.
When leaving the later mode, the arbiter should "recover" from whatever
userland and/or X did.

While I've been thinking about these & possible solutions, I didn't have
time to write any actual code. Without solving those issues, though, a
VGA arbiter is fairly useless.

Ben.


