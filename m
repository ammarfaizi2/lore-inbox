Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135192AbRDLNnW>; Thu, 12 Apr 2001 09:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135191AbRDLNnN>; Thu, 12 Apr 2001 09:43:13 -0400
Received: from [32.97.182.101] ([32.97.182.101]:6803 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S135190AbRDLNnE>;
	Thu, 12 Apr 2001 09:43:04 -0400
Importance: Normal
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, "Pratap Pattnaik" <pratap@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF4470826B.E254EA3C-ON85256A2C.0049F803@pok.ibm.com>
From: "Hubertus Franke" <frankeh@us.ibm.com>
Date: Thu, 12 Apr 2001 09:44:43 -0400
X-MIMETrack: Serialize by Router on D01ML244/01/M/IBM(Release 5.0.7 |March 21, 2001) at
 04/12/2001 09:42:56 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



First the 2.4.3 tries to prefer the child.
Only does it in half of the cases though (odd counter numbers).

Your patch seems a bit radical for what you want to do.
Taking away all tokens from the parents will require that it has to wait
until the next recalculate loop.
Since (p) and (current) share the same <mm> and the same <cpu>
why not simply make sure that the (p->counter) > (current->counter).
If you are concerned that a tick is not enough to fire off the
exec then make it a predefined constant.

Try this ... this will guarantee that (p->counter) > (current->counter)
and it seems not as radical

         p->counter = (current->counter + 1) >> 1;
        current->counter = (current->counter - 1) >> 1;
        if (!current->counter)
                current->need_resched = 1;


instead of this


-       p->counter = (current->counter + 1) >> 1;
-       current->counter >>= 1;
-       if (!current->counter)
-               current->need_resched = 1;
+       p->counter = current->counter;
+       current->counter = 0;
+       current->need_resched = 1;

Hubertus Franke
Enterprise Linux Group (Mgr),  Linux Technology Center (Member Scalability)
, OS-PIC (Chair)
email: frankeh@us.ibm.com
(w) 914-945-2003    (fax) 914-945-4425   TL: 862-2003



"Adam J. Richter" <adam@yggdrasil.com>@vger.kernel.org on 04/12/2001
04:55:16 AM

Sent by:  linux-kernel-owner@vger.kernel.org


To:   torvalds@transmeta.com, linux-kernel@vger.kernel.org
cc:
Subject:  PATCH(?): linux-2.4.4-pre2: fork should run child first



     I remember sometime in the late 80's a fellow at UniSoft
named Don whose last name escapes me just now told me about a
paper presented at a Usenix symposium that had some measurements
that purported that copy-on-write was a performance lose and
better performance would be achieve by having fork() just copy
all of the writable pages of the parent process.

     It turned out that the particular unix-like system on which
these benchmarks were taken had a version of fork that did not run
the child first.  As it was explained to me then, most of the time,
the child process from a fork will do just a few things and then do
an exec(), releasing its copy-on-write references to the parent's
pages, and that is the big win of copy-on-write for fork() in practice.
This oversight was considered a big embarassment for the operating
system in question, so I won't name it here.

     Guess why you're seeing this email.  That's right.  Linux-2.4.3's
fork() does not run the child first.  Consequently, the parent will
probably generate unnecessary copy-on-write page copies until it burns
through its remaining clock ticks (any COW's that the child causes will
basically happen no matter what the order of execution is) or calls
wait() (and while the wait is blocking, the parent's CPU priority will
decay as the scheduler periodically recalculates process priorities, so
that bit of dynamic priority has probably not been allocated where the
user will be able to use it, if we want to look at "fairness" in such
detail).

     I suppose that running the child first also has a minor
advantage for clone() in that it should make programs that spawn lots
of threads to do little bits of work behave better on machines with a
small number of processors, since the threads that do so little work that
they accomplish they finish within their time slice will not pile up
before they have a chance to run.  So, rather than give the parent's CPU
priority to the child only if CLONE_VFORK is not set, I have decided to
do a bit of machete surgery and have the child always inherit all of the
parent's CPU priority all of the time.  It simplifies the code and
probably saves a few clock cycles (and before you say that this will
cost a context switch, consider that the child will almost always run
at least one time slice anyhow).

     I have attached the patch below.  I have also adjusted the
comment describing the code.  Please let me know if this hand waving
explanation is sufficient.  I'm trying to be lazy on not do a measurement
project to justify this relatively simple change.  However, I do know, from
a simple test program ("printf ("%d", fork());"), that this patch has
the intended effect of running the child first.

--
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite
104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."






