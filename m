Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275903AbSIUR2z>; Sat, 21 Sep 2002 13:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275915AbSIUR2z>; Sat, 21 Sep 2002 13:28:55 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:15772 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S275903AbSIUR2y> convert rfc822-to-8bit; Sat, 21 Sep 2002 13:28:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] [PATCH 1/2] node affine NUMA scheduler
Date: Sat, 21 Sep 2002 19:32:59 +0200
User-Agent: KMail/1.4.1
Cc: LSE <lse-tech@lists.sourceforge.net>, Ingo Molnar <mingo@elte.hu>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>
References: <598631797.1032601564@[10.10.2.3]> <600156739.1032603089@[10.10.2.3]>
In-Reply-To: <600156739.1032603089@[10.10.2.3]>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209211932.59871.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

thanks for the comments and the testing!

On Saturday 21 September 2002 19:11, Martin J. Bligh wrote:
> > From the below, I'd suggest you're getting pages off the wrong
> > nodes: do_anonymous_page is page zeroing, and rmqueue the buddy
> > allocator. Are you sure the current->node thing is getting set
> > correctly? I'll try backing out your alloc_pages tweaking, and
> > see what happens.

The current->node is most probably wrong for most of the kernel threads,
except for migration_thread and ksoftirqd. But it should be fine for
user processes.

Might also be that the __node_distance matrix which you might use
by default is not optimal for NUMAQ. It is fine for our remote/local
latency ratio of 1.6. Yours is maybe an order of magnitude larger?
Try replacing: 15 -> 50, guess you don't go beyond 4 nodes now...


> OK, well removing that part of the patch gets us back from 28s to
> about 21s (compared to 20s virgin), total user time compared to
> virgin is up from 59s to 62s, user from 191 to 195. So it's still
> a net loss, but not by nearly as much. Are you determining target
> node on fork or exec ? I forget ...

The default is exec(). You can use
http://home.arcor.de/efocht/sched/nodpol.c
to set the node_policy to do initial load_balancing in fork().
Just do "nodpol -P 2" in the shell before starting the job/task.
This is VERY reccomended if you are creating many tasks/threads.
The default behavior is fine for MPI jobs or users starting serial
processes.

> Profile is more comparible. Nothing sticks out any more, but maybe
> it just needs some tuning for balance intervals or something.

Hmmm... There are two changes which might lead to lower performance:
1. load_balance() is not inlined any more.
2. pull_task steals only one task at a load_balance() call. It was
maximally imbalance/2 (if I remember correctly).

And of course, there is some real additional overhead due to the
initial load balancing which one feels for short living tasks... So
please try "nodpol -P 2" (and reset to default by "nodpol -P 0".

Did you try the first patch alone? I mean the pooling-only scheduler?

Thanks,
Erich

> 153385 total                                      0.1544
>  91219 default_idle
>   7475 do_anonymous_page
>   4564 page_remove_rmap
>   4167 handle_mm_fault
>   3467 .text.lock.namei
>   2520 page_add_rmap
>   2112 rmqueue
>   1905 .text.lock.dec_and_lock
>   1849 zap_pte_range
>   1668 vm_enough_memory
>   1612 __free_pages_ok
>   1504 file_read_actor
>   1484 find_get_page
>   1381 __generic_copy_from_user
>   1207 do_no_page
>   1066 schedule
>   1050 get_empty_filp
>   1034 link_path_walk

-- 
Dr. Erich Focht                                <efocht@ess.nec.de>
NEC European Supercomputer Systems, European HPC Technology Center
Hessbruehlstr. 21B, 70565 Stuttgart, Germany
phone: +49-711-78055-15                    fax  : +49-711-78055-25

