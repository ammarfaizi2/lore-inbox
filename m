Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273269AbRJJBnw>; Tue, 9 Oct 2001 21:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273364AbRJJBnd>; Tue, 9 Oct 2001 21:43:33 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:61717 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S273269AbRJJBna>; Tue, 9 Oct 2001 21:43:30 -0400
Date: Wed, 10 Oct 2001 03:43:30 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paul McKenney <Paul.McKenney@us.ibm.com>
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, rth@redhat.com
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010034330.G8384@athlon.random>
In-Reply-To: <OFA3BA1BC5.2B2D11F4-ON88256AE1.000725E4@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFA3BA1BC5.2B2D11F4-ON88256AE1.000725E4@boulder.ibm.com>; from Paul.McKenney@us.ibm.com on Tue, Oct 09, 2001 at 06:19:49PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 06:19:49PM -0700, Paul McKenney wrote:
> 
> >    The IPIs and related junk are I believe needed only on Alpha, which
> has
> >    no single memory-barrier instruction that can do wmbdd()'s job.  Given
> >    that Alpha seems to be on its way out, this did not seem to me to be
> >    too horrible.
> >
> > I somehow doubt that you need an IPI to implement the equivalent of
> > "membar #StoreStore" on Alpha.  Richard?
> 
> I received my copy of the SPARC Architecture Manual (Weaver and Germond)
> today.
> 
> It turns out that there is -no- equivalent of "membar #StoreStore"
> on Alpha, if I am correctly interpreting this manual.

The equivalent of "membar #StoreStore" on alpha is be the "wmb" asm
instruction, in linux common code called wmb().

> >From section D.4.4, on page 260:
> 
>      A memory order is legal in RMO if and only if:
> 
>      (1)  X <d Y & L(X) -> X <m Y
> 
>      [... two other irrelevant cases omitted ...]
> 
>      Rule (1) states that the RMO model will maintain dependence
>      when the preceding transaction is a load.  Preceding stores
>      may be delayed in the implementation, so their order may
>      not be preserved globally.
> 
> In the example dereferencing a pointer, we first load the
> pointer, then load the value it points to.  The second load is
> dependent on the first, and the first is a load.  Thus, rule (1)
> holds, and there is no need for a read-side memory barrier
> between the two loads.
> 
> This is consistent with the book's definition of
> "completion" and the description of the membar
> instruction.
> 
> In contrast, on Alpha, unless there is an explicit rmb(), data
> dependence between a pair of loads in no way forces the two loads
> to be ordered.  http://lse.sourceforge.net/locking/wmbdd.html
> shows how Alpha can get the new value of the pointer, but the
> old value of the data it points to.  Alpha thus needs the rmb()
> between the two loads, even though there is a data dependency.

You remeber I was suprised when you told me alpha needs the rmb despite
of the data dependency :). I thought it wasn't needed (and in turn I
thought we didn't need the wmbdd). I cannot see this requirement
in any alpha specification infact. Are you sure the issue isn't
specific to old cpus or old cache coherency protocols that we can safely
ignore today? I think in SMP systems we care only about ev6 ev67 and
future chips. Also if this can really be reproduced it shouldn't be too
difficult to demonstrate it with a malicious application that stress the
race in loop, maybe somebody (Ivan?) could be interested to write such
application to test.

The IPI just for the rmb within two reads that depends on each other is
just too ugly... But yes, adding rmb() in the reader side looks even
uglier and nobody should really need it.

> Am I misinterpreting the SPARC manual?
> 
>                               Thanx, Paul
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Andrea
