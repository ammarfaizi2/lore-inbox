Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVJaUaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVJaUaJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:30:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbVJaUaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:30:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61607 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932493AbVJaUaH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:30:07 -0500
To: Randy Dunlap <randy_d_dunlap@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
Subject: Re: amd64 bitops fix for -Os
References: <orvezggf7x.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
	<4366533C.1010809@linux.intel.com>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat OS Tools Group
Date: Mon, 31 Oct 2005 18:29:36 -0200
In-Reply-To: <4366533C.1010809@linux.intel.com> (Randy Dunlap's message of
 "Mon, 31 Oct 2005 09:24:12 -0800")
Message-ID: <or4q6xv39r.fsf@livre.oliva.athome.lsd.ic.unicamp.br>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1

On Oct 31, 2005, Randy Dunlap <randy_d_dunlap@linux.intel.com> wrote:

>> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

> Possibly Andrew or Andi have already merged this into their trees.
> However, I have a few comments on the patch re Linux style.
> They are meant to help inform you and others -- that's all.

Thanks, I didn't realized I'd deviated from the recommended style.  In
this updated version of the patch, I've removed the ifdefs that could
sanity-check arguments to the exported entry points and adjusted the
comments to follow the guidelines.

>> --- arch/x86_64/lib/bitops.c~	2005-10-27 22:02:08.000000000 -0200
>> +++ arch/x86_64/lib/bitops.c	2005-10-29 18:24:27.000000000 -0200

> Diffs should start with a top-level names (even if it's entirely
> phony), so that they can be applied with many scripts that are around
> and expect that.

I hope you mean -p1 vs -p0.  I tend to prefer -p0 myself, but quilt
makes it easy enough to handle either :-)  Fixed in the revised
version.

>> -inline long find_first_zero_bit(const unsigned long * addr, unsigned long size)
>> +static inline long
>> +__find_first_zero_bit(const unsigned long * addr, unsigned long size)

> The only good reason for splitting a function header is if it would
> otherwise be > 80 columns, not just to put the function name at the
> beginning of the line.

In this case, it would, because I'm adding static and two leading
underscores.  But I'll keep that in mind, since this is quite
different from the GCC style.

>> +		 /* Any register here would do, but GCC tends to
>> +		    prefer rbx over rsi, even though rsi is readily
>> +		    available and doesn't have to be saved.  */
>> +		 [addr] "S" (addr) : "memory");

> Comment in the middle of the difficult-to-read asm instruction in
> undesirable (IMO).

I hope it is as useful after the statement.  Moving it before it would
move it too far apart from what it refers to IMHO.

Thanks again for the style feedback, it's really appreciated.

Should I have retained the problem description in the patch file, or
is the Signed-off-by: line enough?


--=-=-=
Content-Type: text/x-patch; charset=iso-8859-1
Content-Disposition: inline; filename=amd64-bitops.patch

	Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>

Index: linux-2.6/arch/x86_64/lib/bitops.c
===================================================================
--- linux-2.6.orig/arch/x86_64/lib/bitops.c	2005-10-31 18:16:16.000000000 -0200
+++ linux-2.6/arch/x86_64/lib/bitops.c	2005-10-31 18:22:06.000000000 -0200
@@ -5,19 +5,23 @@
 #undef find_first_bit
 #undef find_next_bit
 
-/**
- * find_first_zero_bit - find the first zero bit in a memory region
- * @addr: The address to start the search at
- * @size: The maximum size to search
- *
- * Returns the bit-number of the first zero bit, not the number of the byte
- * containing a bit.
- */
-inline long find_first_zero_bit(const unsigned long * addr, unsigned long size)
+static inline long
+__find_first_zero_bit(const unsigned long * addr, unsigned long size)
 {
 	long d0, d1, d2;
 	long res;
 
+	/*
+	 * We must test the size in words, not in bits, because
+	 * otherwise incoming sizes in the range -63..-1 will not run
+	 * any scasq instructions, and then the flags used by the je
+	 * instruction will have whatever random value was in place
+	 * before.  Nobody should call us like that, but
+	 * find_next_zero_bit() does when offset and size are at the
+	 * same word and it fails to find a zero itself.
+	 */
+	size += 63;
+	size >>= 6;
 	if (!size)
 		return 0;
 	asm volatile(
@@ -30,12 +34,30 @@
 		"  shlq $3,%%rdi\n"
 		"  addq %%rdi,%%rdx"
 		:"=d" (res), "=&c" (d0), "=&D" (d1), "=&a" (d2)
-		:"0" (0ULL), "1" ((size + 63) >> 6), "2" (addr), "3" (-1ULL),
-		 [addr] "r" (addr) : "memory");
+		:"0" (0ULL), "1" (size), "2" (addr), "3" (-1ULL),
+		 [addr] "S" (addr) : "memory");
+	/*
+	 * Any register would do for [addr] above, but GCC tends to
+	 * prefer rbx over rsi, even though rsi is readily available
+	 * and doesn't have to be saved.
+	 */
 	return res;
 }
 
 /**
+ * find_first_zero_bit - find the first zero bit in a memory region
+ * @addr: The address to start the search at
+ * @size: The maximum size to search
+ *
+ * Returns the bit-number of the first zero bit, not the number of the byte
+ * containing a bit.
+ */
+long find_first_zero_bit(const unsigned long * addr, unsigned long size)
+{
+	return __find_first_zero_bit (addr, size);
+}
+
+/**
  * find_next_zero_bit - find the first zero bit in a memory region
  * @addr: The address to base the search on
  * @offset: The bitnumber to start searching at
@@ -43,7 +65,7 @@
  */
 long find_next_zero_bit (const unsigned long * addr, long size, long offset)
 {
-	unsigned long * p = ((unsigned long *) addr) + (offset >> 6);
+	const unsigned long * p = addr + (offset >> 6);
 	unsigned long set = 0;
 	unsigned long res, bit = offset&63;
 
@@ -63,8 +85,8 @@
 	/*
 	 * No zero yet, search remaining full words for a zero
 	 */
-	res = find_first_zero_bit ((const unsigned long *)p,
-				   size - 64 * (p - (unsigned long *) addr));
+	res = __find_first_zero_bit (p, size - 64 * (p - addr));
+
 	return (offset + set + res);
 }
 
@@ -74,6 +96,19 @@
 	long d0, d1;
 	long res;
 
+	/*
+	 * We must test the size in words, not in bits, because
+	 * otherwise incoming sizes in the range -63..-1 will not run
+	 * any scasq instructions, and then the flags used by the jz
+	 * instruction will have whatever random value was in place
+	 * before.  Nobody should call us like that, but
+	 * find_next_bit() does when offset and size are at the same
+	 * word and it fails to find a one itself.
+	 */
+	size += 63;
+	size >>= 6;
+	if (!size)
+		return 0;
 	asm volatile(
 		"   repe; scasq\n"
 		"   jz 1f\n"
@@ -83,8 +118,7 @@
 		"   shlq $3,%%rdi\n"
 		"   addq %%rdi,%%rax"
 		:"=a" (res), "=&c" (d0), "=&D" (d1)
-		:"0" (0ULL),
-		 "1" ((size + 63) >> 6), "2" (addr),
+		:"0" (0ULL), "1" (size), "2" (addr),
 		 [addr] "r" (addr) : "memory");
 	return res;
 }

--=-=-=
Content-Type: text/plain; charset=iso-8859-1


-- 
Alexandre Oliva         http://www.lsd.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}

--=-=-=--
