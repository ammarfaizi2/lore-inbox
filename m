Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319005AbSHFGR4>; Tue, 6 Aug 2002 02:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319006AbSHFGR4>; Tue, 6 Aug 2002 02:17:56 -0400
Received: from pl204.dhcp.adsl.tpnet.pl ([217.98.31.204]:13696 "EHLO
	bzzzt.slackware.pl") by vger.kernel.org with ESMTP
	id <S319005AbSHFGRx>; Tue, 6 Aug 2002 02:17:53 -0400
Date: Tue, 6 Aug 2002 08:24:35 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
X-X-Sender: <pkot@bzzzt.slackware.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: <linux-kernel@vger.kernel.org>
Subject: [patch] add missing symbol exports
Message-ID: <Pine.LNX.4.33.0208060815400.24592-100000@bzzzt.slackware.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During the work on the NTFS backport I found that some sympols are missing
in ksyms exports. The following patch add the missing symbols. This is
against 2.4.19, as I can't find 2.4.20pre1 patch anywhere.

diff -Nur linux/arch/i386/kernel/i386_ksyms.c linux-2.4.19/arch/i386/kernel/i386_ksyms.c
--- linux/arch/i386/kernel/i386_ksyms.c	Sat Aug  3 23:14:47 2002
+++ linux-2.4.19/arch/i386/kernel/i386_ksyms.c	Wed Jul 31 07:00:39 2002
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/tty.h>
+#include <linux/highmem.h>

 #include <asm/semaphore.h>
 #include <asm/processor.h>
@@ -144,6 +145,11 @@

 /* TLB flushing */
 EXPORT_SYMBOL(flush_tlb_page);
+#endif
+
+#ifdef CONFIG_HIGHMEM
+EXPORT_SYMBOL(kmap_pte);
+EXPORT_SYMBOL(kmap_prot);
 #endif

 #ifdef CONFIG_X86_IO_APIC
diff -Nur linux/arch/mips/kernel/mips_ksyms.c linux-2.4.19/arch/mips/kernel/mips_ksyms.c
--- linux/arch/mips/kernel/mips_ksyms.c	Sat Aug  3 23:14:53 2002
+++ linux-2.4.19/arch/mips/kernel/mips_ksyms.c	Wed Jul 31 07:01:45 2002
@@ -16,6 +16,7 @@
 #include <linux/in6.h>
 #include <linux/pci.h>
 #include <linux/ide.h>
+#include <linux/highmem.h>

 #include <asm/bootinfo.h>
 #include <asm/checksum.h>
@@ -110,6 +111,14 @@
 EXPORT_SYMBOL(hpc3c0);
 EXPORT_SYMBOL(hpc3c1);
 EXPORT_SYMBOL(mcmisc_regs);
+#endif
+
+/*
+ * Highmem
+ */
+#ifdef CONFIG_HIGHMEM
+EXPORT_SYMBOL(kmap_pte);
+EXPORT_SYMBOL(kmap_prot);
 #endif

 /*
diff -Nur linux/arch/ppc/kernel/ppc_ksyms.c linux-2.4.19/arch/ppc/kernel/ppc_ksyms.c
--- linux/arch/ppc/kernel/ppc_ksyms.c	Sat Aug  3 23:14:57 2002
+++ linux-2.4.19/arch/ppc/kernel/ppc_ksyms.c	Wed Jul 31 07:00:10 2002
@@ -17,6 +17,7 @@
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#include <linux/highmem.h>

 #include <asm/page.h>
 #include <asm/semaphore.h>
@@ -100,6 +101,11 @@
 EXPORT_SYMBOL(kernel_flag);
 #endif /* CONFIG_SMP */

+#ifdef CONFIG_HIGHMEM
+EXPORT_SYMBOL(kmap_pte);
+EXPORT_SYMBOL(kmap_prot);
+#endif
+
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL_NOVERS(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
@@ -344,6 +350,8 @@
 EXPORT_SYMBOL(request_8xxirq);
 EXPORT_SYMBOL(cpm_install_handler);
 EXPORT_SYMBOL(cpm_free_handler);
+#else
+EXPORT_SYMBOL(local_flush_tlb_page);
 #endif /* CONFIG_8xx */

 EXPORT_SYMBOL(ret_to_user_hook);
diff -Nur linux/arch/sparc/kernel/sparc_ksyms.c linux-2.4.19/arch/sparc/kernel/sparc_ksyms.c
--- linux/arch/sparc/kernel/sparc_ksyms.c	Sat Aug  3 23:14:59 2002
+++ linux-2.4.19/arch/sparc/kernel/sparc_ksyms.c	Wed Jul 31 07:02:17 2002
@@ -23,6 +23,7 @@
 #include <linux/pci.h>
 #endif
 #include <linux/pm.h>
+#include <linux/highmem.h>

 #include <asm/oplib.h>
 #include <asm/delay.h>
@@ -145,6 +146,12 @@
 EXPORT_SYMBOL(smp_num_cpus);
 EXPORT_SYMBOL(__cpu_number_map);
 EXPORT_SYMBOL(__cpu_logical_map);
+#endif
+
+/* Highmem */
+#ifdef CONFIG_HIGHMEM
+EXPORT_SYMBOL(kmap_pte);
+EXPORT_SYMBOL(kmap_prot);
 #endif

 EXPORT_SYMBOL(udelay);
diff -Nur linux/kernel/ksyms.c linux-2.4.19/kernel/ksyms.c
--- linux/kernel/ksyms.c	Sat Aug  3 23:15:53 2002
+++ linux-2.4.19/kernel/ksyms.c	Mon Aug  5 01:03:41 2002
@@ -162,7 +162,8 @@
 EXPORT_SYMBOL(d_lookup);
 EXPORT_SYMBOL(__d_path);
 EXPORT_SYMBOL(mark_buffer_dirty);
-EXPORT_SYMBOL(set_buffer_async_io); /* for reiserfs_writepage */
+EXPORT_SYMBOL(end_buffer_io_sync);
+EXPORT_SYMBOL(set_buffer_async_io);
 EXPORT_SYMBOL(__mark_buffer_dirty);
 EXPORT_SYMBOL(__mark_inode_dirty);
 EXPORT_SYMBOL(fd_install);

pkot
-- 
Pawel Kot <pkot@linuxnews.pl>
http://www.gnokii.org/ :: http://www.slackware.pl/
http://kt.linuxnews.pl/ -- Kernel Traffic po polsku

