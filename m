Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262093AbSJNXOF>; Mon, 14 Oct 2002 19:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262222AbSJNXOF>; Mon, 14 Oct 2002 19:14:05 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:31495 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S262093AbSJNXNx>;
	Mon, 14 Oct 2002 19:13:53 -0400
Date: Mon, 14 Oct 2002 19:19:38 -0400
From: Rob Radez <rob@osinvestor.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>
Subject: [patch] remove csum_partial_copy
Message-ID: <20021014191938.T16698@osinvestor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The attached patch against 2.5.42 removes csum_partial_copy.  It's on top of a
patch that I just sent to Dave removing csum_partial_copy_fromuser.  Does it
look alright to people?  Arch maintainers?  Dave?

Regards,
Rob Radez

diff -ruN linux-2.5.42-fromuser/arch/alpha/kernel/alpha_ksyms.c linux-2.5.42-cpc/arch/alpha/kernel/alpha_ksyms.c
--- linux-2.5.42-fromuser/arch/alpha/kernel/alpha_ksyms.c	2002-10-12 00:21:31.000000000 -0400
+++ linux-2.5.42-cpc/arch/alpha/kernel/alpha_ksyms.c	2002-10-14 17:12:24.000000000 -0400
@@ -167,7 +167,6 @@
 EXPORT_SYMBOL(csum_tcpudp_magic);
 EXPORT_SYMBOL(ip_compute_csum);
 EXPORT_SYMBOL(ip_fast_csum);
-EXPORT_SYMBOL(csum_partial_copy);
 EXPORT_SYMBOL(csum_partial_copy_nocheck);
 EXPORT_SYMBOL(csum_partial_copy_from_user);
 EXPORT_SYMBOL(csum_ipv6_magic);
diff -ruN linux-2.5.42-fromuser/arch/alpha/lib/csum_partial_copy.c linux-2.5.42-cpc/arch/alpha/lib/csum_partial_copy.c
--- linux-2.5.42-fromuser/arch/alpha/lib/csum_partial_copy.c	2002-10-12 00:22:08.000000000 -0400
+++ linux-2.5.42-cpc/arch/alpha/lib/csum_partial_copy.c	2002-10-14 17:12:01.000000000 -0400
@@ -385,16 +385,3 @@
 {
 	return do_csum_partial_copy_from_user(src, dst, len, sum, NULL);
 }
-
-unsigned int
-csum_partial_copy (const char *src, char *dst, int len, unsigned int sum)
-{
-	unsigned int ret;
-	int error = 0;
-
-	ret = do_csum_partial_copy_from_user(src, dst, len, sum, &error);
-	if (error)
-		printk("csum_partial_copy_old(): tell mingo to convert me!\n");
-
-	return ret;
-}
diff -ruN linux-2.5.42-fromuser/arch/cris/lib/old_checksum.c linux-2.5.42-cpc/arch/cris/lib/old_checksum.c
--- linux-2.5.42-fromuser/arch/cris/lib/old_checksum.c	2002-10-12 00:21:36.000000000 -0400
+++ linux-2.5.42-cpc/arch/cris/lib/old_checksum.c	2002-10-14 17:29:54.000000000 -0400
@@ -80,48 +80,3 @@
   BITOFF;
   return(sum);
 }
-
-#if 0
-
-/*
- * copy while checksumming, otherwise like csum_partial
- */
-
-unsigned int csum_partial_copy(const unsigned char *src, unsigned char *dst, 
-				  int len, unsigned int sum)
-{
-  const unsigned char *endMarker;
-  const unsigned char *marker;
-  printk("csum_partial_copy len %d.\n", len);
-#if 0
-  if((int)src & 0x3)
-    printk("unaligned src %p\n", src);
-  if((int)dst & 0x3)
-    printk("unaligned dst %p\n", dst);
-  __delay(1800); /* extra delay of 90 us to test performance hit */
-#endif
-  endMarker = src + len;
-  marker = endMarker - (len % 16);
-  CBITON;
-  while(src < marker) {
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-  }
-  marker = endMarker - (len % 2);
-  while(src < marker) {
-    sum += (*((unsigned short *)dst)++ = *((unsigned short *)src)++);
-  }
-  if(endMarker - src > 0) {
-    sum += (*dst = *src);                 /* add extra byte seperately */
-  }
-  CBITOFF;
-  return(sum);
-}
-
-#endif
diff -ruN linux-2.5.42-fromuser/arch/i386/lib/Makefile linux-2.5.42-cpc/arch/i386/lib/Makefile
--- linux-2.5.42-fromuser/arch/i386/lib/Makefile	2002-10-12 00:21:30.000000000 -0400
+++ linux-2.5.42-cpc/arch/i386/lib/Makefile	2002-10-14 17:03:38.000000000 -0400
@@ -4,7 +4,7 @@
 
 L_TARGET = lib.a
 
-obj-y = checksum.o old-checksum.o delay.o \
+obj-y = checksum.o delay.o \
 	usercopy.o getuser.o \
 	memcpy.o strstr.o
 
diff -ruN linux-2.5.42-fromuser/arch/i386/lib/old-checksum.c linux-2.5.42-cpc/arch/i386/lib/old-checksum.c
--- linux-2.5.42-fromuser/arch/i386/lib/old-checksum.c	2002-10-14 15:07:00.000000000 -0400
+++ linux-2.5.42-cpc/arch/i386/lib/old-checksum.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,19 +0,0 @@
-/*
- * FIXME: old compatibility stuff, will be removed soon.
- */
-
-#include <net/checksum.h>
-
-unsigned int csum_partial_copy( const char *src, char *dst, int len, int sum)
-{
-	int src_err=0, dst_err=0;
-
-	sum = csum_partial_copy_generic ( src, dst, len, sum, &src_err, &dst_err);
-
-	if (src_err || dst_err)
-		printk("old csum_partial_copy_fromuser(), tell mingo to convert me.\n");
-
-	return sum;
-}
-
-
diff -ruN linux-2.5.42-fromuser/arch/ia64/lib/csum_partial_copy.c linux-2.5.42-cpc/arch/ia64/lib/csum_partial_copy.c
--- linux-2.5.42-fromuser/arch/ia64/lib/csum_partial_copy.c	2002-10-12 00:22:10.000000000 -0400
+++ linux-2.5.42-cpc/arch/ia64/lib/csum_partial_copy.c	2002-10-14 17:40:11.000000000 -0400
@@ -145,17 +145,3 @@
 {
 	return do_csum_partial_copy_from_user(src, dst, len, sum, NULL);
 }
-
-unsigned int
-csum_partial_copy (const char *src, char *dst, int len, unsigned int sum)
-{
-	unsigned int ret;
-	int error = 0;
-
-	ret = do_csum_partial_copy_from_user(src, dst, len, sum, &error);
-	if (error)
-		printk("csum_partial_copy_old(): tell mingo to convert me!\n");
-
-	return ret;
-}
-
diff -ruN linux-2.5.42-fromuser/arch/m68k/kernel/m68k_ksyms.c linux-2.5.42-cpc/arch/m68k/kernel/m68k_ksyms.c
--- linux-2.5.42-fromuser/arch/m68k/kernel/m68k_ksyms.c	2002-10-12 00:22:18.000000000 -0400
+++ linux-2.5.42-cpc/arch/m68k/kernel/m68k_ksyms.c	2002-10-14 17:28:14.000000000 -0400
@@ -62,7 +62,7 @@
 #endif
 
 /* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy);
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
 /* The following are special because they're not called
    explicitly (the C compiler generates them).  Fortunately,
diff -ruN linux-2.5.42-fromuser/arch/m68k/lib/checksum.c linux-2.5.42-cpc/arch/m68k/lib/checksum.c
--- linux-2.5.42-fromuser/arch/m68k/lib/checksum.c	2002-10-12 00:22:46.000000000 -0400
+++ linux-2.5.42-cpc/arch/m68k/lib/checksum.c	2002-10-14 17:19:19.000000000 -0400
@@ -324,7 +324,7 @@
  */
 
 unsigned int
-csum_partial_copy(const char *src, char *dst, int len, int sum)
+csum_partial_copy_nocheck(const char *src, char *dst, int len, int sum)
 {
 	unsigned long tmp1, tmp2;
 	__asm__("movel %2,%4\n\t"
diff -ruN linux-2.5.42-fromuser/arch/mips/kernel/mips_ksyms.c linux-2.5.42-cpc/arch/mips/kernel/mips_ksyms.c
--- linux-2.5.42-fromuser/arch/mips/kernel/mips_ksyms.c	2002-10-12 00:21:35.000000000 -0400
+++ linux-2.5.42-cpc/arch/mips/kernel/mips_ksyms.c	2002-10-14 17:35:59.000000000 -0400
@@ -80,7 +80,7 @@
 
 
 /* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy);
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
 /*
  * Functions to control caches.
diff -ruN linux-2.5.42-fromuser/arch/mips/lib/csum_partial_copy.c linux-2.5.42-cpc/arch/mips/lib/csum_partial_copy.c
--- linux-2.5.42-fromuser/arch/mips/lib/csum_partial_copy.c	2002-10-12 00:22:08.000000000 -0400
+++ linux-2.5.42-cpc/arch/mips/lib/csum_partial_copy.c	2002-10-14 17:59:39.000000000 -0400
@@ -25,8 +25,8 @@
 /*
  * copy while checksumming, otherwise like csum_partial
  */
-unsigned int csum_partial_copy(const char *src, char *dst, 
-                               int len, unsigned int sum)
+unsigned int csum_partial_copy_nocheck (const char *src, char *dst, 
+                                        int len, unsigned int sum)
 {
 	/*
 	 * It's 2:30 am and I don't feel like doing it real ...
diff -ruN linux-2.5.42-fromuser/arch/mips64/kernel/mips64_ksyms.c linux-2.5.42-cpc/arch/mips64/kernel/mips64_ksyms.c
--- linux-2.5.42-fromuser/arch/mips64/kernel/mips64_ksyms.c	2002-10-12 00:21:41.000000000 -0400
+++ linux-2.5.42-cpc/arch/mips64/kernel/mips64_ksyms.c	2002-10-14 17:42:25.000000000 -0400
@@ -76,7 +76,7 @@
 
 
 /* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy);
+EXPORT_SYMBOL(csum_partial_copy_nocheck);
 
 /*
  * Functions to control caches.
diff -ruN linux-2.5.42-fromuser/arch/mips64/lib/csum_partial_copy.c linux-2.5.42-cpc/arch/mips64/lib/csum_partial_copy.c
--- linux-2.5.42-fromuser/arch/mips64/lib/csum_partial_copy.c	2002-10-12 00:22:18.000000000 -0400
+++ linux-2.5.42-cpc/arch/mips64/lib/csum_partial_copy.c	2002-10-14 17:42:36.000000000 -0400
@@ -16,7 +16,7 @@
 /*
  * copy while checksumming, otherwise like csum_partial
  */
-unsigned int csum_partial_copy(const char *src, char *dst, 
+unsigned int csum_partial_copy_nocheck(const char *src, char *dst, 
                                int len, unsigned int sum)
 {
 	/*
diff -ruN linux-2.5.42-fromuser/arch/parisc/lib/checksum.c linux-2.5.42-cpc/arch/parisc/lib/checksum.c
--- linux-2.5.42-fromuser/arch/parisc/lib/checksum.c	2002-10-12 00:22:12.000000000 -0400
+++ linux-2.5.42-cpc/arch/parisc/lib/checksum.c	2002-10-14 17:47:12.000000000 -0400
@@ -97,7 +97,7 @@
 /*
  * copy while checksumming, otherwise like csum_partial
  */
-unsigned int csum_partial_copy(const char *src, char *dst, 
+unsigned int csum_partial_copy_nocheck(const char *src, char *dst, 
                                int len, unsigned int sum)
 {
 	/*
diff -ruN linux-2.5.42-fromuser/arch/sh/kernel/sh_ksyms.c linux-2.5.42-cpc/arch/sh/kernel/sh_ksyms.c
--- linux-2.5.42-fromuser/arch/sh/kernel/sh_ksyms.c	2002-10-12 00:21:34.000000000 -0400
+++ linux-2.5.42-cpc/arch/sh/kernel/sh_ksyms.c	2002-10-14 17:44:10.000000000 -0400
@@ -36,9 +36,6 @@
 EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(no_irq_type);
 
-/* Networking helper routines. */
-EXPORT_SYMBOL(csum_partial_copy);
-
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strlen);
diff -ruN linux-2.5.42-fromuser/arch/sh/lib/Makefile linux-2.5.42-cpc/arch/sh/lib/Makefile
--- linux-2.5.42-fromuser/arch/sh/lib/Makefile	2002-10-12 00:22:07.000000000 -0400
+++ linux-2.5.42-cpc/arch/sh/lib/Makefile	2002-10-14 17:44:44.000000000 -0400
@@ -3,7 +3,7 @@
 #
 
 L_TARGET = lib.a
-obj-y  = delay.o memcpy.o memset.o memmove.o memchr.o old-checksum.o \
-	 checksum.o strcasecmp.o strlen.o
+obj-y  = delay.o memcpy.o memset.o memmove.o memchr.o checksum.o \
+	 strcasecmp.o strlen.o
 
 include $(TOPDIR)/Rules.make
diff -ruN linux-2.5.42-fromuser/arch/sh/lib/old-checksum.c linux-2.5.42-cpc/arch/sh/lib/old-checksum.c
--- linux-2.5.42-fromuser/arch/sh/lib/old-checksum.c	2002-10-12 00:21:30.000000000 -0400
+++ linux-2.5.42-cpc/arch/sh/lib/old-checksum.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,17 +0,0 @@
-/*
- * FIXME: old compatibility stuff, will be removed soon.
- */
-
-#include <net/checksum.h>
-
-unsigned int csum_partial_copy( const char *src, char *dst, int len, int sum)
-{
-	int src_err=0, dst_err=0;
-
-	sum = csum_partial_copy_generic ( src, dst, len, sum, &src_err, &dst_err);
-
-	if (src_err || dst_err)
-		printk("old csum_partial_copy_fromuser(), tell mingo to convert me.\n");
-
-	return sum;
-}
diff -ruN linux-2.5.42-fromuser/include/asm-alpha/checksum.h linux-2.5.42-cpc/include/asm-alpha/checksum.h
--- linux-2.5.42-fromuser/include/asm-alpha/checksum.h	2002-10-14 15:27:11.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-alpha/checksum.h	2002-10-14 17:15:47.000000000 -0400
@@ -37,19 +37,9 @@
 extern unsigned int csum_partial(const unsigned char * buff, int len, unsigned int sum);
 
 /*
- * the same as csum_partial, but copies from src while it
- * checksums
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- *
- * this will go away soon.
- */
-unsigned int csum_partial_copy(const char *src, char *dst, int len, unsigned int sum);
-
-/*
- * this is a new version of the above that records errors it finds in *errp,
- * but continues and zeros the rest of the buffer.
+ * the same as csum_partial, but copies while it checksums
+ * records errors it finds in *errp, then continues and zeros the rest of the
+ * buffer.
  */
 unsigned int csum_partial_copy_from_user(const char *src, char *dst, int len, unsigned int sum, int *errp);
 
diff -ruN linux-2.5.42-fromuser/include/asm-arm/checksum.h linux-2.5.42-cpc/include/asm-arm/checksum.h
--- linux-2.5.42-fromuser/include/asm-arm/checksum.h	2002-10-14 15:27:47.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-arm/checksum.h	2002-10-14 17:59:10.000000000 -0400
@@ -38,14 +38,6 @@
 csum_partial_copy_from_user(const char *src, char *dst, int len, int sum, int *err_ptr);
 
 /*
- * This is the old (and unsafe) way of doing checksums, a warning message will
- * be printed if it is used and an exception occurs.
- *
- * this functions should go away after some time.
- */
-#define csum_partial_copy(src,dst,len,sum)	csum_partial_copy_nocheck(src,dst,len,sum)
-
-/*
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
  */
diff -ruN linux-2.5.42-fromuser/include/asm-i386/checksum.h linux-2.5.42-cpc/include/asm-i386/checksum.h
--- linux-2.5.42-fromuser/include/asm-i386/checksum.h	2002-10-14 15:28:13.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-i386/checksum.h	2002-10-14 17:05:48.000000000 -0400
@@ -50,14 +50,6 @@
 }
 
 /*
- * This is the old (and unsafe) way of doing checksums, a warning message will
- * be printed if it is used and an exeption occurs.
- *
- * this function should go away after some time.
- */
-unsigned int csum_partial_copy( const char *src, char *dst, int len, int sum);
-
-/*
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
  *
diff -ruN linux-2.5.42-fromuser/include/asm-ia64/checksum.h linux-2.5.42-cpc/include/asm-ia64/checksum.h
--- linux-2.5.42-fromuser/include/asm-ia64/checksum.h	2002-10-14 15:28:22.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-ia64/checksum.h	2002-10-14 17:41:21.000000000 -0400
@@ -45,18 +45,8 @@
 
 /*
  * Same as csum_partial, but copies from src while it checksums.
- *
- * Here it is even more important to align src and dst on a 32-bit (or
- * even better 64-bit) boundary.
- *
- * this will go away soon.
- */
-extern unsigned int csum_partial_copy (const char *src, char *dst, int len,
-				       unsigned int sum);
-
-/*
- * This is a new version of the above that records errors it finds in
- * *errp, but continues and zeros the rest of the buffer.
+ * records errors it finds in *errp, but continues and zeros the rest of
+ * the buffer.
  */
 extern unsigned int csum_partial_copy_from_user (const char *src, char *dst,
 						 int len, unsigned int sum,
diff -ruN linux-2.5.42-fromuser/include/asm-m68k/checksum.h linux-2.5.42-cpc/include/asm-m68k/checksum.h
--- linux-2.5.42-fromuser/include/asm-m68k/checksum.h	2002-10-14 15:28:29.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-m68k/checksum.h	2002-10-14 17:29:02.000000000 -0400
@@ -21,11 +21,9 @@
  *
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
- *
- * this will go away soon.
  */
 
-unsigned int csum_partial_copy(const char *src, char *dst, int len, int sum);
+unsigned int csum_partial_copy_nocheck(const char *src, char *dst, int len, int sum);
 
 
 /*
@@ -38,9 +36,6 @@
 extern unsigned int csum_partial_copy_from_user(const char *src, char *dst,
 						int len, int sum, int *csum_err);
 
-#define csum_partial_copy_nocheck(src, dst, len, sum)	\
-	csum_partial_copy((src), (dst), (len), (sum))
-
 /*
  *	This is a version of ip_compute_csum() optimized for IP headers,
  *	which always checksum on 4 octet boundaries.
diff -ruN linux-2.5.42-fromuser/include/asm-mips/checksum.h linux-2.5.42-cpc/include/asm-mips/checksum.h
--- linux-2.5.42-fromuser/include/asm-mips/checksum.h	2002-10-14 15:03:02.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-mips/checksum.h	2002-10-14 17:36:28.000000000 -0400
@@ -28,12 +28,6 @@
  * this is a new version of the above that records errors it finds in *errp,
  * but continues and zeros the rest of the buffer.
  */
-#define csum_partial_copy_nocheck csum_partial_copy
-
-/*
- * this is a new version of the above that records errors it finds in *errp,
- * but continues and zeros the rest of the buffer.
- */
 unsigned int csum_partial_copy_from_user(const char *src, char *dst, int len,
                                          unsigned int sum, int *errp);
 
@@ -58,11 +52,9 @@
 /*
  * the same as csum_partial, but copies from user space (but on MIPS
  * we have just one address space, so this is identical to the above)
- *
- * this is obsolete and will go away.
  */
-unsigned int csum_partial_copy(const char *src, char *dst, int len,
-			       unsigned int sum);
+unsigned int csum_partial_copy_nocheck(const char *src, char *dst, int len,
+				       unsigned int sum);
 
 /*
  *	Fold a partial checksum without adding pseudo headers
diff -ruN linux-2.5.42-fromuser/include/asm-mips64/checksum.h linux-2.5.42-cpc/include/asm-mips64/checksum.h
--- linux-2.5.42-fromuser/include/asm-mips64/checksum.h	2002-10-14 15:05:13.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-mips64/checksum.h	2002-10-14 17:42:02.000000000 -0400
@@ -30,12 +30,6 @@
  * this is a new version of the above that records errors it finds in *errp,
  * but continues and zeros the rest of the buffer.
  */
-#define csum_partial_copy_nocheck csum_partial_copy
-
-/*
- * this is a new version of the above that records errors it finds in *errp,
- * but continues and zeros the rest of the buffer.
- */
 unsigned int csum_partial_copy_from_user(const char *src, char *dst, int len,
                                          unsigned int sum, int *errp);
 
@@ -60,10 +54,8 @@
 /*
  * the same as csum_partial, but copies from user space (but on MIPS
  * we have just one address space, so this is identical to the above)
- *
- * this is obsolete and will go away.
  */
-unsigned int csum_partial_copy(const char *src, char *dst, int len,
+unsigned int csum_partial_copy_nocheck(const char *src, char *dst, int len,
 			       unsigned int sum);
 
 /*
diff -ruN linux-2.5.42-fromuser/include/asm-parisc/checksum.h linux-2.5.42-cpc/include/asm-parisc/checksum.h
--- linux-2.5.42-fromuser/include/asm-parisc/checksum.h	2002-10-14 15:29:08.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-parisc/checksum.h	2002-10-14 17:46:50.000000000 -0400
@@ -22,9 +22,13 @@
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  *
- * this will go away soon.
+ * Note: when you get a NULL pointer exception here this means someone
+ * passed in an incorrect kernel address to one of these functions. 
+ *
+ * If you use these functions directly please don't forget the 
+ * verify_area().
  */
-extern unsigned int csum_partial_copy(const char *, char *, int, unsigned int);
+extern unsigned int csum_partial_copy_nocheck(const char *, char *, int, unsigned int);
 
 /*
  * this is a new version of the above that records errors it finds in *errp,
@@ -33,20 +37,6 @@
 unsigned int csum_partial_copy_from_user(const char *src, char *dst, int len, unsigned int sum, int *errp);
 
 /*
- *	Note: when you get a NULL pointer exception here this means someone
- *	passed in an incorrect kernel address to one of these functions. 
- *	
- *	If you use these functions directly please don't forget the 
- *	verify_area().
- */
-extern __inline__
-unsigned int csum_partial_copy_nocheck (const char *src, char *dst,
-					int len, int sum)
-{
-	return csum_partial_copy (src, dst, len, sum);
-}
-
-/*
  *	Optimized for IP headers, which always checksum on 4 octet boundaries.
  *
  *	Written by Randolph Chung <tausq@debian.org>
diff -ruN linux-2.5.42-fromuser/include/asm-ppc/checksum.h linux-2.5.42-cpc/include/asm-ppc/checksum.h
--- linux-2.5.42-fromuser/include/asm-ppc/checksum.h	2002-10-14 15:29:23.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-ppc/checksum.h	2002-10-14 17:50:26.000000000 -0400
@@ -38,12 +38,6 @@
 /* FIXME: this needs to be written to really do no check -- Cort */
 #define csum_partial_copy_nocheck(src, dst, len, sum)	\
 	csum_partial_copy_generic((src), (dst), (len), (sum), 0, 0)     
-/*
- * Old version which ignore errors.
- * it will go away soon.
- */
-#define csum_partial_copy(src, dst, len, sum)	\
-	csum_partial_copy_generic((src), (dst), (len), (sum), 0, 0)
 
 
 /*
diff -ruN linux-2.5.42-fromuser/include/asm-ppc64/checksum.h linux-2.5.42-cpc/include/asm-ppc64/checksum.h
--- linux-2.5.42-fromuser/include/asm-ppc64/checksum.h	2002-10-14 15:29:34.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-ppc64/checksum.h	2002-10-14 17:49:54.000000000 -0400
@@ -43,12 +43,7 @@
 /*
  * the same as csum_partial, but copies from src to dst while it
  * checksums
- *
- * csum_partial_copy will go away soon.
  */
-unsigned int csum_partial_copy(const char *src, char *dst, 
-			       int len, unsigned int sum);
-
 extern unsigned int csum_partial_copy_generic(const char *src, char *dst,
 					      int len, unsigned int sum,
 					      int *src_err, int *dst_err);
diff -ruN linux-2.5.42-fromuser/include/asm-s390/checksum.h linux-2.5.42-cpc/include/asm-s390/checksum.h
--- linux-2.5.42-fromuser/include/asm-s390/checksum.h	2002-10-14 15:29:41.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-s390/checksum.h	2002-10-14 17:51:10.000000000 -0400
@@ -62,24 +62,7 @@
 }
 
 /*
- * the same as csum_partial, but copies from src while it
- * checksums
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- *
- * this will go away soon.
- */
-
-static inline unsigned int 
-csum_partial_copy(const char *src, char *dst, int len,unsigned int sum)
-{
-	memcpy(dst,src,len);
-        return csum_partial_inline(dst, len, sum);
-}
-
-/*
- * the same as csum_partial_copy, but copies from user space.
+ * the same as csum_partial, but copies from user space while it checksums.
  *
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
diff -ruN linux-2.5.42-fromuser/include/asm-s390x/checksum.h linux-2.5.42-cpc/include/asm-s390x/checksum.h
--- linux-2.5.42-fromuser/include/asm-s390x/checksum.h	2002-10-14 15:29:46.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-s390x/checksum.h	2002-10-14 17:49:24.000000000 -0400
@@ -64,24 +64,7 @@
 }
 
 /*
- * the same as csum_partial, but copies from src while it
- * checksums
- *
- * here even more important to align src and dst on a 32-bit (or even
- * better 64-bit) boundary
- *
- * this will go away soon.
- */
-
-static inline unsigned int 
-csum_partial_copy(const char *src, char *dst, int len,unsigned int sum)
-{
-	memcpy(dst,src,len);
-        return csum_partial_inline(dst, len, sum);
-}
-
-/*
- * the same as csum_partial_copy, but copies from user space.
+ * the same as csum_partial, but copies from user space while it checksums.
  *
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
diff -ruN linux-2.5.42-fromuser/include/asm-sh/checksum.h linux-2.5.42-cpc/include/asm-sh/checksum.h
--- linux-2.5.42-fromuser/include/asm-sh/checksum.h	2002-10-14 15:30:00.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-sh/checksum.h	2002-10-14 17:43:41.000000000 -0400
@@ -58,14 +58,6 @@
 }
 
 /*
- * This is the old (and unsafe) way of doing checksums, a warning message will
- * be printed if it is used and an exeption occurs.
- *
- * this function should go away after some time.
- */
-unsigned int csum_partial_copy( const char *src, char *dst, int len, int sum);
-
-/*
  *	Fold a partial checksum
  */
 
diff -ruN linux-2.5.42-fromuser/include/asm-sparc/checksum.h linux-2.5.42-cpc/include/asm-sparc/checksum.h
--- linux-2.5.42-fromuser/include/asm-sparc/checksum.h	2002-10-14 15:05:02.000000000 -0400
+++ linux-2.5.42-cpc/include/asm-sparc/checksum.h	2002-10-14 17:52:05.000000000 -0400
@@ -39,11 +39,6 @@
  * here even more important to align src and dst on a 32-bit (or even
  * better 64-bit) boundary
  */
-
-/* FIXME: Remove this macro ASAP */
-#define csum_partial_copy(src, dst, len, sum) \
- 		       csum_partial_copy_nocheck(src,dst,len,sum)
-  
 extern unsigned int __csum_partial_copy_sparc_generic (const char *, char *);
 
 extern __inline__ unsigned int 
