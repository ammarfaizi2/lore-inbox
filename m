Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbTH3Q0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 12:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbTH3Q0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 12:26:42 -0400
Received: from fmr09.intel.com ([192.52.57.35]:25575 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261484AbTH3Q0k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 12:26:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Date: Sat, 30 Aug 2003 09:26:38 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D225@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCHSET][2.6-test4][0/6]Support for HPET based timer - Take 2
Thread-Index: AcNus6wiUrR0Dd5xTaWqQNJvSc9NPgAXEv3w
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <David.Mosberger@acm.org>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 30 Aug 2003 16:26:38.0961 (UTC) FILETIME=[7D0D9610:01C36F13]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: David Mosberger-Tang [mailto:davidm@mostang.com]
> >>>>> On Fri, 29 Aug 2003 09:12:52 -0700, "Pallipadi, 
> Venkatesh" <venkatesh.pallipadi@intel.com> said:
> 
>   Venkatesh> The part of the patch that does the HPET initialization
>   Venkatesh> for timer interrupt, and general HPET registers
>   Venkatesh> read/write/programming can be common across
>   Venkatesh> architectures.  However, different archs diverge, when it
>   Venkatesh> comes to gettimeofday-timer implementation (tsc, pit,
>   Venkatesh> itc, hpet, ) and we may still have to keep that part
>   Venkatesh> architecture specific.
> 
> Is the time_interpolator interface provided by timex.h sufficient for
> HPET timer-interrupt needs?  I think It ought to be.  If so, perhaps
> all that's missing is that x86 needs to be switched over to that
> interface?
> 

timer_interpolator kind of interface helps for one part of HPET changes.
That is using HPET during gettimeofday(). Unfortunately, i386 has its
own timer infrastructure (which is quite similar to timer_interpolator),
which is already being used by variety of timers that exist (cyclone_timer,
tsc, pit - code under arch/i386/kernel/timers). i386 timers seems to be 
the superset of timer_interpolator.
struct timer_opts{
        int (*init)(char *override);
        void (*mark_offset)(void);
        unsigned long (*get_offset)(void);
        unsigned long long (*monotonic_clock)(void);
        void (*delay)(unsigned long);
};
I agree, in future, it is best to integrate these timers in an 
architecture independent way. 

The other part of HPET change is, change in kernel base timer. In i386, 
along with local APIC timer interrupts, we also have a IRQ0 timer interrupt.
This is where kernel time-keeping happens (similar to TIME_KEEPER_ID in IPF).
This will also used for process times in UP case, when there is no LAPIC.
As of now this interrupt comes from PIT/8254. HPET will replace this too, 
and can be programmed to generate periodic interrupts at a particular rate.
This part may be specific to i386.


Thanks,
-Venkatesh

