Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUDBIRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 03:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbUDBIRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 03:17:23 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:8440 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263354AbUDBIRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 03:17:15 -0500
Date: Fri, 2 Apr 2004 00:15:45 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch 24/23] mask v2 - Small system optimizations
Message-Id: <20040402001545.2dbb7894.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Patch 24 of 23 ;-) improves the small system code, where small is
anything under 32 or 64 CPUs.  I am now getting vmlinux kernel text
sizes that are about 600 bytes of text _smaller_ with these mask patches
applied (which include the addition of Matthew's nodemask_t), then a
stock 2.6.4.  This is with i386 arch defconfig, NR_CPUS = 8, 16 or 32,
gcc 3.3.2.

The patch uses some preprocessor logic in the mask.h file, in order to
provide alternative macros that are custom tuned for the small system.
So far, only a couple of macros, for cpumask_of_cpu() and CPU_MASK_ALL,
look to be worth special casing this way.

The cpumask.h and nodemask.h files that users of these macros will work
with are practically free of any of this logic - just one #define
telling mask.h what size masks are needed, before the #include of
mask.h. There is less such overhead in these files than in yesterdays
version.

The focus continues to be on keeping these masks convenient to understand
and use.

Thanks to Matthew for provoking me into these latest improvements.

And special thanks to Andrew for his patch tools (ancestor of 'quilt'),
without which even the few patches I have here would be a royal pain.

Diffstat:
 cpumask.h  |   13 ++++++-------
 mask.h     |   53 ++++++++++++++++++++++++++++++++++++++++++-----------
 nodemask.h |   14 ++++++--------
 3 files changed, 54 insertions(+), 26 deletions(-)

==================================================================
diff -Naur old/include/linux/cpumask.h new/include/linux/cpumask.h
--- old/include/linux/cpumask.h	2004-04-01 09:44:00.000000000 -0800
+++ new/include/linux/cpumask.h	2004-04-01 23:33:27.000000000 -0800
@@ -61,9 +61,10 @@
  */
 
 #include <linux/threads.h>
-#include <linux/mask.h>
 #include <asm/bug.h>
 
+#define _NBITS_IN_THIS_MASK NR_CPUS
+#include <linux/mask.h>
 typedef __mask(NR_CPUS) cpumask_t;
 extern cpumask_t _unused_cpumask_arg_;
 
@@ -90,13 +91,11 @@
 			mask_shift_left((dst), (src), (n), NR_CPUS)
 #define first_cpu(mask)		     mask_first((mask), NR_CPUS)
 #define next_cpu(cpu, mask)	     mask_next((cpu), (mask), NR_CPUS)
-#define cpumask_of_cpu(cpu)	     mask_of_bit((cpu), _unused_cpumask_arg_)
-#if NR_CPUS <= BITS_PER_LONG
-#define CPU_MASK_ALL		     MASK_ALL1(NR_CPUS)
-#else
-#define CPU_MASK_ALL		     MASK_ALL2(NR_CPUS)
-#endif
+
 #define CPU_MASK_NONE		     MASK_NONE(NR_CPUS)
+#define cpumask_of_cpu(cpu)	     mask_of_bit((cpu), _unused_cpumask_arg_)
+#define CPU_MASK_ALL		     MASK_ALL(NR_CPUS)
+
 #define cpus_addr(mask)		     mask_addr(mask)
 #define cpumask_scnprintf(buf, len, mask) \
 			mask_scnprintf((buf), (len), (mask), NR_CPUS)
diff -Naur old/include/linux/mask.h new/include/linux/mask.h
--- old/include/linux/mask.h	2004-04-01 09:44:00.000000000 -0800
+++ new/include/linux/mask.h	2004-04-01 23:32:32.000000000 -0800
@@ -1,6 +1,3 @@
-#ifndef __LINUX_MASK_H
-#define __LINUX_MASK_H
-
 /*
  * include/linux/mask.h
  *
@@ -194,6 +191,21 @@
  *   directly, using cpus_addr() or nodes_addr().  Of course,
  *   if your masks are more than one word long, this won't
  *   be adequate.
+ *
+ * Includers of this file (such as cpumask.h or nodemask.h) must
+ *   pass in a defined symbol _NBITS_IN_THIS_MASK equal to
+ *   the number of bits in the masks they will be defining.
+ *   If that value is less-than-or-equal to the number of bits
+ *   in an unsigned long, then when the includer uses the macros
+ *   mask_of_bit or MASK_ALL, they will get the single word
+ *   (small, fast) implementations mask_of_bit1 or MASK_ALL1,
+ *   below.  If that value is greater than the number of bits in
+ *   an unsigned long, they will get the multi-word (bigger and
+ *   slower) implementations mask_of_bit2 or MASK_ALL2 instead.
+ *   This header file does _not_ use #ifndef...#endif wrappers
+ *   to suppress multiple inclusions.  Each includer needs to
+ *   see the entire file, in the context of their current value
+ *   of _NBITS_IN_THIS_MASK.
  */
 
 #include "linux/bitops.h"
@@ -331,7 +343,19 @@
 #define mask_next(bit, mask, nbits)					\
 	find_next_bit((mask)._m, (nbits), (bit)+1)
 
-#define mask_of_bit(bit, T)						\
+#define MASK_NONE(nbits)						\
+{ {									\
+	[0 ... BITS_TO_LONGS(nbits)-1] =  0UL				\
+} }
+
+#define mask_of_bit1(bit, T)						\
+({									\
+	typeof(T) m;							\
+	m._m[0] = 1UL<<(bit);						\
+	m;								\
+})
+
+#define mask_of_bit2(bit, T)						\
 ({									\
 	typeof(T) m;							\
 	mask_clearall(m, 8*sizeof(m));					\
@@ -339,23 +363,30 @@
 	m;								\
 })
 
-/* Use if nbits <= BITS_PER_LONG */
+#undef mask_of_bit
+#if _NBITS_IN_THIS_MASK <= BITS_PER_LONG
+	#define mask_of_bit mask_of_bit1
+#else
+	#define mask_of_bit mask_of_bit2
+#endif
+
 #define MASK_ALL1(nbits)						\
 { {									\
 	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
 } }
 
-/* Use if nbits > BITS_PER_LONG */
 #define MASK_ALL2(nbits)						\
 { {									\
 	[0 ... BITS_TO_LONGS(nbits)-2] = ~0UL,				\
 	[BITS_TO_LONGS(nbits)-1] = MASK_LAST_WORD(nbits)		\
 } }
 
-#define MASK_NONE(nbits)						\
-{ {									\
-	[0 ... BITS_TO_LONGS(nbits)-1] =  0UL				\
-} }
+#undef MASK_ALL
+#if _NBITS_IN_THIS_MASK <= BITS_PER_LONG
+	#define MASK_ALL MASK_ALL1
+#else
+	#define MASK_ALL MASK_ALL2
+#endif
 
 #define mask_addr(mask)							\
 	((mask)._m)
@@ -366,4 +397,4 @@
 #define mask_parse(ubuf, ulen, mask, nbits)				\
 	bitmap_parse((ubuf), (ulen), ((mask)._m), (nbits))
 
-#endif /* __LINUX_MASK_H */
+#undef _NBITS_IN_THIS_MASK
diff -Naur old/include/linux/nodemask.h new/include/linux/nodemask.h
--- old/include/linux/nodemask.h	2004-04-01 09:44:00.000000000 -0800
+++ new/include/linux/nodemask.h	2004-04-01 23:33:29.000000000 -0800
@@ -61,9 +61,10 @@
  */
 
 #include <linux/numa.h>
-#include <linux/mask.h>
 #include <asm/bug.h>
 
+#define _NBITS_IN_THIS_MASK MAX_NUMNODES
+#include <linux/mask.h>
 typedef __mask(MAX_NUMNODES) nodemask_t;
 extern nodemask_t _unused_nodemask_arg_;
 
@@ -90,14 +91,11 @@
 			mask_shift_left((dst), (src), (n), MAX_NUMNODES)
 #define first_node(mask)		mask_first((mask), MAX_NUMNODES)
 #define next_node(node, mask)		mask_next((node), (mask), MAX_NUMNODES)
-#define nodemask_of_node(node)		\
-			mask_of_bit((node), _unused_nodemask_arg_)
-#if MAX_NUMNODES <= BITS_PER_LONG
-#define NODE_MASK_ALL			MASK_ALL1(MAX_NUMNODES)
-#else
-#define NODE_MASK_ALL			MASK_ALL2(MAX_NUMNODES)
-#endif
+
 #define NODE_MASK_NONE			MASK_NONE(MAX_NUMNODES)
+#define nodemask_of_node(node)		mask_of_bit((node), _unused_nodemask_arg_)
+#define NODE_MASK_ALL			MASK_ALL(MAX_NUMNODES)
+
 #define nodes_addr(mask)			mask_addr(mask)
 #define nodemask_scnprintf(buf, len, mask) \
 			mask_scnprintf((buf), (len), (mask), MAX_NUMNODES)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
