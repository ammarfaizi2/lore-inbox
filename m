Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272532AbRITU0h>; Thu, 20 Sep 2001 16:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274633AbRITU01>; Thu, 20 Sep 2001 16:26:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43255 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S272532AbRITU0O> convert rfc822-to-8bit; Thu, 20 Sep 2001 16:26:14 -0400
Message-ID: <3BAA4DD2.FDDAEE6F@mvista.com>
Date: Thu, 20 Sep 2001 13:13:06 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Robert Love <rml@tech9.net>, Roger Larsson <roger.larsson@norran.net>,
        linux-kernel@vger.kernel.org,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Preemption Latency Measurement Tool
In-Reply-To: <1000939458.3853.17.camel@phantasy> <20010920063143.424BD1E41A@Cantor.suse.de> <20010920084131.C1629@athlon.random> <20010920075751.6CA791E6B2@Cantor.suse.de> <20010920102139.G729@athlon.random>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Thu, Sep 20, 2001 at 09:57:50AM +0200, Dieter Nützel wrote:
> > Am Donnerstag, 20. September 2001 08:41 schrieb Andrea Arcangeli:
> > > Those inodes lines reminded me one thing, you may want to give it a try:
> > >
> > > --- 2.4.10pre12aa1/fs/inode.c.~1~   Thu Sep 20 01:44:07 2001
> > > +++ 2.4.10pre12aa1/fs/inode.c       Thu Sep 20 08:37:33 2001
> > > @@ -295,6 +295,12 @@
> > >                      * so we have to start looking from the list head.
> > >                      */
> > >                     tmp = head;
> > > +
> > > +                   if (unlikely(current->need_resched)) {
> > > +                           spin_unlock(&inode_lock);
> > > +                           schedule();
> > > +                           spin_lock(&inode_lock);
> > > +                   }
> > >             }
> > >     }
> > >
Be warned, while the above will improve latency, it will not improve the
numbers reported by the tool.  The reason is that the tool looks at
actual preemption disable times, so it does not care if "need_resched"
is set or not.  This means that, in the case where need_resched is not
set, the tool would report a long latency as if the conditional lock
break code was not present.  To get the above code into the tools
purview, you could either code it without the conditional or, better,
put the whole thing into a macro ( I think Ingo called it
"conditional_schedule()") and put the instrumentation stuff in the
macro.  Also, in the case of a system with the preemption patch, the
schedule is not needed unless the BKL is also held.

> >
> > You've forgotten a one liner.
> >
> >   #include <linux/locks.h>
> > +#include <linux/compiler.h>
> 
> woops, didn't trapped it because of gcc 3.0.2. thanks.
> 
> > But this is not enough. Even with reniced artsd (-20).
> > Some shorter hiccups (0.5~1 sec).
> 
> I'm not familiar with the output of the latency bench, but I actually
> read "4617" usec as the worst latency, that means 4msec, not 500/1000
> msec.
> 
> > Worst 20 latency times of 4261 measured in this period.
> >   usec      cause     mask   start line/file      address   end line/file
>     ^^^^
> >   4617   reacqBKL        0  1375/sched.c         c0114d94  1381/sched.c
>     ^^^^
~snip
> 
> those are kernel addresses, can you resolve them via System.map rather
> than trying to find their start/end line number?

Uh, trying to find???  These are the names and line numbers provided by
the PPC macros.  The only time the address is helpful is when the bad
guy is hiding in an "inline" in a header file.  Still, is there a simple
script to get the function/offset from the System.map?  We could then
post process with a simple bash/sed script.

> 
> > Worst 20 latency times of 8033 measured in this period.
> >   usec      cause     mask   start line/file      address   end line/file
> >  10856  spin_lock        1  1376/sched.c         c0114db3   697/sched.c
> 
> with dbench 48 we gone to 10msec latency as far I can see (still far
> from 0.5~1 sec). dbench 48 is longer so more probability to get the
> higher latency, and it does more I/O, probably also seeks more, so thre
> are many variables (slower insection in I/O queues first of all, etcll).
> However 10msec isn't that bad, it means 100hz, something that the human
> eye cannot see. 0.5~1 sec would been horribly bad latency instead.. :)

Ah, but we would REALLY like to see it below 1msec.
~snip
 
George
