Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbUJ1RHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbUJ1RHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 13:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbUJ1REr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 13:04:47 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:36734 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261755AbUJ1RCI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 13:02:08 -0400
Date: Thu, 28 Oct 2004 21:02:21 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: i386: use generic support for offsets.h
Message-ID: <20041028190221.GD9004@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028185917.GA9004@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i386: use new generic infrastructure to generate offsets.h
   
Also renamed .h file to offsets.h.
   
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	2004-10-28 20:47:38 +02:00
+++ b/arch/i386/Makefile	2004-10-28 20:47:38 +02:00
@@ -140,15 +140,6 @@
 install fdimage fdimage144 fdimage288: vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) BOOTIMAGE=$(KBUILD_IMAGE) $@
 
-prepare: include/asm-$(ARCH)/asm_offsets.h
-CLEAN_FILES += include/asm-$(ARCH)/asm_offsets.h
-
-arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
-				   include/config/MARKER
-
-include/asm-$(ARCH)/asm_offsets.h: arch/$(ARCH)/kernel/asm-offsets.s
-	$(call filechk,gen-asm-offsets)
-
 archclean:
 	$(Q)$(MAKE) $(clean)=arch/i386/boot
 
diff -Nru a/arch/i386/kernel/asm-offsets.c b/arch/i386/kernel/asm-offsets.c
--- a/arch/i386/kernel/asm-offsets.c	2004-10-28 20:47:38 +02:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,66 +0,0 @@
-/*
- * Generate definitions needed by assembly language modules.
- * This code generates raw asm output which is post-processed
- * to extract and format the required data.
- */
-
-#include <linux/sched.h>
-#include <linux/signal.h>
-#include <linux/personality.h>
-#include <asm/ucontext.h>
-#include "sigframe.h"
-#include <asm/fixmap.h>
-#include <asm/processor.h>
-#include <asm/thread_info.h>
-
-#define DEFINE(sym, val) \
-        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
-void foo(void)
-{
-	OFFSET(SIGCONTEXT_eax, sigcontext, eax);
-	OFFSET(SIGCONTEXT_ebx, sigcontext, ebx);
-	OFFSET(SIGCONTEXT_ecx, sigcontext, ecx);
-	OFFSET(SIGCONTEXT_edx, sigcontext, edx);
-	OFFSET(SIGCONTEXT_esi, sigcontext, esi);
-	OFFSET(SIGCONTEXT_edi, sigcontext, edi);
-	OFFSET(SIGCONTEXT_ebp, sigcontext, ebp);
-	OFFSET(SIGCONTEXT_esp, sigcontext, esp);
-	OFFSET(SIGCONTEXT_eip, sigcontext, eip);
-	BLANK();
-
-	OFFSET(CPUINFO_x86, cpuinfo_x86, x86);
-	OFFSET(CPUINFO_x86_vendor, cpuinfo_x86, x86_vendor);
-	OFFSET(CPUINFO_x86_model, cpuinfo_x86, x86_model);
-	OFFSET(CPUINFO_x86_mask, cpuinfo_x86, x86_mask);
-	OFFSET(CPUINFO_hard_math, cpuinfo_x86, hard_math);
-	OFFSET(CPUINFO_cpuid_level, cpuinfo_x86, cpuid_level);
-	OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
-	OFFSET(CPUINFO_x86_vendor_id, cpuinfo_x86, x86_vendor_id);
-	BLANK();
-
-	OFFSET(TI_task, thread_info, task);
-	OFFSET(TI_exec_domain, thread_info, exec_domain);
-	OFFSET(TI_flags, thread_info, flags);
-	OFFSET(TI_status, thread_info, status);
-	OFFSET(TI_cpu, thread_info, cpu);
-	OFFSET(TI_preempt_count, thread_info, preempt_count);
-	OFFSET(TI_addr_limit, thread_info, addr_limit);
-	OFFSET(TI_restart_block, thread_info, restart_block);
-	BLANK();
-
-	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
-	OFFSET(RT_SIGFRAME_sigcontext, rt_sigframe, uc.uc_mcontext);
-
-	/* Offset from the sysenter stack to tss.esp0 */
-	DEFINE(TSS_sysenter_esp0, offsetof(struct tss_struct, esp0) -
-		 sizeof(struct tss_struct));
-
-	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
-	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
-}
diff -Nru a/arch/i386/kernel/head.S b/arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S	2004-10-28 20:47:38 +02:00
+++ b/arch/i386/kernel/head.S	2004-10-28 20:47:38 +02:00
@@ -17,7 +17,7 @@
 #include <asm/desc.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
-#include <asm/asm_offsets.h>
+#include <asm/offsets.h>
 #include <asm/setup.h>
 
 /*
diff -Nru a/arch/i386/kernel/vsyscall-sigreturn.S b/arch/i386/kernel/vsyscall-sigreturn.S
--- a/arch/i386/kernel/vsyscall-sigreturn.S	2004-10-28 20:47:38 +02:00
+++ b/arch/i386/kernel/vsyscall-sigreturn.S	2004-10-28 20:47:38 +02:00
@@ -7,7 +7,7 @@
  */
 
 #include <asm/unistd.h>
-#include <asm/asm_offsets.h>
+#include <asm/offsets.h>
 
 
 /* XXX
diff -Nru a/arch/i386/kernel/vsyscall.lds.S b/arch/i386/kernel/vsyscall.lds.S
--- a/arch/i386/kernel/vsyscall.lds.S	2004-10-28 20:47:38 +02:00
+++ b/arch/i386/kernel/vsyscall.lds.S	2004-10-28 20:47:38 +02:00
@@ -3,7 +3,7 @@
  * object prelinked to its virtual address, and with only one read-only
  * segment (that fits in one page).  This script controls its layout.
  */
-#include <asm/asm_offsets.h>
+#include <asm/offsets.h>
 
 SECTIONS
 {
diff -Nru a/include/asm-i386/Kbuild b/include/asm-i386/Kbuild
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-i386/Kbuild	2004-10-28 20:47:38 +02:00
@@ -0,0 +1,17 @@
+# Generate header files required for i386
+# Pull in generic stuff from include/asm-generic
+# Used to:
+# 1) Generate include/asm/offset.h
+
+# pull in generic parts
+include $(srctree)/include/asm-generic/Kbuild
+
+
+# generate offsets.h file
+always  := offsets.h
+targets := offsets.s
+
+CFLAGS_offsets.o := -I arch/i386/kernel
+
+$(obj)/offsets.h: $(obj)/offsets.s FORCE
+	$(call filechk,gen-asm-offsets, < $<)
diff -Nru a/include/asm-i386/offsets.c b/include/asm-i386/offsets.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-i386/offsets.c	2004-10-28 20:47:38 +02:00
@@ -0,0 +1,66 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed
+ * to extract and format the required data.
+ */
+
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/personality.h>
+#include <asm/ucontext.h>
+#include "sigframe.h"
+#include <asm/fixmap.h>
+#include <asm/processor.h>
+#include <asm/thread_info.h>
+
+#define DEFINE(sym, val) \
+        asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+#define OFFSET(sym, str, mem) \
+	DEFINE(sym, offsetof(struct str, mem));
+
+void foo(void)
+{
+	OFFSET(SIGCONTEXT_eax, sigcontext, eax);
+	OFFSET(SIGCONTEXT_ebx, sigcontext, ebx);
+	OFFSET(SIGCONTEXT_ecx, sigcontext, ecx);
+	OFFSET(SIGCONTEXT_edx, sigcontext, edx);
+	OFFSET(SIGCONTEXT_esi, sigcontext, esi);
+	OFFSET(SIGCONTEXT_edi, sigcontext, edi);
+	OFFSET(SIGCONTEXT_ebp, sigcontext, ebp);
+	OFFSET(SIGCONTEXT_esp, sigcontext, esp);
+	OFFSET(SIGCONTEXT_eip, sigcontext, eip);
+	BLANK();
+
+	OFFSET(CPUINFO_x86, cpuinfo_x86, x86);
+	OFFSET(CPUINFO_x86_vendor, cpuinfo_x86, x86_vendor);
+	OFFSET(CPUINFO_x86_model, cpuinfo_x86, x86_model);
+	OFFSET(CPUINFO_x86_mask, cpuinfo_x86, x86_mask);
+	OFFSET(CPUINFO_hard_math, cpuinfo_x86, hard_math);
+	OFFSET(CPUINFO_cpuid_level, cpuinfo_x86, cpuid_level);
+	OFFSET(CPUINFO_x86_capability, cpuinfo_x86, x86_capability);
+	OFFSET(CPUINFO_x86_vendor_id, cpuinfo_x86, x86_vendor_id);
+	BLANK();
+
+	OFFSET(TI_task, thread_info, task);
+	OFFSET(TI_exec_domain, thread_info, exec_domain);
+	OFFSET(TI_flags, thread_info, flags);
+	OFFSET(TI_status, thread_info, status);
+	OFFSET(TI_cpu, thread_info, cpu);
+	OFFSET(TI_preempt_count, thread_info, preempt_count);
+	OFFSET(TI_addr_limit, thread_info, addr_limit);
+	OFFSET(TI_restart_block, thread_info, restart_block);
+	BLANK();
+
+	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
+	OFFSET(RT_SIGFRAME_sigcontext, rt_sigframe, uc.uc_mcontext);
+
+	/* Offset from the sysenter stack to tss.esp0 */
+	DEFINE(TSS_sysenter_esp0, offsetof(struct tss_struct, esp0) -
+		 sizeof(struct tss_struct));
+
+	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
+	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
+}
diff -Nru a/include/asm-i386/thread_info.h b/include/asm-i386/thread_info.h
--- a/include/asm-i386/thread_info.h	2004-10-28 20:47:38 +02:00
+++ b/include/asm-i386/thread_info.h	2004-10-28 20:47:38 +02:00
@@ -47,7 +47,7 @@
 
 #else /* !__ASSEMBLY__ */
 
-#include <asm/asm_offsets.h>
+#include <asm/offsets.h>
 
 #endif
 
