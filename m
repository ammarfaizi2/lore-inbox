Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313908AbSDJWOq>; Wed, 10 Apr 2002 18:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313910AbSDJWOp>; Wed, 10 Apr 2002 18:14:45 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:16354 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313908AbSDJWOm>;
	Wed, 10 Apr 2002 18:14:42 -0400
Date: Wed, 10 Apr 2002 15:11:03 -0700
From: Russ Weight <rweight@us.ibm.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.8-pre3] Scalable CPU bitmasks
Message-ID: <20020410151103.A7688@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This patch applies to the 2.5.8-pre3 kernel. It is
essentially the same as the previous version, except that the 
definition of CPUMAP_SIZE is unified as suggested by
pmenage@ensim.com.

          This patch implements a scalable bitmask specifically
  for tracking CPUs. It consists of two architecture-independent
  files, cpumap.h and cpumap.c. These files add a new datatype and
  supporting functions which allow for future expansion to a CPU count 
  which is not confined to the bit-size of (unsigned long).  The new
  datatype (cpumap_t) and supporting interfaces are optimized at
  compile-time according to the definition of NR_CPUS.
  
          While systems with more than 32 processors are still
  out in the future, these interfaces provide a path for gradual
  code migration. One of the primary goals is to provide current
  functionality without affecting performance. The following 
  is a list of bitmasks that could be converted to the new datatype.
  
          phys_cpu_present_map
          cpu_initialized
          wait_init_idle
          cpu_online_map/cpu_present_mask
          cpu_callin_map
          cpu_callout_map
  
  NOTE:   The cpumap_to_ulong() and cpumap_ulong_to_cpumap() interfaces
          are provided specifically for migration. If these interfaces are
          used when NR_CPUS is greater than the bitsize of (unsigned long),
          they will cause a link-time failure.

diff -Nru a/include/linux/cpumap.h b/include/linux/cpumap.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/linux/cpumap.h	Wed Apr 10 12:43:08 2002
@@ -0,0 +1,110 @@
+/*
+ * cpumap_t data type and supporting functions
+ *
+ * Copyright (c) 2002 IBM Corp.
+ *
+ *	01/25/02 Initial Version 	Russ Weight <rweight@us.ibm.com>
+ *	03/20/02 Move larger functions to cpumap.c	Russ Weight
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#ifndef __LINUX_CPUMAP_H
+#define __LINUX_CPUMAP_H
+
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <asm/types.h>
+
+#define CPUMAP_SIZE       ((NR_CPUS + BITS_PER_LONG - 1) / BITS_PER_LONG)
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+typedef unsigned long cpumap_t[CPUMAP_SIZE];
+
+/*
+ * The following interfaces are the same regardless of CPUMAP_SIZE
+ */
+#define cpumap_clear_bit	clear_bit
+#define cpumap_set_bit		set_bit
+#define cpumap_test_and_set_bit	test_and_set_bit
+#define cpumap_test_bit		test_bit
+
+#if (NR_CPUS % BITS_PER_LONG)
+#define CPUMAP_FILLMASK	((1 << (NR_CPUS % BITS_PER_LONG)) -1)
+#else
+#define CPUMAP_FILLMASK	(~0UL)
+#endif
+
+/*
+ * The following macros and prototype are used to format
+ * a cpumap_t object for display. This function knows the 
+ * minimum size required, which is provided as CPUMAP_BUFSIZE.
+ *
+ * The CPUMAP_BUFSIZE is an exact calcuation of the byte count
+ * required to display a cpumap_t object.
+ */
+
+#define CPUMAP_BUFSIZE (((sizeof(long) * 2) + 1) * CPUMAP_SIZE + 2)
+
+#if BITS_PER_LONG > 32
+#define CPUMAP_FORMAT_STR	"%016lx"
+#else
+#define CPUMAP_FORMAT_STR	"%08lx"
+#endif
+extern char *cpumap_format(cpumap_t map, char *buf, int size);
+
+#if CPUMAP_SIZE == 1
+/*
+ * The following interfaces are optimized for the case where
+ * CPUMAP_SIZE==1 (i.e. a single unsigned long). The single
+ * CPU case falls into the CPUMAP_SIZE==1 case.
+ */
+#define cpumap_to_ulong(cpumap)			(cpumap[0])
+#define cpumap_ulong_to_cpumap(bitmap, cpumap)	(cpumap[0] = bitmap)
+#define cpumap_is_empty(cpumap) 		(cpumap[0] == 0)
+#define cpumap_cmp_mask(map1, map2)		(map1[0] ==  map2[0])
+#define cpumap_clear_mask(cpumap)		(cpumap[0] = 0)
+#define cpumap_fill(cpumap)			(cpumap[0] = CPUMAP_FILLMASK)
+#define cpumap_copy_mask(srcmap, destmap) 	(destmap[0] = srcmap[0])
+#define cpumap_and_mask(map1, map2, result)	(result[0] = map1[0] & map2[0])
+
+#else
+
+/*
+ * The cpumap_to_ulong() and cpumap_ulong_to_cpumap() functions
+ * are provided to facilitate migration to the cpumap_t datatype.
+ * As currently defined, they are only valid for CPUMAP_SIZE==1.
+ * If they are referenced when CPUMAP_SIZE > 1, then we call a
+ * bogus function name in order to trigger a link-time error.
+ */
+extern unsigned long __bad_cpumap_to_ulong(void);
+extern void __bad_cpumap_ulong_to_cpumap(void);
+#define cpumap_to_ulong(cpumap)			__bad_cpumap_to_ulong()
+#define cpumap_ulong_to_cpumap(bitmap, cpumap)	__bad_cpumap_ulong_to_cpumap()
+
+extern int cpumap_is_empty(cpumap_t map);
+extern int cpumap_cmp_mask(cpumap_t map1, cpumap_t map2);
+extern void cpumap_clear_mask(cpumap_t cpumap);
+extern void cpumap_fill(cpumap_t cpumap);
+extern void cpumap_copy_mask(cpumap_t srcmap, cpumap_t destmap);
+extern void cpumap_and_mask(cpumap_t map1, cpumap_t map2, cpumap_t result);
+
+#endif
+#endif
+#endif
diff -Nru a/lib/Makefile b/lib/Makefile
--- a/lib/Makefile	Wed Apr 10 12:43:08 2002
+++ b/lib/Makefile	Wed Apr 10 12:43:08 2002
@@ -8,9 +8,9 @@
 
 L_TARGET := lib.a
 
-export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o rbtree.o
+export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o rbtree.o cpumap.o
 
-obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o
+obj-y := errno.o ctype.o string.o vsprintf.o brlock.o cmdline.o bust_spinlocks.o rbtree.o cpumap.o
 
 obj-$(CONFIG_RWSEM_GENERIC_SPINLOCK) += rwsem-spinlock.o
 obj-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
diff -Nru a/lib/cpumap.c b/lib/cpumap.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/lib/cpumap.c	Wed Apr 10 12:43:08 2002
@@ -0,0 +1,132 @@
+/*
+ * Supporting functions for cpumap_t data type
+ *
+ * Copyright (c) 2002 IBM Corp.
+ *
+ *	03/20/02 Initial Version 	Russ Weight <rweight@us.ibm.com>
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/cpumap.h>
+#include <asm/string.h>
+
+/* Not all architectures define BUG() */
+#ifndef BUG
+  #define BUG() do { \
+	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	* ((char *) 0) = 0; \
+  } while (0)
+#endif /* BUG */
+
+/*
+ * The cpumap_format() function is used to format a cpumap_t
+ * object for display. This function knows the minimum size
+ * required, which is provided as CPUMAP_BUFSIZE.
+ */
+char *cpumap_format(cpumap_t map, char *buf, int size)
+{
+	if (size < CPUMAP_BUFSIZE) {
+		BUG();
+	}
+
+#if CPUMAP_SIZE > 1
+	sprintf(buf, "0x" CPUMAP_FORMAT_STR, map[CPUMAP_SIZE-1]);
+	{
+		int i;
+		char *p = buf + strlen(buf);
+		for (i = CPUMAP_SIZE-2; i >= 0; i--, p += (sizeof(long) + 1)) {
+			sprintf(p, " " CPUMAP_FORMAT_STR, map[i]);
+		}
+	}
+#else
+	sprintf(buf, "0x" CPUMAP_FORMAT_STR, map[0]);
+#endif
+	return(buf);
+}
+
+#if CPUMAP_SIZE > 1
+/*
+ * The following interfaces are provided for (CPUMAP_SIZE > 1).
+ * For the case of (CPUMAP_SIZE==1) (i.e. a single unsigned long),
+ * the same interfaces are provided as inline functions in cpumap.h.
+ */
+int cpumap_is_empty(cpumap_t cpumap)
+{
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		if (cpumap[i] !=  0) {
+			return 0;
+		}
+	}
+	return 1;
+}
+
+/*
+ * Return 1 (non-zero) if they are equal, 0 if not equal
+ */
+int cpumap_cmp_mask(cpumap_t map1, cpumap_t map2)
+{
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		if (map1[i] !=  map2[i]) {
+			return 0;
+		}
+	}
+	return 1;
+}
+
+void cpumap_clear_mask(cpumap_t cpumap)
+{
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		cpumap[i] = 0UL;
+	}
+}
+
+void cpumap_fill(cpumap_t cpumap)
+{
+	int i;
+	for (i = 0; i < (CPUMAP_SIZE - 1); i++) {
+		cpumap[i] = ~0UL;
+	}
+	cpumap[CPUMAP_SIZE - 1] = CPUMAP_FILLMASK;
+}
+
+/*
+ * The following interfaces are optimized for the case where
+ * CPUMAP_SIZE==1 (i.e. a single unsigned long).
+ */
+void cpumap_copy_mask(cpumap_t srcmap, cpumap_t destmap)
+{
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		destmap[i] = srcmap[i];
+	}
+}
+
+void cpumap_and_mask(cpumap_t map1, cpumap_t map2, cpumap_t result)
+{
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		result[i] = map1[i] & map2[i];
+	}
+}
+
+#endif
-- 
Russ Weight (rweight@us.ibm.com)
Linux Technology Center
