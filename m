Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161060AbWBAOOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161060AbWBAOOS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbWBAOOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:14:18 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46730 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161060AbWBAOOR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:14:17 -0500
Date: Wed, 1 Feb 2006 15:12:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201141248.GA6277@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au> <43E0BDA3.8040003@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0BDA3.8040003@yahoo.com.au>
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


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> ... and my point is that there is not much reason to introduce a 
> possible performance regression because of such a latency in an 
> artificial test case, especially when there are other sources of 
> unbound latency when dealing with large numbers of tasks (and on 
> uniprocessor too, eg. rwsem).
> 
> However, as an RT-tree thing obviously I have no problems with it, but 
> unless your interrupt thread is preemptible, then there isn't much 
> point because it can cause a similar latency (that your tools won't 
> detect) simply by running multiple times.

we can (and do) detect any type of latency. E.g. there's the 
CONFIG_LPPTEST feature in the -rt kernel, which allows me to inject 
50,000 hardirqs per second from another box, over a parallel port, and 
allows me to validate the worst-case IRQ response time from that 
external box. The 'external' component of LPPTEST injects the interrupt 
with interrupts disabled, and polls for the response, and does all 
measurements on that other box. I can use that in conjunction with the 
latency tracer running on the measured box, to get an easy snapshot of 
the longest hardirq latency path.

to answer your question: yes, all hardware interrupt handlers [except a 
very slim shim that blocks the irq source and wakes up the interrupt 
thread] are fully preemptible in the -rt kernel too. I.e. all the IDE 
irq handlers, all the networking handlers, all the irq codepath that 
usually runs with irqs off, runs fully preemptible in the -rt kernel.

so when we say the -rt kernel has a 20 usecs worst-case scheduling 
latency on a fast box, while running arbitrary SCHED_OTHER workloads 
(including heavy networking, heavy swapping/VM and IO work, using 
thousands of tasks) it really means we measured it using robust methods.

> You really want isolcpus on SMP machines to really ensure load 
> balancing doesn't harm RT behaviour, yeah?

not really - isolcpus is useful for certain problems, but it is not 
generic as it puts heavy constraints on usability and resource 
utilization. We have really, really good latencies on SMP too in the -rt 
kernel, with _arbitrary_ SCHED_OTHER workloads. Rwsems and rwlocks are 
not an issue, pretty much the only issue is the scheduler's 
load-balancing.

	Ingo
