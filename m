Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267191AbSLECml>; Wed, 4 Dec 2002 21:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267193AbSLECml>; Wed, 4 Dec 2002 21:42:41 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56589 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267191AbSLECmj>; Wed, 4 Dec 2002 21:42:39 -0500
Date: Wed, 4 Dec 2002 18:51:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DEEB37A.233DD280@mvista.com>
Message-ID: <Pine.LNX.4.44.0212041830100.3100-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, george anzinger wrote:
> 
> The way the system is now a system call "appears" to get by
> value calls, but the parameters are on the stack (in the
> regs structure).  This is what is restored and passed back
> on a system call restart.  What I am getting at is that
> nano_sleep could scribble anything it wants here and
> "notice" it on the recall.

Absolutely. That's what my ERESTARTSYS_RESTARTBLOCK thing is all about: a
"portable" way to let the architecture-specific do_signal() know what to
do about the return stack.

It mustn't be nanosleep()-specific, that just gets too nasty.

> Changing the call to absolute changes the semantics (in
> particular the behavior on clock setting) in a way I don't
> think you want to.  I.e. you can tell it was done.  So you
> would have to do this in a way that does not look like the
> absolute call in the current POSIX spec.

No, the point is that re-starting the system call is totally invisible to 
user space, and user space would never use the "restart" system call 
directly.

Let me give a more explicit example on an x86 level:

 - This is part of the x86 library function:

		movl 4(%esp),%ebx	// request
		movl 8(%esp),%ecx	// remainder
		movl $162,%eax		// nanosleep syscall #
		int 0x80		// system call

 - this enters the kernel, which saves stuff off on the stack, 
   and calls sys_nanosleep by indexing the 162 off the system call
   table. Time is now X.

 - we're supposed to sleep until "X + request"

	...
	schedule_timeout()

 - we get woken up by a signal thing, which doesn't have a handler, but 
   does (for example) put us to sleep. Let's say that it's SIGSTOP. To 
   handle the signal, sys_nanosleep() need to return -ERESTARTSYS because
   it can't do it on its own.

 - 2 seconds later, the user sends a SIGCONT, and the process restarts. 
   Time is now X+2, which may or may not be AFTER the original timeout. 

See the problem here? We MUST NOT restart the system call with the
original timeout pointer (the contents of which we must not change). Not
only have we already slept part of the time (that part we know about), but
we may _also_ have been blocked by a signal part of the time (which has
been totally outside the control of sys_nanosleep()).

So my solution implies that our restart logic in do_signal(), which 
already knows how to update the user-level EIP register (that's how the 
restart is done), can also be told to update the system call and the 
argument registers. So what we do is to introduce a _new_ system call 
(system call number NNN), which takes a different form of timeout, namely 
"absolute value of end time".

And then, when we enter do_signal(), we not only update %eip to point to 
the original "int 0x80" instruction, we _also_ update %eax to point to the 
new system call NNN, _and_ we update %ebx to contain the new timeout in 
absolute jiffies:

	current_thread->restart_block.syscall_nr = NNN;
	current_thread->restart_block.arg0 = jiffies + timeout;

and then we have a

	sys_nanosleep_resume(unsigned long timeout, struct timespec *rem)
	{
		long jif = timeout - jiffies;

		if (jif > 0) {
			current->state = TASK_INTERRUPTIBLE;
			jif = schedule_timeout(jif);
			/* interrupted - we already have the restart block set up */
			if (jif) {
				if (rem)
					jiffies_to_usertimespec(jif, rem);
				return -ERESTART_RESTARTBLOCK;
			}
		}
		put_user(0, rem->tv_sec);
		put_user(0, rem->tv_nsec);
		return 0;
	}

See? The "nanosleep_resume" system call is never used by a program
directly, it's only virtualized by the signal restart changing the system
call number on restart. (A user program _could_ use it directly, but
there's no point, and the interface to the thing might change at any
time).

		Linus

