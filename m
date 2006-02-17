Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWBQIUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWBQIUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 03:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWBQIUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 03:20:52 -0500
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:28821 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932505AbWBQIUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 03:20:52 -0500
Date: Fri, 17 Feb 2006 03:16:55 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix singlestepping though a syscall
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Paulo Marques <pmarques@grupopie.com>
Message-ID: <200602170320_MC3-1-B898-C9D3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2006 at 17:06:22 -0800, Linus Torvalds wrote:

> On Thu, 16 Feb 2006, Chuck Ebbert wrote:
> >
> > Singlestep through a syscall using vsyscall-sysenter had two bugs:
> > 
> >     1.  Setting TIF_SINGLESTEP is not enough to force
> >         do_notify_resume() to be run on return to user;
> >         TIF_IRET must also be set.
>
> Interesting, but I think you pinpointed the _real_ bug.
> ...
> Oh, actually, I think you should just remove the clearing of 
> _TIF_SINGLESTEP from _TIF_WORK_MASK. Does that fix the bug.

Yes, that works.  I was afraid to try it because of unknown side-effects
but one of those may be that it fixes Paolo's debugger problem.  The C
program I was testing with is enclosed and I can even (with care) debug
it with gdb passing through SIGTRAP and step through the signal handler.

Paolo, can you try this patch for your debugger problem?


Do not mask TIF_SINGLESTEP bit in _TIF_WORK_MASK. Masking this stopped
do_notify_resume() from being called when it should have been.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc3-nb.orig/include/asm-i386/thread_info.h
+++ 2.6.16-rc3-nb/include/asm-i386/thread_info.h
@@ -158,8 +158,8 @@ register unsigned long current_stack_poi
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
-  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP|\
-		  _TIF_SECCOMP|_TIF_SYSCALL_EMU))
+  (0x0000FFFF & ~(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
+		  _TIF_SECCOMP | _TIF_SYSCALL_EMU))
 /* work to do on any return to u-space */
 #define _TIF_ALLWORK_MASK	(0x0000FFFF & ~_TIF_SECCOMP)
_ 

#define _GNU_SOURCE
#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>

#define TRAP_FLAG 0x100

#ifdef INT80
# define ENTER_KERNEL	"int $0x80\n\t"
#else
# define ENTER_KERNEL	"call *vsyscall\n\t"
#endif

static struct sigaction sa;
static void * const vsyscall = (void *)0xffffe400;

static void handler(int nr, siginfo_t *si, void *vuc)
{
	struct ucontext *uc = (struct ucontext *)vuc;
	struct sigcontext *sc = (struct sigcontext *)&uc->uc_mcontext;

	printf("handler: signo = %d, errno = %d, code = %d\n",
		si->si_signo, si->si_errno, si->si_code);
	printf("handler: addr = 0x%08x, inst = 0x%02x, flags=0x%08x\n\n",
		si->si_addr, *(unsigned char *)si->si_addr, sc->eflags);
}

int main(int argc, char * const argv[])
{
	sa.sa_sigaction = handler;
	sa.sa_flags     = SA_SIGINFO;
	sigaction(SIGTRAP, &sa, NULL);

	asm volatile ("pushf ; orl %0,(%%esp) ; popf" : : "i" (TRAP_FLAG));
	asm volatile (ENTER_KERNEL : : "a" (20) /* getpid() */);
	asm volatile ("pushf ; andl %0,(%%esp) ; popf" : : "i" (~TRAP_FLAG));
	asm volatile (ENTER_KERNEL : : "a" (20) /* getpid() */);

	return 0;
}
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
