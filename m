Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262774AbUJ0Wpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbUJ0Wpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 18:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUJ0WpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:45:13 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:17682 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S262930AbUJ0Wgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:36:39 -0400
Message-ID: <41801DE1.6000007@vmware.com>
Date: Wed, 27 Oct 2004 15:14:57 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove some divide instructions
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060007040506070109070606"
X-OriginalArrivalTime: 27 Oct 2004 22:14:59.0608 (UTC) FILETIME=[65F53980:01C4BC72]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.12; VDF: 6.28.0.42; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060007040506070109070606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Apologies in advance for e-mail difficulties today - I can't reply 
directly to your message, so threading may be off.

>I'd suggest _only_ changing the i386 version.
>
>For example, your asm-generic changes looks senseless, since they only
>make the macros more complex, without actually changing anything. And the
>other architectures may want to do other things, since right now at least
>some of them use things like fixed hardware registers etc which is not
>necessarily appropriate for the non-asm case...
>
>That way you'd also only modify the architecture that you can actually 
>verify..
>
>		Linus
>

Backed out everything but i386 and generic.  For the generic version, I 
compiled and tested this code outside of the kernel.  Actually, I found 
that at least for my tool chain, the generic version

+# define do_div(n,base) ({                                             \
+       uint32_t __rem;                                                 \
+       if (__builtin_constant_p(base) && !((base) & ((base)-1))) {     \
+               __rem = ((uint64_t)(n)) % (base);                       \
+               (n) = ((uint64_t)(n)) / (base);                         \
+       } else {                                                        \
+               uint32_t __base = (base);                               \
+               __rem = ((uint64_t)(n)) % __base;                       \
+               (n) = ((uint64_t)(n)) / __base;                         \
+       }                                                               \
+       __rem;          

Does indeed generate different code for the constant case - without it, 
due to the assignment to __base, the shift / mask optimization does not 
take place.  Apparently the constant attribute and associated 
optimizations do not propagate through the assignment.  Other gccs may 
behave differently.   I also tried making __base const, to no avail.  If 
one were willing to ignore the potential macro side effects of the 
references to (base), the code could be the same, but I'm not the best 
judge of whether that is a good thing to do.

Zach
zach@vmware.com

--------------060007040506070109070606
Content-Type: text/plain;
 name="div64-3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="div64-3.patch"

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
 

--------------060007040506070109070606--
