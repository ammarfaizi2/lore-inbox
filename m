Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWFZQus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWFZQus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWFZQq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:46:58 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32741 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750814AbWFZQqs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:46:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 4/4] [Suspend2] Build swsusp lowlevel code for Suspend2 as well
Date: Tue, 27 Jun 2006 02:46:52 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164650.10641.33264.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
References: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suspend2 now uses the same lowlevel code as swsusp. This patch lets that
lowlevel code be built when swsusp is disabled but Suspend2 is enabled.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 arch/i386/mm/init.c          |    2 +-
 arch/i386/power/Makefile     |    2 +-
 arch/powerpc/kernel/Makefile |    2 +-
 arch/x86_64/kernel/Makefile  |    2 +-
 arch/x86_64/kernel/suspend.c |    4 ++--
 kernel/power/Kconfig         |    5 +++++
 kernel/power/Makefile        |    3 ++-
 kernel/power/snapshot.c      |   17 ++++++++++++++++-
 8 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
index 3df1371..1678ec4 100644
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -384,7 +384,7 @@ static void __init pagetable_init (void)
 #endif
 }
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#ifdef CONFIG_SUSPEND_SHARED
 /*
  * Swap suspend & friends need this for resume because things like the intel-agp
  * driver might have split up a kernel 4MB mapping.
diff --git a/arch/i386/power/Makefile b/arch/i386/power/Makefile
index 8cfa4e8..7f4efb1 100644
--- a/arch/i386/power/Makefile
+++ b/arch/i386/power/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_PM)		+= cpu.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
+obj-$(CONFIG_SUSPEND_SHARED)	+= swsusp.o
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 803858e..86eabdc 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -36,7 +36,7 @@ obj64-$(CONFIG_PPC_MULTIPLATFORM) += nvr
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
-obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
+obj32-$(CONFIG_SUSPEND_SHARED)	+= swsusp_32.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
 obj-$(CONFIG_E500)		+= perfmon_fsl_booke.o
 
diff --git a/arch/x86_64/kernel/Makefile b/arch/x86_64/kernel/Makefile
index 059c883..81881b5 100644
--- a/arch/x86_64/kernel/Makefile
+++ b/arch/x86_64/kernel/Makefile
@@ -25,7 +25,7 @@ obj-$(CONFIG_X86_IO_APIC)	+= io_apic.o m
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o crash.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_PM)		+= suspend.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= suspend_asm.o
+obj-$(CONFIG_SUSPEND_SHARED)	+= suspend_asm.o
 obj-$(CONFIG_CPU_FREQ)		+= cpufreq/
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 obj-$(CONFIG_GART_IOMMU)	+= pci-gart.o aperture.o
diff --git a/arch/x86_64/kernel/suspend.c b/arch/x86_64/kernel/suspend.c
index ecbd34c..510d369 100644
--- a/arch/x86_64/kernel/suspend.c
+++ b/arch/x86_64/kernel/suspend.c
@@ -141,7 +141,7 @@ void fix_processor_context(void)
 
 }
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
+#ifdef CONFIG_SUSPEND_SHARED
 /* Defined in arch/x86_64/kernel/suspend_asm.S */
 extern int restore_image(void);
 
@@ -220,4 +220,4 @@ int swsusp_arch_resume(void)
 	restore_image();
 	return 0;
 }
-#endif /* CONFIG_SOFTWARE_SUSPEND */
+#endif /* CONFIG_SUSPEND_SHARED */
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index ce0dfb8..e8d57d1 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -98,3 +98,8 @@ config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM
 	default y
+ 
+config SUSPEND_SHARED
+	bool
+	depends on SUSPEND2 || SOFTWARE_SUSPEND
+	default y
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 8d0af3d..01f2230 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -5,8 +5,9 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o swap.o user.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
+obj-$(CONFIG_SUSPEND_SHARED)	+= snapshot.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 3eeedbb..968b927 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -34,6 +34,13 @@
 
 #include "power.h"
 
+#ifdef CONFIG_SUSPEND2
+#include "pagedir.h"
+
+extern int suspend2_running;
+int suspend_post_context_save(void);
+#endif
+
 struct pbe *pagedir_nosave;
 static unsigned int nr_copy_pages;
 static unsigned int nr_meta_pages;
@@ -177,7 +184,6 @@ static int saveable(struct zone *zone, u
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn))
@@ -358,6 +364,10 @@ static inline void *alloc_image_page(gfp
 
 unsigned long get_safe_page(gfp_t gfp_mask)
 {
+#ifdef CONFIG_SUSPEND2
+	if (suspend2_running)
+		return suspend_get_nonconflicting_page();
+#endif
 	return (unsigned long)alloc_image_page(gfp_mask, 1);
 }
 
@@ -480,6 +490,11 @@ asmlinkage int swsusp_save(void)
 {
 	unsigned int nr_pages;
 
+#ifdef CONFIG_SUSPEND2
+	if (suspend2_running)
+		return suspend_post_context_save();
+#endif
+
 	pr_debug("swsusp: critical section: \n");
 
 	drain_local_pages();

--
Nigel Cunningham		nigel at suspend2 dot net
