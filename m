Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292882AbSBQJBo>; Sun, 17 Feb 2002 04:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292881AbSBQJBf>; Sun, 17 Feb 2002 04:01:35 -0500
Received: from holomorphy.com ([216.36.33.161]:62850 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S292880AbSBQJBU>;
	Sun, 17 Feb 2002 04:01:20 -0500
Date: Sun, 17 Feb 2002 01:01:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: riel@surriel.com, davem@redhat.com, phillips@bonn-fries.net,
        rwhron@earthlink.net
Subject: [PATCH] [rmap] operator-sparse Fibonacci hashing of waitqueues
Message-ID: <20020217090111.GF832@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, davem@redhat.com,
	phillips@bonn-fries.net, rwhron@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After distilling with hpa's help the results of some weeks-old
numerological experiments^W^Wnumber crunching, I've devised a patch
here for -rmap to make the waitqueue hashing somewhat more palatable
for SPARC and several others.

This patch uses some operator-sparse Fibonacci hashing primes in order
to allow shift/add implementations of the hash function used for hashed
waitqueues.


Dan, Dave, could you take a look here and please comment?

Randy, any chance you could benchmark -rmap with this on top for
comparison against standard -rmap to ensure there is no regression?


Thanks,
Bill

P.S.: Dave: Sorry I took so long to get this thing out, but here it is.


# This is a BitKeeper generated patch for the following project:
# Project Name: Long-term Linux VM development
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.199   ->        
#	include/linux/mm_inline.h	1.14    -> 1.15   
#	        mm/filemap.c	1.52    -> 1.53   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/02/17	wli@holomorphy.com	1.200
# Use operator-sparse Fibonacci hashing primes for the hashed waitqueues so as to reduce the cost of
# the hashing computation on several major RISC architectures and most 64-bit machines.
# 
# Specifically the search for operator-sparse primes was documented around the definitions of the
# GOLDEN_RATIO_PRIME values, where the number of terms in the sum of powers of 2 was chosen in
# advance and the numbers generated this way were sorted by their continued fraction expansion
# and then filtered for primality.
# 
# In turn the definition of page_waitqueue() also needed to be altered so that for 64-bit machines,
# whose compilers cannot perform the transformation of multiplication by a constant to shifts and
# adds, the transformation is explcitly coded, and documentation is included for it describing how
# the shifts and adds correspond to the signed sum of powers of two representation of the golden
# ratio prime.
# --------------------------------------------
#
diff -Nru a/include/linux/mm_inline.h b/include/linux/mm_inline.h
--- a/include/linux/mm_inline.h	Sun Feb 17 00:49:26 2002
+++ b/include/linux/mm_inline.h	Sun Feb 17 00:49:26 2002
@@ -9,12 +9,43 @@
  * Chuck Lever verified the effectiveness of this technique for several
  * hash tables in his paper documenting the benchmark results:
  * http://www.citi.umich.edu/techreports/reports/citi-tr-00-1.pdf
+ *
+ * These prime numbers were determined by searching all numbers
+ * composed of sums of seven terms of the form 2^n with n decreasing
+ * with the index of the summand and sorting by the continued fraction
+ * expansion of p/2^BITS_PER_LONG, then filtering for primality.
+ * Verifying that the confidence tests on the chi^2 statistics passed
+ * is necessary because this process can produce "bad" factors, but on
+ * the other hand it often produces excellent factors, so it's a very
+ * useful process for generating hash functions.
  */
+
 #if BITS_PER_LONG == 32
-#define GOLDEN_RATIO_PRIME 2654435761UL
+/*
+ * 2654404609 / 2^32 has the continued fraction expansion
+ * 0,1,1,1,1,1,1,1,1,1,1,1,1,18,7,1,3,7,18,1,1,1,1,1,1,1,1,1,1,2,0
+ * which is very close to phi.
+ * It is of the form 2^31 + 2^29 - 2^25 + 2^22 - 2^19 - 2^16 + 1
+ * which makes it suitable for compiler optimization to shift/add
+ * implementations on machines where multiplication is a slow operation.
+ * gcc is successfully able to optimize this on 32-bit SPARC and MIPS.
+ */
+#define GOLDEN_RATIO_PRIME 0x9e370001UL
 
 #elif BITS_PER_LONG == 64
-#define GOLDEN_RATIO_PRIME 11400714819323198549UL
+/*
+ * 11400862456688148481 / 2^64 has the continued fraction expansion
+ * 0,1,1,1,1,1,1,1,1,1,1,1,2,1,14,1,1048579,15,1,2,1,1,3,9,1,1,8,3,1,7,
+ *    1,1,9,1,2,1,1,1,1,2,0
+ * which is very close to phi = (sqrt(5)-1)/2 = 0,1,1,1,....
+ *
+ * It is of the form 2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1
+ * which makes it suitable for shift/add implementations of the hash
+ * function. 64-bit architectures typically have slow multiplies (or
+ * no hardware multiply) and also gcc is unable to optimize 64-bit
+ * multiplies for these bit patterns so explicit expansion is used.
+ */
+#define GOLDEN_RATIO_PRIME 0x9e37fffffffc0001UL
 
 #else
 #error Define GOLDEN_RATIO_PRIME in mm_inline.h for your wordsize.
diff -Nru a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Sun Feb 17 00:49:26 2002
+++ b/mm/filemap.c	Sun Feb 17 00:49:26 2002
@@ -787,6 +787,9 @@
  * collisions. This cost is great enough that effective hashing
  * is necessary to maintain performance.
  */
+
+#if BITS_PER_LONG == 32
+
 static inline wait_queue_head_t *page_waitqueue(struct page *page)
 {
 	const zone_t *zone = page_zone(page);
@@ -798,6 +801,50 @@
 
 	return &wait[hash];
 }
+
+#elif BITS_PER_LONG == 64
+
+static inline wait_queue_head_t *page_waitqueue(struct page *page)
+{
+	const zone_t *zone = page_zone(page);
+	wait_queue_head_t *wait = zone->wait_table;
+	unsigned long hash = (unsigned long)page;
+	unsigned long n;
+
+	/*
+	 * The bit-sparse GOLDEN_RATIO_PRIME is a sum of powers of 2
+	 * with varying signs: 2^63 + 2^61 - 2^57 + 2^54 - 2^51 - 2^18 + 1
+	 * The shifts in the code below correspond to the differences
+	 * in the exponents above.
+	 * The primary reason why the work of expanding the multiplication
+	 * this way is not given to the compiler is because 64-bit code
+	 * generation does not seem to be capable of doing it. So the code
+	 * here manually expands it.
+	 * The differences are used in order to both reduce the number of
+	 * variables used and also to reduce the size of the immediates
+	 * needed for the shift instructions, whose precision is limited
+	 * on some architectures.
+	 */
+
+	n = hash;
+	n <<= 18;
+	hash -= n;
+	n <<= 33;
+	hash -= n;
+	n <<= 3;
+	hash += n;
+	n <<= 3;
+	hash -= n;
+	n <<= 4;
+	hash += n;
+	n <<= 2;
+	hash += n;
+
+	hash >>= zone->wait_table_shift;
+	return &wait[hash];
+}
+
+#endif /* BITS_PER_LONG == 64 */
 
 
 /* 
