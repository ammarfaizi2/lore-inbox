Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVEFXYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVEFXYW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 19:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVEFXYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 19:24:22 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:46598 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261344AbVEFXOd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 19:14:33 -0400
Message-Id: <200505062249.j46MnRLX010469@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: torvalds@osdl.org, akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/12] UML - Turn literal numbers into symbolic constants
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 May 2005 18:49:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, there I was, looking at my own code, wondering what the magic setjmp
return values did.  This patch turns the constants that are used to make 
requests of the initial thread into meaningful symbols.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/process.c	2005-04-29 15:03:57.000000000 -0400
+++ linux-2.6.11/arch/um/kernel/skas/process.c	2005-04-29 15:08:28.000000000 -0400
@@ -201,6 +201,11 @@
 		}
 	}
 }
+#define INIT_JMP_NEW_THREAD 0
+#define INIT_JMP_REMOVE_SIGSTACK 1
+#define INIT_JMP_CALLBACK 2
+#define INIT_JMP_HALT 3
+#define INIT_JMP_REBOOT 4
 
 void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
 		void (*handler)(int))
@@ -236,7 +241,7 @@
 	*switch_buf = &buf;
 	fork_buf = fb;
 	if(sigsetjmp(buf, 1) == 0)
-		siglongjmp(*fork_buf, 1);
+		siglongjmp(*fork_buf, INIT_JMP_REMOVE_SIGSTACK);
 }
 
 void switch_threads(void *me, void *next)
@@ -266,21 +271,25 @@
 
 	*fork_buf_ptr = &initial_jmpbuf;
 	n = sigsetjmp(initial_jmpbuf, 1);
-	if(n == 0)
-		new_thread_proc((void *) stack, new_thread_handler);
-	else if(n == 1)
-		remove_sigstack();
-	else if(n == 2){
+        switch(n){
+        case INIT_JMP_NEW_THREAD:
+                new_thread_proc((void *) stack, new_thread_handler);
+                break;
+        case INIT_JMP_REMOVE_SIGSTACK:
+                remove_sigstack();
+                break;
+        case INIT_JMP_CALLBACK:
 		(*cb_proc)(cb_arg);
 		siglongjmp(*cb_back, 1);
-	}
-	else if(n == 3){
+                break;
+        case INIT_JMP_HALT:
 		kmalloc_ok = 0;
 		return(0);
-	}
-	else if(n == 4){
+        case INIT_JMP_REBOOT:
 		kmalloc_ok = 0;
 		return(1);
+        default:
+                panic("Bad sigsetjmp return in start_idle_thread - %d\n", n);
 	}
 	siglongjmp(**switch_buf, 1);
 }
@@ -305,7 +314,7 @@
 
 	block_signals();
 	if(sigsetjmp(here, 1) == 0)
-		siglongjmp(initial_jmpbuf, 2);
+		siglongjmp(initial_jmpbuf, INIT_JMP_CALLBACK);
 	unblock_signals();
 
 	cb_proc = NULL;
@@ -316,13 +325,13 @@
 void halt_skas(void)
 {
 	block_signals();
-	siglongjmp(initial_jmpbuf, 3);
+	siglongjmp(initial_jmpbuf, INIT_JMP_HALT);
 }
 
 void reboot_skas(void)
 {
 	block_signals();
-	siglongjmp(initial_jmpbuf, 4);
+	siglongjmp(initial_jmpbuf, INIT_JMP_REBOOT);
 }
 
 void switch_mm_skas(int mm_fd)

