Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266904AbRGHPDW>; Sun, 8 Jul 2001 11:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266906AbRGHPDM>; Sun, 8 Jul 2001 11:03:12 -0400
Received: from [62.172.234.2] ([62.172.234.2]:6974 "EHLO alloc.wat.veritas.com")
	by vger.kernel.org with ESMTP id <S266904AbRGHPDB>;
	Sun, 8 Jul 2001 11:03:01 -0400
Date: Sun, 8 Jul 2001 16:04:20 +0100 (BST)
From: <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] copy_from_high_bh
Message-ID: <Pine.LNX.4.33.0107081603100.9756-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  mm/highmem.c/copy_from_high_bh() blocks interrupts while copying "down"
to a bounce buffer, for writing.
  This function is only ever called from create_bounce() (which cannot
be called from an interrupt context - it may block), and the kmap
'KM_BOUNCE_WRITE' is only used in copy_from_high_bh().

  Therefore, the comment in copy_from_high_bh() is wrong, and the
__cli()/__sti() unnecessary.

  Patch against 2.4.6 below.

Mark

-------------------------------------------------------------------

diff -urN -X dontdiff linux-2.4.6/mm/highmem.c cli-2.4.6/mm/highmem.c
--- linux-2.4.6/mm/highmem.c	Fri Jun 29 23:17:34 2001
+++ cli-2.4.6/mm/highmem.c	Sun Jul  8 15:50:04 2001
@@ -182,20 +182,12 @@
 {
 	struct page *p_from;
 	char *vfrom;
-	unsigned long flags;

 	p_from = from->b_page;

-	/*
-	 * Since this can be executed from IRQ context, reentrance
-	 * on the same CPU must be avoided:
-	 */
-	__save_flags(flags);
-	__cli();
 	vfrom = kmap_atomic(p_from, KM_BOUNCE_WRITE);
 	memcpy(to->b_data, vfrom + bh_offset(from), to->b_size);
 	kunmap_atomic(vfrom, KM_BOUNCE_WRITE);
-	__restore_flags(flags);
 }

 static inline void copy_to_high_bh_irq (struct buffer_head *to,


