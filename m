Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132289AbQLHSmn>; Fri, 8 Dec 2000 13:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132358AbQLHSmd>; Fri, 8 Dec 2000 13:42:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:40179 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132289AbQLHSmW>;
	Fri, 8 Dec 2000 13:42:22 -0500
Date: Fri, 8 Dec 2000 13:11:54 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: kernel BUG at buffer.c:827 in test12-pre6 and 7 
In-Reply-To: <Pine.GSO.4.21.0012080410180.24770-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0012081301160.27010-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks, see if the following patch helps. AFAICS it closes a pretty real
race - we could call block_write_full_page() for a page that has sync
IO in progress and blindly change ->b_end_io callbacks on the bh with
pending requests. With a little bit of bad luck they would complete before
we got to ll_rw_block(), thus leading to extra UnlockPage(). All it takes
is a pageout on a page that got partial write recently - if some fragments
were still unmapped we get to call get_block() on them and it can easily
block, providing a decent window for that race.

Fix: postpone changing ->b_end_io until the call of ll_rw_block(); if by
the time of ll_rw_block() some fragments will still have IO in progress -
wait on them.

Comments?
						Cheers,
							Al

--- buffer.c	Fri Dec  8 16:19:53 2000
+++ buffer.c.new	Fri Dec  8 16:26:44 2000
@@ -1577,6 +1577,26 @@
  * "Dirty" is valid only with the last case (mapped+uptodate).
  */
 
+static void write_array_async(struct page *page, struct buffer_head **p, int n)
+{
+	int i;
+	if (!n) {
+		UnlockPage(page);
+		return;
+	}
+	/*
+	 * If there are pending requests on these guys - wait before changing
+	 * ->b_end_io.
+	 */
+	for (i=0; i<n; i++) {
+		wait_on_buffer(p[i]);
+		set_bit(BH_Uptodate, &p[i]->b_state);
+		set_bit(BH_Dirty, &p[i]->b_state);
+		p[i]->b_end_io = end_buffer_io_async;
+	}
+	ll_rw_block(WRITE, n, p);
+}
+
 /*
  * block_write_full_page() is SMP-safe - currently it's still
  * being called with the kernel lock held, but the code is ready.
@@ -1616,28 +1636,17 @@
 			if (buffer_new(bh))
 				unmap_underlying_metadata(bh);
 		}
-		set_bit(BH_Uptodate, &bh->b_state);
-		set_bit(BH_Dirty, &bh->b_state);
-		bh->b_end_io = end_buffer_io_async;
 		atomic_inc(&bh->b_count);
 		arr[nr++] = bh;
 		bh = bh->b_this_page;
 		block++;
 	} while (bh != head);
 
-	if (nr) {
-		ll_rw_block(WRITE, nr, arr);
-	} else {
-		UnlockPage(page);
-	}
+	write_array_async(page, arr, nr);
 	SetPageUptodate(page);
 	return 0;
 out:
-	if (nr) {
-		ll_rw_block(WRITE, nr, arr);
-	} else {
-		UnlockPage(page);
-	}
+	write_array_async(page, arr, nr);
 	ClearPageUptodate(page);
 	return err;
 }

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
