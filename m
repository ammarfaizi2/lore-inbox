Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbUBYXJX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 18:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbUBYXIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 18:08:07 -0500
Received: from 217-162-59-239.dclient.hispeed.ch ([217.162.59.239]:22020 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S261568AbUBYXCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 18:02:06 -0500
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges - take 2
Date: Thu, 26 Feb 2004 00:01:23 +0100
User-Agent: KMail/1.5.2
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200402240033.31042.daniel.ritz@gmx.ch> <200402252103.48739.daniel.ritz@gmx.ch> <Pine.LNX.4.58.0402251553410.20967@marabou.research.att.com>
In-Reply-To: <Pine.LNX.4.58.0402251553410.20967@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402260001.23913.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 February 2004 22:20, Pavel Roskin wrote:
> On Wed, 25 Feb 2004, Daniel Ritz wrote:
> 
> > > Yenta: CardBus bridge found at 0000:00:08.0 [133f:1233]
> > > Yenta: Enabling burst memory read transactions
> > > Yenta: Using CSCINT to route CSC interrupts to PCI
> > > Yenta: Routing CardBus interrupts to PCI
> > > Yenta TI: mfunc 0cc07d92, devctl 60
> >
> > mfunc0 is inta, mfunc1 is irq9, mfunc2 is activity led, mfunc3 is irq7,
> > mfunc4 GPI3, mfunc5 is the other led, mfunc6 is irq12...
> >
> > this would give you irq7,9,12 but device control says parallel PCI only..
> 
> That's not surprising.  The card is a PCI device, it's not connected to
> the ISA bus.

that explains it...

> 
> [snip]
> > that's just an uninitialized ti1410. so we're using PCI
> >
> >
> > > Yenta TI: changing mfunc to 00001000
> > > Yenta TI: falling back to PCI interrupts
> 
> By the way, I looked through your mails an I still don't quite understand
> what the above is for.  I understand you are trying serial ISA interrupts
> first.  What's the reason for that?  Do you know any device that needs
> this?  I would prefer not to add any code unless it's known to be needed.
> Any probe is potentially dangerous.  The known problems are with PCI
> cards, which have PCI interrupts and don't need anything else.  I believe
> laptops are engineered better and don't need any fixes.
>

it's looking at the device control register first. if it's configured for
serial interutps then test it...my laptop for example uses serial interrupts
(plus the parallel PCI)

may be there are cards out there that need an exclusive interrupt. i don't
know.

the reason why i did it is the comment in the old code:

        /*
         * If ISA interrupts don't work, then fall back to routing card
         * interrupts to the PCI interrupt of the socket.
         *
         * Tweaking this when we are using serial PCI IRQs causes hangs
         *   --rmk
         */

the comment is there for a reason. so make sure DEVCTL is wrong, not MFUNC.
if we do check for all serial and don't fall back to PCI, the code wouldn't fixup
most of the non-working setups.
 
> > > Yenta TI: changing mfunc to 00001002
> > > Yenta: ISA IRQ mask 0x0000, PCI irq 12
> 
> Apparently you are enabling INTA.  Shouldn't you disable serial ISA
> interrupts if they didn't work?

it does so by masking out the routing bits in the device control register, it
set it to PCI only...but read on

> 
> I also think you are using mfunc_old incorrectly.  Either it should be the
> current value of irqmux, in which case you should change it when testing
> serial ISA interrupts, or it's the initial value of irqmux, in which case
> you shouldn't compare it to mfunc the second time.  You cannot have it
> both ways.  Please create one more variable, e.g. mfunc_current.
> 

no, it's the way it should be. but it should really go back to the old value if 
serial interrupts probing failed. then it would be correct.


> -- 
> Regards,
> Pavel Roskin
> 
> 

rgds,
-daniel

