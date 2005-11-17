Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750810AbVKQNXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750810AbVKQNXT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVKQNXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:23:19 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:49603 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750810AbVKQNXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:23:18 -0500
Date: Thu, 17 Nov 2005 18:53:15 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 4/10] kdump: save registers early (inline functions)
Message-ID: <20051117132315.GH3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com> <20051117131825.GE3981@in.ibm.com> <20051117132004.GF3981@in.ibm.com> <20051117132138.GG3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: ump-save-registers-early.patch
Content-Disposition: inline
In-Reply-To: <20051117132138.GG3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o If system panics then cpu register states are captured through funciton
  crash_get_current_regs(). This is not a inline function hence a stack
  frame is pushed on to the stack and then cpu register state is captured.
  Later this frame is popped and new frames are pushed (machine_kexec).

o In theory this is not very right as we are capturing register states for
  a frame and that frame is no more valid. This seems to have created back
  trace problems for ppc64.

o This patch fixes it up. The very first thing it does after entering
  crash_kexec() is to capture the register states. Anyway we don't want the
  back trace beyond crash_kexec(). crash_get_current_regs() has been made
  inline

o crash_setup_regs() is the top architecture dependent function which should
  be responsible for capturing the register states as well as to do some
  architecture dependent tricks. For ex. fixing up ss and esp for i386.
  crash_setup_regs() has also been made inline to ensure no new call frame
  is pushed onto stack.


Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash.c |   47 --------------
 linux-2.6.15-rc1-1M-dynamic-root/include/asm-i386/kexec.h |   45 +++++++++++++
 linux-2.6.15-rc1-1M-dynamic-root/kernel/kexec.c           |    4 -
 3 files changed, 51 insertions(+), 45 deletions(-)

diff -puN arch/i386/kernel/crash.c~kdump-save-registers-early arch/i386/kernel/crash.c
--- linux-2.6.15-rc1-1M-dynamic/arch/i386/kernel/crash.c~kdump-save-registers-early	2005-11-15 14:22:35.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash.c	2005-11-15 16:48:34.000000000 +0530
@@ -82,53 +82,12 @@ static void crash_save_this_cpu(struct p
 	final_note(buf);
 }
 
-static void crash_get_current_regs(struct pt_regs *regs)
+static void crash_save_self(struct pt_regs *regs)
 {
-	__asm__ __volatile__("movl %%ebx,%0" : "=m"(regs->ebx));
-	__asm__ __volatile__("movl %%ecx,%0" : "=m"(regs->ecx));
-	__asm__ __volatile__("movl %%edx,%0" : "=m"(regs->edx));
-	__asm__ __volatile__("movl %%esi,%0" : "=m"(regs->esi));
-	__asm__ __volatile__("movl %%edi,%0" : "=m"(regs->edi));
-	__asm__ __volatile__("movl %%ebp,%0" : "=m"(regs->ebp));
-	__asm__ __volatile__("movl %%eax,%0" : "=m"(regs->eax));
-	__asm__ __volatile__("movl %%esp,%0" : "=m"(regs->esp));
-	__asm__ __volatile__("movw %%ss, %%ax;" :"=a"(regs->xss));
-	__asm__ __volatile__("movw %%cs, %%ax;" :"=a"(regs->xcs));
-	__asm__ __volatile__("movw %%ds, %%ax;" :"=a"(regs->xds));
-	__asm__ __volatile__("movw %%es, %%ax;" :"=a"(regs->xes));
-	__asm__ __volatile__("pushfl; popl %0" :"=m"(regs->eflags));
-
-	regs->eip = (unsigned long)current_text_addr();
-}
-
-/* CPU does not save ss and esp on stack if execution is already
- * running in kernel mode at the time of NMI occurrence. This code
- * fixes it.
- */
-static void crash_setup_regs(struct pt_regs *newregs, struct pt_regs *oldregs)
-{
-	memcpy(newregs, oldregs, sizeof(*newregs));
-	newregs->esp = (unsigned long)&(oldregs->esp);
-	__asm__ __volatile__(
-			"xorl %%eax, %%eax\n\t"
-			"movw %%ss, %%ax\n\t"
-			:"=a"(newregs->xss));
-}
-
-/* We may have saved_regs from where the error came from
- * or it is NULL if via a direct panic().
- */
-static void crash_save_self(struct pt_regs *saved_regs)
-{
-	struct pt_regs regs;
 	int cpu;
 
 	cpu = smp_processor_id();
-	if (saved_regs)
-		crash_setup_regs(&regs, saved_regs);
-	else
-		crash_get_current_regs(&regs);
-	crash_save_this_cpu(&regs, cpu);
+	crash_save_this_cpu(regs, cpu);
 }
 
 #ifdef CONFIG_SMP
@@ -147,7 +106,7 @@ static int crash_nmi_callback(struct pt_
 	local_irq_disable();
 
 	if (!user_mode(regs)) {
-		crash_setup_regs(&fixed_regs, regs);
+		crash_fixup_ss_esp(&fixed_regs, regs);
 		regs = &fixed_regs;
 	}
 	crash_save_this_cpu(regs, cpu);
diff -puN kernel/kexec.c~kdump-save-registers-early kernel/kexec.c
--- linux-2.6.15-rc1-1M-dynamic/kernel/kexec.c~kdump-save-registers-early	2005-11-15 14:33:35.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/kernel/kexec.c	2005-11-15 14:40:35.000000000 +0530
@@ -1057,7 +1057,9 @@ void crash_kexec(struct pt_regs *regs)
 	if (!locked) {
 		image = xchg(&kexec_crash_image, NULL);
 		if (image) {
-			machine_crash_shutdown(regs);
+			struct pt_regs fixed_regs;
+			crash_setup_regs(&fixed_regs, regs);
+			machine_crash_shutdown(&fixed_regs);
 			machine_kexec(image);
 		}
 		xchg(&kexec_lock, 0);
diff -puN include/asm-i386/kexec.h~kdump-save-registers-early include/asm-i386/kexec.h
--- linux-2.6.15-rc1-1M-dynamic/include/asm-i386/kexec.h~kdump-save-registers-early	2005-11-15 14:39:07.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/include/asm-i386/kexec.h	2005-11-15 16:51:46.000000000 +0530
@@ -2,6 +2,7 @@
 #define _I386_KEXEC_H
 
 #include <asm/fixmap.h>
+#include <asm/ptrace.h>
 
 /*
  * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
@@ -27,4 +28,48 @@
 
 #define MAX_NOTE_BYTES 1024
 
+/* CPU does not save ss and esp on stack if execution is already
+ * running in kernel mode at the time of NMI occurrence. This code
+ * fixes it.
+ */
+static inline void crash_fixup_ss_esp(struct pt_regs *newregs,
+					struct pt_regs *oldregs)
+{
+	memcpy(newregs, oldregs, sizeof(*newregs));
+	newregs->esp = (unsigned long)&(oldregs->esp);
+	__asm__ __volatile__(
+			"xorl %%eax, %%eax\n\t"
+			"movw %%ss, %%ax\n\t"
+			:"=a"(newregs->xss));
+}
+
+/*
+ * This function is responsible for capturing register states if coming
+ * via panic otherwise just fix up the ss and esp if coming via kernel
+ * mode exception.
+ */
+static inline void crash_setup_regs(struct pt_regs *newregs,
+                                       struct pt_regs *oldregs)
+{
+       if (oldregs)
+               crash_fixup_ss_esp(newregs, oldregs);
+       else {
+               __asm__ __volatile__("movl %%ebx,%0" : "=m"(newregs->ebx));
+               __asm__ __volatile__("movl %%ecx,%0" : "=m"(newregs->ecx));
+               __asm__ __volatile__("movl %%edx,%0" : "=m"(newregs->edx));
+               __asm__ __volatile__("movl %%esi,%0" : "=m"(newregs->esi));
+               __asm__ __volatile__("movl %%edi,%0" : "=m"(newregs->edi));
+               __asm__ __volatile__("movl %%ebp,%0" : "=m"(newregs->ebp));
+               __asm__ __volatile__("movl %%eax,%0" : "=m"(newregs->eax));
+               __asm__ __volatile__("movl %%esp,%0" : "=m"(newregs->esp));
+               __asm__ __volatile__("movw %%ss, %%ax;" :"=a"(newregs->xss));
+               __asm__ __volatile__("movw %%cs, %%ax;" :"=a"(newregs->xcs));
+               __asm__ __volatile__("movw %%ds, %%ax;" :"=a"(newregs->xds));
+               __asm__ __volatile__("movw %%es, %%ax;" :"=a"(newregs->xes));
+               __asm__ __volatile__("pushfl; popl %0" :"=m"(newregs->eflags));
+
+               newregs->eip = (unsigned long)current_text_addr();
+       }
+}
+
 #endif /* _I386_KEXEC_H */
_
