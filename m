Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWDFHkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWDFHkk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 03:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932143AbWDFHkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 03:40:40 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:14215 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932136AbWDFHkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 03:40:40 -0400
Date: Thu, 6 Apr 2006 09:37:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Darren Hart <darren@dvhart.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060406073753.GA18349@elte.hu>
References: <200604052025.05679.darren@dvhart.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604052025.05679.darren@dvhart.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Darren Hart <darren@dvhart.com> wrote:

> My last mail specifically addresses preempt-rt, but I'd like to know 
> people's thoughts regarding this issue in the mainline kernel.  Please 
> see my previous post "realtime-preempt scheduling - rt_overload 
> behavior" for a testcase that produces unpredictable scheduling 
> results.

the rt_overload feature i intend to push upstream-wards too, i just 
didnt separate it out of -rt yet.

"RT overload scheduling" is a totally orthogonal mechanism to the SMP 
load-balancer (and this includes smpnice too) that is more or less 
equivalent to having a 'global runqueue' for real-time tasks, without 
the SMP overhead associated with that. If there is no "RT overload" [the 
common case even on Linux systems that _do_ make use of RT tasks 
occasionally], the new mechanism is totally inactive and there's no 
overhead. But once there are more RT tasks than CPUs, the scheduler will 
do "global" decisions for what RT tasks to run on which CPU. To put even 
less overhead on the mainstream kernel, i plan to introduce a new 
SCHED_FIFO_GLOBAL scheduling policy to trigger this behavior. [it doesnt 
make much sense to extend SCHED_RR in that direction.]

my gut feeling is that it would be wrong to integrate this feature into 
smpnice: SCHED_FIFO is about determinism, and smpnice is a fundamentally 
statistical approach. Also, smpnice doesnt have to try as hard to pick 
the right task as rt_overload does, so there would be constant 
'friction' between "overhead" optimizations (dont be over-eager) and 
"latency" optimizations (dont be _under_-eager). So i'm quite sure we 
want this feature separate. [nevertheless i'd happy to be proven wrong 
via some good and working smpnice based solution]

in any case, i'll check your -rt testcase to see why it fails.

	Ingo
