Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbSLEAKz>; Wed, 4 Dec 2002 19:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267160AbSLEAKy>; Wed, 4 Dec 2002 19:10:54 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:59409 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267137AbSLEAKx>; Wed, 4 Dec 2002 19:10:53 -0500
Date: Wed, 4 Dec 2002 16:18:39 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jim Houston <jim.houston@ccur.com>
cc: george anzinger <george@mvista.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DEE92EF.350F4F9F@ccur.com>
Message-ID: <Pine.LNX.4.44.0212041600070.3100-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, Jim Houston wrote:
> 
> Agreed!  In my alternative version of the Posix timers patch, I avoid
> calling do_signal() from clock_nanosleep by using a variant of the 
> existing ERESTARTNOHAND mechanism.  The problem I ran into was that I
> could not tell on entry to clock_nanosleep if it was a new call or
> an old one being restarted.

Restarting has other problems too, namely how to save off the partial 
results.

>				  I solved this by adding a new 
> ERESTARTNANOSLP error code and making a small change in do_signal().
> The handling of ERESTARTNANOSLP is the same as ERESTARTNOHAND but also
> sets a new flag in the task_struct before restarting the system call.

The problem I see with this is that the signal handler can do a 
"siglongjump()" out of the regular path, and the next system call may well 
be a _new_ nanosleep() that has nothing to do with the old one. And 
realizing that it's _not_ a restarted one is interesting.

A better and more flexible approach would be to not restart the same
system call with the same parameters, but having some way of telling
do_signal to restart with new parameters and a new system call number.

For example, it shouldn't be impossible to have an interface more akin to

	...
	thread_info->restart_block.syscall = __NR_nanosleep_restart;
	thread_info->restart_block.arg0 = timeout + jiffies; /* absolute time */
	return -ERESTARTSYS_RESTARTBLOCK;

where the signal stack stuff re-writes not just eip (like the current 
restart logic does), but also rewrites the system call number and the 
argument registers.

This way you can get a truly restartable system call, because the
arguments really need to be fundamentally changed (the restarted system
call had better have _absolute_ time, not relative time, since we don't
know how much time passed before it got restarted).

		Linus

