Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278808AbRKHXiO>; Thu, 8 Nov 2001 18:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278829AbRKHXiD>; Thu, 8 Nov 2001 18:38:03 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:32243
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278808AbRKHXh4>; Thu, 8 Nov 2001 18:37:56 -0500
Date: Thu, 8 Nov 2001 15:37:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
Message-ID: <20011108153749.A14468@mikef-linux.matchmail.com>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.33.0111082028430.20248-100000@localhost.localdomain> <Pine.LNX.4.40.0111081056490.1501-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0111081056490.1501-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2001 at 11:13:30AM -0800, Davide Libenzi wrote:
> On Thu, 8 Nov 2001, Ingo Molnar wrote:
> 
> >
> > On Thu, 8 Nov 2001, Davide Libenzi wrote:
> >
> > > It sets the time ( in jiffies ) at which the process won't have any
> > > more scheduling advantage.
> >
> > (sorry, it indeed makes sense, since sched_jtime is on the order of
> > jiffies.)
> >
> > > > and your patch adds a scheduling advantage to processes with more cache
> > > > footprint, which is the completely opposite of what we want.
> > >
> > > It is exactly what we want indeed :
> >
> > if this is what is done by your patch, then we do not want to do this.
> > My patch does not give an advantage of CPU-intensive processes over that
> > of eg. 'vi'.
> 
> If A & B are CPU hog processes and E is the editor ( low level keventd )
> you do want to avoid priority inversion between A and B when E kicks in.
> Really IO bound tasks accumulates dynamic priority inside the recalc loop
> and this is sufficent to win over this kind of "advantage" given to CPU
> hog tasks.
> My approach make also more "expensive" the preemption goodness to move
> tasks between CPUs.
> I'll take a closer look at your patch anyway.
> 

Conceptually, both patches are compatible.

Whether they are technically is for someone else to say...

Ingo's patch in effect lowers the number of jiffies taken per second in the
scheduler (by making each task use several jiffies).

Davide's patch can take the default scheduler (even Ingo's enhanced
scheduler) and make it per processor, with his extra layer of scheduling
between individual processors.

I think that together, they both win.  Davide's patch keeps a task from
switching CPUs very often, and Ingo's patch will make each task on each CPU
use the cache to the best extent for that task.

It remains to be proven whether the coarser scheduling approach (Ingo's) will
actually help when looking at cache properties....  When each task takes a
longer time slice, that allows the other tasks to be flushed out of the
caches during that time.  When the next task comes back in, it will have to
re-populate the cache again.  And the same for the next and etc...

Mike
