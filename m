Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261647AbSIXL5y>; Tue, 24 Sep 2002 07:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbSIXL5y>; Tue, 24 Sep 2002 07:57:54 -0400
Received: from pr-66-150-46-254.wgate.com ([66.150.46.254]:27232 "EHLO
	mail.tvol.net") by vger.kernel.org with ESMTP id <S261647AbSIXL5x>;
	Tue, 24 Sep 2002 07:57:53 -0400
Message-ID: <3D90547A.8070203@wgate.com>
Date: Tue, 24 Sep 2002 08:03:06 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.1b) Gecko/20020813
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
CC: Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
References: <E2E1F730-CE5C-11D6-8873-00039387C942@mac.com> <20020923210346.GA2075@gnuppy.monkey.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Huey (Hui) wrote:
> On Sun, Sep 22, 2002 at 08:55:39PM +0200, Peter Waechtler wrote:
> 
>>AIX and Irix deploy M:N - I guess for a good reason: it's more
>>flexible and combine both approaches with easy runtime tuning if
>>the app happens to run on SMP (the uncommon case).
> 
> Also, for process scoped scheduling in a way so that system wide threads
> don't have an impact on a process slice. Folks have piped up about that
> being important.

This is the one major complaint I have with "a thread is a process"
implementation in Linux.  The scheduler does not take process vs thread
into account.

A simple example:  Two users (or two different programs - same user)
are running.  Both could use all of the CPU resources (for whatever
reason).

One of the programs (A) has N threads (where N >> 1) and the other
program (B) has only 1 thread.  Of the N threads in (A), M of them
are not blocked (where M > 1) then (A) will get M:1 CPU usage advantage
over (B).

This means that two processes/programs that should be scheduled equally
are not and the one with many threads "effectively" is stealing cycles
from the other.

In a multi-user (server with multiple processes) environment, this
means that you just write with lots of threads to get more of the
bandwidth out of the scheduled processes.

A real-world (albeit not great) example from many years ago:

A program that does ray-tracing can very easily split the process up
into very small bits.  This is great on multi-processor systems as you
can get each CPU to do part of the work in parallel.  There is almost
no I/O involved in such a system other than initial load and final save.

It turned out that on non-dedicated systems (multi-user systems) that
you could actually get your work done faster by having the program
create many (100, in this case) threads even though there was only
one big CPU.  The reason was that that OS also did not (yet) understand
process scheduling fairness and the student who did this effectively
made a way around the fair scheduling of system resources.

The problem was very quickly noticed as other students quickly learned
how to make use of such "solutions" to their performance wants.  We
relatively quickly had to add process level accounting of thread CPU
usage such that any thread in a process counted to that process's
CPU usage/timeslice/etc.  It basically made the scheduler into a
2-stage device - much like user threads but with the kernel doing
the work and all of the benefits of kernel threads.  (And did not
require any code recompile other than those people who were doing
the many-threads CPU hog type of thing ended up having to revert as
it was now slower than the single thread-per-CPU code...)

Now, computer hardware has changed a lot.  Back then, branch took
longer than current kernel syscall overhead.  Memory was faster
than the CPU.  The scheduler was complex, so I could not say that
it was as efficient as the Linux kernel.  However, we did have real
threads and did quickly get real process accounting after someone
"pointed out" the problem of not doing so :-)

-- 
Michael Sinz -- Director, Systems Engineering -- Worldgate Communications
A master's secrets are only as good as
	the master's ability to explain them to others.


