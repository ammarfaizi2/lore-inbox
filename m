Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbUD1TqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbUD1TqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUD1TpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:45:22 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:30431 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S264950AbUD1Qt1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 12:49:27 -0400
Date: Wed, 28 Apr 2004 18:49:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/6): core s390.
Message-ID: <20040428164916.GB2777@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: core changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

s390 core changes:
 - Move setting/clearing of TIF_31BIT thread flag to SET_PERSONALITY.
 - Use TASK_UNMAPPED_BASE in elf_map32 for mmaps with address 0.
 - Define ARCH_KMALLOC_MINALIGN.
 - Define ARCH_MIN_TASKALIGN.

diffstat:
 arch/s390/kernel/binfmt_elf32.c |    9 +++------
 arch/s390/kernel/sys_s390.c     |    1 +
 include/asm-s390/cache.h        |    2 ++
 include/asm-s390/elf.h          |   10 ++--------
 include/asm-s390/processor.h    |    2 ++
 5 files changed, 10 insertions(+), 14 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	Wed Apr 28 17:51:14 2004
+++ linux-2.6-s390/arch/s390/kernel/binfmt_elf32.c	Wed Apr 28 17:51:34 2004
@@ -40,8 +40,7 @@
    passed in R14. */
 #define ELF_PLAT_INIT(_r, load_addr) \
 	do { \
-	_r->gprs[14] = 0; \
-	set_thread_flag(TIF_31BIT); \
+		_r->gprs[14] = 0; \
 	} while(0)
 
 #define USE_ELF_CORE_DUMP
@@ -82,6 +81,7 @@
 		set_personality(PER_SVR4);              \
 	else if (current->personality != PER_LINUX32)   \
 		set_personality(PER_LINUX);             \
+	set_thread_flag(TIF_31BIT);			\
 } while (0)
 
 #include "compat_linux.h"
@@ -194,10 +194,7 @@
 	unsigned long map_addr;
 
 	if (!addr) 
-		addr = 0x40000000; 
-
-	if (prot & PROT_READ) 
-		prot |= PROT_EXEC; 
+		addr = TASK_UNMAPPED_BASE;
 
 	down_write(&current->mm->mmap_sem);
 	map_addr = do_mmap(filep, ELF_PAGESTART(addr),
diff -urN linux-2.6/arch/s390/kernel/sys_s390.c linux-2.6-s390/arch/s390/kernel/sys_s390.c
--- linux-2.6/arch/s390/kernel/sys_s390.c	Sun Apr  4 05:36:56 2004
+++ linux-2.6-s390/arch/s390/kernel/sys_s390.c	Wed Apr 28 17:51:34 2004
@@ -4,6 +4,7 @@
  *  S390 version
  *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
+ *               Thomas Spatzier (tspat@de.ibm.com)
  *
  *  Derived from "arch/i386/kernel/sys_i386.c"
  *
diff -urN linux-2.6/include/asm-s390/cache.h linux-2.6-s390/include/asm-s390/cache.h
--- linux-2.6/include/asm-s390/cache.h	Sun Apr  4 05:36:17 2004
+++ linux-2.6-s390/include/asm-s390/cache.h	Wed Apr 28 17:51:36 2004
@@ -15,4 +15,6 @@
 #define L1_CACHE_SHIFT     8
 #define L1_CACHE_SHIFT_MAX 8	/* largest L1 which this arch supports */
 
+#define ARCH_KMALLOC_MINALIGN	8
+
 #endif
diff -urN linux-2.6/include/asm-s390/elf.h linux-2.6-s390/include/asm-s390/elf.h
--- linux-2.6/include/asm-s390/elf.h	Sun Apr  4 05:38:14 2004
+++ linux-2.6-s390/include/asm-s390/elf.h	Wed Apr 28 17:51:36 2004
@@ -123,16 +123,10 @@
 
 /* For SVR4/S390 the function pointer to be registered with `atexit` is
    passed in R14. */
-#ifndef __s390x__
-#define ELF_PLAT_INIT(_r, load_addr) \
-	_r->gprs[14] = 0
-#else /* __s390x__ */
 #define ELF_PLAT_INIT(_r, load_addr) \
 	do { \
-	_r->gprs[14] = 0; \
-	clear_thread_flag(TIF_31BIT); \
-	} while(0)
-#endif /* __s390x__ */
+		_r->gprs[14] = 0; \
+	} while (0)
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE	4096
diff -urN linux-2.6/include/asm-s390/processor.h linux-2.6-s390/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	Sun Apr  4 05:37:06 2004
+++ linux-2.6-s390/include/asm-s390/processor.h	Wed Apr 28 17:51:36 2004
@@ -98,6 +98,8 @@
 
 typedef struct thread_struct thread_struct;
 
+#define ARCH_MIN_TASKALIGN	8
+
 #ifndef __s390x__
 # define __SWAPPER_PG_DIR __pa(&swapper_pg_dir[0]) + _SEGMENT_TABLE
 #else /* __s390x__ */
