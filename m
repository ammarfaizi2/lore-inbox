Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277252AbRJLGjN>; Fri, 12 Oct 2001 02:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277258AbRJLGjE>; Fri, 12 Oct 2001 02:39:04 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36748 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277252AbRJLGi5>; Fri, 12 Oct 2001 02:38:57 -0400
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: andrea@suse.de (Andrea Arcangeli), cardoza@zk3.dec.com,
        frival@zk3.dec.com (Peter Rival),
        ink@jurassic.park.msu.ru (Ivan Kokshaysky), Jay.Estabrook@compaq.com,
        linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
        rth@twiddle.net (Richard Henderson), woodward@zk3.dec.com
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFEF9283F3.DB79EDD4-ON88256AE3.0024377A@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Thu, 11 Oct 2001 23:35:38 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/12/2001 12:36:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Note that they require a memory barrier (rmb()) between the time the
> > item is removed from the queue and the time that the data in the item
> > is referenced, despite the fact that there is a data dependency between
> > the dequeueing and the dereferencing.  So, again, data dependency does
> > -not- substitute for an MB on Alpha.
>
> This looks an awful lot like the PowerPC architecture.

IIRC, the PowerPC architecture requires that data dependencies
imply ordering (as does SPARC).  Unfortunately, I am currently >1000 km
from my PPC manual, and my eyes just aren't quite what they used to be.
I will look it up when I get back on Monday, and post my findings.

Sorry for the lack of an immediate answer!

> In an SMP system, one would most likely mark pages as
> requiring coherency. This means that stores to a memory
> location from multiple processors will give sane results.
> Ordering is undefined when multiple memory locations are
> involved.

Yep, the eieio and SYNC instructions are used to force
ordering.

> There is a memory barrier instruction called "eieio".
> This is commonly used for IO, but is also useful for RAM.
> Two separate sets of memory operations are simultaneously
> and independently affected by eieio:
>
> -- set one, generally memory-mapped IO space --
> loads to uncached + guarded memory
> stores to uncached + guarded memory
> stores to write-through-required memory
>
> -- set two, generally RAM on an SMP box --
> stores to cached + write-back + coherent

Set two is all we care about for SMP locking algorithms.
People writing drivers sometimes have to worry about
set one, but they often do so by use of locks, thus
avoiding the set-one issues.

> "The eieio instruction is intended for use in managing shared data
> structures ... the shared data structure and the lock that protects
> it must be altered only by stores that are in the same set"
>                              -- from the 32-bit ppc arch book

Yep!  If you map the same physical memory as coherent on one
CPU and uncached on another, you are certainly taking your
chances.  There may be a situation where doing this sort of
thing is useful, but I don't know of one.

                         Thanx, Paul

