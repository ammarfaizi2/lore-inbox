Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbULCTum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbULCTum (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:50:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbULCT3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:29:43 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:10244
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262468AbULCT1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:27:11 -0500
Message-Id: <200412032143.iB3LhEZW004668@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: [PATCH] UML - kill host processes properly
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:43:14 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes how UML kills ptraced processes in order to be more 
correct in the presence of the ptrace changes in 2.6.9.  It used to be that
ptrace stopped processes could simply be killed and they would go away.  Now,
there's a new run state for ptraced processes which doesn't receive signals
until they are PTRACE_KILLed or PTRACE_CONTinued.  So, this patch kills the
process, as usual, then PTRACE_KILL and PTRACE_CONT.  This is done in
os_kill_ptrace_process() for use from skas mode, and in tracer() when it
sees a child process getting a SIGKILL.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/tt/exec_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/exec_user.c	2004-12-03 12:42:17.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/exec_user.c	2004-12-03 12:44:56.000000000 -0500
@@ -16,6 +16,7 @@
 #include "kern_util.h"
 #include "user.h"
 #include "ptrace_user.h"
+#include "os.h"
 
 void do_exec(int old_pid, int new_pid)
 {
@@ -36,7 +37,7 @@
 		tracer_panic("do_exec failed to get registers - errno = %d",
 			     errno);
 
-	kill(old_pid, SIGKILL);
+	os_kill_ptraced_process(old_pid, 0);
 
 	if (ptrace(PTRACE_SETOPTIONS, new_pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
 		tracer_panic("do_exec: PTRACE_SETOPTIONS failed, errno = %d", errno);
Index: 2.6.9/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/process_kern.c	2004-12-03 12:42:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/process_kern.c	2004-12-03 12:42:17.000000000 -0500
@@ -65,7 +65,8 @@
 		panic("write of switch_pipe failed, err = %d", -err);
 
 	reading = 1;
-	if((from->exit_state == EXIT_ZOMBIE) || (from->exit_state == EXIT_DEAD))
+	if((from->exit_state == EXIT_ZOMBIE) ||
+	   (from->exit_state == EXIT_DEAD))
 		os_kill_process(os_getpid(), 0);
 
 	err = os_read_file(from->thread.mode.tt.switch_pipe[0], &c, sizeof(c));
@@ -82,7 +83,7 @@
 	prev_sched = current->thread.prev_sched;
 	if((prev_sched->exit_state == EXIT_ZOMBIE) ||
 	   (prev_sched->exit_state == EXIT_DEAD))
-		os_kill_ptraced_process(prev_sched->thread.mode.tt.extern_pid, 1);
+		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
 
 	/* This works around a nasty race with 'jail'.  If we are switching
 	 * between two threads of a threaded app and the incoming process 
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-12-03 12:42:17.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-12-03 12:44:48.000000000 -0500
@@ -319,7 +319,13 @@
 				case OP_HALT:
 					unmap_physmem();
 					kmalloc_ok = 0;
-					ptrace(PTRACE_KILL, pid, 0, 0);
+					os_kill_ptraced_process(pid, 0);
+					/* Now let's reap remaining zombies */
+					errno = 0;
+					do {
+						waitpid(-1, &status, 
+							WUNTRACED);
+					} while (errno != ECHILD);
 					return(op == OP_REBOOT);
 				case OP_NONE:
 					printf("Detaching pid %d\n", pid);
Index: 2.6.9/arch/um/os-Linux/process.c
===================================================================
--- 2.6.9.orig/arch/um/os-Linux/process.c	2004-12-03 12:42:11.000000000 -0500
+++ 2.6.9/arch/um/os-Linux/process.c	2004-12-03 12:42:17.000000000 -0500
@@ -95,9 +95,16 @@
 		
 }
 
+/* Kill off a ptraced child by all means available.  kill it normally first,
+ * then PTRACE_KILL it, then PTRACE_CONT it in case it's in a run state from
+ * which it can't exit directly.
+ */
+
 void os_kill_ptraced_process(int pid, int reap_child)
 {
+	kill(pid, SIGKILL);
 	ptrace(PTRACE_KILL, pid);
+	ptrace(PTRACE_CONT, pid);
 	if(reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, 0));
 }

