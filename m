Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbTAWTwP>; Thu, 23 Jan 2003 14:52:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264986AbTAWTwP>; Thu, 23 Jan 2003 14:52:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33955 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261523AbTAWTwO>;
	Thu, 23 Jan 2003 14:52:14 -0500
Date: Thu, 23 Jan 2003 11:55:50 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jim Houston <jim.houston@attbi.com>
cc: <high-res-timers-discourse@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: alternate high-res-timers patch comments (II)
In-Reply-To: <3E30468A.3DAF4BF0@attbi.com>
Message-ID: <Pine.LNX.4.33L2.0301231150120.6515-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2003, Jim Houston wrote:

| > Here are more comments/questions on Jim's alternate high-res-timers
| > patch.  Some of this is just to understand the code.
| >
| > a.  Why return here and skip profiling?
| >     Is this an intermediate (high-res) timer interrupt that shouldn't be
| >     used for profiling?
| >
| >  inline void smp_local_timer_interrupt(struct pt_regs * regs)
| >  {
| >         int cpu = smp_processor_id();
| > +
| > +       if (!run_posix_timers((void *)regs))
| > +               return;
| >
| >         x86_do_profile(regs);
| >
| > b.  In kernel/id2ptr.c,
| >
| > <id_free_cnt>:  change cnt to count; just a style thing.
| > Linux doesn't use many abbreviations, which makes it easier on
| > everyone not having to remember "what is the abbreviation that code
| > uses for <whatever>?".
| >
| > sub_alloc() is recursive.  How bounded is it?  32 calls max?
| > I'm not totally against recursion, but it needs to be *well-bounded*.
| >
| > Same for sub_remove().
| >
|
| Hi Randy,
|
| Yes, the code fragment in a) above is how the timer code shares the
| APIC timer interrupt.  There is an in-kernel "Posix style" timer
| which is used to generate the profile tick.  This still needs
| a bit of work to allow the profile tick rate to be set.  It defaults
| to HZ.  In the long run, it might make sense to call the profiling
| code from the "case TICK" in check_expiry() perhaps generalizing the interface
| so that it would call through a function pointer.  There are a few
| bits of code that would benifit from having in-kernel repeating timers.
| An example would be the code which syncs the hardware clock every 18 minutes.
|
| Yes, the id allocator uses a recursive approach.  This has been discussed
| before. It is well bounded, has a tiny stack frame and will never
| require more than 6 levels of nesting.  I have been following the changes
| George has made to his version.  This "simple problem" is a real time sink.

Ah, I think I recall akpm commenting on that.
Yes, I noticed it is a small stack requirement, and being so bounded
doesn't seem like a problem to me.

Thanks,
-- 
~Randy

