Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751389AbWHFTAc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751389AbWHFTAc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 15:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbWHFTAc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 15:00:32 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:17823 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751389AbWHFTAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 15:00:31 -0400
Date: Sun, 6 Aug 2006 14:56:19 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: fix stuck unwind into kernel thread
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>
Message-ID: <200608061458_MC3-1-C742-330A@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot unwind past kernel_thread_helper.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

On top of previous arch_unw_user_mode() patch;
to make this apply to vanilla: s/(unsigned long)_stext/PAGE_OFFSET/

 arch/i386/kernel/process.c   |    6 ++++--
 include/asm-i386/processor.h |    2 ++
 include/asm-i386/unwind.h    |   10 +++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

--- 2.6.18-rc3-d4.orig/arch/i386/kernel/process.c
+++ 2.6.18-rc3-d4/arch/i386/kernel/process.c
@@ -319,15 +319,17 @@ void show_regs(struct pt_regs * regs)
  * function to call, and %edx containing
  * the "args".
  */
-extern void kernel_thread_helper(void);
 __asm__(".section .text\n"
 	".align 4\n"
-	"kernel_thread_helper:\n\t"
+	"kernel_thread_helper:\n"
+	".globl kernel_thread_helper\n\t"
 	"movl %edx,%eax\n\t"
 	"pushl %edx\n\t"
 	"call *%ebx\n\t"
 	"pushl %eax\n\t"
 	"call do_exit\n"
+	"kernel_thread_helper_end:\n"
+	".globl kernel_thread_helper_end\n"
 	".previous");
 
 /*
--- 2.6.18-rc3-d4.orig/include/asm-i386/processor.h
+++ 2.6.18-rc3-d4/include/asm-i386/processor.h
@@ -555,6 +555,8 @@ extern void prepare_to_copy(struct task_
  * create a kernel thread without removing it from tasklists
  */
 extern int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags);
+extern void kernel_thread_helper(void);
+extern void kernel_thread_helper_end(void);
 
 extern unsigned long thread_saved_pc(struct task_struct *tsk);
 void show_trace(struct task_struct *task, struct pt_regs *regs, unsigned long *stack);
--- 2.6.18-rc3-d4.orig/include/asm-i386/unwind.h
+++ 2.6.18-rc3-d4/include/asm-i386/unwind.h
@@ -79,9 +79,13 @@ static inline int arch_unw_user_mode(con
          are properly annotated (and tracked in UNW_REGISTER_INFO). */
 	return user_mode_vm(&info->regs);
 #else
-	return info->regs.eip < (unsigned long)_stext
-	       || (info->regs.eip >= __fix_to_virt(FIX_VDSO)
-	            && info->regs.eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
+	unsigned long eip = info->regs.eip;
+
+	return eip < (unsigned long)_stext
+	       || (eip >= __fix_to_virt(FIX_VDSO)
+		   && eip < __fix_to_virt(FIX_VDSO) + PAGE_SIZE)
+	       || (eip >= (unsigned long)kernel_thread_helper
+		   && eip < (unsigned long)kernel_thread_helper_end)
 	       || info->regs.esp < PAGE_OFFSET;
 #endif
 }
-- 
Chuck
