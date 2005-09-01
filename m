Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbVIAUCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbVIAUCW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 16:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbVIAUCV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 16:02:21 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:391 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030344AbVIAUCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 16:02:20 -0400
Date: Thu, 1 Sep 2005 22:02:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] m68k: cleanup inline mem functions
Message-ID: <Pine.LNX.4.61.0509012201170.7247@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use the builtin functions for memset/memclr/memcpy, special optimizations 
for page operations have dedicated functions now. Uninline memmove/memchr 
and move all functions into a single file and clean it up a little.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/kernel/m68k_ksyms.c |    4 
 arch/m68k/lib/Makefile        |    2 
 arch/m68k/lib/memcmp.c        |   11 -
 arch/m68k/lib/memcpy.c        |   75 -------
 arch/m68k/lib/memset.c        |   68 -------
 arch/m68k/lib/string.c        |  237 ++++++++++++++++++++++++
 include/asm-m68k/string.h     |  403 ------------------------------------------
 7 files changed, 245 insertions(+), 555 deletions(-)

Index: linux-2.6/arch/m68k/kernel/m68k_ksyms.c
===================================================================
--- linux-2.6.orig/arch/m68k/kernel/m68k_ksyms.c	2004-10-19 19:30:58.000000000 +0200
+++ linux-2.6/arch/m68k/kernel/m68k_ksyms.c	2005-08-30 13:45:31.611933547 +0200
@@ -74,10 +74,6 @@ EXPORT_SYMBOL(vme_brdtype);
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__lshrdi3);
-EXPORT_SYMBOL(memcpy);
-EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(memcmp);
-EXPORT_SYMBOL(memscan);
 EXPORT_SYMBOL(__muldi3);
 
 EXPORT_SYMBOL(__down_failed);
Index: linux-2.6/arch/m68k/lib/Makefile
===================================================================
--- linux-2.6.orig/arch/m68k/lib/Makefile	2003-07-18 23:21:48.000000000 +0200
+++ linux-2.6/arch/m68k/lib/Makefile	2005-08-30 13:44:33.806824983 +0200
@@ -5,4 +5,4 @@
 EXTRA_AFLAGS := -traditional
 
 lib-y		:= ashldi3.o ashrdi3.o lshrdi3.o muldi3.o \
-			checksum.o memcmp.o memcpy.o memset.o semaphore.o
+			checksum.o string.o semaphore.o
Index: linux-2.6/arch/m68k/lib/memcmp.c
===================================================================
--- linux-2.6.orig/arch/m68k/lib/memcmp.c	2003-07-18 23:21:48.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,11 +0,0 @@
-#include <linux/types.h>
-
-int memcmp(const void * cs,const void * ct,size_t count)
-{
-  const unsigned char *su1, *su2;
-
-  for( su1 = cs, su2 = ct; 0 < count; ++su1, ++su2, count--)
-    if (*su1 != *su2)
-      return((*su1 < *su2) ? -1 : +1);
-  return(0);
-}
Index: linux-2.6/arch/m68k/lib/memcpy.c
===================================================================
--- linux-2.6.orig/arch/m68k/lib/memcpy.c	2003-07-18 23:21:48.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,75 +0,0 @@
-#include <linux/types.h>
-
-void * memcpy(void * to, const void * from, size_t n)
-{
-  void *xto = to;
-  size_t temp, temp1;
-
-  if (!n)
-    return xto;
-  if ((long) to & 1)
-    {
-      char *cto = to;
-      const char *cfrom = from;
-      *cto++ = *cfrom++;
-      to = cto;
-      from = cfrom;
-      n--;
-    }
-  if (n > 2 && (long) to & 2)
-    {
-      short *sto = to;
-      const short *sfrom = from;
-      *sto++ = *sfrom++;
-      to = sto;
-      from = sfrom;
-      n -= 2;
-    }
-  temp = n >> 2;
-  if (temp)
-    {
-      long *lto = to;
-      const long *lfrom = from;
-
-      __asm__ __volatile__("movel %2,%3\n\t"
-			   "andw  #7,%3\n\t"
-			   "lsrl  #3,%2\n\t"
-			   "negw  %3\n\t"
-			   "jmp   %%pc@(1f,%3:w:2)\n\t"
-			   "4:\t"
-			   "movel %0@+,%1@+\n\t"
-			   "movel %0@+,%1@+\n\t"
-			   "movel %0@+,%1@+\n\t"
-			   "movel %0@+,%1@+\n\t"
-			   "movel %0@+,%1@+\n\t"
-			   "movel %0@+,%1@+\n\t"
-			   "movel %0@+,%1@+\n\t"
-			   "movel %0@+,%1@+\n\t"
-			   "1:\t"
-			   "dbra  %2,4b\n\t"
-			   "clrw  %2\n\t"
-			   "subql #1,%2\n\t"
-			   "jpl   4b\n\t"
-			   : "=a" (lfrom), "=a" (lto), "=d" (temp),
-			   "=&d" (temp1)
-			   : "0" (lfrom), "1" (lto), "2" (temp)
-			   );
-      to = lto;
-      from = lfrom;
-    }
-  if (n & 2)
-    {
-      short *sto = to;
-      const short *sfrom = from;
-      *sto++ = *sfrom++;
-      to = sto;
-      from = sfrom;
-    }
-  if (n & 1)
-    {
-      char *cto = to;
-      const char *cfrom = from;
-      *cto = *cfrom;
-    }
-  return xto;
-}
Index: linux-2.6/arch/m68k/lib/memset.c
===================================================================
--- linux-2.6.orig/arch/m68k/lib/memset.c	2003-07-18 23:21:48.000000000 +0200
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,68 +0,0 @@
-#include <linux/types.h>
-
-void * memset(void * s, int c, size_t count)
-{
-  void *xs = s;
-  size_t temp, temp1;
-
-  if (!count)
-    return xs;
-  c &= 0xff;
-  c |= c << 8;
-  c |= c << 16;
-  if ((long) s & 1)
-    {
-      char *cs = s;
-      *cs++ = c;
-      s = cs;
-      count--;
-    }
-  if (count > 2 && (long) s & 2)
-    {
-      short *ss = s;
-      *ss++ = c;
-      s = ss;
-      count -= 2;
-    }
-  temp = count >> 2;
-  if (temp)
-    {
-      long *ls = s;
-
-      __asm__ __volatile__("movel %1,%2\n\t"
-			   "andw  #7,%2\n\t"
-			   "lsrl  #3,%1\n\t"
-			   "negw  %2\n\t"
-			   "jmp   %%pc@(2f,%2:w:2)\n\t"
-			   "1:\t"
-			   "movel %3,%0@+\n\t"
-			   "movel %3,%0@+\n\t"
-			   "movel %3,%0@+\n\t"
-			   "movel %3,%0@+\n\t"
-			   "movel %3,%0@+\n\t"
-			   "movel %3,%0@+\n\t"
-			   "movel %3,%0@+\n\t"
-			   "movel %3,%0@+\n\t"
-			   "2:\t"
-			   "dbra  %1,1b\n\t"
-			   "clrw  %1\n\t"
-			   "subql #1,%1\n\t"
-			   "jpl   1b\n\t"
-			   : "=a" (ls), "=d" (temp), "=&d" (temp1)
-			   : "d" (c), "0" (ls), "1" (temp)
-			   );
-      s = ls;
-    }
-  if (count & 2)
-    {
-      short *ss = s;
-      *ss++ = c;
-      s = ss;
-    }
-  if (count & 1)
-    {
-      char *cs = s;
-      *cs = c;
-    }
-  return xs;
-}
Index: linux-2.6/arch/m68k/lib/string.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/m68k/lib/string.c	2005-08-30 13:44:33.808824641 +0200
@@ -0,0 +1,237 @@
+
+#include <linux/types.h>
+#include <linux/module.h>
+
+void *memset(void *s, int c, size_t count)
+{
+	void *xs = s;
+	size_t temp, temp1;
+
+	if (!count)
+		return xs;
+	c &= 0xff;
+	c |= c << 8;
+	c |= c << 16;
+	if ((long)s & 1) {
+		char *cs = s;
+		*cs++ = c;
+		s = cs;
+		count--;
+	}
+	if (count > 2 && (long)s & 2) {
+		short *ss = s;
+		*ss++ = c;
+		s = ss;
+		count -= 2;
+	}
+	temp = count >> 2;
+	if (temp) {
+		long *ls = s;
+
+		asm volatile (
+			"	movel %1,%2\n"
+			"	andw  #7,%2\n"
+			"	lsrl  #3,%1\n"
+			"	negw  %2\n"
+			"	jmp   %%pc@(2f,%2:w:2)\n"
+			"1:	movel %3,%0@+\n"
+			"	movel %3,%0@+\n"
+			"	movel %3,%0@+\n"
+			"	movel %3,%0@+\n"
+			"	movel %3,%0@+\n"
+			"	movel %3,%0@+\n"
+			"	movel %3,%0@+\n"
+			"	movel %3,%0@+\n"
+			"2:	dbra  %1,1b\n"
+			"	clrw  %1\n"
+			"	subql #1,%1\n"
+			"	jpl   1b"
+			: "=a" (ls), "=d" (temp), "=&d" (temp1)
+			: "d" (c), "0" (ls), "1" (temp));
+		s = ls;
+	}
+	if (count & 2) {
+		short *ss = s;
+		*ss++ = c;
+		s = ss;
+	}
+	if (count & 1) {
+		char *cs = s;
+		*cs = c;
+	}
+	return xs;
+}
+EXPORT_SYMBOL(memset);
+
+void *memcpy(void *to, const void *from, size_t n)
+{
+	void *xto = to;
+	size_t temp, temp1;
+
+	if (!n)
+		return xto;
+	if ((long)to & 1) {
+		char *cto = to;
+		const char *cfrom = from;
+		*cto++ = *cfrom++;
+		to = cto;
+		from = cfrom;
+		n--;
+	}
+	if (n > 2 && (long)to & 2) {
+		short *sto = to;
+		const short *sfrom = from;
+		*sto++ = *sfrom++;
+		to = sto;
+		from = sfrom;
+		n -= 2;
+	}
+	temp = n >> 2;
+	if (temp) {
+		long *lto = to;
+		const long *lfrom = from;
+
+		asm volatile (
+			"	movel %2,%3\n"
+			"	andw  #7,%3\n"
+			"	lsrl  #3,%2\n"
+			"	negw  %3\n"
+			"	jmp   %%pc@(1f,%3:w:2)\n"
+			"4:	movel %0@+,%1@+\n"
+			"	movel %0@+,%1@+\n"
+			"	movel %0@+,%1@+\n"
+			"	movel %0@+,%1@+\n"
+			"	movel %0@+,%1@+\n"
+			"	movel %0@+,%1@+\n"
+			"	movel %0@+,%1@+\n"
+			"	movel %0@+,%1@+\n"
+			"1:	dbra  %2,4b\n"
+			"	clrw  %2\n"
+			"	subql #1,%2\n"
+			"	jpl   4b"
+			: "=a" (lfrom), "=a" (lto), "=d" (temp), "=&d" (temp1)
+			: "0" (lfrom), "1" (lto), "2" (temp));
+		to = lto;
+		from = lfrom;
+	}
+	if (n & 2) {
+		short *sto = to;
+		const short *sfrom = from;
+		*sto++ = *sfrom++;
+		to = sto;
+		from = sfrom;
+	}
+	if (n & 1) {
+		char *cto = to;
+		const char *cfrom = from;
+		*cto = *cfrom;
+	}
+	return xto;
+}
+EXPORT_SYMBOL(memcpy);
+
+void *memmove(void *dest, const void *src, size_t n)
+{
+	void *xdest = dest;
+	size_t temp;
+
+	if (!n)
+		return xdest;
+
+	if (dest < src) {
+		if ((long)dest & 1) {
+			char *cdest = dest;
+			const char *csrc = src;
+			*cdest++ = *csrc++;
+			dest = cdest;
+			src = csrc;
+			n--;
+		}
+		if (n > 2 && (long)dest & 2) {
+			short *sdest = dest;
+			const short *ssrc = src;
+			*sdest++ = *ssrc++;
+			dest = sdest;
+			src = ssrc;
+			n -= 2;
+		}
+		temp = n >> 2;
+		if (temp) {
+			long *ldest = dest;
+			const long *lsrc = src;
+			temp--;
+			do
+				*ldest++ = *lsrc++;
+			while (temp--);
+			dest = ldest;
+			src = lsrc;
+		}
+		if (n & 2) {
+			short *sdest = dest;
+			const short *ssrc = src;
+			*sdest++ = *ssrc++;
+			dest = sdest;
+			src = ssrc;
+		}
+		if (n & 1) {
+			char *cdest = dest;
+			const char *csrc = src;
+			*cdest = *csrc;
+		}
+	} else {
+		dest = (char *)dest + n;
+		src = (const char *)src + n;
+		if ((long)dest & 1) {
+			char *cdest = dest;
+			const char *csrc = src;
+			*--cdest = *--csrc;
+			dest = cdest;
+			src = csrc;
+			n--;
+		}
+		if (n > 2 && (long)dest & 2) {
+			short *sdest = dest;
+			const short *ssrc = src;
+			*--sdest = *--ssrc;
+			dest = sdest;
+			src = ssrc;
+			n -= 2;
+		}
+		temp = n >> 2;
+		if (temp) {
+			long *ldest = dest;
+			const long *lsrc = src;
+			temp--;
+			do
+				*--ldest = *--lsrc;
+			while (temp--);
+			dest = ldest;
+			src = lsrc;
+		}
+		if (n & 2) {
+			short *sdest = dest;
+			const short *ssrc = src;
+			*--sdest = *--ssrc;
+			dest = sdest;
+			src = ssrc;
+		}
+		if (n & 1) {
+			char *cdest = dest;
+			const char *csrc = src;
+			*--cdest = *--csrc;
+		}
+	}
+	return xdest;
+}
+EXPORT_SYMBOL(memmove);
+
+int memcmp(const void *cs, const void *ct, size_t count)
+{
+	const unsigned char *su1, *su2;
+
+	for (su1 = cs, su2 = ct; count > 0; ++su1, ++su2, count--)
+		if (*su1 != *su2)
+			return *su1 < *su2 ? -1 : +1;
+	return 0;
+}
+EXPORT_SYMBOL(memcmp);
Index: linux-2.6/include/asm-m68k/string.h
===================================================================
--- linux-2.6.orig/include/asm-m68k/string.h	2004-08-14 13:00:36.000000000 +0200
+++ linux-2.6/include/asm-m68k/string.h	2005-08-30 13:44:33.806824983 +0200
@@ -80,43 +80,6 @@ static inline char * strchr(const char *
   return( (char *) s);
 }
 
-#if 0
-#define __HAVE_ARCH_STRPBRK
-static inline char *strpbrk(const char *cs,const char *ct)
-{
-  const char *sc1,*sc2;
-
-  for( sc1 = cs; *sc1 != '\0'; ++sc1)
-    for( sc2 = ct; *sc2 != '\0'; ++sc2)
-      if (*sc1 == *sc2)
-	return((char *) sc1);
-  return( NULL );
-}
-#endif
-
-#if 0
-#define __HAVE_ARCH_STRSPN
-static inline size_t strspn(const char *s, const char *accept)
-{
-  const char *p;
-  const char *a;
-  size_t count = 0;
-
-  for (p = s; *p != '\0'; ++p)
-    {
-      for (a = accept; *a != '\0'; ++a)
-        if (*p == *a)
-          break;
-      if (*a == '\0')
-        return count;
-      else
-        ++count;
-    }
-
-  return count;
-}
-#endif
-
 /* strstr !! */
 
 #define __HAVE_ARCH_STRLEN
@@ -173,370 +136,18 @@ static inline int strncmp(const char * c
 }
 
 #define __HAVE_ARCH_MEMSET
-/*
- * This is really ugly, but its highly optimizatiable by the
- * compiler and is meant as compensation for gcc's missing
- * __builtin_memset(). For the 680[23]0	it might be worth considering
- * the optimal number of misaligned writes compared to the number of
- * tests'n'branches needed to align the destination address. The
- * 680[46]0 doesn't really care due to their copy-back caches.
- *						10/09/96 - Jes Sorensen
- */
-static inline void * __memset_g(void * s, int c, size_t count)
-{
-  void *xs = s;
-  size_t temp;
-
-  if (!count)
-    return xs;
-
-  c &= 0xff;
-  c |= c << 8;
-  c |= c << 16;
-
-  if (count < 36){
-	  long *ls = s;
-
-	  switch(count){
-	  case 32: case 33: case 34: case 35:
-		  *ls++ = c;
-	  case 28: case 29: case 30: case 31:
-		  *ls++ = c;
-	  case 24: case 25: case 26: case 27:
-		  *ls++ = c;
-	  case 20: case 21: case 22: case 23:
-		  *ls++ = c;
-	  case 16: case 17: case 18: case 19:
-		  *ls++ = c;
-	  case 12: case 13: case 14: case 15:
-		  *ls++ = c;
-	  case 8: case 9: case 10: case 11:
-		  *ls++ = c;
-	  case 4: case 5: case 6: case 7:
-		  *ls++ = c;
-		  break;
-	  default:
-		  break;
-	  }
-	  s = ls;
-	  if (count & 0x02){
-		  short *ss = s;
-		  *ss++ = c;
-		  s = ss;
-	  }
-	  if (count & 0x01){
-		  char *cs = s;
-		  *cs++ = c;
-		  s = cs;
-	  }
-	  return xs;
-  }
-
-  if ((long) s & 1)
-    {
-      char *cs = s;
-      *cs++ = c;
-      s = cs;
-      count--;
-    }
-  if (count > 2 && (long) s & 2)
-    {
-      short *ss = s;
-      *ss++ = c;
-      s = ss;
-      count -= 2;
-    }
-  temp = count >> 2;
-  if (temp)
-    {
-      long *ls = s;
-      temp--;
-      do
-	*ls++ = c;
-      while (temp--);
-      s = ls;
-    }
-  if (count & 2)
-    {
-      short *ss = s;
-      *ss++ = c;
-      s = ss;
-    }
-  if (count & 1)
-    {
-      char *cs = s;
-      *cs = c;
-    }
-  return xs;
-}
-
-/*
- * __memset_page assumes that data is longword aligned. Most, if not
- * all, of these page sized memsets are performed on page aligned
- * areas, thus we do not need to check if the destination is longword
- * aligned. Of course we suffer a serious performance loss if this is
- * not the case but I think the risk of this ever happening is
- * extremely small. We spend a lot of time clearing pages in
- * get_empty_page() so I think it is worth it anyway. Besides, the
- * 680[46]0 do not really care about misaligned writes due to their
- * copy-back cache.
- *
- * The optimized case for the 680[46]0 is implemented using the move16
- * instruction. My tests showed that this implementation is 35-45%
- * faster than the original implementation using movel, the only
- * caveat is that the destination address must be 16-byte aligned.
- *                                            01/09/96 - Jes Sorensen
- */
-static inline void * __memset_page(void * s,int c,size_t count)
-{
-  unsigned long data, tmp;
-  void *xs = s;
-
-  c = c & 255;
-  data = c | (c << 8);
-  data |= data << 16;
-
-#ifdef CPU_M68040_OR_M68060_ONLY
-
-  if (((unsigned long) s) & 0x0f)
-	  __memset_g(s, c, count);
-  else{
-	  unsigned long *sp = s;
-	  *sp++ = data;
-	  *sp++ = data;
-	  *sp++ = data;
-	  *sp++ = data;
-
-	  __asm__ __volatile__("1:\t"
-			       ".chip 68040\n\t"
-			       "move16 %2@+,%0@+\n\t"
-			       ".chip 68k\n\t"
-			       "subqw  #8,%2\n\t"
-			       "subqw  #8,%2\n\t"
-			       "dbra   %1,1b\n\t"
-			       : "=a" (sp), "=d" (tmp)
-			       : "a" (s), "0" (sp), "1" ((count - 16) / 16 - 1)
-			       );
-  }
-
-#else
-  __asm__ __volatile__("1:\t"
-		       "movel %2,%0@+\n\t"
-		       "movel %2,%0@+\n\t"
-		       "movel %2,%0@+\n\t"
-		       "movel %2,%0@+\n\t"
-		       "movel %2,%0@+\n\t"
-		       "movel %2,%0@+\n\t"
-		       "movel %2,%0@+\n\t"
-		       "movel %2,%0@+\n\t"
-		       "dbra  %1,1b\n\t"
-		       : "=a" (s), "=d" (tmp)
-		       : "d" (data), "0" (s), "1" (count / 32 - 1)
-		       );
-#endif
-
-  return xs;
-}
-
-extern void *memset(void *,int,__kernel_size_t);
-
-#define __memset_const(s,c,count) \
-((count==PAGE_SIZE) ? \
-  __memset_page((s),(c),(count)) : \
-  __memset_g((s),(c),(count)))
-
-#define memset(s, c, count) \
-(__builtin_constant_p(count) ? \
- __memset_const((s),(c),(count)) : \
- __memset_g((s),(c),(count)))
+extern void *memset(void *, int, __kernel_size_t);
+#define memset(d, c, n) __builtin_memset(d, c, n)
 
 #define __HAVE_ARCH_MEMCPY
-extern void * memcpy(void *, const void *, size_t );
-/*
- * __builtin_memcpy() does not handle page-sized memcpys very well,
- * thus following the same assumptions as for page-sized memsets, this
- * function copies page-sized areas using an unrolled loop, without
- * considering alignment.
- *
- * For the 680[46]0 only kernels we use the move16 instruction instead
- * as it writes through the data-cache, invalidating the cache-lines
- * touched. In this way we do not use up the entire data-cache (well,
- * half of it on the 68060) by copying a page. An unrolled loop of two
- * move16 instructions seem to the fastest. The only caveat is that
- * both source and destination must be 16-byte aligned, if not we fall
- * back to the generic memcpy function.  - Jes
- */
-static inline void * __memcpy_page(void * to, const void * from, size_t count)
-{
-  unsigned long tmp;
-  void *xto = to;
-
-#ifdef CPU_M68040_OR_M68060_ONLY
-
-  if (((unsigned long) to | (unsigned long) from) & 0x0f)
-	  return memcpy(to, from, count);
-
-  __asm__ __volatile__("1:\t"
-		       ".chip 68040\n\t"
-		       "move16 %1@+,%0@+\n\t"
-		       "move16 %1@+,%0@+\n\t"
-		       ".chip 68k\n\t"
-		       "dbra  %2,1b\n\t"
-		       : "=a" (to), "=a" (from), "=d" (tmp)
-		       : "0" (to), "1" (from) , "2" (count / 32 - 1)
-		       );
-#else
-  __asm__ __volatile__("1:\t"
-		       "movel %1@+,%0@+\n\t"
-		       "movel %1@+,%0@+\n\t"
-		       "movel %1@+,%0@+\n\t"
-		       "movel %1@+,%0@+\n\t"
-		       "movel %1@+,%0@+\n\t"
-		       "movel %1@+,%0@+\n\t"
-		       "movel %1@+,%0@+\n\t"
-		       "movel %1@+,%0@+\n\t"
-		       "dbra  %2,1b\n\t"
-		       : "=a" (to), "=a" (from), "=d" (tmp)
-		       : "0" (to), "1" (from) , "2" (count / 32 - 1)
-		       );
-#endif
-  return xto;
-}
-
-#define __memcpy_const(to, from, n) \
-((n==PAGE_SIZE) ? \
-  __memcpy_page((to),(from),(n)) : \
-  __builtin_memcpy((to),(from),(n)))
-
-#define memcpy(to, from, n) \
-(__builtin_constant_p(n) ? \
- __memcpy_const((to),(from),(n)) : \
- memcpy((to),(from),(n)))
+extern void *memcpy(void *, const void *, __kernel_size_t);
+#define memcpy(d, s, n) __builtin_memcpy(d, s, n)
 
 #define __HAVE_ARCH_MEMMOVE
-static inline void * memmove(void * dest,const void * src, size_t n)
-{
-  void *xdest = dest;
-  size_t temp;
-
-  if (!n)
-    return xdest;
-
-  if (dest < src)
-    {
-      if ((long) dest & 1)
-	{
-	  char *cdest = dest;
-	  const char *csrc = src;
-	  *cdest++ = *csrc++;
-	  dest = cdest;
-	  src = csrc;
-	  n--;
-	}
-      if (n > 2 && (long) dest & 2)
-	{
-	  short *sdest = dest;
-	  const short *ssrc = src;
-	  *sdest++ = *ssrc++;
-	  dest = sdest;
-	  src = ssrc;
-	  n -= 2;
-	}
-      temp = n >> 2;
-      if (temp)
-	{
-	  long *ldest = dest;
-	  const long *lsrc = src;
-	  temp--;
-	  do
-	    *ldest++ = *lsrc++;
-	  while (temp--);
-	  dest = ldest;
-	  src = lsrc;
-	}
-      if (n & 2)
-	{
-	  short *sdest = dest;
-	  const short *ssrc = src;
-	  *sdest++ = *ssrc++;
-	  dest = sdest;
-	  src = ssrc;
-	}
-      if (n & 1)
-	{
-	  char *cdest = dest;
-	  const char *csrc = src;
-	  *cdest = *csrc;
-	}
-    }
-  else
-    {
-      dest = (char *) dest + n;
-      src = (const char *) src + n;
-      if ((long) dest & 1)
-	{
-	  char *cdest = dest;
-	  const char *csrc = src;
-	  *--cdest = *--csrc;
-	  dest = cdest;
-	  src = csrc;
-	  n--;
-	}
-      if (n > 2 && (long) dest & 2)
-	{
-	  short *sdest = dest;
-	  const short *ssrc = src;
-	  *--sdest = *--ssrc;
-	  dest = sdest;
-	  src = ssrc;
-	  n -= 2;
-	}
-      temp = n >> 2;
-      if (temp)
-	{
-	  long *ldest = dest;
-	  const long *lsrc = src;
-	  temp--;
-	  do
-	    *--ldest = *--lsrc;
-	  while (temp--);
-	  dest = ldest;
-	  src = lsrc;
-	}
-      if (n & 2)
-	{
-	  short *sdest = dest;
-	  const short *ssrc = src;
-	  *--sdest = *--ssrc;
-	  dest = sdest;
-	  src = ssrc;
-	}
-      if (n & 1)
-	{
-	  char *cdest = dest;
-	  const char *csrc = src;
-	  *--cdest = *--csrc;
-	}
-    }
-  return xdest;
-}
+extern void *memmove(void *, const void *, __kernel_size_t);
 
 #define __HAVE_ARCH_MEMCMP
-extern int memcmp(const void * ,const void * ,size_t );
-#define memcmp(cs, ct, n) \
-(__builtin_constant_p(n) ? \
- __builtin_memcmp((cs),(ct),(n)) : \
- memcmp((cs),(ct),(n)))
-
-#define __HAVE_ARCH_MEMCHR
-static inline void *memchr(const void *cs, int c, size_t count)
-{
-	/* Someone else can optimize this, I don't care - tonym@mac.linux-m68k.org */
-	unsigned char *ret = (unsigned char *)cs;
-	for(;count>0;count--,ret++)
-		if(*ret == c) return ret;
-
-	return NULL;
-}
+extern int memcmp(const void *, const void *, __kernel_size_t);
+#define memcmp(d, s, n) __builtin_memcmp(d, s, n)
 
 #endif /* _M68K_STRING_H_ */
