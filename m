Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278309AbRJMO7T>; Sat, 13 Oct 2001 10:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278310AbRJMO7K>; Sat, 13 Oct 2001 10:59:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38134 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278309AbRJMO67>; Sat, 13 Oct 2001 10:58:59 -0400
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with
 insertion
To: Linus Torvalds <torvalds@transmeta.com>
Cc: dipankar@beaverton.ibm.com, linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF8D375F1C.810E1992-ON88256AE4.0050CCA0@boulder.ibm.com>
From: "Paul McKenney" <Paul.McKenney@us.ibm.com>
Date: Sat, 13 Oct 2001 07:42:49 -0700
X-MIMETrack: Serialize by Router on D03NM045/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/13/2001 08:59:27 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >
> > And the read side is:
> >        lock
> >        loopup
> >        atomic_inc
> >        unlock
> >
> > With RCU, read side is:
> >        loopup
> >        atomic_inc
>
> Yes. With maybe
>
>          non_preempt()
>          ..
>          preempt()
>
> around it for the pre-emption patches.
>
> However, you also need to make your free _free_ be aware of the count.
> Which means that the current RCU patch is really unusable for this. You
> need to have the "count" always in a generic place (put it with the
hash),

???

Ah!  Are you thinking of the trick that associates a reference counter
with each pointer, and where one uses a double-compare-and-swap instruction
to do updates?  That is definitely -not- what we are proposing here, since
it is important to avoid writes during read-only traversals.

Instead, we use side information to deduce when it is no longer possible
for there to be any references to a given data structure.

It -is- possible to use RCU in Linux -without- reference counts.  See
the Maneesh Soni's FD-management patch and description at:

http://lse.sourceforge.net/locking/patches/files_struct_rcu-2.4.10-04.patch
http://lse.sourceforge.net/locking/files_struct_rcu.txt

The reference counts are needed -only- in cases where references to an
RCU-protected data structure may be held across a sleep.  Dipankar Sarma's
IPV4 route-cache lookup patch at:

http://lse.sourceforge.net/locking/patches/rt_rcu-2.4.6-02.patch

is an example use of RCU where reference counts are used, since entries
can be queued.

                              Thanx, Paul

