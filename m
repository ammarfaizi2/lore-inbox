Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292684AbSBZTEc>; Tue, 26 Feb 2002 14:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292702AbSBZTEW>; Tue, 26 Feb 2002 14:04:22 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16375 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292684AbSBZTEI>;
	Tue, 26 Feb 2002 14:04:08 -0500
Date: Tue, 26 Feb 2002 11:03:48 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Erich Focht <focht@ess.nec.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
Message-ID: <20020226110348.D1262@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20940000.1014663303@flay> <Pine.LNX.4.21.0202261028370.2830-100000@sx6.ess.nec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0202261028370.2830-100000@sx6.ess.nec.de>; from focht@ess.nec.de on Tue, Feb 26, 2002 at 11:33:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich,

I'm glad to see you are also exploring NUMA scheduling.  The
more the merrier.

On Tue, Feb 26, 2002 at 11:33:14AM +0100, Erich Focht wrote:
> 
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
> 
> So the functional difference is not really that big here, I am also trying
> to balance locally first. If that fails (no imbalance), I try
> globally. The factor of 2 in the times is not so relevant, I think, and
> also I don't consider my approach significantly more aggressive.

My factor of 'two' is really a 'distance' factor.  My thoughts were
along the lines that node rebalancing would occur at different rates
based on the distance between nodes.  On the Sequent NUMA-Q machines
with really high remote memory latencies, you might want to be less
agressive than on machines with lower latencies.  I was playing with
the idea that you would discover distances during topology discovery,
and the rate of rebalancing would somehow correspond to these distances.

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
> 
> As Mike has mainly the cache affinity in mind, it doesn't really matter
> where a task is scheduled as long as it stays there long enough and the
> nodes are well balanced. A wrong scheduling decision (based on old
> data) will be fixed sooner or later (after x*250ms or so).

Agreed.  I also played with the idea of keeping a load average over
time, which seems to be something we may want.  However, I couldn't
think of an efficient way to accomplish this, and my first attempts
showed little promise.  Perhaps, I will investigate this more.

-- 
Mike
