Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVBQUR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVBQUR2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261184AbVBQUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:14:51 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:24202 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261194AbVBQUK7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:10:59 -0500
From: David Brownell <david-b@pacbell.net>
To: "Frank Buss" <fb@frank-buss.de>
Subject: Re: SL811 problem on mach-pxa
Date: Thu, 17 Feb 2005 12:10:56 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050217191130.B750B5B874@frankbuss.de>
In-Reply-To: <20050217191130.B750B5B874@frankbuss.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502171210.56627.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 February 2005 11:11 am, Frank Buss wrote:
> > Some of that looks reasonable, not all.  In particular, don't
> > change the convention on resources (memory to i/o), or expect
> > that the two regions involve more than one byte each ... the
> > hardware only has two single-byte registers!
> 
> ok, perhaps I've misunderstood the meaning of IORESOURCE_IO and
> IORESOURCE_MEM. Is IORESOURCE_IO for "outb" and "inb" (Intel assembler,
> don't know the Arm aquivalent)?

Yes, and there _is_ no ARM equivalent.  Modern CPUs generaly won't
bother with a separate physical I/O space, and special instructions
to access it.  So Linux drivers use macros that always boil down to
normal memory-mapped I/O accessors ... that's what ARM does, and
oddly enough all current users of this driver are on PXA hardware.

I'm not sure what the CFU1U(*) CF/PCMCIA support will need; if that
card maps those registers to I/O space, this driver will need some
minor tweaks (in addition to the PCMCIA framework glue that registers
a new platform_device).  That is, the registers would normally be
memory-mapped, but on some boards they might need to be in I/O space.

All your platform should need to do is initialize a platform_device
with the three resources (two memory, one IRQ), and platform_data
initialized to match the structure defined for that purpose.


> > That looks like the sort of thing that
> > should be done in the reset() routine rather than start(); 
> > and it should
> > certainly use a symbolic constant not 0x08.
> 
> do you mean sl811->board->reset? 

If your board is wired to support a separate chip reset (maybe
through a GPIO or something), yes; otherwise, I suppose in this
case I meant the port_power() routine should be handling that.

This driver doesn't have a separate hc_driver.reset() entry, it
does the analagous stuff as part of powering up the chip ... but
as you've noted, that approach is a bit troublesome on boards
that don't have that level of control over the hardware.

It's best to ask questions about USB drivers on linux-usb-devel,
not all USB developers make time to swim through LKML.

- Dave

(*) http://www.ratocsystems.com/english/products/subpages/cfu1u.html
    CompactFlash single-port USB host adapter, for PDAs, using
    the SL811HS chip.

