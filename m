Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTEISBC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263383AbTEISBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:01:01 -0400
Received: from holomorphy.com ([66.224.33.161]:28577 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263380AbTEISAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:00:25 -0400
Date: Fri, 9 May 2003 11:12:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm3
Message-ID: <20030509181257.GB8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030508013958.157b27b7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508013958.157b27b7.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 01:39:58AM -0700, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.69-mm3.gz
>   Will appear sometime at
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm3/

topology.h has a syntactic hygiene issue where it has a for () loop with
an if () in the body defined as a macro:

#define foo(...) for (...) if (...)

This patch prepares some of the bitop definitions used for the loop
mechanics to be usable in headers where BITS_PER_LONG is not guaranteed
to be defined for some reason. It removes the #ifdef on BITS_PER_LONG
in favor of if (sizeof(...) == ...) tests so hweight_long() will be
defined even when BITS_PER_LONG is not. unsigned long is also used for
some variables and/or return types that changed size with BITS_PER_LONG.
The 32-bit generic_hweight64() also changed its argument from a pointer
to a u64, which actually makes for a consistent interface in both cases.

The follow-up will make use of this to clean up the hygiene issue above
and correct a compilation error in topology.h


-- wli


diff -urpN mm3-2.5.69-1/include/linux/bitops.h mm3-2.5.69-2/include/linux/bitops.h
--- mm3-2.5.69-1/include/linux/bitops.h	2003-05-09 09:22:16.000000000 -0700
+++ mm3-2.5.69-2/include/linux/bitops.h	2003-05-09 10:27:57.000000000 -0700
@@ -1,5 +1,6 @@
 #ifndef _LINUX_BITOPS_H
 #define _LINUX_BITOPS_H
+#include <asm/types.h>
 #include <asm/bitops.h>
 
 /*
@@ -107,11 +108,14 @@ static inline unsigned int generic_hweig
         return (res & 0x0F) + ((res >> 4) & 0x0F);
 }
 
-#if (BITS_PER_LONG == 64)
-
-static inline u64 generic_hweight64(u64 w)
+static inline unsigned long generic_hweight64(u64 w)
 {
-        u64 res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);
+	u64 res;
+	if (sizeof(unsigned long) == 4)
+		return generic_hweight32((unsigned long)(w >> 32)) +
+					generic_hweight32((unsigned long)w);
+
+	res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);
         res = (res & 0x3333333333333333) + ((res >> 2) & 0x3333333333333333);
         res = (res & 0x0F0F0F0F0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F0F0F0F0F);
         res = (res & 0x00FF00FF00FF00FF) + ((res >> 8) & 0x00FF00FF00FF00FF);
@@ -119,22 +123,9 @@ static inline u64 generic_hweight64(u64 
         return (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
 }
 
-#define hweight_long(w)	generic_hweight64(w)
-
-#endif /* BITS_PER_LONG == 64 */
-
-#if (BITS_PER_LONG == 32)
-
-static inline unsigned int generic_hweight64(unsigned int *w)
+static inline unsigned long hweight_long(unsigned long x)
 {
-	return generic_hweight32(w[0]) + generic_hweight32(w[1]);
+	return sizeof(x) == 4 ? generic_hweight32(x) : generic_hweight64(x);
 }
 
-#define hweight_long(w)	generic_hweight32(w)
-
-#endif /* BITS_PER_LONG == 32 */
-
-#include <asm/bitops.h>
-
-
 #endif
