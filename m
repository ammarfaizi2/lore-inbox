Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275870AbSIUDdP>; Fri, 20 Sep 2002 23:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275871AbSIUDdO>; Fri, 20 Sep 2002 23:33:14 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:47340 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S275870AbSIUDdO>; Fri, 20 Sep 2002 23:33:14 -0400
Date: Fri, 20 Sep 2002 20:38:20 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Bill Huey <billh@gnuppy.monkey.org>
cc: Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920231133.GA2599@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0209202033360.22066-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002, Bill Huey wrote:

> On Fri, Sep 20, 2002 at 03:30:19PM -0700, dean gaudet wrote:
> > > It's better to have an explict pthread_suspend_[thread,all]() function
> >
> > could this be implemented by having a gc thread in a unique process group
> > and then suspending the jvm process group?
>
> Suspending how ? via signal ?

yeah SIGSTOP to the jvm process group.

> Possibly, but having an explicit syscall() call is important since interrupts
> are also suspended under that condition, pthread_cond_timedwait(), etc...
> It really needs to be suspended in a way that's different than the SIGSOMETHING
> mechanism. I was fixing bugs in libc_r, so I know the issues to a certain degree
> and bad logic those particular corner cases was screwing me up.

SIGSTOP is different from other signals because it will stop the whole
process group from continuing.  i am completely aware of how much of a
pain it is to actually trap signals and do something (for apache 2.0's
design i outlawed the use of signals because of the pains of getting
things working in 1.3.x :).

doesn't the hotspot GC work something like this:

- stop all threads
- go read each thread's $pc, and find its nearest "safety point"
- go overwrite that safety point (YUCK SELF MODIFYING CODE!! :) with
  something which will stop the thread
- start the threads and wait for them all to get to their safety points
- perform gc
- undo the above mess

the only part of that which looks challenging with kernel threads is the
$pc reading part...  ptrace will certainly get it for you, but that's a
lot of syscall overhead.

or am i missing something?

-dean

