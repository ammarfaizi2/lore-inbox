Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262498AbUJ0QTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUJ0QTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 12:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262506AbUJ0QSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 12:18:33 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:60938 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262498AbUJ0QP3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 12:15:29 -0400
Message-ID: <417FC982.7070602@vmware.com>
Date: Wed, 27 Oct 2004 09:14:58 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       george@mvista.com
Subject: [PATCH] Remove some divide instructions
Content-Type: multipart/mixed;
 boundary="------------060305040708000909050703"
X-OriginalArrivalTime: 27 Oct 2004 16:14:58.0981 (UTC) FILETIME=[1AFB1D50:01C4BC40]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.41; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060305040708000909050703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I noticed several 64-bit divides for HZ/USER_HZ, and also the fact that 
HZ == USER_HZ on many architectures (or if you play with scaling it ;).  
Since do_div is macroized to optimized assembler on many platforms, we 
emit long divides for divide by one.  This could be extended further to 
recognize other power of two divides, but I don't think the complexity 
of the macros would be justified.  I also didn't feel it was worthwhile 
to optimize this for non-constant divides; if you feel otherwise, please 
extend.

Cheers,

Zachary Amsden
zach@vmware.com

--------------060305040708000909050703
Content-Type: text/plain;
 name="div64.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="div64.patch"

diff -ru linux-2.6.10-rc1-nsz/include/asm-arm/div64.h linux-2.6.10-rc1/include/asm-arm/div64.h
--- linux-2.6.10-rc1-nsz/include/asm-arm/div64.h	2004-10-25 10:53:12.000000000 -0700
+++ linux-2.6.10-rc1/include/asm-arm/div64.h	2004-10-27 08:29:36.000000000 -0700
@@ -28,6 +28,7 @@
 #endif
 
 #define do_div(n,base)						\
+((__builtin_constant_p(base) && ((base) == 1)) ? 0 :		\
 ({								\
 	register unsigned int __base      asm("r4") = base;	\
 	register unsigned long long __n   asm("r0") = n;	\
@@ -43,6 +44,6 @@
 		: "ip", "lr", "cc");				\
 	n = __res;						\
 	__rem;							\
-})
+}))
 
 #endif
diff -ru linux-2.6.10-rc1-nsz/include/asm-generic/div64.h linux-2.6.10-rc1/include/asm-generic/div64.h
--- linux-2.6.10-rc1-nsz/include/asm-generic/div64.h	2003-12-17 18:59:30.000000000 -0800
+++ linux-2.6.10-rc1/include/asm-generic/div64.h	2004-10-27 08:26:01.000000000 -0700
@@ -22,13 +22,14 @@
 
 #if BITS_PER_LONG == 64
 
-# define do_div(n,base) ({					\
-	uint32_t __base = (base);				\
+# define do_div(n,base) (					\
+	(__builtin_constant_p(base) && ((base) == 1)) ? 0 : ({	\
 	uint32_t __rem;						\
+	uint32_t __base = (base);				\
 	__rem = ((uint64_t)(n)) % __base;			\
 	(n) = ((uint64_t)(n)) / __base;				\
 	__rem;							\
- })
+ }))
 
 #elif BITS_PER_LONG == 32
 
@@ -37,17 +38,18 @@
 /* The unnecessary pointer compare is there
  * to check for type safety (n must be 64bit)
  */
-# define do_div(n,base) ({				\
-	uint32_t __base = (base);			\
-	uint32_t __rem;					\
-	(void)(((typeof((n)) *)0) == ((uint64_t *)0));	\
-	if (likely(((n) >> 32) == 0)) {			\
-		__rem = (uint32_t)(n) % __base;		\
-		(n) = (uint32_t)(n) / __base;		\
-	} else 						\
-		__rem = __div64_32(&(n), __base);	\
-	__rem;						\
- })
+# define do_div(n,base) (					\
+	(__builtin_constant_p(base) && ((base) == 1)) ? 0 : ({	\
+	uint32_t __base = (base);				\
+	uint32_t __rem;						\
+	(void)(((typeof((n)) *)0) == ((uint64_t *)0));		\
+	if (likely(((n) >> 32) == 0)) {				\
+		__rem = (uint32_t)(n) % __base;			\
+		(n) = (uint32_t)(n) / __base;			\
+	} else 							\
+		__rem = __div64_32(&(n), __base);		\
+	__rem;							\
+ }))
 
 #else /* BITS_PER_LONG == ?? */
 
diff -ru linux-2.6.10-rc1-nsz/include/asm-i386/div64.h linux-2.6.10-rc1/include/asm-i386/div64.h
--- linux-2.6.10-rc1-nsz/include/asm-i386/div64.h	2003-12-17 18:57:59.000000000 -0800
+++ linux-2.6.10-rc1/include/asm-i386/div64.h	2004-10-27 08:31:45.000000000 -0700
@@ -13,7 +13,8 @@
  * This ends up being the most efficient "calling
  * convention" on x86.
  */
-#define do_div(n,base) ({ \
+#define do_div(n,base) ( \
+	(__builtin_constant_p(base) && ((base) == 1)) ? 0 : ({ \
 	unsigned long __upper, __low, __high, __mod, __base; \
 	__base = (base); \
 	asm("":"=a" (__low), "=d" (__high):"A" (n)); \
@@ -25,7 +26,7 @@
 	asm("divl %2":"=a" (__low), "=d" (__mod):"rm" (__base), "0" (__low), "1" (__upper)); \
 	asm("":"=A" (n):"a" (__low),"d" (__high)); \
 	__mod; \
-})
+}))
 
 /*
  * (long)X = ((long long)divs) / (long)div
diff -ru linux-2.6.10-rc1-nsz/include/asm-m32r/div64.h linux-2.6.10-rc1/include/asm-m32r/div64.h
--- linux-2.6.10-rc1-nsz/include/asm-m32r/div64.h	2004-10-25 11:15:58.000000000 -0700
+++ linux-2.6.10-rc1/include/asm-m32r/div64.h	2004-10-27 08:21:53.000000000 -0700
@@ -12,6 +12,7 @@
  *  return value = n % base;
  */
 #define do_div(n, base)						\
+((__builtin_constant_p(base) && ((base) == 1)) ? 0 : 		\
 ({								\
 	unsigned long _res, _high, _mid, _low;			\
 								\
@@ -33,6 +34,6 @@
 		n = (_low / (unsigned long)(base));		\
 	}							\
 	_res;							\
-})
+}))
 
 #endif  /* _ASM_M32R_DIV64 */
diff -ru linux-2.6.10-rc1-nsz/include/asm-m68k/div64.h linux-2.6.10-rc1/include/asm-m68k/div64.h
--- linux-2.6.10-rc1-nsz/include/asm-m68k/div64.h	2003-12-17 18:59:37.000000000 -0800
+++ linux-2.6.10-rc1/include/asm-m68k/div64.h	2004-10-27 08:30:55.000000000 -0700
@@ -3,7 +3,8 @@
 
 /* n = n / base; return rem; */
 
-#define do_div(n, base) ({					\
+#define do_div(n, base) (					\
+(__builtin_constant_p(base) && ((base) == 1)) ? 0 : ({		\
 	union {							\
 		unsigned long n32[2];				\
 		unsigned long long n64;				\
@@ -21,6 +22,6 @@
 		: "d" (base), "1" (__upper), "0" (__n.n32[1]));	\
 	(n) = __n.n64;						\
 	__rem;							\
-})
+}))
 
 #endif /* _M68K_DIV64_H */
diff -ru linux-2.6.10-rc1-nsz/include/asm-mips/div64.h linux-2.6.10-rc1/include/asm-mips/div64.h
--- linux-2.6.10-rc1-nsz/include/asm-mips/div64.h	2003-12-17 18:59:06.000000000 -0800
+++ linux-2.6.10-rc1/include/asm-mips/div64.h	2004-10-27 08:25:29.000000000 -0700
@@ -51,7 +51,8 @@
 	(res) = __quot; \
 	__mod; })
 
-#define do_div(n, base) ({ \
+#define do_div(n, base) ( \
+	(__builtin_constant_p(base) && ((base) == 1)) ? 0 : ({ \
 	unsigned long long __quot; \
 	unsigned long __mod; \
 	unsigned long long __div; \
@@ -74,7 +75,7 @@
 	__quot = __high; \
 	__quot = __quot << 32 | __low; \
 	(n) = __quot; \
-	__mod; })
+	__mod; }))
 #endif /* (_MIPS_SZLONG == 32) */
 
 #if (_MIPS_SZLONG == 64)
@@ -104,7 +105,8 @@
  * Hey, we're already 64-bit, no
  * need to play games..
  */
-#define do_div(n, base) ({ \
+#define do_div(n, base) ( \
+	(__builtin_constant_p(base) && ((base) == 1)) ? 0 : ({ \
 	unsigned long __quot; \
 	unsigned int __mod; \
 	unsigned long __div; \
@@ -117,7 +119,7 @@
 	__quot = __div / __base; \
 	\
 	(n) = __quot; \
-	__mod; })
+	__mod; }))
 
 #endif /* (_MIPS_SZLONG == 64) */
 
diff -ru linux-2.6.10-rc1-nsz/include/asm-s390/div64.h linux-2.6.10-rc1/include/asm-s390/div64.h
--- linux-2.6.10-rc1-nsz/include/asm-s390/div64.h	2004-10-25 10:50:43.000000000 -0700
+++ linux-2.6.10-rc1/include/asm-s390/div64.h	2004-10-27 08:27:34.000000000 -0700
@@ -4,7 +4,8 @@
 #ifndef __s390x__
 
 /* for do_div "base" needs to be smaller than 2^31-1 */
-#define do_div(n, base) ({                                      \
+#define do_div(n, base) (					\
+	(__builtin_constant_p(base) && ((base) == 1)) ? 0 : ({	\
 	unsigned long long __n = (n);				\
 	unsigned long __r;					\
 								\
@@ -40,7 +41,7 @@
 	     : "d" (base), "m" (__n) : "0", "1", "2", "cc" );	\
 	(n) = (__n);						\
         __r;                                                    \
-})
+}))
 
 #else /* __s390x__ */
 #include <asm-generic/div64.h>

--------------060305040708000909050703
Content-Type: text/plain;
 name="README.div64"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.div64"


div64.patch :

Get rid of 64-bit constant divide by one.  This appears to be a common case
for HZ == USER_HZ.  I tested the patch on older 2.6 kernels and was able to
produce some harmless warnings (statement has no effect), but it builds clean
for i386 with a 2.6.10 kernel.  I tested the generic asm inline by extracting
to gcc, but I have not tested any other platforms.

Doubtful, but if this breaks your build for some other platform, send me mail.

Zach Amsden
zach@vmware.com

--------------060305040708000909050703--
