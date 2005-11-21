Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbVKUWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbVKUWne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVKUWnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:43:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:62642 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751203AbVKUWn1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:43:27 -0500
Subject: [PATCH] kprobes: Fix return probes on sys_execve
From: Jim Keniston <jkenisto@us.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Cc: SystemTAP <systemtap@sources.redhat.com>
Content-Type: multipart/mixed; boundary="=-u4o3AggpwignT1Ve6RMh"
Organization: 
Message-Id: <1132613005.3140.6.camel@dyn9047018079.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Nov 2005 14:43:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u4o3AggpwignT1Ve6RMh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch against 2.6.15-rc2 fixes a bug in kprobes that can cause
an Oops or even a crash when a return probe is installed on one
of the following functions: sys_execve, do_execve, load_*_binary,
flush_old_exec, or flush_thread.  The fix is to remove the call to
kprobe_flush_task() in flush_thread().  This fix has been tested on all
architectures for which the return-probes feature has been implemented
(i386, x86_64, ppc64, ia64).  Please apply.

BACKGROUND
Up to now, we have called kprobe_flush_task() under two situations:
when a task exits, and when it execs.  Flushing kretprobe_instances on
exit is correct because (a) do_exit() doesn't return, and (b) one or
more return-probed functions may be active when a task calls do_exit().
Neither is the case for sys_execve() and its callees.

Initially, the mistaken call to kprobe_flush_task() on exec was
harmless because we put the "real" return address of each active
probed function back in the stack, just to be safe, when we recycled
its kretprobe_instance.  When support for ppc64 and ia64 was added,
this safety measure couldn't be employed, and was eventually dropped
even for i386 and x86_64.  sys_execve() and its callees were informally
blacklisted for return probes until this fix was developed.

Acked-by: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Signed-off-by: Jim Keniston <jkenisto@us.ibm.com>



--=-u4o3AggpwignT1Ve6RMh
Content-Disposition: attachment; filename=kretprobes-exec.patch
Content-Type: text/plain; name=kretprobes-exec.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit


This patch fixes a bug in kprobes that can cause an Oops or even
a crash when a return probe is installed on one of the following
functions: sys_execve, do_execve, load_*_binary, flush_old_exec, or
flush_thread.  The fix is to remove the call to kprobe_flush_task()
in flush_thread().

---

 arch/i386/kernel/process.c    |    7 -------
 arch/ia64/kernel/process.c    |    7 -------
 arch/powerpc/kernel/process.c |    1 -
 arch/x86_64/kernel/process.c  |    7 -------
 4 files changed, 22 deletions(-)

diff -puN arch/i386/kernel/process.c~kretprobes-exec arch/i386/kernel/process.c
--- linux-2.6.15-rc2/arch/i386/kernel/process.c~kretprobes-exec	2005-11-21 13:32:59.000000000 -0800
+++ linux-2.6.15-rc2-jimk/arch/i386/kernel/process.c	2005-11-21 13:33:25.000000000 -0800
@@ -393,13 +393,6 @@ void flush_thread(void)
 {
 	struct task_struct *tsk = current;
 
-	/*
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(tsk);
-
 	memset(tsk->thread.debugreg, 0, sizeof(unsigned long)*8);
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));	
 	/*
diff -puN arch/ia64/kernel/process.c~kretprobes-exec arch/ia64/kernel/process.c
--- linux-2.6.15-rc2/arch/ia64/kernel/process.c~kretprobes-exec	2005-11-21 13:32:59.000000000 -0800
+++ linux-2.6.15-rc2-jimk/arch/ia64/kernel/process.c	2005-11-21 13:33:25.000000000 -0800
@@ -718,13 +718,6 @@ kernel_thread_helper (int (*fn)(void *),
 void
 flush_thread (void)
 {
-	/*
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(current);
-
 	/* drop floating-point and debug-register state if it exists: */
 	current->thread.flags &= ~(IA64_THREAD_FPH_VALID | IA64_THREAD_DBG_VALID);
 	ia64_drop_fpu(current);
diff -puN arch/powerpc/kernel/process.c~kretprobes-exec arch/powerpc/kernel/process.c
--- linux-2.6.15-rc2/arch/powerpc/kernel/process.c~kretprobes-exec	2005-11-21 13:32:59.000000000 -0800
+++ linux-2.6.15-rc2-jimk/arch/powerpc/kernel/process.c	2005-11-21 13:33:25.000000000 -0800
@@ -457,7 +457,6 @@ void flush_thread(void)
 	if (t->flags & _TIF_ABI_PENDING)
 		t->flags ^= (_TIF_ABI_PENDING | _TIF_32BIT);
 #endif
-	kprobe_flush_task(current);
 
 #ifndef CONFIG_SMP
 	if (last_task_used_math == current)
diff -puN arch/x86_64/kernel/process.c~kretprobes-exec arch/x86_64/kernel/process.c
--- linux-2.6.15-rc2/arch/x86_64/kernel/process.c~kretprobes-exec	2005-11-21 13:32:59.000000000 -0800
+++ linux-2.6.15-rc2-jimk/arch/x86_64/kernel/process.c	2005-11-21 13:33:25.000000000 -0800
@@ -351,13 +351,6 @@ void flush_thread(void)
 	struct task_struct *tsk = current;
 	struct thread_info *t = current_thread_info();
 
-	/*
-	 * Remove function-return probe instances associated with this task
-	 * and put them back on the free list. Do not insert an exit probe for
-	 * this function, it will be disabled by kprobe_flush_task if you do.
-	 */
-	kprobe_flush_task(tsk);
-
 	if (t->flags & _TIF_ABI_PENDING)
 		t->flags ^= (_TIF_ABI_PENDING | _TIF_IA32);
 
_

--=-u4o3AggpwignT1Ve6RMh--

