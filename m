Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266695AbUGUVBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUGUVBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266736AbUGUVBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:01:45 -0400
Received: from host-65-117-135-105.timesys.com ([65.117.135.105]:26252 "EHLO
	yoda.timesys") by vger.kernel.org with ESMTP id S266695AbUGUVB3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:01:29 -0400
Date: Wed, 21 Jul 2004 17:00:51 -0400
To: Scott Wood <scott@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, linux-audio-dev@music.columbia.edu,
       arjanv@redhat.com, linux-kernel <linux-kernel@vger.kernel.org>,
       "La Monte H.P. Yarroll" <piggy@timesys.com>
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040721210051.GA2744@yoda.timesys>
References: <20040712163141.31ef1ad6.akpm@osdl.org> <1089677823.10777.64.camel@mindpipe> <20040712174639.38c7cf48.akpm@osdl.org> <20040719102954.GA5491@elte.hu> <1090380467.1212.3.camel@mindpipe> <20040721000348.39dd3716.akpm@osdl.org> <20040721053007.GA8376@elte.hu> <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040721183010.GA2206@yoda.timesys>
User-Agent: Mutt/1.5.4i
From: Scott Wood <scott@timesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2004 at 02:30:10PM -0400, Scott Wood wrote:
> Why is it "clearly wrong"?  As far as I can tell, the only legitimate
> use of it currently is to protect against deadlock (as in
> spin_lock_bh()), which is not an issue if all softirqs run from a
> thread.  Ksoftirqd already ignores such disabling (unless I'm missing
> something?), so code that uses it to synchronize with a softirq is
> already broken.

It appears, though, that recent kernel versions do preempt_disable()
in ksoftirqd, apparently to support CPU hotplugging[1].  When I
originally made the patch (against 2.6.0), this wasn't the case. 
Since it was done so recently, hopefully there are no cases since
then that have started depending on this behavior.

If preempt-disabled softirqs (and thus a local_bh_disable() that
works for mutual exclusion on the local CPU) become relied upon by
random pieces of kernel code, the ability to achieve very low
latencies in Linux (not counting Linux bolt-ons like RT-Linux) would
be substantially impared.  At best, we'd have to use a per-CPU mutex
to replace local_bh_disable(), causing possible performance
degradation; this would require that any other locks held at the time
are also turned into mutexes.

-Scott

[1] Supporting this along with non-preempt-disable softirqs would
require some minor changes in the way that per-CPU softirqs are done
(especially in the network code).  We did these changes in our 2.4
kernel, so as to allow priority inheritance to move a bound task
across CPUs[2].  In particular, the softirq needs to remember which CPU
it's processing data for, rather than using smp_processor_id() all
over the place, and there are a few places where a per-CPU spinlock
(only contended when the CPU binding is broken) needs to be acquired
(all of very short duration, at least in the 2.4 code).

Alternatively, some sort of "CPU reference count" could be used to
withhold permission to take a CPU offline without stopping
preemption.

[2] ...which is required for priority inheritance to work properly in
the presence of bound tasks without violating schedulability analysis
done on other CPUs.
