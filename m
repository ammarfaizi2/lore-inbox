Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751469AbWCSJ1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbWCSJ1t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 04:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWCSJ1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 04:27:49 -0500
Received: from fmr21.intel.com ([143.183.121.13]:64214 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751469AbWCSJ1s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 04:27:48 -0500
Message-Id: <200603190927.k2J9RSg11077@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <suparna@in.ibm.com>,
       "'Zach Brown'" <zach.brown@oracle.com>, <pbadari@gmail.com>
Subject: [patch] bug fix in dio handling write error - v2
Date: Sun, 19 Mar 2006 01:27:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZLN1o7kWNIkMc0RM6FURTvVGl7RA==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Referring to original posting:
http://marc.theaimsgroup.com/?t=113752710100001&r=1&w=2

Suparna pointed out that this fix has a potential race window.  I think
the race condition also exists on the READ side currently. The fundamental
problem is that dio->result is overloaded with dual use: an indicator of
fall back path for partial dio write, and an error indicator used in the
I/O completion path.  In the event of device error, the setting of -EIO
to dio->result clashes with value used to track partial write that activates
the fall back path.

One way to fix the race issue is to pull all the code that uses dio->result
up before I/O is submitted and then never look at dio->result once IO is
submitted.  Or alternatively another independent variable can be introduce
to track fall back state, note that to set the tracking logic, kernel still
have to look at dio->result before I/O is submitted.

The following patch implements the first option. I would appreciate some
reviews.  Thanks.



[patch] bug fix in dio handling write error

There is a bug in direct-io on propagating write error up to the
higher I/O layer.  When performing an async ODIRECT write to a
block device, if a device error occurred (like media error or disk
is pulled), the error code is only propagated from device driver
to the DIO layer.  The error code stops at finished_one_bio(). The
aysnc write, however, is supposedly have a corresponding AIO event
with appropriate return code (in this case -EIO).  Application
which waits on the async write event, will hang forever since such
AIO event is lost forever (if such app did not use the timeout
option in io_getevents call. Regardless, an AIO event is lost).

The discovery of above bug leads to another discovery of potential
race window with dio->result.  The fundamental problem is that
dio->result is overloaded with dual use: an indicator of fall back
path for partial dio write, and an error indicator used in the I/O
completion path.  In the event of device error, the setting of -EIO
to dio->result clashes with value used to track partial write that
activates the fall back path.

Propose to fix the race issue by pulling all the code that uses
dio->result up before I/O is submitted and then never look at
dio->result once IO is submitted.

Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- ./fs/direct-io.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ ./fs/direct-io.c	2006-03-19 01:57:49.797391064 -0800
@@ -253,8 +253,7 @@ static void finished_one_bio(struct dio 
 			dio_complete(dio, offset, transferred);
 
 			/* Complete AIO later if falling back to buffered i/o */
-			if (dio->result == dio->size ||
-				((dio->rw == READ) && dio->result)) {
+			if (!dio->waiter) {
 				aio_complete(dio->iocb, transferred, 0);
 				kfree(dio);
 				return;
@@ -939,7 +938,7 @@ direct_io_worker(int rw, struct kiocb *i
 	struct dio *dio)
 {
 	unsigned long user_addr; 
-	int seg;
+	int seg, should_wait = 0;
 	ssize_t ret = 0;
 	ssize_t ret2;
 	size_t bytes;
@@ -1031,6 +1030,16 @@ direct_io_worker(int rw, struct kiocb *i
 		}
 	} /* end iovec loop */
 
+	/*
+	 * We'll have to wait for a partial write to drain before falling back
+	 * to buffered.  We check this before submitting io so that completion
+	 * doesn't have a chance to overwrite dio->result with -EIO.
+	 */
+	if (dio->result < dio->size && dio->is_async && rw == WRITE) {
+		dio->waiter = current;
+		should_wait = 1;
+	}
+
 	if (ret == -ENOTBLK && rw == WRITE) {
 		/*
 		 * The remaining part of the request will be
@@ -1051,6 +1060,7 @@ direct_io_worker(int rw, struct kiocb *i
 		page_cache_release(dio->cur_page);
 		dio->cur_page = NULL;
 	}
+	ret2 = dio->result;
 	if (dio->bio)
 		dio_bio_submit(dio);
 
@@ -1073,14 +1083,8 @@ direct_io_worker(int rw, struct kiocb *i
 	 * reflect the number of to-be-processed BIOs.
 	 */
 	if (dio->is_async) {
-		int should_wait = 0;
-
-		if (dio->result < dio->size && rw == WRITE) {
-			dio->waiter = current;
-			should_wait = 1;
-		}
 		if (ret == 0)
-			ret = dio->result;
+			ret = ret2;
 		finished_one_bio(dio);		/* This can free the dio */
 		blk_run_address_space(inode->i_mapping);
 		if (should_wait) {




