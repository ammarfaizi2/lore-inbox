Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287817AbSCKSqg>; Mon, 11 Mar 2002 13:46:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSCKSq0>; Mon, 11 Mar 2002 13:46:26 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:16062 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S287817AbSCKSqL>; Mon, 11 Mar 2002 13:46:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Rusty Russell <rusty@rustcorp.com.au>,
        Peter =?iso-8859-1?q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: Mon, 11 Mar 2002 13:47:02 -0500
X-Mailer: KMail [version 1.3.1]
Cc: arjanv@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16jYor-0003Ty-00@wagner.rustcorp.com.au>
In-Reply-To: <E16jYor-0003Ty-00@wagner.rustcorp.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020311184603.212393FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 March 2002 11:50 pm, Rusty Russell wrote:
> In message <3C888284.8030206@loewe-komp.de> you write:
> > Rusty Russell wrote:
> > > To clarify: I'd love this, but rwlocks in the kernel aren't even
> > > vaguely fair.  With a steady stream of overlapping readers, a writer
> > > will never get the lock.
> > >
> > > Hope that clarifies,
> >
> > But you talk about the current implementation, don't you?
> > Is there something to prevent an implementation of rwlocks in the
> > kernel, where a wrlock will lock (postponed) further rdlock requests?
>
> It's proven hard to do without performance impact.  Also, we can't do
> rw semaphores in a single word: you need two.
>
> Disproving me by implementation VERY welcome!
>
> Hope that helps,
> Rusty.

Well I did it with one word and cmpxchg and two queues in the kernel.
The two queues can be consolidated to one if the wait_element for the
queue has a third word, namely read or write.

Did you have a chance to think about the 
FUTEX_UP and FUTEX_UP_FAIR issue.
This should be simple enough as shown in the patch that pulled
your two approaches together. It doesn't seem to come at an
additional cost for the simple FUTEX_UP case.

I thought about it some more and talked to some other folks here.
One option is to wake up multiple ones as well to avoid starvation
and increase throughput.
E.g.    FUTEX_UP_SOME where you wake up #cpu tasks.
They would then go and contend for the lock again.

 
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
