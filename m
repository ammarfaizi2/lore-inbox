Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSCKSV0>; Mon, 11 Mar 2002 13:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310375AbSCKSVM>; Mon, 11 Mar 2002 13:21:12 -0500
Received: from mail.rttinc.com ([139.142.30.71]:26120 "HELO mail.rttinc.com")
	by vger.kernel.org with SMTP id <S310364AbSCKSVK>;
	Mon, 11 Mar 2002 13:21:10 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Brad Pepers <brad@linuxcanada.com>
Organization: Linux Canada Inc.
To: linux-kernel@vger.kernel.org
Subject: Multi-threading
Date: Mon, 11 Mar 2002 11:20:55 -0700
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020311182111Z310364-889+120750@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a message posted by Jim Starkey about his experiences using threads 
on Linux and the problems debugging them.  It came down to two things:

1. Using gdb to debug multi-threaded applications was almost useless because
   of interactions between the thread model and ptrace.

2. Linux is missing an atomic use-count mechanism which returns values like
   the Microsoft InterlockedIncrement/Decrement functions do.

I'll include the text of what he wrote below but I was wondering what anyone 
here could say on the subject.  The code being worked on is the Firebird 
database with FB2 being the next release.

-------------------------------------------------------------------------------
A primary goal of FB2 is to implement fine granuality multi-threading
to take advantage of multiple processors in an SMP configuration.
I've been doing quite a bit of work in that general area on a different
project, and thought I'd share some observations on pitfalls and
challenges, particularly on Linux and similar systems.

The first problem is that gdb (and presumably any other debugger)
can't be used on a multi-threaded system under load.  The problem
is an unfortunate interaction between ptrace (the Unix debugging
mechanism) and the Linux implementation of pthreads.  The basic
ptrace mechanism works this way: a signal intended for the target
process causes the target process to stall while the signal
is delivered to the debugging process, which figures out what to
do, then restarts the target process.  The Linux threading
mechanism uses a separate OS process for each thread.  Synchronization
is performed by the pthread mutex calls.  When one thread (process)
fails to acquire a mutex, it goes to sleep.  When another thread
releases the mutex, it sends a signal to all sleeping threads
(in fact, all threads) to wake up and look around.  Unfortunately,
when the target process/threads are under control of the debugger,
there is a very complex multi-process dance involving (apparently)
multiple debugger interactions per wake up.  Kinda like the
guys who designed the threads didn't talk to the guys who designed
ptrace or one or the other didn't care.

The bottom line is when debugging a multi-threaded application 
under load on Linux, gdb consumes between 45% and 100% of the
cpu.  The practical implication is that Linux is not a viable
debugging platform.  NT, happily, doesn't exhibit the same
characteristics.

A partial but painful workaround is for the debugging image
to set up handlers for SIGSEGV and SIGILL to invoke gdb via
the system() call to attach to the process.  This catches
crashes, but makes ordinary debugging tedious indeed.

A second problem is implementing a use-count mechanism to
control object lifetimes in a multi-threaded environment.
The two alternatives are to use mutexes or other synchronization
mechanisms to protect all addRef/release calls (very, very
expensive) or to use interlocked increment/decrement mechanisms.
Unfortunately, while Microsoft provides intrinsic
InterlockedIncrement/InterlockedDecrement functions that perform
atomic multiprocessor interlocked operations that correctly
return the result of the operation.  Unfortunately, there
are no such functions available on Linux.  Atomic.h provides
interlocked increment/decrement, but they don't return values.
Interestingly enough, Google couldn't find any example of
the Intel instruction sequences required to implement the
necessary atomic operations using the GNU assembler dialect.

All this means two things.  First, there is no alternative
to inline assembler code in FB2.  Distasteful, yes, but get
used to it.  Second, fine granularity threading is alien
to Linux, so prepared to be a pioneer in a nasty environment
without a workable debugger.

Jim Starkey
----------------------------------------------------------------

-- 
Brad Pepers
brad@linuxcanada.com
