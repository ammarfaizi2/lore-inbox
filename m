Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbVFGDOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVFGDOi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbVFGDOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:14:37 -0400
Received: from mail.renesas.com ([202.234.163.13]:50319 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261614AbVFGDOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:14:21 -0400
Date: Tue, 07 Jun 2005 12:14:14 +0900 (JST)
Message-Id: <20050607.121414.137821416.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.12-rc5] m32r: Use asm-generic/div64.h
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, hitoshiy@isl.melco.co.jp,
       takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.17 (Jumbo Shrimp)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The current include/asm-m32r/div64.h of 2.6.12-rc5 looks buggy.
Here is a patch for updating it to use asm-generic/div64.h for m32r
like other architectures.

Please apply.

Symptoms: for example
- idle time information of /proc/uptime is incorrect.
- "top" command sometimes reports incorrect cpu states like this:
> top - 14:05:01 up 5 min,  2 users,  load average: 0.15, 0.14, 0.07
> Tasks:  28 total,   3 running,  25 sleeping,   0 stopped,   0 zombie
> Cpu(s): 2500.0% us, 12800.0% sy,  0.0% ni, 2200.0% id, -28100.0% wa,  0.0% hi, 
> Mem:     26748k total,    22484k used,     4264k free,        0k buffers
> Swap:        0k total,        0k used,        0k free,    14656k cached

Thanks,

From: Bernardo Innocenti (bernie@develer.com)
Subject: [PATCH] Kill div64.h dupes, parenthesize do_div() macro params
Date: Tue Jul 01 2003 - 19:32:20 EST
>  - move the 64/32bit do_div() macro to a new asm-generic/div64.h
>    header;
> 
>  - kill multiple copies of the generic version in architecture
>    specific subdirs. Most copies were either buggy or subtly
>    different from each other;
> 
>  - ensure all surviving instances of do_div() have their parameters
>    correctly parenthesized to avoid funny results;
> 
> Note that the arm26, cris, m68knommu, sh, sparc and v850 architectures
> are silently clipping 64bit dividend to 32bit! This patch doesn't try
> to fix this because I can't test on all architectures.
> 
> Patch submitted by Bernardo Innocenti <bernie@develer.com>
> 
> Applies to 2.5.73. Backporting to 2.4.21 is trivial.
> 
> FOOT NOTE: what's the point with do_div()? Isn't gcc's long long
> arithmetic support good enough on all platforms? If not, why
> doesn't that get fixed in libgcc instead of polluting the kernel
> with silly (and sometimes bogus) implementations?
> 
>  asm-alpha/div64.h | 15 +--------------
>  asm-arm26/div64.h | 15 +--------------
>  asm-cris/div64.h | 17 +----------------
>  asm-generic/div64.h | 13 +++++++++++++
>  asm-h8300/div64.h | 14 +-------------
>  asm-ia64/div64.h | 21 +--------------------
>  asm-m68k/div64.h | 9 ---------
>  asm-m68knommu/div64.h | 14 +-------------
>  asm-mips64/div64.h | 20 +-------------------
>  asm-parisc/div64.h | 36 ++++++++++--------------------------
>  asm-ppc64/div64.h | 19 +------------------
>  asm-s390/div64.h | 8 +-------
>  asm-sh/div64.h | 11 +----------
>  asm-sparc/div64.h | 12 +-----------
>  asm-sparc64/div64.h | 15 +--------------
>  asm-v850/div64.h | 12 +-----------
>  asm-x86_64/div64.h | 15 +--------------
>  17 files changed, 37 insertions(+), 229 deletions(-) 


Signed-off-by: Hitoshi Yamamoto <hitoshiy@isl.melco.co.jp>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

diff -ruNp a/include/asm-m32r/div64.h b/include/asm-m32r/div64.h
--- a/include/asm-m32r/div64.h	2004-12-25 06:33:49.000000000 +0900
+++ b/include/asm-m32r/div64.h	2005-05-31 19:49:38.000000000 +0900
@@ -1,38 +1 @@
-#ifndef _ASM_M32R_DIV64
-#define _ASM_M32R_DIV64
-
-/* $Id$ */
-
-/* unsigned long long division.
- * Input:
- *  unsigned long long  n
- *  unsigned long  base
- * Output:
- *  n = n / base;
- *  return value = n % base;
- */
-#define do_div(n, base)						\
-({								\
-	unsigned long _res, _high, _mid, _low;			\
-								\
-	_low = (n) & 0xffffffffUL;				\
-	_high = (n) >> 32;					\
-	if (_high) {						\
-		_mid = (_high % (unsigned long)(base)) << 16;	\
-		_high = _high / (unsigned long)(base);		\
-		_mid += _low >> 16;				\
-		_low &= 0x0000ffffUL;				\
-		_low += (_mid % (unsigned long)(base)) << 16;	\
-		_mid = _mid / (unsigned long)(base);		\
-		_res = _low % (unsigned long)(base);		\
-		_low = _low / (unsigned long)(base);		\
-		n = _low + ((long long)_mid << 16) +		\
-			((long long)_high << 32);		\
-	} else {						\
-		_res = _low % (unsigned long)(base);		\
-		n = (_low / (unsigned long)(base));		\
-	}							\
-	_res;							\
-})
-
-#endif  /* _ASM_M32R_DIV64 */
+#include <asm-generic/div64.h>

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
