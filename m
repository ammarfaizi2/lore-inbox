Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278297AbRJMOLQ>; Sat, 13 Oct 2001 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278296AbRJMOLH>; Sat, 13 Oct 2001 10:11:07 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:22146 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278297AbRJMOKw>; Sat, 13 Oct 2001 10:10:52 -0400
From: "Paul E. McKenney" <pmckenne@us.ibm.com>
Message-Id: <200110131411.f9DEBAK07090@eng4.beaverton.ibm.com>
Subject: Re: Re: RFC: patch to allow lock-free traversal of lists
To: davidel@xmailserver.org (Davide Libenzi)
Date: Sat, 13 Oct 2001 07:11:08 -0700 (PDT)
Cc: paulus@samba.org (Paul Mackerras), torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0110121834150.1505-100000@blue1.dev.mcafeelabs.com> from "Davide Libenzi" at Oct 12, 2001 05:54:36 PM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> To set the record straight, the PPC architecture spec says that
>> implementations *can* speculate reads, but they have to make it look
>> as if dependent loads have a read barrier between them.
>>
>> And it isn't speculated reads that are the problem in the alpha case,
>> it's the fact that the cache can reorder invalidations that are
>> received from the bus.  That's why you can read the new value of p but
>> the old value of *p on one processor after another processor has just
>> done something like a = 1; wmb(); p = &a.
>
>I think that necessary condition to have a reordering of bus sent
>invalidations is to have a partitioned cache architecture.
>I don't see any valid reason for a cache controller of a linear cache
>architecture to reorder an invalidation stream coming from a single cpu.
>If the invalidation sequence for cpu1 ( in a linear cache architecture )
>is 1a, 1b, 1c, ... this case can happen :
>
>1a, 2a, 1b, 2b, 2c, 1c, ...
>|       |           |
>.........................
>
>but not this :
>
>1a, 2a, 2b, 1c, 2c, 1b, ...
>|           |       |
>...............><........

A split cache is certainly one way to get the updates reordered.  It is
not the only one.  As Linus pointed out earlier, value speculation can
have the same effect (though I do not believe that value speculation is
in the cards for the i386 architecture).

>> My impression from what Paul McKenney was saying was that on most
>> modern architectures other than alpha, dependent loads act as if they
>> have a read barrier between them.  What we need to know is which
>> architectures specify that behaviour in their architecture spec, as
>> against those which do that today but which might not do it tomorrow.
>
>Uhmm, an architecture that with  a = *p;  schedule the load of  *p  before
>the load of  p  sounds screwy to me.

Agreed, but value speculation could do just that.  However, value
speculation would be handled correctly by rmbdd() and by wmbdd(),
though the latter case relies on precise interrupts.

>The problem is that even if cpu1 schedule the load of  p  before the
>load of  *p  and cpu2 does  a = 1; wmb(); p = &a; , it could happen that
>even if from cpu2 the invalidation stream exit in order, cpu1 could see
>the value of  p  before the value of  *p  due a reordering done by the
>cache controller delivering the stream to cpu1.

Yep!  I did not create Alpha, I am just trying to help everyone understand
how to live with it.  ;-)

					Thanx, Paul
