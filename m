Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272692AbRIGOzr>; Fri, 7 Sep 2001 10:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272691AbRIGOzf>; Fri, 7 Sep 2001 10:55:35 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22808 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S272689AbRIGOzU>; Fri, 7 Sep 2001 10:55:20 -0400
Date: Fri, 7 Sep 2001 16:56:12 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@redhat.com>
Subject: flush_tlb_all in vmalloc_area_pages
Message-ID: <20010907165612.T11329@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

can somebody see a good reason for flushing the tlb in vmalloc? We must
do that in vfree but doing it in vmalloc is just a waste of time, we are
guaranteed that's an unmapped space before we start setting up the
pagetables so such address space cannot be cached in any tlb in first
place.

For the flush_cache_all for the virtually indexed caches should be the
same issue in theory (at least the kmap logic only needs to flush the
caches before the unmapping [not before the mapping] too)

Am I missing something, Dave?

--- 2.4.10pre4aa1/mm/vmalloc.c.~1~	Sat May 26 04:03:50 2001
+++ 2.4.10pre4aa1/mm/vmalloc.c	Fri Sep  7 16:53:41 2001
@@ -144,7 +144,6 @@
 	int ret;
 
 	dir = pgd_offset_k(address);
-	flush_cache_all();
 	spin_lock(&init_mm.page_table_lock);
 	do {
 		pmd_t *pmd;
@@ -164,7 +163,6 @@
 		ret = 0;
 	} while (address && (address < end));
 	spin_unlock(&init_mm.page_table_lock);
-	flush_tlb_all();
 	return ret;
 }
 
Andrea
