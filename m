Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWFBBdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWFBBdW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 21:33:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWFBBdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 21:33:22 -0400
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:12453 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751080AbWFBBdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 21:33:21 -0400
Date: Thu, 1 Jun 2006 21:28:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.16-rc5-mm2] i386 memcpy: optimal memcpy for IO
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200606012130_MC3-1-C15B-2A16@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: H. Peter Anvin <hpa@zytor.com>

Optimal memcpy for moves to/from IO space.  Does as few moves as
possible while keeping transfers optimally aligned.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

Andrew, remove i386-memcpy-use-as-few-moves-as.patch from -mm
and replace it with this, please.

 arch/i386/lib/memcpy.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/io.h  |   11 ++-------
 2 files changed, 60 insertions(+), 8 deletions(-)

--- 2.6.17-rc5-32.orig/arch/i386/lib/memcpy.c
+++ 2.6.17-rc5-32/arch/i386/lib/memcpy.c
@@ -42,3 +42,60 @@ void *memmove(void *dest, const void *sr
 	return dest;
 }
 EXPORT_SYMBOL(memmove);
+
+/*
+ * The most general form of memory copy to/from I/O space, used for
+ * devices which can handle arbitrary transactions with appropriate
+ * handling of byte enables.  The goal is to produce the minimum
+ * number of naturally aligned transactions on the bus.
+ */
+
+#define build_memcpy_io(dst, src, count, align_reg)	\
+({							\
+unsigned long d0, d1, d2, d3;				\
+asm volatile(						\
+	"jecxz	1f\n\t"					\
+							\
+	"testl	$1, " align_reg "\n\t"			\
+	"jz	2f\n\t"					\
+	"movsb\n\t"					\
+	"decl	%2\n"					\
+"2:\n\t"						\
+	"cmpl	$2, %2\n\t"				\
+	"jb	3f\n\t"					\
+	"testl	$2, " align_reg "\n\t"			\
+	"jz	4f\n\t"					\
+	"movsw\n\t"					\
+	"decl	%2\n\t"					\
+	"decl	%2\n"					\
+"4:\n\t"						\
+	"movl	%2, %3\n\t"				\
+	"shrl	$2, %2\n\t"				\
+	"jz	5f\n\t"					\
+	"rep ; movsl\n"					\
+"5:\n\t"						\
+	"movl	%3, %2\n\t"				\
+	"testb	$2, %b2\n\t"				\
+	"jz	3f\n\t"					\
+	"movsw\n"					\
+"3:\n\t"						\
+	"testb	$1, %b2\n\t"				\
+	"jz	1f\n\t"					\
+	"movsb\n"					\
+"1:"							\
+	: "=&D" (d0), "=&S" (d1), "=&c" (d2), "=&g" (d3)\
+	: "0" (dst), "1" (src), "2" (count)		\
+	: "memory");					\
+})
+
+void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
+{
+	build_memcpy_io(dst, src, count, "%%esi");
+}
+EXPORT_SYMBOL(memcpy_fromio)
+
+void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
+{
+	build_memcpy_io(dst, src, count, "%%edi");
+}
+EXPORT_SYMBOL(memcpy_toio)
--- 2.6.17-rc5-32.orig/include/asm-i386/io.h
+++ 2.6.17-rc5-32/include/asm-i386/io.h
@@ -200,14 +200,9 @@ static inline void memset_io(volatile vo
 {
 	memset((void __force *) addr, val, count);
 }
-static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
-{
-	__memcpy(dst, (void __force *) src, count);
-}
-static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
-{
-	__memcpy((void __force *) dst, src, count);
-}
+
+extern void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
+extern void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
 
 /*
  * ISA space is 'always mapped' on a typical x86 system, no need to
-- 
Chuck
