Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbSKNBDs>; Wed, 13 Nov 2002 20:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSKNBDs>; Wed, 13 Nov 2002 20:03:48 -0500
Received: from fmr05.intel.com ([134.134.136.6]:5062 "EHLO hermes.jf.intel.com")
	by vger.kernel.org with ESMTP id <S261173AbSKNBDg>;
	Wed, 13 Nov 2002 20:03:36 -0500
Subject: [PATCH] Optimize linux/include/asm-ARCH/page.h:get_order() take 2
To: falk.hueffner@student.uni-tuebingen.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Message-Id: <E18C8Sf-00041C-00@milikk>
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Date: Wed, 13 Nov 2002 17:06:25 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all

This patch is a reorganization and optimization of the get_order()
function. It also fixes some obvious, blatant and stupid errors I
did in the first release; the speed up is also higher.

Currently each architecture defines its version in
asm-${ARCH}/page.h, being most of them the same function. I have
unified the implementation in asm-generic/page.h, as
generic_get_order(). Then each arch can implement it's own version
or use the generic one [as the patch stands now, every
architecture that had the generic version uses
generic_get_oder()].

The optimization is done in the way the generic_get_order() is
implemented; currently it is a loop - however, that can be highly
optimized by using fls() [available on each architecture or as
generic_tls() where not optimized]. 

On my tests in a tight loop doing repeated get_order() calls (see
included test program), I got an aprox average run time of 6m24s
for the unoptimized version (the old one, executing "time ./goo -v
speed-new") and 2m32s for the optimized version (executing "time
./goo -v speed-old"). The test machine is a 2xP3 933MHhz 1.5GB.

Even using generic_fls() on ia32 yields better results - my guess
is it caused for it being a fixed-path functio instead of a for
loop. 

I was only able to test it and try it in ia32, so I don't know if
I broke anything else in other archs; reports welcome.

CAVEATS:

- the #include <asm-generic/page.h> ... I don't know if it is the
  best way to do it. Any ideas?

- Some arches still define fls() as the generic_fls(), instead of
  using bit-searching ASM instructions - I lack the knowledge to
  fix it, though.


Test program (patch follows):

compile with 'cc -Iinclude/ -Wall -g -O2 goo.c -o goo' from the
root of the patched linux kernel tree.

#define __KERNEL__
#define __ASSEMBLY__

#include "asm-i386/bitops.h"
#include "asm-i386/page.h"
#include "asm-generic/page.h"
#include <stdio.h>
#include <getopt.h>
#include <stdlib.h>

  /* Old, unoptimized version */

static __inline__
int get_order_0 (unsigned long size)
{
  int order;
  
  size = (size-1) >> (PAGE_SHIFT-1);
  order = -1;
  do {
    size >>= 1;
    order++;
  } while (size);
  return order;
}

unsigned long verbose_step = 0;

static __inline__
void progress (unsigned long cnt)
{
  if (verbose_step && (cnt % verbose_step) == 0)
    printf ("Going through %lu\n", cnt);
}


void help (FILE *f)
{
  fprintf (f,
           "Usage: goo [-b BOTTOM] [-t TOP] [-s STEP] [-v VSTEP] [-h]\n"
           "           {verify,speed-new,speed-old}\n"
           "\n"
           "-b BOTTOM where to start counting [0]\n"
           "-t TOP    where to stop counting [~0UL]\n"
           "-s STEP   count increment [1]\n"
           "-v VSTEP  Every VSTEP report the count [0]\n"
           "\n"
           "verify     Verify that the old and new implementations behave the same\n"
           "           from BOTTOM to TOP with STEP.\n"
           "\n"
           "speed-new  Call the optimized get_order() for all the numbers from\n"
           "           BOTTOM to TOP with STEP.\n"
           "\n"
           "speed-old  Call the original get_order() for all the numbers from\n"
           "           BOTTOM to TOP with STEP.\n"
           "\n"
           "It is nice to have a wide range, so that the timing is better; use -v\n"
           "if you want reporting because it feels nice. The default range covers\n"
           "all that an unsigned long can hold.\n"
    );
}



  /* Test driver
  **
  ** We just count from 0 to ~0UL; in verify mode, we verify that
  ** _every_ number get's the same order with the old and new
  ** versions. In the speed mode we just run in a tight loop so that
  ** it can be rawly measured how fast is the new version (speed-new)
  ** against the old version (speed-old). time(1) is your friend.
  */

int main (int argc, char **argv)
{
  const char *mode;
  int opterr, c;
  unsigned long bottom = 0,
    top = ~0UL,
    step = 1,
    dummy = 0,
    cnt;
  
  opterr = 0;  
  
  while ((c = getopt (argc, argv, "b:t:s:v:h")) != -1)
    switch (c) {
     case 'b':
      bottom = strtoul (optarg, NULL, 10);
      break;
     case 't':
      top = strtoul (optarg, NULL, 10);
      break;
     case 's':
      step = strtoul (optarg, NULL, 10);
      break;
     case 'v':
      verbose_step = strtoul (optarg, NULL, 10);
      break;
     case 'h':
      help (stdout);
      exit (0);
      break;
     case '?':
     default:
      fprintf (stderr, "Unknown option %s\n", argv[optind]);
      help (stderr);
      exit (1);
    }

  if (argc < 2) {
    help (stderr);
    return 1;
  }
  
  mode = argv[optind];

  if (!strcmp (mode, "verify")) {
    for (cnt = bottom; cnt < top; cnt += step) {
      if (get_order_0 (cnt) != generic_get_order (cnt))
        printf ("error: %lu - different results\n", cnt);
      progress (cnt);
    }
  }
  else if (!strcmp (mode, "speed-old")) {
    for (cnt = bottom; cnt < top; cnt += step) {
      dummy += get_order_0 (cnt);
      progress (cnt);
    }
  }
  else if (!strcmp (mode, "speed-new")) {
    for (cnt = bottom; cnt < top; cnt += step) {
      dummy += generic_get_order (cnt);
      progress (cnt);
    }
  }
  else {
    fprintf (stderr, "Unknown mode\n");
    help (stderr);
    exit (1);
  }
  printf ("accumulated dummy = %lu\n", dummy);
  return 0;
}

/*
** Local Variables:
**   compile-command: "cc -Iinclude/ -Wall -g -O2 goo.c -o goo"
** End:
*/


This patch is against 2.5.47.


diff -u include/asm-alpha/page.h:1.1.1.1 include/asm-alpha/page.h:1.1.1.1.16.1
--- include/asm-alpha/page.h:1.1.1.1	Tue Oct  8 19:47:09 2002
+++ include/asm-alpha/page.h	Tue Nov 12 16:49:22 2002
@@ -67,18 +67,17 @@
 
 #define PAGE_BUG(page)	BUG()
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
+
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 #endif /* !__ASSEMBLY__ */

diff -u include/asm-arm/page.h:1.1.1.2 include/asm-arm/page.h:1.1.1.2.10.1
--- include/asm-arm/page.h:1.1.1.2	Thu Oct 17 13:08:30 2002
+++ include/asm-arm/page.h	Tue Nov 12 16:49:22 2002
@@ -175,18 +175,16 @@
 
 #endif
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 #include <asm/memory.h>

diff -u /dev/null include/asm-generic/page.h:1.1.2.2
--- /dev/null	Wed Nov 13 17:05:37 2002
+++ include/asm-generic/page.h	Wed Nov 13 14:58:51 2002
@@ -0,0 +1,20 @@
+#ifndef _GENERIC_PAGE_H
+#define _GENERIC_PAGE_H
+
+#include <asm/bitops.h>
+
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+static __inline__
+int generic_get_order (unsigned long s)
+{
+        s = (s - 1) >> PAGE_SHIFT;
+        if (s == 0)
+                return 0;
+        return fls (s);
+}
+
+#endif _GENERIC_PAGE_H
+

diff -u include/asm-i386/bitops.h:1.1.1.2 include/asm-i386/bitops.h:1.1.1.2.4.1
--- include/asm-i386/bitops.h:1.1.1.2	Mon Nov 11 20:02:12 2002
+++ include/asm-i386/bitops.h	Tue Nov 12 16:49:22 2002
@@ -414,11 +414,19 @@
 	return word;
 }
 
-/*
- * fls: find last bit set.
+/**
+ * __fls - find last bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
  */
-
-#define fls(x) generic_fls(x)
+static __inline__ unsigned long __fls(unsigned long word)
+{
+	__asm__("bsrl %1,%0"
+		:"=r" (word)
+		:"rm" (word));
+	return word;
+}
 
 #ifdef __KERNEL__
 
@@ -454,6 +462,23 @@
 	int r;
 
 	__asm__("bsfl %1,%0\n\t"
+		"jnz 1f\n\t"
+		"movl $-1,%0\n"
+		"1:" : "=r" (r) : "g" (x));
+	return r+1;
+}
+
+/**
+ * fls - find last bit set
+ * @x: the word to search
+ *
+ * Check out comments for ffs()
+ */
+static __inline__ int fls(int x)
+{
+	int r;
+
+	__asm__("bsrl %1,%0\n\t"
 		"jnz 1f\n\t"
 		"movl $-1,%0\n"
 		"1:" : "=r" (r) : "g" (x));

diff -u include/asm-i386/page.h:1.1.1.2 include/asm-i386/page.h:1.1.1.2.10.1
--- include/asm-i386/page.h:1.1.1.2	Thu Oct 17 13:06:36 2002
+++ include/asm-i386/page.h	Tue Nov 12 16:49:22 2002
@@ -120,18 +120,17 @@
 	BUG(); \
 } while (0)
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
+
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 #endif /* __ASSEMBLY__ */

diff -u include/asm-m68k/page.h:1.1.1.2 include/asm-m68k/page.h:1.1.1.2.4.1
--- include/asm-m68k/page.h:1.1.1.2	Mon Nov  4 18:10:53 2002
+++ include/asm-m68k/page.h	Tue Nov 12 16:49:22 2002
@@ -100,18 +100,17 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
+
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 #endif /* !__ASSEMBLY__ */

diff -u include/asm-m68knommu/page.h:1.1.2.1 include/asm-m68knommu/page.h:1.1.2.1.4.1
--- include/asm-m68knommu/page.h:1.1.2.1	Mon Nov  4 18:10:53 2002
+++ include/asm-m68knommu/page.h	Tue Nov 12 16:49:22 2002
@@ -51,19 +51,18 @@
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
+
 
 extern unsigned long memory_start;
 extern unsigned long memory_end;

diff -u include/asm-mips/page.h:1.1.1.1 include/asm-mips/page.h:1.1.1.1.16.1
--- include/asm-mips/page.h:1.1.1.1	Tue Oct  8 19:47:08 2002
+++ include/asm-mips/page.h	Tue Nov 12 16:49:22 2002
@@ -49,18 +49,16 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 #endif /* _LANGUAGE_ASSEMBLY */

diff -u include/asm-parisc/page.h:1.1.1.2 include/asm-parisc/page.h:1.1.1.2.6.1
--- include/asm-parisc/page.h:1.1.1.2	Thu Oct 31 15:28:28 2002
+++ include/asm-parisc/page.h	Tue Nov 12 16:49:22 2002
@@ -53,19 +53,18 @@
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
+
 
 #ifdef __LP64__
 #define MAX_PHYSMEM_RANGES 8 /* Fix the size for now (current known max is 3) */

diff -u include/asm-ppc64/page.h:1.1.1.1 include/asm-ppc64/page.h:1.1.1.1.16.1
--- include/asm-ppc64/page.h:1.1.1.1	Tue Oct  8 19:47:06 2002
+++ include/asm-ppc64/page.h	Tue Nov 12 16:49:22 2002
@@ -119,19 +119,18 @@
 
 #define PAGE_BUG(page) do { BUG(); } while (0)
 
-/* Pure 2^n version of get_order */
-static inline int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
+
 
 #define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
 

diff -u include/asm-s390/page.h:1.1.1.1 include/asm-s390/page.h:1.1.1.1.16.1
--- include/asm-s390/page.h:1.1.1.1	Tue Oct  8 19:47:08 2002
+++ include/asm-s390/page.h	Tue Nov 12 16:49:22 2002
@@ -71,18 +71,16 @@
         BUG(); \
 } while (0)                      
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-        int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-        size = (size-1) >> (PAGE_SHIFT-1);
-        order = -1;
-        do {
-                size >>= 1;
-                order++;
-        } while (size);
-        return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 /*

diff -u include/asm-s390x/page.h:1.1.1.1 include/asm-s390x/page.h:1.1.1.1.16.1
--- include/asm-s390x/page.h:1.1.1.1	Tue Oct  8 19:47:05 2002
+++ include/asm-s390x/page.h	Tue Nov 12 16:49:22 2002
@@ -69,18 +69,16 @@
         BUG(); \
 } while (0)                      
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-        int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-        size = (size-1) >> (PAGE_SHIFT-1);
-        order = -1;
-        do {
-                size >>= 1;
-                order++;
-        } while (size);
-        return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 /*

diff -u include/asm-sh/page.h:1.1.1.1 include/asm-sh/page.h:1.1.1.1.16.1
--- include/asm-sh/page.h:1.1.1.1	Tue Oct  8 19:47:10 2002
+++ include/asm-sh/page.h	Tue Nov 12 16:49:22 2002
@@ -102,19 +102,18 @@
 	BUG(); \
 } while (0)
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
+
 
 #endif
 

diff -u include/asm-sparc/page.h:1.1.1.1 include/asm-sparc/page.h:1.1.1.1.16.1
--- include/asm-sparc/page.h:1.1.1.1	Tue Oct  8 19:47:09 2002
+++ include/asm-sparc/page.h	Tue Nov 12 16:49:22 2002
@@ -147,19 +147,18 @@
 
 #define TASK_UNMAPPED_BASE	BTFIXUP_SETHI(sparc_unmapped_base)
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
+
 
 #else /* !(__ASSEMBLY__) */
 

diff -u include/asm-sparc64/page.h:1.1.1.2 include/asm-sparc64/page.h:1.1.1.2.6.1
--- include/asm-sparc64/page.h:1.1.1.2	Thu Oct 31 15:28:29 2002
+++ include/asm-sparc64/page.h	Tue Nov 12 16:49:22 2002
@@ -161,18 +161,16 @@
 
 extern struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS];
 
-/* Pure 2^n version of get_order */
-static __inline__ int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
 
 #endif /* !(__ASSEMBLY__) */

diff -u include/asm-v850/page.h:1.1.2.1 include/asm-v850/page.h:1.1.2.1.4.1
--- include/asm-v850/page.h:1.1.2.1	Mon Nov  4 18:10:54 2002
+++ include/asm-v850/page.h	Tue Nov 12 16:49:22 2002
@@ -98,19 +98,18 @@
 #define BUG()		__bug()
 #define PAGE_BUG(page)	__bug()
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order (unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
+
 
 #endif /* !__ASSEMBLY__ */
 

diff -u include/asm-x86_64/page.h:1.1.1.2 include/asm-x86_64/page.h:1.1.1.2.10.1
--- include/asm-x86_64/page.h:1.1.1.2	Thu Oct 17 13:08:31 2002
+++ include/asm-x86_64/page.h	Tue Nov 12 16:49:22 2002
@@ -80,19 +80,18 @@
 #define PAGE_BUG(page) BUG()
 void out_of_line_bug(void);
 
-/* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
+/* Return 'n' in how many 2^n pages are needed to store s bytes.
+** (n == 0 for s == 0)
+*/
+
+#include <asm-generic/page.h>
 
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+static __inline__
+int get_order (unsigned long s)
+{
+        return generic_get_order (s);
 }
+
 
 #endif /* __ASSEMBLY__ */
 


-- 

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my fault]
