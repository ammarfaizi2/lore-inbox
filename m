Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSHKHbb>; Sun, 11 Aug 2002 03:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318111AbSHKHbF>; Sun, 11 Aug 2002 03:31:05 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44806 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318155AbSHKH0e>;
	Sun, 11 Aug 2002 03:26:34 -0400
Message-ID: <3D5614DC.635ED602@zip.com.au>
Date: Sun, 11 Aug 2002 00:40:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 19/21] introduce L1_CACHE_SHIFT_MAX
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



zone->lock and zone->lru_lock are two of the hottest locks in the
kernel.  Their usage patterns are quite independent.  And they have
just been put into the same structure.  It is essential that they not
fall into the same cacheline.

That could be fixed by padding with L1_CACHE_BYTES.  But the problem
with this is that a kernel which was configured for (say) a PIII will
perform poorly on SMP PIV.  This will cause problems for kernel
vendors.  For example, RH currently ship PII and Athlon binaries.  To
get best SMP performance they will end up needing to ship a lot of
differently configured kernels.

To solve this we need to know, at compile time, the maximum L1 size
which this kernel will ever run on.

This patch adds L1_CACHE_SHIFT_MAX to every architecture's cache.h.

Of course it'll break when newer chips come out with increased
cacheline sizes.   Better suggestions are welcome.



 asm-alpha/cache.h   |    1 +
 asm-arm/cache.h     |    2 ++
 asm-cris/cache.h    |    2 ++
 asm-i386/cache.h    |    2 ++
 asm-ia64/cache.h    |    2 ++
 asm-m68k/cache.h    |    2 ++
 asm-mips/cache.h    |    1 +
 asm-mips64/cache.h  |    1 +
 asm-parisc/cache.h  |    1 +
 asm-ppc/cache.h     |    1 +
 asm-ppc64/cache.h   |    1 +
 asm-s390/cache.h    |    1 +
 asm-s390x/cache.h   |    1 +
 asm-sh/cache.h      |    2 ++
 asm-sparc/cache.h   |    1 +
 asm-sparc64/cache.h |    1 +
 asm-x86_64/cache.h  |    1 +
 linux/cache.h       |    9 +++++++++
 18 files changed, 32 insertions(+)

--- 2.5.31/include/linux/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/linux/cache.h	Sun Aug 11 00:20:35 2002
@@ -44,4 +44,13 @@
 #endif /* CONFIG_SMP */
 #endif
 
+#if !defined(____cacheline_maxaligned_in_smp)
+#if defined(CONFIG_SMP)
+#define ____cacheline_maxaligned_in_smp \
+	__attribute__((__aligned__(1 << (L1_CACHE_SHIFT_MAX))))
+#else
+#define ____cacheline_maxaligned_in_smp
+#endif
+#endif
+
 #endif /* __LINUX_CACHE_H */
--- 2.5.31/include/asm-alpha/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-alpha/cache.h	Sun Aug 11 00:20:35 2002
@@ -20,5 +20,6 @@
 
 #define L1_CACHE_ALIGN(x)  (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 #define SMP_CACHE_BYTES    L1_CACHE_BYTES
+#define L1_CACHE_SHIFT_MAX 6	/* largest L1 which this arch supports */
 
 #endif
--- 2.5.31/include/asm-arm/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-arm/cache.h	Sun Aug 11 00:20:35 2002
@@ -16,4 +16,6 @@
 		 __section__(".data.cacheline_aligned")))
 #endif
 
+#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
+
 #endif
--- 2.5.31/include/asm-cris/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-cris/cache.h	Sun Aug 11 00:20:35 2002
@@ -7,4 +7,6 @@
 
 #define L1_CACHE_BYTES 32
 
+#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
+
 #endif /* _ASM_CACHE_H */
--- 2.5.31/include/asm-i386/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-i386/cache.h	Sun Aug 11 00:20:35 2002
@@ -10,4 +10,6 @@
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
 
+#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
+
 #endif
--- 2.5.31/include/asm-ia64/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-ia64/cache.h	Sun Aug 11 00:20:35 2002
@@ -12,6 +12,8 @@
 #define L1_CACHE_SHIFT		CONFIG_IA64_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
+#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
+
 #ifdef CONFIG_SMP
 # define SMP_CACHE_SHIFT	L1_CACHE_SHIFT
 # define SMP_CACHE_BYTES	L1_CACHE_BYTES
--- 2.5.31/include/asm-m68k/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-m68k/cache.h	Sun Aug 11 00:20:35 2002
@@ -8,4 +8,6 @@
 #define        L1_CACHE_SHIFT  4
 #define        L1_CACHE_BYTES  (1<< L1_CACHE_SHIFT)
 
+#define L1_CACHE_SHIFT_MAX 4	/* largest L1 which this arch supports */
+
 #endif
--- 2.5.31/include/asm-mips/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-mips/cache.h	Sun Aug 11 00:20:35 2002
@@ -35,5 +35,6 @@ struct cache_desc {
 #endif
 
 #define SMP_CACHE_BYTES		L1_CACHE_BYTES
+#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
 
 #endif /* _ASM_CACHE_H */
--- 2.5.31/include/asm-mips64/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-mips64/cache.h	Sun Aug 11 00:20:35 2002
@@ -11,5 +11,6 @@
 
 /* bytes per L1 cache line */
 #define L1_CACHE_BYTES		(1 << CONFIG_L1_CACHE_SHIFT)
+#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
 
 #endif /* _ASM_CACHE_H */
--- 2.5.31/include/asm-parisc/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-parisc/cache.h	Sun Aug 11 00:20:35 2002
@@ -34,6 +34,7 @@
 #define L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
+#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
 
 #define __cacheline_aligned __attribute__((__aligned__(L1_CACHE_BYTES)))
 
--- 2.5.31/include/asm-ppc/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-ppc/cache.h	Sun Aug 11 00:20:35 2002
@@ -28,6 +28,7 @@
 
 #define	L1_CACHE_BYTES L1_CACHE_LINE_SIZE
 #define	SMP_CACHE_BYTES L1_CACHE_BYTES
+#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
 
 #define	L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
 #define	L1_CACHE_PAGES		8
--- 2.5.31/include/asm-ppc64/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-ppc64/cache.h	Sun Aug 11 00:20:35 2002
@@ -12,5 +12,6 @@
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
 
 #define SMP_CACHE_BYTES L1_CACHE_BYTES
+#define L1_CACHE_SHIFT_MAX 7	/* largest L1 which this arch supports */
 
 #endif
--- 2.5.31/include/asm-s390/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-s390/cache.h	Sun Aug 11 00:20:35 2002
@@ -13,5 +13,6 @@
 
 #define L1_CACHE_BYTES     256
 #define L1_CACHE_SHIFT     8
+#define L1_CACHE_SHIFT_MAX 8	/* largest L1 which this arch supports */
 
 #endif
--- 2.5.31/include/asm-s390x/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-s390x/cache.h	Sun Aug 11 00:20:35 2002
@@ -13,5 +13,6 @@
 
 #define L1_CACHE_BYTES     256
 #define L1_CACHE_SHIFT     8
+#define L1_CACHE_SHIFT_MAX 8	/* largest L1 which this arch supports */
 
 #endif
--- 2.5.31/include/asm-sh/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-sh/cache.h	Sun Aug 11 00:20:35 2002
@@ -14,4 +14,6 @@
 #define        L1_CACHE_BYTES  32
 #endif
 
+#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
+
 #endif /* __ASM_SH_CACHE_H */
--- 2.5.31/include/asm-sparc/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-sparc/cache.h	Sun Aug 11 00:20:35 2002
@@ -13,6 +13,7 @@
 #define L1_CACHE_SHIFT 5
 #define L1_CACHE_BYTES 32
 #define L1_CACHE_ALIGN(x) ((((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1)))
+#define L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
 
 #define SMP_CACHE_BYTES 32
 
--- 2.5.31/include/asm-sparc64/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-sparc64/cache.h	Sun Aug 11 00:20:35 2002
@@ -9,6 +9,7 @@
 #define        L1_CACHE_BYTES	32 /* Two 16-byte sub-blocks per line. */
 
 #define        L1_CACHE_ALIGN(x)       (((x)+(L1_CACHE_BYTES-1))&~(L1_CACHE_BYTES-1))
+#define		L1_CACHE_SHIFT_MAX 5	/* largest L1 which this arch supports */
 
 #define        SMP_CACHE_BYTES_SHIFT	6
 #define        SMP_CACHE_BYTES		(1 << SMP_CACHE_BYTES_SHIFT) /* L2 cache line size. */
--- 2.5.31/include/asm-x86_64/cache.h~l1-max-size	Sun Aug 11 00:20:35 2002
+++ 2.5.31-akpm/include/asm-x86_64/cache.h	Sun Aug 11 00:20:35 2002
@@ -9,5 +9,6 @@
 /* L1 cache line size */
 #define L1_CACHE_SHIFT	(CONFIG_X86_L1_CACHE_SHIFT)
 #define L1_CACHE_BYTES	(1 << L1_CACHE_SHIFT)
+#define L1_CACHE_SHIFT_MAX 6	/* largest L1 which this arch supports */
 
 #endif

.
