Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161327AbWG1W2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161327AbWG1W2g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbWG1W2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:28:36 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49303 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161327AbWG1W2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:28:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H1S5N+YS/Bfgx14OVUAe/ItAC6xXE3PrepRulMluw8LLRwsKByEWEIAf2CMJfl9jI0bu5j6VFU8aY9w5fyzjH2VpxEs68iTcXFy14oXvdyZ+heVFJ6kbYt0r7fha4fz0nbu6F6DycRLscvbAwWMtH0dNZHHCw3R3L0w0/voDhfU=
Message-ID: <787b0d920607281528w56472db2u81268aad523d5c72@mail.gmail.com>
Date: Fri, 28 Jul 2006 18:28:34 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: ptrace bugs and related problems
In-Reply-To: <20060728034741.GA3372@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
	 <20060727203128.GA26390@nevyn.them.org>
	 <787b0d920607271817u4978d2bdiac261d916971c1b3@mail.gmail.com>
	 <20060728034741.GA3372@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Daniel Jacobowitz <dan@debian.org> wrote:
> On Thu, Jul 27, 2006 at 09:17:48PM -0400, Albert Cahalan wrote:
> > Minor correction: the message is sent with bad data.
> > Here at home I happen to have 2.6.17-rc5, so
> > looking in the kernel/fork.c file there:
> >
> > The fork_traceflag function looks only at the flags
> > used to follow processes, including PT_TRACE_VFORK.
> >
> > In do_fork, the result of fork_traceflag is assigned
> > to the "trace" variable. Note that PT_TRACE_VFORK_DONE
> > does not cause "trace" to be non-zero.
> >
> > Then we hit this code:
> >
> >                if (unlikely (trace)) {
> >                        current->ptrace_message = nr;
> >                        ptrace_notify ((trace << 8) | SIGTRAP);
> >                }
> >
> > That doesn't run. The ptrace_message is thus not set when
> > ptrace_notify is called to send the PTRACE_EVENT_VFORK_DONE
> > message. You get random stale data from a previous message.
>
> Why do you want the message data anyway?

I was using the data to look up which task just got split away
from the parent. Judging by Chuck Ebbert's email, I'm not the
only person to expect the data to be valid.

> > The forced exits show up, oddly. I see one for each task,
> > except for the task which called execve(). The task calling
> > execve() will silently go away. The leader task, despite
> > being reported as dead, returns from execve. Ouch. It would
> > be much more friendly to have the task calling execve()
> > send a (new) PTRACE_EVENT_TID_CHANGE message with the new ID
> > as the ptrace_message. If this is the very last message sent
> > by the task doing execve and is made to arrive in proper order,
> > the debugger can renumber the structures it uses to track tasks.
>
> Or just present things as if the leader task did the execve, which is
> effectively what happens, and what I thought would happen for ptrace
> too.

That makes things even weirder. A successful execve done in one
thread appears to be done by another (which might not be
traced if the debugger was a bit odd), while a failing execve
appears... where?

> > Note that the new unshare() system call will need to send
> > ptrace events for all tasks affected. Sending the event from
> > one task is no good because the event might arrive after the
> > debugger has responded to some other task. Consider breakpoints
> > in a shared mm, with the mm suddenly becoming unshared.
>
> The interface was never designed to handle unsharing.  I don't really
> think it should be extended to; whoever needs this functionality should
> design something cleaner for utrace.

I'm not sure utrace will be accepted. (many ptrace alternatives
have been born and died over the years) Even if utrace does get
accepted, initially we only get:

1. a clean-up that provides hope for the future
2. a hopefully-compatible ptrace on top of utrace
3. some sort of demo interface

That alone won't replace ptrace.

> > There is also no way to find all the tasks which share an mm.
> > This is needed so that tasks don't die if the debugger attaches
> > to a pre-existing task and sets a breakpoint.
>
> Ditto.  In practice, thread groups or LinuxThreads libthread_db suffice
> for daily use.
>
> > The /proc/*/auxv files don't work immediately after starting
> > a process via the usual fork,PTRACE_TRACEME,exec method.
> > One has to wait some undetermined amount of time.
>
> I have no idea what this refers to, sorry.

Never mind. I need to use vfork to ensure that the debugger
does not run until the child has done execve. Hopefully the
vfork wake-up won't happen before /proc/*/auxv is ready.
(doing a wait is awkward: I want the data before I enter my
main debugger loop, but the main debugger loop is based on
waitpid and will thus hang if the event is eaten early)

> > PTRACE_GETSIGINFO has 0x0605 as si_code when a process exits.
> > This is not defined anywhere.
>
> It's garbage.  PTRACE_GETSIGINFO is only valid after the process stops
> with a signal.

The process does indeed stop with a signal. It gets SIGTRAP
as part of sending the ptrace event.
