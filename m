Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272843AbRILOxN>; Wed, 12 Sep 2001 10:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272848AbRILOxE>; Wed, 12 Sep 2001 10:53:04 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34418 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272843AbRILOwt>; Wed, 12 Sep 2001 10:52:49 -0400
Date: Wed, 12 Sep 2001 16:53:35 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
        Paul Mckenney <paul.mckenney@us.ibm.com>
Subject: Re: 2.4.10pre7aa1
Message-ID: <20010912165335.F695@athlon.random>
In-Reply-To: <20010912163426.A5979@in.ibm.com> <20010912160313.A695@athlon.random> <20010912201229.F5819@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010912201229.F5819@in.ibm.com>; from dipankar@in.ibm.com on Wed, Sep 12, 2001 at 08:12:29PM +0530
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 08:12:29PM +0530, Dipankar Sarma wrote:
> You changed the way I maintained the wait_list and current_list.
> The basic logic was that new callbacks are always added to the
> wait list. The wait_for_rcu() is started only if current_list
> was empty and we just moved the wait_list to current_list. The
> key step was moving the wait_list to current_list *after* doing
> a wait_for_rcu(). This prevents another CPU from doing a wait_for_rcu().
> Either that or I missed something big time :-)

Really when Rusty said "multiple cpus calling wait_for_rcu" I was thinking 
at common code calling wait_for_rcu directly (in such a case you would
have a problem too), I thought it was exported as well as call_rcu.

If you mean races with call_rcu they cannot be explained by wait_for_rcu
called by different cpus also with my approch because there's only one
keventd so only one wait_for_rcu can run at once with my current code
(obviously, only keventd will ever recall wait_for_rcu).

The problem should be elsewhere.

Also we still don't address the case of keventd being starved by RT
tasks. Maybe we should just make keventd RT, but then it would hang if
somebody reinserts itself for a long time :(. Maybe Russel's approch is
the cleaner after all, it just adds a branch in schedule fast path but
(once fixed properly with the IPI and need_resched and dropping the
unused irq checks that we don't want anyways to avoid even further
slowdown of the slow paths) then the other issues goes away as well as
the memory consumation.

> One disadvantage of the wrappers is that we would be wasting most of
> the L1 cache line for rcu_head and that could be relatively significant for 
> a small frequently allocated structure. And no, I don't see any problem asking
> people to allocate the rcu_head in the data structure.

Ok. As usual people should care to order the fields in cacheline
optimized manner, so for example they should care to put the rcu_head at
the very end if they want to reserve the cacheline for the "hot" fields.
This can infact save a cacheline if the data structure is very small.
It's something we cannot choose in rcu_kmalloc etc... only the user can.

Andrea
