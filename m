Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUING1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUING1r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269147AbUINGZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:25:30 -0400
Received: from [12.177.129.25] ([12.177.129.25]:29379 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S269156AbUINGXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:23:53 -0400
Message-Id: <200409140727.i8E7RfL7005648@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] UML - Finish conversion to sigjmp_buf/siglongjmp
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Sep 2004 03:27:41 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

UML needs to use siglongjmp instead of longjmp everywhere.  This patch fixes
the remaining longjmp/jmp_buf occurrences.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9-rc2/arch/um/kernel/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/process.c	2004-09-14 02:03:57.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/process.c	2004-09-14 02:03:59.000000000 -0400
@@ -297,7 +297,7 @@
 
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
 {
-	jmp_buf buf;
+	sigjmp_buf buf;
 	int n;
 
 	*jmp_ptr = &buf;
Index: 2.6.9-rc2/arch/um/kernel/skas/process.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/skas/process.c	2004-09-14 02:03:52.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/skas/process.c	2004-09-14 02:03:59.000000000 -0400
@@ -209,7 +209,7 @@
 		void (*handler)(int))
 {
 	unsigned long flags;
-	jmp_buf switch_buf, fork_buf;
+	sigjmp_buf switch_buf, fork_buf;
 
 	*switch_buf_ptr = &switch_buf;
 	*fork_buf_ptr = &fork_buf;
@@ -233,7 +233,7 @@
 
 void thread_wait(void *sw, void *fb)
 {
-	jmp_buf buf, **switch_buf = sw, *fork_buf;
+	sigjmp_buf buf, **switch_buf = sw, *fork_buf;
 
 	*switch_buf = &buf;
 	fork_buf = fb;
@@ -295,23 +295,23 @@
 
 void switch_threads(void *me, void *next)
 {
-	jmp_buf my_buf, **me_ptr = me, *next_buf = next;
+	sigjmp_buf my_buf, **me_ptr = me, *next_buf = next;
 	
 	*me_ptr = &my_buf;
 	if(sigsetjmp(my_buf, 1) == 0)
 		siglongjmp(*next_buf, 1);
 }
 
-static jmp_buf initial_jmpbuf;
+static sigjmp_buf initial_jmpbuf;
 
 /* XXX Make these percpu */
 static void (*cb_proc)(void *arg);
 static void *cb_arg;
-static jmp_buf *cb_back;
+static sigjmp_buf *cb_back;
 
 int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
 {
-	jmp_buf **switch_buf = switch_buf_ptr;
+	sigjmp_buf **switch_buf = switch_buf_ptr;
 	int n;
 
 	*fork_buf_ptr = &initial_jmpbuf;
@@ -347,7 +347,7 @@
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 {
-	jmp_buf here;
+	sigjmp_buf here;
 
 	cb_proc = proc;
 	cb_arg = arg;
Index: 2.6.9-rc2/arch/um/kernel/trap_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/trap_user.c	2004-09-14 02:03:52.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/trap_user.c	2004-09-14 02:03:59.000000000 -0400
@@ -127,7 +127,7 @@
 
 void do_longjmp(void *b, int val)
 {
-	jmp_buf *buf = b;
+	sigjmp_buf *buf = b;
 
 	siglongjmp(*buf, val);
 }
Index: 2.6.9-rc2/arch/um/kernel/tt/uaccess_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/tt/uaccess_user.c	2004-09-14 02:03:52.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/tt/uaccess_user.c	2004-09-14 02:03:59.000000000 -0400
@@ -72,7 +72,7 @@
 	struct tt_regs save = TASK_REGS(get_current())->tt;
 	int ret;
 	unsigned long *faddrp = (unsigned long *)fault_addr;
-	jmp_buf jbuf;
+	sigjmp_buf jbuf;
 
 	*fault_catcher = &jbuf;
 	if(sigsetjmp(jbuf, 1) == 0)
Index: 2.6.9-rc2/arch/um/kernel/uaccess_user.c
===================================================================
--- 2.6.9-rc2.orig/arch/um/kernel/uaccess_user.c	2004-09-14 02:03:52.000000000 -0400
+++ 2.6.9-rc2/arch/um/kernel/uaccess_user.c	2004-09-14 02:03:59.000000000 -0400
@@ -17,8 +17,8 @@
 					int n), int *faulted_out)
 {
 	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
+	sigjmp_buf jbuf;
 
-	jmp_buf jbuf;
 	*fault_catcher = &jbuf;
 	if(sigsetjmp(jbuf, 1) == 0){
 		(*op)(to, from, n);
More recent patches modify files in sigjmp.

