Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSFDJtp>; Tue, 4 Jun 2002 05:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317470AbSFDJto>; Tue, 4 Jun 2002 05:49:44 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:60107 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S317469AbSFDJtn>;
	Tue, 4 Jun 2002 05:49:43 -0400
Date: Tue, 4 Jun 2002 19:47:42 +1000
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use page_to_pfn in BIO code
Message-ID: <20020604094741.GA17665@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

While porting the DISCONTIGMEM code to ppc64 (in order to do NUMA memory
allocation) I noticed the bio code uses page_to_phys. We should instead
be using the recently introduced page_to_pfn code.

This now limits the direct usage of mem_map (at least on ppc64) to 
two spots - page_to_pfn/pfn_to_page which makes DISCONTIGMEM support
quite trivial.

Anton

diff -urN linux-2.5_ppc64/include/linux/bio.h linux-2.5_work/include/linux/bio.h
--- linux-2.5_ppc64/include/linux/bio.h	Wed May  8 10:31:25 2002
+++ linux-2.5_work/include/linux/bio.h	Tue Jun  4 16:20:41 2002
@@ -128,8 +130,8 @@
 /*
  * will die
  */
-#define bio_to_phys(bio)	(page_to_phys(bio_page((bio))) + (unsigned long) bio_offset((bio)))
-#define bvec_to_phys(bv)	(page_to_phys((bv)->bv_page) + (unsigned long) (bv)->bv_offset)
+#define bio_to_phys(bio)	((page_to_pfn(bio_page((bio))) << PAGE_SHIFT) + (unsigned long) bio_offset((bio)))
+#define bvec_to_phys(bv)	((page_to_pfn((bv)->bv_page) << PAGE_SHIFT) + (unsigned long) (bv)->bv_offset)
 
 /*
  * queues that have highmem support enabled may still need to revert to
