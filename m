Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261464AbSIWNyT>; Mon, 23 Sep 2002 09:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261487AbSIWNyT>; Mon, 23 Sep 2002 09:54:19 -0400
Received: from igw3.watson.ibm.com ([198.81.209.18]:50662 "EHLO
	igw3.watson.ibm.com") by vger.kernel.org with ESMTP
	id <S261464AbSIWNyR>; Mon, 23 Sep 2002 09:54:17 -0400
From: bob <bob@watson.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Sep 2002 09:59:05 -0400 (EDT)
To: Ingo Molnar <mingo@elte.hu>
Cc: bob <bob@watson.ibm.com>, Karim Yaghmour <karim@opersys.com>,
       <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209230920160.2518-100000@localhost.localdomain>
References: <15758.22318.507460.859271@k42.watson.ibm.com>
	<Pine.LNX.4.44.0209230920160.2518-100000@localhost.localdomain>
X-Mailer: VM 6.43 under 20.4 "Emerald" XEmacs  Lucid
Message-ID: <15759.7290.223110.768962@k42.watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar writes:
 > 
 > On Sun, 22 Sep 2002, bob wrote:
 > 
 > > Yes this is simple code - similar to the model we use in K42.  Still,
 > > couple of things about the below.
 > > 
 > > 1) the !event_wanted can be done outside the function, in a macro so
 > > that the only cost if tracing is disabled is a hot cache hit on a mask
 > > (not function call) - that helps with your comment:
 > > > The event_wanted() filter function should be made as fast as possible.
 > 
 > yes. It's a cost to be considered, but the main issue these days is the
 > icache cost of inlining. So generally we are leaning towards the
 > least-impact inlining cost.

mmm - that seems a reasonable trade-off.

 > > 2) If you use the lockless scheme you do not need to disable interrupts.
 > > In K42 we manage to do the entire log operation in 21 instructions and
 > > about as many cycles (couple more for getting time).  We do this from
 > > user space as well, disabling interrupts precludes this model (may of
 > > may not be a problem).  I was really leaning hard away from even the
 > > cost of making a system call and disabling interrupts.  Do people on the
 > > kernel dev team feel this is an acceptable cost?  Is migration prevented
 > > when interrupts are disabled?  This is something for us to consider.
 > 
 > the trace() functions runs purely in kernel-space, so doing a cli/sti is
 > not a performance problem - if it can be avoided it saves a few cycles,
 > but it does not have any global costs. But i dont think reliable tracing
 > can be done without disabling interrupts - how do you guarantee that there
 > will be no trace 'holes' due to interruption at the wrong instruction?

We do have a way of guaranteeing no 'holes' get created unless the process
is interrupted for a *very* long time or killed (which could happen) during
the logging of an event.  The code is a little more complicated and does
require an atomic operation that may be more or less equivalent to the cli
cost.  In K42, and other OSes I worked on, we wanted very efficient logging
from user space as well.  I think there might be a place for understanding
libc, database, jvm, performance, for examples, but if we really only do
log events in kernel space then the cli/sti approach is simpler and roughly 
equivalent performance.

 > 
 > > 3) All trace events should not have to have the same number of data
 > > words logged - though I think that's just a packaging/interface issue
 > > the code below would just be placed behind macros which correctly
 > > package up the right number of arguments.
 > 
 > yes, agreed, this can be solved by having some sort of RLA, tightly packed
 > trace buffer. Trace buffer usage is definitely one of the more important
 > points.

Yes! and we also have a scheme to allowed such a packed buffer stream to be
randomaly accessed on disk (useful if you have 100Ms or Gs of data).

-bob

Robert Wisniewski
The K42 MP OS Project
Advanced Operating Systems
Scalable Parallel Systems
IBM T.J. Watson Research Center
914-945-3181
http://www.research.ibm.com/K42/
bob@watson.ibm.com
