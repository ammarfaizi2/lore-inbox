Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263320AbSIUExp>; Sat, 21 Sep 2002 00:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263324AbSIUExp>; Sat, 21 Sep 2002 00:53:45 -0400
Received: from mx2.elte.hu ([157.181.151.9]:6111 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S263320AbSIUExo>;
	Sat, 21 Sep 2002 00:53:44 -0400
Date: Sat, 21 Sep 2002 07:06:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020921040121.GA3895@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0209210702320.2441-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Bill Huey wrote:

> > doesn't the hotspot GC work something like this:
> > 
> > - stop all threads
> > - go read each thread's $pc, and find its nearest "safety point"
> > - go overwrite that safety point (YUCK SELF MODIFYING CODE!! :) with
> >   something which will stop the thread
> > - start the threads and wait for them all to get to their safety points
> > - perform gc
> > - undo the above mess
> 
> + read the entire ucontext for EAX, etc... so that it can be used for GC
> roots. It could be allocating something in an executing method block
> that hasn't hit stack or any kind of variable storage known to the GC.

PTRACE_GETREGS. Yeah, it's overhead, see my previous mails about various
levels of kernel features of how to do it potentially cheaper. Not like
the above process is particularly fast.

One more method to speed it up: to amortize the kernel entry overhead we
could introduce a new PTRACE_GETREGS_GROUP to get a full array of user
contexts from all group member threads, via a single system-call.

> > the only part of that which looks challenging with kernel threads is the
> > $pc reading part...  ptrace will certainly get it for you, but that's a
> > lot of syscall overhead.
> 
> And the entire ucontext.

PTRACE_GETREGS gets you the instruction pointer and all general purpose 
registers, eax and the rest.

	Ingo

