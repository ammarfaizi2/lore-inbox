Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267807AbUHJXEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267807AbUHJXEJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 19:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUHJXEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 19:04:09 -0400
Received: from holomorphy.com ([207.189.100.168]:8685 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267807AbUHJXEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 19:04:02 -0400
Date: Tue, 10 Aug 2004 16:03:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Robert Picco <Robert.Picco@hp.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
Message-ID: <20040810230357.GE11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Robert Picco <Robert.Picco@hp.com>,
	Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100937.47451.jbarnes@engr.sgi.com> <20040810212033.GY11200@holomorphy.com> <41194EA5.80706@hp.com> <20040810222840.GA11200@holomorphy.com> <20040810223006.GB11200@holomorphy.com> <20040810224308.GC11200@holomorphy.com> <20040810224532.GD11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810224532.GD11200@holomorphy.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 03:43:08PM -0700, William Lee Irwin III wrote:
>> This still doesn't eliminate the branch in ia64's copy_thread().
>> The best solution possible would be to redo the whole affair as an
>> ia64-specific cleanup pass, and to find some initial setting of regs
>> that works for all architectures (it seems memset(&regs, 0, ...) doesn't).

On Tue, Aug 10, 2004 at 03:45:32PM -0700, William Lee Irwin III wrote:
> "whole affair" == NULL check in copy_thread(). Except this is a nop, so
> I think we're just looking for something that survives copy_thread().

I have an even better fix:

Index: mm1-2.6.8-rc4/arch/ia64/kernel/smpboot.c
===================================================================
--- mm1-2.6.8-rc4.orig/arch/ia64/kernel/smpboot.c	2004-08-10 15:32:08.000000000 -0700
+++ mm1-2.6.8-rc4/arch/ia64/kernel/smpboot.c	2004-08-10 15:55:28.902437225 -0700
@@ -356,6 +356,11 @@
 	return cpu_idle();
 }
 
+struct pt_regs * __init idle_regs(struct pt_regs *regs)
+{
+	return NULL;
+}
+
 struct create_idle {
 	struct task_struct *idle;
 	struct completion done;
Index: mm1-2.6.8-rc4/kernel/fork.c
===================================================================
--- mm1-2.6.8-rc4.orig/kernel/fork.c	2004-08-10 15:32:08.000000000 -0700
+++ mm1-2.6.8-rc4/kernel/fork.c	2004-08-10 16:01:24.383878183 -0700
@@ -1190,13 +1190,18 @@
 	goto fork_out;
 }
 
+struct pt_regs * __init __attribute__((weak)) idle_regs(struct pt_regs *regs)
+{
+	memset(regs, 0, sizeof(struct pt_regs));
+	return regs;
+}
+
 task_t * __init fork_idle(int cpu)
 {
 	task_t *task;
 	struct pt_regs regs;
 
-	memset(&regs, 0, sizeof(struct pt_regs));
-	task = copy_process(CLONE_VM, 0, &regs, 0, NULL, NULL, 0);
+	task = copy_process(CLONE_VM, 0, idle_regs(&regs), 0, NULL, NULL, 0);
 	if (!task)
 		return ERR_PTR(-ENOMEM);
 	init_idle(task, cpu);
