Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVAaR5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVAaR5p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVAaR5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:57:43 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:28120 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261278AbVAaR5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:57:21 -0500
Date: Mon, 31 Jan 2005 18:57:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/8] s390: core changes.
Message-ID: <20050131175712.GA7940@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/8] s390: core changes.

From: Christian Bornträger <cborntra@de.ibm.com>
From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: Michael Holzheu <holzheu@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Export arch_pick_mmap_layout as GPL symbol for binfmt_elf32.
 - Remove unnecessary include from cmm.
 - Allow only root to read the debug feature logs.
 - Register all RAM resources, this fixes output of /proc/iomem.
 - Add read_can_lock and write_can_lock primitives.
 - Regenerate default configuration.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig         |    7 ++++---
 arch/s390/kernel/debug.c    |    2 +-
 arch/s390/kernel/setup.c    |   44 +++++++++++++++++++++++++++++++++-----------
 arch/s390/mm/cmm.c          |    1 -
 arch/s390/mm/mmap.c         |    3 +++
 include/asm-s390/spinlock.h |   12 ++++++++++++
 6 files changed, 53 insertions(+), 16 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-patched/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	2005-01-31 18:51:02.000000000 +0100
+++ linux-2.6-patched/arch/s390/defconfig	2005-01-31 18:51:19.000000000 +0100
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc1
-# Fri Jan 14 14:56:51 2005
+# Linux kernel version: 2.6.11-rc2
+# Mon Jan 31 16:27:12 2005
 #
 CONFIG_MMU=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
@@ -156,6 +156,7 @@
 #
 # Block devices
 #
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=m
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 CONFIG_BLK_DEV_NBD=m
@@ -579,5 +580,5 @@
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
-# CONFIG_CRC32 is not set
+CONFIG_CRC32=m
 # CONFIG_LIBCRC32C is not set
diff -urN linux-2.6/arch/s390/kernel/debug.c linux-2.6-patched/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	2004-12-24 22:34:00.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/debug.c	2005-01-31 18:51:19.000000000 +0100
@@ -931,7 +931,7 @@
 	int rc = 0;
 	int i;
 	unsigned long flags;
-	mode_t mode = S_IFREG;
+	mode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
 	struct proc_dir_entry *pde;
 
 	if (!id)
diff -urN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-01-31 18:51:02.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-01-31 18:51:19.000000000 +0100
@@ -76,8 +76,15 @@
 
 static char command_line[COMMAND_LINE_SIZE] = { 0, };
 
-static struct resource code_resource = { "Kernel code", 0x100000, 0 };
-static struct resource data_resource = { "Kernel data", 0, 0 };
+static struct resource code_resource = {
+	.name  = "Kernel code",
+	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
+};
+
+static struct resource data_resource = {
+	.name = "Kernel data",
+	.flags = IORESOURCE_BUSY | IORESOURCE_MEM,
+};
 
 /*
  * cpu_init() initializes state that is per-CPU.
@@ -314,7 +321,6 @@
         unsigned long bootmap_size;
         unsigned long memory_start, memory_end;
         char c = ' ', cn, *to = command_line, *from = COMMAND_LINE;
-	struct resource *res;
 	unsigned long start_pfn, end_pfn;
         static unsigned int smptrap=0;
         unsigned long delay = 0;
@@ -472,6 +478,30 @@
         }
 #endif
 
+	for (i = 0; i < 16 && memory_chunk[i].size > 0; i++) {
+		struct resource *res;
+
+		res = alloc_bootmem_low(sizeof(struct resource));
+		res->flags = IORESOURCE_BUSY | IORESOURCE_MEM;
+
+		switch (memory_chunk[i].type) {
+		case CHUNK_READ_WRITE:
+			res->name = "System RAM";
+			break;
+		case CHUNK_READ_ONLY:
+			res->name = "System ROM";
+			res->flags |= IORESOURCE_READONLY;
+			break;
+		default:
+			res->name = "reserved";
+		}
+		res->start = memory_chunk[i].addr;
+		res->end = memory_chunk[i].addr +  memory_chunk[i].size - 1;
+		request_resource(&iomem_resource, res);
+		request_resource(res, &code_resource);
+		request_resource(res, &data_resource);
+	}
+
         /*
          * Setup lowcore for boot cpu
          */
@@ -524,14 +554,6 @@
 	 */
         paging_init();
 
-	res = alloc_bootmem_low(sizeof(struct resource));
-	res->start = 0;
-	res->end = memory_end;
-	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
-	request_resource(&iomem_resource, res);
-	request_resource(res, &code_resource);
-	request_resource(res, &data_resource);
-
         /* Setup default console */
 	conmode_default();
 }
diff -urN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2005-01-31 18:51:02.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2005-01-31 18:51:19.000000000 +0100
@@ -19,7 +19,6 @@
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
-#include <asm/smp.h>
 
 #include "../../../drivers/s390/net/smsgiucv.h"
 
diff -urN linux-2.6/arch/s390/mm/mmap.c linux-2.6-patched/arch/s390/mm/mmap.c
--- linux-2.6/arch/s390/mm/mmap.c	2004-12-24 22:33:48.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/mmap.c	2005-01-31 18:51:19.000000000 +0100
@@ -26,6 +26,7 @@
 
 #include <linux/personality.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 
 /*
  * Top of mmap area (just below the process stack).
@@ -81,3 +82,5 @@
 		mm->unmap_area = arch_unmap_area_topdown;
 	}
 }
+EXPORT_SYMBOL_GPL(arch_pick_mmap_layout);
+
diff -urN linux-2.6/include/asm-s390/spinlock.h linux-2.6-patched/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	2005-01-31 18:51:10.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/spinlock.h	2005-01-31 18:51:19.000000000 +0100
@@ -117,6 +117,18 @@
 
 #define rwlock_init(x)	do { *(x) = RW_LOCK_UNLOCKED; } while(0)
 
+/**
+ * read_can_lock - would read_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define read_can_lock(x) ((int)(x)->lock >= 0)
+
+/**
+ * write_can_lock - would write_trylock() succeed?
+ * @lock: the rwlock in question.
+ */
+#define write_can_lock(x) ((x)->lock == 0)
+
 #ifndef __s390x__
 #define _raw_read_lock(rw)   \
         asm volatile("   l     2,0(%1)\n"   \
