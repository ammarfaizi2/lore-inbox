Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264235AbTCXOyy>; Mon, 24 Mar 2003 09:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264236AbTCXOyy>; Mon, 24 Mar 2003 09:54:54 -0500
Received: from crack.them.org ([65.125.64.184]:11501 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S264235AbTCXOyu>;
	Mon, 24 Mar 2003 09:54:50 -0500
Date: Mon, 24 Mar 2003 10:05:53 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: raj <raj@cs.wisc.edu>
Cc: linux-kernel@vger.kernel.org, zandy@cs.wisc.edu
Subject: Re: [PATCH] ptrace on stopped processes (2.4)
Message-ID: <20030324150552.GA26287@nevyn.them.org>
Mail-Followup-To: raj <raj@cs.wisc.edu>, linux-kernel@vger.kernel.org,
	zandy@cs.wisc.edu
References: <1047936295.3e763d273307c@www-auth.cs.wisc.edu> <20030324040908.GA19754@nevyn.them.org> <3E7EA4B2.5010306@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7EA4B2.5010306@cs.wisc.edu>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 10:24:50PM -0800, raj wrote:
> Daniel Jacobowitz wrote:
> 
> >On Mon, Mar 17, 2003 at 03:24:55PM -0600, Rajesh Rajamani wrote:
> > 
> >
> >>Hi All,
> >>I'm working on adding a function 
> >>
> >>void debugbreak(void);
> >>
> >>to glibc.  I got the inspiration for this from Windows.  Windows has a
> >>DebugBreak() function, which when invoked from  a process, spawns a
> >>debugger, which then attaches to the process.  I think this would be
> >>invaluable to linux developers in situations where they currently have to
> >>put an infinite loop and attach to a running process (say, to stop in a
> >>library that has been LD_PRELOADed).
> >>
> >>To this end, I've been experimenting and found out that gdb can't attach
> >>to a process that has been stopped.  I'd like to send a SIGSTOP as soon as
> >>debugbreak() is invoked, so that all threads are stopped in a state close
> >>to the one they were in, when the debugbreak() was invoked. 
> >>
> >>I spoke to Vic Zandy about this and he informed me that he had submitted 
> >>a patch
> >>that would allow ptrace to attach to stopped processes also (the thread of
> >>discussion is pasted below).  I believe the patch was not accepted at 
> >>that time.
> >>  I was wondering what the official line on this is?  If there are no 
> >>  serious
> >>objections, will the community consider accepting the patch?  It would go 
> >>a long
> >>way in helping me accomplish my goal.
> >>   
> >>
> >
> >The question is, what _should_ happen when yu attach to a stopped
> >process?  If the tracer receives the same one SIGSTOP that it normally
> >would, then it will just resume the program as if it weren't stopped. 
> >Does that make sense or not?
> >
> Ideally, a stopped process should not be resumed, until it receives a 
> SIGCONT.  I ran two tests to understand the effect of this patch.
> 
> 1. Attaching to a stopped process using gdb.  This did not cause the 
> tracee to continue.

No, that's not what I meant.  When you attach using GDB, there is no
way for GDB to determine if the process was previously stopped or
running.

> 2. stracing a stopped process.  This caused the stopped process to 
> continue.  On further investigation, I found out that strace calls 
> ptrace(PTRACE_SYSCALL), which restarts the child, but arranges for the 
> child to be stopped at the next entry to or exit from a system call.
> 
> IMHO, the new ptrace semantics adds a feature to strace. If someone 
> tries to run strace a stopped process without the patch, it will just 
> hang, whereas with the patch, it'll let the process continue. Even 
> without the patch, if a process that sends itself a SIGCONT is straced, 
> the process will not stop. I do not think this is an issue, considering 
> that ppl will not get any info by running strace on a stopped process, 
> until they send a SIGCONT.
> 
> In conclusion, the action taken by the tracer depends on the mechanism 
> it uses for monitoring the system calls.  That said, it'll definitely be 
> useful if the tracer could find out the state of the tracee at the time 
> of attachment and take appropriate action.  Given below, is a port of 
> Vic's patch to 2.5.xx series -
> --------------------------------------------------------------------------------
> -- kernel/ptrace.c     2003-03-23 22:15:33.000000000 -0800
> +++ kernel/ptrace.c 2003-03-23 22:19:27.000000000 -0800
> @@ -115,7 +115,10 @@
>        __ptrace_link(task, current);
>        write_unlock_irq(&tasklist_lock);
> 
> -       force_sig_specific(SIGSTOP, task);
> +       if (task->state != TASK_STOPPED)
> +               force_sig_specific(SIGSTOP, task);
> +       else
> +               task->exit_code = SIGSTOP;
>        return 0;
> 
> bad:

I'll test this here, give me a day or two.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
