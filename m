Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262602AbTA2Drp>; Tue, 28 Jan 2003 22:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262780AbTA2Drp>; Tue, 28 Jan 2003 22:47:45 -0500
Received: from fmr05.intel.com ([134.134.136.6]:61407 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP
	id <S262602AbTA2Dre>; Tue, 28 Jan 2003 22:47:34 -0500
Message-ID: <15927.20631.762730.598344@milikk.co.intel.com>
Date: Tue, 28 Jan 2003 19:55:03 -0800
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: [PATCH 2.5.59] Optimize include/asm-ARCH/page.h:get_order() (take 1.0)
To: falk.hueffner@student.uni-tuebingen.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
X-Mailer: VM 7.07 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi all

This patch is a reorganization and optimization of the get_order()
function. 

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
generic_fls() where not optimized]. 

On my tests in a tight loop doing repeated get_order() calls (see
included test program), I got an aprox average run time of 6m24s
for the unoptimized version (the old one, executing "time ./goo -v
speed-new") and 2m32s for the optimized version (executing "time
./goo -v speed-old"). The test machine is a 2xP3 933MHhz 1.5GB.

Even using generic_fls() on ia32 yields better results - my guess
is it caused for it being a fixed-path function instead of a for()
loop. 

I was only able to test it and try it in ia32, so I don't know if
I broke anything else in other archs; reports welcome.

CAVEATS:

- the #include <asm-generic/page.h> ... I don't know if it is the
  best way to do it. Any ideas?

- Some arches still define fls() as the generic_fls(), instead of
  using bit-searching ASM instructions - I lack the knowledge to
  fix it, though.

Changelog:

 - Pull up to 2.5.59

 - Pull up to 2.5.57

 - Pull up to 2.5.52

 - Fixes some obvious, blatant and stupid errors I did in the
   first release.

 - Increase the speed up.


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

diff -u linux/include/asm-alpha/page.h:1.1.1.2 linux/include/asm-alpha/page.h:1.1.1.1.6.4
--- linux/include/asm-alpha/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-alpha/page.h	Tue Jan 28 19:19:16 2003
@@ -2,6 +2,7 @@
 #define _ALPHA_PAGE_H
 
 #include <asm/pal.h>
+#include <asm-generic/page.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	13
@@ -60,17 +61,9 @@
 #endif /* STRICT_MM_TYPECHECKS */
 
 /* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
+static __inline__ int get_order(unsigned long size)
 {
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+        return generic_get_order (size);
 }
 
 #endif /* !__ASSEMBLY__ */
diff -u linux/include/asm-arm/page.h:1.1.1.2 linux/include/asm-arm/page.h:1.1.1.1.6.4
--- linux/include/asm-arm/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-arm/page.h	Tue Jan 28 19:19:16 2003
@@ -2,6 +2,7 @@
 #define _ASMARM_PAGE_H
 
 #include <linux/config.h>
+#include <asm-generic/page.h>
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
@@ -163,15 +164,7 @@
 /* Pure 2^n version of get_order */
 static inline int get_order(unsigned long size)
 {
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+        return generic_get_order (size);
 }
 
 #include <asm/memory.h>
diff -u /dev/null linux/include/asm-generic/page.h:1.1.2.1
--- /dev/null	Tue Jan 28 19:40:27 2003
+++ linux/include/asm-generic/page.h	Mon Dec 16 20:36:48 2002
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
diff -u linux/include/asm-i386/bitops.h:1.1.1.3 linux/include/asm-i386/bitops.h:1.1.1.3.2.3
--- linux/include/asm-i386/bitops.h:1.1.1.3	Wed Dec 11 11:13:36 2002
+++ linux/include/asm-i386/bitops.h	Mon Jan 13 18:43:43 2003
@@ -416,11 +416,19 @@
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
 
@@ -456,6 +464,23 @@
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
diff -u linux/include/asm-i386/page.h:1.1.1.2 linux/include/asm-i386/page.h:1.1.1.1.6.4
--- linux/include/asm-i386/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-i386/page.h	Tue Jan 28 19:19:16 2003
@@ -13,6 +13,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
+#include <asm-generic/page.h>
 
 #ifdef CONFIG_X86_USE_3DNOW
 
@@ -102,15 +103,7 @@
 /* Pure 2^n version of get_order */
 static __inline__ int get_order(unsigned long size)
 {
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+        return generic_get_order (size);
 }
 
 #endif /* __ASSEMBLY__ */
diff -u linux/include/asm-m68k/page.h:1.1.1.3 linux/include/asm-m68k/page.h:1.1.1.2.2.4
--- linux/include/asm-m68k/page.h:1.1.1.3	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-m68k/page.h	Tue Jan 28 19:19:16 2003
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
diff -u linux/include/asm-m68knommu/page.h:1.1.2.2 linux/include/asm-m68knommu/page.h:1.1.2.1.2.4
--- linux/include/asm-m68knommu/page.h:1.1.2.2	Thu Jan 16 18:56:22 2003
+++ linux/include/asm-m68knommu/page.h	Tue Jan 28 19:19:16 2003
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
diff -u linux/include/asm-mips/page.h:1.1.1.2 linux/include/asm-mips/page.h:1.1.1.1.6.4
--- linux/include/asm-mips/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-mips/page.h	Tue Jan 28 19:19:16 2003
@@ -46,18 +46,16 @@
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
diff -u linux/include/asm-parisc/page.h:1.1.1.2 linux/include/asm-parisc/page.h:1.1.1.1.6.4
--- linux/include/asm-parisc/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-parisc/page.h	Tue Jan 28 19:19:16 2003
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
diff -u linux/include/asm-ppc64/page.h:1.1.1.4 linux/include/asm-ppc64/page.h:1.1.1.2.2.5
--- linux/include/asm-ppc64/page.h:1.1.1.4	Thu Jan 16 18:56:22 2003
+++ linux/include/asm-ppc64/page.h	Tue Jan 28 19:19:17 2003
@@ -11,6 +11,7 @@
  */
 
 #include <linux/config.h>
+#include <asm-generic/page.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
@@ -96,19 +97,11 @@
 
 #endif
 
-/* Pure 2^n version of get_order */
 static inline int get_order(unsigned long size)
 {
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+        return generic_get_order (size);
 }
+
 
 #define __pa(x) ((unsigned long)(x)-PAGE_OFFSET)
 
diff -u linux/include/asm-s390/page.h:1.1.1.3 linux/include/asm-s390/page.h:1.1.1.2.2.4
--- linux/include/asm-s390/page.h:1.1.1.3	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-s390/page.h	Tue Jan 28 19:19:17 2003
@@ -11,6 +11,7 @@
 
 #include <asm/setup.h>
 #include <asm/types.h>
+#include <asm-generic/page.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT      12
@@ -63,17 +64,9 @@
 #define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
 /* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
+static __inline__ int get_order(unsigned long size)
 {
-        int order;
-
-        size = (size-1) >> (PAGE_SHIFT-1);
-        order = -1;
-        do {
-                size >>= 1;
-                order++;
-        } while (size);
-        return order;
+        return generic_get_order (size);
 }
 
 /*
diff -u linux/include/asm-s390x/page.h:1.1.1.2 linux/include/asm-s390x/page.h:1.1.1.1.6.4
--- linux/include/asm-s390x/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-s390x/page.h	Tue Jan 28 19:19:17 2003
@@ -10,6 +10,7 @@
 #define _S390_PAGE_H
 
 #include <asm/setup.h>
+#include <asm-generic/page.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT      12
@@ -61,17 +62,9 @@
 #define copy_user_page(to, from, vaddr, pg) copy_page(to, from)
 
 /* Pure 2^n version of get_order */
-extern __inline__ int get_order(unsigned long size)
+static __inline__ int get_order(unsigned long size)
 {
-        int order;
-
-        size = (size-1) >> (PAGE_SHIFT-1);
-        order = -1;
-        do {
-                size >>= 1;
-                order++;
-        } while (size);
-        return order;
+        return generic_get_order (size);
 }
 
 /*
diff -u linux/include/asm-sh/page.h:1.1.1.2 linux/include/asm-sh/page.h:1.1.1.1.6.4
--- linux/include/asm-sh/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-sh/page.h	Tue Jan 28 19:19:17 2003
@@ -14,6 +14,7 @@
  */
 
 #include <linux/config.h>
+#include <asm-generic/page.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
@@ -93,16 +94,9 @@
 /* Pure 2^n version of get_order */
 static __inline__ int get_order(unsigned long size)
 {
-	int order;
-
-	size = (size-1) >> (PAGE_SHIFT-1);
-	order = -1;
-	do {
-		size >>= 1;
-		order++;
-	} while (size);
-	return order;
+        return generic_get_order (size);
 }
+
 
 #endif
 
diff -u linux/include/asm-sparc/page.h:1.1.1.3 linux/include/asm-sparc/page.h:1.1.1.2.2.4
--- linux/include/asm-sparc/page.h:1.1.1.3	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-sparc/page.h	Tue Jan 28 19:19:17 2003
@@ -127,19 +127,18 @@
 
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
 
diff -u linux/include/asm-sparc64/page.h:1.1.1.2 linux/include/asm-sparc64/page.h:1.1.1.1.6.4
--- linux/include/asm-sparc64/page.h:1.1.1.2	Mon Jan 13 23:03:09 2003
+++ linux/include/asm-sparc64/page.h	Tue Jan 28 19:19:17 2003
@@ -149,18 +149,16 @@
 
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
diff -u linux/include/asm-v850/page.h:1.1.2.1 linux/include/asm-v850/page.h:1.1.2.1.2.3
--- linux/include/asm-v850/page.h:1.1.2.1	Wed Dec 11 11:07:56 2002
+++ linux/include/asm-v850/page.h	Mon Jan 13 18:44:01 2003
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
 
diff -u linux/include/asm-x86_64/page.h:1.1.1.3 linux/include/asm-x86_64/page.h:1.1.1.1.6.5
--- linux/include/asm-x86_64/page.h:1.1.1.3	Thu Jan 16 18:56:22 2003
+++ linux/include/asm-x86_64/page.h	Tue Jan 28 19:19:17 2003
@@ -71,19 +71,18 @@
 
 #include <asm/bug.h>
 
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
