Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317405AbSHMPXH>; Tue, 13 Aug 2002 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSHMPXG>; Tue, 13 Aug 2002 11:23:06 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17354 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317405AbSHMPXF>;
	Tue, 13 Aug 2002 11:23:05 -0400
Date: Tue, 13 Aug 2002 17:25:33 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] exit_free(), 2.5.31-A0
Message-ID: <Pine.LNX.4.44.0208131712270.30879-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch implements a new syscall, exit_free():

	exit_free(error_code, addr, val);

this syscall is used as a performance optimization in glibc's threading
library.

upon exiting of child threads there is an ugly race condition that must be
solved: the freeing of the child stack. Old pthreads used to set up a
trampoline, jump to it, munmap() the child stack and call sys_exit(). It
does not have to be detailed how much this hurts performance: the
munmap(), besides being slow for such a lightweight thing as thread-exit,
also flushes the TLB, possibly across CPUs. Also, locality of reference of
thread stacks is lost as well.

the new thread library solves this performance by introducing a 'thread
stack cache' - a simple list of thread stacks. (with some more details to
handle different stack sizes.) The problem with the stack cache is that
there's a race condition: who releases it? We must not free the thread
stack up until the very last instruction the current thread executes,
because a signal handler might arrive and might use an alrady freed stack.  
Other threads might pick this stack and overwrite it ... Disabling signals
upon thread-exit adds a syscall overhead, but it still doesnt solve the
fundamental problem of 'who frees the stack'. A global semaphore for a
trampoline stack would have to be introduced to be able to free the stack
safely - a messy, slow and unscalable solution. Or queueing the stack to a
helper thread is equally messy.

again the kernel can give the threading library a helping hand to solve
this catch-22 problem, surprisingly easily in this case as well.  
exit_free() simply writes a user-provided word back to userspace. At that
point the user stack is not used anymore (nor will it ever be - sys_exit()
cannot fail), so freeing it is appropriate. The actual way glibc utilizes
exit_free() is that there's a "is this stack free" flag in the thread
stack control structure, and exit_free() sets this to '1'. So upon
thread-exit the thread frees the stack and puts it into the stack cache -
but other threads will skip over it because the 'free' flag is still 0.

with this syscall it was possible to implement single-syscall thread exit
in glibc. (well, actually not yet, the next patch i send will enable this
fully by solving the "who does the waitpid()?" problem.)

	Ingo

--- linux/arch/i386/kernel/entry.S.orig	Tue Aug 13 17:13:30 2002
+++ linux/arch/i386/kernel/entry.S	Tue Aug 13 17:13:42 2002
@@ -755,6 +755,7 @@
 	.long sys_set_thread_area
 	.long sys_get_thread_area
 	.long sys_clone_startup	/* 245 */
+	.long sys_exit_free
 
 	.rept NR_syscalls-(.-sys_call_table)/4
 		.long sys_ni_syscall
--- linux/include/asm-i386/unistd.h.orig	Tue Aug 13 17:13:00 2002
+++ linux/include/asm-i386/unistd.h	Tue Aug 13 17:13:17 2002
@@ -250,6 +250,7 @@
 #define __NR_set_thread_area	243
 #define __NR_get_thread_area	244
 #define __NR_clone_startup	245
+#define __NR_exit_free		246
 
 /* user-visible error numbers are in the range -1 - -124: see <asm-i386/errno.h> */
 
--- linux/kernel/exit.c.orig	Tue Aug 13 17:12:06 2002
+++ linux/kernel/exit.c	Tue Aug 13 17:12:45 2002
@@ -586,6 +586,12 @@
 	do_exit((error_code&0xff)<<8);
 }
 
+asmlinkage long sys_exit_free(int error_code, unsigned long *addr, unsigned long val)
+{
+	put_user(val, addr);
+	do_exit((error_code&0xff)<<8);
+}
+
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru)
 {
 	int flag, retval;

