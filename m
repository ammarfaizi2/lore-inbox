Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132900AbRDXJIK>; Tue, 24 Apr 2001 05:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132909AbRDXJIB>; Tue, 24 Apr 2001 05:08:01 -0400
Received: from [202.54.26.202] ([202.54.26.202]:56503 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S132900AbRDXJHs>;
	Tue, 24 Apr 2001 05:07:48 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A38.00308A04.00@sandesh.hss.hns.com>
Date: Tue, 24 Apr 2001 14:26:13 +0530
Subject: Re: BUG: Global FPU corruption in 2.2
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Hi,
     I want to look into this problem. Its seems to be very interesting. But I
was not following the thread from the beginning (and I mistakely deleted all
these mails :( .. ).. I hope you won't mind answering following questions...

1) you are doing this on an MP or a uniprocessor ?
2) I want to know how are you calling sys_ptrace(Attach) and
sys_ptrace(detach).. i.e is it something linke following

      for(;;){
     sys_ptrace(attach to process);
     sys_wait4();
     sys_ptrace(detach from process);
      }

In short the sequence of system calls you are using for attaching and detaching
to the process

3) Have you tried doing attach and detach only once ? If not.. can you please
try this and let me know whether by doing attach and detach one time also
results in global FPU corruption. Please do not fork in the above process.

---------

Whenever process A calls sys_ptrace(Attach) to Process B, sys_ptrace sends
SIGSTOP to process B.
Now process B in do_signal, checks that it is being traced and then it does the
following
     current->state = TASK_STOPPED;
     notify_parent(current,SIGCHLD);
     schedule();

so now in schedule() --> __switch_to --> unlazy_fpu() function we do following
     if (current->flags & PF_USEDFPU)
          save_fpu();

In save_fpu() we do following
     fnsave current->tss.i387
     fwait;

I want to ask a question....... is it possible if 'somehow' we were not able to
save the complete floating point state with fnsave i.e. current->tss.i387 is
'invalid' after
          fnsave current->tss.i387
     fwait;

Thanks
Amol




David Konerding <dek_ml@konerding.com> on 04/23/2001 01:09:27 AM

To:   Ulrich Drepper <drepper@cygnus.com>
cc:   root@chaos.analogic.com, linux-kernel@vger.kernel.org (bcc: Amol Lad/HSS)

Subject:  Re: BUG: Global FPU corruption in 2.2




Ulrich Drepper wrote:

> "Richard B. Johnson" <root@chaos.analogic.com> writes:
>
> > The kernel doesn't know if a process is going to use the FPU when
> > a new process is created. Only the user's code, i.e., the 'C' runtime
> > library knows.
>
> Maybe you should try to understand the kernel code and the features of
> the processor first.  The kernel can detect when the FPU is used for
> the first time.

OK, regardless of how the linux kernel actually manages the FPU for user-space

programs, does anybody have any comments on the original bugreport?

>We have found that one of our programs can cause system-wide
>corruption of the x86 FPU under 2.2.16 and 2.2.17.  That is, after we
>run this program, the FPU gives bad results to all subsequent
>processes.

>We see this problem on dual 550MHz Xeons with 1GB RAM.  We have 64 of
>these things, and we see the problem on every node we try (dozens).
>We don't have other SMPs handy.  Uniprocessors, including other PIIIs,
>don't seem to be affected.

>Below are two programs we use to produce the behavior.  The first
>program, pi, repeatedly spawns 10 parallel computations of pi.  When
>all is well, each process prints pi as it completes.

>The second program, pt, repeatedly attaches to and detaches from
>another process.  Run pt against the root pi process until the output
>of pi begins to look wrong.  Then kill everything and run pi by itself
>again.  It will no longer produce good results.  We find that the FPU
>persistently gives bad results until we reboot.

I tried this on my dual PIII-600 runnng 2.2.19 and got exactly the behavior
described.
If it is a bug in the linux kernel (I can see nothing wrong with the source
code provided),
I would suspect probems with SMP and ptrace, somehow causing the wrong FP
registers
to be returned to a process after the scheduler restarted it.  It's very
interesting that the
PI program works fine until you run PT, but after you run PT, PI is screwed
until reboot.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/






