Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267749AbUHJW2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267749AbUHJW2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHJW2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:28:54 -0400
Received: from holomorphy.com ([207.189.100.168]:53996 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267749AbUHJW2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:28:51 -0400
Date: Tue, 10 Aug 2004 15:28:40 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Picco <Robert.Picco@hp.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-ID: <20040810222840.GA11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Picco <Robert.Picco@hp.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100937.47451.jbarnes@engr.sgi.com> <20040810212033.GY11200@holomorphy.com> <41194EA5.80706@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41194EA5.80706@hp.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 06:39:33PM -0400, Robert Picco wrote:
> copy_thread expects a switch_stack below pt_regs  on the stack.  the 
> switch_stack would have the parent's bspstore value for computing how 
> much register backing store to copy into child.  there isn't a 
> switch_stack and the resultant bspstore size computed is enormous 
> (depends on what there is on stack).  i suspect printk has changed stack 
> and the code layout changed too.

Please, let's do this instead:

Index: mm1-2.6.8-rc4/arch/ia64/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc4.orig/arch/ia64/kernel/smpboot.c	2004-08-10 15:21:56.215915699 -0700
+++ mm1-2.6.8-rc4/arch/ia64/kernel/smpboot.c	2004-08-10 15:22:39.504001106 -0700
@@ -367,7 +367,7 @@
 {
 	struct create_idle *c_idle = _c_idle;
 
-	c_idle->idle = fork_idle(c_idle->cpu);
+	c_idle->idle = __fork_idle(c_idle->cpu, NULL);
 	complete(&c_idle->done);
 }
 
Index: mm1-2.6.8-rc4/include/linux/sched.h
===================================================================
--- mm1-2.6.8-rc4.orig/include/linux/sched.h	2004-08-10 15:21:56.215915699 -0700
+++ mm1-2.6.8-rc4/include/linux/sched.h	2004-08-10 15:26:26.673920198 -0700
@@ -831,7 +831,8 @@
 
 extern int do_execve(char *, char __user * __user *, char __user * __user *, struct pt_regs *);
 extern long do_fork(unsigned long, unsigned long, struct pt_regs *, unsigned long, int __user *, int __user *);
-task_t *fork_idle(int);
+task_t *__fork_idle(int, struct pt_regs *);
+task_t *fork_idle(intcpu);
 
 extern void set_task_comm(struct task_struct *tsk, char *from);
 extern void get_task_comm(char *to, struct task_struct *tsk);
Index: mm1-2.6.8-rc4/kernel/fork.c
===================================================================
--- mm1-2.6.8-rc4.orig/kernel/fork.c	2004-08-10 15:21:56.200290699 -0700
+++ mm1-2.6.8-rc4/kernel/fork.c	2004-08-10 15:26:59.940521353 -0700
@@ -1192,11 +1192,15 @@
 
 task_t * __init fork_idle(int cpu)
 {
-	task_t *task;
 	struct pt_regs regs;
 
 	memset(&regs, 0, sizeof(struct pt_regs));
-	task = copy_process(CLONE_VM, 0, &regs, 0, NULL, NULL, 0);
+	return __fork_idle(cpu, &regs);
+}
+
+task_t * __init __fork_idle(int cpu, struct pt_regs *regs)
+{
+	task_t *task = copy_process(CLONE_VM, 0, regs, 0, NULL, NULL, 0);
 	if (!task)
 		return ERR_PTR(-ENOMEM);
 	init_idle(task, cpu);
