Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264916AbSIWHOT>; Mon, 23 Sep 2002 03:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264918AbSIWHOT>; Mon, 23 Sep 2002 03:14:19 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26770 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264916AbSIWHOS>;
	Mon, 23 Sep 2002 03:14:18 -0400
Date: Mon, 23 Sep 2002 09:27:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: bob <bob@watson.ibm.com>
Cc: Karim Yaghmour <karim@opersys.com>, <okrieg@us.ibm.com>, <trz@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [ltt-dev] Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <15758.22318.507460.859271@k42.watson.ibm.com>
Message-ID: <Pine.LNX.4.44.0209230920160.2518-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, bob wrote:

> Yes this is simple code - similar to the model we use in K42.  Still,
> couple of things about the below.
> 
> 1) the !event_wanted can be done outside the function, in a macro so
> that the only cost if tracing is disabled is a hot cache hit on a mask
> (not function call) - that helps with your comment:
> > The event_wanted() filter function should be made as fast as possible.

yes. It's a cost to be considered, but the main issue these days is the
icache cost of inlining. So generally we are leaning towards the
least-impact inlining cost.

> 2) If you use the lockless scheme you do not need to disable interrupts.
> In K42 we manage to do the entire log operation in 21 instructions and
> about as many cycles (couple more for getting time).  We do this from
> user space as well, disabling interrupts precludes this model (may of
> may not be a problem).  I was really leaning hard away from even the
> cost of making a system call and disabling interrupts.  Do people on the
> kernel dev team feel this is an acceptable cost?  Is migration prevented
> when interrupts are disabled?  This is something for us to consider.

the trace() functions runs purely in kernel-space, so doing a cli/sti is
not a performance problem - if it can be avoided it saves a few cycles,
but it does not have any global costs. But i dont think reliable tracing
can be done without disabling interrupts - how do you guarantee that there
will be no trace 'holes' due to interruption at the wrong instruction?

> 3) All trace events should not have to have the same number of data
> words logged - though I think that's just a packaging/interface issue
> the code below would just be placed behind macros which correctly
> package up the right number of arguments.

yes, agreed, this can be solved by having some sort of RLA, tightly packed
trace buffer. Trace buffer usage is definitely one of the more important
points.

	Ingo


