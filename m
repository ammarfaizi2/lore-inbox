Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263805AbUDVHTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUDVHTM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263797AbUDVHRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:17:43 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:24499 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263722AbUDVHJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:09:20 -0400
Date: Thu, 22 Apr 2004 00:06:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [Patch 2 of 17] cpumask v4 - Dont generate nonzero unused bits in
 bitmap
Message-Id: <20040422000657.1dd399fd.pj@sgi.com>
In-Reply-To: <20040421232247.22ffe1f2.pj@sgi.com>
References: <20040421232247.22ffe1f2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mask2-bitmap-complement - Dont generate nonzero unused bits in bitmap
        Tighten up bitmap so it does not generate nonzero bits
        in the unused tail if it is not given any on input.

Index: 2.6.5.bitmap/lib/bitmap.c
===================================================================
--- 2.6.5.bitmap.orig/lib/bitmap.c	2004-04-05 02:50:25.000000000 -0700
+++ 2.6.5.bitmap/lib/bitmap.c	2004-04-05 03:02:39.000000000 -0700
@@ -26,10 +26,10 @@
  * carefully filter out these unused bits from impacting their
  * results.
  *
- * Except for bitmap_complement, these operations hold to a
- * slightly stronger rule: if you don't input any bitmaps to
- * these ops that have some unused bits set, then they won't
- * output any set unused bits in output bitmaps.
+ * These operations actually hold to a slightly stronger rule:
+ * if you don't input any bitmaps to these ops that have some
+ * unused bits set, then they won't output any set unused bits
+ * in output bitmaps.
  */
 
 #define MAX_BITMAP_BITS	512U	/* for ia64 NR_CPUS maximum */
@@ -83,11 +83,12 @@
 
 void bitmap_complement(unsigned long *bitmap, int bits)
 {
-	int k;
-	int nr = BITS_TO_LONGS(bits);
-
-	for (k = 0; k < nr; ++k)
+	int k, lim = bits/BITS_PER_LONG;
+	for (k = 0; k < lim; ++k)
 		bitmap[k] = ~bitmap[k];
+
+	if (bits % BITS_PER_LONG)
+		bitmap[k] = ~bitmap[k] & ((1UL << (bits % BITS_PER_LONG)) - 1);
 }
 EXPORT_SYMBOL(bitmap_complement);
 


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
