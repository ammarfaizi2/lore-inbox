Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbUKVT7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUKVT7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 14:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbUKVT6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 14:58:15 -0500
Received: from fmr99.intel.com ([192.55.52.32]:19657 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S262551AbUKVT40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 14:56:26 -0500
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
From: Len Brown <len.brown@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Chris Wright <chrisw@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411201048470.20993@ppc970.osdl.org>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <Pine.LNX.4.58.0411200940410.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411201048470.20993@ppc970.osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1101153314.20008.95.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 14:55:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 14:10, Linus Torvalds wrote:
> 
> On Sat, 20 Nov 2004, Linus Torvalds wrote:
> >
> > In particular, the code will disable irq12 (mouse interrupt), so the
> mouse
> > has no chance of working.
> 
> Btw, looking closer still, this all will most likely vary wildly
> according to southbridge (and BIOS setups). At least some SB's seem to
> put the legacy interrupts totally separately from the PIRQ stuff, in
> which case the PIRQ disable will not matter one whit - the legacy
> interrupt is inserted "after" the PIRQ gating/translation anyway. This
> seems to be especially common for controllers for keyboard/mouse/i2c
> etc that are actually on the southbridge itself.

Right, programming a PIRQ router to an IRQ doesn't mean that a legacy
device isn't still attached to that IRQ.

> But the basic notion remains: disabling a PIRQ line is valid only if
> you know it's only used by PCI devices. There might be other special
> devices on the board that don't show up as PCI devices, eg things like
> the Sony programmable I/O thing that doesn't show up as a PCI device
> at all, it's just "invisibly" connected to the bus (it just hijacks
> port 0x66 or something - the range 0-0x3ff is generally reserved for
> "motherboard devices").

> These kinds of things hopefully aren't all that common (there can't be
> a lot of extra hw required to follow the PCI spec _properly_), but if
> I were a hw designer, I'd connect such a chip to the PIRQ input, and
> just make the BIOS enable it automatically.

While there may be non-standard non-PCI legacy devices that
(erroneously) use PIRQ routers on legacy systms, that isn't the issue at
hand.

The issue at hand is what to do in ACPI mode.

ACPI PCI Interrupt Link Devices, by definition, are used only by PCI
devices, or devices that look like them.  You look up the device in the
_PRT by its devid.  Although links are often implemented underneath by
PIRQ routers, they are much more general.  ACPI PCI Interrupt Links can
specificy any trigger/polarity, as well as connect to IOAPIC inputs.

If there is "special" hardware using an ACPI PCI Interrupt Link without
being listed in the DSDT _PRT that describes the link, then the BIOS is
simply broken.

-Len



