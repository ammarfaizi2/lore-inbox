Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319150AbSHTDRC>; Mon, 19 Aug 2002 23:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319151AbSHTDRC>; Mon, 19 Aug 2002 23:17:02 -0400
Received: from crack.them.org ([65.125.64.184]:14096 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S319150AbSHTDRB>;
	Mon, 19 Aug 2002 23:17:01 -0400
Date: Mon, 19 Aug 2002 23:21:30 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave McCracken <dmccr@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
Message-ID: <20020820032130.GA15912@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Dave McCracken <dmccr@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <65670000.1029783102@baldur.austin.ibm.com> <Pine.LNX.4.44.0208192251540.2201-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208192251540.2201-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 10:59:17PM +0200, Ingo Molnar wrote:
> 
> On Mon, 19 Aug 2002, Dave McCracken wrote:
> 
> > In looking at the code I was wondering something.  What happens to the
> > real parent of a ptraced task when it calls wait4()?  If that's its only
> > child, won't it return ECHILD?
> 
> hm, so this could be fixed by iterating over the ptraced tasks as well
> when doing a wait4.
> 
> the problem is that the debugger wants to do a wait4 as well, to receive
> the SIGSTOP result. Now if the original parent 'steals' the wait4 result,
> what will happen?
> 
> this whole mess can only be fixed by decoupling the ptrace() mechanism
> from signals and wait4 completely, it's a nasty relationship that infests
> both the kernel and userspace code [check out strace.c once to see the
> kind of pain it has to go through to isolate ptrace events from other
> signals.]
> 
> I'm not quite sure whether this is possible, how deeply do ptrace
> applications depend on a real SIGSTOP signal interrupting the task? Would
> it be equally good if it was a different interruption/signalling method
> that did this? [with a few minor and straightforward cleanups to entry.S i
> think we could use a task ornament flag for ptrace interruption. This
> would result in a few orders better behavior on all fronts.]

I have in my mailbox somewhere the beginnings of an implementation of
this, from David Howells (the ornaments approach); I think he ran out
of time to work on it.  Rather than pursue it, if there's someone
interested in giving Linux a way to access at least some of the
Solaris/BSD procfs debug interface...

The biggest problem with ptrace is the way it overloads signals.  It
makes figuring out what events are pretty tricky (see the patches I
just posted for some workarounds on this), and it makes debugging a
signal-intensive process extremely awkward.  For instance, in a lot of
cases you'll lose or confuse the realtime payload entirely.


I don't think there is anything you could do here that would not break
strace/gdb's uses of ptrace, however; any incremental changes would
toast them.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
