Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280911AbRKLSkM>; Mon, 12 Nov 2001 13:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280916AbRKLSkC>; Mon, 12 Nov 2001 13:40:02 -0500
Received: from chaos.analogic.com ([204.178.40.224]:44418 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S280911AbRKLSjt>; Mon, 12 Nov 2001 13:39:49 -0500
Date: Mon, 12 Nov 2001 13:39:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Sebastian Heidl <heidl@zib.de>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: doing a callback from the kernel to userspace
In-Reply-To: <20011112180505.A5446@csr-pc1.zib.de>
Message-ID: <Pine.LNX.3.95.1011112133630.7750A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Nov 2001, Sebastian Heidl wrote:

> 
> 
> Hi,
> 
> I read some of the signaling code and must admit that I could not extract the
> necessary information from it. Ideally I'd like to call a user-supplied function
> having just a pointer to this function and say the task_struct of the owning
> process.
> What steps are needed to savely do the callback ?  (How) can I retrieve the
> necessary information from the task_struct ?
> 
> any pointers are welcome
> _sh_
> 
> PS: Yes, I really do need this as signals form the kernel to userspace add to
>     much latency (10 to 20 usecs) and I want to avoid waiting in a system call.


First, Linux is a Unix variant. There is no such thing as a
"call-back" from kernel space because the "kernel" is not a
process. The kernel executes functions on behalf of the process
that is "current". The only event possible, that could result
in a so-called call-back is an interrupt. Interrupt 'thunks' are
not safely possible in any operating system, including those that
purport to support them, regardless of the kiddie code in Dr. Dobbs.

The normal way to execute user-mode code as a result of an
event is to use select() or poll(). In this case, the user-mode
code that wants to do something as a result of an event, gets
awakened as a result of that event. The wakeup does not take
milliseconds are you describe, only a few microseconds. Of
course if you have a task doing for(;;) ;, using all CPU just
spinning, you are not going to get the CPU until the rogue task's
time-slice is up.

Note that from user-space, you don't have to use main-line code
to sleep in poll() waiting for an event, you can have multiple
tasks, going about their business. One of these tasks can be
waiting for the kernel event and, if necessary, communicate with
your other tasks using shared memory, semaphores, pipes, signals,
and a handful of other mechanisms.

If you insist, it is possible for kernel-mode code to write
directly to user-mode memory. This memory must be locked down
so it isn't paged out. However, the kernel can't execute
user-mode code because the kernel doesn't exist as a separate
process, therefore it can't get "back", there is no place for
such a procedure call to return to.

There is the capability, in 2.x.xx kernels for a kernel-thread.
This is a process that exists in kernel space. Since this is
a process, which has a context, it can do everything that user-mode
code can do, in addition to directly accessing kernel structures.

You might wish to grep through some network drivers for "kernel_thread"
to see how it's done.

Please check the 'standard' ways of making drivers before you hack
together something as Linux-specific as a kernel thread. I have
drivers that are interrupted 10,000 times per second, transfer
data from hardware buffers in 20,240 byte chunks at an overall
transfer rate of 24 megabytes per second. The task(s) waiting
for these data sleep in poll(), then call read() when data
starts to arrive. This is the De-facto standard way for Unix
systems. I don't have "latency" problems.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


