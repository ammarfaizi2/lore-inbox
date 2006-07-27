Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751855AbWG0GzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbWG0GzU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 02:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWG0GzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 02:55:20 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:28614 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751855AbWG0GzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 02:55:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Twxf7HL/VZJE40EN9AgH+zBPiF6Ugq5OgV+4tv9lZx+MXTt0DMUJ+HDy8VTsGN+ot995TBSyjeOQwvJby0l108csTl4TsA1F4okwxIdN2SHr3LslcgkkOfabnW0exC/pcn39Q6H+ZsoRIpXiQ/CdjSyxozC0totdp4i1VjlfARM=
Message-ID: <787b0d920607262355x3f669f0ap544e3166be2dca21@mail.gmail.com>
Date: Thu, 27 Jul 2006 02:55:17 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk, ak@suse.de, mingo@elte.hu,
       arjan@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       roland@redhat.com
Subject: ptrace bugs and related problems
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Many of these bugs are generic, some are pure i386, some are for
i386 binaries on the x86-64 kernel, and some apply to a bit more.
Some bugs may involve race conditions: I use a 2-core AMD system.
Kernels vary, but are generally quite recent. (stock 2.6.17.7,
FC5's latest update, etc.)

There is a ptrace option to follow vfork, and an option to get a
message when the parent is released by the child. In kernel/fork.c
there is a bad attempt at optimization which prevents the release
message (PTRACE_EVENT_VFORK_DONE) from being sent unless the ptrace
user also chose the option to follow the vfork child.

System call restart does not appear to nest. It stores stuff
in the thread info rather than on the user stack.

Both i386 and x86-64 PTRACE_SINGLESTEP only check for popf, not iret.
Yes, really, iret can be used by normal apps. There is also no check
for failure, as when the popf or iret takes an alignment exception
or hits an unmapped page. The signal handler could fix that up, but
the kernel still thinks that the popf must have set TF in eflags and
thus writes a messed-up eflags into the sigcontext.

There is the pushf problem. Single-stepping this simple code
does not work:   pushf ; popf

A debugger can set or get the siginfo. Great. Signal handlers also
have sigcontext/ucontext data. Besides being generally very useful,
this is the only place where the cr2 register and trap error data
can be found. Looking on the stack only works once the signal is
allowed to be delivered, which may be too late for the debugger.

x86-64 has big problems single-stepping in the vdso's signal
return path. Suppose I breakpoint the pop. (this is in the path
that goes pop,mov,syscall or pop,mov,sysenter) If I then try to
single step, the process runs free. The i386 arch works fine.

I can't even set the hardware breakpoints:

(gdb) hbreak __kernel_sigreturn
Hardware assisted breakpoint 1 at 0xffffe500
(gdb) hbreak __kernel_rt_sigreturn
Hardware assisted breakpoint 2 at 0xffffe600
(gdb) continue
Continuing.
Couldn't write debug register: Input/output error.

The debugger has no way to reliably stop a process without causing
confusion. The SIGSTOP signal is not queued. The app under debug might
use SIGSTOP and rely on SIGSTOP to work. The debugger can't steal this.
Any signal that could be queued can also be blocked. The debugger has
no way to get notice when a signal has merely been queued, can not
see into the queue, and can not reasonably adjust the signal mask.

The is_at_popf function on x86-64 fails to account for instruction
set differences. Many prefixes are only valid in 32-bit mode, and
many others are only valid in 64-bit mode. The name is of course
wrong too; see above note about iret and other problems.

The PTRACE_EVENT_EXEC messages are just plain unreliable. They don't
always arrive. Things get especially ugly when a non-leader task
does an execve.

A debugger has little reasonable access to x86 segment info.
Given an arbitrary segment number, I can not generally look it
up in the context of the target process. I can special case
the typical ones, separately for i386 and x86-64. I can "know"
that specific segments are the context switched ones, then ask
the kernel about those.

A debugger needs to read the vdso page. A debugger might want to use
either /proc/*/mem or PTRACE_PEEK. One of the architectures can't do
both. If I remember right, x86-64 can't PTRACE_PEEK.

Suppose my debugger has a few threads. PTRACE_ATTACH will not share.
All ptrace calls fail for all threads other than the one that attached.
It really sucks to have to funnel everything through one thread.

BTW, not bugs exactly, but... Getting ptrace events via waitpid is
horrible. Events arrive in some arbitrary order, with no peeking ahead
either within a single target process or even across multiple target
processes. Messages from successful clone/fork/exec may arrive before
or after the child stops, making for some lovely non-deterministic
behavior. Also, it's no fun to mix waitpid with signals or select.
Writing a reliable debugger with ptrace on Linux is absurdly painful.
