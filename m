Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVEEFeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVEEFeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 01:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261896AbVEEFeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 01:34:17 -0400
Received: from fmr24.intel.com ([143.183.121.16]:28880 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261895AbVEEFeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 01:34:06 -0400
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
From: Len Brown <len.brown@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Asit K Mallick <asit.k.mallick@intel.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <20050502190850.GN7342@wotan.suse.de>
References: <20050429172605.A23722@unix-os.sc.intel.com>
	 <20050502163821.GE7342@wotan.suse.de>
	 <20050502101631.A4875@unix-os.sc.intel.com>
	 <20050502190850.GN7342@wotan.suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1115271213.7637.126.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 05 May 2005 01:33:33 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re: no idle tick

Idle power savings does not by itself justify HZ=0.
We'll get the same idle power consumption with HZ=1.

Indeed, within measurement error, we'll get the same
idle power consumption with HZ=10.

Linux should probably default to HZ=100, and have
the capability to speed up to HZ=1000 at run-time
if applications request it; and it should slow down
to HZ=10 in deep idle.

If we keep HZ=10 in idle rather than going all
the way to HZ=0, it allows the C-state promotion code
to work without any special cases to wake the system
when idle just to promote to a deeper C-state --
i.e. like it works today.

Re: multiple LAPIC rates on SMP

This concept doesn't work when it is needed (C3)
and isn't needed when it works (C1/C2).

This is because the LAPIC timer stops in C3,
and the latencies in C1/C2 are so low that
it doesn't matter what the tick rate is.

Re: using TSC to patch things up

Nope.  TSC is variable on some processors with P-states,
and on some processors it stops in C3.

I'm not happy about this reality either.

Re: LAPIC timer vs P-states

On the systems I'm aware of, LAPIC timer is based
on the bus speed rather than the core speed.  So
today it should be constant or zero -- that is until
some HW guy decides to throttle the bus at run-time
to save power.  Based on the history of the TSC --
frozen in C3 and sometimes variable with MHz changes;
it would not surprise me a bit to see the LAPIC, now
frozen in C3, become variable in some future power
saving state that varies bus speed.

Re: re-calibrating the un-frozen LAPIC timer 

I think we're on thin-ice if we endeavor to continue
to use the LAPIC timer.  The multiple LAPIC rates
on SMP concept is defunct (above), so the only benefit
of using the LAPIC timer is that it is lower latency
to re-program it when we re-program the global rate.
But then we have to do this on all logical processors
and we have to add the code correct it with a
stable reference time-source.

This must be compared to simply using the stable
reference time-source in the first place, and perhaps
not changing its rate as frequently.

Re: what to do?

A proposal:
1. disable LAPIC timer use on uni-processor
   it adds no value, and breaks if C3 is supported.
2. disable LAPIC timer use on SMP, via
   Venki's timer broadcast patch, or similar.
3. Transparently use HZ=10 in "deep idle"
   This can be done the same way that C-state
   promotions are done -- when we recognize
   that we're still idle after a long time,
   take steps to get into a deeper state.
   eg. we might say that entry to C3 or C4
   is "deep idle", or better yet, we might
   base this on the advertised latency of
   the C-states since low latency states will
   not notice clock ticks and high-latency
   states will become ineffective if ticks
   are too frequent.
4. Apply "boot-time dynamic HZ" patch, and default
   to hz=100.
5. Move to real "run-time dynamic HZ" where the
   system HZ can be changed by programs that need
   it changed.

thoughts?

-Len


