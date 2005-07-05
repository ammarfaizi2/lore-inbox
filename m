Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVGETLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVGETLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVGETLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:11:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60319 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261341AbVGETLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:11:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <drow@false.org>
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86-64: ptrace ia32 BP fix
In-Reply-To: Daniel Jacobowitz's message of  Tuesday, 5 July 2005 10:07:24 -0400 <20050705140724.GA19552@nevyn.them.org>
X-Windows: putting new limits on productivity.
Message-Id: <20050705191101.C8712180981@magilla.sf.frob.com>
Date: Tue,  5 Jul 2005 12:11:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't this  to botch a debugger which supported both backtracing and
> PTRACE_SYSCALL, when stopped in a syscall?  We have unwind information
> for the VDSO and it's not going to tell us that the kernel has done
> something clever to the value of %ebp.

The user vDSO code pushes %ebp on the stack and then clobbers it.  The
unwind information says that %ebp was clobbered and says where the original
value can be found on the stack.  Unwinding doesn't care whether the %ebp
value is the one clobbered by the vDSO code, or the one clobbered by the
kernel (back to the previous value).  Like I said before, this matches the
i386 behavior.  If this were a problem, then it would have broken unwinding
on i386 already, but it's not a problem.

> The kernel is indeed not supposed to modify any input
> registers of syscalls (ok except rcx, but that is unavoidable)

The kernel plus the vDSO code together yield no modification.  That's the
point.  The kernel modifies %ebp in the sysenter/syscall path to match what
it would have contained if the user had done int $0x80 instead of call
vDSO.  This is the most sensible thing.  Otherwise using the unwind
information to back out of the vDSO special-frame would be required by every
tracer that wants to know the 6th argument to a system call.  (Or else it
would have to recognize the vDSO entry magically and have hard-wired
knowledge of what that does with the stack and registers.)

This change really does what I said: it makes the behavior consistent with
the i386 behavior.  Even if that were wrong (which it's not really), the
principle remains that the x86-64 support for 32-bit processes should
behave like the real 32-bit kernel does.


Thanks,
Roland

