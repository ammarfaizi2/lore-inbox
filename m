Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932710AbWCPUCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWCPUCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 15:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932722AbWCPUCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 15:02:05 -0500
Received: from nevyn.them.org ([66.93.172.17]:22468 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932721AbWCPUCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 15:02:03 -0500
Date: Thu, 16 Mar 2006 15:02:01 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Kerrisk <mtk-manpages@gmx.net>
Subject: Re: [RFC] Proposed manpage additions for ptrace(2)
Message-ID: <20060316200201.GA20315@nevyn.them.org>
Mail-Followup-To: Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Michael Kerrisk <mtk-manpages@gmx.net>
References: <200603150415_MC3-1-BAB1-D3CE@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200603150415_MC3-1-BAB1-D3CE@compuserve.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks for doing this.

One nice addition might be when they became available; it varies,
but most of these were mid-2.5.  PTRACE_O_TRACESYSGOOD is older,
but it hasn't always worked on all architectures (and I'm not sure if
it does now).

On Wed, Mar 15, 2006 at 04:12:10AM -0500, Chuck Ebbert wrote:
> The following is what I propose to add the the manpages entry for
> ptrace(2).  Some of it came from experimentation, some from linux-kernel
> messages and the rest came from reading the source code.
> 
> 
>        PTRACE_GETSIGINFO
>               Retrieve  information  about  the  signal  that caused the stop.
>               Copies a siginfo_t from the child to location data in  the  par-
>               ent.
> 
>        PTRACE_SETSIGINFO
>               Set signal information.  Copies a siginfo_t from  location  data
>               in the parent to the child.

Right.  These are usable any time we're stopped in ptrace_stop, and
nowadays I think that ought to be any time we're stopped.  However,
when we come from ptrace_notify, you'll notice that the resulting
siginfo is discarded!  It's only used in the get_signal_to_deliver
case.

I don't know offhand if there's a robust way to tell which of those
two cases we're in.

>               PTRACE_O_TRACEFORK
>                      Stop the child at the next fork()  call  with  SIGTRAP  |
>                      PTRACE_EVENT_FORK  <<  8  and automatically start tracing
>                      the  newly  forked  process,  which  will  start  with  a
>                      SIGSTOP.   The  pid  for the new process can be retrieved
>                      with PTRACE_GETEVENTMSG.
> 
>               PTRACE_O_TRACEVFORK
>                      Stop the child at the next vfork() call  with  SIGTRAP  |
>                      PTRACE_EVENT_VFORK  <<  8 and automatically start tracing
>                      the the newly vforked process, which will  start  with  a
>                      SIGSTOP.   The  pid  for the new process can be retrieved
>                      with PTRACE_GETEVENTMSG.
> 
>               PTRACE_O_TRACECLONE
>                      Stop the child at the next clone() call  with  SIGTRAP  |
>                      PTRACE_EVENT_CLONE  <<  8 and automatically start tracing
>                      the  newly  cloned  process,  which  will  start  with  a
>                      SIGSTOP.   The  pid  for the new process can be retrieved
>                      with PTRACE_GETEVENTMSG.

Specifically, the three kinds of cloning are distinguished as:

if CLONE_VFORK -> PTRACE_EVENT_VFORK
else if clone exit signal == SIGCHLD -> PTRACE_EVENT_FORK
else PTRACE_EVENT_CLONE

You need to do some juggling to get the actual clone flags.

>               PTRACE_O_TRACEEXEC
>                      Stop the child at the next exec()  call  with  SIGTRAP  |
>                      PTRACE_EVENT_EXEC << 8.
> 
>               PTRACE_O_TRACEVFORKDONE
>                      Stop the child at the completion of the next vfork() call
>                      with SIGTRAP | PTRACE_EVENT_VFORK_DONE << 8.

Right.  BTW, I believe there are still some potential deadlocks between
the vfork event and the vfork done event; I used to regularly generate
unkillable processes working on this code.

>               PTRACE_O_TRACEEXIT
>                      Stop the child at exit with SIGTRAP  |  PTRACE_EVENT_EXIT
>                      <<  8.   The  child’s  exit  status can be retrieved with
>                      PTRACE_GETEVENTMSG.  This stop will be done early  during
>                      process  exit  whereas  the  normal  notification is done
>                      after the process is done exiting.

Right.  This is useful because the process's registers are still
available - we can actually check where we were before exiting! 
However, there's no way to prevent the exit at this point.

>        PTRACE_GETEVENTMSG
>               Retrieve a message (as an unsigned long) about the ptrace  event
>               that  just  happened  to  the  location data in the parent.  For
>               PTRACE_EVENT_EXIT  this  is  the   child’s   exit   code.    For
>               PTRACE_EVENT_FORK,   PTRACE_EVENT_VFORK  and  PTRACE_EVENT_CLONE
>               this is the pid of the new process.

Right.

>        PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP
>               For  PTRACE_SYSEMU,  continue  and  stop  on  entry  to the next
>               syscall, which will not  be  executed.   For  PTRACE_SYSEMU_SIN-
>               GLESTEP, so the same but also singlestep if not a syscall.

I think this is right; I had nothing to do with these :-)


-- 
Daniel Jacobowitz
CodeSourcery
