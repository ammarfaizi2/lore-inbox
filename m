Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262375AbVGGAXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbVGGAXc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVGFUBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:01:24 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:52426 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S262395AbVGFROZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:14:25 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Wed, 6 Jul 2005 18:14:23 +0100
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <200507061756.20861.s0348365@sms.ed.ac.uk> <20050706170158.GA27797@elte.hu>
In-Reply-To: <20050706170158.GA27797@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061814.23656.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 Jul 2005 18:01, Ingo Molnar wrote:
> * Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:
> > > I'm beginning to understand the issue, and I see why you think the
> > > proposed patch fixes it. I'll compile and boot V0.7.51-05 now.
> >
> > Indeed, this seems to have fixed it.
> >
> > ( softirq-timer/0-3    |#0): new 8 us maximum-latency wakeup.
> > ( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
> > ( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
> > ( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
> > ( softirq-timer/0-3    |#0): new 10 us maximum-latency wakeup.
> > ( softirq-timer/0-3    |#0): new 14 us maximum-latency wakeup.
>
> great! Do the softlockup warnings still occur?

Yes, but in no greater a number.

[root] 18:09 [~] uptime
 18:09:39 up 19 min,  4 users,  load average: 0.36, 0.29, 0.16

[root] 18:09 [~] dmesg | grep BUG: | wc -l
5

So far, however, there have been no lockups! The previous kernels would die 
very obviously within a couple of minutes.

I wonder if the ACPI problem was causing lockups (one thought I had was that 
the "ondemand" cpufreq governor was generating more ACPI events than usual, 
as the BIOS stepped through the different CPU speeds).

>
> > Find attached another trace (only 33us this time).
>
> the main latency comes from here:
> >    <...>-3485  0Dnh2   13us : enqueue_task (__schedule)
> >    <...>-3485  0Dnh2   14us+: trace_array (__schedule)
> >    <...>-3485  0Dnh2   18us : trace_array <softirq--3> (69 6e)
> >    <...>-3485  0Dnh2   18us : trace_array <<...>-3485> (76 78)
> >    <...>-3485  0Dnh2   20us+: trace_array (__schedule)
> > softirq--3     0Dnh2   28us+: __switch_to (__schedule)
>
> trace_array() can be quite expensive (it generates a trace entry of
> every runnable task, with interrupts and preemption disabled). It is
> disabled if RT_DEADLOCK_DETECT is disabled. For pure wakeup latency
> tracing, the most optimal combination of options is:
>
[snip]
>
> such a kernel will still be able to generate /proc/latency_trace traces,
> but has much lower runtime overhead than your current kernel. (But you
> should probably keep all debugging enabled until all of the current
> problems have been resolved.)
>
> 	Ingo

Well, thanks for the info. As you said, when the remaining issues have been 
resolved, I'll need to step up to a more efficient kernel, because I require 
extremely low kernel latency for the software I'm writing (this was not an 
idle patch fest).

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/CSim Undergraduate
contact:    1F2 55 South Clerk Street,
            Edinburgh. EH8 9PP.
