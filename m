Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLGWeY>; Thu, 7 Dec 2000 17:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130701AbQLGWeP>; Thu, 7 Dec 2000 17:34:15 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:34566 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S129525AbQLGWeC>; Thu, 7 Dec 2000 17:34:02 -0500
Message-ID: <3A300933.29813DE8@Hell.WH8.TU-Dresden.De>
Date: Thu, 07 Dec 2000 23:03:31 +0100
From: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Organization: Dept. Of Computer Science, Dresden University Of Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en, de-DE
MIME-Version: 1.0
To: Jan Niehusmann <jan@gondor.com>
CC: linux-kernel@vger.kernel.org, adilger@turbolinux.com,
        Byron Stanoszek <gandalf@winds.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] Re: fs corruption with invalidate_buffers()
In-Reply-To: <20001206030723.A1136@gondor.com> <20001207200558.A976@gondor.com> <20001207223043.A994@gondor.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Niehusmann wrote:
> 
> The following patch actually prevents the corruption I described.
> 
> I'd like to hear from the people having problems with hdparm, if it helps
> them, too.

Yes, it prevents the issue.

> Please note that the patch circumvents the problem more than it fixes it.
> The true fix would invalidate the mappings, but I don't know how to do it.

I don't know either. What does Alexander Viro say to all of this?

-Udo.



Same debug patch adapted to test12-pre7 follows:
 
--- linux/fs/buffer.c   Thu Dec  7 22:55:54 2000
+++ /usr/src/linux/fs/buffer.c  Thu Dec  7 22:49:02 2000
@@ -627,7 +627,7 @@
    then an invalidate_buffers call that doesn't trash dirty buffers. */
 void __invalidate_buffers(kdev_t dev, int destroy_dirty_buffers)
 {
-       int i, nlist, slept;
+       int i, nlist, slept, db_message = 0;
        struct buffer_head * bh, * bh_next;
 
  retry:
@@ -653,9 +653,13 @@
                        write_lock(&hash_table_lock);
                        if (!atomic_read(&bh->b_count) &&
                            (destroy_dirty_buffers || !buffer_dirty(bh))) {
-                               remove_inode_queue(bh);
-                               __remove_from_queues(bh);
-                               put_last_free(bh);
+                               if (bh->b_page && bh->b_page->mapping)
+                                       db_message = 1;
+                               else {
+                                       remove_inode_queue(bh);
+                                       __remove_from_queues(bh);
+                                       put_last_free(bh);
+                               }
                        }
                        /* else complain loudly? */
 
@@ -668,6 +672,8 @@
        spin_unlock(&lru_list_lock);
        if (slept)
                goto retry;
+       if (db_message)
+               printk("invalidate_buffers with mapped page!\n");
 }
 
 void set_blocksize(kdev_t dev, int size)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
