Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277723AbRJIFpQ>; Tue, 9 Oct 2001 01:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277724AbRJIFpG>; Tue, 9 Oct 2001 01:45:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41434 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277723AbRJIFox>; Tue, 9 Oct 2001 01:44:53 -0400
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF2F33BD66.440BE6A1-ON88256AE0.001DFF26@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Mon, 8 Oct 2001 22:27:44 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/08/2001 11:45:18 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>    I am particularly interested in comments from people who understand
>    the detailed operation of the SPARC membar instruction and the PARISC
>    SYNC instruction.  My belief is that the membar("#SYNC") and SYNC
>    instructions are sufficient,
>
> SYNC is sufficient but way too strict.  You don't explicitly say what
> you need to happen.  If you need all previous stores to finish
> before all subsequent memory operations then:
>
>          membar #StoreStore | #StoreLoad
>
> is sufficient.  If you need all previous memory operations to finish
> before all subsequent stores then:
>
>          membar #StoreStore | #LoadStore
>
> is what you want.

I need to segregate the stores executed by the CPU doing the membar.
All other CPUs must observe the preceding stores before the following
stores.  Of course, this means that the loads on the observing CPUs
must be ordered somehow.  I need data dependencies between the loads
to be sufficient to order the loads.

For example, if a CPU executes the following:

     a = new_value;
     wmbdd();
     p = &a;

then i need any other CPU executing:

     d = *p;

to see either the value that "p" pointed to before the "p = &a" assignment,
or "new_value", -never- the old value of "a".

Does this do the trick?

           membar #StoreStore

>    Thoughts?
>
> I think if you need to perform IPIs and junk like that to make the
> memory barrier happen correctly, just throw your code away and use a
> spinlock instead.

The IPIs and related junk are I believe needed only on Alpha, which has
no single memory-barrier instruction that can do wmbdd()'s job.  Given
that Alpha seems to be on its way out, this did not seem to me to be
too horrible.

                                   Thanx, Paul

