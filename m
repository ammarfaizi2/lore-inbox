Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTFOCRF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 22:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTFOCRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 22:17:05 -0400
Received: from dp.samba.org ([66.70.73.150]:49879 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261808AbTFOCRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 22:17:03 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16107.55733.155825.17744@cargo.ozlabs.ibm.com>
Date: Sun, 15 Jun 2003 12:28:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@digeo.com, torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: manfred@colorfullife.com
Subject: [PATCH] fix weird kmalloc bug
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last night, Manfred and I found an interesting bug with kmalloc on
ppc32, where the kmalloc in alloc_super() (fs/super.c) was requesting
432 bytes but only getting 256 bytes.  The reason was that PAGE_SIZE
wasn't defined at the point where the kmalloc() inline function
occurs.  Thus the CACHE(32) entry got omitted from the list in
kmalloc_sizes.h, and kmalloc therefore used the entry in
malloc_sizes[] before the correct entry.

This patch fixes it by including asm/page.h and asm/cache.h in
linux/slab.h.  The list in kmalloc_sizes.h depends on L1_CACHE_BYTES
as well as PAGE_SIZE, which is why I added asm/cache.h.

Paul.

diff -urN linux-2.5/include/linux/slab.h pmac-2.5-smp/include/linux/slab.h
--- linux-2.5/include/linux/slab.h	2003-06-12 10:43:55.000000000 +1000
+++ pmac-2.5/include/linux/slab.h	2003-06-14 22:16:14.000000000 +1000
@@ -13,6 +13,8 @@
 
 #include	<linux/gfp.h>
 #include	<linux/types.h>
+#include	<asm/page.h>
+#include	<asm/cache.h>
 
 /* flags for kmem_cache_alloc() */
 #define	SLAB_NOFS		GFP_NOFS
