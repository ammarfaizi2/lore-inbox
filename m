Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262662AbUCVUWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUCVUWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:22:44 -0500
Received: from mail.ccur.com ([208.248.32.212]:46857 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S262547AbUCVUWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:22:39 -0500
Date: Mon, 22 Mar 2004 15:21:18 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Paul Jackson <pj@sgi.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] broken bitmap_parse for ncpus > 32
Message-ID: <20040322202118.GA27281@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
 This patch replaces the call to bitmap_shift_right() in bitmap_parse()
with bitmap_shift_left().

This mental confusion between right and left did not show up in my
(userland) testing, as I foolishly wrote my own bitmap_shift routines
rather than drag over the kernel versions.  And it did not show up in my
kernel testing because no shift routine is called when NR_CPUS <= 32.

I tested this in userland with the kernel's versions of bitmap_shift_*
and compiled a kernel and spot checked it on a 2-cpu system.

I also prepended comments to the bitmap_shift_* functions defining what
'left' and 'right' means. This is under the theory that if I and all the
reviewers were bamboozled, others in the future occasionally might be too.

Regards,
Joe

--- base/lib/bitmap.c	2004-03-10 21:55:43.000000000 -0500
+++ new/lib/bitmap.c	2004-03-22 14:41:03.000000000 -0500
@@ -71,6 +71,11 @@
 }
 EXPORT_SYMBOL(bitmap_complement);
 
+/*
+ * Shifting right (dividing) means moving bits in the MS -> LS bit
+ * direction.  Zeros are fed into the vacated MS positions and the
+ * LS bits shifted off the bottom are lost.
+ */
 void bitmap_shift_right(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
@@ -86,6 +91,11 @@
 }
 EXPORT_SYMBOL(bitmap_shift_right);
 
+/*
+ * Shifting left (multiplying) means moving bits in the LS -> MS
+ * direction.  Zeros are fed into the vacated LS bit positions
+ * and those MS bits shifted off the top are lost.
+ */
 void bitmap_shift_left(unsigned long *dst,
 			const unsigned long *src, int shift, int bits)
 {
@@ -269,7 +279,7 @@
 		if (nchunks == 0 && chunk == 0)
 			continue;
 
-		bitmap_shift_right(maskp, maskp, CHUNKSZ, nmaskbits);
+		bitmap_shift_left(maskp, maskp, CHUNKSZ, nmaskbits);
 		*maskp |= chunk;
 		nchunks++;
 		nbits += (nchunks == 1) ? nbits_to_hold_value(chunk) : CHUNKSZ;
