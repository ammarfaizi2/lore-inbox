Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130164AbQLDAuA>; Sun, 3 Dec 2000 19:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130750AbQLDAtu>; Sun, 3 Dec 2000 19:49:50 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:53772 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S129700AbQLDAtp>; Sun, 3 Dec 2000 19:49:45 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>
Date: Mon, 4 Dec 2000 11:18:58 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14890.58098.787542.75516@notabene.cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: PATCH - documentation for ll_rw_block and generic_make_request
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,
 below is a patch for 2.4.0-test that adds documentation for
 ll_rw_block and generic_make_request.  It also corrects a type error
 in a printk call.

 I would really like to change a couple of names in the file:
  "generic_make_request" would sound much better as "raw_rw_block".
    that would highlight it's similarity to ll_rw_block, and would
    remove the "generic" which seems to imply that it is possible to
    replace it with a specific_make_request - which is wrong.

 also
   "__make_request" would sound much better as elevator_make_request, as
     that is more descriptive of what it does.  Also __foo() normally is
     a special (e.g. no locking) case of foo(), but that is not the
     case here.


 Would you accept such as patch at this stage?

NeilBrown




--- drivers/block/ll_rw_blk.c	2000/12/03 23:59:07	1.1
+++ drivers/block/ll_rw_blk.c	2000/12/04 00:17:34
@@ -262,13 +262,18 @@
  *
  * Description:
  *    The normal way for &struct buffer_heads to be passed to a device driver
- *    it to collect into requests on a request queue, and allow the device
- *    driver to select requests off that queue when it is ready.  This works
- *    well for many block devices. However some block devices (typically
- *    virtual devices such as md or lvm) do not benefit from the processes on
+ *    is for them to be collected into requests on a request queue, and then to
+ *    allow the device driver to select requests off that queue when it is ready.
+ *    This works well for many block devices. However some block devices (typically
+ *    virtual devices such as md or lvm) do not benefit from the processing on
  *    the request queue, and are served best by having the requests passed
  *    directly to them.  This can be achieved by providing a function to
  *    blk_queue_make_request().
+ *
+ * Caveat:
+ *    The driver that does this *must* be able to deal appropriately with
+ *    buffers in "highmemory", either by calling bh_kmap() to get a kernel mapping,
+ *    to by calling create_bounce() to create a buffer in normal memory.
  **/
 
 void blk_queue_make_request(request_queue_t * q, make_request_fn * mfn)
@@ -831,6 +836,40 @@
 	return 0;
 }
 
+/**
+ * generic_make_request: hand a buffer head to it's device driver for I/O
+ * @rw:  READ, WRITE, or READA - what sort of I/O is desired.
+ * @bh:  The buffer head describing the location in memory and on the device.
+ *
+ * generic_make_request() is used to make I/O requests of block
+ * devices. It is passed a &struct buffer_head and a &rw value.  The
+ * %READ and %WRITE options are (hopefully) obvious in meaning.  The
+ * %READA value means that a read is required, but that the driver is
+ * free to fail the request if, for example, it cannot get needed
+ * resources immediately.
+ *
+ * generic_make_request() does not return any status.  The
+ * success/failure status of the request, along with notification of
+ * completion, is delivered asynchronously through the bh->b_end_io
+ * function described (one day) else where.
+ *
+ * The caller of generic_make_request must make sure that b_page,
+ * b_addr, b_size are set to describe the memory buffer, that b_rdev
+ * and b_rsector are set to describe the device address, and the
+ * b_end_io and optionally b_private are set to describe how
+ * completion notification should be signaled.  BH_Mapped should also
+ * be set (to confirm that b_dev and b_blocknr are valid).
+ *
+ * generic_make_request and the drivers it calls may use b_reqnext,
+ * and may change b_rdev and b_rsector.  So the values of these fields
+ * should NOT be depended on after the call to generic_make_request.
+ * Because of this, the caller should record the device address
+ * information in b_dev and b_blocknr.
+ *
+ * Apart from those fields mentioned above, no other fields, and in
+ * particular, no other flags, are changed by generic_make_request or
+ * any lower level drivers.
+ * */
 void generic_make_request (int rw, struct buffer_head * bh)
 {
 	int major = MAJOR(bh->b_rdev);
@@ -851,7 +890,7 @@
 				   when mounting a device. */
 				printk(KERN_INFO
 				       "attempt to access beyond end of device\n");
-				printk(KERN_INFO "%s: rw=%d, want=%d, limit=%d\n",
+				printk(KERN_INFO "%s: rw=%d, want=%ld, limit=%d\n",
 				       kdevname(bh->b_rdev), rw,
 				       (sector + count)>>1,
 				       blk_size[major][MINOR(bh->b_rdev)]);
@@ -883,9 +922,39 @@
 	while (q->make_request_fn(q, rw, bh));
 }
 
-/* This function can be used to request a number of buffers from a block
-   device. Currently the only restriction is that all buffers must belong to
-   the same device */
+/**
+ * ll_rw_block: low-level access to block devices
+ * @rw: whether to %READ or %WRITE or maybe %READA (readahead)
+ * @nr: number of &struct buffer_heads in the array
+ * @bhs: array of pointers to &struct buffer_head
+ *
+ * ll_rw_block() takes an array of pointers to &struct buffer_heads,
+ * and requests an I/O operation on them, either a %READ or a %WRITE.
+ * The third %READA option is described in the documentation for
+ * generic_make_request() which ll_rw_block() calls.
+ *
+ * This function provides extra functionality that is not in
+ * generic_make_request() that is relevant to buffers in the buffer
+ * cache or page cache.  In particular it drops any buffer that it
+ * cannot get a lock on (with the BH_Lock state bit), any buffer that
+ * appears to be clean when doing a write request, and any buffer that
+ * appears to be up-to-date when doing read request.  Further it marks
+ * as clean buffers that are processed for writing (the buffer cache
+ * wont assume that they are actually clean until the buffer gets
+ * unlocked).
+ *
+ * ll_rw_block sets the b_rdev and b_rsector for generic_make_request
+ * based on the values in b_dev and b_blocknr.  It assumes that
+ * b_blocknr is in multiples of b_size bytes (b_rsector must always be
+ * in multiples of 512bytes).
+ *
+ * The comments in the documentation for generic_make_request() about
+ * what fields need to be set up apply to ll_rw_block as well.
+ *
+ * Caveat:
+ *  All of the buffers must be for the same device, and must also be
+ *  of the current approved size for the device.
+ */
 
 void ll_rw_block(int rw, int nr, struct buffer_head * bhs[])
 {
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
