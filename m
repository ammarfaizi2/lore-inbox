Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbWEaBGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbWEaBGu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 21:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWEaBGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 21:06:50 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:20352 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932552AbWEaBGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 21:06:49 -0400
Date: Tue, 30 May 2006 20:59:45 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.17-rc5 1/2] i386 memcpy: use as few moves as
  possible for I/O
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chris Lesiak <chris.lesiak@licor.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200605302103_MC3-1-BF0E-59B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Lesiak reported that changes to i386's __memcpy() broke his device
because it can't handle byte moves and the new code uses them for
all trailing bytes when the length is not divisible by four.  The old
code tried to use a 16-bit move and/or a byte move as needed.

H. Peter Anvin:
"There are only a few semantics that make sense: fixed 8, 16, 32, or 64
bits, plus "optimal"; the latter to be used for anything that doesn't
require a specific transfer size.  Logically, an unqualified
"memcpy_to/fromio" should be the optimal size (as few transfers as
possible)"

So add back the old code as __minimal_memcpy and have IO transfers
use that.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 include/asm-i386/io.h     |    4 ++--
 include/asm-i386/string.h |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

--- 2.6.17-rc5-32.orig/include/asm-i386/io.h
+++ 2.6.17-rc5-32/include/asm-i386/io.h
@@ -202,11 +202,11 @@ static inline void memset_io(volatile vo
 }
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
 {
-	__memcpy(dst, (void __force *) src, count);
+	__minimal_memcpy(dst, (void __force *) src, count);
 }
 static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
 {
-	__memcpy((void __force *) dst, src, count);
+	__minimal_memcpy((void __force *) dst, src, count);
 }
 
 /*
--- 2.6.17-rc5-32.orig/include/asm-i386/string.h
+++ 2.6.17-rc5-32/include/asm-i386/string.h
@@ -220,6 +220,28 @@ return (to);
 }
 
 /*
+ * Do memcpy with as few moves as possible (for transfers to/from IO space.)
+ */
+static inline void * __minimal_memcpy(void * to, const void * from, size_t n)
+{
+int d0, d1, d2;
+__asm__ __volatile__(
+	"rep ; movsl\n\t"
+	"testb $2,%b4\n\t"
+	"jz 1f\n\t"
+	"movsw\n"
+	"1:\n\t"
+	"testb $1,%b4\n\t"
+	"jz 2f\n\t"
+	"movsb\n"
+	"2:"
+	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
+	:"0" (n/4), "q" (n), "1" ((long) to), "2" ((long) from)
+	: "memory");
+return to;
+}
+
+/*
  * This looks ugly, but the compiler can optimize it totally,
  * as the count is constant.
  */
-- 
Chuck
