Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318996AbSHSTb4>; Mon, 19 Aug 2002 15:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318998AbSHSTb4>; Mon, 19 Aug 2002 15:31:56 -0400
Received: from mx1.elte.hu ([157.181.1.137]:52162 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318996AbSHSTbz>;
	Mon, 19 Aug 2002 15:31:55 -0400
Date: Mon, 19 Aug 2002 21:37:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <65670000.1029783102@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0208192100540.31428-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Dave McCracken wrote:

> In looking at the code I was wondering something.  What happens to the
> real parent of a ptraced task when it calls wait4()?  If that's its only
> child, won't it return ECHILD?

yes, this is ugly beyond belief.

eg. under bash start up some code that blocks, eg:

	# cat

the shell will not display a prompt, it wait4()s for the 'cat' process to 
exit.

strace the bash PID - it shows the wait4().

strace 'cat' PID (via strace -p) and keep the strace running - it will
show 'cat' blocked on console input. [some signal like this could happen
to a shell anyway, in a reasonably complex script.]

now do something that breaks bash out of its wait4 - eg. send a 'kill
-SIGCONT BASH_PID' signal - bash returns with a prompt! The 'cat' becomes
a 'background' task - and it gets majorly confused when doing the next
shell command in bash - it displays "cat: -: Input/output error" and goes
zombie.

ptrace is clearly broken - and i tested this with a stock 2.4 kernel.

	Ingo

