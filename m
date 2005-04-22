Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261964AbVDVPMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261964AbVDVPMj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262049AbVDVPKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 11:10:06 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:59270 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261964AbVDVPAf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 11:00:35 -0400
Date: Fri, 22 Apr 2005 17:00:03 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 4/12] s390: default storage key.
Message-ID: <20050422150002.GD17508@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 4/12] s390: default storage key.

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Provide an easy way to define a non-zero storage key at compile
time. This is useful for debugging purposes.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/s390_ksyms.c |    1 -
 arch/s390/kernel/setup.c      |   20 ++++++++++++++++----
 drivers/s390/cio/cio.c        |    4 ++--
 drivers/s390/cio/device_ops.c |    6 +++---
 drivers/s390/cio/qdio.h       |    6 ++++--
 include/asm-s390/page.h       |    2 ++
 include/asm-s390/processor.h  |    2 +-
 include/asm-s390/ptrace.h     |   16 +++++++++++++---
 8 files changed, 41 insertions(+), 16 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/s390_ksyms.c linux-2.6-patched/arch/s390/kernel/s390_ksyms.c
--- linux-2.6/arch/s390/kernel/s390_ksyms.c	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/s390_ksyms.c	2005-04-22 15:45:01.000000000 +0200
@@ -34,7 +34,6 @@ EXPORT_SYMBOL(__clear_user_asm);
 EXPORT_SYMBOL(__strncpy_from_user_asm);
 EXPORT_SYMBOL(__strnlen_user_asm);
 EXPORT_SYMBOL(diag10);
-EXPORT_SYMBOL(default_storage_key);
 
 /*
  * semaphore ops
diff -urpN linux-2.6/arch/s390/kernel/setup.c linux-2.6-patched/arch/s390/kernel/setup.c
--- linux-2.6/arch/s390/kernel/setup.c	2005-04-22 15:45:01.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/setup.c	2005-04-22 15:45:01.000000000 +0200
@@ -44,6 +44,8 @@
 #include <asm/cpcmd.h>
 #include <asm/lowcore.h>
 #include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/ptrace.h>
 
 /*
  * Machine setup..
@@ -53,7 +55,6 @@ unsigned int console_devno = -1;
 unsigned int console_irq = -1;
 unsigned long memory_size = 0;
 unsigned long machine_flags = 0;
-unsigned int default_storage_key = 0;
 struct {
 	unsigned long addr, size, type;
 } memory_chunk[MEMORY_CHUNKS] = { { 0 } };
@@ -402,7 +403,7 @@ setup_lowcore(void)
 	lc = (struct _lowcore *)
 		__alloc_bootmem(lc_pages * PAGE_SIZE, lc_pages * PAGE_SIZE, 0);
 	memset(lc, 0, lc_pages * PAGE_SIZE);
-	lc->restart_psw.mask = PSW_BASE_BITS;
+	lc->restart_psw.mask = PSW_BASE_BITS | PSW_DEFAULT_KEY;
 	lc->restart_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
 	lc->external_new_psw.mask = PSW_KERNEL_BITS;
@@ -470,7 +471,7 @@ static void __init
 setup_memory(void)
 {
         unsigned long bootmap_size;
-	unsigned long start_pfn, end_pfn;
+	unsigned long start_pfn, end_pfn, init_pfn;
 	unsigned long last_rw_end;
 	int i;
 
@@ -481,6 +482,10 @@ setup_memory(void)
 	start_pfn = (__pa(&_end) + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	end_pfn = max_pfn = memory_end >> PAGE_SHIFT;
 
+	/* Initialize storage key for kernel pages */
+	for (init_pfn = 0 ; init_pfn < start_pfn; init_pfn++)
+		page_set_storage_key(init_pfn << PAGE_SHIFT, PAGE_DEFAULT_KEY);
+
 	/*
 	 * Initialize the boot-time allocator (with low memory only):
 	 */
@@ -491,7 +496,7 @@ setup_memory(void)
 	 */
 	last_rw_end = start_pfn;
 
-	for (i = 0; i < 16 && memory_chunk[i].size > 0; i++) {
+	for (i = 0; i < MEMORY_CHUNKS && memory_chunk[i].size > 0; i++) {
 		unsigned long start_chunk, end_chunk;
 
 		if (memory_chunk[i].type != CHUNK_READ_WRITE)
@@ -505,6 +510,11 @@ setup_memory(void)
 		if (end_chunk > end_pfn)
 			end_chunk = end_pfn;
 		if (start_chunk < end_chunk) {
+			/* Initialize storage key for RAM pages */
+			for (init_pfn = start_chunk ; init_pfn < end_chunk;
+			     init_pfn++)
+				page_set_storage_key(init_pfn << PAGE_SHIFT,
+						     PAGE_DEFAULT_KEY);
 			free_bootmem(start_chunk << PAGE_SHIFT,
 				     (end_chunk - start_chunk) << PAGE_SHIFT);
 			if (last_rw_end < start_chunk)
@@ -513,6 +523,8 @@ setup_memory(void)
 		}
 	}
 
+	psw_set_key(PAGE_DEFAULT_KEY);
+
 	if (last_rw_end < end_pfn - 1)
 		add_memory_hole(last_rw_end, end_pfn - 1);
 
diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2005-04-22 15:44:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2005-04-22 15:45:01.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
- *   $Revision: 1.131 $
+ *   $Revision: 1.133 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -228,7 +228,7 @@ cio_start_key (struct subchannel *sch,	/
 int
 cio_start (struct subchannel *sch, struct ccw1 *cpa, __u8 lpm)
 {
-	return cio_start_key(sch, cpa, lpm, default_storage_key);
+	return cio_start_key(sch, cpa, lpm, PAGE_DEFAULT_KEY);
 }
 
 /*
diff -urpN linux-2.6/drivers/s390/cio/device_ops.c linux-2.6-patched/drivers/s390/cio/device_ops.c
--- linux-2.6/drivers/s390/cio/device_ops.c	2005-04-22 15:44:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/device_ops.c	2005-04-22 15:45:01.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/device_ops.c
  *
- *   $Revision: 1.55 $
+ *   $Revision: 1.56 $
  *
  *    Copyright (C) 2002 IBM Deutschland Entwicklung GmbH,
  *			 IBM Corporation
@@ -128,7 +128,7 @@ ccw_device_start(struct ccw_device *cdev
 		 unsigned long intparm, __u8 lpm, unsigned long flags)
 {
 	return ccw_device_start_key(cdev, cpa, intparm, lpm,
-				    default_storage_key, flags);
+				    PAGE_DEFAULT_KEY, flags);
 }
 
 int
@@ -137,7 +137,7 @@ ccw_device_start_timeout(struct ccw_devi
 			 int expires)
 {
 	return ccw_device_start_timeout_key(cdev, cpa, intparm, lpm,
-					    default_storage_key, flags,
+					    PAGE_DEFAULT_KEY, flags,
 					    expires);
 }
 
diff -urpN linux-2.6/drivers/s390/cio/qdio.h linux-2.6-patched/drivers/s390/cio/qdio.h
--- linux-2.6/drivers/s390/cio/qdio.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.h	2005-04-22 15:45:01.000000000 +0200
@@ -1,7 +1,9 @@
 #ifndef _CIO_QDIO_H
 #define _CIO_QDIO_H
 
-#define VERSION_CIO_QDIO_H "$Revision: 1.26 $"
+#include <asm/page.h>
+
+#define VERSION_CIO_QDIO_H "$Revision: 1.32 $"
 
 #ifdef CONFIG_QDIO_DEBUG
 #define QDIO_VERBOSE_LEVEL 9
@@ -42,7 +44,7 @@
 
 #define QDIO_Q_LAPS 5
 
-#define QDIO_STORAGE_KEY 0
+#define QDIO_STORAGE_KEY PAGE_DEFAULT_KEY
 
 #define L2_CACHELINE_SIZE 256
 #define INDICATORS_PER_CACHELINE (L2_CACHELINE_SIZE/sizeof(__u32))
diff -urpN linux-2.6/include/asm-s390/page.h linux-2.6-patched/include/asm-s390/page.h
--- linux-2.6/include/asm-s390/page.h	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/page.h	2005-04-22 15:45:01.000000000 +0200
@@ -16,6 +16,8 @@
 #define PAGE_SHIFT      12
 #define PAGE_SIZE       (1UL << PAGE_SHIFT)
 #define PAGE_MASK       (~(PAGE_SIZE-1))
+#define PAGE_DEFAULT_ACC	0
+#define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
diff -urpN linux-2.6/include/asm-s390/processor.h linux-2.6-patched/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	2005-04-22 15:44:53.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/processor.h	2005-04-22 15:45:01.000000000 +0200
@@ -245,7 +245,7 @@ static inline void enabled_wait(void)
 	psw_t wait_psw;
 
 	wait_psw.mask = PSW_BASE_BITS | PSW_MASK_IO | PSW_MASK_EXT |
-		PSW_MASK_MCHECK | PSW_MASK_WAIT;
+		PSW_MASK_MCHECK | PSW_MASK_WAIT | PSW_DEFAULT_KEY;
 #ifndef __s390x__
 	asm volatile (
 		"    basr %0,0\n"
diff -urpN linux-2.6/include/asm-s390/ptrace.h linux-2.6-patched/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/ptrace.h	2005-04-22 15:45:01.000000000 +0200
@@ -185,6 +185,7 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 #include <asm/setup.h>
+#include <asm/page.h>
 
 typedef union
 {
@@ -235,6 +236,7 @@ typedef struct 
 #define PSW_ADDR_INSN		0x7FFFFFFFUL
 
 #define PSW_BASE_BITS		0x00080000UL
+#define PSW_DEFAULT_KEY		(((unsigned long) PAGE_DEFAULT_ACC) << 20)
 
 #define PSW_ASC_PRIMARY		0x00000000UL
 #define PSW_ASC_ACCREG		0x00004000UL
@@ -260,6 +262,7 @@ typedef struct 
 
 #define PSW_BASE_BITS		0x0000000180000000UL
 #define PSW_BASE32_BITS		0x0000000080000000UL
+#define PSW_DEFAULT_KEY		(((unsigned long) PAGE_DEFAULT_ACC) << 52)
 
 #define PSW_ASC_PRIMARY		0x0000000000000000UL
 #define PSW_ASC_ACCREG		0x0000400000000000UL
@@ -268,14 +271,15 @@ typedef struct 
 
 #define PSW_USER32_BITS (PSW_BASE32_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
 			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
-			 PSW_MASK_PSTATE)
+			 PSW_MASK_PSTATE | PSW_DEFAULT_KEY)
 
 #endif /* __s390x__ */
 
-#define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY)
+#define PSW_KERNEL_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_PRIMARY | \
+			 PSW_DEFAULT_KEY)
 #define PSW_USER_BITS	(PSW_BASE_BITS | PSW_MASK_DAT | PSW_ASC_HOME | \
 			 PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK | \
-			 PSW_MASK_PSTATE)
+			 PSW_MASK_PSTATE | PSW_DEFAULT_KEY)
 
 /* This macro merges a NEW PSW mask specified by the user into
    the currently active PSW mask CURRENT, modifying only those
@@ -470,6 +474,12 @@ struct user_regs_struct
 extern void show_regs(struct pt_regs * regs);
 #endif
 
+static inline void
+psw_set_key(unsigned int key)
+{
+	asm volatile ( "spka 0(%0)" : : "d" (key) );
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _S390_PTRACE_H */
