Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272620AbRJJBVr>; Tue, 9 Oct 2001 21:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272717AbRJJBVh>; Tue, 9 Oct 2001 21:21:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54234 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S272620AbRJJBVX>; Tue, 9 Oct 2001 21:21:23 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        rth@redhat.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA3BA1BC5.2B2D11F4-ON88256AE1.000725E4@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Tue, 9 Oct 2001 18:19:49 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/09/2001 07:21:49 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    The IPIs and related junk are I believe needed only on Alpha, which
has
>    no single memory-barrier instruction that can do wmbdd()'s job.  Given
>    that Alpha seems to be on its way out, this did not seem to me to be
>    too horrible.
>
> I somehow doubt that you need an IPI to implement the equivalent of
> "membar #StoreStore" on Alpha.  Richard?

I received my copy of the SPARC Architecture Manual (Weaver and Germond)
today.

It turns out that there is -no- equivalent of "membar #StoreStore"
on Alpha, if I am correctly interpreting this manual.

>From section D.4.4, on page 260:

     A memory order is legal in RMO if and only if:

     (1)  X <d Y & L(X) -> X <m Y

     [... two other irrelevant cases omitted ...]

     Rule (1) states that the RMO model will maintain dependence
     when the preceding transaction is a load.  Preceding stores
     may be delayed in the implementation, so their order may
     not be preserved globally.

In the example dereferencing a pointer, we first load the
pointer, then load the value it points to.  The second load is
dependent on the first, and the first is a load.  Thus, rule (1)
holds, and there is no need for a read-side memory barrier
between the two loads.

This is consistent with the book's definition of
"completion" and the description of the membar
instruction.

In contrast, on Alpha, unless there is an explicit rmb(), data
dependence between a pair of loads in no way forces the two loads
to be ordered.  http://lse.sourceforge.net/locking/wmbdd.html
shows how Alpha can get the new value of the pointer, but the
old value of the data it points to.  Alpha thus needs the rmb()
between the two loads, even though there is a data dependency.

Am I misinterpreting the SPARC manual?

                              Thanx, Paul

