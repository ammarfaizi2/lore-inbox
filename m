Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268586AbTBZCLQ>; Tue, 25 Feb 2003 21:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268590AbTBZCLQ>; Tue, 25 Feb 2003 21:11:16 -0500
Received: from holomorphy.com ([66.224.33.161]:57272 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268586AbTBZCLM>;
	Tue, 25 Feb 2003 21:11:12 -0500
Date: Tue, 25 Feb 2003 18:20:30 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.63-1
Message-ID: <20030226022030.GJ10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20030225175456.GE10396@holomorphy.com> <20030225133207.2352bb9a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225133207.2352bb9a.rddunlap@osdl.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:32:07PM -0800, Randy.Dunlap wrote:
> # My comments on this begin with '#'.

All suggested changes implemented.

cpu-2.5.63-1A, the diff between cpu-2.5.63-1 and cpu-2.5.63-2, follows,
both cpu-2.5.63-1A and cpu-2.5.63-2 are also available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/cpu/

(well, uploaded 30s ago, you might have to wait for mirroring)

-- wli


Include Randy Dunlaps BITS_TO_LONGS() cleanups and his irqbalance
bugfix.

 arch/i386/kernel/io_apic.c |    2 +-
 include/linux/bitmap.h     |   44 ++++++++++++++------------------------------
 include/linux/cpumask.h    |    4 ++--
 3 files changed, 17 insertions(+), 33 deletions(-)


diff -urpN cpu-2.5.63-1/arch/i386/kernel/io_apic.c cpu-2.5.63-2/arch/i386/kernel/io_apic.c
--- cpu-2.5.63-1/arch/i386/kernel/io_apic.c	2003-02-25 08:42:47.000000000 -0800
+++ cpu-2.5.63-2/arch/i386/kernel/io_apic.c	2003-02-25 18:05:21.000000000 -0800
@@ -437,7 +437,7 @@ tryanotherirq:
 	cpu_set(min_loaded, target_cpu_mask);
 	cpus_and(tmp, target_cpu_mask, allowed_mask);
 
-	if (cpus_empty(tmp)) {
+	if (!cpus_empty(tmp)) {
 		irq_desc_t *desc = irq_desc + selected_irq;
 		Dprintk("irq = %d moved to cpu = %d\n", selected_irq, min_loaded);
 		/* mark for change destination */
diff -urpN cpu-2.5.63-1/include/linux/bitmap.h cpu-2.5.63-2/include/linux/bitmap.h
--- cpu-2.5.63-1/include/linux/bitmap.h	2003-02-25 08:39:07.000000000 -0800
+++ cpu-2.5.63-2/include/linux/bitmap.h	2003-02-25 18:13:30.000000000 -0800
@@ -5,48 +5,39 @@
 
 #include <linux/bitops.h>
 
+#define BITS_TO_LONGS(bits) (((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
 #define DECLARE_BITMAP(name,bits) \
-	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
+	unsigned long name[BITS_TO_LONGS(bits)]
 #define CLEAR_BITMAP(name,bits) \
-	memset(name, 0, ((bits)+BITS_PER_LONG-1)/8)
+	memset(name, 0, BITS_TO_LONGS(bits)*sizeof(unsigned long))
 
 static inline int bitmap_empty(unsigned long *bitmap, int bits)
 {
 	int k;
-	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
 		if (bitmap[k])
 			return 0;
 
-	if (bits % BITS_PER_LONG)
-		return (bitmap[k+1] & (~0UL >> (bits % BITS_PER_LONG))) == 0;
-
 	return 1;
 }
 
 static inline int bitmap_full(unsigned long *bitmap, int bits)
 {
 	int k;
-	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
 		if (~bitmap[k])
 			return 0;
 
-	if (bits % BITS_PER_LONG)
-		return (~bitmap[k+1] & (~0UL >> (bits % BITS_PER_LONG))) == 0;
-
 	return 1;
 }
 
 static inline int bitmap_equal(unsigned long *bitmap1, unsigned long *bitmap2, int bits)
 {
 	int k;
-	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
 		if (bitmap1[k] != bitmap2[k])
 			return 0;
 
-	if (bits % BITS_PER_LONG) {
-		unsigned long mask = ~0UL >> (bits % BITS_PER_LONG);
-		return (bitmap1[k+1] & mask) == (bitmap2[k+1] & mask);
-	}
 	return 1;
 }
 
@@ -54,7 +45,7 @@ static inline void bitmap_complement(uns
 {
 	int k;
 
-	for (k = 0; k < (bits+BITS_PER_LONG-1)/BITS_PER_LONG; ++k)
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
 		bitmap[k] = ~bitmap[k];
 }
 
@@ -65,12 +56,12 @@ static inline void bitmap_clear(unsigned
 
 static inline void bitmap_fill(unsigned long *bitmap, int bits)
 {
-	memset(bitmap, 0xf, (bits+BITS_PER_LONG/8-1)/8);
+	memset(bitmap, 0xff, BITS_TO_LONGS(bits)*sizeof(unsigned long));
 }
 
 static inline void bitmap_copy(unsigned long *dst, unsigned long *src, int bits)
 {
-	memcpy(dst, src, (bits+BITS_PER_LONG/8-1)/8);
+	memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
 }
 
 static inline void bitmap_shift_left(unsigned long *,unsigned long *,int,int);
@@ -102,7 +93,7 @@ static inline void bitmap_and(unsigned l
 {
 	int k;
 
-	for (k = 0; k < (bits+BITS_PER_LONG-1)/BITS_PER_LONG; ++k)
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
 		dst[k] = bitmap1[k] & bitmap2[k];
 }
 
@@ -110,7 +101,7 @@ static inline void bitmap_or(unsigned lo
 {
 	int k;
 
-	for (k = 0; k < (bits+BITS_PER_LONG-1)/BITS_PER_LONG; ++k)
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
 		dst[k] = bitmap1[k] | bitmap2[k];
 }
 
@@ -119,25 +110,18 @@ static inline int bitmap_weight(unsigned
 {
 	int k, w = 0;
 
-	for (k = 0; k < bits/BITS_PER_LONG; ++k)
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
 		w += hweight32(bitmap[k]);
 
-	if (bits % BITS_PER_LONG)
-		w += hweight32(bitmap[k] & (~0UL >> (bits % BITS_PER_LONG)));
-
 	return w;
 }
 #elif BITS_PER_LONG == 64
 static inline int bitmap_weight(unsigned long *bitmap, int bits)
 {
 	int k, w = 0;
-	u32 *map = (u32 *)bitmap;
-
-	for (k = 0; k < bits/32; ++k)
-		w += hweight32(map[k]);
 
-	if (bits % 32)
-		w += hweight32(map[k] & (~0UL >> (bits % 32)));
+	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+		w += hweight64(bitmap[k]);
 
 	return w;
 }
diff -urpN cpu-2.5.63-1/include/linux/cpumask.h cpu-2.5.63-2/include/linux/cpumask.h
--- cpu-2.5.63-1/include/linux/cpumask.h	2003-02-25 08:39:07.000000000 -0800
+++ cpu-2.5.63-2/include/linux/cpumask.h	2003-02-25 18:14:17.000000000 -0800
@@ -5,11 +5,11 @@
 
 #include <linux/bitmap.h>
 
-#define CPU_ARRAY_SIZE		((NR_CPUS + BITS_PER_LONG - 1)/BITS_PER_LONG)
+#define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
 
 struct cpumask
 {
-	unsigned long mask[(NR_CPUS+BITS_PER_LONG-1)/BITS_PER_LONG];
+	unsigned long mask[CPU_ARRAY_SIZE];
 };
 
 typedef struct cpumask cpumask_t;
