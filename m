Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWDGDHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWDGDHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 23:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDGDHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 23:07:21 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:39559
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932302AbWDGDHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 23:07:21 -0400
Date: Thu, 6 Apr 2006 20:07:13 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060407030713.GA9623@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060406073753.GA18349@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2006 at 09:37:53AM +0200, Ingo Molnar wrote:
> do "global" decisions for what RT tasks to run on which CPU. To put even 
> less overhead on the mainstream kernel, i plan to introduce a new 
> SCHED_FIFO_GLOBAL scheduling policy to trigger this behavior. [it doesnt 
> make much sense to extend SCHED_RR in that direction.]

Ingo,

You should consider for a moment to allow for the binding of a thread to
a CPU to determine the behavior of a SCHED_FIFO class task instead of 
creating a new run category. Trying to anticipate the behavior of a
thread via a kernel semantic removes control from the applications using
them and into the kernel which is often incorrect about those assumption.

Con might have comments the matter that might be useful.

The current IPI method you use to balance RT is fine. I don't think it
should be changed for the general SCHED_FIFO case, but I do think that
binding a thread to a certain CPU, or set of CPUs, would simplify various
control cases, where the default case is to rebalance immediately via an
IPI. Having a specific case only running on a specific CPU or CPU set
should be the only mechanism to either "isolate" a CPU or create a
condition that's more deterministic than a global policy that -rt is
doing now.
 
This is consistent to how I would use it in an app and wouldn't create
clutter in scheduling code that is already under minor refactoring.

> my gut feeling is that it would be wrong to integrate this feature into 
> smpnice: SCHED_FIFO is about determinism, and smpnice is a fundamentally 
> statistical approach. Also, smpnice doesnt have to try as hard to pick 
> the right task as rt_overload does, so there would be constant 
> 'friction' between "overhead" optimizations (dont be over-eager) and 
> "latency" optimizations (dont be _under_-eager). So i'm quite sure we 
> want this feature separate. [nevertheless i'd happy to be proven wrong 
> via some good and working smpnice based solution]

Please consider the ideas I've mentioned above and research how other
RTOSes deal with these critical issues.

Thanks

bill

