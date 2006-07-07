Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWGGLrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWGGLrs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 07:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWGGLrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 07:47:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51945 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932111AbWGGLrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 07:47:47 -0400
From: David Howells <dhowells@redhat.com>
Subject: [PATCH 1/8] FRV: Fix FRV arch compile errors [try #4]
Date: Fri, 07 Jul 2006 12:47:40 +0100
To: torvalds@osdl.org, akpm@osdl.org, bernds_cb1@t-online.de, sam@ravnborg.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Message-Id: <20060707114740.948.9421.stgit@warthog.cambridge.redhat.com>
In-Reply-To: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
References: <20060707114738.948.76567.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

The attached patch fixes some FRV arch compile errors, including:

 (*) Marking nr_kernel_pages as __initdata so that references to it end up
     being properly calculated rather than being assumed to be in the small
     data section (and thus calculated wrt the GP register).  Not doing this
     causes the linker to emit errors as the offset is too big to fit into the
     load instruction.

 (*) Move pm_power_off into an unconditionally compiled .c file as it's now
     unconditionally accessed.

 (*) Declare frv_change_cmode() in a header file rather than in a .c file, and
     declare it asmlinkage.

Signed-Off-By: David Howells <dhowells@redhat.com>
---

 arch/frv/kernel/local.h         |    3 +++
 arch/frv/kernel/pm.c            |    5 -----
 arch/frv/kernel/process.c       |    4 ++++
 arch/frv/mb93090-mb00/pci-vdk.c |   11 ++++++++---
 include/linux/bootmem.h         |    2 +-
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/frv/kernel/local.h b/arch/frv/kernel/local.h
index e947176..76606d1 100644
--- a/arch/frv/kernel/local.h
+++ b/arch/frv/kernel/local.h
@@ -51,6 +51,9 @@ #endif
 /* time.c */
 extern void time_divisor_init(void);
 
+/* cmode.S */
+extern asmlinkage void frv_change_cmode(int);
+
 
 #endif /* __ASSEMBLY__ */
 #endif /* _FRV_LOCAL_H */
diff --git a/arch/frv/kernel/pm.c b/arch/frv/kernel/pm.c
index e65a9f1..c1d9fc8 100644
--- a/arch/frv/kernel/pm.c
+++ b/arch/frv/kernel/pm.c
@@ -26,11 +26,6 @@ #include <asm/mb86943a.h>
 
 #include "local.h"
 
-void (*pm_power_off)(void);
-EXPORT_SYMBOL(pm_power_off);
-
-extern void frv_change_cmode(int);
-
 /*
  * Debug macros
  */
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
index eeeb1e2..ecdeafb 100644
--- a/arch/frv/kernel/process.c
+++ b/arch/frv/kernel/process.c
@@ -10,6 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
 #include <linux/kernel.h>
@@ -38,6 +39,9 @@ asmlinkage void ret_from_fork(void);
 
 #include <asm/pgalloc.h>
 
+void (*pm_power_off)(void);
+EXPORT_SYMBOL(pm_power_off);
+
 struct task_struct *alloc_task_struct(void)
 {
 	struct task_struct *p = kmalloc(THREAD_SIZE, GFP_KERNEL);
diff --git a/arch/frv/mb93090-mb00/pci-vdk.c b/arch/frv/mb93090-mb00/pci-vdk.c
index fb98e90..f7279d7 100644
--- a/arch/frv/mb93090-mb00/pci-vdk.c
+++ b/arch/frv/mb93090-mb00/pci-vdk.c
@@ -406,7 +406,9 @@ int __init pcibios_init(void)
 	ioport_resource.end	= (__reg_MB86943_sl_pci_io_range << 9) | 0x3ff;
 	ioport_resource.end	+= ioport_resource.start;
 
-	printk("PCI IO window:  %08lx-%08lx\n", ioport_resource.start, ioport_resource.end);
+	printk("PCI IO window:  %08llx-%08llx\n",
+	       (unsigned long long) ioport_resource.start,
+	       (unsigned long long) ioport_resource.end);
 
 	iomem_resource.start	= (__reg_MB86943_sl_pci_mem_base << 9) & 0xfffffc00;
 
@@ -416,8 +418,11 @@ int __init pcibios_init(void)
 	iomem_resource.end	= (__reg_MB86943_sl_pci_mem_range << 9) | 0x3ff;
 	iomem_resource.end	+= iomem_resource.start;
 
-	printk("PCI MEM window: %08lx-%08lx\n", iomem_resource.start, iomem_resource.end);
-	printk("PCI DMA memory: %08lx-%08lx\n", dma_coherent_mem_start, dma_coherent_mem_end);
+	printk("PCI MEM window: %08llx-%08llx\n",
+	       (unsigned long long) iomem_resource.start,
+	       (unsigned long long) iomem_resource.end);
+	printk("PCI DMA memory: %08lx-%08lx\n",
+	       dma_coherent_mem_start, dma_coherent_mem_end);
 
 	if (!pci_probe)
 		return -ENXIO;
diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 22866fa..1021f50 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -91,7 +91,7 @@ static inline void *alloc_remap(int nid,
 }
 #endif
 
-extern unsigned long nr_kernel_pages;
+extern unsigned long __meminitdata nr_kernel_pages;
 extern unsigned long nr_all_pages;
 
 extern void *__init alloc_large_system_hash(const char *tablename,
