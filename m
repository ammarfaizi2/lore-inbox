Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262656AbVAVDZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbVAVDZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 22:25:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVAVDZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 22:25:22 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:28454
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262656AbVAVDZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 22:25:16 -0500
Date: Sat, 22 Jan 2005 04:25:16 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Roland McGrath <roland@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050122032516.GF11112@dualathlon.random>
References: <20050121125558.GA5596@elte.hu> <200501212131.j0LLVkJ8013886@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501212131.j0LLVkJ8013886@magilla.sf.frob.com>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 01:31:46PM -0800, Roland McGrath wrote:
> When gdb has a bug, people want to be able to kill it and get on with using
> their program, not have their program always be killed too.

What I need is that the program is killed right away synchronously as
soon as the "debugger" detaches (to me that's a needed feature). No
matter why the debugger detached.  This is the opposite of what
ptrace/strace does right now.

Just try to attach to a task with strace -p, then kill strace with -9,
the task will keep going like if nothing has happened. I need the child
killed too instead (before the parent unptrace the child).

Probably the reason why the app gets killed is that gdb is the ptrace
task is the process leader of the process group like Ingo suggested. But
I'd rather not depend on leaders/groups/pids/signals, when I can do it
with do_exit and a check on the syscall number.

Ptrace does a lot more of what I need, I don't care about parameters or
anything more than the syscall number, I don't need to change the
retvals during syscall return or to check registers or to stop a task.
Even the auditing subsystem could be implemented by putting all tasks
under strace and by having the ptracers communicating with each other
with pipes to generate a global info. But it wouldn't be as reliable and
as simple as having kernel code doing it.

I'm still open to do it with ptrace if there's a consensus on l-k to do
it in that direction, it's probably going to work fine too but if I
didn't feel safer with seccomp I would be doing ptrace in the first
place, it's not like I forgotten I could do it with ptrace too (like
Pavel already reminded me some month ago).
