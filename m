Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264769AbTGBGi3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 02:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264770AbTGBGi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 02:38:29 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:16615 "HELO
	develer.com") by vger.kernel.org with SMTP id S264769AbTGBGi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 02:38:27 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Andrea Arcangeli <andrea@suse.de>, Peter Chubb <peter@chubb.wattle.id.au>
Subject: Re: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Wed, 2 Jul 2003 08:52:17 +0200
User-Agent: KMail/1.5.9
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@transmeta.com>
References: <200307020232.20726.bernie@develer.com> <16130.21283.122787.362837@wombat.chubb.wattle.id.au> <20030702055759.GJ3040@dualathlon.random>
In-Reply-To: <20030702055759.GJ3040@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307020852.17782.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 July 2003 07:57, Andrea Arcangeli wrote:

 > this doesn't even sounds safe. If it's just for printing not a big
 > deal, but there may be functional usages where they should not
 > truncate the high 32bit of the 64bit words.

 I've seen some of them already. Even if none were currently present,
this would easily lead to architecture specific bugs in future kernels.

 > Bernardo, you should definitely add an #if BITS_PER_LONG == 64 around
 > your implementation of do_div in asm-generic, just to make an example
 > sparc is still silenty broken (and that's not an embedded thing).
 > [...]

 How does this new patch look? The 32bit version comes from asm-ppc/div64.h
and seems to work fine on m68knommu too, so I assume it to be at least
correct.

 Ciao!


--- /dev/null	1970-01-01 01:00:00.000000000 +0100
+++ asm-generic/div64.h	2003-07-02 08:23:48.000000000 +0200
@@ -0,0 +1,66 @@
+#ifndef _ASM_GENERIC_DIV64_H
+#define _ASM_GENERIC_DIV64_H
+
+#include <linux/types.h>
+
+/*
+ * do_div() performs a 64bit/32bit unsigned division and modulo.
+ * The 64bit result is stored back in the divisor, the 32bit
+ * remainder is returned.
+ *
+ * A semantically correct implementation would do this:
+ *
+ *	static inline uint32_t do_div(uint64_t &n, uint32_t base)
+ *	{
+ *		uint32_t rem;
+ *		rem = n % base;
+ *		n = n / base;
+ *		return rem;
+ *	}
+ *
+ * We can't rely on GCC's "long long" math since it would turn
+ * everything into a full 64bit division implemented through _udivdi3(),
+ * which is much slower.
+ */
+
+#if BITS_PER_LONG == 64
+
+# define do_div(n,base) ({					\
+	uint32_t __res;						\
+	__res = ((uint64_t)(n)) % (uint32_t)(base);		\
+	(n) = ((uint64_t)(n)) / (uint32_t)(base);		\
+	__res;							\
+ })
+
+#elif BITS_PER_LONG == 32
+
+# define do_div(n,base)	({					\
+								\
+	uint32_t __low, __low2, __high, __rem;			\
+	__low  = (n) & 0xffffffff;				\
+	__high = (n) >> 32;					\
+	if (__high) {						\
+		__rem   = __high % (uint32_t)(base);		\
+		__high  = __high / (uint32_t)(base);		\
+		__low2  = __low >> 16;				\
+		__low2 += __rem << 16;				\
+		__rem   = __low2 % (uint32_t)(base);		\
+		__low2  = __low2 / (uint32_t)(base);		\
+		__low   = __low & 0xffff;			\
+		__low  += __rem << 16;				\
+		__rem   = __low  % (uint32_t)(base);		\
+		__low   = __low  / (uint32_t)(base);		\
+		(n) = __low  + ((uint64_t)__low2 << 16) +	\
+			((uint64_t) __high << 32);		\
+	} else {						\
+		__rem = __low % (uint32_t)(base);		\
+		(n) = (__low / (uint32_t)(base));		\
+	}							\
+	__rem;							\
+ })
+
+#else /* BITS_PER_LONG == ?? */
+# error do_div() does not yet support the C64
+#endif /* BITS_PER_LONG */
+
+#endif /* _ASM_GENERIC_DIV64_H */

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


