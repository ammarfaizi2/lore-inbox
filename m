Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTFCQbK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbTFCQbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:31:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59827 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265086AbTFCQbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:31:07 -0400
Date: Tue, 3 Jun 2003 18:43:55 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ulrich Drepper <drepper@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] new sys_tkill2() system call, 2.5.70
In-Reply-To: <Pine.LNX.4.44.0306030933240.3714-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0306031836400.23082-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 3 Jun 2003, Linus Torvalds wrote:

> > are you suggesting to extend sys_tgkill() functionality to also detect -1
> > for the PID, and do a process-signal send?
> 
> I don't care much, but that zero special case is definitely not a good 
> idea.
> 
> You might make the thing acceptable to me by just removing the "zero means 
> everythign", and replacing that logic with
> 
> 	if (!tgid)
> 		tgid = current->tgid;
> 
> which is similar to how we handle zeroes in some other places. In other 
> words, a zero is not a "wildcard", it means "_this_ thread group".

i did it this way mostly because i wanted to avoid duplicating code, and
wanted to 'fold' tkill into the new variant.

in the attached patch sys_tgkill(tgid,pid,sig) means only that, nothing
more: send the signal to the thread specified by (tgid,pid) - return
-ESRCH if it does not exist in that combination.

	Ingo

--- linux/include/asm-i386/unistd.h.orig	
+++ linux/include/asm-i386/unistd.h	
@@ -273,6 +273,7 @@
 #define __NR_clock_gettime	(__NR_timer_create+6)
 #define __NR_clock_getres	(__NR_timer_create+7)
 #define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_tgkill		268
 
 #define NR_syscalls 268
 
--- linux/arch/i386/kernel/entry.S.orig	
+++ linux/arch/i386/kernel/entry.S	
@@ -874,6 +874,7 @@ ENTRY(sys_call_table)
  	.long sys_clock_gettime		/* 265 */
  	.long sys_clock_getres
  	.long sys_clock_nanosleep
+	.long sys_tgkill
  
  
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
@@ -1930,6 +1930,52 @@ sys_kill(int pid, int sig)
 	return kill_something_info(sig, &info, pid);
 }
 
+/**
+ *  sys_tkill - send signal to one specific thread
+ *  @tgid: the thread group ID of the thread
+ *  @pid: the PID of the thread
+ *  @sig: signal to be sent
+ *
+ *  This syscall also checks the tgid and returns -ESRCH even if the PID
+ *  exists but it's not belonging to the target process anymore. This
+ *  method solves the problem of threads exiting and PIDs getting reused.
+ */
+asmlinkage long sys_tgkill(int tgid, int pid, int sig)
+{
+	struct siginfo info;
+	int error;
+	struct task_struct *p;
+
+	/* This is only valid for single tasks */
+	if (pid <= 0 || tgid <= 0)
+		return -EINVAL;
+
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_TKILL;
+	info.si_pid = current->pid;
+	info.si_uid = current->uid;
+
+	read_lock(&tasklist_lock);
+	p = find_task_by_pid(pid);
+	error = -ESRCH;
+	if (p && (p->tgid == tgid)) {
+		error = check_kill_permission(sig, &info, p);
+		/*
+		 * The null signal is a permissions and process existence
+		 * probe.  No signal is actually delivered.
+		 */
+		if (!error && sig && p->sighand) {
+			spin_lock_irq(&p->sighand->siglock);
+			handle_stop_signal(sig, p);
+			error = specific_send_sig_info(sig, &info, p);
+			spin_unlock_irq(&p->sighand->siglock);
+		}
+	}
+	read_unlock(&tasklist_lock);
+	return error;
+}
+
 /*
  *  Send a signal to only one task, even if it's a CLONE_THREAD task.
  */

