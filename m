Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbQKIAJK>; Wed, 8 Nov 2000 19:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129100AbQKIAI7>; Wed, 8 Nov 2000 19:08:59 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:14084 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129057AbQKIAIx>; Wed, 8 Nov 2000 19:08:53 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 9 Nov 2000 11:08:33 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14857.60161.343937.977948@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH: rd - deadlock removal
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Linus,

 There is a problem with drivers/block/rd.c which can lead to a
 deadlock an SMP hardware.

 The scenario goes:

     Processor A                                   Processor B

     enter _make_request                           in getblk (or elsewhere)
       (or generic_unplug_device)
                                                   spin_lock(&lru_list_lock);
     spin_lock_irqsave(&io_request_lock)        
                                                   Take an interrupt
                                                   for some block device
     call q->request_fn (== rd_rquest)
                                                   spin_lock_irqsave(&io_request_lock);
     call getblk                                   BLOCK

     spin_lock(&lru_list_lock)
     BLOCK 
                                    DEADLOCK


 I have two patches which address this problem.
 The first is simple and simply drops ui_request_lock before calling
 getblk.  This may be the appropriate one to use given the code
 freeze.

 The second is more elegant in that it side steps the problem by
 giving rd.c a make_request function instead of using the default
 _make_request.   This means that io_request_lock is simply never
 claimed my rd.

 I'll let you choose which is most appropriate for the current
 circumstances.  If you take the first, I will hold on the the second
 until 2.5.*

 Both patches also replace the usage for b_blocknr with the more
 correct b_rsector*(b_size>>9).  This would allow rd to be used under
 raid0 or lwm (should anyone choose to do so).

 For the first patch:

    | sed -e '/^MARKER/,$d' | patch -p0

 for the second

    | sed -e '1,/^MARKER/d' | patch -p0

NeilBrown


--- ./drivers/block/rd.c	2000/11/08 23:38:33	1.1
+++ ./drivers/block/rd.c	2000/11/08 23:39:45	1.2
@@ -225,8 +225,15 @@
 		goto repeat;
 	}
 
+	/* Possible deadlock when calling getblk as we currently have io_request_lock
+	 * and are about to take lru_list_lock.
+	 * Another processor may have taken lru_list_lock, and now be trying to take
+	 * io_request_lock from inside and interrupt handler
+	 */
+	spin_unlock(&io_request_lock); /* interrupts are still disabled */
+
 	sbh = CURRENT->bh;
-	rbh = getblk(sbh->b_dev, sbh->b_blocknr, sbh->b_size);
+	rbh = getblk(sbh->b_dev, sbh->b_rsector/(sbh->b_size>>9), sbh->b_size);
 	if (CURRENT->cmd == READ) {
 		if (sbh != rbh)
 			memcpy(CURRENT->buffer, rbh->b_data, rbh->b_size);
@@ -235,6 +242,11 @@
 			memcpy(rbh->b_data, CURRENT->buffer, rbh->b_size);
 	mark_buffer_protected(rbh);
 	brelse(rbh);
+
+	spin_lock(&io_request_lock); /* reclaiming the lock - don't need
+					to worry about interrupts
+					because we know they are
+					disabled */
 
 	end_request(1);
 	goto repeat;


 
MARKER



--- ./include/linux/blk.h	2000/11/08 23:41:09	1.1
+++ ./include/linux/blk.h	2000/11/08 23:41:15	1.2
@@ -115,7 +115,6 @@
 
 /* ram disk */
 #define DEVICE_NAME "ramdisk"
-#define DEVICE_REQUEST rd_request
 #define DEVICE_NR(device) (MINOR(device))
 #define DEVICE_NO_RANDOM
 
--- ./drivers/block/rd.c	2000/11/08 23:40:46	1.3
+++ ./drivers/block/rd.c	2000/11/08 23:41:15	1.4
@@ -194,50 +194,47 @@
  * 19-JAN-1998  Richard Gooch <rgooch@atnf.csiro.au>  Added devfs support
  *
  */
-static void rd_request(request_queue_t * q)
+static int rd_make_request(request_queue_t * q, int rw, struct buffer_head *sbh)
 {
 	unsigned int minor;
 	unsigned long offset, len;
 	struct buffer_head *rbh;
-	struct buffer_head *sbh;
 
-repeat:
-	INIT_REQUEST;
 	
-	minor = MINOR(CURRENT->rq_dev);
+	minor = MINOR(sbh->b_rdev);
+
+	if (minor >= NUM_RAMDISKS)
+		goto fail;
 
-	if (minor >= NUM_RAMDISKS) {
-		end_request(0);
-		goto repeat;
-	}
 	
-	offset = CURRENT->sector << 9;
-	len = CURRENT->current_nr_sectors << 9;
+	offset = sbh->b_rsector << 9;
+	len = sbh->b_size;
 
-	if ((offset + len) > rd_length[minor]) {
-		end_request(0);
-		goto repeat;
-	}
+	if ((offset + len) > rd_length[minor])
+		goto fail;
 
-	if ((CURRENT->cmd != READ) && (CURRENT->cmd != WRITE)) {
-		printk(KERN_INFO "RAMDISK: bad command: %d\n", CURRENT->cmd);
-		end_request(0);
-		goto repeat;
+	if (rw==READA)
+		rw=READ;
+	if ((rw != READ) && (rw != WRITE)) {
+		printk(KERN_INFO "RAMDISK: bad command: %d\n", rw);
+		goto fail;
 	}
 
-	sbh = CURRENT->bh;
-	rbh = getblk(sbh->b_dev, sbh->b_blocknr, sbh->b_size);
-	if (CURRENT->cmd == READ) {
+	rbh = getblk(sbh->b_rdev, sbh->b_rsector/(sbh->b_size>>9), sbh->b_size);
+	if (rw == READ) {
 		if (sbh != rbh)
-			memcpy(CURRENT->buffer, rbh->b_data, rbh->b_size);
+			memcpy(sbh->b_data, rbh->b_data, rbh->b_size);
 	} else
 		if (sbh != rbh)
-			memcpy(rbh->b_data, CURRENT->buffer, rbh->b_size);
+			memcpy(rbh->b_data, sbh->b_data, rbh->b_size);
 	mark_buffer_protected(rbh);
 	brelse(rbh);
 
-	end_request(1);
-	goto repeat;
+	sbh->b_end_io(sbh,1);
+	return 0;
+ fail:
+	sbh->b_end_io(sbh,0);
+	return 0;
 } 
 
 static int rd_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -378,7 +375,6 @@
 
 	devfs_unregister (devfs_handle);
 	unregister_blkdev( MAJOR_NR, "ramdisk" );
-	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	hardsect_size[MAJOR_NR] = NULL;
 	blksize_size[MAJOR_NR] = NULL;
 	blk_size[MAJOR_NR] = NULL;
@@ -403,7 +399,7 @@
 		return -EIO;
 	}
 
-	blk_init_queue(BLK_DEFAULT_QUEUE(MAJOR_NR), &rd_request);
+	blk_queue_make_request(BLK_DEFAULT_QUEUE(MAJOR_NR), &rd_make_request);
 
 	for (i = 0; i < NUM_RAMDISKS; i++) {
 		/* rd_size is given in kB */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
