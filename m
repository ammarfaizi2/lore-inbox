Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272310AbTHFUje (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 16:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272325AbTHFUje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 16:39:34 -0400
Received: from tribal.metalab.unc.edu ([152.2.210.122]:31407 "EHLO
	tribal.metalab.unc.edu") by vger.kernel.org with ESMTP
	id S272310AbTHFUjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 16:39:31 -0400
Date: Wed, 6 Aug 2003 16:39:17 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] ToPIC specific init for yenta_socket
In-Reply-To: <20030806203217.F16116@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com>
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk>
 <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com>
 <20030806203217.F16116@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003, Russell King wrote:

> On Wed, Aug 06, 2003 at 03:07:21PM -0400, Pavel Roskin wrote:
> > I read the PCMCIA list, but not LKML, and I have no idea what problems
> > you are talking about.  Could you please explain of give a pointer to
> > a previous post?  I could cross-check the problem against plx9052
> > driver.
>
> It's fairly complex.  Let's just summarize it as "yenta texas
> instruments IRQ routing fucked up" 8)  The chip has a bunch of registers
> to control what signals get routed to which physical pins, and it seems
> that between June 2002 and today, some bad changes happened.  I'm
> currently trying to track down each one, but, as there have been several
> levels of patching going on, it isn't simple.

I thought you mean something more fundamental.  This problem really should
not stand in the way of changes unrelated to the TI bridges, such as the
ToPIC patch.

TI bridges have 3 different interrupt routing methods.  The i82365 manual
from pcmcia-cs lists all three - PCI interrupts, ISA interrupts and ISA
interrupts routed via an external serial interrupt controller.

PCI cards without an additional ISA connector always use PCI interrupts.
PowerPC architecture also requires PCI interrupts.  Laptops may use any of
three routing methods, but some of those methods may not work.

The i82365 driver from pcmcia-cs used the preexisting configuration by
default, which was OK for most laptops, but not for standalone PCI cards.

2.5 kernels introduced a device table to determine the interrupt delivery
method.  I criticized this approach, and wrote a patch that would turn on
ISA interrupts if the PCI interrupt delivery failed.  This patch was
applied by Alan Cox to the 2.4 tree.

Unfortunately, I forgot about bridges using external serial interrupt
controllers (I have no idea what it means).  It was reported that such
bridges were also probed for PCI interrupts, and after failing that,
reconfigured to the normal ISA interrupt delivery, which didn't work
either.

Unfortunately I was to busy to respond and didn't have anything but a PCI
card.  I saw some activity on the 2.4 branch to work around this problem.
My patch was also ported to the 2.5 branch.

The problem with TI bridges is that there are at least 3 types of them
that needs to be tested, and I only have one of them.

If there is a desire to do it right this time, and if the problem is
considered serious to spend some time on it, here's how I would do it.

- Never trust preexisting configuration.  Always probe the interrupts.
- Use PCI ID only to disable access to unsupported registers, not to
  find the best IRQ routing.
- Cache the probe results until yenta_socket is unloaded.  Probe
  interrupts once per socket (i.e. 2 times for two-socket cards).
- Probe PCI interrupts first.
- Probe ISA interrupts next, only if there are free interrupts and the
  architecture allows ISA interrupts.
- Probe serial ISA interrupts under the same conditions.
- If all probes fail, deny interrupt requests from clients.  This would
  allow some memory cards.

I can write this code, but I only have a PCI card to test.

-- 
Regards,
Pavel Roskin
