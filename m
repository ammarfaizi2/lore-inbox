Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267188AbUBSA1K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267193AbUBSA1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:27:09 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:44271 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267188AbUBSA07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:26:59 -0500
Message-ID: <403402C1.50102@us.ibm.com>
Date: Wed, 18 Feb 2004 16:26:41 -0800
From: Mike Christie <mikenc@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: dm core patches
References: <1076690681.2158.54.camel@mulgrave>
In-Reply-To: <1076690681.2158.54.camel@mulgrave>
Content-Type: multipart/mixed;
 boundary="------------010108010305080200070503"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010108010305080200070503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
>>The mechanism is in place, but the SCSI stack still needs a few changes
>>to pass down the correct errors. The easiest would be to pass down
>>pseudo-sense keys (I'd rather just call them something else as not to
>>confuse things, io error hints or something) to
>>end_that_request_first(), changing uptodate from a bool to a hint.
> 
> 
> Yes, I'm ready to do this in SCSI.  I think the uptodate field should
> include at least two (and possibly three) failure type indications:
> 
> - fatal: error cannot be retried
> - retryable: error may be retried
> 
> and possibly
> 
> - informational: This is dangerous, since it's giving information about
> a transaction that actually succeeded (i.e. we'd need to fix drivers to
> recognise it as being uptodate but with info, like sector remapped)
> 
> Then, we also have a error origin indication:
> 
> - device: The device is actually reporting the problem
> - transport: the error is a transport error
> - driver: the error comes from the device driver.
> 
> So dm would know that fatal transport or driver errors could be
> repathed, but fatal device errors probably couldn't.
> 

I apologize for not starting a new thread, but I just wanted some 
feedback as to whether or not the attached patch is headed in the right 
direction or even acceptable. block-err.patch adds new errornos to 
include/linux/errno.h (it does not touch the asm values), so useful IO 
error info can passed from callers of end_that_request_first to 
bio_endio and eventually to the DM/MD endio functions.

I have an alternative patch that defines BLK_ERR_xxx values instead of 
touching errno.h, but becuase the error values get passed through the 
request code, bio code and DM/MD code the callers of bio_endio that are 
already using -Exxx values could present a problem. It would be nice to 
change them to the BLK_ERR_xxx, so the bio layer could have a single 
error value namespace. It's a more invasive change as there are several 
callers passing at least -EIO, -EWOULDBLOCK and -EPERM, so I am not sure 
if that is going to be OK since we are already in 2.6.3?

Thanks,

Mike Christie
mikenc@us.ibm.com

--------------010108010305080200070503
Content-Type: text/plain;
 name="block-err.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="block-err.patch"

diff -aurp linux-2.6.3-orig/drivers/block/ll_rw_blk.c linux-2.6.3-ec/drivers/block/ll_rw_blk.c
--- linux-2.6.3-orig/drivers/block/ll_rw_blk.c	2004-02-17 19:57:16.000000000 -0800
+++ linux-2.6.3-ec/drivers/block/ll_rw_blk.c	2004-02-18 12:33:50.000000000 -0800
@@ -2456,8 +2456,13 @@ static int __end_that_request_first(stru
 	if (!blk_pc_request(req))
 		req->errors = 0;
 
-	if (!uptodate) {
-		error = -EIO;
+	/*
+	 * Most drivers set uptodate to 0 for error and 1 for success.
+	 * MD/DM ready drivers will set 1 for success and a -Exxx
+	 * value to indicate a specific error.
+	 */
+	if (uptodate < 1) {
+		error = (uptodate == 0 ? -EIO : uptodate);
 		if (blk_fs_request(req) && !(req->flags & REQ_QUIET))
 			printk("end_request: I/O error, dev %s, sector %llu\n",
 				req->rq_disk ? req->rq_disk->disk_name : "?",
@@ -2540,7 +2545,7 @@ static int __end_that_request_first(stru
 /**
  * end_that_request_first - end I/O on a request
  * @req:      the request being processed
- * @uptodate: 0 for I/O error
+ * @@uptodate: <= 0 to indicate an I/O error.
  * @nr_sectors: number of sectors to end I/O on
  *
  * Description:
@@ -2561,7 +2566,7 @@ EXPORT_SYMBOL(end_that_request_first);
 /**
  * end_that_request_chunk - end I/O on a request
  * @req:      the request being processed
- * @uptodate: 0 for I/O error
+ * @uptodate: <= 0 to indicate an I/O error.
  * @nr_bytes: number of bytes to complete
  *
  * Description:
diff -aurp linux-2.6.3-orig/include/linux/errno.h linux-2.6.3-ec/include/linux/errno.h
--- linux-2.6.3-orig/include/linux/errno.h	2004-02-17 19:59:12.000000000 -0800
+++ linux-2.6.3-ec/include/linux/errno.h	2004-02-18 12:45:42.000000000 -0800
@@ -23,6 +23,14 @@
 #define EJUKEBOX	528	/* Request initiated, but will not complete before timeout */
 #define EIOCBQUEUED	529	/* iocb queued, will get completion event */
 
+/* Block device error codes */
+#define EFATALDEV	540	/* Fatal device error */
+#define EFATALTRNSPT	541	/* Fatal transport error */
+#define EFATALDRV	542	/* Fatal driver error */
+#define ERETRYDEV	543	/* Device error occured, I/O may be retried */
+#define ERETRYTRNSPT	544	/* Transport error occured, I/O may be retried */
+#define ERETRYDRV	545	/* Driver error occured, I/O may be retried */
+
 #endif
 
 #endif

--------------010108010305080200070503--

