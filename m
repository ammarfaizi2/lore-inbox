Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbSLZCKe>; Wed, 25 Dec 2002 21:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSLZCKe>; Wed, 25 Dec 2002 21:10:34 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:12745 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S261799AbSLZCKd>; Wed, 25 Dec 2002 21:10:33 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C0101F568@usslc-exch-4.slc.unisys.com>
From: "Van Maren, Kevin" <kevin.vanmaren@unisys.com>
To: "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
Cc: "''William Lee Irwin III' '" <wli@holomorphy.com>,
       "''Christoph Hellwig' '" <hch@infradead.org>,
       "''James Cleverdon' '" <jamesclv@us.ibm.com>,
       "''Pallipadi, Venkatesh' '" <venkatesh.pallipadi@intel.com>,
       "''Linux Kernel' '" <linux-kernel@vger.kernel.org>,
       "''Martin Bligh' '" <mbligh@us.ibm.com>,
       "''John Stultz' '" <johnstul@us.ibm.com>,
       "''Nakajima, Jun' '" <jun.nakajima@intel.com>,
       "''Mallick, Asit K' '" <asit.k.mallick@intel.com>,
       "''Saxena, Sunil' '" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "''Andi Kleen' '" <ak@suse.de>, "''Hubert Mantel' '" <mantel@suse.de>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m
	 ore than 8 CPUs
Date: Wed, 25 Dec 2002 20:18:27 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One thing I will say. Your code would be a hell of a lot saner for
> merging if you mapped the ISA/Legacy IRQ's as 0-15 (to software) and the
> PCI ones to 16+ like everyone else does. That would kill a _lot_ of
> ifdefs and the IRQ0 corner case

If you have a suggestion on how to do that, I am sure we would
all be grateful to hear it.

Note that the reason the code _exists_ is because the interrupt
lines are physically connected to different pins on the APIC
than they are in "normal" systems.  The legitimacy of that
decision is not up for debate at this point -- that is the way
the system was built, and Linux needs to deal with it in
order to run on it.

So the PCI interrupts are in the table at IRQs < 16 (because
it tells which pin is being used), which makes it difficult
to tell whether a PCI or an ISA interrupt is being requested
if you tell the code "irq 3": if ISA, you need to use pin f(X),
while if PCI, you use pin X.

ACPI should have the ISA redirection information, but as
Natalie was saying, drivers hard-code the ISA vectors without
checking the ACPI info.

I suppose it would be possible to detect the ES7000 and have
the kernel re-write the PCI vectors (say, add 16 to them all)
and then re-mangle them based on a "< 16" criteria.
But I don't believe that is a "clean" solution either
(and would break when the ACPI isa redirection table is
properly used).

Anyway, this was the reason for the "severe irq override"
comment by Natalie.

Kevin
