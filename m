Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbUKKJjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbUKKJjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbUKKJhI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:37:08 -0500
Received: from aun.it.uu.se ([130.238.12.36]:35747 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262199AbUKKJgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:36:14 -0500
Date: Thu, 11 Nov 2004 10:36:07 +0100 (MET)
Message-Id: <200411110936.iAB9a7EL028755@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm4][2/4] perfctr x86_64 core updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2/4 of the perfctr interrupt fixes:
- Move perfctr_suspend_thread() call from __switch_to()
  to the beginning of switch_to(). Ensures that suspend
  actions are done when the owner task still is 'current'.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/x86_64/kernel/process.c |    2 --
 include/asm-x86_64/system.h  |    6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -rupN linux-2.6.10-rc1-mm4/arch/x86_64/kernel/process.c linux-2.6.10-rc1-mm4.perfctr-x86_64-core-update/arch/x86_64/kernel/process.c
--- linux-2.6.10-rc1-mm4/arch/x86_64/kernel/process.c	2004-11-10 18:02:55.000000000 +0100
+++ linux-2.6.10-rc1-mm4.perfctr-x86_64-core-update/arch/x86_64/kernel/process.c	2004-11-11 00:23:20.000000000 +0100
@@ -432,8 +432,6 @@ struct task_struct *__switch_to(struct t
 	int cpu = smp_processor_id();  
 	struct tss_struct *tss = &per_cpu(init_tss, cpu);
 
-	perfctr_suspend_thread(prev);
-
 	unlazy_fpu(prev_p);
 
 	/*
diff -rupN linux-2.6.10-rc1-mm4/include/asm-x86_64/system.h linux-2.6.10-rc1-mm4.perfctr-x86_64-core-update/include/asm-x86_64/system.h
--- linux-2.6.10-rc1-mm4/include/asm-x86_64/system.h	2004-10-28 19:28:42.000000000 +0200
+++ linux-2.6.10-rc1-mm4.perfctr-x86_64-core-update/include/asm-x86_64/system.h	2004-11-11 00:23:48.000000000 +0100
@@ -26,7 +26,8 @@
 #define __EXTRA_CLOBBER  \
 	,"rcx","rbx","rdx","r8","r9","r10","r11","r12","r13","r14","r15"
 
-#define switch_to(prev,next,last) \
+#define switch_to(prev,next,last) do { \
+	perfctr_suspend_thread(&(prev)->thread); \
 	asm volatile(SAVE_CONTEXT						    \
 		     "movq %%rsp,%P[threadrsp](%[prev])\n\t" /* save RSP */	  \
 		     "movq %P[threadrsp](%[next]),%%rsp\n\t" /* restore RSP */	  \
@@ -46,7 +47,8 @@
 		       [tif_fork] "i" (TIF_FORK),			  \
 		       [thread_info] "i" (offsetof(struct task_struct, thread_info)), \
 		       [pda_pcurrent] "i" (offsetof(struct x8664_pda, pcurrent))   \
-		     : "memory", "cc" __EXTRA_CLOBBER)
+		     : "memory", "cc" __EXTRA_CLOBBER); \
+} while (0)
     
 extern void load_gs_index(unsigned); 
 
