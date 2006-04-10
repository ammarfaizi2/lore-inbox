Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932217AbWDKAgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932217AbWDKAgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 20:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWDKAgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 20:36:12 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:7396 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932217AbWDKAgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 20:36:10 -0400
Message-Id: <200604102337.k3ANb659006843@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Blaisorblade <blaisorblade@yahoo.it>
Subject: [PATCH 1/3] UML - Change sigjmp_buf to jmp_buf
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Apr 2006 19:37:06 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up the jmpbuf code.  Since softints, we no longer use sig_setjmp, so
the UML_SIGSETJMP wrapper now has a misleading name.  Also, I forgot to
change the buffers from sigjmp_buf to jmp_buf.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16-mm/arch/um/include/longjmp.h
===================================================================
--- linux-2.6.16-mm.orig/arch/um/include/longjmp.h	2006-04-08 17:21:34.000000000 -0400
+++ linux-2.6.16-mm/arch/um/include/longjmp.h	2006-04-10 12:52:04.000000000 -0400
@@ -4,11 +4,11 @@
 #include <setjmp.h>
 #include "os.h"
 
-#define UML_SIGLONGJMP(buf, val) do { \
+#define UML_LONGJMP(buf, val) do { \
 	longjmp(*buf, val);	\
 } while(0)
 
-#define UML_SIGSETJMP(buf, enable) ({ \
+#define UML_SETJMP(buf, enable) ({ \
 	int n; \
 	enable = get_signals(); \
 	n = setjmp(*buf); \
Index: linux-2.6.16-mm/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/process.c	2006-04-08 17:21:34.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/process.c	2006-04-10 12:52:04.000000000 -0400
@@ -266,11 +266,11 @@ void init_new_thread_signals(int altstac
 
 int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
 {
-	sigjmp_buf buf;
+	jmp_buf buf;
 	int n, enable;
 
 	*jmp_ptr = &buf;
-	n = UML_SIGSETJMP(&buf, enable);
+	n = UML_SETJMP(&buf, enable);
 	if(n != 0)
 		return(n);
 	(*fn)(arg);
Index: linux-2.6.16-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/skas/process.c	2006-04-08 17:21:35.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/skas/process.c	2006-04-10 12:52:04.000000000 -0400
@@ -434,7 +434,7 @@ void new_thread(void *stack, void **swit
 		void (*handler)(int))
 {
 	unsigned long flags;
-	sigjmp_buf switch_buf, fork_buf;
+	jmp_buf switch_buf, fork_buf;
 	int enable;
 
 	*switch_buf_ptr = &switch_buf;
@@ -450,7 +450,7 @@ void new_thread(void *stack, void **swit
 	 */
 	flags = get_signals();
 	block_signals();
-	if(UML_SIGSETJMP(&fork_buf, enable) == 0)
+	if(UML_SETJMP(&fork_buf, enable) == 0)
 		new_thread_proc(stack, handler);
 
 	remove_sigstack();
@@ -466,35 +466,35 @@ void new_thread(void *stack, void **swit
 
 void thread_wait(void *sw, void *fb)
 {
-	sigjmp_buf buf, **switch_buf = sw, *fork_buf;
+	jmp_buf buf, **switch_buf = sw, *fork_buf;
 	int enable;
 
 	*switch_buf = &buf;
 	fork_buf = fb;
-	if(UML_SIGSETJMP(&buf, enable) == 0)
+	if(UML_SETJMP(&buf, enable) == 0)
 		siglongjmp(*fork_buf, INIT_JMP_REMOVE_SIGSTACK);
 }
 
 void switch_threads(void *me, void *next)
 {
-	sigjmp_buf my_buf, **me_ptr = me, *next_buf = next;
+	jmp_buf my_buf, **me_ptr = me, *next_buf = next;
 	int enable;
 
 	*me_ptr = &my_buf;
-	if(UML_SIGSETJMP(&my_buf, enable) == 0)
-		UML_SIGLONGJMP(next_buf, 1);
+	if(UML_SETJMP(&my_buf, enable) == 0)
+		UML_LONGJMP(next_buf, 1);
 }
 
-static sigjmp_buf initial_jmpbuf;
+static jmp_buf initial_jmpbuf;
 
 /* XXX Make these percpu */
 static void (*cb_proc)(void *arg);
 static void *cb_arg;
-static sigjmp_buf *cb_back;
+static jmp_buf *cb_back;
 
 int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
 {
-	sigjmp_buf **switch_buf = switch_buf_ptr;
+	jmp_buf **switch_buf = switch_buf_ptr;
 	int n, enable;
 
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
@@ -502,7 +502,7 @@ int start_idle_thread(void *stack, void 
 		    SIGVTALRM, -1);
 
 	*fork_buf_ptr = &initial_jmpbuf;
-	n = UML_SIGSETJMP(&initial_jmpbuf, enable);
+	n = UML_SETJMP(&initial_jmpbuf, enable);
 	switch(n){
 	case INIT_JMP_NEW_THREAD:
 		new_thread_proc((void *) stack, new_thread_handler);
@@ -512,7 +512,7 @@ int start_idle_thread(void *stack, void 
 		break;
 	case INIT_JMP_CALLBACK:
 		(*cb_proc)(cb_arg);
-		UML_SIGLONGJMP(cb_back, 1);
+		UML_LONGJMP(cb_back, 1);
 		break;
 	case INIT_JMP_HALT:
 		kmalloc_ok = 0;
@@ -523,12 +523,12 @@ int start_idle_thread(void *stack, void 
 	default:
 		panic("Bad sigsetjmp return in start_idle_thread - %d\n", n);
 	}
-	UML_SIGLONGJMP(*switch_buf, 1);
+	UML_LONGJMP(*switch_buf, 1);
 }
 
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 {
-	sigjmp_buf here;
+	jmp_buf here;
 	int enable;
 
 	cb_proc = proc;
@@ -536,8 +536,8 @@ void initial_thread_cb_skas(void (*proc)
 	cb_back = &here;
 
 	block_signals();
-	if(UML_SIGSETJMP(&here, enable) == 0)
-		UML_SIGLONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
+	if(UML_SETJMP(&here, enable) == 0)
+		UML_LONGJMP(&initial_jmpbuf, INIT_JMP_CALLBACK);
 	unblock_signals();
 
 	cb_proc = NULL;
@@ -548,13 +548,13 @@ void initial_thread_cb_skas(void (*proc)
 void halt_skas(void)
 {
 	block_signals();
-	UML_SIGLONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
+	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_HALT);
 }
 
 void reboot_skas(void)
 {
 	block_signals();
-	UML_SIGLONGJMP(&initial_jmpbuf, INIT_JMP_REBOOT);
+	UML_LONGJMP(&initial_jmpbuf, INIT_JMP_REBOOT);
 }
 
 void switch_mm_skas(struct mm_id *mm_idp)
Index: linux-2.6.16-mm/arch/um/os-Linux/trap.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/trap.c	2006-04-08 17:21:34.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/trap.c	2006-04-10 12:52:04.000000000 -0400
@@ -35,7 +35,7 @@ void os_fill_handlinfo(struct kern_handl
 
 void do_longjmp(void *b, int val)
 {
-	sigjmp_buf *buf = b;
+	jmp_buf *buf = b;
 
-	UML_SIGLONGJMP(buf, val);
+	UML_LONGJMP(buf, val);
 }
Index: linux-2.6.16-mm/arch/um/os-Linux/uaccess.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/uaccess.c	2006-04-08 17:21:34.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/uaccess.c	2006-04-10 12:52:04.000000000 -0400
@@ -16,9 +16,9 @@ unsigned long __do_user_copy(void *to, c
 	unsigned long *faddrp = (unsigned long *) fault_addr, ret;
 	int enable;
 
-	sigjmp_buf jbuf;
+	jmp_buf jbuf;
 	*fault_catcher = &jbuf;
-	if(UML_SIGSETJMP(&jbuf, enable) == 0){
+	if(UML_SETJMP(&jbuf, enable) == 0){
 		(*op)(to, from, n);
 		ret = 0;
 		*faulted_out = 0;
Index: linux-2.6.16-mm/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6.16-mm.orig/arch/um/os-Linux/util.c	2006-04-08 17:21:35.000000000 -0400
+++ linux-2.6.16-mm/arch/um/os-Linux/util.c	2006-04-10 12:52:04.000000000 -0400
@@ -104,7 +104,7 @@ void setup_hostinfo(void)
 int setjmp_wrapper(void (*proc)(void *, void *), ...)
 {
 	va_list args;
-	sigjmp_buf buf;
+	jmp_buf buf;
 	int n;
 
 	n = sigsetjmp(buf, 1);

