Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbUBXPZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262273AbUBXPZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:25:12 -0500
Received: from mailrelay3.alcatel.de ([194.113.59.71]:43660 "EHLO
	mailrelay1.alcatel.de") by vger.kernel.org with ESMTP
	id S262272AbUBXPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:25:03 -0500
From: Daniel Ritz <daniel.ritz@alcatel.ch>
Reply-To: daniel.ritz@gmx.ch
To: Russell King <rmk+lkml@arm.linux.org.uk>, daniel.ritz@gmx.ch
Subject: Re: [PATCH] yenta: irq-routing for TI bridges
Date: Tue, 24 Feb 2004 16:23:11 +0100
User-Agent: KMail/1.5.2
Cc: Pavel Roskin <proski@gnu.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200402240033.31042.daniel.ritz@gmx.ch> <200402241259.50046.daniel.ritz@alcatel.ch> <20040224124011.A30975@flint.arm.linux.org.uk>
In-Reply-To: <20040224124011.A30975@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402241623.11569.daniel.ritz@alcatel.ch>
X-Alcanet-virus-scanned: i1OFOLMt009421 at mailrelay1.alcatel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[removing akpm from cc as it is pcmcia centric]

On Tuesday 24 February 2004 13:40, Russell King wrote:
> On Tue, Feb 24, 2004 at 12:59:50PM +0100, Daniel Ritz wrote:
> > there's another bug btw. one that is probably never hit and harmless too:
> > rmk's notbook has parellel isa interrupts, INTA is _not_ routed.
>
> Not true.  It has parallel ISA interrupts _and_ parallel PCI interrupts.
> It's a TI 1250.  Unfortunately, the 1250 data sheet isn't available,
> however there seems to be some consistency in the device codes to
> features offered.

ok, i see the 1250, 1450 are different. the 1410/1520 doc says nothing about it.
did i miss something about the 1410/1520/etc ?

>
> The 1450 and 1251A (both of which seem similar to 1250) has separate pins
> for PCI parallel interrupts which are outside the control of the "IRQMUX"
> register.  When these pins are not used for parallel PCI interrupts,
> they function as "GPIO3" and "IRQSER" (for PCI serial interrupts)
> respectively.  The function of these pins is controlled by the device
> control register.
>
> Please note that "IRQMUX" is a misleading definition of the register in
> question.  The register programs various multifunction pins on the device
> which _may_ be IRQ outputs, LED outputs, ZV switching outputs, audio, or
> even GPIO.

TI calls it Multifunction Routing Register for a reason :)

so i think the safe way would be:
- move routing code to 12xx_override()
- first test interrupts, do nothing if working correct
- try to reflect the settings in device control register, test again
- fall back to pci if nothing works
- handle the 125x/1450 by not touching MFUNC0
- don't do INTB routing, set INTRTIE instead (on 2 slot chips)
(- remove the bad code from 2.4 and do the same)

