Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbTDQTHq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbTDQTHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:07:46 -0400
Received: from havoc.daloft.com ([64.213.145.173]:53908 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261896AbTDQTHn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:07:43 -0400
Date: Thu, 17 Apr 2003 15:19:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
Message-ID: <20030417191939.GG25696@gtf.org>
References: <1050569207.1412.1.camel@laptop.fenrus.com> <Pine.LNX.4.44.0304170903001.1530-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304170903001.1530-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 09:07:45AM -0700, Linus Torvalds wrote:
> HOWEVER, that doesn't fix the memcpy() issue. The fact is, the kernel 
> _can_ and does use SSE instructions - it's just that it has to do magic 
> crap before it does so. 

That issue is completely immaterial to my patch, though...

__constant_memcpy was used for small, constant-sized cases AFTER
the kernel made the decision not to hand the copy duties over to the
kernel's MMX/SSE code.  Take a look at the bottom of the patch below,
and also this snip from a non-hacked string.h, for illustration...

	...

	#define memcpy(t, f, n) \
	(__builtin_constant_p(n) ? \
	 __constant_memcpy3d((t),(f),(n)) : \
	 __memcpy3d((t),(f),(n)))

	#else

	/*
	 *      No 3D Now!
	 */
 
	#define memcpy(t, f, n) \
	(__builtin_constant_p(n) ? \
	 __constant_memcpy((t),(f),(n)) : \
	 __memcpy((t),(f),(n)))

	#endif

I can certainly see your argument about gcc suddenly deciding to use
SSE[2] registers to do the copy on its own, though.  The previous
patch -mno-foo should take care of that.

So, I _do_ see the downsides of my "radical" approach described
in my initial message (now), but I don't see the downsides to the
conservative patch that I actually submitted.  This patch retains
the kernel's decision-making on MMX/SSE/etc., but hands over the easy
and obvious stuff to gcc.

Even if the gcc guys suddenly turn hostile to the kernel, I really
can't see them breaking __builtin_memcpy for the simple case --
which is the only case where I use it below.



diff -Nru a/include/asm-i386/string.h b/include/asm-i386/string.h
--- a/include/asm-i386/string.h	Thu Apr 17 15:08:34 2003
+++ b/include/asm-i386/string.h	Thu Apr 17 15:08:34 2003
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
