Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317661AbSHCSOB>; Sat, 3 Aug 2002 14:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317638AbSHCSM6>; Sat, 3 Aug 2002 14:12:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8976 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317639AbSHCSMx>; Sat, 3 Aug 2002 14:12:53 -0400
To: Linus Torvalds <torvalds@transmeta.com>
CC: <linux-kernel@vger.kernel.org>
From: Russell King <rmk@arm.linux.org.uk>
Subject: [PATCH] 7: 2.5.29-mmap
Message-Id: <E17b3Rp-0006wV-00@flint.arm.linux.org.uk>
Date: Sat, 03 Aug 2002 19:16:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch has been verified to apply cleanly to 2.5.30

This patch goes back almost 2 years.  First sent on: 30 September 2000
Ignored every time.

The following patch is required so that munmap(0x8000, *) does not cause
ARM kernels to crash.  The problem is that the machine vectors are at
virtual address 0.  Unfortunately, when free_pgtables() is called, it
clears first level page tables starting at 0 in this case, and takes
out the machine vectors.  This then results in an unrecoverable hang.

We already have FIRST_USER_PGD_NR to define the first entry in the pgd
which may be cleared, so we use this to clamp "start_index"
appropriately.  The following patch does this.  Tested on ARM.

 mm/mmap.c |    2 ++
 1 files changed, 2 insertions

diff -urN orig/mm/mmap.c linux/mm/mmap.c
--- orig/mm/mmap.c	Sat Jul 27 13:55:25 2002
+++ linux/mm/mmap.c	Sat Jul 27 14:14:43 2002
@@ -888,6 +888,8 @@
 	 * old method of shifting the VA >> by PGDIR_SHIFT doesn't work.
 	 */
 	start_index = pgd_index(first);
+	if (start_index < FIRST_USER_PGD_NR)
+		start_index = FIRST_USER_PGD_NR;
 	end_index = pgd_index(last);
 	if (end_index > start_index) {
 		clear_page_tables(tlb, start_index, end_index - start_index);

