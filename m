Return-Path: <linux-kernel-owner+w=401wt.eu-S1750714AbWLKXPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWLKXPq (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWLKXPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:15:46 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:36744 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbWLKXPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:15:45 -0500
Date: Mon, 11 Dec 2006 15:15:44 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: john stultz <johnstul@us.ibm.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>
Subject: Re: rdtscp vgettimeofday
In-Reply-To: <20061211213235.GN5363@opteron.random>
Message-ID: <Pine.LNX.4.64.0612111503560.21063@twinlark.arctic.org>
References: <20061129025728.15379.50707.sendpatchset@localhost>
 <20061129025752.15379.14257.sendpatchset@localhost> <20061211003904.GB5366@opteron.random>
 <Pine.LNX.4.64.0612111302440.22490@twinlark.arctic.org>
 <20061211213235.GN5363@opteron.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006, Andrea Arcangeli wrote:

> On Mon, Dec 11, 2006 at 01:17:25PM -0800, dean gaudet wrote:
> > rdtscp doesn't solve anything extra [..]
> > [..] lsl-based vgetcpu is relatively slow
> 
> Well, if you accept to run slow there's nothing to solve in the first
> place indeed.
> 
> If nothing else rdtscp should avoid the mess of restarting a
> vsyscalls, which is quite a difficult problem as it heavily depends on
> the compiler/dwarf.

rdtscp gets you 2 of the 5 values you need to compute the time.  anything 
can happen between when you do the rdtscp and do the other 3 reads:  the 
computation is (((tsc-A)*B)>>N)+C where N is a constant, and A, B, C are 
per-cpu data.

A/B/C change a few times a second (to avoid 32-bit rollover in (tsc-A)), 
every time there's a halt, and every P-state transition.

if you lose your tick in the middle of those reads any number of things 
can happen to screw the computation... including being scheduled on 
another core and mixing values from two cores.


> > even with rdtscp you have to deal with the definite possibility of being 
> > scheduled away in the middle of the computation.  arguably you need
> > to 
> 
> Isn't rdtscp atomic? all you need is to read atomically the current
> contents of the tsc and the index to use in a per-cpu table exported
> in readonly. This table will contain a per-cpu seqlock as well. Then a
> math logic has to be built with per-cpu threads, so that those per-cpu
> tables are updated by cpufreq and at regular intervals.
> 
> If this is all wrong and it's not feasible to implement a safe and
> monothonic vgettimeofday that doesn't access the southbridge and that
> doesn't require restarting the vsyscall manually by patching rip/rsp,
> I've an hard time to see how rdtscp is useful at all. I hope somebody
> thought about those issues before adding a new instruction to a
> popular CPU ;).

oh i think there are several solutions which will work... and i also think 
rdtscp wasn't a necessary addition to the ISA :)

-dean
