Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262367AbVAUMsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbVAUMsH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262357AbVAUMsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:48:05 -0500
Received: from mx1.elte.hu ([157.181.1.137]:27531 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262355AbVAUMr3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:47:29 -0500
Date: Fri, 21 Jan 2005 13:47:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121124701.GA5179@elte.hu>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121120325.GA2934@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> > This is the seccomp patch ported to 2.6.11-rc1-bk8, that I need for
> > Cpushare (until trusted computing will hit the hardware market). 
> > [...]
> 
> why do you need any kernel code for this? This seems to be a limited
> ptrace implementation: restricting untrusted userspace code to only be
> able to exec read/write/sigreturn.
> 
> So this patch, unless i'm missing something, duplicates in essence what
> ptrace can do [...]

there's one thing ptrace wont do: if the ptrace parent dies unexpectedly
and the child was 'running' (there is a small window where the child
might not be stopped and where this may happen) then the child can get
runaway. While i think this is theoretical (UML doesnt suffer from this
problem), it is simple to fix - find below a proof-of-concept patch that
introduces PTRACE_ATTACH_JAIL - ptraced children can never escape out of
such a jail. (barely tested - but you get the idea.)

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- kernel/ptrace.c.orig
+++ kernel/ptrace.c
@@ -49,10 +49,20 @@ void ptrace_untrace(task_t *child)
 {
 	spin_lock(&child->sighand->siglock);
 	if (child->state == TASK_TRACED) {
-		if (child->signal->flags & SIGNAL_STOP_STOPPED) {
+		/*
+		 * Child must be killed if parent dies unexpectedly:
+		 */
+		if (child->signal->flags & SIGNAL_PTRACE_ONLY) {
 			child->state = TASK_STOPPED;
-		} else {
+			spin_unlock(&child->sighand->siglock);
+			force_sig_specific(SIGKILL, child);
 			signal_wake_up(child, 1);
+		} else {
+			if (child->signal->flags & SIGNAL_STOP_STOPPED) {
+				child->state = TASK_STOPPED;
+			} else {
+				signal_wake_up(child, 1);
+			}
 		}
 	}
 	spin_unlock(&child->sighand->siglock);
@@ -117,7 +127,7 @@ int ptrace_check_attach(struct task_stru
 	return ret;
 }
 
-int ptrace_attach(struct task_struct *task)
+static int __ptrace_attach(struct task_struct *task, int jail)
 {
 	int retval;
 	task_lock(task);
@@ -154,8 +164,12 @@ int ptrace_attach(struct task_struct *ta
 
 	write_lock_irq(&tasklist_lock);
 	__ptrace_link(task, current);
+	if (jail) {
+		spin_lock(&task->sighand->siglock);
+		task->signal->flags |= SIGNAL_PTRACE_ONLY;
+		spin_unlock(&task->sighand->siglock);
+	}
 	write_unlock_irq(&tasklist_lock);
-
 	force_sig_specific(SIGSTOP, task);
 	return 0;
 
@@ -164,6 +178,16 @@ bad:
 	return retval;
 }
 
+int ptrace_attach(struct task_struct *task)
+{
+	return __ptrace_attach(task, 0);
+}
+
+int ptrace_attach_jail(struct task_struct *task)
+{
+	return __ptrace_attach(task, 1);
+}
+
 int ptrace_detach(struct task_struct *child, unsigned int data)
 {
 	if ((unsigned long) data > _NSIG)
--- arch/i386/kernel/ptrace.c.orig
+++ arch/i386/kernel/ptrace.c
@@ -388,6 +388,10 @@ asmlinkage int sys_ptrace(long request, 
 		ret = ptrace_attach(child);
 		goto out_tsk;
 	}
+	if (request == PTRACE_ATTACH_JAIL) {
+		ret = ptrace_attach_jail(child);
+		goto out_tsk;
+	}
 
 	ret = ptrace_check_attach(child, request == PTRACE_KILL);
 	if (ret < 0)
--- include/linux/ptrace.h.orig
+++ include/linux/ptrace.h
@@ -18,6 +18,7 @@
 
 #define PTRACE_ATTACH		0x10
 #define PTRACE_DETACH		0x11
+#define PTRACE_ATTACH_JAIL	0x12
 
 #define PTRACE_SYSCALL		  24
 
@@ -79,6 +80,7 @@
 extern int ptrace_readdata(struct task_struct *tsk, unsigned long src, char __user *dst, int len);
 extern int ptrace_writedata(struct task_struct *tsk, char __user *src, unsigned long dst, int len);
 extern int ptrace_attach(struct task_struct *tsk);
+extern int ptrace_attach_jail(struct task_struct *tsk);
 extern int ptrace_detach(struct task_struct *, unsigned int);
 extern void ptrace_disable(struct task_struct *);
 extern int ptrace_check_attach(struct task_struct *task, int kill);
--- include/linux/sched.h.orig
+++ include/linux/sched.h
@@ -338,6 +338,7 @@ struct signal_struct {
 #define SIGNAL_STOP_DEQUEUED	0x00000002 /* stop signal dequeued */
 #define SIGNAL_STOP_CONTINUED	0x00000004 /* SIGCONT since WCONTINUED reap */
 #define SIGNAL_GROUP_EXIT	0x00000008 /* group exit in progress */
+#define SIGNAL_PTRACE_ONLY	0x00000010 /* kill on ptrace parent death */
 
 
 /*
