Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVCaH2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVCaH2g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVCaH2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:28:32 -0500
Received: from mail.renesas.com ([202.234.163.13]:42734 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262531AbVCaHXK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:23:10 -0500
Date: Thu, 31 Mar 2005 16:23:04 +0900 (JST)
Message-Id: <20050331.162304.723210008.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwata@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.12-rc1-mm3] m32r: build fix for CONFIG_DISCONTIGMEM
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes build error for CONFIG_DISCONTIGMEM.
Please apply.

	* arch/m32r/mm/discontig.c: Fix build error for CONFIG_DISCONTIGMEM.
	* arch/m32r/kernel/setup.c: ditto.

	* arch/m32r/mm/discontig.c:
	- Add topology_init.
	- Cosmetics: change indentation of comments.

Thanks,

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/setup.c |   31 +++++++++++++++++++++++--------
 arch/m32r/mm/discontig.c |    1 +
 2 files changed, 24 insertions(+), 8 deletions(-)


diff -ruNp a/arch/m32r/kernel/setup.c b/arch/m32r/kernel/setup.c
--- a/arch/m32r/kernel/setup.c	2005-03-31 16:18:18.640005019 +0900
+++ b/arch/m32r/kernel/setup.c	2005-03-31 16:17:55.848982566 +0900
@@ -7,8 +7,6 @@
  *                            Hitoshi Yamamoto
  */
 
-/* $Id$ */
-
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/stddef.h>
@@ -24,6 +22,9 @@
 #include <linux/seq_file.h>
 #include <linux/timex.h>
 #include <linux/tty.h>
+#include <linux/cpu.h>
+#include <linux/nodemask.h>
+
 #include <asm/processor.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -52,7 +53,7 @@ struct cpuinfo_m32r boot_cpu_data;
 #ifdef CONFIG_BLK_DEV_RAM
 extern int rd_doload;	/* 1 = load ramdisk, 0 = don't load */
 extern int rd_prompt;	/* 1 = prompt for ramdisk, 0 = don't prompt */
-extern int rd_image_start;  /* starting block # of image */
+extern int rd_image_start;	/* starting block # of image */
 #endif
 
 #if defined(CONFIG_VGA_CONSOLE)
@@ -273,6 +274,21 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 }
 
+static struct cpu cpu[NR_CPUS];
+
+static int __init topology_init(void)
+{
+	int cpu_id;
+
+	for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++)
+		if (cpu_possible(cpu_id))
+			register_cpu(&cpu[cpu_id], cpu_id, NULL);
+
+	return 0;
+}
+
+subsys_initcall(topology_init);
+
 #ifdef CONFIG_PROC_FS
 /*
  *	Get CPU information for use by the procfs.
@@ -285,7 +301,7 @@ static int show_cpuinfo(struct seq_file 
 #ifdef CONFIG_SMP
 	if (!cpu_online(cpu))
 		return 0;
-#endif  /* CONFIG_SMP */
+#endif	/* CONFIG_SMP */
 
 	seq_printf(m, "processor\t: %ld\n", cpu);
 
@@ -359,7 +375,7 @@ struct seq_operations cpuinfo_op = {
 	stop:	c_stop,
 	show:	show_cpuinfo,
 };
-#endif  /* CONFIG_PROC_FS */
+#endif	/* CONFIG_PROC_FS */
 
 unsigned long cpu_initialized __initdata = 0;
 
@@ -399,7 +415,6 @@ void __init cpu_init (void)
 #endif
 
 	/* Set up ICUIMASK */
-	outl(0x00070000, M32R_ICU_IMASK_PORTL);   /* imask=111 */
+	outl(0x00070000, M32R_ICU_IMASK_PORTL);		/* imask=111 */
 }
-#endif  /* defined(CONFIG_CHIP_VDEC2) ... */
-
+#endif	/* defined(CONFIG_CHIP_VDEC2) ... */
diff -ruNp a/arch/m32r/mm/discontig.c b/arch/m32r/mm/discontig.c
--- a/arch/m32r/mm/discontig.c	2005-03-31 16:18:18.649003632 +0900
+++ b/arch/m32r/mm/discontig.c	2005-03-31 15:28:45.000000000 +0900
@@ -11,6 +11,7 @@
 #include <linux/bootmem.h>
 #include <linux/mmzone.h>
 #include <linux/initrd.h>
+#include <linux/nodemask.h>
 
 #include <asm/setup.h>
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
