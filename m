Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUAFRG3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 12:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUAFRG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 12:06:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:52360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264546AbUAFRGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 12:06:23 -0500
Date: Tue, 6 Jan 2004 09:05:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: James.Bottomley@SteelEye.com, johnstultz@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix get_jiffies_64 to work on voyager
Message-Id: <20040106090545.6e906493.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
References: <1073405053.2047.28.camel@mulgrave>
	<20040106081947.3d51a1d5.akpm@osdl.org>
	<Pine.LNX.4.58.0401060826570.2653@home.osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 6 Jan 2004, Andrew Morton wrote:
> > 
> > Hm, OK.  I hit the same deadlock when running with the "don't require TSCs
> > to be synchronised in sched_clock()" patch from -mm.  The fix for that is
> > below.  I shall accelerate it.
> > 
> > --- 25/arch/i386/kernel/timers/timer_tsc.c~sched_clock-2.6.0-A1-deadlock-fix	2003-12-30 00:45:09.000000000 -0800
> > +++ 25-akpm/arch/i386/kernel/timers/timer_tsc.c	2003-12-30 00:45:09.000000000 -0800
> > @@ -140,7 +140,8 @@ unsigned long long sched_clock(void)
> >  #ifndef CONFIG_NUMA
> >  	if (!use_tsc)
> >  #endif
> > -		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
> > +		/* jiffies might overflow but this is not a big deal here */
> > +		return (unsigned long long)jiffies * (1000000000 / HZ);
> 
> Augh. If you cast it to "unsigned long long" anyway, why not just use the 
> right value? It's "jiffies_64".

Sounds sane.

> It has other problems, of course, but at least that makes them slightly 
> less.

Yes, it's slightly sleazy.

I haven't tested this...


From: Ingo Molnar <mingo@elte.hu>

Voyager is getting odd deadlocks due to the taking of xtime_lock() in
sched_clock()->get_jiffies_64().

I had this patch queued up to fix a different deadlock, which ocurs when we
relax the requirement that TSC's be synchronised across CPUs.  But it will
fix James' deadlock too.




 arch/i386/kernel/timers/timer_tsc.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/timers/timer_tsc.c~sched_clock-2.6.0-A1-deadlock-fix arch/i386/kernel/timers/timer_tsc.c
--- 25/arch/i386/kernel/timers/timer_tsc.c~sched_clock-2.6.0-A1-deadlock-fix	2004-01-06 08:56:36.000000000 -0800
+++ 25-akpm/arch/i386/kernel/timers/timer_tsc.c	2004-01-06 08:58:37.000000000 -0800
@@ -140,7 +140,12 @@ unsigned long long sched_clock(void)
 #ifndef CONFIG_NUMA
 	if (!use_tsc)
 #endif
-		return (unsigned long long)get_jiffies_64() * (1000000000 / HZ);
+		/*
+		 * Avoid xtime_lock deadlocks by not locking the read of
+		 * jiffies_64.  Can possibly cause glitches on 32-bit rollovers
+		 * but the CPU scheduler will recover OK.
+		 */
+		return jiffies_64 * (1000000000 / HZ);
 
 	/* Read the Time Stamp Counter */
 	rdtscll(this_offset);

_

