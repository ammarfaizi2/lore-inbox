Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261529AbTHTBab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 21:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbTHTBab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 21:30:31 -0400
Received: from fmr09.intel.com ([192.52.57.35]:12282 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261529AbTHTBa1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 21:30:27 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH][2.6][2/5]Support for HPET based timer
Date: Tue, 19 Aug 2003 18:30:10 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1CF@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.6][2/5]Support for HPET based timer
Thread-Index: AcNmpHpTOcueUqPtT76X42EcX180QQAEPQrw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Andi Kleen" <ak@muc.de>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Aug 2003 01:30:11.0189 (UTC) FILETIME=[98E96A50:01C366BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The timer stuff in kernel is divided into two levels:
1) Base kernel timer, the one that generates periodic timer interrupt on
IRQ 0. There is also associated initializations like APIC timer
initialization in case of SMP,
which again depends on the timer hardware. As of now, kernel has only
have PIT 
in this level.

2) Various timers under arch/i386/kernel/timers, basically used during
gettimeofday().
we currently have different timers here like, timer_cyclone, timer_tsc
or timer_pit. 
This part has a clean infrastructure to add and/or prioritize different
timers.


With HPET support we are changing stuff at both the levels.
1) We use HPET hardware to generate HZ interrupts on IRQ 0. This is the
change that
is there in PATCH 2/5. Unfortunately, we cannot use the existing timers
infrastructure 
for this part. We tried to keep the changes here as less as possible.
But, still had to
do changes in apic.c as it was assuming PIT for base timer. And the
other change is in
time.c, wherein we have to calibrate/initialize HPET for base timer, in
place of PIT.
The reason we kept timer_hpet.c in arch/i386/kernel is because it has
more to do with
initialization of the base-kernel-timer, than the gettimeofday-timer.

2) The timers for gettimeofday will change too, with HPET. The timer
list will be 
something like, timer_cyclone, timer_hpet, timer_tsc. This change is
there in 
PATCH 3/5. This change uses the exisiting timer infrastructure in 
arch/i386/kernel/timers


Thanks,
-Venkatesh

> -----Original Message-----
> From: Andi Kleen [mailto:ak@muc.de] 
> Sent: Tuesday, August 19, 2003 3:41 PM
> To: Pallipadi, Venkatesh
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
> 
> 
> "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:
> 
> >  /*
> > + * Default initialization for 8254 timers. If we use other 
> timers like HPET,
> > + * we override this later 
> > + */
> > +void (*wait_timer_tick)(void) = wait_8254_wraparound;
> 
> It would be much cleaner to just poll the generic monotonic 
> time source here,
> not add more special cases.
> 
> > diff -purN linux-2.6.0-test1/arch/i386/kernel/time_hpet.c 
> linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c
> > --- linux-2.6.0-test1/arch/i386/kernel/time_hpet.c	
> 1969-12-31 16:00:00.000000000 -0800
> > +++ linux-2.6.0-test1-hpet/arch/i386/kernel/time_hpet.c	
> 2003-08-18 20:22:06.000
> 000000 -0700
> 
> Shouldn't that be in arch/i386/kernel/timers/hpet.c ? 
> 
> Also I suspect it should be made an generic timer object there with
> a timer_ops structure. If some hook for that is missing it 
> could be added to 
> timer_ops and timers/timer.c
> 
> When there is already a generic framework to add new timers 
> it would be a shame
> not to use it.
> 
> -Andi
> 
