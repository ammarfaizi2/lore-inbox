Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbTDQXhV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262680AbTDQXhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:37:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50100 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262665AbTDQXhS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:37:18 -0400
Message-ID: <3E9F3D6F.9030501@pobox.com>
Date: Thu, 17 Apr 2003 19:49:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Arjan van de Ven <arjanv@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BK+PATCH] remove __constant_memcpy
References: <Pine.LNX.4.44.0304171253270.2795-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304171253270.2795-100000@home.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------080705020707090006090106"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080705020707090006090106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> On Thu, 17 Apr 2003, Jeff Garzik wrote:
> 
>>__constant_memcpy was used for small, constant-sized cases AFTER
>>the kernel made the decision not to hand the copy duties over to the
>>kernel's MMX/SSE code.  Take a look at the bottom of the patch below,
>>and also this snip from a non-hacked string.h, for illustration...
> 
> 
> This is the part I don't like
> 
>  #define memcpy(t, f, n) \
>  (__builtin_constant_p(n) ? \
> - __constant_memcpy((t),(f),(n)) : \
> + __builtin_memcpy((t),(f),(n)) : \
>   __memcpy((t),(f),(n)))
> 
> Notice? Our old __constant_memcpy() would do the rigth thing for large 
> copies. In conrast, I don't know that gcc will do so.


If DTRT means just using the existing code for large copies in general, 
that's easy enough...  patch attached.  I made the definition of "large 
copy" more pessimistic, where <= 128 bytes goes to __builtin_memcpy, 
otherwise to __constant_memcpy.  I carried this over to the MMX side too 
by proxy, as the existing MMX code already called __constant_memcpy. 
Thus, the modification is now only in one place.

If DTRT means not using MMX/SSE[2], that's a given considering the above 
code is from the "we don't have MMX/SSE" part of the ifdef.  If gcc 
starts using MMX with -march=i586 it's time for us all to go home and 
write a new compiler ;-)

Three tangents:
1) where did the 486 string ops go?
2) why no sse2-optimized memcpy?  just that noone has done one yet?
3) for copies >512 bytes, should we simply call the un-inlined memcpy? 
I would think that the call would get lost in cache misses of the block 
copy itself, but then again, __constant_memcpy (as it appears in output 
asm) is pretty darn small already.

	Jeff



--------------080705020707090006090106
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

===== include/asm-i386/string.h 1.8 vs edited =====
--- 1.8/include/asm-i386/string.h	Mon Mar 31 17:29:08 2003
+++ edited/include/asm-i386/string.h	Thu Apr 17 19:45:20 2003
@@ -214,49 +214,9 @@
  */
 static inline void * __constant_memcpy(void * to, const void * from, size_t n)
 {
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
+	if (n <= 128)
+		return __builtin_memcpy(to, from, n);
+
 #define COMMON(x) \
 __asm__ __volatile__( \
 	"rep ; movsl" \

--------------080705020707090006090106--

