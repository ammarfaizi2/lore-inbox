Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWBVUix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWBVUix (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbWBVUix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:38:53 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:24729 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751117AbWBVUix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:38:53 -0500
Date: Wed, 22 Feb 2006 15:32:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: fix singlestep through an int80 syscall
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602221534_MC3-1-B90B-410F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using PTRACE_SINGLESTEP on a child that does an int80 syscall
misses the SIGTRAP that should be delivered upon syscall exit.
Fix that by setting TIF_SINGLESTEP when entering the kernel
via int80 with TF set.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Please consider for 2.6.16.  Simple test program:

/* Test whether singlestep through an int80 syscall works.
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <asm/user.h>

static int child, status;
static struct user_regs_struct regs;

static void do_child()
{
	ptrace(PTRACE_TRACEME, 0, 0, 0);
	kill(getpid(), SIGUSR1);
	asm ("int $0x80" : : "a" (20)); /* getpid */
}

static void do_parent()
{
	unsigned long eip, expected = 0;
again:
	waitpid(child, &status, 0);
	if (WIFEXITED(status) || WIFSIGNALED(status))
		return;

	if (WIFSTOPPED(status)) {
		ptrace(PTRACE_GETREGS, child, 0, &regs);
		eip = regs.eip;
		if (expected)
			fprintf(stderr, "child stop @ %08x, expected %08x %s\n",
					eip, expected,
					eip == expected ? "" : " <== ERROR");

		if (*(unsigned short *)eip == 0x80cd) {
			fprintf(stderr, "int 0x80 at %08x\n", (unsigned int)eip);
			expected = eip + 2;
		} else
			expected = 0;

		ptrace(PTRACE_SINGLESTEP, child, NULL, NULL);
	}
	goto again;
}

int main(int argc, char * const argv[])
{
	child = fork();
	if (child)
		do_parent();
	else
		do_child();
	return 0;
}

--- 2.6.16-rc4-nb.orig/arch/i386/kernel/entry.S
+++ 2.6.16-rc4-nb/arch/i386/kernel/entry.S
@@ -226,6 +226,10 @@ ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
+	testl $TF_MASK,EFLAGS(%esp)
+	jz no_singlestep
+	orl $_TIF_SINGLESTEP,TI_flags(%ebp)
+no_singlestep:
 					# system call tracing in operation / emulation
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
 	testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
