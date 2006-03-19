Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWCSWrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWCSWrE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 17:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWCSWrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 17:47:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21181 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751126AbWCSWrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 17:47:01 -0500
Date: Sun, 19 Mar 2006 14:46:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: viro@ftp.linux.org.uk, kernel-stuff@comcast.net,
       linux-kernel@vger.kernel.org, alex-kernel@digriz.org.uk,
       jun.nakajima@intel.com, davej@redhat.com
Subject: Re: OOPS: 2.6.16-rc6 cpufreq_conservative
In-Reply-To: <Pine.LNX.4.64.0603191412270.3826@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0603191429580.3826@g5.osdl.org>
References: <200603181525.14127.kernel-stuff@comcast.net>
 <Pine.LNX.4.64.0603181321310.3826@g5.osdl.org> <20060318165302.62851448.akpm@osdl.org>
 <Pine.LNX.4.64.0603181827530.3826@g5.osdl.org> <Pine.LNX.4.64.0603191034370.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191050340.3826@g5.osdl.org> <Pine.LNX.4.64.0603191125220.3826@g5.osdl.org>
 <20060319194004.GZ27946@ftp.linux.org.uk> <Pine.LNX.4.64.0603191148160.3826@g5.osdl.org>
 <Pine.LNX.4.64.0603191217560.3826@g5.osdl.org> <20060319124701.41e16e7b.akpm@osdl.org>
 <Pine.LNX.4.64.0603191412270.3826@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 19 Mar 2006, Linus Torvalds wrote:
> 
> How does this patch look? It makes "for_each_cpu()" look the same 
> regardless of whether it is UP/SMP, by simply making first_cpu() and 
> next_cpu() work appropriately. 

It's still about 200 bytes larger than the inlined "smarter code", but 
yeah, the unlinlining is certainly the smaller change and doesn't depend 
on the compiler being as smart.

Here's another uninlining patch if you want it.

It doesn't make much of a difference on x86 (since the ffs/fls things are 
inlined to single instructions rather than making use of the generic 
routines, so the fact that we now link against the generic versions 
actually increases code size that isn't ever used), but if anybody is 
collecting patches that removes unnecessary inlining, it definitely looks 
like the right thing for v850/sh/sh64/arm etc that use the generic 
versions..

		Linus

---
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 208650b..2d3ed35 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -1,74 +1,28 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
+
+#include <linux/linkage.h>
 #include <asm/types.h>
 
 /*
  * ffs: find first bit set. This is defined the same way as
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
+ *
+ * fls: find last bit set.
  */
 
-static inline int generic_ffs(int x)
-{
-	int r = 1;
-
-	if (!x)
-		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
-	return r;
-}
+extern int fastcall generic_ffs(int x);
+extern int fastcall generic_fls(int x);
 
 /*
- * fls: find last bit set.
+ * hweightN: returns the hamming weight (i.e. the number
+ * of bits set) of a N-bit word
  */
-
-static __inline__ int generic_fls(int x)
-{
-	int r = 32;
-
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
-}
+unsigned int fastcall generic_hweight64(__u64 w);
+unsigned int fastcall generic_hweight32(unsigned int w);
+unsigned int fastcall generic_hweight16(unsigned int w);
+unsigned int fastcall generic_hweight8(unsigned int w);
 
 /*
  * Include this here because some architectures need generic_ffs/fls in
@@ -76,7 +30,6 @@ static __inline__ int generic_fls(int x)
  */
 #include <asm/bitops.h>
 
-
 static inline int generic_fls64(__u64 x)
 {
 	__u32 h = x >> 32;
@@ -103,51 +56,6 @@ static __inline__ int get_count_order(un
 	return order;
 }
 
-/*
- * hweightN: returns the hamming weight (i.e. the number
- * of bits set) of a N-bit word
- */
-
-static inline unsigned int generic_hweight32(unsigned int w)
-{
-        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
-        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
-        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
-        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
-        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
-}
-
-static inline unsigned int generic_hweight16(unsigned int w)
-{
-        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
-        res = (res & 0x3333) + ((res >> 2) & 0x3333);
-        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
-        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
-}
-
-static inline unsigned int generic_hweight8(unsigned int w)
-{
-        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
-        res = (res & 0x33) + ((res >> 2) & 0x33);
-        return (res & 0x0F) + ((res >> 4) & 0x0F);
-}
-
-static inline unsigned long generic_hweight64(__u64 w)
-{
-#if BITS_PER_LONG < 64
-	return generic_hweight32((unsigned int)(w >> 32)) +
-				generic_hweight32((unsigned int)w);
-#else
-	u64 res;
-	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
-	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
-	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
-	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
-	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
-	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
-#endif
-}
-
 static inline unsigned long hweight_long(unsigned long w)
 {
 	return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
diff --git a/lib/Makefile b/lib/Makefile
index 648b2c1..bba36f1 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o bitops.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
diff --git a/lib/bitops.c b/lib/bitops.c
new file mode 100644
index 0000000..e5e4cab
--- /dev/null
+++ b/lib/bitops.c
@@ -0,0 +1,106 @@
+#include <linux/bitops.h>
+#include <linux/module.h>
+
+int generic_ffs(int x)
+{
+	int r = 1;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff)) {
+		x >>= 16;
+		r += 16;
+	}
+	if (!(x & 0xff)) {
+		x >>= 8;
+		r += 8;
+	}
+	if (!(x & 0xf)) {
+		x >>= 4;
+		r += 4;
+	}
+	if (!(x & 3)) {
+		x >>= 2;
+		r += 2;
+	}
+	if (!(x & 1)) {
+		x >>= 1;
+		r += 1;
+	}
+	return r;
+}
+EXPORT_SYMBOL(generic_ffs);
+
+int generic_fls(int x)
+{
+	int r = 32;
+
+	if (!x)
+		return 0;
+	if (!(x & 0xffff0000u)) {
+		x <<= 16;
+		r -= 16;
+	}
+	if (!(x & 0xff000000u)) {
+		x <<= 8;
+		r -= 8;
+	}
+	if (!(x & 0xf0000000u)) {
+		x <<= 4;
+		r -= 4;
+	}
+	if (!(x & 0xc0000000u)) {
+		x <<= 2;
+		r -= 2;
+	}
+	if (!(x & 0x80000000u)) {
+		x <<= 1;
+		r -= 1;
+	}
+	return r;
+}
+EXPORT_SYMBOL(generic_fls);
+
+unsigned int generic_hweight32(unsigned int w)
+{
+        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
+        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
+        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
+        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
+        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+}
+EXPORT_SYMBOL(generic_hweight32);
+
+unsigned int generic_hweight16(unsigned int w)
+{
+        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
+        res = (res & 0x3333) + ((res >> 2) & 0x3333);
+        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
+        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
+}
+EXPORT_SYMBOL(generic_hweight16);
+
+unsigned int generic_hweight8(unsigned int w)
+{
+        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
+        res = (res & 0x33) + ((res >> 2) & 0x33);
+        return (res & 0x0F) + ((res >> 4) & 0x0F);
+}
+EXPORT_SYMBOL(generic_hweight8);
+
+unsigned int generic_hweight64(__u64 w)
+{
+#if BITS_PER_LONG < 64
+	return generic_hweight32((unsigned int)(w >> 32)) +
+				generic_hweight32((unsigned int)w);
+#else
+	u64 res;
+	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
+	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
+	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
+	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
+	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+#endif
+}
+EXPORT_SYMBOL(generic_hweight64);
