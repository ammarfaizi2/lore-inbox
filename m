Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTFPRYj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 13:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTFPRYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 13:24:39 -0400
Received: from palrel11.hp.com ([156.153.255.246]:3509 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S264047AbTFPRYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 13:24:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16110.147.422432.486761@napali.hpl.hp.com>
Date: Mon, 16 Jun 2003 10:38:27 -0700
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: force_successful_syscall_return() buggy?
In-Reply-To: <20030615193604.L5417@flint.arm.linux.org.uk>
References: <20030615193604.L5417@flint.arm.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 15 Jun 2003 19:36:04 +0100, Russell King <rmk@arm.linux.org.uk> said:

  Russell> Consider what happens when a userspace program is started
  Russell> from kernel space, eg the init(8) or hotplug programs.  In
  Russell> these, we call execve() from within kernel space function.
  Russell> This implies that we have some frames already on the stack.

  Russell> AFAIK, sys_execve() does not ensure that the kernel stack
  Russell> will be empty before starting the user space thread, so
  Russell> these programs are running with a slightly reduced kernel
  Russell> stack.

  Russell> In turn, this means that the user registers are not stored
  Russell> at the top of the kernel stack when the user space program
  Russell> subsequently calls a kernel system call, which means the
  Russell> *_task_regs() macro doesn't point at the saved user
  Russell> registers.

That's a limitation that was described in the change log entry:

	The only limitation of force_successful_syscall_return() is
	that it doesn't help with system calls performed by the
	kernel.  But the kernel does that so rarely and for such a
	limited set of syscalls that this is not a real problem.

Alpha and ia64 have used pt_regs for "force-success" purposes for a
long time, but if you want to add support to another platform, I'd
also recommend using the task_info instead.  Dave Miller proposed a
scheme that could work nicely: force_success flag is off by default
and turned on by force_successful_syscall_return().  When you
"consume" the flag in the syscall exit path, you turn it off
afterwards.  The advantage of this scheme is that you don't have any
extra stores on the performance-critical syscall entry path.  The
disadvantage is that you'll have to check the flag even when the
return-value is non-negative (probably not much of a disadvantage if
you store the flag along with the other flags).

Having said that, there is one real problem: Linus pointed out that
the current scheme may be in correct for certain platforms: if
sizeof(loff_t) > sizeof(off_t) then drivers/char/mem.c:memory_lseek()
may do force_successful_syscall_return() yet sys_lseek() would have to
return EOVERFLOW if it turns out that the offset doesn't fit in off_t.
I think this would only affect 32-bit platforms with some sort of
physical address-extensions.  So it would affect x86, but perhaps
nothing else (but of course, x86 doesn't use
force_successful_syscall() anyhow, so for now, that's OK).

The clean way to fix this would probably be to return the offset via a
pointer argument.

	--david
