Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264841AbTFCI4l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264848AbTFCI4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:56:41 -0400
Received: from mx2.elte.hu ([157.181.151.9]:25520 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264841AbTFCI4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:56:38 -0400
Date: Tue, 3 Jun 2003 11:09:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [patch] new sys_tkill2() system call, 2.5.70
Message-ID: <Pine.LNX.4.44.0306031100170.5663-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch, against 2.5.70, adds a new system-call called
sys_tkill2():

	asmlinkage long sys_tkill2(int tgid, int pid, int sig);

this new syscall solves the problem of PID-reuse. The pthread_kill()  
interface itself cannot guarantee via current kernel mechanisms that a
thread wont go away (call pthread_exit()) before the signal is delivered -
due to threads being detached. If some other application creates threads
fast enough and makes the PID space overwrap, then it might happen that
the wrong application gets the signal.

the tgid never changes during the lifetime of the application, so
specifying tgid guarantees that pthread_kill() will only send signals to
threads within this application.

(i also added the rule of tgid == 0 meaning 'no tgid check' - this made it
possible to merge the previous sys_tkill() API into the new sys_tkill2()
API. The sys_tkill API is of course preserved.)

Ulrich says that this interface is OK and desired for glibc. The patch was
sanity-compiled & booted on x86 SMP.

	Ingo

--- linux/include/asm-i386/unistd.h.orig	
+++ linux/include/asm-i386/unistd.h	
@@ -273,6 +273,7 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_tkill2		268
 
 #define NR_syscalls 268
 
--- linux/arch/i386/kernel/entry.S.orig	
+++ linux/arch/i386/kernel/entry.S	
@@ -874,6 +874,7 @@ ENTRY(sys_call_table)
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+	.long sys_tkill2
  
  
 nr_syscalls=(.-sys_call_table)/4
--- linux/kernel/signal.c.orig	
+++ linux/kernel/signal.c	
@@ -570,7 +570,7 @@ static int rm_from_queue(unsigned long m
 /*
  * Bad permissions for sending the signal
  */
-static inline int check_kill_permission(int sig, struct siginfo *info,
+static int check_kill_permission(int sig, struct siginfo *info,
 					struct task_struct *t)
 {
 	int error = -EINVAL;
@@ -1930,11 +1930,17 @@ sys_kill(int pid, int sig)
 	return kill_something_info(sig, &info, pid);
 }
 
-/*
- *  Send a signal to only one task, even if it's a CLONE_THREAD task.
+/**
+ *  sys_tkill2 - send signal to one specific thread
+ *  @tgid: the thread group ID of the thread - if 0 then no check is done.
+ *  @pid: the PID of the thread
+ *  @sig: signal to be sent
+ *
+ *  This syscall also checks the tgid and returns -ESRCH even if the PID
+ *  exists but it's not belonging to the target process anymore. This
+ *  method solves the problem of threads exiting and PIDs getting reused.
  */
-asmlinkage long
-sys_tkill(int pid, int sig)
+asmlinkage long sys_tkill2(int tgid, int pid, int sig)
 {
 	struct siginfo info;
 	int error;
@@ -1953,7 +1959,7 @@ sys_tkill(int pid, int sig)
 	read_lock(&tasklist_lock);
 	p = find_task_by_pid(pid);
 	error = -ESRCH;
-	if (p) {
+	if (p && (!tgid || (p->tgid == tgid))) {
 		error = check_kill_permission(sig, &info, p);
 		/*
 		 * The null signal is a permissions and process existence
@@ -1970,6 +1976,12 @@ sys_tkill(int pid, int sig)
 	return error;
 }
 
+asmlinkage long sys_tkill(int pid, int sig)
+{
+	return sys_tkill2(0, pid, sig);
+}
+
+
 asmlinkage long
 sys_rt_sigqueueinfo(int pid, int sig, siginfo_t __user *uinfo)
 {

