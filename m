Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbWBNFFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbWBNFFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWBNFFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:05:45 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:3792 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030405AbWBNFFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:11 -0500
Message-Id: <20060214050450.360102000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:37 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Ben Collins <bcollins@debian.org>,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 46/47] hweight() related cleanup
Content-Disposition: inline; filename=bitmap-cleanup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

By defining generic hweight*() routines

- hweight64() will be defined on all architectures
- hweight_long() will use architecture optimized hweight32() or hweight64()

I found two possible cleanups by these reasons.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 drivers/ieee1394/highlevel.c |    3 +--
 lib/bitmap.c                 |   19 ++-----------------
 2 files changed, 3 insertions(+), 19 deletions(-)

Index: 2.6-rc/lib/bitmap.c
===================================================================
--- 2.6-rc.orig/lib/bitmap.c
+++ 2.6-rc/lib/bitmap.c
@@ -253,33 +253,18 @@ int __bitmap_subset(const unsigned long 
 }
 EXPORT_SYMBOL(__bitmap_subset);
 
-#if BITS_PER_LONG == 32
 int __bitmap_weight(const unsigned long *bitmap, int bits)
 {
 	int k, w = 0, lim = bits/BITS_PER_LONG;
 
 	for (k = 0; k < lim; k++)
-		w += hweight32(bitmap[k]);
+		w += hweight_long(bitmap[k]);
 
 	if (bits % BITS_PER_LONG)
-		w += hweight32(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
+		w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
 
 	return w;
 }
-#else
-int __bitmap_weight(const unsigned long *bitmap, int bits)
-{
-	int k, w = 0, lim = bits/BITS_PER_LONG;
-
-	for (k = 0; k < lim; k++)
-		w += hweight64(bitmap[k]);
-
-	if (bits % BITS_PER_LONG)
-		w += hweight64(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
-
-	return w;
-}
-#endif
 EXPORT_SYMBOL(__bitmap_weight);
 
 /*
Index: 2.6-rc/drivers/ieee1394/highlevel.c
===================================================================
--- 2.6-rc.orig/drivers/ieee1394/highlevel.c
+++ 2.6-rc/drivers/ieee1394/highlevel.c
@@ -306,8 +306,7 @@ u64 hpsb_allocate_and_register_addrspace
 	u64 align_mask = ~(alignment - 1);
 
 	if ((alignment & 3) || (alignment > 0x800000000000ULL) ||
-	    ((hweight32(alignment >> 32) +
-	      hweight32(alignment & 0xffffffff) != 1))) {
+	    (hweight64(alignment) != 1)) {
 		HPSB_ERR("%s called with invalid alignment: 0x%048llx",
 			 __FUNCTION__, (unsigned long long)alignment);
 		return retval;

--
