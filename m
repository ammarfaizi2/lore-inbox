Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbRB0Izx>; Tue, 27 Feb 2001 03:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129623AbRB0Izn>; Tue, 27 Feb 2001 03:55:43 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:22796 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129618AbRB0Iz2>; Tue, 27 Feb 2001 03:55:28 -0500
Date: Tue, 27 Feb 2001 04:09:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Rik van Riel <riel@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: [PATCH] count for buffer IO in page_launder()
Message-ID: <Pine.LNX.4.21.0102270353020.6519-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

page_launder() is not counting direct ll_rw_block() IO correctly in the
flushed pages counter. 

A page is only counted as flushed if it had its buffer_head's freed,
meaning that pages which have been queued but not freed are not counted.

The following patch against ac5 fixes the problem.



diff -Nur linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Sat Feb 24 23:30:20 2001
+++ linux/mm/vmscan.c	Mon Feb 26 05:45:08 2001
@@ -535,7 +535,7 @@
 		 * buffer pages
 		 */
 		if (page->buffers) {
-			int wait, clearedbuf;
+			int wait;
 			/*
 			 * Since we might be doing disk IO, we have to
 			 * drop the spinlock and take an extra reference
@@ -554,7 +554,8 @@
 				wait = 0;	/* No IO */
 
 			/* Try to free the page buffers. */
-			clearedbuf = try_to_free_buffers(page, wait);
+			if (try_to_free_buffers(page, wait))
+				flushed_pages++;
 
 			/*
 			 * Re-take the spinlock. Note that we cannot
@@ -564,10 +565,8 @@
 			spin_lock(&pagemap_lru_lock);
 
 			/* The buffers were not freed. */
-			if (!clearedbuf) {
+			if (page->buffers) {
 				add_page_to_inactive_dirty_list(page);
-				if (wait)
-					flushed_pages++;
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
diff -Nur linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Sat Feb 24 23:30:16 2001
+++ linux/fs/buffer.c	Mon Feb 26 04:44:54 2001
@@ -1399,7 +1399,8 @@
 	 * instead.
 	 */
 	if (!offset) {
-		if (!try_to_free_buffers(page, 0)) {
+		try_to_free_buffers(page, 0)
+		if (page->buffers) {
 			atomic_inc(&buffermem_pages);
 			return 0;
 		}
@@ -2413,7 +2414,7 @@
 	spin_unlock(&free_list[index].lock);
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
-	return 1;
+	return 0;
 
 busy_buffer_page:
 	/* Uhhuh, start writeback so that we don't end up with all dirty pages */
@@ -2428,6 +2429,7 @@
 			goto cleaned_buffers_try_again;
 		}
 		wakeup_bdflush(0);
+		return 1;
 	}
 	return 0;
 }






