Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTHTVxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTHTVxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:53:47 -0400
Received: from fmr01.intel.com ([192.55.52.18]:58564 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S262245AbTHTVxp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:53:45 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH][2.6][5/5]Support for HPET based timer
Date: Wed, 20 Aug 2003 10:51:39 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1D7@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][5/5]Support for HPET based timer
Thread-Index: AcNm9reljKoYKRXaTDyCHmVtAFQBmAARidLg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 20 Aug 2003 17:51:40.0141 (UTC) FILETIME=[B57661D0:01C36743]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vojtech Pavlik [mailto:vojtech@suse.cz] 
> On Tue, Aug 19, 2003 at 06:28:40PM -0700, Pallipadi, Venkatesh wrote:
> > 
> Yes, that is a problem. We could do some switchover from PIT 
> to HPET (or
> from legacy to IOAPIC IRQs) after APICs are initialized, 
> though I don't
> like the idea very much. Best would be to remove the dependence on the
> timer interrupt ticking so early. Or moving APIC detection earlier.

I agree. Depending both on PIT and HPET is not a clean solution. Also, I
am not that 
comfortable with moving APIC detection earlier, as it can possibly break
different
things on different platforms. It will surely need lot more testing. 

The way I got standard mode to work was by removing the dependency on
the early timer tick.
IIRC, the dependency is basically coming from Bogomips calculation and
also halt_works_ok
check. We can try and delay this until IOAPIC initialization.

> Well, the APIC should have quite a number of free pins, which 
> means that
> the HPET shouldn't need to share an interrupt. 

We interacted with some server folks, and they were of the opinion that
they may not be able to give a dedicated interrupt for HPET, as already
they have too many devices sitting on PCI these days. If they have to
give a dedicated IRQ for HPET, they may have to share some other
devices, which may result in performance loss. Another reason against it
was, if they give a dedicated IRQ and the OS decides against using HPET
(or older version of OS), then an IRQ will be needlessly wasted (kind of
a chicken and egg problem).

> Regarding lost and late
> delivered timer interrupts - that happens nevertheless with drivers
> disabling interrupts for a long time. The kernel timekeeping code can
> cope with that.

I agree that kernel can cope with the timer interrupt inaccuracy. But,
IMO, delays due to driver disabling the interrupts is more of an
exception case. With timer in shared interrupt, this will become more of
a common case.

Our thinking was to have a two phased approach. Have the legacy mode
enabled first. Make sure that the code around HPET interrupts is fully
optimized and is working fine. This mode is any way _required_ for
systems without IOAPIC and systems running UP kernels / with IOAPIC
disabled. Later we can add an option to use HPET standard mode.

Thanks,
-Venkatesh 


