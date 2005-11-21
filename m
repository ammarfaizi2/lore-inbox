Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbVKUVu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVKUVu3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVKUVu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:50:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32931 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751072AbVKUVu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:50:28 -0500
Date: Mon, 21 Nov 2005 13:49:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Ingo Molnar <mingo@elte.hu>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.64.0511211339450.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
 <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu>
 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Paul Mackerras wrote:
> 
> Yes, G5 powermacs have the SATA controller on irq 0.  So if we can't
> use irq 0, I can't get to my hard disk. :)  Other powermacs also use
> irq 0 for various things, as do embedded PPC machines.

That doesn't change any of the logic. There already is no "1:1" mapping of 
PCI interrupts to what the machine does.

On all PC hardware, having a zero in the PCI irq register basically means 
that no irq is enabled. That's a _fact_. It's a fact however much you may 
not like it. It's how the hardware comes up, and it's how the BIOS leaves 
it. So "0" absolutely does mean "not allocated". 

Now, the second part of the story is that when it comes to PCI, it doesn't 
matter what Apple, Sun, or pretty much anybody else has done.  The reason 
PCI has a separate MMIO and IO space is that it comes from a PC 
background, and the reason Apple and others use PCI is that through that, 
there are thousands of controller cards that are sold for PC's that also 
happen to work on non-PC's.

So PC usage really is a defining part of PCI. It's what defines basically 
_all_ of the testing, even under Linux. 

So let's face those facts:
 - we have a 8-bit register (0-255) for firmware telling the kernel what 
   the pre-allocated interrupt is.
 - all of those 256 numbers _may_ in fact be valid on some piece of 
   hardware.
 - only one of those numbers (0) is de-facto the "no irq line set up" 
   value.
 - pretty much all drivers have been tested mainly with 0 being the "no 
   irq" value.

Those are FACTS. Denying them is a sign of stupidity.

I'd suggest that if some architecture can't live with those facts, it 
either:

 - define it's own PCI_NO_IRQ value, and face the fact that it will have 
   to test the drivers and hope they work (and that a lot of them simply 
   will _not_ work). 

   This is what we have today. It mostly works. Maybe we shouldn't change 
   it.

 - realize that 0 is special, and use another number for when firmware 
   tells it 0 _is_ actually a valid irq (maybe 256. Maybe "1u<<31". I 
   don't care.)

And I won't apply the "turn PCI_NO_IRQ" into -1 generally, because I 
consider it to be strictly _worse_ than what we have now.

Comprende?

		Linus
