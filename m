Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287966AbSA2Agk>; Mon, 28 Jan 2002 19:36:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288012AbSA2AgY>; Mon, 28 Jan 2002 19:36:24 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61346 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S287966AbSA2AgB>;
	Mon, 28 Jan 2002 19:36:01 -0500
Date: Mon, 28 Jan 2002 16:33:33 -0800
From: Russ Weight <rweight@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [RFC] [PATCH] Scalable CPU bitmasks
Message-ID: <20020128163333.A9744@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	This patch applies to the 2.5.2 kernel.

	This patch implements a scalable bitmask specifically
for tracking CPUs. It consists of a single file which simply
adds a new datatype and supporting functions.  It allows for
future expansion to a CPU count which is not confined to the
bit-size of (unsigned long).  The new datatype (cpumap_t) and
supporting functions are optimized at compile-time according to
the definition of NR_CPUS.

	While systems with more than 32 processors are still
out in the future, these interfaces provide a path for gradual
code migration. One of the primary goals is to provide current
functionality without affecting performance.

	A preliminary list of global CPU bitmasks which _could_
migrate to this new datatype are listed below.

	phys_cpu_present_map
	cpu_initialized
	wait_init_idle
	cpu_online_map/cpu_present_mask
	cpu_callin_map
	cpu_callout_map

***	I have been working on patches for some of these bitmasks,
***	and will send out the one for phys_cpu_present_map as an
***	example.

	One question that has arisen is whether or not a more
generic datatype and interface set could be provided for bitmasks
in general.  I considered this, but could not find sufficient
justification for doing so. However, it would be very easy to
break out the generic portions of these functions into lower-level
primitives that could be more generally used.

NOTE:	The cpumap_to_ulong() and cpumap_ulong_to_cpumap() interfaces
	are provided specifically for migration. In their current form,
	they call BUG() if NR_CPUS is defined to be greater than the
	bit-size of (unsigned long).

Your comments are welcome! Please let me know what you think...

-- 
Russ Weight (rweight@us.ibm.com)
Linux Technology Center


diff -u lx252.pure/include/linux/cpumap.h linux/include/linux/cpumap.h
--- lx252.pure/include/linux/cpumap.h	Thu Jan 24 16:17:32 2002
+++ linux/include/linux/cpumap.h	Fri Jan 25 16:40:44 2002
@@ -0,0 +1,246 @@
+/*
+ * cpumap_t data type and supporting functions
+ *
+ * Copyright (c) 2001 IBM Corp.
+ *
+ *	01/25/02 Initial Version 	Russ Weight <rweight@us.ibm.com>
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
+#ifdef CONFIG_SMP
+ #include <asm/types.h>
+ #define CPUMAP_SIZE       ((NR_CPUS + BITS_PER_LONG - 1) / BITS_PER_LONG)
+#else
+ #define CPUMAP_SIZE       1
+#endif
+
+#ifndef __ASSEMBLY__
+#include <linux/bitops.h>
+typedef unsigned long cpumap_t[CPUMAP_SIZE];
+
+/*
+ * The cpumap_to_ulong() and cpumap_ulong_to_cpumap() functions
+ * are provided primarily for migration to the cpumap_t datatype.
+ * As currently defined, they are only valid for CPUMAP_SIZE==1.
+ */
+static inline unsigned long cpumap_to_ulong(cpumap_t cpumap)
+{
+#if CPUMAP_SIZE > 1
+	BUG();	/* Not supported */
+	return 0;
+#else
+	return cpumap[0];
+#endif
+}
+
+static inline void cpumap_ulong_to_cpumap(unsigned long bitmap, cpumap_t cpumap)
+{
+#if CPUMAP_SIZE > 1
+	BUG();	/* Not supported */
+#else
+	cpumap[0] = bitmap;
+#endif
+}
+
+
+/*
+ * The first set of interfaces are the same for SMP and UP.
+ */
+static inline void cpumap_clear_bit(int nr, cpumap_t cpumap)
+{
+	if (nr < NR_CPUS) {
+		clear_bit(nr, cpumap);
+	} else {
+		BUG();
+	}
+}
+
+static inline void cpumap_set_bit(int nr, cpumap_t cpumap)
+{
+	if (nr < NR_CPUS) {
+		set_bit(nr, cpumap);
+	} else {
+		BUG();
+	}
+}
+
+static inline int cpumap_test_and_set_bit(int nr, cpumap_t cpumap)
+{
+	if (nr < NR_CPUS) {
+		return test_and_set_bit(nr, cpumap);
+	} else {
+		BUG();
+		return -1;
+	}
+}
+
+/*
+ * Return 1 (non-zero) if they are equal, 0 if not equal
+ */
+static inline int cpumap_test_bit(int nr, cpumap_t cpumap)
+{
+	if (nr < NR_CPUS) {
+		return test_bit(nr, cpumap);
+	} else {
+		return 0;
+	}
+}
+
+/*
+ * The following interfaces are optimized for the case where
+ * CPUMAP_SIZE==1 (i.e. a single unsigned long). The single
+ * CPU case falls into the CPUMAP_SIZE==1 case.
+ */
+static inline void cpumap_clear_mask(cpumap_t cpumap)
+{
+#if CPUMAP_SIZE > 1
+	int i;
+
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		cpumap[i] = 0UL;
+	}
+#else
+	cpumap[0] = 0;
+#endif
+}
+
+static inline int cpumap_is_empty(cpumap_t map)
+{
+#if CPUMAP_SIZE > 1
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		if (map[i] !=  0) {
+			return 0;
+		}
+	}
+	return 1;
+#else
+	return (map[0] == 0);
+#endif
+}
+
+/*
+ * Return 1 (non-zero) if they are equal, 0 if not equal
+ */
+static inline int cpumap_cmp_mask(cpumap_t map1, cpumap_t map2)
+{
+#if CPUMAP_SIZE > 1
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		if (map1[i] !=  map2[i]) {
+			return 0;
+		}
+	}
+	return 1;
+#else
+	return (map1[0] ==  map2[0]);
+#endif
+}
+
+#if (NR_CPUS % BITS_PER_LONG)
+#define	CPUMAP_FILLMASK	((1 << (NR_CPUS % BITS_PER_LONG)) -1)
+#else
+#define	CPUMAP_FILLMASK	(~0UL)
+#endif
+
+static inline void cpumap_fill(cpumap_t cpumap)
+{
+#if CPUMAP_SIZE > 1
+	int i;
+
+	for (i = 0; i < (CPUMAP_SIZE - 1); i++) {
+		cpumap[i] = ~0UL;
+	}
+	cpumap[CPUMAP_SIZE - 1] = CPUMAP_FILLMASK;
+#else
+	cpumap[0] = CPUMAP_FILLMASK;
+#endif
+}
+
+/*
+ * The following interfaces are optimized for the case where
+ * CPUMAP_SIZE==1 (i.e. a single unsigned long).
+ */
+static inline void cpumap_copy_mask(cpumap_t srcmap, cpumap_t destmap)
+{
+#if CPUMAP_SIZE > 1
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		destmap[i] = srcmap[i];
+	}
+#else
+	destmap[0] = srcmap[0];
+#endif
+}
+
+static inline void cpumap_and_mask(cpumap_t map1, cpumap_t map2, cpumap_t result)
+{
+#if CPUMAP_SIZE > 1
+	int i;
+	for (i = 0; i < CPUMAP_SIZE; i++) {
+		result[i] = map1[i] & map2[i];
+	}
+#else
+	result[0] = map1[0] & map2[0];
+#endif
+}
+
+/*
+ * The following macros and functions are used to format
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
+
+static inline char *cpumap_format(cpumap_t map, char *buf, int size)
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
+#endif /* __ASSEMBLY__ */
+#endif /* __LINUX_CPUMAP_H */
