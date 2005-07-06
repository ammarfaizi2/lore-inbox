Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVGGAXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVGGAXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVGFUBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:01:06 -0400
Received: from mx1.elte.hu ([157.181.1.137]:57277 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262382AbVGFRCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:02:39 -0400
Date: Wed, 6 Jul 2005 19:01:58 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Message-ID: <20050706170158.GA27797@elte.hu>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050706162457.GA24728@elte.hu> <200507061737.18322.s0348365@sms.ed.ac.uk> <200507061756.20861.s0348365@sms.ed.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061756.20861.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9, BAYES_00 -4.90,
	UPPERCASE_25_50 0.00
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Alistair John Strachan <s0348365@sms.ed.ac.uk> wrote:

> > I'm beginning to understand the issue, and I see why you think the proposed
> > patch fixes it. I'll compile and boot V0.7.51-05 now.
> 
> Indeed, this seems to have fixed it.
> 
> ( softirq-timer/0-3    |#0): new 8 us maximum-latency wakeup.
> ( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
> ( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
> ( softirq-timer/0-3    |#0): new 9 us maximum-latency wakeup.
> ( softirq-timer/0-3    |#0): new 10 us maximum-latency wakeup.
> ( softirq-timer/0-3    |#0): new 14 us maximum-latency wakeup.

great! Do the softlockup warnings still occur?

> Find attached another trace (only 33us this time).

the main latency comes from here:

>    <...>-3485  0Dnh2   13us : enqueue_task (__schedule)
>    <...>-3485  0Dnh2   14us+: trace_array (__schedule)
>    <...>-3485  0Dnh2   18us : trace_array <softirq--3> (69 6e)
>    <...>-3485  0Dnh2   18us : trace_array <<...>-3485> (76 78)
>    <...>-3485  0Dnh2   20us+: trace_array (__schedule)
> softirq--3     0Dnh2   28us+: __switch_to (__schedule)

trace_array() can be quite expensive (it generates a trace entry of 
every runnable task, with interrupts and preemption disabled). It is 
disabled if RT_DEADLOCK_DETECT is disabled. For pure wakeup latency 
tracing, the most optimal combination of options is:

 # CONFIG_DETECT_SOFTLOCKUP is not set
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_PREEMPT is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 CONFIG_WAKEUP_TIMING=y
 # CONFIG_CRITICAL_PREEMPT_TIMING is not set
 # CONFIG_CRITICAL_IRQSOFF_TIMING is not set
 CONFIG_LATENCY_TIMING=y
 CONFIG_LATENCY_TRACE=y
 CONFIG_MCOUNT=y
 # CONFIG_RT_DEADLOCK_DETECT is not set
 # CONFIG_DEBUG_RT_LOCKING_MODE is not set
 # CONFIG_DEBUG_KOBJECT is not set
 CONFIG_DEBUG_BUGVERBOSE=y
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_FS is not set
 CONFIG_FRAME_POINTER=y
 CONFIG_EARLY_PRINTK=y
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_KPROBES is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set

such a kernel will still be able to generate /proc/latency_trace traces, 
but has much lower runtime overhead than your current kernel. (But you 
should probably keep all debugging enabled until all of the current 
problems have been resolved.)

	Ingo
