Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932577AbWACVHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577AbWACVHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 16:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWACVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 16:07:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:27279 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932529AbWACVHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 16:07:41 -0500
To: torvalds@osdl.org
Subject: [PATCH 07/50] amd64: task_stack_page()
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-Id: <E1EttNa-0008PQ-6k@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Tue, 03 Jan 2006 21:07:38 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

References: <20060103210515.5135@ftp.linux.org.uk>
In-Reply-To: <20060103210515.5135@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 arch/x86_64/kernel/process.c |    6 +++---
 arch/x86_64/kernel/smpboot.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

c93c0d97f1334d04b0f0ac98acc40e8b6ffc2ff1
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 08e578f..334cecc 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -423,7 +423,7 @@ int copy_thread(int nr, unsigned long cl
 	struct task_struct *me = current;
 
 	childregs = ((struct pt_regs *)
-			(THREAD_SIZE + (unsigned long) p->thread_info)) - 1;
+			(THREAD_SIZE + task_stack_page(p))) - 1;
 	*childregs = *regs;
 
 	childregs->rax = 0;
@@ -562,7 +562,7 @@ __switch_to(struct task_struct *prev_p, 
 	write_pda(oldrsp, next->userrsp); 
 	write_pda(pcurrent, next_p); 
 	write_pda(kernelstack,
-	    (unsigned long)next_p->thread_info + THREAD_SIZE - PDA_STACKOFFSET);
+		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
 
 	/*
 	 * Now maybe reload the debug registers
@@ -676,7 +676,7 @@ unsigned long get_wchan(struct task_stru
 
 	if (!p || p == current || p->state==TASK_RUNNING)
 		return 0; 
-	stack = (unsigned long)p->thread_info; 
+	stack = (unsigned long)task_stack_page(p);
 	if (p->thread.rsp < stack || p->thread.rsp > stack+THREAD_SIZE)
 		return 0;
 	fp = *(u64 *)(p->thread.rsp);
diff --git a/arch/x86_64/kernel/smpboot.c b/arch/x86_64/kernel/smpboot.c
index e92eec2..fe94a69 100644
--- a/arch/x86_64/kernel/smpboot.c
+++ b/arch/x86_64/kernel/smpboot.c
@@ -747,7 +747,7 @@ static int __cpuinit do_boot_cpu(int cpu
 
 	if (c_idle.idle) {
 		c_idle.idle->thread.rsp = (unsigned long) (((struct pt_regs *)
-			(THREAD_SIZE + (unsigned long) c_idle.idle->thread_info)) - 1);
+			(THREAD_SIZE +  task_stack_page(c_idle.idle))) - 1);
 		init_idle(c_idle.idle, cpu);
 		goto do_rest;
 	}
-- 
0.99.9.GIT

