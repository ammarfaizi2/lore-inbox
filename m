Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277826AbRJIQup>; Tue, 9 Oct 2001 12:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJIQuj>; Tue, 9 Oct 2001 12:50:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:15333 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277822AbRJIQuV>; Tue, 9 Oct 2001 12:50:21 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        rth@redhat.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFB7BD4A8C.67D9CA0D-ON88256AE0.00549718@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 9 Oct 2001 08:24:17 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/09/2001 10:50:44 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
>    Date: Mon, 8 Oct 2001 22:27:44 -0700
>
>    All other CPUs must observe the preceding stores before the following
>    stores.
>  ...
>    Does this do the trick?
>
>               membar #StoreStore
>
> Yes.

Cool!  Thank you!!!

>    The IPIs and related junk are I believe needed only on Alpha, which
has
>    no single memory-barrier instruction that can do wmbdd()'s job.  Given
>    that Alpha seems to be on its way out, this did not seem to me to be
>    too horrible.
>
> I somehow doubt that you need an IPI to implement the equivalent of
> "membar #StoreStore" on Alpha.  Richard?

If "membar #StoreStore" is sufficient, then there is no equivalent of
it on Alpha.  Neither the "mb" nor the "wmb" instructions wait for
outstanding invalidations to complete, and therefore do -not- guarantee
that reading CPUs will see writes occuring in the order that the writes
occurred on the writing CPU, even if data dependencies force the order
of the reads (as the pointer-dereference example I gave does).

On Alpha, there -must- be an "mb" on the reading CPU if the reading CPU
is to observe the stores in order.  The IPIs are just a way of causing
those "mb"s to happen without having code like this:

     d = p->a->b;

from having to be written as follows:

     q = p->a;
     rmb();
     d = q->b;

More thoughts?

                         Thanx, Paul

