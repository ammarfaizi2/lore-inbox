Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751759AbWG1BRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbWG1BRu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWG1BRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:17:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:41441 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751285AbWG1BRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:17:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XrX+jPSXei2vsBJqhiVtMOaMWifvMGhJRCreD9QlzGcg1UtJn29WqB8cCDnteek/qxIU7mH42vkNi22uu35P+q07Gbw1mzpUntWkXyJtGHSSStwoKRJaHsoQG5ZUP8z/NARV1YGHtltjryf4acQYXMI+LaDFaElpwsXH+5Wvo3o=
Message-ID: <787b0d920607271817u4978d2bdiac261d916971c1b3@mail.gmail.com>
Date: Thu, 27 Jul 2006 21:17:48 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Albert Cahalan" <acahalan@gmail.com>, torvalds@osdl.org,
       alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: ptrace bugs and related problems
In-Reply-To: <20060727203128.GA26390@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
	 <20060727203128.GA26390@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Daniel Jacobowitz <dan@debian.org> wrote:
> On Thu, Jul 27, 2006 at 02:55:17AM -0400, Albert Cahalan wrote:
> > Many of these bugs are generic, some are pure i386, some are for
> > i386 binaries on the x86-64 kernel, and some apply to a bit more.
> > Some bugs may involve race conditions: I use a 2-core AMD system.
> > Kernels vary, but are generally quite recent. (stock 2.6.17.7,
> > FC5's latest update, etc.)
>
> Reporting bugs individually, and with a bit more detail, has the
> advantage that people can actually keep track of them and
> recognize them; I highly recommend it.  And how are we supposed to
> answer bugs that apply individually to kernels of unspecified origin?

I think the detail is enough to be useful, which is better
than no bug reports at all.

I've been taking notes as I encounter the bugs at work.
I just recently got an OK to post them. While trying to
find workarounds so I can ship a product, I certainly did
not have an excess of time to play with the bugs.

> > There is a ptrace option to follow vfork, and an option to get a
> > message when the parent is released by the child. In kernel/fork.c
> > there is a bad attempt at optimization which prevents the release
> > message (PTRACE_EVENT_VFORK_DONE) from being sent unless the ptrace
> > user also chose the option to follow the vfork child.
>
> This doesn't make sense.  Example?
>
>      wait_for_completion(&vfork);
>      if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
>             ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);
>
> When the parent's vfork is done, the parent's debugger gets a
> notification.

Minor correction: the message is sent with bad data.
Here at home I happen to have 2.6.17-rc5, so
looking in the kernel/fork.c file there:

The fork_traceflag function looks only at the flags
used to follow processes, including PT_TRACE_VFORK.

In do_fork, the result of fork_traceflag is assigned
to the "trace" variable. Note that PT_TRACE_VFORK_DONE
does not cause "trace" to be non-zero.

Then we hit this code:

                if (unlikely (trace)) {
                        current->ptrace_message = nr;
                        ptrace_notify ((trace << 8) | SIGTRAP);
                }

That doesn't run. The ptrace_message is thus not set when
ptrace_notify is called to send the PTRACE_EVENT_VFORK_DONE
message. You get random stale data from a previous message.

> > The PTRACE_EVENT_EXEC messages are just plain unreliable. They don't
> > always arrive. Things get especially ugly when a non-leader task
> > does an execve.
>
> This is what I meant by vague bug reports.  The code for sending this
> event is quite simple.  Things do get ugly when non-leader tasks exec;
> I don't know whether the forced exits of other threads are clearly
> visible from the debugger.

The forced exits show up, oddly. I see one for each task,
except for the task which called execve(). The task calling
execve() will silently go away. The leader task, despite
being reported as dead, returns from execve. Ouch. It would
be much more friendly to have the task calling execve()
send a (new) PTRACE_EVENT_TID_CHANGE message with the new ID
as the ptrace_message. If this is the very last message sent
by the task doing execve and is made to arrive in proper order,
the debugger can renumber the structures it uses to track tasks.

I don't get WIFEXITED with waitpid for any of this.

> > Suppose my debugger has a few threads. PTRACE_ATTACH will not share.
> > All ptrace calls fail for all threads other than the one that attached.
> > It really sucks to have to funnel everything through one thread.
>
> This is a known limit of ptrace.  It's discussed periodically.

It's a known bug. More trouble:

Note that the new unshare() system call will need to send
ptrace events for all tasks affected. Sending the event from
one task is no good because the event might arrive after the
debugger has responded to some other task. Consider breakpoints
in a shared mm, with the mm suddenly becoming unshared.

There is also no way to find all the tasks which share an mm.
This is needed so that tasks don't die if the debugger attaches
to a pre-existing task and sets a breakpoint.

The /proc/*/auxv files don't work immediately after starting
a process via the usual fork,PTRACE_TRACEME,exec method.
One has to wait some undetermined amount of time.

PTRACE_GETSIGINFO has 0x0605 as si_code when a process exits.
This is not defined anywhere.
