Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbUKCQUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUKCQUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 11:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUKCQUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 11:20:16 -0500
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:52876
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S261675AbUKCQUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 11:20:03 -0500
Subject: [patch 1/1] uml: fix ptrace() hang on 2.6.9 host due to host changes
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, cw@f00f.org,
       blaisorblade_spam@yahoo.it, kraxel@bytesex.org
From: blaisorblade_spam@yahoo.it
Date: Wed, 03 Nov 2004 17:06:19 +0100
Message-Id: <20041103160621.0707356742@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Gerd Knorr <kraxel@bytesex.org>, Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>

Uml was using kill(pid, SIGKILL) instead of ptrace(PTRACE_KILL, pid), which
used to work, while being probably undocumented. Due to the changes in 2.6.9
to the ptrace(2) semantics, with the introduction of TASK_TRACED by Roland
McGrath, this does not more work, so this patch should fix it.

With help of Gerd Knorr report and analysis, and its early fix of this
problem. He fixed the problem by sending SIGCONT to the child processes after
SIGKILL. Which IMHO should not be needed (I think this is a regression, which
he already reported).

I improved his one, by replacing the SIGCONT hack with using PTRACE_KILL
instead.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/um/include/os.h             |    1 +
 vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process.c    |    2 +-
 vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/process_kern.c |    2 +-
 vanilla-linux-2.6.9-paolo/arch/um/os-Linux/process.c       |    8 ++++++++
 4 files changed, 11 insertions(+), 2 deletions(-)

diff -puN arch/um/include/os.h~uml-hang-on-2.6.9-host arch/um/include/os.h
--- vanilla-linux-2.6.9/arch/um/include/os.h~uml-hang-on-2.6.9-host	2004-10-31 23:46:12.232616920 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/include/os.h	2004-10-31 23:46:12.237616160 +0100
@@ -157,6 +157,7 @@ extern unsigned long os_process_pc(int p
 extern int os_process_parent(int pid);
 extern void os_stop_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
+extern void os_kill_ptraced_process(int pid, int reap_child);
 extern void os_usr1_process(int pid);
 extern int os_getpid(void);
 
diff -puN arch/um/os-Linux/process.c~uml-hang-on-2.6.9-host arch/um/os-Linux/process.c
--- vanilla-linux-2.6.9/arch/um/os-Linux/process.c~uml-hang-on-2.6.9-host	2004-10-31 23:46:12.233616768 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/os-Linux/process.c	2004-10-31 23:52:07.401623024 +0100
@@ -8,6 +8,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <linux/unistd.h>
+#include <sys/ptrace.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include "os.h"
@@ -94,6 +95,13 @@ void os_kill_process(int pid, int reap_c
 		
 }
 
+void os_kill_ptraced_process(int pid, int reap_child)
+{
+	ptrace(PTRACE_KILL, pid);
+	if(reap_child)
+		CATCH_EINTR(waitpid(pid, NULL, 0));
+}
+
 void os_usr1_process(int pid)
 {
 	kill(pid, SIGUSR1);
diff -puN arch/um/kernel/skas/process.c~uml-hang-on-2.6.9-host arch/um/kernel/skas/process.c
--- vanilla-linux-2.6.9/arch/um/kernel/skas/process.c~uml-hang-on-2.6.9-host	2004-10-31 23:46:12.234616616 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/skas/process.c	2004-10-31 23:51:43.532251720 +0100
@@ -389,7 +389,7 @@ void switch_mm_skas(int mm_fd)
 void kill_off_processes_skas(void)
 {
 #warning need to loop over userspace_pids in kill_off_processes_skas
-	os_kill_process(userspace_pid[0], 1);
+	os_kill_ptraced_process(userspace_pid[0], 1);
 }
 
 void init_registers(int pid)
diff -puN arch/um/kernel/tt/process_kern.c~uml-hang-on-2.6.9-host arch/um/kernel/tt/process_kern.c
--- vanilla-linux-2.6.9/arch/um/kernel/tt/process_kern.c~uml-hang-on-2.6.9-host	2004-10-31 23:46:12.235616464 +0100
+++ vanilla-linux-2.6.9-paolo/arch/um/kernel/tt/process_kern.c	2004-10-31 23:46:12.238616008 +0100
@@ -82,7 +82,7 @@ void *switch_to_tt(void *prev, void *nex
 	prev_sched = current->thread.prev_sched;
	if((prev_sched->exit_state == EXIT_ZOMBIE) ||
	   (prev_sched->exit_state == EXIT_DEAD))
-		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
+		os_kill_ptraced_process(prev_sched->thread.mode.tt.extern_pid, 1);
 
 	/* This works around a nasty race with 'jail'.  If we are switching
 	 * between two threads of a threaded app and the incoming process 
_
