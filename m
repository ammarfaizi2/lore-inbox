Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262234AbUBXMCR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 07:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUBXMCR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 07:02:17 -0500
Received: from mailrelay2.alcatel.de ([194.113.59.71]:51106 "EHLO
	mailrelay1.alcatel.de") by vger.kernel.org with ESMTP
	id S262234AbUBXMCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 07:02:14 -0500
From: Daniel Ritz <daniel.ritz@alcatel.ch>
Reply-To: daniel.ritz@gmx.ch
To: Pavel Roskin <proski@gnu.org>, Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
Date: Tue, 24 Feb 2004 12:59:50 +0100
User-Agent: KMail/1.5.2
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200402240033.31042.daniel.ritz@gmx.ch> <200402240132.31659.daniel.ritz@gmx.ch> <Pine.LNX.4.58.0402231947520.30747@marabou.research.att.com>
In-Reply-To: <Pine.LNX.4.58.0402231947520.30747@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402241259.50046.daniel.ritz@alcatel.ch>
X-Alcanet-virus-scanned: i1OC0wMt027630 at mailrelay1.alcatel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 February 2004 02:06, Pavel Roskin wrote:
> On Tue, 24 Feb 2004, Daniel Ritz wrote:
> > ok, not good. what about: read the routing in MFUNC0, test if it works,
> > only set to PCI if it doesn't work. the problem is we can't test if
> > another device already sits on that irq. we shouldn't do anything then.
>
> What if we just check if irqmux is 0.  Is it 0 on your card?  I believe
> the only problem is the the cards that don't have irqmux initialized from
> EEPROM.

not good. newer chips (eg 1520) have a default value != 0. when a manufacter
forgets the serial ROM and does nothing in the BIOS you end up with default
values (eg. the 1520 has all serial interrupts). for the 1410 irqmux defaults to 0.

>
> I think that your fix is too intrusive.  I'm not sure it's worth it.

currently yes, i try to do better in the next version.

> After all, we are not going to support every possible piece of broken
> hardware, only those that are relatively widespread.  I have one, you have
> one (presumably), let's see what we have.
>

not broken hardware. uninitialized hardware. hardware that doesn't work with
yenta_socket but works with some redmond os...bad...

> Could you please give more information about your hardware?  My hardware
> is a card based on TI PCI1410 with broken EEPROM.  It has one slot.
> irqmux is 0 on startup.  Attempts to write to EEPROM damage the card
> permanently.  It stops working as a valid PCI device and prevents booting
> Linux with PCI support.

it's a 1410. and it's working. almost. with the redmond os it works, with linux
it works too and with freebsd the laptop dies as soon as inserting a card.

it's programmed for serial interrputs and PCI, INTA is routed. so not really
a problem there. (and my patch does _nothing_ there :)

>
> I'm concerned that you are reading irqmux in ti_override(), which is also
> used in bridges without irqmux.  Those bridges only need changes in devctl
> if any.  The fix should be in ti12xx_override() or even ti1250_override().

good catch...ti113x is one w/o irqmux...so yes ti12xx_override is the right place.
another bug in the disabled code...and i think in 2.4 too)

>
> > yeah, not as it is now. more checks are needed, PCI fallback only if
> > nothing else works. may be we should just make it a module param like in
> > pcmcia-cs i82365.c?
>
> The parameter would be the last resort.  Shifting the problem to the users
> is more like a surrender than a victory.  Not to mention that such
> approach won't work well with multiple card and/or solid kernel.

of course a module param would suck. that's why i didn't write code.

there's another bug btw. one that is probably never hit and harmless too:
rmk's notbook has parellel isa interrupts, INTA is _not_ routed. if it happens
that all the interrupts are taken by other devices the resource manager falls
back to routing the card to PCI which we know is not working...however
it is not happening on a notebook.


