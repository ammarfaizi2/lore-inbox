Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVAWCOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVAWCOP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:14:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVAWCOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:14:15 -0500
Received: from siaag1ad.compuserve.com ([149.174.40.6]:63689 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S261174AbVAWCOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:14:07 -0500
Date: Sat, 22 Jan 2005 21:10:40 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 1/12] random pt4: Create new rol32/ror32 bitops
To: Matt Mackall <mpm@selenic.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>
Message-ID: <200501222113_MC3-1-940A-5393@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2005 at 15:41:06 -0600 Matt Mackall wrote:

> Add rol32 and ror32 bitops to bitops.h

Can you test this patch on top of yours?  I did it on 2.6.10-ac10 but it
should apply OK.  Compile tested and booted, but only random.c is using it
in my kernel.

x86-64 could use this too...

Add i386 bitops for rol32/ror32:
Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.10-ac10/include/linux/bitops.h~orig     2005-01-22 11:31:20.130239000 -0500
+++ 2.6.10-ac10/include/linux/bitops.h  2005-01-22 11:34:55.740239000 -0500
@@ -129,6 +129,7 @@
        return sizeof(w) == 4 ? generic_hweight32(w) : generic_hweight64(w);
 }
 
+#ifndef __HAVE_ARCH_ROTATE_32
 /*
  * rol32 - rotate a 32-bit value left
  *
@@ -150,5 +151,6 @@
 {
        return (word >> shift) | (word << (32 - shift));
 }
+#endif /* ndef __HAVE_ARCH_ROTATE_32 */
 
 #endif
--- 2.6.10-ac10/include/asm-i386/bitops.h~orig  2004-08-24 05:08:39.000000000 -0400
+++ 2.6.10-ac10/include/asm-i386/bitops.h       2005-01-22 11:42:12.010239000 -0500
@@ -431,6 +431,41 @@
 #define hweight16(x) generic_hweight16(x)
 #define hweight8(x) generic_hweight8(x)
 
+#define __HAVE_ARCH_ROTATE_32
+/*
+ * rol32 - rotate a 32-bit value left
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static inline __u32 rol32(__u32 word, int shift)
+{
+       __u32 res;
+
+       asm("roll %%cl,%0"
+           : "=r" (res)
+           : "0" (word), "c" (shift)
+           : "cc");
+       return res;
+}
+
+/*
+ * ror32 - rotate a 32-bit value right
+ *
+ * @word: value to rotate
+ * @shift: bits to roll
+ */
+static inline __u32 ror32(__u32 word, int shift)
+{
+       __u32 res;
+
+       asm("rorl %%cl,%0"
+           : "=r" (res)
+           : "0" (word), "c" (shift)
+           : "cc");
+       return res;
+}
+
 #endif /* __KERNEL__ */
 
 #ifdef __KERNEL__

Chuck
