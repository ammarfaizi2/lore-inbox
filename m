Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTAWThF>; Thu, 23 Jan 2003 14:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266731AbTAWThF>; Thu, 23 Jan 2003 14:37:05 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:16572 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S266320AbTAWThE>; Thu, 23 Jan 2003 14:37:04 -0500
Message-ID: <3E30468A.3DAF4BF0@attbi.com>
Date: Thu, 23 Jan 2003 14:46:18 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: alternate high-res-timers patch comments (II)
References: <Pine.LNX.4.33L2.0301221712200.3511-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Here are more comments/questions on Jim's alternate high-res-timers
> patch.  Some of this is just to understand the code.
> 
> a.  Why return here and skip profiling?
>     Is this an intermediate (high-res) timer interrupt that shouldn't be
>     used for profiling?
> 
>  inline void smp_local_timer_interrupt(struct pt_regs * regs)
>  {
>         int cpu = smp_processor_id();
> +
> +       if (!run_posix_timers((void *)regs))
> +               return;
> 
>         x86_do_profile(regs);
> 
> b.  In kernel/id2ptr.c,
> 
> <id_free_cnt>:  change cnt to count; just a style thing.
> Linux doesn't use many abbreviations, which makes it easier on
> everyone not having to remember "what is the abbreviation that code
> uses for <whatever>?".
> 
> sub_alloc() is recursive.  How bounded is it?  32 calls max?
> I'm not totally against recursion, but it needs to be *well-bounded*.
> 
> Same for sub_remove().
> 

Hi Randy,

Yes, the code fragment in a) above is how the timer code shares the 
APIC timer interrupt.  There is an in-kernel "Posix style" timer
which is used to generate the profile tick.  This still needs
a bit of work to allow the profile tick rate to be set.  It defaults
to HZ.  In the long run, it might make sense to call the profiling
code from the "case TICK" in check_expiry() perhaps generalizing the interface
so that it would call through a function pointer.  There are a few 
bits of code that would benifit from having in-kernel repeating timers.
An example would be the code which syncs the hardware clock every 18 minutes.

Yes, the id allocator uses a recursive approach.  This has been discussed
before. It is well bounded, has a tiny stack frame and will never
require more than 6 levels of nesting.  I have been following the changes
George has made to his version.  This "simple problem" is a real time sink.

Jim Houston - Concurrent Computer Corp.
