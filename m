Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275239AbTHGJCQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275240AbTHGJCQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:02:16 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10505 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275239AbTHGJCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:02:15 -0400
Date: Thu, 7 Aug 2003 10:02:11 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: Tim Small <tim@buttersideup.com>, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: TI yenta-alikes (was: ToPIC specific init for yenta_socket)
Message-ID: <20030807100211.A17690@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Roskin <proski@gnu.org>,
	Tim Small <tim@buttersideup.com>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <200308062025.08861.daniel.ritz@gmx.ch> <20030806194430.D16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061452310.3849@marabou.research.att.com> <20030806203217.F16116@flint.arm.linux.org.uk> <Pine.LNX.4.56.0308061554480.4178@marabou.research.att.com> <3F317FD7.6020209@buttersideup.com> <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.56.0308062301550.1995@marabou.research.att.com>; from proski@gnu.org on Thu, Aug 07, 2003 at 12:01:06AM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 12:01:06AM -0400, Pavel Roskin wrote:
> I have no idea, but I think it's an important consideration.  I wonder how
> it's possible to put IRQ3 and INTA on the same pin?

It's not, and this is the whole point about why what we're currently
doing is *wrong*.  The only people who know whether the pin has been
wired for INTA or IRQ3 are the _designers_ of the hardware, not the
Linux kernel.

Currently, the Linux kernel assumes a "greater than designers" approach
to fiddling with the registers which control the function of these pins,
and so far I've seen:

- changing the mode from serial PCI interrupts to parallel PCI interrupts
  causes the machine to lock hard (since some cardbus controllers use the
  same physical pins for both functions.)

- fiddling with the IRQMUX register changes the mapping between the card
  IRQ selector register and the physical ISA IRQ on which the interrupt
  appears, or even changes the function of the pin connected to a shared
  ISA IRQ (IRQ3 and 4) to become the ZV status output.

In essense, when we find that a particular machine has not setup the
function of these multi-purpose signals, we need to find a way to
perform the fixup which is dependent on the machine not on the
cardbus controller type.

If we can't do that, then we can't fix up the problem automatically -
chances are applying the same "fix" across different machines will
break the cases which presently work.

So, to find a solution, as of last night, Linus has integrated changes
which completely disables the frobbing of the IRQMUX register on TI
chips, and disables the "select PCI only IRQ mode" code which was
recently merged from the -ac tree.  The latter was rather bogus -
it disabled the ISA interrupts before we determined if we had any
to start with.

In addition, we display the slot and subsystem vendor and device IDs
at boot.  Hopefully, this will allow us to gather sufficient information
to put together a reasonable picture of which machines are broken and
give us a way to perform the necessary fixups on a per-machine basis.

I'm hoping that those who need these machine specific registers frobbed
are going to be testing 2.6.0-test kernels.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

