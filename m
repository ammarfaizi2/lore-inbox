Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267186AbSLEB4e>; Wed, 4 Dec 2002 20:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267187AbSLEB4d>; Wed, 4 Dec 2002 20:56:33 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:54769 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S267186AbSLEB4A>;
	Wed, 4 Dec 2002 20:56:00 -0500
Message-ID: <3DEEB37A.233DD280@mvista.com>
Date: Wed, 04 Dec 2002 18:01:30 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, davidm@hpl.hp.com,
       schwidefsky@de.ibm.com, ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
References: <Pine.LNX.4.44.0212041600070.3100-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 4 Dec 2002, Jim Houston wrote:
> >
> > Agreed!  In my alternative version of the Posix timers patch, I avoid
> > calling do_signal() from clock_nanosleep by using a variant of the
> > existing ERESTARTNOHAND mechanism.  The problem I ran into was that I
> > could not tell on entry to clock_nanosleep if it was a new call or
> > an old one being restarted.
> 
> Restarting has other problems too, namely how to save off the partial
> results.
> 
> >                                 I solved this by adding a new
> > ERESTARTNANOSLP error code and making a small change in do_signal().
> > The handling of ERESTARTNANOSLP is the same as ERESTARTNOHAND but also
> > sets a new flag in the task_struct before restarting the system call.
> 
> The problem I see with this is that the signal handler can do a
> "siglongjump()" out of the regular path, and the next system call may well
> be a _new_ nanosleep() that has nothing to do with the old one. And
> realizing that it's _not_ a restarted one is interesting.
> 
> A better and more flexible approach would be to not restart the same
> system call with the same parameters, but having some way of telling
> do_signal to restart with new parameters and a new system call number.
> 
> For example, it shouldn't be impossible to have an interface more akin to
> 
>         ...
>         thread_info->restart_block.syscall = __NR_nanosleep_restart;
>         thread_info->restart_block.arg0 = timeout + jiffies; /* absolute time */
>         return -ERESTARTSYS_RESTARTBLOCK;
> 
> where the signal stack stuff re-writes not just eip (like the current
> restart logic does), but also rewrites the system call number and the
> argument registers.
> 
> This way you can get a truly restartable system call, because the
> arguments really need to be fundamentally changed (the restarted system
> call had better have _absolute_ time, not relative time, since we don't
> know how much time passed before it got restarted).

The way the system is now a system call "appears" to get by
value calls, but the parameters are on the stack (in the
regs structure).  This is what is restored and passed back
on a system call restart.  What I am getting at is that
nano_sleep could scribble anything it wants here and
"notice" it on the recall.  A new call would not have these
values.  So, all that needs to really happen in the arch
code is to set up the restart address (or, maybe the system
call number).  But then, if this is what we do, do we even
need a new call?

But now you are going to tell me that other archs don't pass
parameters to system calls in this way, right?
Changing the call to absolute changes the semantics (in
particular the behavior on clock setting) in a way I don't
think you want to.  I.e. you can tell it was done.  So you
would have to do this in a way that does not look like the
absolute call in the current POSIX spec.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
