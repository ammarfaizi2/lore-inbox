Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbSLECUh>; Wed, 4 Dec 2002 21:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSLECUh>; Wed, 4 Dec 2002 21:20:37 -0500
Received: from mail.ccur.com ([208.248.32.212]:54790 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id <S267178AbSLECUf>;
	Wed, 4 Dec 2002 21:20:35 -0500
Message-ID: <3DEEB9AB.2A36454E@ccur.com>
Date: Wed, 04 Dec 2002 21:27:55 -0500
From: Jim Houston <jim.houston@ccur.com>
Reply-To: jim.houston@ccur.com
Organization: Concurrent Computer Corp.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: george anzinger <george@mvista.com>,
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
> 
>                 Linus

Hi Linus,

The general solution you propose sounds nice but I have a feeling
the implementation would get ugly.  It is hard enough to back up the 
pc. I hate to think where the arguments are on some machines.

I think that "siglongjump()" is not a problem.  My change to
do_signal() only sets the flag indicating a restart at the same time
it backs up the pc to restart the system call.  I don't see a path
where the user code gets control before we're back at clock_nanosleep.

I'm saving the information to restart the nanosleep in the task_struct.
I have a pre-allocated timer which I leave running.  When I get
into nanosleep for the restart, I just have to check if the timer has
already expired and, if not, go back to sleep.  To calculate the 
remaining time I also save an un-rounded copy of the absolute expiry
time (also in the task_struct).

Jim Houston - Concurrent Computer Corp.
