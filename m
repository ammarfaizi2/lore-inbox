Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbULCUDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbULCUDg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbULCTwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:52:03 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:20484
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262477AbULCT30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:29:26 -0500
Message-Id: <200412032145.iB3LjQZW004710@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - SYSEMU fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:45:26 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Usage of SYSEMU in TT mode is modified, so that always the
same method is used in do_syscall as has been used before in
ptrace(PTRACE_SYSCALL/SYSEMU, ...)

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/tt/include/tt.h
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/include/tt.h	2004-12-01 23:47:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/include/tt.h	2004-12-01 23:53:37.000000000 -0500
@@ -26,7 +26,7 @@
 extern int is_tracing(void *task);
 extern void syscall_handler(int sig, union uml_pt_regs *regs);
 extern void exit_kernel(int pid, void *task);
-extern int do_syscall(void *task, int pid, int local_using_sysemu);
+extern void do_syscall(void *task, int pid, int local_using_sysemu);
 extern void do_sigtrap(void *task);
 extern int is_valid_pid(int pid);
 extern void remap_data(void *segment_start, void *segment_end, int w);
Index: 2.6.9/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/syscall_user.c	2004-12-01 23:47:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/syscall_user.c	2004-12-01 23:53:37.000000000 -0500
@@ -48,7 +48,7 @@
 	UPT_SYSCALL_NR(TASK_REGS(task)) = -1;
 }
 
-int do_syscall(void *task, int pid, int local_using_sysemu)
+void do_syscall(void *task, int pid, int local_using_sysemu)
 {
 	unsigned long proc_regs[FRAME_SIZE];
 
@@ -62,14 +62,11 @@
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
 		tracer_panic("I'm tracing myself and I can't get out");
 
-	if(local_using_sysemu)
-		return(1);
-
+	/* syscall number -1 in sysemu skips syscall restarting in host */
 	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, 
-		  __NR_getpid) < 0)
+		  local_using_sysemu ? -1 : __NR_getpid) < 0)
 		tracer_panic("do_syscall : Nullifying syscall failed, "
 			     "errno = %d", errno);
-	return(1);
 }
 
 /*
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-12-01 23:51:02.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-12-01 23:53:37.000000000 -0500
@@ -186,7 +186,7 @@
 	unsigned long eip = 0;
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
 	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
-	int pt_syscall_parm, local_using_sysemu;
+	int pt_syscall_parm, local_using_sysemu = 0;
 
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
@@ -307,9 +307,6 @@
 			if ( tracing )
 				do_sigtrap(task);
 
-			local_using_sysemu = get_using_sysemu();
-			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
-
 			switch(sig){
 			case SIGUSR1:
 				sig = 0;
@@ -393,6 +390,9 @@
 				continue;
 			}
 
+			local_using_sysemu = get_using_sysemu();
+			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
+
 			if(tracing){
 				if(singlestepping(task))
 					cont_type = PTRACE_SINGLESTEP;

