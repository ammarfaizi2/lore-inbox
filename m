Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130096AbRCAXXh>; Thu, 1 Mar 2001 18:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130094AbRCAXX1>; Thu, 1 Mar 2001 18:23:27 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:62728 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S130089AbRCAXXP>; Thu, 1 Mar 2001 18:23:15 -0500
Date: Thu, 1 Mar 2001 18:37:08 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rik van Riel <riel@conectiva.com.br>, lkml <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org
Subject: [PATCH] ac7: page_launder() & refill_inactive() changes
Message-ID: <Pine.LNX.4.21.0103011829150.8305-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

The following patch changes two things:

 - Counts asynchronous ll_rw_block() IO in the flushed pages counter (page_launder)
 - Limits the amount of scanned pte's _by user tasks_ inside swap_out()



diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Thu Mar  1 19:21:02 2001
+++ linux/fs/buffer.c	Thu Mar  1 19:33:38 2001
@@ -1399,7 +1399,8 @@
 	 * instead.
 	 */
 	if (!offset) {
-		if (!try_to_free_buffers(page, 0)) {
+		try_to_free_buffers(page, 0);
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
diff --exclude-from=/home/marcelo/exclude -Nur linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Thu Mar  1 19:21:08 2001
+++ linux/mm/vmscan.c	Thu Mar  1 19:35:51 2001
@@ -269,7 +269,7 @@
 	return nr < SWAP_MIN ? SWAP_MIN : nr;
 }
 
-static int swap_out(unsigned int priority, int gfp_mask)
+static int swap_out(unsigned int priority, int gfp_mask, int user)
 {
 	int counter;
 	int retval = 0;
@@ -280,7 +280,12 @@
 		retval = swap_out_mm(mm, swap_amount(mm));
 
 	/* Then, look at the other mm's */
-	counter = (mmlist_nr << SWAP_SHIFT) >> priority;
+
+	if  (user) 
+		counter = (mmlist_nr) >> priority;
+	else
+		counter = (mmlist_nr << SWAP_SHIFT) >> priority;
+
 	do {
 		struct list_head *p;
 
@@ -535,7 +540,7 @@
 		 * buffer pages
 		 */
 		if (page->buffers) {
-			int wait, clearedbuf;
+			int wait;
 			/*
 			 * Since we might be doing disk IO, we have to
 			 * drop the spinlock and take an extra reference
@@ -554,7 +559,8 @@
 				wait = 0;	/* No IO */
 
 			/* Try to free the page buffers. */
-			clearedbuf = try_to_free_buffers(page, wait);
+			if (try_to_free_buffers(page, wait))
+				flushed_pages++;
 
 			/*
 			 * Re-take the spinlock. Note that we cannot
@@ -564,10 +570,8 @@
 			spin_lock(&pagemap_lru_lock);
 
 			/* The buffers were not freed. */
-			if (!clearedbuf) {
+			if (page->buffers) {
 				add_page_to_inactive_dirty_list(page);
-				if (wait)
-					flushed_pages++;
 
 			/* The page was only in the buffer cache. */
 			} else if (!page->mapping) {
@@ -876,7 +880,7 @@
 			goto done;
 
 		/* If refill_inactive_scan failed, try to page stuff out.. */
-		swap_out(DEF_PRIORITY, gfp_mask);
+		swap_out(DEF_PRIORITY, gfp_mask, user);
 
 		if (--maxtry <= 0)
 				return 0;

