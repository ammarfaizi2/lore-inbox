Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUE2I5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUE2I5c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 04:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264210AbUE2I5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 04:57:32 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:40884 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264124AbUE2I53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 04:57:29 -0400
Message-ID: <40B85071.8090402@colorfullife.com>
Date: Sat, 29 May 2004 10:57:21 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [RFC,PATCH] use nonatomic bitops for cpumask_t
Content-Type: multipart/mixed;
 boundary="------------010407080909000500090409"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010407080909000500090409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The default implementation for cpumasks in <asm-generic/cpumask*> uses 
atomic bitops for the operations that affect a single cpu and nonatomic 
operations for the rest.
What about switching to nonatomic operations for all operations? I'm 
checking for callers that rely on the atomicity of the bitops, but so 
far everyone has it's own locks.

--
    Manfred

--------------010407080909000500090409
Content-Type: text/plain;
 name="patch-nonatomic-cpumask"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-nonatomic-cpumask"

diff -u 2.6/include/asm-generic/cpumask_arith.h build-2.6/include/asm-generic/cpumask_arith.h
--- 2.6/include/asm-generic/cpumask_arith.h	2004-05-23 21:08:51.000000000 +0200
+++ build-2.6/include/asm-generic/cpumask_arith.h	2004-05-29 10:34:53.000000000 +0200
@@ -6,10 +6,10 @@
  * to contain the whole cpu bitmap.
  */
 
-#define cpu_set(cpu, map)		set_bit(cpu, &(map))
-#define cpu_clear(cpu, map)		clear_bit(cpu, &(map))
+#define cpu_set(cpu, map)		__set_bit(cpu, &(map))
+#define cpu_clear(cpu, map)		__clear_bit(cpu, &(map))
 #define cpu_isset(cpu, map)		test_bit(cpu, &(map))
-#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, &(map))
+#define cpu_test_and_set(cpu, map)	__test_and_set_bit(cpu, &(map))
 
 #define cpus_and(dst,src1,src2)		do { dst = (src1) & (src2); } while (0)
 #define cpus_or(dst,src1,src2)		do { dst = (src1) | (src2); } while (0)
diff -u 2.6/include/asm-generic/cpumask_array.h build-2.6/include/asm-generic/cpumask_array.h
--- 2.6/include/asm-generic/cpumask_array.h	2004-05-23 21:08:51.000000000 +0200
+++ build-2.6/include/asm-generic/cpumask_array.h	2004-05-29 10:35:19.000000000 +0200
@@ -9,10 +9,10 @@
 
 #define CPU_ARRAY_SIZE		BITS_TO_LONGS(NR_CPUS)
 
-#define cpu_set(cpu, map)		set_bit(cpu, (map).mask)
-#define cpu_clear(cpu, map)		clear_bit(cpu, (map).mask)
-#define cpu_isset(cpu, map)		test_bit(cpu, (map).mask)
-#define cpu_test_and_set(cpu, map)	test_and_set_bit(cpu, (map).mask)
+#define cpu_set(cpu, map)		__set_bit(cpu, (map).mask)
+#define cpu_clear(cpu, map)		__clear_bit(cpu, (map).mask)
+#define cpu_isset(cpu, map)		__test_bit(cpu, (map).mask)
+#define cpu_test_and_set(cpu, map)	__test_and_set_bit(cpu, (map).mask)
 
 #define cpus_and(dst,src1,src2)	bitmap_and((dst).mask,(src1).mask, (src2).mask, NR_CPUS)
 #define cpus_or(dst,src1,src2)	bitmap_or((dst).mask, (src1).mask, (src2).mask, NR_CPUS)
diff -u 2.6/include/asm-generic/cpumask_up.h build-2.6/include/asm-generic/cpumask_up.h
--- 2.6/include/asm-generic/cpumask_up.h	2004-01-09 07:59:19.000000000 +0100
+++ build-2.6/include/asm-generic/cpumask_up.h	2004-05-29 10:41:25.000000000 +0200
@@ -6,7 +6,7 @@
 #define cpu_set(cpu, map)		do { (void)(cpu); cpus_coerce(map) = 1UL; } while (0)
 #define cpu_clear(cpu, map)		do { (void)(cpu); cpus_coerce(map) = 0UL; } while (0)
 #define cpu_isset(cpu, map)		((void)(cpu), cpus_coerce(map) != 0UL)
-#define cpu_test_and_set(cpu, map)	((void)(cpu), test_and_set_bit(0, &(map)))
+#define cpu_test_and_set(cpu, map)	((void)(cpu), __test_and_set_bit(0, &(map)))
 
 #define cpus_and(dst, src1, src2)					\
 	do {								\

--------------010407080909000500090409--

