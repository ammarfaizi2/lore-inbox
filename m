Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTD3C21 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 22:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTD3C21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 22:28:27 -0400
Received: from mx12.arcor-online.net ([151.189.8.88]:27366 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id S261785AbTD3C2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 22:28:23 -0400
From: Daniel Phillips <dphillips@sistina.com>
Reply-To: dphillips@sistina.com
Organization: Sistina
Subject: [RFC][PATCH] Faster generic_fls
Date: Wed, 30 Apr 2003 04:46:23 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304300446.24330.dphillips@sistina.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here's a faster implementation of generic_fls, that I discovered accidently,
by not noticing 2.5 already had a generic_fls, and so I rolled my own.  Like
the incumbent, it's O log2(bits), but there's not a lot of resemblance beyond
that.  I think the new algorithm is inherently more parallelizable than the
traditional approach.  A processor that can speculatively evaluate both sides 
of a conditional would benefit even more than the PIII I tested on.

The algorithm works roughly as follows: to find the highest bit in a value of
a given size, test the higher half for any one bits, then recursively apply
the algorithm to one of the two halves, depending on the test.  Once down to 8
bits, enumerate all the cases:

   return n & 0xf0? (n & 0xc0? (n & 0x80? 8: 7): (n & 0x20? 6: 5)):
          n & 0x0f? (n & 0x0c? (n & 0x08? 4: 3): (n & 0x02? 2: 1)): 0;

The above expression can be considerably optimized by noting that once we get
down to just two bits, at least one of which is known to be a one bit, it's
faster to shift out the higher of the two bits and add it directly to the
result than to evaluate a conditional.

A sneaky optimization is possible for the lowest two bits: the four values
{0, 1, 2, 3} map directly onto three of the four wanted results {0, 1, 2, 2},
so a little bit bashing takes care of both the conditional mentioned above
and the test that would otherwise be needed for the zero case.  The resulting
optimized code is sufficiently obfuscated for an IOCC entry, but it's fast:

   return n & 0xf0?
       n & 0xc0? (n >> 7) + 7: (n >> 5) + 5:
       n & 0x0c? (n >> 3) + 3: n - ((n + 1) >> 2);

In short, to find the high bit of a 32 bit value, the algorithm enumerates
all 32 possibilities using a binary search.  Inlines clarify the recursion,
and as a fringe benefit, give us a handy set of 8, 16, 32 and 64 bit
function flavors, the shorter versions being a little faster if you can use
them.

The thing that makes it fast (I think) is that the expressions at the leaves
can be evaluated in parallel with the conditional tests - that is, it's
possible to compute the results before we know exactly which one is needed. 
Another thing that may contribute to the speed is that the algorithm is doing
relatively more reading than writing, compared to the current version.
Though I did not test it, I believe the speedup will carry over to assembly
implementations as well.

There are still some optimization possibilities remaining.  For example, in
some of the evaluation cases the zero case doesn't have to be evaluated, so
a little arithmetic can be saved.  But then the helper functions wouldn't be
useable as sub-functions in their own right any more, so I don't think the
small speedup is worth it for the decreased orthogonality.

The improvement on a PIII varies from about 1.43x with gcc -O2 to 2.08x at
-O3.  The benchmark runs 2**32 iterations, evaluating all 32 bit cases.
Roughly speaking, at O3 it takes about 10 cycles to do the job:

       Old       New   Empty loop  Actual old  Actual new   Speedup
O2:  111.267   94.129    54.014      57.253      40.115       1.43
O3:   95.875   53.018    13.200      82.675      39.818       2.08

The test program is here:

   http://people.nl.linux.org/~phillips/test_fls.c

The patch is against 2.5.68-bk9.

Regards,

Daniel

--- 2.5.68.clean/include/linux/bitops.h	2003-04-20 04:51:12.000000000 +0200
+++ 2.5.68/include/linux/bitops.h	2003-04-30 01:29:27.000000000 +0200
@@ -41,33 +41,35 @@
  * fls: find last bit set.
  */
 
-extern __inline__ int generic_fls(int x)
+/* Faster generic_fls */
+/* (c) 2002, D.Phillips and Sistina Software */
+/* Licensed under Version 2 of the GPL */
+
+static inline unsigned fls8(unsigned n)
+{
+	return n & 0xf0?
+	    n & 0xc0? (n >> 7) + 7: (n >> 5) + 5:
+	    n & 0x0c? (n >> 3) + 3: n - ((n + 1) >> 2);
+}
+
+static inline unsigned fls16(unsigned n)
+{
+	return n & 0xff00? fls8(n >> 8) + 8: fls8(n);
+}
+
+static inline unsigned fls32(unsigned n)
+{
+	return n & 0xffff0000? fls16(n >> 16) + 16: fls16(n);
+}
+
+static inline unsigned fls64(unsigned long long n) /* should be u64 */
 {
-	int r = 32;
+	return n & 0xffffffff00000000? fls32(n >> 32) + 32: fls32(n);
+}
 
-	if (!x)
-		return 0;
-	if (!(x & 0xffff0000u)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xff000000u)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xf0000000u)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xc0000000u)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
-		r -= 1;
-	}
-	return r;
+static inline int generic_fls(int n)
+{
+	return fls32(n);
 }
 
 extern __inline__ int get_bitmask_order(unsigned int count)

