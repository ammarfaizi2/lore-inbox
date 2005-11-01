Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751433AbVKAX2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbVKAX2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVKAX2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:28:04 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:60549 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S1751433AbVKAX2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:28:03 -0500
Date: Wed, 2 Nov 2005 00:27:58 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Carlos Antunes <cmantunes@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Realtime-preempt performs worse for many threads?
In-Reply-To: <cb2ad8b50511011202l5bdc8c82se145adf158221e28@mail.gmail.com>
Message-Id: <Pine.OSF.4.05.10511020010590.29420-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005, Carlos Antunes wrote:

> Hi!
> 
> I've been developing some code for the OpenPBX project
> (http://www.openpbx.org) and wrote a program to test how the system,
> responds when hundreds of threads are spawned. These threads run at
> high priority (SCHED_FIFO) and use clock_nanocleep with absolute
> timeouts on a 20ms loop cycle.
> 
> With the stock 2.6.14 kernel, I get latencies in the order of several
> milliseconds (but less than 20ms) when running 1250 threads
> simultaneously. However, when I switch to a kernel patched with
> realtime-preempt latency increases to several hundred milliseconds in
> many cases.

There is only one explanation:
Some of the operations (task switch, nanosleep etc.) are more expensive in
the RT kernel. Thus your 1250 threads spend 100% CPU doing what they do.
You therefore get very bad latencies.

> 
> When I only only spawn 10 or so threads, realtime-preempt gives me
> latencies of less than 1ms while the stock kernel still gives me a few
> milliseconds. However, when the number of threads sleeping on
> clock_nanosleep increases to several hundred, things just break.
> 
> Should I assume that realtime-preempt at this time is not ready to
> deal with hundreds of realtime threads sleeping most of the time on
> clock_nanosleep?
> 

Well, apparently not. But whoever wants to do that for a _real_
application?
In practise, I would say that you can not really gurantie latencies for
more than the 10-20 highest priority threads. The probabilty that
those 10-20 threads have runs for an non-determiniticly long time
becomes very high, especially if they are event-triggered: The events
could come in bursts. Therefore you can't consider the next threads "RT".
This is what happens in your case: When you increase the number of threads
the CPU gets more and more to do on the highest priority. At some point
you hit 100% workload for 100s of ms in row. The next threads thus can't
meet their deadlines. As you put all your threads on the same priority,
nobody is really among highest priority threads and nobody optains
deterministic latencies.

> Any ideas on how to maybe debug this and see if there is some kind of problem?
> 

No bug, only extra overhead. The RT kernel has a lower _throughput_.
Apparently 1250 threads doing nanosleep for 2ms is it's limit on your
machine.

Esben


> Thanks!
> 
> Carlos
> 
> 
> 
> --
> "We hold [...] that all men are created equal; that they are
> endowed [...] with certain inalienable rights; that among
> these are life, liberty, and the pursuit of happiness"
>         -- Thomas Jefferson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

