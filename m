Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262545AbUKVUKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUKVUKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbUKVUGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:06:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:45444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262570AbUKVUD3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:03:29 -0500
Date: Mon, 22 Nov 2004 12:02:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Len Brown <len.brown@intel.com>
cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
In-Reply-To: <1101151780.20006.69.camel@d845pe>
Message-ID: <Pine.LNX.4.58.0411221137200.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>  <1100819685.987.120.camel@d845pe>
 <20041118230948.W2357@build.pdx.osdl.net>  <1100941324.987.238.camel@d845pe>
 <20041120124001.GA2829@stusta.de>  <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
 <1101151780.20006.69.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Nov 2004, Len Brown wrote:
> 
> Windows uses ACPI to probe the legacy motherboard devices, and ACPI uses
> what the BIOS finds.  If the BIOS and ACPI don't know about the
> motherboard device, then it isn't an ACPI system and among other
> failures, it would never have got a nifty Made for Windows sticker, and
> thus would have market penetration of approximately 0.

One thing that matters is definitely "how does Windows do things", because 
that's what has been tested. However, "Windows" clearly does not use ACPI 
for all enumeration, since there are different versions of Windows, and 
some of them don't (and some of them very much don't boot on all hardware 
either).

In other words, Linux actually needs to be _more_ careful than Windows, 
because it's supposed to just magically work on pretty much anything out 
there. Nasty. So "what windows does" can never be anything but a hint on 
what kind of functionality has ever been tested.

> When we enable a link, we must set the ELCR.
> When we disable a link, we must clear the ELCR.
> We need to be able to enable and disable all links in the system.
> 
> The bug was that while we were were setting the ELCR
> when we enabled a link, we were not clearing it when we disabled one.

Fair enough. That may be a good fix too, but so far I can see the bug on a 
system I actually have access to, and my one-liner fixes it in a 
fundamentally more acceptable manner than any other patch I've seen.

Why?  Because _not_ touching things is the other thing that _has_ been
tested on machines, ie mb manufacturers actually tend to test things that
have no ACPI knowledge at all, still. DOS comes to mind, but so do pretty
much all other operating systems.

Because of that, there's this dichtonomy: you either do everything exactly
like Windows does things, or you try very carefully to do the minimal
amount of untrusted accesses possible. Linux ends up mixing the two
approaches as best it can.

But feel free to send me a patch that doesn't just clear ELCR totally, but
clears the bits we are disabling. I just don't believe in the "let's just
clear everything" approach. In particular, I don't have the same kind of
"ACPI will provide" belief in higher powers that you seem to have.

> But if you're more comfortable with disabling the associated ELCR bit
> only when we disable links directed at that entry, we can do that too. 
> The complication with that approach is that links are many to one, so
> clearing the bit without disabling all links directed to that entry
> would result in a failure.  Also, the SCI uses the ELCR too, and it
> isn't described by links at all.

Wouldn't it be nicer to take the _reverse_ approach: let's assume that any 
PCI interrupts that we have already enabled are fine and should not be 
disabled? Mark them in the ELCR, and _report_ when the ELCR seems to be 
incorrect (let's make a wild guess here, and realize that the screaming 
VIA interrupts you talk about are exactly because the ELCR was wrong).

This is exactly what you are already doing with SCI, thanks to
"acpi_pic_sci_set_trigger()", no?

So I'm really suggesting that instead of disabling the PCI irq routing, it 
should do exactly the same thing that SCI already does. Namely make sure 
that ELCR is set correctly for it.

So in "acpi_pci_link_add()", when you find a link that is enabled, add a
call to make sure that it is set to level triggered in the ELCR. That's
not even ACPI-specific, now we're talking fundamental PCI behaviour, so 
the likelihood of that being wrong is pretty low, no?

That seems like a _safe_ thing to do.

		Linus
