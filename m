Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262495AbULCTdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262495AbULCTdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbULCTcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:32:52 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:25604
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262487AbULCTaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:30:02 -0500
Message-Id: <200412032146.iB3Lk3ZW004730@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - use SYSEMU_SINGLESTEP
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:46:03 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This implements using the new ptrace option SYSEMU_SINGLESTEP in UML
(advanced sysemu) in SKAS and TT modes.
To have a fast selection of the appropriate ptrace option to use next,
a 2 dimensional arry is used and singlestepping() is modified to return
0,1 or 2:
    0 = don't do singlestepping
    1 = singlestep a syscall
    2 = singlestep a "non syscall" instruction

In do_syscall() writing of the syscall number is supressed, if the
advanced sysemu is in use (that does it itself).

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/ptrace_user.h
===================================================================
--- 2.6.9.orig/arch/um/include/ptrace_user.h	2004-12-01 23:54:59.000000000 -0500
+++ 2.6.9/arch/um/include/ptrace_user.h	2004-12-01 23:55:20.000000000 -0500
@@ -29,4 +29,11 @@
 int get_using_sysemu(void);
 extern int sysemu_supported;
 
+#define SELECT_PTRACE_OPERATION(sysemu_mode, singlestep_mode) \
+	(((int[3][3] ) { \
+		{ PTRACE_SYSCALL, PTRACE_SYSCALL, PTRACE_SINGLESTEP }, \
+		{ PTRACE_SYSEMU, PTRACE_SYSEMU, PTRACE_SINGLESTEP }, \
+		{ PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP, PTRACE_SYSEMU_SINGLESTEP }}) \
+		[sysemu_mode][singlestep_mode])
+
 #endif
Index: 2.6.9/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/process_kern.c	2004-12-01 23:54:59.000000000 -0500
+++ 2.6.9/arch/um/kernel/process_kern.c	2004-12-01 23:55:20.000000000 -0500
@@ -464,9 +464,9 @@
 		return(0);
 
 	if (task->thread.singlestep_syscall)
-		return(0);
+		return(1);
 
-	return 1;
+	return 2;
 }
 
 /*
Index: 2.6.9/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/process.c	2004-12-01 23:51:51.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/process.c	2004-12-01 23:56:25.000000000 -0500
@@ -140,15 +140,15 @@
 
 void userspace(union uml_pt_regs *regs)
 {
-	int err, status, op, pt_syscall_parm, pid = userspace_pid[0];
+	int err, status, op, pid = userspace_pid[0];
 	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
 
 	restore_registers(regs);
 		
 	local_using_sysemu = get_using_sysemu();
 
-	pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
-	err = ptrace(pt_syscall_parm, pid, 0, 0);
+	op = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
+	err = ptrace(op, pid, 0, 0);
 
 	if(err)
 		panic("userspace - PTRACE_%s failed, errno = %d\n",
@@ -196,10 +196,8 @@
 
 		/*Now we ended the syscall, so re-read local_using_sysemu.*/
 		local_using_sysemu = get_using_sysemu();
-		pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
 
-		op = singlestepping(NULL) ? PTRACE_SINGLESTEP :
-			pt_syscall_parm;
+		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
 
 		err = ptrace(op, pid, 0, 0);
 		if(err)
Index: 2.6.9/arch/um/kernel/tt/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/syscall_user.c	2004-12-01 23:53:37.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/syscall_user.c	2004-12-01 23:55:20.000000000 -0500
@@ -62,6 +62,10 @@
 	   ((unsigned long *) PT_IP(proc_regs) <= &_etext))
 		tracer_panic("I'm tracing myself and I can't get out");
 
+	/* advanced sysemu mode set syscall number to -1 automatically */
+	if (local_using_sysemu==2)
+		return;
+
 	/* syscall number -1 in sysemu skips syscall restarting in host */
 	if(ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET, 
 		  local_using_sysemu ? -1 : __NR_getpid) < 0)
Index: 2.6.9/arch/um/kernel/tt/tracer.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/tt/tracer.c	2004-12-01 23:53:37.000000000 -0500
+++ 2.6.9/arch/um/kernel/tt/tracer.c	2004-12-01 23:55:20.000000000 -0500
@@ -186,7 +186,7 @@
 	unsigned long eip = 0;
 	int status, pid = 0, sig = 0, cont_type, tracing = 0, op = 0;
 	int last_index, proc_id = 0, n, err, old_tracing = 0, strace = 0;
-	int pt_syscall_parm, local_using_sysemu = 0;
+	int local_using_sysemu = 0;
 
 	signal(SIGPIPE, SIG_IGN);
 	setup_tracer_winch();
@@ -391,18 +391,14 @@
 			}
 
 			local_using_sysemu = get_using_sysemu();
-			pt_syscall_parm = local_using_sysemu ? PTRACE_SYSEMU : PTRACE_SYSCALL;
 
-			if(tracing){
-				if(singlestepping(task))
-					cont_type = PTRACE_SINGLESTEP;
-				else cont_type = pt_syscall_parm;
-			}
-			else cont_type = PTRACE_CONT;
-
-			if((cont_type == PTRACE_CONT) && 
-			   (debugger_pid != -1) && strace)
+			if(tracing)
+				cont_type = SELECT_PTRACE_OPERATION(local_using_sysemu,
+				                                    singlestepping(task));
+			else if((debugger_pid != -1) && strace)
 				cont_type = PTRACE_SYSCALL;
+			else
+				cont_type = PTRACE_CONT;
 
 			if(ptrace(cont_type, pid, 0, sig) != 0){
 				tracer_panic("ptrace failed to continue "

