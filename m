Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267052AbSLKIG2>; Wed, 11 Dec 2002 03:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbSLKIG1>; Wed, 11 Dec 2002 03:06:27 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:14578 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267052AbSLKIGX>;
	Wed, 11 Dec 2002 03:06:23 -0500
Message-ID: <3DF6F31F.DBB24F10@mvista.com>
Date: Wed, 11 Dec 2002 00:11:11 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Jacobowitz <dan@debian.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <3DF06B15.1F6ECD5D@mvista.com> <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com> <20021209154142.GA22901@nevyn.them.org> <3DF673B9.4E273E83@mvista.com> <20021211071041.GA8988@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz wrote:
> 
> On Tue, Dec 10, 2002 at 03:07:37PM -0800, george anzinger wrote:
> > Daniel Jacobowitz wrote:
> > >
> > > On Fri, Dec 06, 2002 at 09:57:08AM -0800, Linus Torvalds wrote:
> > > >
> > > > I just pushed my version of the system call restart code to the BK trees.
> > > > It's losely based on Georges code, but subtly different. Also, I didn't
> > > > actually update any actual system calls to use it, I just did the
> > > > infrastructure.
> > > >
> > > > Non-x86 architectures need to be updated to work with this: they need to
> > > > update their thread structures, the additional do_signal() support in
> > > > their signal.c, and add the actual system call itself somewhere. For x86,
> > > > this was about 15 lines of changes.
> > > >
> > > > The basic premise is very simple: if you want to restart a system call,
> > > > you can do
> > > >
> > > >       restart = &current_thread()->restart_block;
> > > >       restart->fn = my_continuation_function;
> > > >       restart->arg0 = my_arg0_for_continuation;
> > > >       restart->arg1 = my_arg1_for_continuation;
> > > >       ..
> > > >       return -ERESTARTSYS_RESTARTBLOCK;
> > > >
> > > > which will cause the system call to either return -EINTR (if a signal
> > > > handler was actually invoced) or for "benign" signals (SIGSTOP etc) it
> > > > will end up restarting the system call at the continuation function (with
> > > > the "restart" block as the argument).
> > > >
> > > > We could extend this to allow restarting even over signal handlers, but
> > > > that would have some re-entrancy issues (ie what happens if a signal
> > > > handler itself wants to use a system call that may want restarting), so at
> > > > least for now restarting is only done when no handler is invoced (*).
> > > >
> > > >                       Linus
> > > >
> > > > (*) The nesting case is by no means impossible to handle gracefully
> > > > (adding a "restart even if handler is called" error number and returning
> > > > -EINTR if nesting, for example), but I don't know of any system calls that
> > > > would really want to try to restart anyway, so..
> > >
> > > Well, here's something to consider.  This isn't entirely hypothetical;
> > > there are test cases in GDB's regression suite that cover nearly this.
> > >
> > > Suppose a process is sleeping for an hour.  The user wants to see what
> > > another thread is doing, so he hits Control-C; the thread which happens
> > > to be reported as 'current' is the one that was in nanosleep().  It
> > > used to be that when he said continue, the nanosleep would return; now
> > > hopefully it'll continue.  Great!  But this damnable user isn't done
> > > yet.  He wants to look at one of his data structures.  He calls a
> > > debugging print_foo() function from GDB.  He realizes he left a
> > > sleep-for-a-minute nanosleep call in it and C-c's again.  Now we have
> > > two interrupted nanosleep calls and the application will never see a
> > > signal to interrupt either of them; he says "continue" twice and
> > > expects to get back to his hour-long sleep.
> > >
> > > Note that I'm not saying we _need_ to support this, mind :)  It's a
> > > little pathological.
> >
> > I seem to recall working on a debugger in the distant past
> > and put a lock in it that did not allow it to run a debuggee
> > function while the debugee was in a system call.  It seems
> > to me that is is begging for problems and is not that hard
> > for gdb/etc to prevent.
> >
> > Daniel, what to you think?
> 
> I really don't see the point.  I like being able to call functions
> while stopped in read() or poll(); you can hit C-c and go off to
> examine your application.  That's as much "in a syscall" as this is.

Granted, and restarting them is a bit easier, to be sure. 
But if the function does the same call it can hose the
program.
> 
> Besides, implementing this is more of a pain than it's worth.

The problem we are left with is how to detect that a
nanosleep call that is interrupted and has set itself up to
continue and determine if it is, in fact, now handling that
continue call.  Once we figure that out, we need to
understand what to do if it is not, i.e. what to do when the
call is continued.  The "correct" thing to do would be to
stack all the relevant info on the user stack and pop it off
when needed much as what is done on a signal.

As it stands now, however, the detection of the need to do
this comes AFTER ptrace has handed control over to the
debugger and it has modified the users stack.
> 
How about something like this:

1.) We use the same error returns as now and do not use a
new restart system call.
2.) Define a function "push_restart(struct restart_block
*restart)" which is called by the function when it detects
that it _may_ be restarted.  This function would save the
restart block in a block of memory allocated from the slab
allocater and link it into the task, either the task_struct
or the thread_info.  The function would add the current user
stack address and pc to the block.
3.) do_signal would toss the block and return the memory if
it determines that the call is not to be restarted.
4.) Define a "int pop_restart(struct restart_block
*restart)" function which the system call should call if it
is possible that it may be restarted.  This function would
search the list of restart_blocks for the task doing:
a.) freeing any that have stack tags that are below the
current stack and 
b.) returning the block with the current stack and pc
address, or null if not found.

This should be a true push down stack so that either a.) or
b.) will always be true unless there is no block for the
current call.  I.e. the search can stop once the stack tag
is above the current user stack address.

We could put the first restart block in the task_struct or
thread_info area so we almost never allocate any memory.

So, is this overkill?

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
