Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281710AbRKQDzc>; Fri, 16 Nov 2001 22:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281700AbRKQDzX>; Fri, 16 Nov 2001 22:55:23 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:19378 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281697AbRKQDzM>; Fri, 16 Nov 2001 22:55:12 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Sat, 17 Nov 2001 14:55:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15349.57256.352406.194138@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - discard buffer_IO_error
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 all current calls to "buffer_IO_error" are in violation of proper
 layering.
 buffer_io_error calls "mark_buffer_clean" which relates to b_list and
 the buffercache.  However all calls to it are below "submit_bh" and
 so could involve a buffer that is not part of the buffer cache at
 all. (e.g. could be a md/raid intermediate buffer, or a bounce_io
 buffer, or probably others).

 This patch replaces all calls to buffer_IO_error with calls to 
 bh->b_end_io(bh,0) and removes buffer_IO_error.

 Given this, there is no need for md to set b_list for intermediate
 buffers, so that code is now gone.

 There is still the setting of b_list to "-1" in
    highmem.c:create_bounce
 which can probably be fixed, but it's not my code and it doesn't
 really need changing so I didn't.

NeilBrown




--- ./include/linux/fs.h	2001/11/16 03:44:33	1.1
+++ ./include/linux/fs.h	2001/11/16 03:56:09	1.2
@@ -1160,21 +1160,6 @@
 		clear_bit(BH_Async, &bh->b_state);
 }
 
-/*
- * If an error happens during the make_request, this function
- * has to be recalled. It marks the buffer as clean and not
- * uptodate, and it notifys the upper layer about the end
- * of the I/O.
- */
-static inline void buffer_IO_error(struct buffer_head * bh)
-{
-	mark_buffer_clean(bh);
-	/*
-	 * b_end_io has to clear the BH_Uptodate bitflag in the error case!
-	 */
-	bh->b_end_io(bh, 0);
-}
-
 extern void buffer_insert_inode_queue(struct buffer_head *, struct inode *);
 static inline void mark_buffer_dirty_inode(struct buffer_head *bh, struct inode *inode)
 {
--- ./drivers/block/ll_rw_blk.c	2001/11/16 03:44:33	1.1
+++ ./drivers/block/ll_rw_blk.c	2001/11/16 03:56:09	1.2
@@ -867,7 +867,7 @@
 			       "generic_make_request: Trying to access "
 			       "nonexistent block-device %s (%ld)\n",
 			       kdevname(bh->b_rdev), bh->b_rsector);
-			buffer_IO_error(bh);
+			bh->b_end_io(bh, 0);
 			break;
 		}
 	} while (q->make_request_fn(q, rw, bh));
--- ./drivers/block/loop.c	2001/11/16 03:44:33	1.1
+++ ./drivers/block/loop.c	2001/11/16 03:56:09	1.2
@@ -515,7 +515,7 @@
 		up(&lo->lo_bh_mutex);
 	loop_put_buffer(bh);
 out:
-	buffer_IO_error(rbh);
+	rbh->b_end_io(rbh,0);
 	return 0;
 inactive:
 	spin_unlock_irq(&lo->lo_lock);
--- ./drivers/md/md.c	2001/11/16 03:44:33	1.1
+++ ./drivers/md/md.c	2001/11/16 03:56:09	1.2
@@ -179,7 +179,7 @@
 	if (mddev && mddev->pers)
 		return mddev->pers->make_request(mddev, rw, bh);
 	else {
-		buffer_IO_error(bh);
+		bh->b_end_io(bh, 0);
 		return 0;
 	}
 }
--- ./drivers/md/raid5.c	2001/11/16 03:44:33	1.1
+++ ./drivers/md/raid5.c	2001/11/16 03:56:09	1.2
@@ -473,7 +473,6 @@
 
 	bh->b_state	= (1 << BH_Req) | (1 << BH_Mapped);
 	bh->b_size	= sh->size;
-	bh->b_list	= BUF_LOCKED;
 	return bh;
 }
 
--- ./drivers/md/lvm.c	2001/11/16 03:44:33	1.1
+++ ./drivers/md/lvm.c	2001/11/16 03:56:09	1.2
@@ -1253,7 +1253,7 @@
 	return 1;
 
  bad:
-	buffer_IO_error(bh);
+	bh->b_end_io(bh, 0);
 	up_read(&lv->lv_lock);
 	return -1;
 } /* lvm_map() */
--- ./drivers/md/raid1.c	2001/11/16 03:44:33	1.1
+++ ./drivers/md/raid1.c	2001/11/16 03:56:09	1.2
@@ -665,7 +665,6 @@
  		mbh->b_size       = bh->b_size;
  		mbh->b_page	  = bh->b_page;
  		mbh->b_data	  = bh->b_data;
- 		mbh->b_list       = BUF_LOCKED;
  		mbh->b_end_io     = raid1_end_request;
  		mbh->b_private    = r1_bh;
 
@@ -1188,7 +1187,6 @@
 					mbh->b_size       = bh->b_size;
 					mbh->b_page	  = bh->b_page;
 					mbh->b_data	  = bh->b_data;
-					mbh->b_list       = BUF_LOCKED;
 					mbh->b_end_io     = end_sync_write;
 					mbh->b_private    = r1_bh;
 
@@ -1409,7 +1407,6 @@
 		bsize <<= 1;
 	}
 	bh->b_size = bsize;
-	bh->b_list = BUF_LOCKED;
 	bh->b_dev = mirror->dev;
 	bh->b_rdev = mirror->dev;
 	bh->b_state = (1<<BH_Req) | (1<<BH_Mapped) | (1<<BH_Lock);
--- ./drivers/md/linear.c	2001/11/16 03:51:49	1.1
+++ ./drivers/md/linear.c	2001/11/16 03:56:09	1.2
@@ -134,7 +134,7 @@
 		if (!hash->dev1) {
 			printk ("linear_make_request : hash->dev1==NULL for block %ld\n",
 						block);
-			buffer_IO_error(bh);
+			bh->b_end_io(bh, 0);
 			return 0;
 		}
 		tmp_dev = hash->dev1;
@@ -144,7 +144,7 @@
 	if (block >= (tmp_dev->size + tmp_dev->offset)
 				|| block < tmp_dev->offset) {
 		printk ("linear_make_request: Block %ld out of bounds on dev %s size %ld offset %ld\n", block, kdevname(tmp_dev->dev), tmp_dev->size, tmp_dev->offset);
-		buffer_IO_error(bh);
+		bh->b_end_io(bh, 0);
 		return 0;
 	}
 	bh->b_rdev = tmp_dev->dev;
--- ./drivers/md/raid0.c	2001/11/16 03:52:16	1.1
+++ ./drivers/md/raid0.c	2001/11/16 03:56:09	1.2
@@ -285,7 +285,7 @@
 bad_zone1:
 	printk ("raid0_make_request bug: hash->zone1==NULL for block %ld\n", block);
  outerr:
-	buffer_IO_error(bh);
+	bh->b_end_io(bh, 0);
 	return 0;
 }
 			   
