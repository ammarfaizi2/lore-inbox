Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbSLFTMF>; Fri, 6 Dec 2002 14:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265647AbSLFTMF>; Fri, 6 Dec 2002 14:12:05 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43791 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265608AbSLFTME>; Fri, 6 Dec 2002 14:12:04 -0500
Date: Fri, 6 Dec 2002 11:20:26 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212061111090.1489-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Dec 2002, Linus Torvalds wrote:
>
> I just pushed my version of the system call restart code to the BK trees.
> It's losely based on Georges code, but subtly different. Also, I didn't
> actually update any actual system calls to use it, I just did the
> infrastructure.

I did the nanosleep() implementation using the new infrastructure now, and
am pushing it out as I write this.

Ironically (considering the origin of the thread), this actually _breaks_
the kernel/compat.c nanosleep handling, since the restarting really needs
to know the type for "struct timespec", and the common "do_nanosleep()"
was just too stupid and limited to be able to do restarting sanely.

Compat people can hopefully fix it up. Either by just copying the
nanosleep function and not even trying to share code, or by making the
restart function be a function pointer argument to a new and improved
common "do_nanosleep()".

It's been tested, and the only problem I found (which is kind of
fundamental) is that if the system call gets interrupted by a signal and
restarted, and then later returns successfully, the partial restart will
have updated the "remaining time" field to whatever was remaining when the
restart was started.

That could be fixed by making the restart block contain not just the
restart pointer, but also a "no restart possible" pointer, which would be
the one called if the signal handler logic ended up returning -EINTR.

It's a trivial extension, and possibly worth it regardless (it might be
useful for other system call cases too that may want to undo some
reservation or whatever), but I would like to hear from the standards
lawyers whether POSIX/SuS actually cares or not. George?

			Linus

