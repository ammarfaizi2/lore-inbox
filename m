Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932748AbWBURRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932748AbWBURRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWBURR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:17:27 -0500
Received: from [151.97.230.9] ([151.97.230.9]:4062 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932753AbWBURRW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:17:22 -0500
X-Antivirus-MYDOMAIN-Mail-From: blaisorblade@yahoo.it via ssc.unict.it
X-Antivirus-MYDOMAIN: 1.25-st-qms (Clear:RC:1(151.97.230.9):. Processed in 0.166563 secs Process 16089)
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 2/6] uml: fix usage of kernel_errno in place of errno
Date: Tue, 21 Feb 2006 18:16:22 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060221171622.509.200.stgit@zion.home.lan>
In-Reply-To: <20060221171535.509.28286.stgit@zion.home.lan>
References: <20060221171535.509.28286.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

To avoid conflicts, in kernel files errno is expanded to kernel_errno, to
distinguish it from glibc errno. In this case, the code wants to use the libc
errno but the kernel one is used; in the other usage, we return errno in place
of -errno in case of an error.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/include/os.h       |    3 +++
 arch/um/os-Linux/process.c |   15 +++++++++++++++
 arch/um/sys-i386/ldt.c     |    9 +++------
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index eb1710b..2a1c64d 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -179,8 +179,11 @@ extern void os_stop_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
 extern void os_usr1_process(int pid);
+extern long os_ptrace_ldt(long pid, long addr, long data);
+
 extern int os_getpid(void);
 extern int os_getpgrp(void);
+
 extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
 extern void init_new_thread_signals(int altstack);
 extern int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr);
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 7f5e2da..49434a7 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -19,6 +19,7 @@
 #include "irq_user.h"
 #include "kern_util.h"
 #include "longjmp.h"
+#include "skas_ptrace.h"
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -100,6 +101,20 @@ void os_kill_process(int pid, int reap_c
 		
 }
 
+/* This is here uniquely to have access to the userspace errno, i.e. the one
+ * used by ptrace in case of error.
+ */
+
+long os_ptrace_ldt(long pid, long addr, long data) {
+	int ret;
+
+	ret = ptrace(PTRACE_LDT, pid, addr, data);
+
+	if (ret < 0)
+		return -errno;
+	return ret;
+}
+
 /* Kill off a ptraced child by all means available.  kill it normally first,
  * then PTRACE_KILL it, then PTRACE_CONT it in case it's in a run state from
  * which it can't exit directly.
diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
index 1fa09a7..fe0877b 100644
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -107,7 +107,7 @@ long write_ldt_entry(struct mm_id * mm_i
 		 * So we need to switch child's mm into our userspace, then
 		 * later switch back.
 		 *
-		 * Note: I'm unshure: should interrupts be disabled here?
+		 * Note: I'm unsure: should interrupts be disabled here?
 		 */
 		if(!current->active_mm || current->active_mm == &init_mm ||
 		   mm_idp != &current->active_mm->context.skas.id)
@@ -129,9 +129,7 @@ long write_ldt_entry(struct mm_id * mm_i
 			pid = userspace_pid[cpu];
 		}
 
-		res = ptrace(PTRACE_LDT, pid, 0, (unsigned long) &ldt_op);
-		if(res)
-			res = errno;
+		res = os_ptrace_ldt(pid, 0, (unsigned long) &ldt_op);
 
 		if(proc_mm)
 			put_cpu();
@@ -181,8 +179,7 @@ static long read_ldt_from_host(void __us
 	 */
 
 	cpu = get_cpu();
-	res = ptrace(PTRACE_LDT, userspace_pid[cpu], 0,
-		     (unsigned long) &ptrace_ldt);
+	res = os_ptrace_ldt(userspace_pid[cpu], 0, (unsigned long) &ptrace_ldt);
 	put_cpu();
 	if(res < 0)
 		goto out;

