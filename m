Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265872AbSLIRY7>; Mon, 9 Dec 2002 12:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265890AbSLIRY7>; Mon, 9 Dec 2002 12:24:59 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:19211 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265872AbSLIRY5>; Mon, 9 Dec 2002 12:24:57 -0500
Date: Mon, 9 Dec 2002 09:33:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
cc: Daniel Jacobowitz <dan@debian.org>, george anzinger <george@mvista.com>,
       Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <OFC1954F5C.20E78677-ONC1256C8A.005E887F@de.ibm.com>
Message-ID: <Pine.LNX.4.44.0212090927430.3397-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Dec 2002, Martin Schwidefsky wrote:
>
> For s390/s390x this is actually quite tricky. The system call number is
> coded in the instruction, e.g. 0x0aa2 is svc 162 or sys_nanosleep. There
> is no register involved that contains the system call number I could
> simply change. I either have to change the instruction (no way) or I
> have to avoid going back to userspace in this case. This would require
> assembler magic in entry.S. Not nice.

Well, that is tricky independently of the actual argument stuff - even the
_current_ system call restart ends up being tricky for you in that case, I
suspect. The current one already basically depends on rewriting the system
call number, it just leaves the arguments untouched.

One thing you could do (which is pretty much architecture-independent) is
to have a "restart" flag in the thread info structure. The system call
entry code-path already has to check the thread info structure for things
like the "ptrace" flags, so it shouldn't add much overhead to the system
call entrypoint.

You would need to add a "do _not_ restart" macro to the system call
restart infrastructure, which would clear the restart bit when a restarted
system call returns (it also would get cleared when ERESTART_RESTARTBLOCK
ends up being changed into an EINTR, of course, but that's already
architecture-dependent code so you can do anything there).

			Linus

