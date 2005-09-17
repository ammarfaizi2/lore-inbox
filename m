Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVIQAkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVIQAkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 20:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbVIQAkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 20:40:15 -0400
Received: from liaag2ag.mx.compuserve.com ([149.174.40.158]:1481 "EHLO
	liaag2ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750785AbVIQAkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 20:40:14 -0400
Date: Fri, 16 Sep 2005 20:36:14 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.13-mm2
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509162038_MC3-1-AA6D-60D9@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2005 at 20:26:51 -0400, Parag Warudkar wrote:

> Andrew Morton wrote:
> 
> > Parag, perhaps you could confirm that reverting that patch fixes 
> > things up?
> 
> Sure - reverting the x86-64-ptrace-ia32-bp-fix patch fixes it.

 It looks to me like that patch corrupts ebp.

 This one works for me, though ebp still appears wrong to a 32-bit
debugger on syscall exit trace.  Maybe that doesn't matter so much.

 Test program follows (it will create a file named "__ptfile__"), then patch.

================================================================================

/* ptrace test program 
 *
 * Tests if ptrace can modify syscall arg6 (ebp) in ia32 mode.
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ptrace.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <asm/user.h>

int parent, child, status, traces;
struct user_regs_struct regs;
char zero = '0', one = '1';

void dump_regs(struct user_regs_struct *regs)
{
	printf("eax = %08X (%d), orig_eax = %08X (%d)\n",
		(unsigned int)regs->eax,
		(unsigned int)regs->eax,
		(unsigned int)regs->orig_eax,
		(unsigned int)regs->orig_eax);
	printf("ebx = %08X, ecx = %08X, edx = %08X\n",
		(unsigned int)regs->ebx,
		(unsigned int)regs->ecx,
		(unsigned int)regs->edx);
	printf("esi = %08X, edi = %08X, ebp = %08X\n",
		(unsigned int)regs->esi,
		(unsigned int)regs->edi,
		(unsigned int)regs->ebp);
}

void do_parent()
{
again:
	waitpid(child, &status, 0);
	if (WIFSTOPPED(status)) {
		if (traces && traces <= 2 ) { /* skip first, then do two */
			puts("child stopped");
			ptrace(PTRACE_GETREGS, child, 0, &regs);
			dump_regs(&regs);
			if (regs.orig_eax == 192 && traces == 1) { /* mmap2 */
				if (regs.ebp != 0)
					puts("tracer: arg6 was not 0: "
					     "ptrace is broken!");
				else {
					regs.ebp = 1; /* change arg 6 */
					ptrace(PTRACE_SETREGS, child, 0, &regs);
				}
			} else if (traces == 1) /* first syscall wasn't mmap2 */
				puts("unexpected problem, ignore the result!");
		}
		ptrace(PTRACE_SYSCALL, child, 0, 0);
		traces++;
	}
	if (!WIFEXITED(status))
		goto again;
}

void do_child()
{
	int f, i;
	void *a;
	int works = 1;

	f = open("__ptfile__", O_RDWR | O_CREAT | O_TRUNC, S_IREAD | S_IWRITE);
	for (i = 0; i < 4096; i++) /* a page of '0' */
		write(f, &zero, 1);
	for (i = 0; i < 4096; i++) /* a page of '1' */
		write(f, &one, 1);
	close(f);
	
	f = open("__ptfile__", O_RDONLY);
	ptrace(PTRACE_TRACEME, 0, 0, 0);
	kill(getpid(), SIGUSR1);
	a = mmap(0, 4096, PROT_READ, MAP_SHARED, f, 0); /* map first page */
	if (*(char *)a != one)
		works = 0; /* got first page: arg6 was unchanged */
	munmap(a, 4096);
	close(f);
	remove("__ptfile__");
	
	if (works)
		puts("ptrace works");
	else
		puts("mmap args didn't change: ptrace is broken!");
}

int main(int argc, char * const argv[])
{
	parent = getpid();
	child = fork();

	if (child)
		do_parent();
	else
		do_child();

	return 0;
}
================================================================================

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Original-Patch-By: Roland McGrath <roland@redhat.com>

When the 32-bit vDSO is used to make a system call, the %ebp register for
the 6th syscall arg has to be loaded from the user stack (where it's pushed
by the vDSO user code).  The native i386 kernel always does this before
stopping for syscall tracing, so %ebp can be seen and modified via ptrace
to access the 6th syscall argument.  The x86-64 kernel fails to do this,
presenting the stack address to ptrace instead.  This makes the %rbp value
seen by 64-bit ptrace of a 32-bit process, and the %ebp value seen by a
32-bit caller of ptrace, both differ from the native i386 behavior.

This patch fixes the problem by putting the word loaded from the user stack
into %rbp before calling syscall_trace_enter, and reloading the 6th syscall
argument from there afterwards (so ptrace can change it).  This makes the
behavior match that of i386 kernels.

 arch/x86_64/ia32/ia32entry.S |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

--- 2.6.13-64.orig/arch/x86_64/ia32/ia32entry.S
+++ 2.6.13-64/arch/x86_64/ia32/ia32entry.S
@@ -102,20 +102,16 @@ sysenter_do_call:	
 	.byte	0xf, 0x35
 
 sysenter_tracesys:
+	xchgl	%r9d,%ebp
 	SAVE_REST
 	CLEAR_RREGS
+	movq	%r9,R9(%rsp)
 	movq	$-ENOSYS,RAX(%rsp)	/* really needed? */
 	movq	%rsp,%rdi        /* &pt_regs -> arg1 */
 	call	syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
-	movl	%ebp, %ebp
-	/* no need to do an access_ok check here because rbp has been
-	   32bit zero extended */ 
-1:	movl	(%rbp),%r9d
-	.section __ex_table,"a"
-	.quad 1b,ia32_badarg
-	.previous
+	xchgl	%ebp,%r9d
 	jmp	sysenter_do_call
 	CFI_ENDPROC
 
@@ -183,20 +179,17 @@ cstar_do_call:	
 	sysretl
 	
 cstar_tracesys:	
+	xchgl %r9d,%ebp
 	SAVE_REST
 	CLEAR_RREGS
+	movq %r9,R9(%rsp)
 	movq $-ENOSYS,RAX(%rsp)	/* really needed? */
 	movq %rsp,%rdi        /* &pt_regs -> arg1 */
 	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
+	xchgl %ebp,%r9d
 	movl RSP-ARGOFFSET(%rsp), %r8d
-	/* no need to do an access_ok check here because r8 has been
-	   32bit zero extended */ 
-1:	movl	(%r8),%r9d
-	.section __ex_table,"a"
-	.quad 1b,ia32_badarg
-	.previous
 	jmp cstar_do_call
 				
 ia32_badarg:
__
Chuck
