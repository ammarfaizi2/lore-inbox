Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUDAV31 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 16:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUDAV2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 16:28:47 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:19762 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263166AbUDAVMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 16:12:19 -0500
Date: Thu, 1 Apr 2004 13:10:13 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Matthew Dobson <colpatch@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: [Patch 1/23] mask v2 - Document bitmap.c bit model
Message-Id: <20040401131013.08929f6d.pj@sgi.com>
In-Reply-To: <20040401122802.23521599.pj@sgi.com>
References: <20040401122802.23521599.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch_1_of_23 - Document bitmap.c bit model.
	Document the bitmap bit model, including handling of unused bits,
	and operation preconditions and postconditions.

Diffstat Patch_1_of_23:
 bitmap.c                       |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+)

===================================================================
--- 2.6.4.orig/lib/bitmap.c	2004-03-31 20:47:58.000000000 -0800
+++ 2.6.4/lib/bitmap.c	2004-03-31 21:20:02.000000000 -0800
@@ -12,6 +12,44 @@
 #include <asm/bitops.h>
 #include <asm/uaccess.h>
 
+/*
+ * The bitmap bit model:
+ *
+ * The operations in this lib/bitmap.c, and the associated
+ * files include/linux/bitmap.h, include/linux/bitops.h,
+ * and include/asm-*/bitops.h, and in the *_BITMAP macros in
+ * include/linux/types.h, support a model of a set of bits, in
+ * positions 0 .. nbits-1, for some nbits size between 1 and some
+ * modest size.  There is no specific limit on the size, but the
+ * internal representation, as an array of unsigned longs, would
+ * not be efficient for very large or sparse sets.
+ *
+ * If the number of valid bits in a particular bitmap is not
+ * an exact multiple of the number of bits in an unsigned long
+ * (BITS_PER_LONG), then there will be some unused bits, in a
+ * so called "tail", that is physically present in the internal
+ * representation, but will appear as if always zero to callers.
+ *
+ * To a first approximation, the "tail" bits are don't care bits.
+ * That is, regardless of their internal state, zero (0) or one
+ * (1), any of these functions will behave as if they were zero.
+ * In particular, all the bitmap functions returning a Boolean
+ * (e.g. bitmap_empty) or scalar (e.g. bitmap_weight) value are
+ * implemented so as to filter out or avoid being affected by
+ * possible one bits in the tail.
+ *
+ * Bitmaps are declared using the DECLARE_BITMAP() macro in
+ * include/linux/types.h.  Subsequent operations on a bitmap that
+ * take a bit position, such as set_bit(), must only be provided
+ * positions between 0 and the bitmap size, as first provided
+ * in the DECLARE_BITMAP() invocation.  Bitmap operations, such
+ * as bitmap_empty(), that take an argument specifying how many
+ * bits are in the bitmap, must be provided the same number as
+ * first provided to DECLARE_BITMAP().  Bitmap operations such as
+ * bitmap_or() that take two bitmaps as input must be passed two
+ * bitmaps of the same size.
+ */
+
 #define MAX_BITMAP_BITS	512U	/* for ia64 NR_CPUS maximum */
 
 int bitmap_empty(const unsigned long *bitmap, int bits)


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
