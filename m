Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUDHUcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUDHTuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:50:12 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:29410 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262391AbUDHTtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:49:19 -0400
Date: Thu, 8 Apr 2004 12:48:43 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Patch 2/23 - Bitmaps, Cpumasks and Nodemasks
Message-Id: <20040408124843.223d219c.pj@sgi.com>
In-Reply-To: <20040408115050.2c67311a.pj@sgi.com>
References: <20040408115050.2c67311a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P2.bitmap_complement - Dont generate nonzero unused bits in bitmap
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
