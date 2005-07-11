Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVGKPyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVGKPyJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGKPvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:51:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:6852 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262089AbVGKPvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:51:14 -0400
Date: Mon, 11 Jul 2005 17:51:08 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Make ll_rw_block() wait for buffer lock
Message-ID: <20050711155108.GR12428@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  attached patch adds an operation SWRITE to ll_rw_block(). When this
operation is specified ll_rw_block() waits for a buffer lock and doesn't
just skip the locked buffer. Under some circumstances we need to make
sure that current data are really being sent to disk and the old
ll_rw_block()'s behaviour makes this impossible to achieve (as in some
places we lock and unlock buffer without sending it to disk). The patch
also changes the one caller in buffer.c. Please apply.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="buffer-2.6.12-2-ll_rw_block-fix.diff"

Introduce new ll_rw_block() operation SWRITE meaning that block layer should
wait for the buffer lock and write-out afterwards. Hence data in buffers
at the time of call are guaranteed to be submitted to the disk.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/buffer.c linux-2.6.12-2-ll_rw_block-fix/fs/buffer.c
--- linux-2.6.12-1-forgetfix/fs/buffer.c	2005-06-28 13:26:17.000000000 +0200
+++ linux-2.6.12-2-ll_rw_block-fix/fs/buffer.c	2005-07-07 07:10:34.000000000 +0200
@@ -933,8 +933,7 @@ static int fsync_buffers_list(spinlock_t
 				 * contents - it is a noop if I/O is still in
 				 * flight on potentially older contents.
 				 */
-				wait_on_buffer(bh);
-				ll_rw_block(WRITE, 1, &bh);
+				ll_rw_block(SWRITE, 1, &bh);
 				brelse(bh);
 				spin_lock(lock);
 			}
@@ -2805,21 +2804,22 @@ int submit_bh(int rw, struct buffer_head
 
 /**
  * ll_rw_block: low-level access to block devices (DEPRECATED)
- * @rw: whether to %READ or %WRITE or maybe %READA (readahead)
+ * @rw: whether to %READ or %WRITE or %SWRITE or maybe %READA (readahead)
  * @nr: number of &struct buffer_heads in the array
  * @bhs: array of pointers to &struct buffer_head
  *
- * ll_rw_block() takes an array of pointers to &struct buffer_heads,
- * and requests an I/O operation on them, either a %READ or a %WRITE.
- * The third %READA option is described in the documentation for
- * generic_make_request() which ll_rw_block() calls.
+ * ll_rw_block() takes an array of pointers to &struct buffer_heads, and
+ * requests an I/O operation on them, either a %READ or a %WRITE.  The third
+ * %SWRITE is like %WRITE only we make sure that the *current* data in buffers
+ * are sent to disk. The fourth %READA option is described in the documentation
+ * for generic_make_request() which ll_rw_block() calls.
  *
  * This function drops any buffer that it cannot get a lock on (with the
- * BH_Lock state bit), any buffer that appears to be clean when doing a
- * write request, and any buffer that appears to be up-to-date when doing
- * read request.  Further it marks as clean buffers that are processed for
- * writing (the buffer cache won't assume that they are actually clean until
- * the buffer gets unlocked).
+ * BH_Lock state bit) unless SWRITE is required, any buffer that appears to be
+ * clean when doing a write request, and any buffer that appears to be
+ * up-to-date when doing read request.  Further it marks as clean buffers that
+ * are processed for writing (the buffer cache won't assume that they are
+ * actually clean until the buffer gets unlocked).
  *
  * ll_rw_block sets b_end_io to simple completion handler that marks
  * the buffer up-to-date (if approriate), unlocks the buffer and wakes
@@ -2835,11 +2835,13 @@ void ll_rw_block(int rw, int nr, struct 
 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
 
-		if (test_set_buffer_locked(bh))
+		if (rw == SWRITE)
+			lock_buffer(bh);
+		else if (test_set_buffer_locked(bh))
 			continue;
 
 		get_bh(bh);
-		if (rw == WRITE) {
+		if (rw == WRITE || rw == SWRITE) {
 			if (test_clear_buffer_dirty(bh)) {
 				bh->b_end_io = end_buffer_write_sync;
 				submit_bh(WRITE, bh);
diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/include/linux/fs.h linux-2.6.12-2-ll_rw_block-fix/include/linux/fs.h
--- linux-2.6.12-1-forgetfix/include/linux/fs.h	2005-06-28 13:26:35.000000000 +0200
+++ linux-2.6.12-2-ll_rw_block-fix/include/linux/fs.h	2005-07-07 07:16:39.000000000 +0200
@@ -69,6 +69,7 @@ extern int dir_notify_enable;
 #define READ 0
 #define WRITE 1
 #define READA 2		/* read-ahead  - don't block if no resources */
+#define SWRITE 3	/* for ll_rw_block() - wait for buffer lock */
 #define SPECIAL 4	/* For non-blockdevice requests in request queue */
 #define READ_SYNC	(READ | (1 << BIO_RW_SYNC))
 #define WRITE_SYNC	(WRITE | (1 << BIO_RW_SYNC))

--dTy3Mrz/UPE2dbVg--
