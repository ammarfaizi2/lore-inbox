Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291944AbSB0Q5h>; Wed, 27 Feb 2002 11:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292806AbSB0Q5D>; Wed, 27 Feb 2002 11:57:03 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:42408 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S292803AbSB0Q45>; Wed, 27 Feb 2002 11:56:57 -0500
Date: Wed, 27 Feb 2002 17:56:50 +0100 (MET)
From: Erich Focht <focht@ess.nec.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Mike Kravetz <kravetz@us.ibm.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
In-Reply-To: <227195569.1014708639@[10.10.2.3]>
Message-ID: <Pine.LNX.4.21.0202271708190.7872-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Erich's approach:
> > - idle CPU : load_balance() every 1ms   (first try balancing the local
> >                             node, if already balanced (no CPU exceeds the
> >                             current load by >25%) try to find a remote
> >                             node with larger load than on the current one
> >                             (>25% again)).
> > - busy CPU : load_balance() every 250ms (same comment as above)
> > - schedule() : load_balance() if idle (same comment as above).
> 
> Actually, if I understand what you're doing correctly, what
> you really want is to only shift when the load average on
> the source cpu (the one you're shifting from) has been
> above "limit" for a specified amount of time, rather than
> making the interval when we inspect longer (in order to
> avoid bouncing stuff around unnecessarily).

I just tried to keep Ingo's original time intervals for load
balancing and the 25% (which he imposes) were taken as a balance condition
for the nodes, too. The delayed balancing is not implemented, but that
would be very nice to have. Davide Libenzi was using that in his scheduler
(incrementing a counter for a cpu which was busier than the current one,
resetting it when it wasn't, select that cpu if the counter reached some
number larger than the "distance" between the cpus). He was balancing only
when the cpu went idle, I'm not sure what would be the corresponding
treatment for busy balancing.

> When you say "balance", are you trying to balance the number of
> tasks in each queue, or the % of time each CPU is busy? It would
> seem OK to me to have 100 IO bound tasks on one node, and 4 cpu
> bound tasks on another (substitute "CPU" for "node" above at will).

Just as primitive as rq->nr_running (or the minimum of that value and the
one at the previous balance tick, as Ingo implemented it).

> In fact, shifting around IO bound tasks will win you far less than
> moving around CPU bound tasks in general.

Agreed. Not quite sure how to distinguish the IO bound tasks currently,
maybe somehow by their priority? Anyhow, tasks with state not equal to
TASK_RUNNING are deactivated by schedule() and don't show up in
rq->nr_running, also they can't be migrated by the load balancer. So
there's no problem with shells, etc...


> How are you calculating load? Load average? Over what period of time?
> Please forgive my idleness in not going and reading the code ;-)

Again: it's just nr_running (minimum of last two balance ticks). 


> > As Mike has mainly the cache affinity in mind, it doesn't really matter
> > where a task is scheduled as long as it stays there long enough and the
> > nodes are well balanced. A wrong scheduling decision (based on old
> > data) will be fixed sooner or later (after x*250ms or so).
> 
> Not sure I understand that - the wrong decision will cost you two
> moves, blowing not only the cache for your current process, but
> also whoever else's cache you accidentally trampled upon (which
> admittedly might be nothing useful).

Yes, you are right. That's why I think that the relatively old data which
Mike uses (can be 250ms old!) could lead to such a degradation.

Thanks,

best regards,

Erich



