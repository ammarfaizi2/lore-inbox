Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbTDQAqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 20:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTDQAqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 20:46:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261999AbTDQAqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 20:46:10 -0400
Message-ID: <3E9DFC11.50800@pobox.com>
Date: Wed, 16 Apr 2003 20:57:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [BK+PATCH] remove __constant_memcpy
Content-Type: multipart/mixed;
 boundary="------------050200030607000809000707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050200030607000809000707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,

Please review the patch below, then do a

	bk pull http://gkernel.bkbits.net/misc-2.5

Summary:

gcc's __builtin_memcpy performs the same function (and more) as the 
kernel's __constant_memcpy.  So, let's remove __constant_memcpy, and let 
the compiler do it.

Instead of shouldering the burden of the kernel needing to have a 
decently-fast memcpy routine, I would prefer to hand off that 
maintenance burden to the compiler.  For the less common (read: 
non-Intel) processors, I bet this patch shows immediate asm-level 
benefits in instruction scheduling.

The patch below is the conservative, obvious patch.  It only kicks in 
when __builtin_constant_p() is true, and it only applies to the i386 
arch.  I'm currently running w/ 2.5.67+BK+patch and it's stable.  With 
some recently-acquired (but still nascent) x86 asm skills, I diff'd the 
before-and-after x86 asm cases for when a constant memcpy() call was 
made in the kernel code; nothing interesting.  The instruction sequence 
was usually longer once you exceeded ~32 byte memcpy, but it looked like 
it scheduled better on i686.  The small-copy cases looked reasonably 
equivalent.

The more radical direction, where I would eventually like to go, is to 
hand off all memcpy duties to the compiler, and -march=xxx selects the 
best memcpy strategies.  This "radical" direction requires a lot more 
work, benching both the kernel and gcc before and after the memcpy changes.

Finally, on a compiler note, __builtin_memcpy can fall back to emitting 
a memcpy function call.  Given the conservatism of my patch, this is 
unlikely, but it should be mentioned.  This also gives less-capable 
compilers the ability to simplify, by choosing the slow path of 
unconditionally emitting a memcpy call.

--------------050200030607000809000707
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

# --------------------------------------------
# 03/04/16	jgarzik@redhat.com	1.1067.1.1
# [ia32] remove __constant_memcpy, use __builtin_memcpy
# 
# gcc's memcpy handling already takes into account the cases that
# include/asm-i386/string.h's __constant_memcpy takes into
# account.  __constant_memcpy is removed, and it is replaced
# with references to __builtin_memcpy.
# 
# Compilers that do not/cannot optimize __builtin_memcpy can choose
# the slow path and simply emit a memcpy function call.
# --------------------------------------------
#
diff -Nru a/include/asm-i386/string.h b/include/asm-i386/string.h
--- a/include/asm-i386/string.h	Wed Apr 16 20:19:42 2003
+++ b/include/asm-i386/string.h	Wed Apr 16 20:19:42 2003
@@ -208,75 +208,6 @@
 return (to);
 }
 
-/*
- * This looks horribly ugly, but the compiler can optimize it totally,
- * as the count is constant.
- */
-static inline void * __constant_memcpy(void * to, const void * from, size_t n)
-{
-	switch (n) {
-		case 0:
-			return to;
-		case 1:
-			*(unsigned char *)to = *(const unsigned char *)from;
-			return to;
-		case 2:
-			*(unsigned short *)to = *(const unsigned short *)from;
-			return to;
-		case 3:
-			*(unsigned short *)to = *(const unsigned short *)from;
-			*(2+(unsigned char *)to) = *(2+(const unsigned char *)from);
-			return to;
-		case 4:
-			*(unsigned long *)to = *(const unsigned long *)from;
-			return to;
-		case 6:	/* for Ethernet addresses */
-			*(unsigned long *)to = *(const unsigned long *)from;
-			*(2+(unsigned short *)to) = *(2+(const unsigned short *)from);
-			return to;
-		case 8:
-			*(unsigned long *)to = *(const unsigned long *)from;
-			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
-			return to;
-		case 12:
-			*(unsigned long *)to = *(const unsigned long *)from;
-			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
-			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
-			return to;
-		case 16:
-			*(unsigned long *)to = *(const unsigned long *)from;
-			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
-			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
-			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
-			return to;
-		case 20:
-			*(unsigned long *)to = *(const unsigned long *)from;
-			*(1+(unsigned long *)to) = *(1+(const unsigned long *)from);
-			*(2+(unsigned long *)to) = *(2+(const unsigned long *)from);
-			*(3+(unsigned long *)to) = *(3+(const unsigned long *)from);
-			*(4+(unsigned long *)to) = *(4+(const unsigned long *)from);
-			return to;
-	}
-#define COMMON(x) \
-__asm__ __volatile__( \
-	"rep ; movsl" \
-	x \
-	: "=&c" (d0), "=&D" (d1), "=&S" (d2) \
-	: "0" (n/4),"1" ((long) to),"2" ((long) from) \
-	: "memory");
-{
-	int d0, d1, d2;
-	switch (n % 4) {
-		case 0: COMMON(""); return to;
-		case 1: COMMON("\n\tmovsb"); return to;
-		case 2: COMMON("\n\tmovsw"); return to;
-		default: COMMON("\n\tmovsw\n\tmovsb"); return to;
-	}
-}
-  
-#undef COMMON
-}
-
 #define __HAVE_ARCH_MEMCPY
 
 #ifdef CONFIG_X86_USE_3DNOW
@@ -290,7 +221,7 @@
 static inline void * __constant_memcpy3d(void * to, const void * from, size_t len)
 {
 	if (len < 512)
-		return __constant_memcpy(to, from, len);
+		return __builtin_memcpy(to, from, len);
 	return _mmx_memcpy(to, from, len);
 }
 
@@ -314,7 +245,7 @@
  
 #define memcpy(t, f, n) \
 (__builtin_constant_p(n) ? \
- __constant_memcpy((t),(f),(n)) : \
+ __builtin_memcpy((t),(f),(n)) : \
  __memcpy((t),(f),(n)))
 
 #endif

--------------050200030607000809000707--

