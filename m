Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbTLRWij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265364AbTLRWij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:38:39 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:22695 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S265237AbTLRWig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:38:36 -0500
Subject: Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
From: john stultz <johnstul@us.ibm.com>
To: John Hawkes <hawkes@babylon.engr.sgi.com>
Cc: ia64 <linux-ia64@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com>
Content-Type: text/plain
Message-Id: <1071787066.1117.57.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 18 Dec 2003 14:37:47 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-18 at 12:44, John Hawkes wrote:
> David Mosberger suggests raising this issue on LKML to encourage a search
> for a more general solution to my ia64 problem.
> 
> My specific problem is that the generic ia64 sched_clock() is broken for
> "drifty ITC" (the per-CPU cycle counter clock) platforms, such as the SGI
> sn.  sched_clock() currently uses its local CPU's ITC and therefore on
> drifty platforms its values are not synchronized across the CPUs.  This
> results (in part) in an invalid load_balance() is-the-cache-hot-or-not
> calculation.

[snip]

> My personal preference is to keep sched_clock() semantics unchanged (i.e.,
> to presume that all CPU values are synchronized), and to bury non-compliant
> platform complexity in arch-specific and platform-specific implementations,
> rather than add any unnecessary complications to sched.c.
> 
> As a reference point, the current i386 2.6.0-test11 algorithm is platform-
> specific and is, in my opinion, less clean than the arch/ia64 change I have
> proposed:  all i386 NUMA platforms are forced to use the low-resolution
> "jiffies" value as the only officially synchronized timebase.  (However,
> with my sched.c patch, it is possible that i386 NUMA platforms could use the
> unsynchronized higher resolution TSC.)

I've tried switching sched_clock() to call monotonic_clock() on i386
(both functions do basically the same thing, only monotonic_clock
redirects to the system's chosen time source). However,the consensus was
that the access time to read the systems non-"drifty" time source can be
too expensive to make it worth while. 

I'll concede that I haven't done enough testing to measure it in any
great detail, but the interest in my patch was very very low. So I'd be
interested in any measurements you have to the contrary.

Personally, I'd keep your changes arch specific for 2.6. When 2.7 opens
I'd be very interested in ideas and input for broader change in the time
subsystem.

thanks
-john

