Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSL0Xb5>; Fri, 27 Dec 2002 18:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSL0Xb5>; Fri, 27 Dec 2002 18:31:57 -0500
Received: from m68-mp1.cvx3-a.ren.dial.ntli.net ([213.104.120.68]:56311 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265306AbSL0Xb4>; Fri, 27 Dec 2002 18:31:56 -0500
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	ore than 8 CPUs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       "''William Lee Irwin III' '" <wli@holomorphy.com>,
       "''Christoph Hellwig' '" <hch@infradead.org>,
       "''James Cleverdon' '" <jamesclv@us.ibm.com>,
       "\"''Pallipadi, Venkatesh' \"'" <venkatesh.pallipadi@intel.com>,
       "''Linux Kernel' '" <linux-kernel@vger.kernel.org>,
       "''Martin Bligh' '" <mbligh@us.ibm.com>,
       "''John Stultz' '" <johnstul@us.ibm.com>,
       "''Nakajima, Jun' '" <jun.nakajima@intel.com>,
       "''Mallick, Asit K' '" <asit.k.mallick@intel.com>,
       "''Saxena, Sunil' '" <sunil.saxena@intel.com>,
       "''Andi Kleen' '" <ak@suse.de>, "''Hubert Mantel' '" <mantel@suse.de>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C0101F568@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C0101F568@usslc-exch-4.slc.unisys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Dec 2002 23:38:21 +0000
Message-Id: <1041032301.1157.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-26 at 02:18, Van Maren, Kevin wrote:
> If you have a suggestion on how to do that, I am sure we would
> all be grateful to hear it.
> 
> Note that the reason the code _exists_ is because the interrupt
> lines are physically connected to different pins on the APIC
> than they are in "normal" systems.  The legitimacy of that
> decision is not up for debate at this point -- that is the way
> the system was built, and Linux needs to deal with it in
> order to run on it.

The IRQ number is a cookie. Linux knows that on x86 ISA IRQ is mapped
0-15 and the ISA drivers sometimes know about this stuff too. What
exception number comes back off the processor and what function you call
is really quite unrelated. So request/free_irq functionality in the i386
layer can happily remap the irqs back and forth so ISA comes 0-15, and
keep the drivers and core oblivious to this.

> So the PCI interrupts are in the table at IRQs < 16 (because
> it tells which pin is being used), which makes it difficult
> to tell whether a PCI or an ISA interrupt is being requested
> if you tell the code "irq 3": if ISA, you need to use pin f(X),
> while if PCI, you use pin X.

Internal detail - doesnt matter for how you number IRQ's outside of your
arch/i386/kernel internal bits

> ACPI should have the ISA redirection information, but as
> Natalie was saying, drivers hard-code the ISA vectors without
> checking the ACPI info.

ACPI is basically PC specific gunge. Drivers don't and should not know
about it.

> I suppose it would be possible to detect the ES7000 and have
> the kernel re-write the PCI vectors (say, add 16 to them all)

Linux doesn't touch the PCI interrupt line values or really care about
them, so thats trivial to do.

> and then re-mangle them based on a "< 16" criteria.
> But I don't believe that is a "clean" solution either
> (and would break when the ACPI isa redirection table is
> properly used).

No because any ACPI ISA redirect must be done portably, so used to keep
the ISA irq's logically 0-15 on x86

> 
> Anyway, this was the reason for the "severe irq override"
> comment by Natalie.

I understand why it was done - I think its the wrong abstraction as it
pushes too much board knowledge into drivers and into places that make
assumptions about ISA (a legacy of Linux original design being for ISA
PC)

