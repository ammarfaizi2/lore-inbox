Return-Path: <linux-kernel-owner+w=401wt.eu-S1750725AbWLKXiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWLKXiH (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 18:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWLKXiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 18:38:07 -0500
Received: from ns2.suse.de ([195.135.220.15]:51729 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750725AbWLKXiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 18:38:04 -0500
Date: Tue, 12 Dec 2006 00:38:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: dean gaudet <dean@arctic.org>
Cc: john stultz <johnstul@us.ibm.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>
Subject: Re: rdtscp vgettimeofday
Message-ID: <20061211233800.GP5363@opteron.random>
References: <20061129025728.15379.50707.sendpatchset@localhost> <20061129025752.15379.14257.sendpatchset@localhost> <20061211003904.GB5366@opteron.random> <Pine.LNX.4.64.0612111302440.22490@twinlark.arctic.org> <20061211213235.GN5363@opteron.random> <Pine.LNX.4.64.0612111503560.21063@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612111503560.21063@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2006 at 03:15:44PM -0800, dean gaudet wrote:
> rdtscp gets you 2 of the 5 values you need to compute the time.  anything 
> can happen between when you do the rdtscp and do the other 3 reads:  the 
> computation is (((tsc-A)*B)>>N)+C where N is a constant, and A, B, C are 
> per-cpu data.
> A/B/C change a few times a second (to avoid 32-bit rollover in (tsc-A)), 
> every time there's a halt, and every P-state transition.

This is wrong. There's the D variable too, the seq lock.

The thing I've in mind is something like:

    rdstcp (get tsc and cpu atomic) this is fundamental without tsc
    and cpu read atomically nothing of the below is possible

    read D from cpu we got from rdtscp (seqlock)
    smb_rmb()
    check that D isn't during the race condition (last LSB clear
    or similar) or restart
    rdstcp again (tsc and cpu atomic)
    check that cpu is still the same or restart
    index the per-cpu array and get the safe A B C
    smp_rmb()
    read per-cpu D again and check that it didn't change or restart

Then you have tsc, A, B and C all atomic. N is a constant. rdtsc again
is fundamental in getting this info all atomic w/o accessing the
southbridge and without expensive asm instruction.

> if you lose your tick in the middle of those reads any number of things 
> can happen to screw the computation... including being scheduled on 
> another core and mixing values from two cores.

Being scheduled in another core is normal. continuing gettimeofday
from another core after you have the tsc value is just fine.

If something the problem is to generate A B C in per-cpu data with a
per-cpu seqlock around it. That's the job for the per-cpu kernel
thread.

The only real trouble I see is the offset from the last irq. It's
possible to make this to work we need to rotate the timer irq across
all cpus at regular intervals (before the tsc2usec measurement error
showup).

> oh i think there are several solutions which will work... and i also think 
> rdtscp wasn't a necessary addition to the ISA :)

Please don't suggest me the userland rsp manual unwinding, that's
orders of magnitude more fragile and it sounds much more complex too ;).
