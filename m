Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263123AbTDBTHF>; Wed, 2 Apr 2003 14:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263125AbTDBTHF>; Wed, 2 Apr 2003 14:07:05 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:2216 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S263123AbTDBTHD>;
	Wed, 2 Apr 2003 14:07:03 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16011.14209.703212.772185@gargle.gargle.HOWL>
Date: Wed, 2 Apr 2003 21:18:25 +0200
To: ak@suse.de
CC: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.21-pre6] update x86_64 for kernel_thread change
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building an x86_64 kernel from 2.4.21-pre6 results in two linkage
errors due to the recent kernel_thread to arch_kernel_thread name change.
This patch updates x86_64 for that change.

/Mikael

--- linux-2.4.21-pre6/arch/x86_64/kernel/entry.S.~1~	2003-04-02 20:02:40.000000000 +0200
+++ linux-2.4.21-pre6/arch/x86_64/kernel/entry.S	2003-04-02 20:51:08.000000000 +0200
@@ -77,7 +77,7 @@
 	jnz 2f
 1:
 	RESTORE_REST
-	testl $3,CS-ARGOFFSET(%rsp) # from kernel_thread?
+	testl $3,CS-ARGOFFSET(%rsp) # from arch_kernel_thread?
 	jz   int_ret_from_sys_call
 	testl $ASM_THREAD_IA32,tsk_thread+thread_flags(%rcx)
 	jnz  int_ret_from_sys_call
@@ -542,12 +542,12 @@
  * Create a kernel thread.
  *
  * C extern interface:
- *	extern long kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
+ *	extern long arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
  *
  * asm input arguments:
  *	rdi: fn, rsi: arg, rdx: flags
  */
-ENTRY(kernel_thread)
+ENTRY(arch_kernel_thread)
 	FAKE_STACK_FRAME $child_rip
 	SAVE_ALL
 
@@ -566,7 +566,7 @@
 
 	/*
 	 * It isn't worth to check for reschedule here,
-	 * so internally to the x86_64 port you can rely on kernel_thread()
+	 * so internally to the x86_64 port you can rely on arch_kernel_thread()
 	 * not to reschedule the child before returning, this avoids the need
 	 * of hacks for example to fork off the per-CPU idle tasks.
          * [Hopefully no generic code relies on the reschedule -AK]	
@@ -578,7 +578,7 @@
 child_rip:
 	/*
 	 * Here we are in the child and the registers are set as they were
-	 * at kernel_thread() invocation in the parent.
+	 * at arch_kernel_thread() invocation in the parent.
 	 */
 	movq %rdi, %rax
 	movq %rsi, %rdi
--- linux-2.4.21-pre6/include/asm-x86_64/processor.h.~1~	2003-04-02 20:40:19.000000000 +0200
+++ linux-2.4.21-pre6/include/asm-x86_64/processor.h	2003-04-02 20:49:53.000000000 +0200
@@ -361,7 +361,7 @@
 /*
  * create a kernel thread without removing it from tasklists
  */
-extern long kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
+extern long arch_kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
 
 /* Copy and release all segment info associated with a VM */
 extern void copy_segments(struct task_struct *p, struct mm_struct * mm);
