Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUDAVLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbUDAVLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:11:54 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:29233 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263171AbUDAVLw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:11:52 -0500
Date: Thu, 1 Apr 2004 13:10:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: [Patch 2/23] mask v2 - Tighten unused bitmap bit handling
Message-Id: <20040401131059.6eb19f7e.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_2_of_23 - Dont generate nonzero unused bits in bitmap
	Tighten up bitmap so it does not generate nonzero bits
	in the unused tail if it is not given any on input.

Diffstat Patch_2_of_23:
 bitmap.c                       |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

===================================================================
--- 2.6.4.orig/lib/bitmap.c	2004-03-31 21:20:02.000000000 -0800
+++ 2.6.4/lib/bitmap.c	2004-03-31 21:22:31.000000000 -0800
@@ -38,6 +38,15 @@
  * implemented so as to filter out or avoid being affected by
  * possible one bits in the tail.
  *
+ * These operations actually provide a slightly stronger guarantee.
+ * If all input masks to a given operation have only zero bits in
+ * their tail, then any output masks from such an operation will
+ * also have only zero bits in the tail.  These bitmap operations
+ * themselves don't require that input bitmap arguments to bitmap
+ * operations have zero tails; but these operations will not
+ * generate any ones in tails, if not provided such.  This enables
+ * certain efficiencies in users of bitmaps.
+ *
  * Bitmaps are declared using the DECLARE_BITMAP() macro in
  * include/linux/types.h.  Subsequent operations on a bitmap that
  * take a bit position, such as set_bit(), must only be provided
@@ -101,11 +110,12 @@
 
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
