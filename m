Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUBYVXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUBYVVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:21:49 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:63619 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S261554AbUBYVUF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:20:05 -0500
Date: Wed, 25 Feb 2004 16:20:02 -0500 (EST)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges - take 2
In-Reply-To: <200402252103.48739.daniel.ritz@gmx.ch>
Message-ID: <Pine.LNX.4.58.0402251553410.20967@marabou.research.att.com>
References: <200402240033.31042.daniel.ritz@gmx.ch> <200402250026.20708.daniel.ritz@gmx.ch>
 <Pine.LNX.4.58.0402250148080.2144@portland.hansa.lan> <200402252103.48739.daniel.ritz@gmx.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Feb 2004, Daniel Ritz wrote:

> > Yenta: CardBus bridge found at 0000:00:08.0 [133f:1233]
> > Yenta: Enabling burst memory read transactions
> > Yenta: Using CSCINT to route CSC interrupts to PCI
> > Yenta: Routing CardBus interrupts to PCI
> > Yenta TI: mfunc 0cc07d92, devctl 60
>
> mfunc0 is inta, mfunc1 is irq9, mfunc2 is activity led, mfunc3 is irq7,
> mfunc4 GPI3, mfunc5 is the other led, mfunc6 is irq12...
>
> this would give you irq7,9,12 but device control says parallel PCI only..

That's not surprising.  The card is a PCI device, it's not connected to
the ISA bus.

[snip]
> that's just an uninitialized ti1410. so we're using PCI
>
>
> > Yenta TI: changing mfunc to 00001000
> > Yenta TI: falling back to PCI interrupts

By the way, I looked through your mails an I still don't quite understand
what the above is for.  I understand you are trying serial ISA interrupts
first.  What's the reason for that?  Do you know any device that needs
this?  I would prefer not to add any code unless it's known to be needed.
Any probe is potentially dangerous.  The known problems are with PCI
cards, which have PCI interrupts and don't need anything else.  I believe
laptops are engineered better and don't need any fixes.

> > Yenta TI: changing mfunc to 00001002
> > Yenta: ISA IRQ mask 0x0000, PCI irq 12

Apparently you are enabling INTA.  Shouldn't you disable serial ISA
interrupts if they didn't work?

I also think you are using mfunc_old incorrectly.  Either it should be the
current value of irqmux, in which case you should change it when testing
serial ISA interrupts, or it's the initial value of irqmux, in which case
you shouldn't compare it to mfunc the second time.  You cannot have it
both ways.  Please create one more variable, e.g. mfunc_current.

-- 
Regards,
Pavel Roskin
