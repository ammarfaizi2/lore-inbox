Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263826AbUFFRGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263826AbUFFRGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 13:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263834AbUFFRGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 13:06:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:36786 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263826AbUFFRFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 13:05:06 -0400
Date: Sun, 6 Jun 2004 10:04:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: ktech@wanadoo.es, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.7-rc1 breaks forcedeth
In-Reply-To: <40C2D780.4010009@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0406060957410.7010@ppc970.osdl.org>
References: <E1BWmws-0005aN-Nw@mb04.in.mad.eresmas.com>
 <Pine.LNX.4.58.0406051958150.7010@ppc970.osdl.org> <40C2D780.4010009@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Manfred Spraul wrote:
>
> I'll add that, but it's only a partial fix: what if ehci_hcd is loaded 
> before the forcedeth driver?

Yes. We've had those kinds of problems before, and sometimes you need a 
PCI quirk to disable a screaming device. See the PIIX3 USB quirk in 
drivers/pci/quirks.c for example.

The good news is that it's fairly rare. Devices don't generally have
pending interrupts, since they haven't been turned on, or at least the
BIOS has finished doing whatever it was doing to them. The USB thing
happens because the BIOS leaves the USB controller active (probably for
keyboard usage) and USB normally generates interrupts whether anything
happens or not.

> Luis, could you apply the patch and boot with it? It should print 
> something like
> 
> forcedeth: irq line 11, Status 0x00000020, Mask 0x00000020
> 
> If mask and status are really not zero, then it explains your problems. 

It could be something else on the NForce thing too, of course. Including
just having ACPI get confused about the polarity of the interrupt (if the
interrupt is _off_, but we've told the irq controller the wrong polarity,
the controller will obviously think that it is _on_).

But it's usually a good thing to try to reset a device as much as possible 
when you probe for it. If for no other reason than the fact that then 
you'll have it in a "known state", and hopefully there won't be as many 
surprises..

		Linus
