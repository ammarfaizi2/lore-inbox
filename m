Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263106AbUKTQlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263106AbUKTQlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 11:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbUKTQlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 11:41:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:43172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263106AbUKTQlt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 11:41:49 -0500
Date: Sat, 20 Nov 2004 08:41:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <1100941324.987.238.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411200831560.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 20 Nov 2004, Len Brown wrote:
> 
> It clears the ELCR on Linux boot.

I think this is _really_ wrong.

Basically, you're screwing up more and more PIC state. 

Len, the PIC was _correct_ before ACPI touched it. We don't want to touch 
it MORE, we want to touch it LESS. 

I'll try this for debugging, but what I want to figure out is where ACPI 
is doing something it shouldn't be doing, and _removing_ that.

We already had one patch where people tried to hide this problem by adding 
more code. Clearly, that patch was bogus. Yes, it hid the problem for 
floppies, but as shown by my other case (and as I was trying to say from 
the beginning), it's not about floppies. It's about _any_ non-PCI 
interrupt that apparently ACPI has done something _wrong_ for.

So ACPI seems to assume that all interrupts are PCI interrupts, and that's 
just totally wrong. Clearing ELCR is more of this total wrongness. ELCR 
exists for a reason, namely that not all interrupts are PCI. 

Also, you seem to still totally concentrate on PIRQ routing etc. Totally
ignoring the fact that the problematic cases are about interrupts that
have _nothing_ to do with PCI. Not the floppy, not the PS/2 mouse. NOT
PCI! They're both on the southbridge behind a very special interface that
may or may not look like a PCI bus internally, but might quite as well be
something totally special-case (ie a perfectly normal case is that
somebody literally just bolted an old 8042 controller core into the system
and set up special case magic irq routing).

> ps. what I think is happening...
> 
> To its credit, he BIOS correctly recognizes that there is
> no floppy, and it routes a PIRQ to IRQ6.  It correctly sets the
> ELCR bit for this IRQ.
> 
> Linux boots and disables all the PCI Interrupt Links,
> which un-programs the PIRQ directed to IRQ6.

And this is what I think is the bug. There is no reason to disable the PCI 
interrupt link unless you have a damn good reason to do so.

> However, Linux doesn't clear the ELCR first,
> and for some reason that causes an interrupt
> to latch in IRQ6 -- though it is masked.
> 
> Along comes the broken floppy driver before
> the PCI devices probe.  floppy
> doesn't realize there is no hardware and
> unwittingly does a request_irq(6).

You are totally ignoring my other bug report which was for a (existing) 
PSAUX mouse driver on irq12.

If I had had a mouse on that port, it would not have worked.

So the fact is, ACPI does something WRONG. 

		Linus
