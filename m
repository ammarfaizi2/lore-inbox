Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWCUIvr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWCUIvr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 03:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbWCUIvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 03:51:47 -0500
Received: from fmr21.intel.com ([143.183.121.13]:46807 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1750785AbWCUIvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 03:51:46 -0500
Message-Id: <200603210851.k2L8pHg21393@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: <akpm@osdl.org>, <pbadari@us.ibm.com>, <suparna@in.ibm.com>,
       <zach.brown@oracle.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [patch] direct-io: bug fix in dio handling write error
Date: Tue, 21 Mar 2006 00:51:27 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZMxKOo2/0sOmfJTCGUkMPg2KnXqg==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>

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

It was also pointed out that it is impossible to use dio->result to
track partial write and at the same time to track error returned
from device driver. Because direct_io_work can only determines whether
it is a partial write at the end of io submission and in mid stream
of those io submission, a return code could be coming back from the
driver.  Thus messing up all the subsequent logic.

Proposed fix is to separating out error code returned by the IO
completion path from partial IO submit tracking.  A new variable is
added to dio structure specifically to track io error returned in the
completion path.


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>
Acked-by: Zach Brown <zach.brown@oracle.com>
Acked-by: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Badari Pulavarty <pbadari@us.ibm.com>
---

Patch tested by pulling a scsi drive while running aiostress as well
as running test code in http://developer.osdl.org/daniel/AIO/TESTS/

Andrew - please merge this version.  Thank you.


--- ./fs/direct-io.c.orig	2006-01-02 19:21:10.000000000 -0800
+++ ./fs/direct-io.c	2006-03-21 01:28:48.704475280 -0800
@@ -129,6 +129,7 @@ struct dio {
 	/* AIO related stuff */
 	struct kiocb *iocb;		/* kiocb */
 	int is_async;			/* is IO async ? */
+	int io_error;			/* IO error in completion path */
 	ssize_t result;                 /* IO result */
 };
 
@@ -250,6 +251,10 @@ static void finished_one_bio(struct dio 
 			    ((offset + transferred) > dio->i_size))
 				transferred = dio->i_size - offset;
 
+			/* check for error in completion path */
+			if (dio->io_error)
+				transferred = dio->io_error;
+
 			dio_complete(dio, offset, transferred);
 
 			/* Complete AIO later if falling back to buffered i/o */
@@ -406,7 +411,7 @@ static int dio_bio_complete(struct dio *
 	int page_no;
 
 	if (!uptodate)
-		dio->result = -EIO;
+		dio->io_error = -EIO;
 
 	if (dio->is_async && dio->rw == READ) {
 		bio_check_pages_dirty(bio);	/* transfers ownership */
@@ -964,6 +969,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->next_block_for_io = -1;
 
 	dio->page_errors = 0;
+	dio->io_error = 0;
 	dio->result = 0;
 	dio->iocb = iocb;
 	dio->i_size = i_size_read(inode);



