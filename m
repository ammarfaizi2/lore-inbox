Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319102AbSHMTou>; Tue, 13 Aug 2002 15:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319116AbSHMTou>; Tue, 13 Aug 2002 15:44:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1797 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319102AbSHMTot>; Tue, 13 Aug 2002 15:44:49 -0400
Date: Tue, 13 Aug 2002 12:50:50 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208132119520.8104-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208131244150.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Ingo Molnar wrote:
> 
> one solution would be a new syscall to set 'VM exit notification' address
> and value in the released VM. But since it would always come in pair with
> sys_exit() or sys_execve()

Why do you say that?

In fact, by looking at the current implementation of mm_release(), you 
should realize that this is wrong.

We already have an interface where the parent wants to know about the 
child doing a mm_release() - it's called vfork(). And the mm_release() 
intention notification is done at _vfork_ time, not at exit or execve() 
time.

This is my whole argument. It makes sense to say at clone time that "I 
want to be notified when my thread exits" or "I want to be notified when 
my thread no longer uses my address space". That makes 100% sense, and is 
in fact something we're already doing with the signal mask, and with the 
existing CLONE_VFORK case.

In contrast, it does _not_ make sense to say "I'm the child, and I'm now 
exiting, so I want to notify my parent", because the child does not always 
even _know_ when it is exiting.

For example, if you want to use the existing execvp() etc libc helper
routines, the final execve() is not going to be a magic system call. So 
you cannot have a special execve_release() system call, because that makes 
no sense within the libc.

I repeat: it is the _parent_ that knows whether it wants to be notified at 
exit. Not the child.

Ergo, the "notify me on exit" should be a parent decision, and it might be 
as simple as writing zero to the (same) "pid_t *" that it passed for the 
pid information thing for startup.

		Linus

