Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbVIGI3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbVIGI3h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 04:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVIGI3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 04:29:37 -0400
Received: from fmr23.intel.com ([143.183.121.15]:1427 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751116AbVIGI3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 04:29:36 -0400
Message-Id: <200509070829.j878TSg25898@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>
Subject: Prefetch kernel stacks to speed up context switch
Date: Wed, 7 Sep 2005 01:28:47 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcWzhir0Be6sCv8PScC6Z6ggYRdRcQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Repost previously discussed patch (on Jul 27, 2005). Ingo did
the same thing for all arch with 471 lines of patch.  I'm still
advocating this little 30 lines patch, of 6 lines introduces
prefetch_stack() generic interface.

Andrew, please consider -mm inclusion. Or advise me what I need
to do to take this forward.  Thanks.

- Ken


------

For architecture like ia64, the switch stack structure is fairly large
(currently 528 bytes).  For context switch intensive application, we
found that significant amount of cache misses occurs in switch_to()
function.  The following patch adds a hook in the schedule() function to
prefetch switch stack structure as soon as 'next' task is determined. 
This allows maximum overlap in prefetch cache lines for that structure.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

 arch/ia64/kernel/entry.S  |   23 +++++++++++++++++++++++
 include/asm-ia64/system.h |    1 +
 include/linux/sched.h     |    5 +++++
 kernel/sched.c            |    1 +
 4 files changed, 30 insertions(+)


--- ./arch/ia64/kernel/entry.S.orig	2005-08-09 15:32:47.778894000 -0700
+++ ./arch/ia64/kernel/entry.S	2005-08-09 16:14:17.839410590 -0700
@@ -470,6 +470,29 @@ ENTRY(load_switch_stack)
 	br.cond.sptk.many b7
 END(load_switch_stack)
 
+GLOBAL_ENTRY(prefetch_stack)
+	add r14 = -IA64_SWITCH_STACK_SIZE, sp
+	add r15 = IA64_TASK_THREAD_KSP_OFFSET, in0
+	;;
+	ld8 r16 = [r15]				// load next's stack pointer
+	lfetch.fault.excl [r14], 128
+	;;
+	lfetch.fault.excl [r14], 128
+	lfetch.fault [r16], 128
+	;;
+	lfetch.fault.excl [r14], 128
+	lfetch.fault [r16], 128
+	;;
+	lfetch.fault.excl [r14], 128
+	lfetch.fault [r16], 128
+	;;
+	lfetch.fault.excl [r14], 128
+	lfetch.fault [r16], 128
+	;;
+	lfetch.fault [r16], 128
+	br.ret.sptk.many rp
+END(prefetch_switch_stack)
+
 GLOBAL_ENTRY(execve)
 	mov r15=__NR_execve			// put syscall number in place
 	break __BREAK_SYSCALL
--- ./include/asm-ia64/system.h.orig	2005-08-09 15:32:51.100183000 -0700
+++ ./include/asm-ia64/system.h	2005-08-09 16:10:08.942929264 -0700
@@ -274,6 +274,7 @@ extern void ia64_load_extra (struct task
  */
 #define __ARCH_WANT_UNLOCKED_CTXSW
 
+#define ARCH_HAS_PREFETCH_SWITCH_STACK
 #define ia64_platform_is(x) (strcmp(x, platform_name) == 0)
 
 void cpu_idle_wait(void);
--- ./include/linux/sched.h.orig	2005-08-09 15:32:51.339441000 -0700
+++ ./include/linux/sched.h	2005-08-09 16:02:35.378481695 -0700
@@ -592,6 +592,11 @@ extern int groups_search(struct group_in
 #define GROUP_AT(gi, i) \
     ((gi)->blocks[(i)/NGROUPS_PER_BLOCK][(i)%NGROUPS_PER_BLOCK])
 
+#ifdef ARCH_HAS_PREFETCH_SWITCH_STACK
+extern void prefetch_stack(struct task_struct*);
+#else
+static inline void prefetch_stack(struct task_struct *t) { }
+#endif
 
 struct audit_context;		/* See audit.c */
 struct mempolicy;
--- ./kernel/sched.c.orig	2005-08-09 15:32:51.429284000 -0700
+++ ./kernel/sched.c	2005-08-09 16:02:51.929262743 -0700
@@ -2887,6 +2887,7 @@ switch_tasks:
 	if (next == rq->idle)
 		schedstat_inc(rq, sched_goidle);
 	prefetch(next);
+	prefetch_stack(next);
 	clear_tsk_need_resched(prev);
 	rcu_qsctr_inc(task_cpu(prev));
 



