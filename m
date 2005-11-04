Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbVKDFbV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbVKDFbV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 00:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbVKDFbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 00:31:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:12991 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161059AbVKDFbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 00:31:21 -0500
Date: Thu, 3 Nov 2005 21:31:09 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051104053109.549.76824.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 1/5] cpuset: better bitmap remap defaults
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the default behaviour for the remap operators in bitmap,
cpumask and nodemask.

As previously submitted, the pair of masks <A, B> defined a map
of the positions of the set bits in A to the corresponding bits
in B.  This is still true.

The issue is how to map the other positions, corresponding to
the unset (0) bits in A.  As previously submitted, they were
all mapped to the first set bit position in B, a constant map.

When I tried to code per-vma mempolicy rebinding using these
remap operators, I realized this was wrong.

This patch changes the default to map all the unset bit positions
in A to the same positions in B, the identity map.

For example, if A has bits 4-7 set, and B has bits 9-12 set,
then the map defined by the pair <A, B> maps each bit position
in the first 32 bits as follows:
	0 ==> 0
	  ...
	3 ==> 3
	4 ==> 9
	  ...
	7 ==> 12
	8 ==> 8
	9 ==> 9
	  ...
	31 ==> 31

This now corresponds to the typical behaviour desired when
migrating pages and policies from one cpuset to another.

The pages on nodes within the original cpuset, and the
references in memory policies to nodes within the original
cpuset, are migrated to the corresponding cpuset-relative nodes
in the destination cpuset.  Other pages and node references
are left untouched.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 lib/bitmap.c   |   89 ++++++++++++++++++++++++++++-----------------------------
 2 files changed, 53 insertions(+), 47 deletions(-)

--- 2.6.14-rc4-mm1-cpuset-patches.orig/lib/bitmap.c	2005-10-25 00:46:28.750910463 -0700
+++ 2.6.14-rc4-mm1-cpuset-patches/lib/bitmap.c	2005-10-25 06:50:03.755941035 -0700
@@ -519,7 +519,7 @@ EXPORT_SYMBOL(bitmap_parselist);
  *
  * Map the bit at position @pos in @buf (of length @bits) to the
  * ordinal of which set bit it is.  If it is not set or if @pos
- * is not a valid bit position, map to zero (0).
+ * is not a valid bit position, map to -1.
  *
  * If for example, just bits 4 through 7 are set in @buf, then @pos
  * values 4 through 7 will get mapped to 0 through 3, respectively,
@@ -531,18 +531,19 @@ EXPORT_SYMBOL(bitmap_parselist);
  */
 static int bitmap_pos_to_ord(const unsigned long *buf, int pos, int bits)
 {
-	int ord = 0;
+	int i, ord;
 
-	if (pos >= 0 && pos < bits) {
-		int i;
+	if (pos < 0 || pos >= bits || !test_bit(pos, buf))
+		return -1;
 
-		for (i = find_first_bit(buf, bits);
-		     i < pos;
-		     i = find_next_bit(buf, bits, i + 1))
-	     		ord++;
-		if (i > pos)
-			ord = 0;
+	i = find_first_bit(buf, bits);
+	ord = 0;
+	while (i < pos) {
+		i = find_next_bit(buf, bits, i + 1);
+	     	ord++;
 	}
+	BUG_ON(i != pos);
+
 	return ord;
 }
 
@@ -553,11 +554,12 @@ static int bitmap_pos_to_ord(const unsig
  *	@bits: number of valid bit positions in @buf
  *
  * Map the ordinal offset of bit @ord in @buf to its position in @buf.
- * If @ord is not the ordinal offset of a set bit in @buf, map to zero (0).
+ * Value of @ord should be in range 0 <= @ord < weight(buf), else
+ * results are undefined.
  *
  * If for example, just bits 4 through 7 are set in @buf, then @ord
  * values 0 through 3 will get mapped to 4 through 7, respectively,
- * and all other @ord valuds will get mapped to 0.  When @ord value 3
+ * and all other @ord values return undefined values.  When @ord value 3
  * gets mapped to (returns) @pos value 7 in this example, that means
  * that the 3rd set bit (starting with 0th) is at position 7 in @buf.
  *
@@ -583,8 +585,8 @@ static int bitmap_ord_to_pos(const unsig
 
 /**
  * bitmap_remap - Apply map defined by a pair of bitmaps to another bitmap
- *	@src: subset to be remapped
  *	@dst: remapped result
+ *	@src: subset to be remapped
  *	@old: defines domain of map
  *	@new: defines range of map
  *	@bits: number of bits in each of these bitmaps
@@ -596,49 +598,42 @@ static int bitmap_ord_to_pos(const unsig
  * weight of @old, map the position of the n-th set bit in @old to
  * the position of the m-th set bit in @new, where m == n % w.
  *
- * If either of the @old and @new bitmaps are empty, or if@src and @dst
- * point to the same location, then this routine does nothing.
+ * If either of the @old and @new bitmaps are empty, or if @src and
+ * @dst point to the same location, then this routine copies @src
+ * to @dst.
  *
- * The positions of unset bits in @old are mapped to the position of
- * the first set bit in @new.
+ * The positions of unset bits in @old are mapped to themselves
+ * (the identify map).
  *
  * Apply the above specified mapping to @src, placing the result in
  * @dst, clearing any bits previously set in @dst.
  *
- * The resulting value of @dst will have either the same weight as
- * @src, or less weight in the general case that the mapping wasn't
- * injective due to the weight of @new being less than that of @old.
- * The resulting value of @dst will never have greater weight than
- * that of @src, except perhaps in the case that one of the above
- * conditions was not met and this routine just returned.
- *
  * For example, lets say that @old has bits 4 through 7 set, and
  * @new has bits 12 through 15 set.  This defines the mapping of bit
  * position 4 to 12, 5 to 13, 6 to 14 and 7 to 15, and of all other
- * bit positions to 12 (the first set bit in @new.  So if say @src
- * comes into this routine with bits 1, 5 and 7 set, then @dst should
- * leave with bits 12, 13 and 15 set.
+ * bit positions unchanged.  So if say @src comes into this routine
+ * with bits 1, 5 and 7 set, then @dst should leave with bits 1,
+ * 13 and 15 set.
  */
 void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
 		int bits)
 {
-	int s;
+	int oldbit, w;
 
-	if (bitmap_weight(old, bits) == 0)
-		return;
-	if (bitmap_weight(new, bits) == 0)
-		return;
 	if (dst == src)		/* following doesn't handle inplace remaps */
 		return;
-
 	bitmap_zero(dst, bits);
-	for (s = find_first_bit(src, bits);
-	     s < bits;
-	     s = find_next_bit(src, bits, s + 1)) {
-	     	int x = bitmap_pos_to_ord(old, s, bits);
-		int y = bitmap_ord_to_pos(new, x, bits);
-		set_bit(y, dst);
+
+	w = bitmap_weight(new, bits);
+	for (oldbit = find_first_bit(src, bits);
+	     oldbit < bits;
+	     oldbit = find_next_bit(src, bits, oldbit + 1)) {
+	     	int n = bitmap_pos_to_ord(old, oldbit, bits);
+		if (n < 0 || w == 0)
+			set_bit(oldbit, dst);	/* identity map */
+		else
+			set_bit(bitmap_ord_to_pos(new, n % w, bits), dst);
 	}
 }
 EXPORT_SYMBOL(bitmap_remap);
@@ -657,8 +652,8 @@ EXPORT_SYMBOL(bitmap_remap);
  * weight of @old, map the position of the n-th set bit in @old to
  * the position of the m-th set bit in @new, where m == n % w.
  *
- * The positions of unset bits in @old are mapped to the position of
- * the first set bit in @new.
+ * The positions of unset bits in @old are mapped to themselves
+ * (the identify map).
  *
  * Apply the above specified mapping to bit position @oldbit, returning
  * the new bit position.
@@ -666,14 +661,18 @@ EXPORT_SYMBOL(bitmap_remap);
  * For example, lets say that @old has bits 4 through 7 set, and
  * @new has bits 12 through 15 set.  This defines the mapping of bit
  * position 4 to 12, 5 to 13, 6 to 14 and 7 to 15, and of all other
- * bit positions to 12 (the first set bit in @new.  So if say @oldbit
- * is 5, then this routine returns 13.
+ * bit positions unchanged.  So if say @oldbit is 5, then this routine
+ * returns 13.
  */
 int bitmap_bitremap(int oldbit, const unsigned long *old,
 				const unsigned long *new, int bits)
 {
-	int x = bitmap_pos_to_ord(old, oldbit, bits);
-	return bitmap_ord_to_pos(new, x, bits);
+	int w = bitmap_weight(new, bits);
+	int n = bitmap_pos_to_ord(old, oldbit, bits);
+	if (n < 0 || w == 0)
+		return oldbit;
+	else
+		return bitmap_ord_to_pos(new, n % w, bits);
 }
 EXPORT_SYMBOL(bitmap_bitremap);
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
