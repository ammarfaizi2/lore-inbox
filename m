Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269021AbUINPJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269021AbUINPJe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUINPHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:07:03 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:61925 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S269410AbUINPDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:03:31 -0400
Date: Tue, 14 Sep 2004 17:03:16 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914150316.GN4180@dualathlon.random>
References: <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <41470021.1030205@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41470021.1030205@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 12:28:49AM +1000, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> >On Tue, Sep 14, 2004 at 11:33:48PM +1000, Nick Piggin wrote:
> >
> >>cond_rescheds everywhere? Isn't this now the worst of both worlds?
> >
> >
> >1) cond_resched should become a noop if CONFIG_PREEMPT=y
> >   (cond_resched_lock of course should still unlock/relock if
> >    need_resched() is set, but not __cond_resched).
> 
> Unfortunately we need to keep the cond_rescheds that are called under
> the bkl. Otherwise yes, this would be nice to be able to do.

we simply need a cond_resched_bkl() for that, no? Very few places are
still serialized with the BKL, so I don't think it would be a big issue
to convert those few places to use cond_resched_bkl.

> Which is why we don't need more of them ;)

eheh ;)

> Well I don't know how good an argument the crashes one is these days,
> but generally (as far as I know) those who really care about latency
> shouldn't mind about some extra overheads.

sure, that's especially true for the hardirq and softirq total scheduler
offloading. The real question is where a generic desktop positions. I
doubt on a generic desktop a latency over 1msec matters much,
top performance of repetitive tasks that sums up like hardirqs for a NIC
sounds more sensible to me.

And for the other usages RTAI or any other hard realtime sounds safer
anyways.

> Now I don't disagree with some cond_rescheds for places where !PREEMPT
> latency would otherwise be massive, but cases like doing cond_resched
> for every page in the scanner is something that you could say is imposing
> overhead on people who *don't* want it (ie !PREEMPT).

definitely. Note that this could be simply fixed by having a
CONFIG_PREEMPT around it, but the real fix is definitely to make
cond_resched a noop with PREEMPT=y and secondly to add a
cond_resched_bkl defined as the current cond_resched as suggested above.

> :) I don't think Ingo intended this for merging as is. Maybe it is to
> test how much progress he has made.

I hope so, he said the latest patches were cleaned up and he removed the
debugging/performance cruft (the most explicit message was
20040719115952.GA13564@elte.hu) but it's still not clear to me if he
left the CONFIG_VOLOUNTARY_PREEMPT config option because he intends to
merge it or just temporarily. Comments?

Thanks.
