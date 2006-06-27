Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932222AbWF0Enz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWF0Enz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030708AbWF0EnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:43:11 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:57307 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030701AbWF0Emz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:55 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 08/13] [Suspend2] Powerpc support (needed?)
Date: Tue, 27 Jun 2006 14:42:53 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044252.15066.53177.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the powerpc. Originally merged as part of the suspend2
arch-specific code. I'm not sure if this is needed now that we use swsusp
code.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 drivers/macintosh/Kconfig     |    4 +
 drivers/macintosh/via-pmu.c   |    7 +++
 include/asm-ppc/cpu_context.h |  110 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 12ad462..504e6a6 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -200,4 +200,8 @@ config ANSLCD
 	tristate "Support for ANS LCD display"
 	depends on ADB_CUDA && PPC_PMAC
 
+config SOFTWARE_REPLACE_SLEEP
+	bool "Using Software suspend replace broken sleep function"
+	depends on SUSPEND2
+
 endmenu
diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 0b5ff55..ec8d140 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -2654,6 +2654,13 @@ pmu_ioctl(struct inode * inode, struct f
 			return -EACCES;
 		if (sleep_in_progress)
 			return -EBUSY;
+#ifdef CONFIG_SOFTWARE_REPLACE_SLEEP
+		{
+		extern void suspend2_try_suspend(void);
+		suspend2_try_suspend();
+		return (0);
+		}
+#endif
 		sleep_in_progress = 1;
 		switch (pmu_kind) {
 		case PMU_OHARE_BASED:
diff --git a/include/asm-ppc/cpu_context.h b/include/asm-ppc/cpu_context.h
new file mode 100644
index 0000000..d449094
--- /dev/null
+++ b/include/asm-ppc/cpu_context.h
@@ -0,0 +1,110 @@
+/*
+ * Written by Hu Gang (hugang@soulinfo.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/adb.h>
+#include <linux/pmu.h>
+#include <asm/mmu_context.h>
+
+/* image of the saved processor states */
+struct saved_context {
+	u32 lr, cr, sp, r2;
+	u32 r[20]; /* r12 - r31 */                                                 
+	u32 sprg[4];
+	u32 msr, sdr1, tb1, tb2;
+} __attribute__((packed));
+
+inline static void __save_processor_state(struct saved_context *s)
+{
+	/*asm volatile ("mflr 0; stw 0,%0" : "=m" (s->lr));*/
+	asm volatile ("mfcr 0; stw 0,%0" : "=m" (s->cr));
+	asm volatile ("stw 1,%0" : "=m" (s->sp));
+	asm volatile ("stw 2,%0" : "=m" (s->r2));
+	asm volatile ("stmw 12,%0" : "=m" (s->r));
+
+	/* Save MSR & SDR1 */
+	asm volatile ("mfmsr 4; stw 4,%0" : "=m" (s->msr));
+	asm volatile ("mfsdr1 4; stw 4,%0": "=m" (s->sdr1));
+
+	/* Get a stable timebase and save it */
+	asm volatile ("1:\n"
+		      "mftbu 4;stw 4,%0\n"
+		      "mftb  5;stw 5,%1\n"
+		      "mftbu 3\n"
+		      "cmpw 3,4;\n"
+			  "bne 1b" : 
+			  "=m" (s->tb1),
+			  "=m" (s->tb2));
+		
+	/* Save SPRGs */
+	asm volatile ("mfsprg 4,0; stw 4,%0 " : "=m" (s->sprg[0]));
+	asm volatile ("mfsprg 4,1; stw 4,%0 " : "=m" (s->sprg[1]));
+	asm volatile ("mfsprg 4,2; stw 4,%0 " : "=m" (s->sprg[2]));
+	asm volatile ("mfsprg 4,3; stw 4,%0 " : "=m" (s->sprg[3]));
+}
+
+inline static void __restore_processor_state(struct saved_context *s)
+{
+	/* Restore the BATs, and SDR1 */
+	asm volatile ("lwz 4,%0; mtsdr1 4" : "=m" (s->sdr1));
+	/* asm volatile ("lwz 3,%0" : "=m" (saved_context.msr)); */
+
+	asm volatile ("lwz 4,%0; mtsprg 0,4": "=m" (s->sprg[0]));
+	asm volatile ("lwz 4,%0; mtsprg 1,4": "=m" (s->sprg[1]));
+	asm volatile ("lwz 4,%0; mtsprg 2,4": "=m" (s->sprg[2]));
+	asm volatile ("lwz 4,%0; mtsprg 3,4": "=m" (s->sprg[3]));
+
+	/* Restore TB */
+	asm volatile ("li 3,0; mttbl 3; \n"
+		      "lwz 3,%0\n; lwz 4,%1\n"
+		      "mttbu 3; mttbl 4" :
+		      "=m" (s->tb1),
+		      "=m" (s->tb2));
+
+	/* Restore the callee-saved registers and return */
+	asm volatile ("lmw 12,%0" : "=m" (s->r)); 
+	asm volatile ("lwz 2,%0" : "=m" (s->r2));
+	asm volatile ("lwz 1,%0" : "=m" (s->sp));
+	asm volatile ("lwz 0,%0; mtcr 0" : "=m" (s->cr));
+	
+	/* tell gcc that we clobbered all the registers... 
+	 * otherwise it might keep some addresses there. */
+	asm volatile ("" : : : "r13", "r14", "r15", "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23", "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31");
+	/*asm volatile ("lwz 0,%0; mtlr 0" : "=m" (s->lr));*/
+}
+
+static inline void save_context(void)
+{
+#ifdef CONFIG_ADB_PMU
+	printk("pmu suspend\n");
+	pmu_suspend();
+#endif
+}
+
+extern void enable_kernel_altivec(void);
+
+static inline void restore_context(void)
+{
+	printk("set context: <%p>\n", current);
+	set_context(current->active_mm->context,
+			current->active_mm->pgd);
+
+#ifdef CONFIG_ADB_PMU
+	printk("pmu_resume\n");
+	pmu_resume();
+#endif
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC) {
+		printk("enable altivec\n");
+		enable_kernel_altivec();
+	}
+#endif
+	printk("enable fp\n");
+	enable_kernel_fp();
+}

--
Nigel Cunningham		nigel at suspend2 dot net
