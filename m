Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSHBQWk>; Fri, 2 Aug 2002 12:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316465AbSHBQWk>; Fri, 2 Aug 2002 12:22:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37892 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316446AbSHBQWj>; Fri, 2 Aug 2002 12:22:39 -0400
Date: Fri, 2 Aug 2002 09:27:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Roman Zippel <zippel@linux-m68k.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, <alan@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: manipulating sigmask from filesystems and drivers
In-Reply-To: <20020802120040.A25119@redhat.com>
Message-ID: <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Aug 2002, Benjamin LaHaise wrote:
>
> Personally, I think that uninterruptible file io is good, but there needs
> to be an upper limit to the maximum size of the io.  As it stands today,
> someone can do a single multigigabyte read or write that is completely
> uninterruptible (even to kill -9), but could take a minute or more to
> complete.

Actually, i fyou read my original email on this thread, I actually
suggested splitting up the "INTERRUPTIBLE" vs "UNINTERRUPTIBLE" into three
different cases and one extra bit.

Sending somebody a SIGKILL (or any signal that kills the process) is
different (in my opinion) from a signal that interrupts a system call in
order to run a signal handler.

So my original suggestion on this thread was to make

        TASK_WAKESIGNAL - wake on all signals
        TASK_WAKEKILL   - wake on signals that are deadly
        TASK_NOSIGNAL   - don't wake on signals
        TASK_LOADAVG    - counts toward loadaverage

        #define TASK_UNINTERRUPTIBLE    (TASK_NOSIGNAL | TASK_LOADAVG)
        #define TASK_INTERRUPTIBLE      TASK_WAKESIGNAL

and then let code like generic_file_write() etc use other combinations
than the two existing ones, ie

	(TASK_WAKEKILL | TASK_LOADAVG)

results in a process that is woken up by signals that kill it (but not
other signals), and is counted towards the loadaverage. Which is what we
want in generic_file_read() (and _probably_ generic_file_write() as well,
but that's slightly more debatable).

(We'd also have to add a new way to test whether you've been killed, so
that such users could use "process_killed()" instead of the
"signal_pending()" that a INTERRUPTIBLE sleeper uses to test whether it
should exit).

This is the trivial way to get the best of both worlds - you can still
kill a process that is in D wait (if that particular kernel path allows
it), but you don't get process-visible semantic changes.

AND it also allows waiting uninterruptibly without adding to the
loadaverage, for those people who want to do long uninterruptible waits
(which was one of the reasons for starting this whole thread in the first
place - it just got slightly de-railed in the meantime).

		Linus

