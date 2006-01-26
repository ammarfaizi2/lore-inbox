Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWAZQp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWAZQp3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 11:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWAZQp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 11:45:29 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:64974 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750724AbWAZQp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 11:45:28 -0500
Date: Thu, 26 Jan 2006 11:41:55 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] i386 - sys_clone from vsyscall
To: Daniel fernandez <ergot86@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <200601261144_MC3-1-B6C2-3A7B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <401b11ae0601260712w7cfe88abm638dc7a459b3bb3a@mail.gmail.com>

On Thu, 26 Jan 2006 at 15:12:08 +0000, Daniel fernandez wrote:

> > Your patch almost works but it copies the stack into the parent's address space.
> > Using access_process_vm() fixes it.  However, that still leaves unfixed the case
> > where vsyscall-int80 is used.
> 
> I copy the stack into the parent's address space becuase in this case
> the memory is shared, but  access_process_vm() is more elegant :).

My test program (below) doesn't use CLONE_VM.  With your patch the stack
data showed up only in the parent process, probably due to copy-on-write,
and the child gets SIGSEGV trying to transfer control to address 0.

> About vsyscall-int80, I don't know how to test that case in my
> computer but I think a solution could be:

I patched arch/i386/kernel/cpu/common.c to add a boot option "nox86sep"
similar to "nofxsr" and sure enough the test program dies when booting
with that option:

        $ ./test_clone2.ex
        SIGSEGV accessing 0x00000000 from EIP 0x00000000
        cloned; ret = 621

Your fix for this should work fine.

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>

#ifdef INT80
#  define SYSCALL_STR "int $0x80\n\t"
#else
#  define SYSCALL_STR "call 0xffffe400\n\t"
#endif

#define CLONE	120
#define FLAGS	0

unsigned long child_stack[4096] __attribute__((__aligned__(4096)));
unsigned long *child_stack_ptr = &child_stack[2047];
struct sigaction sa;
int ret;

static void handler(int nr, siginfo_t *si, void *vuc)
{
	struct ucontext *uc = (struct ucontext *)vuc;
	struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;

	printf("SIGSEGV accessing 0x%08x from EIP 0x%08x\n",
	       (unsigned long)si->si_addr, sc->eip);

	sa.sa_handler = SIG_DFL;
	sa.sa_flags = 0;
	sigaction(SIGSEGV, &sa, NULL);
}

int main(int argc, char * const argv[])
{
	sa.sa_sigaction = handler;
	sa.sa_flags = SA_SIGINFO;
	sigaction(SIGSEGV, &sa, NULL);

	asm volatile(
		SYSCALL_STR
		: "=a"(ret)
		: "a"(CLONE), "b"(FLAGS), "c"(child_stack_ptr)
		: "memory"
	);

	printf("cloned; ret = %d\n", ret);
	_exit(0);
}
-- 
Chuck
Currently reading: _The Atrocity Archives_ by Charles Stross
