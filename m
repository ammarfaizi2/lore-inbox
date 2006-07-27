Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWG0Ubo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWG0Ubo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 16:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWG0Ubo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 16:31:44 -0400
Received: from nevyn.them.org ([66.93.172.17]:7900 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S1750725AbWG0Ubn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 16:31:43 -0400
Date: Thu, 27 Jul 2006 16:31:28 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: Re: ptrace bugs and related problems
Message-ID: <20060727203128.GA26390@nevyn.them.org>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>, torvalds@osdl.org,
	alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
	arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	roland@redhat.com
References: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 02:55:17AM -0400, Albert Cahalan wrote:
> Many of these bugs are generic, some are pure i386, some are for
> i386 binaries on the x86-64 kernel, and some apply to a bit more.
> Some bugs may involve race conditions: I use a 2-core AMD system.
> Kernels vary, but are generally quite recent. (stock 2.6.17.7,
> FC5's latest update, etc.)

Reporting bugs individually, and with a bit more detail, has the
advantage that people can actually keep track of them and
recognize them; I highly recommend it.  And how are we supposed to
answer bugs that apply individually to kernels of unspecified origin?

> There is a ptrace option to follow vfork, and an option to get a
> message when the parent is released by the child. In kernel/fork.c
> there is a bad attempt at optimization which prevents the release
> message (PTRACE_EVENT_VFORK_DONE) from being sent unless the ptrace
> user also chose the option to follow the vfork child.

This doesn't make sense.  Example?

     wait_for_completion(&vfork);
     if (unlikely (current->ptrace & PT_TRACE_VFORK_DONE))
            ptrace_notify ((PTRACE_EVENT_VFORK_DONE << 8) | SIGTRAP);

When the parent's vfork is done, the parent's debugger gets a
notification.

> The debugger has no way to reliably stop a process without causing
> confusion. The SIGSTOP signal is not queued. The app under debug might
> use SIGSTOP and rely on SIGSTOP to work. The debugger can't steal this.
> Any signal that could be queued can also be blocked. The debugger has
> no way to get notice when a signal has merely been queued, can not
> see into the queue, and can not reasonably adjust the signal mask.

See utrace.  This problem is roughly not solvable using ptrace.

> The PTRACE_EVENT_EXEC messages are just plain unreliable. They don't
> always arrive. Things get especially ugly when a non-leader task
> does an execve.

This is what I meant by vague bug reports.  The code for sending this
event is quite simple.  Things do get ugly when non-leader tasks exec;
I don't know whether the forced exits of other threads are clearly
visible from the debugger.

> A debugger needs to read the vdso page. A debugger might want to use
> either /proc/*/mem or PTRACE_PEEK. One of the architectures can't do
> both. If I remember right, x86-64 can't PTRACE_PEEK.

As far as I know I don't have this problem, on x86_64.

> Suppose my debugger has a few threads. PTRACE_ATTACH will not share.
> All ptrace calls fail for all threads other than the one that attached.
> It really sucks to have to funnel everything through one thread.

This is a known limit of ptrace.  It's discussed periodically.

> BTW, not bugs exactly, but... Getting ptrace events via waitpid is
> horrible. Events arrive in some arbitrary order, with no peeking ahead
> either within a single target process or even across multiple target
> processes. Messages from successful clone/fork/exec may arrive before
> or after the child stops, making for some lovely non-deterministic
> behavior. Also, it's no fun to mix waitpid with signals or select.
> Writing a reliable debugger with ptrace on Linux is absurdly painful.

See utrace.

-- 
Daniel Jacobowitz
CodeSourcery
