Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSJ1T7r>; Mon, 28 Oct 2002 14:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261489AbSJ1T7q>; Mon, 28 Oct 2002 14:59:46 -0500
Received: from [202.88.156.6] ([202.88.156.6]:37604 "EHLO
	saraswati.hathway.com") by vger.kernel.org with ESMTP
	id <S261477AbSJ1T7p>; Mon, 28 Oct 2002 14:59:45 -0500
Date: Tue, 29 Oct 2002 01:30:59 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Hugh Dickins <hugh@veritas.com>, Mingming Cao <cmm@us.ibm.com>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]updated ipc lock patch
Message-ID: <20021029013059.A13287@dikhow>
Reply-To: dipankar@gamebox.net
References: <Pine.LNX.4.44.0210270748560.1704-100000@localhost.localdomain> <20021028010711.E659A2C085@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028010711.E659A2C085@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Oct 28, 2002 at 02:20:04AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

I am pathologically late in catching up lkml, so if I missed some
context here, I apologize in advance. I have just started looking
at mm6 ipc code and I want to point out a few things.

On Mon, Oct 28, 2002 at 02:20:04AM +0100, Rusty Russell wrote:
> Yes, nonsensical.  Firstly, it's in violation of the standard to fail
> IPC_RMID under random circumstances.  Secondly, failing to clean up is
> an unhandlable error, since you're quite possible in the failure path
> of the code already.  This is a well known issue.

I am not sure how Ming/Hugh's current IPC changes affect IPC_RMID.
It affects only when you are trying to add a new ipc. In fact,
since it is a *add* operation (grow_ary()), it seems ok to fail it if rcu_head
allocation fails. Feel free to correct me if I missed something here.
AFAICS, the rcu stuff doesn't affect any freeing other than the IPC
id array.

> Two oom kills.  Three oom kills.  Four oom kills.  Where's the bound
> here?
> 
> Our allocator behavior for GFP_KERNEL has changed several times.  Are
> you sure that it won't *ever* fail under other circomstances?
> 
> > Okay (I expect, didn't review it) for just the ids arrays, but too much
> > memory waste if we have to allocate for each msq, sema, shm: if there's
> > a better solution available.  mempool looks better to us.
> 
> It's a hacky, fragile and incorrect solution.  It's completely
> tasteless.

Yes, the mempool code is broken, but only because rcu_backup_pool
is created three times, one by each IPC mechanism init :-)

> > Not yet.  You seem to have had a bad experience with something like
> > this (the mempools or the RCU or the combination), and you're warning
> > us away without actually telling us what you found.
> 
> I *wrote* the RCU interface (though the implementation in 2.5 isn't
> mine).  I thought it was pretty clear how it was supposed to be used.
> Obviously, I was wrong.

Yes, we went through this a long time ago and the general model
is to embedd the rcu_head thereby allocating it at the time
of allocation of the RCU protected data. This increases the
probability of recovery from low-memory situation as compared
to having to allocte during freeing.

That said, it seems that Ming/Hugh's patch does allocate
the rcu_head at the time of *growing* the array. It is just
that they allocate it for the freeing array rather than the
allocated array. I don't see how this is semantically different
from clubbing the two allocations other than the fact that
smaller number of allocation calls would likely reduce the
likelyhood of allocation failures.


> Patch below is against Mingming's mm4 release.  Compiles, untested.
> Rusty.

Yes, this is the typical RCU model, except that in this case (IPC),
I am not quite sure if it is in effect that different from what Ming/Hugh
have done.

Thanks
Dipankar
