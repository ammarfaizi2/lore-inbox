Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTEPVrz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTEPVrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:47:55 -0400
Received: from palrel13.hp.com ([156.153.255.238]:3532 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261192AbTEPVry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:47:54 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16069.24454.349874.198470@napali.hpl.hp.com>
Date: Fri, 16 May 2003 15:00:38 -0700
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, Arjan van de Ven <arjanv@redhat.com>,
       john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org,
       David Mosberger <davidm@napali.hpl.hp.com>
Subject: Re: time interpolation hooks
In-Reply-To: <20030516142311.3844ee97.akpm@digeo.com>
References: <20030516142311.3844ee97.akpm@digeo.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 16 May 2003 14:23:11 -0700, Andrew Morton <akpm@digeo.com> said:

  Andrew> It will need per-arch support.  I'm not sure what that looks
  Andrew> like; maybe David can outline what the reset/update
  Andrew> functions should do?

See below.

  Andrew> (Those function pointers should go away in favour of
  Andrew> optionally-stubbed-out static calls.  Minor point).

Really?  On ia64, we want to use cycle-based interpolation by default,
but if firmware indicates that the cycle-counters may drift, we want
to switch to one of several possible external counters (which counter
gets used depends on hardware/drivers are is present).  Yes, we could
have a static call into ia64 specific code and then do an indirection
there, but if most platforms need an indirect call (I suspect they
do), it makes more sense to have the indirection directly in the core
code (especially if you believe Linus' mantra that indirect calls are
only going to get cheaper).

Anyhow, back to the reset/update functions:

For cycle-counter-based interpolation, the relevant file is this one:

http://lia64.bkbits.net:8080/linux-ia64-2.5/anno/arch/ia64/kernel/time.c@1.24

Functions ia64_reset_wall_time() and ia64_update_wall_time() are what
the hooks would normally point to.  Note that there is also an
important matching piece that updates last_nsec_offset in
do_gettimeofday().

(ia64_gettimeoffset() also reads last_nsec_offset, but only to handle
a rare error-case).

An example of the callback routines for an external high-precision
counter can be found here:

http://lia64.bkbits.net:8080/linux-ia64-2.5/anno/arch/ia64/sn/kernel/sn2/timer.c@1.2

in functions sn2_update_wall_time() and sn2_reset_wall_time().  Note
that sn2_update_wall_time() needs to be updated to decrement
rtc_offset based on delta_nsec instead of rtc_per_timer_tick, but
since this isn't my code and since I added the delta_nsec offset only
recently, this hasn't been done yet.

The ia64 implementation does rely on having single-word cmpxchg.  On
platforms that don't have this, it should be possible to emulate
cmpxchg with a spinlock, but you'd obviously end up serializing
concurrent gettimeofday() calls.  And, in case it isn't obvious,
platforms that do not use time-interpolation don't have to do
anything, as the callbacks will default to doing nothing.

	--david
