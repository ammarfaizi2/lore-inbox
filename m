Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbSLFUNA>; Fri, 6 Dec 2002 15:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265725AbSLFUNA>; Fri, 6 Dec 2002 15:13:00 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:43762 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265708AbSLFUM7>;
	Fri, 6 Dec 2002 15:12:59 -0500
Message-ID: <3DF10610.A73AED68@mvista.com>
Date: Fri, 06 Dec 2002 12:18:24 -0800
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
References: <Pine.LNX.4.44.0212061111090.1489-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 6 Dec 2002, Linus Torvalds wrote:
> >
> > I just pushed my version of the system call restart code to the BK trees.
> > It's losely based on Georges code, but subtly different. Also, I didn't
> > actually update any actual system calls to use it, I just did the
> > infrastructure.
> 
> I did the nanosleep() implementation using the new infrastructure now, and
> am pushing it out as I write this.
> 
> Ironically (considering the origin of the thread), this actually _breaks_
> the kernel/compat.c nanosleep handling, since the restarting really needs
> to know the type for "struct timespec", and the common "do_nanosleep()"
> was just too stupid and limited to be able to do restarting sanely.
> 
> Compat people can hopefully fix it up. Either by just copying the
> nanosleep function and not even trying to share code, or by making the
> restart function be a function pointer argument to a new and improved
> common "do_nanosleep()".
> 
> It's been tested, and the only problem I found (which is kind of
> fundamental) is that if the system call gets interrupted by a signal and
> restarted, and then later returns successfully, the partial restart will
> have updated the "remaining time" field to whatever was remaining when the
> restart was started.
> 
> That could be fixed by making the restart block contain not just the
> restart pointer, but also a "no restart possible" pointer, which would be
> the one called if the signal handler logic ended up returning -EINTR.
> 
> It's a trivial extension, and possibly worth it regardless (it might be
> useful for other system call cases too that may want to undo some
> reservation or whatever), but I would like to hear from the standards
> lawyers whether POSIX/SuS actually cares or not. George?

My reading of the standard indicates that the return values
have meaning ONLY if EINTR is returned.  I changed the POSIX
Clocks & timers patch to do it this way, and, yes it is
observable from user space.  My test code tried to pass a
bad return address to flush out an error which failed
because the address was not used so I just changed the
test.  My reading of the prior nanosleep seemed to say the
same thing, i.e. the address  was not dereferenced on
success.

I have not looked at your code yet, but I am concerned that
the restart may not be able to get to the original
parameters. For nanosleep this is not a problem, but for
clock_nanosleep there are 4 parameters, at least two of
which are needed for restart (the Clock and the return
address).  (See the POSIX timers patch for example.)

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
