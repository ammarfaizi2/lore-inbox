Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbTGDIqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 04:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbTGDIp1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 04:45:27 -0400
Received: from air-2.osdl.org ([65.172.181.6]:24727 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265923AbTGDIly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 04:41:54 -0400
Date: Fri, 4 Jul 2003 01:56:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: wli@holomorphy.com, helgehaf@aitel.hist.no, zboszor@freemail.hu,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm1
Message-Id: <20030704015642.7840cab5.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0307040437100.24383@montezuma.mastecende.com>
References: <3F0407D1.8060506@freemail.hu>
	<3F042AEE.2000202@freemail.hu>
	<20030703122243.51a6d581.akpm@osdl.org>
	<20030703200858.GA31084@hh.idb.hist.no>
	<20030703141508.796e4b82.akpm@osdl.org>
	<20030704055315.GW26348@holomorphy.com>
	<Pine.LNX.4.53.0307040307090.24383@montezuma.mastecende.com>
	<20030704012734.77f99e74.akpm@osdl.org>
	<Pine.LNX.4.53.0307040437100.24383@montezuma.mastecende.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
>
> > I shall make that change.
> 
>  Very nice, thanks!

Like this.  I erased every `volatile' I could find.  No idea why they were
in there.


 arch/i386/kernel/smp.c     |    2 -
 arch/i386/kernel/smpboot.c |    6 ++---
 include/asm-i386/smp.h     |    2 -
 include/linux/bitmap.h     |   52 ++++++++++++++++++++++++++-------------------
 4 files changed, 36 insertions(+), 26 deletions(-)

diff -puN include/linux/bitmap.h~gcc-bug-workaround include/linux/bitmap.h
--- 25/include/linux/bitmap.h~gcc-bug-workaround	2003-07-04 01:52:11.000000000 -0700
+++ 25-akpm/include/linux/bitmap.h	2003-07-04 01:52:11.000000000 -0700
@@ -10,7 +10,7 @@
 #include <linux/bitops.h>
 #include <linux/string.h>
 
-static inline int bitmap_empty(const volatile unsigned long *bitmap, int bits)
+static inline int bitmap_empty(const unsigned long *bitmap, int bits)
 {
 	int k;
 	for (k = 0; k < bits/BITS_PER_LONG; ++k)
@@ -24,7 +24,7 @@ static inline int bitmap_empty(const vol
 	return 1;
 }
 
-static inline int bitmap_full(const volatile unsigned long *bitmap, int bits)
+static inline int bitmap_full(const unsigned long *bitmap, int bits)
 {
 	int k;
 	for (k = 0; k < bits/BITS_PER_LONG; ++k)
@@ -38,7 +38,8 @@ static inline int bitmap_full(const vola
 	return 1;
 }
 
-static inline int bitmap_equal(const volatile unsigned long *bitmap1, volatile unsigned long *bitmap2, int bits)
+static inline int bitmap_equal(const unsigned long *bitmap1,
+				unsigned long *bitmap2, int bits)
 {
 	int k;
 	for (k = 0; k < bits/BITS_PER_LONG; ++k)
@@ -46,13 +47,14 @@ static inline int bitmap_equal(const vol
 			return 0;
 
 	if (bits % BITS_PER_LONG)
-		if ((bitmap1[k] ^ bitmap2[k]) & ((1UL << (bits % BITS_PER_LONG)) - 1))
+		if ((bitmap1[k] ^ bitmap2[k]) &
+				((1UL << (bits % BITS_PER_LONG)) - 1))
 			return 0;
 
 	return 1;
 }
 
-static inline void bitmap_complement(volatile unsigned long *bitmap, int bits)
+static inline void bitmap_complement(unsigned long *bitmap, int bits)
 {
 	int k;
 
@@ -60,23 +62,24 @@ static inline void bitmap_complement(vol
 		bitmap[k] = ~bitmap[k];
 }
 
-static inline void bitmap_clear(volatile unsigned long *bitmap, int bits)
+static inline void bitmap_clear(unsigned long *bitmap, int bits)
 {
 	CLEAR_BITMAP((unsigned long *)bitmap, bits);
 }
 
-static inline void bitmap_fill(volatile unsigned long *bitmap, int bits)
+static inline void bitmap_fill(unsigned long *bitmap, int bits)
 {
-	memset((unsigned long *)bitmap, 0xff, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+	memset(bitmap, 0xff, BITS_TO_LONGS(bits)*sizeof(unsigned long));
 }
 
-static inline void bitmap_copy(volatile unsigned long *dst, const volatile unsigned long *src, int bits)
+static inline void bitmap_copy(unsigned long *dst,
+			const unsigned long *src, int bits)
 {
-	memcpy((unsigned long *)dst, (unsigned long *)src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
+	memcpy(dst, src, BITS_TO_LONGS(bits)*sizeof(unsigned long));
 }
 
-static inline void bitmap_shift_left(volatile unsigned long *,const volatile unsigned long *,int,int);
-static inline void bitmap_shift_right(volatile unsigned long *dst, const volatile unsigned long *src, int shift, int bits)
+static inline void bitmap_shift_right(unsigned long *dst,
+				const unsigned long *src, int shift, int bits)
 {
 	int k;
 	DECLARE_BITMAP(__shr_tmp, bits);
@@ -88,7 +91,8 @@ static inline void bitmap_shift_right(vo
 	bitmap_copy(dst, __shr_tmp, bits);
 }
 
-static inline void bitmap_shift_left(volatile unsigned long *dst, const volatile unsigned long *src, int shift, int bits)
+static inline void bitmap_shift_left(unsigned long *dst,
+				const unsigned long *src, int shift, int bits)
 {
 	int k;
 	DECLARE_BITMAP(__shl_tmp, bits);
@@ -100,24 +104,28 @@ static inline void bitmap_shift_left(vol
 	bitmap_copy(dst, __shl_tmp, bits);
 }
 
-static inline void bitmap_and(volatile unsigned long *dst, const volatile unsigned long *bitmap1, const volatile unsigned long *bitmap2, int bits)
+static inline void bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
 {
 	int k;
+	int nr = BITS_TO_LONGS(bits);
 
-	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+	for (k = 0; k < nr; k++)
 		dst[k] = bitmap1[k] & bitmap2[k];
 }
 
-static inline void bitmap_or(volatile unsigned long *dst, const volatile unsigned long *bitmap1, const volatile unsigned long *bitmap2, int bits)
+static inline void bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
+				const unsigned long *bitmap2, int bits)
 {
 	int k;
+	int nr = BITS_TO_LONGS(bits);
 
-	for (k = 0; k < BITS_TO_LONGS(bits); ++k)
+	for (k = 0; k < nr; k++)
 		dst[k] = bitmap1[k] | bitmap2[k];
 }
 
 #if BITS_PER_LONG == 32
-static inline int bitmap_weight(const volatile unsigned long *bitmap, int bits)
+static inline int bitmap_weight(const unsigned long *bitmap, int bits)
 {
 	int k, w = 0;
 
@@ -125,12 +133,13 @@ static inline int bitmap_weight(const vo
 		w += hweight32(bitmap[k]);
 
 	if (bits % BITS_PER_LONG)
-		w+= hweight32(bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1));
+		w += hweight32(bitmap[k] &
+				((1UL << (bits % BITS_PER_LONG)) - 1));
 
 	return w;
 }
 #else
-static inline int bitmap_weight(const volatile unsigned long *bitmap, int bits)
+static inline int bitmap_weight(const unsigned long *bitmap, int bits)
 {
 	int k, w = 0;
 
@@ -138,7 +147,8 @@ static inline int bitmap_weight(const vo
 		w += hweight64(bitmap[k]);
 
 	if (bits % BITS_PER_LONG)
-		w += hweight64(bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1));
+		w += hweight64(bitmap[k] &
+				((1UL << (bits % BITS_PER_LONG)) - 1));
 
 	return w;
 }
diff -puN include/asm-i386/smp.h~gcc-bug-workaround include/asm-i386/smp.h
--- 25/include/asm-i386/smp.h~gcc-bug-workaround	2003-07-04 01:52:17.000000000 -0700
+++ 25-akpm/include/asm-i386/smp.h	2003-07-04 01:52:25.000000000 -0700
@@ -53,7 +53,7 @@ extern void zap_low_mappings (void);
  */
 #define smp_processor_id() (current_thread_info()->cpu)
 
-extern volatile cpumask_t cpu_callout_map;
+extern cpumask_t cpu_callout_map;
 
 #define cpu_possible(cpu) cpu_isset(cpu, cpu_callout_map)
 
diff -puN arch/i386/kernel/smpboot.c~gcc-bug-workaround arch/i386/kernel/smpboot.c
--- 25/arch/i386/kernel/smpboot.c~gcc-bug-workaround	2003-07-04 01:52:36.000000000 -0700
+++ 25-akpm/arch/i386/kernel/smpboot.c	2003-07-04 01:52:59.000000000 -0700
@@ -64,8 +64,8 @@ int phys_proc_id[NR_CPUS]; /* Package ID
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
 
-static volatile cpumask_t cpu_callin_map;
-volatile cpumask_t cpu_callout_map;
+static cpumask_t cpu_callin_map;
+cpumask_t cpu_callout_map;
 static cpumask_t smp_commenced_mask;
 
 /* Per CPU bogomips and other parameters */
@@ -529,7 +529,7 @@ static inline void unmap_cpu_to_node(int
 
 #endif /* CONFIG_NUMA */
 
-volatile u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 cpu_2_logical_apicid[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
 
 void map_cpu_to_logical_apicid(void)
 {
diff -puN arch/i386/kernel/smp.c~gcc-bug-workaround arch/i386/kernel/smp.c
--- 25/arch/i386/kernel/smp.c~gcc-bug-workaround	2003-07-04 01:55:10.000000000 -0700
+++ 25-akpm/arch/i386/kernel/smp.c	2003-07-04 01:55:25.000000000 -0700
@@ -241,7 +241,7 @@ inline void send_IPI_mask_sequence(cpuma
  *	Optimizations Manfred Spraul <manfred@colorfullife.com>
  */
 
-static volatile cpumask_t flush_cpumask;
+static cpumask_t flush_cpumask;
 static struct mm_struct * flush_mm;
 static unsigned long flush_va;
 static spinlock_t tlbstate_lock = SPIN_LOCK_UNLOCKED;

_

