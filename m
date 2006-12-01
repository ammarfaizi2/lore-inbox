Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936541AbWLATBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936541AbWLATBj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 14:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936542AbWLATBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 14:01:38 -0500
Received: from smtp3.Stanford.EDU ([171.67.20.26]:34992 "EHLO
	smtp3.stanford.edu") by vger.kernel.org with ESMTP id S936540AbWLATBh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 14:01:37 -0500
Subject: Re: 2.6.19-rt1: max latencies with jackd
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, "Linux-Kernel," <linux-kernel@vger.kernel.org>
In-Reply-To: <20061201080826.GA17504@elte.hu>
References: <1164923245.31959.49.camel@cmn3.stanford.edu>
	 <20061201080826.GA17504@elte.hu>
Content-Type: text/plain
Date: Fri, 01 Dec 2006 11:01:35 -0800
Message-Id: <1164999696.4385.20.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-01 at 09:08 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> could you try the patch below? It changes trace entries to be measured 
> via get_cycles() again [which should be must faster than pmtimer on your 
> CPU], but keeps the latency tracing timestamps (the timestamp of the 
> start/end of critical sections) on pmtimer again. This should give us 
> accurate latency measurements, but fast trace entries.
> 
> you can still revert to the conservative timestamping behavior via:
> 
> 	echo 0 > /proc/sys/kernel/trace_use_raw_cycles
> 
> note: you can probably get a higher quality of 'overview trace' via:
> 
> 	echo 0 > /proc/sys/kernel/mcount_enabled
> 	echo 1 > /proc/sys/kernel/stackframe_tracing

If I do this I get a lockup or an instant reboot. 

But it looks like something is wrong. I'm not getting traces at all and
the preempt_max_latency remains stubbornly at 0. 

I'll try with the previous kernel but I'll just turn on tracing for all
activity, not just within the jackd client activation cycle. It looks
like the xruns are happening elsewhere. 

-- Fernando

PS: this is what I'm using to "arm" the trace (from the trace-it.c
example):

-----
#!/bin/bash
#

echo 1 > /proc/sys/kernel/trace_user_triggered
[ -e /proc/sys/kernel/wakeup_timing ] && echo 1
> /proc/sys/kernel/wakeup_timing
echo 1 > /proc/sys/kernel/trace_enabled

# get better quality traces
echo 1 > /proc/sys/kernel/mcount_enabled
# echo 0 > /proc/sys/kernel/mcount_enabled
# echo 1 > /proc/sys/kernel/stackframe_tracing

echo 0 > /proc/sys/kernel/trace_freerunning
echo 0 > /proc/sys/kernel/trace_print_at_crash
echo 0 > /proc/sys/kernel/trace_verbose
echo 0 > /proc/sys/kernel/preempt_thresh 2>/dev/null
echo 0 > /proc/sys/kernel/preempt_max_latency 2>/dev/null
-----


