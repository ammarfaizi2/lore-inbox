Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbSLFRug>; Fri, 6 Dec 2002 12:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSLFRtS>; Fri, 6 Dec 2002 12:49:18 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54793 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264945AbSLFRtH>; Fri, 6 Dec 2002 12:49:07 -0500
Date: Fri, 6 Dec 2002 09:57:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DF06B15.1F6ECD5D@mvista.com>
Message-ID: <Pine.LNX.4.44.0212060944030.23118-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just pushed my version of the system call restart code to the BK trees.
It's losely based on Georges code, but subtly different. Also, I didn't
actually update any actual system calls to use it, I just did the
infrastructure.

Non-x86 architectures need to be updated to work with this: they need to
update their thread structures, the additional do_signal() support in
their signal.c, and add the actual system call itself somewhere. For x86,
this was about 15 lines of changes.

The basic premise is very simple: if you want to restart a system call,
you can do

	restart = &current_thread()->restart_block;
	restart->fn = my_continuation_function;
	restart->arg0 = my_arg0_for_continuation;
	restart->arg1 = my_arg1_for_continuation;
	..
	return -ERESTARTSYS_RESTARTBLOCK;

which will cause the system call to either return -EINTR (if a signal
handler was actually invoced) or for "benign" signals (SIGSTOP etc) it
will end up restarting the system call at the continuation function (with
the "restart" block as the argument).

We could extend this to allow restarting even over signal handlers, but
that would have some re-entrancy issues (ie what happens if a signal
handler itself wants to use a system call that may want restarting), so at
least for now restarting is only done when no handler is invoced (*).

			Linus

(*) The nesting case is by no means impossible to handle gracefully
(adding a "restart even if handler is called" error number and returning
-EINTR if nesting, for example), but I don't know of any system calls that
would really want to try to restart anyway, so..

