Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbRBIAm6>; Thu, 8 Feb 2001 19:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRBIAmt>; Thu, 8 Feb 2001 19:42:49 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:42762 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S129109AbRBIAmf>;
	Thu, 8 Feb 2001 19:42:35 -0500
Date: Fri, 9 Feb 2001 01:42:27 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: linux-kernel@vger.kernel.org
Cc: riel@conectiva.com.br
Subject: [PATCH] redundant call to vm_enough_memory
Message-ID: <20010209014227.O13984@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a redundant call to vm_enough_memory from
mm/mmap.c:sys_brk. Exactly the same test is made in mm/mmap.c:do_brk,
with the exception that the latter is done after calling do_munmap.

Note that do_munmap in do_brk has no effect when called from sys_brk,
because the check for find_vma_intersection only lets us pass if there
are no memory objects in the way.

The patch is for 2.4.2-pre1, with my /proc/sys/vm/max_map_count patch
applied. (The latter only changes some offsets, not the context of this
patch.)

- Werner

------------------------------------ patch ------------------------------------

--- linux.orig/mm/mmap.c	Mon Jan 29 17:10:41 2001
+++ linux/mm/mmap.c	Fri Feb  9 01:12:55 2001
@@ -148,10 +149,6 @@
 	if (find_vma_intersection(mm, oldbrk, newbrk+PAGE_SIZE))
 		goto out;
 
-	/* Check if we have enough memory.. */
-	if (!vm_enough_memory((newbrk-oldbrk) >> PAGE_SHIFT))
-		goto out;
-
 	/* Ok, looks good - let it rip. */
 	if (do_brk(oldbrk, newbrk-oldbrk) != oldbrk)
 		goto out;
-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
