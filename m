Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129385AbQLGWCh>; Thu, 7 Dec 2000 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129826AbQLGWC0>; Thu, 7 Dec 2000 17:02:26 -0500
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:53252 "EHLO
	anduin.gondor.com") by vger.kernel.org with ESMTP
	id <S129725AbQLGWCO>; Thu, 7 Dec 2000 17:02:14 -0500
Date: Thu, 7 Dec 2000 22:30:43 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org, adilger@turbolinux.com
Cc: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>,
        Byron Stanoszek <gandalf@winds.org>
Subject: [PATCH] Re: fs corruption with invalidate_buffers()
Message-ID: <20001207223043.A994@gondor.com>
In-Reply-To: <20001206030723.A1136@gondor.com> <20001207200558.A976@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001207200558.A976@gondor.com>; from jan@gondor.com on Thu, Dec 07, 2000 at 08:05:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch actually prevents the corruption I described.

I'd like to hear from the people having problems with hdparm, if it helps
them, too.

Please note that the patch circumvents the problem more than it fixes it.
The true fix would invalidate the mappings, but I don't know how to do it.

Jan

--- linux-2.4.0-test11/fs/buffer.c	Mon Nov 20 08:55:05 2000
+++ test/fs/buffer.c	Thu Dec  7 22:28:24 2000
@@ -589,7 +589,7 @@
    then an invalidate_buffers call that doesn't trash dirty buffers. */
 void __invalidate_buffers(kdev_t dev, int destroy_dirty_buffers)
 {
-	int i, nlist, slept;
+	int i, nlist, slept, db_message=0;
 	struct buffer_head * bh, * bh_next;
 
  retry:
@@ -615,8 +615,13 @@
 			write_lock(&hash_table_lock);
 			if (!atomic_read(&bh->b_count) &&
 			    (destroy_dirty_buffers || !buffer_dirty(bh))) {
-				__remove_from_queues(bh);
-				put_last_free(bh);
+				if(bh->b_page 
+					&& bh->b_page->mapping) { 
+					db_message=1;
+				} else { 
+					__remove_from_queues(bh);
+					put_last_free(bh);
+				}
 			}
 			/* else complain loudly? */
 
@@ -629,6 +634,8 @@
 	spin_unlock(&lru_list_lock);
 	if (slept)
 		goto retry;
+	if(db_message)
+		printk("invalidate_buffer with mapped page\n");
 }
 
 void set_blocksize(kdev_t dev, int size)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
