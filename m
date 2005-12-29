Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964966AbVL2KR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbVL2KR7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVL2KR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:17:59 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:62385 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964966AbVL2KR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:17:58 -0500
Date: Thu, 29 Dec 2005 11:17:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>, Lee Revell <rlrevell@joe-job.com>,
       Hugh Dickins <hugh@veritas.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] latency tracer, 2.6.15-rc7
Message-ID: <20051229101736.GA2560@elte.hu>
References: <1135726300.22744.25.camel@mindpipe> <Pine.LNX.4.61.0512282205450.2963@goblin.wat.veritas.com> <1135814419.7680.13.camel@mindpipe> <20051229082217.GA23052@elte.hu> <20051229100233.GA12056@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229100233.GA12056@redhat.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jones <davej@redhat.com> wrote:

>  > could test it by e.g. trying to reproduce the same VM latency as in the 
>  > -rt tree. [the two zlib patches are needed if you are using 4K stacks, 
>  > mcount increases stack footprint.]
> 
> kernel/latency.c: In function 'add_preempt_count_ti':
> kernel/latency.c:1703: warning: implicit declaration of function 'preempt_count_ti'
> kernel/latency.c:1703: error: invalid lvalue in assignment
> kernel/latency.c: In function 'sub_preempt_count_ti':
> kernel/latency.c:1764: error: invalid lvalue in assignment

indeed - i have fixed this and have uploaded a new version to:

   http://redhat.com/~mingo/latency-tracing-patches/

> interesting config options ...
> 
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=y
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_BKL=y
> 
> CONFIG_WAKEUP_TIMING=y
> CONFIG_WAKEUP_LATENCY_HIST=y
> CONFIG_CRITICAL_IRQSOFF_TIMING=y
> CONFIG_INTERRUPT_OFF_HIST=y
> CONFIG_LATENCY_TRACE=y
> CONFIG_USE_FRAME_POINTER=y
> CONFIG_FRAME_POINTER=y

these are various things one might be interested in gathering on a live 
system. Enabling more of them means higher runtime overhead.  
WAKEUP_TIMING only measures the worst-case wakeup cost, it's the 
lowest-overhead option. It's activated via resetting the worst-case 
cost:

	echo 0 > /proc/sys/kernel/preempt_max_latency

The histogram ones are gathering a histogram (but no traces) into 
/proc/latency_hist/<cpu_nr>. These have some overhead as they hook into 
every preempt-disable/enable call. Output is:

  $ head -15 /proc/latency_hist/wakeup_latency/CPU0
  #Minimum latency: 2 microseconds.
  #Average latency: 7 microseconds.
  #Maximum latency: 511 microseconds.
  #Total samples: 5241
  #There are 0 samples greater or equal than 10240 microseconds
  #usecs           samples
      0                  0
      1                  0
      2                  7
      3               2041
      4                921
      5                194
      6                 62
      7                502
      8                119
  ...

The LATENCY_TRACING option does full tracing of critical sections 
[driven by e.g. WAKEUP_TIMING - but it can also be activated by 
interrupts, or be completely user-driven via userspace calls], which 
trace is then put into /proc/latency_trace - mcount done for every 
function call in the kernel. This can add up to 30% of runtime overhead 
[or worse], but is obviously very useful for debugging latencies.

	Ingo
