Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbULCTfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbULCTfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbULCTdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 14:33:47 -0500
Received: from pool-151-203-6-248.bos.east.verizon.net ([151.203.6.248]:24324
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262485AbULCT3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 14:29:55 -0500
Message-Id: <200412032145.iB3LjvZW004725@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, Blaisorblade <blaisorblade_spam@yahoo.it>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] UML - detect SYSEMU_SINGLESTEP
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Dec 2004 16:45:57 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This implements checking for the new ptrace option SYSEMU_SINGLESTEP
(advanced sysemu) and allows the values 0,1,2 for /proc/sysemu,
if advanced sysemu is available:
   0 = don't use sysemu
   1 = use sysemu, but don't use advanced sysemu
   2 = use sysemu and advanced sysemu

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/ptrace_user.h
===================================================================
--- 2.6.9.orig/arch/um/include/ptrace_user.h	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/arch/um/include/ptrace_user.h	2004-12-01 23:54:59.000000000 -0500
@@ -21,6 +21,9 @@
 #ifndef PTRACE_SYSEMU
 #define PTRACE_SYSEMU 31
 #endif
+#ifndef PTRACE_SYSEMU_SINGLESTEP
+#define PTRACE_SYSEMU_SINGLESTEP 32
+#endif
 
 void set_using_sysemu(int value);
 int get_using_sysemu(void);
Index: 2.6.9/arch/um/include/sysdep-i386/ptrace.h
===================================================================
--- 2.6.9.orig/arch/um/include/sysdep-i386/ptrace.h	2004-12-01 23:43:11.000000000 -0500
+++ 2.6.9/arch/um/include/sysdep-i386/ptrace.h	2004-12-01 23:54:59.000000000 -0500
@@ -15,6 +15,9 @@
 #ifdef UML_CONFIG_MODE_SKAS
 #include "ptrace-skas.h"
 #endif
+#ifndef PTRACE_SYSEMU_SINGLESTEP
+#define PTRACE_SYSEMU_SINGLESTEP 32
+#endif
 
 #include "choose-mode.h"
 
Index: 2.6.9/arch/um/kernel/process.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/process.c	2004-12-01 23:47:11.000000000 -0500
+++ 2.6.9/arch/um/kernel/process.c	2004-12-01 23:54:59.000000000 -0500
@@ -241,7 +241,7 @@
 static void __init check_sysemu(void)
 {
 	void *stack;
-	int pid, n, status;
+	int pid, syscall, n, status, count=0;
 
 	printk("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
@@ -269,12 +269,46 @@
 	sysemu_supported = 1;
 	printk("OK\n");
 	set_using_sysemu(!force_sysemu_disabled);
+
+	printk("Checking advanced syscall emulation patch for ptrace...");
+	pid = start_ptraced_child(&stack);
+	while(1){
+		count++;
+		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
+			goto fail;
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if(n < 0)
+			panic("check_ptrace : wait failed, errno = %d", errno);
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
+			      "got status = %d", status);
+
+		syscall = ptrace(PTRACE_PEEKUSER, pid, PT_SYSCALL_NR_OFFSET,
+				 0);
+		if(syscall == __NR_getpid){
+			if (!count)
+				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't singlestep");
+			n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET,
+				   os_getpid());
+			if(n < 0)
+				panic("check_sysemu : failed to modify system "
+				      "call return, errno = %d", errno);
+			break;
+		}
+	}
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+		goto fail_stopped;
+
+	sysemu_supported = 2;
+	printk("OK\n");
+
+	if ( !force_sysemu_disabled )
+		set_using_sysemu(sysemu_supported);
 	return;
 
 fail:
 	stop_ptraced_child(pid, stack, 1, 0);
 fail_stopped:
-	sysemu_supported = 0;
 	printk("missing\n");
 }
 
Index: 2.6.9/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/process_kern.c	2004-12-01 23:43:12.000000000 -0500
+++ 2.6.9/arch/um/kernel/process_kern.c	2004-12-01 23:54:59.000000000 -0500
@@ -404,7 +404,9 @@
 
 void set_using_sysemu(int value)
 {
-	atomic_set(&using_sysemu, sysemu_supported && value);
+	if (value > sysemu_supported)
+		return;
+	atomic_set(&using_sysemu, value);
 }
 
 int get_using_sysemu(void)
@@ -427,7 +429,7 @@
 	if (copy_from_user(tmp, buf, 1))
 		return -EFAULT;
 
-	if (tmp[0] == '0' || tmp[0] == '1')
+	if (tmp[0] >= '0' && tmp[0] <= '2')
 		set_using_sysemu(tmp[0] - '0');
 	return count; /*We use the first char, but pretend to write everything*/
 }

