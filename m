Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277306AbRJJQ1K>; Wed, 10 Oct 2001 12:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277305AbRJJQ1C>; Wed, 10 Oct 2001 12:27:02 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:15615 "EHLO
	e34.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277304AbRJJQ0t>; Wed, 10 Oct 2001 12:26:49 -0400
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
 insertion
To: Andrea Arcangeli <andrea@suse.de>
Cc: Peter Rival <frival@zk3.dec.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        Richard Henderson <rth@twiddle.net>, cardoza@zk3.dec.com,
        woodward@zk3.dec.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF206EE8AA.7A83A16B-ON88256AE1.005467E3@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Wed, 10 Oct 2001 08:24:11 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/10/2001 10:25:36 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > true for older alphas, especially because they are strictly in-order
> > machines, unlike ev6.
>
> Yes, it sounds strange. However According to Paul this would not be the
> cpu but a cache coherency issue. rmb() would enforce the cache coherency
> etc... so maybe the issue is related to old SMP motherboard etc... not
> even to the cpus ... dunno. But as said it sounded very strange that
> also new chips and new boards have such a weird reodering trouble.

It sounded strange to me, too.  ;-)  And my first reading of the
Alpha AXP Archtecture RM didn't help me much.

It was indeed a cache coherency issue.  The architect I talked to felt
that it was a feature rather than a bug.  I have an email in to him.
In the meantime, Compaq's patent #6,108,737 leads me to believe that
others in DEC/Compaq also believe it to be a feature.  The paragraph
starting at column 2 line 20 of the body of this patent states:

     In a weakly-ordered system, an order is imposed between selected
     sets of memory reference operations, while other operations are
     considered unordered.  One or more MB instructions are used to
     indicate the required order.  In the case of an MB instruction
     defined by the Alpha (R) 21264 processor instruction set, the MB
     denotes that all memory reference instructions above the MB (i.e.,
     pre-MB instructions) are ordered before all reference instructions
     after the MB (i.e., post-MB instructions).  However, no order
     is required between reference instructions that are not separated
     by an MB.

(The patent talks about the WMB instruction later on.)

In other words, if there is no MB, the CPU is not required to maintain
ordering.  Regardless of data dependencies or anything else.

There is also an application note at

     http://www.openvms.compaq.com/wizard/wiz_2637.html

which states:

     For instance, your producer must issue a "memory barrier" instruction
     after writing the data to shared memory and before inserting it on
     the queue; likewise, your consumer must issue a memory barrier
     instruction after removing an item from the queue and before reading
     from its memory.  Otherwise, you risk seeing stale data, since,
     while the Alpha processor does provide coherent memory, it does
     not provide implicit ordering of reads and writes.  (That is, the
     write of the producer's data might reach memory after the write of
     the queue, such that the consumer might read the new item from the
     queue but get the previous values from the item's memory.

Note that they require a memory barrier (rmb()) between the time the
item is removed from the queue and the time that the data in the item
is referenced, despite the fact that there is a data dependency between
the dequeueing and the dereferencing.  So, again, data dependency does
-not- substitute for an MB on Alpha.

Comments from DEC/Compaq people who know Alpha architecture details?

                              Thanx, Paul

> > I suspect some confusion here - probably that architect meant loads
> > to independent addresses. Of course, in this case mb() is required
> > to assure ordering.
> >
> > Ivan.
>
>
> Andrea
>

