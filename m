Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129745AbQL1Rmv>; Thu, 28 Dec 2000 12:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbQL1Rmc>; Thu, 28 Dec 2000 12:42:32 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8721 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129523AbQL1Rm1>; Thu, 28 Dec 2000 12:42:27 -0500
Date: Thu, 28 Dec 2000 13:18:43 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Juan Quintela <quintela@fi.udc.es>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] not sleep while holding a locked page in block_truncate_page
Message-ID: <Pine.LNX.4.21.0012281312020.12295-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus, 

block_truncate_page() function unecessarily calls mark_buffer_dirty(),
which may wait on bdflush, while holding a locked page.

The following patch against 2.4.0test13pre4 makes block_truncate_page call
balance_dirty() (which may wait for bdflush) after when we unlocked the
page and decrement its counter.

Comments?

--- linux.orig/fs/buffer.c.orig    Thu Dec 28 15:01:01 2000
+++ linux/fs/buffer.c Thu Dec 28 15:01:40 2000
@@ -1909,12 +1909,13 @@
        flush_dcache_page(page);
        kunmap(page);
 
-       mark_buffer_dirty(bh);
+       __mark_buffer_dirty(bh);
        err = 0;
 
 unlock:
        UnlockPage(page);
        page_cache_release(page);
+       balance_dirty(bh->b_dev);
 out:
        return err;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
