Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290767AbSBZP7w>; Tue, 26 Feb 2002 10:59:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290823AbSBZP7n>; Tue, 26 Feb 2002 10:59:43 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:63134 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S290767AbSBZP7d>; Tue, 26 Feb 2002 10:59:33 -0500
Date: Tue, 26 Feb 2002 07:30:49 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Erich Focht <focht@ess.nec.de>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
Message-ID: <227195569.1014708639@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.21.0202261028370.2830-100000@sx6.ess.nec.de>
In-Reply-To: <Pine.LNX.4.21.0202261028370.2830-100000@sx6.ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, maybe my description was a little bit misleading. My approach is not
> balancing much more aggressively, the difference is actually minimal,
> e.g. for 1ms ticks:
>
> Mike's approach:
> - idle CPU : load_balance()     every 1ms    (only within local node)
>              balance_cpu_sets() every 2ms    (balance across nodes)
> - busy CPU : load_balance()     every 250ms
>              balance_cpu_sets() every 500ms
> - schedule() : load_balance() if idle        (only within local node)
>
> Erich's approach:
> - idle CPU : load_balance() every 1ms   (first try balancing the local
>                             node, if already balanced (no CPU exceeds the
>                             current load by >25%) try to find a remote
>                             node with larger load than on the current one
>                             (>25% again)).
> - busy CPU : load_balance() every 250ms (same comment as above)
> - schedule() : load_balance() if idle (same comment as above).

Actually, if I understand what you're doing correctly, what
you really want is to only shift when the load average on
the source cpu (the one you're shifting from) has been
above "limit" for a specified amount of time, rather than
making the interval when we inspect longer (in order to
avoid bouncing stuff around unnecessarily).

> So the functional difference is not really that big here, I am also trying
> to balance locally first. If that fails (no imbalance), I try
> globally. The factor of 2 in the times is not so relevant, I think, and
> also I don't consider my approach significantly more aggressive.

When you say "balance", are you trying to balance the number of
tasks in each queue, or the % of time each CPU is busy? It would
seem OK to me to have 100 IO bound tasks on one node, and 4 cpu
bound tasks on another (substitute "CPU" for "node" above at will).

In fact, shifting around IO bound tasks will win you far less than
moving around CPU bound tasks in general.

> More significant is the difference in the data used for the balance
> decision:
>
> Mike: calculate load of a particular cpu set in the corresponding
> load_balance() call.
>         Advantage: cheap (if spinlocks don't hurt there)
>         Disadvantage: for busy CPUs it can be really old (250ms)
>
> Erich: calculate load when needed, at the load_balance() call, but not
> more than needed (normally only local node data, global data if needed,
> all lockless).
>         Advantage: fresh, lockless
>         Disadvantage: sometimes slower (when balancing across nodes)

How are you calculating load? Load average? Over what period of time?
Please forgive my idleness in not going and reading the code ;-)

> As Mike has mainly the cache affinity in mind, it doesn't really matter
> where a task is scheduled as long as it stays there long enough and the
> nodes are well balanced. A wrong scheduling decision (based on old
> data) will be fixed sooner or later (after x*250ms or so).

Not sure I understand that - the wrong decision will cost you two
moves, blowing not only the cache for your current process, but
also whoever else's cache you accidentally trampled upon (which
admittedly might be nothing useful).

>> Presumably exec-time balancing is cheaper, since there are fewer shared
>> pages to be bounced around between nodes, but less effective if the main
>> load on the machine is one large daemon app, which just forks a few
>> copies of itself ... I would have though that'd get sorted out a little
>> later anyway by the background rebalancing though?
>
> OK, thanks. I agree with the first part of your reply. The last sentence
> is true for Mike's approach but a bit more complicated with the boundary
> condition of a process having its memory allocated on a particular node...

Ah, now I see why you're doing what you're doing ;-) Maybe we're
getting into the realm of processes providing hints to the kernel
at fork time ... I need to think on this one some more ...

Thanks,

Martin.
