Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVFCRej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVFCRej (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVFCRej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:34:39 -0400
Received: from nevyn.them.org ([66.93.172.17]:16801 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261413AbVFCRee (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:34:34 -0400
Date: Fri, 3 Jun 2005 13:34:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: John Blackwood <john.blackwood@ccur.com>
Cc: linux-kernel@vger.kernel.org, roland@redhat.com, ak@suse.de, akpm@osdl.org,
       bugsy@ccur.com
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
Message-ID: <20050603173432.GA29940@nevyn.them.org>
Mail-Followup-To: John Blackwood <john.blackwood@ccur.com>,
	linux-kernel@vger.kernel.org, roland@redhat.com, ak@suse.de,
	akpm@osdl.org, bugsy@ccur.com
References: <42A09190.8080703@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A09190.8080703@ccur.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 01:21:20PM -0400, John Blackwood wrote:
> While being able to single-step through a ptraced process's signal
> handler may be desirable sometimes, I would like to submit the notion
> that usually, a user would like simply to single-step to the next
> instruction in the main stream of execution.  That is to say, when the
> single-step operation is issued, the user would like to execute the
> signal handler, return back from the signal handler, and then stop at
> the next instruction in the normal (non-signal) stream of execution.
> Note that this described behavior is how previous linux kernels
> handled single-step operations when the user had a signal pending with
> a corresponding user signal handler.  The kernel did NOT previously step
> into the signal handler, but would instead step to the next instruction
> in the normal, main stream of execution.

No, in fact, the user will almost always want to see the signal
handler.  The GDB user experience is dramatically worse when signal
handlers execute without any sign to the user; single steps can appear
to leave you absolutely anywhere, esp. if the signal handler longjumps
or hits a breakpoint.

You can see this by using GDB on MIPS or ARM, where it does not use
PTRACE_SINGLESTEP.

If your application wants to skip the signal handler, you will have to
use a breakpoint to do so.

I don't know what previous version of the kernel you are referring to. 
This behavior is not new.

> As support for this preference, consider attempting to debug a program
> that has setup a SIGALRM signal handler, and while you are attempting
> to debug a stream of instructions by single-stepping through the code,
> you constantly instead end up in the SIGALRM signal handler, and have
> to set a breakpoint at the instruction that you actually wanted to
> single-step to, and then 'continue' out of the SIGALARM signal handler.

Yes.  That's three context switches instead of one; if you are using a
local debug agent, then this is not a big deal.  If you are using a
simplistic remote debug agent, then you need to teach the agent when to
do this automatically.

> 1. Make the default behavior that we single-step to the next instruction
>    in the main (non-signal handler) stream of execution, instead of
>    single-stepping into the user's signal handler.

An incompatible change.  No.

> 2. Add a new ptrace PTRACE_SETOPTIONS command flag,
>    PTRACE_O_TRACESSTEPSIG.  When this new flag is set by the debugger,
>    then execute the new behavior of single-stepping into the user's
>    signal handler.  (Yes, this means that debuggers such as gdb will need
>    to be taught about this new PTRACE_SETOPTIONS flag if the user wishes
>    to single-step into their signal handler.)

ptrace options are for asynchronous behaviors.  This is a synchronous
behavior; if it is worth implementing at all it should be an action,
not an option.

> 3. When the PTRACE_O_TRACESSTEPSIG flag is set and the ptraced process
>    single-steps to the first instruction in the signal handler and executes
>    a SIGTRAP debugger stop, make it easier for the debugger to determine
>    why the ptraced process stopped, by passing a new extended result code,
>    PTRACE_EVENT_SSTEPSIG.
> 
>    This extended code will be returned in the status parameter location
>    of a wait(2) style call, and the debugger can extract this additional
>    information with the following pseudo code snippet:

First of all we already have an event message facility,
PTRACE_GETEVENTMSG.  Secondly the only way we will step into a signal
handler after PTRACE_SINGLESTEP is if the PTRACE_SINGLESTEP requests
a signal.  That was your application; keep track of it in your
application.

> The reason for this behavior is due to the fact that:
> 
> - We saved off the eflags (with the TF bit set) in setup_sigcontext()
>   before we single stepped into the user's signal handler.

You didn't say what kernel you were using.  I believe this was fixed
some time ago.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
