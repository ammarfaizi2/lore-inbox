Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319018AbSHSUyH>; Mon, 19 Aug 2002 16:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319020AbSHSUyH>; Mon, 19 Aug 2002 16:54:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:8382 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S319018AbSHSUyG>;
	Mon, 19 Aug 2002 16:54:06 -0400
Date: Mon, 19 Aug 2002 22:59:17 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
In-Reply-To: <65670000.1029783102@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0208192251540.2201-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Aug 2002, Dave McCracken wrote:

> In looking at the code I was wondering something.  What happens to the
> real parent of a ptraced task when it calls wait4()?  If that's its only
> child, won't it return ECHILD?

hm, so this could be fixed by iterating over the ptraced tasks as well
when doing a wait4.

the problem is that the debugger wants to do a wait4 as well, to receive
the SIGSTOP result. Now if the original parent 'steals' the wait4 result,
what will happen?

this whole mess can only be fixed by decoupling the ptrace() mechanism
from signals and wait4 completely, it's a nasty relationship that infests
both the kernel and userspace code [check out strace.c once to see the
kind of pain it has to go through to isolate ptrace events from other
signals.]

I'm not quite sure whether this is possible, how deeply do ptrace
applications depend on a real SIGSTOP signal interrupting the task? Would
it be equally good if it was a different interruption/signalling method
that did this? [with a few minor and straightforward cleanups to entry.S i
think we could use a task ornament flag for ptrace interruption. This
would result in a few orders better behavior on all fronts.]

	Ingo

