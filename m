Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbUJ0VIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbUJ0VIB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbUJ0VGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:06:42 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:52743 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262432AbUJ0VAz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:00:55 -0400
Message-ID: <41800218.8090902@vmware.com>
Date: Wed, 27 Oct 2004 13:16:24 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Remove some divide instructions
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060201070808020302040100"
X-OriginalArrivalTime: 27 Oct 2004 20:16:24.0916 (UTC) FILETIME=[D5456140:01C4BC61]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.42; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201070808020302040100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Apparently cc-ing linux-kernel is not good enough

Tested code generation (gcc (GCC) 3.2.2 20030222) and the optimization 
for powers of two works.  Reassigning base to a register causes the 
optimization to be dropped, but since these are constants anyway we can 
reference base without side effects.  I didn't extract n into a register 
to avoid side effects if it was not already done, since there are 
several possible places where the macro can generate side effects for 
(n) and even a comment to this effect.

This does the right thing for at least i386 and the generic code, and 
generates the expected shifts and and masks for power of two divides.

Passes several tests (code looks sane, assembler looks sane, boots & 
runs fine) on i386.  Apologies if I unlikely broke any other 
architectures, but it's quite difficult to test them all.

Zachary Amsden
zach@vmware.com

Linus Torvalds wrote:

>On Wed, 27 Oct 2004, Zachary Amsden wrote:
>  
>
>>I noticed several 64-bit divides for HZ/USER_HZ, and also the fact that 
>>HZ == USER_HZ on many architectures (or if you play with scaling it ;).  
>>Since do_div is macroized to optimized assembler on many platforms, we 
>>emit long divides for divide by one.  This could be extended further to 
>>recognize other power of two divides, but I don't think the complexity 
>>of the macros would be justified.  I also didn't feel it was worthwhile 
>>to optimize this for non-constant divides; if you feel otherwise, please 
>>extend.
>>    
>>
>
>Can you test out the trivial extension, which is to allow any power-of-two
>constant, and just leave it as a divide in those cases (and let the
>compiler turn it into a 64-bit shift)?
>
>It's very easy to test for powers of two: !((x) & ((x)-1)) does it for 
>everything but zero, and zero in this case is an error anyway.
>
>		Linus
>  
>


--------------060201070808020302040100
Content-Type: text/plain;
 name="div64-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="div64-2.patch"

diff -ru linux-2.6.10-rc1/include/asm-arm/div64.h linux-2.6.10-rc1-nsz/include/asm-arm/div64.h
--- linux-2.6.10-rc1/include/asm-arm/div64.h	2004-10-27 10:41:40.000000000 -0700
+++ linux-2.6.10-rc1-nsz/include/asm-arm/div64.h	2004-10-27 10:24:25.000000000 -0700
@@ -27,22 +27,27 @@
 #define __xh "r1"
 #endif
 
-#define do_div(n,base)						\
-({								\
-	register unsigned int __base      asm("r4") = base;	\
-	register unsigned long long __n   asm("r0") = n;	\
-	register unsigned long long __res asm("r2");		\
-	register unsigned int __rem       asm(__xh);		\
-	asm(	__asmeq("%0", __xh)				\
-		__asmeq("%1", "r2")				\
-		__asmeq("%2", "r0")				\
-		__asmeq("%3", "r4")				\
-		"bl	__do_div64"				\
-		: "=r" (__rem), "=r" (__res)			\
-		: "r" (__n), "r" (__base)			\
-		: "ip", "lr", "cc");				\
-	n = __res;						\
-	__rem;							\
+#define do_div(n,base)							\
+({									\
+	register unsigned long long __n   asm("r0") = n;		\
+	register unsigned long long __res asm("r2");			\
+	register unsigned int __rem       asm(__xh);			\
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) {	\
+		__rem = __n % (base);					\
+		__res = __n / (base);					\
+	} else {							\
+		register unsigned int __base      asm("r4") = base;	\
+		asm(	__asmeq("%0", __xh)				\
+			__asmeq("%1", "r2")				\
+			__asmeq("%2", "r0")				\
+			__asmeq("%3", "r4")				\
+			"bl	__do_div64"				\
+			: "=r" (__rem), "=r" (__res)			\
+			: "r" (__n), "r" (__base)			\
+			: "ip", "lr", "cc");				\
+	}								\
+	n = __res;							\
+	__rem;								\
 })
 
 #endif
diff -ru linux-2.6.10-rc1/include/asm-generic/div64.h linux-2.6.10-rc1-nsz/include/asm-generic/div64.h
--- linux-2.6.10-rc1/include/asm-generic/div64.h	2004-10-27 10:41:40.000000000 -0700
+++ linux-2.6.10-rc1-nsz/include/asm-generic/div64.h	2004-10-27 10:24:06.000000000 -0700
@@ -22,12 +22,17 @@
 
 #if BITS_PER_LONG == 64
 
-# define do_div(n,base) ({					\
-	uint32_t __base = (base);				\
-	uint32_t __rem;						\
-	__rem = ((uint64_t)(n)) % __base;			\
-	(n) = ((uint64_t)(n)) / __base;				\
-	__rem;							\
+# define do_div(n,base) ({						\
+	uint32_t __rem;							\
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) {	\
+		__rem = ((uint64_t)(n)) % (base);			\
+		(n) = ((uint64_t)(n)) / (base);				\
+	} else {							\
+		uint32_t __base = (base);				\
+		__rem = ((uint64_t)(n)) % __base;			\
+		(n) = ((uint64_t)(n)) / __base;				\
+	}								\
+	__rem;								\
  })
 
 #elif BITS_PER_LONG == 32
@@ -37,16 +42,21 @@
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
+# define do_div(n,base) ({						\
+	uint32_t __rem;						 	\
+	(void)(((typeof((n)) *)0) == ((uint64_t *)0));			\
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) {     \
+		__rem = ((uint64_t)(n)) % (base);			\
+		(n) = ((uint64_t)(n)) / (base);				\
+	} else {							\
+		uint32_t __base = (base);				\
+		if (likely(((n) >> 32) == 0)) {				\
+			__rem = (uint32_t)(n) % __base;			\
+			(n) = (uint32_t)(n) / __base;			\
+		} else 							\
+			__rem = __div64_32(&(n), __base);		\
+	}								\
+	__rem;								\
  })
 
 #else /* BITS_PER_LONG == ?? */
diff -ru linux-2.6.10-rc1/include/asm-i386/div64.h linux-2.6.10-rc1-nsz/include/asm-i386/div64.h
--- linux-2.6.10-rc1/include/asm-i386/div64.h	2004-10-27 10:41:40.000000000 -0700
+++ linux-2.6.10-rc1-nsz/include/asm-i386/div64.h	2004-10-27 10:15:04.000000000 -0700
@@ -14,16 +14,23 @@
  * convention" on x86.
  */
 #define do_div(n,base) ({ \
-	unsigned long __upper, __low, __high, __mod, __base; \
-	__base = (base); \
-	asm("":"=a" (__low), "=d" (__high):"A" (n)); \
-	__upper = __high; \
-	if (__high) { \
-		__upper = __high % (__base); \
-		__high = __high / (__base); \
+	unsigned long __mod; \
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) { \
+		__mod = ((uint64_t)(n)) % base;	\
+		(n) = ((uint64_t)(n)) / base; \
+	} else { \
+		unsigned long __upper, __low, __high, __base; \
+		__base = (base); \
+		asm("":"=a" (__low), "=d" (__high):"A" (n)); \
+		__upper = __high; \
+		if (__high) { \
+			__upper = __high % (__base); \
+			__high = __high / (__base); \
+		} \
+		asm("divl %2":	"=a" (__low), "=d" (__mod) : \
+				"rm" (__base), "0" (__low), "1" (__upper)); \
+		asm("":"=A" (n):"a" (__low),"d" (__high)); \
 	} \
-	asm("divl %2":"=a" (__low), "=d" (__mod):"rm" (__base), "0" (__low), "1" (__upper)); \
-	asm("":"=A" (n):"a" (__low),"d" (__high)); \
 	__mod; \
 })
 
diff -ru linux-2.6.10-rc1/include/asm-m32r/div64.h linux-2.6.10-rc1-nsz/include/asm-m32r/div64.h
--- linux-2.6.10-rc1/include/asm-m32r/div64.h	2004-10-27 10:41:40.000000000 -0700
+++ linux-2.6.10-rc1-nsz/include/asm-m32r/div64.h	2004-10-27 10:23:37.000000000 -0700
@@ -11,28 +11,33 @@
  *  n = n / base;
  *  return value = n % base;
  */
-#define do_div(n, base)						\
-({								\
-	unsigned long _res, _high, _mid, _low;			\
-								\
-	_low = (n) & 0xffffffffUL;				\
-	_high = (n) >> 32;					\
-	if (_high) {						\
-		_mid = (_high % (unsigned long)(base)) << 16;	\
-		_high = _high / (unsigned long)(base);		\
-		_mid += _low >> 16;				\
-		_low &= 0x0000ffffUL;				\
-		_low += (_mid % (unsigned long)(base)) << 16;	\
-		_mid = _mid / (unsigned long)(base);		\
-		_res = _low % (unsigned long)(base);		\
-		_low = _low / (unsigned long)(base);		\
-		n = _low + ((long long)_mid << 16) +		\
-			((long long)_high << 32);		\
-	} else {						\
-		_res = _low % (unsigned long)(base);		\
-		n = (_low / (unsigned long)(base));		\
-	}							\
-	_res;							\
+#define do_div(n, base)							\
+({									\
+	unsigned long _res;						\
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) {	\
+		_res = ((uint64_t)(n)) % (base);			\
+		(n) = ((uint64_t)(n)) / (base);				\
+	} else {							\
+		unsigned long _high, _mid, _low;			\
+		_low = (n) & 0xffffffffUL;				\
+		_high = (n) >> 32;					\
+		if (_high) {						\
+			_mid = (_high % (unsigned long)(base)) << 16;	\
+			_high = _high / (unsigned long)(base);		\
+			_mid += _low >> 16;				\
+			_low &= 0x0000ffffUL;				\
+			_low += (_mid % (unsigned long)(base)) << 16;	\
+			_mid = _mid / (unsigned long)(base);		\
+			_res = _low % (unsigned long)(base);		\
+			_low = _low / (unsigned long)(base);		\
+			n = _low + ((long long)_mid << 16) +		\
+				((long long)_high << 32);		\
+		} else {						\
+			_res = _low % (unsigned long)(base);		\
+			n = (_low / (unsigned long)(base));		\
+		}							\
+	}								\
+	_res;								\
 })
 
 #endif  /* _ASM_M32R_DIV64 */
diff -ru linux-2.6.10-rc1/include/asm-m68k/div64.h linux-2.6.10-rc1-nsz/include/asm-m68k/div64.h
--- linux-2.6.10-rc1/include/asm-m68k/div64.h	2004-10-27 10:41:40.000000000 -0700
+++ linux-2.6.10-rc1-nsz/include/asm-m68k/div64.h	2004-10-27 10:23:23.000000000 -0700
@@ -3,24 +3,30 @@
 
 /* n = n / base; return rem; */
 
-#define do_div(n, base) ({					\
-	union {							\
-		unsigned long n32[2];				\
-		unsigned long long n64;				\
-	} __n;							\
-	unsigned long __rem, __upper;				\
-								\
-	__n.n64 = (n);						\
-	if ((__upper = __n.n32[0])) {				\
-		asm ("divul.l %2,%1:%0"				\
-			: "=d" (__n.n32[0]), "=d" (__upper)	\
-			: "d" (base), "0" (__n.n32[0]));	\
-	}							\
-	asm ("divu.l %2,%1:%0"					\
-		: "=d" (__n.n32[1]), "=d" (__rem)		\
-		: "d" (base), "1" (__upper), "0" (__n.n32[1]));	\
-	(n) = __n.n64;						\
-	__rem;							\
-})
+#define do_div(n, base) ({						\
+	unsigned long __rem;						\
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) {	\
+		__rem = ((uint64_t)(n)) % (base);			\
+		(n) = ((uint64_t)(n)) / (base);				\
+	} else {							\
+		union {							\
+			unsigned long n32[2];				\
+			unsigned long long n64;				\
+		} __n;							\
+		unsigned long __upper;					\
+									\
+		__n.n64 = (n);						\
+		if ((__upper = __n.n32[0])) {				\
+			asm ("divul.l %2,%1:%0"				\
+				: "=d" (__n.n32[0]), "=d" (__upper)	\
+				: "d" (base), "0" (__n.n32[0]));	\
+		}							\
+		asm ("divu.l %2,%1:%0"					\
+			: "=d" (__n.n32[1]), "=d" (__rem)		\
+			: "d" (base), "1" (__upper), "0" (__n.n32[1]));	\
+		(n) = __n.n64;						\
+	}								\
+	__rem;								\
+}))
 
 #endif /* _M68K_DIV64_H */
diff -ru linux-2.6.10-rc1/include/asm-mips/div64.h linux-2.6.10-rc1-nsz/include/asm-mips/div64.h
--- linux-2.6.10-rc1/include/asm-mips/div64.h	2004-10-27 10:41:40.000000000 -0700
+++ linux-2.6.10-rc1-nsz/include/asm-mips/div64.h	2004-10-27 10:34:01.000000000 -0700
@@ -52,27 +52,32 @@
 	__mod; })
 
 #define do_div(n, base) ({ \
+	unsigned long long __div; \
 	unsigned long long __quot; \
 	unsigned long __mod; \
-	unsigned long long __div; \
-	unsigned long __upper, __low, __high, __base; \
 	\
 	__div = (n); \
-	__base = (base); \
-	\
-	__high = __div >> 32; \
-	__low = __div; \
-	__upper = __high; \
-	\
-	if (__high) \
-		__asm__("divu	$0, %z2, %z3" \
-			: "=h" (__upper), "=l" (__high) \
-			: "Jr" (__high), "Jr" (__base)); \
-	\
-	__mod = do_div64_32(__low, __upper, __low, __base); \
-	\
-	__quot = __high; \
-	__quot = __quot << 32 | __low; \
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) { \
+		__mod = __div % (base); \
+		__quot = __div / (base); \
+	} else { \
+		unsigned long __upper, __low, __high, __base; \
+		\
+		__base = (base); \
+		__high = __div >> 32; \
+		__low = __div; \
+		__upper = __high; \
+		\
+		if (__high) \
+			__asm__("divu	$0, %z2, %z3" \
+				: "=h" (__upper), "=l" (__high) \
+				: "Jr" (__high), "Jr" (__base)); \
+		\
+		__mod = do_div64_32(__low, __upper, __low, __base); \
+		\
+		__quot = __high; \
+		__quot = __quot << 32 | __low; \
+	} \
 	(n) = __quot; \
 	__mod; })
 #endif /* (_MIPS_SZLONG == 32) */
@@ -104,18 +109,22 @@
  * Hey, we're already 64-bit, no
  * need to play games..
  */
-#define do_div(n, base) ({ \
+#define do_div(n, base) ( \
+	unsigned long __div; \
 	unsigned long __quot; \
 	unsigned int __mod; \
-	unsigned long __div; \
-	unsigned int __base; \
 	\
 	__div = (n); \
-	__base = (base); \
-	\
-	__mod = __div % __base; \
-	__quot = __div / __base; \
-	\
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) { \
+		__mod = __div % (base); \
+		__quot = __div / (base); \
+	} else { \
+		unsigned int __base; \
+		\
+		__base = (base); \
+		__mod = __div % __base; \
+		__quot = __div / __base; \
+	} \
 	(n) = __quot; \
 	__mod; })
 
diff -ru linux-2.6.10-rc1/include/asm-s390/div64.h linux-2.6.10-rc1-nsz/include/asm-s390/div64.h
--- linux-2.6.10-rc1/include/asm-s390/div64.h	2004-10-27 10:42:32.000000000 -0700
+++ linux-2.6.10-rc1-nsz/include/asm-s390/div64.h	2004-10-27 10:43:06.000000000 -0700
@@ -4,42 +4,47 @@
 #ifndef __s390x__
 
 /* for do_div "base" needs to be smaller than 2^31-1 */
-#define do_div(n, base) (					\
-	unsigned long long __n = (n);				\
-	unsigned long __r;					\
-								\
-	asm ("   slr  0,0\n"					\
-	     "   l    1,%1\n"					\
-	     "   srdl 0,1\n"					\
-	     "   dr   0,%2\n"					\
-	     "   alr  1,1\n"					\
-	     "   alr  0,0\n"					\
-	     "   lhi  2,1\n"					\
-	     "   n    2,%1\n"					\
-	     "   alr  0,2\n"					\
-	     "   clr  0,%2\n"					\
-	     "   jl   0f\n"					\
-	     "   slr  0,%2\n"					\
-             "   ahi  1,1\n"					\
-	     "0: st   1,%1\n"					\
-	     "   l    1,4+%1\n"					\
-	     "   srdl 0,1\n"					\
-             "   dr   0,%2\n"					\
-	     "   alr  1,1\n"					\
-	     "   alr  0,0\n"					\
-	     "   lhi  2,1\n"					\
-	     "   n    2,4+%1\n"					\
-	     "   alr  0,2\n"					\
-	     "   clr  0,%2\n"					\
-             "   jl   1f\n"					\
-	     "   slr  0,%2\n"					\
-	     "   ahi  1,1\n"					\
-	     "1: st   1,4+%1\n"					\
-             "   lr   %0,0"					\
-	     : "=d" (__r), "=m" (__n)				\
-	     : "d" (base), "m" (__n) : "0", "1", "2", "cc" );	\
-	(n) = (__n);						\
-        __r;                                                    \
+#define do_div(n, base) ({						\
+	unsigned long long __n = (n);					\
+	unsigned long __r;						\
+									\
+	if (__builtin_constant_p(base) && !((base) & ((base)-1))) {	\
+		__r = __n % (base);					\
+		__n = __n / (base);					\
+	} else {							\
+		asm ("   slr  0,0\n"					\
+		     "   l    1,%1\n"					\
+		     "   srdl 0,1\n"					\
+		     "   dr   0,%2\n"					\
+		     "   alr  1,1\n"					\
+		     "   alr  0,0\n"					\
+		     "   lhi  2,1\n"					\
+		     "   n    2,%1\n"					\
+		     "   alr  0,2\n"					\
+		     "   clr  0,%2\n"					\
+		     "   jl   0f\n"					\
+		     "   slr  0,%2\n"					\
+		     "   ahi  1,1\n"					\
+		     "0: st   1,%1\n"					\
+		     "   l    1,4+%1\n"					\
+		     "   srdl 0,1\n"					\
+		     "   dr   0,%2\n"					\
+		     "   alr  1,1\n"					\
+		     "   alr  0,0\n"					\
+		     "   lhi  2,1\n"					\
+		     "   n    2,4+%1\n"					\
+		     "   alr  0,2\n"					\
+		     "   clr  0,%2\n"					\
+		     "   jl   1f\n"					\
+		     "   slr  0,%2\n"					\
+		     "   ahi  1,1\n"					\
+		     "1: st   1,4+%1\n"					\
+		     "   lr   %0,0"					\
+		     : "=d" (__r), "=m" (__n)				\
+		     : "d" (base), "m" (__n) : "0", "1", "2", "cc" );	\
+	}								\
+	(n) = (__n);							\
+	__r;								\
 })
 
 #else /* __s390x__ */

--------------060201070808020302040100--
