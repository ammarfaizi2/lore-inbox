Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932572AbWG1Dry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbWG1Dry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbWG1Dry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:47:54 -0400
Received: from nevyn.them.org ([66.93.172.17]:47768 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1751403AbWG1Drx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:47:53 -0400
Date: Thu, 27 Jul 2006 23:47:41 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: ptrace bugs and related problems
Message-ID: <20060728034741.GA3372@nevyn.them.org>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>, torvalds@osdl.org,
	alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
	arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	roland@redhat.com
References: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com> <20060727203128.GA26390@nevyn.them.org> <787b0d920607271817u4978d2bdiac261d916971c1b3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607271817u4978d2bdiac261d916971c1b3@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 09:17:48PM -0400, Albert Cahalan wrote:
> Minor correction: the message is sent with bad data.
> Here at home I happen to have 2.6.17-rc5, so
> looking in the kernel/fork.c file there:
> 
> The fork_traceflag function looks only at the flags
> used to follow processes, including PT_TRACE_VFORK.
> 
> In do_fork, the result of fork_traceflag is assigned
> to the "trace" variable. Note that PT_TRACE_VFORK_DONE
> does not cause "trace" to be non-zero.
> 
> Then we hit this code:
> 
>                if (unlikely (trace)) {
>                        current->ptrace_message = nr;
>                        ptrace_notify ((trace << 8) | SIGTRAP);
>                }
> 
> That doesn't run. The ptrace_message is thus not set when
> ptrace_notify is called to send the PTRACE_EVENT_VFORK_DONE
> message. You get random stale data from a previous message.

Why do you want the message data anyway?

FORK/VFORK/CLONE events have a message: it says what the new process's
PID is.  VFORK_DONE doesn't have a message, because it only indicates
that the current process is about to resume; it's an event that only
has one process associated with it.

I really don't think this is a bug.

> The forced exits show up, oddly. I see one for each task,
> except for the task which called execve(). The task calling
> execve() will silently go away. The leader task, despite
> being reported as dead, returns from execve. Ouch. It would
> be much more friendly to have the task calling execve()
> send a (new) PTRACE_EVENT_TID_CHANGE message with the new ID
> as the ptrace_message. If this is the very last message sent
> by the task doing execve and is made to arrive in proper order,
> the debugger can renumber the structures it uses to track tasks.

Or just present things as if the leader task did the execve, which is
effectively what happens, and what I thought would happen for ptrace
too.

> Note that the new unshare() system call will need to send
> ptrace events for all tasks affected. Sending the event from
> one task is no good because the event might arrive after the
> debugger has responded to some other task. Consider breakpoints
> in a shared mm, with the mm suddenly becoming unshared.

The interface was never designed to handle unsharing.  I don't really
think it should be extended to; whoever needs this functionality should
design something cleaner for utrace.

> There is also no way to find all the tasks which share an mm.
> This is needed so that tasks don't die if the debugger attaches
> to a pre-existing task and sets a breakpoint.

Ditto.  In practice, thread groups or LinuxThreads libthread_db suffice
for daily use.

> The /proc/*/auxv files don't work immediately after starting
> a process via the usual fork,PTRACE_TRACEME,exec method.
> One has to wait some undetermined amount of time.

I have no idea what this refers to, sorry.

> PTRACE_GETSIGINFO has 0x0605 as si_code when a process exits.
> This is not defined anywhere.

It's garbage.  PTRACE_GETSIGINFO is only valid after the process stops
with a signal.

-- 
Daniel Jacobowitz
CodeSourcery
