Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUKNUyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUKNUyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 15:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261377AbUKNUxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 15:53:01 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:14340
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261372AbUKNUvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 15:51:15 -0500
Message-Id: <200411142304.iAEN4YbV013371@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH] - UML - remove some dead code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 14 Nov 2004 18:04:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo pointed out that arch/um/kernel/skas/exec_user.c is dead code, so
this removes it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/kernel/skas/Makefile
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/Makefile	2004-11-14 15:31:24.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/Makefile	2004-11-14 15:31:37.000000000 -0500
@@ -1,11 +1,11 @@
 # 
-# Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+# Copyright (C) 2002 - 2004 Jeff Dike (jdike@addtoit.com)
 # Licensed under the GPL
 #
 
-obj-y := exec_kern.o exec_user.o mem.o mem_user.o mmu.o process.o \
-	process_kern.o syscall_kern.o syscall_user.o time.o tlb.o trap_user.o \
-	uaccess.o sys-$(SUBARCH)/
+obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
+	syscall_kern.o syscall_user.o time.o tlb.o trap_user.o uaccess.o \
+	sys-$(SUBARCH)/
 
 subdir-y := util
 
Index: 2.6.9/arch/um/kernel/skas/exec_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/skas/exec_user.c	2004-11-14 15:31:24.000000000 -0500
+++ 2.6.9/arch/um/kernel/skas/exec_user.c	2003-09-15 09:40:47.000000000 -0400
@@ -1,63 +0,0 @@
-/* 
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <errno.h>
-#include <signal.h>
-#include <sched.h>
-#include <sys/wait.h>
-#include <sys/ptrace.h>
-#include "user.h"
-#include "kern_util.h"
-#include "user_util.h"
-#include "os.h"
-#include "time_user.h"
-
-static int user_thread_tramp(void *arg)
-{
-	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0)
-		panic("user_thread_tramp - PTRACE_TRACEME failed, "
-		      "errno = %d\n", errno);
-	enable_timer();
-	os_stop_process(os_getpid());
-	return(0);
-}
-
-int user_thread(unsigned long stack, int flags)
-{
-	int pid, status, err;
-
-	pid = clone(user_thread_tramp, (void *) stack_sp(stack), 
-		    flags | CLONE_FILES | SIGCHLD, NULL);
-	if(pid < 0){
-		printk("user_thread - clone failed, errno = %d\n", errno);
-		return(pid);
-	}
-
-	CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
-	if(err < 0){
-		printk("user_thread - waitpid failed, errno = %d\n", errno);
-		return(-errno);
-	}
-
-	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)){
-		printk("user_thread - trampoline didn't stop, status = %d\n", 
-		       status);
-		return(-EINVAL);
-	}
-
-	return(pid);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

