Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310999AbSCHSOJ>; Fri, 8 Mar 2002 13:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310996AbSCHSM5>; Fri, 8 Mar 2002 13:12:57 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:34503 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S310998AbSCHSMt>; Fri, 8 Mar 2002 13:12:49 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: Fri, 8 Mar 2002 13:13:26 -0500
X-Mailer: KMail [version 1.3.1]
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
In-Reply-To: <E16j95K-00047G-00@wagner.rustcorp.com.au> <3C888284.8030206@loewe-komp.de>
In-Reply-To: <3C888284.8030206@loewe-komp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020308181230.832C73FE07@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 04:21 am, Peter Wächtler wrote:
> Rusty Russell wrote:
> > In message <20020307153228.3A6773FE06@smtp.linux.ibm.com> you write:
> >>On Thursday 07 March 2002 07:50 am, Arjan van de Ven wrote:
> >>>Rusty Russell wrote:
> >>>>This is a userspace implementation of rwlocks on top of futexes.
> >>>
> >>>question: if rwlocks aren't actually slower in the fast path than
> >>>futexes,
> >>>would it make sense to only do the rw variant and in some userspace
> >>>layer
> >>>map "traditional" semaphores to write locks ?
> >>>Saves half the implementation and testing....
> >>
> >>I m not in favor of that. The dominant lock will be mutexes.
> >
> > To clarify: I'd love this, but rwlocks in the kernel aren't even
> > vaguely fair.  With a steady stream of overlapping readers, a writer
> > will never get the lock.
> >
> > Hope that clarifies,
>
> But you talk about the current implementation, don't you?
> Is there something to prevent an implementation of rwlocks in the
> kernel, where a wrlock will lock (postponed) further rdlock requests?
>
> I mean: the wrlocker prevents newly rdlocks to succeed and waits for the
> current rdlockers to release the lock an then gets the lock..

Correct, the idea is to have four functionalities.

(a) writer preference
	if any writer is waiting then wake that one up.
(b) reader preference
	if any reader is waiting wait up all the readers in the queue
(c) fifo preference
	if the first waiter is a writer wait it up, otherwise wake up all readers
(d) fifo-fair  preference
	like (c), but only wake up readers until the next writer is encountered

(a) - (c) can be implemented with Rusty's 2 user-ueue approach as long
as the wakeup type is always the same. The last one can't (?).

In the kernel this is easy to implement, but the trouble is the status
word in user space, still thinking about it.

It also requires compare and swap.

Also we still need the verdict on the FUTEX_UP and FUTEX_UP_FAIR issue.
Rusty, I noticed you have not stated anything to my combining the two things
into FUTEX V submission. Could you respond with your take on these issues.

-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
