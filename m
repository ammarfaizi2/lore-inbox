Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130155AbQLUPvB>; Thu, 21 Dec 2000 10:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131123AbQLUPuv>; Thu, 21 Dec 2000 10:50:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15968 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130155AbQLUPuh>; Thu, 21 Dec 2000 10:50:37 -0500
Date: Thu, 21 Dec 2000 16:19:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@redhat.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001221161952.B20843@athlon.random>
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>, <E147MkJ-00036t-00@the-village.bc.nu>; <20001220142858.A7381@athlon.random> <3A40C8CB.D063E337@uow.edu.au>, <3A40C8CB.D063E337@uow.edu.au>; <20001220162456.G7381@athlon.random> <3A41DDB3.7E38AC7@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A41DDB3.7E38AC7@uow.edu.au>; from andrewm@uow.edu.au on Thu, Dec 21, 2000 at 09:38:43PM +1100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 09:38:43PM +1100, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > The fact you could mix non-exclusive and exlusive wakeups in the same waitqueue
> > was a feature not a misfeature. Then of course you cannot register in two
> > waitqueues one with wake-one and one with wake-all but who does that anyways?
> > Definitely not an issue for 2.2.x.
> 
> Definitely?  Let's think about that.

If you can tell one showstopper bottleneck in 2.2.x that needs to register
in two waitqueues at the same time, one exclusive and one non-exclusive, then I
will think about it.

> > I think the real reason for spearating the two things as davem proposed is
> > because otherwise we cannot register for a LIFO wake-one in O(1) as we needed
> > for accept.
> 
> Yes.  In other words, if we try to do O(1) LIFO, we can cause lost wakeups.

We can do LIFO in O(N) just fine, no lost wakeups with the "mix" way. Only
problem is additional complexity in the inserction operation.

> > Other thing about your patch, adding TASK_EXCLUSIVE to
> > wake_up/wake_up_interruptible is useless.
> 
> This enables wake_up_all().

It is useless as it is in 2.2.19pre2: there's no wake_up_all in 2.2.19pre2.

> Anyway, this is all just noise.
> 
> The key question is: which of the following do we want?
> 
> a) A simple, specific accept()-accelerator, and 2.2 remains without
>    an exclusive wq API or

To make the accellerator we need a minimal wake-one support. So a) doesn't
make sense to me.

> b) A general purpose exclusive wq mechanism which does not correctly
>    support waiting on two queues simultaneuously where one is
>    exclusive or

That's what we had in whole 2.3.x and that is better suitable for 2.2.x
as it allows to do a) with obviously right approch and minimal effort.

> c) A general purpose exclusive wq mechanism which _does_ support it.
>
> Each choice has merit!  You seem to want b).  davem wants c).

I have not read any email from DaveM who proposes C for 2.2.19pre3 (or 2.2.x in
general). Are you sure he wasn't talking about 2.4.x?

BTW, you also implemented b) in 2.2.19pre2 ;)

> And given that 2.2 has maybe 2-4 years life left in it, I'd

I hope no ;).

> agree with David.  Let's do it once and do it right while the issue
> is fresh in our minds.

I disagree. The changes to separate the two waitqueues even only for accept are
not suitable for 2.2.x. Alan filter should forbid that changes.  They're simply
not worthwhile because I cannot even think at one bottleneck-showstopper place
that registers in two waitqueues and wants wake-one from one and wake-all from
the other in 2.2.x.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
