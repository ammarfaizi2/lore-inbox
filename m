Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264883AbUEVDtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264883AbUEVDtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 23:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUEVDtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 23:49:16 -0400
Received: from holomorphy.com ([207.189.100.168]:15239 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264883AbUEVDtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 23:49:14 -0400
Date: Fri, 21 May 2004 20:49:02 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: manfred@colorfullife.com
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: slab redzoning
Message-ID: <20040522034902.GB2161@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	manfred@colorfullife.com, mpm@selenic.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code does not appear to match the intent for slab redzoning sizing.
It wants to ignore size increases when order 0 allocations are involved,
and otherwise to allow the size increase except when it would make the
size cross a power of 2 boundary.

This actually came under scrutiny during a discussion of fls() usage,
but there appears to be little that can be done there.

The following patch attempts to correct this variation of code from
intent and to document the intent in more detail. Untested.

One thing that could happen is to change or clarify what's trying to
be done to be something other than what I've arranged this to do. The
important point is that the current code doesn't match the intent.


Index: mm4-2.6.6/mm/slab.c
===================================================================
--- mm4-2.6.6.orig/mm/slab.c	2004-05-21 14:30:17.000000000 -0700
+++ mm4-2.6.6/mm/slab.c	2004-05-21 20:13:07.892507000 -0700
@@ -1158,8 +1158,21 @@
 	 * large objects, if the increased size would increase the object size
 	 * above the next power of two: caches with object sizes just above a
 	 * power of two have a significant amount of internal fragmentation.
+	 *
+	 * The situation we're trying to avoid is there being a power of 2,
+	 * 2**n for some n, where size < 2**n <= size + 3*BYTES_PER_WORD,
+	 * but excepting anything smaller than a page.
+	 * PAGE_SIZE >= 1024 and 3*BYTES_PER_WORD <= 24 so ignore the
+	 * case where size would more than double from redzone overhead
+	 * in this check; it's taken care of by checking for <= PAGE_SIZE.
+	 * 1 << fls(size) is the next power of 2 above size, so then
+	 * this checks that size is more than 3*BYTES_PER_WORD below it.
+	 * This also special cases the case where size is a power of 2,
+	 * where fragmentation would be increased greatly.
 	 */
-	if ((size < 4096 || fls(size-1) == fls(size-1+3*BYTES_PER_WORD)))
+	if (size + 3*BYTES_PER_WORD <= PAGE_SIZE ||
+				((size & (size - 1)) &&
+				(1 << fls(size)) - size > 3*BYTES_PER_WORD))
 		flags |= SLAB_RED_ZONE|SLAB_STORE_USER;
 	flags |= SLAB_POISON;
 #endif
