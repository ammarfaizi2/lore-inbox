Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268294AbTBYV0T>; Tue, 25 Feb 2003 16:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268354AbTBYV0T>; Tue, 25 Feb 2003 16:26:19 -0500
Received: from air-2.osdl.org ([65.172.181.6]:52950 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S268294AbTBYV0N>;
	Tue, 25 Feb 2003 16:26:13 -0500
Date: Tue, 25 Feb 2003 13:32:07 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.63-1
Message-Id: <20030225133207.2352bb9a.rddunlap@osdl.org>
In-Reply-To: <20030225175456.GE10396@holomorphy.com>
References: <20030225175456.GE10396@holomorphy.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2003 09:54:56 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

# My comments on this begin with '#'.


diff -urpN linux-2.5.63/arch/i386/kernel/io_apic.c cpu-2.5.63-1/arch/i386/kernel/io_apic.c
--- linux-2.5.63/arch/i386/kernel/io_apic.c	2003-02-24 11:05:15.000000000 -0800
+++ cpu-2.5.63-1/arch/i386/kernel/io_apic.c	2003-02-25 08:42:47.000000000 -0800
@@ -433,10 +432,12 @@ tryanotherirq:
 
-	allowed_mask = cpu_online_map & irq_affinity[selected_irq];
-	target_cpu_mask = 1 << min_loaded;
+	cpus_and(allowed_mask, cpu_online_map, irq_affinity[selected_irq]);
+	cpus_clear(target_cpu_mask);
+	cpu_set(min_loaded, target_cpu_mask);
+	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
-	if (target_cpu_mask & allowed_mask) {
+	if (cpus_empty(tmp)) {
# ?	if (!cpus_empty(tmp)) {
 		irq_desc_t *desc = irq_desc + selected_irq;
 		Dprintk("irq = %d moved to cpu = %d\n", selected_irq, min_loaded);
 		/* mark for change destination */

diff -urpN linux-2.5.63/include/linux/bitmap.h cpu-2.5.63-1/include/linux/bitmap.h
--- linux-2.5.63/include/linux/bitmap.h	1969-12-31 16:00:00.000000000 -0800
+++ cpu-2.5.63-1/include/linux/bitmap.h	2003-02-25 08:39:07.000000000 -0800
@@ -0,0 +1,148 @@
+#ifndef __LINUX_BITMAP_H
+#define __LINUX_BITMAP_H
+
+#ifndef __ASSEMBLY__
+
+#include <linux/bitops.h>

-#define BITS_TO_LONGS(bits) \
-	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
# keep this and use it.  (but moved from another file)

+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
#	unsigned long name[BITS_TO_LONGS(bits)]

+#define CLEAR_BITMAP(name,bits) \
+	memset(name, 0, ((bits)+BITS_PER_LONG-1)/8)
#	memset(name, 0, BITS_TO_LONGS(bits) * (BITS_PER_LONG / 8))
# This clears all longs in <name>, so that extra code below can disappear.

+static inline int bitmap_empty(unsigned long *bitmap, int bits)
+{
+	int k;
#	int m = BITS_TO_LONGS(bits);
+	for (k = 0; k < bits/BITS_PER_LONG; ++k)
#	for (k = 0; k < m; ++k)
+		if (bitmap[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		return (bitmap[k+1] & (~0UL >> (bits % BITS_PER_LONG))) == 0;
# don't need this 'if' any more.
+
+	return 1;
+}
+
+static inline int bitmap_full(unsigned long *bitmap, int bits)
+{
+	int k;
#	int m = BITS_TO_LONGS(bits);
+	for (k = 0; k < bits/BITS_PER_LONG; ++k)
#	for (k = 0; k < m; ++k)
+		if (~bitmap[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG)
+		return (~bitmap[k+1] & (~0UL >> (bits % BITS_PER_LONG))) == 0;
# don't need this 'if' any more.
+
+	return 1;
+}
+
+static inline int bitmap_equal(unsigned long *bitmap1, unsigned long *bitmap2, int bits)
+{
+	int k;
#	int m = BITS_TO_LONGS(bits);
+	for (k = 0; k < bits/BITS_PER_LONG; ++k)
#	for (k = 0; k < m; ++k)
+		if (bitmap1[k] != bitmap2[k])
+			return 0;
+
+	if (bits % BITS_PER_LONG) {
+		unsigned long mask = ~0UL >> (bits % BITS_PER_LONG);
+		return (bitmap1[k+1] & mask) == (bitmap2[k+1] & mask);
+	}
# don't need this 'if' any more.
+	return 1;
+}
+
+static inline void bitmap_fill(unsigned long *bitmap, int bits)
+{
+	memset(bitmap, 0xf, (bits+BITS_PER_LONG/8-1)/8);
# 0xf: should be 0xff; however, it's not used (as wli pointed out to me);
+}
+
+static inline void bitmap_copy(unsigned long *dst, unsigned long *src, int bits)
+{
+	memcpy(dst, src, (bits+BITS_PER_LONG/8-1)/8);
# Change to copy entire longs:
#	memcpy(dst, src, BITS_TO_LONGS(bits) * (BITS_PER_LONG / 8));
+}
+
+static inline void bitmap_shift_left(unsigned long *,unsigned long *,int,int);
# why this line above?  not needed.

+static inline void bitmap_shift_right(unsigned long *dst, unsigned long *src, int shift, int bits)
+{
...
+}
+
+static inline void bitmap_shift_left(unsigned long *dst, unsigned long *src, int shift, int bits)
+{
...
+}

+#elif BITS_PER_LONG == 64
+static inline int bitmap_weight(unsigned long *bitmap, int bits)
+{
+	int k, w = 0;
+	u32 *map = (u32 *)bitmap;
+
+	for (k = 0; k < bits/32; ++k)
+		w += hweight32(map[k]);
+
+	if (bits % 32)
+		w += hweight32(map[k] & (~0UL >> (bits % 32)));
+
+	return w;
+}
+#endif
# use hweight64() above?

diff -urpN linux-2.5.63/include/linux/cpumask.h cpu-2.5.63-1/include/linux/cpumask.h
--- linux-2.5.63/include/linux/cpumask.h	1969-12-31 16:00:00.000000000 -0800
+++ cpu-2.5.63-1/include/linux/cpumask.h	2003-02-25 08:39:07.000000000 -0800
@@ -0,0 +1,90 @@
+#ifndef __LINUX_CPUMASK_H
+#define __LINUX_CPUMASK_H
+
+#ifdef CONFIG_SMP
+
+#include <linux/bitmap.h>
+
+#define CPU_ARRAY_SIZE		((NR_CPUS + BITS_PER_LONG - 1)/BITS_PER_LONG)
# define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)

+struct cpumask
+{
+	unsigned long mask[(NR_CPUS+BITS_PER_LONG-1)/BITS_PER_LONG];
#                         [CPU_ARRAY_SIZE];
+};


--
~Randy
