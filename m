Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbUC3BYg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 20:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263413AbUC3BYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 20:24:36 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:7728 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263401AbUC3BYW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 20:24:22 -0500
Date: Mon, 29 Mar 2004 16:27:40 -0800
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       wli@holomorphy.com, haveblue@us.ibm.com
Subject: Re: [PATCH] mask ADT: new mask.h file [2/22]
Message-Id: <20040329162740.0ca8f6d5.pj@sgi.com>
In-Reply-To: <1080606618.6742.89.camel@arrakis>
References: <20040329041253.5cd281a5.pj@sgi.com>
	<1080606618.6742.89.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote (of my recommendation to not use the mask type directly):
> Is this necessary, or just convenient?

Technically as you suspect, just convenient, except in the case of the
mask_of_bit() macro, as you observe.

I was adhering to the K.I.S.S. school here - just tell the user one
recommended way of using things, suppressing my engineering urge to
explain alternatives that had no real advantages.

> This paragraph seems a bit unclear.

That's an understatment.  I left out a 'not' and didn't
explain half the cases.  See my updates, below.

> I think that it wouldn't be terribly ugly to split out the 1 unsigned
> long special cases (bitmap_and, bitmap_or, etc) with #ifdefs.

Do you have in mind an ifdef per function, or putting
several functions inside an ifdef?  If you think it
looks better - show us the code ;).

> test_and_set_bit((bit), (mask)._m) ?

yup.

Here's my cumulative patch of changes that I have gained so far
from your excellent feedback, and a couple I've noticed:

diff -Nru a/include/linux/mask.h b/include/linux/mask.h
--- a/include/linux/mask.h	Mon Mar 29 17:21:41 2004
+++ b/include/linux/mask.h	Mon Mar 29 17:21:41 2004
@@ -62,7 +62,7 @@
  *     Don't use mask.h directly - use cpumask.h and nodemask.h.
  *
  * The available mask operations and their rough meaning in the
- * case that "nbits == 8 * sizeof(single unsigned long)" are:
+ * case that "nbits == BITS_PER_LONG" are:
  *
  * __mask(nbits)			Use to define new *mask types
  * mask_setbit(bit, mask)		mask |= bit
@@ -70,7 +70,7 @@
  * mask_setall(mask, nbits)		mask = ~0UL
  * mask_clearall(mask)			mask = 0UL
  * mask_isset(bit, mask)		Is bit set in mask?
- * mask_test_and_set(bit, mask)		mask | bit ? 0 : mask |= bit
+ * mask_test_and_set(bit, mask)		mask & bit ? 1 : (mask |= bit, 0)
  * mask_and(dst, src1, src2)		dst = src1 & src2
  * mask_or(dst, src1, src2)		dst = src1 | src2
  * mask_xor(dst, src1, src2)		dst = src1 ^ src2
@@ -155,8 +155,10 @@
  *
  * The underlying bitmap.c operations such as bitmap_and() and
  *   bitmap_or() don't follow this model.  They don't assume
- *   the precondition that unused bits are zero, and they do
+ *   the precondition that unused bits are zero, and they do not
  *   mask off any unused portion of input masks in most cases.
+ *   The bitmap operations that produce Boolean or scalar results,
+ *   such as for empty, full and weight, _do_ filter out unused bits.
  *   However the underlying bitop.h operations, such as set_bit()
  *   and clear_bit(), do no sanitizing of their inputs, depending
  *   heavily on preconditions.
@@ -234,7 +236,7 @@
 	test_bit((bit), (mask)._m)
 
 #define mask_test_and_set(bit, mask)					\
-	test_and_set_bit(bit, (mask)._m)
+	test_and_set_bit((bit), (mask)._m)
 
 #define mask_and(dst, src1, src2)					\
 do {									\
diff -Nru a/lib/bitmap.c b/lib/bitmap.c
--- a/lib/bitmap.c	Mon Mar 29 17:21:41 2004
+++ b/lib/bitmap.c	Mon Mar 29 17:21:41 2004
@@ -47,7 +47,7 @@
 int bitmap_equal(const unsigned long *bitmap1,
 		const unsigned long *bitmap2, int bits)
 {
-	int k, lim = bits/BITS_PER_LONG;;
+	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] != bitmap2[k])
 			return 0;
@@ -63,7 +63,7 @@
 
 void bitmap_complement(unsigned long *dst, const unsigned long *src, int bits)
 {
-	int k, lim = bits/BITS_PER_LONG;;
+	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		dst[k] = ~src[k];
 
@@ -149,7 +149,7 @@
 int bitmap_intersects(const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
-	int k, lim = bits/BITS_PER_LONG;;
+	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & bitmap2[k])
 			return 1;
@@ -165,7 +165,7 @@
 int bitmap_subset(const unsigned long *bitmap1,
 				const unsigned long *bitmap2, int bits)
 {
-	int k, lim = bits/BITS_PER_LONG;;
+	int k, lim = bits/BITS_PER_LONG;
 	for (k = 0; k < lim; ++k)
 		if (bitmap1[k] & ~bitmap2[k])
 			return 0;


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
