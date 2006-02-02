Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWBBMuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWBBMuU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 07:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWBBMuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 07:50:19 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:34 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751020AbWBBMuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 07:50:15 -0500
Date: Thu, 2 Feb 2006 21:50:07 +0900
To: Andi Kleen <ak@suse.de>
Cc: Michael Tokarev <mjt@tls.msk.ru>, linux-kernel@vger.kernel.org,
       Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       dev-etrax@axis.com, David Howells <dhowells@redhat.com>,
       Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>, linux-ia64@vger.kernel.org,
       Hirokazu Takata <takata@linux-m32r.org>, linux-m68k@vger.kernel.org,
       Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org,
       parisc-linux@parisc-linux.org, linuxppc-dev@ozlabs.org,
       linux390@de.ibm.com, linuxsh-dev@lists.sourceforge.net,
       linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org,
       ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>,
       Chris Zankel <chris@zankel.net>
Subject: Re: [patch 14/44] generic hweight{64,32,16,8}()
Message-ID: <20060202125007.GA5918@miraclelinux.com>
References: <20060201090224.536581000@localhost.localdomain> <200602011006.09596.ak@suse.de> <43E07EB2.4020409@tls.msk.ru> <200602011124.29423.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602011124.29423.ak@suse.de>
User-Agent: Mutt/1.5.9i
From: mita@miraclelinux.com (Akinobu Mita)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2006 at 11:24:27AM +0100, Andi Kleen wrote:
> On Wednesday 01 February 2006 10:26, Michael Tokarev wrote:
> > Andi Kleen wrote:
> > > On Wednesday 01 February 2006 10:02, Akinobu Mita wrote:
> > > 
> > >>+static inline unsigned int hweight32(unsigned int w)
> > []
> > > How large are these functions on x86? Maybe it would be better to not inline them,
> > > but put it into some C file out of line.
> > 
> > hweight8	47 bytes
> > hweight16	76 bytes
> > hweight32	97 bytes
> > hweight64	56 bytes (NOT inlining hweight32)
> > hweight64	197 bytes (inlining hweight32)
> > 
> > Those are when compiled as separate non-inlined functions,
> > with pushl %ebp and ret.
> 
> This would argue for moving them out of line.

This patch will put hweight*() into lib/hweight.c

Index: 2.6-git/include/asm-generic/bitops/hweight.h
===================================================================
--- 2.6-git.orig/include/asm-generic/bitops/hweight.h
+++ 2.6-git/include/asm-generic/bitops/hweight.h
@@ -1,54 +1,9 @@
 #ifndef _ASM_GENERIC_BITOPS_HWEIGHT_H_
 #define _ASM_GENERIC_BITOPS_HWEIGHT_H_
 
-#include <asm/types.h>
-
-/**
- * hweightN - returns the hamming weight of a N-bit word
- * @x: the word to weigh
- *
- * The Hamming Weight of a number is the total number of bits set in it.
- */
-
-static inline unsigned int hweight32(unsigned int w)
-{
-        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
-        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
-        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
-        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
-        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
-}
-
-static inline unsigned int hweight16(unsigned int w)
-{
-        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
-        res = (res & 0x3333) + ((res >> 2) & 0x3333);
-        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
-        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
-}
-
-static inline unsigned int hweight8(unsigned int w)
-{
-        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
-        res = (res & 0x33) + ((res >> 2) & 0x33);
-        return (res & 0x0F) + ((res >> 4) & 0x0F);
-}
-
-static inline unsigned long hweight64(__u64 w)
-{
-#if BITS_PER_LONG == 32
-	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
-#elif BITS_PER_LONG == 64
-	u64 res;
-	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
-	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
-	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
-	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
-	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
-	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
-#else
-#error BITS_PER_LONG not defined
-#endif
-}
+extern unsigned int hweight32(unsigned int w);
+extern unsigned int hweight16(unsigned int w);
+extern unsigned int hweight8(unsigned int w);
+extern unsigned long hweight64(__u64 w);
 
 #endif /* _ASM_GENERIC_BITOPS_HWEIGHT_H_ */
Index: 2.6-git/lib/Makefile
===================================================================
--- 2.6-git.orig/lib/Makefile
+++ 2.6-git/lib/Makefile
@@ -5,7 +5,7 @@
 lib-y := errno.o ctype.o string.o vsprintf.o cmdline.o \
 	 bust_spinlocks.o rbtree.o radix-tree.o dump_stack.o \
 	 idr.o div64.o int_sqrt.o bitmap.o extable.o prio_tree.o \
-	 sha1.o
+	 sha1.o hweight.o
 
 lib-y	+= kobject.o kref.o kobject_uevent.o klist.o
 
Index: 2.6-git/lib/hweight.c
===================================================================
--- /dev/null
+++ 2.6-git/lib/hweight.c
@@ -0,0 +1,54 @@
+#include <linux/module.h>
+#include <asm/types.h>
+
+/**
+ * hweightN - returns the hamming weight of a N-bit word
+ * @x: the word to weigh
+ *
+ * The Hamming Weight of a number is the total number of bits set in it.
+ */
+
+unsigned int hweight32(unsigned int w)
+{
+        unsigned int res = (w & 0x55555555) + ((w >> 1) & 0x55555555);
+        res = (res & 0x33333333) + ((res >> 2) & 0x33333333);
+        res = (res & 0x0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F);
+        res = (res & 0x00FF00FF) + ((res >> 8) & 0x00FF00FF);
+        return (res & 0x0000FFFF) + ((res >> 16) & 0x0000FFFF);
+}
+EXPORT_SYMBOL(hweight32);
+
+unsigned int hweight16(unsigned int w)
+{
+        unsigned int res = (w & 0x5555) + ((w >> 1) & 0x5555);
+        res = (res & 0x3333) + ((res >> 2) & 0x3333);
+        res = (res & 0x0F0F) + ((res >> 4) & 0x0F0F);
+        return (res & 0x00FF) + ((res >> 8) & 0x00FF);
+}
+EXPORT_SYMBOL(hweight16);
+
+unsigned int hweight8(unsigned int w)
+{
+        unsigned int res = (w & 0x55) + ((w >> 1) & 0x55);
+        res = (res & 0x33) + ((res >> 2) & 0x33);
+        return (res & 0x0F) + ((res >> 4) & 0x0F);
+}
+EXPORT_SYMBOL(hweight8);
+
+unsigned long hweight64(__u64 w)
+{
+#if BITS_PER_LONG == 32
+	return hweight32((unsigned int)(w >> 32)) + hweight32((unsigned int)w);
+#elif BITS_PER_LONG == 64
+	u64 res;
+	res = (w & 0x5555555555555555ul) + ((w >> 1) & 0x5555555555555555ul);
+	res = (res & 0x3333333333333333ul) + ((res >> 2) & 0x3333333333333333ul);
+	res = (res & 0x0F0F0F0F0F0F0F0Ful) + ((res >> 4) & 0x0F0F0F0F0F0F0F0Ful);
+	res = (res & 0x00FF00FF00FF00FFul) + ((res >> 8) & 0x00FF00FF00FF00FFul);
+	res = (res & 0x0000FFFF0000FFFFul) + ((res >> 16) & 0x0000FFFF0000FFFFul);
+	return (res & 0x00000000FFFFFFFFul) + ((res >> 32) & 0x00000000FFFFFFFFul);
+#else
+#error BITS_PER_LONG not defined
+#endif
+}
+EXPORT_SYMBOL(hweight64);
