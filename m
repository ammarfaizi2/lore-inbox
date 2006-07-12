Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWGLQjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWGLQjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbWGLQjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:39:52 -0400
Received: from [198.99.130.12] ([198.99.130.12]:4759 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751350AbWGLQjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:39:51 -0400
Message-Id: <200607121639.k6CGdrL4021226@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/5] UML - tidy longjmp macro
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 12 Jul 2006 12:39:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The UML_SETJMP macro was requiring its users to pass in a argument
which it could supply itself, since it wasn't used outside that
invocation of the macro.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/longjmp.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/longjmp.h	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/include/longjmp.h	2006-07-12 12:04:43.000000000 -0400
@@ -8,8 +8,8 @@
 	longjmp(*buf, val);	\
 } while(0)
 
-#define UML_SETJMP(buf, enable) ({ \
-	int n; \
+#define UML_SETJMP(buf) ({ \
+	int n, enable;	   \
 	enable = get_signals(); \
 	n = setjmp(*buf); \
 	if(n != 0) \
Index: linux-2.6.17/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/process.c	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/process.c	2006-07-12 12:04:43.000000000 -0400
@@ -273,12 +273,12 @@ void init_new_thread_signals(void)
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
 {
 	jmp_buf buf;
-	int n, enable;
+	int n;
 
 	*jmp_ptr = &buf;
-	n = UML_SETJMP(&buf, enable);
+	n = UML_SETJMP(&buf);
 	if(n != 0)
-		return(n);
+		return n;
 	(*fn)(arg);
-	return(0);
+	return 0;
 }
Index: linux-2.6.17/arch/um/os-Linux/uaccess.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/uaccess.c	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/uaccess.c	2006-07-12 12:04:43.000000000 -0400
@@ -14,11 +14,10 @@ unsigned long __do_user_copy(void *to, c
 					int n), int *faulted_out)
 {
 	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
-	int enable;
 
 	jmp_buf jbuf;
 	*fault_catcher = &jbuf;
-	if(UML_SETJMP(&jbuf, enable) == 0){
+	if(UML_SETJMP(&jbuf) == 0){
 		(*op)(to, from, n);
 		ret = 0;
 		*faulted_out = 0;
Index: linux-2.6.17/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/skas/process.c	2006-07-12 11:29:00.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/skas/process.c	2006-07-12 12:04:43.000000000 -0400
@@ -435,7 +435,6 @@ void new_thread(void *stack, void **swit
 {
 	unsigned long flags;
 	jmp_buf switch_buf, fork_buf;
-	int enable;
 
 	*switch_buf_ptr = &switch_buf;
 	*fork_buf_ptr = &fork_buf;
@@ -450,7 +449,7 @@ void new_thread(void *stack, void **swit
 	 */
 	flags = get_signals();
 	block_signals();
-	if(UML_SETJMP(&fork_buf, enable) == 0)
+	if(UML_SETJMP(&fork_buf) == 0)
 		new_thread_proc(stack, handler);
 
 	remove_sigstack();
@@ -467,21 +466,19 @@ void new_thread(void *stack, void **swit
 void thread_wait(void *sw, void *fb)
 {
 	jmp_buf buf, **switch_buf = sw, *fork_buf;
-	int enable;
 
 	*switch_buf = &buf;
 	fork_buf = fb;
-	if(UML_SETJMP(&buf, enable) == 0)
+	if(UML_SETJMP(&buf) == 0)
 		siglongjmp(*fork_buf, INIT_JMP_REMOVE_SIGSTACK);
 }
 
 void switch_threads(void *me, void *next)
 {
 	jmp_buf my_buf, **me_ptr = me, *next_buf = next;
-	int enable;
 
 	*me_ptr = &my_buf;
-	if(UML_SETJMP(&my_buf, enable) == 0)
+	if(UML_SETJMP(&my_buf) == 0)
 		UML_LONGJMP(next_buf, 1);
 }
 
@@ -495,14 +492,14 @@ static jmp_buf *cb_back;
 int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
 {
 	jmp_buf **switch_buf = switch_buf_ptr;
-	int n, enable;
+	int n;
 
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
 		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
 		    SIGVTALRM, -1);
 
 	*fork_buf_ptr = &initial_jmpbuf;
-	n = UML_SETJMP(&initial_jmpbuf, enable);
+	n = UML_SETJMP(&initial_jmpbuf);
 	switch(n){
 	case INIT_JMP_NEW_THREAD:
 		new_thread_proc((void *) stack, new_thread_handler);
@@ -529,14 +526,13 @@ int start_idle_thread(void *stack, void 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 {
 	jmp_buf here;
-	int enable;
 
 	cb_proc = proc;
 	cb_arg = arg;
 	cb_back = &here;
 
 	block_signals();
-	if(UML_SETJMP(&here, enable) == 0)
+	if(UML_SETJMP(&here) == 0)
 		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
 	unblock_signals();
 

