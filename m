Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264575AbSIVWcx>; Sun, 22 Sep 2002 18:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264576AbSIVWcw>; Sun, 22 Sep 2002 18:32:52 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:37078 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S264575AbSIVWcu>; Sun, 22 Sep 2002 18:32:50 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Sun, 22 Sep 2002 18:37:46 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: bob <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       <okrieg@us.ibm.com>, trz@us.ibm.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209222333470.19919-100000@localhost.localdomain>
References: <15758.12948.103681.852724@k42.watson.ibm.com>
	<Pine.LNX.4.44.0209222333470.19919-100000@localhost.localdomain>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15758.14124.935684.460733@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > On Sun, 22 Sep 2002, bob wrote:
 > 
 > > There is no drag on the kernel.  The concept that we are working on is
 > > consistent with your below recommendations.  Only place in the kernel an
 > > efficient tracing infrastructure, keep trace points as patches. [...]
 > 
 > well, this is not the impression i got from the patches posted to lkml ...

The intent is to split LTT, get the infrastructure into the kernel, have
the trace points as patches.

 > 
 > > [...] This adds no overhead to kernel, allows your suggested patches to
 > > use a standard efficient infrastructure, reduces replicated work from
 > > specific problem to specific problem.
 > 
 > so why not keep the core parts as separate patches as well? If it does
 > nothing then i dont see why it should get into the kernel proper.

:-) It does do something.  It provides a common infrastructure for anyone
wanting to use trace points.  What I meant is that when not enabled it
doesn't cause any overhead.

As a performance tool it will be used not only be kernel developers but by
people writing device drivers, sub-systems, and apps.  Having an accepted
infrastructure in the kernel allows a common vocabulary to be used across
kernel, devices, sub-systems, and applications.  It allows sub-system
developers who know their system best to put in the events and developers
of other sub-systems of apps to use those events to understand what is
going on.  If the infrastructure is in the kernel, users could dynamically
enable and feedback performance results to the kernel developers.

In short this will provide a common way to discuss performance issues
across kernel, sub-system, and application space.

 > >  > my problem with this stuff is conceptual: it introduces a constant drag on
 > >  > the kernel sourcecode, while 99% of development will not want to trace,
 > > 
 > > If you care about performance you will want to trace.  On two previous
 > > kernels I have worked on I've heard this comment.  Once the
 > > infrastructure was in it was used and appreciated.
 > 
 > (i think you have not read what i have written. I use tracing pretty
 > frequently, and no, i dont need tracing in the kernel, during development
 > i can apply patches to kernel trees just fine.)

Good - I'm glad you find tracing useful - sorry if I reacted to the
statement that most of the time it's not needed.  As above, it should be in
the kernel proper not as just a patch.

> > The lockless scheme is pretty simple, instead of using a spinlock to
> > ensure atomic allocation of buffer space, the code does an
> > allocate-and-test routine where it tries to allocate space in the buffer
> 
> (this is in essence a moving spinlock at the tail of the trace buffer -
> same problem.)

No, we use lock-free atomic operations to reserve a place in the buffer to
write the data.  What happens is you attempt to atomic move the current
index pointer forward.  If you succeed then you have bought yourself that
many data words in the queue.  In the unlikely event you happened to
collide with someone you perform the atomic operation again.


Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com
