Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSIWWcz>; Mon, 23 Sep 2002 18:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSIWWcz>; Mon, 23 Sep 2002 18:32:55 -0400
Received: from mark.mielke.cc ([216.209.85.42]:44806 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S261426AbSIWWct>;
	Mon, 23 Sep 2002 18:32:49 -0400
Date: Mon, 23 Sep 2002 18:35:29 -0400
From: Mark Mielke <mark@mark.mielke.cc>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Larry McVoy <lm@bitmover.com>, Peter Waechtler <pwaechtler@mac.com>,
       linux-kernel@vger.kernel.org, ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923183529.A26887@mark.mielke.cc>
References: <20020923083004.B14944@work.bitmover.com> <Pine.LNX.3.96.1020923152135.13351C-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96.1020923152135.13351C-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Sep 23, 2002 at 03:48:58PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 03:48:58PM -0400, Bill Davidsen wrote:
> On Mon, 23 Sep 2002, Larry McVoy wrote:
> > Sure, there are lotso benchmarks which show how fast user level threads
> > can context switch amongst each other and it is always faster than going
> > into the kernel.  So what?  What do you think causes a context switch in
> > a threaded program?  What?  Could it be blocking on I/O?  Like 99.999%
> > of the time?  And doesn't that mean you already went into the kernel to
> > see if the I/O was ready?  And doesn't that mean that in all the real
> > world applications they are already doing all the work you are arguing
> > to avoid?
> Actually you have it just backward. Let me try to explain how this works.
> The programs which benefit from N:M are exactly those which don't behave
> the way you describe. Think of programs using locking to access shared
> memory, or other fast resources which don't require a visit to the kernel.
> It would seem that the switch could be done much faster without the
> transition into and out of the kernel.

For operating systems that require cross-process locks to always be
kernel ops, yes. For operating systems that provide _any_ way for most
cross-process locks to be performed completely in user space (i.e. FUTEX),
the entire argument very quickly disappears.

Is there a situation you can think of that requires M:N threading
because accessing user space is cheaper than accessing kernel space? 
What this really means is that the design of the kernel space
primitives is not optimal, and that a potentially better solution that
would benefit more people by a great amount, would be to redesign the
kernel primitives. (i.e. FUTEX)

> Looking for data before forming an opinion has always seemed to be
> reasonable, and the way design decisions are usually made in Linux, based
> on the performance of actual code. The benchmark numbers reports are
> encouraging, but actual production loads may not show the huge improvement
> seen in the benchmarks. And I don't think anyone is implying that they
> will.

You say that people should look to data before forming an opinion, but
you also say that benchmarks mean little and you *suspect* real loads may
be different. It seems to me that you might take your own advice, and
use 'real data' before reaching your own conclusion.

> Given how small the overhead of threading is on a typical i/o bound
> application such as you mentioned, I'm not sure the improvement will be
> above the noise. The major improvement from NGPT is not performance in
> many cases, but elimination of unexpected application behaviour.

Many people would argue that threading overhead has been traditional quite
high. They would have 'real data' to substantiate their claims.

> When someone responds to a technical question with an attack on the
> question instead of a technical response I always wonder why. In this case
> other people have provided technical feedback and I'm sure we will see
> some actual application numbers in a short time. I have an IPC benchmark
> I'd like to try if I could get any of my test servers to boot a recent
> kernel :-(

I've always considered 1:1 to be an optimal model, but an unreachable
model, like cold fusion. :-)

If the kernel can manage the tasks such that they can be very quickly
switched betweens queues, and the run queue can be minimized to
contain only tasks that need to run, or that have a very high
probability of needing to run, and if operations such as locks can be
done, at least in the common case, completely in user space, there
is no reason why 1:1 could not be better than M:N.

There _are_ reasons why OS threads could be better than user space
threads, and the reasons all relate to threads that do actual work.

The line between 1:1 and M:N is artificially bold. M:N is a necessity
where 1:1 is inefficient. Where 1:1 is efficient, M:N ceases to be a
necessity.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

