Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261903AbSJIUZb>; Wed, 9 Oct 2002 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261942AbSJIUZb>; Wed, 9 Oct 2002 16:25:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:29172 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261903AbSJIUZa>;
	Wed, 9 Oct 2002 16:25:30 -0400
Message-ID: <3DA49002.3C4636@mvista.com>
Date: Wed, 09 Oct 2002 13:22:26 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>, Linus <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@karaya.com>
Subject: Re: [PATCH] make do_signal static on i386
References: <20021009181003.022da660.sfr@canb.auug.org.au> <3DA46A17.447B2C59@mvista.com> <20021009193738.GA15232@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> On Wed, Oct 09, 2002 at 10:40:39AM -0700, george anzinger wrote:
> > This will cause problems for nano_sleep and
> > clock_nanosleep.  These system calls need to call
> > do_signal() in order to meet the POSIX standard which states
> > that they are interrupted only by signals that are delivered
> > to user code.  Other signals are not to interrupt the
> > sleep.  This is why do_signal() returns this information to
> > the caller.
> >
> > I suppose one could argue that such functions should be in
> > signal.c, but save for this signal issue the code is
> > common.  Seems a waste to support the same code in N
> > platforms.
> 
> IMO, calling the architecture's do_signal function to handle that is
> entirely the wrong way to go.  They don't even all have the same
> arguments, and the wrappers hi-res-timers put around sys_nanosleep are
> hideous.

Ah, but they should, unless you mean the register structure
is different...
> 
> All of this should be handled correctly in kernel/signal.c, and things
> like triggering the debugger should be done from there, not duplicated
> in each platform's signal delivery code.

The other side of this nasty mess is getting a handle on the
registers.  They are all passed differently from the system
call stuff in entry.S (or what ever).
> 
> Ideally we should even trigger the debugger without necessarily
> knocking the sleeping process out of sleep.

Actually it is the other way round, the debugger is
triggering the task and asking it to go to a "collection"
point.

I would love to do it otherwise.  But this is what we have
today.  And the debugger is not the only case of signals
that do not get delivered to user code.  For the moment, I
would like to make sure the problem can still be addressed. 
At least today, a solution is possible.

As to how to deliver such events, what is needed is a way to
make a task arrive at a known point and to wait there.  Sure
sounds like a signal to me.  I don't see how this can be
done with out waking sleepers, but then there are lots of
things I don't see :)


-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
